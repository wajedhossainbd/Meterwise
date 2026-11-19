import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_tokens.dart';

/// The engine of the "Soft Modern" design language.
///
/// Depth is expressed with *paired* shadows — a light highlight on the top-left
/// and a darker shade on the bottom-right — against a single neutral base that
/// is shared by the background and every surface. Inset (inner) shadows create
/// wells and pressed states. No gradients, no glows, no coloured surfaces.
enum SoftDepth { subtle, normal, strong }

/// Brightness-aware colour and shadow tokens plus the reusable soft widgets.
class Soft {
  const Soft._();

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color base(BuildContext context) =>
      isDark(context) ? AppColors.baseDark : AppColors.baseLight;
  /// The tile colour — a warm cream that lifts off the orange-tinted canvas.
  static Color surface(BuildContext context) =>
      isDark(context) ? AppColors.baseDark : AppColors.surfaceLight;
  static Color inset(BuildContext context) =>
      isDark(context) ? AppColors.insetDark : AppColors.insetLight;
  static Color lightShadow(BuildContext context) =>
      isDark(context) ? AppColors.lightShadowDark : AppColors.lightShadowLight;
  static Color darkShadow(BuildContext context) =>
      isDark(context) ? AppColors.darkShadowDark : AppColors.darkShadowLight;
  static Color text(BuildContext context) =>
      isDark(context) ? AppColors.textDark : AppColors.textLight;
  static Color muted(BuildContext context) =>
      isDark(context) ? AppColors.textMutedDark : AppColors.textMutedLight;
  static Color accent(BuildContext context) =>
      isDark(context) ? AppColors.seedDark : AppColors.seed;
  /// Deeper orange for icons and small text on light surfaces.
  static Color accentInk(BuildContext context) =>
      isDark(context) ? AppColors.accentInkDark : AppColors.accentInk;
  static Color success(BuildContext context) =>
      isDark(context) ? AppColors.creditDark : AppColors.credit;
  static Color danger(BuildContext context) =>
      isDark(context) ? AppColors.dueDark : AppColors.due;

  static double _distance(SoftDepth depth) => switch (depth) {
        SoftDepth.subtle => 2.5,
        SoftDepth.normal => AppTokens.softDistance,
        SoftDepth.strong => 9.0,
      };
  static double _blur(SoftDepth depth) => switch (depth) {
        SoftDepth.subtle => 6.0,
        SoftDepth.normal => AppTokens.softBlur,
        SoftDepth.strong => 20.0,
      };

  /// Extruded surface: light top-left, dark bottom-right.
  static List<BoxShadow> raised(BuildContext context,
          {SoftDepth depth = SoftDepth.normal}) =>
      _shadows(context, depth: depth, inset: false);

  /// Pressed / well: reversed inner shadows.
  static List<BoxShadow> pressed(BuildContext context,
          {SoftDepth depth = SoftDepth.normal}) =>
      _shadows(context, depth: depth, inset: true);

  static List<BoxShadow> _shadows(BuildContext context,
      {required SoftDepth depth, required bool inset}) {
    final d = _distance(depth);
    final b = _blur(depth);
    final light = lightShadow(context);
    final dark = darkShadow(context);
    if (inset) {
      return [
        BoxShadow(
          color: dark,
          offset: Offset(d * 0.6, d * 0.6),
          blurRadius: b,
          blurStyle: BlurStyle.inner,
        ),
        BoxShadow(
          color: light,
          offset: Offset(-d * 0.6, -d * 0.6),
          blurRadius: b,
          blurStyle: BlurStyle.inner,
        ),
      ];
    }
    return [
      BoxShadow(
        color: light,
        offset: Offset(-d, -d),
        blurRadius: b,
        spreadRadius: AppTokens.softSpread,
      ),
      BoxShadow(
        color: dark,
        offset: Offset(d, d),
        blurRadius: b,
        spreadRadius: AppTokens.softSpread,
      ),
    ];
  }

  /// A circular soft tile used for icons and avatars.
  static BorderRadius get circle => BorderRadius.circular(AppTokens.radiusPill);
}

/// Restrained gradient washes used only on feature surfaces and icon tiles.
/// White cards stay white; colour is a deliberate accent, not the canvas.
class SoftGradient {
  const SoftGradient._();

  /// The dashboard hero: a warm electricity gradient, light to deep.
  static const LinearGradient hero = LinearGradient(
    colors: [
      Color(0xFFFFB85C),
      Color(0xFFF78837),
      Color(0xFFE8622E),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// A green credit / red due gradient for the tenant balance hero.
  static const LinearGradient credit = LinearGradient(
    colors: [Color(0xFF46B98C), Color(0xFF1F7A54)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient due = LinearGradient(
    colors: [Color(0xFFEF8062), Color(0xFFC44532)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// A subtle sheen for a single coloured icon tile.
  static LinearGradient tile(Color color) => LinearGradient(
        colors: [
          Color.lerp(color, Colors.white, 0.30)!,
          color,
          Color.lerp(color, Colors.black, 0.10)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}

/// The universal soft container. Everything that needs to "sit on" the surface
/// is built from this one widget: cards, tiles, buttons, wells and icon pads.
class SoftSurface extends StatelessWidget {
  const SoftSurface({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.color,
    this.gradient,
    this.borderRadius,
    this.inset = false,
    this.depth = SoftDepth.normal,
    this.onTap,
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final bool inset;
  final SoftDepth depth;
  final VoidCallback? onTap;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ??
        BorderRadius.circular(AppTokens.radiusCard);
    final background = color ??
        (inset ? Soft.inset(context) : Soft.surface(context));

    Widget content = child;
    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: content,
        ),
      );
    }

    return AnimatedContainer(
      duration: AppTokens.durationShort,
      curve: AppTokens.easing,
      margin: margin,
      padding: padding,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: gradient == null ? background : null,
        gradient: gradient,
        borderRadius: radius,
        boxShadow: inset
            ? Soft.pressed(context, depth: depth)
            : Soft.raised(context, depth: depth),
      ),
      child: content,
    );
  }
}

/// A drop-in replacement for Material [Card] with soft extruded depth.
///
/// Callers keep their own Padding around content, exactly as with Card.
class SoftCard extends StatelessWidget {
  const SoftCard({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.color,
    this.gradient,
    this.onTap,
    this.inset = false,
    this.depth = SoftDepth.normal,
    this.borderRadius,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final bool inset;
  final SoftDepth depth;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => SoftSurface(
        padding: padding,
        margin: margin,
        color: color,
        gradient: gradient,
        onTap: onTap,
        inset: inset,
        depth: depth,
        borderRadius: borderRadius,
        child: child,
      );
}

/// A circular icon button that extrudes at rest and sinks when pressed.
class SoftIconButton extends StatefulWidget {
  const SoftIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.size = AppTokens.iconButtonSize,
    this.color,
    this.iconSize = AppTokens.iconMedium,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final Color? color;
  final double iconSize;

  @override
  State<SoftIconButton> createState() => _SoftIconButtonState();
}

class _SoftIconButtonState extends State<SoftIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final button = AnimatedScale(
      scale: _pressed ? 0.94 : 1,
      duration: AppTokens.durationShort,
      curve: AppTokens.easing,
      child: GestureDetector(
        onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
        onTapUp: enabled ? (_) => setState(() => _pressed = false) : null,
        onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
        onTap: enabled ? widget.onPressed : null,
        child: SoftSurface(
          inset: _pressed,
          depth: SoftDepth.subtle,
          borderRadius: Soft.circle,
          padding: const EdgeInsets.all(AppTokens.s2),
          child: SizedBox(
            width: widget.size - AppTokens.s4,
            height: widget.size - AppTokens.s4,
            child: Icon(
              widget.icon,
              size: widget.iconSize,
              color: widget.color ?? Soft.accentInk(context),
            ),
          ),
        ),
      ),
    );
    return widget.tooltip == null
        ? Semantics(button: true, child: button)
        : Tooltip(message: widget.tooltip!, child: Semantics(button: true, child: button));
  }
}

/// A reusable recessed icon tile — the consistent accent container used across
/// lists, settings and status rows. Replaces ad-hoc tinted circles.
class SoftIconTile extends StatelessWidget {
  const SoftIconTile({
    required this.icon,
    super.key,
    this.color,
    this.size = AppTokens.iconButtonSize,
    this.iconSize = AppTokens.iconMedium,
    this.circular = false,
  });

  final IconData icon;
  final Color? color;
  final double size;
  final double iconSize;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    final inner = size - AppTokens.s4;
    final tileColor = color ?? Soft.accentInk(context);
    return SoftSurface(
      depth: SoftDepth.subtle,
      gradient: SoftGradient.tile(tileColor),
      borderRadius: circular
          ? Soft.circle
          : BorderRadius.circular(AppTokens.radiusControl),
      child: SizedBox(
        width: inner,
        height: inner,
        child: Icon(icon, size: iconSize, color: Colors.white),
      ),
    );
  }
}

/// An inset well — used for charts, progress tracks and read-only value blocks.
class SoftInset extends StatelessWidget {
  const SoftInset({required this.child, super.key, this.padding, this.radius});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? radius;

  @override
  Widget build(BuildContext context) => SoftSurface(
        inset: true,
        depth: SoftDepth.subtle,
        padding: padding,
        borderRadius: BorderRadius.circular(radius ?? AppTokens.radiusCard),
        child: child,
      );
}
