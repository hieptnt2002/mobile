import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/data/models/post.dart';
import 'package:make_appointment_app/repository/post_repository.dart';

class PostViewModel extends BaseViewModel {
  final _postRepository = locator.get<PostRepository>();
  var _currentPage = 1;
  final _pageSize = 10;

  List<Post> allPost = [];
  bool hasMoreData = true;
  PostViewModel() {
    getPosts();
  }

  Future<void> getPosts() async {
    _currentPage = 1;
    handleTask(
      onRequest: () => _postRepository.getPosts(pageIndex: _currentPage),
      onSuccess: (data) {
        allPost = data;
        checkHasMoreData(data);
        notifyListeners();
      },
    );
  }

  Future<void> loadMore() async {
    if (!hasMoreData) return;
    _currentPage++;
    handleTask(
      onRequest: () => _postRepository.getPosts(pageIndex: _currentPage),
      onSuccess: (data) {
        allPost.addAll(data);
        checkHasMoreData(data);
        notifyListeners();
      },
    );
  }

  void checkHasMoreData(List<Post> posts) {
    if (posts.length < _pageSize) {
      hasMoreData = false;
    } else {
      hasMoreData = true;
    }
  }
}
