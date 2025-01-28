.PHONY: present

present: presentation/reveal.js
	cp presentation/index.html presentation/reveal.js/
	cp presentation/*.md presentation/reveal.js/
	cd presentation/reveal.js && npm start

presentation/reveal.js:
	cd presentation && git clone https://github.com/hakimel/reveal.js.git
	cd presentation/reveal.js && npm install
