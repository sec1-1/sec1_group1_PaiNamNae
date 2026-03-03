*** Settings ***
Resource       ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-020 Passenger Select Few Checkbox.
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,200)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[5]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[4]
    Select Few Checkbox
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    View All Route
    View Passenger Info
    Page Should Contain     ${PASSENGER_SURNAME}
    Page Should Contain     สะอาด
    Page Should Contain     ตรงเวลา

UAT-021 Passenger Select All Checkbox.
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,250)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[6]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Select All Checkboxes
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    View All Route
    View Passenger Info
    Page Should Contain     ${PASSENGER_SURNAME}
    Page Should Contain     สะอาด
    Page Should Contain     คนขับมารยาทดี
    Page Should Contain     ตรงเวลา
    Page Should Contain     ขับปลอดภัย
    Page Should Contain     บริการเป็นกันเอง


