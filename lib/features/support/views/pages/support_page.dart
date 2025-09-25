// // features/support/views/pages/support_page.dart
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:rajakumari_scheme/core/services/auth_state_service.dart';
// import 'package:rajakumari_scheme/features/support/service/add_new_ticket_service.dart';
// import 'package:rajakumari_scheme/features/support/service/support_ticket_list.dart';
// import 'package:rajakumari_scheme/features/support/service/ticket_service.dart';
// import 'package:rajakumari_scheme/features/support/views/pages/chat_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SupportPage extends ConsumerStatefulWidget {
//   const SupportPage({super.key});

//   @override
//   ConsumerState<SupportPage> createState() => _SupportPageState();
// }

// class _SupportPageState extends ConsumerState<SupportPage> {
//   Timer? _timer; // Timer to fetch new tickets
//   List<TicketModel> _tickets = []; // State variable to hold tickets
//   String? userId;

// Future<void> loaduserid () async {

//              userId = await SharedPreferences.getInstance().then(
//               (value) => value.getString('user_id'),
//             ); ;

// }





//   @override
//   void initState() {
//     super.initState();
// loaduserid();
//     _fetchTickets(); // Initial fetch
//     _startFetchingTickets(); // Start fetching tickets periodically
//   }

//   void _startFetchingTickets() {
//     _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
//       _fetchTickets(); // Fetch tickets every 5 seconds
//     });
//   }

//   Future<void> _fetchTickets() async {
//     // Call the service to fetch tickets
//     final tickets = await TicketService().fetchOpenTickets(userId!);
//     setState(() {
//       _tickets = tickets; // Update the state with fetched tickets
//     });
//   }



//   @override
//   void dispose() {
//     _timer?.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//         title: const Text('Help Center'),
//         elevation: 0,
//         backgroundColor: Theme.of(context).colorScheme.surface,
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           _showAddTicketDialog(context, userId!);
//         },
//         icon: const Icon(Icons.add),
//         label: const Text('New Ticket'),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//       ),
//       body: SafeArea(
//         child: _tickets.isEmpty
//             ? _buildEmptyState(context, userId!)
//             : _buildTicketsList(context, userId!),
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context, String userId) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             "assets/icons/empty_tickets.svg",
//             height: 150,
//             width: 150,
//             placeholderBuilder: (context) => Icon(
//               Icons.support_agent,
//               size: 150,
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'No Support Tickets',
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Create a new ticket to get help from our support team',
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   color: Theme.of(context).colorScheme.onSurfaceVariant,
//                 ),
//           ),
//           const SizedBox(height: 32),
//           ElevatedButton.icon(
//             onPressed: () {
//               _showAddTicketDialog(context, userId);
//             },
//             icon: const Icon(Icons.add),
//             label: const Text('Create New Ticket'),
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTicketsList(BuildContext context, String userId) {
//     return RefreshIndicator(
//       onRefresh: _fetchTickets,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Your Support Tickets',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _tickets.length,
//                 itemBuilder: (context, index) {
//                   final ticket = _tickets[index];
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Theme.of(context).shadowColor.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Material(
//                       borderRadius: BorderRadius.circular(16),
//                       color: 
//                           Theme.of(context).colorScheme.surface,
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(16),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ChatPage(
//                                 ticketId: ticket.id,
//                                 userId: userId,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                       vertical: 4,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: ticket.status == "0"
//                                           ? Colors.red.withOpacity(0.1)
//                                           : Colors.green.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Text(
//                                       ticket.status == "0" ? "Open" : "Closed",
//                                       style: TextStyle(
//                                         color: ticket.status == "0"
//                                             ? Colors.red
//                                             : Colors.green,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                   const Spacer(),
//                                   Text(
//                                     ticket.createdOn,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodySmall
//                                         ?.copyWith(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .onSurfaceVariant,
//                                         ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 ticket.subject,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium
//                                     ?.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 ticket.msg,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium
//                                     ?.copyWith(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .onSurfaceVariant,
//                                     ),
//                               ),
//                               const SizedBox(height: 12),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Icon(
//                                     Icons.arrow_forward,
//                                     size: 16,
//                                     color:
//                                         Theme.of(context).colorScheme.primary,
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     'View Details',
//                                     style: TextStyle(
//                                       color:
//                                           Theme.of(context).colorScheme.primary,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddTicketDialog(BuildContext context, String userId) {
//     final TextEditingController mobileController = TextEditingController();
//     final TextEditingController subjectController = TextEditingController();
//     final TextEditingController messageController = TextEditingController();

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surface,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(24),
//               topRight: Radius.circular(24),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -5),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Create New Support Ticket',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.close),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     'Contact Information',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: mobileController,
//                     decoration: InputDecoration(
//                       labelText: 'Mobile Number',
//                       prefixIcon: const Icon(Icons.phone),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       filled: true,
//                       fillColor: Theme.of(context).colorScheme.surface,
//                     ),
//                     keyboardType: TextInputType.phone,
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     'Ticket Details',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: subjectController,
//                     decoration: InputDecoration(
//                       labelText: 'Subject',
//                       prefixIcon: const Icon(Icons.subject),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       filled: true,
//                       fillColor: Theme.of(context).colorScheme.surface,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       labelText: 'Message',
//                       prefixIcon: const Icon(Icons.message),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       filled: true,
//                       fillColor: Theme.of(context).colorScheme.surface,
//                       alignLabelWithHint: true,
//                     ),
//                     maxLines: 5,
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         // Show loading indicator
//                         showDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           builder: (BuildContext context) {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           },
//                         );

//                         // Call the service to add a new ticket
//                         final addTicketService = AddTicketService();
//                         final success = await addTicketService.addTicket(
//                           userId: userId,
//                           mobile: mobileController.text,
//                           subject: subjectController.text,
//                           message: messageController.text,
//                         );

//                         // Close loading indicator
//                         Navigator.pop(context);

//                         if (success) {
//                           Navigator.pop(context); // Close the dialog
//                           _fetchTickets(); // Refresh the ticket list
//                           // Show a success message
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               behavior: SnackBarBehavior.floating,
//                               backgroundColor: Colors.green,
//                               content: Row(
//                                 children: [
//                                   Icon(Icons.check_circle, color: Colors.white),
//                                   SizedBox(width: 12),
//                                   Text('Ticket submitted successfully!'),
//                                 ],
//                               ),
//                             ),
//                           );
//                         } else {
//                           Navigator.pop(context); // Close the dialog
//                           // Show an error message
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               backgroundColor: Colors.red,
//                               content: Row(
//                                 children: [
//                                   Icon(Icons.error, color: Colors.white),
//                                   SizedBox(width: 12),
//                                   Text(
//                                       'Failed to submit ticket. Please try again.'),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Theme.of(context).colorScheme.primary,
//                         foregroundColor:
//                             Theme.of(context).colorScheme.onPrimary,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Submit Ticket',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
