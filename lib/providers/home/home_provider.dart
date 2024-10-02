import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  bool searchPerformed = false;
  List<Map<String, dynamic>> searchResults = [];
  final List<Map<String, dynamic>> allData = [];

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();
    try {
      DataSnapshot snapshot = await _dbRef.get();
      if (snapshot.value != null) {
        List<dynamic> data = snapshot.value as List<dynamic>;
        allData.clear();
        data.forEach((element) {
          allData.add(Map<String, dynamic>.from(element));
        });
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    searchPerformed = true;
    List<String> queryParts = query.toLowerCase().split(' ');
    searchResults = allData.where((user) {
      final firstName = user['first_name']?.toString().toLowerCase() ?? '';
      final lastName = user['last_name']?.toString().toLowerCase() ?? '';
      return queryParts
          .every((part) => firstName.contains(part) || lastName.contains(part));
    }).toList();
    notifyListeners();
  }
}
