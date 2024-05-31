import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../contexts/user_context.dart';
import '../../enums/type_user.dart';
import '../utils/default_colors.dart';

class WorkerLabelAppBar extends StatelessWidget {

  const WorkerLabelAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userContext = Provider.of<UserContext>(context);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            alignment: AlignmentDirectional.center,
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: DefaultColors.primaryColor,
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.person_outline,
              color: DefaultColors.primaryColor,
              size: 42,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                'Olá, ${userContext.Nome}',
                style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'Roboto-Regular',
                  fontWeight: FontWeight.bold,
                  height: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${TypeUser.ProfileValues[int.parse(userContext.typeUser!)]}',
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.normal,
                // backgroundColor: Colors.red,
                height: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
