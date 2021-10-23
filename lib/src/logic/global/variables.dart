import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news360/src/logic/model/user_models/user_data_model.dart';

RxBool isLoading = false.obs;
Rx<UserResponseModel>? user;
RxString error = ''.obs;
RxBool isPointerAbsorbing = false.obs;
RxBool? selectedLanguage;
final appdata = GetStorage();
bool isDarkMode = false;
