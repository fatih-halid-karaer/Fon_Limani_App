import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API{
  final String api_key = "s67fd6sg67asd67g4sdd3gahfgsdl26875768dfasfsf78sdg78s8g89l568";
  final String apiUrl = 'http://172.16.59.204:8000/';
  Map<String, dynamic>data1 = {};
  late bool data;
  List<dynamic> data2 = [];
  /*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();
    getAllNews();
    getAllFunds();
    getAllUserPortfolios();
    getAllMessages();
    // addMessage("title", "body", "email");
    // addFund("history", "fund_code", "fund_title", "umbrella", 10, 20, 5, [1,2,4]);
    // addUser("username", "password", "karaerfatihalid@gmail.com");
    getUser(0);
    // getFund(0);
    //getMessage(1);
    //  deleteMessage(2);
    //loginUser("fatihalid", "galata");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter HTTP Request Example'),
      ),
      body: Center(

      ),
    );
  }
  */

//FUND

  Future<void> getAllFunds() async {
    final String query_add = 'funds/get_all_funds';
    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          'api_key': api_key,
        },
      );

      if (response.statusCode == 200) {

        print("Fund details: ${jsonDecode(response.body)}");
        // Handle the data as needed
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error, e.g., show an error message to the user
    }
  }

  Future<void> addFund(String history,String fund_code,String fund_title,String umbrella,double price,int number_of_shares_in_circulation,double fund_total_value,int num_invest) async {
    final String query_add = 'funds/add_fund?history=$history&fund_code=$fund_code&fund_name=$fund_title&price=$price&number_of_shares_in_circulation=$number_of_shares_in_circulation&num_investors=$num_invest&fund_total_value=$fund_total_value';
    try {
      final response = await http.post(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("Fund details: ${jsonDecode(response.body)}");
      } else {
        print("Failed to add fund. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getLastMonthFund(String fund) async {
    final String query_add = 'funds/get_last_month_data?value=$fund&by=fund_code';
    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("Fund details: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get fund. Status code: ${response.statusCode}  Details : ${response.body}");
      }
    }catch(e){
      print("Error : $e");
    }
  }



  Future<void> getFund(int fundId) async {
    final String query_add = 'funds/get_fund/$fundId';
    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("Fund details: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get fund. Status code: ${response.statusCode}  Details : ${response.body}");
      }
    }catch(e){
      print("Error : $e");
    }
  }


  Future<void> updateFund(int fundId, Map<String, dynamic> updateData) async {
    final String query_add = "funds/update_fund/$fundId";
    try {
      final response = await http.put(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {

        print("Fund updated successfully");
      } else {
        print("Failed to update fund. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }


  Future<void> deleteFund(int fundId) async {
    final String query_add = "funds/delete_fund/$fundId";
    try {
      final response = await http.delete(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",

          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("Fund deleted successfully");
      } else {
        print("Failed to delete fund. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }
  Future<void> getLast_n_Reports(int n) async {
    final String query_add = "funds/get_last_n_reports?n=$n";

    final response = await http.get(
      Uri.parse(apiUrl + query_add),
      headers: {
        'Content-Type': 'application/json',
        'api_key': '$api_key',
      },
    );
    if (response.statusCode == 200) {
      print("Reports  : ${jsonDecode(response.body)}");
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<String> getAllReports() async {
    final String query_add = "funds/get_all_reports";

    final response = await http.get(
      Uri.parse(apiUrl + query_add),
      headers: {
        'Content-Type': 'application/json',
        'api_key': '$api_key',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

//USER
  Future<void> addUser(String username, String password, String email, {String name = "", bool verified = false, bool subscription = false, String? subscriptionEndDate}) async {
    final String query_add = 'users/add_user?username=$username&password=$password&email=$email&verified=false&subscription=false';

    try {
      final response = await http.post(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",

          "api_key": "$api_key",
        },

      );

      if (response.statusCode == 200) {

        print("User added successfully");
      } else {
        print("Failed to add user. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> getUser(int value, {String by = "_id"}) async {
    final String query_add = 'users/get_user?value=$value&by=_id';
    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("User details: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get user. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> getAllUsers() async {
    final String query_add = 'users/get_all_users';
    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("All users: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get all users. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }


  Future<void> updateUser(int userId, Map<String, dynamic> data) async {
    final String query_add = 'users/update_user/$userId';
    try {
      final response = await http.put(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print("User updated successfully");
      } else {
        print("Failed to update user. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> deleteUser(int userId) async {
    final String query_add = 'users/delete_user/$userId';
    try {
      final response = await http.delete(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("User deleted successfully");
      } else {
        print("Failed to delete user. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }
  //PORTFOLİO
  Future<void> addUserPortfolio(dynamic funds, dynamic portions) async {
    final String query_add = 'user_portfolios/add_user_portfolio?funds=$funds&portions=$portions';

    try {
      final response = await http.post(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
        body: jsonEncode({
          "funds": funds,
          "portions": portions,
        }),
      );

      if (response.statusCode == 200) {

        print("User portfolio added successfully");
      } else {
        print("Failed to add user portfolio. Status code: ${response.statusCode}");
      }
    }  catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> getUserPortfolio(int portfolioId) async {
    final String query_add = 'user_portfolios/get_user_portfolio/$portfolioId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("User portfolio details: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get user portfolio. Status code: ${response.statusCode}");
      }
    }  catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> getAllUserPortfolios() async {
    final String query_add = 'user_portfolios/get_all_user_portfolios';
    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("All user portfolios: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get all user portfolios. Status code: ${response
            .statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> updateUserPortfolio(int portfolioId, Map<String, dynamic> updateData) async {
    final String query_add = 'user_portfolios/update_user_portfolio/$portfolioId';

    try {
      final response = await http.put(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {

        print("User portfolio updated successfully");
      } else {
        print("Failed to update user portfolio. Status code: ${response.statusCode}");
      }
    }catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> deleteUserPortfolio(int portfolioId) async {
    final String query_add = 'user_portfolios/delete_user_portfolio/$portfolioId';

    try {
      final response = await http.delete(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("User portfolio deleted successfully");
      } else {
        print("Failed to delete user portfolio. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> loginUser(String username, String password) async {
    final String endpoint = 'users/login?username=$username&password=$password';
    try {

      final response = await http.get(
        Uri.parse(apiUrl + endpoint),
        headers: {
          "Content-Type": "application/json",
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Login successful: $data");
        // Handle the successful login response as needed
      } else {
        print("Login failed. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        // Handle login failure
      }
    } catch (e) {
      print('Error: $e');
      // Handle other errors
    }
  }
  //NEWS

  Future<void> addNews(String newsTitle, String newsInformation, String newsKeywords, String newsEffects) async {
    final String query_add = 'news/add_news?news_title=$newsTitle&news_information=$newsInformation&news_keywords=$newsKeywords&news_effects=$newsEffects';

    try {
      final response = await http.post(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },

      );

      if (response.statusCode == 200) {

        print("News added successfully");
      } else {
        print("Failed to add news. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }
  Future<void> getLastNews(int newsId) async {
    final String query_add = 'news/get_last_n_news?n=$newsId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("News details: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get news. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }
  Future<void> getNews(int newsId) async {
    final String query_add = 'news/get_news/$newsId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("News details: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get news. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> getAllNews() async {
    final String query_add = 'news/get_all_news';

    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("All news: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get all news. Status code: ${response.statusCode}");
      }
    } catch(e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> updateNews(int newsId, Map<String, dynamic> updateData) async {
    final String query_add = 'news/update_news/$newsId';

    try {
      final response = await http.put(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {

        print("News updated successfully");
      } else {
        print("Failed to update news. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> deleteNews(int newsId) async {
    final String query_add = 'news/delete_news/$newsId';

    try {
      final response = await http.delete(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",

          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("News deleted successfully");
      } else {
        print("Failed to delete news. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }
  //MESSAGE
  Future<void> addMessage(String title, String body, String email) async {
    final String query_add = 'messages/add_message?title=$title&body=$body&email=$email';

    try {
      final response = await http.post(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers

          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("Message added successfully");
      } else {
        print("Failed to add message. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> getMessage(int messageId) async {
    final String query_add = 'messages/get_message/$messageId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl +  query_add),
        headers: {
          "Content-Type": "application/json",

          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("Message details: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get message. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> getAllMessages() async {
    final String query_add = 'messages/get_all_messages';

    try {
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("All messages: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get all messages. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> updateMessage(int messageId, Map<String, dynamic> updateData) async {
    final String query_add = "messages/update_message/$messageId";

    try {
      final response = await http.put(
        Uri.parse(apiUrl  +query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {

        print("Message updated successfully");
      } else {
        print("Failed to update message. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> deleteMessage(int messageId) async {
    final String query_add = "messages/delete_message/$messageId";

    try {
      final response = await http.delete(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("Message deleted successfully");
      } else {
        print("Failed to delete message. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  //TOKEN
  Future<void> addToken(int userId, String token) async {
    final String query_add = 'token/add_token?user_id=$userId&token=$token';

    try {
      final response = await http.post(
        Uri.parse(apiUrl + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
        body: jsonEncode({
          "user_id": userId,
          "token": token,
        }),
      );

      if (response.statusCode == 200) {

        print("Token added successfully");
      } else {
        print("Failed to add token. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }

  Future<void> getToken(String value, String by) async {
    final String query_add = "token/get_token?value=$value&by=$by";

    try {
      final response = await http.get(
        Uri.parse(apiUrl  + query_add),
        headers: {
          "Content-Type": "application/json",
          // Include your API key in the headers
          "api_key": "$api_key",
        },
      );

      if (response.statusCode == 200) {

        print("Token details: ${jsonDecode(response.body)}");
      } else {
        print("Failed to get token. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      // TODO
      print("Error : $e");
    }
  }


}
