// _audio_devices.cpp
#include <Python.h>
#include <mmdeviceapi.h>
#include <functiondiscoverykeys_devpkey.h>
#include <atlbase.h>

static PyObject* list_device_ids(PyObject* self, PyObject* args) {
    PyObject* devices = PyList_New(0);
    HRESULT hr = CoInitialize(NULL);
    if (FAILED(hr)) return devices;

    CComPtr<IMMDeviceEnumerator> pEnum;
    hr = CoCreateInstance(__uuidof(MMDeviceEnumerator), NULL, CLSCTX_ALL, IID_PPV_ARGS(&pEnum));
    if (FAILED(hr)) {
        CoUninitialize();
        return devices;
    }

    CComPtr<IMMDeviceCollection> pColl;
    hr = pEnum->EnumAudioEndpoints(eCapture, DEVICE_STATE_ACTIVE, &pColl);
    if (SUCCEEDED(hr)) {
        UINT count = 0;
        pColl->GetCount(&count);
        for (UINT i = 0; i < count; ++i) {
            CComPtr<IMMDevice> pDevice;
            if (SUCCEEDED(pColl->Item(i, &pDevice))) {
                LPWSTR id = NULL;
                if (SUCCEEDED(pDevice->GetId(&id))) {
                    PyList_Append(devices, PyUnicode_FromWideChar(id, wcslen(id)));
                    CoTaskMemFree(id);
                }
            }
        }
    }
    CoUninitialize();
    return devices;
}

static PyMethodDef methods[] = {
    {"list_device_ids", list_device_ids, METH_NOARGS, "List audio device IDs (Windows)"},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef moddef = {
    PyModuleDef_HEAD_INIT, "_audio_devices", NULL, -1, methods
};

PyMODINIT_FUNC PyInit__audio_devices(void) {
    return PyModule_Create(&moddef);
}
