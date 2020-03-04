*** Settings ***
Library           SeleniumLibrary
Library           ExcelLibrary
Library           clipboard
Library           String
Library           ImageHorizonLibrary
Library           DateTime

*** Variables ***
${Count1}         ${EMPTY}
${Var1}           ${EMPTY}
${Url}            https://civil.pjud.cl/CIVILPORWEB
@{Count1}
${path_excel}     resultado/Nombres.xls
${Nombre}         ${EMPTY}
${NombreCopiar}    ${EMPTY}
${ApellidoPaternoCopiar}    ${EMPTY}
${ApellidoMaternoCopiar}    ${EMPTY}
${RutCopiar}      ${EMPTY}
${NombreHoja}     nombres
${Contador}       ${1}
${Var2}           ${EMPTY}
${ContadorDeCasosInternos}    ${EMPTY}
${MyText}         ${EMPTY}
${ContadorCasos}    ${EMPTY}
${ContadorCasos2}    1
${EstadoPersona}    ${EMPTY}
${MensajePositivo}    Soy un valor verdadero
${MensajeNegativo}    No somos iguales
${RutCopiar1}     ${EMPTY}
${ContadorRutDentroCaso}    14

*** Test Cases ***
Test1
    Open Excel    ${path_excel}    #Ubicacion de archivo Excel.
    ${Count1}    Get Row Count    ${NombreHoja}    #Cuenta el total de valores de la columnas
    @{Count1}    Get column values    ${NombreHoja}    1    #vALORES DE LA COLUMNA 1
    FOR    ${Var1}    IN    @{Count1}    #Busca por cada fila en la pagina pjud
        BuscadorDeCasos
        Contador
        Sleep    5s
        ValidarCasosTotal
        ContadorCasosInternosReset
        Sleep    5s
        Close Browser
        Log    ${Var1}
    END

Test2
    Open Browser    https://civil.pjud.cl/CIVILPORWEB    chrome
    Wait Until Element Is Visible    name=body
    Select Frame    name=body
    Click Element    //td[contains(@id,'tdCuatro')]
    clipboard.Copy    Chacón
    Input Text    //input[contains(@name,'NOM_Consulta')]    diego
    Input Text    //input[contains(@name,'APE_Paterno')]    medel
    Click Element    //input[contains(@name,'APE_Materno')]
    Press Keys    none    CTRL+V
    Press Keys    \    ENTER
    Sleep    5s
    ValidarCasosTotal

TestCtrlF
    Open Browser    https://stackoverflow.com/questions/34961646/retrieve-html-data-with-robot-framework-and-xpath    chrome
    ${ValorF}=    Press Combination    Key.ctrl    F
    Press Combination    Key.ctrl    V
    Log    ${ValorF}

ProbarTeclaReturn
    Open Browser    https://www.google.com/search?q=hola&oq=hola&aqs=chrome..69i57j0l6j69i61.1508j0j7&sourceid=chrome&ie=UTF-8    chrome
    Click Element    //h3[@class='LC20lb DKV0Md'][contains(.,'HOLA.com, diario de actualidad, moda y belleza')]
    Go Back
    Click Element    //a[@href='https://www.hola.com/realeza/']
    Close Window

TestExcel
    GuardadoEnExcel

PruebaDeValidacionDeRutPjud
    [Documentation]    Pendiente
    SeleniumLibrary.Open Browser    https://civil.pjud.cl/CIVILPORWEB    chrome
    Sleep    9s
    SeleniumLibrary.wait Until Element Is Visible    name=body
    SeleniumLibrary.Select Frame    name=body
    SeleniumLibrary.Click Element    //td[contains(@id,'tdCuatro')]
    clipboard.Copy    Chacón
    SeleniumLibrary.Input Text    //input[contains(@name,'NOM_Consulta')]    diego
    SeleniumLibrary.Input Text    //input[contains(@name,'APE_Paterno')]    medel
    SeleniumLibrary.Click Element    //input[contains(@name,'APE_Materno')]
    SeleniumLibrary.Press Keys    none    CTRL+V
    SeleniumLibrary.Press Keys    \    ENTER
    Sleep    9s
    SeleniumLibrary.Click Element    (//td[contains(@class,'textoC')])[1]
    Sleep    21s
    SeleniumLibrary.Click Element    (//td[contains(.,'Litigantes')])[1]
    Sleep    2s
    ${RutCopiar1}=    Set Variable    15771613-1
    ${Span}=    SeleniumLibrary.Get WebElements    //td[@class='texto'][contains(.,'15771613-1')]
    Log    ${Span}
    log    ${RutCopiar1}
    ${test}=    Get Element Count    //td[@class='texto'][contains(.,'115771613-1')]
    log    ${test}
    Run Keyword If    ${test}>0    log    "Hay un rut valido"
    ...    ELSE    log    "No hay rut valido aca"
        Close Browser

PruebaDeValidacionDeRutPjud1
    [Documentation]    Pendiente
    Open Browser    https://civil.pjud.cl/CIVILPORWEB    chrome
    Wait Until Element Is Visible    name=body
    Select Frame    name=body
    Click Element    //td[contains(@id,'tdCuatro')]
    clipboard.Copy    Chacón
    Input Text    //input[contains(@name,'NOM_Consulta')]    diego
    Input Text    //input[contains(@name,'APE_Paterno')]    medel
    Click Element    //input[contains(@name,'APE_Materno')]
    Press Keys    none    CTRL+V
    Press Keys    \    ENTER
    Sleep    5s
    Click Element    (//td[contains(@class,'textoC')])[1]
    Sleep    21s
    Click Element    (//td[contains(.,'Litigantes')])[1]
    Sleep    2s
    ${RutCopiar1}=    Set Variable    15771613-1222
    log    ${RutCopiar1}
    #Wait Until Element Is Visible    //th[contains(@id,'Tit1')]
    Sleep    5s
    ${Span}=    Get WebElements    //td[@class='texto'][contains(.,'15771613-1')]
    Sleep    5s
    Log    ${Span}=
    Sleep    5s
    Sleep    5s
    ${MyText}=    Get Text    ${Span[0]}
    Sleep    5s
    Log    ${MyText}
    Sleep    5s
    ${MyTex2t}=    Remove String Using Regexp    ${MyText}    /^[a-zA-Z\s]*$/;
    Log    ${MyTex2t}
    ${string}=    String.Fetch From Left    ${MyText}    )
    ${string}=    String.Replace String    ${string}    ${Space}    ${EMPTY}
    Log    ${string}
    ${MyText}=    Remove String    ${string}    Causas    [    ]    :    Cantidad
    Log    ${MyText}
    Convert To String    ${MyText}
    Convert To String    ${RutCopiar1}
    #Should Be Equal As Strings    ${MyText}    ${RutCopiar1}    #${Tempo1}=    Evaluate    Should Be Equal As Strings    ${MyText}    erwe    #Run Keyword If    ${MyText}==${RutCopiar1}    "Somos iguales"    # ELSE    "Somos Distintos"
    Run Keyword If    "${MyText}"=="${RutCopiar1}"    log    "Somos iguales"
    ...    ELSE    log    "Somos Distintos"
    Close Browser

*** Keywords ***
AperturaCasosV2
    Click Element    (//td[contains(@class,'textoC')])[1]
    Sleep    9s
    Click Element    (//td[contains(.,'Litigantes')])[1]
    Sleep    9s
    Log    Apertura de caso ok
    Close Browser

AperturaDeCasos
    [Documentation]    Apertura de cada causa.
    Log    ${ContadorCasos}
    Log    ${RutCopiar}
    Log    ${ContadorCasos}
    #Select Frame    name=body
    FOR    ${Var2}    IN    ${ContadorCasos}
        Sleep    10s
        Click Element    (//td[contains(@class,'textoC')])[${ContadorCasos2}]
        Sleep    21s
        Click Element    (//td[contains(.,'Litigantes')])[1]
        Sleep    20s
        ValidarRutExcelHaciaPjud
        Go Back    #Go Back
        Sleep    15s
        Select Frame    name=body
        Sleep    10s
        ContadorCasosInternos
    END

BuscadorDeCasos
    [Documentation]    Asignador de variables a pagina pjud.
    Open Browser    ${Url}    chrome
    Sleep    10s
    Select Frame    name=body
    Click Element    //td[contains(@id,'tdCuatro')]
    ${NombreCopiar}    Read Cell Data By Name    ${NombreHoja}    B${Contador}
    clipboard.Copy    ${NombreCopiar}
    ${NombreCopiar}    Set Suite Variable    ${NombreCopiar}
    Log    ${NombreCopiar}
    Click Element    //input[contains(@name,'NOM_Consulta')]
    Press Keys    none    CTRL+V
    ${ApellidoPaternoCopiar}    Read Cell Data By Name    ${NombreHoja}    D${Contador}
    clipboard.Copy    ${ApellidoPaternoCopiar}
    ${ApellidoPaternoCopiar}    Set Suite Variable    ${ApellidoPaternoCopiar}
    Log    ${ApellidoPaternoCopiar}
    Click Element    //input[contains(@name,'APE_Paterno')]
    Press Keys    none    CTRL+V
    ${ApellidoMaternoCopiar}    Read Cell Data By Name    ${NombreHoja}    E${Contador}
    clipboard.Copy    ${ApellidoMaternoCopiar}
    ${ApellidoMaternoCopiar}    Set Suite Variable    ${ApellidoMaternoCopiar}
    Log    ${ApellidoMaternoCopiar}
    Click Element    //input[contains(@name,'APE_Materno')]
    Press Keys    none    CTRL+V
    ${RutCopiar}    Read Cell Data By Name    ${NombreHoja}    A${Contador}
    clipboard.Copy    ${RutCopiar}
    ${RutCopiar}    Set Suite Variable    ${RutCopiar}
    Log    ${RutCopiar}
    Sleep    10s
    Press Keys    \    ENTER
    Sleep    10s
    Wait Until Element Is Visible    //th[contains(@id,'Tit1')]
    Sleep    10s
    Log    ${RutCopiar}

ConsultaDeCasos

Contador
    [Documentation]    Contador del total de personas de los cuales se consideraran para las consultas.
    #${Contador} =    Set Variable    ${Contador + 1}
    ${temp}    Evaluate    ${Contador} + 1
    Set Test Variable    ${Contador}    ${temp}

ContadorCasos

ContadorCasosInternos
    ${temp2}    Evaluate    ${ContadorCasos2}+2
    Set Test Variable    ${ContadorCasos2}    ${temp2}

ContadorCasosInternosReset
    ${temp2}    Evaluate    1
    Set Test Variable    ${ContadorCasos2}    ${temp2}

GuardadoEnExcel
    [Documentation]    Guarda las consultas realizadas
    ...    En un archivo tipo xls 97-2003 con la hora y fecha, con
    ...    que se realizó la prueba.
    Open Excel    resultado/Prototipo.xls
    ${RutCopiar}
    ${NombreCopiar}
    ${ApellidoPaternoCopiar}
    ${ApellidoMaternoCopiar}
    ${EstadoPersona}
    Put String To Cell    resultado    0    5    Ahora Guarda
    Put String To Cell    resultado    0    6    Ahora Guarda
    Put String To Cell    resultado    0    7    Ahora Guarda
    ${timestamp} =    Get Current Date    result_format=%Y-%m-%d-%H-%M
    ${filename} =    Set Variable    resultado-${timestamp}.xls
    Save Excel    resultado/${filename}
    Create Excel Workbook    soyTest
    Save Excel    soyTest.xls

ValidarCasosTotal
    [Documentation]    Validar el total de causas y extraer el total como numero.
    Sleep    5s
    Sleep    15s
    Wait Until Element Is Visible    //th[contains(@id,'Tit1')]
    Sleep    5s
    ${Span}=    Get WebElements    //th[contains(@id,'Tit1')]
    Sleep    5s
    Wait Until Element Is Visible    //th[contains(@id,'Tit1')]
    Log Many    ${Span}=
    Sleep    5s
    Wait Until Element Is Visible    //th[contains(@id,'Tit1')]
    Sleep    5s
    ${MyText}=    Get Text    ${Span[0]}
    Wait Until Element Is Visible    //th[contains(@id,'Tit1')]
    Sleep    5s
    Log    ${MyText}
    Wait Until Element Is Visible    //th[contains(@id,'Tit1')]
    Sleep    5s
    ${MyTex2t}=    Remove String Using Regexp    ${MyText}    /^[a-zA-Z\s]*$/;
    Log    ${MyTex2t}
    ${string}=    String.Fetch From Left    ${MyText}    )
    ${string}=    String.Replace String    ${string}    ${Space}    ${EMPTY}
    Log    ${string}
    ${MyText}=    Remove String    ${string}    Causas    [    ]    :    Cantidad
    Log    ${MyText}
    Convert To Number    ${MyText}
    Log    Ahora soy un numero
    Log    ${MyText}
    Set Test Variable    ${ContadorCasos}    ${MyText}
    Log    ${ContadorCasos}
    Run Keyword If    ${MyText}>0    Repeat Keyword    ${ContadorCasos} times    AperturaDeCasos
    ...    ELSE    Close Browser
    Set Test Variable    ${ContadorCasos}    0

ValidarTotaldeCasos

ObtenerFechaExccel
    [Documentation]    Agrega Fecha y hora al archivo excel,que se entrega como resultado.
    ${timestamp} =    Get Current Date    result_format=%Y-%m-%d
    ${filename} =    Set Variable    resultado-${timestamp}.xls
    Save Excel Current Directory    ${filename}

ValidarRutExcelHaciaPjud
    [Documentation]    validar Rut de Excel en pjud
    log    ${Contador}
    log    ${NombreCopiar}
    log    ${RutCopiar}
    log    ${ApellidoMaternoCopiar}
    log    ${ApellidoPaternoCopiar}
    Sleep    2s
    #Should Contain Any    Get WebElements    //td[@class='texto'][contains(.,'${RutCopiar}')]
    Sleep    5s    #${elList} =    Get WebElements    //td[@class='texto'][contains(.,'${RutCopiar}')]    #${rowList} =    evaluate    [item.get_attribute('innerHTML')    for    item    in    ${elList}]    #@{elem}=    Get WebElements    //td[@class='texto'][contains(.,'${RutCopiar}')]    #FOR    ${item}
    ...    # IN    @{elem}    #    Log To Console    Item:    # ${item.text}    #log    # ${Span}    #Run Keyword If    # ${Span}==\    "Vacio"    # ELSE    "Hay Algo"    #Convert To String    ${Span}    #Run Keyword If
    ...    # ${Span}!=[]    log    "No son corchetes"    # ELSE    log    # "Hay Corchetes"
    #${MyText}=    Get Text    ${Span[0]}
    #${MyText}=    Remove String    ${Span}    [    ]
    #log    ${MyText}
    #Run Keyword If    ${MyText}==[]    log    "Hay Corchetes"
    #Run Keyword If    ${Span}==${EMPTY}    log    "No hay Registro"
    #ELSE    log    "Hay Algo"
    #for    item    in    ${elList}]
    #Run Keyword And Expect Error    ${MyText}=    Get WebElements    //td[@class='texto'][contains(.,'${RutCopiar}')]
    #log    ${MyText}
    Sleep    2s
    #${RutCopiar1}=    Set Variable    15771613-1
    ${Span}=    SeleniumLibrary.Get WebElements    //td[@class='texto'][contains(.,'${RutCopiar}')]
    Log    ${Span}
    log    ${RutCopiar}
    ${test}=    Get Element Count    //td[@class='texto'][contains(.,'${RutCopiar}')]
    log    ${test}
    Run Keyword If    ${test}>0    log    "Hay un rut valido"
    ...    ELSE    log    "No hay rut valido aca"
    #    Close Browser

CopiarRut
    ${RutCopiar1}    Read Cell Data By Name    ${NombreHoja}    A${Contador}
    log    ${RutCopiar1}
    Set Test Variable    ${RutCopiar}    ${RutCopiar1}

ContadorDeCadaRut
    ${temp3}    Evaluate    ${ContadorRutDentroCaso}+4
    Set Test Variable    ${ContadorRutDentroCaso}    ${temp3}
