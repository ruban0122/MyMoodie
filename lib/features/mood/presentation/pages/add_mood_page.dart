import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoodie/core/constants/app_colors.dart';
import 'package:mymoodie/injection_container.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_event.dart';


class AddMoodPage extends StatefulWidget {
  final String userId;
  const AddMoodPage({super.key, required this.userId});

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  final _noteController = TextEditingController();
  String selectedMood = 'Happy';
  final List<String> moodOptions = ['Happy', 'Sad', 'Angry', 'Calm', 'Excited'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoodBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Mood'),
          backgroundColor: AppColors.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<MoodBloc, MoodState>(
            listener: (context, state) {
              if (state is MoodSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mood added successfully!')),
                );
                Navigator.pop(context);
              } else if (state is MoodFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              if (state is MoodLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Mood:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedMood,
                    items: moodOptions.map((mood) {
                      return DropdownMenuItem(value: mood, child: Text(mood));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMood = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Add a Note:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _noteController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'How do you feel?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () {
                        context.read<MoodBloc>().add(
                              AddMoodEvent(
                                moodType: selectedMood,
                                note: _noteController.text,
                                userId: widget.userId,
                              ),
                            );
                      },
                      child: const Text('Save Mood'),
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
