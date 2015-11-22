#pragma once

#include "ofxiOS.h"

class ofApp : public ofxiOSApp{
    
public:
    void setup();
    void update();
    void draw();
    void exit();
    
    void forceUpdate();
    void applyForce(ofPoint force);
    void seek(ofPoint target);
    
    ofPoint location, velocity, acceleration, desired;
    float speed, maxSpeed, maxForce;
    
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);
    
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    
    void gotMessage(ofMessage msg);
    
//    float px, py;
    
    float t;
    ofFloatColor averagedCol;
    ofVideoGrabber vidGrabber;
    
    ofPoint accel;
    ofImage img;

    

    
    
};
