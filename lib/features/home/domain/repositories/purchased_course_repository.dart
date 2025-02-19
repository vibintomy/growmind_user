import 'package:growmind/features/home/domain/entities/purchase_entity.dart';

abstract class PurchasedCourseRepository {
  Future<List<PurchaseEntity>> purchaseCourse(String userId);
}
