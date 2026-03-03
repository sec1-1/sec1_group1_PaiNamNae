*** Settings ***
Library    SeleniumLibrary
Resource       ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-017 Passenger Give 1 Star
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,150)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[2]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[1]
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    View All Route
    View Passenger Info
    Page Should Contain     1
    Page Should Contain     ${PASSENGER_SURNAME}

UAT-018 Passenger Give 5 Star
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,200)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[3]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    View All Route
    View Passenger Info
    Page Should Contain     1
    Page Should Contain     ${PASSENGER_SURNAME}

UAT-019 Passenger Do not Give a Star
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,200)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[4]
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"กรุณาให้คะแนนก่อน")]    10s