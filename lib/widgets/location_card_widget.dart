import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/network_data_model.dart';

class NetworkCard extends StatelessWidget {
  final NetworkDataModel data;

  const NetworkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(15.r),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),

            //flag
            leading: data.icon,

            //title
            title: Text(data.title),

            //subtitle
            subtitle: Text(data.subtitle),
          ),
        ));
  }
}
