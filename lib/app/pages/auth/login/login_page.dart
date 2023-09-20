import 'dart:math';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zen8app/app/pages/auth/login/login_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/router/router.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/widgets/widgets.dart';

import '../../../../widgets/sources/fade_animate_widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with MVVMBinding<LoginVM, LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoggedIn = false;
  final _usernameController = TextEditingController(text: "vu12345");
  final _passwordController = TextEditingController(text: "vu123");

  @override
  LoginVM onCreateVM() => LoginVM();

  @override
  void onBindingVM(CompositeSubscription subscription) {
    vm.output.response.listen((response) async {
      await Session.startAuthenticatedSession(response);
      context.router.replaceAll([HomeRoute()]);
    }).addTo(subscription);

  }

  void _validate() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      vm.input.login.add((_usernameController.text, _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: vm.activityTracker.isRunningAny(),
      error: vm.errorTracker.asAppException(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            FadeAnimation(
                                1.2,
                                Text("Login",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1.4,
                                Text("Login to your account",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[700]))),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: <Widget>[
                              FadeAnimation(
                                  1.6,
                                  makeInput(
                                      label: "User",
                                      controller: _usernameController,
                                      validator: ValidationBuilder()
                                          .maxLength(50)
                                          .build())),
                              FadeAnimation(
                                  1.8,
                                  makeInput(
                                    label: "Password",
                                    controller: _passwordController,
                                    obscureText: true,
                                    validator: ValidationBuilder()
                                        .minLength(5)
                                        .maxLength(50)
                                        .build(),
                                  )),
                            ],
                          ),
                        ),
                        FadeAnimation(
                            2.0,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                padding: EdgeInsets.only(top: 3, left: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black),
                                      top: BorderSide(color: Colors.black),
                                      left: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black),
                                    )),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: _validate,
                                  color: Colors.greenAccent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    _isLoggedIn ? "Logged In" : "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            )),
                        FadeAnimation(
                            2.2,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Don't have an account?"),
                                GestureDetector(
                                  onTap: () {
                                   context.router.push(SignUpRoute());
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.blue, // You can set the color to indicate it's tappable
                                    ),
                                  ),
                                ),
                              ],
                            )

                        )
                      ],
                    ),
                  ),
                ),
                FadeAnimation(
                    2.4,
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('images/background.png'),
                      )),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, validator, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87)),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }




}
