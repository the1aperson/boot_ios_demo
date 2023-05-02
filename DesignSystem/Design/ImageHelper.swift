//
//  ImageHelper.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/12/22.
//

import SwiftUI

public enum AppImage: String, CaseIterable {
    
    //MARK: happyMedium
    case hMIcon, hMLogo
    
    // MARK: Tab Bar
    case home, discover, shop, account
    
    // MARK: Shop Tab
    case fullScreenCategorySelect
    
    // BB Loading Screen
    case loadingLogo = "loading_logo"
    
    // Style scroll
    case westernBoots = "1_westernBoots",
         workBoots = "2_workBoots",
         hikingBoots = "3_hikingBoots",
         shirts = "4_shirts",
         outerwear = "5_outerwear",
         jeansAndPants = "6_jeansAndPants",
         workwear = "7_workwear",
         hats = "8_hats",
         accessories = "9_accessories"
    
    // PLP
    case plp1 = "plp_1",
         plp2 = "plp_2",
         plp3 = "plp_3",
         plp4 = "plp_4",
         plp5 = "plp_5",
         plp6 = "plp_6",
         plp7 = "plp_7",
         plp8 = "plp_8"
    
    // PDP 1
    case pdp1_1,
         pdp1_2,
         pdp1_3,
         pdp1_4,
         pdp1_5,
         pdp1_6
    
    case recentlyViewedBootPDP_1,
         recentlyViewedBootPDP_2,
         recentlyViewedBootPDP_3
    
    // PDP 1
    case pdp2_1,
         pdp2_2,
         pdp2_3,
         pdp2_4
    
    case recentlyViewedSkirtPDP_1,
         recentlyViewedSkirtPDP_2,
         recentlyViewedSkirtPDP_3
    
    // MARK: Home Tab
    case homeBanner1 = "home_banner_1"
    
    case homeWonderWest1 = "home_wonderWest_1",
         homeWonderWest2 = "home_wonderWest_2",
         homeWonderWest3 = "home_wonderWest_3",
         homeWonderWest4 = "home_wonderWest_4",
         homeWonderWest5 = "home_wonderWest_5"
    
    case homeCategory1 = "home_category_1",
         homeCategory2 = "home_category_2",
         homeCategory3 = "home_category_3",
         homeCategory4 = "home_category_4"
    
    case homeTrending1 = "home_trending_1",
         homeTrending2 = "home_trending_2",
         homeTrending3 = "home_trending_3",
         homeTrending4 = "home_trending_4",
         homeTrending5 = "home_trending_5",
         homeTrending6 = "home_trending_6"
    
    case homeNewDeals1 = "home_newDeals_1",
         homeNewDeals2 = "home_newDeals_2",
         homeNewDeals3 = "home_newDeals_3",
         homeNewDeals4 = "home_newDeals_4",
         homeNewDeals5 = "home_newDeals_5"

    // MARK: Discover
    case discover1 = "discover_1"
    
    case discover3Slide1 = "discover_3slide1",
         discover3Slide2 = "discover_3slide2",
         discover3Slide3 = "discover_3slide3"
    
    case discover4Slide2 = "discover_4slide2",
         discover4Slide3 = "discover_4slide3"
    
    case discover5 = "discover_5"

    case discover7Slide1 = "discover_7slide1",
         discover7Slide2 = "discover_7slide2",
         discover7Slide3 = "discover_7slide3"

    case discover8 = "discover_8"

    case shoplook_circle = "shoplook_circle"
    
    // MARK: Icons
    case arrowUp = "arrow up",
         arrowDown = "arrow down",
         arrowLeft = "arrow left",
         arrowRight = "arrow right",
         arrowCircleUp = "arrow circle up",
         arrowCircleDown = "arrow circle down",
         arrowCircleLeft = "arrow circle left",
         arrowCircleRight = "arrow circle right"
    
    case appleIcon,
         augmentedReality = "AR",
         backArrow = "arrow back",
         bag = "bag",
         filters,
         heartFilled = "heart filled",
         heart,
         inStore = "in store",
         longArrow = "long arrow",
         pickup = "pick up",
         pin,
         search,
         share,
         shipping,
         exit = "x",
         exitCircle = "x_circle_white"


}

// MARK: Image View
public extension Image {
    init(_ appImage: AppImage) {
        self.init(appImage.rawValue)
    }
}
