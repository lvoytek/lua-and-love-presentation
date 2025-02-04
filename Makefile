.PHONY: present

present: presentation/reveal.js
	cp presentation/index.html presentation/reveal.js/
	cp presentation/*.md presentation/reveal.js/
	cp -r presentation/img presentation/reveal.js/
	cd presentation/reveal.js && npm start

presentation/reveal.js:
	cd presentation && git clone https://github.com/hakimel/reveal.js.git
	cd presentation/reveal.js && npm install


.PHONY: p1
p1:
	love projects/hello-world

.PHONY: p2
p2:
	love projects/scale-img

.PHONY: p3
p3:
	love projects/system-info

.PHONY: p4
p4:
	love projects/mouse-physics

.PHONY: p5

p5: projects/scale-img-shader/moonshine
	love projects/scale-img-shader

projects/scale-img-shader/moonshine:
	cd projects/scale-img-shader && git clone https://github.com/vrld/moonshine.git
