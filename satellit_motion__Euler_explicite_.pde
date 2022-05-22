float ti=0;
float M=500000;
float g=0.01;
float x1=-150;
float x2=400 ;
float v1=0;
float v2=-4;

float x3=-150;
float x4=400 ;
float v3=0;
float v4=-4;

float h=0.1;

PGraphics canvas;
float px1=-1;
float py2=-1;
float px3=-1;
float py4=-1;

void setup(){
 size(1000,1000); 
canvas = createGraphics(1000,1000);
}

void draw(){
 //background(255);
 image(canvas,0,0);
 stroke(0);
 strokeWeight(1); 
 translate(500,500); 
 fill(255, 127,0);
 circle(0,0,50);
 fill(0,400,0);
 stroke(0);
 strokeWeight(0); 
 circle(x1,x2,6);
 fill(400,0,0);
 circle(x3,x4,6);
         float y1=x1;
         float y2=x2;
        x1=x1+h*v1;
        x2=x2+h*v2;
        v1=v1-g*M*h*y1/pow(dist(0,0,y1, y2),3);
        v2=v2-g*M*h*y2/pow(dist(0,0,y1, y2),3);
        
        float y3=x3;
        float y4=x4;
        x3=x3/(1+g*M*h*h/pow(dist(0,0,y3,y4),3)) + v3*h/((1+g*M*h*h/pow(dist(0,0,y3,y4),3)));
        x4=x4/(1+g*M*h*h/pow(dist(0,0,y3,y4),3)) + v4*h/((1+g*M*h*h/pow(dist(0,0,y3,y4),3)));
        v3=-y3*(g*M*h/pow(dist(0,0,y3,y4),3))/(1+g*M*h*h/(pow(dist(0,0,y3,y4),3))) + v3/(1+g*M*h*h/(pow(dist(0,0,y3,y4),3)));
        v4=-y4*(g*M*h/pow(dist(0,0,y3,y4),3))/(1+g*M*h*h/(pow(dist(0,0,y3,y4),3))) + v4/(1+g*M*h*h/(pow(dist(0,0,y3,y4),3)));

 canvas.beginDraw(); 
 canvas.translate(500,500);
 canvas.strokeWeight(0);
 canvas.stroke(0);
 if (frameCount>1){
 canvas.line(px1, py2, x1,x2);
 canvas.line(px3, py4, x3,x4);}
 canvas.endDraw();
 
 px1=x1;
 py2=x2;
 px3=x3;
 py4=x4;
 }
