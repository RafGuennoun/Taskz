import 'package:animate_do/animate_do.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

FadeInLeftBig WelcomeText(double width, double height, String username, BuildContext context) {
    return FadeInLeftBig(
      child: Container( 
                width: width,
                height: height*0.1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: RichText(
                    text: TextSpan(
                      text: "What's up, ",
                      style: Theme.of(context).textTheme.headline1,
                    children: [
                      TextSpan(
                      text: "${StringUtils.capitalize(username.toString())} ",
                        style: Theme.of(context).textTheme.headline2,
                      ),
    
                      TextSpan(
                      text: '!',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ]
                    )
                  ),
                ),
              ),
    );
  }