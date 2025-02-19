import 'package:dartz/dartz.dart';
import 'package:growmind/features/home/domain/entities/purchase_entity.dart';
import 'package:growmind/features/home/domain/repositories/purchased_course_repository.dart';

class PurchaseCourseUsecases {
  final PurchasedCourseRepository purchasedCourseRepository;
  PurchaseCourseUsecases(this.purchasedCourseRepository);
  Future<Either<Exception, List<PurchaseEntity>>> call(String userId) async {
    try {
      final course = await purchasedCourseRepository.purchaseCourse(userId);
      return right(course);
    } catch (e) {
      return left(Exception('Failed to load $e'));
    }
  }
}
