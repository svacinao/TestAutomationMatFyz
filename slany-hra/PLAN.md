# Solné Město – hra ve stylu GTA ve Slaném (předávací poznámky)

Stav: kód zatím nevznikl. Tohle je hotový návrh, podle kterého se dá rovnou začít psát.

## Technologie
- Jeden soubor `index.html`, HTML5 canvas a čistý JavaScript bez knihoven.
- Pohled shora jako v prvních dílech žánru. Dlaždice 32 px, mapa 150×150 dlaždic.
- Mapa se kreslí po chuncích 16×16 dlaždic do offscreen canvasů (cache), aby hra běžela plynule.

## Inspirace a návody (z rešerše)
- Fyzika auta shora, hlavně tlumení boční rychlosti (drift): https://phaser.io/tutorials/box2d-tutorials/top-down-car-physics
- Jednoduché auto na canvasu: https://ucfcdl.github.io/html5-tutorial
- Ukázkové repozitáře: https://github.com/le-s/getaway, https://github.com/PacktPublishing/Build-a-Car-Driving-Game-from-Scratch-using-JavaScript
- Reálie Slaného: https://www.kudyznudy.cz/aktivity/velvarska-brana, https://www.turistika.cz/mista/slany-masarykovo-namesti-martinicky-dvur-mestska-radnice-ungelt-velvarska-brana/detail
  - Velvarská brána je poslední zachovaná ze čtyř bran, stojí severně od Masarykova náměstí.
  - Pražská brána stála na východě a dnes už nestojí.
  - Slánská hora je kopec u centra. Pod ní je pramen, kdysi slaný (odtud „Solné město“).

## Mapa (dlaždicové souřadnice, volně podle Slaného)
- Centrum (Staré Město) je uvnitř okružní silnice „hradby“: x 56–94, y 52–92.
- Masarykovo náměstí je dlážděná plocha x 64–87, y 62–81, kterou se dá projet. Na jeho severní straně stojí radnice.
- Ulice. Silnice jsou široké 2 dlaždice, jezdí se vpravo.
  - v75: Velvarská (sever), Husova (jih).
  - h71: Wilsonova (západ), Pražská (východ).
  - Okruh: Vinařického (sever), Šultysova (jih), Lázeňská (západ), Dr. E. Beneše (východ).
  - Vnější síť:
    - Svislé: v30 Kladenská, v120 Netovická, v94 Lidická (sever), v56 Soukenická (jih), v94 Žižkova (jih).
    - Vodorovné: h30 Pod Horou, h112 Nádražní, h52 Třebízského, h92 Politických vězňů.
- Velvarská brána: dva pilíře na Velvarské (y 56–58). Střecha se kreslí nad auty a průhlední, když hráč projíždí pod ní.
- Slánská hora: kopec se středem (52,16) a poloměrem 11, nahoře vyhlídka. Dá se po něm jet, ale pomaleji.
- Kostel sv. Gotharda: jižně od náměstí (79–88, 83–90).
- Nemocnice Slaný na východě (100–116, 34–49), tady se hráč objeví po smrti.
- Policie na západě (36–48, 76–85) s parkovištěm. Tady se hráč objeví po zatčení.
- Smetanovy sady: park s rybníčkem (33–54, 55–69).
- Nádraží: budova (64–86, 115–119), trať přes celou mapu v y 121–122.
- Lakovna (100–107, 96–101): za 200 Kč smaže hledanost.
- Šrotiště za městem na západě (12–22, 62–67).
- Pekárna u západního okruhu (59–62, 74–77).
- Domy: skupiny 3×3 dlaždic, každá má jinou barvu střechy. V centru je zástavba hustá, na okraji jsou zahrady a za městem pole.
- Upozornění pro hráče: mapa je jen volně inspirovaná, nesedí přesně.

## Mechaniky
- Pěšky: WASD nebo šipky, Shift je sprint. Střílí se mezerou nebo myší (míří na kurzor).
- E nebo F: nastoupit a vystoupit. Řidič ukradeného auta vyběhne ven.
- Auto:
  - Plyn a brzda ovlivňují rychlost dopředu a vzad.
  - Boční rychlost se tlumí (grip 9, s ruční brzdou 1,5), díky tomu auto driftuje.
  - Zatáčivost závisí na rychlosti. Kolize se počítají přes rohy auta proti pevným dlaždicím.
- Typy aut: běžné, sportovní, dodávka, taxi, policie, zlaté auto (pro misi).
- Provoz:
  - Silnice tvoří graf: uzly jsou křižovatky, hrany úseky ulic.
  - AI auto jede po pravém pruhu přes body začátek a konec hrany a na křižovatce si náhodně vybere směr.
  - Když má něco před sebou, zabrzdí. Po 3 s čekání to zkusí objet.
- Chodci chodí po chodnících a po náměstí. Když se něco děje, utíkají.
- Hledanost 0–5 hvězd podle „heat“:
  - Přidává: přejetý chodec +0,6, zabitý policista +1,5, krádež auta před policií +0,4.
  - Ubírá: když hráče policie 7 s nevidí, spadne jedna hvězda.
- Policie:
  - Vyráží za hráčem: zblízka jede přímo na něj, zdálky hladově po grafu ulic.
  - Když se zasekne, couvne. Od 2 hvězd střílí.
  - Zatčení: policejní auto stojí do 46 px od hráče a hráč stojí nebo je pěšky, a to 1,5 s.
- Poškození: auto hoří pod 15 HP a pak vybuchne. Výbuch zraní všechno v okruhu 80 px.
- Sběratelské předměty: 12 solných krystalů po mapě, každý za 100 Kč.
- Postup se ukládá do localStorage (peníze, mise, krystaly).
- Zvuk přes WebAudio: motor, siréna, výstřel, náraz, výbuch. M ztlumí zvuk.
- Na mobilu je virtuální joystick a tlačítka E a Střelba (v autě slouží jako ruční brzda).

## Mise (start na značce M na náměstí)
1. **Rohlíky pro Velvarskou** (300 Kč): sežeň auto, zajeď do pekárny a za 75 s doruč rohlíky k Velvarské bráně.
2. **Taxi z nádraží** (450 Kč): vyzvedni zákazníka na nádraží a za 80 s ho dovez na Slánskou horu.
3. **Kolem hradeb** (600 Kč): závod přes 4 rohy okruhu a zpět, celkem 60 s.
4. **Zlaté auto** (1000 Kč): ukradni zlaté auto u nemocnice (hned 2 hvězdy) a odvez ho na šrotiště.
5. **Velká honička** (1500 Kč): získej 4 hvězdy a pak se jich zbav. Lakovna se nepočítá.

## Rozhraní
- Vlevo nahoře mise a časovač. Vpravo nahoře peníze, hvězdy, zdraví a stav auta.
- Minimapa vlevo dole, na mobilu vpravo nahoře.
- Uprostřed dole název ulice a čtvrti, například „Velvarská · Staré Město“.
- Velké nápisy: „ZATČEN“, „NA MARODCE“ (smrt), „MISE SPLNĚNA“.
- Úvodní obrazovka „SOLNÉ MĚSTO“ s přehledem ovládání. Esc hru pozastaví.
- Vizuální styl: tmavé arkádové rozhraní, písma Bungee (nadpisy) a Rubik (text), jantarový akcent.
