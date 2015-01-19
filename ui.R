library(shiny)
# https://github.com/AnalytixWare/ShinySky
library(shinysky)

inputTextarea <- function(inputId, value="", nrows, ncols) {
  tagList(
    singleton(tags$head(tags$script(src = "textarea.js"))),
    tags$textarea(id = inputId,
                  class = "inputtextarea",
                  rows = nrows,
                  cols = ncols,
                  as.character(value))
  )
}

fluidPage(

  h2("Questionário sobre a aula 08"),
  tags$hr(),
  h4('Curso R - do casual ao avançado'),
  tags$hr(),

  wellPanel(fluidRow(
    textInput('email', 'Email', value='')
  )),

  wellPanel(fluidRow(
    checkboxGroupInput('q1',
                       'Selecione entre 1 e 3 temas que você gostaria de ver na Aula 08',
                       c('Análise de textos'='texto',
                         'Outros modelos: LASSO, modelo aditivo, GAMLSS'='modelos_plus',
                         'Gráficos em HTML e D3 com HTMLWidgets'='htmlwidgets',
                         'Otimização e ajuste de modelos usando funções do base no R'='justiniano',
                         'Sobre paralelização, trabalhar com grandes bancos, etc.'='bigdata',
                         'Mais análise descritiva: mapas, kaplan-meier, gráficos de multivariada, etc.'='descritiva_plus',
                         'Web crawling e web scraping (trabalhar com arquivos html e baixar dados da web)'='webscraping',
                         'R Open CPU (criação de APIs com o R)'='opencpu'),
                       inline=F),

    tags$p('OBS: Se você deseja ver algo que não está nessa lista fale conosco!')

  )),

  actionButton('salvar', 'Salvar!'),
  tags$br(), tags$br(),
  shinyalert('salvou', click.hide=FALSE),

  tags$br(),
  tags$span('Esse questionário foi feito utilizando R e Shiny. Código disponível em',
            tags$a('https://github.com/curso-r/questionario_aula08',
                   href='https://github.com/curso-r/questionario_aula08',
                   target='blank')),
  tags$hr()

)

