/************************************************************************ */
/* FILE TITLE : user/registerInfo.js                                     
/* FILE AIM :                                                             
/*            1. 2nd part of the registration process              
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
import { FormLabel, FormInput, FormValidationMessage, Button } from 'react-native-elements';

import { // Import React-Native UI Kitten Design
  RkButton,
} from 'react-native-ui-kitten';
import { connect } from 'react-redux'; // Probably not useful
import DropdownAlert from 'react-native-dropdownalert'; // Alert component
import validator from "validator"; // Use to validate the forms

import styles from "./styles";



export default class RegisterInfo extends Component {

    static navigationOptions = {
        title: 'Account information'
      };
    
    // Use constructor to store email and password. 
    constructor(){
      super();
      this.state = {phone: "", lastname :"", firstname : ""};
    }

/********************************************/
/* Function : func_onNextButton             
/* Action : Navigate to next page in the registration process      
/* Return: -                                
/********************************************/
  func_onNextButton(){

    if (!this.state.firstname.length) {
      console.log(this.state.firstname.length)
      this.dropdown.alertWithType("error", "Error", "Firstname must be provided.");
      return;
    }
    if (!this.state.lastname.length) {
      this.dropdown.alertWithType("error", "Error", "Lastname must be provided.");
      return;
    }
    if (!this.state.phone.length) {
      this.dropdown.alertWithType(
        "error",
        "Error",
        "Phone number must be provided."
      );
      return;
    }
    if (!validator.isMobilePhone(this.state.phone, 'fr-FR')) {
      this.dropdown.alertWithType(
        "error", 
        "Error", 
        "Supply a correct phone number."
      );
      return;
    }

    this.props.navigation.navigate('Register', {firstname: this.state.firstname, lastname: this.state.lastname, phone: this.state.phone})
  } 
    



  // Visual container and text 
  render() {
    return (
      <ScrollView contentContainerStyle={styles.container}>


        <View style={{ flexDirection: 'row', justifyContent: 'space-around'}} >
        <View style={{flex:1}} > 
          <FormLabel>Enter First Name</FormLabel>
          <FormInput
            value={this.state.firstname}
            placeholder='Maxime'
            onChangeText={(firstname) => {this.setState({firstname}); }}
          />
        </View>
        <View style={{flex:1}} >
          <FormLabel>Enter Last Name</FormLabel>
          <FormInput
            value={this.state.lastname}
            placeholder='Schmit'
            onChangeText={(lastname) => {this.setState({lastname}); }}

          />
        </View>
        </View>
      
        <FormLabel>Enter Phone Number</FormLabel>
        <FormInput
          value={this.state.phone}
          style={styles.phone}
          placeholder='0712345678'
          textAlign='center'
          keyboardType={'phone-pad'}
          onChangeText={(phone) => {this.setState({phone}); }}
          blurOnSubmit
        />

        <FormLabel>  </FormLabel>

        <RkButton
              onPress={() => this.func_onNextButton()}
              rkType='rounded'
              style={styles.save}>
              PROCEED
        </RkButton>
        <DropdownAlert ref={ref => this.dropdown = ref}/>
      </ScrollView>
    );
  }
}

AppRegistry.registerComponent('RegisterInfo', () => RegisterInfo);