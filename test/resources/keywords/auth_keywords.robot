*** Variables ***
${URL}    http://localhost:3001/
${VALID_PASS}           123456789
${ADMIN_USER}           admin123
${ADMIN_FIRST_NAME}     System
${ADMIN_PASS}           123456789
${BLACKLIST_USER}       
${BLACKLIST_PASS}   
${PASSENGER_USER}       Veerapat
${PASSENGER_SURNAME}    Veera
${PASSENGER_PASS}       asdfjkl;123

*** Keywords ***
Open Web Page
    Open Browser                    ${URL}    chrome

Admin Login
    Open Web Page
    Click Element                   xpath=//a[@href='/login']
    Wait Until Location Contains    /login    10s
    Location Should Contain         /login
    Input Text                      id=identifier    ${ADMIN_USER}
    Input Text                      id=password    ${ADMIN_PASS}
    Click Button                    xpath=//button[@type='submit']

Go To User Management Page
    Mouse Over                          xpath=//span[normalize-space()='${ADMIN_FIRST_NAME}']
    Wait Until Element Is Visible       xpath=//a[@href='/admin/users']    10s
    Click Element                       xpath=//a[@href='/admin/users']
    Page Should Contain                 User Management   

Dashboard User Should Be Visible
    Wait Until Element Is Visible       xpath=//span[normalize-space()='${PASSENGER_SURNAME}']    10s
    Element Should Be Visible           xpath=//span[normalize-space()='${PASSENGER_SURNAME}']

Dashboard Admin Should Be Visible
    Wait Until Element Is Visible       xpath=//span[normalize-space()='${ADMIN_FIRST_NAME}']    10s
    Element Should Be Visible           xpath=//span[normalize-space()='${ADMIN_FIRST_NAME}']

Passenger Login
    Open Web Page
    Click Element                   xpath=//a[@href='/login']
    Wait Until Location Contains    /login                          10s
    Location Should Contain         /login
    Input Text                      id=identifier                   ${PASSENGER_USER}
    Input Text                      id=password                     ${PASSENGER_PASS}
    Click Button                    xpath=//button[@type='submit']

View All Route
    Click Element                   xpath=//a[@href='/findTrip']
    
View My Trip
    Click Element                   xpath=//a[@href='/myTrip']
    Sleep                           2s
    Click Element                   xpath=//button[starts-with(normalize-space(), "ทั้งหมด")]

View Passenger Info
    Wait Until Element Is Visible    xpath=//h4[normalize-space()="Takumi Fujiwara"]    10s
    Click Element                    xpath=//h4[normalize-space()="Takumi Fujiwara"]
Select Few Checkbox
    Select Checkbox    xpath=//input[@value="CLEAN"]
    Select Checkbox    xpath=//input[@value="ON_TIME"]

Select All Checkboxes
    Select Checkbox    xpath=//input[@value="CLEAN"]
    Select Checkbox    xpath=//input[@value="POLITE_DRIVER"]
    Select Checkbox    xpath=//input[@value="ON_TIME"]
    Select Checkbox    xpath=//input[@value="SAFE_DRIVING"]
    Select Checkbox    xpath=//input[@value="FRIENDLY_SERVICE"]