*** Comments ***
# ============================================================
# ชื่อไฟล์: auth_resource.robot
#
# คำอธิบาย:
#     ไฟล์นี้ใช้สำหรับเก็บ Keyword ที่เกี่ยวข้องกับ
#     การยืนยันตัวตน (Authentication) เช่น
#     Login, Logout และการจัดการ Session
#
# วัตถุประสงค์:
#     - รวมคำสั่งด้าน Auth ไว้ส่วนกลาง
#     - ลดการเขียนโค้ดซ้ำในแต่ละ Test Case
#     - เพิ่มความสะดวกในการแก้ไขและบำรุงรักษา
#
# แนวทางการใช้งาน:
#     ให้นำไฟล์นี้ไปเรียกใช้ใน Test Case ด้วยคำสั่ง:
#         Resource    ../../resources/auth_resource.robot
#
# ข้อกำหนดในการพัฒนา:
#     - ห้ามกำหนด Username/Password แบบ Hardcode
#       (ให้ใช้ไฟล์ Variables แยกต่างหาก)
#     - Keyword ควรออกแบบให้สามารถใช้งานซ้ำได้
#     - ไม่ควรสร้าง Keyword ที่ผูกกับ Sprint ใด Sprint หนึ่ง
#     - หากเพิ่ม Flow ใหม่ ให้จัดกลุ่มให้ชัดเจน
#
# ผู้ดูแลไฟล์:
#     ทีม UAT Automation
#
# วันที่แก้ไขล่าสุด:
#     26-02-2026

*** Settings ***
Library         SeleniumLibrary
Library         String
Resource       ../resources/keywords/auth_keywords.robot


*** Variables ***
# ตัวแปรที่ใช้บน Localhost
${URL}    http://localhost:3001/
${VALID_PASS}               123456789
${ADMIN_USER}               admin123
${ADMIN_FIRST_NAME}         System
${ADMIN_PASS}               123456789
${BLACKLIST_USER}           goodboy
${BLACKLIST_EMAIL}          good@mail.com
${BLACKLIST_PASS}           asdfjkl;123
${BLACKLIST_SUR}            Goodboy
${BLACKLIST_LAST}           andgoodgirl
${BLACKLIST_TEL}            0987654333
${BLACKLIST_ID}             1234567890987
${EXPID_DATE}               02022030
${BLACKLIST_ID_PATH}        D:/Coding Project/Github Project/Software Engineering/My Branch/sec1_group1_PaiNamNae/test/resources/IDCard.jpg
${BLACKLIST_SELF_PATH}      D:/Coding Project/Github Project/Software Engineering/My Branch/sec1_group1_PaiNamNae/test/resources/Selfies.jpg
${PASSENGER_USER}           Veerapat
${PASSENGER_SURNAME}        Veera
${PASSENGER_PASS}           asdfjkl;123

${IMAGE_PATH}               D:/Coding Project/Github Project/Software Engineering/My Branch/sec1_group1_PaiNamNae/test/resources/IMG-8206.jpg
${INVALID_PATH}             D:/Coding Project/Github Project/Software Engineering/My Branch/sec1_group1_PaiNamNae/test/resources/This is pdf file.pdf
${IMAGE01_PATH}             ..\..\..\image\pexels-hazardos-8041.jpg
${IMAGE02_PATH}             ..\..\..\image\pexels-hazardos-80412.jpg
${IMAGE03_PATH}             ..\..\..\image\pexels-hazardos-804129.jpg
${VIDEO01_PATH}             ..\..\..\image\3785380-hd_1920_1080_25fps.mp4             

# ตัวแปรที่ใช้บนเว็บที่ Deploy แล้ว
${PASSENGER_REVIEW_USER}
${PASSENGER_REVIEW_SURNAME}
${PASSENGER_REVIEW_PASS}

${PASSENGER_VIEW_USER}
${PASSENGER_VIEW_SURNAME}
${PASSENGER_VIEW_PASS}

# ตัวแปรที่ใช้ได้ทั้ง Localhost และ Deploy 
${REVIEW_TEXT}              ขับเร็วทันใจ คนขับสุภาพ รถสะอาด ตรงเวลา
${REPORT_TEXT}              ขับรถแย่มาก ฝ่าไปแดง ขับเร็ว ขับส่ายไปส่ายมา

# รวมฟังก์ชั่นทั้งหมด สามารถพิมพ์แค่ชื่อและนำไปใช้ได้เลยในไฟล์ UAT_Test
*** Keywords ***
# -----------------------------
# กลุ่ม: Login
# -----------------------------
Admin Login
    Click Element                   xpath=//a[@href='/login']
    Wait Until Location Contains    /login    10s
    Location Should Contain         /login
    Input Text                      id=identifier       ${ADMIN_USER}
    Input Text                      id=password         ${ADMIN_PASS}
    Click Button                    xpath=//button[@type='submit']

Passenger Login
    Click Element                   xpath=//a[@href='/login']
    Wait Until Location Contains    /login                          10s
    Location Should Contain         /login
    Input Text                      id=identifier                   ${PASSENGER_USER}
    Input Text                      id=password                     ${PASSENGER_PASS}
    Click Button                    xpath=//button[@type='submit']

# ฟังก์ชั่นนี้ ใช้ข้อมูลจาก Database จริง
Passenger Create Review Login
    Click Element                   xpath=//a[@href='/login']
    Wait Until Location Contains    /login                          10s
    Location Should Contain         /login
    Input Text                      id=identifier                   ${PASSENGER_REVIEW_USER}
    Input Text                      id=password                     ${PASSENGER_REVIEW_PASS}
    Click Button                    xpath=//button[@type='submit']

    # ==== Expected Results ====
    Wait Until Element Is Visible       xpath=//span[normalize-space()='${PASSENGER_REVIEW_SURNAME}']    10s
    Element Should Be Visible           xpath=//span[normalize-space()='${PASSENGER_REVIEW_SURNAME}']

# ฟังก์ชั่นนี้ ใช้ข้อมูลจาก Database จริง
Passenger View Review Login
    Click Element                   xpath=//a[@href='/login']
    Wait Until Location Contains    /login                          10s
    Location Should Contain         /login
    Input Text                      id=identifier                   ${PASSENGER_VIEW_USER}
    Input Text                      id=password                     ${PASSENGER_VIEW_USER}
    Click Button                    xpath=//button[@type='submit']

    # ==== Expected Results ====
    Wait Until Element Is Visible       xpath=//span[normalize-space()='${PASSENGER_VIEW_SURNAME}']    10s
    Element Should Be Visible           xpath=//span[normalize-space()='${PASSENGER_VIEW_SURNAME}']

# -----------------------------
# กลุ่ม: ตรวจสอบว่าอยู่ในหน้า Dashboard
# -----------------------------
Dashboard User Should Be Visible
    Wait Until Element Is Visible       xpath=//span[normalize-space()='${PASSENGER_SURNAME}']    10s
    Element Should Be Visible           xpath=//span[normalize-space()='${PASSENGER_SURNAME}']

Dashboard Admin Should Be Visible
    Wait Until Element Is Visible       xpath=//span[normalize-space()='${ADMIN_FIRST_NAME}']    10s
    Element Should Be Visible           xpath=//span[normalize-space()='${ADMIN_FIRST_NAME}']

# -----------------------------
# กลุ่ม: กดปุ่มไปแต่ละหน้า
# -----------------------------
Go To User Management Page
    Mouse Over                          xpath=//span[normalize-space()='${ADMIN_FIRST_NAME}']
    Wait Until Element Is Visible       xpath=//a[@href='/admin/users']    10s
    Click Element                       xpath=//a[@href='/admin/users']
    Page Should Contain                 User Management   

View All Route
    Click Element                   xpath=//a[@href='/findTrip']

View My Trip
    Click Element                   xpath=//a[@href='/myTrip']
    Sleep                           2s
    Click Element                   xpath=//button[starts-with(normalize-space(), "ทั้งหมด")]

View Passenger Info
    Wait Until Element Is Visible    xpath=//h4[normalize-space()="Takumi Fujiwara"]    10s
    Click Element                    xpath=//h4[normalize-space()="Takumi Fujiwara"]

# -----------------------------
# กลุ่ม: Checkbox Review
# -----------------------------
Select Few Checkbox
    Select Checkbox    xpath=//input[@value="CLEAN"]
    Select Checkbox    xpath=//input[@value="ON_TIME"]

Select All Checkboxes
    Select Checkbox    xpath=//input[@value="CLEAN"]
    Select Checkbox    xpath=//input[@value="POLITE_DRIVER"]
    Select Checkbox    xpath=//input[@value="ON_TIME"]
    Select Checkbox    xpath=//input[@value="SAFE_DRIVING"]
    Select Checkbox    xpath=//input[@value="FRIENDLY_SERVICE"]

# -----------------------------
# กลุ่ม: Upload File
# -----------------------------
Upload 2 Image and 1 Video
    Choose File         xpath=//input[@type="file"]    ${IMAGE01_PATH}
    Choose File         xpath=//input[@type="file"]    ${IMAGE02_PATH}
    Choose File         xpath=//input[@type="file"]    ${VIDEO01_PATH}

Upload 3 Image and 1 Video
    Choose File         xpath=//input[@type="file"]    ${IMAGE01_PATH}
    Choose File         xpath=//input[@type="file"]    ${IMAGE02_PATH}
    Choose File         xpath=//input[@type="file"]    ${IMAGE03_PATH}
    Choose File         xpath=//input[@type="file"]    ${VIDEO01_PATH}

# -----------------------------
# กลุ่ม: Report
# -----------------------------
