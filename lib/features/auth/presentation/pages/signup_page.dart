import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/auth/presentation/bloc/signup_bloc/bloc/signup_bloc.dart';
import 'package:growmind/features/auth/presentation/bloc/signup_bloc/bloc/signup_event.dart';
import 'package:growmind/features/auth/presentation/bloc/signup_bloc/bloc/signup_state.dart';
import 'package:growmind/features/auth/presentation/pages/login_page.dart';
import 'package:growmind/features/auth/presentation/widgets/text_fields.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  static bool isObscure = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
     backgroundColor: textColor,
        automaticallyImplyLeading: true,
      ),
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
              
                kheight1,
             const Align(
                alignment:AlignmentDirectional.topStart,
                child:   Text(
                  
                  'Create  Account,',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                  ),
              ),
                const Align(
                alignment:AlignmentDirectional.topStart,
                child:   Text(
                  
                  'Sign Up to get started!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.grey),
                                  ),
              ),
                kheight2,
                CustomTextField(
                    controller: nameController,
                    hintText: 'Name',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the name';
                      }
                      return null;
                    }),
                kheight1,
                CustomTextField(
                  controller: emailController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Enter the mail';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(p0)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                kheight1,
                CustomTextField(
                  controller: passwordController,
                  prefixIcon: Icons.lock,
                  hintText: 'password',
                  suffixIcon: Icons.remove_red_eye,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the password';
                    }

                    if (value.length <= 3 || value.length >= 15) {
                      return 'please enter a valid password';
                    }
                    return null;
                  },
                ),
                kheight1,
                CustomTextField(
                  controller: rePasswordController,
                  prefixIcon: Icons.lock,
                  hintText: 'Re-confirm password',
                  suffixIcon: Icons.remove_red_eye,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the password';
                    }

                    if (value.length <= 3 || value.length >= 15) {
                      return 'please enter a valid password';
                    }
                    if (passwordController.text != rePasswordController.text) {
                      return 'enter the valid password';
                    }
                    return null;
                  },
                ),
               
               
                kheight1,
                CustomTextField(
                  controller: phoneController,
                  prefixIcon: Icons.phone,
                  hintText: '(+91) phone',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' enter the phone number';
                    }
                    return null;
                  },
                ),
                kheight2,
                BlocConsumer<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state is SignupSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('SignUp successful')));
                      Navigator.pushReplacementNamed(context, '/login');
                    } else if (state is SignupFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('failed to SignUp${state.error}')));
                    }
                  },
                  builder: (context, state) {
                    if (state is SignupLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            minimumSize: const Size(350, 50)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<SignupBloc>().add(SignupSubmitted(
                                displayName: nameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                             
                                phone: phoneController.text.trim()));
                          }
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                               const     Text(
                          'Sign Up',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        kwidth,
                        Container(
                          height: 27,
                          width: 27,
                          decoration:const BoxDecoration(
                         shape: BoxShape.circle,
                         color: textColor
                          ),
                          child:const Icon(Icons.arrow_forward,color:Colors.black,),
                        )
                          ],
                        ));
                  },
                ),
                kheight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                 const     Text(
                        "Already have an Account?",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      kwidth,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child:const Text(
                          "SIGN IN",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC82C55)),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
