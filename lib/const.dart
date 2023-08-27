import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var db = FirebaseFirestore.instance;

// default background color for the app
var backgroundColor = Colors.grey[300];

// default border color
var borderColor = Colors.grey;

// default font size
const defaultStyle = TextStyle(fontSize: 16);

// split options
enum SplitOptions { equal, percent, exact, none }

SplitOptions selectedSplit = SplitOptions.equal;

// months
String monthEng(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "-";
  }
}
