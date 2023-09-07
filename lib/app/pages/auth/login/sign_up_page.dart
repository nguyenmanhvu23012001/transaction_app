import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rxdart/src/utils/composite_subscription.dart';
import 'package:zen8app/app/pages/auth/login/sign_up_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/router/router.dart';
import 'package:zen8app/widgets/sources/loading_widget.dart';

import '../../../../utils/helpers/mvvm_binding.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with MVVMBinding<SignUpVM, SignUpPage> {
  TextEditingController _userController = TextEditingController(text:"Manh VU");
  TextEditingController _phoneNumberController = TextEditingController(text: "0947250936");
  TextEditingController _emailController = TextEditingController(text:"Nguyenmanhvu23012001@gmail.com");
  TextEditingController _passwordController = TextEditingController(text: "123456");
  TextEditingController _confirmPasswordController = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: vm.activityTracker.isRunningAny(),
      error: vm.errorTracker.asAppException(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 24, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _fadeAnimation(
                  1.2,
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _fadeAnimation(
                  1.4,
                  Text(
                    "Create an account. It's free!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: 36),
                _makeInput(label: "Username", controller: _userController),
                SizedBox(height: 16),
                _makeInput(label: "Email", controller: _emailController),
                SizedBox(height: 16),
                _makeInput(
                    label: "Phone Number", controller: _phoneNumberController),
                SizedBox(height: 16),
                _makeInput(
                    label: "Password",
                    obscureText: true,
                    controller: _passwordController),
                SizedBox(height: 16),
                _makeInput(
                    label: "Confirm Password",
                    obscureText: true,
                    controller: _confirmPasswordController),
                SizedBox(height: 36),
                _submitButton(context),
                SizedBox(height: 24),
                _loginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fadeAnimation(double delay, Widget child) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      child: Transform.translate(
        offset: Offset(0, 20),
        child: child,
      ),
    );
  }

  Widget _makeInput(
      {label, obscureText = false, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.greenAccent, Colors.tealAccent],
        ),
      ),
      child: MaterialButton(
        onPressed: () {
          vm.input.signUp.add(
            (
            _userController.text,
            _passwordController.text,
            _emailController.text,
            _phoneNumberController.text,
            ),
          );
        },
        padding: EdgeInsets.symmetric(vertical: 16),
        child: GestureDetector(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Already have an account?",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            // Add navigation logic here
          },
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.greenAccent,
            ),
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Đăng ký thành công"),
          content: Text("Tài khoản của bạn đã được đăng ký thành công."),
          actions: [
            TextButton(
              onPressed: () {
                context.router.push(LoginRoute());
              },
              child: Text("Đi đến Đăng nhập"),
            ),
          ],
        );
      },
    );
  }

  @override
  void onBindingVM(CompositeSubscription subscription) {
    vm.output.response.listen((value) {
      _showSuccessDialog();
    });
  }

  @override
  SignUpVM onCreateVM() {
    return SignUpVM();
  }
}
