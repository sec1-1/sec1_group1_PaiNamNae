*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-ReportFail-004 Passenger Report and upload image 4 file
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                       PASSENGER_ISSUE
    Input Text    xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]      ${REPORT_TEXT}
    Upload 4 Images
  
    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    Wait Until Element Is Visible    xpath=//*[contains(text(),"เพิ่มรูปได้สูงสุด 3 รูป")]    10s

UAT-ReportFail-005 Passenger Report and do not select topic
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Input Text    xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]      ${REPORT_TEXT}

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    Element Should Be Disabled    xpath=//button[contains(text(),'ส่งรายงานความปลอดภัย')]

UAT-ReportFail-006 Passenger Report and do not fill report detail
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                       PASSENGER_ISSUE

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    Element Should Be Disabled    xpath=//button[contains(text(),'ส่งรายงานความปลอดภัย')]

UAT-ReportFail-007 Passenger Report and do not fill anything
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    Element Should Be Disabled    xpath=//button[contains(text(),'ส่งรายงานความปลอดภัย')]
