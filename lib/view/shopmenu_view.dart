import 'package:food4u/model/shopmenu_model.dart';

abstract class ShopMenuView{
  Future<List<ShopMenuModel>> displayShopMenuList();
}