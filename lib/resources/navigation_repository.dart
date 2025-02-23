import 'package:tdot_gkr/models/activity.model.dart';
import 'package:tdot_gkr/models/node.model.dart';
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

  Future<List<Node>> getNodes() async {
    var response = await _provider.getRequest(endpoint: '/navigation/nodes');
    var responseData = response.data;

    try {
      if(responseData is List) {
        return responseData
          .map((nodeJson) => Node.fromJson(nodeJson))
          .toList();
      } else {
        throw Exception('Unexpected response format: Expected a list of nodes.');
      }
    } catch (e) {
      throw Exception('Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
    }
  }

  Future<String> getSvg(int floor) async {
    var response = await _provider.getRequest(endpoint: '/navigation/floorsvg?floor=$floor');

    try {
      if (response.statusCode == 200) {
        return response.data;
      }else {
        throw Exception('Failed to load SVG.');
      }
    } catch (e) {
      throw Exception("Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.");
    }
  }
}