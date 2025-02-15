import 'package:equatable/equatable.dart';

class CurriculumEvent extends Equatable {
  const CurriculumEvent();
  @override
  List<Object?> get props => [];
}

class ToggleSectionExpansion extends CurriculumEvent {
  final int sectionindex;
  final String videoUrl;
  const ToggleSectionExpansion(this.sectionindex, this.videoUrl);
  @override
  List<Object?> get props => [sectionindex, videoUrl];
}

class DisposeCurriculumVideo extends CurriculumEvent {
 const DisposeCurriculumVideo();
}
