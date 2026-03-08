import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';

abstract class UsecaseWithParams<T, P> {
  const UsecaseWithParams();

  ResultObject<T> call(P params);
}

abstract class UsecaseWithoutParams<T> {
  const UsecaseWithoutParams();

  ResultObject<T> call();
}
