import 'package:flutter/material.dart';
import 'package:gareda/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(context: context, widget: WebViewScreen(url: article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: (article['urlToImage'] == null ||
                        article['urlToImage'].toString().isEmpty)
                    ? AssetImage('assets/images/news-placeholder.jpg')
                        as ImageProvider
                    : NetworkImage(
                        '${article['urlToImage']}',
                      ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${DateTime.parse(article['publishedAt']).toString().substring(0, DateTime.parse(article['publishedAt']).toString().length - 8)}',
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      height: 2,
      width: double.infinity,
      color: Colors.grey,
    ),
  );
}

Widget defaultFormField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?) onValidate,
  required void Function(String?) onChange,
  Function()? onTap,
  required String labelText,
  required IconData prefixIcon,
  bool isReadOnly = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    readOnly: isReadOnly,
    style: Theme.of(context).textTheme.bodyText1,
    decoration: InputDecoration(
      hintText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText1,
      prefixIcon: Icon(
        prefixIcon,
        color: Theme.of(context).appBarTheme.iconTheme!.color,
        size: Theme.of(context).appBarTheme.iconTheme!.size,
      ),
      border: OutlineInputBorder(borderSide: BorderSide.none),
    ),
    validator: onValidate,
    onChanged: onChange,
    onTap: onTap,
  );
}

void navigateTo({required BuildContext context, required Widget widget}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
    );
