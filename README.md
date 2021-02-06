# Meta2Json
Create a json file for a Medium Post containing a filtered list of data. The tool requires the URL to your post, an optional second parameter can point to the output path for the JSON data.

# Compile
Using dart AOT you can create a standalone application:

```dart compile exe bin/meta2json.dart ```

See https://dart.dev/tools/dart2native

# Example

meta2json "https://medium.com/better-programming/engage-your-development-team-e2bcb27d5632" "/home/user/mypost.json"
