import 'package:tdot_gkr/models/activity.model.dart';
import 'api_provider.dart';

class NavigationRepository {
  NavigationRepository._privateConstructor();

  static final NavigationRepository _instance =
      NavigationRepository._privateConstructor();

  factory NavigationRepository() {
    return _instance;
  }

  final _provider = ApiProvider();

  Future<List<Activity>> getActivities() async {
    var response = await _provider.getRequest(endpoint: '/navigation/activities');
    var responseData = response.data;

    try {
      if (responseData is List) {
        return responseData
            .map((activityJson) => Activity.fromJson(activityJson))
            .toList();
      } else {
        throw Exception('Unexpected response format: Expected a list of activities.');
      }
    } catch (e) {
      throw Exception('Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
    }
  }
}