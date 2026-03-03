*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-ReportFail-009 Passenger Report and comments limit
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                       PASSENGER_ISSUE
    ${RANDOM_TEXT}=    Generate Random String    501    [LETTERS]
    Input Text    xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]      ${RANDOM_TEXT}
  
    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    Element Text Should Be          //div[contains(@class,"text-xs")]    501 / 501