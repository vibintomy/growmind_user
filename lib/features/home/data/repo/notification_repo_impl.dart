import 'package:growmind/features/home/data/datasource/fcm_datasource.dart';
import 'package:growmind/features/home/data/models/notification_model.dart';
import 'package:growmind/features/home/domain/entities/notification_entities.dart';
import 'package:growmind/features/home/domain/repositories/notification_repositories.dart';

class NotificationRepoImpl implements NotificationRepositories {
  final FCMDatasource fcmDatasource;
  NotificationRepoImpl(this.fcmDatasource);

  @override
  Future<String> getDeviceToken() {
    return fcmDatasource.getDeviceToken();
  }

  @override
  Stream<NotificationEntities> onNotificationReceived() {
    return fcmDatasource.onNotificationReceived();
  }

  @override
  Future<void> sendPushNotification(NotificationEntities notification) {
    return fcmDatasource.sendPushNotification(NotificationModel(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        senderId: notification.senderId,
        receiverId: notification.receiverId,
        timeStamp: notification.timeStamp,
        data: notification.data));
  }

  @override
  Future<void> subscribeToTopic(String topic) {
    return fcmDatasource.subscribeToTopic(topic);
  }

@override
  Future<void> unsubscribeFromTopic(String topic) {
    return fcmDatasource.unsubscribeToTopic(topic);
  }
}
