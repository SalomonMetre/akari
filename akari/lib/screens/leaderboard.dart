// ignore_for_file: library_private_types_in_public_api

import 'package:akari/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:akari/models/auth_model.dart';
import 'package:akari/models/db_model.dart';

class LeaderboardPage extends StatefulWidget {
  final String difficulty;
  final int gameNo;

  const LeaderboardPage({super.key, required this.difficulty, required this.gameNo});

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<Map<String, dynamic>> leaderboard = [];

  @override
  void initState() {
    super.initState();
    fetchLeaderboardData();
  }

  Future<void> fetchLeaderboardData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await DbModel.instance.getAllDataWhereConditions(
        collectionName: "unlocked_games",
        conditions: {
          "difficulty": widget.difficulty,
          "game_no": widget.gameNo,
        },
      );

      List<Map<String, dynamic>> fetchedData = snapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        leaderboard = fetchedData;
      });
    } catch (e) {
      print("Error fetching leaderboard data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = Auth().firebaseAuthInstance.currentUser!.email!;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        centerTitle: true,
        backgroundColor: AppColors.blue1,
        title: const Text('Leaderboard'),
      ),
      body: leaderboard.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: leaderboard.length,
              itemBuilder: (context, index) {
                final entry = leaderboard[index];
                final isCurrentUser = entry['user_email'] == userEmail;

                return ListTile(
                  leading: const Icon(Icons.gamepad, color: AppColors.yellow,),
                  tileColor: isCurrentUser ? const Color.fromARGB(255, 0, 133, 88) : AppColors.blue1,
                  title: Text(
                    entry['user_email'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text('Score: ${entry['score']} seconds', style: const TextStyle(color: Colors.yellow),),
                );
              },
            ),
    );
  }
}
