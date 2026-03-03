*** Settings ***
Resource   ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-022 Passenger Upload Image File
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,300)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[9]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Choose File         xpath=//input[@type="file"]    ${IMAGE01_PATH} 
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    View All Route
    View Passenger Info
    Wait Until Element Is Visible    xpath=//div[contains(@class,"flex-wrap")]//img    30s
    Element Should Be Visible        xpath=//div[contains(@class,"flex-wrap")]//img
    Page Should Contain             ${PASSENGER_SURNAME}

UAT-023 Passenger Upload Video File
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,300)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[10]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Choose File         xpath=//input[@type="file"]    ${VIDEO01_PATH} 
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    60s
    View All Route
    View Passenger Info
    Wait Until Element Is Visible    xpath=//div[contains(@class,"flex-wrap")]//video    30s
    Element Should Be Visible        xpath=//div[contains(@class,"flex-wrap")]//video

UAT-024 Passenger Upload Invalid File
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,325)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[11]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    ${count_before}=    Get Element Count    xpath=//div[contains(@class,"flex-wrap")]//*[self::img or self::video]
    Choose File         xpath=//input[@type="file"]    ${PDF_PATH}
    ${count_after}=    Get Element Count    xpath=//div[contains(@class,"flex-wrap")]//*[self::img or self::video]
    
    # ==== Expected Results ====
    Should Be Equal As Integers     ${count_before}    ${count_after}
    ${accept}=    Get Element Attribute    xpath=//input[@type="file"]    accept
    Should Contain    ${accept}    image
    Should Contain    ${accept}    video
    Should Not Contain    ${accept}    pdf
    Wait Until Element Is Visible    xpath=//*[contains(text(),"กรุณาเลือกไฟล์รูปภาพเท่านั้น")]    20s
    Element Should Be Visible        xpath=//*[contains(text(),"กรุณาเลือกไฟล์รูปภาพเท่านั้น")]