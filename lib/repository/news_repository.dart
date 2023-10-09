import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/categories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_models.dart';

class NewsRepository{

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlineApi(String channelName)async{
    

    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=cdbabe32799a4cefbf02368abd576dc8';
  
    final response = await http.get(Uri.parse(url));
     if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }else{
      throw Exception('Error');
    }
  }


    Future<CategoriesNewsModel> fetchCategoriesNwsApi(String category)async{
    

    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=cdbabe32799a4cefbf02368abd576dc8';
  
    final response = await http.get(Uri.parse(url));
     if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }else{
      throw Exception('Error');
    }
  }

}