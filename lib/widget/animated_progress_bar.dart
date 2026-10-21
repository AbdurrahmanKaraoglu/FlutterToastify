import 'package:flutter/material.dart';

/// Bildirimin kalan süresini gösteren, doludan boşa doğru [duration] boyunca
/// sabit hızla ilerleyen çubuk.
///
/// A bar that empties at a constant rate over [duration], showing the
/// remaining display time of a notification.
class AnimatedProgressBar extends StatefulWidget {
  /// Dolu çubuktan boşa doğru [duration] boyunca ilerleyen bir çubuk oluşturur.
  const AnimatedProgressBar({super.key, required this.duration, required this.foregroundColor, required this.backgroundColor});

  /// İlerleme çubuğunun ön plan rengi. (Foreground color of the progress bar)
  final Color foregroundColor;

  /// İlerleme çubuğunun arka plan rengi. (Background color of the progress bar)
  final Color backgroundColor;

  /// İlerleme çubuğunun animasyon süresi. (Animation duration of the progress bar)
  final Duration duration;

  /// Kullanılmıyor; çubuk her zaman 0'a doğru ilerler. (Unused, the bar always runs to 0)
  @Deprecated('Unused. The bar always runs to 0. Will be removed in the next major version.')
  final double value = 0;

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Bildirimin kapanma zamanlayıcısıyla aynı anda başlar ve doğrusal ilerler,
    // böylece çubuk kalan süreyi doğru gösterir.
    _controller = AnimationController(
      duration: widget.duration,
      value: 1,
      vsync: this,
    )..reverse();
  }

  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller
        ..duration = widget.duration
        ..reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return LinearProgressIndicator(
          backgroundColor: widget.backgroundColor,
          valueColor: AlwaysStoppedAnimation(widget.foregroundColor),
          value: _controller.value,
        );
      },
    );
  }
}
