import 'dart:convert';

import 'package:make_appointment_app/base/repository/base_repository.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/models/post.dart';
import 'package:make_appointment_app/data/remote/post_api.dart';

class PostRepository extends BaseRepository {
  final PostApi _postApi;
  PostRepository({required PostApi postApi}) : _postApi = postApi;

  Future<DataResult<List<Post>>> getPosts({int pageIndex = 0}) async {
    return resultWithFuture(
      future: () async {
        final json = await _postApi.getPosts(pageIndex: pageIndex);
        return (jsonDecode(json) as List<dynamic>)
            .map((e) => Post.fromMap(e))
            .toList();
      },
    );
  }

  Future<DataResult<String>> getPostDetailById(String id) async {
    return resultWithFuture(
      future: () async {
        final json = await _postApi.getPostDetailById(id);
        return json;
      },
    );
  }
}
