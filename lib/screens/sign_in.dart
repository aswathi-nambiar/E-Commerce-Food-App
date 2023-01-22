import 'package:e_commerce_food_app/common_widgets/common_textfield.dart';
import 'package:e_commerce_food_app/common_widgets/loading.dart';
import 'package:e_commerce_food_app/providers/user_provider.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:e_commerce_food_app/utils/constants.dart';
import 'package:e_commerce_food_app/utils/validations.dart';
import 'package:flutter/cupertino.dart';

/// This is the Login page of the application. User can
/// enter the registered email id and password to login
class SignInPage extends StatefulWidget {
  final Function toggleView;
  const SignInPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final UserProvider _auth = UserProvider();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  /// [TextEditingController] for email and password field
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : CupertinoPageScaffold(
            backgroundColor: CupertinoColors.activeGreen,
            child: Stack(
              children: [
                /// background Color shown in the Sign In page
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [CupertinoColors.systemYellow, greenColor],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                ),

                /// Card having the username and password field
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5.0),
                            Text(
                              'Login',
                              style: loginHeaderTextStyle,
                            ),
                            const SizedBox(height: 15.0),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(height: 20.0),

                                  /// Email id field

                                  CommonTextField(
                                    textController: emailController,
                                    textInputAction: TextInputAction.next,
                                    hintText: 'Enter email',
                                    placeHolderStyle: placeHolderStyle,
                                    icon: Icon(
                                      CupertinoIcons.person,
                                      color: black,
                                    ),
                                    validator: (dynamic value) {
                                      bool isEmailValid =
                                          Validations.validateEmail(
                                              emailController.value.text);

                                      if (!isEmailValid) {
                                        return 'Please enter valid email id';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20.0),

                                  /// Password field

                                  CommonTextField(
                                    textController: passwordController,
                                    hintText: 'Enter password',
                                    placeHolderStyle: placeHolderStyle,
                                    obscureText: true,
                                    icon: Icon(
                                      CupertinoIcons.padlock_solid,
                                      color: black,
                                    ),
                                    validator: (dynamic value) {
                                      if (value == null || value.length < 6) {
                                        return 'Must be 6 character long';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 30.0),

                                  /// Sign in Button
                                  CupertinoButton(
                                    color: greenColor,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                emailController.text,
                                                passwordController.text);
                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            error =
                                                'Could not sign in with those credentials';
                                          });
                                        }
                                      } else {}
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(color: black),
                                    ),
                                  ),

                                  /// sign in button

                                  const SizedBox(height: 12.0),
                                  Text(
                                    error,
                                    style: const TextStyle(
                                        color: CupertinoColors.systemRed,
                                        fontSize: 14.0),
                                  ),

                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('New to our App?'),
                                        const SizedBox(width: 5.0),
                                        GestureDetector(
                                            onTap: () => widget.toggleView(),
                                            child: Text('Register',
                                                style: signUpTextStyle))
                                      ]),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
