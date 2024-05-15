import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Email List',
      home: EmailListScreen(),
    );
  }
}

final TextEditingController _searchController = TextEditingController();

class EmailListScreen extends StatelessWidget {
  const EmailListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          width: 190,
          child: TextFormField(
              
              controller: _searchController ,
              decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 22,
                ),
                border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        gapPadding: 6,
                      ),
              ),
            ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Mail',
            onPressed: () {},
          ),
          
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.create),
            tooltip: 'Compose',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Compose',
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'IITK Mail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inbox),
              title: const Text('Inbox'),
              onTap: () {
                // Handle inbox tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: const Text('Sent'),
              onTap: () {
                // Handle sent tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.drafts),
              title: const Text('Drafts'),
              onTap: () {
                // Handle drafts tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text('Compose'),
              onTap: () {
                // Handle compose tap
              },
            ),
          ],
        ),
      ),
      body: EmailList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        tooltip: 'Compose',
        icon: const Icon(Icons.create),
        label: const Text('Compose'),
      ),
    );
  }
}

class EmailList extends StatelessWidget {
  EmailList({super.key});

  final List<Map<String, String>> emails = [
    {
      'subject': 'Newsletter',
      'from': 'newsletter@example.com',
      'date': '2024-04-10',
    },
    {
      'subject': 'Upcoming Deadline',
      'from': 'reminder@example.com',
      'date': '2024-04-11',
    },
    {
      'subject': 'Customer Feedback',
      'from': 'feedback@example.com',
      'date': '2024-04-12',
    },
    {
      'subject': 'Customer Feedback',
      'from': 'feedback@example.com',
      'date': '2024-04-12',
    },
    {
      'subject': 'Customer Feedback',
      'from': 'feedback@example.com',
      'date': '2024-04-12',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: emails.length,
      itemBuilder: (context, index) {
        final email = emails[index];
        return Card(
          margin: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(email['subject'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('From: ${email['from']}'),
                Text(email['date'] ?? ''),
              ],
            ),
          ),
        );
      },
    );
  }
}
