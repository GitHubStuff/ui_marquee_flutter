part of 'ui_marquee_widget.dart';

class IntegralCurve extends Curve {
  static const double delta = 0.01;

  const IntegralCurve._(this.original, this.integral, this._values);

  final Curve original;
  final double integral;
  final Map<double, double> _values;

  factory IntegralCurve(Curve original) {
    double integral = 0.0;
    final values = <double, double>{};

    for (double t = 0.0; t <= 1.0; t += delta) {
      integral += original.transform(t) * delta;
      values[t] = integral;
    }
    values[1.0] = integral;

    for (final double t in values.keys) {
      values[t] = values[t]! / integral;
    }

    return IntegralCurve._(original, integral, values);
  }

  @override
  double transform(double t) {
    if (t < 0) return 0.0;
    for (final key in _values.keys) {
      if (key > t) return _values[key]!;
    }
    return 1.0;
  }
}
