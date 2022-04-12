import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food4u/model/shop_model.dart';
import 'package:food4u/model/shoprest_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food4u/screen/home.dart';
import 'package:food4u/state/upimage/image_state.dart' as imgstate;
import 'package:food4u/state/upimage/imageapi_call.dart';
//import 'package:food4u/state/upimage/upload_state.dart';
import 'package:food4u/utility/my_constant.dart';
import 'package:food4u/utility/mystyle.dart';
import 'package:food4u/utility/myutil.dart';
import 'package:food4u/widget/infosnackbar.dart';
import 'package:food4u/widget/mysnackbar.dart';
import 'package:image_picker/image_picker.dart';
//https://codingwithdhrumil.com/2020/10/image-picker-flutter-example.html

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class UserEditInfo extends StatefulWidget {
  final mbid;
  final loginname;
  final loginmobile;
  final pictname;
  UserEditInfo(
      {Key key, this.mbid, this.loginname, this.loginmobile, this.pictname})
      : super(key: key);

  @override
  UserEditInfoState createState() => UserEditInfoState();
}

class UserEditInfoState extends State<UserEditInfo> {
  String mbid, loginName, loginMobile;
  double screen;
  ShopModel shopModel;
  ShopRestModel restModel = new ShopRestModel();
  String txtName, txtMobile;
  String _txtName, _txtMobile;
  String _userImage;

  PickedFile _imageFile;
  String gllery = 'N';
  io.File imgFile;
  final imgPicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    _imageFile = null;
    imgFile = null;
    setState(() {
      mbid = widget.mbid;
      _txtName = widget.loginname;
      _txtMobile = widget.loginmobile;
      txtName = _txtName;
      txtMobile = _txtMobile;
      _userImage = widget.pictname;
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildLogo(),
                      SizedBox(width: 5),
                      MyStyle().txtbrandsmall('Food4U'),
                    ],
                  ),
                  buildTitle(),
                  inputName(),
                  inputMobile(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 3, left: 15),
                          width: !kIsWeb ? (screen) : (screen * 0.35),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: screen*0.58,
                                child: (_imageFile == null)
                                    ? Image.network('${MyConstant().domain}/' +
                                        '${MyConstant().memberimagepath}/$_userImage')
                                    : displayImage(),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center, //start
                                children: [
                                  (!kIsWeb) ? galleryPickup() : Container(),
                                  (!kIsWeb) ? photoGraphy() : Container(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        saveButton(),
                      ]),
                ],
              ),
            )));
  }

  Container buildLogo() {
    return Container(
        width: !kIsWeb ? (screen * 0.15) : (screen * 0.08),
        margin: const EdgeInsets.only(top: 3),
        child: MyUtil().showLogo());
  }

  Column buildTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            //margin: const EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment(0, 0),
                  radius: 2.7,
                  colors: <Color>[MyStyle().secondarycolor, Colors.white]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyStyle().txtTH18Dark('แก้ไขข้มูลส่วนตัว'),
              ],
            )),
      ],
    );
  }

  Widget displayImage() {
    if (_imageFile == null) {
      return Text("กรุณาเลือกรูปภาพ");
    } else {
      return Image.file(imgFile, width: 150, height: 150);
    }
  }

  Widget galleryPickup() => Container(
      margin: const EdgeInsets.only(top: 3, left: 3),
      width: 105,
      child: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () async {
          gllery = 'Y';
          var pickedFile = await imgPicker.getImage(
              source: ImageSource.gallery, maxWidth: 200, maxHeight: 200);
          if (pickedFile != null) {
            setState(() {
              _imageFile = pickedFile;
              imgFile = io.File(pickedFile.path);
            });
          }
        },
        label: Text('คลังภาพ',
            style: TextStyle(
              fontFamily: 'thaisanslite',
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            )),
        icon: Icon(Icons.photo, color: Color.fromARGB(255, 147, 250, 84),size: 32),
        splashColor: Colors.blue,
      ));

  Widget photoGraphy() => Container(
        margin: const EdgeInsets.only(top: 25, left: 3),
        width: 105,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () async {
            gllery = 'N';
            takePhoto(ImageSource.camera, 200.0, 200.0); //480.0, 640.0
          },
          label: Text('กล้อง',
              style: TextStyle(
                fontFamily: 'thaisanslite',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              )),
          icon: Icon(Icons.camera,color: Color.fromARGB(255, 60, 212, 250),size: 32),
          splashColor: Colors.blue,
        ),
      );

  Widget saveButton() => Container(
    width: screen * 0.88,
    margin: const EdgeInsets.only(top: 3),
    child: FloatingActionButton.extended(
        backgroundColor: MyStyle().savecolor,
        onPressed: () async {
          if ((txtName?.isEmpty ?? true) || (txtMobile?.isEmpty ?? true)) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                MySnackBar.showSnackBar(
                    "! ชื่อสมาชิก และเบอร์มือถือ\r\nห้ามเป็นช่องว่าง",
                    Icons.contact_phone,
                    strDimiss: 'ลองใหม่'),
              );
          } else {
            if (txtMobile.length != 10) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  MySnackBar.showSnackBar(
                      "! เบอร์มือถือ ไม่ถูกต้อง", Icons.app_blocking_outlined,
                      strDimiss: 'ลองใหม่'),
                );
            } else {
              checkUser();
            }
          }
        },
        label: Text('บันทึกข้อมูล',
            style: TextStyle(
              fontFamily: 'thaisanslite',
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            )),
        icon: Icon(Icons.cloud_done, color: Colors.white),
        splashColor: Colors.cyanAccent[400],
        foregroundColor: Colors.white,
        hoverColor: Color.fromARGB(255, 46, 180, 241),
        focusColor: Colors.red,
      )
  );

  Widget xxxsaveButton() => Container(
      margin: const EdgeInsets.only(top: 3),
      width: screen * 0.9,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: () async {
          if ((txtName?.isEmpty ?? true) || (txtMobile?.isEmpty ?? true)) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                MySnackBar.showSnackBar(
                    "! ชื่อสมาชิก และเบอร์มือถือ\r\nห้ามเป็นช่องว่าง",
                    Icons.contact_phone,
                    strDimiss: 'ลองใหม่'),
              );
          } else {
            if (txtMobile.length != 10) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  MySnackBar.showSnackBar(
                      "! เบอร์มือถือ ไม่ถูกต้อง", Icons.app_blocking_outlined,
                      strDimiss: 'ลองใหม่'),
                );
            } else {
              checkUser();
            }
          }
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: MyStyle().txtTH('บันทึกข้อมูล', Colors.white),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(2)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return Color.fromARGB(255, 46, 180, 241);
              return Color.fromARGB(
                  255, 0, 0, 80); // Use the component's default.
            },
          ),
        ),
      ));

  Future<Null> routeToService() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString('pname', txtName);
        prefs.setString('pmobile', txtMobile);
        mbid = widget.mbid;
        _txtName = prefs.getString(MyConstant().keymbname);
        _txtMobile = prefs.getString(MyConstant().keymoblie);
        //_userImage = ???
        //'$mbid.$_picttype';
        _imageFile = null;
        imgFile = null;
      });
      MaterialPageRoute route = MaterialPageRoute(builder: (context) => Home());
      Navigator.push(context, route);
    } catch (e) {
      //
    }
  }

  Future<Null> checkUser() async {
    String url = '${MyConstant().domain}/${MyConstant().apipath}/' +
        'profileMobile.aspx?mbid=${widget.mbid}&mobile=$txtMobile';

    try {
      Response response = await Dio().get(url);
      if (response.toString().trim() == '') {
        await saveImage();
        await saveData();
        await routeToService();
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            MySnackBar.showSnackBar(
                '! $txtMobile ถูกลงทะเบียนแล้ว', Icons.sick),
          );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          MySnackBar.showSnackBar(
              '!ไม่สามารถติดต่อ Server ได้', Icons.cloud_off),
        );
    }
  }

  Future<Null> saveData() async {
    bool ok = true;
    String _picttype = '';
    if (_imageFile != null) {
      String filePath = (gllery == 'Y')
          ? context.read(imgstate.imageProvider).state
          : _imageFile.path;
      var fn = filePath.split('.');
      _picttype = filePath.split('.')[fn.length - 1];
      //print('**** gllery=$gllery  / filePath=$filePath  _picttype=$_picttype');
    }
    try {
      String url = '${MyConstant().domain}/${MyConstant().apipath}/' +
          'updateMbInfo.aspx?mbid=$mbid&mbname=$txtName';
      if (_picttype != '') url += '&mbpict=$mbid.$_picttype';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String preMobile = prefs.getString(MyConstant().keymoblie);
      if (txtMobile != preMobile) {
        url += '&mobile=$txtMobile';
      }

      Response response = await Dio().get(url);
      if (response.toString() != '') {
        ok = false;
      }
    } catch (ex) {
      ok = false;
    }
    if (ok) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          InfoSnackBar.infoSnackBar('บันทึกข้อมูลเรียบร้อย',
              Icons.sentiment_satisfied_alt), //tackface
        );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          MySnackBar.showSnackBar('!บันทึกข้อมูลไม่สำเร็จ', Icons.sick),
        );
    }
  }

  Future<Null> saveImage() async {
    bool saveImage = true;
    if (_imageFile != null) {
      try {
        //context.read(uploadState).state = STATE.UPLOAD;
        // String filePath = gllery == 'Y'
        //     ? context.read(imgstate.imageProvider).state
        //     : _imageFile.path;

        String filePath = imgFile.path;
        //debugPrint('**** filePath = $filePath');
        var imageUri = await uploadImageMember(mbid, filePath, 'Y');
        if (imageUri != null) {
          //* context.read(uploadState).state = STATE.SUCCESS;
          //* context.read(resultProvider).state = imageUri;
          imageCache.clear();
        } else {
          //context.read(uploadState).state = STATE.ERROR;
          saveImage = false;
        }
      } catch (e) {
        saveImage = false;
      }
    }
    if (!saveImage) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          MySnackBar.showSnackBar('!บันทึกข้อมูล/รูปภาพไม่สำเร็จ', Icons.sick),
        );
    }
  }

  Future<Null> takePhoto(
      ImageSource source, double maxWidth, double maxHeight) async {
    try {
      final pickedFile = await imgPicker.getImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
          imgFile = io.File(pickedFile.path);
          //*** _image = io.File(_imageFile.path);
          //* context.read(imgstate.imageProvider).state = pickedFile.path;
          //* context.read(uploadState).state = STATE.PICKED;
        });
      }
    } catch (e) {
      print("Image picker error " + e);
    }
  }

  Widget inputName() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: screen * 0.9,
            height: 54,
            child: TextFormField(
              initialValue: _txtName,
              onChanged: (value) => txtName = value.trim(),
              decoration: InputDecoration(
                labelStyle: MyStyle().myLabelStyle(),
                labelText: 'ชื่อสมาชิก',
                prefixIcon:
                    Icon(Icons.account_circle, color: MyStyle().darkcolor),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().lightcolor),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().darkcolor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        ],
      );

  Widget inputMobile() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: screen * 0.9,
            height: 54,
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: _txtMobile,
              onChanged: (value) => txtMobile = value.trim(),
              decoration: InputDecoration(
                labelStyle: MyStyle().myLabelStyle(),
                labelText: 'เบอร์มือถือ',
                prefixIcon:
                    Icon(Icons.mobile_friendly, color: MyStyle().darkcolor),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().lightcolor),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().darkcolor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        ],
      );
}
