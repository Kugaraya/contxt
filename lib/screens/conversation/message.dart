import 'package:ConTXT/screens/home/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sms_maintained/contact.dart';
import 'package:sms_maintained/sms.dart';
import 'arrow_painter.dart';

abstract class Message extends StatelessWidget {
  Message(this.message, {this.compactMode = false, this.backgroundColor, this.arrowDirection})
      : super();

  final SmsMessage message;
  final bool compactMode;
  final Color backgroundColor;
  final ArrowDirection arrowDirection;

  bool get sent =>
      message.kind == SmsMessageKind.Sent ||
      message.state == SmsMessageState.Sent ||
      message.state == SmsMessageState.Sending ||
      message.state == SmsMessageState.Delivered;

  get time {
    return TimeOfDay(hour: message.date.hour, minute: message.date.minute);
  }

  createAvatar(Photo thumbnail, String alternativeText) {
    if (compactMode) {
      return Container(width: 40.0);
    }

    return Avatar(thumbnail, alternativeText);
  }

  createArrow() {
    if (compactMode) {
      return Container();
    }

    return CustomPaint(
      painter: ArrowPainter(
        color: this.backgroundColor, direction: this.arrowDirection),
    );
  }
}
