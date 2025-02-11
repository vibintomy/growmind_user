import 'package:growmind/features/home/domain/entities/category.dart';


abstract class CategoryRepository {
  Future<List<FetchCategory>> getCategory();
}
