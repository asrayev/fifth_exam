import 'package:fifth_exam/data/models/users_model.dart';
import '../service/api_service/api_service.dart';

class UserRepository {
  UserRepository({required ApiService apiService}): _apiService = apiService;
  final ApiService _apiService;

  Future<List<UsersModel>?> getAllUserDio()=>_apiService.getAllUsers();
}