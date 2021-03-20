/************************************************************************ */
/* FILE TITLE : user/styles.js                                         */
/* FILE AIM : login / register / registerInfo / resetPassword Stylesheet                           */
/* Exported functions:                                                    */
/*                                                                        */
/*                                                                        */
/* Exported Variables:                                                    */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*                                                                        */
/**************************************************************************/

const React = require("react-native");

const { StyleSheet, Platform, Dimensions } = React;

export default {
    container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: '#ddd',
    },
    title: {
      marginTop: 40,
      marginBottom: 10,
      fontSize: 20,
      fontWeight: 'bold',
    },
    reloadButton: {
      fontSize: 16,
      fontWeight: 'bold',
      backgroundColor: 'blue',
      color: 'white',
      padding: 10,
    },
    loginField: {
        height: 40,
        margin: 10,
        padding: 5,
        backgroundColor: 'white',
      },
      passwordField: {
        height: 40,
        margin: 10,
        padding: 10,
        backgroundColor: 'white',
      },
      listView: {
        alignSelf: 'stretch',
        backgroundColor: 'white',
      },
      listViewRow: {
        flex: 1,
        flexDirection: 'row',
        alignItems: 'center',
        height: 50,
      },
      rowName: {
        padding: 10,
        fontSize: 16,
      },
      rowTemperature: {
        padding: 10,
        fontSize: 16,
      },
    save: {
      marginVertical: 9,
    },
    saveLogin: {
        marginVertical: 15,
    },
    image: {
      width: 200,
      height: 200
    },
    phone: {
        margin: 10,
      },
    registerContainer: {
      position: 'absolute',
      bottom: 0,
      alignSelf: "flex-end",
      backgroundColor: "rgba(0, 0, 0, 0.1)",
      paddingVertical: 16,
      width: Dimensions.get("window").width,
      justifyContent: "center",
      alignItems: "center",
    },
    registerText: {
      color: "black",
      fontSize: 16
    },
    enterMail: {
        marginVertical: 15,
      },
      enterMailInput: {
      },
      resetButton: {
      }
  };