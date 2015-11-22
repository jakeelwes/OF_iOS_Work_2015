#include "ofApp.h"
#include "Vehicle.h"


void ofApp::setup(){
    
    ofBackground(20);
    
    for(int i = 0; i < 300; i++){
        
        Vehicle line;
        line.x = ofRandom(ofGetWidth());
        line.y = ofRandom(ofGetHeight());
        line.maxSpeed = ofRandom(3,8);
        line.maxForce = ofRandom(0.2,0.8);
        
        lines.push_back(line);
    }
}

void ofApp::update(){
    for(std::size_t i = 0; i < lines.size(); i++){
        lines[i].update();
    }
}

void ofApp::draw(){
    
    ofBackgroundGradient(50, 10);
    
    
    for(std::size_t i = 0; i < lines.size(); i++){
        
//            lines[i].location = ofPoint(ofRandom(ofGetWidth()),ofRandom(ofGetHeight()));

        
        //          lines[i].maxSpeed += speed;
        //          lines[i].maxForce += force;
        lines[i].seek(ofPoint(ofGetMouseX(),ofGetMouseY()));
        lines[i].draw(ofGetMouseX(),ofGetMouseY());
    }
    
    drawLines();
}


void ofApp::drawLines() {
    float miminumLineDist = 30;
    
    for(std::size_t i = 0; i < lines.size(); i++){
        for(std::size_t j = 0; j < lines.size(); j++){
            float objDist = lines[i].location.distance(lines[j].location);
            if(objDist < miminumLineDist){
                float alpha = ofMap(objDist, 0, miminumLineDist, 255, 0);
                
                ofSetColor(255, alpha);
                
                ofDrawLine(lines[i].location, lines[j].location);
            }
        }
    }
}

