import 'package:growmind/features/home/domain/entities/category.dart';
import 'package:growmind/features/home/domain/repositories/category_repository.dart';

class CategoryUsecases {
  final CategoryRepository categoryRepository;
  CategoryUsecases(this.categoryRepository);

  Future<List<FetchCategory>> call() {
    return categoryRepository.getCategory();
  }

  
}
