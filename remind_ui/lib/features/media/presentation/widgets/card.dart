import 'package:flutter/material.dart';

class CardMedia {
  displaywithImage(imageurl, text, link, category, keyWord, createdAt) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            width: 400,
            height: 300,
            child: GestureDetector(
              child: Image.network(
                "http://192.168.104.42:5244$imageurl",
                fit: BoxFit.cover,
              ),
              onTap: () {},
            ),
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
