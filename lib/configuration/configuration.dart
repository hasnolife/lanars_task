class Configuration {
  static const accessKey = '4ZFTlEJScJ7BXZ1tE3jlT1JMlIBHqQSkKyL26HESfao';
  static const secretKey = 'FxSYXDsq19SBBefTRocWRxs3GnWp7yc3as_KCMaZKdA';
  static const unsplashUrl = 'https://api.unsplash.com';
  static const imageListHeader = '/photos';
  static const searchHeader = '/search';

  static String get searchImagesUrl => '$unsplashUrl$searchHeader$imageListHeader';
  static String get imagesUrl => '$unsplashUrl$imageListHeader';
}
