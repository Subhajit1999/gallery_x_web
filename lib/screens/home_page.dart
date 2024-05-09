import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:online_photo_gallery/components/image_card.dart';
import 'package:online_photo_gallery/config.dart';
import 'package:online_photo_gallery/controllers/gallery_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic> _queryParams = {};
  static int _page = 1;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {      // Initial Callback
      galleryController.loading.value = true;
      if(galleryController.searchQuery.value.isNotEmpty) {
        _queryParams['q'] = galleryController.searchQuery.value;
        _searchController.value = TextEditingValue(text: _queryParams['q'].replaceAll('+', ' '));
      }
      await galleryController.fetchImages(_queryParams);
      galleryController.loading.value = false;
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    galleryController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Lazy Loading on detecting scroll end
  void _scrollListener() {
    if (scrollController.position.extentAfter == 0) {
      print("Reached to the end");
      galleryController.loading.value = true;
      _page++;
      _queryParams["page"] = _page;
      _queryParams["per_page"] = PER_PAGE_RESULT_COUNT;
      galleryController.fetchImages(_queryParams);
      galleryController.loading.value = false;
    }
  }

  // Search By Query
  Future<void> _handleSearch(String query) async {
    galleryController.clearImageList();

    if (query.isEmpty) {
      // all images data
      _queryParams = {};
    } else {
      _queryParams['q'] = query.toLowerCase().replaceAll(' ', '+');
      galleryController.searchQuery.value = _queryParams['q'];
    }
    galleryController.loading.value = true;
    await galleryController.fetchImages(_queryParams);
    galleryController.loading.value = false;
  }

  // Search Field Widget
  Widget _searchField() => Container(
        width: isMobileScreen(context)? screenSize(context).width * 0.5 : screenSize(context).width * 0.25,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(
              fontSize: 12,
              color: matteBlackColor,
              fontWeight: FontWeight.w600),
          maxLines: 1,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) => _handleSearch(value),
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search_rounded,
                size: 20,
              ),
              contentPadding: const EdgeInsets.all(10),
              hintText: "Search Here",
              counterText: '',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4))),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          APP_NAME,
          style: TextStyle(
              color: SECONDARY_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          // SEARCH FIELD
          _searchField(),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: galleryController.loading.value
          ? const Center(
            child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: SECONDARY_COLOR,
                )),
          )
          : Obx(() => GridView.builder(
                controller: scrollController,
                itemCount: galleryController.imageList.length,
                padding: const EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenSize(context).width ~/ 250,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => context.go(
                        '/image/${galleryController.imageList[index].id}',
                        extra: galleryController.imageList[index]),
                    child: ImageCard(
                      imageUrl: galleryController.imageList[index].webformatUrl,
                      likes: galleryController.imageList[index].likes,
                      views: galleryController.imageList[index].views,
                    ),
                  );
                },
              )),
    );
  }
}