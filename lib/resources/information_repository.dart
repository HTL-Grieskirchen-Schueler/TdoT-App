import 'api_provider.dart';

class InformationRepositroy {
  InformationRepositroy._privateConstructor();

  static final InformationRepositroy _instance =
      InformationRepositroy._privateConstructor();

  factory InformationRepositroy() {
    return _instance;
  }

  final _provider = ApiProvider();
  String? _cachedInformationText;

  Future<String> getInformationText() async {
    if (_cachedInformationText != null) {
      return _cachedInformationText!;
    }

    var response = await _provider.getRequest(endpoint: '/text/someText');
    _cachedInformationText = response.data;

    return _cachedInformationText!;
  }
}
