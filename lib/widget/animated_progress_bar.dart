import 'package:flutter/material.dart';

/// Bu kod, animasyonlu bir ilerleme çubuğu (progress bar) widget'ı olan `AnimatedProgressBar`'u tanımlar. İlerleme çubuğu, bir işlemin veya yükleme durumunun görsel bir şekilde kullanıcıya bildirilmesi için kullanılır.

/// `AnimatedProgressBar` sınıfı aşağıdaki özelliklere sahiptir:

/// - `foregroundColor`: İlerleme çubuğunun ön plan rengini belirten `Color` tipinde bir değişken.
/// - `backgroundColor`: İlerleme çubuğunun arka plan rengini belirten `Color` tipinde bir değişken.
/// - `duration`: İlerleme çubuğunun animasyon süresini belirten `Duration` tipinde bir değişken.
/// - `value`: İlerleme çubuğunun başlangıç değerini belirten ve her zaman 0 olan bir değişken (bu değeri değiştirilebilir).

/// Bu widget, `LinearProgressIndicator`'ı kullanarak görsel olarak ilerleme çubuğunu gösterir. `AnimatedBuilder` widget'ı, animasyonun tetiklenmesini ve çubuğun ilerleme değerini takip eder. `AnimationController` ve `Tween` kullanılarak ilerleme çubuğunun animasyonlu bir şekilde güncellenmesi sağlanır.

/// Kodun çalışması şu şekildedir:

/// 1. `AnimatedProgressBar` oluşturulurken `foregroundColor`, `backgroundColor` ve `duration` değerleri parametre olarak alınır.
/// 2. `initState` metodu, `AnimationController` ve diğer animasyon nesnelerinin oluşturulmasını ve ilerleme çubuğunun animasyonunun başlatılmasını sağlar.
/// 3. `didUpdateWidget` metodu, ilerleme çubuğunun ilerleme değeri (`value`) değiştirildiğinde animasyonun güncellenmesini sağlar.
/// 4. `build` metodu, `AnimatedBuilder` içinde `LinearProgressIndicator` widget'ını döndürür ve çubuğun ilerleme değerini animasyonlu olarak gösterir.
/// Sonuç olarak, bu kod, animasyonlu bir ilerleme çubuğu oluşturarak işlemlerinizin veya yükleme durumlarının kullanıcılara daha etkileşimli bir şekilde gösterilmesini sağlar.

/// This code defines an animated progress bar widget called `AnimatedProgressBar`. A progress bar is used to visually indicate the progress of a task or loading status to the user.
/// The `AnimatedProgressBar` class has the following properties:
/// - `foregroundColor`: A `Color` variable that defines the foreground color of the progress bar.
/// - `backgroundColor`: A `Color` variable that defines the background color of the progress bar.
/// - `duration`: A `Duration` variable that determines the animation duration of the progress bar.
/// - `value`: A variable that represents the initial value of the progress bar and is always set to 0 (this value can be changed).
/// This widget displays the progress bar visually using the `LinearProgressIndicator`. The `AnimatedBuilder` widget is used to trigger the animation and track the progress value of the bar. The progress bar is animated using an `AnimationController` and `Tween`.
/// Here's how the code works:
/// 1. When an `AnimatedProgressBar` is created, it takes `foregroundColor`, `backgroundColor`, and `duration` as parameters.
/// 2. The `initState` method initializes the `AnimationController` and other animation objects and starts the animation of the progress bar.
/// 3. The `didUpdateWidget` method updates the animation when the progress value (`value`) of the progress bar is changed.
/// 4. The `build` method returns the `LinearProgressIndicator` widget wrapped inside an `AnimatedBuilder`, which visually shows the animated progress value of the bar.
/// In conclusion, this code creates an animated progress bar, enhancing user interaction by visually indicating the progress of tasks or loading processes.
class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({super.key, required this.duration, required this.foregroundColor, required this.backgroundColor});
  final Color foregroundColor; // İlerleme çubuğunun ön plan rengi. (Foreground color of the progress bar)
  final Color backgroundColor; // İlerleme çubuğunun arka plan rengi. (Background color of the progress bar)
  final Duration duration; // İlerleme çubuğunun animasyon süresi. (Animation duration of the progress bar)
  final double value = 0; // İlerleme çubuğunun başlangıç değeri. (Initial value of the progress bar)

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> curve;
  late Tween<double> valueTween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    valueTween = Tween<double>(
      begin: 1,
      end: 0,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      double beginValue = valueTween.evaluate(curve);
      valueTween = Tween<double>(
        begin: beginValue,
        end: widget.value,
      );

      _controller
        ..value = 0
        ..forward();
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
      animation: curve,
      builder: (context, child) {
        return LinearProgressIndicator(
          backgroundColor: widget.backgroundColor, // İlerleme çubuğunun arka plan rengi. (Background color of the progress bar)
          valueColor: AlwaysStoppedAnimation(widget.foregroundColor), // İlerleme çubuğunun ilerleme rengi. (Progress color of the progress bar)
          value: valueTween.evaluate(curve), // İlerleme çubuğunun ilerleme değeri. (Progress value of the progress bar)
        );
      },
    );
  }
}


