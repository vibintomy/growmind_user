import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/home/domain/usecases/purchase_course_usecases.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_event.dart';
import 'package:growmind/features/home/presentation/bloc/purchased_bloc/purchased_state.dart';

class PurchasedBloc extends Bloc<PurchasedEvent, PurchasedState> {
  final PurchaseCourseUsecases purchaseCourseUsecases;
  PurchasedBloc(this.purchaseCourseUsecases):super(PurchasedInitial()){
    on<PurchasedCourseEvent>((event,emit)async{
      emit(PurchasedLoading());     
        final result = await purchaseCourseUsecases.call(event.userId);
       result.fold(
        (error)=> emit(PurchasedError(error.toString())),
        (course)=> emit(PurchasedLoaded(course))
       );     
    });
  }
}
