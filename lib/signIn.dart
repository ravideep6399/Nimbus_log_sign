import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }
  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 116,
              ),
              const SizedBox(
                width: 175,
                height: 72,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              // const SizedBox(height: 250,),
              SizedBox(
                height: 250,
                width: 250,
                child: RiveAnimation.asset(
                  "assets/2244-4437-animated-login-screen.riv",
                  fit: BoxFit.fitHeight,
                  stateMachines: const ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                        artboard, "Login Machine");
                    if (controller == null) {
                      return;
                    }
                    artboard.addController(controller!);
                    isChecking = controller?.findInput("isChecking");
                    numLook = controller?.findInput("numLook");
                    isHandsUp = controller?.findInput("isHandsUp");
                    trigSuccess = controller?.findInput("trigSuccess");
                    trigFail = controller?.findInput("trigFail");
                  },
                ),
              ),
              Container(
                height: 270,
                width: 300,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.white,),
                
                child: Form(
                  
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 260,
                          height: 35,
                          child: TextFormField(
                            focusNode: emailFocusNode,
                            controller: emailController,
                            cursorColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              filled: true,
                              fillColor:
                                  Color.fromARGB(255, 255, 255, 255),
                            ),
                            onChanged: (value) {
                              numLook?.change(value.length.toDouble());
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: 260,
                          height: 35,
                          child: TextFormField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                             
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              filled: true,
                              fillColor:
                                  Color.fromARGB(255, 255, 255, 255),
                            ),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(
                          height: 39,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              maximumSize: const Size(260, 40),
                              backgroundColor:
                                  Color.fromARGB(255, 143, 197, 240),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          onPressed: (() {}),
                          child: const Center(
                            child: SizedBox(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
