import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/auth/presentation/bloc/signup_bloc/bloc/signup_event.dart';
import 'package:growmind/features/auth/presentation/bloc/signup_bloc/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  SignupBloc({required this.auth, required this.firestore})
      : super(SignupInitial()) {
    on<SignupSubmitted>(onSignupSubmitted);
  }

  Future<void> onSignupSubmitted(
      SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'displayName': event.displayName,
        'email': event.email,
        'phone': event.phone,
        'uid': userCredential.user!.uid,
        'imageUrl':event.imageUrl
      });

      final user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(event.displayName);
        await user.sendEmailVerification();
        emit(SignupSuccess());
      } else {
        emit(const SignupFailure('User Credential Failed'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
      } else {
        errorMessage = 'An error occurred. Please try again.';
      }
      emit(SignupFailure(errorMessage));
    } catch (e) {
      emit(SignupFailure('An error occured $e'));
    }
  }
}
