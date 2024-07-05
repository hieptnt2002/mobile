import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/models/address.dart';
import 'package:make_appointment_app/data/models/user.dart';
import 'package:make_appointment_app/presentation/helper/iterable_extensions.dart';
import 'package:make_appointment_app/repository/profile_repository.dart';

class EditProfileViewModel extends BaseViewModel {
  final _profileRepository = locator.get<ProfileRepository>();
  List<Prefecture> prefectures = [];
  List<Address> allAddresses = [];
  Address? get mainAddress => allAddresses.isEmpty ? null : allAddresses.first;
  Address? get defaultDeliveryAddress =>
      allAddresses.firstWhereOrNull((e) => e.defaultFlg == 1);

  EditProfileViewModel() {
    getAllData();
  }

  Future<void> getAllData() async {
    handleMultiTask(
      requests: [
        getAllAddresses(),
        getPrefectures(),
      ],
      onSuccess: (_) {
        notifyListeners();
      },
    );
  }

  Future<DataResult<List<Prefecture>>> getPrefectures() {
    return handleTaskWithResultReturn(
      showLoading: false,
      showErrorDialog: false,
      onRequest: () => _profileRepository.getPrefectures(),
      onSuccess: (data) {
        prefectures = data;
      },
    );
  }

  Future<DataResult<List<Address>>> getAllAddresses() {
    return handleTaskWithResultReturn(
      showLoading: false,
      showErrorDialog: false,
      onRequest: () => _profileRepository.getAllAddresses(),
      onSuccess: (data) {
        allAddresses = data;
      },
    );
  }

  Future<DataResult> updateUser(User user) {
    return handleTaskWithResultReturn(
      showLoading: false,
      showErrorDialog: false,
      onRequest: () => _profileRepository.updateUser(user.toJson()),
    );
  }

  Future<DataResult> updateMainAddress(Address address) {
    return handleTaskWithResultReturn(
      showLoading: false,
      showErrorDialog: false,
      onRequest: () =>
          _profileRepository.updateAddress(address.id, address.toJson()),
    );
  }

  Future updateProfile(
    User user,
    Address? mainAddress,
    void Function(dynamic)? onSuccess,
  ) async {
    var requests = [updateUser(user)];
    if (mainAddress != null) {
      requests.add(updateMainAddress(mainAddress));
    }
    handleMultiTask(
      requests: requests,
      onSuccess: (data) {
        if (onSuccess != null) {
          onSuccess(data);
        }
      },
    );
  }
}
