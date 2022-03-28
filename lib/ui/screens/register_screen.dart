import 'package:flutter/material.dart';
import 'package:livechat/database/users_api.dart';
import 'package:livechat/ui/screens/home_screen.dart';
import 'package:livechat/ui/screens/signin_screen.dart';
import 'package:livechat/ui/screens/users_screen.dart';
import 'package:livechat/ui/widgets/custom_widget/button.dart';
import 'package:livechat/ui/widgets/custom_widget/text_form_field.dart';
import 'package:provider/provider.dart';

import '../../providers/users_provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static const String screenRoute = '/register';
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 30, bottom: 50, start: 50, end: 10),
                      child: Image.asset('images/logo.png'),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextFormField(
                            controller: _name,
                            hint: 'enter your display name',
                            isSecure: false,
                            type: TextInputType.text,
                            errorText: 'please write your display name',
                            validate: (value) {
                              for (var user in userProvider.userList) {
                                String userName = user.name.toString();
                                if (value!.contains(userName)) {
                                  return 'this name already taken';
                                }
                              }
                              if (value!.isEmpty) {
                                return 'please write your display name';
                              } else if (value.length < 4) {
                                return 'please add at least 4 letters';
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField(
                            controller: _email,
                            hint: 'enter you email ',
                            isSecure: false,
                            type: TextInputType.emailAddress,
                            errorText: 'please enter correct email',
                            validate: (value) {
                              for (var user in userProvider.userList) {
                                String userEmail = user.email.toString();
                                if (value!.contains(userEmail)) {
                                  return 'the email already exist';
                                }
                                print(userEmail);
                              }
                              if (value!.isEmpty) {
                                return 'please enter correct email';
                              } else if (!value.contains('@') ||
                                  !value.contains('.com')) {
                                return 'please don\'t forget \'@\' and \'.com\'';
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField(
                            controller: _pass,
                            hint: 'enter your password',
                            isSecure: true,
                            type: TextInputType.text,
                            errorText: 'please enter your password',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
                              } else if (value.length < 6) {
                                return 'please add at least 6 letters';
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        MyButton(
                            color: Colors.deepOrange,
                            label: 'create account',
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                UsersApi.instance
                                    .createUser(context, _name.text,
                                        _email.text, _pass.text)
                                    .then((_) => UsersApi.instance.signInUser(
                                        context, _email.text, _pass.text));
                                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.screenRoute, (route) => false);
                              } else {
                                print('wrong validate');
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen())),
                            child: Text(
                              'I have already account..',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[900],
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
                // TextFormField(
                //   controller: _name,
                //   onSaved: (value) {
                //     _name.text = value!;
                //   },
                // ),
                // TextFormField(
                //   controller: _email,
                //   onSaved: (value) {
                //     _email.text = value!;
                //   },
                // ),
                // TextFormField(
                //   controller: _pass,
                //   onSaved: (value) {
                //     _pass.text = value!;
                //   },
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       UsersApi.instance
                //           .createUser(
                //               context, _name.text, _email.text, _pass.text)
                //           .then((_) => UsersApi.instance
                //               .signInUser(context, _email.text, _pass.text));
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => UsersScreen()));
                //     },
                //     child: Text('add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
