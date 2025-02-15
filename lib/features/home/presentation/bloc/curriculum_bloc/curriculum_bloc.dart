import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/curriculum_bloc/curriculum_event.dart';
import 'package:growmind/features/home/presentation/bloc/curriculum_bloc/curriculum_state.dart';
import 'package:video_player/video_player.dart';

class CurriculumBloc extends Bloc<CurriculumEvent, CurriculumState> {
  CurriculumBloc() : super(CurriculumState()) {
    on<ToggleSectionExpansion>(onToggleSectionExpansion);
    on<DisposeCurriculumVideo>(onDisposeCurriculumVideo);
  }

  Future<void> onToggleSectionExpansion(
      ToggleSectionExpansion event, Emitter<CurriculumState> emit) async {
    if (state.expandedSectionIndex == event.sectionindex) {
      await state.videoPlayerController?.dispose();
       state.chewieController?.dispose();
      emit(const CurriculumState());
      return;
    }
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await state.videoPlayerController?.dispose();
       state.chewieController?.dispose();
      final controller = VideoPlayerController.network(event.videoUrl);
      final chewieController = ChewieController(
          videoPlayerController: controller,
          autoPlay: false,
          looping: false,
          allowMuting: true,
          allowFullScreen: true);
      await controller.initialize();
      emit(state.copyWith(
          expandedSectionIndex: event.sectionindex,
          videoPlayerController: controller,
          chewieController: chewieController,
          isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load video: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> onDisposeCurriculumVideo(
      DisposeCurriculumVideo event, Emitter<CurriculumState> emit) async {
    await state.videoPlayerController?.dispose();
     state.chewieController?.dispose();
    emit(const CurriculumState());
  }

  @override
  Future<void> close() {
    state.videoPlayerController?.dispose();
    state.chewieController?.dispose();
    return super.close();
  }
}
