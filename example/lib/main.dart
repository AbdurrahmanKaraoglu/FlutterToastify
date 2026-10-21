import 'package:flutter/material.dart';
import 'package:flutter_toastify/flutter_toastify.dart';

void main() {
  runApp(const MyApp());
}

/// Kurumsal lacivert tonlu marka rengi.
const Color _brand = Color(0xFF1E3A5F);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _theme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(seedColor: _brand, brightness: brightness);
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: brightness == Brightness.light ? const Color(0xFFF5F7FA) : scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: brightness == Brightness.light ? _brand : scheme.surfaceContainer,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterToastify',
      debugShowCheckedModeBanner: false,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      home: const ExampleApp(),
    );
  }
}

/// Örnek bir bildirim senaryosu.
class _Demo {
  const _Demo({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.show,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final void Function(BuildContext context) show;
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  static final List<_Demo> _presets = [
    _Demo(
      title: 'Başarılı işlem',
      subtitle: 'Sol üst · yukarıdan',
      icon: Icons.check_circle_outline,
      color: const Color(0xFF01CB67),
      show: (context) => FlutterToastify.success(
        width: 360,
        notificationPosition: NotificationPosition.topLeft,
        animation: AnimationType.fromTop,
        title: const Text('Güncelleme'),
        description: const Text('Verileriniz güncellendi'),
      ).show(context),
    ),
    _Demo(
      title: 'Hata bildirimi',
      subtitle: 'Sağ üst · sağdan',
      icon: Icons.error_outline,
      color: const Color(0xFFFE355C),
      show: (context) => FlutterToastify.error(
        width: 360,
        notificationPosition: NotificationPosition.topRight,
        animation: AnimationType.fromRight,
        title: const Text('Hata'),
        description: const Text('Verilerinizi doğrulayın'),
      ).show(context),
    ),
    _Demo(
      title: 'Bilgilendirme',
      subtitle: 'Orta sol · soldan · ilerleme çubuksuz',
      icon: Icons.info_outline,
      color: const Color(0xFF0066FF),
      show: (context) => FlutterToastify.info(
        width: 360,
        notificationPosition: NotificationPosition.centerLeft,
        animation: AnimationType.fromLeft,
        title: const Text('Bilgi'),
        description: const Text('Hesabınız çıkış yapıldığında güncellenecektir.'),
        showProgressIndicator: false,
      ).show(context),
    ),
  ];

  static final List<_Demo> _custom = [
    _Demo(
      title: 'Özel ikon ve renk',
      subtitle: 'Orta sağ · sağdan',
      icon: Icons.system_update_alt,
      color: Colors.orange,
      show: (context) => FlutterToastify(
        width: 360,
        notificationPosition: NotificationPosition.centerRight,
        animation: AnimationType.fromRight,
        title: const Text('Yeni sürüm', style: TextStyle(color: Colors.red)),
        description: const Text('Size uygun yeni bir sürüm mevcut, lütfen güncelleyin.'),
        icon: const Icon(Icons.access_alarm, color: Colors.orange),
        progressIndicatorColor: Colors.orange,
      ).show(context),
    ),
    _Demo(
      title: 'Eylem bağlantılı',
      subtitle: 'Sol alt · soldan · tıklanabilir bağlantı',
      icon: Icons.link,
      color: const Color(0xFF0066FF),
      show: (context) => FlutterToastify.info(
        width: 360,
        notificationPosition: NotificationPosition.bottomLeft,
        animation: AnimationType.fromLeft,
        title: const Text('Bilgi'),
        description: const Text('Hesabınız çıkış yapıldığında güncellenecektir.'),
        action: const Text(
          'Ayrıntıları gör',
          style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
        ),
        onActionPressed: () {},
        showProgressIndicator: false,
      ).show(context),
    ),
    _Demo(
      title: 'Kalıcı, başlıksız',
      subtitle: 'Sağ alt · aşağıdan · elle kapatılır',
      icon: Icons.push_pin_outlined,
      color: Colors.orange,
      show: (context) => FlutterToastify(
        width: 360,
        notificationPosition: NotificationPosition.bottomRight,
        animation: AnimationType.fromBottom,
        description: const Text('Size uygun yeni bir sürüm mevcut, lütfen güncelleyin.'),
        icon: const Icon(Icons.access_alarm, color: Colors.orange),
        showProgressIndicator: false,
        autoDismiss: false,
      ).show(context),
    ),
    _Demo(
      title: 'Özel kapatma düğmesi',
      subtitle: 'Sağ üst · sağdan · kalıcı',
      icon: Icons.logout,
      color: Colors.purple,
      show: (context) => FlutterToastify(
        width: 360,
        notificationPosition: NotificationPosition.topRight,
        animation: AnimationType.fromRight,
        description: const Text('Artık panele geçebilirsiniz.'),
        icon: const Icon(Icons.dashboard_customize_outlined, color: Colors.purple),
        showProgressIndicator: false,
        autoDismiss: false,
        closeButton: (dismiss) => Padding(
          padding: const EdgeInsetsDirectional.only(end: 12),
          child: IconButton.filled(
            onPressed: dismiss,
            tooltip: 'Çıkış',
            style: IconButton.styleFrom(backgroundColor: Colors.purple),
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ),
      ).show(context),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterToastify', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              children: [
                const _Header(),
                const SizedBox(height: 24),
                const _SectionTitle('Hazır stiller'),
                _DemoGroup(demos: _presets),
                const SizedBox(height: 24),
                const _SectionTitle('Özelleştirme'),
                _DemoGroup(demos: _custom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_brand, Color(0xFF2F5D8C)],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.notifications_active_outlined, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bildirim bileşeni',
                  style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bir senaryoya dokunarak bildirimi canlı olarak görüntüleyin.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _DemoGroup extends StatelessWidget {
  const _DemoGroup({required this.demos});

  final List<_Demo> demos;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var i = 0; i < demos.length; i++) ...[
            if (i > 0) Divider(height: 1, indent: 72, color: theme.colorScheme.outlineVariant),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: demos[i].color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(demos[i].icon, color: demos[i].color, size: 22),
              ),
              title: Text(demos[i].title, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(demos[i].subtitle),
              trailing: Icon(Icons.play_circle_outline, color: theme.colorScheme.primary),
              onTap: () => demos[i].show(context),
            ),
          ],
        ],
      ),
    );
  }
}
