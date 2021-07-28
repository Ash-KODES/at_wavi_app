import 'dart:io';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:at_common_flutter/services/size_config.dart';

class WebsiteScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebsiteScreen({Key? key, required this.title, required this.url})
      : super(key: key);
  @override
  _WebsiteScreenState createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen> {
  late bool loading;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: ColorConstants.black,
            size: 25.toHeight,
          ),
        ),
        title: Text(widget.title, style: CustomTextStyles.black(size: 18)),
      ),
      body: Stack(children: [
        WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (test1) {
            setState(() {
              loading = false;
            });
          },
        ),
        loading
            ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                  ColorConstants.black,
                )),
              )
            : SizedBox()
      ]),
    );
  }
}
