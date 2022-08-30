import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<AppBloc>().add(AppEventSearch(value));
      },
      decoration: InputDecoration(
        hintText: "Search routes",
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
        prefixIcon: _buildIconButton(
          onTap: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIconButton(
              onTap: () {},
              icon: const Icon(Icons.search),
            ),
            Container(
              height: 20,
              width: 1,
              color: Colors.grey,
            ),
            _buildIconButton(
              onTap: () {},
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required Widget icon,
    VoidCallback? onTap,
  }) {
    const padding = EdgeInsets.all(defaultPadding * 0.75);

    return Container(
      margin: const EdgeInsets.all(defaultPadding / 2),
      decoration: const BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: icon,
        ),
      ),
    );
  }
}
