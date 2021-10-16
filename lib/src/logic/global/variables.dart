import 'package:get/get.dart';
import 'package:news360/src/logic/model/user_models/user_data_model.dart';

RxBool isLoading = false.obs;
Rx<UserResponseModel>? user;
RxString error = ''.obs;
