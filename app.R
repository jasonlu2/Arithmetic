library(shiny)

ui <- fluidPage(
    titlePanel("Let's Do Arithmetic!"),
    sidebarLayout(
        sidebarPanel(
            numericInput(inputId = "number1",
                         label = "Number 1",
                         value = 0),
            numericInput(inputId = "number2",
                         label = "Number 2",
                         value = 0),
            actionButton(inputId = "add_btn",
                         label = "Add",
                         icon = icon("plus")),
            actionButton(inputId = "multiply_btn",
                         label = "Multiply",
                         icon = icon("times"))
        ),
        mainPanel(
            h2(textOutput("operation_text")),
            textOutput("result")
        )
    )
)

server <- function(input, output) {

    # Reactive values to store current operation and result
    current_operation <- reactiveVal("addition")
    current_result <- reactiveVal(0)

    # Observe Add button clicks
    observeEvent(input$add_btn, {
        x1 <- as.numeric(input$number1)
        x2 <- as.numeric(input$number2)
        current_operation("addition")
        current_result(x1 + x2)
    })

    # Observe Multiply button clicks
    observeEvent(input$multiply_btn, {
        x1 <- as.numeric(input$number1)
        x2 <- as.numeric(input$number2)
        current_operation("multiplication")
        current_result(x1 * x2)
    })

    # Output for operation text
    output$operation_text <- renderText({
        op <- current_operation()
        if (op == "addition") {
            "The sum of the two numbers is:"
        } else if (op == "multiplication") {
            "The product of the two numbers is:"
        }
    })

    # Output for result
    output$result <- renderText({
        current_result()
    })
}

shinyApp(ui = ui, server = server)


