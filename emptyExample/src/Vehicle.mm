#include "Vehicle.h"

Vehicle::Vehicle(){
    acceleration = ofPoint(0,0);
    velocity = ofPoint(0,0);
    location = ofPoint(x,y);
    size = 3;
    
    maxSpeed = 4;
    maxForce = 0.1;
}

void Vehicle::update(){ //Euler integration motion model
    velocity += acceleration;
    velocity.limit(maxSpeed);
    location += velocity;
    acceleration *= 0;
}

void Vehicle::applyForce(ofPoint force){
    acceleration += force;
}

void Vehicle::seek(ofPoint target){ //seek steering force algorithm
    desired = ofPoint(target - location);
    desired.getNormalized();
    desired * maxSpeed;
    
    ofPoint steer = ofPoint(desired - velocity);
    
    steer.limit(maxForce);
    applyForce(steer);
}

void Vehicle::repel(){
    desired *= -1;
}

void Vehicle::draw(float mX, float mY){
    //    float theta = velocity.angle;
    
    //    ofFill();
    //    ofSetColor(120);
    //    ofPushMatrix();
    //    ofTranslate(location.x, location.y);
    //    ofRotate(theta);
    //    ofBeginShape();
    //    ofVertex(0, -size*2);
    //    ofVertex(-size, size*2);
    //    ofVertex(size, size*2);
    //    ofEndShape();
    //    ofPopMatrix();
    
    ofFill();
    //    ofSetColor(255,30);
    //    ofLine(location.x, location.y, mX, mY);
    ofSetColor(255,180);
    ofCircle(location.x, location.y, 3);
}