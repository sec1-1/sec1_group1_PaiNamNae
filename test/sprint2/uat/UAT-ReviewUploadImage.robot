*** Settings ***
Resource   ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-024 Passenger Upload Image File In Review
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

UAT-025 Passenger Upload Video File In Review
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

UAT-026 Passenger Upload Invalid File In Review
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,325)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[11]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Choose File         xpath=//input[@type="file"]    ${PDF_PATH}
    
    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"กรุณาเลือกไฟล์รูปหรือวิดีโอเท่านั้น")]    10s

UAT-027 Passenger Upload File Video More than 50MB In Review
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,325)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[11]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Choose File         xpath=//input[@type="file"]    ${INVALID_VIDEO}
    
    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"ขนาดไฟล์ต้องไม่เกิน 50MB")]    10s