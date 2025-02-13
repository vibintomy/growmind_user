import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/presentation/bloc/get_tutor_bloc/tutor_bloc.dart';
import 'package:growmind/features/home/presentation/bloc/get_tutor_bloc/tutor_event.dart';
import 'package:growmind/features/home/presentation/bloc/get_tutor_bloc/tutor_state.dart';

Container instructorDetails(BuildContext context, String subCategory,String tutorId) {
  context.read<TutorBloc>().add(GetTutorEvent(tutorId));
  return Container(
    height: 400,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
        color: textColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 3),
              spreadRadius: 0,
              blurRadius: 3,
              color: greyColor)
        ]),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Instructor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              )),
          kheight,
          BlocBuilder<TutorBloc, TutorState>(builder: (context, state) {
            if (state is TutorStateLoading) {
              return const Center(
                child: Text('No values'),
              );
            } else if (state is TutorStateLoaded) {
              final tutor = state.tutorId;
              return ListTile(
                leading: Container(
                  decoration:const BoxDecoration(shape: BoxShape.circle),
               
                    height: 70, width: 60, child: ClipOval(child: Image.network(tutor.image,fit: BoxFit.fill,))),
                title: Text(tutor.name,style:const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(tutor.email,overflow: TextOverflow.ellipsis,),
                trailing: IconButton(
                    onPressed: () {}, icon:const Icon(Icons.wechat_sharp)),
              );
            } else {
              return const Center(
                child: Text('No tutor'),
              );
            }
          }),
          kheight,
          const Divider(
            height: 1,
            thickness: 1,
            color: greyColor,
          ),
          kheight1,
          const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'What you will Get',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          kheight,
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.menu_book,
                    color: Colors.orange,
                  ),
                  kwidth,
                  Text(
                    'Informative lessons about \n$subCategory ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              kheight1,
              const Row(
                children: [
                  Icon(Icons.smartphone_outlined),
                  kwidth,
                  Text('Access -Mobile',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              kheight1,
              const Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    color: Colors.green,
                  ),
                  kwidth,
                  Text('Beginner Level',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              kheight1,
              const Row(
                children: [
                  Icon(
                    Icons.all_inclusive,
                    color: Colors.blue,
                  ),
                  kwidth,
                  Text('LifeTime Acess',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
