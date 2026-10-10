import 'package:flutter/scheduler.dart';
import 'package:material_ui/material_ui.dart';

/// 当前是否处于构建 / 布局 / 绘制阶段（含组件 dispose），此时不能直接 setState。
bool get isFrameLocked =>
    SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks;

/// 在帧内（例如别的组件 dispose 里调用 hideLoading）把回调推迟到本帧结束后执行。
///
/// [action] 内部自行检查 mounted；推迟后会请求新的一帧，保证界面刷新。
void runWhenUnlocked(VoidCallback action) {
  if (!isFrameLocked) {
    action();
    return;
  }
  SchedulerBinding.instance.addPostFrameCallback((_) => action());
  SchedulerBinding.instance.ensureVisualUpdate();
}

/// 给 [State] 用的安全 setState：未挂载时忽略，帧内自动推迟。
extension SafeSetState<T extends StatefulWidget> on State<T> {
  void setStateSafely(VoidCallback fn) {
    runWhenUnlocked(() {
      // ignore: invalid_use_of_protected_member
      if (mounted) setState(fn);
    });
  }
}
