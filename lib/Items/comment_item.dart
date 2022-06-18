import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/comment_model.dart';
import '../Models/user_model.dart';
import '../data.dart';

class CommentItem extends StatefulWidget {
  CommentItem(
      this.comments, this.changeDownVotes, this.changeUpVotes, this.addComment);

  final UserModel currentUser = Data().currentUser;
  final List<CommentModel> comments;
  final Function changeDownVotes;
  final Function changeUpVotes;
  final Function addComment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.comments.length,
      itemBuilder: (context, index) {
        CommentModel comment = widget.comments[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 3.0,
                spreadRadius: 0.0,
                offset: Offset(
                  0.0,
                  1.0,
                ),
              ),
            ],
          ),
          child: Column(children: [
            ListTile(
              horizontalTitleGap: 5,
              leading: const Icon(
                Icons.account_circle_rounded,
                size: 35,
                color: Colors.black54,
              ),
              title: Text(
                comment.user.username +
                    ' . ' +
                    DateFormat('yyyy-MM-dd – kk:mm').format(comment.date),
                style: const TextStyle(fontSize: 14, color: Colors.black45),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(comment.comment,
                        style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(Icons.reply_rounded, size: 20),
                        onPressed: () {
                          widget.addComment(comment.replies);
                        },
                      ),
                      Text(
                        "reply",
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: comment.upvotes.contains(widget.currentUser)
                        ? const Icon(Icons.arrow_upward,
                            color: Colors.deepOrange, size: 20)
                        : const Icon(Icons.arrow_upward,
                            color: Colors.black, size: 20),
                    onPressed: () {
                      widget.changeUpVotes(comment);
                    },
                  ),
                  Text((comment.upvotes.length - comment.downvotes.length)
                      .toString()),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: comment.downvotes.contains(widget.currentUser)
                        ? const Icon(Icons.arrow_downward,
                            color: Colors.purple, size: 20)
                        : const Icon(Icons.arrow_downward,
                            color: Colors.black, size: 20),
                    onPressed: () {
                      widget.changeDownVotes(comment);
                    },
                  ),
                ],
              ),
            ]),
            // (comment.replies != null && comment.replies.isNotEmpty)
            //     ? Column(
            //         children: [
            //           Divider(
            //             color: Colors.grey,
            //           ),
            //           CommentItem(
            //             comment.replies,
            //             widget.changeDownVotes,
            //             widget.changeUpVotes,
            //           ),
            //         ],
            //       )
            //     : Container(),
          ]),
        );
      },
    );
  }
}
