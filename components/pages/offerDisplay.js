/************************************************************************ */
/* FILE TITLE : pages/offerDisplay.js                                     
/* FILE AIM :                                                             
/*            1.Get datas from DB of specified section                    
/*            2.Build an array with announces to be display               
/*            3.Display announces using card                              
/*                                                                        
/* Input : section from this.props.navigation.state.params.section;       
/*                                                                        
/* Exported functions:                                                    
/*                                                                        
/*                                                                        
/* Exported Variables:                                                    
/*                                                                        
/* DOCUMENTATION USED:                                                    
/*   https://firebase.google.com/docs/reference/js/firebase.database.DataSnapshot#forEach                                                                      */
/**************************************************************************/

import React, { Component } from "react";
import { Image, Dimensions, TouchableOpacity, ListView, RefreshControl } from "react-native";

import firebase from 'firebase'; // Import Firebase login
import {
  Container, // *
  Header, // *
  Title, // *
  Content, // *
  Button, // *
  Icon, // *
  Card, // *
  List, // *
  CardItem, // *
  Text, // *
  Thumbnail, // *
  Left, // *
  Right, // *
  Body, // *
  IconNB, // *
  Fab, // *
  View, // *
  Spinner, // *
} from "native-base";

import styles from "./styles";


import DropdownAlert from 'react-native-dropdownalert'; // Alert component used to display error

//const const_deviceWidth = Dimensions.get("window").width;
const logo = require("../../assets/images/logo.png");

//Array that will contain Datas
var array_offerDatas = [];
var db_section;

class OfferDisplay extends Component {

  constructor() {
    super();
    this.state = {
      Fab: false,
     // announceNumber: 0,
      //retrieved: "",
      isLoaded:false,
      refreshing:false,
    };
  }


_onRefresh()
{
      this.setState({refreshing: true});
      this.func_getData().then(() => {
      this.setState({refreshing: false});
    });
}
/********************************************/
/* Function : componentDidMount             
/* Action : Call func_getData               
/* Return: -                                
/********************************************/
//ISSUE : Only called on first construct 
componentDidMount(){ 
       // Reset the array on reload
      //Call the function that will get the data
      //var_section = this.props.navigation.state.params.section;
      this.func_getData()
      .then(res => this.setState({ isLoaded:true }))
      .catch(err => alert("An error occurred: "+err));
}

/********************************************/
/* Function : func_getData                  
/* Action : Generate an array with articles 
/* Return: True/False                       
/********************************************/
func_getData() {
  array_offerDatas = []
  db_section = this.props.navigation.state.params.section;
  //DEBUG
  console.log("Db_section : "+ db_section);  

  //Return Resolved once datas have been fetched
  return new Promise(function(resolve, reject){
    try {
      //Get Object corresponding to the section from Firebase
      var ref = firebase.database().ref(db_section).orderByKey();
      

      ref.once('value')
      .then(function(snapshot) {
        
        //Must be limited to 20
        var var_funcIncrement = 0;
        const const_NUMARTICLES = 20;
  
        //Loop foreach going through each child (Articles)
        snapshot.forEach(function(childSnapshot){
          
          //Check the number of articles
          if(var_funcIncrement == const_NUMARTICLES){resolve(true);}
          else{
          //Increment to limit displayed articles to 20
          var_funcIncrement++;
  
          //Get Article  (Child) information
          var child_key = childSnapshot.key;
          var child_uid = childSnapshot.child("uid").val();
          var child_offer = childSnapshot.child("offer").val();
          var child_date = childSnapshot.child("date").val();
          var child_description = childSnapshot.child("description").val();
          var child_price = childSnapshot.child("price").val();
  
          //Add Articles (Child) information to the array
          array_offerDatas.push({    
            section: db_section,
            key : child_key,  
            offer: child_offer,
            date: child_date,
            description: child_description,
            price:child_price,
            uid:child_uid,});
          }
        });
        resolve(true);
      });
    }
     catch (error) {
      this.dropdown.alertWithType("error", "Error", String(error));
      reject(Error(error));
      }
    });
  }


  render() {

    //ALTERNATIVE TO BE FOUND
    if(this.props.navigation.state.params.section != db_section)
    {
      //DEBUG

      console.log("Should launch on refresh");
      this._onRefresh();
    }
    if (!this.state.isLoaded) {return <View style={styles.containerPublish}><Spinner color='blue' /></View>;
    }
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
              onPress={() => this.props.navigation.navigate("DrawerOpen")}
              >
              <Icon name="menu" />
            </Button>
          </Left>
          <Body>
            <Title>{this.props.navigation.state.params.section}</Title>
          </Body>
          <Right />
        </Header>
        <Content          refreshControl={
            <RefreshControl
              refreshing={this.state.refreshing}
              onRefresh={this._onRefresh.bind(this)}
            />}>
          <List
						dataArray={array_offerDatas}
						renderRow={data =>
          <Card style={styles.mb}>
            <CardItem bordered>
              <Left>
                <Thumbnail source={logo} />
                <Body>
                  <Text>{data.offer}</Text>
                  <Text note>{data.date}</Text>
                </Body>
              </Left>
            </CardItem>

            <CardItem>
              <Body>
                <Text>
                  Description : {"\n"}{data.description}
                </Text>
                <Text style={styles.text}>
                  Price : {data.price} CHF
                </Text>

              </Body>
            </CardItem>
            <CardItem>
              <Left>
                <Button primary style={styles.mb15}
                  onPress={() => this.props.navigation.navigate("Offer", {
                    section: this.props.navigation.state.params.section, 
                    offer: data.offer, 
                    description: data.description,
                    price: data.price,
                    date: data.date,
                    key: data.key,
                    uid: data.uid,
                    })}>
                  <Icon name="search" />
                  <Text>See</Text>
                </Button>
              </Left>
            </CardItem>
          </Card>}
          />
        </Content>
        <Fab // Floating button "add an announce"
          active={this.state.Fab}
          direction="up"
          containerStyle={{ }}
          style={styles.FAB}
          position="bottomRight"
          onPress={() => this.setState({ Fab: !this.state.Fab })}>
          
          <Icon name="add" />
          <Button 
            style={{ backgroundColor: '#3B5998' }}
            onPress={() => this.props.navigation.navigate("Publish", {section: this.props.navigation.state.params.section})}>
            <Icon name="mail" />
          </Button>
          
        </Fab>
        <DropdownAlert ref={ref => this.dropdown = ref}/>
      </Container>
    );
  }
}

export default OfferDisplay;