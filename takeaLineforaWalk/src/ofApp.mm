#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(averagedCol);
    ofSetCircleResolution(80);
//    ofSetLogLevel(OF_LOG_VERBOSE);
    
    // initialize the accelerometer
    ofxAccelerometer.setup();
    ofEnableAlphaBlending();
    
    
    acceleration = ofPoint(0,0);
    velocity = ofPoint(0,0);
    location = ofPoint(ofGetWidth()/2, ofGetHeight()/2);

    maxSpeed = 4;
    maxForce = 1;
    
    vidGrabber.setup(480, 360);
//    vidGrabber.setVerbose(true);
    
    int width = ofGetWidth();
    int height = ofGetHeight();
    
    fbo.allocate(width*2, height*2);
//    fbo.clear(0, 0, 0, 1);
    
//    pixels = new unsigned char[width*height*3];
    
//    imgSaver.allocate(width*2, height*2, OF_IMAGE_COLOR);
//    imgSaver.setUseTexture(false);

}


//--------------------------------------------------------------
void ofApp::update() {
    
    vidGrabber.update();
    
    averagedCol = vidGrabber.getPixels().getColor(vidGrabber.getWidth() / 2,
                                                  vidGrabber.getHeight() / 2);
    
    forceUpdate();
//    ofLog(OF_LOG_VERBOSE, "x = %f, y = %f", ofxAccelerometer.getForce().x, ofxAccelerometer.getForce().y);
    
    float way = 30;
    
//    collision
    if(location.x >= ofGetWidth()*2+way){
        location.x = ofGetWidth()*2+way;
    }
    if(location.x <= 0-way){
        location.x = 0-way;
    }
    if(location.y >= ofGetHeight()*2+way){
        location.y = ofGetHeight()*2+way;
    }
    if(location.y <= 0-way){
        location.y = 0-way;
    }
    
}

//--------------------------------------------------------------
void ofApp::draw() {

    fbo.begin();
    
    if(noBG && ofGetFrameNum()>10){
        ofSetColor(averagedCol);
        ofDrawRectangle(0,0, ofGetWidth()*2, ofGetHeight()*2);
        noBG = false;
    }
    
//    ofSetBackgroundAuto( false );
    

    seek(ofPoint(ofGetMouseX()*2,ofGetMouseY()*2));
    
    accel = ofPoint( ofxAccelerometer.getForce().x, -ofxAccelerometer.getForce().y);
    
    

    location += 20* accel;
    
    speed = ofClamp(
                sqrt(velocity.x*velocity.x
                     + velocity.y*velocity.y
                     + 20*accel.x * 20*accel.x
                     + 20*accel.y * 20*accel.y),
                  0, 10);

    
    ofSetColor(ofColor(averagedCol, 255));
    ofDrawCircle(location, (25-speed*2)*4);
    
//    ofSetColor(ofColor(averagedCol, 15-speed));
//    ofDrawCircle(location, (10+speed*6)*4);
//    
//    ofSetColor(ofColor(averagedCol, 1+speed/2));
//    ofDrawCircle(location, (500-speed*100)*4);

    fbo.end();
    
    fbo.draw(0,0, ofGetWidth(), ofGetHeight());

    
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

void ofApp::forceUpdate(){
    velocity += acceleration;
    velocity.limit(maxSpeed);
    location += velocity;
    acceleration *= 0;
    
}

void ofApp::applyForce(ofPoint force){
    acceleration += force;
}

void ofApp::seek(ofPoint target){ //seek steering force algorithm
    desired = ofPoint(target - location);
    desired.getNormalized();
    desired * maxSpeed;
    
    ofPoint steer = ofPoint(desired - velocity);
    
    steer.limit(maxForce);
    applyForce(steer);
}


//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
//    keyboard = new ofxiOSKeyboard(2,40,320,32);
//    keyboard->setVisible(false);
//    keyboard->setBgColor(255, 255, 255, 255);
//    keyboard->setFontColor(0,0,0, 255);
//    keyboard->setFontSize(26);
//    
//    ofSetColor(0, 255);
//    ofSetColor(20, 160, 240, 255);
//    ofDrawBitmapString("Name: "+  keyboard->getText() , 2, 100);
//    keyboard->setVisible(true);

    
//    save = true;
    
    ofPixels pixels;
    fbo.readToPixels(pixels);
    
    ofSaveImage(pixels, ofxiOSGetDocumentsDirectory() + "image"+ofGetTimestampString(" %d:%m:%y %H.%M.%S") + ".png");
    
    fbo.clear();
    
    fbo.begin();

    ofSetColor(averagedCol);
    ofDrawRectangle(0,0, ofGetWidth()*2, ofGetHeight()*2);
    
    fbo.end();
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){
}

