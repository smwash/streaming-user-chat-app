import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFA95EFA);
const kSecondaryColor = Color(0xFFF3F6F8);
const kTextColor = Color(0xFF171717);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xffF9FAFB),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12.0),
    ),
    borderSide: BorderSide(
      color: Colors.black,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12.0),
    ),
    borderSide: BorderSide(
      color: Colors.black,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12.0),
    ),
    borderSide: BorderSide(
      color: Colors.black54,
    ),
  ),
);
