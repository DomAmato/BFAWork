#include "OgreFramework.h"
#include "macUtils.h"

using namespace Ogre; 

namespace Ogre
{
    template<> OgreFramework* Ogre::Singleton<OgreFramework>::ms_Singleton = 0;
};

OgreFramework::OgreFramework()
: mRot180Z(Degree(180.f), Vector3::UNIT_Z)
{
    
	m_bShutDownOgre     = false;
	m_iNumScreenShots   = 0;
    
	m_pRoot				= 0;
	m_pSceneMgr			= 0;
	m_pRenderWnd        = 0;
	m_pCamera			= 0;
	m_pViewport			= 0;
	m_pLog				= 0;
	m_pTimer			= 0;
    m_pCameraNode         = 0;
	m_pObjectNode         = 0;
    m_pAnimState          = 0;
    m_pVidNode            = 0;
    

	m_pInputMgr			= 0;
	m_pKeyboard			= 0;
	m_pMouse			= 0;
    m_pCubeNode         = 0;
	m_pCubeEntity       = 0;
    
    ps                  = 0;
    
#if OGRE_PLATFORM == OGRE_PLATFORM_APPLE
    m_ResourcePath = macBundlePath() + "/Contents/Resources/";
#elif defined(OGRE_IS_IOS)
    m_ResourcePath = macBundlePath() + "/";
#else
    m_ResourcePath = "";
#endif
    m_pTrayMgr          = 0;
    m_FrameEvent        = Ogre::FrameEvent();
}

//|||||||||||||||||||||||||||||||||||||||||||||||
#if defined(OGRE_IS_IOS)
bool OgreFramework::initOgre(Ogre::String wndTitle, OIS::KeyListener *pKeyListener, OIS::MultiTouchListener *pMouseListener)
#else
bool OgreFramework::initOgre(Ogre::String wndTitle, OIS::KeyListener *pKeyListener, OIS::MouseListener *pMouseListener)
#endif
{
    //new Ogre::LogManager();

	//m_pLog = Og::LogManager::getSingleton().createLog("OgreLogfile.log", true, true, false);
	//m_pLog->setDebugOutputEnabled(true);
    
    String pluginsPath;
    // only use plugins.cfg if not static
#ifndef OGRE_STATIC_LIB
    pluginsPath = m_ResourcePath + "plugins.cfg";
#endif
    
    m_pRoot = new Ogre::Root(pluginsPath);//, Ogre::macBundlePath() + "/ogre.cfg");
    
#ifdef OGRE_STATIC_LIB
    m_StaticPluginLoader.load();
#endif
    
	if(!m_pRoot->showConfigDialog())
		return false;
	m_pLog = Ogre::LogManager::getSingleton().getDefaultLog();
    
    m_pRenderWnd = m_pRoot->initialise(true, wndTitle);
    
    
	unsigned long hWnd = 0;
    OIS::ParamList paramList;
    m_pRenderWnd->getCustomAttribute("WINDOW", &hWnd);
    
	paramList.insert(OIS::ParamList::value_type("WINDOW", Ogre::StringConverter::toString(hWnd)));
    
	m_pInputMgr = OIS::InputManager::createInputSystem(paramList);
    
#if !defined(OGRE_IS_IOS)
    m_pKeyboard = static_cast<OIS::Keyboard*>(m_pInputMgr->createInputObject(OIS::OISKeyboard, true));
	m_pMouse = static_cast<OIS::Mouse*>(m_pInputMgr->createInputObject(OIS::OISMouse, true));
    
	m_pMouse->getMouseState().height = m_pRenderWnd->getHeight();
	m_pMouse->getMouseState().width	 = m_pRenderWnd->getWidth();
#else
	m_pMouse = static_cast<OIS::MultiTouch*>(m_pInputMgr->createInputObject(OIS::OISMultiTouch, true));
#endif
    
#if !defined(OGRE_IS_IOS)
	if(pKeyListener == 0)
		m_pKeyboard->setEventCallback(this);
	else
		m_pKeyboard->setEventCallback(pKeyListener);
#endif
    
	if(pMouseListener == 0)
		m_pMouse->setEventCallback(this);
	else
		m_pMouse->setEventCallback(pMouseListener);
    
	Ogre::String secName, typeName, archName;
	Ogre::ConfigFile cf;
    cf.load(m_ResourcePath + "resources.cfg");
    
	Ogre::ConfigFile::SectionIterator seci = cf.getSectionIterator();
    while (seci.hasMoreElements())
    {
        secName = seci.peekNextKey();
		Ogre::ConfigFile::SettingsMultiMap *settings = seci.getNext();
        Ogre::ConfigFile::SettingsMultiMap::iterator i;
        for (i = settings->begin(); i != settings->end(); ++i)
        {
            typeName = i->first;
            archName = i->second;
#if OGRE_PLATFORM == OGRE_PLATFORM_APPLE || defined(OGRE_IS_IOS)
            // OS X does not set the working directory relative to the app,
            // In order to make things portable on OS X we need to provide
            // the loading with it's own bundle path location
            if (!Ogre::StringUtil::startsWith(archName, "/", false)) // only adjust relative dirs
                archName = Ogre::String(m_ResourcePath + archName);
#endif
            Ogre::ResourceGroupManager::getSingleton().addResourceLocation(archName, typeName, secName);
        }
    }
	Ogre::TextureManager::getSingleton().setDefaultNumMipmaps(5);
	Ogre::ResourceGroupManager::getSingleton().initialiseAllResourceGroups();
    
	m_pTimer = OGRE_NEW Ogre::Timer();
	m_pTimer->reset();
	
	m_pTrayMgr = new OgreBites::SdkTrayManager("TrayMgr", m_pRenderWnd, m_pMouse, this);
    m_pTrayMgr->showFrameStats(OgreBites::TL_BOTTOMLEFT);
    m_pTrayMgr->showLogo(OgreBites::TL_BOTTOMRIGHT);
    m_pTrayMgr->hideCursor();
    
    m_pRoot->renderOneFrame(Real (1.0f/60.0f));
    
    /***************************************
     Openframeworks Init
     **************************************/
    //For debugging
    ofLogVerbose();
    
    //need to set this to where your Openframeworks data folder is to find rescources
    ofSetDataPathRoot("/Users/DomMBP/Documents/OGRE/OgreTestApp/bin/data/");
    
    //width and height of webcam capture
    width = 640;
    height = 480;
	
	// Print the markers from the "AllBchThinMarkers.png" file in the data folder
	if(vidGrabber.initGrabber(width, height))
    {
       // #define CAMERA_CONNECTED
    } else {
        vidPlayer.loadMovie("marker.mov");
        vidPlayer.play();
    }
    vidMaterial.loadMovie("Introspection.m4v");
    vidMaterial.play();
    videoImage.allocate(vidMaterial.getWidth(), vidMaterial.getHeight());
    
	colorImage.allocate(width, height);
    grayImage.allocate(width, height);
    grayThres.allocate(width, height);
	
	// This uses the default camera calibration and marker file
	artk.setup(width, height);
    
    // The camera calibration file can be created using GML:
	// http://graphics.cs.msu.ru/en/science/research/calibration/cpp
	// and these instructions:
	// http://studierstube.icg.tu-graz.ac.at/doc/pdf/Stb_CamCal.pdf
	// This only needs to be done once and will aid with detection
	// for the specific camera you are using
	// Put that file in the data folder and then call setup like so:
	// artk.setup(width, height, "myCamParamFile.cal", "markerboard_480-499.cfg");
	
	// Set the threshold
	// ARTK+ does the thresholding for us
	// Uncomment to set your own threshold rather than having ARTK+ do it automatically
	threshold = 85;
	//artk.setThreshold(threshold);
    
    artk.activateAutoThreshold(true);
    
#ifdef CAMERA_CONNECTED
    mPixelBox = Ogre::PixelBox(width, height, 1, Ogre::PF_B8G8R8, vidGrabber.getPixels());
#else
    mPixelBox = Ogre::PixelBox(width, height, 1, Ogre::PF_B8G8R8, vidPlayer.getPixels());
#endif
    vPixelBox = Ogre::PixelBox(vidMaterial.getWidth(), vidMaterial.getHeight(), 1, Ogre::PF_B8G8R8, vidMaterial.getPixels());

    
    /////////////
    // Setup planes and camera
    ////////////
    
    createSceneManager();
	createViewport();
	createCamera();
	createScene();
    
    initTracking(width, height);
    createWebcamPlane(width, height, 45000.0f);
    createVideoPlane(vidMaterial.getWidth(), vidMaterial.getHeight(), 40000.0f);
    //////
    // Particle System
    //////
    ParticleSystem::setDefaultNonVisibleUpdateTimeout(5);  // set nonvisible timeout
    
    m_pRenderWnd->setActive(true);
    
    return true;
}

OgreFramework::~OgreFramework()
{
    vidMaterial.close();
    
	m_bShutDownOgre     = false;
	m_iNumScreenShots   = 0;
    
	m_pRoot             = 0;
	m_pSceneMgr			= 0;
	m_pRenderWnd        = 0;
	m_pCamera			= 0;
	m_pViewport			= 0;
	m_pLog				= 0;
	m_pTimer			= 0;
    m_pCameraNode         = 0;
	m_pObjectNode         = 0;
    m_pAnimState          = 0;
    m_pVidNode            = 0;
    
	m_pInputMgr			= 0;
	m_pKeyboard			= 0;
	m_pMouse			= 0;
    m_pCubeNode         = 0;
	m_pCubeEntity       = 0;
	
	if(m_pSceneMgr)
		m_pRoot->destroySceneManager(m_pSceneMgr);
	m_pSceneMgr = 0;
    
    if(m_pInputMgr) OIS::InputManager::destroyInputSystem(m_pInputMgr);
    if(m_pTrayMgr)  delete m_pTrayMgr;
#ifdef OGRE_STATIC_LIB
    m_StaticPluginLoader.unload();
#endif
    if(m_pRoot)     delete m_pRoot;
}

bool OgreFramework::keyPressed(const OIS::KeyEvent &keyEventRef)
{
#if !defined(OGRE_IS_IOS)
	
	if(m_pKeyboard->isKeyDown(OIS::KC_ESCAPE))
	{
        m_bShutDownOgre = true;
        return true;
	}
    
	if(m_pKeyboard->isKeyDown(OIS::KC_P))
	{
		m_pRenderWnd->writeContentsToTimestampedFile("BOF_Screenshot_", ".png");
		return true;
	}
    
	if(m_pKeyboard->isKeyDown(OIS::KC_M))
	{
		static int mode = 0;
		
		if(mode == 2)
		{
			m_pCamera->setPolygonMode(PM_SOLID);
			mode = 0;
		}
		else if(mode == 0)
		{
            m_pCamera->setPolygonMode(PM_WIREFRAME);
            mode = 1;
		}
		else if(mode == 1)
		{
			m_pCamera->setPolygonMode(PM_POINTS);
			mode = 2;
		}
	}
    
	if(m_pKeyboard->isKeyDown(OIS::KC_O))
	{
		if(m_pTrayMgr->isLogoVisible())
        {
            m_pTrayMgr->hideLogo();
            m_pTrayMgr->hideFrameStats();
        }
        else
        {
            m_pTrayMgr->showLogo(OgreBites::TL_BOTTOMRIGHT);
            m_pTrayMgr->showFrameStats(OgreBites::TL_BOTTOMLEFT);
        }
	}
    
#endif
	return true;
}

bool OgreFramework::keyReleased(const OIS::KeyEvent &keyEventRef)
{
	return true;
}

//|||||||||||||||||||||||||||||||||||||||||||||||

#if defined(OGRE_IS_IOS)
bool OgreFramework::touchMoved(const OIS::MultiTouchEvent &evt)
{
    OIS::MultiTouchState state = evt.state;
    int origTransX = 0, origTransY = 0;
#if !OGRE_NO_VIEWPORT_ORIENTATIONMODE
    switch(m_pCamera->getViewport()->getOrientationMode())
    {
        case Ogre::OR_LANDSCAPELEFT:
            origTransX = state.X.rel;
            origTransY = state.Y.rel;
            state.X.rel = -origTransY;
            state.Y.rel = origTransX;
            break;
            
        case Ogre::OR_LANDSCAPERIGHT:
            origTransX = state.X.rel;
            origTransY = state.Y.rel;
            state.X.rel = origTransY;
            state.Y.rel = origTransX;
            break;
            
            // Portrait doesn't need any change
        case Ogre::OR_PORTRAIT:
        default:
            break;
    }
#endif
	m_pCamera->yaw(Degree(state.X.rel * -0.1));
	m_pCamera->pitch(Degree(state.Y.rel * -0.1));
	
	return true;
}

//|||||||||||||||||||||||||||||||||||||||||||||||

bool OgreFramework::touchPressed(const OIS:: MultiTouchEvent &evt)
{
#pragma unused(evt)
	return true;
}

//|||||||||||||||||||||||||||||||||||||||||||||||

bool OgreFramework::touchReleased(const OIS:: MultiTouchEvent &evt)
{
#pragma unused(evt)
	return true;
}

bool OgreFramework::touchCancelled(const OIS:: MultiTouchEvent &evt)
{
#pragma unused(evt)
	return true;
}
#else
bool OgreFramework::mouseMoved(const OIS::MouseEvent &evt)
{	
	return true;
}

bool OgreFramework::mousePressed(const OIS::MouseEvent &evt, OIS::MouseButtonID id)
{
	return true;
}

bool OgreFramework::mouseReleased(const OIS::MouseEvent &evt, OIS::MouseButtonID id)
{
	return true;
}
#endif

void OgreFramework::updateOgre(double timeSinceLastFrame)
{

#if OGRE_VERSION >= 0x10800
    m_pSceneMgr->setSkyBoxEnabled(true);
#endif
    
///Openframeworks update//////	
    
#ifdef CAMERA_CONNECTED
	vidGrabber.grabFrame();
	bool bNewFrame = vidGrabber.isFrameNew();
#else
	vidPlayer.update();
	bool bNewFrame = vidPlayer.isFrameNew();
#endif
	
    vidMaterial.update();
    
	if(bNewFrame) {
		
#ifdef CAMERA_CONNECTED
		colorImage.setFromPixels(vidGrabber.getPixels(), width, height);
#else
		colorImage.setFromPixels(vidPlayer.getPixels(), width, height);
#endif
		videoImage.setFromPixels(vidMaterial.getPixels(), vidMaterial.getWidth(), vidMaterial.getHeight());
		// convert our camera image to grayscale
		grayImage = colorImage;
		// apply a threshold so we can see what is going on
		grayThres = grayImage;
		grayThres.threshold(threshold);
		
		// Pass in the new image pixels to artk
		artk.update(grayImage.getPixels());
        
        if (!mTexture.isNull())
		{
			HardwarePixelBufferSharedPtr pixelBuffer = mTexture->getBuffer();
			pixelBuffer->blitFromMemory(mPixelBox);
		}
        if (!vTexture.isNull())
		{
			HardwarePixelBufferSharedPtr pixelBuffer = vTexture->getBuffer();
			pixelBuffer->blitFromMemory(vPixelBox);
		}
        
        int myIndex = artk.getMarkerIndex(0);
        if(myIndex >= 0 && !markerDisplayed) {	
           convertPoseToOgreCoordinate(myIndex);
            m_pVidNode->setVisible(true);
            vidMaterial.setPaused(false);
            m_pCameraNode->setOrientation(getOrientation());
            m_pCameraNode->setPosition(getTranslation());
            markerDisplayed=true;
        } else {
            m_pVidNode->setVisible(false);
            vidMaterial.setPaused(true);

        }
        myIndex = artk.getMarkerIndex(1);
        if(myIndex >= 0 && !markerDisplayed) {	
            convertPoseToOgreCoordinate(myIndex);
            m_pParticleNode->setVisible(true);
            m_pCameraNode->setOrientation(getOrientation());
            m_pCameraNode->setPosition(getTranslation());
            markerDisplayed=true;
        } else {
            m_pParticleNode->setVisible(false);
        }
        myIndex = artk.getMarkerIndex(2);
        if(myIndex >= 0 && !markerDisplayed) {	
            convertPoseToOgreCoordinate(myIndex);
            m_pObjectNode->setVisible(true);
            m_pCameraNode->setOrientation(getOrientation());
            m_pCameraNode->setPosition(getTranslation());
            markerDisplayed=true;
        } else {
            m_pObjectNode->setVisible(false); 
        }
        if (m_pAnimState)
            m_pAnimState->addTime(timeSinceLastFrame);
        markerDisplayed=false;
    }
        
    m_FrameEvent.timeSinceLastFrame = timeSinceLastFrame;
    m_pTrayMgr->frameRenderingQueued(m_FrameEvent);
}

void OgreFramework::getInput()
{
#if !defined(OGRE_IS_IOS)
#endif
}

void OgreFramework::createSceneManager(void)
{
	m_pSceneMgr = m_pRoot->createSceneManager(ST_GENERIC, "SceneManager");
	m_pSceneMgr->setAmbientLight(Ogre::ColourValue(0.7f, 0.7f, 0.7f));
}

void OgreFramework::createViewport(void)
{
    m_pViewport = m_pRenderWnd->addViewport(0);
	m_pViewport->setBackgroundColour(ColourValue(0.8f, 0.7f, 0.6f, 1.0f));
}

void OgreFramework::createCamera(void)
{
    m_pCamera = m_pSceneMgr->createCamera("Camera");
	m_pCamera->setPosition(0, 0, 0); 
	m_pCamera->lookAt(0, 0, 1); 
	m_pCamera->setNearClipDistance(10);
    m_pCamera->setFarClipDistance(50000);
    m_pCamera->setAspectRatio(Real(m_pViewport->getActualWidth()) / Real(m_pViewport->getActualHeight()));
	m_pCamera->setFOVy(Degree(30.5)); //FOVy camera Ogre = 40∞
    m_pViewport->setCamera(m_pCamera);

	m_pCameraNode = m_pSceneMgr->getRootSceneNode()->createChildSceneNode("cameraNode");
	m_pCameraNode->setPosition(0, 1700, 0);
	m_pCameraNode->lookAt(Vector3(0, 1700, -1), Node::TS_WORLD);
	m_pCameraNode->attachObject(m_pCamera);
	m_pCameraNode->setFixedYawAxis(true, Vector3::UNIT_Y);
    
}

void OgreFramework::createScene(void)
{    
	m_pCubeEntity = m_pSceneMgr->createEntity("Cube", "Cube.mesh");
	m_pObjectNode = m_pSceneMgr->getRootSceneNode()->createChildSceneNode("cube");	
	m_pObjectNode->setOrientation(Quaternion(Degree(180.f), Vector3::UNIT_X));
	Ogre::Real scale = 22;
	m_pObjectNode->setPosition(0, 2, 35);
    m_pObjectNode->setScale(Ogre::Vector3::UNIT_SCALE*1.5);
	m_pObjectNode->attachObject(m_pCubeEntity);
    
    m_pAnimState = m_pCubeEntity->getAnimationState("my_animation");
	m_pAnimState->setLoop(true);
	m_pAnimState->setEnabled(true);
    
    // create particle
    ps = m_pSceneMgr->createParticleSystem("blue", "Fairy");
    ps->setKeepParticlesInLocalSpace(true);
    
    m_pParticleNode = m_pSceneMgr->getRootSceneNode()->createChildSceneNode("bparticle");	
	m_pParticleNode->setOrientation(Quaternion(Degree(90.f), Vector3::UNIT_X));
	m_pParticleNode->setPosition(0, 0, 10); 
    m_pParticleNode->setScale(Ogre::Vector3::UNIT_SCALE*.1);
    m_pParticleNode->attachObject(ps);
    
    
}
void OgreFramework::convertPoseToOgreCoordinate(int index) 
{
    
    // Set the matrix to the perspective of this marker
    // The origin is in the middle of the marker	
    Matrix4 invTrans = convert(artk.getMatrix(index)).inverseAffine(); //gets translation per index
    Vector3 invTransPosition = invTrans.getTrans();
    Quaternion invTransOrientation = invTrans.extractQuaternion();	
    invTransOrientation = invTransOrientation * mRot180Z;	
    
    mTranslation = invTransPosition;
    mOrientation = invTransOrientation;	
}
//does not work no ASE coordinates to be extracted
void OgreFramework::convertPoseToOgreCoordinate() 
{
    
    // Set the matrix to the perspective of this marker
    // The origin is in the middle of the marker	
    ofVec3f tempTrans;
    ofMatrix4x4 tempOrient;
    artk.getMultiMarkerTranslationAndOrientation(tempTrans, tempOrient);
    Matrix4 invTrans = convert(tempOrient, tempTrans);
    Vector3 invTransPosition = invTrans.getTrans();
    Quaternion invTransOrientation = invTrans.extractQuaternion();	
    invTransOrientation = invTransOrientation * mRot180Z;	
    
    mTranslation = invTransPosition;
    mOrientation = invTransOrientation;	
}

Ogre::Matrix4 OgreFramework::convert(ofMatrix4x4 _orient, ofVec3f _trans) const
{
	Ogre::Matrix4 m;
	for (int i = 0; i<4; i++)
		for (int j=0; j<4; j++)        
            m[i][j] = _orient.get(i,j);
    m[0][3] = _trans.x;
    m[1][3] = _trans.y;
    m[2][3] = _trans.z;
	return m;
}
Ogre::Matrix4 OgreFramework::convert(ofMatrix4x4 _orient) const
{
	Ogre::Matrix4 m;
	for (int i = 0; i<4; i++)
		for (int j=0; j<4; j++)        
            m[i][j] = _orient.get(i,j);
	return m;
}

Ogre::Vector3 OgreFramework::getTranslation() const
{
	return mTranslation;
}

Ogre::Quaternion OgreFramework::getOrientation() const
{
	return mOrientation;
}

void OgreFramework::createTexture(const std::string name)
{
	mTexture = TextureManager::getSingleton().createManual(
                                                           name, 
                                                           ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME, 
                                                           TEX_TYPE_2D, 
                                                           width, 
                                                           height, 
                                                           0,
                                                           PF_R8G8B8, 
                                                           TU_DYNAMIC_WRITE_ONLY_DISCARDABLE);
}
void OgreFramework::createVTexture(const std::string name, int vWidth, int vHeight)
{
	vTexture = TextureManager::getSingleton().createManual(
                                                      name, 
                                                      ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME, 
                                                      TEX_TYPE_2D, 
                                                      vWidth, 
                                                      vHeight, 
                                                      0,
                                                      PF_R8G8B8, 
                                                      TU_DYNAMIC_WRITE_ONLY_DISCARDABLE);
}

void OgreFramework::initTracking(int width, int height)
{
	
    createTexture("WebcamTexture");
    
    //Create Webcam Material
    MaterialPtr material = MaterialManager::getSingleton().create("WebcamMaterial", ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME);
    Ogre::Technique *technique = material->createTechnique();
    technique->createPass();
    material->getTechnique(0)->getPass(0)->setLightingEnabled(false);
    material->getTechnique(0)->getPass(0)->setDepthWriteEnabled(false);
    material->getTechnique(0)->getPass(0)->createTextureUnitState("WebcamTexture");

}

void OgreFramework::createWebcamPlane(int width, int height, Ogre::Real _distanceFromCamera)
{
	// Create a prefab plane dedicated to display video
	float videoAspectRatio = width / (float) height;
    //was 2.36 slightly off at edges of screen
	float planeHeight = 2.46 * _distanceFromCamera * Ogre::Math::Tan(Degree(26)*0.5); //FOVy webcam = 26∞ (intrinsic param)
	float planeWidth = planeHeight * videoAspectRatio;
    
	Plane p(Vector3::UNIT_Z, 0.0);
	MeshManager::getSingleton().createPlane("VerticalPlane", ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME, p , planeWidth, planeHeight, 1, 1, true, 1, 1, 1, Vector3::UNIT_Y);
	Entity* planeEntity = m_pSceneMgr->createEntity("VideoPlane", "VerticalPlane"); 
	planeEntity->setMaterialName("WebcamMaterial");
	planeEntity->setRenderQueueGroup(RENDER_QUEUE_WORLD_GEOMETRY_1);
    
	// Create a node for the plane, inserts it in the scene
	Ogre::SceneNode* node = m_pCameraNode->createChildSceneNode("planeNode");
	node->attachObject(planeEntity);
    
	// Update position    
	Vector3 planePos = m_pCamera->getPosition() + m_pCamera->getDirection() * _distanceFromCamera;
	node->setPosition(planePos);
    
	// Update orientation
	node->setOrientation(m_pCamera->getOrientation());
}

void OgreFramework::createVideoPlane(int width, int height, Ogre::Real _distanceFromCamera)
{
    
    createVTexture("VideoTexture", width, height);
    
    //Create Video Material
    MaterialPtr vmaterial = MaterialManager::getSingleton().create("VideoMaterial", ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME);
    Ogre::Technique *vtechnique = vmaterial->createTechnique();
    vtechnique->createPass();
    vmaterial->getTechnique(0)->getPass(0)->setLightingEnabled(false);
    vmaterial->getTechnique(0)->getPass(0)->setDepthWriteEnabled(false);
    vmaterial->getTechnique(0)->getPass(0)->createTextureUnitState("VideoTexture");
    
	// Create a prefab plane dedicated to display video
	//float videoAspectRatio = width / (float) height;

	float planeHeight = height;
	float planeWidth = width;
    
	Plane p2(Vector3::UNIT_Z, 0.0);
	MeshManager::getSingleton().createPlane("VidPlane", ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME, p2 , planeWidth, planeHeight, 1, 1, true, 1, 1, 1, Vector3::UNIT_Y);
	Entity* planeEntity = m_pSceneMgr->createEntity("Video", "VidPlane"); 
	planeEntity->setMaterialName("VideoMaterial");
	planeEntity->setRenderQueueGroup(RENDER_QUEUE_3);
    
	// Create a node for the plane, inserts it in the scene
	m_pVidNode = m_pSceneMgr->getRootSceneNode()->createChildSceneNode("vidPlaneNode");
	m_pVidNode->setPosition(0, 0, 5); 
    m_pVidNode->setScale(Ogre::Vector3::UNIT_SCALE*.1);
	m_pVidNode->attachObject(planeEntity);
    
}


/*using namespace std;
//////////Needs translating perhaps to deal with multiple markers on the screen
Marker::Marker()
{
	id = 0;
	trans = Ogre::Matrix4::IDENTITY;
}
Marker::Marker(const Ogre::Matrix4& _trans, int _id)
{
	id    = _id;
	trans = _trans;
}
const std::vector<int> TrackingSystem::getVisibleMarkersId() const
{
	std::vector<int> ids;
	
	int* markersIds;
	mTracker->getDetectedMarkers(markersIds);
	for (int i=0; i<mTracker->getNumDetectedMarkers(); ++i)
		ids.push_back(markersIds[i]);
    
	return ids;
}

const std::vector<Marker> TrackingSystem::getMarkersInfo() const
{
	std::vector<Marker> markers;
	const ARToolKitPlus::ARMultiMarkerInfoT* config = mTracker->getMultiMarkerConfig();
	for (int i=0; i<config->marker_num; ++i)
	{
		int id = config->marker[i].patt_id;
		Matrix4 trans = convert(config->marker[i].trans);
		markers.push_back(Marker(trans, id));
	}
    
	return markers;
}*/