//
//  EndPoints.swift
//  Luban
//
//  Created by Ganesh Sharma on 10/06/20.
//



struct EndPoints {
    static let BASE_URL = "https://www.lubancabinetry.com/api/"
//    static let BASE_URL = "http://dev.lubancabinetry.com/api/"
    static let loginRequest = BASE_URL + "login"
    static let logoutRequest = BASE_URL + "logout"
    static let requestQuote = BASE_URL + "request-quote"
    static let registerNewUser = BASE_URL + "signup"
    static let detailUser = BASE_URL + "details"
    static let homeCategory = BASE_URL + "home-page"
    static let newsBlogs = BASE_URL + "announcement-news"
    static let faq = BASE_URL + "faq"
    static let forgotPassword = BASE_URL + "forgot-password"
    static let searchProduct = BASE_URL + "search?query="
    static let dealerSearch = BASE_URL + "stores"
    static let contactUs = BASE_URL + "contact-us"
    static let register_dropdown = BASE_URL + "reg-dropdown/"
    static let country_state = BASE_URL + "country-state/"
    static let category = BASE_URL + "category/"
    static let ourTeam = BASE_URL + "team/"
    static let product = BASE_URL + "product/"
    static let shipping_cost = BASE_URL + "shipping-cost"
    static let dealerStoreSearch = BASE_URL + "store-search"
    static let checkout = BASE_URL + "checkout"
    static let clearCart = BASE_URL + "clear-cart"
    static let shippingMethod = BASE_URL + "shipping-method"
    static let storeDetail = BASE_URL + "store"
    static let change_password = BASE_URL + "change-password"
    static let uploadWin = BASE_URL + "upload-win"
    static let compare = BASE_URL + "compare/"
    static let my_orders = BASE_URL + "my-orders"
    static let apply_coupon = BASE_URL + "coupon"
    static let removeCoupon = BASE_URL + "remove-coupon"
    static let updateProfile = BASE_URL + "update-profile"
    static let saveUserCart = BASE_URL + "cartSave"
    
    //Logged in Cart API.
    static let cart = BASE_URL + "cart"
    static let wishlist = BASE_URL + "wishlist"
    static let move_to_cart = BASE_URL + "move-to-cart/"
    static let move_to_wishlist = BASE_URL + "move-to-wishlist/"
    static let cart_count = BASE_URL + "cart-count"
    static let wishlist_count = BASE_URL + "wishlist-count"
    
    //Logged in Guest Cart API.
    static let guestCart = BASE_URL + "guest-cart"
    static let guestWishlist = BASE_URL + "guest-wishlist"
    static let guestMoveToCart = BASE_URL + "guest-move-to-cart/"
    static let guestMoveWishlist = BASE_URL + "guest-move-to-wishlist/"
    static let guestCartCount = BASE_URL + "guest-cart-count"
    static let guestWishlistCount = BASE_URL + "guest-wishlist-count"
}
