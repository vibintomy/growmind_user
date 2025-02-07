import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/profile/domain/usecases/update_profile_usecases.dart';
import 'package:growmind/features/profile/presentation/bloc/update_profile_bloc/bloc/update_profile_event.dart';
import 'package:growmind/features/profile/presentation/bloc/update_profile_bloc/bloc/update_profile_state.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  final UpdateProfileUsecases updateProfileUsecases;
  ProfileUpdateBloc(this.updateProfileUsecases)
      : super(ProfileUpdateInitial()) {
    on<UploadImageEvent>((event, emit) async {
      try {
        final imageUrl =
            await updateProfileUsecases.uploadImage(event.imagePath);
        emit(ProfileImageUpdate(imageUrl));
      } catch (e) {
    
        throw Exception('Error Adding image');
      }
      emit(ProfileError('Error'));
    });

    on<AddDetailsEvent>((event, emit) async {
      try {
        await updateProfileUsecases.call(
            id: event.id,
            name: event.name,
            phone: event.number,
            imageUrl: event.imageUrl);

        emit(ProfileUpdated());
        print('you are successfully added the data');
      } catch (e) {
        throw Exception('Error while updating profile');
      }
    });
  }
}
