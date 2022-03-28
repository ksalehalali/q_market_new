import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Assistants/globals.dart';
import '../../../Data/data_for_ui.dart';
import '../../widgets/departments_list_r.dart';
import '../home/search_area_des.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List categoriesButtons = [];
  List<Widget> brandsWidgets = [];
  List colors =[];
  Color color =Colors.grey;
  List<double> opacityColor = [];



  // List<Map<String,String>> brands =[
  //   {'catName': 'Women\'s Fashion','imagePath':'assets/images/agelesspix-PlcByunJ78c-unsplash.jpg'},
  //   {'catName': 'Men\'s Fashion','imagePath':'assets/images/austin-wade-d2s8NQ6WD24-unsplash.jpg'},
  //   {'catName': 'Kids, Baby & Toys','imagePath':'assets/images/robo-wunderkind-3EuPcI31MQU-unsplash.jpg'},
  //   {'catName': 'Accessories and gifts','imagePath':'assets/images/freestocks-PxM8aeJbzvk-unsplash.jpg'},
  //   {'catName': 'beauty supplies','imagePath':'assets/images/laura-chouette-RkINI2JZwss-unsplash.jpg'},
  //   {'catName': 'Men\'s stuff','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
  //   {'catName': 'Mobiles & Accessories','imagePath':'assets/images/mehrshad-rajabi-cLrcbfSwBxU-unsplash.jpg'},
  //   {'catName': 'Home & Kitchen','imagePath':'assets/images/ryan-christodoulou-68CDDj03rks-unsplash.jpg'},
  //   {'catName': 'Brands','imagePath':'assets/images/zara-outlet.png'},
  //   {'catName': 'Watches & Bags','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
  // ];
  List<Map<String,String>> handbags_wallets =[
    {'catName': 'Women\'s Fashion','imagePath':'assets/images/agelesspix-PlcByunJ78c-unsplash.jpg'},
    {'catName': 'Men\'s Fashion','imagePath':'assets/images/austin-ade-d2s8NQ6WD24-unsplash.jpg'},
    {'catName': 'Kids, Baby & Toys','imagePath':'assets/images/robo-wunderkind-3EuPcI31MQU-unsplash.jpg'},
    {'catName': 'Accessories and gifts','imagePath':'assets/images/freestocks-PxM8aeJbzvk-unsplash.jpg'},
    {'catName': 'beauty supplies','imagePath':'assets/images/laura-chouette-RkINI2JZwss-unsplash.jpg'},
    {'catName': 'Men\'s stuff','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
    {'catName': 'Mobiles & Accessories','imagePath':'assets/images/mehrshad-rajabi-cLrcbfSwBxU-unsplash.jpg'},
    {'catName': 'Home & Kitchen','imagePath':'assets/images/ryan-christodoulou-68CDDj03rks-unsplash.jpg'},
    {'catName': 'Brands','imagePath':'assets/images/zara-outlet.png'},
    {'catName': 'Watches & Bags','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
  ];
  var departmentContent =[];
  var brandsContent =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    departmentContent = womenFashionDepartments;
    brandsContent =womenFashionBrands;
    createBrandsList();
  }
  Widget buildCategoriesButtons(var data,int index){
    for(int i =0; i<categories.length;i++){
      if(i==0){
        colors.add(myHexColor);
        opacityColor.add(1.0);

      }else{
        opacityColor.add(0.7);
        colors.add(Colors.black);
      }}
      return InkWell(
        onTap: (){
          print('object');
          switch (index){
            case 0:
              departmentContent = womenFashionDepartments;
              brandsContent = womenFashionBrands;
              break;
            case 1:
              departmentContent = menFashionDepartments;
              break;
            case 2:
              departmentContent = kidsBabyToysDepartments;
              break;
            case 4:
              departmentContent = accessoriesAndGifts;
              break;
            case 5:
              departmentContent = beautySuppliesAndPersonalCare;
              break;
            case 6:
              departmentContent = mensStuff;
              break;
            case 7:
              departmentContent = mobilesAndAccessories;
              break;
            case 8:
              departmentContent = homeKitchen;
              break;
            case 9:
              departmentContent = brands;
              break;
            case 8:
              departmentContent = watchesAndBags;
              break;
            case 9:
              departmentContent = mensShoes;
              break;
            case 8:
              departmentContent = womenShoes;
              break;
            case 9:
              departmentContent = kidsShoes;
              break;
          }
          setState(() {

            for(int i =0; i<colors.length;i++){
             if(index==i){
               colors[index]= myHexColor;
               opacityColor[index]= 1.0;
             }else{
               opacityColor[i]= 0.7;
               colors[i]=Colors.black;
             }
           }
          });
        },
        child: Container(

          height: 76,
          width: 79,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(data['imagePath'].toString(),),fit: BoxFit.fill)
          ),
          child: Container(
              color: colors[index].withOpacity(opacityColor[index]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(data['catName'].toString(),maxLines: 2,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)),
              )),
        ),
      );

  }
  final screenSize = Get.size;

   createBrandsList(){
    for(int i =0; i<categories.length;i++){
      brandsWidgets.add(Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              i==1 ? Container(width:screenSize.width ,height: 7,color: Colors.red[500],):Container(),
              Container(
                height: 59,
                width: 59,
                //padding:  EdgeInsets.all(0.1),
                decoration:  BoxDecoration(
                  color: myHexColor,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  child: Image.asset(
                    categories[i]['imagePath'].toString(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(categories[i]['catName'].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
            ],
          )));
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Key? key;
  @override
  Widget build(BuildContext context) {

    return Container(
      color: myHexColor5,
      child: SafeArea(child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              const SizedBox(
                height: 6.0,
              ),
              SearchAreaDesign(),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: screenSize.height-150,
                    child: ListView(

                      children: <Widget>[
                       buildCategoriesButtons(categories[0], 0),
                        buildCategoriesButtons(categories[1], 1),
                        buildCategoriesButtons(categories[2], 2),
                        buildCategoriesButtons(categories[3], 3),
                        buildCategoriesButtons(categories[4], 4),
                        buildCategoriesButtons(categories[5], 5),
                        buildCategoriesButtons(categories[6], 6),
                        buildCategoriesButtons(categories[7], 7),
                        buildCategoriesButtons(categories[8], 8),
                        buildCategoriesButtons(categories[9], 9),



                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height-150,
                    width: screenSize.width -101,
                    child:  Padding(
                      padding: const EdgeInsets.only(bottom: 42.0),
                      child: Stack(
                        children: [
                          Container(width:screenSize.width ,height: 0.5,color: Colors.grey[500],),

                          CustomScrollView(
                            anchor: 0.0,

                            slivers:<Widget> [
                              _buildTitle('Category'),
                             _buildListOfDepartments(departmentContent),
                              _buildTitle('Brands'),
                              _buildListOfDepartments(brandsContent),

                              _buildTitle('Handbags & Wallets'),
                              _buildListOfDepartments(departmentContent),

                            ],
                          ),


                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),

      ),),
    );
  }
  Widget _buildTitle(String title){
    return  SliverAppBar(
        floating: false,
        expandedHeight: 1,
        titleSpacing: 6.0,
        centerTitle: false,
        foregroundColor: Colors.transparent.withOpacity(0.0),
    backgroundColor: Colors.white.withOpacity(0.0),
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black)),
      ],
    ));
    // flexibleSpace: FlexibleSpaceBar(
    //   title: Text('AAAAAAAA',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),),
    // ),
  }
  Widget _buildListOfDepartments(categories){
    return  SliverGrid(
      delegate: SliverChildBuilderDelegate(
              (context,index){
            return Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 82,
                      width: 88,
                      //padding:  EdgeInsets.all(0.1),
                      decoration:  BoxDecoration(
                        color: myHexColor,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        child: Image.asset(
                          categories[index]['imagePath'].toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(categories[index]['depName'].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                  ],
                ));

          },childCount: categories.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 0.8,
          crossAxisCount: 3),);

  }
}
