*** Keywords ***
Login With Valid User
    Open Browser    ${URL}    chrome
    Input Text      id=username    ${VALID_USER}
    Input Text      id=password    ${VALID_PASS}
    Click Button    id=login-btn

Admin Login
    Open Browser    ${URL}    chrome
    Input Text      id=username    ${ADMIN_USER}
    Input Text      id=password    ${ADMIN_PASS}
    Click Button    id=login-btn
    Page Should Contain    Dashboard

Dashboard Should Be Visible
    Page Should Contain    Dashboard