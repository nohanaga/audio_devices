import sys
if sys.platform == "darwin":
    from ._audio_devices import list_device_uids as list_audio_devices
    from ._audio_devices import list_device_details
elif sys.platform == "win32":
    from ._audio_devices import list_device_ids as list_audio_devices
    from ._audio_devices import list_device_details
else:
    def list_audio_devices():
        raise NotImplementedError("Not supported on this OS")
