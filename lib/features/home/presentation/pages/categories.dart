import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_categories_bloc/fetch_categories_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_categories_bloc/fetch_categories_event.dart';
import 'package:growmind/features/home/presentation/bloc/fetch_categories_bloc/fetch_categories_state.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FetchCategoriesBloc>().add(GetCategoriesEvent());
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'All Categories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            kheight1,
            Container(
              height: 50,
              width: 350,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: textColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                        blurRadius: 3,
                        color: greyColor)
                  ]),
              child: TextField(
                decoration: InputDecoration(
                  
                    hintText: 'Search',     
                    
                    suffixIcon: Padding(padding:const EdgeInsets.only(right: 10,top: 10,bottom: 10),child: Container(height: 10,width: 10,
                    decoration:const BoxDecoration(
                      color: mainColor,
                     borderRadius: BorderRadius.all(Radius.circular(5))
                    ), child:const Icon(Icons.search,color: textColor,),),),              
                    border: OutlineInputBorder(      
                      borderSide: BorderSide.none,                
                        borderRadius: BorderRadius.circular(30))),
                        textAlign: TextAlign.center,
                onChanged: (value) {
                  context
                      .read<FetchCategoriesBloc>()
                      .add(SearchCategoriesEvent(query: value));
                },
              ),
            ),
            kheight1,
            Expanded(
              child: BlocBuilder<FetchCategoriesBloc, FetchCategoriesState>(
                builder: (context, state) {
                  if (state is FetchCategoriesLoading) {
                    return 
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FetchCategoriesLoaded) {
                    final values = state.value;

                    return values.isEmpty?
                 const   Center(child: Text('No Category Found'),)
                    : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: values.length,
                      itemBuilder: (context, index) {
                        final category = values[index];

                        return Card(
                          color: textColor,
                          child: Column(
                            children: [
                              kheight2,
                              SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Image.network(
                                    category.imageUrl,
                                  )),
                              kheight1,
                              Text(
                                category.category,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text('No Categories Found'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
