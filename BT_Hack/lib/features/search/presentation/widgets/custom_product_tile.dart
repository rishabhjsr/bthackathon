
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/product_model.dart';
import '../manager/search_bloc.dart';


Widget customListTile(Product product,BuildContext context,SearchBloc searchBloc)
{
  return GestureDetector(
    onTap: (){
      searchBloc.add(SearchProductCardBtnNavigateEvent(product: product));
    },
    child: Container(
      margin:  EdgeInsets.all(MediaQuery.of(context).size.width*0.035),
      //padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.0),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: NetworkImage(product.image),fit: BoxFit.fitWidth),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.006),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(product.title,style: const TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis),maxLines: 2,softWrap: true,)),
                Text("\$"+product.price.toString(),style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,softWrap: true,)
              ],
            ),
          ),
          // Text(product.imageUrl,style: const TextStyle(color: Colors.black),)
        ],
      ),
    ),
  );
}