import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/models/confirm/confirm_item_count_table.dart';
import 'package:smart_eats/services/confirm/confirm_service.dart';
import '../../utils/default_colors.dart';

class QrCodeGenerator extends StatefulWidget {
  final String userId;
  QrCodeGenerator({super.key, required this.userId});
  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        titleAppBar: 'QrCode',
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: DefaultColors.primaryColor, width: 2)
                ),
                child: Center(
                  child: QrImageView(
                    data: widget.userId,
                    size: 280,

                    // You can include embeddedImageStyle Property if you
                    //wanna embed an image from your Asset folder
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: const Size(
                        100,
                        100,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
      backgroundColor: DefaultColors.backgroudColor,
    );
  }
}
