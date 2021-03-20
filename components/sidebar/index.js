/************************************************************************ */
/* FILE TITLE : sidebar/index.js                                          */
/* FILE AIM : Sidebar component for Drawer navigation                               */
/* Exported functions:                                                    */
/*                                                                        */
/*                                                                        */
/* Exported Variables:                                                    */
/*                                                                        */
/* DOCUMENTATION USED:                                                    */
/*                                                                        */
/**************************************************************************/


import React, { Component } from "react";
import { Image } from "react-native";

import {
	Content,
	Text,
	List,
	ListItem,
	Icon,
	Container,
	Left,
	Right,
	Badge,
	Button,
} from "native-base";

import styles from "./style";

//Load logo
const drawerCover = require("../../assets/images/menu-bg.png");
const drawerImage = require("../../assets/images/logo.png");

//CONSTANTE OF MENU DETAILS
//Name = Display name
//Section = seciont used for database
//Icon = Displayed icon -> Taken from Ionicons
//bg = Background of the types
//types = Number of types
const datas = [
	{
		name: "My home",
		route: "Home",
		icon: "apps",
		bg: "#C5F442",
	},
	{
		name: "Electronics",
		section:"electronics",
		route: "OfferDisplay",
		icon: "book",
		bg: "#C5F442",
	},
	{
		name: "Sports",
		section:"sports",
		route: "OfferDisplay",
		icon: "home",
		bg: "#C5F442",
	},
	{
		name: "Educational",
		section:"educational",
		route: "OfferDisplay",
		icon: "thunderstorm",
		bg: "#477EEA",
	},
	{
		name: "Agricultural",
		section:"Agricultural",
		route: "OfferDisplay",
		icon: "help-buoy",
		bg: "#DA4437",
	},
	{
		name: "Associations",
		section:"associations",
		route: "OfferDisplay",
		icon: "people",
		bg: "#4DCAE0",
	},
	{
		name: "Fashions",
		section:"fashion",
		route: "OfferDisplay",
		icon: "beer",
		bg: "#1EBC7C",
	},
	{
		name: "Furniture",
		section:"furniture",
		route: "OfferDisplay",
		icon: "easel",
		bg: "#B89EF5",
	},
	{
		name: "Other",
		section:"other",
		route: "OfferDisplay",
		icon: "infinite",
		bg: "#EB6B23",
	},
	{
		name: "My account",
		route: "UserPage",
		icon: "person",
		bg: "#3591FA",
	}
];

class SideBar extends Component {
	constructor(props) {
		super(props);
		this.state = {
			shadowOffsetWidth: 1,
			shadowRadius: 4,
		};
	}

	render() {
		return (
			<Container>
				<Content bounces={false} style={{ flex: 1, backgroundColor: "#fff", top: -1 }}>
					<Image source={drawerCover} style={styles.drawerCover}>
						<Image square style={styles.drawerImage} source={drawerImage}
						/>
					</Image>
					<List
						dataArray={datas}
						renderRow={data =>
							<ListItem button noBorder onPress={() => this.props.navigation.navigate(data.route, {section: data.section})}>
								<Left>
									<Icon active name={data.icon} style={{ color: "#777", fontSize: 26, width: 30}} />
									<Text style={styles.text}>
										{data.name}
									</Text>
								</Left>
								{data.types &&
									<Right style={{ flex: 1 }}>
										<Badge
											style={{
												borderRadius: 3,
												height: 25,
												width: 72,
												backgroundColor: data.bg,
											}}
										>
										</Badge>
									</Right>}
							</ListItem>}
					/>
				</Content>
			</Container>
		);
	}
}

export default SideBar;
