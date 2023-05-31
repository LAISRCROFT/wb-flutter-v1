import 'package:flutter/material.dart';
import '../palletes/pallete.dart';
import 'components/Sidebar.dart';
import 'dart:io';

class CreateLivro extends StatelessWidget {
  const CreateLivro({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Palette.WBColor.shade50,
          elevation: 0
        ),
        endDrawer: Sidebar(),
      )
    );
  }
}