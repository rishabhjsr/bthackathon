import 'package:bt_hack/features/details/presentation/pages/product_page.dart';
import 'package:bt_hack/features/home/presentation/manager/home_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../search/presentation/pages/searchResult_page.dart';
import '../widgets/custom_product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id='homepage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc=HomeBloc();

  final TextEditingController _searchController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return  BlocConsumer<HomeBloc,HomeState>(
        bloc: homeBloc,
        listenWhen: (prev,curr)=>curr is HomeActionState,
        buildWhen: (prev,curr)=>curr is !HomeActionState,
        builder: (context,state){
          switch(state.runtimeType)
          {
            case HomeLoadingState:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            case HomeLoadedSuccessState:
              final successState =state as HomeLoadedSuccessState;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Container(
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(fontSize: 20),
                        prefixIcon: IconButton(onPressed: (){
                        homeBloc.add(HomeSearchBtnClickedEvent());
                    //setState(){}
                    }, icon:const Icon(Icons.search),),
                        suffixIcon: IconButton(onPressed: (){
                          _searchController.clear();

                          //setState(){}
                        }, icon:const Icon(Icons.clear),)

                  ),
                    ),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  actions: const [

                  ],
                ),
                body:GridView.builder(itemCount: successState.products.length,itemBuilder: (context,index){
                        return customListTile(successState.products[index],context,homeBloc);
                      }, gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing:width*0.005,mainAxisSpacing: 10,childAspectRatio: width*0.00125) , ),
              );
            case HomeErrorState:
              return const Scaffold(
                // appBar: AppBar(
                //   backgroundColor: Colors.transparent,
                //   title: const Text('Subspace Blog Mania', style: kTitleTextStyle,),
                //   actions: [
                //     IconButton(onPressed: (){
                //       homeBloc.add(HomeFavouritesBtnNavigateEvent());
                //       print("fav btn pressed");
                //       setState(){}
                //     }, icon:const Icon(Icons.favorite_border),color: Colors.white,)
                //   ],
                // ),
                body: Center(
                  child: Text("Error Occured",style: kTitleTextStyle,),
                ),
              );
            default:
              return Container(
                child: Text("Default case in Home Page"),
              );
          }

        },
        listener: (context,state){
          if(state is HomeNavigateToDetailsPageActionState)
          {
            if(state.products!=null)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage(product: state.products)));
              // Navigator.pushNamed(context, BlogPage.id,arguments: state.blog);
            }
            else
            {
              if (kDebugMode) {
                print("blog was found null in the state of HomeAction state!!!");
              }
            }
          }
          if(state is HomeNavigateToSearchPageActionState)
            {
              if(_searchController!=null)
                {
                  String queryText=_searchController.text;
                  if(queryText.isNotEmpty)
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage(query: queryText)));
                }
            }
        });
  }
}
