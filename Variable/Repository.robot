*** Variables ***
#Login
${USERNAME_FIELD}   id=user-name
${PASSWORD_FIELD}   id=password
${LOGIN_BUTTON}   //input[@data-test='login-button']
${PRODUCT_TITLE}      //span[@data-test='title'][contains(text(),'Products')]

#add and remove item to cart
${YOURCART_TITLE}        //span[@data-test='title'][contains(text(),'Your Cart')]
${SHOPPINGCART_PATH}     //a[@data-test='shopping-cart-link']
${BACKPAK_TEXT_PATH}        //div[@data-test='inventory-item-name'][contains(text(), 'Backpack')]
${REMOVEBACKPAK_BUTTON}       //button[@data-test='remove-sauce-labs-backpack']
${CHECKOUT_BUTTON}      //button[@data-test='checkout']

#Checkout: Your Information
${YOURINFORMATION_TITLE}     //span[@data-test='title'][contains(text(),'Checkout: Your Information')]
${FIRSTNAME_FIELD}      //input[@data-test='firstName']
${LASTNAME_FIELD}       //input[@data-test='lastName']
${POSTALCODE_FIELD}       //input[@data-test='postalCode']
${CONTINUE_BUTTON}      //input[@data-test='continue']

#Checkout: Overview
${OVERVIEW_TITLE}        //span[@data-test='title'][contains(text(),'Checkout: Overview')]
${FINISH_BUTTON}        //button[@data-test='finish']

#Checkout: Complete!
${COMPLETE_TITLE}       //span[@data-test='title'][contains(text(),'Checkout: Complete')]
${TANKYOU_PATH}     //h2[@data-test='complete-header'][contains(text(),'Thank you for your order!')]


#Items & Price
${ITEMS_XPATH}    xpath=//div[@class='inventory_item_name']
${PRICE_XPATH}     xpath=//div[@data-test='inventory-item-price']