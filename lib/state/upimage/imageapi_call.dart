import 'package:food4u/utility/my_constant.dart';
import 'package:http/http.dart' as http;

Future<String> uploadImageMember(
  String mbid, String filePath, String chkfile) async {
  http.MultipartRequest request = new http.MultipartRequest(
    "POST", 
      Uri.parse('${MyConstant().imageapi}/' +
        'api/upload?dirpath=${MyConstant().webappfolder}\\'+
        '${MyConstant().apipath}\\Image\\Member\\&fname=$mbid&chkfile=$chkfile'));

  http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('file', filePath);

  request.files.add(multipartFile);
  var headers = {"content-type": "multipart/form-data"};
  request.headers.addAll(headers);

  var response = await request.send();
  if (response.statusCode == 200) {
    final responseString = await response.stream.bytesToString();
    return responseString;
  } else {
    return null;
  }
}

Future<String> uploadImageShop(
  String ccode, String filePath, String chkfile) async {
  http.MultipartRequest request = new http.MultipartRequest(
    "POST",
     Uri.parse('${MyConstant().imageapi}/' +
        'api/upload?dirpath=${MyConstant().webappfolder}\\'+
        '${MyConstant().apipath}\\Image\\Shop\\&fname=$ccode&chkfile=$chkfile'));

  // http.MultipartRequest request = new http.MultipartRequest(
  //     "POST", Uri.parse('http://10.0.2.2:5000/api/upload'));

  http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('file', filePath);

  request.files.add(multipartFile);
  var headers = {"content-type": "multipart/form-data"};
  request.headers.addAll(headers);

  var response = await request.send();
  if (response.statusCode == 200) {
    final responseString = await response.stream.bytesToString();
    return responseString;
  } else {
    return null;
  }
}

Future<String> uploadImageItem(
  String ccode, String filePath, String chkfile, String fname) async {
  http.MultipartRequest request = new http.MultipartRequest(
      "POST",
      Uri.parse('${MyConstant().imageapi}/' +
          'api/upload?dirpath=F:\\Webapp\\Food4u\\Images\\product\\$ccode\\' +
          '&fname=$fname&chkfile=$chkfile'));

  http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('file', filePath);

  request.files.add(multipartFile);
  var headers = {"content-type": "multipart/form-data"};
  request.headers.addAll(headers);

  var response = await request.send();
  if (response.statusCode == 200) {
    final responseString = await response.stream.bytesToString();
    return responseString;
  } else {
    return null;
  }
}
