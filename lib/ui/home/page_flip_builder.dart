import 'package:flutter/material.dart';

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder({
    Key? key,
    required this.frontPageBuilder,
    required this.backPageBuilder,
  }) : super(key: key);

  final WidgetBuilder frontPageBuilder;
  final WidgetBuilder backPageBuilder;

  @override
  _PageFlipBuilderState createState() => _PageFlipBuilderState();
}

class _PageFlipBuilderState extends State<PageFlipBuilder> {
  @override
  Widget build(BuildContext context) {
    //logic to set front or back builder
    return widget.frontPageBuilder(context);
  }
}
