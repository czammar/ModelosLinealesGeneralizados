# ModelosLinealesGeneralizados
Projecto de Trabajo Final

15 de noviembre de 2019

### 0. Introducción

Este documento pretende ser un bosquejo de los temas que se deben cubrir con motivo del trabajo final del curso de Modelos Lineales Generalizados.

### 1. Consideraciones generales

* **Conformación de equipos:**  De entre 2 a 4 integrantes.
	
* **Fuentes de datos:** Base de datos del trabajo o de internet con un problema que sea motivador.
	
* **Idea central:** Demostrar que:
	* Se sabe usar **de manera apropiada los modelos vistos en clase para resolver un problema práctico**.
	* Con la base seleccionada se debe:
		* **Formular una serie de objetivos a resolver**,
		* **Plasmar en el projecto que se hizo para resolver dichos objetivos**.
		
* **Fecha:** entrega el día del  examen final; 16 de diciembre de 2019
	
### 2. Estructura a seguir en el trabajo escrito:


i. **Introducción:** descripción del problema, contexto y objetivos a resolver
ii. **Descripción de la información:** en términos de cada una de sus variables, escalas de medición. Debe incluir un análisis exploratorio de datos.

iii. **Modelado e implementación:** describir con detalle el modelo, con todas sus especificaciones, que usarán para resolver sus objetivos. 

**Nota:** Corre modelo en *R-OpenBugs-JAGS* y dar detalles de sus cadenas, convergencia, etc.

iv. **Interpretación de resultados:** presentar a) un resumen de sus estimadores y la b) interpretación en el contexto del problema. Seleccionen las variables importantes. 

**Nota:** Se deben usar los resultados para responder a los objetivos planteados, sugieriendo o tomando decisiones con respecto a dichos resultados.

v. **Referencias:** fuentes consultadas para hacer el trabajo (e.g. páginas de internet, libros, revistas o apuntes de clase).
vi. **Apéndice.** Incluir (opcionalmente) todo el código utilizado. 

**Otras consideraciones:**

a. **No incluir código en las secciones distintas del apéndice (i.e. no en secciones de la i-iv)**.
b. Se puede incluir gráficas útiles  en secciones de la i-iv con comentarios dirigidos. 
c, Las gráficas que no indispensables pueden ir en el apéndice.


* **Formato:** Aparentemente libre. Sugiero que usemos un template colaborativo como este de overleaf (https://www.overleaf.com/4493396731rtpjkjmjfhft); depende de lo que decidamos que es mejor trabajar a distancia.

### 3. Presentación oral

* **Formato:** Se debe exponer el tema en un presentación de formato libre, en un tiempo **máximo de 15 minutos**.

Entiendo que deberían cubrir los puntos principales del trabajo; aunque sea rápido no se debería omitir ningún punto de la estructura obligada.

**Nota:** Podríamos usar Beamer (LaTeX), ya sea colaborativo como los de overlead o uno fijo (como el que que subí en la carpeta *Beamer\_ejemplo*), o bien un PowerPoint. **Este punto se puede decidir cuando tengamos casi cerrado el trabajo escrito.**


* calificación de la presentación será individual, mientras que la calificación del trabajo será por equipo
	*  **Fecha de exposición:**  No se aclara, pero supongo que se plantea para el día en que tendríamos el final (**16 de diciembre**).

### 4. Lluvia de ideas sobre problema que podría ser interesante para resolver

Creo que lo más conveniente es que cada quien aporte **esta semana entrante** ideas de un tema del trabajo. Les ruego que cada uno presente un tema (oralmente) que pueda ser motivo del trabajo, considerando el planteamiento concreto a través de cuando menos los siguientes puntos:

1. **Tema:** que sea atractivo por su relevancia en las áreas en que ha laborado o bien a sus intereses. De preferencia algo que no se haya abordado en clase.

2. **Solubilidad:** que se **pueda para resolver** 1) usando las herramientas del cursos sobre modelos y herramientas bayesianas, 2) que sea **asequible** de acuerdo al tiempo que todos podemos dedicar de acuerdo a la agenda de finales.

3. **Disponibilidad de datos:** describiendo la fuente explícita donde se localizan los datos que servirían para el análisis. Es decir; fuentes claras y concretas de repositorios que se necesiten, y si existen otras fuentes de datos que sea necesario investigar.

**Nota:** Como ejemplo, del **planteamiento concreto de un problema ficticio** se tiene:

* **Objetivo:**  Se plantea determinar cuales son los factores significativos que inciden en el gasto de un hogar en el servicio de internet, para emitir recomendaciones que permitan plantear políticas públicas que permitan incentivar la adopción de este medio que permite la comunicación de las personas y su interacción con el mundo digital. 

* **Herramientas:** Para ello se plantea estimar el gasto de los hogares del país en servicios de internet, usando datos de encuesta ENDUTIH 2017 del INEGI y otros factores socioeconómicos. De este modo, consideremos un modelo normal que relacione el gasto con por hogar con la cantidad de Hogares con conexión a Internet, según medio de conexión; usando distintas ligas (logit, log-log, probit). Asequible dado que se deben construir 4 modelos para JAGS y testear convergencia, asi como idoneaidad de ajuste con DIC, pseudo R^2.

* **Base de datos:** Tabulados de *Hogares con Internet, según medio de conexión* en el rubro *Equipamiento de Tecnologías de Información de las Comunciaciones del Hogar* de la ENDUTIH 2017 disponibles en la dirección https://www.inegi.org.mx/programas/dutih/2017/default.html#Tabulados para estimar el gasto de los hogares en servicios de interner.

* **Datos faltantes:** Ingreso promedio de los hogares en México; se podría investigar en la Encuesta Nacional de Ingresos y Gastos de los Hogares (ENIGH) de 2016 u otros. Ver: https://www.inegi.org.mx/programas/enigh/nc/2016/

### 5. Disponibilidad de horarios para reunión de Kick-Off (18-22 Nov)

| Nombre | Disponibilidad (18 - 22 Nov)                 | Notas |
|--------|----------------------------------------------|-------|
| Laura  | Mi: > 17:30<br>Ju: 08:00 - 15:00             |       |
| Ely    | ?                                            |       |
| Miguel | ?                                            |       |
| César  | Mi: > 17:30, Ju: 08:00 - 15:00, Vi: > 10:00  |       |



César
