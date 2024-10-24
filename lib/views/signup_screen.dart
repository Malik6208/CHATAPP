import 'dart:io';
import 'package:chat_app/controller/auth_controller/auth_controller.dart';
import 'package:chat_app/controller/image_upload.dart';
import 'package:chat_app/utils/components/cBtn.dart';
import 'package:chat_app/utils/components/cTextField.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static final fireStore=FirebaseFirestore.instance.collection('Users');
  static File? _image=UploadImage.getFile;



  var _nameController=TextEditingController();
  var _emailController=TextEditingController();
  var _phoneController=TextEditingController();
  var _passlController=TextEditingController();
  var _cPasslController=TextEditingController();
  static ValueNotifier<bool> notifier=ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print('Build function called');
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
                child: Text('Getting started',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),),
              ),
              const Text('Create account to continue!',style: TextStyle(
                fontSize: 19,
              ),),
              const SizedBox(height: 20,),
              Center(child: InkWell(
                onTap: (){
                  Utils.showDailog(context);

                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:_image!=null? FileImage(_image!):AssetImage('assets/icons/userpic.png'),

                ),
              ),),
              const SizedBox(height: 20,),
              Form(
                key: _formKey,
                  child:  Column(
                children: [
                  CtextField.CoustomeTextField(
                      'Name',
                      _nameController,
                      TextInputType.name,
                      Icons.person,

                  ),
                  CtextField.CoustomeTextField(
                      'Email',
                      _emailController,
                      TextInputType.emailAddress,
                      Icons.email_outlined
                  ),
                  CtextField.CoustomeTextField(
                      'Phone',
                      _phoneController,
                      TextInputType.phone,
                      Icons.phone
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 13),
                    child: ValueListenableBuilder(
                      valueListenable: notifier,
                      builder: (context, value, child) {
                        return  TextFormField(
                          obscureText: notifier.value,
                        controller: _passlController,
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
                          validator: (value){
                            if(value==null || value.isEmpty)
                              {
                                return 'Please enter password';
                              }
                            return null;
                          },
                        );
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 13),
                    child: ValueListenableBuilder(
                      valueListenable: notifier,
                      builder: (context, value, child) {
                        return  TextFormField(
                          obscureText: notifier.value,
                          controller: _cPasslController,
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
                          validator: (value){
                            if(value==null || value.isEmpty)
                            {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        );
                      },

                    ),
                  ),

                const SizedBox(height: 27,),
                 CustomButtom(
                     voidCallback: (){
                       setState(() {

                       });
                       onSubmit();
                       Utils.loading();
                       AuthController.signUp(
                           context,
                           _nameController.text.toString(),
                           _emailController.text.toString(),
                           _passlController.text.toString(),
                           _cPasslController.text.toString(),
                           _phoneController.text.toString()
                       );

                     },
                     title: 'Sign Up',
                 )
                ],
              )),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 0, 0),
                child: const Row(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 17, 0),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage('assets/icons/google.png'),
                    ),
                  ),
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/icons/facebook.png'),),
                  Padding(
                    padding: EdgeInsets.only(left: 17),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage('assets/icons/twitter.png'),),
                  ),

                ],),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 2, 0),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Text('Already have an account? ',style: TextStyle(fontSize: 18),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                      },
                      child: Text(
                          'Sign in'
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
