
import 'package:newsapp/models/categories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_models.dart';
import 'package:newsapp/repository/news_repository.dart';
import 'package:newsapp/view/home_screen.dart';

class NewsViewModel{
    
    final _repo =  NewsRepository();

    Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlineApi(String channelName)async{

      final response = await _repo.fetchNewsChannelHeadlineApi(channelName);
      return response;
      
    }

    
    Future<CategoriesNewsModel> fetchCategoriesNwsApi(String category)async{

      final response = await _repo.fetchCategoriesNwsApi(category);
      return response;
      
    }
}