*** Settings ***
Library    SeleniumLibrary
Resource   ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
# ==== UAT-012 Passenger Repeat Review ====
UAT-029 Passenger Repeat Review
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,375)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[11]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Double Review ====
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[11]
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Dashboard User Should Be Visible
    Wait Until Element Is Visible    xpath=//*[contains(text(),"Already reviewed")]    10s
    Element Should Be Visible        xpath=//*[contains(text(),"Already reviewed")]