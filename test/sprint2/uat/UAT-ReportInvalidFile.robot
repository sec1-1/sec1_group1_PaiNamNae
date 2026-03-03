*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource   ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-010 Passenger Upload Invalid File
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,325)
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[11]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                       PASSENGER_ISSUE
    Input Text                      xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]      ${REPORT_TEXT}
    Choose File         xpath=//input[@type="file"]    ${PDF_PATH}
    
    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"กรุณาเลือกไฟล์รูปหรือวิดีโอเท่านั้น")]    10s

UAT-011 Passenger Upload File Video More than 50MB
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,325)
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[11]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                       PASSENGER_ISSUE
    Input Text                      xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]      ${REPORT_TEXT}
    Choose File                     xpath=//input[@type="file"]    ${INVALID_VIDEO}

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"ขนาดไฟล์ต้องไม่เกิน 50MB")]    10s


