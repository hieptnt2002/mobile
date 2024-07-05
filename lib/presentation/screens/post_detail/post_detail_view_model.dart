import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/repository/post_repository.dart';

class PostDetailViewModel extends BaseViewModel {
  final _postRepository = locator.get<PostRepository>();
  var html = '';

  Future<void> getPostDetailById(String id) async {
    handleTask(
      onRequest: () => _postRepository.getPostDetailById(id),
      onSuccess: (data) {
        html = data;
        notifyListeners();
      },
    );
  }
}
