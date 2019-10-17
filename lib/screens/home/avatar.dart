import 'package:ConTXT/utils/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sms_maintained/contact.dart';

class Avatar extends StatelessWidget {
  Avatar(Photo photo, String alternativeText)
      : photo = photo,
        alternativeText = alternativeText,
        super(key: ObjectKey(photo));

  final Photo photo;
  final String alternativeText;

  @override
  Widget build(BuildContext context) {
    if (photo != null) {
      return CircleAvatar(
        backgroundImage: MemoryImage(photo.bytes),
      );
    }

    return CircleAvatar(
      backgroundColor: ContactColor.getColor(alternativeText),
      child: alternativeText != null ? 
        Text(alternativeText[0]) :
        Icon(Icons.person_pin)
    );
  }
}
