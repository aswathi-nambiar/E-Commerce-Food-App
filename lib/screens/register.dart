import 'package:e_commerce_food_app/common_widgets/common_textfield.dart';
import 'package:e_commerce_food_app/common_widgets/loading.dart';
import 'package:e_commerce_food_app/providers/user_provider.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:e_commerce_food_app/utils/constants.dart';
import 'package:e_commerce_food_app/utils/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// This is the Registration page of the application. User can
/// enter the name, email id and password to register.

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  const RegisterPage({required this.toggleView, super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserProvider? userProvider;

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  ///[TextEditingController] for name, email and password fields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return loading
        ? const Loading()
        : CupertinoPageScaffold(
            backgroundColor: CupertinoColors.activeGreen,
            child: Stack(
              children: [
                /// Background Color shown in the Sign In page
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
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 25.0,
                            color: black55,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5.0),
                            Text(
                              'Register',
                              style: loginHeaderTextStyle,
                            ),
                            const SizedBox(height: 5.0),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(height: 20.0),

                                  /// Name field
                                  CommonTextField(
                                    textController: nameController,
                                    placeHolderStyle: placeHolderStyle,
                                    textInputAction: TextInputAction.next,
                                    hintText: 'Enter name',
                                    icon: Icon(
                                      CupertinoIcons.person,
                                      color: greenColor,
                                    ),
                                    validator: (dynamic name) {
                                      if (name.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20.0),

                                  /// Email id field
                                  CommonTextField(
                                    textController: emailController,
                                    textInputAction: TextInputAction.next,
                                    placeHolderStyle: placeHolderStyle,
                                    hintText: 'Enter email',
                                    icon: Icon(
                                      CupertinoIcons.mail,
                                      color: greenColor,
                                    ),
                                    validator: (dynamic value) {
                                      bool isEmailValid =
                                          Validations.validateEmail(
                                              emailController.value.text);

                                      if (!isEmailValid) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20.0),

                                  /// Password Field
                                  CommonTextField(
                                    textController: passwordController,
                                    hintText: 'Enter password',
                                    placeHolderStyle: placeHolderStyle,
                                    obscureText: true,
                                    validator: (dynamic value) {
                                      if (value.isEmpty && value.length < 6) {
                                        return 'Please enter valid password';
                                      }
                                      return null;
                                    },
                                    icon: Icon(
                                      CupertinoIcons.padlock_solid,
                                      color: greenColor,
                                    ),
                                  ),

                                  const SizedBox(height: 30.0),

                                  /// sign in button
                                  CupertinoButton(
                                    color: greenColor,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await userProvider
                                            ?.registerWithEmailAndPassword(
                                                nameController.text,
                                                emailController.text,
                                                passwordController.text);

                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            error =
                                                'Please supply a valid email';
                                          });
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(color: black),
                                    ),
                                  ),

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
                                        const Text('Already have an account?'),
                                        const SizedBox(width: 5.0),
                                        GestureDetector(
                                            onTap: () => widget.toggleView(),
                                            child: Text('Login',
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
