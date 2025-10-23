import 'package:flutter/material.dart';

import 'steps/choose_language_step.dart';
import 'steps/presentation_step.dart';
import 'steps/user_agreement_step.dart';
import 'steps/auth_step.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';
import 'package:skma_smartapp/generated/l10n.dart';
import '../widgets/dots_indicator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skma_smartapp/core/widgets/brand_button.dart';

class WelcomePage extends StatefulWidget {
  final VoidCallback? onFinish;

  const WelcomePage({super.key, this.onFinish});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _controller = PageController();
  int _index = 0;

  late final List<Widget> _pages = const [
    ChooseLanguageStep(),
    PresentationStep(),
    UserAgreementStep(),
    AuthStep(),
  ];

  String _buttonLabel() {
    switch (_index) {
      case 0:
        return S.of(context).next;
      case 1:
        return S.of(context).next;
      case 2:
        return S.of(context).agree;
      default:
        return S.of(context).next;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _prev() {
    if (_index > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    }
  }

  void _next() {
    if (_index < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    } else {
      widget.onFinish?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>()!;
    final isLast = _index == _pages.length - 1;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [brand.bgPrimary, brand.bgHalftone],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Верхняя панель
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      if (_index > 0)
                        IconButton(
                          onPressed: _prev,
                          icon: Icon(PhosphorIconsRegular.arrowLeft),
                          color: brand.main,
                          tooltip: 'Назад',
                        ),
                      Expanded(
                        child: AnimatedAlign(
                          alignment: _index == 0 ? Alignment.center : Alignment.centerRight,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          child: DotsIndicator(length: _pages.length, index: _index),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Контент страниц
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _index = i),
                  children: _pages,
                ),
              ),

              // Кнопка Далее/Начать — только если НЕ последний шаг
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, anim) => SizeTransition(
                  sizeFactor: anim,
                  axisAlignment: -1.0, // анимация "сжимается" кверху
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: isLast
                    ? const SizedBox(key: ValueKey('empty')) // ничего не рендерим
                    : Column(
                  key: const ValueKey('cta'),
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      child: BrandButton(
                        label: _buttonLabel(),
                        trailingIcon: PhosphorIconsRegular.arrowRight,
                        onPressed: _next,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
