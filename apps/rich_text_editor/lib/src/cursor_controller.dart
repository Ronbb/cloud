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
    start();
  }
  final Duration blinkInterval;

  final Curve _curve = Curves.easeOut;

  Timer? _timer;

  bool _visible = true;

  double get opacity => value;

  void _onTick(Timer timer) {
    _visible = !_visible;
    animateTo(_visible ? upperBound : lowerBound, curve: _curve);
  }

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(blinkInterval, _onTick);
    _visible = true;
    super.value = super.upperBound;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
