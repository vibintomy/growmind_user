import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind/features/chat/domain/entities/chat.dart';
import 'package:growmind/features/chat/domain/repositories/last_chat_repositories.dart';

class LastChatRepoImpl implements LastChatRepositories {
  final FirebaseFirestore firebaseFirestore;
  LastChatRepoImpl(this.firebaseFirestore);


Future<List<Chat>> getLastMessage(String userId) async {
  try {
    final querySnapshot = await  firebaseFirestore
        .collection('chat')
        .where('participants', arrayContains: userId)
        .get();
    
    return querySnapshot.docs.map((doc) => Chat(
      id: doc.id,
      participants: List<String>.from(doc.get('participants')),
      lastMessage: doc.get('lastMessage')??''
    )).toList();
  } catch (e) {
    throw Exception('Failed to get user chats: $e');
  }
}
}
