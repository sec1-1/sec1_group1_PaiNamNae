*** Settings ***
Library    SeleniumLibrary
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-015: Blacklist Register
    Open Browser    ${URL}    chrome    options=add_argument("--disable-extensions")
    Click Element                       xpath=//a[@href='/register']
    Wait Until Location Contains        /register           10s
    Input Text                      id=username             ${BLACKLIST_USER}
    Input Text                      id=email                ${BLACKLIST_EMAIL}
    Input Text                      id=password             ${BLACKLIST_PASS}
    Input Text                      id=confirmPassword      ${BLACKLIST_PASS}
    Execute JavaScript              window.scrollBy(0,500)
    Click Element                       xpath=//button[normalize-space()="ถัดไป"]

    Input Text                      id=firstName                ${BLACKLIST_USER}
    Input Text                      id=lastName                 ${BLACKLIST_EMAIL}
    Input Text                      id=phoneNumber              ${BLACKLIST_TEL}
    Sleep                           2s
    Click Element                   xpath=//label[normalize-space()="ชาย"]/input
    Wait Until Element Is Visible       xpath=//button[normalize-space()="ถัดไป"]
    Click Element                       xpath=//button[normalize-space()="ถัดไป"]

    Choose File    id=idCardFile    ${BLACKLIST_ID_PATH}
    Input Text                      id=idNumber                     ${BLACKLIST_ID}
    Input Text                      id=expiryDate                   ${EXPID_DATE}
    Choose File    id=selfieFile     ${BLACKLIST_SELF_PATH}
    
    Click Element                   xpath=//input[@type="checkbox"]
    Click Element                   xpath=//button[starts-with(normalize-space(), "สมัครสมาชิก")]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"ข้อมูลซ้ำ")]    10s
