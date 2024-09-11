import 'package:hive_flutter/hive_flutter.dart';

class DatabaseServices {
  final Box<Object> box;
  DatabaseServices._(this.box);
  static const databaseBox = 'databaseBox';

  /// DB Surah
  static const lastSurahRead = 'lastSurahRead';
  static const lastAyahRead = 'lastAyahRead';
  static const lastSurahNameRead = 'lastSurahNameRead';
  static const lastSurahNameTranslationRead = 'lastSurahNameTranslationRead';
  static const totalAyatSuratLastRead = 'totalAyatSuratLastRead';
  static const dateLastRead = 'dateLastRead';

  ///DB auth
  static const accesToken = 'accessToken';
  static const refreshToken = 'refreshToken';
  static const idUser = 'idUser';
  static const expiresIn = 'expiresIn';

  /// DB Location
  static const longitude = 'longitude';
  static const latitude = 'latitude';
  static const cityNameKey = 'cityName';

  /// Skip
  static const skipLogin = 'skipLogin';

  ///book
  static const bookCat = 'bookCategory';

  static Future<DatabaseServices> getInstance() async {
    final box = await Hive.openBox<Object>(databaseBox);
    return DatabaseServices._(box);
  }

  T getValue<T>(Object key, {required T defaultValue}) =>
      box.get(key, defaultValue: defaultValue) as T;

  Future<void> setValue<T>(Object key, T value) => box.put(key, value!);

  /// Surat

  Future<void> setLastReadQuran(Map<dynamic, dynamic> lastReadQuran) =>
      setValue(
        'lastReadQuran',
        lastReadQuran,
      );

  Map<dynamic, dynamic> getLastReadQuran() => getValue(
        'lastReadQuran',
        defaultValue: {
          "nama_surah": '',
          "last_ayat": 0,
          "total_ayat": 7,
          "index_ayat": 0,
          "page_surah": 0,
          "read_by_page": false,
          "nomer_surah": 0,
        },
      );

  Future<void> setBookmarkQuran(List bookmarkQuran) => setValue(
        'bookmarkQuran',
        bookmarkQuran,
      );

  List getBookmarkQuran() => getValue(
        'bookmarkQuran',
        defaultValue: [],
      );

  Future<void> deleteSurahData() async {
    await box.delete('offsetLastReadQuran');
    await box.delete('lastReadQuran');

    // await box.delete(dateLastRead);
  }

  /// Pengaturan Quran

  Future<void> setArabicFontSize(Map<dynamic, dynamic> arabicFontSize) =>
      setValue('arabicFontSize', arabicFontSize);

  Map<dynamic, dynamic> getArabicFontSize() => getValue(
        'arabicFontSize',
        defaultValue: {
          "title": "Normal",
          "data": {
            "size": 24,
            "value": 2,
          }
        },
      );

  Future<void> setLatinFontSize(Map<dynamic, dynamic> latinFontSize) =>
      setValue('latinFontSize', latinFontSize);

  Map<dynamic, dynamic> getLatinFontSize() => getValue(
        'latinFontSize',
        defaultValue: {
          "title": "Normal",
          "data": {
            "size": 16,
            "value": 2,
          }
        },
      );

  Future<void> setTerjemahanFontSize(
          Map<dynamic, dynamic> terjemahanFontSize) =>
      setValue('terjemahanFontSize', terjemahanFontSize);

  Map<dynamic, dynamic> getTerjemahanFontSize() => getValue(
        'terjemahanFontSize',
        defaultValue: {
          "title": "Normal",
          "data": {
            "size": 16,
            "value": 2,
          }
        },
      );

  Future<void> setIsLatinActive(bool isLatinActive) =>
      setValue('isLatinActive', isLatinActive);

  bool getIsLatinActive() => getValue(
        'isLatinActive',
        defaultValue: true,
      );

  Future<void> setIsTerjemahanActive(bool isTerjemahanActive) =>
      setValue('isTerjemahanActive', isTerjemahanActive);

  bool getIsTerjemahanActive() => getValue(
        'isTerjemahanActive',
        defaultValue: true,
      );

  Future<void> setQuranAudio(String quranAudio) =>
      setValue('quranAudio', quranAudio);

  String getQuranAudio() => getValue(
        'quranAudio',
        defaultValue: 'alafasy',
      );

  /// Token
  Future<void> setAccessToken(String lastAccessToken) =>
      setValue(accesToken, lastAccessToken);

  String getAccessToken() => getValue(accesToken, defaultValue: '');

  Future<void> setRefreshToken(String lastRefreshToken) =>
      setValue(refreshToken, lastRefreshToken);

  String getRefreshToken() => getValue(refreshToken, defaultValue: '');

  Future<void> setExpiresIn(String lastRefreshToken) =>
      setValue(expiresIn, lastRefreshToken);

  String getExpiresIn() => getValue(expiresIn, defaultValue: '');

  Future<void> deleteAccessToken() => box.delete(accesToken);

  Future<void> deleteRefreshToken() => box.delete(refreshToken);

  Future<void> deleteExpiresIn() => box.delete(expiresIn);

  /// Profile

  Future<void> deleteIdProfile() => box.delete(idUser);

  Future<void> setIdUser(String idUserProfile) =>
      setValue(idUser, idUserProfile);

  String getIdUser() => getValue(idUser, defaultValue: '');

  Future<void> setProfileUser(Map<dynamic, dynamic> profileUser) =>
      setValue('profileUser', profileUser);

  Map<dynamic, dynamic> getProfileUser() => getValue(
        'profileUser',
        defaultValue: {},
      );

  Future<void> deleteProfileUser() => box.delete('profileUser');

  /// Location
  Future<void> setLongitude(double lastLongitude) =>
      setValue(longitude, lastLongitude);

  double getLongitude() => getValue(longitude, defaultValue: 0);

  Future<void> setTimezone(String lastTimezone) =>
      setValue("timezone", lastTimezone);

  String getTimoze() => getValue("timezone", defaultValue: "+07");

  Future<void> setLatitude(double lastLatitude) =>
      setValue(latitude, lastLatitude);

  double getLatitude() => getValue(latitude, defaultValue: 0);

  Future<void> setCityName(String cityName) => setValue(cityNameKey, cityName);

  String getCityName() => getValue(cityNameKey, defaultValue: '');

  Future<void> setIsLiveLocation(bool isLiveLocation) =>
      setValue('isLiveLocation', isLiveLocation);

  bool getIsLiveLocation() => getValue('isLiveLocation', defaultValue: false);

  /// Sholat
  Future<void> setJadwalSholat(Map<dynamic, dynamic> jadwalSholat) =>
      setValue('jadwalSholat', jadwalSholat);

  Map<dynamic, dynamic> getJadwalSholat() => getValue(
        'jadwalSholat',
        defaultValue: {},
      );

  Future<void> deleteJadwalSholat() => box.delete('jadwalSholat');

  Future<void> setAlarmAdzan(List alarmAdzan) =>
      setValue('alarmAdzan', alarmAdzan);

  List getAlarmAdzan() => getValue(
        'alarmAdzan',
        defaultValue: [],
      );

  Future<void> deleteAlarmAdzan() => box.delete('alarmAdzan');

  /// Log Out
  Future<void> deleteBoxWhileLogout() async {
    await deleteAccessToken();
    await deleteExpiresIn();
    await deleteIdProfile();
    await deleteJadwalSholat();
    await deleteProfileUser();
    await deleteRefreshToken();
    await deleteFirstLogin();
    await box.delete('longitude');
    await box.delete('latitude');
    await box.delete('isLiveLocation');
    await deleteChatHPTProfile();
    await deleteAlarmAdzan();
  }

  /// Skip

  bool getSkipLogin() => getValue(skipLogin, defaultValue: false);

  Future<void> setSkipLogin(bool skippingLogin) =>
      setValue(skipLogin, skippingLogin);

  /// Notification

  Future<void> setSholatNotification(bool sholatNotifValue) async {
    setValue('sholatNotifValue', sholatNotifValue);
  }

  bool getSholatNotification() => getValue(
        'sholatNotifValue',
        defaultValue: false,
      );

  /// Bukumu
  Future<void> setBukumuLastRead(bukumuLastRead) async {
    setValue('bukumuLastRead', bukumuLastRead);
  }

  List getBukumuLastRead() => getValue(
        'bukumuLastRead',
        defaultValue: [],
      );
  Future<void> deleteBumu() async {
    await box.delete('bukumuLastRead');
  }

  /// Login
  Future<void> setFirstLogin(firstLogin) async {
    setValue('firstLogin', firstLogin);
  }

  bool getFirstLogin() => getValue('firstLogin', defaultValue: false);

  Future<void> deleteFirstLogin() async {
    await box.delete('firstLogin');
  }

  Future<void> setBookCategory(String data) => setValue(bookCat, data);
  Map<dynamic, dynamic> getBookCategory() =>
      getValue(bookCat, defaultValue: {});

  /// Epub
  Future<void> setEpubLasRead(bukumuLastRead) async {
    setValue('epubLastRead', bukumuLastRead);
  }

  List getEpubLastRead() => getValue(
        'epubLastRead',
        defaultValue: [],
      );

  Future<void> deleteEpubLastRead() async {
    await box.delete('epubLastRead');
  }

  /// ChatHPT Profile
  Future<void> setChatHPTProfile(Map<dynamic, dynamic> chatHPTProfil) async {
    setValue('chatHPTProfile', chatHPTProfil);
  }

  Map<dynamic, dynamic> getChatHPTProfile() => getValue(
        'chatHPTProfile',
        defaultValue: {
          "name": "",
          "email": "",
        },
      );

  Future<void> deleteChatHPTProfile() async {
    await box.delete('chatHPTProfile');
  }
}
