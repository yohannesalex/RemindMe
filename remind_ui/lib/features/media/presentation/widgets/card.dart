import 'package:flutter/material.dart';

class CardMedia {
  displaywithImage(imageurl, text, link, category, keyWord, createdAt) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(
            "http://10.0.2.2:5244$imageurl",
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 5,
          ),
          Text(text),
          SizedBox(
            height: 5,
          ),
          Text('Category: $category'),
          SizedBox(
            height: 5,
          ),
          Text('KeyWord: $keyWord'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('Created At: $createdAt'),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('View'),
              )
            ],
          )
        ],
      ),
    );
  }
}

CardMedia cardMedia = CardMedia();
