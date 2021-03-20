/************************************************************************ */
/* FILE TITLE : Router.js                                                 */
/* FILE AIM : Determine the navigation to display                         */
/* Exported functions:                                                    */
/*     createRootNavigator                                                */
/*                                                                        */
/* Exported Variables:                                                    */
/*     Drawer                                                             */
/*                                                                        */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*                                                                        */
/**************************************************************************/

import React from "react";

//Import navigation components
import { StackNavigator, TabNavigator } from "react-navigation";

//Import the Navigation Drawer & Signedout
import Drawer from "./Drawer";
import SignedOut from "./SignedOut";

//Set up core navigation
export const createRootNavigator = (signedIn = false) => {
    return StackNavigator(
    {
      Drawer: {screen: Drawer},
      SignedOut: {screen: SignedOut}
    },
    {
     initialRouteName: signedIn ? "Drawer":"SignedOut",
      headerMode:"None",
    }
  );
};

