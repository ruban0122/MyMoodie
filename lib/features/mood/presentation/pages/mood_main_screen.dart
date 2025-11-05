// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../domain/entities/mood_entity.dart';
// import '../bloc/mood_bloc.dart';
// import '../bloc/mood_event.dart';
// import 'add_mood_page.dart';

// class MoodMainScreen extends StatefulWidget {
//   final String userId;
//   const MoodMainScreen({super.key, required this.userId});

//   @override
//   State<MoodMainScreen> createState() => _MoodMainScreenState();
// }

// class _MoodMainScreenState extends State<MoodMainScreen> {
//   final user = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     super.initState();
//     if (user != null) {
//       context.read<MoodBloc>().add(GetMoodsEvent(user!.uid));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('MyMoodie 😊'),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               if (mounted) {
//                 Navigator.pushReplacementNamed(context, '/login');
//               }
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: BlocBuilder<MoodBloc, MoodState>(
//         builder: (context, state) {
//           if (state is MoodLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is MoodLoaded) {
//             final moods = state.moods;
//             if (moods.isEmpty) {
//               return const Center(child: Text("No moods yet. Tap + to add!"));
//             }
//             return ListView.builder(
//               itemCount: moods.length,
//               itemBuilder: (context, index) {
//                 final mood = moods[index];
//                 return Card(
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text(mood.moodType),
//                     subtitle: Text(mood.note),
//                     trailing: Text(
//                       mood.date.toLocal().toString().split(' ')[0],
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                     onLongPress: () {
//                       context.read<MoodBloc>().add(DeleteMoodEvent(mood.id));
//                     },
//                   ),
//                 );
//               },
//             );
//           } else if (state is MoodFailure) {
//             return Center(child: Text("Error: ${state.error}"));
//           }
//           return const Center(child: Text("Loading moods..."));
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (_) => AddMoodPage(userId: widget.userId)),
//           );
//           // refresh list
//           if (user != null) {
//             context.read<MoodBloc>().add(GetMoodsEvent(user!.uid));
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/mood_entity.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_event.dart';
import 'add_mood_page.dart';

class MoodMainScreen extends StatefulWidget {
  const MoodMainScreen({super.key});

  @override
  State<MoodMainScreen> createState() => _MoodMainScreenState();
}

class _MoodMainScreenState extends State<MoodMainScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      context.read<MoodBloc>().add(GetMoodsEvent(user!.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'How are you feeling today?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<MoodBloc, MoodState>(
                builder: (context, state) {
                  if (state is MoodLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MoodLoaded) {
                    final moods = state.moods;
                    if (moods.isEmpty) {
                      return const Center(
                          child: Text("No moods yet. Tap + to add!"));
                    }
                    return ListView.builder(
                      itemCount: moods.length,
                      itemBuilder: (context, index) {
                        final mood = moods[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: _getEmojiIcon(mood.moodType),
                            title: Text(mood.moodType),
                            subtitle: Text(mood.note),
                            trailing: Text(
                              mood.date.toLocal().toString().split(' ')[0],
                              style: const TextStyle(fontSize: 12),
                            ),
                            onLongPress: () {
                              context
                                  .read<MoodBloc>()
                                  .add(DeleteMoodEvent(mood.id));
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is MoodFailure) {
                    return Center(child: Text("Error: ${state.error}"));
                  }
                  return const Center(child: Text("Loading moods..."));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (user == null) return;
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddMoodPage(userId: user!.uid),
            ),
          );
          context.read<MoodBloc>().add(GetMoodsEvent(user!.uid));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getEmojiIcon(String moodType) {
    switch (moodType) {
      case 'Happy':
        return const Text('😄', style: TextStyle(fontSize: 24));
      case 'Sad':
        return const Text('😊', style: TextStyle(fontSize: 24));
      case 'Grateful':
        return const Text('😢', style: TextStyle(fontSize: 24));
      case 'Angry':
        return const Text('😡', style: TextStyle(fontSize: 24));
      case 'Neutral':
        return const Text('😐', style: TextStyle(fontSize: 24));
      case 'Tired':
        return const Text('😴', style: TextStyle(fontSize: 24));
      default:
        return const Icon(Icons.sentiment_satisfied);
    }
  }
}
