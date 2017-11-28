/************************************************************************ */
/* FILE TITLE : App.js                                                    */
/* FILE AIM : Core file of the appnected and function to signout          */
/* Exported functions:                                                    */
/*                                                                        */
/*                                                                        */
/* Exported Variables:                                                    */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*                                                                        */
/**************************************************************************/

import Expo from "expo";
import React from "react";

import firebase from 'firebase'; // Import Firebase login
import { firebaseConfig } from './config/firebase_config.js'; // Import of Firebase config

//Router takes care of determining which navigation to display
//Auth determines if a user is already logged in
import {createRootNavigator} from "./components/Router";
import { isSignedIn } from "./components/Auth";

//Initialise firebase 
firebase.initializeApp(firebaseConfig);

export default class App extends React.Component {
  
  //Initial function
  constructor() {
    super();
    //Set app state to false in order to load components before display
    this.state = {
      isReady: false,
      signedIn: false, 
      checkedSignIn: false 
    };
  }

  //Load required fonts in asynchroneous
  async componentDidMount(){
    console.log("ComponentDidMount : Signed in - " +this.state.signedIn + "++++  hasCheckedSignedin - "+ this.state.checkedSignIn);
    //BEFORE DISPLAYING LOAD FONTS
    await Expo.Font.loadAsync({
      Roboto: require("native-base/Fonts/Roboto.ttf"),
      Roboto_medium: require("native-base/Fonts/Roboto_medium.ttf"),
      Ionicons: require("@expo/vector-icons/fonts/Ionicons.ttf")
    });

    //Change state isReady to True
    this.setState({ isReady: true });
  }

 //Check if logged in before loeading the components
  componentWillMount() {
    console.log("ComponentWillMount : Signed in - " +this.state.signedIn + "++++  hasCheckedSignedin - "+ this.state.checkedSignIn);
    //BEFORE DISPLAYING CHECK IF ALREADY SIGNED IN
    isSignedIn()
    .then(res => this.setState({ signedIn: res, checkedSignIn: true }))
    .catch(err => alert("An error occurred: "+err));
  }
  render() {
  
    //Check isReady to see if app ressources have been loaded
    //As long as auth state has not been checked, keep displaying loading icon
    if (!this.state.isReady && !this.state.checkedSignIn) {
      //State while loading 
      return <Expo.AppLoading />;
    }

    console.log("this.state.signedIn response: " + this.state.signedIn);
    const App = createRootNavigator(this.state.signedIn);
    //Launch app if the app isReady
    //Display ./js/App
    return <App />;
  }
}