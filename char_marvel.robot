*** Settings ***
Library  RequestsLibrary
Variables  config.py
Resource  kabum_resource.resource

*** Test Cases ***
Testar API Catalogo kabum
    Configurar Sessao
    Realizar requisicao no catalogo
    Validar os campos obrigatorios

*** Keywords ***
Configurar Sessao
    Create Session  requisicao_catalogo  https://servicespub.prod.api.aws.grupokabum.com.br  headers=${HEADERS}  verify=true

Realizar requisicao no catalogo
    ${resposta_catalog}=  Get On Session  requisicao_catalogo  /catalog/v2/releases
    Log To Console  ${resposta_catalog}
    Set Test Variable  ${resposta_catalog}

Validar os campos obrigatorios 
    Request Should Be Successful  ${resposta_catalog}
    Should Not Be Empty  ${resposta_catalog.json()}[data]