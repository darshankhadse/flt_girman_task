import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final VoidCallback onFetchDetails;

  const UserCard({super.key, required this.user, required this.onFetchDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user['image_url'] ?? ''),
              radius: 30,
            ),
            const SizedBox(height: 16),
            Text(
              '${user['first_name']} ${user['last_name']}',
              style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_pin,
                  size: 16,
                  color: Color(0xFF425763),
                ),
                const SizedBox(width: 6),
                Text(user['city'],
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF425763))),
              ],
            ),
            const SizedBox(height: 27),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone_rounded),
                        const SizedBox(width: 4),
                        Text(
                          user['contact_number'],
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 2.0, left: 2.0),
                      child: Text(
                        'Available on phone',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                  onPressed: onFetchDetails,
                  child: const Text('Fetch Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
