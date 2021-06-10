rm(list=ls())
graphics.off()
source('PE_Refra_anim.R')
#source('ev_ta.R')

ncapas <- 3

#############################################################################################
#Parametros del modelo
m <-  c(tan((0*pi)/180),tan((1*pi)/180),tan((-2*pi)/180))#,tan((4*pi)/180),tan((0*pi)/180))  #Pendiente estratos
h  <- c(20,35,50)#,1090,1250)
v  <- c(338,957,2471,4500)#,5000,6000)
gi <- 50                                  #Distancia primer Geofono
gf <- 120                                 #Distancia ultimo Geofono
int<- 15                                  #Intervalo entre Geofonos
gn <- seq(gi,gf,int)                      #Serie de Geofonos 
ng  <- length(gn)                         #Numero de Geofonos
capas <- seq(ncapas)
##############################################################################################
hh <- c(0,h)
mm <- c(0,m) 
##############################################################################################
#Graficar Modelo 
###Estratos###

Xneg <- seq(-gf,-gi,int)
Xpos <- seq(gi,gf,int)
X    <- c(Xneg,0,Xpos)
ge   <- matrix(0,ncapas,length(X))

for(i in 1:length(X)){ 
  for(j in 1:length(h)){
    ge[j,i] <- (m[j]*X[i])+h[j] 
  }
}

x11()

if(ncapas==1){
  plot(X,-ge[1,],'l',ylim=c(-(h[length(h)]+20),0),main='Trazado',xlab = 'Distancia (m)',ylab= 'Profundidad (m)')
}
if(ncapas>1){
  plot(X,-ge[1,],'l',ylim=c(-(h[length(h)]+20),0),main='Trazado',xlab = 'Distancia (m)',ylab= 'Profundidad (m)')
  
  for(i in 1:(nrow(ge)-1)){
    lines(X,-ge[i+1,],'l')
  }
}


abline(h=0)
points(0,1,pch=8)
gkn <- -gn[seq(length(gn),1,-1)]
for (p in 1:length(gkn)){
  points(gkn[p],0.5,pch=6)
}
for (p in 1:length(gn)){
  points(gn[p],0.5,pch=6)
}

###########################################################################################

####Parametros del algoritmo####

ngeneraciones <- 40
nind <- 10
nvar <- 2*ncapas
stdmin <- 0
stdmax <-  3

tt<-10

tao<-1/(sqrt(2*(sqrt(nind))))
taop<-1/sqrt(2*nind)

###########################################################################################
####Registro tiempos de arribo####
tap <- matrix(0,ng,1)
tan <- matrix(0,ng,1)

####Parametros del algoritmo####

stdmin <-  0
stdmax <-  3

tt<-10

tao<-1/(sqrt(2*(sqrt(nind))))
taop<-1/sqrt(2*nind)

####Registro tiempos de arribo####
tar  <- matrix(0,1,ng)
ta  <- matrix(0,ncapas+1,ng)
ta[1,]  <- (gn/v[1])*1000

mxp <- matrix(0,(ngeneraciones*nvar),(nind*ng))
mxn <- matrix(0,(ngeneraciones*nvar),(nind*ng))

for(u in ncapas:length(capas)){
  nvar<-(2*capas[u])
  for(n in 1:ng){
    
    #Parte positiva
    xmin1 <- 0
    xmax1 <- gn[n]
    
    #Parte negativa
    xmin2 <- -gn[n]
    xmax2 <- 0
    
    P <- PE_Refra_anim(ngeneraciones,nind,nvar,xmin1,xmax1,tt,stdmin,stdmax,tao,taop,capas[u],hh[1:(u+1)],v[1:(u+1)],mm[1:(u+1)])
    N <- PE_Refra_anim(ngeneraciones,nind,nvar,xmin2,xmax2,tt,stdmin,stdmax,tao,taop,capas[u],hh[1:(u+1)],v[1:(u+1)],mm[1:(u+1)])
    
    mxp[(1:(ngeneraciones*nvar)),((((n-1)*nind)+1):(n*nind))]<-P
    mxn[(1:(ngeneraciones*nvar)),((((n-1)*nind)+1):(n*nind))]<-N
   
    print(n)
    
  }
  
}

###Grafica de Animacion####

###Intervalo de avance del GIF
ani.options(interval=.05,ani.height=500,ani.width=900,ani.type="png",ani.dev="png")

saveVideo({
  # Para la mayor parte, es mas seguro empezar con los ajustes graficos
  # en el bucle de animacion, asi como el bucle añade una mayor
  # complejidad a la manipulacion de graficas. Por ejemplo, las
  # especificaciones de layout necesitan estar dentro del bucle de animacion
  # para trabajar apropiadamente
  
  # Empezar el ciclo y crear las graficas
  for (l in 1:ngeneraciones) {
    
    yp <- matrix(0,1,nvar)
    yn <- matrix(0,1,nvar)
    
    ####-Graficar Modelo-#### 
    ####-Estratos-####
    
    Xneg <- seq(-gf,-gi,int)
    Xpos <- seq(gi,gf,int)
    X    <- c(Xneg,0,Xpos)
    ge   <- matrix(0,ncapas,length(X))
    
    for(i in 1:length(X)){ 
      for(j in 1:length(h)){
        ge[j,i] <- (m[j]*X[i])+h[j] 
      }
    }
    
    if(ncapas==1){
      plot(X,-ge[1,],'l',ylim=c(-(h[length(h)]+20),0),xlab = 'Distancia (m)',ylab= 'Profundidad (m)',main = paste('Sismica de Refraccion
Generacion No.',l))
    }
    if(ncapas>1){
      plot(X,-ge[1,],'l',ylim=c(-(h[length(h)]+20),0),xlab = 'Distancia (m)',ylab= 'Profundidad (m)',main = paste('Sismica de Refraccion
Generacion No.',l))
      
      for(i in 1:(nrow(ge)-1)){
        lines(X,-ge[i+1,],'l')
      }
    }
        
    abline(h=0)
    points(0,1,pch=8)
    gkn <- -gn[seq(length(gn),1,-1)]
    for (p in 1:length(gkn)){
      points(gkn[p],0.5,pch=6)
    }
    for (p in 1:length(gn)){
      points(gn[p],0.5,pch=6)
    }
    
    ####-Grafica Rayos-####
    
    for(n in 1:ng){
      
      mxcp<-mxp[(1:(ngeneraciones*nvar)),((((n-1)*nind)+1):(n*nind))]
      mxcn<-mxn[(1:(ngeneraciones*nvar)),((((n-1)*nind)+1):(n*nind))]
      
      for(j in 1:nind){
        
        xp <- mxcp[((l*nvar)-(nvar-1)):(l*nvar),j]
        xn <- mxcn[((l*nvar)-(nvar-1)):(l*nvar),j]
        
        for(k in 1:nvar){
          yp[k]<-m[k]*xp[k]+h[k]
          yn[k]<-m[k]*xn[k]+h[k]
        }
        
        hr<-h[seq(length(h),1,-1)]
        mr<-m[seq(length(m),1,-1)]
        yp[(ncapas+1):nvar] <- mr*xp[((ncapas+1):nvar)]+hr
        yn[(ncapas+1):nvar] <- mr*xn[((ncapas+1):nvar)]+hr
        
        X <- c(-gn[n],xn,0,xp,gn[n])
        
        Y <- c((0),-yn,(0),-yp,(0))
        lines(X,Y,'l',col='blue',lwd=1)
        
      }
    }  
  }
})

# taf<-matrix(0,ng,1)
# 
# for(i in 1:ng){
#   taf[i]<-min(ta[,i])
# }