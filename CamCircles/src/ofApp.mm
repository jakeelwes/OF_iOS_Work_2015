#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){	

    vidGrabber.setup(480, 360);
    vidGrabber.setVerbose(true);

    
    ofSetBackgroundColor(255);
    ofSetVerticalSync(true);
    ofSetCircleResolution(200);
    
    vidWidth = vidGrabber.getWidth();
    vidHeight = vidGrabber.getHeight();
    
    pixelCount = vidHeight*vidWidth;

    
    pixelTarget = pixelCount/2 + vidWidth/2;


}

//--------------------------------------------------------------
void ofApp::update(){
    
    vidGrabber.update();

    averagedCol = vidGrabber.getPixels().getColor(vidGrabber.getWidth() / 2, vidGrabber.getHeight() / 2);
    
    cout << averagedCol << endl;
    
//    averagedCol = ofFloatColor((vidGrabber.getPixels()[pixelTarget*3-3]/255.f
//                                + vidGrabber.getPixels()[pixelTarget*3]/255.f
//                                + vidGrabber.getPixels()[pixelTarget*3+3]/255.f) /3,
//                               (vidGrabber.getPixels()[pixelTarget*3-3+1]/255.f
//                                + vidGrabber.getPixels()[pixelTarget*3+1]/255.f
//                                + vidGrabber.getPixels()[pixelTarget*3+3+1]/255.f) /3,
//                               (vidGrabber.getPixels()[pixelTarget*3-3+2]/255.f
//                                + vidGrabber.getPixels()[pixelTarget*3+2]/255.f
//                                + vidGrabber.getPixels()[pixelTarget*3+3+2]/255.f) /3);
}

//--------------------------------------------------------------
void ofApp::draw(){
	
    time += 0.5;

    
    ofSetBackgroundAuto( false );

    
    ofSetColor(averagedCol);
    
    ofNoFill();
    ofDrawCircle(ofGetWidth()/2, ofGetHeight()/2, time);
    if(time>sqrt(pow(ofGetHeight()/2,2) + pow(ofGetWidth()/2,2))){
        time = 0;
    }
}

//--------------------------------------------------------------
void ofApp::exit(){

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
