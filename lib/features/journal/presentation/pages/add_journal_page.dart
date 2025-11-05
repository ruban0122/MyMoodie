import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoodie/core/constants/app_colors.dart';
import 'package:mymoodie/features/journal/presentation/bloc/journal_state.dart';
import 'package:mymoodie/injection_container.dart';
import '../bloc/journal_bloc.dart';
import '../bloc/journal_event.dart';
import '../../domain/entities/journal_entity.dart';

class AddJournalPage extends StatefulWidget {
  final String userId;
  const AddJournalPage({super.key, required this.userId});

  @override
  State<AddJournalPage> createState() => _AddJournalPageState();
}

class _AddJournalPageState extends State<AddJournalPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<JournalBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Journal'),
          backgroundColor: AppColors.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<JournalBloc, JournalState>(
            listener: (context, state) {
              if (state is JournalSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Journal added successfully!')),
                );
                Navigator.pop(context);
              } else if (state is JournalFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              if (state is JournalLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _contentController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: 'Write your thoughts...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Save Journal'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        if (_titleController.text.isNotEmpty &&
                            _contentController.text.isNotEmpty) {
                          final journal = JournalEntity(
                            id: '', // will be replaced in bloc
                            userId: widget.userId,
                            title: _titleController.text.trim(),
                            content: _contentController.text.trim(),
                            date: DateTime.now(),
                          );

                          context
                              .read<JournalBloc>()
                              .add(AddJournalEvent(journal));
                          Navigator.pop(context, true);
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
