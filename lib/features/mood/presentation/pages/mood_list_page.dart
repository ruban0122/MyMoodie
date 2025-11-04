import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoodie/core/constants/app_colors.dart';
import 'package:mymoodie/injection_container.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_event.dart';

import 'add_mood_page.dart';

class MoodListPage extends StatefulWidget {
  final String userId;
  const MoodListPage({super.key, required this.userId});

  @override
  State<MoodListPage> createState() => _MoodListPageState();
}

class _MoodListPageState extends State<MoodListPage> {
  @override
  void initState() {
    super.initState();
    context.read<MoodBloc>().add(GetMoodsEvent(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoodBloc>()..add(GetMoodsEvent(widget.userId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Mood History'),
          backgroundColor: AppColors.primary,
        ),
        body: BlocBuilder<MoodBloc, MoodState>(
          builder: (context, state) {
            if (state is MoodLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoodLoaded) {
              if (state.moods.isEmpty) {
                return const Center(child: Text('No moods recorded yet.'));
              }
              return ListView.builder(
                itemCount: state.moods.length,
                itemBuilder: (context, index) {
                  final mood = state.moods[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(mood.moodType),
                      subtitle: Text(mood.note),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<MoodBloc>().add(DeleteMoodEvent(mood.id));
                        },
                      ),
                    ),
                  );
                },
              );
            } else if (state is MoodFailure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.accent,
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddMoodPage(userId: widget.userId),
              ),
            );
            context.read<MoodBloc>().add(GetMoodsEvent(widget.userId)); // refresh
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
