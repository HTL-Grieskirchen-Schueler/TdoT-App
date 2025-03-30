import 'package:tdot_gkr/models/event.model.dart';
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

  Future<List<Event>> getActivities() async {
    var response = await _provider.getRequest(endpoint: '/navigation/activities');
    var responseData = response.data;

    try {
      if (responseData is List) {
        return responseData
            .map((activityJson) => Event.fromJson(activityJson))
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

      if (responseData is List) {
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
      String svgData = response.data;

/*
      // Fetch activities and nodes directly within this method
      final activities = await getActivities();
      final nodes = await getNodes();

      // Filter nodes that have activities and match the given floor
      final nodesWithActivities = nodes.where((node) {
        return (node.name.startsWith("e") ? 0 : 1) == floor &&
            activities.any((activity) => activity.room == node.name);
      }).toList();

      
      for (var node in nodesWithActivities) {
        final activity = activities.firstWhere((activity) => activity.room == node.name);

        // Debug: Print activity details
        print('Adding "i" icon for activity "${activity.name}" at node (${node.height}, ${node.width})');

        // Add the "i" icon to the SVG
        final activityElement = '''
  <text x="${(int.parse(node.height) + 10).toString()}" 
        y="${(int.parse(node.width) + 10).toString()}" 
        font-size="16" fill="red" >
        i
  </text>
''';

        // Inject the activity element into the SVG
        final insertIndex = svgData.lastIndexOf('</svg>'); // Ensures it is placed at the very end

        svgData = svgData.substring(0, insertIndex) + activityElement + svgData.substring(insertIndex);
      }
      */


      final rectRegex = RegExp(r'<rect[^>]*id="([^"]+)"(?:[^>]*x="([^"]*)")?(?:[^>]*y="([^"]*)")?[^>]*>');

      svgData = svgData.replaceAllMapped(rectRegex, (match) {
        final id = match.group(1);
        final rawX = match.group(2);
        final rawY = match.group(3);

        if (id == null || id.length > 3) {
          return match.group(0)!; 
        }

        final x = double.tryParse(rawX ?? '0') ?? 0;
        final y = double.tryParse(rawY ?? '0') ?? 0;

        print('Parsed values: id=$id, x=$x, y=$y');

        final textElement = '<text x="${x + 5}" y="${y + 15}" font-size="14" fill="black">$id</text>';

        return '${match.group(0)}$textElement';
      });


      return svgData;
    } else {
      throw Exception('Failed to load SVG.');
    }
  } catch (e) {
    throw Exception("An error occurred. Please try again later.");
  }
}

}