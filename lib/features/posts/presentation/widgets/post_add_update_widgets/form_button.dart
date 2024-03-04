import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({super.key , required this.onPressed , required this.text , required this.icon});
final void Function()? onPressed ;
final IconData icon ;
final String text ;

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      width: MediaQuery.sizeOf(context).width / 3,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))),
        onPressed:onPressed ,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
