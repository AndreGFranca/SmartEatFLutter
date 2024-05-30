import 'package:flutter/material.dart';
import 'package:smart_eats/components/utils/default_colors.dart';

import 'custom_radio_button.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final Function onClick;
  final IconData icon;

  MenuItem({
    super.key,
    required this.text,
    required this.onClick, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color.fromRGBO(223, 223, 223, 0.5), width: 0.5)),
      ),
      child: ListTile(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Icon(icon, color: DefaultColors.primaryColor,size: 35,),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto-Regular',
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios_rounded,color: DefaultColors.primaryColor,size: 30,),
          onPressed: () => onClick(),
        ),
        //onTap: () => onChanged(value),
      ),
    );
  }
}
