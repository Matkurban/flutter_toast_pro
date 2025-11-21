import 'package:rxdart/rxdart.dart';

import 'model/toast_data_model.dart';
import 'model/toast_type.dart';

sealed class ToastEvent {
  ///显示消息的监听
  static BehaviorSubject<ToastDataModel> showMessages = BehaviorSubject.seeded(
    ToastDataModel.empty(),
  );

  ///关闭消息的监听
  static PublishSubject<ToastType> hideMessages = PublishSubject();
}
