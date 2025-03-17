import 'package:growmind/features/home/data/models/notification_model.dart';

abstract class FCMDatasource {
  Future<void> sendPushNotification(NotificationModel notification);
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeToTopic(String topic);
  Future<String> getDeviceToken();
  Stream<NotificationModel> onNotificationReceived();
}
