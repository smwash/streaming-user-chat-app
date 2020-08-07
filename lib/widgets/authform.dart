import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_chat_app/constants.dart';
import 'package:my_chat_app/model/user.dart';
import 'package:my_chat_app/providers/auth_provider.dart';
import 'package:my_chat_app/widgets/loading.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _errorMessage = '';
  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscureText = true;

  _handleSubmitForm() async {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    final _auth = Provider.of<AuthProvider>(context, listen: false);

    try {
      setState(() {
        _isLoading = true;
      });
      if (isValid) {
        _formKey.currentState.save();
        if (_isLogin) {
          await _auth.loginUser();
        } else {
          await _auth.signUpUser();
        }
      }
      if (!isValid) {
        setState(() {
          _isLoading = false;
          _errorMessage = _auth.message;
        });
        return null;
      }
      setState(() {
        _isLoading = false;
        _errorMessage = _auth.message;
      });

      SnackBar snackbar = SnackBar(
        content: Text(
          _errorMessage,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red[100],
        duration: Duration(
          seconds: 4,
        ),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    } catch (error) {
      print(error);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context);
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            offset: Offset(1, 1),
            spreadRadius: 5.0,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              _isLogin ? 'LogIn' : 'SignUp',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 15.0),
            if (!_isLogin)
              TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Username',
                  helperText: 'Must be atleast 3 characters long',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value.length < 3) {
                    return 'Username too short';
                  }
                  if (value.isEmpty) {
                    return 'Please enter a valid username';
                  }
                  return null;
                },
                onSaved: (value) => _auth.changeUsername(value),
              ),
            SizedBox(height: 10.0),
            TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _auth.changeUseremail(value.trim());
                  });
                }),
            SizedBox(height: 10.0),
            TextFormField(
                textCapitalization: TextCapitalization.words,
                obscureText: _obscureText,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: _obscureText
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _obscureText = !_obscureText),
                    )),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password is too short';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _auth.changeUserpassword(value.trim());
                  });
                }),
            SizedBox(height: 10.0),
            _isLoading
                ? CircularProgressIndicator()
                : RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: kTextColor,
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Text(
                      _isLogin ? 'LogIn' : 'SignUp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    onPressed: _handleSubmitForm,
                  ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isLogin ? 'Create an account?' : 'Already have an account?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
                FlatButton(
                  child: Text(
                    _isLogin ? 'SignUp' : 'LogIn',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  onPressed: () => setState(() => _isLogin = !_isLogin),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
