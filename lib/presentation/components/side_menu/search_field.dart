import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchField extends HookWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return TextField(
      controller: controller,
      onChanged: (value) {
        context.read<AppBloc>().add(AppEventSearch(value));
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        hintText: "Search routes",
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
        prefixIcon: _buildIconButton(
          onTap: () {
            context.read<AppBloc>().add(AppEventGoToBack());
          },
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
              onTap: () {
                controller.clear();
                context.read<AppBloc>().add(AppEventSearch(""));
              },
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
