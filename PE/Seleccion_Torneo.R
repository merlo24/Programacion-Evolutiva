Seleccion_Torneo <- function(PI,PM,tt){
  
  nind<-nrow(PI)
  nvar<-ncol(PI)-2

  PTS   <- matrix(0,(2*nind),(nvar+2))
  
  PT<- matrix(0,(nind*2),(nvar+3))
  PT[1:nind,1:(nvar+2)]<-PI
  PT[(nind+1):(2*nind),1:(nvar+2)]<-PM
  
  for (i in 1:tt){
    for(j in 1:(2*nind)){
      p<-floor(runif(1,1,(2*nind+1)))
      if(PT[i, (nvar+2)]<PT[p, (nvar+2)]){
        PT[i, (nvar+3)]<-PT[i, (nvar+3)]+1
      }
      else{
        PT[p,(nvar+3)]<-PT[p,(nvar+3)]+1
      }
    }
  }
  
  #Ordenar
  v <- sort(PT[,(nvar+3)], decreasing = T, index.return=T)
  v <- v$ix

  for(i in 1:(2*nind)){
    PTS[i,]<-PT[v[i],(1:(nvar+2))]
  }
  
  return(PTS)
  
}