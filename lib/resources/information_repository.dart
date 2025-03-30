import 'package:tdot_gkr/models/information/section.model.dart';

import 'api_provider.dart';

class InformationRepositroy {
  InformationRepositroy._privateConstructor();

  static final InformationRepositroy _instance =
      InformationRepositroy._privateConstructor();

  factory InformationRepositroy() {
    return _instance;
  }

  final _provider = ApiProvider();
  List<InformationSection>? _cachedInformationSections;

  Future<List<InformationSection>> getInformationSections() async {
    if (_cachedInformationSections != null) {
      return _cachedInformationSections!;
    }

    var response = await _provider.getRequest(endpoint: '/text/registration');

    _cachedInformationSections = (response.data as List)
        .map((item) => InformationSection.fromJson(item))
        .toList();

    return _cachedInformationSections!;
  }
}
