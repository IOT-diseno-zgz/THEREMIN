
//----------------------------------------------------------------------------------------------------------------
//JAVIER MARÍN BONÉ
//ROSANA SANZ SEGURA
//Universidad de Zaragoza, Máster en Ingeniería de Diseño de Producto, Internet de las cosas.
//----------------------------------------------------------------------------------------------------------------


#include <NewPing.h>
 
/*Aqui se configuran los pines donde debemos conectar el sensor*/
#define TRIGGER_PIN  12
#define ECHO_PIN     11
#define MAX_DISTANCE 50

//Variable donde se guarda la distancia medida
int distancia;
byte distancia_byte;
 
/*Crear el objeto de la clase NewPing*/
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
 
void setup() {
  Serial.begin(9600);
}
 
void loop() {
  // Esperar 1 segundo entre mediciones
  delay(50);
  // Obtener medicion de tiempo de viaje del sonido y guardar en variable uS (Microsegundos)
  int uS = sonar.ping_median();
  // Imprimir la distancia medida a la consola serial
  //Serial.print("Distancia: ");
  // Calcular la distancia con base en una constante
  distancia = uS / US_ROUNDTRIP_CM;
  distancia_byte=(byte) distancia;
  //Serial.println(distancia);
  //Serial.println("cm");
  Serial.write(distancia_byte);
}

