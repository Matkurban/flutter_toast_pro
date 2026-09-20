# GlassContainer

Public `StatelessWidget` from `package:flutter_toast_pro/flutter_toast_pro.dart`
(`export 'src/ui/glass_container.dart'`).

Frosted-glass card. When blur is off, it is a decorated `Container`.
Default loading and progress widgets wrap their content in this class.
Message defaults do not.

## Constructor

```dart
const GlassContainer({
  super.key,
  required this.child,
  this.enableBlur = true,
  this.blurSigma = 20.0,
  this.backgroundColor,
  this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  this.padding,
  this.margin,
  this.border,
  this.elevation = 0,
  this.constraints,
});
```

| Field | Type | Default | Role |
|-------|------|---------|------|
| `child` | `Widget` | required | Content inside the card. |
| `enableBlur` | `bool` | `true` | When `false`, skips `BackdropFilter`. |
| `blurSigma` | `double` | `20.0` | `ImageFilter.blur` sigma on X and Y. `<= 0` also skips blur. |
| `backgroundColor` | `Color?` | `null` | Fill color. Dark fallback: white α 0.1. Light fallback: white α 0.25. |
| `borderRadius` | `BorderRadiusGeometry` | `Radius.circular(16)` | Decoration radius. Blur path `resolve`s it with `Directionality`. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Inner padding. |
| `margin` | `EdgeInsetsGeometry?` | `null` | Outer margin on the inner `Container`. |
| `border` | `Border?` | `null` | Dark fallback: white α 0.08, width 0.5. Light fallback: white α 0.3, width 0.5. |
| `elevation` | `double` | `0` | If `> 0`, one `BoxShadow`: black α 0.08, `blurRadius: elevation * 2`, `offset: Offset(0, elevation)`. |
| `constraints` | `BoxConstraints?` | `null` | Passed to the inner `Container`. |

## `build`

1. Resolve background and border from theme brightness when those fields
   are null.
2. Build a `Container` with margin, constraints, decoration, padding, child.
3. If `!enableBlur || blurSigma <= 0`, return that container.
4. Otherwise wrap in `ClipRRect` + `BackdropFilter`.

```dart
GlassContainer(
  enableBlur: true,
  blurSigma: 20,
  padding: const EdgeInsets.all(16),
  child: const Text('Custom card'),
);
```
