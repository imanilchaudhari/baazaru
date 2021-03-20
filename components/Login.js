import React, { Component } from 'react';
import firebase from 'firebase'; // Import Firebase login
import { firebaseConfig } from '../config'; // Import of Firebase config
import { emailChanged, passwordChanged, loginUser, errorSet } from './actions'; // Need to be explained
import {
  Alert,
  AppRegistry,
  ListView,
  Image,
  StyleSheet,
  Text,
  TextInput,
  TouchableHighlight,
  View,
} from 'react-native'; // Import React-Native elements
import { // Import React-Native UI Kitten Design
  RkButton,
  RkText,
  RkTextInput,
  RkAvoidKeyboard,
  RkStyleSheet,
  RkTheme
} from 'react-native-ui-kitten';
import { connect } from 'react-redux'; // Probably not useful
  
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#ddd',
  },
  title: {
    marginTop: 40,
    marginBottom: 10,
    fontSize: 20,
    fontWeight: 'bold',
  },
  reloadButton: {
    fontSize: 16,
    fontWeight: 'bold',
    backgroundColor: 'blue',
    color: 'white',
    padding: 10,
  },
  loginField: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    margin: 10,
    padding: 10,
    backgroundColor: 'white',
  },
  passwordField: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    margin: 10,
    padding: 10,
    backgroundColor: 'white',
  },
  listView: {
    alignSelf: 'stretch',
    backgroundColor: 'white',
  },
  listViewRow: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    height: 50,
  },
  rowName: {
    padding: 10,
    fontSize: 16,
  },
  rowTemperature: {
    padding: 10,
    fontSize: 16,
  },
  save: {
    marginVertical: 9
  },
  image: {
    width: 200,
    height: 200
  },
});

export default class Login extends Component {

    // Use constructor to store email and password. 
    constructor(){
      super();
      this.state = {isLoggedIn : false, email :"", password : ""};
     }


  // Sending for login to "loginUser" function
  onButtonPress = async () => { // The "async" serve for the await function

    console.log('Login button pressed');
      // const { email, password } = this.props;
      // this.props.loginUser({ email, password });
      try {
        //const email = "testtest@gmail.com"
        //const password = "testtest"
        console.log(this.state.email)
        console.log(this.state.password)
        let user = await firebase.auth().signInWithEmailAndPassword(this.state.email, this.state.password); // Should be "user = await fire..."
        console.log('User successfully logged');
        // loginUserSuccess(dispatch, user);
      }
      catch (error) {
        console.log(error);
        let err_message = error.message;
        // loginUserFail(dispatch, err_message);
      }
  }

// Reset the password based on the email
  onResetButtonPress = async () => {
    console.log("Reset button pressed")

    try {
      console.log(this.state.email)
      await firebase.auth().sendPasswordResetEmail(this.state.email)
      console.log(reset)
    }
    catch (error) {
      console.log(error)
      let err_message = error.message
    
    }
  }

  // Visual container and text 
  render() {
    return (
      <View style={styles.container}>

        <Image
          style={styles.image}
          source={require('./assets/logo.png')}
        />



        <RkTextInput // Login field
          rkType='rounded'
          placeholder='Email'
          value={this.props.email}
          onChangeText={(email) => this.setState({email : email})}
        />



        <RkTextInput // Password field
          rkType='rounded'
          placeholder='Password'
          secureTextEntry={true}
          value={this.props.password}
          secureTextEntry={true}
          onChangeText={(password) => this.setState({password : password})}
        />

        <RkButton
              onPress={() => { this.onButtonPress(); }}
              rkType='large'
              style={styles.save}>
              LOGIN
        </RkButton>

        <RkButton
              onPress={() => { this.onResetButtonPress(); }}
              rkType='large'
              style={styles.save}>
              RESET PASSWORD
        </RkButton>
             

      </View>
    );
  }
}

AppRegistry.registerComponent('login', () => Login);
//
// test