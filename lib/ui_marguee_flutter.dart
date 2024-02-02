library ui_marquee_flutter;

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

/// Flutter widget that displays a scrolling sign board with a message.
///
/// The [UIMarqueeWidget] widget can be used to display a message that scrolls
/// horizontally if it doesn't fit within the available width. You can
/// customize the message and text style.

/// The duration to pause between scrolling rounds.
const Duration _kPauseDuration = Duration(milliseconds: 750);

/// Default percentage of the total Text Widgets width to use for amount of rollover
const double _kRolloverPercentage = 0.1;

/// Padding on TextStyle height so lower case letters [gjpqy] are not cut off.
/// This is a hack to fix the issue with lower case letters being cut off.
const double _kTextStyleHeightPadding = 1.1;

/// Scroll velocity in pixels per second.
const double _kVelocity = 60.0;

@immutable
final class UIMarqueeWidget extends StatelessWidget {
  /// The message to display on the sign board.
  final String message;

  /// Force the text to scroll
  final bool forceScroll;

  /// Duration of the pause between scrolling rounds.
  final Duration pauseDuration;

  /// Percentage of the total Text Widgets width to use for amount of rollover
  /// between instances of the animation.
  final double rolloverPercentage;

  /// The scroll velocity in pixels per second.
  final double scrollVelocityInPixelsPerSecond;

  /// Optional text style for the message.
  final TextStyle? textStyle;

  /// Creates a [UIMarqueeWidget] widget with the specified [message] and [textStyle].
  ///
  /// The [message] parameter is required and represents the text to be displayed.
  ///
  /// The [forceScroll] parameter is optional and allows you to force the text to scroll
  ///
  /// The [pauseDuration] parameter is optional and allows you to customize the pause between scrolls
  ///
  /// The [rolloverPercentage] parameter is optional and allows you to customize the amount of rollover
  ///
  /// The [scrollVelocityInPixelsPerSecond] parameter is optional and allows you to customize the scroll velocity
  ///
  /// The [textStyle] parameter is optional and allows you to customize the text
  /// style of the message.
  const UIMarqueeWidget({
    super.key,
    required this.message,
    this.pauseDuration = _kPauseDuration,
    this.rolloverPercentage = _kRolloverPercentage,
    this.scrollVelocityInPixelsPerSecond = _kVelocity,
    this.textStyle,
    this.forceScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to determine available width
    return LayoutBuilder(builder: (builderContext, constraints) {
      // Calculate the available width for the message
      final double availableWidth = constraints.maxWidth == double.infinity
          ? MediaQuery.of(context).size.width
          : constraints.maxWidth;

      // Create a Text widget with the provided message and text style
      Text textWidget = Text(message, style: textStyle);

      // Calculate the dimensions of the Text widget
      final textWidgetSize = _getTextDimensions(textWidget);

      // Create a SizedBox to hold the message
      // If the text will fit within the available width, return the text
      // Otherwise, return a Marquee widget with the text that will scroll
      return SizedBox(
        height: textWidgetSize.height * _kTextStyleHeightPadding,
        child: textWidgetSize.width >= availableWidth || forceScroll
            ? Marquee(
                text: message,
                style: textStyle,
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: _space(availableWidth, pct: rolloverPercentage),
                velocity: scrollVelocityInPixelsPerSecond,
                pauseAfterRound: pauseDuration,
              )
            : textWidget,
      );
    });
  }

  /// Calculates the Size of the provided [Text] widget.
  ///
  /// This method is used to determine the dimensions of the Text widget to be
  /// displayed.
  ///
  /// Returns a [Size] object containing the calculated height and width.
  Size _getTextDimensions(Text text) {
    final textSpan = TextSpan(
      text: text.data,
      style: text.style,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    return Size(
      textPainter.width,
      textPainter.height,
    );
  }

  /// The extend of blank space to display between instances of the text.
  /// The value is the width of the 10% of the total Text Widgets width.
  /// This is used to present a small number of pixes at the start of the text
  /// so enhance the scrolling effect.
  double _space(double width, {required double pct}) {
    assert(pct >= 0.0 && pct <= 1.0, 'pct must be between 0.0 and 1.0');
    return width * (1.0 - pct);
  }
}
