import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  VoidCallback voidCallback;
  var title;
  bool loading;
  CustomButtom({
    super.key,
    required this.voidCallback,
    required this.title,
    this.loading=false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 45,
      child: ElevatedButton(onPressed: voidCallback,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightGreen,
          ),
          child:loading ?const Center(child:
          CircularProgressIndicator(),): Text(title,style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),)
      ),
    );
  }
}
