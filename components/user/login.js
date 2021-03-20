/************************************************************************ */
/* FILE TITLE : user/login.js                                     
/* FILE AIM :                                                             
/*            1.Ask for user's data
/*            2.Check if user exists and login
/*            3.Also offer the possibility to create an account and reset password                   
/*                                                                        
/* Input     
/*                                                                        
/* Exported functions:                                                    
/*                                                                        
/*                                                                        
/* Exported Variables:                                                    
/*                                                                        
/* DOCUMENTATION USED:                                                    
/*                                                                       */
/**************************************************************************/

import React, { Component, PropTypes } from 'react';
import firebase from 'firebase'; // Import Firebase login
import { firebaseConfig } from '../../config/firebase_config.js'; // Import of Firebase config
import {
  Alert,
  AppRegistry,
  ListView,
  Image,
  StyleSheet,
  Text,
  TextInput,
  TouchableHighlight,
  TouchableOpacity, // Used for the "regiter button" width
  View,
  Dimensions // Used for the "regiter button" width
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
import { TabNavigator, StackNavigator } from 'react-navigation'; // Navigation components
// NEED TO USE REACT NAVIGTION 
import DropdownAlert from 'react-native-dropdownalert'; // Alert component

import styles from "./styles";

export default class Login extends Component {  

  // Use constructor to store email and password. 
  constructor(){
    super();
    this.state = {isLoggedIn : false, email :"", password : ""};
   }


// Remove the navigation header on the login screen
  static navigationOptions = {
    header: null
  };

/********************************************/
/* Function : func_onNavPress             
/* Action : Navigate to desired page from page name input               
/* Return: -                                
/********************************************/
  func_onNavPress = (screenname) => {
    this.props.navigation.navigate(screenname);
  };


/********************************************/
/* Function : func_onLoginPress             
/* Action : Call func_getData               
/* Return: -                                
/********************************************/
  // Sending for login to "loginUser" function
  func_onLoginPress = async () => { // The "async" serve for the await function


    console.log('Login button pressed');
      // const { email, password } = this.props;
      // this.props.loginUser({ email, password });
      try {
        //const email = "testtest@gmail.com"
        //const password = "testtest"
        console.log(this.state.email)
        console.log(this.state.password)
  
        let user = await firebase.auth().signInWithEmailAndPassword(this.state.email, this.state.password);
        // loginUserSuccess(dispatch, user);
        console.log('User sucessfully logged')
        this.state.isLoggedIn = true
        console.log(user)
        console.log("Custom log")
        if (user) {
          this.dropdown.alertWithType('success', 'Success', "Logged-in");
          //IF LOGIN WORK; REDIRECT TO LOGGEDIN STACK

          this.props.navigation.navigate("Drawer")
        }
      }
      catch (error) {
        console.log(error);
        let err_message = error.message;
        // loginUserFail(dispatch, err_message);
        
        if (err_message) {
          this.dropdown.alertWithType('error', 'Error', err_message);
        }
      }
  }


  // Visual container and text 
  render() {
    return (
      <View style={styles.container}>
        <Image
          style={styles.image}
          source={require('../../assets/images/logo.png')}
        />
        <RkTextInput // Login field
          rkType='rounded'
          autoCorrect={false}
          style={styles.loginField}
          placeholder='Email'
          value={this.props.email}
          returnKeyType="next"
          onChangeText={(email) => this.setState({email : email})}
        />
        <RkTextInput // Password field
          rkType='rounded'
          placeholder='Password'
          style={styles.loginField}
          secureTextEntry={true}
          value={this.props.password}
          onChangeText={(password) => this.setState({password : password})}
          blurOnSubmit
          returnKeyType="send"
          onSubmitEditing={() => this.func_onLoginPress()}
        />
        <RkButton // Login button 
              rkType='rounded'
              onPress={() => { this.func_onLoginPress(); }}
              style={styles.saveLogin}>
              LOGIN
        </RkButton> 
        <Text // Reset password
              onPress={() => this.func_onNavPress('ResetPassword')}
              rkType='large'
              style={styles.saveLogin}>
              Reset password
        </Text>
        <TouchableOpacity // Register button
          onPress={() => this.func_onNavPress('RegisterInfo')}
          style={styles.registerContainer}
          >
          <Text style={styles.registerText}>
            Don't have an account? Register!
          </Text>
        </TouchableOpacity>
        <DropdownAlert ref={ref => this.dropdown = ref}/>
      </View>
    );
  }
}
AppRegistry.registerComponent('Login', () => Login);