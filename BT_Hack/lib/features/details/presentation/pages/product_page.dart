import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants.dart';
import '../../../../core/models/product_model.dart';
import '../manager/details_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.product}) : super(key: key);
  static const String id = "Product_page";
  final Product product;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final DetailsBloc detailsBloc = DetailsBloc();
  @override
  void initState() {
    // TODO: implement initState
    detailsBloc.add(DetailsInitialEvent(product: widget.product));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<DetailsBloc, DetailsState>(
        bloc: detailsBloc,
        listenWhen: (prev, curr) => curr is DetailsActionState,
        buildWhen: (prev, curr) => curr is! DetailsActionState,
        listener: (context, state) {
          if (state is DetailsNavigateToHomePageActionState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case DetailsLoadingState:
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () {
                        detailsBloc.add(DetailsNavigateToHomePageEvent());
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      )),
                  title: const Text(
                    'Product Mania',
                    style: kTitleTextStyle,
                    softWrap: true,
                    maxLines: 1,
                  ),
                ),
                body: const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            case DetailsLoadedSuccessState:
              final successState = state as DetailsLoadedSuccessState;
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () {
                        detailsBloc.add(DetailsNavigateToHomePageEvent());
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      )),
                  title: Text(
                    widget.product.category,
                    style: kTitleTextStyle,
                    softWrap: true,
                    maxLines: 1,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                        tag: 'product',
                        child: Container(
                          height: size.height * 0.50,
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.product.image),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.01),
                          child: Text(
                            widget.product.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: Text(
                              "Category: ${widget.product.category}",
                              style:
                                  TextStyle(fontSize: 18, color: primaryColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: Text(
                              "\$${widget.product.price}",
                              style:
                                  TextStyle(fontSize: 25, color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.01),
                        child: InkWell(
                            onLongPress: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: "Copied Data"));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Copied To Clipboard")));
                            },
                            child: const Text(
                              "Long Press to Copy Content (add links if any)",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.01),
                        child: Text(widget.product.description),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03),
                        child: Text(
                          "Rating:",
                          style:
                          TextStyle(fontSize: 25, color: primaryColor),
                        ),
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03),
                        child: Text(
                          "Rate: ${widget.product.rating.rate}",
                          style:
                          TextStyle(fontSize: 19, color: primaryColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03),
                        child: Text(
                          "Count: ${widget.product.rating.count}",
                          style:
                          TextStyle(fontSize: 19, color: primaryColor),
                        ),
                      ),
                    ],),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(primaryColor),
                              minimumSize: MaterialStatePropertyAll(
                                  (Size(size.width * 0.5, size.height * 0.07))),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                          onPressed: () {

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 1),backgroundColor: secondaryColor,content: Text("Future Scope",style: TextStyle(color: primaryColor),)));
                          },
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                                fontSize: 17, color: secondaryColor),
                          ))
                    ],
                  ),
                ),
              );
            case DetailsErrorState:
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  //centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () {
                        detailsBloc.add(DetailsNavigateToHomePageEvent());
                      },
                      icon: Icon(Icons.arrow_back)),
                  title: const Text(
                    'Subspace Product Mania',
                    style: kTitleTextStyle,
                    softWrap: true,
                    maxLines: 1,
                  ),
                ),
                body: const Center(
                    child: Text("Error State encountered in details page")),
              );
            default:
              return Container();
          }
        });
  }
}
