pageWithSidebar(
  headerPanel('Iris k-means clustering'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris), selected=names(iris)[[2]]),
    numericInput('clusters', 'Cluster count', 3, min = 1, max = 9),
    #downloadButton("export_data", "Put dataset to history")
    actionButton("export_param", "Generate parameters file")
  ),
  mainPanel(
    plotOutput('plot1')
  )
)


