import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smart_eats/services/confirm/confirm_service.dart';
import '../../utils/default_colors.dart';
import '../response_modal.dart';

class QrCodeScan extends StatefulWidget {
  bool loading = false;
  ConfirmService _confirmService = ConfirmService();

  QrCodeScan({super.key});

  @override
  State<QrCodeScan> createState() => _QrCodeScanState();
}

class _QrCodeScanState extends State<QrCodeScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if(result != null)
          widget.loading = true;
      });
      if (result != null) {
        try{
          widget._confirmService.ConfirmPresence(result!.code!).then((value){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResponseModal(
                  texto: value,
                ),
              ),
            ).then((value){
              Navigator.pop(context);
            });
          }).catchError((e){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
            setState(() {
              widget.loading = false;
              result = null;
            });
          });

        }catch(e){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("QrCode não é valido"),
            ),
          );
          setState(() {
            widget.loading = false;
            result = null;
          });
        }
      }
    });
  }

  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        titleAppBar: 'QrCode Scan',
      ),
      body: Column(
        children: <Widget>[
          if (!widget.loading)
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(),
              ),
            )
          else
          Center(child: CircularProgressIndicator()),
          buildResult(),
        ],
      ),
      backgroundColor: DefaultColors.backgroudColor,
    );
  }

  Widget buildResult() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Text(
          result != null
              ? 'Resultado: ${result!.code}'
              : 'Procurando QR Code...',
          maxLines: 3,
        ),
      );
}
