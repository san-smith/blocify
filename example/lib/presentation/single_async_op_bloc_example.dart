import 'package:blocify/blocify.dart';
import 'package:example/data/api/model/user.dart';
import 'package:example/data/repository/user_repository.dart';
import 'package:example/internal/repository_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleAsyncOpExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingleAsyncOpExampleState();
}

class _SingleAsyncOpExampleState extends State<SingleAsyncOpExample> {
  TextEditingController _controller = TextEditingController();
  // Object that can call async request
  UserRepository _repository = RepositoryModule.userRepository();

  // Create bloc
  SingleAsyncOpBloc<User> _bloc = SingleAsyncOpBloc();

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _findUser() {
    if (_controller.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      // Send the event with an async request
      _bloc.add(
          SingleAsyncOpRequestEvent(_repository.getUser(_controller.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('SyngleAsyncOp Example'),
        ),
        body: _getBody(),
      ),
    );
  }

  Widget _getContent() {
    return BlocBuilder<SingleAsyncOpBloc<User>, SingleAsyncOpState<User>>(
      bloc: _bloc,
      builder: (context, state) {
        // Use state for updating UI
        if (state is SingleAsyncOpLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SingleAsyncOpReadyState<User>) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20),
            child: _getUserInfo(state.data),
          );
        }
        if (state is SingleAsyncOpErrorState) {
          return Center(
            child: Text('''Can't find user "${_controller.text}"'''),
          );
        }
        return Container();
      },
    );
  }

  Widget _getUserInfo(User user) {
    return Column(
      children: <Widget>[
        if (user.avatarUrl.isNotEmpty)
          Image.network(
            user.avatarUrl,
          ),
        SizedBox(height: 15),
        Text(
          user.login,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (user.name.isNotEmpty) ...[
          SizedBox(height: 15),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ],
        if (user.location.isNotEmpty) ...[
          SizedBox(height: 15),
          Text(
            user.location,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
        if (user.bio.isNotEmpty) ...[
          SizedBox(height: 15),
          Text(
            user.bio,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
        SizedBox(height: 15),
        Text(
          'Repos: ${user.publicRepos}',
          style: TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget _getSearch() {
    return TextField(
      controller: _controller,
      autocorrect: false,
      autofocus: false,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'type user name',
        suffix: IconButton(
          icon: Icon(Icons.search),
          onPressed: _findUser,
        ),
      ),
    );
  }

  Widget _getBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getSearch(),
          SizedBox(height: 15),
          Expanded(child: _getContent()),
        ],
      ),
    );
  }
}
