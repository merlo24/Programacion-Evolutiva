PE_Refra_anim <- function(ngeneraciones,nind,nvar,xmin,xmax,tt,stdmin,stdmax,tao,taop,capas,hh,v,mm){
  
  source('ev_ta_refra.R')
  
  PI <- matrix(0,nind,(nvar+2))
  mx  <- matrix(0,(ngeneraciones*nvar),nind)
  pm  <- seq(0,(ngeneraciones-1),1)
  
  #Poblacion Inicial
  for(i in 1:nind){
    
    for(j in 1:nvar){
      PI[i,j]<-runif(1,xmin,xmax)      
      
      while(PI[i,j] > xmax & PI[i,j] < 0){
        PI[i,j]<-runif(1,xmin,xmax)
      }
      
    }
    
    PI[i,(1:nvar)]<-sort(PI[i,(1:nvar)])
    
    PI[i,(nvar+1)]<-runif(1,stdmin,stdmax)
    
    #Funcion Evaluada como Poblacion Inicial
    PI[i,(nvar+2)]<-ev_ta_refra(capas,c(xmin,PI[i,(1:nvar)],xmax),hh,v,mm)
  }
  
  #Poblacion Mutada
  PM<-matrix(0,nind,(nvar+2))
  
  for (k in 1:ngeneraciones){
    for(i in 1:nind){
      sd<-PI[i,nvar+1]
      
      for(j in 1:nvar){
        PM[i,j] <- PI[i,j]+(sd*rnorm(1))
        
        if(PM[i,j] < 0){
          PM[i,j]<-PM[i,j]*(-1)
        }
        
        while(PM[i,j] > xmax){
          PM[i,j]<- PI[i,j]+(sd*rnorm(1))
        }         
      }
      
      PM[i,(1:nvar)]<-sort(PM[i,(1:nvar)])
      
      PM[i,nvar+1]<- PI[i,nvar+1]*exp((taop*rnorm(1))+(tao*rnorm(1)));
      #Funcion Evaluada como Poblacion Mutada
      PM[i,(nvar+2)]<-ev_ta_refra(capas,c(xmin,PM[i,(1:nvar)],xmax),hh,v,mm)
    } 
    
    #Seleccion Torneo  
    PT<- matrix(0,(nind*2),(nvar+3))
    PT[1:nind,1:(nvar+2)]<-PI
    PT[(nind+1):(2*nind),1:(nvar+2)]<-PM
    for (i in 1:tt){
      for(j in 1:(2*nind)){
        p<-floor(runif(1,1,(2*nind+1)))
        if(PT[j,(nvar+2)]<PT[p,(nvar+2)]){
          PT[j,(nvar+3)]<-PT[j,(nvar+3)]+1
        }
        else{
          PT[p,(nvar+3)]<-PT[p,(nvar+3)]+1
        }
        #     print(p)
      }
    }
    
    #Ordenar
    for(i in 1:nind){
      I <- PT[i,]
      mejor <- i
      maximo <- PT[i,nvar+3]
      for(j in (i+1):(2*nind)){
        if(maximo<PT[j,nvar+3]){
          mejor <- j
          maximo <- PT[j,nvar+3]
        }
      }
      PT[i,] <- PT[mejor,]
      PT[mejor,] <- I
    }
    
    PI<-PT[1:(nind),1:(nvar+2)]
    
    if (ncapas==1){
      for(i in 1:nind){
        mx[((k+pm[k]):(k*nvar)),i]<-PI[i,(1:nvar)]
      }
    }
    
    for(i in 1:nind){
      if(k==1){
        mx[((k+pm[k]):(k*nvar)),i]<-PI[i,(1:nvar)]
      }
      mx[((((k-1)*nvar)+1):(k*nvar)),i]<-PI[i,(1:nvar)]
    }
    
  }
  
  return(mx)
  
}