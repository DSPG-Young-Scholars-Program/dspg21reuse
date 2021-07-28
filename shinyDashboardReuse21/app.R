library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(rsconnect)




ui <- fluidPage(
  theme ="themes.css",

  navbarPage(title = span("Business Innovation", style = "color:#232D4B"),
             tabPanel("About",style = "margin:45px",
                      fluidRow(
                        column(3, tags$img(height = "80%", width = "80%", src = "biilogo.png")),
                        column(6, h1("Business Innovation")),
                        column(3, tags$img(height = "80%", width = "80%", src = "partnerlogos.png", align = "right"))
                      ),

                      h5("SDAD/DSPG"),
                      p("The Social and Decision Analytics Division (SDAD) is one of three research divisions within the Biocomplexity Institute and Initiative at the University of Virginia.
                        SDAD combines expertise in statistics and social and behavioral sciences to develop evidence-based research
                        and quantitative methods to inform policy decision-making and evaluation.
                        The researchers at SDAD span many disciplines including statistics, economics, sociology, psychology,
                        political science, policy, health IT, public health, program evaluation, and data science.
                        The SDAD office is located near our nation's capital in Arlington, VA. You can learn more about us at",
                        tags$a(href="https://biocomplexity.virginia.edu/social-decision-analytics.", "https://biocomplexity.virginia.edu/social-decision-analytics."), style = "color:#232D4B"),
                      p("The Data Science for the Public Good (DSPG) Young Scholars program is a summer immersive program held at SDAD. Entering its seventh year, the program engages students from across the country
                        to work together on projects that address state, federal, and local government challenges around critical social issues relevant in the world today.
                        DSPG young scholars conduct research at the intersection of statistics, computation, and the social sciences to determine how information
                        generated within every community can be leveraged to improve quality of life and inform public policy. ", style = "color:#232D4B"),
                      h5("DSPG20BI Summer Project"),
                      p("The DSPG20BI team is one of x number of teams within the larger DSPG program tasked with looking into detecting product innovation within non-traditional data sources.
                        Our goal is to find instances of product innovation within the pharmaceutical industry thorugh niche natural-language processessing techniques in an attempt
                        to supplement the current measure of innovation", tags$a(href = "https://www.nsf.gov/statistics/srvyindustry/about/brdis/", "the Business R&D and Innovation Survey (BRDIS)"),"conducted by The National Science Foundation."),

                      p("During the 10-week DSPG program, the Business Innovation team focused on developing functions that used NLP techniques to match strings across datasets.
                        These functions were written particularly focused on datasets mentioning innovation amongst pharmaceutical companies. However, the functions can be applied to any dataset containing strings.
                        The goal of this task it to provide future insights on the companies doing innovation as it pertains to the OLSO manual definition"),

                      h5("Our Team"),
                      p("SDAD: Devika Mahoney-Nair, Gizem Korkmaz, & Neil Alexander"),
                      p("DSPG: Susweta Ray (Fellow), Isabel Gomez (Intern), Ian MacLeod (Intern)"),
                      p("Sponsor: Gary Anderson, National Science Foundation (NSF), National Center for Science and Engineering (NCSES)")


                      ),

             #ui
             navbarMenu("Profiling",

             tabPanel("Publishers", style = "margin:20px",
                      h5("Visuals"),
                      br(),
                      br(),
                      br(),
                      sidebarLayout(
                        sidebarPanel(
                          h4("Top Publishers"),
                          selectInput("year", "Year", choices = c(2013, 2014,2015,2016,2017,2018))),
                        mainPanel(
                          imageOutput("pub"))
                      )

                      ),

             tabPanel("Profiles", style = "margin:60px",
                      h5("Profiling", align = "center"),
                      p(style = "margin-top:25px","Profiling is essential for ensuring the contents of datasets align with the projects overall goal and resources. The first goal of the Business Innovation project is to obtain a general understanding of what companies are the ones producing recent innovation. Therefore, we profiled the DNA data to include only unique, complete and valid entries.  We defined a valid entry, as an article that was published after 2010, had more than 100 but less than 10,000 characters and had a company code that was in the company codes dictionary. The year restriction will allow us to only consider recent innovations, the character restriction will allow our computing resources to fully analyze the text and the company code restriction will ensure that we have the full name of the company which will provide better insights on the companies completing innovation. " ),
                      br(),
                      p("Originally, the dataset contained 1,942,855 data entries. Given a restriction on memory and running power, we decided to only have unique and complete entries as it diminished the dataset by 96.2% to 73, 688 entries, while still fulfilling our main goal of understanding what companies are producing innovation. The visualization [above/below] demonstrates the total percentage of data entries that passed our validity checks.  About 78.3% of the total unique entries passed the validity check, 100% of the entries were published after 2010, and 91.7% of the entries contained valid company codes.  "),
                      sidebarLayout(
                        sidebarPanel(
                          width = 6,
                          selectInput("selectTable", "Select", choices = c("Completeness, Uniqueness, Duplicates", "Validity")),
                          h4("Definitions: ", style = "margin-top:50px"),
                          helpText("Note: All definitions are provided by Dow Jones Developer Platform"),
                          tags$ul(
                            tags$li("an - Accession Number (Unique id)"),
                            tags$li("art: Caption text and other descriptions of images and illustrations"),
                            tags$li("action: Action perfomed on a document (ex. add, rep, del)"),
                            tags$li("body: The content of the article"),
                            tags$li("byline: The author of an article"),
                            tags$li("copyright: Copyright text"),
                            tags$li("credit: Attribution text"),
                            tags$li("currency_codes: Currencies"),
                            tags$li("dateline: Place of origin and date"),
                            tags$li("document_type: Document type (ex. article, multimedia, summary"),
                            tags$li("ingestion_datetime: Data and time the artile was added to the Dow Jones Developer Platfrom"),
                            tags$li("language_code: Code for teh published language (ex. en)"),
                            tags$li("modification_datetime: Data and time that the article was modified"),
                            tags$li("modification_date: Date in which the article was last modified"),
                            tags$li("publication_date: Date in which the article was published"),
                            tags$li("publication_datetime: Date and time in which the article was published"),
                            tags$li("publisher_name: Publisher name"),
                            tags$li("region_of_origin: Publisher's region of origin"),
                            tags$li("snippet: What you see of an article outiside the paywall"),
                            tags$li("source_code: Publisher code"),
                            tags$li("source_name: Name of the source"),
                            tags$li("title: Title text"),
                            tags$li("word_count: Document word count"),
                            tags$li("subject_codes: News subjects"),
                            tags$li("region_codes: Region codes (ex. usa, namz, etc"),
                            tags$li("industry_codes: Industry codes"),
                            tags$li("person_codes: Persons"),
                            tags$li("market_index_codes: Market indices"),
                            tags$li("company_codes: Factiva IDs for companies and organizations"),
                            tags$li("company_codes_about: Companies that have high relevance to the document"),
                            tags$li("company_codes_association: Companies added to the document because of a relationship other than parent/child"),
                            tags$li("company_codes_lineage: Companies added to the document because of a parent/child relationship to another company"),
                            tags$li("company_codes_occur: Companies mentioned in the document but that do not necessarily have a high relevance to it"),
                            tags$li("company_codes_relevance: Companies added to the document because they have a certain degree of relevance to it")

                          )

                        ),
                        mainPanel(width = 3, tableOutput("tables"))
                      ))
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




