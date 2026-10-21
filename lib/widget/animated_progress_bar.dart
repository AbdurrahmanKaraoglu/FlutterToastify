import 'package:flutter/material.dart';

/// A bar that empties at a constant rate over [duration], showing the
/// remaining display time of a notification.
///
/// Bildirimin kalan süresini gösteren, [duration] boyunca sabit hızla boşalan çubuk.
class AnimatedProgressBar extends StatefulWidget {
  /// Creates a bar that empties over [duration]. / [duration] boyunca boşalan bir çubuk oluşturur.
  const AnimatedProgressBar({super.key, required this.duration, required this.foregroundColor, required this.backgroundColor});

  /// Foreground color of the progress bar. / İlerleme çubuğunun ön plan rengi.
  final Color foregroundColor;

  /// Background color of the progress bar. / İlerleme çubuğunun arka plan rengi.
  final Color backgroundColor;

  /// Animation duration of the progress bar. / İlerleme çubuğunun animasyon süresi.
  final Duration duration;

  /// Unused, the bar always runs to 0. / Kullanılmıyor; çubuk her zaman 0'a doğru ilerler.
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
