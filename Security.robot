*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Library    OperatingSystem

*** Variables ***
${BASE_URL}    https://develop.qacoders-academy.com.br/api/login
${VALID_MAIL}    sysadmin@qacoders.com
${VALID_PASSWORD}    1234@Test

*** Test Cases ***
Send Valid Login Request
    [Documentation]    Enviar uma requisição de login válida e verificar a resposta.
    Create Session    session    ${BASE_URL}    verify=${False}
    ${data}=    Create Dictionary    mail=${VALID_MAIL}    password=${VALID_PASSWORD}
    ${response}=    POST On Session    session    /    json=${data}
    Log    Status Code: ${response.status_code}
    Log    Response: ${response.json()}
    Should Be Equal As Strings    ${response.status_code}    200

Test Weak Password
    [Documentation]    Verificar se a API aceita uma senha comum/fraca.
    Create Session    session    ${BASE_URL}    verify=${False}
    ${data}=    Create Dictionary    mail=${VALID_MAIL}    password=123456
    ${response}=    POST On Session    session    /    json=${data}
    Log    Status Code: ${response.status_code}
    Log    Response: ${response.json()}
    Should Not Be Equal As Strings    ${response.status_code}    200

Test SQL Injection
    [Documentation]    Verificar se a API é vulnerável a SQL Injection.
    Create Session    session    ${BASE_URL}    verify=${False}
    ${data}=    Create Dictionary    mail=${VALID_MAIL}    password=' OR \'1\'=\'1'
    ${response}=    POST On Session    session    /    json=${data}
    Log    Status Code: ${response.status_code}
    Log    Response: ${response.json()}
    Should Not Be Equal As Strings    ${response.status_code}    200

Test Brute Force Protection
    [Documentation]    Simular tentativas de login com várias senhas para verificar proteção contra força bruta.
    Create Session    session    ${BASE_URL}    verify=${False}
    ${invalid_passwords}=    Create List    wrongpassword1    wrongpassword2    wrongpassword3
    FOR    ${password}    IN    @{invalid_passwords}
        ${data}=    Create Dictionary    mail=${VALID_MAIL}    password=${password}
        ${response}=    POST On Session    session    /    json=${data}
        Log    Status Code: ${response.status_code}
        Log    Response: ${response.json()}
        Should Be True    ${response.status_code} in [401, 403]
    END
