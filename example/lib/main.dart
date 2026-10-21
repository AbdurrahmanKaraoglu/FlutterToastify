import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_toastify/flutter_toastify.dart';

import 'strings.dart';

void main() {
  runApp(const MyApp());
}

/// Corporate navy brand color. / Kurumsal lacivert marka rengi.
const Color _brand = Color(0xFF1E3A5F);

class MyApp extends StatefulWidget {
  /// [initialLocale] is null by default, so the app follows the device language.
  const MyApp({super.key, this.initialLocale});

  final Locale? initialLocale;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale? _locale = widget.initialLocale;

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
      locale: _locale,
      supportedLocales: AppStrings.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // Desteklenmeyen cihaz dillerinde İngilizceye düşer.
      localeResolutionCallback: (deviceLocale, supported) => supported.firstWhere(
        (l) => l.languageCode == deviceLocale?.languageCode,
        orElse: () => const Locale('en'),
      ),
      home: ExampleApp(onLocaleChanged: (locale) => setState(() => _locale = locale)),
    );
  }
}

/// A single notification scenario. / Örnek bir bildirim senaryosu.
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

List<_Demo> _presets(AppStrings s) => [
      _Demo(
        title: s.successTitle,
        subtitle: s.successSubtitle,
        icon: Icons.check_circle_outline,
        color: const Color(0xFF01CB67),
        show: (context) => FlutterToastify.success(
          width: 360,
          notificationPosition: NotificationPosition.topLeft,
          animation: AnimationType.fromTop,
          title: Text(s.successToastTitle),
          description: Text(s.successToastBody),
        ).show(context),
      ),
      _Demo(
        title: s.errorTitle,
        subtitle: s.errorSubtitle,
        icon: Icons.error_outline,
        color: const Color(0xFFFE355C),
        show: (context) => FlutterToastify.error(
          width: 360,
          notificationPosition: NotificationPosition.topRight,
          animation: AnimationType.fromRight,
          title: Text(s.errorToastTitle),
          description: Text(s.errorToastBody),
        ).show(context),
      ),
      _Demo(
        title: s.infoTitle,
        subtitle: s.infoSubtitle,
        icon: Icons.info_outline,
        color: const Color(0xFF0066FF),
        show: (context) => FlutterToastify.info(
          width: 360,
          notificationPosition: NotificationPosition.centerLeft,
          animation: AnimationType.fromLeft,
          title: Text(s.infoToastTitle),
          description: Text(s.infoToastBody),
          showProgressIndicator: false,
        ).show(context),
      ),
    ];

List<_Demo> _custom(AppStrings s) => [
      _Demo(
        title: s.customTitle,
        subtitle: s.customSubtitle,
        icon: Icons.system_update_alt,
        color: Colors.orange,
        show: (context) => FlutterToastify(
          width: 360,
          notificationPosition: NotificationPosition.centerRight,
          animation: AnimationType.fromRight,
          title: Text(s.newVersionTitle, style: const TextStyle(color: Colors.red)),
          description: Text(s.newVersionBody),
          icon: const Icon(Icons.access_alarm, color: Colors.orange),
          progressIndicatorColor: Colors.orange,
        ).show(context),
      ),
      _Demo(
        title: s.actionTitle,
        subtitle: s.actionSubtitle,
        icon: Icons.link,
        color: const Color(0xFF0066FF),
        show: (context) => FlutterToastify.info(
          width: 360,
          notificationPosition: NotificationPosition.bottomLeft,
          animation: AnimationType.fromLeft,
          title: Text(s.infoToastTitle),
          description: Text(s.infoToastBody),
          action: Text(
            s.actionLink,
            style: const TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
          ),
          onActionPressed: () {},
          showProgressIndicator: false,
        ).show(context),
      ),
      _Demo(
        title: s.persistentTitle,
        subtitle: s.persistentSubtitle,
        icon: Icons.push_pin_outlined,
        color: Colors.orange,
        show: (context) => FlutterToastify(
          width: 360,
          notificationPosition: NotificationPosition.bottomRight,
          animation: AnimationType.fromBottom,
          description: Text(s.newVersionBody),
          icon: const Icon(Icons.access_alarm, color: Colors.orange),
          showProgressIndicator: false,
          autoDismiss: false,
        ).show(context),
      ),
      _Demo(
        title: s.customCloseTitle,
        subtitle: s.customCloseSubtitle,
        icon: Icons.logout,
        color: Colors.purple,
        show: (context) => FlutterToastify(
          width: 360,
          notificationPosition: NotificationPosition.topRight,
          animation: AnimationType.fromRight,
          description: Text(s.dashboardBody),
          icon: const Icon(Icons.dashboard_customize_outlined, color: Colors.purple),
          showProgressIndicator: false,
          autoDismiss: false,
          closeButton: (dismiss) => Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: IconButton.filled(
              onPressed: dismiss,
              tooltip: s.signOut,
              style: IconButton.styleFrom(backgroundColor: Colors.purple),
              icon: const Icon(Icons.logout, color: Colors.white),
            ),
          ),
        ).show(context),
      ),
    ];

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key, required this.onLocaleChanged});

  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterToastify', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          _LanguageMenu(onSelected: onLocaleChanged),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              children: [
                _Header(title: s.headerTitle, body: s.headerBody),
                const SizedBox(height: 24),
                _SectionTitle(s.presetsSection),
                _DemoGroup(demos: _presets(s)),
                const SizedBox(height: 24),
                _SectionTitle(s.customSection),
                _DemoGroup(demos: _custom(s)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// App bar language picker. / Uygulama çubuğundaki dil seçici.
class _LanguageMenu extends StatelessWidget {
  const _LanguageMenu({required this.onSelected});

  final ValueChanged<Locale> onSelected;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final current = Localizations.localeOf(context).languageCode;
    return PopupMenuButton<Locale>(
      tooltip: s.language,
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final locale in AppStrings.supportedLocales)
          CheckedPopupMenuItem<Locale>(
            value: locale,
            checked: locale.languageCode == current,
            child: Text(AppStrings.languageName(locale)),
          ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.translate, size: 20),
            const SizedBox(width: 6),
            Text(current.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.body});

  final String title;
  final String body;

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
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
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

  /// Already upper case: Dart's toUpperCase() is not Turkish-aware (i → I instead of İ).
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
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
