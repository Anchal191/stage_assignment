import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_assignment/UI/Auth/signUp.dart';

import '../../Repoistory/authProvider.dart';

class SigIn extends StatelessWidget {
   SigIn({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor:Colors.cyan,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            backgroundUI(context),
            Container(
                alignment: Alignment.center,
                child: Column(
                    children: [
                      SizedBox(height: 60),
                      Image.asset('assets/login.png', scale: 1.5),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 40,
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
                              Text('SigIn',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                                    authProvider.signInWithEmailAndPassword(context,
                                      _emailController.text.toString(),
                                      _passwordController.text.toString(),
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
                                  child: Text('SigIn', style: TextStyle(
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
      bottomNavigationBar: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SignUpPage()));
        },
        child: Text('New User? Create Account', style: TextStyle(fontSize: 15,color: Colors.white),
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
