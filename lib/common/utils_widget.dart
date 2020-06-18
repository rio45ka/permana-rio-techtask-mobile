import 'package:flutter/material.dart';

Widget loadingViewState({String text = "Loading"}) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Colors.black.withOpacity(0.3),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          width: 220,
          height: 180,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [bgBoxShadowContainer()],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text(text),
            ],
          ),
        ),
      ),
    ),
  );
}

BoxShadow bgBoxShadowContainer() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    blurRadius: 1.0,
    spreadRadius: 0.5,
    offset: Offset(0.5, 0.5),
  );
}