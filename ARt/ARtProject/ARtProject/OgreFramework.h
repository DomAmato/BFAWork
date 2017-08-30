//|||||||||||||||||||||||||||||||||||||||||||||||

#ifndef OGRE_FRAMEWORK_H
#define OGRE_FRAMEWORK_H

//|||||||||||||||||||||||||||||||||||||||||||||||



#include "ofxOpenCv.h"
#include "ofxARToolkitPlus.h"


#include <OgreCamera.h>
#include <OgreEntity.h>
#include <OgreLogManager.h>
#include <OgreOverlay.h>
#include <OgreOverlayElement.h>
#include <OgreOverlayManager.h>
#include <OgreRoot.h>
#include <OgreViewport.h>
#include <OgreSceneManager.h>
#include <OgreRenderWindow.h>
#include <OgreConfigFile.h>

#include <OISEvents.h>
#include <OISInputManager.h>
#include <OISKeyboard.h>
#include <OISMouse.h>


#ifdef OGRE_STATIC_LIB
#  define OGRE_STATIC_GL
#  if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
#    define OGRE_STATIC_Direct3D9
// dx10 will only work on vista, so be careful about statically linking
#    if OGRE_USE_D3D10
#      define OGRE_STATIC_Direct3D10
#    endif
#  endif
#  define OGRE_STATIC_CgProgramManager
#  ifdef OGRE_USE_PCZ
#    define OGRE_STATIC_PCZSceneManager
#    define OGRE_STATIC_OctreeZone
#  endif
#  if OGRE_VERSION >= 0x10800
#    if OGRE_PLATFORM == OGRE_PLATFORM_APPLE_IOS
#      define OGRE_IS_IOS 1
#    endif
#  else
#    if OGRE_PLATFORM == OGRE_PLATFORM_IPHONE
#      define OGRE_IS_IOS 1
#    endif
#  endif
#  ifdef OGRE_IS_IOS
#    undef OGRE_STATIC_CgProgramManager
#    undef OGRE_STATIC_GL
#    define OGRE_STATIC_GLES 1
#    ifdef OGRE_USE_GLES2
#      define OGRE_STATIC_GLES2 1
#      define USE_RTSHADER_SYSTEM
#      undef OGRE_STATIC_GLES
#    endif
#    ifdef __OBJC__
#      import <UIKit/UIKit.h>
#    endif
#  endif
#  include "OgreStaticPluginLoader.h"
#endif

#ifdef OGRE_IS_IOS
#   include <OISMultiTouch.h>
#endif

#include <SdkTrays.h>

//|||||||||||||||||||||||||||||||||||||||||||||||
/*struct Marker
{
	Marker();
	Marker(const Ogre::Matrix4& _trans, int _id);
    
	int id;
	Ogre::Matrix4 trans;
};*/

#ifdef OGRE_IS_IOS
class OgreFramework : public Ogre::Singleton<OgreFramework>, OIS::KeyListener, OIS::MultiTouchListener, OgreBites::SdkTrayListener
#else
class OgreFramework : public Ogre::Singleton<OgreFramework>, OIS::KeyListener, OIS::MouseListener, OgreBites::SdkTrayListener
#endif
{
public:
	OgreFramework();
	~OgreFramework();
    
 //   const std::vector<Marker> getMarkersInfo() const;
 //   const std::vector<int>    getVisibleMarkersId() const;
    
#ifdef OGRE_IS_IOS
    bool initOgre(Ogre::String wndTitle, OIS::KeyListener *pKeyListener = 0, OIS::MultiTouchListener *pMouseListener = 0);
#else
	bool initOgre(Ogre::String wndTitle, OIS::KeyListener *pKeyListener = 0, OIS::MouseListener *pMouseListener = 0);
#endif
	void updateOgre(double timeSinceLastFrame);
	void getInput();
    
	bool isOgreToBeShutDown()const{return m_bShutDownOgre;}
    
	bool keyPressed(const OIS::KeyEvent &keyEventRef);
	bool keyReleased(const OIS::KeyEvent &keyEventRef);
    
    void createSceneManager(void);
	void createViewport(void);
	void createCamera(void);
	void createScene(void);
    void initTracking(int width, int height);
	void createWebcamPlane(int width, int height, Ogre::Real _distanceFromCamera);
    void createVideoPlane(int width, int height, Ogre::Real _distanceFromCamera);
    
#ifdef OGRE_IS_IOS
	bool touchMoved(const OIS::MultiTouchEvent &evt);
	bool touchPressed(const OIS::MultiTouchEvent &evt); 
	bool touchReleased(const OIS::MultiTouchEvent &evt);
	bool touchCancelled(const OIS::MultiTouchEvent &evt);
#else
	bool mouseMoved(const OIS::MouseEvent &evt);
	bool mousePressed(const OIS::MouseEvent &evt, OIS::MouseButtonID id); 
	bool mouseReleased(const OIS::MouseEvent &evt, OIS::MouseButtonID id);
#endif
	
	Ogre::Root*                 m_pRoot;
	Ogre::SceneManager*			m_pSceneMgr;
	Ogre::RenderWindow*			m_pRenderWnd;
	Ogre::Camera*				m_pCamera;
	Ogre::Viewport*				m_pViewport;
	Ogre::Log*                  m_pLog;
	Ogre::Timer*				m_pTimer;
    Ogre::SceneNode*            m_pCameraNode;
    Ogre::SceneNode*            m_pVidNode;
	Ogre::SceneNode*            m_pObjectNode;
    Ogre::SceneNode*            m_pParticleNode;
	Ogre::AnimationState*       m_pAnimState;
	Ogre::SceneNode*			m_pCubeNode;
	Ogre::Entity*				m_pCubeEntity;
    
    Ogre::TexturePtr            mTexture;
    Ogre::TexturePtr            vTexture;
    Ogre::PixelBox              mPixelBox;
    Ogre::PixelBox              vPixelBox;
    Ogre::ParticleSystem*       ps;
	OIS::InputManager*			m_pInputMgr;
	OIS::Keyboard*				m_pKeyboard;
#ifdef OGRE_IS_IOS
	OIS::MultiTouch*			m_pMouse;
#else
	OIS::Mouse*					m_pMouse;
#endif

protected:
   // Added for Mac compatibility
   Ogre::String                 m_ResourcePath;
    
private:
	OgreFramework(const OgreFramework&);
	OgreFramework& operator= (const OgreFramework&);
    
	OgreBites::SdkTrayManager*  m_pTrayMgr;
    Ogre::FrameEvent            m_FrameEvent;
	int                         m_iNumScreenShots;
    
	bool                        m_bShutDownOgre;
    bool                        markerDisplayed;
    
#ifdef OGRE_STATIC_LIB
    Ogre::StaticPluginLoader    m_StaticPluginLoader;
#endif
    /* Size of the image */
    int width, height;
	
    /* Use either camera or a video file */
    ofVideoGrabber vidGrabber;
    ofVideoPlayer vidPlayer;
    ofVideoPlayer vidMaterial;
    
    /* ARToolKitPlus class */	
    ofxARToolkitPlus artk;	
    int threshold;
	
    /* OpenCV images */
    ofxCvColorImage colorImage;
    ofxCvGrayscaleImage grayImage;
    ofxCvGrayscaleImage	grayThres;
    ofxCvColorImage videoImage;
	
    Ogre::Quaternion mRot180Z;
    
    Ogre::Vector3 getTranslation() const;
    Ogre::Quaternion getOrientation() const;
        
    Ogre::Vector3     mTranslation;
    Ogre::Quaternion  mOrientation;
    
    void convertPoseToOgreCoordinate(int index);
    void convertPoseToOgreCoordinate();		
    Ogre::Matrix4 convert(ofMatrix4x4 _orient, ofVec3f _trans) const;
    Ogre::Matrix4 convert(ofMatrix4x4 _orient) const;
    
    void createTexture(const std::string name);
    void createVTexture(const std::string name, int vWidth, int vHeight);
    
};

//|||||||||||||||||||||||||||||||||||||||||||||||

#endif 

//|||||||||||||||||||||||||||||||||||||||||||||||
