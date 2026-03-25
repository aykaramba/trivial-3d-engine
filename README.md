# Trivial 3D Engine

```
;;
;;   _____     _       _       _   _____ ____    _____             _            
;;  |_   _| __(_)_   _(_) __ _| | |___ /|  _ \  | ____|_ __   __ _(_)_ __   ___ 
;;    | || '__| \ \ / / |/ _` | |   |_ \| | | | |  _| | '_ \ / _` | | '_ \ / _ \
;;    | || |  | |\ V /| | (_| | |  ___) | |_| | | |___| | | | (_| | | | | |  __/
;;    |_||_|  |_| \_/ |_|\__,_|_| |____/|____/  |_____|_| |_|\__, |_|_| |_|\___|
;;                                                            |___/             
```

<img width="402" height="411" alt="trival" src="https://github.com/user-attachments/assets/8e1092b7-3a8c-4252-b6d0-67c8285a864e" />

A simple test to transpose a wonderful little tutorial by Tsoding that demonstrates how to store data as vectors and use a few simple formulas to translate the data and render points and lines of a cube in 3d dimensions.

Tsoding performs the line tutorial in JavaScript, and I wanted to see what the code would look like in Sketch and learn a little bit about how to render 3d data.

This is my first attempt. 

All comments are welcome. All criticisms and suggestions are even better. 

Original tutorial link: https://www.youtube.com/watch?v=qjWkNZ0SXfo
Tutorial author: Tsoding
Authors GitHub: https://github.com/tsoding

To load the app, in SLY or SLIME run: (ql:quickload :trivial-3d-engine)
When the app compiles, it should open up a Sketch window with a spinning cube. If you close the Sketch window, you can just start another Sketch window with: (trivial-3d-engine:start-app)


