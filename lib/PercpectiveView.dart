import 'package:flutter/material.dart';
import 'package:percpective_view/pageViewHolder.dart';
import 'package:provider/provider.dart';

class PerspectiveView extends StatefulWidget {

  @override
  State<PerspectiveView> createState() => _PerspectiveViewState();
}

class _PerspectiveViewState extends State<PerspectiveView> {


  pageViewHolder holder = pageViewHolder(2);

  PageController pageController = PageController();
  double fraction = 0.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    pageController = PageController(initialPage: 2,viewportFraction: fraction);

    pageController.addListener(() {
      holder.setValue(pageController.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Perspective PageView'),
          ),
          body: Container(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: ChangeNotifierProvider<pageViewHolder>.value(
                  value: holder,
                  child: PageView.builder(
                    controller: pageController,
                      itemCount: 12,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (
                          BuildContext context, int index){
                        return MyScreen(number: index.toDouble(),fraction: fraction,);


                        },


                  ),
                ),
              ),

            ),
          ),
        ),
    );
  }
}


class MyScreen extends StatelessWidget {

  final double number;
  final double fraction;

  MyScreen({required this.number,required this.fraction});

  @override
  Widget build(BuildContext context) {

    double value = Provider.of<pageViewHolder>(context).value;
    double diff = (number - value);

    //Matrix for Elements
    final Matrix4 pvMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / 0.9) // Increasing Scale by 90%
      ..setEntry(1, 1, fraction) // Changing Scale Along Y Axis
      ..setEntry(3, 0, 0.004 * -diff); // Changing Perspective Along X Axis

    print(value);
    return Transform(
      transform: pvMatrix,
      alignment: FractionalOffset.center,
      child: Container(
        child: Image.asset('images/image_${number.toInt()+1}.jpg',fit: BoxFit.fill,),
      ),
    );
  }
}

