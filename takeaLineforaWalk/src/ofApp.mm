#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(averagedCol);
    ofSetCircleResolution(80);
//    ofSetLogLevel(OF_LOG_VERBOSE);
    
    // initialize the accelerometer
    ofxAccelerometer.setup();
    ofEnableAlphaBlending();
    
    font.load("Avenir Book.otf", 26);
    
    
    acceleration = ofPoint(0,0);
    velocity = ofPoint(0,0);
    location = ofPoint(ofGetWidth(), ofGetHeight());

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
    
  if(!pause) {


    fbo.begin();
      
      if(noBG && ofGetFrameNum()>10){
          ofSetColor(averagedCol);
          ofDrawRectangle(0,0, ofGetWidth()*2, ofGetHeight()*2);
          noBG = false;
      }
      ofSetBackgroundAuto(false);

    
//    ofSetBackgroundAuto( false );
    

    seek(ofPoint(ofGetMouseX()*2,ofGetMouseY()*2));
    
    accel = ofPoint( ofxAccelerometer.getForce().x, -ofxAccelerometer.getForce().y);
    
    

    location += 20* accel;
    
    speed = ofClamp(
                sqrt(velocity.x*velocity.x
                     + velocity.y*velocity.y
                     + 20*accel.x * 20*accel.x
                     + 20*accel.y * 20*accel.y),
                  0, 35);
      

    if(ofGetFrameNum()>10){
        ofSetColor(ofColor(averagedCol, 255));
        ofDrawCircle(location, ofClamp((20-speed*1.3), 1, 20)*4);
        
        ofSetColor(ofColor(averagedCol, ofClamp((2+speed/2),0,15)));
        ofDrawCircle(location, (10+speed*2)*4);
        
        ofSetColor(ofColor(averagedCol, ofMap(speed/3, 0, 35, 0, 15)));
        ofDrawCircle(location, (400-speed*10)*4);
    }
      
      cout<<speed<<endl;
    


        fbo.end();
      
      ofSetColor(255,255,255);
        fbo.draw(0,0, ofGetWidth(), ofGetHeight());
  }
    
    if(dtap && ofGetMousePressed() && ofGetMouseY() > 300 && ofGetMouseY() < 600){
        
        if(ofGetMouseY() < 450){
            if(ofGetMouseX()<ofGetWidth()/2){
                pause = false;
                keyboard->setVisible(false);
                fbo.draw(0,0, ofGetWidth(), ofGetHeight());
            } else {
                pause = false;
                keyboard->setVisible(false);
                noBG = true;
            }
        } else {
            saveImg();
            pause = false;
            keyboard->setVisible(false);
            noBG = true;
        }
        

    }
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
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
    dtap = true;
    
    pause = true;
    
    keyboard = new ofxiOSKeyboard(2,40,320,32);
    keyboard->setVisible(true);
    keyboard->openKeyboard();
    keyboard->setBgColor(255, 255, 255, 150);
    keyboard->setFontColor(50,50,50, 255);
    keyboard->setFontSize(26);
    
    ofSetColor(0, 60);
    ofDrawRectangle(0, 0, ofGetWidth(), 60);

    ofSetColor(255, 255);
    font.drawString("Title of image to save", 2, 45);
    
    ofSetColor(0, 60);
    ofDrawRectangle(0, 340, ofGetWidth(), 180);
    ofSetColor(255, 255);
    font.drawString("Save", 50, 500);
    font.drawString("Clear", ofGetWidth()-180, 380);
    font.drawString("Continue", 50, 380);

    
//    save = true;
    
//    cout<<keyboard->isKeyboardShowing()<<endl;
    
}

void ofApp::saveImg(){
    ofPixels pixels;
//    pixels.setNumChannels(3);
    fbo.readToPixels(pixels);
    
    cout<<pixels.getNumChannels()<<endl;
    
    ofSaveImage(pixels, ofxiOSGetDocumentsDirectory() + keyboard->getText()+ofGetTimestampString(" %d:%m:%y %H.%M.%S") + ".png");
    
//    save = false;
    dtap = false;
}


