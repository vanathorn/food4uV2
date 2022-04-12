import 'package:flutter/material.dart';
import 'package:food4u/model/shoprest_model.dart';
import 'package:food4u/screen/custom/advice_food_screen.dart';
import 'package:food4u/screen/custom/category_screen.dart';
import 'package:food4u/state/main_state.dart';
import 'package:food4u/widget/shop/about_shop.dart';
import 'package:food4u/widget/appbar_withcart.dart';
import 'package:get/get.dart';

class UerRestFood extends StatefulWidget {
  final ShopRestModel restModel;
  UerRestFood({Key key, this.restModel}) : super(key: key);
  @override
  _UerRestFoodState createState() => _UerRestFoodState();
}

class _UerRestFoodState extends State<UerRestFood> {
  final MainStateController  mainStateController =  Get.find(); //vtr mainController
  ShopRestModel restModel;
  List<Widget> listWidgets;
  int indexPage = 0;

  @override
  void initState() {
    super.initState();
    restModel = widget.restModel;
    listWidgets = [AboutShop( restModel:restModel), AdviceFoodScreen( restModel: restModel,) , CategoryScreen( restModel:restModel)];
  }

  BottomNavigationBarItem aboutShopNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.location_pin),
      label: ('ที่อยู่ร้านค้า'),     
    );
  }

  BottomNavigationBarItem adviceMenuNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.thumb_up),      
      label: ('สินค้าแนะนำ'),
    );
  }

  BottomNavigationBarItem showMenuFoodNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.auto_stories),      
      label: ('รายการสินค้า'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithCartButton(title: 'ร้าน ${mainStateController.selectedRestaurant.value.thainame}', subtitle: '',),
      body: listWidgets[indexPage],
      bottomNavigationBar: showBottonNavBar(),
    );
  }

  BottomNavigationBar showBottonNavBar() =>
    BottomNavigationBar(
      backgroundColor: Colors.amber[900],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      selectedFontSize: 18,
      unselectedFontSize: 15,
      currentIndex: indexPage,
      onTap: (value){
      setState(() {
        indexPage = value;
      });
    },
    items: <BottomNavigationBarItem>[
      aboutShopNav(),
      adviceMenuNav(),
      showMenuFoodNav(),
    ]
  );
}
