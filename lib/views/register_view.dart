import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar_helper.dart';
import 'package:chat_app/widgets/custom_button_widget.dart';
import 'package:chat_app/widgets/custom_text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});
  static String id = "RegisterView";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:128),
                    child: Center(child: Image.asset("assets/images/scholar.png")),
                  ),
                  const Center(
                    child: Text("Scholar Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 32
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  const Text("Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFieldWidget(label: "Email",onChanged: (data){email = data;},
                      validate:(value){
                        if(value!.isEmpty){
                          return "This field is required.";
                        }
                        else if(!value.contains("@")||!value.toLowerCase().contains(".com")){
                          return "Email format is not correct";
                        }
                      }
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormFieldWidget(label: "Password",onChanged: (data){password = data;},
                    isPassword: true,
                    validate: (value){
                          if(value!.isEmpty){
                            return "This field is required.";
                          }
                        },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(label: "Register",function: ()async{
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {
                      });
                      try {
                        await registerUser();
                        showSnackBar(context, "Account created successfully.", Colors.green);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password'){
                          showSnackBar(context, "Weak Password", Colors.red);
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, "The account already exists for that email.", Colors.red);
                        }
                      }
                    }
                    isLoading = false;
                    setState(() {

                    });
                    Navigator.of(context).pop();
                  },),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",style:TextStyle(color: Colors.white),),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: const Text("Login Now"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> registerUser()async {
    UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,);
  }
}

