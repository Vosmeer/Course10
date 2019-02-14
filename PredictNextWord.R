suppressPackageStartupMessages(library(stringr));library(stringr)       # text handlin
suppressPackageStartupMessages(library(dplyr));library(dplyr)           # summaries ed
suppressPackageStartupMessages(library(tidyr));library(tidyr)           # transforming dataframes
suppressPackageStartupMessages(library(utf8));library(utf8)             # Changing characters
suppressPackageStartupMessages(library(rio));library(rio)               # Text cleaning
suppressPackageStartupMessages(library(quanteda));library(quanteda)     # Text mining
suppressPackageStartupMessages(library(tm));library(tm)                 # Text mining
suppressPackageStartupMessages(library(wordcloud));library(wordcloud)   # Word cloud
suppressPackageStartupMessages(library(textclean));library(textclean)   # Word cloud
suppressPackageStartupMessages(library(tidytext));library(tidytext)   # Word cloud
suppressPackageStartupMessages(library(ECharts2Shiny));library(ECharts2Shiny)
                               
ngram1_comb<- readRDS("./data/ngram1_comb.rds") 
ngram2_comb<- readRDS("./data/ngram2_comb.rds")     
ngram3_comb<- readRDS("./data/ngram3_comb.rds")  
ngram4_comb<- readRDS("./data/ngram4_comb.rds") 


ngram1_comb<-ngram1_comb %>% arrange(desc(tot_ngram))
ngram1_comb<-ngram1_comb[c(1:10000),]


ngram2_comb<-ngram2_comb %>% arrange(desc(Pkn))
ngram2_comb<-ngram2_comb[c(1:10000),]


ngram3_comb<-ngram3_comb %>% arrange(desc(Pkn))
ngram3_comb<-ngram3_comb[c(1:10000),]


ngram4_comb<-ngram4_comb %>% arrange(desc(Pkn))
ngram4_comb<-ngram4_comb[c(1:10000),]

prof_raw<- readRDS("./data/prof_raw.rds")
stopwords_smart<- readRDS("./data/stopwords_smart.rds")

Inputcleaner<-function(invoer){

  text_match<-invoer %>%
    mutate(text=str_to_lower(invoer$value))%>%
    mutate(text=removeNumbers(text))%>%
    mutate(text=removePunctuation(text, preserve_intra_word_contractions = TRUE))%>%
    mutate(text=replace_white(text))%>%
    unnest_tokens(word, text) %>%
    anti_join(prof_raw)%>%
    anti_join(stopwords_smart)%>%
    transmute(text=gsub("([[:alpha:]])\\1{2,}", "\\1",word))%>%
    filter(!nchar(text)<3)%>%
    mutate_at("text", str_replace_all, "[:space:]+"," ")
  
  return(text_match)
  
}

####################### Create 1gram

get1gram<-function(to_predict){

  Prediction_n1<-as_tibble(head(ngram1_comb$ngram,3))
  colnames(Prediction_n1)<-c("value")
  return(Prediction_n1)
}

########################## Create 2gram

get2gram<-function(to_predict){
  
  unigram<-str_trim(str_c(tail(to_predict,1),collapse=" "),side="both")

  ngram_match31 <- ngram2_comb %>% filter(str_detect(deel1,unigram))

  Prediction_n2<-as_tibble(head(ngram_match31$deel2,cloudsize))
  
  return(Prediction_n2)
}

################ Create 3gram

get3gram<-function(to_predict){
  
  bigram<-str_trim(str_c(tail(to_predict$text,2),collapse=" "),side="both")

  ngram_match32 <- ngram3_comb %>% filter(str_detect(deel1,bigram))
  
  Prediction_n3<-as_tibble(head(ngram_match32$deel2,cloudsize))
  
  return(Prediction_n3)

}

##################### Create 4gram

get4gram<-function(to_predict){
  
  trigram<-str_trim(str_c(tail(to_predict$text,3),collapse=" "),side="both")
  
  ngram_match33 <- ngram4_comb %>% filter(str_detect(deel1,trigram))
  
  Prediction_n4<-as_tibble(head(ngram_match33$deel2,cloudsize))
  
  return(Prediction_n4)
}

 