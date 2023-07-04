

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Repoistory/authProvider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
      backgroundColor:Colors.cyan,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            backgroundUI(context),
            Container(
                alignment: Alignment.center,
                child: Column(
                    children: [
                      SizedBox(height: 40),
                      Image.asset('assets/login.png', scale: 1.5),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 50,
                        padding: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          )
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('SigUp',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Email',
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  authProvider.signUpWithEmailAndPassword(context,
                                    _emailController.text,
                                    _passwordController.text,
                                  );}
                                },
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('SigUp', style: TextStyle(
                                      color: Colors.white, fontSize: 18),),),
                              )
                            ],),
                        ),
                      )
                    ])
            )
          ],
        ),
      ),
    );
  }

  Widget backgroundUI(context) {
    return Column(
      children: [
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height / 2.1,
          color: Colors.white,
        ),
      ],
    );
  }
}



