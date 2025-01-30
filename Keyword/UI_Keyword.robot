*** Settings ***
Resource    Redefine_Keyword.robot
Resource    ../Variable/Repository.robot
Resource    ../Variable/Message.robot

*** Keywords ***
Add Items To Cart
    # นับจำนวนใน ${ITEM_NAMES} และเก็บไว้ในตัวแปร ${item_count}
    ${item_count}=    Evaluate    len(${ITEM_NAMES})
    # log จำนวนที่ได้จาก ${item_count}
    log    Total items to check: ${item_count}
    # วนลูปซึ่ง ${item_count} = 4
    FOR    ${index}    IN RANGE    ${item_count}
        # set variable ${ITEM_NAMES} index 0 ไว้ในตัวแปร ${item_name} ไว้สำหรับไปใช้เช็คว่ามีสินค้า index 0 อยู่หน้าเว็บมั้ย
        ${item_name}=    Set Variable    ${ITEM_NAMES}[${index}]
        # set variable ${BUTTON_CONTAINS} index 0 ไว้ในตัวแปร ${button_name} ไว้สำหรับไปใช้หาปุ่ม add to cart ข้างล่างว่ามี index 0 อยู่หน้าเว็บมั้ย
        ${button_name}=  Set Variable    ${BUTTON_CONTAINS}[${index}]
        # log ชื่อสิ้นค้าที่อยู่ใน index 0
        log    Checking for item: ${item_name}
        # ตรวจสอบว่ามีสินค้าบนหน้าเว็บมั้ย โดยจะเอาค่าใน ${item_name} มาแทนลงใน xpath กรณีมี xpath นี้จะมีการคืน status เป็น PASS กรณีไม่่มีจะคืนเป็น FAIL
        ${status}=    Run Keyword And Ignore Error    Page Should Contain Element    xpath=//div[@data-test='inventory-item-name'][contains(text(), '${item_name}')]
        # กรณีที่ status = FAIL จะมี log เตือนว่า Item not found
        IF    '${status[0]}' == 'FAIL'
            log    Item not found: ${item_name}    WARN
        ELSE
            # กรณทีี่ status = PASS จะมี log บอกว่า 	Item found และเข้าเงื่อนไขต่อไป
            log    Item found: ${item_name}
            # หลังจากที่มีการเจอแล้วว่ามีสินค้า index0 อยู่หน้าเว็บ ก็จะคลิกปุ่ม Add to cart โดยจะเอาค่าใน ${button_name} มาแทนลงใน xpath เพื่อหาและคลิกปุ่ม Add to cart กรณีเจอปุ่มจะมีการคืน status เป็น PASS กรณีไม่่มีจะคืนเป็น FAIL
            ${button_status}=    Run Keyword And Ignore Error    Click Web Element    xpath=//button[contains(@data-test, '${button_name}')]
            #  กรณี status ปุ่ม = Fail ก็จะเข้าเงื่อนไขนี้ มี log WARN Unable to click Add to cart
            IF    '${button_status[0]}' == 'FAIL'
                log    Unable to click Add to cart for: ${item_name}    WARN
            # กรณี status ปุ่ม = PASS จะมี log uccessfully clicked Add to cart
            ELSE
                log    Successfully clicked Add to cart for: ${item_name}
            END
        END
    END
    #ซึ่งจะวนทำแบบนี้เรื่อยๆจนครบจำนวน ${item_count}

Remove Backpack
    # รอหา xpath Backpack
    Web Element Should Be Visible    ${BACKPAK_TEXT_PATH}
    # ทำการกด remove
    Click Web Element       ${REMOVEBACKPAK_BUTTON}

Verify Items After Remove Backpack
    # get Webelements ออกมาจะได้ 2 elements
    ${items_found}=    Get Webelements    ${ITEMS_XPATH}
    # log Webelements ที่ get ออกมาได้
    log     ${items_found}
    # วนหาโดยเอา webelement index 0 มาวนก่อน
    FOR    ${item}    IN    @{items_found}
    # get text ออกมาจาก webelement index 0
        ${text}=    Get Text    ${item}
        # log text ที่ get ออกมาได้
        Log    Found item: ${text}
        # เอา text ที่ได้ไปเก็บไว้ใน list ${ITEMS_LIST}
        Append To List    ${ITEMS_LIST}    ${text}
        # วนทำจนครบ @{items_found}
    END
    # log text ที่ไป get ออกมาจากการวนลลูปซึ่งเก็บไว้ใน ${ITEMS_LIST}
    Log    All items: ${ITEMS_LIST}
    # เอา text ที่ได้จาก list มา compare ซึ่งใน ${ITEMS_LIST} จะต้องมีสินค้า ${Bolt_T-Shirt}
    Should Contain    ${ITEMS_LIST}    ${Bolt_T-Shirt}
    # เอา text ที่ได้จาก list มา compare ซึ่งใน ${ITEMS_LIST} จะต้องมีสินค้า ${T-Shirt_Red}
    Should Contain    ${ITEMS_LIST}    ${T-Shirt_Red}

Verify Price With Tax
    # get Webelements ออกมาจะได้ 2 elements
    ${items_price}=     Get Webelements     ${PRICE_XPATH}
    # set total_price ให้เท่ากับ 0
    ${total_price}=    Set Variable    0
    FOR    ${price_element}    IN    @{items_price}
       # get ตัวเลขราคา ออกมาจาก webelement index 0
        ${price_text}   Get Text    ${price_element}
       # แปลงค่า price_text ให้เป็นทศนิยม และลบ $ ออก และลบช่องว่างทั้งด้านหน้าและด้านหลังข้อความออก
        ${price}        Evaluate    float(${price_text.replace('$', '').strip()})
       # เอา ${total_price} = 0 ตอนต้นมา + กับ price index 0 ที่ get ออกมา
        ${total_price}  Evaluate    ${total_price} + ${price}
    # วน get ราคาและเอามาบวกจนกว่าจะครบลูป
    END
    # สินค้ามีการคิดภาษีอยู่ที่ 8% เอา ${total_price} มาคิดรวมกับภาษี
    ${total_with_tax}=    Evaluate    ${total_price} + (${total_price} * 0.08)
    # ปัดราคาให้เหลือทศนิยม 2 ตำแหน่งและเก็บไว้ใน ${rounded_total}
    ${rounded_total}    Evaluate    round(${total_with_tax}, 2)
    # แปลงค่า ${expected_price} ให้เป็นทศนิยมและเก็บไว้ใน ${expected_price_float}
    ${expected_price_float}=    Evaluate    float(${expected_price})
    # log Price without tax
    log  Price without tax : ${total_price}
    # log Price with tax
    log  Price with tax : ${rounded_total}
    # เอา price with tax ที่มีการปัดราคาให้เหลือทศนิยม 2 ตำแหน่งมา compare กับ  ${expected_price_float}
    should be equal     ${rounded_total}        ${expected_price_float}


