remove(list=ls())
graphics.off()
library(animation)
library(plot3D)
source('Poblacion_Inicial.R')
source('Poblacion_Mutada.R')
source('Seleccion_Torneo.R')

# Funcion a evaluar (Michalewicz)
m    <- 10
fx1x2 <- function(x1,x2){-(sin(x1)*((sin((x1)^2/pi))^(2*m)))-(sin(x2)*((sin((2*(x2)^2/pi))^(2*m))))}

ngeneraciones <- 80 # Aqui radica mi inquietud al generalizar para n generaciones 
nind <- 100
nvar <- 2
xmin <- 0
xmax <- 3
stdmin <-  -0.5
stdmax <-   0.5
tt <- 10

# Matriz de poblaciones calculadas (primera generacion)
mpcal <- matrix(0,((ngeneraciones*nind)+nind),nvar+2)

# Poblacion Inicial
PI <- Poblacion_Inicial(nind,nvar,xmin,xmax,stdmin,stdmax,fx1x2)

PII<-PI
mpcal[1:nind,1:(nvar+2)]<-PII

for (k in 1:ngeneraciones){
  
  # Poblacion Mutada
  PM <- Poblacion_Mutada(PI,fx1x2)
  
  # Seleccion Torneo (Poblacion Torneo)
  PT <- Seleccion_Torneo(PI,PM,tt)
  
  # Nueva Poblacion Inicial
  PI <- PT[1:(nind),1:(nvar+2)]
  
  # Matriz de poblaciones calculadas (utilizadas para la animacion)
  mpcal[((k*nind)+1):(nind*(k+1)),(1:(nvar+2))] <- PI

  print(k)
}

# Animacion 3D

saveVideo({
  c <- -1
  for(i in seq(40, 420, 20)){ # Esta parte del codigo que puede modificarse para adaptar el algoritmo

    intg <- seq(0,76,4) # Esta parte del codigo que puede modificarse para adaptar el algoritmo
    c <- c+1

    for(j in (c(1:4)+(c*4))){ # Esta parte del codigo creo puede modificarse para adaptar el algoritmo

      x1<-seq(0,pi,pi/200)
      x2<-seq(0,pi,pi/200)
      m<-10

      fx1x2<-function(x1,x2){-(sin(x1)*((sin((x1)^2/pi))^(2*m)))-(sin(x2)*((sin((2*(x2)^2/pi))^(2*m))))}
      z1<-outer(x1,x2,fx1x2)

      funcmat <- persp3D(x1, x2, z = z1, colvar = z1, zlim=range(-2,0),
                         phi = 20, theta = i , expand=0.5,
                         ticktype="detailed", nticks=6, bty="b2", clim=range(z1),
                         colkey = F, plot=T)
      title(main = paste("Michalewicz \nGeneracion", j),
            sub = list(substitute(paste(x, "=", a, "   ",y, "=", b, "   ", f(x,y), "=", c ),
                                  list(a = round(mpcal[(j*nind)+1,1], digits = 3),
                                       b = round(mpcal[(j*nind)+1,2], digits = 3),
                                       c = round(mpcal[(j*nind)+1,4], digits = 3))), cex = 1.3), cex.main = 1.5,line = -1)

      xx <- mpcal[(j*nind):((j*nind)+(nind-1)),1]
      yy <- mpcal[(j*nind):((j*nind)+(nind-1)),2]
      zz <- fx1x2(xx,yy)

      # De coordenadas 3D a 2D
      mypoints <- trans3d(xx, yy, zz, funcmat)

      # Gafica en un espacio 2D los individuos
      points(mypoints, pch = 19, cex = 0.7, col = 1)
    }

  }
}, interval = 0.2, ani.width = 550, ani.height = 550)