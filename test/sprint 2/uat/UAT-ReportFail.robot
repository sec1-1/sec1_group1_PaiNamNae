*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-ReportFail-004  : Passenger Report and upload image 4 file
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                       PASSENGER_ISSUE
    Input Text    xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]      ${REPORT_TEXT}
    Upload 3 Image and 1 Video
    Click Element                   xpath=(//button[normalize-space()="ส่งรายงานความปลอดภัย"])
  
    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    # พร้อมขึ้นข้อความว่า "(รอ Frontend Design)"

UAT-ReportFail-005  : Passenger Report and do not select topic
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Input Text    xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]      ${REPORT_TEXT}
    Click Element                   xpath=(//button[normalize-space()="ส่งรายงานความปลอดภัย"])

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    # พร้อมขึ้นข้อความว่า "(รอ Frontend Design)"

UAT-ReportFail-006  : Passenger Report and do not fill report detail
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                       PASSENGER_ISSUE
    Click Element                   xpath=(//button[normalize-space()="ส่งรายงานความปลอดภัย"])

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    # พร้อมขึ้นข้อความว่า "(รอ Frontend Design)"

UAT-ReportFail-007  : Passenger Report and do not fill anything
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Click Element                   xpath=(//button[normalize-space()="ส่งรายงานความปลอดภัย"])

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    # พร้อมขึ้นข้อความว่า "(รอ Frontend Design)"
