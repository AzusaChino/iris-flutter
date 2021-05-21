import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class SectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return InfiniteListView(onRetrieveData: (page, items, refresh) async {
      return true;
    }, itemBuilder: (list, index, ctx) {
      return null;
    });
  }
}
