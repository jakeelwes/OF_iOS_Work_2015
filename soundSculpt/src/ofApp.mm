#include "ofApp.h"

string drawTypeArray[] = {"Plane", "Circular","Spiral", "Curvy", "Spring", "Spire", "Disc", "Wavy Disc"};

void ofApp::setup() {
    ofSetWindowTitle("Sonic Sculpture - 's' to save - 'd' for debug");
    ofSetVerticalSync(true);
    ofSetFrameRate(60); ///lets only sample 30 times a second instead of 60 - too much data otherwise
    
    material.setShininess( 120 );
    // the light highlight of the material //
    material.setSpecularColor(ofColor(255, 255, 255, 255));
    ofSetSmoothLighting(true);
    
    light.setDiffuseColor( ofColor(0.f, 255.f, 0.f));
    
    light.setSpecularColor( ofColor(255.f, 255.f, 0.f));
    light.setPointLight();
    
    shapes.setup();
    
    mainGui.setup();
    mainGui.loadFont("Avenir Light.otf", 10);
    
    mainGui.add(shapes.getParameters());
    GUIvis = false;
    mainGui.minimizeAll();
    mainGui.loadFromFile("settings.xml");
    
}

void ofApp::update() {
    shapes.update();
    
}

void ofApp::draw() {
    
    ofBackgroundGradient(ofColor::white, ofColor(100));
    
    ofPushMatrix();
    ofSetColor(0);
    shapes.draw();
    ofPopMatrix();
    
    
    
    mainGui.draw();
    
    ofSetColor(255);
    //	string msg = ofToString((int) ofGetFrameRate()) + " fps";
    //	ofDrawBitmapString(msg, ofGetWidth() - 80, ofGetHeight() - 20);
    
    //Cursor showing bug right now..
    ofShowCursor();
    ofCircle(ofGetMouseX(), ofGetMouseY(), 3);
    
    
}

void ofApp::keyPressed(int key){
    if(key=='r'){
        shapes.reset();
    }
    //mesh.clear();
    if(key=='s'){
        shapes.saveToFile();
    }
    if(key=='p') shapes.setPauseMesh(!shapes.getPauseMesh());
    if(key=='d'){
        shapes.setShowDebug(!shapes.getShowDebug());
    };
    
    if(key=='h'){
        
        GUIvis = !GUIvis;
        if(GUIvis){
            mainGui.maximizeAll();
        } else {
            mainGui.minimizeAll();
        }
    };
    
    if (key=='j') {
        mainGui.saveToFile("settings.xml");
    }
    
    if (key=='l') {
        mainGui.loadFromFile("settings.xml");
    }
    
    if (key=='f') {
        ofToggleFullscreen();
    }
    
    if (key=='m') {
        shapes.bShowWireframe = !shapes.bShowWireframe;
    }
    
    
    if(key=='1'){
        //Pause Itunes from the app
        char tempor[255];
        sprintf(tempor, "osascript -e \'tell application \"iTunes\"\' -e \"pause\" -e \"end tell\"");
        //osascript -e 'tell application "iTunes"' -e "play" -e "end tell"
        system(tempor);
    }
    if(key=='2'){
        //Press play on itunes from the app
        char tempor[255];
        sprintf(tempor, "osascript -e \'tell application \"iTunes\"\' -e \"play\" -e \"end tell\"");
        system(tempor);
    }
    
}





