/************************************************************************ */
/* FILE TITLE : pages/userPage.js                                     
/* FILE AIM :                                                             
/*            1.Get datas filled by the user (Photo to come)                    
/*            2.Generate a random ID for the upload            
/*            3.Upload announces data                       
/*                                                                        
/* Input : section from this.props.navigation.state.params.section;       
/*                                                                        
/* Exported functions:                                                    
/*                                                                        
/*                                                                        
/* Exported Variables:                                                    
/*                                                                        
/* DOCUMENTATION USED:                                                    
/*                                                                        */
/**************************************************************************/


import React, { Component } from "react";
import { 
  Alert, // *
  ScrollView,
  StyleSheet,
  Switch, // *
  Platform,
  TouchableOpacity, // *
  TextInput, // *
 } from "react-native";
import { email } from "react-native-communications"; // TO be used to send Feedback
import {
  Container,
  View, // *
  Header, // *
  Title, // *
  Content,
  Button,
  Icon,
  Text, // *
  Thumbnail,
  Left, // *
  Right, // *
  Body,
  IconNB,
} from "native-base";

import firebase from 'firebase'; // Import Firebase login
import { firebaseConfig } from '../../config/firebase_config.js'; // Import of Firebase config

import DropdownAlert from 'react-native-dropdownalert'; // Alert component // *
import { onSignOut } from "../Auth";


import styles from "./stylesUserPage";





class UserPage extends Component {

  constructor() {
    super();
    this.state = {
      notif: false,
      displayName: '', 
      phoneNumber: '', 
    };
  }


/********************************************/
/* Function : func_getUser             
/* Action : Get connected user name               
/* Return: -                                
/********************************************/
  func_getUser = () => {
    this.state.displayName = firebase.auth().currentUser.displayName
    // + this function should get the phone number and store it in "this.state.phoneNumber"
  };
  
  componentWillMount() {
    this.func_getUser();
  }

  render() {
    return (
      <Container>
      <Header 
        style={styles.Header}
				androidStatusBarColor='#6FAF98'
				backgroundColor='#6FAF98'>
          <Left>
            <Button
              transparent
              light
              onPress={() => this.props.navigation.navigate("DrawerOpen")}
              >
              <Icon name="menu" color='white'/>
            </Button>
          </Left>
          <Body>
            <Title>My Account</Title>
          </Body>
          <Right />
      </Header>
      

      <ScrollView contentContainerStyle={styles.container}>
        <View>
          <View style={styles.sectionHeaderContainer}>
            <Text style={styles.text}>ACCOUNT</Text>
            <View style={styles.sectionHeaderUnderline} />
          </View>
          <View style={styles.fieldContainer}>
            <Text style={styles.text}>Name</Text>
            <TextInput
              style={styles.editableText}
              editable
              autoCorrect={false}
              underlineColorAndroid="transparent"
              //onChangeText={(displayName) => this.setState({displayName})}
              onChangeText={(displayName) => {
                this.setState({displayName})
                if (displayName.trim().length < 4) {
                  this.dropdown.alertWithType('error', 'Error', 'Please enter your full name (more than 4 caracters).');
                  return;
                }
                firebase
                  .auth()
                  .currentUser.updateProfile({
                    displayName: displayName.trim()
                  })
                  .then(() => {
                    firebase
                      .database()
                      .ref("users/"+ firebase.auth().currentUser.uid + "/userDetails")
                      .update({
                        displayName: displayName.trim()
                      });
                  })
                  .catch(error => {
                    this.dropdown.alertWithType("error","Error",error.toString());
                  });
              }}
              onEndEditing={this.func_getUser}
              value={this.state.displayName}
            />
            
          </View>
          <View style={styles.fieldContainer}>
            <Text style={styles.text}>Phone Number</Text>
            <TextInput
              placeholder={"Enter your new phone number here"}
              style={styles.editableText}
              editable
              autoCorrect={false}
              underlineColorAndroid="transparent"
              //onChangeText={(displayName) => this.setState({displayName})}
              onChangeText={(phoneNumber) => {
                this.setState({phoneNumber})
                if (phoneNumber.trim().length !== 10) {
                  this.dropdown.alertWithType('error', 'Error', 'Please enter a correct number (10 digit).');
                  return;
                }
                firebase
                  .auth()
                  .currentUser.updateProfile({
                    phoneNumber: phoneNumber.trim()
                  })
                  .then(() => {
                    firebase
                      .database()
                      .ref("users/"+ firebase.auth().currentUser.uid + "/userDetails")
                      .update({
                        phoneNumber: phoneNumber.trim()
                      });
                  })
                  .catch(error => {
                    this.dropdown.alertWithType("error","Error",error.toString());
                    console.log(error)
                  });
              }}
              onEndEditing={this.func_getUser}
              value={this.state.phoneNumber}
            />

          </View>
          <View style={styles.switchFieldContainer}>
              <Text style={styles.text}>Push notifications</Text>
            <Switch // PUSH NOTIFICATIONS TO BE IMPLEMENTED
              onValueChange={() => this.setState({ notif: !this.state.notif })}
              value={this.state.notif}
            />
          </View>
        </View>
        <View>
          
          <TouchableOpacity
            onPress={() => {
              email(
                ["feedback@baazaru.com"],
                null,
                null,
                `Feedback <${firebase.auth().currentUser.uid}>`,
                null
              );
            }}
            style={styles.fieldContainer}
            >
            <Text style={styles.text}>Send feedback</Text>
          </TouchableOpacity>
            <Text></Text> 

          <TouchableOpacity // LOG OUT TO BE IMPLEMENTED
            onPress={() => {
              Alert.alert(
                Platform.OS === "ios" ? "Log Out" : "Log out",
                "Are you sure? Logging out will remove all data from this device.",
                [
                  {
                    text: "Cancel",
                    onPress: () => {},
                    style: "cancel"
                  },
                  {
                    text: "OK",
                    onPress: () => {
                      firebase.auth().signOut().then(() => this.props.navigation.navigate("SignOut")) // To be add in auth
                      // Cannot make it work with "onSignOut().then(navigation)"
                    }
                  }
                ]
              );
            }}
            style={styles.fieldContainer}
          >
            <Text style={styles.text}>Log out</Text>

          </TouchableOpacity>
          
        
        </View>
      </ScrollView>
      <DropdownAlert ref={ref => this.dropdown = ref}/>
      </Container>
    );
  }
}
export default UserPage;
