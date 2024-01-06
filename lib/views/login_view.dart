import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar_helper.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/custom_button_widget.dart';
import 'package:chat_app/widgets/custom_text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
   LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
   GlobalKey<FormState>formKey = GlobalKey();

  String? email;

  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                    Padding(
                      padding: const EdgeInsets.only(top:75),
                      child: Center(child: Image.asset("assets/images/scholar.png")),
                    ),
                    const Center(
                      child: Text("Scholar Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontFamily: "TitleFont",
                          fontSize: 32
                      ),
                      ),
                    ),
                  const SizedBox(
                    height: 60,
                  ),
                  const Text("Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFieldWidget(label: "Email",onChanged: (data){email = data;},
                    validate: (value){
                      if(value!.isEmpty){
                        return "This field is required.";
                      }
                      else if(!value.contains("@")||!value.toLowerCase().contains(".com")){
                        return "Email format is not correct";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormFieldWidget(label: "Password",onChanged: (data){password = data;},isPassword: true,
                    validate: (value){if(value!.isEmpty){
                    return "This field is required";
                    }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(label: "Login",function: ()async{
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {
                      });
                      try {
                        await loginUser();
                        Navigator.of(context).pushNamedAndRemoveUntil(ChatView.id, (route) => false);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, "Email not found.", Colors.red);
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, "Wrong Password", Colors.red);
                        }else if(e.code=='INVALID_LOGIN_CREDENTIALS'){
                          showSnackBar(context, "Email or Password is wrong", Colors.red);
                        }
                      }
                      isLoading = false;
                      setState(() {
                      });
                    }
                  },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",style:TextStyle(color: Colors.white),),
                      TextButton(onPressed: (){
                        Navigator.of(context).pushNamed(RegisterView.id);
                      }, child: const Text("Register Now"))
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
   Future<UserCredential> loginUser()async{
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email!,
         password: password!
     );
     return credential;
   }
}

