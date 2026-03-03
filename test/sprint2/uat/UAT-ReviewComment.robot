*** Settings ***
Library    String
Resource   ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-022 Passenger Comments Under 501 Characters
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,250)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[7]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Input Text    xpath=//textarea[@placeholder="เขียนรีวิวของคุณ... (สูงสุด 501 ตัวอักษร)"]    ${REVIEW_TEXT}
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    View All Route
    View Passenger Info
    Page Should Contain     ${REVIEW_TEXT}
    Page Should Contain     ${PASSENGER_SURNAME}

UAT-023 Passenger Comments 501 Characters
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,300)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[8]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    ${RANDOM_TEXT}=    Generate Random String    501    [LETTERS]
    Input Text          xpath=//textarea[@placeholder="เขียนรีวิวของคุณ... (สูงสุด 501 ตัวอักษร)"]    ${RANDOM_TEXT}
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    View All Route
    View Passenger Info
    Page Should Contain     ${RANDOM_TEXT}
    Page Should Contain     ${PASSENGER_SURNAME}