// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class Parameter {
  static const bool API_PRINT_LOGGING_ENABLED = true;
}

class ApiUrl {
  static String MAIN_BASE = "http://10.0.2.2:8080/api/";

  static String USER = "user";
  static String SIGN_IN = "sign-in";
  static String SIGN_UP = "sign-up";
  static String SIGN_OUT = "sign-out";
  static String HOME_PIN = "home-pins";
  static String SEARCH_PIN = "search-pins";

  static String PIN_DETAIL = "pins"; // pakai id pins/{id}
  static String PIN_SAVE_REMOVE = "pins/save-or-remove/";
  static String CREATE_PIN = "create-pins";
  static String CREATE_COMMENT = "create-comments";
  static String FOLLOW = "follows"; // pakai id follows/{id}
  static String REPORT = "reports"; // pakai id reports/{id}
  static String LIKE = "likes"; // pakai id likes/{id}
  static String NOTIFICATION = "notifications";
  static String NOTIFICATION_UNREAD = "unread-notifications";
  static String NOTIFICATION_READ_BY_ID = "read-notifications"; // pakai id read-notifications/{id}
  static String NOTIFICATION_READ_ALL = "read-all-notifications";
  static String CHANGE_PROFILE = "change-profiles";
  static String CHANGE_PASSWORD = "change-passwords";
  static String ACCOUNT = "accounts";
  static String PIN_ALBUM_DETAIL = "pins/albums"; // pakai id pins/albums/{id}
  static String ALBUM = "albums";
  static String ALBUM_THUMBNAIL = "albums/pins";
  static String ALBUM_ADD = "albums/add";


}

enum SharedPreferenceKey {
  SESSION_ID,
  USERNAME,
}
