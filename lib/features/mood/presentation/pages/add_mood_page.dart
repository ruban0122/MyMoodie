import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoodie/core/constants/app_colors.dart';
import 'package:mymoodie/injection_container.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_event.dart';

// class AddMoodPage extends StatefulWidget {
//   final String userId;
//   const AddMoodPage({super.key, required this.userId});

//   @override
//   State<AddMoodPage> createState() => _AddMoodPageState();
// }

// class _AddMoodPageState extends State<AddMoodPage> {
//   final _noteController = TextEditingController();
//   String? selectedMood;

//   final List<Map<String, String>> moodOptions = [
//     {'emoji': '😄', 'label': 'Happy'},
//     {'emoji': '😊', 'label': 'Grateful'},
//     {'emoji': '😐', 'label': 'Neutral'},
//     {'emoji': '😢', 'label': 'Sad'},
//     {'emoji': '😡', 'label': 'Angry'},
//     {'emoji': '😴', 'label': 'Tired'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => sl<MoodBloc>(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Add Mood'),
//           backgroundColor: AppColors.primary,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: BlocConsumer<MoodBloc, MoodState>(
//             listener: (context, state) {
//               if (state is MoodSuccess) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Mood added successfully!')),
//                 );
//                 Navigator.pop(context);
//               } else if (state is MoodFailure) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error: ${state.error}')),
//                 );
//               }
//             },
//             builder: (context, state) {
//               if (state is MoodLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               return SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'How are you feeling today?',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 20),

//                     // Emoji Selection Grid
//                     Wrap(
//                       spacing: 15,
//                       runSpacing: 15,
//                       children: moodOptions.map((mood) {
//                         final isSelected = selectedMood == mood['label'];
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedMood = mood['label'];
//                             });
//                           },
//                           child: Container(
//                             width: 80,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: isSelected
//                                   ? AppColors.primary.withOpacity(0.2)
//                                   : Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(
//                                 color: isSelected
//                                     ? AppColors.primary
//                                     : Colors.transparent,
//                                 width: 2,
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 mood['emoji']!,
//                                 style: const TextStyle(fontSize: 36),
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),

//                     const SizedBox(height: 30),
//                     const Text('Wanna share why?',
//                         style: TextStyle(fontSize: 16)),
//                     const SizedBox(height: 10),
//                     TextField(
//                       controller: _noteController,
//                       maxLines: 3,
//                       decoration: InputDecoration(
//                         hintText: 'Write your thoughts...',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 30),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         icon: const Icon(Icons.save),
//                         label: const Text('Save Mood'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primary,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                         ),
//                         onPressed: selectedMood == null
//                             ? null
//                             : () {
//                                 context.read<MoodBloc>().add(
//                                       AddMoodEvent(
//                                         moodType: selectedMood!,
//                                         note: _noteController.text.trim(),
//                                         userId: widget.userId,
//                                       ),
//                                     );
//                               },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class AddMoodPage extends StatefulWidget {
  final String userId;
  const AddMoodPage({super.key, required this.userId});

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  final _noteController = TextEditingController();
  String? selectedMood;

  final List<Map<String, String>> moodOptions = [
    {'emoji': '😄', 'label': 'Happy'},
    {'emoji': '😊', 'label': 'Grateful'},
    {'emoji': '😐', 'label': 'Neutral'},
    {'emoji': '😢', 'label': 'Sad'},
    {'emoji': '😡', 'label': 'Angry'},
    {'emoji': '😴', 'label': 'Tired'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How are you feeling today?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: moodOptions.map((mood) {
                      final isSelected = selectedMood == mood['label'];
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedMood = mood['label']);
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withOpacity(0.2)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              mood['emoji']!,
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Wanna share why?',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Write your thoughts...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Save Mood'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: selectedMood == null
                          ? null
                          : () {
                              context.read<MoodBloc>().add(
                                    AddMoodEvent(
                                      moodType: selectedMood!,
                                      note: _noteController.text.trim(),
                                      userId: widget.userId,
                                    ),
                                  );
                            },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

