/************************************************************************ */
/* FILE TITLE : pages/stylesUserPage.js                                            
/* FILE AIM : UserPage.js
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
    container: {
        flex: 1,
        //backgroundColor: colors.eggshell,
        paddingHorizontal: 16,
        justifyContent: "space-between",
        paddingVertical: 16
      },
      sectionHeaderContainer: {
        paddingBottom: 16
      },
      sectionHeaderText: {
        fontSize: 16,
        //color: colors.blue
      },
      sectionHeaderUnderline: {
        marginTop: 8,
        height: 2,
        borderRadius: 4,
        //backgroundColor: colors.blue
      },
      fieldContainer: {
        paddingBottom: 16
      },
      switchFieldContainer: {
        justifyContent: "space-between",
        flexDirection: "row",
        alignItems: "center",
        marginBottom: 16
      },
      editableText: {
        color: "grey",
      },
      text: {
        fontSize: 20,
      }
};
