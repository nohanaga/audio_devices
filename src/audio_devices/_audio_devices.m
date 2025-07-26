// _audio_devices.m
#include <Python.h>
#include <CoreAudio/CoreAudio.h>
#include <AudioToolbox/AudioServices.h>

static PyObject* list_device_uids(PyObject* self, PyObject* args) {
    UInt32 propsize;
    AudioObjectPropertyAddress prop = {
        kAudioHardwarePropertyDevices,
        kAudioObjectPropertyScopeGlobal,
        kAudioObjectPropertyElementMaster
    };
    AudioObjectID *audioDevices;
    UInt32 deviceCount;

    AudioObjectGetPropertyDataSize(kAudioObjectSystemObject, &prop, 0, NULL, &propsize);
    deviceCount = propsize / sizeof(AudioObjectID);
    audioDevices = malloc(propsize);
    AudioObjectGetPropertyData(kAudioObjectSystemObject, &prop, 0, NULL, &propsize, audioDevices);

    PyObject *uids = PyList_New(0);
    for (UInt32 i = 0; i < deviceCount; ++i) {
        CFStringRef uid = NULL;
        UInt32 uidSize = sizeof(uid);
        AudioObjectPropertyAddress prop_uid = {
            kAudioDevicePropertyDeviceUID,
            kAudioObjectPropertyScopeGlobal,
            kAudioObjectPropertyElementMaster
        };
        if (AudioObjectGetPropertyData(audioDevices[i], &prop_uid, 0, NULL, &uidSize, &uid) == noErr && uid) {
            char buf[256];
            if (CFStringGetCString(uid, buf, sizeof(buf), kCFStringEncodingUTF8)) {
                PyList_Append(uids, PyUnicode_FromString(buf));
            }
            CFRelease(uid);
        }
    }
    free(audioDevices);
    return uids;
}

static PyMethodDef methods[] = {
    {"list_device_uids", list_device_uids, METH_NOARGS, "List audio device UIDs (macOS)"},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef moddef = {
    PyModuleDef_HEAD_INIT, "_audio_devices", NULL, -1, methods
};

PyMODINIT_FUNC PyInit__audio_devices(void) {
    return PyModule_Create(&moddef);
}
