import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  final heroTag;

  const DetailsScreen({super.key,this.heroTag});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Stack(
        alignment: Alignment.center,
        children: [
         _flechaAtras(),
          _nombrePerromon(),
          _pokefondo(),
          Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height*0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                    )
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                  child: Column(
                  children: [
                 SizedBox(
                 height: 50,
                   ),
                    Padding(padding: const EdgeInsets.all(20),
                            child: Row(children: [
                              Container(
                                width: width*0.3,
                                child: Text("Raza",style: TextStyle(fontSize: 18),),
                              ),
                              Container(child: Text("Aqui va la raza",style: TextStyle(fontSize: 18),),)
                            ],),
                    
                    ),
                    Padding(padding: const EdgeInsets.all(20),
                      child: Row(children: [
                        Container(
                          width: width*0.3,
                          child: Text("Altura",style: TextStyle(fontSize: 18),),
                        ),
                        Container(child: Text("Aqui va la altura",style: TextStyle(fontSize: 18),),)
                      ],),

                    ),
                    Padding(padding: const EdgeInsets.all(20),
                      child: Row(children: [
                        Container(
                          width: width*0.3,
                          child: Text("Peso",style: TextStyle(fontSize: 18),),
                        ),
                        Container(child: Text("Aqui va el peso",style: TextStyle(fontSize: 18),),)
                      ],),

                    ),
                    Padding(padding: const EdgeInsets.all(20),
                      child: Row(children: [
                        Container(
                          width: width*0.3,
                          child: Text("Esperanza de vida",style: TextStyle(fontSize: 18),),
                        ),
                        Container(child: Text("Aqui va la esperanza",style: TextStyle(fontSize: 18),),)
                      ],),

                    )
                ],
              )
                ),

              )
            ),
                 Positioned(
                 top: (height*0.2),

                child: Hero(
                  tag: widget.heroTag,
                  child: Image.asset('images/imagenes_perros/Affenpinscher.jpg',height: 200,width: 300,
                    fit: BoxFit.cover,),
                 )
                  ),
        ],
      ),
    );
  }
  
  Widget _flechaAtras(){
    return  Positioned(
        top: 25,
        left: 5,
        child: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,size: 35))
    );
  }
  
  Widget _nombrePerromon(){
    return Positioned(
        top: 90,
        left: 20,
        right: 20,
        child: Row(
      children: [
        Text("Affenpinscher",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),)
      ],
    )
    );
  }

  Widget _pokefondo(){

    var height = MediaQuery.of(context).size.height;
    return Positioned(
        top: height * 0.18,
        right: -30,
        child: Image.asset('images/pokeball.png',
        height: 200,
        fit: BoxFit.fitHeight,
        ));
  }


}
