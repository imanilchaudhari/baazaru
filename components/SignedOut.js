/************************************************************************ */
/* FILE TITLE : SignedOut.js                                              */
/* FILE AIM : Stack to display if user is logged OUT                      */
/* Exported functions:                                                    */
/*                                                                        */
/*                                                                        */
/* Exported Variables:                                                    */
/*     SignedOut                                                          */
/*                                                                        */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*                                                                        */
/**************************************************************************/


import React from "react";
import {StackNavigator } from "react-navigation";

import login from "./user/login"
import register from "./user/register"
import registerInfo from "./user/registerInfo"
import resetPassword from "./user/resetPassword"

const SignedOut = StackNavigator({
    Login: {screen: login},
    Register: {
      screen: register,
      path: 'register/:firstname',
      path: 'register/:lastname',
      path: 'register/:phone',
    },
    RegisterInfo: {screen: registerInfo},
    ResetPassword: {screen: resetPassword},
  },{
  initialRouteName: "Login",
  headerMode:"none",}
  );

export default SignedOut;
