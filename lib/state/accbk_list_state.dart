import 'package:food4u/model/shoprest_model.dart';
import 'package:get/get.dart';

class AccbkListStateController  extends GetxController{
  var selectedAccount = ShopRestModel(
    restaurantId: '',
    ccode: '',   
    account: [], 
  ).obs;
}