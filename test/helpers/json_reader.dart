import 'dart:io';

String readJson(String path) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/', 'replace');
  }
  // final file = File(path);
  // final contents =  File('$dir/test/$path').readAsString();
  // return jsonDecode(contents);

  return File('$dir/test/$path').readAsStringSync();
}
