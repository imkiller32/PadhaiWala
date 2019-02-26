import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';

void onShareTap(context,link) {
    final RenderBox box = context.findRenderObject();
    link="Hi Download iitism2k16 App to get Amazing stuff and study material Now.\n"+link;
    Share.share(link,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }