abstract class FetchCategoriesEvent {}

class GetCategoriesEvent extends FetchCategoriesEvent {}



class SearchCategoriesEvent extends FetchCategoriesEvent {
  final String query;
  SearchCategoriesEvent({required this.query});
}

class UpdateFilterEvent extends FetchCategoriesEvent {
  final String selectedFilter;
  UpdateFilterEvent(this.selectedFilter);
}
