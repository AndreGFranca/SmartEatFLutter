import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import '../utils/confirm_button.dart';
import '../utils/default_colors.dart';

class ResponseModal extends StatelessWidget {
 final String texto;
  ResponseModal({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                border: Border.all(color: Colors.white,width: 25),
              ),
                child: Icon(Icons.check_circle,size: 200,fill: 1,color: DefaultColors.primaryColor,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(texto,style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: DefaultColors.primaryColor,
                overflow: TextOverflow.clip,
              ),),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Column(
                children: [
                  ConfirmButton(
                      label: 'Voltar',
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: DefaultColors.backgroudColor,
    );
  }
}