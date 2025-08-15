import 'package:chat_app/views/avatar_with_fallback.dart';
import 'package:chat_app/views/file_message_box.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String username;
  final String text;
  final String time;
  final String avatarUrl;
  final bool showHeader; // show avatar + username + time
  final bool isMe;
  final bool isFile;
  final String? filename;
  final String? filesize;

  const MessageBox({
    super.key,
    required this.username,
    required this.text,
    required this.time,
    required this.avatarUrl,
    this.showHeader = true,
    this.isMe = false,
    this.isFile = false,
    this.filename,
    this.filesize,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width * 0.4;

    // Measure text width
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 15, height: 1.4),
      ),
      textDirection: TextDirection.ltr,
      // maxLines: null,
    )..layout(maxWidth: maxWidth);

    double textWidth = textPainter.width + 100; // + padding inside bubble

    return Padding(
      padding: EdgeInsets.only(
        top: showHeader ? 8 : 2,
        left: isMe
            ? showHeader
                  ? 60
                  : 6
            : showHeader
            ? 12
            : 6,
        right: isMe
            ? showHeader
                  ? 12
                  : 6
            : showHeader
            ? 60
            : 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe)
            // Avatar column
            Padding(
              padding: EdgeInsets.only(right: showHeader ? 16 : 12),
              child: showHeader
                  ? AvatarWithFallback(
                      avatarUrl: avatarUrl,
                      name: username,
                      radius: 18,
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Row(
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: time.length == 8 ? 6 : 12),
                          Expanded(
                            child: isFile
                                ? Column(
                                    children: [
                                      FileMessageBox(
                                        fileName: filename!,
                                        fileSize: filesize!,
                                      ),
                                      Text(
                                        text,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    text,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      height: 1.4,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ), //SizedBox(width: 36),
            ),

          // Message body
          if (showHeader)
            Expanded(
              child: Column(
                crossAxisAlignment: isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: isMe
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      // if (!isMe)
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 0.358,
                    ),
                    child: isFile
                        ? Column(
                            children: [
                              FileMessageBox(
                                fileName: filename!,
                                fileSize: filesize!,
                              ),
                              Text(
                                text,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            text,
                            style: const TextStyle(fontSize: 15, height: 1.4),
                          ),
                  ),
                ],
              ),
            ),

          // // Avatar for "me" on the right
          // if (isMe && showHeader)
          //   Padding(
          //     padding: const EdgeInsets.only(left: 16),
          //     child: AvatarWithFallback(
          //       avatarUrl: avatarUrl,
          //       name: username,
          //       radius: 18,
          //     ),
          //   ),
          if (isMe)
            // Avatar column
            Padding(
              padding: EdgeInsets.only(left: showHeader ? 16 : 12),
              child: showHeader
                  ? AvatarWithFallback(
                      avatarUrl: avatarUrl,
                      name: username,
                      radius: 18,
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: textWidth > maxWidth ? maxWidth : textWidth,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: isFile
                                ? Column(
                                    children: [
                                      FileMessageBox(
                                        fileName: filename!,
                                        fileSize: filesize!,
                                      ),
                                      Text(
                                        text,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    text,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      height: 1.4,
                                    ),
                                  ),
                          ),
                          SizedBox(width: time.length == 8 ? 6 : 12),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ), //SizedBox(width: 36),
            ),
        ],
      ),
    );
  }
}
