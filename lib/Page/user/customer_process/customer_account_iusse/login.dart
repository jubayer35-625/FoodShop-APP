import 'package:authui/Page/adminpage/adminhome.dart';
import 'package:authui/Page/user/customer_process/customer_account_iusse/forgot_password.dart';
import 'package:authui/Page/user/customer_process/customer_account_iusse/signup.dart';
import 'package:authui/Page/user/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  bool _obscureText = true;
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
   Future userLogin() async {

    try {
       await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
if( email == "admin@gmail.com" ){

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) =>
      const AdminHome(),
    ),
  );
       }
else {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) =>
      const UserMain(),
    ),
  );
}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {

    var h= MediaQuery.of(context).size.height;
    var w =MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 28,
        centerTitle:true,
        title: const Text("User Login"),
        leading: Icon(Icons.vpn_key),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:SizedBox(
            height:h,
            width: w,
            child: Column(
              children: [

                SizedBox(height:h*0.02,),
                CircleAvatar(backgroundImage: NetworkImage(img),minRadius: 80,),
                SizedBox(height:h*0.08,),


                SizedBox(
                  width: w*0.67,
                  height: h*0.06,
                  child: TextFormField(
                    maxLength: 30,
                    maxLines: 1,
                    autofocus: false,
                    decoration:  InputDecoration(
                      labelText: 'Email: ',
                      counterText:'',
                      labelStyle: const TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorStyle:
                      const TextStyle(color: Colors.redAccent, fontSize: 12),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: h*0.025,),
                SizedBox(
                  width: w*0.67,
                  height: h*0.06,
                  child: TextFormField(
                    maxLength: 30,
                    maxLines: 1,
                    autofocus: false,
                    obscureText:_obscureText,
                    decoration:  InputDecoration(
                      labelText: 'Password: ',
                      suffix: IconButton(
                          onPressed:_toggle,
                          icon:Icon(Icons.visibility_outlined)
                      ),
                      counterText:'',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: h*0.035,),
                Container(
                  margin:  EdgeInsets.only(right:h*0.15),
                  child:  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          email = emailController.text;
                          password = passwordController.text;
                        });
                        userLogin();
                      }
                    },

                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: h*0.031,fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(h*0.05),

                      ),
                      primary: Colors.pinkAccent,
                      side:const BorderSide(color: Colors.pink, width: 2),
                    ),
                  ),
                ),


                Container(
                  margin:  EdgeInsets.only(top: h*.004 ,left: w*0.54),
                  child:  TextButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      )
                    },
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(fontSize:w*0.038,color: Colors.deepPurple,fontWeight: FontWeight.bold),
                    ),
                  ),

                ),

                Container(
                  margin: EdgeInsets.only(top: w*0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ const Text("Don't have an Account? ",style: TextStyle(
                      fontSize: 16
                    ),),
                      TextButton(
                        onPressed: () => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a, b) => Signup(),
                                transitionDuration: const Duration(seconds: 0),
                              ),
                                  (route) => false)
                        },
                        child:const Text('Signup',style: TextStyle(
                            fontSize: 17
                        ),
                        ),
                      ),

                      /* TextButton(
                         onPressed: () => {
                           Navigator.pushAndRemoveUntil(
                              context,
                               PageRouteBuilder(
                                 pageBuilder: (context, a, b) => const Dashboard(),
                                 transitionDuration: const Duration(seconds: 0),
                               ),
                               (route) => false)
                         },
                         child: const Text('Dashboard'),
                       ), */
                    ],
                  ),
                ),
                SizedBox(height: h*0.035,),
                const   Text("Or. WithOut in SignUp Now,   "),
                SizedBox(height: h*0.011,),
                SizedBox(
                  child: Row(
                    children: [

                      Container(
                          margin: EdgeInsets.only(left: w*0.25,top: h*0.031),
                          child: CircleAvatar(backgroundImage: NetworkImage(img_google2),
                            minRadius: w*0.055,)
                      ),

                      Container(
                          margin: EdgeInsets.only(left: w*0.055),
                          child: CircleAvatar(backgroundImage: NetworkImage(img_facebook)
                            ,minRadius:  w*0.06,)
                      ),

                      Container(
                          margin: EdgeInsets.only(left: w*0.055,top: h*0.031),
                          child: CircleAvatar(backgroundImage: NetworkImage(img_linkden)
                            ,minRadius: w*0.055,)
                      ),
                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }


  var img = 'https://mir-s3-cdn-cf.behance.net/projects/404/576548105443009.Y3JvcCwyMzAxLDE4MDAsMTQ4LDA.jpg';
  var img_google = 'https://www.tkdtricities.com/wp-content/uploads/2018/06/googleplus-hd-png-google-plus-logo-png-transparent-background-8-281-200x200.png';
  var img_google2 = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_BxIFDiqRSADS_dryOjRxIdflIGgt8vianZy7fPOHmGz8HsBUi-lggRTn5-raiCOnF0Q&usqp=CAU';
  var img_facebook = 'https://www.kindpng.com/picc/m/217-2173031_transparent-facebook-icons-png-transparent-facebook-logo-circle.png';
  var img_linkden = 'https://www.clipartmax.com/png/small/143-1430920_index-of-pound-work-graphictango-desktop-icon-sets-social-media-icons-linkedin.png';


}
