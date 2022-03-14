class Queries {
  static String country() {
    return '''
    query {
      countries {
        name
        emoji
        native
        capital
        emojiU
        currency
        languages {
          code
          name
        }
      }
    }
  ''';
  }

  static String language() {
    return '''
    query Query {
      languages {
        name
        code
      }
    }
  ''';
  }

  static String searchByCode({String? lgCode}) {
    return '''
    query Query {
      country(code: "$lgCode") {
      name
      emoji
      native
      capital
      emojiU
      currency
      }
    }
  ''';
  }
}
