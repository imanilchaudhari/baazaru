/************************************************************************ */
/* FILE TITLE : pages/styles.js                                            */
/* FILE AIM : offer.js / publish.js / offerDisplay.js Stylesheet          */
/* Exported functions:                                                    */
/*                                                                        */
/*                                                                        */
/* Exported Variables:                                                    */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*                                                                        */
/**************************************************************************/


const React = require("react-native");

const { StyleSheet } = React;

export default {
  //viewFlex:{
    //flex: 3,
     //flexDirection: 'column',
     //backgroundColor:'Yellow',
 // },
  containerPublish: { // only concern the "publish.js"
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#ddd',
  },
  save1Publish: { // only concern the "publish.js"
    marginVertical: 15,
    width: 100,
    height: 43,  
    },
  save2Publish: { // only concern the "publish.js"
      marginVertical: 9,
      backgroundColor: '#228b22',
      width: 200, 
      height: 50,
    },
  image: { // only concern the "publish.js"
    width: 100,
    height: 100,
  },
  container: {
    backgroundColor: "#FFF",

  },
  text: {
    alignSelf: "center",
    marginBottom: 7
  },
  mb: {
    marginBottom: 15
  },
  FAB: {
    backgroundColor: '#5067FF'
  },
  text: {
    fontWeight: 'bold',
  }
};
