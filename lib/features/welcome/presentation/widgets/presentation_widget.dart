import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';

class PresentationVideoWidget extends StatefulWidget {
  /// Сколько секунд проигрывать, затем пауза и кнопка «replay»
  final Duration playDuration;
  final double borderRadius;
  final bool autoReplay;

  const PresentationVideoWidget({
    super.key,
    this.playDuration = const Duration(seconds: 5),
    this.borderRadius = 20,
    this.autoReplay = true,      // по умолчанию включён
  });

  @override
  State<PresentationVideoWidget> createState() => _PresentationVideoWidgetState();
}

class _PresentationVideoWidgetState extends State<PresentationVideoWidget> {
  static const _urls = [
    'https://media.w3.org/2010/05/sintel/trailer.mp4',
  ];

  late final String _url = _urls[Random().nextInt(_urls.length)];
  VideoPlayerController? _controller;
  Timer? _cycleTimer;
  bool _showReplay = false; // используется только если autoReplay=false
  bool _muted = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final c = VideoPlayerController.networkUrl(Uri.parse(_url));
    _controller = c;
    await c.initialize();
    await c.setLooping(false); // сами контролируем 5-секундные циклы
    if (_muted) await c.setVolume(0.0);
    if (!mounted) return;
    setState(() {}); // показать первый кадр
    c.play();
    _scheduleNextCycle();
  }

  void _scheduleNextCycle() {
    _cycleTimer?.cancel();
    _cycleTimer = Timer(widget.playDuration, () {
      if (!mounted) return;
      final c = _controller;
      if (c == null) return;

      if (widget.autoReplay) {
        // авто-повтор: перемотать и продолжить
        c.seekTo(Duration.zero);
        c.play();
        _scheduleNextCycle();
      } else {
        // ручной повтор: остановить и показать кнопку
        c.pause();
        setState(() => _showReplay = true);
      }
    });
  }

  void _replay() {
    final c = _controller;
    if (c == null) return;
    setState(() => _showReplay = false);
    c.seekTo(Duration.zero);
    c.play();
    _scheduleNextCycle();
  }

  Future<void> _toggleMute() async {
    final c = _controller;
    if (c == null) return;
    _muted = !_muted;
    await c.setVolume(_muted ? 0.0 : 1.0);
    setState(() {});
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>();
    final c = _controller;

    const double aspectWanted = 9 / 16; // фикс: портрет 9:16

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Контейнер строго 9:16
          AspectRatio(
            aspectRatio: aspectWanted,
            child: c == null || !c.value.isInitialized
                ? Container(color: brand?.bgHalftone ?? theme.colorScheme.surfaceVariant)
                : ClipRect(
              // FittedBox с cover заполнит 9:16, обрежет лишнее (обычно по бокам)
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: c.value.size.width,
                  height: c.value.size.height,
                  child: VideoPlayer(c),
                ),
              ),
            ),
          ),

          // (опционально) overlay для ручного реплея, если autoReplay=false
          if (_showReplay && !widget.autoReplay)
            Positioned.fill(
              child: Material(
                color: Colors.black26,
                child: InkWell(
                  onTap: _replay,
                  child: const Center(
                    child: Icon(Icons.replay_circle_filled, size: 64, color: Colors.white),
                  ),
                ),
              ),
            ),

          // mute/unmute
          Positioned(
            right: 8,
            bottom: 8,
            child: Material(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: _toggleMute,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.volume_up_rounded, size: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}