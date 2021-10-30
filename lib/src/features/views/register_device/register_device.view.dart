import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class RegisterDeviceView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterDeviceViewState();
}

class _RegisterDeviceViewState extends State<RegisterDeviceView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          tooltip: 'Go back',
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: IconButton(
                          icon: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              bool? flashStatus = snapshot.data as bool?;
                              return Icon(flashStatus != null && flashStatus ? Icons.flash_off : Icons.flash_on);
                            },
                          ),
                          tooltip: 'Toggle flash',
                          onPressed: ()async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                        )
                      ),
                      Container(
                          margin: EdgeInsets.all(8),
                          child: IconButton(
                            icon: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                CameraFacing? cameraStatus = snapshot.data as CameraFacing?;
                                IconData iconForPlatform = Platform.isIOS ? Icons.flip_camera_ios : Icons.flip_camera_android;
                                return Icon(iconForPlatform);
                              },
                            ),
                            tooltip: 'Toggle Camera',
                            onPressed: ()async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData.format == BarcodeFormat.qrcode) {
        print("Found QRCode");
        print("Data ${scanData.code}");
      }
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}