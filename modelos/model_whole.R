#--- Carga de paquetes necesarios ---
#library(R2OpenBUGS)
library(R2jags)
library(tidyverse)

# Para ejectuar este archivo, por favor situarse en la ruta donde esta el archivo csv con los datos
# Cargamos los datos limpios


# Nota: ajustar "/media/Box/Modelos_Lineales_Generalizados/Projecto/data/Base/Ecobicis_Final.csv"
# a la ruta apropiada

###### ----- Se convierten a variables caracteres las variables categoricas ----- ######
Ecobicis_Final <- read_csv("/media/Box/Modelos_Lineales_Generalizados/Projecto/data/Base/Ecobicis_Final.csv", 
                           col_types = cols(bici = col_skip(), ciclo_estacion_arribo = col_character(), 
                                            ciclo_estacion_retiro = col_character(), 
                                            dia_sem = col_character(), dif_dias = col_skip(), 
                                            districtcode_retiro = col_skip(), 
                                            edad_usuario = col_character(), fecha_arribo = col_skip(), 
                                            fecha_retiro = col_skip(), genero_usuario = col_character(), 
                                            hora_arribo = col_skip(), hora_retiro = col_skip(), 
                                            hora_retiro_int = col_integer(), 
                                            nearbystation0 = col_skip(), nearbystation1 = col_skip(), 
                                            tipo_estacion_retiro = col_skip()))

df <- Ecobicis_Final


###### ----- Parametros de la simulacion ----- ######

# Numero de renglones
N <- nrow(df)

# Parametros de la simulacion
s= 500 # numero de puntos a obtenerse en la cadena
umbral_calentamiento = 0.1 # % puntos a quemar en periodo de calentamiento
s_cal = s*umbral_calentamiento # numero de puntos a quemar en periodo de calentamiento

#-Definicion de datos para el modelo
data<-list("N"=N,
           "y"=df$tiempo_min,
           "Genero"=df$genero_usuario,
           "Edad"=df$edad_usuario,
           "Estacion"=df$ciclo_estacion_arribo,
           "Dia"=df$dia_sem,
           "Hora"=df$hora_retiro_int+1) # Se agrega 1 para recorrer horas (0:23 -> 1:24)

#-Defininicion de inicilizadores (inits)
inits_a<-function(){list(beta0=0,
                         beta1=rep(0,2), # genero
                         #beta2=0,
                         beta2=rep(0,85), # Edad
                         beta3=rep(0,3002), # Estacion de arribo
                         beta4=rep(0,7), # Dia de la semana
                         beta5=rep(0,24), # Hora en que la bici fue tomada
                         yf=rep(1,N))}

#-Selecting parameters to monitor-
#pars_a<-c("beta0.est","beta1.est","beta2.est","beta3.est","beta4.est","beta5.est","mu","yf")
pars_a<-c("beta0.est","beta1.est","beta2.est","beta3.est","beta4.est","beta5.est","mu","yf")

#- Especificacion del modelo

modelowhole_prep.txt <-
  '
model{
# Verosimilitud
  for(i in 1:N){
    y[i] ~ dnorm(mu[i],tau)
    eta[i]<- beta0+beta1[Genero[i]]+beta2[Edad[i]]+beta3[Estacion[i]]+beta4[Dia[i]]+beta5[Hora[i]]
    mu[i] <- eta[i] #exp(eta[i])/(1+exp(eta[i]))
  }
#Priors
l  beta0 ~ dnorm(0,0.001) # Intercepto
  for (i in 1:2) {beta1[i] ~ dnorm(0,0.01)} # Genero del usuario
  #beta2 ~ dnorm(0,100) # Edad del usuario
  for (i in 1:85) {beta2[i] ~ dnorm(0,0.01)} # Edad
  for (i in 1:3002) {beta3[i] ~ dnorm(0,0.01)} # Estacion de arribo
  for (i in 1:7) {beta4[i] ~ dnorm(0,0.01)} # Dia de la semana en que ocurrio el viaje
  for (i in 1:24) {beta5[i] ~ dnorm(0,0.01)} # Hora en que la bicicleta fue tomada
  tau ~ dbeta(1,1) # Precision de la distribucion normal

# Condiciones de estimabilidad
  beta0.est <- beta0+mean(beta1[])+mean(beta2[])+mean(beta3[])+mean(beta4[])+mean(beta5[])
  for (i in 1:2) {beta1.est[i] <- beta1[i]-mean(beta1[])} # Genero del usuario
  #beta2.est <- beta2                                # Edad del usuario
  for (i in 1:85) {beta2.est[i] <- beta2[i]-mean(beta2[])} # Genero del usuario
  for (i in 1:3002) {beta3.est[i] <- beta3[i]-mean(beta3[])} # Estacion de arribo
  for (i in 1:7) {beta4.est[i] <- beta4[i]-mean(beta4[])} # Dia de la semana en que ocurrio el viaje
  for (i in 1:24) {beta5.est[i] <- beta5[i]-mean(beta5[])} # Estado civil

#Predictive
for (i in 1:N) {
    yf[i] ~ dnorm(mu[i],tau)
    }
}
'
cat(modelowhole_prep.txt, file = 'modelowhole_prep.jags')

#--- Jags
# Familia de modelos
modelwhole.normal<-jags(data,inits_a, pars_a,model.file="modelowhole_prep.jags",n.iter=s,n.chains=2,n.burnin=s_cal)


# ---- Traceplot

# Monitoreamos la convergencia de las cadenas

#traceplot(model.normal)

# Salvamos al modelo en formato rds
saveRDS(modelwhole.normal,"modelwhole.normal")






#--- Plots del efecto de las variables en la mortalidad

# Genero
plot1 <-  model.normal$BUGSoutput$summary[grep("beta1.est",rownames(model.normal$BUGSoutput$summary)),] # devuelve la tabla de 

k<-2
ymin<-min(plot1[,c(1,3,7)])
ymax<-max(plot1[,c(1,3,7)])
plot(1:k,plot1[,1],xlab="Género",ylab="",ylim=c(ymin,ymax))
segments(1:k,plot1[,3],1:k,plot1[,7])
abline(h=0,col="grey70")
abline(h=max(plot1[,c(1)]),col="red",lwd=1, lty=2)
title(paste0("Tiempo de viaje: Efecto del genero", "- Max: ", round(max(plot1[,c(1)]),2) ))

# Edad
plot1 <-  model.normal$BUGSoutput$summary[grep("beta2.est",rownames(model.normal$BUGSoutput$summary)),] # devuelve la tabla de 

k<-78
ymin<-min(plot1[,c(1,3,7)])
ymax<-max(plot1[,c(1,3,7)])
plot(1:k,plot1[,1],xlab="Edad",ylab="",ylim=c(ymin,ymax))
segments(1:k,plot1[,3],1:k,plot1[,7])
abline(h=0,col="grey70")
abline(h=max(plot1[,c(1)]),col="red",lwd=1, lty=2)
title(paste0("Tiempo de viaje: Efecto de la edad", "- Max: ", round(max(plot1[,c(1)]),2) ))

# Estacion de arribo
plot1 <-  model.normal$BUGSoutput$summary[grep("beta3.est",rownames(model.normal$BUGSoutput$summary)),] # devuelve la tabla de 

k<-318
ymin<-min(plot1[,c(1,3,7)])
ymax<-max(plot1[,c(1,3,7)])
plot(1:k,plot1[,1],xlab="Estacion de arribo",ylab="",ylim=c(ymin,ymax))
segments(1:k,plot1[,3],1:k,plot1[,7])
abline(h=0,col="grey70")
abline(h=max(plot1[,c(1)]),col="red",lwd=1, lty=2)
title(paste0("Tiempo de viaje: Estacion de arribo", "- Max: ", round(max(plot1[,c(1)]),2) ))

# Dia de la semana
plot1 <-  model.normal$BUGSoutput$summary[grep("beta4.est",rownames(model.normal$BUGSoutput$summary)),] # devuelve la tabla de 

k<-7
ymin<-min(plot1[,c(1,3,7)])
ymax<-max(plot1[,c(1,3,7)])
plot(1:k,plot1[,1],xlab="Dia de la semana",ylab="",ylim=c(ymin,ymax))
segments(1:k,plot1[,3],1:k,plot1[,7])
abline(h=0,col="grey70")
abline(h=max(plot1[,c(1)]),col="red",lwd=1, lty=2)
title(paste0("Tiempo de viaje: Dia de la semana", "- Max: ", round(max(plot1[,c(1)]),2) ))

# Hora del dia
plot1 <-  model.normal$BUGSoutput$summary[grep("beta5.est",rownames(model.normal$BUGSoutput$summary)),] # devuelve la tabla de 

k<-24
ymin<-min(plot1[,c(1,3,7)])
ymax<-max(plot1[,c(1,3,7)])
plot(1:k,plot1[,1],xlab="Hora del dia",ylab="",ylim=c(ymin,ymax))
segments(1:k,plot1[,3],1:k,plot1[,7])
abline(h=0,col="grey70")
abline(h=max(plot1[,c(1)]),col="red",lwd=1, lty=2)
title(paste0("Tiempo de viaje: Hora del dia", "- Max: ", round(max(plot1[,c(1)]),2) ))



