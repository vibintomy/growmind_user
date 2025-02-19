import 'package:growmind/features/home/domain/entities/purchase_entity.dart';

abstract class PurchasedState {}

class PurchasedInitial extends PurchasedState {}

class PurchasedLoading extends PurchasedState {}

class PurchasedLoaded extends PurchasedState {
  final List<PurchaseEntity> course;
  PurchasedLoaded(this.course);
}

class PurchasedError extends PurchasedState {
  final String error;
  PurchasedError(this.error);
}
