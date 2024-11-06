import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remind_ui/features/media/presentation/pages/edit.dart';
import 'package:remind_ui/features/media/presentation/widgets/split.dart';
import '../bloc/media_bloc.dart';
import '../bloc/media_event.dart';

class DetailCardMedia {
  // Method to display media with an image
  displaywithImage(
    BuildContext context,
    id,
    imageurl,
    text,
    link,
    category,
    keyWord,
    createdAt,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(20.0)),
              width: 800,
              height: 650,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  "http://192.168.104.42:5244$imageurl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            text != null
                ? Center(
                    child: Column(
                      children: [
                        const Text('Stored Text ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(text),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 15,
            ),
            link != null
                ? Row(
                    children: [
                      const Text('Link: ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () {
                          // Copy the link to the clipboard
                          Clipboard.setData(ClipboardData(text: link))
                              .then((_) {
                            // Show a snackbar as feedback
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Link copied to clipboard!')),
                            );
                          });
                        },
                        child: Text(
                          link,
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Category:',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(category),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                keyWord != null
                    ? Row(
                        children: [
                          const Text('Keyword: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(keyWord),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Edit(
                              id: id,
                              imageUrl: imageurl,
                              category: category,
                              remindBy: keyWord,
                              link: link,
                              text: text,
                            ),
                          ),
                        );
                      },
                      child: const Text('Edit',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<MediaBloc>().add(DeleteMediaEvent(id));
                      },
                      child: const Text('Delete',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Date ${split.splitdate(createdAt)}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Time ${split.splittime(createdAt)}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to display media without an image
  displaywithoutImage(
    BuildContext context,
    id,
    text,
    link,
    category,
    keyWord,
    createdAt,
  ) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              text != null
                  ? Center(
                      child: Column(
                        children: [
                          const Text(
                            'Stored Text ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(text),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 15,
              ),
              link != null
                  ? Row(
                      children: [
                        const Text('Link: ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        GestureDetector(
                          onTap: () {
                            // Copy the link to the clipboard
                            Clipboard.setData(ClipboardData(text: link))
                                .then((_) {
                              // Show a snackbar as feedback
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Link copied to clipboard!')),
                              );
                            });
                          },
                          child: Text(
                            link,
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('Category:',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(category),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              keyWord != null
                  ? Row(
                      children: [
                        const Text('Keyword: ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(keyWord),
                      ],
                    )
                  : const SizedBox.shrink(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Edit(
                                id: id,
                                category: category,
                                remindBy: keyWord ?? '',
                                link: link ?? '',
                                text: text ?? '',
                              ),
                            ),
                          );
                        },
                        child: const Text('Edit',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<MediaBloc>().add(DeleteMediaEvent(id));
                        },
                        child: const Text('Delete',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Date ${split.splitdate(createdAt)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Time ${split.splittime(createdAt)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

DetailCardMedia detailCardMedia = DetailCardMedia();
