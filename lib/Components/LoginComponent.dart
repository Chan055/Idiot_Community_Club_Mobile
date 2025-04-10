import 'package:flutter/material.dart';

class Loginwidget {
  static Container inputBox({
    getInput,
    myLabel,
    bool myObsecure = false,
    password = false,
    VoidCallback? togglePassword,
    required myController,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      width: 315,
      decoration: BoxDecoration(
        color: Color.fromARGB(92, 106, 132, 235),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextFormField(
        controller: myController,
        obscureText: myObsecure,
        onChanged: getInput,
        decoration: InputDecoration(
          suffixIcon:
              password
                  ? IconButton(
                    onPressed: togglePassword,
                    icon:
                        myObsecure
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                  )
                  : null,
          labelText: myLabel,
          labelStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
