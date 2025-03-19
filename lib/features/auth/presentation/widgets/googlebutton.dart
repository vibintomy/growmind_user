import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/features/auth/presentation/bloc/google_auth_bloc/google_auth_bloc.dart';
import 'package:growmind/features/auth/presentation/bloc/google_auth_bloc/google_auth_event.dart';
import 'package:growmind/features/auth/presentation/bloc/google_auth_bloc/google_auth_state.dart';
import 'package:growmind/features/bottom_navigation/presentation/pages/bottom_navigation.dart';

class Googlebutton extends StatelessWidget {
  const Googlebutton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Welcome, ${state.googleAuthUser.displayName}!")),
          );
          
          // Navigate to the bottom navigation page after successful sign-in
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const BottomNavigation(),
            ),
          );
        } else if (state is GoogleAuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            minimumSize: const Size(double.infinity, 54),
          ),
          onPressed: () {
            context.read<GoogleAuthBloc>().add(GoogleSignInEvent());
          },
          child: state is GoogleAuthLoading
              ? CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
                      width: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}