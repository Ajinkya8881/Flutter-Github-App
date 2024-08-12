import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GitHub Repos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GitHubRepos(),
    );
  }
}

class GitHubRepos extends StatefulWidget {
  @override
  _GitHubReposState createState() => _GitHubReposState();
}

class _GitHubReposState extends State<GitHubRepos> {
  List repos = [];
  Map<String, String> lastCommits = {};

  @override
  void initState() {
    super.initState();
    fetchRepos();
  }

  void fetchRepos() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.github.com/users/freeCodeCamp/repos'),
      );
      if (response.statusCode == 200) {
        setState(() {
          repos = json.decode(response.body);
        });
        fetchLastCommits();
      } else {
        print('Failed to load repositories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching repositories: $e');
    }
  }

  void fetchLastCommits() async {
    for (var repo in repos) {
      try {
        final response = await http.get(
          Uri.parse('https://api.github.com/repos/freeCodeCamp/${repo['name']}/commits'),
        );
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            setState(() {
              lastCommits[repo['name']] = jsonData[0]['commit']['message'];
            });
          }
        } else {
          print('Failed to load commits: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching commits: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Repos'),
      ),
      body: ListView.builder(
        itemCount: repos.length,
        itemBuilder: (context, index) {
          String repoName = repos[index]['name'];
          return ListTile(
            title: Text(repoName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(repos[index]['description'] ?? 'No description'),
                SizedBox(height: 5),
                Text('Last Commit: ${lastCommits[repoName] ?? 'Loading...'}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
