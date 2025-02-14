import 'package:equatable/equatable.dart';

 class CurriculumEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleSection extends CurriculumEvent {
  final int index;
  final String videoUrl;
  ToggleSection({required this.index, required this.videoUrl});
   @override
  List<Object?> get props => [index,videoUrl];
}
