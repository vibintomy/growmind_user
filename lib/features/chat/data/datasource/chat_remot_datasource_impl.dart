import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:growmind/features/chat/data/model/message_model.dart';

class ChatRemotDatasourceimpl implements ChatRemoteDatasource  {
  final FirebaseFirestore firestore;
  ChatRemotDatasourceimpl(this.firestore);
  @override
  Stream<List<MessageModel>> getMessages(String receiverId) {
    return firestore
        .collection('chat')
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList());
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    await firestore.collection('chat').add(message.toJson());
  }
}
