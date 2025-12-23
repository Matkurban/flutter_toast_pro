import 'package:rxdart/rxdart.dart';

import 'model/toast_data_model.dart';
import 'model/toast_type.dart';

/// Global toast event bus.
///
/// 全局 toast 事件总线。
sealed class ToastEvent {
  /// Stream that emits the latest toast data to show.
  ///
  /// 用于“显示 toast”的数据流（始终保留最新值）。
  ///
  /// Note: This is a [BehaviorSubject] seeded with [ToastDataModel.empty].
  ///
  /// 注意：这是一个 [BehaviorSubject]，初始值为 [ToastDataModel.empty]。
  static BehaviorSubject<ToastDataModel> showMessages = BehaviorSubject.seeded(
    ToastDataModel.empty(),
  );

  /// Stream that emits a toast type to hide.
  ///
  /// 用于“隐藏 toast”的事件流（发出要隐藏的 toast 类型）。
  static PublishSubject<ToastType> hideMessages = PublishSubject();
}
