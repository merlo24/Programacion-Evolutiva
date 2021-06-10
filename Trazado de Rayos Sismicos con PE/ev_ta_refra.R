ev_ta_refra <- function(n,x,h,v,m){
  t1 <- 0
  t2 <- 0
  
  for(i in 1:n){
    t1 <- t1+((1/v[i])*sqrt((x[i+1]-x[i])^2+((m[i+1]*x[i+1]+h[i+1])-(m[i]*x[i]+h[i]))^2))
    t2 <- t2+((1/v[n+1-i])*sqrt((x[n+2+i]-x[n+1+i])^2+((m[n+1-i]*x[n+2+i]+h[n+1-i])-(m[n+2-i]*x[n+1+i]+h[n+2-i]))^2))
  }
  
  t3 <- ((1/v[n+1])*sqrt((x[n+2]-x[n+1])^2+((m[n+1]*x[n+2]+h[n+1])-(m[n+1]*x[n+1]+h[n+1]))^2))
  
  t<-t1+t2+t3
  return(t)
}