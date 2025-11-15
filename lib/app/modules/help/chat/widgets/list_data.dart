import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/widgets/chat_video_widget.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/widgets/full_screen.dart';

class ListDataChatWidget extends StatelessWidget {
  final ChatModel data;
  const ListDataChatWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(data.date), // Use the date directly
          ),
        ),
        // Display each chat message
        ListView.builder(
          shrinkWrap: true,
          physics:
              NeverScrollableScrollPhysics(), // Disable scrolling inside to keep everything in the parent
          itemCount: data.chat.length,
          itemBuilder: (context, messageIndex) {
            Chat chat =
                data.chat[messageIndex]; // Access the Chat object directly
            return Container(
              child: Align(
                alignment: chat.me
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: GestureDetector(
                  onLongPressStart: (details) {
                    // _showDropdownMenu(context, details.globalPosition, chat.id);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: chat.me ? mainColor : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: chat.message != null
                            ? Text(
                                chat.message ?? '',
                                softWrap: true,
                                style: GoogleFonts.montserrat(
                                  color: chat.me
                                      ? Colors.white
                                      : textPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : chat.is_image == true
                            ? GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FullscreenMediaWidget(
                                        url: chat.file!,
                                        mediaType: MediaType.image,
                                      ),
                                    ),
                                  ),
                                },
                                child: Image.network(
                                  chat.file ?? '',
                                  width: size.width / 2,
                                  height: size.height / 2,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Text('Failed to load image'),
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                ),
                              )
                            : ChatVideoWidget(videoUrl: chat.file!),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          DateFormat("HH:mm").format(chat.createdAt),
                          textAlign: TextAlign.right,
                          style: GoogleFonts.montserrat(
                            color: textPrimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
