import 'dart:io';
import 'dart:convert';

Future<Map<String, dynamic>> readJson(String path) async {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/', 'replace');
  }
  // final file = File(path);
  final contents = await File('$dir/test/$path').readAsString();
  return jsonDecode(contents);
}
