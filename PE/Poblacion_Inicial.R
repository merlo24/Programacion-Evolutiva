Poblacion_Inicial <- function(nind,nvar,xmin,xmax,stdmin,stdmax,fx1x2){
  PI    <- matrix(0,nind,(nvar+2)) #Poblacion Inicial
  #Poblacion Inicial
  for(i in 1:nind){
    for(j in 1:nvar){
      PI[i,j]<-runif(1,xmin,xmax)
    }
    PI[i,(nvar+1)] <- runif(1,stdmin,stdmax)
    
    #Funcion Evaluada como Poblacion Inicial 
    PI[i,(nvar+2)] <- fx1x2(PI[i,1],PI[i,2])
  }
  return(PI)
}