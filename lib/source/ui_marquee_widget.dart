import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'integral_curve.dart';
part 'marquee.dart';

const Duration _kPauseDuration = Duration(milliseconds: 750);
const double _kRolloverPercentage = 0.1;
const double _kTextStyleHeightPadding = 1.1;
const double _kVelocity = 60.0;

@immutable
final class UIMarqueeWidget extends StatelessWidget {
  final String message;
  final bool forceScroll;
  final double rolloverPercentage;
  final double scrollVelocityInPixelsPerSecond;
  final Duration pauseDuration;
  final TextStyle? textStyle;

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
    return LayoutBuilder(builder: (builderContext, constraints) {
      final double availableWidth = constraints.maxWidth == double.infinity
          ? MediaQuery.of(context).size.width
          : constraints.maxWidth;

      Text textWidget = Text(message, style: textStyle);
      final textWidgetSize = _getTextDimensions(textWidget);

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

  double _space(double width, {required double pct}) {
    assert(pct >= 0.0 && pct <= 1.0, 'pct must be between 0.0 and 1.0');
    return width * (1.0 - pct);
  }
}
