#pragma once

#include "ofxiOS.h"
#include "ofxProcessFFT.h"
#include "ofxGui.h"
#include "fftShapes.h"


class ofApp : public ofxiOSApp{
public:
    void setup();
    void update();
    void draw();
    void keyPressed(int key);
    
    fftShapes shapes;
    
    int timePos;
    
    ofEasyCam easyCam;
    ofLight light;
    ofMaterial material;
    
    ofxPanel mainGui;
    
    bool GUIvis;
    
    
};
