## ----echo = FALSE, results = 'hide',   eval=TRUE, message = FALSE-------------
if(!require(devtools)){install.packages('devtools', repos='http://cran.us.r-project.org')}
if(!require(plotly)){install.packages('plotly', repos='http://cran.us.r-project.org')}
if(!require(dplyr)){install.packages('dplyr', repos='http://cran.us.r-project.org')}
if(!require(ggplot2)){install.packages('ggplot2', repos='http://cran.us.r-project.org')}
if(!require(plotrix)){install.packages('plotrix', repos='http://cran.us.r-project.org')}
if(!require(stringr)){install.packages('stringr', repos='http://cran.us.r-project.org')}
require(Rilostat)


## ---- eval=FALSE--------------------------------------------------------------
#  install.packages("Rilostat")

## ---- eval=FALSE--------------------------------------------------------------
#  if(!require(devtools)){install.packages('devtools')}
#  install_github("ilostat/Rilostat")

## ---- eval=TRUE---------------------------------------------------------------
require(Rilostat)
as.data.frame(ls("package:Rilostat"))


## ---- echo=FALSE, eval=TRUE---------------------------------------------------
options(ilostat_quiet = TRUE)

## ---- eval=TRUE---------------------------------------------------------------
toc <- get_ilostat_toc()


## ---- echo=FALSE, eval=TRUE, results = 'asis'---------------------------------
knitr::kable(head(toc[1:3,1:5]), caption = "Table 1a. Extract, 'Table of contents by indicator in English'")

## ---- eval=TRUE---------------------------------------------------------------
toc <- get_ilostat_toc(segment = 'ref_area', lang = 'es')

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(head(toc[1:3,1:9]),caption = "Table 1b. Extract, 'Table of contents by ref_area in Spanish'")

## ---- eval=TRUE---------------------------------------------------------------
toc <- get_ilostat_toc(search = 'bargaining')

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(toc[,1:8],caption = "Table 1c. 'Table of contents by indicator with search word 'bargaining''")

## ---- eval=TRUE---------------------------------------------------------------
toc <- get_ilostat_toc(segment = 'ref_area', search = c('France|Albania', 'Annual'), 
											fixed = FALSE)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(toc[1:2,1:9],caption = "Table 1d. 'Table of contents by ref_area with search words 'France' or 'Albania' and 'Annual''")

## ---- eval=TRUE---------------------------------------------------------------
toc <-  dplyr::filter(get_ilostat_toc(), collection == 'STI', freq == 'M')

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(head(toc[1:5,1:5]),caption = "Table 1e. Extract, 'Table of contents by indicator filtered for Monthly Short term indicators'")

## ---- eval=TRUE---------------------------------------------------------------
dat <- get_ilostat(id = 'UNE_2UNE_SEX_AGE_NB_A', segment = 'indicator') 

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(head(dat[1:3,1:7]),caption = "Table 2a. Extract, 'Annual unemployment by sex and age, ILO modelled estimates, Nov. 2018'")

## ---- eval=TRUE---------------------------------------------------------------
dat <- get_ilostat(id = 'ARM_A', segment = 'ref_area') 


## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(head(dat[1:3, c(1:5,7:8)]),caption = "Table 2b. Extract, 'Armenia, annual data'")

## ---- eval=TRUE---------------------------------------------------------------
dat <- get_ilostat(id = c('AFG_A', 'TTO_A'), segment = 'ref_area') 

dplyr::count(dat, ref_area)


## ---- eval=TRUE---------------------------------------------------------------
toc <- get_ilostat_toc(search = 'CPI_')

dat <- get_ilostat(id = toc, segment = 'indicator', quiet = TRUE) 

dplyr::count(dat, indicator)


## ---- eval=TRUE---------------------------------------------------------------
dat <- get_ilostat(id = 'UNE_TUNE_SEX_AGE_NB_Q', time_format = 'num') 

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(dat[1:3, 1:7],caption = "Table 3a. Extract, 'Quarterly unemployment by sex and age'")

## ---- eval=TRUE---------------------------------------------------------------
dat <- get_ilostat(id = 'TRU_TTRU_SEX_AGE_NB_M', time_format = 'date') 

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(head(dat[1:3, 1:7]),caption = "Table 3b. Extract, Monthly time-related underemployment by sex and age")

## ----eval=FALSE---------------------------------------------------------------
#  dat <- get_ilostat(id = 'TRU_TTRU_SEX_AGE_NB_M', cache_dir = 'c:/temp', cache_format = 'dta')

## ---- eval=FALSE--------------------------------------------------------------
#  get_ilostat(id = get_ilostat_toc(search = 'SDG'), 	cache_dir = 'c:/temp', cache_format = 'dta',
#  													back = FALSE)

## ---- eval=FALSE--------------------------------------------------------------
#  options(ilostat_cache_dir = 'C:/temp')
#  dat <- get_ilostat(id = 'UNE_2EAP_SEX_AGE_RT_A', filters = list(
#  													ref_area = c('BRA', 'ZAF'),
#  													sex = 'T',
#  													classif1 = 'AGE_YTHADULT_Y15-24'))
#  dplyr::count(dat, ref_area, sex, classif1)

## ---- echo =FALSE, eval=TRUE--------------------------------------------------
# options(ilostat_cache_dir = 'C:/temp')
dat <- get_ilostat(id = 'UNE_2EAP_SEX_AGE_RT_A', filters = list(
													ref_area = c('BRA', 'ZAF'), 
													sex = 'T', 
													classif1 = 'AGE_YTHADULT_Y15-24'))
dplyr::count(dat, ref_area, sex, classif1)

## ---- echo =FALSE, eval=TRUE--------------------------------------------------
# options(ilostat_cache_dir = 'C:/temp')
dat <- get_ilostat(id = 'UNE_2EAP_SEX_AGE_RT_A', filters = list(
													ref_area = c('BRA', 'ZAF'), 
													sex = 'M', 
													classif1 = 'AGE_YTHADULT_Y15'), 
												detail = 'serieskeysonly')

## ---- eval=FALSE--------------------------------------------------------------
#  options(ilostat_cache_dir = 'C:/temp')
#  dat <- get_ilostat(id = 'UNE_2EAP_SEX_AGE_RT_A', filters = list(
#  													ref_area = c('BRA', 'ZAF'),
#  													sex = 'M',
#  													classif1 = 'AGE_YTHADULT_Y15'),
#  												detail = 'serieskeysonly')

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(head(dat[1:2,]),caption = "Table 4a. Extract, Youth male unemployment rate in Brazil and South Africa (ILO modelled estimates, Nov. 2018), 'Series Key'")

## ---- echo =FALSE, eval=TRUE--------------------------------------------------
# options(ilostat_cache_dir = 'C:/temp')
dat <- get_ilostat(id = 'UNE_2EAP_SEX_AGE_RT_A', filters = list(ref_area = c('BRA', 'ZAF'), 
													sex = 'F', 
													classif1 = 'AGE_YTHADULT_Y15'), 
													detail = 'dataonly')

## ---- eval=FALSE--------------------------------------------------------------
#  # options(ilostat_cache_dir = 'C:/temp')
#  dat <- get_ilostat(id = 'UNE_2EAP_SEX_AGE_RT_A', filters = list(
#  													ref_area = c('BRA', 'ZAF'),
#  													sex = 'F',
#  													classif1 = 'AGE_YTHADULT_Y15'),
#  												detail = 'dataonly')

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
knitr::kable(head(dat[1:3,1:7]),caption = "Table 4b. Extract, Youth female unemployment rate in Brazil and South Africa (ILO modelled estimates, Nov. 2018)")

## ---- eval=TRUE---------------------------------------------------------------
clean_ilostat_cache()


## ---- eval=FALSE--------------------------------------------------------------
#  require(Rilostat)
#  require(ggplot2, quiet = TRUE)
#  require(dplyr, quiet = TRUE)
#  
#    get_ilostat(id = 'EAP_DWAM_NOC_RT_A',
#                time_format = 'num',
#                filters = list( ref_area = c('FRA', 'USA', 'DEU'),
#                                timefrom = 2005, timeto = 2017))  %>%
#    select(ref_area, time, obs_value) %>%
#    ggplot(aes(x = time, y = obs_value, colour = ref_area)) +
#    geom_line() +
#    ggtitle('Male labour force participation rate in selected countries, 2005-2017') +
#    scale_x_continuous(breaks = seq(2005, 2017, 3)) +
#    labs(x="Year", y="Male LFPR (%)", colour="Country:") +
#    theme(legend.position = "top", plot.title = element_text(hjust = 0.5))
#  
#  
#  

## ---- echo=FALSE, out.width = "100%"------------------------------------------
knitr::include_graphics("./g1_ts.png")

## ---- eval=FALSE--------------------------------------------------------------
#  require(Rilostat)
#  if(!require(ggplot2)){install.packages('ggplot2')}
#  if(!require(dplyr)){install.packages('dplyr')}
#  
#      get_ilostat(id = 'EMP_2EMP_SEX_AGE_CLA_DT_A',
#                  filters = list( ref_area = 'ZAF',
#                                  time = '1999',
#                                  sex = c('M', 'F'),
#                                  classif1 = c('Y15-24', 'YGE25'))) %>%
#      filter(!classif2 %in% 'CLA_ECOCLA_TOTAL') %>%
#      mutate(	sex = 		factor(sex) %>% recode_factor(
#                                  'SEX_M' = 'Male',
#                                  'SEX_F' = 'Female'),
#  			classif1 =  factor(classif1) %>% recode_factor(
#                                  'AGE_YTHADULT_YGE25' = 'Adult',
#                                  'AGE_YTHADULT_Y15-24' = 'Youth'),
#  			classif2 =  factor(classif2) %>% recode_factor(
#                                  'CLA_ECOCLA_USDLT2' = '<US$1.9',
#                                  'CLA_ECOCLA_USDGE2LT3' = '>=US$1.9 & <US$3.2',
#                                  'CLA_ECOCLA_USDGE3LT5' = '>=US$3.2 & <US$5.5',
#                                  'CLA_ECOCLA_USDGE5' = '>=US$5.5')) %>%
#      ggplot(aes(y=obs_value, x=as.factor(classif1), fill=classif2)) +
#      geom_bar(stat="identity") +
#      facet_wrap(~as.factor(sex)) + coord_flip() +
#      theme(legend.position="top") +
#      ggtitle("Employment by economic class, sex and age, South Africa, 1999") +
#      labs(x="Age group", y="Distribution of economic class (%)", fill="Economic class : ") +
#  	theme(plot.title = element_text(hjust = 0.5)) +
#      scale_fill_brewer(type = "div")
#  	

## ---- echo=FALSE, out.width = "100%"------------------------------------------
knitr::include_graphics("./g1_eco.png")

## ---- eval=FALSE--------------------------------------------------------------
#  require(Rilostat)
#  if(!require(tidyr)){install.packages('tidyr')}
#  if(!require(dplyr)){install.packages('dplyr')}
#  if(!require(plotrix)){install.packages('plotrix')}
#  if(!require(stringr)){install.packages('stringr')}
#  
#  triangle <- get_ilostat(id = c('EIP_WDIS_SEX_AGE_NB_A',
#                                 'UNE_TUNE_SEX_AGE_NB_A',
#                                 'TRU_TTRU_SEX_AGE_NB_A'),
#                          filters = list(
#                                        ref_area = c('ZAF', 'MNG', 'CHL'),
#                                        source = 'BA',
#                                        sex = 'SEX_T',
#                                        classif1 = 'YGE15',
#                                        time = '2013'),
#                                detail = 'dataonly',
#                                cmd = "dat %>% select(ref_area, indicator, obs_value)",
#                                quiet = TRUE) %>%
#              label_ilostat() %>%
#              group_by(ref_area.label) %>%
#              mutate(obs_value = obs_value / sum(obs_value)) %>% ungroup() %>%
#              mutate(indicator.label = indicator.label %>%
#                                        str_replace(fixed(' by sex and age (thousands)'), '')) %>%
#              spread(indicator.label, obs_value)
#  
#  par(cex=0.75, mar=c(0,0,0,0))
#  positions <- plotrix::triax.plot(
#                        as.matrix(triangle[, c(2,3,4)]),
#                        show.grid = TRUE,
#                        main = 'Selected labour underutilization indicators',
#                        label.points= FALSE, point.labels = triangle$ref_area.label,
#                        col.axis="gray50", col.grid="gray90",
#                        pch = 19, cex.axis=1.2, cex.ticks=0.7, col="grey50")
#  
#  
#  ind <- which(triangle$ref_area.label %in%  triangle$ref_area.label)
#  
#  df <- data.frame(positions$xypos, geo =  triangle$ref_area.label)
#  
#  points(df$x[ind], df$y[ind], cex=2, col="red", pch=19)
#  
#  text(df$x[ind], df$y[ind], df$geo[ind], adj = c(0.5,-1), cex=1.5)
#  

## ---- echo=FALSE, out.width = "100%"------------------------------------------
knitr::include_graphics("./g1_tri.png")

## ---- eval=FALSE--------------------------------------------------------------
#  require(Rilostat)
#  if(!require(plotly)){install.packages('plotly')}
#  if(!require(dplyr)){install.packages('dplyr')}
#  if(!require(stringr)){install.packages('stringr')}
#  
#  dat <- get_ilostat(id = 'UNE_2YAP_NOC_RT_A', filters = list(time = '2017')) %>%
#  			filter(!str_sub(ref_area,1,1) %in% 'X') %>%
#  			select(ref_area, obs_value) %>%
#  			left_join(	Rilostat:::ilostat_ref_area_mapping %>%
#  							select(ref_area, ref_area_plotly)%>%
#  							label_ilostat(code = 'ref_area'),
#  						by = "ref_area") %>%
#  			filter(!obs_value %in% NA)
#  
#  	
#  			
#  dat %>%
#  	plot_geo(
#  			z = ~obs_value,
#  			text = ~ref_area.label,
#  			locations = ~ref_area_plotly
#  		) %>%
#  		add_trace(
#  			colors = 'Blues',
#  			marker = list(
#  					    line = list(
#  							color = toRGB("grey"),
#  							width = 0.5)
#  					),
#  			showscale = TRUE
#  		) %>%
#  		colorbar(
#  			title = '%',
#  			len = 0.5
#  		) %>%
#  		layout(
#  		  title = 'Youth unemployment rate in 2017 (ILO modelled estimates, Nov. 2018)',
#  		  geo = list(	
#  					showframe = FALSE,
#  					showcoastlines = TRUE,
#  					projection = list(type = 'natural earth'),
#  					showcountries = TRUE,
#  					resolution = 110) # or 50
#  			)

## ---- echo=FALSE, out.width = "100%"------------------------------------------
knitr::include_graphics("./g1_map.png")

