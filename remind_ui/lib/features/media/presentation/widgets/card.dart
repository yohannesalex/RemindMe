import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for Clipboard
import 'package:remind_ui/features/media/presentation/widgets/split.dart';
import '../pages/detail.dart';

class CardMedia {
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
              width: 400,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  "http://192.168.104.42:5244$imageurl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            text != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(text,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            link != null
                ? Row(
                    children: [
                      const Text('link: ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () {
                          // Copy the link to clipboard
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
                    const Text('Category:  ',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(category),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                keyWord != null
                    ? Row(
                        children: [
                          const Text('keyword: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(keyWord),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          id: id,
                          imageUrl: imageurl,
                          category: category,
                          keyWord: keyWord,
                          createdAt: createdAt,
                          link: link,
                          text: text,
                        ),
                      ),
                    );
                  },
                  child: const Text('detail',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                Column(
                  children: [
                    Text(
                      "Date ${split.splitdate(createdAt)}",
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Time ${split.splittime(createdAt)}",
                      style: const TextStyle(fontSize: 10),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            Center(
              child: text != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(text,
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 10,
            ),
            link != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('link: ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () {
                          // Copy the link to clipboard
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
                    const Text('Category:  ',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(category),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                keyWord != null
                    ? Row(
                        children: [
                          const Text('keyword: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(keyWord),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          id: id,
                          category: category,
                          keyWord: keyWord,
                          createdAt: createdAt,
                          link: link,
                          text: text,
                        ),
                      ),
                    );
                  },
                  child: const Text('detail',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                Column(
                  children: [
                    Text(
                      "Date ${split.splitdate(createdAt)}",
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Time ${split.splittime(createdAt)}",
                      style: const TextStyle(fontSize: 10),
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
}

CardMedia cardMedia = CardMedia();
