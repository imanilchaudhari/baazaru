/************************************************************************ */
/* FILE TITLE : Drawer.js                                                 */
/* FILE AIM : Stack to display if user is logged in                       */
/* Exported functions:                                                    */
/*                                                                        */
/*                                                                        */
/* Exported Variables:                                                    */
/*     Drawer                                                             */
/*                                                                        */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*                                                                        */
/**************************************************************************/

//Import elements
import React from "react";
import { DrawerNavigator } from "react-navigation";

//Pages to be display if loggedIn
  import Home from "./home/";
  import SideBar from "./sidebar";
  //import Offers publish and display pages
  //Display receive a parameter that determines what offer to display
  import offerDisplay from "./pages/offerDisplay"
  import publish from "./pages/publish"
  import offer from "./pages/offer"
  //import User pages
  import userpage from "./pages/userPage" 
  import login from "./user/login"
  import SignOut from "./SignedOut"


//Declare Navigator to be used if logged-in
const Drawer = DrawerNavigator(
    {
        //Declare elements part of the Drawer navigation
        Home: {screen:Home},
        OfferDisplay: {
          screen: offerDisplay,
          path: 'offerDisplay/:section',},
        Publish: {
          screen: publish,
          path: 'publish/:section',},
        Offer: {
          screen: offer, 
          path: 'offer/:section',
          path: 'offer/:offer',
          path: 'offer/:description',
          path: 'offer/:price',
          path: 'offer/:date',
          path: 'offer/:key',
          path: 'offer/:uid',
        },
        UserPage: {screen: userpage},
        SignOut: {screen: login}
    },
    {
      //Declare initial routename (Default displayed page)
      initialRouteName: "Home",
      contentOptions:{
        activeTintColor:"#e91e63"
      },
      headerMode:"none",
      //Drawer Menu design
      contentComponent: props => <SideBar {...props} />
    }
  );


export default Drawer;
