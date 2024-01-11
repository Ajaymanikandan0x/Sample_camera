

import 'package:camera_test/pages/display.dart';
import 'package:camera_test/pages/home.dart';
import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(routes: {
 '/':(context)=>Camera(),
 '/display':(context)=>Photos(),
},

));