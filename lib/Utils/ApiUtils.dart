class ApiUtils {
  // static const String BASE = "https://dats.digitecglobal.com/novel"; // Client Live BASE URL
  static const String BASE = "https://apptocom.com/novelflex";
  static const String URL_REGISTER_USER_API = '$BASE/auth/signup';
  static const String URL_LOGIN_USER_API = '$BASE/auth/login';
  static const String ALL_CATEGORIES_API = '$BASE/books';
  static const String ALL_CATEGORIES_DROP_DOWN_API = '$BASE/categories/all';
  static const String HOME_SCREEN_API = '$BASE/books';
  static const String PROFILE_IMAGE_UPLOAD_API = '$BASE/auth/profile/update';
  static const String SEE_ALL_BOOKS_API = '$BASE/books/getCategoryBooks?categoryId=';
  static const String SEE_ALL_REVIEWS_API = '$BASE/books//reviews/all?bookId=';
  static const String UPLOAD_HISTORY_API = '$BASE/books/GetBooksOfUser';
  static const String MULTIPLE_PDF_UPLOAD_API = '$BASE/books/add/fileupload';
  static const String DROP_DOWN_CATEGORIES_API = '$BASE/cate/all';
  static const String ADD_IMAGE_WITH_FILED_API = '$BASE/books/add';
  static const String BOOK_DETAIL_API = '$BASE/books/bookDetails?bookId=';
  static const String ADD_REVIEW_API = '$BASE/books/add/reviews';
  static const String FORGET_PASSWORD_API = '$BASE/auth/password/forgot';
  static const String UPDATE_PASSWORD_API = '$BASE/auth/updatePassword';
  static const String PROFILE_STATUS_API = '$BASE/auth/user/type';
  static const String UPDATE_PROFILE_STATUS_API = '$BASE/auth/user/statusUpdate';
  static const String SUBSCRIBE_API = '$BASE/user/subscriptions';
  static const String AUTHOR_PROFILE_API = '$BASE/user/history';

}