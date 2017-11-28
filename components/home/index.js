/************************************************************************ */
/* FILE TITLE : home/index.js                                             */
/* FILE AIM : Home Page code                                              */
/* Exported functions:                                                    */
/*                                                                        */
/*                                                                        */
/* Exported Variables:                                                    */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*                                                                        */
/**************************************************************************/

import React, { Component } from "react";
import { Image, View, StatusBar } from "react-native";

import { Container, Button, H3, Text, Header, Left, Right, Title, Icon, Body} from "native-base";

import styles from "./styles";

//Background Launchscreen
const launchscreenBg = require("../../assets/images/bg.png");
//Logo launchscreen
const launchscreenLogo = require("../../assets/images/logo.png");

class Home extends Component {
	// eslint-disable-line

	 //Initial function
	 constructor() {
		super();
		//Set app state to false in order to load components before display
		this.state = {
		  isReady: false
		};
	  }


	render() {
		return (
			<Container>
				<Header style={styles.Header}
					androidStatusBarColor='#6FAF98'
					backgroundColor='#6FAF98'> 
					<Left>
						<Button
						transparent
						light
						backgroundColor= 'White'
						onPress={() => this.props.navigation.navigate("DrawerOpen")}
						>
						<Icon name="menu"/>
						</Button>
					</Left>
					<Right />
				</Header>
				<StatusBar 
						barStyle="light-content" 
						style={styles.StatusBar}
						backgroundColor="#c0c0c0"
						translucent={false}
				 />
				<Image source={launchscreenBg} style={styles.imageContainer}>
					<View style={styles.logoContainer}>
						<Image source={launchscreenLogo} style={styles.logo} />
					</View>
					<View
						style={{
							alignItems: "center",
							marginBottom: 50,
							backgroundColor: "transparent",
						}}
					>
						
					</View>
					<View style={{ marginBottom: 80 }}>
						<Button
							style={{ backgroundColor: "#6FAF98", alignSelf: "center" }}
							onPress={() => this.props.navigation.navigate("DrawerOpen")}
						>
							<Text>See the different categories</Text>
						</Button>
					</View>
				</Image>
			</Container>
		);
	}
}

export default Home;
