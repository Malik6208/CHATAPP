import 'package:chat_app/controller/auth_controller/auth_controller.dart';
import 'package:chat_app/utils/components/cTextField.dart';
import 'package:chat_app/views/signup_screen.dart';
import 'package:flutter/material.dart';

import '../utils/components/cBtn.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController=AuthController();
  var _emailController=TextEditingController();
  static ValueNotifier<bool> notifier=ValueNotifier(false);
  var _passController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Welcome Back!',
                      style:TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                  ),

              Align(
                alignment: Alignment.center,
                child: Text('Enter your email and password to \n'
                    '          access your acount.',style: TextStyle(fontSize: 22),),
              ),
              SizedBox(height: 100,),
              Form(
                  key: _formKey,
                  child: Column(
                children: [
                  CtextField.CoustomeTextField(
                      'Email',
                      _emailController,
                      TextInputType.emailAddress,
                      Icons.email_outlined
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 13),
                    child: ValueListenableBuilder(
                      valueListenable: notifier,
                      builder: (context, value, child) {
                        return  TextFormField(
                          validator: (value){
                            if(value==null || value.isEmpty)
                            {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          obscureText: notifier.value,
                          controller: _passController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock,),
                              suffixIcon: InkWell(
                                onTap: (){
                                  notifier.value=!notifier.value!;
                                },
                                child:  Icon(
                                    notifier.value? Icons.visibility_off_outlined
                                        :Icons.visibility
                                ),
                              ),
                              hintText: 'Password',
                              labelText: "password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )

                          ),
                        );
                      },

                    ),
                  ),
                 const SizedBox(height: 20,),
                  CustomButtom(
                    voidCallback: (){
                      onSubmit();
                      authController.login(context,
                          _emailController.text.toString(),
                          _passController.text.toString());
                    },
                    title: 'Login',
                  ),
                ],
              )),
              SizedBox(height: 28,),
              InkWell(
                onTap: (){},
                child: Align(
                  alignment: Alignment.center,
                    child: Text('Forgot password?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 2, 0),
                child: Row(
                  children: [
                    SizedBox(width: 40,),
                    Text("Don't have an account? ",style: TextStyle(fontSize: 18),),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                        },
                        child: Text(
                          'Sign up'
                          ,style: TextStyle(fontSize: 21,color: Colors.orangeAccent),
                        )
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    if(_formKey.currentState!.validate())
      {

      }
  }
}
