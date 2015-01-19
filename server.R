library(shiny)
library(shinysky)
library(dplyr)
library(stringr)
library(lubridate)
library(RMySQL)

shinyServer(function(input, output, session) {

  valida <- reactive({
    if(!is.null(input$q1) & !is.null(input$email)) {

      val <- (length(input$q1) %in% c(1, 2, 3)) & str_detect(input$email, fixed('@'))

      return(val)
    } else {
      return(0)
    }
  })

  dados <- reactive({
    d <- data_frame(datetime=as.character(now()), email=input$email, q1=input$q1) %>%
      as.data.frame()
    return(d)
  })

  salva <- reactive({
    res <- FALSE
    try({
      con <- dbConnect("MySQL", host=host, dbname=dbname, username=username, password=password)
      # tabela_atual <- dbReadTable(con, 'questionario')
      d <- dados()

      if(dbExistsTable(con, 'questionario_aula08')) {
        res <- dbWriteTable(con, 'questionario_aula08', d, append=T, row.names=F, overwrite=F)
      } else {
        res <- dbWriteTable(con, 'questionario_aula08', d, row.names=F)
      }

      dbDisconnect(con)
    })
    return(res)
  })

  observe({
    aux <- input$salvar
    isolate({
      val <- valida()
      res <- FALSE

      if(aux > 0 & val) {
        res <- salva()
      }

      if(aux > 0 & val & res) {
        showshinyalert(session,'salvou', 'Salvou!!', 'success')
      } else if (aux == 0) {
        showshinyalert(session, 'salvou', 'Clique em salvar!', 'warning')
      } else if (!val) {
        showshinyalert(session,'salvou', 'Existem campos obrigatórios que não foram preenchidos corretamente', 'danger')
      } else if(!res) {
        showshinyalert(session,'salvou', 'Ocorreu um erro na base de dados.', 'danger')
      }

    })
  })

})
