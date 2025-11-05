import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bloc/journal_bloc.dart';
import '../bloc/journal_event.dart';
import '../bloc/journal_state.dart';
import 'add_journal_page.dart';

class JournalMainPage extends StatefulWidget {
  final String userId;
  const JournalMainPage({super.key, required this.userId});

  @override
  State<JournalMainPage> createState() => _JournalMainPageState();
}

class _JournalMainPageState extends State<JournalMainPage> {
  @override
  void initState() {
    super.initState();
    context.read<JournalBloc>().add(GetJournalsEvent(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Journal')),
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state is JournalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JournalLoaded) {
            final journals = state.journals;
            if (journals.isEmpty) {
              return const Center(child: Text('No journal entries yet.'));
            }
            return ListView.builder(
              itemCount: journals.length,
              itemBuilder: (context, index) {
                final journal = journals[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(journal.title),
                    subtitle: Text(
                      journal.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      journal.date.toLocal().toString().split(' ')[0],
                      style: const TextStyle(fontSize: 12),
                    ),
                    onLongPress: () {
                      context
                          .read<JournalBloc>()
                          .add(DeleteJournalEvent(journal.id));
                    },
                  ),
                );
              },
            );
          } else if (state is JournalFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('Loading...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddJournalPage(userId: widget.userId),
            ),
          );

          // 👇 Automatically refresh after returning from AddJournalPage
          if (result == true) {
            context.read<JournalBloc>().add(GetJournalsEvent(widget.userId));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
