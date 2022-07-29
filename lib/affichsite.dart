import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AfficheSite extends StatefulWidget {
  @override
  State<AfficheSite> createState() => _AfficheSiteState();
}

class _AfficheSiteState extends State<AfficheSite> {
  bool isLoading = true;
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.deepPurpleAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          toolbarHeight: 40,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Stack(
            children: [
              Center(
                child:
                    isLoading ? const CircularProgressIndicator() : Container(),
              ),
              Opacity(
                opacity: isLoading ? 0 : 1,
                child: WebView(
                  onWebViewCreated: (WebViewController webViewController) {},
                  initialUrl: "http://equipes-rosaire.org",
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageStarted: (String url) {
                    print(" WebView onPageStarted");
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onPageFinished: (String url) {
                    print(" WebView onPageFinished $url");
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onProgress: (int index) {
                    print("WebView onProgress $index");
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
