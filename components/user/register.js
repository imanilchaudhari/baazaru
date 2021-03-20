/************************************************************************ */
/* FILE TITLE : user/register.js                                     
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
import { firebaseConfig } from '../../config'; // Import of Firebase config
import {
  Alert,
  AppRegistry,
  StyleSheet,
  Text,
  TextInput,
  View,
  ScrollView,
} from 'react-native'; // Import React-Native elements
import { FormLabel, FormInput, FormValidationMessage, Button, Divider, SocialIcon, Icon } from 'react-native-elements';

import { // Import React-Native UI Kitten Design
  RkButton,
} from 'react-native-ui-kitten';
import { connect } from 'react-redux'; // Probably not useful
import DropdownAlert from 'react-native-dropdownalert'; // Alert component
import validator from "validator"; // Use to validate the forms


 import styles from "./styles";


export default class RegisterAccount extends Component {



    static navigationOptions = {
        title: 'Account information'
      };

    // Use constructor to store email and password. 
    constructor(){
      super();
      this.state = {
        isLoggedIn : false, 
        email :"", 
        password : "", 
        firstname :"", 
        lastname : "", 
        phoneNumber : ""};
    }


/********************************************/
/* Function : func_onNavPress             
/* Action : Navigate to desired page from page name input               
/* Return: -                                
/********************************************/
  func_onNavPress = (screenname) => {
    this.props.navigation.navigate(screenname);
    };


/********************************************/
/* Function : func_signupUser             
/* Action :   Sending info to firebase              
/* Return: -                                
/********************************************/ 
  func_signupUser = async () => {

    
    if (!validator.isEmail(this.state.email)) {
      this.dropdown.alertWithType(
        "error", 
        "Error", 
        "Supply a correct email."
      );
      return;
    }
    if (this.state.password.length < 6) {
      this.dropdown.alertWithType(
        "error",
        "Error",
        "The password lenght must be 6 minimum."
      );
      return;
    }
      //var firstname = this.props.navigation.firstname
      //var lastname = this.props.navigation.lastname
      var firstname = this.props.navigation.state.params.firstname
      var lastname = this.props.navigation.state.params.lastname
      
      //DEBUG
      console.log(firstname)
      console.log(lastname)
      var phoneNumber = this.props.navigation.state.params.phone
      var displayName = firstname + ' ' + lastname;
      var email = this.state.email
      var password = this.state.password


      //DEBUG
      console.log(email);
      console.log(password);
      console.log(displayName);
      console.log(phoneNumber);
  
      try {
        let user = await firebase.auth().createUserWithEmailAndPassword(email, password);
        user.updateProfile({ displayName });
        // write user properties to firebase
        firebase.database().ref(`/users/${user.uid}/userDetails`).set({
          email,
          phoneNumber,
          firstname,
          lastname,
          displayName
        });
        console.log(user);
        this.func_onNavPress('Drawer')
        if (user) { // Display success message when logged in.
          this.dropdown.alertWithType('success', 'Success', "Registered");
        }
      }
      catch (error) {
        console.log(error);
        this.dropdown.alertWithType("error", "Error", String(error));
      }
  
  };




  // Visual container and text 
  render() {
    return (
      
      <ScrollView contentContainerStyle={styles.container}>


        <FormLabel>Enter Email</FormLabel>
        <FormInput
          value={this.state.email}
          autoCorrect={false}
          placeholder='maxime.schmit@student.unisg.ch'
          onChangeText={(email) => {this.setState({email}); }}
        />

        <FormLabel>Enter Password</FormLabel>
        <FormInput
          autoCorrect={false}
          value={this.state.password}
          placeholder='•••••••••'
          secureTextEntry={true}
          onChangeText={(password) => {this.setState({password}); }}
          returnKeyType="send"
          onSubmitEditing={() => this.func_signupUser()}
        />

        <FormLabel>  </FormLabel>
        
        <RkButton
              onPress={() => this.func_signupUser()}
              rkType='rounded'
              style={styles.save}>
              CREATE
        </RkButton>
             
        <DropdownAlert ref={ref => this.dropdown = ref}/>
      </ScrollView>
    );
  }
}

AppRegistry.registerComponent('RegisterAccount', () => RegisterAccount);