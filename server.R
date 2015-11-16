library(shiny)
library(d3heatmap)
library(shinythemes)
require(RColorBrewer)
library(dplyr)
library(gplots)

shinyServer(  function(input, output,session) {
  options(shiny.maxRequestSize=50*1024^2)
  #generateHeatmap<-eventReactive(input$goButton , {
        
  #      validate(need(input$gene, 'Check at least one gene!') )
  #      validate(need(input$file1, 'Check at least one uploaded file!') )
   #     print("GenereateD3Heatmap")
  #      inFile <-input$file1
        
   #     my_data <- read.csv(inFile$datapath, sep=";",row.names=1,na.strings = c("UNDEF"))
        
  #      data_filtered =  filter(my_data, grepl(paste0("^",input$gene, collapse = NULL),rownames(my_data) ))
        
   #     rowNamesFiltered <- grep(paste0("^",input$gene,"-.*$", collapse = NULL),rownames(my_data),ignore.case = TRUE,value = TRUE) 
        
  #      row.names(data_filtered) <-  rowNamesFiltered
        
  #      loading_effect() 
        
  #      nrowData <- nrow(data_filtered)
  #      if (nrowData==0) return (NULL)
        
  #      d3heatmap(data_filtered, colors = input$palette ,dendrogram =  "none",symm=FALSE,Rowv=FALSE,Colv=FALSE,na.rm=TRUE)
 # })
  
  #output$heatmap<-renderD3heatmap({ generateHeatmap() })
  
  generatePlot<-eventReactive(input$goButton2 , {
      
        validate(need(input$gene2, 'Check at least one gene!') )
        validate(need(input$file2, 'Check at least one uploaded file!') )
        inFile2 <-input$file2
        
        my_data <- read.csv(inFile2$datapath, sep=";",row.names=1,na.strings = c("UNDEF"))
        
        data_filtered2 =  filter(my_data, grepl(paste0("^",input$gene2, collapse = NULL),rownames(my_data) ))
        
        rowNamesFiltered2 <- grep(paste0("^",input$gene2,"-.*$", collapse = NULL),rownames(my_data),ignore.case = TRUE,value = TRUE) 
        
        row.names(data_filtered2) <-  rowNamesFiltered2
        
        nrowData2 <- nrow(data_filtered2)
      
        loading_effect() 
    
        if (nrowData2==0) return (NULL)
        myCol = NULL
        myBreaks= NULL
       
        # If it's not a 4 multiple
        
        validate(
          need(try(length(colnames(my_data)) %% 4 == 0), "Please check your dataset. Number of columns is weird !")
        )
        countPatient <- ( length(colnames(my_data))  / 4)
        countRun <- ( countPatient  / 3)
        countAll <-  paste (c(countPatient," patients were pooled together among ",countRun," runs for this analyse."), sep = " ", collapse = NULL)
        
       output$count <-  renderText({ countAll })
       
       # if (input$grad == TRUE) {
        # creates a own color palette from red to green
        #myCol <- colorRampPalette(c("red", "gray", "orange", "gray", "green"))(n = 499)
        
        # (optional) defines the color breaks manually for a "skewed" color transition
       # myBreaks = c(seq(0,input$slider1,length=100),  # for red
        #               seq(input$slider2[1], input$slider2[2],length=100),
       #                seq(input$slider2[2], input$slider3,length=100),
        #               seq(input$slider3, 5, length=100)
       #                )  
       # } else if (input$grad == FALSE) {
          
          ## The colors you specified.
          myCol <- c("red", "gray", "orange", "gray", "green")
          ## Defining breaks for the color scale
          myBreaks <- c(0,input$slider1 ,input$slider2, input$slider3, 5)#input$slider1 ,input$slider2, input$slider3, #0.05,0.25,0.77,1.25
          # Render a barplot
      #  }
        
        matrixdata_filtered <- data.matrix(data_filtered2)
        
        mat <- matrix(0, nrow = nrow(data_filtered2) , ncol = 3)
 
        dimnames(matrixdata_filtered) = list(rowNamesFiltered2,colnames(data_filtered2)) 
        # Go throught each line       
         for (index_row in seq(1,nrow(data_filtered2) ) ){
        
          # Go throught each column    
          for ( i in seq(1,ncol(data_filtered2),4)) { 
           
            countDupByGroup <- 0
            countDelHomoByGroup  <- 0
            countDelHetByGroup  <- 0
            
            # Go by group of 4 columns
            for ( i in seq(i,i+3,1)) { 
    
            if(is.na(matrixdata_filtered[index_row,i])){ next() }
          
           
                if(matrixdata_filtered[index_row,i] >= input$slider3){ 
                  countDupByGroup = countDupByGroup +1
                 }
                else if(matrixdata_filtered[index_row,i] <= input$slider1){ 
                  countDelHomoByGroup = countDelHomoByGroup +1
                }
              else if(matrixdata_filtered[index_row,i] >= input$slider2[1] & matrixdata_filtered[index_row,i] <= input$slider2[2]){ 
                countDelHetByGroup = countDelHetByGroup +1
              }
            }  
            # test 
            if (countDupByGroup == 4){ mat[index_row, 1] = mat[index_row, 1] + 1 } 
            if (countDelHetByGroup == 4){ mat[index_row, 2] = mat[index_row, 2] + 1 } 
            if (countDelHomoByGroup == 4){ mat[index_row, 3] = mat[index_row, 3] + 1 } 
            
          }

         
        }
        
       
        heatmap.2(matrixdata_filtered,  cellnote=as.matrix(data_filtered2),notecol="black",na.color="white",
                  col = myCol, ## using your colors
                  breaks = myBreaks, ## using your breaks
                  na.rm=TRUE, Rowv=FALSE,Colv=FALSE,
                  sepwidth=c(0.1,0.01),
                  sepcolor=c("black"),
                  colsep=seq(12,ncol(data_filtered2),12),
                  rowsep=1:nrow(data_filtered2),
                  # level trace
                  trace="none",
                  dendrogram = "none",  ## to suppress warnings
                  key=TRUE, keysize=1,  density.info='none', margins =c(16,8),cexCol = 1.6,
                  lmat=rbind(c(4, 2), c(1, 3)), lhei=c(2, 8), lwid=c(4, 1),
                  symm=F,symkey=F,symbreaks=T, scale="none" ,srtCol=270,adjCol=c(0,0))
       
         dimnames(mat) = list(rowNamesFiltered2,c("Dup.","Hom D.","Het D.")) 
      
        output$table <- renderTable(mat,digits=c(0,0,0,0))  
  })
  
  output$heatmapPlot<-renderPlot({ generatePlot() })
  

  
    # Function to play the effect loading
    loading_effect <- function()({
      # Create 0-row data frame which will be used to store data
      dat <- data.frame(x = numeric(0), y = numeric(0))
      withProgress(message = 'Making plot', value = 0, {
        # Number of times we'll go through the loop
        n <- 10
        
        for (i in 1:n) {
          # Each time through the loop, add another row of data. This is
          # a stand-in for a long-running computation.
          dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
          
          # Increment the progress bar, and update the detail text.
          incProgress(1/n, detail = paste("Doing part", i))
          
          # Pause for 0.1 seconds to simulate a long computation.
          Sys.sleep(0.1)
        }
      })
    })  
 
})

