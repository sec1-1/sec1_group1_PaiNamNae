*** Variable ***
${URL}    http://localhost:3001/
${VALID_USER}           Takumi
${VALID_FIRST_NAME}     Takumi
${VALID_PASS}           123456789
${ADMIN_USER}           admin123
${ADMIN_FIRST_NAME}     System
${ADMIN_PASS}           123456789

*** Keywords ***
Open Web Page
    Open Browser                    ${URL}    chrome

Admin Login
    Open Browser                    ${URL}    chrome
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
    Wait Until Element Is Visible       xpath=//span[normalize-space()='${VALID_FIRST_NAME}']    10s
    Element Should Be Visible           xpath=//span[normalize-space()='${VALID_FIRST_NAME}']

Dashboard Admin Should Be Visible
    Wait Until Element Is Visible       xpath=//span[normalize-space()='${ADMIN_FIRST_NAME}']    10s
    Element Should Be Visible           xpath=//span[normalize-space()='${ADMIN_FIRST_NAME}']
