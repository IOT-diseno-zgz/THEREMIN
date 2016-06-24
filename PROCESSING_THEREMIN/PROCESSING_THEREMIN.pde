
//----------------------------------------------------------------------------------------------------------------
//JAVIER MARÍN BONÉ
//ROSANA SANZ SEGURA
//Universidad de Zaragoza, Máster en Ingeniería de Diseño de Producto, Internet de las cosas.
//----------------------------------------------------------------------------------------------------------------

import processing.serial.*; //Importamos la librería Serial
import beads.*; //Importar biblioteca beads

int limite = 50; //Distancia máxima captada
int valor; //Distancia en cada momento
PFont FuenteTitulo,FuenteLogo; //Fuentes para los títulos y para el logo
int  stage; //Variable escenario corresponde a cada pantalla

float Do4  = 261.626;
float Re4  = 293.665;
float Mi4  = 329.628;
float Fa4  = 349.228;
float Sol4 = 391.995;
float La4  = 440.000;
float Si4  = 493.883;
float Do5  = Do4 * 2;


WavePlayer wp; //Inicializar audio
AudioContext ac;
Glide frequencyGlide;
Serial port; 


void setup()
  {
    
  stage = 0;
  fullScreen();
  FuenteTitulo= loadFont("Verdana-30.vlw");
  FuenteLogo= loadFont("BrannbollFPERSONALUSEONLY-100.vlw");  
  colorMode(HSB,360,100,100); // Modo de color HSB (0,0,0) Negro (360,0,100) Blanco
 
 
  println(Serial.list()); //Visualiza los puertos serie disponibles 
  port = new Serial(this, Serial.list()[0], 9600); //Abre el primer puerto serie.
 
  ac = new AudioContext(); // inicializamos el objeto AudioContext 
  frequencyGlide = new Glide(ac, 20, 50);  // Se crea el objeto frecuencia (20 Hz, tiempo de transición 50 ms)
  wp = new WavePlayer(ac, frequencyGlide, Buffer.SINE);
  ac.out.addInput(wp);
  ac.start();
  
  }


void draw()
{
  
  if(port.available() > 0) // si hay algún dato disponible en el puerto
    {
    valor=port.read();//Lee el dato y lo almacena en la variable "valor"
    }
 
  
  ///////PANTALLA DE INICIO//////////
  
  if(stage==0)
    {
      
    background(360,0,100);
    noStroke();
    fill(182,100,75);
    ellipse(width/2,height/2,400,400); 
    fill(360,0,100);
    textAlign(CENTER);
    textFont(FuenteLogo);  
    text ("Full",width/2,(height/2)-30);
    text ("Color",width/2,(height/2)+70);
      
    fill(0,0,0);
    textAlign(CENTER);
    textFont(FuenteTitulo, 20);  
    text ("Click o barra espaciadora para continuar",width/2,(height/2)+270);
    textAlign(LEFT);
    
    if ((keyPressed) || (mousePressed) )
      {
      stage = 1;
      key=0;
      }
    }
  
  
  /////////////MENU////////////////

  if (stage == 1) 
    {
   
    background(360,0,100);
    frequencyGlide.setValue(0);
    
    noStroke();
    fill(0,0,30);
    rect(0,0,500,80);   

    noStroke();
    fill(0,0,90);
    rect(0,86 ,500,72);
    rect(0,161,500,72);
    rect(0,236,500,72);
    rect(0,311,500,72);
    rect(0,386,500,72);
    rect(0,461,500,72);
    
    noStroke();
    fill(360,0,100);
    rect(10, 15,70, 10);
    rect(10, 35,70, 10);
    rect(10, 55,70, 10);
  
    textFont(FuenteTitulo,30);
    text ("MENU",225,50);
    
    int sep = 75;
    
    fill(0,0,0);
    textFont(FuenteTitulo,15);    
    text ("1            Escala natural monocolor",40,95+(sep/2));
    text ("2            Escala natural multicolor",40,95+(sep/2)+(1*sep));
    text ("3            Escala pentatónica de La monocolor",40,95+(sep/2)+(2*sep));
    text ("4            Escala pentatónica de La multicolor",40,95+(sep/2)+(3*sep));
    text ("5            Colores cálidos",40,95+(sep/2)+(4*sep));
    text ("6            Cores frios",40,95+(sep/2)+(5*sep));    
    
    //Visualizamos la distancia con un texto
    fill(0,0,0);
    text(" Distancia =",30,height-40);
    text(valor, 130, height-40);
    text("cm",160,height-40);

    if ((key == '1') ||(mouseX<500)&&(mouseY>86)&&(mouseY<161)&&(mousePressed))
      {
      stage = 2;
      key=0;
      }
    if ((key == '2') ||(mouseX<500)&&(mouseY>161)&&(mouseY<236)&&(mousePressed))
      {
      stage = 3; 
      }
    if ((key == '3') ||(mouseX<500)&&(mouseY>236)&&(mouseY<311)&&(mousePressed))
      {
      stage = 4;
      key=0;
      }
    if ((key == '4') ||(mouseX<500)&&(mouseY>311)&&(mouseY<386)&&(mousePressed))
      {
      stage = 5;
      key=0;
      }
    if ((key == '5') ||(mouseX<500)&&(mouseY>386)&&(mouseY<461)&&(mousePressed))
      {
      stage = 6;
      key=0;
      }
    
    if ((key == '6') ||(mouseX<500)&&(mouseY>461)&&(mouseY<536)&&(mousePressed))
      {
      stage = 7; 
      key=0;
      }
    
    }
 
  
  //////// ESCALA NATURAL MONOCOLOR/////////
    //Pantalla de un solo color. Notas: DO (4º octava) - RE - MI - FA - SOL - LA - SI - DO - (5º octava)
    //Cada color equivale a una nota
    
  if (stage == 2 )
    {
      
  
    int m = (int) map (valor, 0,limite, 0, 80);

    if (m == 0)
      {
      // SILENCIO
      frequencyGlide.setValue(0);
      noStroke();
      fill(182,100,75);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Silencio",30,height-40);
      }

    if ((m > 0)&&( m < 10))
      {
      // DO
      frequencyGlide.setValue(Do4);
      noStroke();
      fill(111,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Do",30,height-40);
      }
  
    if ((m >= 10)&&( m < 20))
      {
      // RE
      frequencyGlide.setValue(Re4);
      noStroke();
      fill(211,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Re",30,height-40);
      }
 
    if ((m >= 20)&&( m < 30))
      {
      // MI
      frequencyGlide.setValue(Mi4);
      noStroke();
      fill(278,100,81);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Mi",30,height-40);
      }
    
    if ((m >= 30)&&( m < 40))
      {
      // Fa
      frequencyGlide.setValue(Fa4);
      noStroke();
      fill(281,100,33);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Fa",30,height-40);
      }
      
     if ((m >= 40)&&( m < 50))
      {
      // SOL
      frequencyGlide.setValue(Sol4);
      noStroke();
      fill(0,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Sol",30,height-40);      
      } 
      
     if ((m >= 50)&&( m < 60))
      {
      // LA
      frequencyGlide.setValue(La4);
      noStroke();
      fill(24,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("La",30,height-40);      
      } 
      
     if ((m >= 60)&&( m < 70))
      {
      // SI
      frequencyGlide.setValue(Si4);
      noStroke();
      fill(77,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Si",30,height-40);      
      }
      
     if ((m >= 70))
      {
      // DO5
      frequencyGlide.setValue(Do5);
      noStroke();
      fill(111,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Do",30,height-40);      
      } 

    //TECLA MENU 
    noStroke();
    fill(360,0,100);
    rect(10, 15,70, 10);
    rect(10, 35,70, 10);
    rect(10, 55,70, 10);
    
    if ((key == 'm') ||(key == 'M') ||(mouseX<80)&&(mouseY<80)&&(mousePressed))
      {
      stage = 1;
      key=0;
      } 

   }     
      
  ///////// ESCALA NATURAL MULTICOLOR//////// 
  
  if (stage == 3 )
   {
    int H = (int) map (valor, 0,limite, 0, 360);//map(valor, valor actual   inicial, valora actual final, valor objetivo inicial, valor objetivo final)
    text(H, 250, 760);
   
    noStroke();
    fill(H,100,50);
    rect((width/5)*0, 0,width/5, height);
  
    noStroke();
    fill(H,50,100);
    rect((width/5)*1, 0,width/5, height);
  
    noStroke();
    fill(H,100,100);
    rect((width/5)*2, 0,width/5, height);
  
    noStroke();
    fill(H,72,50);
    rect((width/5)*3, 0,width/5, height);
  
    noStroke();
    fill(H,100,80);
    rect((width/5)*4, 0,width/5, height); 
    
    int m = (int) map (valor, 0,limite, 0, 80);

    if (m == 0)
      {
      // SILENCIO
      frequencyGlide.setValue(0);
      fill(360,0,100);
      text("Silencio",30,height-40);
      }

    if ((m > 0)&&( m < 10))
      {
      // DO
      frequencyGlide.setValue(Do4);
      fill(360,0,100);
      text("Do",30,height-40);
      }
  
    if ((m >= 10)&&( m < 20))
      {
      // RE
      frequencyGlide.setValue(Re4);
      fill(360,0,100);
      text("Re",30,height-40);
      }
 
    if ((m >= 20)&&( m < 30))
      {
      // MI
      frequencyGlide.setValue(Mi4);
      fill(360,0,100);
      text("Mi",30,height-40);
      }
    
    if ((m >= 30)&&( m < 40))
      {
      // Fa
      frequencyGlide.setValue(Fa4);
      fill(360,0,100);
      text("Fa",30,height-40);
      }
      
     if ((m >= 40)&&( m < 50))
      {
      // SOL
      frequencyGlide.setValue(Sol4);
      fill(360,0,100);
      text("Sol",30,height-40);      
      } 
      
     if ((m >= 50)&&( m < 60))
      {
      // LA
      frequencyGlide.setValue(La4);
      fill(360,0,100);
      text("La",30,height-40);      
      } 
      
     if ((m >= 60)&&( m < 70))
      {
      // SI
      frequencyGlide.setValue(Si4);
      fill(360,0,100);
      text("Si",30,height-40);      
      }
      
     if ((m >= 70))
      {
      // DO5
      frequencyGlide.setValue(Do5);
      fill(360,0,100);
      text("Do",30,height-40);      
      } 
    
    //TECLA MENU 
    noStroke();
    fill(360,0,100);
    rect(10, 15,70, 10);
    rect(10, 35,70, 10);
    rect(10, 55,70, 10);
    
    if ((key == 'm') ||(key == 'M') ||(mouseX<80)&&(mouseY<80)&&(mousePressed))
      {
      stage = 1;
      key=0;
      } 
  
   }

   
  ///////////ESCALA PENTATONICA DE LA MONOCOLOR/////////  
  
  if (stage == 4 )
    { 
   
    int m = (int) map (valor, 0,limite, 0, 60);

    if (m == 0)
      {
      // SILENCIO
      frequencyGlide.setValue(0);
      noStroke();
      fill(182,100,75);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Silencio",30,height-40);
      }

    if ((m > 0)&&( m < 10))
      {
      // LA
      frequencyGlide.setValue(La4);
      noStroke();
      fill(24,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("La",30,height-40);
      }
  
    if ((m >= 10)&&( m < 20))
      {
      // DO
      frequencyGlide.setValue(Do4);
      noStroke();
      fill(111,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Do",30,height-40);
      }
 
    if ((m >= 20)&&( m < 30))
      {
      // RE
      frequencyGlide.setValue(Re4);
      noStroke();
      fill(211,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Re",30,height-40);
      }
    
    if ((m >= 30)&&( m < 40))
      {
      // MI
      frequencyGlide.setValue(Mi4);
      noStroke();
      fill(278,100,81);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Mi",30,height-40);
      }
      
     if (m >= 40)
      {
      // SOL
      frequencyGlide.setValue(Sol4);
      noStroke();
      fill(0,100,100);
      rect(0, 0,width,height);
      fill(360,0,100);
      text("Sol",30,height-40);      
      } 

      
    //TECLA MENU 
    noStroke();
    fill(360,0,100);
    rect(10, 15,70, 10);
    rect(10, 35,70, 10);
    rect(10, 55,70, 10);
    
    if ((key == 'm') ||(key == 'M') ||(mouseX<80)&&(mouseY<80)&&(mousePressed))
      {
      stage = 1;
      key=0;
      } 
   
   }


  ////////////ESCALA PENTATONICA DE LA MULTICOLOR////////  
  
  if (stage == 5 )
   {
    int H = (int) map (valor, 0,limite, 0, 360);//map(valor, valor actual   inicial, valora actual final, valor objetivo inicial, valor objetivo final)
    text(H, 250, 760);
   
    noStroke();
    fill(H,100,50);
    rect((width/5)*0, 0,width/5, height);
  
    noStroke();
    fill(H,50,100);
    rect((width/5)*1, 0,width/5, height);
  
    noStroke();
    fill(H,100,100);
    rect((width/5)*2, 0,width/5, height);
  
    noStroke();
    fill(H,72,50);
    rect((width/5)*3, 0,width/5, height);
  
    noStroke();
    fill(H,100,80);
    rect((width/5)*4, 0,width/5, height); 
    
    int m = (int) map (valor, 0,limite, 0, 60);    
    if (m == 0)
      {
      // SILENCIO
      frequencyGlide.setValue(0);
      fill(360,0,100);
      text("Silencio",30,height-40);
      }

    if ((m > 0)&&( m < 10))
      {
      // LA
      frequencyGlide.setValue(La4);
      fill(360,0,100);
      text("La",30,height-40);
      }
  
    if ((m >= 10)&&( m < 20))
      {
      // DO
      frequencyGlide.setValue(Do4);
      fill(360,0,100);
      text("Do",30,height-40);
      }
 
    if ((m >= 20)&&( m < 30))
      {
      // RE
      frequencyGlide.setValue(Re4);
      fill(360,0,100);
      text("Re",30,height-40);
      }
    
    if ((m >= 30)&&( m < 40))
      {
      // MI
      frequencyGlide.setValue(Mi4);
      fill(360,0,100);
      text("Mi",30,height-40);
      }
      
     if (m >= 40)
      {
      // SOL
      frequencyGlide.setValue(Sol4);
      fill(360,0,100);
      text("Sol",30,height-40);      
      } 

    
    //TECLA MENU 
    noStroke();
    fill(360,0,100);
    rect(10, 15,70, 10);
    rect(10, 35,70, 10);
    rect(10, 55,70, 10);
    
    if ((key == 'm') ||(key == 'M') ||(mouseX<80)&&(mouseY<80)&&(mousePressed))
      {
      stage = 1;
      key=0;
      }      
   }
 
 
  ////////COLORES CALIDOS///////////////
   
  if (stage == 6 )
    {
    int H = (int) map (valor, 0,limite, -85, 65);//Escalamos la temperatura donde maximo sea 32ºC y   mínimo 15ºC. Convierte valores de un rango en otro--- map(valor, valor actual   inicial, valora actual final, valor objetivo inicial, valor objetivo final)

    if (H<0) 
      {
      H = 360-H;
      }
    noStroke();
    fill(H,100,100);
    rect(0, 0,width,height);  
      
    //TECLA MENU 
    noStroke();
    fill(360,0,100);
    rect(10, 15,70, 10);
    rect(10, 35,70, 10);
    rect(10, 55,70, 10);
    
    if ((key == 'm') ||(key == 'M') ||(mouseX<80)&&(mouseY<80)&&(mousePressed))
      {
      stage = 1;
      key=0;
      } 
      
    int m = (int) map (valor, 0,limite, 0, 80);

    if (m == 0)
      {
      // SILENCIO
      frequencyGlide.setValue(0);
      fill(360,0,100);
      text("Silencio",30,height-40);
      }

    if ((m > 0)&&( m < 10))
      {
      // DO
      frequencyGlide.setValue(Do4);
      fill(360,0,100);
      text("Do",30,height-40);
      }
  
    if ((m >= 10)&&( m < 20))
      {
      // RE
      frequencyGlide.setValue(Re4);
      fill(360,0,100);
      text("Re",30,height-40);
      }
 
    if ((m >= 20)&&( m < 30))
      {
      // MI
      frequencyGlide.setValue(Mi4);
      fill(360,0,100);
      text("Mi",30,height-40);
      }
    
    if ((m >= 30)&&( m < 40))
      {
      // Fa
      frequencyGlide.setValue(Fa4);
      fill(360,0,100);
      text("Fa",30,height-40);
      }
      
     if ((m >= 40)&&( m < 50))
      {
      // SOL
      frequencyGlide.setValue(Sol4);
      fill(360,0,100);
      text("Sol",30,height-40);      
      } 
      
     if ((m >= 50)&&( m < 60))
      {
      // LA
      frequencyGlide.setValue(La4);
      fill(360,0,100);
      text("La",30,height-40);      
      } 
      
     if ((m >= 60)&&( m < 70))
      {
      // SI
      frequencyGlide.setValue(Si4);
      fill(360,0,100);
      text("Si",30,height-40);      
      }
      
     if ((m >= 70))
      {
      // DO5
      frequencyGlide.setValue(Do5);
      fill(360,0,100);
      text("Do",30,height-40);      
      } 
 
  }
 
  
  /////////////COLORES FRIOS///////////   
  
  if (stage == 7 )
   {
    int H = (int) map (valor, 0,limite, 70, 260);//Escalamos la temperatura donde maximo sea 32ºC y   mínimo 15ºC. Convierte valores de un rango en otro--- map(valor, valor actual   inicial, valora actual final, valor objetivo inicial, valor objetivo final)


    noStroke();
    fill(H,100,100);
    rect(0, 0,width,height);  
      
    //TECLA MENU 
    noStroke();
    fill(360,0,100);
    rect(10, 15,70, 10);
    rect(10, 35,70, 10);
    rect(10, 55,70, 10);
    
    if ((key == 'm') ||(key == 'M') ||(mouseX<80)&&(mouseY<80)&&(mousePressed))
      {
      stage = 1;
      key=0;
      }      

    int m = (int) map (valor, 0,limite, 0, 80);

    if (m == 0)
      {
      // SILENCIO
      frequencyGlide.setValue(0);
      fill(360,0,100);
      text("Silencio",30,height-40);
      }

    if ((m > 0)&&( m < 10))
      {
      // DO
      frequencyGlide.setValue(Do4);
      fill(360,0,100);
      text("Do",30,height-40);
      }
  
    if ((m >= 10)&&( m < 20))
      {
      // RE
      frequencyGlide.setValue(Re4);
      fill(360,0,100);
      text("Re",30,height-40);
      }
 
    if ((m >= 20)&&( m < 30))
      {
      // MI
      frequencyGlide.setValue(Mi4);
      fill(360,0,100);
      text("Mi",30,height-40);
      }
    
    if ((m >= 30)&&( m < 40))
      {
      // Fa
      frequencyGlide.setValue(Fa4);
      fill(360,0,100);
      text("Fa",30,height-40);
      }
      
     if ((m >= 40)&&( m < 50))
      {
      // SOL
      frequencyGlide.setValue(Sol4);
      fill(360,0,100);
      text("Sol",30,height-40);      
      } 
      
     if ((m >= 50)&&( m < 60))
      {
      // LA
      frequencyGlide.setValue(La4);
      fill(360,0,100);
      text("La",30,height-40);      
      } 
      
     if ((m >= 60)&&( m < 70))
      {
      // SI
      frequencyGlide.setValue(Si4);
      fill(360,0,100);
      text("Si",30,height-40);      
      }
      
     if ((m >= 70))
      {
      // DO5
      frequencyGlide.setValue(Do5);
      fill(360,0,100);
      text("Do",30,height-40);      
      }    
   }
  
  
}  
  