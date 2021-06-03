// Requires P5js
w = t = 640, draw = _ => {
    createCanvas(w, w);
    loadPixels()
    for (t++, q = y = w / 4; y--;)
        for (x = q; x--;)(t - y - x ^ t - y + x) ** sqrt(2) % 33 < (x + y) / 19 && set(x, y, 0)
    updatePixels();
    clear(g = get(0, 0, q, q));
    image(g, 0, 0, w, w)
}