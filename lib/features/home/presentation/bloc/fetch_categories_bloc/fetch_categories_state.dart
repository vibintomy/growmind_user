import 'package:growmind/features/home/domain/entities/category.dart';


abstract class FetchCategoriesState {}

class FetchCategoriesInitial extends FetchCategoriesState {}

class FetchCategoriesLoading extends FetchCategoriesState {}

class FetchCategoriesLoaded extends FetchCategoriesState {
  final List<FetchCategory> value;
  FetchCategoriesLoaded(this.value);
}


class FetchCategoriesError extends FetchCategoriesState {
  final String error;
  FetchCategoriesError({required this.error});
}
