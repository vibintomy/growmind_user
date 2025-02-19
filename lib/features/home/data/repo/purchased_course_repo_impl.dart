import 'package:growmind/features/home/data/datasource/purchased_course_datasource.dart';
import 'package:growmind/features/home/domain/entities/purchase_entity.dart';
import 'package:growmind/features/home/domain/repositories/purchased_course_repository.dart';

class PurchasedCourseRepoImpl implements PurchasedCourseRepository {
  final PurchasedCourseDatasource purchasedCourseDatasource;
  PurchasedCourseRepoImpl(this.purchasedCourseDatasource);

  @override
  Future<List<PurchaseEntity>> purchaseCourse(String userId) async {
    List<String>purchases = await purchasedCourseDatasource.purchasedCourse(userId);
    return purchases.map((userId)=> PurchaseEntity(userId: userId)).toList();
  }
}
