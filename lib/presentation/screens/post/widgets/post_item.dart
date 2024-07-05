import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:make_appointment_app/data/models/post.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(),
            const SizedBox(width: 8),
            _buildTitle(),
          ],
        ),
        const SizedBox(height: 12),
        _buildContent(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: _buildTimeAndAuthor(context),
        ),
        _buildCategory(),
      ],
    );
  }

  Widget _buildThumbnail() {
    return SizedBox(
      width: 100,
      height: 65,
      child: Image.network(
        post.thumbnail,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Text(
        post.title,
        style: AppTextStyle.headingXXSmall,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildContent() {
    return Text(
      post.content,
      style: AppTextStyle.bodyMedium,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTimeAndAuthor(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: DateFormat('dd/MM/yyyy').format(post.createdAt)),
          const TextSpan(text: '          '),
          TextSpan(text: '${context.t.post.supervisor}: ${post.author}'),
        ],
        style: AppTextStyle.darkGrayBodyXSmall,
      ),
    );
  }

  Widget _buildCategory() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.cyan),
        ),
        child: Text(post.category, style: AppTextStyle.cyanBodySmall),
      ),
    );
  }
}
