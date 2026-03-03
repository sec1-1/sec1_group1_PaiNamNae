*** Settings ***
Library    SeleniumLibrary
Resource   ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-028 Passenger Close Review Page
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,350)
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[11]
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ยกเลิก"]
    Sleep    2s
    # ==== Expected Results ====
    Location Should Contain         /myTrip
