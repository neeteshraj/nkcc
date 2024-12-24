import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/home/presentation/widgets/search_bar.dart';
import 'package:support/features/home/presentation/widgets/top_bar.dart';
import 'package:support/features/startup/presentation/bloc/translations_cubit.dart';
import 'package:support/features/startup/presentation/bloc/translations_state.dart';
import 'package:support/features/home/presentation/widgets/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeUtils.getHeight(context, 0.06)),
        child: BlocBuilder<TranslationsCubit, TranslationsState>(
          builder: (context, state) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SafeArea(
                child: TopBar(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchBar(
              controller: searchController,
              focusNode: _focusNode,
              onSearchChanged: (query) {
                debugPrint('Search query: $query');
              },
              onSettingsPressed: () {
                debugPrint('Settings pressed');
              },
            ),
            const SizedBox(height: 16),
            // Render the CategoryWidget here
            const Expanded(
              child: CategoryWidget(),
            ),

          ],
        ),
      ),
    );
  }
}
