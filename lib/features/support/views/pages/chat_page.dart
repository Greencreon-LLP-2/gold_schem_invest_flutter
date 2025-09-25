// features/support/views/pages/chat_page.dart
import 'dart:async'; // Import the async library for Timer
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/features/support/models/ticket_comment_model.dart';
import 'package:rajakumari_scheme/features/support/service/chat_messages_service.dart';
import 'package:rajakumari_scheme/features/support/service/ticket_replay_service.dart';

class ChatPage extends HookWidget {
  final String ticketId;
  final String userId;

  const ChatPage({super.key, required this.ticketId, required this.userId});

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();
    final comments = useState<List<TicketComment>>([]);
    final errorMessage = useState<String?>(null);
    final timer = useRef<Timer?>(null);
    final isLoading = useState<bool>(true);
    final selectedImage = useState<File?>(null);
    final scrollController = useScrollController();

    // Function to fetch comments
    void fetchComments() {
      final chatService = ChatMessagesService();
      chatService
          .fetchTicketComments(ticketId)
          .then((response) {
            isLoading.value = false;
            if (response.status) {
              if (response.data == "Data not found") {
                errorMessage.value = "No messages yet. Start a conversation!";
              } else {
                comments.value = response.data;
                errorMessage.value = null;
                // Scroll to bottom when new messages arrive
                if (scrollController.hasClients) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                }
              }
            } else {
              errorMessage.value = "Start a conversation with our support team";
            }
          })
          .catchError((error) {
            isLoading.value = false;
            errorMessage.value =
                "Couldn't connect to server. Please try again.";
          });
    }

    // Fetch comments when the widget is built
    useEffect(() {
      fetchComments();
      timer.value = Timer.periodic(const Duration(seconds: 3), (Timer t) {
        fetchComments();
      });

      return () {
        timer.value?.cancel();
      };
    }, [ticketId]);

    // Add image picking functions
    Future<void> uploadImage(
      File imageFile,
      String imageUrl,
      String userId,
    ) async {
      var url = Uri.parse('${ApiSecrets.baseUrl}/upload-ticket-image.php');
      try {
        var request = http.MultipartRequest('POST', url);
        final multipartFile = await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          filename: imageUrl,
        );
        request.files.add(multipartFile);
        var response = await request.send();
        if (response.statusCode == 200) {
          // Send the message with image parameter
          TicketReplayService().sendTicketReply(
            userId,
            'Sent an image', // message
            ticketId,
            imageUrl, // image parameter
          );
        }
      } catch (e) {
        log("Error uploading image: $e");
      }
    }

    Future<void> pickImage(BuildContext context, ImageSource source) async {
      try {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(
          source: source,
          imageQuality: 70,
        );

        if (pickedFile != null) {
          selectedImage.value = File(pickedFile.path);

          // Generate unique filename
          final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
          final imageName = '$timestamp${pickedFile.path.split('/').last}';

          // Upload image
          await uploadImage(selectedImage.value!, imageName, userId);
        }
      } catch (e) {
      
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to pick image'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    void showImagePickerOptions(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                const SizedBox(height: 10),
                const Text(
                  '            *Select one image at a time',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(context, ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Take a Photo'),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(context, ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Chat'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Ticket Information'),
                      content: Text('Ticket ID: $ticketId'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // Chat background pattern
          color: Colors.grey[100],
          image: DecorationImage(
            image: const AssetImage('assets/images/chat_bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            // Date header
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  DateTime.now().toString().substring(0, 10),
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ),

            // Chat messages area
            Expanded(
              child:
                  isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : errorMessage.value != null
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              errorMessage.value!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: comments.value.length,
                        itemBuilder: (context, index) {
                          final comment = comments.value[index];
                          final isCurrentUser = comment.userId == userId;

                          // Show time header if needed
                          bool showTimeHeader = false;
                          if (index == 0
                          // ||
                          //     comments.value[index].createdOn
                          //             .split(' ')[1]
                          //             .substring(0, 5) !=
                          //         comments.value[index - 1].createdOn
                          //             .split(' ')[1]
                          //             .substring(0, 5)
                          ) {
                            showTimeHeader = true;
                          }

                          return Column(
                            children: [
                              if (showTimeHeader)
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 4),
                                  child: SizedBox(),
                                  // Text(
                                  //   comment.createdOn
                                  //       .split(' ')[1]
                                  //       .substring(0, 5),
                                  //   style: TextStyle(
                                  //     fontSize: 12,
                                  //     color: Colors.grey[600],
                                  //   ),
                                  // ),
                                ),
                              Align(
                                alignment:
                                    isCurrentUser
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                        0.75,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isCurrentUser
                                              ? Theme.of(
                                                context,
                                              ).primaryColor.withOpacity(0.9)
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        18,
                                      ).copyWith(
                                        bottomRight:
                                            isCurrentUser
                                                ? const Radius.circular(0)
                                                : null,
                                        bottomLeft:
                                            !isCurrentUser
                                                ? const Radius.circular(0)
                                                : null,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (!isCurrentUser)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 4,
                                            ),
                                            child: Text(
                                              'Support Agent',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).primaryColor,
                                              ),
                                            ),
                                          ),

                                        // Message content
                                        if (comment.image != null &&
                                            comment.image!.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              // Show full image when tapped
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (context) => Dialog(
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            '${ApiSecrets.imageBaseUrl}${comment.image}',
                                                        fit: BoxFit.contain,
                                                        placeholder:
                                                            (
                                                              context,
                                                              url,
                                                            ) => const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                        errorWidget:
                                                            (
                                                              context,
                                                              url,
                                                              error,
                                                            ) => const Icon(
                                                              Icons.error,
                                                            ),
                                                      ),
                                                    ),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${ApiSecrets.imageBaseUrl}${comment.image}',
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                placeholder:
                                                    (context, url) => Container(
                                                      height: 150,
                                                      color: Colors.grey[200],
                                                      child: const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                          height: 150,
                                                          color:
                                                              Colors.grey[200],
                                                          child: const Icon(
                                                            Icons.error,
                                                          ),
                                                        ),
                                              ),
                                            ),
                                          )
                                        else
                                          isCurrentUser
                                              ? Text(
                                                comment.comment,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              )
                                              : Html(
                                                data: comment.comment,
                                                style: {
                                                  "body": Style(
                                                    margin: Margins.zero,
                                                    padding: HtmlPaddings.zero,
                                                    fontSize: FontSize(15),
                                                    color: Colors.black87,
                                                  ),
                                                },
                                              ),

                                        // Message timestamp
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                isCurrentUser
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                            children: [
                                              // Text(
                                              //   comment.createdOn
                                              //       .split(' ')[1]
                                              //       .substring(0, 5),
                                              //   style: TextStyle(
                                              //     fontSize: 11,
                                              //     color: isCurrentUser
                                              //         ? Colors.white70
                                              //         : Colors.black45,
                                              //   ),
                                              // ),
                                              if (isCurrentUser) ...[
                                                const SizedBox(width: 4),
                                                const Icon(
                                                  Icons.done_all,
                                                  size: 14,
                                                  color: Colors.white70,
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
            ),

            // Message input area
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_photo_alternate),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => showImagePickerOptions(context),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: messageController,
                        maxLines: 5,
                        minLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.white,
                      onPressed: () {
                        final String message = messageController.text.trim();
                        if (message.isNotEmpty) {
                          TicketReplayService().sendTicketReply(
                            userId,
                            message,
                            ticketId,
                            '', // no image for text messages
                          );
                          messageController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
