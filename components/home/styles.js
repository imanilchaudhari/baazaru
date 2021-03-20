/************************************************************************ */
/* FILE TITLE : home/styles.js                                            */
/* FILE AIM : Home Page stylesheet                                        */
/* Exported functions:                                                    */
/*                                                                        */
/*                                                                        */
/* Exported Variables:                                                    */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*                                                                        */
/**************************************************************************/

const React = require("react-native");

const { Dimensions, Platform } = React;

const deviceHeight = Dimensions.get("window").height;

export default {
  StatusBar: {
    backgroundColor: 'green',
  },
  Header: {
    backgroundColor: 'transparent',
  },
  imageContainer: {
    flex: 1,
    width: null,
    height: null,
  },
  logoContainer: {
    flex: 1,
    marginTop: deviceHeight / 15,
    marginBottom: 30
  },
  logo: {
    position: "absolute",
    left: Platform.OS === "android" ? 80 : 70,
    top: Platform.OS === "android" ? 35 : 60,
    width: 180,
    height: 180
  },
  text: {
    color: "#6FAF98",
    bottom: 6,
    marginTop: 5
  }
};
