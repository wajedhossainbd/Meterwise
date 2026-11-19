import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_tokens.dart';
import '../theme/soft_ui.dart';

/// Shows an animated welcome splash (logo scale-in + name fade) over the app
/// on cold start, then fades away. Shown once per app session.
class SplashGate extends StatefulWidget {
  const SplashGate({required this.child, super.key});

  final Widget child;

  /// Once the splash has played this session, later rebuilds skip it (e.g.
  /// when the root swaps between onboarding and the main app).
  static bool _playedThisSession = false;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _overlayFade;
  bool _done = SplashGate._playedThisSession;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    );
    _logoScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutBack),
    );
    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
    );
    _textFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.55, curve: Curves.easeOut),
    );
    _textSlide = Tween(begin: const Offset(0, 0.6), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    _overlayFade = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.82, 1.0, curve: Curves.easeIn),
      ),
    );

    if (!_done) {
      _controller.forward().whenComplete(() {
        SplashGate._playedThisSession = true;
        if (mounted) setState(() => _done = true);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return widget.child;

    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => IgnorePointer(
            ignoring: _overlayFade.value < 0.05,
            child: Opacity(
              opacity: _overlayFade.value,
              // Material ancestor: the overlay lives above the Navigator, so
              // without it Text falls back to the debug style (yellow double
              // underline).
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                decoration: BoxDecoration(color: Soft.base(context)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeTransition(
                        opacity: _logoFade,
                        child: ScaleTransition(
                          scale: _logoScale,
                          // A raised soft disc with a recessed dial and the
                          // brand bolt — the app's signature motif.
                          child: SoftSurface(
                            depth: SoftDepth.strong,
                            borderRadius: Soft.circle,
                            padding: const EdgeInsets.all(AppTokens.s5),
                            child: SoftInset(
                              radius: AppTokens.radiusPill,
                              padding: const EdgeInsets.all(AppTokens.s5),
                              child: Icon(
                                Icons.bolt,
                                size: 54,
                                color: Soft.accent(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeTransition(
                        opacity: _textFade,
                        child: SlideTransition(
                          position: _textSlide,
                          child: Column(
                            children: [
                              Text(
                                AppConstants.appName,
                                style: TextStyle(
                                  color: Soft.text(context),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                AppConstants.appTagline,
                                style: TextStyle(
                                  color: Soft.muted(context),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
