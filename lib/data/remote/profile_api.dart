import 'package:make_appointment_app/base/data/remote/api.dart';

class ProfileApi {
  Future<dynamic> updateUser(Map<String, dynamic> data) async {
    return Api.request(httpMethod: HttpMethod.put, url: '/user', body: data);
  }

  Future<dynamic> getUser() async {
    return Api.request(httpMethod: HttpMethod.get, url: '/user');
  }

  Future<dynamic> getAllAddresses() async {
    return Api.request(httpMethod: HttpMethod.get, url: '/user/addresses');
  }

  Future<dynamic> getPrefectures() async {
    return Api.request(httpMethod: HttpMethod.get, url: '/prefectures');
  }

  Future<dynamic> createAddress(Map<String, dynamic> data) async {
    return Api.request(
      httpMethod: HttpMethod.post,
      url: '/user/addresses',
      body: data,
    );
  }

  Future<dynamic> updateAddress(int id, Map<String, dynamic> data) async {
    return Api.request(
      httpMethod: HttpMethod.put,
      url: '/user/addresses/$id',
      body: data,
    );
  }

  Future<dynamic> deleteAddress(int id) async {
    return Api.request(
      httpMethod: HttpMethod.delete,
      url: '/user/addresses/$id',
    );
  }

  Future<dynamic> setDefaultAddress(int id) async {
    return Api.request(
      httpMethod: HttpMethod.put,
      url: '/user/addresses/$id/default-setting',
    );
  }
}
