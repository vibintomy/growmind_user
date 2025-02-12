abstract class CourseEvent {}

class FetchCourseEvent extends CourseEvent {
  final String categoryId;
  FetchCourseEvent({required this.categoryId});
}

class SearchCourseEvent extends CourseEvent {
  final String query;
  SearchCourseEvent(this.query);
}

class FilterSubCatCourse extends CourseEvent {
  final String? subCategory;
  FilterSubCatCourse(this.subCategory);
}
