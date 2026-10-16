import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../theme/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1900),
  )..forward();
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat(reverse: true);
  late final Animation<double> _logoScale = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0, .62, curve: Curves.elasticOut),
  );
  late final Animation<double> _brandOpacity = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(.36, .74, curve: Curves.easeOut),
  );
  late final Animation<Offset> _brandSlide = Tween<Offset>(
    begin: const Offset(0, .3),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _entrance,
    curve: const Interval(.3, .76, curve: Curves.easeOutCubic),
  ));
  late final Animation<double> _taglineOpacity = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(.58, .95, curve: Curves.easeIn),
  );
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(milliseconds: 3100), () {
      if (mounted) Get.offNamed(Routes.HOME);
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _entrance.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: _MintPattern()),
          SafeArea(
            child: Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([_entrance, _pulse]),
                builder: (context, _) {
                  final pulseScale = 1 + (_pulse.value * .035);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: _logoScale.value * pulseScale,
                        child: _LogoMark(progress: _entrance.value),
                      ),
                      const SizedBox(height: 31),
                      FadeTransition(
                        opacity: _brandOpacity,
                        child: SlideTransition(
                          position: _brandSlide,
                          child: const Text(
                            'finora',
                            style: TextStyle(
                              fontSize: 48,
                              height: 1,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -2.4,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 13),
                      FadeTransition(
                        opacity: _taglineOpacity,
                        child: const Text(
                          'MAKE EVERY MONEY MOVE COUNT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 56),
                      FadeTransition(
                        opacity: _taglineOpacity,
                        child: const _LoadingDots(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 27,
            child: FadeTransition(
              opacity: _taglineOpacity,
              child: const Text(
                'YOUR FINANCE, IN FOCUS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.6,
                  color: Color(0x99000000),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  final double progress;
  const _LogoMark({required this.progress});

  @override
  Widget build(BuildContext context) {
    final barProgress = Curves.easeOutBack.transform(
      ((progress - .18) / .62).clamp(0.0, 1.0),
    );
    return Container(
      width: 154,
      height: 154,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderBlack, width: 3),
        borderRadius: BorderRadius.circular(43),
        boxShadow: const [
          BoxShadow(color: AppColors.borderBlack, offset: Offset(7, 7)),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 30,
            bottom: 29,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _Bar(height: 27 * barProgress, color: AppColors.iconYellow),
                const SizedBox(width: 7),
                _Bar(height: 43 * barProgress, color: AppColors.iconOrange),
                const SizedBox(width: 7),
                _Bar(height: 60 * barProgress, color: AppColors.btnEmeraldGreen),
              ],
            ),
          ),
          Positioned(
            right: 22,
            top: 23,
            child: Transform.rotate(
              angle: -.18 * (1 - barProgress),
              child: const Icon(
                Icons.trending_up_rounded,
                size: 61,
                color: AppColors.textBlack,
                shadows: [Shadow(color: Colors.white, blurRadius: 1)],
              ),
            ),
          ),
          Positioned(
            left: 22,
            top: 21,
            child: Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: AppColors.btnEmeraldGreen,
                border: Border.all(color: AppColors.borderBlack, width: 2),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(Icons.attach_money_rounded, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final Color color;
  const _Bar({required this.height, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        width: 18,
        height: math.max(2, height),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: AppColors.borderBlack, width: 1.5),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
        ),
      );
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final phase = (_controller.value - index * .18) % 1;
            final scale = .7 + .5 * (1 - (phase * 2 - 1).abs());
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8 * scale,
              height: 8 * scale,
              decoration: BoxDecoration(
                color: index == 1 ? AppColors.btnEmeraldGreen : AppColors.textBlack,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.textBlack, width: 1),
              ),
            );
          }),
        ),
      );
}

class _MintPattern extends StatelessWidget {
  const _MintPattern();

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _PatternPainter(),
        child: const SizedBox.expand(),
      );
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x16000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    for (var i = 0; i < 9; i++) {
      final x = (i * 71.0) % size.width;
      final y = (i * 113.0) % size.height;
      canvas.drawCircle(Offset(x, y), 17 + (i % 3) * 8.0, paint);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - 13, y + 32, 26, 26),
          const Radius.circular(7),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
