abstract class FetchCategoriesEvent {}

class GetCategoriesEvent extends FetchCategoriesEvent {}

class SearchCategoriesEvent extends FetchCategoriesEvent {
  final String query;
  SearchCategoriesEvent({required this.query});
}
