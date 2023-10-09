import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/categories_news_model.dart';
import 'package:newsapp/view/home_screen.dart';
import 'package:newsapp/view_model/news_vm.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  
   
    FilterList? selectedMenu ;  

    NewsViewModel newsViewModel = NewsViewModel();

    final format = DateFormat('MMMM dd ,yyyy');

    String categoryName = "General";

    List<String> categoriesList = [
      'General',
      'Entertainment',
      'Health',
      'Sports',
      'Business',
      'Technology'
    ];
  
  
  @override
  Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal : 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context , index){
                return InkWell(
                  onTap: (){
                    categoryName = categoriesList[index];
                    setState(() {
                      
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right : 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      color: categoryName == categoriesList[index] ?  Colors.black :  Colors.blue ,
                      ),
                      
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal : 12.0),
                          child: Text(categoriesList[index].toString(), 
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ) ,
                    ),
                  ),
                );
              }),
            ),
           
           SizedBox(height: 20,),
           Expanded(
             child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNwsApi(categoryName), 
              builder: (BuildContext context , snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: SpinKitSpinningLines(
                        color: Colors.blue,
                    ));
                }else{
                  return ListView.builder(
                    
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
        ),
      ),
    );
  }
}