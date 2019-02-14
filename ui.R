library(shiny)

# Define UI for application 
shinyUI(navbarPage("WordPrediction",


                   
     # main panel 
     tabPanel("Main panel ",
              
              #tags$script(' $(document).on("keydown", function (e) {
              #                                    Shiny.onInputChange("lastkeypresscode", e.keyCode);
              #                                    });
              #                                    '),
              fluidRow(
                column(6,
                       tags$div(
                         h3("Enter your text here"),
                         tags$textarea(id = 'text', placeholder = 'Enter your text here', rows = 2, class='form-control',""),

                      
                         hr(),
                         
                         h3("Last word used for prediction"),
                         textOutput("last_source_word"),

                         hr(),
                         
                         HTML('<script type="text/javascript"> 
                              document.getElementById("text").focus();
                              </script>'),
                         
                         HTML("<div id='buttons'>"),
                         uiOutput("prediction1",inline = T),
                         uiOutput("prediction2",inline = T),
                         uiOutput("prediction3",inline = T)),

                       hr(),
                
                #sliderInput("freq",
                #            "Minimum Frequency:",
                #            min = 1,  max = 20, value = 1),
                #
                #plotOutput("plot"),
                
                h6("Please give the app a few seconds extra for the first predictions"),
                
                HTML("</div>"),
                align="left")

                )),
     
     
     # Tab 2, Handleiding
     tabPanel("Manual", 
              hr(),
              h2("The application is designed to predict the next word"),
              h3("To use the application, apply the following steps"),
              hr(),          
              h4("1. Start typing in your next word in the inputbox"),
              h4("2. Be patient for the first prediction, it takes a little while longer"),
              h4("3. Choose your next word from the 3 suggestions, leftmost suggestion is the most likely one, rightmost is the least likely one"),
              h4("4. You can easily paste the suggestion into the inputbox by pressing the suggestion button"),
              hr(),
              h4(" "),
              h5("Warning: profanity words will not be used"),              
              hr() 
     )
     

     
)
) 
   
#     )))

