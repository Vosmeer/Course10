library(shiny)


source("./PredictNextWord.R")

shinyServer(function(input, output,session) {

  observe({

    typedwords<<-as.character((input$text))

    to_predict<<-Inputcleaner(typedwords)

#### Database search for match, default is top3 most frequent words

      
    Prediction_n1<<-get1gram(to_predict)
    Prediction_n2<<-get2gram(to_predict)
    Prediction_n3<<-get3gram(to_predict)
    Prediction_n4<<-get4gram(to_predict)

    results_raw<<-bind_rows(Prediction_n4,Prediction_n3,Prediction_n2,Prediction_n1)

    results_dup<<-results_raw[!is.na(deel2)]

    results<<-unique(results_dup, by = 'deel2')
    
#### Top 3 results 

    results1 <<- results[1,2]
    results2 <<- results[2,2]
    results3 <<- results[3,2]

#### Results to output 
    
    lastwords<-word(to_predict,-1)
    
    output$prediction1 <- renderUI({actionButton("button1", label = results1)})
    output$prediction2 <- renderUI({actionButton("button2", label = results2)})
    output$prediction3 <- renderUI({actionButton("button3", label = results3)})
  
    output$last_source_word<-renderText({lastwords})

      })
  
  observeEvent(input$button1, {
    if(input$button1 == 1){
      name <- paste(input$text, results1)
      updateTextInput(session, "text", value=name)
    }
    
  })
  
  observeEvent(input$button2, {
    
    name <- paste(input$text, results2)
    updateTextInput(session, "text", value=name)
  })
  
  observeEvent(input$button3, {
    
    name <- paste(input$text, results3)
    updateTextInput(session, "text", value=name)
  })
    
})

