import 'package:food4u/model/addon_model.dart';

class LoginModel {
  String mbid;
  String mbname;
  String psw;
  String mobile;
  String email;
  String ccode;
  String servername;
  String dbname;
  String userauthen;
  String pswauthen;
  String strconn;
  int mbtid;
  String mbtcode;
  String mbtname;
  String sendaddr;
  List<AddonModel> addonM = List<AddonModel>.empty(growable: true);

  LoginModel(
      {this.mbid,
      this.mbname,
      this.psw,
      this.mobile,
      this.email,
      this.ccode,
      this.servername,
      this.dbname,
      this.userauthen,
      this.pswauthen,
      this.strconn,
      this.mbtid,
      this.mbtcode,
      this.mbtname,
      this.sendaddr,
      this.addonM}
  );

  LoginModel.fromJson(Map<String, dynamic> json) {
    mbid = json['mbid'];
    mbname = json['mbname'];
    psw = json['Psw'];
    mobile = json['Mobile'];
    email = json['email'];
    ccode = json['ccode'];
    servername = json['servername'];
    dbname = json['dbname'];
    userauthen = json['userauthen'];
    pswauthen = json['pswauthen'];
    strconn = json['strconn'];
    if (json['mbtid'] !=null && json['mbtid'] !=''){
      mbtid = int.parse(json['mbtid'].toString());
    }
    mbtcode = json['mbtcode'];
    mbtname = json['mbtname'];
    sendaddr = json['mbtname'];
    if (json['addonM'] !=null){
      addonM = List<AddonModel>.empty(growable: true);
      json['addonM'].forEach((v){
        addonM.add(AddonModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mbid'] = this.mbid;
    data['mbname'] = this.mbname;
    data['Psw'] = this.psw;
    data['Mobile'] = this.mobile;
    data['email'] = this.email;
    data['ccode'] = this.ccode;
    data['servername'] = this.servername;
    data['dbname'] = this.dbname;
    data['userauthen'] = this.userauthen;
    data['pswauthen'] = this.pswauthen;
    data['strconn'] = this.strconn;
    data['mbtid'] = this.mbtid;
    data['mbtcode'] = this.mbtcode;
    data['mbtname'] = this.mbtname;
    data['sendaddr'] =  this.sendaddr;
    data['addonM'] = this.addonM.map((e) => e.toJson()).toList();
    return data;
  }
}
