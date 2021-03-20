/************************************************************************ */
/* FILE TITLE : Auth.js                                                   */
/* FILE AIM : Check if user is connected and function to signout          */
/* Exported functions:                                                    */
/*    isSignedIn                                                          */
/*    onSignOut                                                           */
/* Exported Variables:                                                    */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*    https://firebase.google.com/docs/auth/web/manage-users              */
/**************************************************************************/


import firebase from 'firebase'; // Import Firebase login
import { firebaseConfig } from '../config/firebase_config.js'; // Import of Firebase config

//Checked if user is logged

//Return the corresponding boolean true/false
//Check if user is logged in and return the session variable user

/***************************** */
/* Function : isSignedIn       */
/* Action : Check if signed in */
/* Return: boolean             */
/***************************** */

export const isSignedIn = () =>{
    return new Promise((resolve, reject) => {
        firebase.auth().onAuthStateChanged(function(user) {
            if (user) {
              // User is signed in.
              console.log("checked logged true");
              console.log(user);
              resolve(true);
            } else {
              // No user is signed in.
              console.log("checked logged false");
              console.log(false);
              resolve(false); // TO BE CHANGED to true to bypass login
            }
        });
    });
};


/***************************** */
/* Function : onSignOut        */
/* Action : Sign out           */
/* Return: boolean             */
/***************************** */
export const onSignOut =() => {
    firebase.auth().signOut().then(function() {
    console.log("Sign Out successfull");
    // Sign-out successful.
  }, function(error) {
    console.log(error);
    // An error happened.
  });
}