Poblacion_Mutada <- function(PI,fx1x2){
  
  nind <- nrow(PI)
  nvar <- ncol(PI)-2
  
  tao <- 1/(sqrt(2*(sqrt(nind))))
  taop <- 1/sqrt(2*nind)
  
  # Poblacion Mutada
  PM<-matrix(0,nind,(nvar+2))
  
  # Restricción en el espacio de búsqueda
  for(i in 1:nind){
    sd<-PI[i,nvar+1]
    
    for(j in 1:nvar){
      PM[i,j] <- PI[i,j]+(sd*rnorm(1))
      
      while (PM[i,j] < xmin){
        PM[i,j] <- PM[i,j]+(sd*rnorm(1))
      }
      
      while (PM[i,j] > xmax){
        PM[i,j] <- PM[i,j]+(sd*rnorm(1))
      }
      
    }
    
    PM[i,nvar+1]<- PI[i,nvar+1]*exp((taop*rnorm(1))+(tao*rnorm(1)))
    
    # Funcion Evaluada como Poblacion Mutada
    PM[i,(nvar+2)] <- fx1x2(PM[i,1],PM[i,2])
  }
  
  return(PM)
}