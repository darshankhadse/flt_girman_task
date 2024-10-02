import 'package:flutter/material.dart';

void showUserDetailsDialog(BuildContext context, Map<String, dynamic> user) {
  var textStyle = const TextStyle(fontWeight: FontWeight.w500);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20, right: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fetch Details',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close, size: 28),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Here are the details of the following employee.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Text('Name: ${user['first_name']} ${user['last_name']}',
                      style: textStyle),
                  Text('Location: ${user['city']}', style: textStyle),
                  Text('Contact Number: ${user['contact_number']}',
                      style: textStyle),
                  const SizedBox(height: 6),
                  Text('Profile Image:', style: textStyle),
                  const SizedBox(height: 10),
                  SizedBox(height: 200,child: Image.network(user['image_url'])),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
