#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(averagedCol);
    ofSetCircleResolution(80);
    ofSetLogLevel(OF_LOG_VERBOSE);
    
    // initialize the accelerometer
    ofxAccelerometer.setup();
    
    
    acceleration = ofPoint(0,0);
    velocity = ofPoint(0,0);
    location = ofPoint(ofGetWidth()/2, ofGetHeight()/2);

    maxSpeed = 4;
    maxForce = 1;
    
    vidGrabber.setup(480, 360);
    vidGrabber.setVerbose(true);
    
//    ofBeginSaveScreenAsPDF("screenshot-"+ofGetTimestampString()+".pdf", false);

}


//--------------------------------------------------------------
void ofApp::update() {
    
    vidGrabber.update();
    
    averagedCol = vidGrabber.getPixels().getColor(vidGrabber.getWidth() / 2, vidGrabber.getHeight() / 2);
    
    forceUpdate();
//    ofLog(OF_LOG_VERBOSE, "x = %f, y = %f", ofxAccelerometer.getForce().x, ofxAccelerometer.getForce().y);
}

//--------------------------------------------------------------
void ofApp::draw() {
    
//    t += 0.05;
//    float mapR = ofMap(ofNoise(t),1,0,0,255);
//    float mapB = ofMap(ofNoise(t+1000),1,0,0,100);

    ofSetBackgroundAuto( false );
    
    ofSetColor(averagedCol);
    
//    float angle = 180 - RAD_TO_DEG * atan2( ofxAccelerometer.getForce().y, ofxAccelerometer.getForce().x );
    
    seek(ofPoint(ofGetMouseX(),ofGetMouseY()));
    
//    ofPushMatrix();
//    ofRotate(90, 1,0,0);
//    float accelx = ofxAccelerometer.getForce().x;
//    ofPopMatrix();
    
    accel = ofPoint( ofxAccelerometer.getForce().x, ofxAccelerometer.getForce().y);
    
    location += 20* accel;
    speed = sqrt(velocity.x*velocity.x + velocity.y*velocity.y + 20*accel.x * 20*accel.x + 20*accel.y * 20*accel.y);

    
    
    ofDrawCircle(location, 30-speed*2);
    
    cout<<speed<<endl;
    
//    ofDrawLine(px, py, x, y);
    
    
//    x = px;
//    y = py;
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
    ofSetColor(averagedCol);
    ofDrawRectangle(0,0, ofGetWidth(), ofGetHeight());
    
    ofxiPhoneScreenGrab(NULL);
    img.saveImage(ofxiPhoneGetDocumentsDirectory() + "test.png");
    
    
    
//    file.open(ofxiPhoneGetDocumentsDirectory() + "myfile.txt", ofFile::WriteOnly, true);
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

