import 'package:flutter/widgets.dart';

/// Turkish and English texts of the example app.
///
/// Örnek uygulamanın Türkçe ve İngilizce metinleri. Gerçek bir uygulamada
/// `flutter gen-l10n` (ARB dosyaları) tercih edilebilir; örnek sade kalsın diye
/// burada basit bir sınıf kullanılıyor.
class AppStrings {
  const AppStrings._({
    required this.language,
    required this.headerTitle,
    required this.headerBody,
    required this.presetsSection,
    required this.customSection,
    required this.successTitle,
    required this.successSubtitle,
    required this.successToastTitle,
    required this.successToastBody,
    required this.errorTitle,
    required this.errorSubtitle,
    required this.errorToastTitle,
    required this.errorToastBody,
    required this.infoTitle,
    required this.infoSubtitle,
    required this.infoToastTitle,
    required this.infoToastBody,
    required this.customTitle,
    required this.customSubtitle,
    required this.newVersionTitle,
    required this.newVersionBody,
    required this.actionTitle,
    required this.actionSubtitle,
    required this.actionLink,
    required this.persistentTitle,
    required this.persistentSubtitle,
    required this.customCloseTitle,
    required this.customCloseSubtitle,
    required this.dashboardBody,
    required this.signOut,
  });

  final String language;
  final String headerTitle;
  final String headerBody;
  final String presetsSection;
  final String customSection;
  final String successTitle;
  final String successSubtitle;
  final String successToastTitle;
  final String successToastBody;
  final String errorTitle;
  final String errorSubtitle;
  final String errorToastTitle;
  final String errorToastBody;
  final String infoTitle;
  final String infoSubtitle;
  final String infoToastTitle;
  final String infoToastBody;
  final String customTitle;
  final String customSubtitle;
  final String newVersionTitle;
  final String newVersionBody;
  final String actionTitle;
  final String actionSubtitle;
  final String actionLink;
  final String persistentTitle;
  final String persistentSubtitle;
  final String customCloseTitle;
  final String customCloseSubtitle;
  final String dashboardBody;
  final String signOut;

  static const List<Locale> supportedLocales = [Locale('en'), Locale('tr')];

  static String languageName(Locale locale) => locale.languageCode == 'tr' ? 'Türkçe' : 'English';

  static AppStrings of(BuildContext context) => Localizations.localeOf(context).languageCode == 'tr' ? tr : en;

  static const AppStrings en = AppStrings._(
    language: 'Language',
    headerTitle: 'Notification component',
    headerBody: 'Tap a scenario to see the notification live.',
    presetsSection: 'BUILT-IN STYLES',
    customSection: 'CUSTOMIZATION',
    successTitle: 'Success',
    successSubtitle: 'Top left · from top',
    successToastTitle: 'Update',
    successToastBody: 'Your data has been updated',
    errorTitle: 'Error',
    errorSubtitle: 'Top right · from right',
    errorToastTitle: 'Error',
    errorToastBody: 'Please check your data',
    infoTitle: 'Information',
    infoSubtitle: 'Center left · from left · no progress bar',
    infoToastTitle: 'Info',
    infoToastBody: 'Your account will be updated when you sign out.',
    customTitle: 'Custom icon and color',
    customSubtitle: 'Center right · from right',
    newVersionTitle: 'New version',
    newVersionBody: 'A new version is available for you, please update.',
    actionTitle: 'With action link',
    actionSubtitle: 'Bottom left · from left · tappable link',
    actionLink: 'View details',
    persistentTitle: 'Persistent, no title',
    persistentSubtitle: 'Bottom right · from bottom · closed manually',
    customCloseTitle: 'Custom close button',
    customCloseSubtitle: 'Top right · from right · persistent',
    dashboardBody: 'You can now go to the dashboard.',
    signOut: 'Sign out',
  );

  static const AppStrings tr = AppStrings._(
    language: 'Dil',
    headerTitle: 'Bildirim bileşeni',
    headerBody: 'Bir senaryoya dokunarak bildirimi canlı olarak görüntüleyin.',
    presetsSection: 'HAZIR STİLLER',
    customSection: 'ÖZELLEŞTİRME',
    successTitle: 'Başarılı işlem',
    successSubtitle: 'Sol üst · yukarıdan',
    successToastTitle: 'Güncelleme',
    successToastBody: 'Verileriniz güncellendi',
    errorTitle: 'Hata bildirimi',
    errorSubtitle: 'Sağ üst · sağdan',
    errorToastTitle: 'Hata',
    errorToastBody: 'Verilerinizi doğrulayın',
    infoTitle: 'Bilgilendirme',
    infoSubtitle: 'Orta sol · soldan · ilerleme çubuksuz',
    infoToastTitle: 'Bilgi',
    infoToastBody: 'Hesabınız çıkış yapıldığında güncellenecektir.',
    customTitle: 'Özel ikon ve renk',
    customSubtitle: 'Orta sağ · sağdan',
    newVersionTitle: 'Yeni sürüm',
    newVersionBody: 'Size uygun yeni bir sürüm mevcut, lütfen güncelleyin.',
    actionTitle: 'Eylem bağlantılı',
    actionSubtitle: 'Sol alt · soldan · tıklanabilir bağlantı',
    actionLink: 'Ayrıntıları gör',
    persistentTitle: 'Kalıcı, başlıksız',
    persistentSubtitle: 'Sağ alt · aşağıdan · elle kapatılır',
    customCloseTitle: 'Özel kapatma düğmesi',
    customCloseSubtitle: 'Sağ üst · sağdan · kalıcı',
    dashboardBody: 'Artık panele geçebilirsiniz.',
    signOut: 'Çıkış',
  );
}
