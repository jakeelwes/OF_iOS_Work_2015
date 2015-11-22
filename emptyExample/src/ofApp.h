#pragma once

#include "ofxiOS.h"
#include "Vehicle.h"


class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void drawLines();

    
    std::vector<Vehicle> lines;

};


