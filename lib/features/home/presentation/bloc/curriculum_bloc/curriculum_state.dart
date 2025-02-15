import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

class CurriculumState extends Equatable {
  final int? expandedSectionIndex;
  final VideoPlayerController? videoPlayerController;
  final bool isLoading;
  final ChewieController? chewieController;
  final String? error;
  const CurriculumState(
      {this.expandedSectionIndex,
      this.videoPlayerController,
      this.chewieController,
      this.isLoading = false,
      this.error});

  CurriculumState copyWith(
      {int? expandedSectionIndex,
      VideoPlayerController? videoPlayerController,
      ChewieController?chewieController,
      bool? isLoading,
      String? error}) {
    return CurriculumState(
        expandedSectionIndex: expandedSectionIndex ?? this.expandedSectionIndex,
        videoPlayerController:
            videoPlayerController ?? this.videoPlayerController,
            chewieController: chewieController?? this.chewieController,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props =>
      [expandedSectionIndex, videoPlayerController,chewieController, isLoading, error];
}
