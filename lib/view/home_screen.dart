
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/categories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_models.dart';
import 'package:newsapp/view/categoriesScreen.dart';
import 'package:newsapp/view_model/news_vm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList{ bbcNews , bbcSports ,aryNews , independent , cnn , alJazeera}



class _HomeScreenState extends State<HomeScreen> {


String name = "bbc-news";
FilterList? selectedMenu ;  

  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd ,yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return  Scaffold(
      
      appBar: AppBar(
        leading:   IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen() ));
        }, icon:Image.asset('images/category_icon.png' , height: 30 , width: 30, ) )  ,
      centerTitle: true,
      title: Text('News' , 
      style: GoogleFonts.poppins(fontSize:24 , fontWeight: FontWeight.w700 ),
      ) ,
      automaticallyImplyLeading: false,
      actions: [
        PopupMenuButton<FilterList>(
          initialValue: selectedMenu,
          onSelected: (FilterList item) {
            if (FilterList.bbcNews.name == item.name){
              name = 'bbc-news';
            }
              if (FilterList.alJazeera.name == item.name){
              name = 'al-jazeera-english';
            }
              if (FilterList.cnn.name == item.name){
              name = 'cnn';
            }

            setState(() {
              selectedMenu = item;
            });
          },
    
          itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
           const PopupMenuItem<FilterList>(
            value: FilterList.bbcNews,
            child: Text('BBC News')),
             const PopupMenuItem<FilterList>(
            value: FilterList.alJazeera,
            child: Text('Al-Jazeera News')),
             const PopupMenuItem<FilterList>(
            value: FilterList.cnn,
            child: Text('CNN')),
        ] )
      ],
      ),
      
      body: ListView(
        // for horizontal list you have to mention size otherwise you will get error
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child:  FutureBuilder<NewsChannelsHeadlinesModel>(
            future: newsViewModel.fetchNewsChannelHeadlineApi(name), 
            builder: (BuildContext context , snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: SpinKitSpinningLines(
                      color: Colors.blue,
                  ));
              }else{
                return ListView.builder(
                  
                  scrollDirection: Axis.horizontal,
             
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context , index){
                      // cconvert publish date in date and time
                    DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                    return SizedBox(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: height * .6,
                        width: width * .9,
                        padding: EdgeInsets.symmetric(horizontal: height * .02),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            height: height * .6,
                            imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                            fit : BoxFit.cover,
                            placeholder: ((context, url) => spInKit2),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline , color: Colors.red,),
                            ),
                        ),
                          
                      ),
                      Positioned(
                        bottom: 10,
                        child: Card(
                          elevation: 5,
                          color: Colors.white.withOpacity(.5),
                          shape: RoundedRectangleBorder(
                            borderRadius:  BorderRadius.circular(12),
                          
                          ),
                          child: Container(
                            height: height * .22,
                            alignment: Alignment.bottomCenter ,
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: height * .02,),
                                Container(
                                  width: width * .7,
                                  child: Text(snapshot.data!.articles![index].title.toString() ,
                                  maxLines: 2, 
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(fontSize: 17 ,fontWeight: FontWeight.bold ) ,),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width * .02 , vertical:  height * .01),
                                  child: Container(
                                    width: width * .7, 
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data!.articles![index].source!.name.toString() ,
                                    maxLines: 2, 
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 12 ,fontWeight: FontWeight.bold ) ,),
                                                               
                                                               Text(format.format(dateTime) ,
                                    maxLines: 2, 
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 12 ,fontWeight: FontWeight.bold ) ,),
                                                               
                                      ]),
                                  ),
                                )
                              ]),
                          ),
                        ),
                      )
                    ],
                  ),
                );
                  }, 
                  
                );
              
                
              }
            }),
        
          ) ,
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNwsApi('General'), 
                builder: (BuildContext context , snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: SpinKitSpinningLines(
                          color: Colors.blue,
                      ));
                  }else{
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context , index){
                          // cconvert publish date in date and time
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return  Padding(
                          padding: const EdgeInsets.only( bottom : 20.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    height: height * .18,
                                    width: width * .3,
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit : BoxFit.cover,
                                    placeholder: ((context, url) => spInKit2),
                                    errorWidget: (context, url, error) => Icon(Icons.error_outline , color: Colors.red,),
                                    ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 12),
                                    height: height * .18 ,
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!.articles![index].title.toString() , 
                                        maxLines: 3 ,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black
                                          
                                        ),),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                        Flexible(
                                          child: Text(snapshot.data!.articles![index].source!.name.toString() , 
                                                               
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue
                                            
                                          ),),
                                        ),
          
                                        Text(format.format(dateTime) , 
                                       
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black
                                          
                                        ),),
                                          ],
                                        )
                                      ],
                                    ),))
                            ],
                          ),
                        );}, 
                    );
                  }
                }),
          ),
          
    
        
        ],
      )
    );
  }

}


const spInKit2 = SpinKitFadingCircle(
    color: Colors.amber,
    size: 50,
  );