import pyautogui as gui
import time

def record():
    print('Started...')
    a = []
    dt = 0.05
    px,py=0,0
    for i in range(100):
        x,y = gui.position()[0],gui.position()[1]
        vx,vy = (x-px)/dt , (y-py)/dt
        a.append([x,y])
        px,py = x,y
        time.sleep(dt)
    print('Stopped...')
    return a

b = record()
print(b)
