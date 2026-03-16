*** Settings ***
Library         SeleniumLibrary
Resource       ../resources/keywords/auth_keywords.robot
Library         String
<<<<<<< HEAD
Variables       variables/credentials.robot
Variables       variables/testdata.robot
=======

# รวมฟังก์ชั่นทั้งหมด สามารถพิมพ์แค่ชื่อและนำไปใช้ได้เลยในไฟล์ UAT_Test
*** Keywords ***
# -----------------------------
# กลุ่ม: Setup Delay
# -----------------------------
Setup Delay Selenium
    Set Selenium Implicit Wait    5s
    Set Selenium Speed            0.5s

# -----------------------------
# กลุ่ม: Login
# -----------------------------
Admin Login
    Click Element                   xpath=//a[@href='/login']
    Wait Until Location Contains    /login    10s
    Location Should Contain         /login
    Input Text                      //input[@placeholder="กรอกชื่อผู้ใช้หรืออีเมล"]       ${ADMIN_USER}
    Input Text                      //input[@placeholder="กรอกรหัสผ่าน"]         ${ADMIN_PASS}
    Click Button                    xpath=//button[@type='submit']

Passenger Login
    Click Element                   xpath=//a[@href='/login']
    Wait Until Location Contains    /login                          10s
    Location Should Contain         /login
    Input Text                      //input[@placeholder="กรอกชื่อผู้ใช้หรืออีเมล"]               ${PASSENGER_USER}
    Input Text                      //input[@placeholder="กรอกรหัสผ่าน"]                     ${PASSENGER_PASS}
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
    Input Text                      //input[@placeholder="กรอกชื่อผู้ใช้หรืออีเมล"]                ${PASSENGER_VIEW_USER}
    Input Text                      //input[@placeholder="กรอกรหัสผ่าน"]                      ${PASSENGER_VIEW_PASS}
    Click Button                    xpath=//button[@type='submit']

    # ==== Expected Results ====
    Wait Until Element Is Visible       xpath=//span[normalize-space()='${PASSENGER_VIEW_SURNAME}']    10s
    Element Should Be Visible           xpath=//span[normalize-space()='${PASSENGER_VIEW_SURNAME}']

Passenger Deploy Login
    Click Element                   xpath=//a[@href='/login']
    Wait Until Location Contains    /login                          10s
    Location Should Contain         /login
    Input Text                      //input[@placeholder="กรอกชื่อผู้ใช้หรืออีเมล"]               ${PASSENGER1_USER}
    Input Text                      //input[@placeholder="กรอกรหัสผ่าน"]                     ${PASSENGER1_PASS}
    Click Button                    xpath=//button[@type='submit']

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

Go To User Profile Page
    Mouse Over                          xpath=//span[normalize-space()='${PASSENGER_SURNAME}']
    Wait Until Element Is Visible       xpath=//a[normalize-space()="บัญชีของฉัน"]    10s
    Click Element                       xpath=//a[normalize-space()="บัญชีของฉัน"]
    Page Should Contain                 โปรไฟล์และการตั้งค่า
    Page Should Contain                 โปรไฟล์ของฉัน   

Go To Check Report
    Click Element                   xpath=//a[.//span[normalize-space()="Check Report"]]

View All Route
    Click Element                   xpath=//a[@href='/findTrip']

View My Trip
    Click Element                   xpath=//a[@href='/myTrip']
    Sleep                           2s
    Click Element                   xpath=//button[starts-with(normalize-space(), "ทั้งหมด")]

View Passenger Info
    Wait Until Element Is Visible    xpath=//h4[normalize-space()="Takumi Fujiwara"]    10s
    Click Element                    xpath=//h4[normalize-space()="Takumi Fujiwara"]

View Notification
    Wait Until Element Is Visible    xpath=//button[@aria-haspopup="true"]    10s
    Click Element                    xpath=//button[@aria-haspopup="true"]
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

Upload 4 Images
    Choose File         xpath=//input[@type="file"]    ${IMAGE01_PATH}
    Choose File         xpath=//input[@type="file"]    ${IMAGE02_PATH}
    Choose File         xpath=//input[@type="file"]    ${IMAGE03_PATH}
    Choose File         xpath=//input[@type="file"]    ${IMAGE04_PATH}
