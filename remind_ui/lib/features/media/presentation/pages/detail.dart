import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remind_ui/features/media/presentation/widgets/detail_card.dart';

import '../bloc/media_bloc.dart';
import '../bloc/media_event.dart';
import '../bloc/media_state.dart';

class Detail extends StatelessWidget {
  final String id;
  final String? imageUrl;
  final String? text;
  final String? link;
  final String category;
  final String? keyWord;
  final String createdAt;

  const Detail(
      {super.key,
      required this.id,
      this.imageUrl,
      this.text,
      this.link,
      required this.category,
      this.keyWord,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MediaBloc, MediaState>(
      listener: (context, state) {
        if (state is DeleteSuccessState) {
          {
            context.read<MediaBloc>().add(LoadAllMediaEvent());
            Navigator.pushReplacementNamed(context, '/home');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('delete is successful'),
              ),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 242, 189, 172),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_outlined,
                color: Color.fromARGB(255, 52, 48, 70)),
          ),
          actions: const [
            Text(
              "Detail",
              style: TextStyle(
                color: Color.fromARGB(255, 52, 48, 70),
                fontSize: 15,
              ),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: imageUrl != null
                  ? detailCardMedia.displaywithImage(context, id, imageUrl,
                      text, link, category, keyWord, createdAt)
                  : detailCardMedia.displaywithoutImage(
                      context, id, text, link, category, keyWord, createdAt)),
        ),
      ),
    );
  }
}
