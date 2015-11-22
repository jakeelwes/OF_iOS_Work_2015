#pragma once

#include "ofMain.h"


class Vehicle : public ofBaseApp{
public:
    Vehicle();
    void update();
    void applyForce(ofPoint force);
    void seek(ofPoint target);
    void repel();
    void draw(float mX, float mY);
    
    
    ofPoint location, velocity, acceleration, desired;
    float maxSpeed, maxForce, size, x, y;
    
};