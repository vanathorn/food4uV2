import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:food4u/model/foodtype_model.dart';
import 'package:food4u/model/menu_model.dart';
import 'package:food4u/model/shop_model.dart';
import 'package:food4u/screen/menu/home_screen.dart';
import 'package:food4u/screen/menu/main_rider.dart';
import 'package:food4u/screen/menu/main_shop.dart';
import 'package:food4u/screen/menu/main_user.dart';
import 'package:food4u/screen/menu/menu_screen.dart';
import 'package:food4u/state/food_state.dart';
import 'package:food4u/view/food_view_imp.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiHome extends StatefulWidget{
  @override
  _MultiHomeState createState() => _MultiHomeState();
}

class _MultiHomeState extends State<MultiHome> {
  //#
  List<MenuModel> listChooseType = List<MenuModel>.empty(growable: true);
  List<FoodTypeModel> foodTypeModels = List<FoodTypeModel>.empty(growable: true);
  final viewModels = FoodViewImp();
  final foodStateController = Get.put(FoodStateController());

  String webPath;
  String loginName, chooseCode, loginccode;
  String nameofShop, shopImage;
  double screen;
  ShopModel shopModel = new ShopModel();
  bool loadding = true;
  bool havemenu = true;

  final drawerController = ZoomDrawerController();
  //#

  @override
  void initState() {
    super.initState();  
    findUser();  
  }  

  Future<Null> findUser() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    setState(() {
      loginccode = prefer.getString('pccode');
      loginName = prefer.getString('pname');
      chooseCode = prefer.getString('pchooseCode'); 
      var ctype = chooseCode.split("|");
      String menuName='', menuImage='';
      Widget menuWidget;
      for(int i=0; i<ctype.length; i++){
        if (ctype[i]=='U'){
          menuName = 'เมนููลูกค้า';
          menuImage = 'user.jpg';
          menuWidget = MainUser();
        }else if (ctype[i]=='S'){
          menuName = 'เมนููร้านค้า';
          menuImage = 'shop.png';
          menuWidget= MainShop();
        }else if (ctype[i]=='R'){
          menuName = 'เมนููผู้ส่งสินค้า';
          menuImage = 'rider.jpg';
          menuWidget = MainRider();
        }
        listChooseType.add(MenuModel(ctype[i], menuName, menuImage, menuWidget));
      }  
      readShopName(loginccode);
    });
  }

  Future<Null> readShopName(String xccode) async {
    setState(() {
      shopModel.shoppict = 'userlogo.png';
      shopModel.thainame = loginName;
    });
      /*
      if (xccode !=''){
        String url = '${MyConstant().domain}/${MyConstant().apipath}/checkShop.aspx?ccode='+'$xccode';
        await Dio().get(url).then((value) {
          var result = json.decode(value.data);
          for (var map in result) {
            setState(() {
              ShopModel sModel = ShopModel.fromJson(map);
              shopModel.shoppict = sModel.shoppict;
              shopModel.thainame = sModel.thainame;
            });
          }      
        });
      }else{
        setState(() {
          shopModel.shoppict = 'userlogo.png';
          shopModel.thainame = loginName;
        });
      }
      */
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
          controller: drawerController, 
          //mainScreen: HomeScreen(drawerController),        
          //menuScreen: MenuScreen(drawerController, shopModel, listChooseType),          
          menuScreen: HomeScreen(drawerController),        
          mainScreen: MenuScreen(drawerController, shopModel, listChooseType),          
          borderRadius: 24.0,
          showShadow: true,
          angle: 0.0,
          backgroundColor: Colors.green[300],
          slideWidth: MediaQuery.of(context).size.width*(ZoomDrawer.isRTL() ? 0.4 : 0.65),
          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.bounceIn,
      ),
    );
  }
}