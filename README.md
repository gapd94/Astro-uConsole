# Astro-uConsole

Astro-uConsole is an open-source project that transforms the ClockworkPi uConsole into a fully standalone, handheld astrophotography control system.

The goal is to provide a reliable, offline-capable, and fully integrated environment for controlling telescope mounts and astrophotography accessories using industry-standard open-source software.

🎯 Project Objective

Use the uConsole as the primary handheld device to manage:

GoTo telescope mounts

Imaging cameras

Auto-focusers

GPS positioning

Environmental data

Plate solving and guiding

All without requiring an active internet connection.

🏆 Project Goals

Fully functional standalone astrophotography controller

Compatible with INDI-supported mounts and accessories

Optimized for the uConsole hardware

Modular and maintainable installation framework

Open-source and community-friendly

📦 Software Stack (Installed)
Core Astronomy Software

INDI Core

INDI 3rd Party Drivers

INDI GPS Support

INDI OpenWeather

KStars & Ekos

PHD2 Guiding

Stellarium

SkyChart / Carte du Ciel

ASTAP

StellarSolver

Plate Solving utilities

Imaging & Processing

FireCapture

AstroDMx

SER Player

Siril

GIMP

ImPPG

GraXpert

Astropy

gPhoto2

Optional / Experimental

INDIGO

AIS INDIGO Imager

Hallo Northern Sky

FlightRadar (optional)

🖥 Hardware Stack

ClockworkPi uConsole

Hacker Gadget NVMe Board

Hacker Gadget RJ45 & USB 3.0 Board

INDI-supported telescope mounts

USB connectivity (Serial optional)

Wi-Fi (experimental)

💽 Operating System

Debian Bookworm 64-bit

Rex image (kernel 6.12.45 at time of writing)

🧩 Architecture Overview

Astro-uConsole uses a modular installer framework:

One entry script

Independent install modules

Offline-first philosophy

No cloud or runtime internet dependency

⚙️ Key Features (Planned)

Automatic uConsole dark theme configuration

Temperature-based autofocus compensation via ESP32

Hardware-aware UI scaling

Fast boot, no container overhead

🚫 Non-Goals

No mandatory internet dependency

No cloud-based control

No power-optimization focus (for now)

📜 Repository Intent

This project is currently personal but is intended to become fully open-source once stable.

All efforts are made to respect upstream licenses and avoid infringement.

✅ Success Criteria

One automated script produces a fully working astrophotography uConsole

All major components installed and verified

Ready to connect a mount and image immediately

🚧 Status

Early development / architecture definition phase
