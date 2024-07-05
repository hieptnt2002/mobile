import 'package:flutter/material.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/post/post_view_model.dart';
import 'package:make_appointment_app/presentation/screens/post/widgets/post_item.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late final _viewModel = context.read<PostViewModel>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _viewModel.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.post.appBarTitle)),
      body: Consumer<PostViewModel>(
        builder: (context, postViewModel, _) {
          final posts = postViewModel.allPost;
          return RefreshIndicator(
            onRefresh: _viewModel.getPosts,
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(Routes.postDetail, arguments: post.id),
                  child: PostItem(post: post),
                );
              },
              separatorBuilder: (_, __) {
                return const Divider(thickness: 1, indent: 20, height: 60);
              },
            ),
          );
        },
      ),
    );
  }
}
