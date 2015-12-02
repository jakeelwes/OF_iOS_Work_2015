#pragma once

#include "ofxiOS.h"
#include "ofxiOSKeyboard.h"
#include <time.h>



class ofApp : public ofxiOSApp{
    
public:
    void setup();
    void update();
    void draw();
    void exit();
    
    void forceUpdate();
    void applyForce(ofPoint force);
    void seek(ofPoint target);
    
    void touchDoubleTap(ofTouchEventArgs & touch);
    void saveImg();
    
    
    ofPoint location, velocity, acceleration, desired;
    float speed, maxSpeed, maxForce;

    
//    float px, py;
    
    float t;
    ofFloatColor averagedCol;
    ofVideoGrabber vidGrabber;
        
    ofPoint accel;
    
//    bool save = false;
    bool noBG = true;
    bool pause = false;
    bool dtap = false;
    
    ofFbo fbo;
//    unsigned char* pixels;
//    ofImage imgSaver;
    
    ofxiOSKeyboard * keyboard;
    ofTrueTypeFont font;
};
