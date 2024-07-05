import 'package:make_appointment_app/data/models/address.dart';
import 'package:make_appointment_app/base/repository/base_repository.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/models/user.dart';
import 'package:make_appointment_app/data/remote/profile_api.dart';

class ProfileRepository extends BaseRepository {
  final ProfileApi _profileApi;
  ProfileRepository({required ProfileApi profileApi})
      : _profileApi = profileApi;

  Future<DataResult<User>> getUser() async {
    return resultWithFuture(
      future: () async {
        final json = await _profileApi.getUser();
        return User.fromJson(json);
      },
    );
  }

  Future<DataResult<List<Address>>> getAllAddresses() async {
    return resultWithFuture(
      future: () async {
        final json = await _profileApi.getAllAddresses();
        return ((json ?? []) as List).map((e) => Address.fromJson(e)).toList();
      },
    );
  }

  Future<DataResult<List<Prefecture>>> getPrefectures() async {
    return resultWithFuture(
      future: () async {
        final json = await _profileApi.getPrefectures();
        return ((json ?? []) as List)
            .map((e) => Prefecture.fromJson(e))
            .toList();
      },
    );
  }

  Future<DataResult> updateUser(Map<String, dynamic> data) async {
    return resultWithFuture(
      future: () => _profileApi.updateUser(data),
    );
  }

  Future<DataResult> createAddress(Map<String, dynamic> data) async {
    return resultWithFuture(
      future: () => _profileApi.createAddress(data),
    );
  }

  Future<DataResult> updateAddress(int id, Map<String, dynamic> data) async {
    return resultWithFuture(
      future: () => _profileApi.updateAddress(id, data),
    );
  }

  Future<DataResult> deleteAddress(int id) async {
    return resultWithFuture(
      future: () => _profileApi.deleteAddress(id),
    );
  }

  Future<DataResult> setDefaultAddress(int id) async {
    return resultWithFuture(
      future: () => _profileApi.deleteAddress(id),
    );
  }
}
