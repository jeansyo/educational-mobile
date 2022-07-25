import 'package:appedvies/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class MaterialWebPage extends StatefulWidget {
  RouteArgument? routeArgument;
  String? _heroTag;
  MaterialWebPage({Key? key,this.routeArgument}) : super(key: key){
    _heroTag = '1';
  }

  @override
  State<MaterialWebPage> createState() => _MaterialWebPageState();
}

class _MaterialWebPageState extends State<MaterialWebPage> {
  String linkm = '';
  @override
  void initState() {
    super.initState();
    linkm = widget.routeArgument!.param[0] as String;
  }

  @override
  Widget build(BuildContext context) {
    print (linkm);
    return SafeArea(
      child: WebView(
          gestureNavigationEnabled: true,
          initialUrl:linkm,
          javascriptMode: JavascriptMode.unrestricted),
    );
  }
}