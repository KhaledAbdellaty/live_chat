import 'package:flutter/material.dart';
import 'package:livechat/database/users_api.dart';
import 'package:livechat/ui/screens/home_screen.dart';
import 'package:livechat/ui/widgets/custom_widget/button.dart';
import 'package:livechat/ui/widgets/custom_widget/text_form_field.dart';
import 'package:provider/provider.dart';
import '../../providers/users_provider.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);
  static const String screenRoute = '/sign_in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    UsersApi.instance.getUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.height / 10, left: size.height / 50),
                  width: size.width,
                  height: size.height / 5,
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 30, bottom: 50, start: 50, end: 10),
                  child: Image.asset('images/logo.png'),
                ),
                SizedBox(
                  height: size.width / 40,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyTextFormField(
                              controller: _email,
                              hint: 'enter you email',
                              isSecure: false,
                              type: TextInputType.emailAddress,
                              errorText: 'please enter your Email',
                              validate: (value) {
                                final signing = userProvider.userList
                                    .where((element) => value == element.email);
                                if (value!.isEmpty) {
                                  return 'please enter your Email';
                                } else if (!value.contains('@') ||
                                    !value.contains('.com')) {
                                  return 'please don\'t forget \'@\' and \'.com\'';
                                } else if (signing.isEmpty) {
                                  return 'this email not created yet';
                                } else {
                                  return null;
                                }
                              }),
                          SizedBox(
                            height: size.width / 20,
                          ),
                          MyTextFormField(
                              controller: _pass,
                              hint: 'enter your password',
                              isSecure: true,
                              type: TextInputType.text,
                              errorText: 'enter your password to sign in',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'enter your password to sign in';
                                } else if (value.length < 6) {
                                  return 'please add at least 6 letters';
                                } else {
                                  return null;
                                }
                              }),
                          SizedBox(
                            height: size.width / 20,
                          ),
                          MyButton(
                              color: Colors.blue[900]!,
                              label: 'sign in ',
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  UsersApi.instance
                                      .signInUser(
                                      context, _email.text, _pass.text)
                                      .then((_) =>
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, HomeScreen.screenRoute, (
                                          route) => false));
                                } else {
                                  print('wrong validate');
                                }
                              }),
                          SizedBox(
                            height: size.width / 20,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () =>
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, HomeScreen.screenRoute, (
                                      route) => false),
                              child: const Text(
                                'Create account..',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepOrange,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
