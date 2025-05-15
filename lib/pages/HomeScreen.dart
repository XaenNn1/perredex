import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:perredex/pages/DetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _fondo(),
          _titulo(),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
              child: Column(
                children: [
                  Expanded(child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.4),
                    itemCount: 151,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return Padding(padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                     ),
                      child: InkWell(
                        child: SafeArea(child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.greenAccent
                          ),
                          child: Stack(
                            children: [
                              _imagenpokeinterna(),
                              _imagenperro(index),
                              _nombrePerromon(),
                            ],
                          ),
                        )
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_)=> DetailsScreen(heroTag: index,))
                          );
                        },
                      ),
                    );
                  }
              )
              )
            ],
          ))
        ],
      ),
    );
  }


  Widget _fondo(){
    return   Positioned(
        top: -50,
        right: -50,
        child: Image.asset('images/pokeball.png',fit: BoxFit.fitWidth, width: 200)
    );
  }

  Widget _titulo(){
    return  Positioned(
        top: 100,
        left: 20,
        child: Text('Perredex',style: TextStyle(color: Colors.black.withOpacity(0.7),fontWeight: FontWeight.bold,fontSize: 30),)
    );
  }

  Widget _imagenpokeinterna(){
    return Positioned(
      bottom:-9,
      right: -10,
      child: Image.asset('images/pokeball.png',height: 150,
          fit: BoxFit.fitHeight),
    );
  }

  Widget _imagenperro(index){
    return   Positioned(
        bottom: 5,
        right: 5,
        child: Hero(
            tag: index,
            child: Image.asset('images/imagenes_perros/Affenpinscher.jpg',height: 72,fit: BoxFit.fitHeight))

    );
  }

  Widget _nombrePerromon(){
    return Positioned(
        top: 15,
        left: 10,
        child: Text("Affenpinscher",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),
    ));
  }

}
