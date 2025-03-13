import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/chat/domain/usecases/last_chat_usecases.dart';
import 'package:growmind/features/chat/presentation/bloc/last_chat_bloc/last_chat_event.dart';
import 'package:growmind/features/chat/presentation/bloc/last_chat_bloc/last_chat_state.dart';

class LastChatBloc extends Bloc<LastChatEvent, LastChatState> {
  final LastChatUsecases lastChatUsecases;
  LastChatBloc(this.lastChatUsecases) : super(LastChatInitial()) {
    on<GetLastChatEvent>((event, emit) async {
      emit(LastChatLoading());

      try {
        final lastChat = await lastChatUsecases.call(event.userId);
        emit(LastChatLoaded(lastChat));
      } catch (e) {
        emit(LastChatError(e.toString()));
      }
    });
  }
}
