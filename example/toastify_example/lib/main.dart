import 'package:flutter/material.dart';
import 'package:flutter_toastify/components/enums.dart';
import 'package:flutter_toastify/flutter_toastify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Bu widget, uygulamanızın köküdür.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExampleApp(),
    );
  }
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    FlutterToastify.success(
                      width: 360,
                      notificationPosition: NotificationPosition.topLeft,
                      animation: AnimationType.fromTop,
                      title: const Text('Güncelleme'),
                      description: const Text('Verileriniz güncellendi'),
                      onDismiss: () {},
                    ).show(context);
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.blue,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Başarılı tema bildirimi\n(sol üst)',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    FlutterToastify.error(
                      width: 360,
                      notificationPosition: NotificationPosition.topRight,
                      animation: AnimationType.fromRight,
                      title: const Text('Hata'),
                      description: const Text('Verilerinizi doğrulayın'),
                      onDismiss: () {},
                    ).show(context);
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.blue,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Hata tema bildirimi\n(sağ üst)',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    FlutterToastify.info(
                      width: 360,
                      notificationPosition: NotificationPosition.centerLeft,
                      animation: AnimationType.fromLeft,
                      title: const Text('Bilgi'),
                      description: const Text(
                        'Hesabınız çıkış yapıldığında güncellenecektir.',
                      ),
                      showProgressIndicator: false,
                      onDismiss: () {},
                    ).show(context);
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.blue,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Bilgi tema bildirimi\n(ortada solda)',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    FlutterToastify(
                      width: 360,
                      notificationPosition: NotificationPosition.centerRight,
                      animation: AnimationType.fromRight,
                      title: const Text(
                        'Yeni sürüm',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      description: const Text(
                        'Size uygun yeni bir sürüm mevcut, lütfen güncelleyin.',
                      ),
                      icon: const Icon(
                        Icons.access_alarm,
                        color: Colors.orange,
                      ),
                      progressIndicatorColor: Colors.orange,
                      onDismiss: () {},
                    ).show(context);
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Özel bildirim\n(ortada sağda)',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    FlutterToastify.info(
                      width: 360,
                      notificationPosition: NotificationPosition.bottomLeft,
                      animation: AnimationType.fromLeft,
                      title: const Text('Bilgi'),
                      description: const Text(
                        'Hesabınız çıkış yapıldığında güncellenecektir.',
                      ),
                      action: const Text(
                        'Link',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                      onActionPressed: () {},
                      showProgressIndicator: false,
                      onDismiss: () {},
                    ).show(context);
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.blue,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Eylemli bildirim\n(sol alt)',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    FlutterToastify(
                      width: 360,
                      notificationPosition: NotificationPosition.bottomRight,
                      animation: AnimationType.fromBottom,
                      description: const Text(
                        'Size uygun yeni bir sürüm mevcut, lütfen güncelleyin.',
                      ),
                      icon: const Icon(
                        Icons.access_alarm,
                        color: Colors.orange,
                      ),
                      progressIndicatorColor: Colors.orange,
                      showProgressIndicator: false,
                      autoDismiss: false,
                      onDismiss: () {},
                    ).show(context);
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Başlık olmadan zarif bildirim\n(sağ alt)',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    FlutterToastify(
                      width: 360,
                      notificationPosition: NotificationPosition.topRight,
                      animation: AnimationType.fromRight,
                      description: const Text(
                        'Artık panele çıkabilirsiniz.',
                      ),
                      icon: const Icon(
                        Icons.dashboard_customize_outlined,
                        color: Colors.purple,
                      ),
                      progressIndicatorColor: Colors.purple,
                      showProgressIndicator: false,
                      autoDismiss: false,
                      closeButton: (dismiss) => Container(
                        margin: Directionality.of(context) == TextDirection.rtl ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          onPressed: dismiss,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            backgroundColor: Colors.purple, // <-- Button color
                            foregroundColor: Colors.white, // <-- Splash color
                          ),
                          child: const Icon(Icons.logout, color: Colors.white),
                        ),
                      ),
                      onDismiss: () {},
                    ).show(context);
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.blue,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Özel kapatma düğmesi olan bildirim\n(sağ üst)',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
