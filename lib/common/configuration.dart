class Configuration {
  static const accessKey = '4ZFTlEJScJ7BXZ1tE3jlT1JMlIBHqQSkKyL26HESfao';
  static const _unsplashUrl = 'https://api.unsplash.com';
  static const _imageListHeader = '/photos';
  static const _searchHeader = '/search';

  static String get searchImagesUrl => '$_unsplashUrl$_searchHeader$_imageListHeader';
  static String get imagesUrl => '$_unsplashUrl$_imageListHeader';
}
