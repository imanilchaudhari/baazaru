/************************************************************************ */
/* FILE TITLE : pages/publish.js                                     
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

import React, { Component } from 'react';
import {
  Alert,
  Image,
  TextInput,
  TouchableHighlight,
  Keyboard,
  TouchableWithoutFeedback,
} from 'react-native'; // Import React-Native elements

import {
    Container, // *
    Header, // *
    Title, // *
    Text, // *
    Icon, // *
    Left, // *
    Right, // *
    Body, // *
    View, // *
    Button, // *
  } from "native-base"; // Import native base elements

import { ImagePicker } from 'expo'; // Take a picture
import { FormLabel, FormInput, FormValidationMessage, Divider } from 'react-native-elements';
import DropdownAlert from 'react-native-dropdownalert'; // Alert component


import firebase from 'firebase'; // Import Firebase login
import { firebaseConfig } from '../../config'; // Import of Firebase config


import styles from "./styles"; // Import styles


class Publish extends Component {

    // Use constructor to store offer, description, localUri and filename. 
    constructor(){
      super();
      this.state = {
        share : false, // Share button
        offer : "", 
        description : "", 
        localUri : null, 
        filename : "", 
        result : "", 
        user : null,
        announceNumber : 0,
        price : 0,
        photo : "",
      };
     }

    static navigationOptions = {
      gesturesEnabled: false,
      swipeEnabled: false, 
    };

     componentWillMount() { // Only for test purpose TO BE REMOVED
      console.log(this.props.navigation.state.params.section)
    }


/********************************************/
/* Function : takePhoto                  
/* Action : Open the camero to take a picture
/* Return: Take a picture with camera and return the path to the render "fileUri".
/* Comment: However for the moment the image upload still need to be implemented.            
/********************************************/  
  takePhoto = async () => {
    
    // Display the camera to the user and wait for them to take a photo or to cancel
    let newphoto = await ImagePicker.launchCameraAsync({
      allowsEditing: true,
      aspect: [4, 3],
    });
    this.setState(
    {
     result: newphoto
    }
    )

    if (this.state.result.cancelled) {
      return;
    }
  
    // ImagePicker saves the taken photo to disk and returns a local URI to it
    this.setState(
      {
        filename: this.state.result.uri.split('/').pop(),
        localUri: this.state.result.uri
      }
    )
    // Infer the type of the image
    let match = /\.(\w+)$/.exec(this.state.filename);
    let type = match ? `image/${match[1]}` : `image`;
    
    //Debug
    console.log(this.state.result.uri)
    console.log(this.state.filename)
    console.log(this.state.localUri)

  }
  // Take a picture from the camera roll and return the path to the render "fileUri".

  
/********************************************/
/* Function : pickImage                  
/* Action : Get URI of a picture from the library
/* Return: Image URI.
/* Comment: However for the moment the image upload still need to be implemented.            
/********************************************/  
  pickImage = async () => {
    // Display the camera to the user and wait for them to take a photo or to cancel
    // the action
    let newphoto = await ImagePicker.launchImageLibraryAsync({
      allowsEditing: true,
      aspect: [4, 3],
    });
    this.setState(
    {
     result: newphoto
    }
    )
    uploadImageAsync(newphoto)

    if (this.state.result.cancelled) {
      return;
    }
  
    // ImagePicker saves the taken photo to disk and returns a local URI to it
    this.setState(
      {
        filename: this.state.result.uri.split('/').pop(),
        localUri: this.state.result.uri
      }
    )
    // Infer the type of the image
    let match = /\.(\w+)$/.exec(this.state.filename);
    let type = match ? `image/${match[1]}` : `image`;
    
    console.log(this.state.result.uri)
    console.log(this.state.filename)
    console.log(this.state.localUri)

  }

  
/********************************************/
/* Function : func_generateKey                  
/* Action : Function that generates a random ID for the post
/* Return: this.state.announceNumber
/* Comment: We use .then to wait that the data is downloaded before proceeding.  
/********************************************/  
  func_generateKey = async () => {
    return this.state.announceNumber = await firebase.database().ref(this.props.navigation.state.params.section).push().key // Return serve as a promise to wait 
  }

/********************************************/
/* Function : func_uploadOffer                  
/* Action : Function that get datas from the form and upload them
/* Return: 
/* Comment:  
/********************************************/
  func_uploadOffer = async (announceNumberInc, uid) => {

    const const_titleLength = 4;
    const const_descriptionLength = 6;
    const const_priceMin = 1;

    //Check content filled by users 
    if (this.state.offer.length < const_titleLength) {
      this.dropdown.alertWithType(
        "error",
        "Error",
        "Enter a valid title (more than "+ const_titleLength +" characters)."
      );
      return;
    }

    if (this.state.description.length < const_descriptionLength) {
      this.dropdown.alertWithType(
        "error",
        "Error",
        "Enter a valid description (more than "+const_descriptionLength+" characters)."
      );
      return;
    }

    if (this.state.price < const_priceMin) {
      console.log(this.state.price);
      if(this.state.price == 0)
      {
        this.state.price = "Free";
        console.log("Free : "+ this.state.price)
        return;
      }
      else{
        this.dropdown.alertWithType(
          "error",
          "Error",
          "Enter a valid price or 0 if the item is free"
        );
        return;
      }
    }      
      
    //Assign content to variabe
    let date = String(new Date()) // get current date and transform it into a String
    //let userUID = this.state.user // get user id
    let offer = this.state.offer // get offer title
    let description = this.state.description // get description
    let price = this.state.price // get price


    //DEBUG CODE
        console.log("           --------------------------------           ")
        console.log("Publishing of the announce n°" + announceNumberInc)
        console.log("Date: " + date)
        console.log("Offer title: " + offer)
        console.log("Description: " + description)
        console.log("Price: " + price + " CHF")
        console.log("User UID: " + uid)
    //END DEBUG CODE
        
    //Upload announce and then redirect user to OfferDisplay
    try {
      // write announces properties to firebase
      firebase.database().ref(this.props.navigation.state.params.section + '/' + announceNumberInc).set({
        date,
        offer,
        description,
        price,
        uid,
        
      })
    .then(() => this.props.navigation.navigate("OfferDisplay", {section: this.props.navigation.state.params.section}));

    }
    catch (error) {
      console.log(error);
      this.dropdown.alertWithType("error", "Error", String(error));
    }
  }

/********************************************/
/* Function : func_fetchAndUpload()                  
/* Action : Function called on User click for the upload
/* Return: 
/* Comment:  
/********************************************/
  func_fetchAndUpload() {
      this.setState({ share: !this.state.share }); // Disable the Share button
      console.log(this.state.share)
      this.func_generateKey() // Retreive the number of announces 
      .then (() => this.func_uploadOffer(this.state.announceNumber, firebase.auth().currentUser.uid)) // Add one to the number of offers and post it.
      .then (() => this.setState({ share: !this.state.share })) // Enable the Share button after request
    }

  
render() {
  return (
    <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
    <Container style={styles.container}>
      <Header 
          style={styles.Header}
					androidStatusBarColor='#6FAF98'
					backgroundColor='#6FAF98'>
              <Left>
                  <Button
                  transparent
                  light
                  onPress={() => this.props.navigation.navigate("OfferDisplay", {section: this.props.navigation.state.params.section})}
                  >
                  <Icon name="ios-arrow-back" color= 'white' />
                  </Button>
              </Left>
              <Body>
                    <Title>New {this.props.navigation.state.params.section}</Title> 
              </Body>
                  <Right/>
      </Header>
      
      <View> 
        <FormLabel>What are you offering?</FormLabel>
        <FormInput
          multiline
          style={{height: 60,
          backgroundColor:'#dcdcdc'}}
          value={this.props.offer}
          placeholder='Books, flats, events etc...'
          onChangeText={(offer) => this.setState({offer : offer})}

        />
      </View>
      <View>
        <FormLabel>Enter Description Here</FormLabel>
        <FormInput
          multiline
          style={{height: 100,
          backgroundColor:'#dcdcdc'}}
          value={this.props.description}
          placeholder='Description of what you propose'
          onChangeText={(description) => this.setState({description : description})}
          
        />
      </View>
      <View>
        <FormLabel>How much does it cost? (enter 0 for free item)</FormLabel>
        <FormInput
        keyboardType={'phone-pad'}
        style={{height: 50,
        backgroundColor:'#dcdcdc'}}
        value={this.props.price}
        placeholder='CHF'
        onChangeText={(price) => this.setState({price : price})}
        
          />
      </View>
      <View style={{flex: 1, flexDirection: 'row', justifyContent: 'space-around'}}>
      <Button
            onPress={() => {this.takePhoto(); }}
            rkType='large'
            style={styles.save1Publish}>
            <Text>Take Picture</Text>
            
      </Button>
      <Button
            onPress={() => {this.pickImage(); }}
            rkType='large'
            style={styles.save1Publish}>
            <Text>Choose Picture</Text>
      </Button>
     
  </View>
  <View style={{flex: 1, flexDirection: 'row', alignItems: 'center', marginLeft: 135, bottom: 50}}>
       <Image
        style={styles.image}
        source={this.state.localUri ? {uri: this.state.localUri} : null}
      /> 
      </View>
      <Button 
            position='absolute'
            bottom='0'
            alignSelf='flex-end'
            block success
            disabled={this.state.share}
            onPress={() => this.func_fetchAndUpload() }
            >
            <Text>Share</Text>
      </Button>
     


      <DropdownAlert ref={ref => this.dropdown = ref}/>
    </Container>
    
    </TouchableWithoutFeedback>
    
  );
}
}


export default Publish;