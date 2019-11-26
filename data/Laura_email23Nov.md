Hola chicos, 

Conforme a lo acordado el jueves pasado, les envío la base de Ecobicis limpia.

*Se consideró información de las dos bases proporcionadas por César (datos abiertos ecobicis y catálogo de ecobicis). Los respectivos campos utilizados se encuentran en el documento adjunto "Desc_Base".

*Fueron calculados y añadidos los siguientes cuatro campos:
    * dia\_sem 	día de la semana en donde 1 se refiere a lunes y 7 se refiere a domingo
    * dif\_dias 	número de días entre fecha_retiro y fecha_arribo.
    * Hay 72 observaciones cuya diferencia entre fecha\_retiro y fecha\_arribo es mayor a un día.
    * tiempo\_min 	duración del viaje en minutos
    *hora\_retiro_int 	hora de retiro sin incluir minutos ni segundos

*Las columnas que contienen información no numérica (tipo_estacion_retiro y districtcode) ya fueron transformadas a minúsculas, se eliminaron los acentos y los espacios.

*En la base original existen 51 registros correspondientes a septiembre 2019, los cuales fueron eliminados de la base final. Lo anterior porque consideraremos únicamente los viajes que fueron iniciados en octubre 2019.


*Con respecto al catálogo de ecobicis, los nombres de las estaciones de retiro y de arribo, así como los nombres de las colonias en donde se encuentran ubicadas las estaciones contiene caracteres extraños en los lugares en donde debería ir algún acento. Los caracteres no son reconocidos por pandas y supongo que tampoco serán reconocidos en R. ¿Me podrían ayudar a decidir si es necesario incluir esta información? En caso de sí requerirla será necesario arreglar esos caracteres manualmente. No tengo problema en hacerlo; pero llevará un par de horas y no quise hacer ese trabajo hasta estar completamente segura de que realmente necesitamos esa información. 


Espero sus comentarios.
