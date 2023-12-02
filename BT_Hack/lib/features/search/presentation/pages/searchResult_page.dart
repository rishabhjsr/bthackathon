
import 'package:bt_hack/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../details/presentation/pages/product_page.dart';
import '../../../search/presentation/widgets/custom_product_tile.dart';
import '../manager/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.query}) : super(key: key);
  static const String id="search_page";
  final String query;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBloc searchBloc=SearchBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchBloc.add(SearchInitialEvent(widget.query));
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return BlocConsumer<SearchBloc,SearchState>(
        bloc: searchBloc,
        listenWhen: (prev,curr)=>curr is SearchActionState,
        buildWhen: (prev,curr)=>curr is !SearchActionState,
        builder: (context,state){
          switch(state.runtimeType)
          {
            case SearchLoadingState:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            case SearchLoadedSuccessState:
              final successState =state as SearchLoadedSuccessState;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text("Search Results",style: kTitleTextStyle,),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  actions: const [

                  ],
                ),
                body:GridView.builder(itemCount: successState.products.length,itemBuilder: (context,index){
                  return customListTile(successState.products[index],context,searchBloc);
                }, gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing:width*0.005,mainAxisSpacing: 10,childAspectRatio: width*0.00145) , ),
              );
            case SearchErrorState:
              return const Scaffold(
                // appBar: AppBar(
                //   backgroundColor: Colors.transparent,
                //   title: const Text('Subspace Blog Mania', style: kTitleTextStyle,),
                //   actions: [
                //     IconButton(onPressed: (){
                //       homeBloc.add(SearchFavouritesBtnNavigateEvent());
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
                child: Text("Default case in Search Page"),
              );
          }

        },
        listener: (context,state){
          if(state is SearchNavigateToDetailsPageActionState)
          {
            if(state.products!=null)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage(product: state.products)));
              // Navigator.pushNamed(context, BlogPage.id,arguments: state.blog);
            }
            else
            {
              if (kDebugMode) {
                print("blog was found null in the state of SearchAction state!!!");
              }
            }
          }
        });
  }
}
