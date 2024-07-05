import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/screens/post_detail/post_detail_view_model.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late final _viewModel = context.read<PostDetailViewModel>();
  @override
  void initState() {
    super.initState();
    _viewModel.getPostDetailById(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.postDetail.appBarTitle)),
      body: Consumer<PostDetailViewModel>(
        builder: (context, viewModel, _) {
          return SingleChildScrollView(
            child: Html(data: viewModel.html),
          );
        },
      ),
    );
  }
}
