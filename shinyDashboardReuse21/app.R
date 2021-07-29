library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(rsconnect)




ui <- fluidPage(
  theme ="themes.css",

  navbarPage(title = span("Data Reusability", style = "color:#232D4B"),
             tabPanel("About",style = "margin:45px",
                      fluidRow(
                        column(3, tags$img(height = "80%", width = "80%", src = "biilogo.png")),
                        column(6, h1("Data Reusability")),
                        column(3, tags$img(height = "80%", width = "80%", src = "partnerlogos.png", align = "right"))
                      ),

                      h5("SDAD/DSPG"),
                      p("The Social and Decision Analytics Division (SDAD) is one of three research divisions within the Biocomplexity Institute and Initiative at the University of Virginia. SDAD combines expertise in statistics and social and behavioral sciences to develop evidence-based research and quantitative methods to inform policy decision-making and evaluation. The researchers at SDAD span many disciplines including statistics, economics, sociology, psychology, political science, policy, health IT, public health, program evaluation, and data science. The SDAD office is located near our nation's capital in Arlington, VA. You can learn more about us",
                        tags$a(href="https://biocomplexity.virginia.edu/social-decision-analytics.", "here."), style = "color:#232D4B"),
                      
                      p("The Data Science for the Public Good (DSPG) Young Scholars program is a summer immersive program held at SDAD. Entering its eighth year, the program engages students from across the country to work together on projects that address state, federal, and local government challenges around critical social issues relevant in the world today. DSPG young scholars conduct research at the intersection of statistics, computation, and the social sciences to determine how information generated within every community can be leveraged to improve quality of life and inform public policy. ", style = "color:#232D4B"),
                      
                      h5("Data Reusability"),
                      p("Data reusability refers to the ease of using data for legitimate scientific research by one or
more communities of research (consumer communities) that is produced by other communities of
research (producer communities); in other words, the ease of use of data collected for one purpose to study a new problem. As data reusability becomes a distinct characteristic of modern scientific practice comes the mandate for public access to research data, and a push towards transparent research practices that transform the way we conduct research across scholarly fields.  However, disciplines vary widely in their readiness to adopt these new practices, and research institutions face the daunting prospect of determining how to encourage better research practices for researchers from any discipline. While best practices in sharing data are now centered on the FAIR principles (findable, accessible, interoperable, reusable), limited attention has been paid to what actually makes a data source reusable by another researcher. 
"),

                      p("In this project, we:"),
                      p("1. Develop and pilot test a framework that articulates the concept of the “reusability” of a data source from the perspective of a user and is extensible across scholarly disciplines;"),
                      p("2. Identify practices for planning and conducting a research study that will increase the reusability of the data shared from the investigation, as well as reduce the burden in creating and appropriately using the data source; and"),
                      p("3. Propose a path forward for accelerating community readiness and the success of researchers in effectively producing a publicly accessible data product that readily enables a new user to evaluate and appropriately analyze the data source."),
                      p("By better understanding of the reusability of a shared research data source, researchers from a range of disciplines, especially those without a data sharing tradition, will be able to improve their planning and execution in producing research data intended for public access, thereby increasing the rigor of research studies and shared data products.By providing a pathway forward for increasing our capacity to produce more reusable data sources, this work provides information desperately needed by research institutions and other organizations to accelerate community readiness for developing and appropriately sharing high quality reusable research data sources."),

                      h5("Our Team"),
                      p("SDAD: Alyssa Mikytuck, Gizem Korkmaz"),
                      p("DSPG: Emily Kurtz (Fellow), Akilesh Ramakrishna (Intern), Aditi Mahabal (Intern)"),
                      p("Sponsor: Gary Anderson, National Science Foundation (NSF)")


                      ),

             

             tabPanel("Profiling and Choosing Repositories",style = "margin:45px",
                      fluidRow(
                        column(3, tags$img(height = "80%", width = "80%", src = "biilogo.png")),
                        column(6, h1("Profiling and Choosing Repositories")),
                        column(3, tags$img(height = "80%", width = "80%", src = "partnerlogos.png", align = "right"))
                      ),
                      
                      p("One of our project’s preliminary steps in the Data Discovery process was finding repositories in which Publicly Accessible Research Data (PARD) is available. To this end, we were able to utilize the Open Access Directory, a collection of lists about open access (OA) to science and scholarship, maintained by the OA community at large. This list holds 204 repositories spanning a wide range of subject fields and can be accessed ",
                        tags$a(href="http://oad.simmons.edu/oadwiki/Data_repositories.", "here."), style = "color:#232D4B"),
                      
                      p("Prior to the step of Data Screening and profiling this list of 204 repositories, our team conducted a literature review of articles on the subject of data reusability to understand the recent progress made towards open science and the challenges that exist in the domain. Our literature review suggested, among other valuable lessons, that solutions to address these goals can be pursued not only at the data level, but at the repository level with basic metrics for reuse and more sophisticated technological features. ", style = "color:#232D4B"),
                      
                      p("With this knowledge of the relevant literature, and working in conjunction with the Iowa State University team, we profiled these 204 repos on the basis of our evaluation framework, namely:"),
                      
                      p("1. Does the repository report the number of downloads, citations, views, or other metrics for datasets?"),
                      
                      p("2. How many datasets are in the repository/ what is the size of the repository?"),
                      
                      p("3. Is the repository widely accessible and has ease of use? Does the site require registration to access data?"),
                      
                      p("4. Does the repository have other interesting features that can be analyzed for their impact and/or association with data reuse?"),
                      
                      p("After completing this profiling process, our team selected 6 repositories to study, with each team member picking two of their own repositories to scrape. These 6 repositories were chosen, as previously mentioned, for their tracking of metrics of reuse, their size, their ease of access, and additionally, interesting features they displayed that could be used in our analysis of reuse. For example, the Multidisciplinary Repository Dryad contained a useful tool relating to the scope of our project, “Data (re)Usage Instructions.” This tool… Another example of such a feature was the “Metadata Assessment Report” from the Ecology and Biology repository the Knowledge Network for Biocomplexity (KNB). This site ran its own analysis on metadata associated with each research study, performing metadata “checks” on aspects of the metadata such as  if a methodology section is present, and if a unique identifier exists for the study."),
                      
                      p("This table here provides an overview of 5 of the 6 repositories our team from UVA chose to analyze."),
                      
                      ##INSERT VISUALS
                      
                      p("These were just the repositories UVA analyzed. ISU also analyzed other repositories. Their site, along with a brief overview of their work, can be found in the ISU tab.")
                      
                      
             ),


             #end profiling tab------------------------------------------


             #navbarMenu("Data Sources and Methods",
                        tabPanel(
                          "Data Sources",
                          h3("Data Sources", align = "center", style = "margin-bottom: 50px"),
                          style = "margin-left: 120px;",
                          style = "margin-top: 30px;",
                          style = "margin-right: 120px;",
                          fluidRow(
                            column(3, tags$img(height = "100%", width = "100%",src = "dnalogo.png")),
                            column(6, wellPanel(p(style = "font-size:15px","The Dow Jones DNA platform collects information from Dow Jones publication with premium and licensed third party sources. This proprietary data platform contains 1.3bn articles each labeled with unique DNA taxonomies tags including word count, source name, and company code. More information on all the included data tags can be found on the DNA website. This dataset served as the primary resource for alternative text sources and will inspire the machine learning algorithms that will predict innovation. "))),
                            ),
                          hr(),
                          fluidRow(style = "margin-top:100px",
                                   column(3, tags$img(height = "100%", width = "100%", src = "fdalogo.png")),
                                   column(7, wellPanel(
                                     tags$b("Approvals"),
                                     p(style = "font-size:15px", "FDA drug approvals dataset generated and reviewed by FDA and includes information regarding. ",
                                     br(),
                                     br(),
                                     tags$b("National Drug Code"),
                                     p(style = "font-size:15px", "The National Drug Code (NDC) Directory is a publicly available source provided by the FDA that contains a list of all current drugs manufactured, prepared, propagated, compounded, or processed for commercial distribution. The data content is manually inputted by the companies producing the drugs as required per the Drug Listing Act of 1972. The FDA assigns the NDC – a unique three-digit number, to the drug products. The administration then updates the NDC directory daily with the NDC along with the rest of the information provided. We gathered content from this dataset on [enter date here]. This data was used to cross-validate the companies that we had previously identified as producing an innovation. ")
                                    )))
                          ),

                        ),


                        tabPanel("The Process",
                                 h3("The Process", align = "center", style = "margin-bottom: 50px"),
                                 style = "margin-left: 120px;",
                                 style = "margin-top: 30px;",
                                 style = "margin-right: 120px;",

                                   fluidRow(style = "margin-top:100px",
                                     column(3, h4("Repository Profiling and Selections")),
                                     column(6, wellPanel(p(style = "font-size:15px","The first step in our process this summer was to identify the data we wanted to collect and the repositories from which to collect the data. This goal was achieved in two main steps. First, we, along with the ISU team, profiled a total of 205 publicly accessible data repositories. When doing this, we recorded characteristics of the repositories, metrics they tracked, their accessibility, their usability for our research purposes, their size, and more. Characteristics include things like which fields the repositories focused on or whether they had integrated tools for facilitating reuse. Metrics they tracked included more obvious metrics like downloads and more unique metrics like altmetrics, which track a piece of research's presence on online platforms. A main consideration when evaluating accessibility was whether the repository required registration or an account for a user to reuse the datasets. To evaluate the repositories' usability for our purposes, we made a note of the APIs they offered and how they could help our research. Finally, we prioritized larger repositories, as measured by the number of datasets or other projects, such as articles or book chapters, they contained. After considering all of these factors, we chose and ultimately analyzed 5 repositories: NSF PAR, Figshare, Dryad, KNB, and ICPSR.")))
                                   ),
                                   hr(),
                                   fluidRow(style = "margin-top:100px",
                                            column(3, h4("Literature Review")),
                                            column(6, wellPanel(p(style = "font-size:15px","The second step for identifying the information we wanted to collect was to compare our repository profiling results to recommendations in the literature. We based our literature review on three main, recent articles: Fecher et. al. (2015), Koesten et. al. (2020), and Thanos (2015). We compiled a list of specific recommendations and common themes. This process highlighted the roles technology, policy, and culture can play in fostering data reuse. While the focus of our research this summer was on the technology side, this information guided the direction of our researh and supplemented our analyses and interpretations of our findings.  ")))
                                   ),
                                   hr(),
                                   fluidRow(style = "margin-top:100px",
                                            column(3, h4("Web Scraping")),
                                            column(6, wellPanel(p(style = "font-size:15px","Before we could do any quantitative analyses, we needed data. We used the R packages rvest and RSelenium, along with the sites' APIs, to collect our samples. The functions contained within rvest ultimately allowed us to extract most of the information we needed from our sites. However, in most cases we needed to use RSelenium in order to allow the websites to fully load before scraping them. This is because the sites initially loaded empty shells, so scraping immediately with rvest returned null results. These two R packages, rvest and RSelenium, allowed us to scrape one site at a time, so we built our code into for loops to scrape thousands of data sets. To get our desired datasets and websites, we used the repositories' APIs.   ")))
                                   ),
                                   hr(),
                                   fluidRow(style = "margin-top:100px",
                                            column(3, h4("Analyses")),
                                            column(6, wellPanel(p(style = "font-size:15px","Since each repository tracked some unique information, analyses by repository varied to some extent. More detailed information can be found in the Results section. However, for almost all repositories, downloads, citations, are views were tracked. We started our analyses by compiling descriptive statistics on these three important metrics of reuse. We also calculated correlations for these three metrics for each repository. After that point, analyses diverged. We used the other information that the repositories tracked, such as metadata analysis reports, file sizes, and numbers of keywords, to build models to predict downloads, citations, and views. We also did more qualitative analyses on the repositories as a whole. Finally, when possible, we graphed the dates of datasets being uploaded to see how the culture of data sharing has changed over time. These are just a few of the total analyses we performed.   "))))




                        ),#),#end navbar

             #end Data Sources and Methods tabs-----------------


             navbarMenu("Results",
                        tabPanel("NSF PAR",
                                 selectInput("within", "Select", choice = c("NDCxNDC", "FDAxFDA", "DNAxDNA")),
                                 dataTableOutput("withinData")
                        ),


                        tabPanel("Figshare",
                                 selectInput("across", "Select", choices = c("FDAxNDC", "FDAxDNA", "DNAxNDC")),
                                 dataTableOutput("AcrossData")



                        ),
                        tabPanel("Dryad"
                        ),
                        
                        
                        tabPanel("KNB"
                        ),
                        
                        
                        tabPanel("ICPSR")
                        

                        )#end results tab





      ) #end navbarPage
  )#end fluid page





server <- function(input, output) {

  output$pub <- renderImage({

    # When input$n is 3, filename is ./images/image3.jpeg
    filename <- normalizePath(file.path('www',
                                        paste(input$year, 'Publisherplot.png', sep='')))

    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste("Image number", input$year))



  }, deleteFile = FALSE)






  output$tables <- renderTable({
    if(input$selectTable == "Validity"){


      valid <- read.csv("validitytable.csv")
      names(valid)[names(valid) == "X"] <- "Column Name"

      valid
    }else{
      profTable <- read.csv("profilingTable.csv")

      names(profTable)[names(profTable) == "X"] <- "Column Name"

      profTable
    }

  })

  #output$fda <- renderDataTable({
    #x <- read.csv("fdaxfda.csv")
    #x
  #})

  #output$ndc <- renderDataTable({
    #ndc <- read.csv("ndcxndc.csv")
    #ndc
  #})

  output$withinData <- renderDataTable({
    if(input$within == "FDAxFDA"){
      withinTable <- read.csv("fdaxfda.csv")

      withinTable$X <- NULL
      withinTable$fuzz.ratio <- NULL
      withinTable$original.row.number <- NULL

      names(withinTable)[names(withinTable) == "clean.company.name"] <- "Corporate Family"
      names(withinTable)[names(withinTable) == "company.matches"] <- "Matches"
      names(withinTable)[names(withinTable) == "original.company.names"] <- "Original Company Name"




      withinTable

    }else if(input$within == "NDCxNDC"){
      withinTable <- read.csv("ndcxndc.csv")

      withinTable$X <- NULL
      withinTable$fuzz.ratio <- NULL
      withinTable$original.row.number <- NULL

      names(withinTable)[names(withinTable) == "clean.company.name"] <- "Corporate Family"
      names(withinTable)[names(withinTable) == "company.matches"] <- "Matches"
      names(withinTable)[names(withinTable) == "original.company.names"] <- "Original Company Name"

      withinTable
    }
  })

  output$AcrossData <- renderDataTable({
    if(input$across == "FDAxNDC"){
      acrossTable <- read.csv("fdaxndc.csv")

      acrossTable$X <- NULL
      acrossTable$fda.row <- NULL
      acrossTable$clean.fda.company.name <- NULL
      acrossTable$clean.ndc.row <- NULL
      acrossTable$fuzz.ratio <- NULL
      acrossTable$clean.ndc.company <- NULL

      names(acrossTable)[names(acrossTable) == "original.fda.company"] <- "Original FDA Company"
      names(acrossTable)[names(acrossTable) == "corporate.family"] <- "Corporate Family"
      names(acrossTable)[names(acrossTable) == "original.ndc.company"] <- "Original NDC Company"

      acrossTable
    }else if(input$across == "FDAxDNA"){
      acrossTable <- read.csv("fda_dna_matching.csv")

      acrossTable$fda.row <- NULL
      acrossTable$clean.fda.company.name <- NULL
      acrossTable$clean.dna.row <- NULL
      acrossTable$fuzz.ratio <- NULL
      acrossTable$clean.dna.company <- NULL

      acrossTable$X <- NULL

      names(acrossTable)[names(acrossTable) == "original.fda.company"] <- "Original FDA Company"
      names(acrossTable)[names(acrossTable) == "corporate.family"] <- "Corporate Family"
      names(acrossTable)[names(acrossTable) == "original.dna.company"] <- "Original DNA Company"
      acrossTable
    }else{
      acrossTable <- read.csv("ndc_dna_matching.csv")

      acrossTable$X <- NULL
      acrossTable$NDC.row <- NULL
      acrossTable$clean.NDC.company <- NULL
      acrossTable$clean.DNA.row <- NULL
      acrossTable$fuzz.ratio <- NULL
      acrossTable$clean.DNA.company <- NULL

      names(acrossTable)[names(acrossTable) == "original.NDC.company"] <- "Original NDC Company"
      names(acrossTable)[names(acrossTable) == "corporate.family"] <- "Corporate Family"
      names(acrossTable)[names(acrossTable) == "original.DNA.company"] <- "Original DNA Company"

      acrossTable
    }
  })

}

# Run the application
shinyApp(ui = ui, server = server)




