import 'package:flutter/material.dart';
import 'package:galli_vector_plugin/src/map.dart';

class Three60ButtonWidget extends StatelessWidget {
  const Three60ButtonWidget({super.key, required this.controller});
  final GalliMapController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        controller.show360Lines();
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffE2DFD2),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xff454545), width: 2),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff454545).withOpacity(0.2),
                  blurRadius: 3,
                  offset: const Offset(1, 1),
                  spreadRadius: 3),
              BoxShadow(
                  color: const Color(0xff454545).withOpacity(0.2),
                  blurRadius: 3,
                  offset: const Offset(-1, -1),
                  spreadRadius: 3)
            ]),
        width: 48,
        height: 48,
        child: const Center(
          child: Icon(
            Icons.rotate_90_degrees_ccw,
            color: Color(0xff454545),
          ),
        ),
      ),
    );
    ;
  }
}
