import 'package:drive_test_ui/widgets/auth/auth/auth_model.dart';
import 'package:drive_test_ui/widgets/auth/main_screen/main_screen_widget.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login to your account')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [_FormWidget()]),
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  _FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
    final textStyle = const TextStyle(fontSize: 16, color: Colors.black);
    final textFieldDecorator = const InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      isCollapsed: true,
    );
    final color = const Color(0xFF01B4E4);
    //final errorText = this.errorText;
    final navigator = Navigator.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ErrorMessageWidget(),

        Text('Username', style: textStyle),
        TextField(
          controller: model?.loginTextController,
          decoration: textFieldDecorator,
        ),
        SizedBox(height: 5),

        Text('Password', style: textStyle),
        TextField(
          controller: model?.passwwordTextController,
          decoration: textFieldDecorator,
          obscureText: true,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            _AuthButtonWidget(),
            SizedBox(width: 20),
            TextButton(
              onPressed: () {},
              child: Text('Reset Password'),
              style: ButtonStyle(
                //backgroundColor: WidgetStateProperty.all(color),
                foregroundColor: WidgetStateProperty.all(color),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: () {
            navigator.push(
              MaterialPageRoute(builder: (context) => MainScreenWidget()),
            );
          },
          child: Text('Continue as a guest'),
          style: ButtonStyle(
            //backgroundColor: WidgetStateProperty.all(color),
            foregroundColor: WidgetStateProperty.all(color),
          ),
        ),
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = const Color(0xFF01B4E4);
    final model = AuthProvider.watch(context)?.model;
    final onPressed = model?.canStartAuth == true
        ? () => model?.auth(context)
        : null;
    final child = model?.isAuthProgress == true
        ? SizedBox(
            width: 15,
            height: 15,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : const Text('Login');
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        ),
      ),

      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;
    if (errorMessage == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.red, fontSize: 17),
      ),
    );
  }
}

// class _FormWidget extends StatefulWidget {
//   _FormWidget({super.key});

//   @override
//   __FormWidgetState createState() => __FormWidgetState();
// }

// class __FormWidgetState extends State<_FormWidget> {
//   // final _loginTextController = TextEditingController();
//   // final _passwwordTextController = TextEditingController();
//   // String? errorText;
//   // void _auth() {
//   //   final login = _loginTextController.text;
//   //   final password = _passwwordTextController.text;
//   //   if (login == 'admin' && password == 'admin') {
//   //     errorText = null;

//   //     print('open app');
//   //   } else {
//   //     errorText = 'Wrong login or password';
//   //     print('show error');
//   //   }
//   //   setState(() {});
//   // }

//   // void _resetPassword() {
//   //   print('Reset Password');
//   // }

//   @override
//   Widget build(BuildContext context) {
    
//     return Column(
      
//     );
//   }
// }
