from setuptools import setup, Extension
import sys

ext_modules = []
if sys.platform == "darwin":
    ext_modules.append(Extension(
        "audio_devices._audio_devices",
        sources=["src/audio_devices/_audio_devices.m"],
        extra_link_args=["-framework", "CoreAudio", "-framework", "AudioToolbox", "-framework", "CoreFoundation"],
        language="objc",
    ))
elif sys.platform == "win32":
    ext_modules.append(Extension(
        "audio_devices._audio_devices",
        sources=["src/audio_devices/_audio_devices.cpp"],
        libraries=["ole32", "uuid"],
    ))

setup(
    ext_modules=ext_modules,
    zip_safe=False,
)
