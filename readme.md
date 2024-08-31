# 💻 Browser Game Development 🎮

> Delving into the Depths of C, WebAssembly, and WebGL

## Table of Contents

- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Build Instructions](#build-instructions)
- [Usage](#usage)

## Introduction

This project is an exploration into developing a browser-based game using C, compiled to WebAssembly, with graphical rendering handled by WebGL.

## Project Structure

The directory structure of the project is:

```
.
├── makefile
├── readme.md
└── src
    └── main.c
```

- **makefile**: Contains build instructions.
- **readme.md**: Project documentation.
- **src**: Directory containing C source files.

## Setup Instructions

### Prerequisites

Ensure you have the following tools installed:

- **clang**: Compiler to translate C code to WebAssembly.
- **make**: Build tool to automate the compilation process.

## Build Instructions

**Clone the Repository:**

```sh
git clone https://github.com/anluin/browsergame.git
cd browsergame
make
```

## Usage

To verify the build, you can inspect the generated WebAssembly binary.

```sh
$ wasm2wat target/wasm32-unknown-unknown/release/browsergame.wasm
```
