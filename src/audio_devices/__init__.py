import sys
if sys.platform == "darwin":
    from ._audio_devices import list_device_uids as list_audio_devices
elif sys.platform == "win32":
    from ._audio_devices import list_device_ids as list_audio_devices
else:
    def list_audio_devices():
        raise NotImplementedError("Not supported on this OS")
