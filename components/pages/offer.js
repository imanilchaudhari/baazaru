
/************************************************************************ */
/* FILE TITLE : pages/offer.js                                     
/* FILE AIM :                                                             
/*            1.Get datas from offerDisplay.js
/*            2.Display offers' details                         
/*                                                                        
/* Input : uid of user that added the offer from this.props.navigation.state.params.uid    
/*                                                                        
/* Exported functions:                                                    
/*                                                                        
/*                                                                        
/* Exported Variables:                                                    
/*                                                                        
/* DOCUMENTATION USED:                                                    
/*                                                                       */
/**************************************************************************/

import React, { Component } from 'react';

import styles from "./styles"; // Import styles

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
    Button, //*
    Content, //*
    Card, //*
    CardItem, // *
  } from "native-base"; // Import native base elements

import firebase from 'firebase'; // Import Firebase login
import { email, text, phonecall } from "react-native-communications"; // TO be used to send Feedback
class Offer extends Component {

  constructor(){
    super();
    this.state = {
      phoneNumber:"", 
      email:"",
      displayName:"",
    };
   }


  componentWillMount() {

    this.func_getFromDb()
    .then(() => this.forceUpdate())
  }
  

/********************************************/
/* Function : func_getFromDb                  
/* Action : Get user email and phoneNumber
/* Return: Take a picture with camera and return the path to the render "fileUri".
/* Comment: However for the moment the image upload still need to be implemented.            
/********************************************/  
func_getFromDb = async () => {
    // Get user mail and phoneNumber
    await firebase.database().ref('users/' + this.props.navigation.state.params.uid +'/userDetails').once('value')
    .then(function(snapshot){
    var_tempSnapshot_mail = snapshot.child("email").val();
    })
    .then (() => this.state.email = var_tempSnapshot_mail) // Wait for data before assigning the value to "announceNumber"
    .then (() => console.log(this.state.email));
    
    await firebase.database().ref('users/' + this.props.navigation.state.params.uid +'/userDetails').once('value')
    .then(function(snapshot){
    var_tempSnapshot_phone = snapshot.child("phoneNumber").val();
    })
    .then (() => this.state.phoneNumber = var_tempSnapshot_phone) // Wait for data before assigning the value to "announceNumber"
    .then (() => console.log(this.state.phoneNumber));

    }


      
      render() {
        return (
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
                         <Title>{this.props.navigation.state.params.section} Offer</Title> 
                    </Body>
                        <Right/>
            </Header>

            <Content padder>
            <Card>
            <CardItem Header>
              <Text><Title>Title: {this.props.navigation.state.params.offer}</Title></Text>
            </CardItem>
            <CardItem>
              <Body>
                  <Text>Description: {this.props.navigation.state.params.description}</Text>
              </Body>
            </CardItem>
            <CardItem>
              <Body>
              <Text>Date: {this.props.navigation.state.params.date}</Text>
              </Body>
            </CardItem>
            <CardItem footer>
              <Text>Price: {this.props.navigation.state.params.price}.- CHF</Text>
            </CardItem>
            </Card>
           
            <Card> 
            <CardItem Header>
              <Text><Title>Contact: </Title></Text>
            </CardItem>
            <CardItem>
              <Body>
                <View style={{flex: 1, flexDirection: 'row'}}>
                      <Button
                          onPress={() => {
                          email(
                          [this.state.email],
                          null,
                          null,
                          `Contact for <${this.props.navigation.state.params.offer}>`,
                          null
                         );
                        }}>
                          <Text>By mail</Text>
                      </Button>
                      </View>
              </Body>
              <Body>
                <View style={{flex: 1, flexDirection: 'row'}}>
                      <Button onPress={() => {text(String(this.state.phoneNumber),`Contact for <${this.props.navigation.state.params.offer}>`)}}>
                          <Text>By SMS</Text>
                       </Button>
                </View>
                </Body>
                <Body>
                  <View style={{flex: 1, flexDirection: 'row'}}>
                      <Button onPress={() => {phonecall(String(this.state.phoneNumber),true);}}>
                          <Text>By phone</Text>
              
                      </Button>
                  </View>
                  </Body>
            </CardItem>
           
            </Card>
            </Content>   

            



          </Container>
          );
      }
    }
    
    
    export default Offer;