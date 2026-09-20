# Theme types

All types live in `lib/src/model/toast_theme.dart` and are exported from
`package:flutter_toast_pro/flutter_toast_pro.dart`.

`Used by overlay` / `Used by default widget` below means the default
rendering path in `ToastOverlay` and the default message/loading/progress
widgets. Custom builders do not read these fields unless you do.

There are no `successColor` / `errorColor` / `blurSigma` fields on
`MessageToastTheme`.

---

## `ToastThemeData`

`@immutable`. Default message position, stack limits, animation, and
sub-themes.

### Constructor

```dart
const ToastThemeData({
  this.position = ToastPosition.top,
  this.maxVisibleToasts = 5,
  this.spacing = 8.0,
  this.animationDuration = const Duration(milliseconds: 300),
  this.animationCurve = Curves.easeOutCubic,
  this.reverseAnimationDuration,
  this.reverseAnimationCurve = Curves.easeInCubic,
  this.enableGlassmorphism = true,
  this.enableSwipeToDismiss = true,
  this.messageTheme = const MessageToastTheme(),
  this.loadingTheme = const LoadingToastTheme(),
  this.progressTheme = const ProgressToastTheme(),
});
```

| Field | Type | Default | Used by | Notes |
|-------|------|---------|---------|-------|
| `position` | `ToastPosition` | `ToastPosition.top` | `FlutterToastPro.show` when `position` is omitted | Default for **message** toasts only. `loading` / `progress` default to `ToastPosition.center` on those APIs. |
| `maxVisibleToasts` | `int` | `5` | `ToastManager._enforceMaxVisible` | Oldest `MessageToastItem`s are dismissed when the count exceeds this. Loading and progress are ignored. |
| `spacing` | `double` | `8.0` | Overlay stack padding | Vertical gap between stacked entries; also a spacer above top / below bottom stacks. |
| `animationDuration` | `Duration` | `300ms` | Enter animation | |
| `animationCurve` | `Curve` | `Curves.easeOutCubic` | Enter animation | |
| `reverseAnimationDuration` | `Duration?` | `null` | Exit animation | `null` uses `animationDuration`. |
| `reverseAnimationCurve` | `Curve` | `Curves.easeInCubic` | Exit animation | |
| `enableGlassmorphism` | `bool` | `true` | Default loading / progress `GlassContainer.enableBlur` | Passed to the default message widget as `enableGlass` but that widget does **not** apply backdrop blur. |
| `enableSwipeToDismiss` | `bool` | `true` | Message `DismissibleToast` | Combined with `MessageToastItem.swipeToDismiss`. Still blocked when `messageTheme.ignorePointer` is `true`. |
| `messageTheme` | `MessageToastTheme` | `const MessageToastTheme()` | Default message widget + message pointer wrapping | |
| `loadingTheme` | `LoadingToastTheme` | `const LoadingToastTheme()` | Default loading widget + loading barrier | |
| `progressTheme` | `ProgressToastTheme` | `const ProgressToastTheme()` | Default progress widget + progress barrier | |

### `copyWith`

```dart
ToastThemeData copyWith({
  ToastPosition? position,
  int? maxVisibleToasts,
  double? spacing,
  Duration? animationDuration,
  Curve? animationCurve,
  Duration? reverseAnimationDuration,
  Curve? reverseAnimationCurve,
  bool? enableGlassmorphism,
  bool? enableSwipeToDismiss,
  MessageToastTheme? messageTheme,
  LoadingToastTheme? loadingTheme,
  ProgressToastTheme? progressTheme,
});
```

Each omitted argument keeps the current value (`??`).

---

## `MessageToastTheme`

`@immutable`. **No `copyWith`.** Construct a new instance to change fields.

### Constructor

```dart
const MessageToastTheme({
  this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  this.margin = const EdgeInsets.symmetric(horizontal: 16),
  this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  this.showIcon = true,
  this.elevation = 0,
  this.textStyle,
  this.actionTextStyle,
  this.infoForegroundColor = const Color.fromRGBO(0, 122, 255, 1.0),
  this.infoBackgroundColor = const Color.fromRGBO(239, 246, 255, 1.0),
  this.successForegroundColor = const Color.fromRGBO(52, 199, 89, 1.0),
  this.successBackgroundColor = const Color.fromRGBO(240, 253, 244, 1.0),
  this.warningForegroundColor = const Color.fromRGBO(255, 149, 0, 1.0),
  this.warningBackgroundColor = const Color.fromRGBO(254, 243, 199, 1.0),
  this.errorForegroundColor = const Color.fromRGBO(255, 59, 48, 1.0),
  this.errorBackgroundColor = const Color.fromRGBO(254, 242, 242, 1.0),
  this.barrierColor = Colors.transparent,
  this.ignorePointer = true,
  this.barrierDismissible = false,
  this.tapToDismiss = true,
});
```

| Field | Type | Default | Used by default path | Notes |
|-------|------|---------|----------------------|-------|
| `padding` | `EdgeInsetsGeometry` | `h:12, v:8` | Yes | Inner padding of the card. |
| `margin` | `EdgeInsetsGeometry` | `h:16` | Yes | Outer margin of the card. |
| `borderRadius` | `BorderRadiusGeometry` | `8` | Yes | |
| `showIcon` | `bool` | `true` | Yes | When true, shows `item.icon` or the type default icon. |
| `elevation` | `double` | `0` | **No** | Declared only. Default message widget uses a fixed `BoxShadow` (blur 12, offset `(0, 4)`). |
| `textStyle` | `TextStyle?` | `null` | Yes | Color is replaced per type; default widget also forces `fontSize: 14`, `fontWeight: w500`. |
| `actionTextStyle` | `TextStyle?` | `null` | Yes | Color is replaced per type; default widget also forces `fontSize: 12`, `fontWeight: w700`. |
| `infoForegroundColor` | `Color?` | `RGBO(0, 122, 255, 1)` | Yes | If explicitly `null`, default widget falls back to `ColorScheme.primary`. |
| `infoBackgroundColor` | `Color?` | `RGBO(239, 246, 255, 1)` | Yes | If explicitly `null`, default widget falls back to `ColorScheme.primary`. |
| `successForegroundColor` | `Color?` | `RGBO(52, 199, 89, 1)` | Yes | If explicitly `null`, fallback `Color(0xFF16A34A)`. |
| `successBackgroundColor` | `Color?` | `RGBO(240, 253, 244, 1)` | Yes | If explicitly `null`, fallback `Color(0xFF16A34A)`. |
| `warningForegroundColor` | `Color?` | `RGBO(255, 149, 0, 1)` | Yes | If explicitly `null`, fallback `Color(0xFFF59E0B)`. |
| `warningBackgroundColor` | `Color?` | `RGBO(254, 243, 199, 1)` | Yes | If explicitly `null`, fallback `Color(0xFFF59E0B)`. |
| `errorForegroundColor` | `Color?` | `RGBO(255, 59, 48, 1)` | Yes | If explicitly `null`, fallback `ColorScheme.error`. |
| `errorBackgroundColor` | `Color?` | `RGBO(254, 242, 242, 1)` | Yes | If explicitly `null`, fallback `ColorScheme.error`. |
| `barrierColor` | `Color` | `Colors.transparent` | **No** | Default overlay never reads this. Message toasts do not create a full-screen barrier. |
| `ignorePointer` | `bool` | `true` | Yes | Wraps the message (including swipe / tap handlers). `true` blocks swipe and tap-to-dismiss. |
| `barrierDismissible` | `bool` | `false` | **No** | Default overlay never reads this. |
| `tapToDismiss` | `bool` | `true` | Yes | Tap on the toast calls dismiss, but only if `ignorePointer` is `false`. |

Default icons when `item.icon` is null: `Icons.info_outline_rounded`,
`Icons.check_circle_outline_rounded`, `Icons.warning_amber_rounded`,
`Icons.error_outline_rounded`.

---

## `LoadingToastTheme`

`@immutable`. Has `copyWith` (every field, `??` keep-current).

### Constructor

```dart
const LoadingToastTheme({
  this.padding = const EdgeInsets.all(24),
  this.margin,
  this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  this.blurSigma = 20.0,
  this.backgroundColor,
  this.indicatorSize = 28.0,
  this.indicatorColor,
  this.messageTextStyle,
  this.messageSpacing = 12.0,
  this.overlayColor = const Color(0x33000000),
  this.ignorePointer = false,
  this.barrierDismissible = false,
});
```

| Field | Type | Default | Used by | Notes |
|-------|------|---------|---------|-------|
| `padding` | `EdgeInsetsGeometry` | `24` all | Default loading `GlassContainer` | |
| `margin` | `EdgeInsetsGeometry?` | `null` | Default loading `GlassContainer` | |
| `borderRadius` | `BorderRadiusGeometry` | `20` | Default loading `GlassContainer` | Resolved with `Directionality`. |
| `blurSigma` | `double` | `20.0` | `GlassContainer` | Blur is off when `enableGlassmorphism` is false or `blurSigma <= 0`. |
| `backgroundColor` | `Color?` | `null` | Default loading widget | Dark: `Colors.black` α 0.65; light: `Colors.white` α 0.85. |
| `indicatorSize` | `double` | `28.0` | `CupertinoActivityIndicator` | Passed as `radius: indicatorSize / 2`. |
| `indicatorColor` | `Color?` | `null` | Default loading widget | Dark: white; light: `ColorScheme.primary`. |
| `messageTextStyle` | `TextStyle?` | `null` | Optional message | Fallback: 13px, dark `white70` / light `black87`. |
| `messageSpacing` | `double` | `12.0` | Gap above the message | Only if `message != null`. |
| `overlayColor` | `Color` | `0x33000000` | Full-screen barrier while a loading toast exists | First loading item in the list wins. |
| `ignorePointer` | `bool` | `false` | Barrier `IgnorePointer` | `false` blocks hits to the app under the barrier. |
| `barrierDismissible` | `bool` | `false` | Barrier tap | When `true` and `ignorePointer` is `false`, tapping the barrier dismisses that loading toast. |

### `copyWith`

Same optional named parameters as the constructor. Omitted values keep the
current field.

---

## `ProgressToastTheme`

`@immutable`. Has `copyWith` (every field, `??` keep-current).

### Constructor

```dart
const ProgressToastTheme({
  this.padding = const EdgeInsets.all(24),
  this.margin,
  this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  this.blurSigma = 20.0,
  this.backgroundColor,
  this.indicatorSize = 56.0,
  this.indicatorColor,
  this.indicatorBackgroundColor,
  this.strokeWidth = 4.0,
  this.messageTextStyle,
  this.overlayColor = const Color(0x33000000),
  this.ignorePointer = false,
  this.barrierDismissible = false,
});
```

| Field | Type | Default | Used by | Notes |
|-------|------|---------|---------|-------|
| `padding` | `EdgeInsetsGeometry` | `24` all | Default progress `GlassContainer` | |
| `margin` | `EdgeInsetsGeometry?` | `null` | Default progress `GlassContainer` | |
| `borderRadius` | `BorderRadiusGeometry` | `20` | Default progress `GlassContainer` | |
| `blurSigma` | `double` | `20.0` | `GlassContainer` | Same blur gate as loading. |
| `backgroundColor` | `Color?` | `null` | Default progress widget | Same dark/light fallbacks as loading. |
| `indicatorSize` | `double` | `56.0` | `SizedBox` around `CircularProgressIndicator` | Percent label font size is `indicatorSize * 0.22`. |
| `indicatorColor` | `Color?` | `null` | Indicator foreground | Dark: white; light: `ColorScheme.primary`. |
| `indicatorBackgroundColor` | `Color?` | `null` | Indicator track | Fallback: `indicatorColor` α 0.2. |
| `strokeWidth` | `double` | `4.0` | `CircularProgressIndicator` | |
| `messageTextStyle` | `TextStyle?` | `null` | Optional message | Fallback: 13px, dark `white70` / light `black87`. |
| `overlayColor` | `Color` | `0x33000000` | Full-screen barrier while a progress toast exists (if no loading toast is present first) | Overlay scans items and prefers loading over progress. |
| `ignorePointer` | `bool` | `false` | Barrier `IgnorePointer` | |
| `barrierDismissible` | `bool` | `false` | Barrier tap | Same interaction rules as loading. |

There is no `messageSpacing` field. The default progress widget hard-codes
`SizedBox(height: 12)` between the indicator and the message.

### `copyWith`

Same optional named parameters as the constructor, including
`indicatorBackgroundColor`. Omitted values keep the current field.
