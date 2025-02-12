import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/home/domain/entities/category.dart';
import 'package:growmind/features/home/domain/usecases/category_usecases.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_categories_bloc/fetch_categories_event.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_categories_bloc/fetch_categories_state.dart';

class FetchCategoriesBloc
    extends Bloc<FetchCategoriesEvent, FetchCategoriesState> {
  final CategoryUsecases usecases;
  List<FetchCategory> allCategories = [];


  FetchCategoriesBloc({required this.usecases})
      : super(FetchCategoriesInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(FetchCategoriesLoading());
      try {
        final categories = await usecases.call();
        allCategories = categories;
        emit(FetchCategoriesLoaded(categories));
      } catch (e) {
        emit(FetchCategoriesError(error: e.toString()));
      }
    });

    on<SearchCategoriesEvent>((event, emit) {
      final filteredCategories = allCategories
          .where((category) => category.category
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();
      emit(FetchCategoriesLoaded(filteredCategories));
    });

   
  }
}
