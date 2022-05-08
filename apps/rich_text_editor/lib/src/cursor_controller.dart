part of 'rich_text_editor.dart';

class CursorController extends AnimationController {
  CursorController({
    required TickerProvider vsync,
    Duration animationDuration = const Duration(milliseconds: 200),
    this.blinkInterval = const Duration(milliseconds: 500),
  }) : super(
          vsync: vsync,
          duration: animationDuration,
        ) {
    _timer = Timer.periodic(blinkInterval, _onTick);
  }
  final Duration blinkInterval;

  final Curve _curve = Curves.easeOut;

  late Timer _timer;

  bool _visible = true;

  double get opacity => value;

  void _onTick(Timer timer) {
    _visible = !_visible;
    animateTo(_visible ? upperBound : lowerBound, curve: _curve);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
