# Playlist clássica — downloads legais

Documentação em inglês: [README.en.md](README.en.md).

Inventário de 50 faixas conforme a seleção solicitada. Obra em domínio público não implica que a gravação seja livre. A [FAQ do Musopen](https://musopen.org/faq/) explica que composição e gravação têm direitos distintos; o [catálogo de gravações](https://musopen.org/music/) oferece material livre, mas cada registro precisa ser identificado.

## Estado atual

A pesquisa encontrou um catálogo legal confiável (Musopen), mas não um URL direto verificável para cada gravação específica sem escolher uma interpretação concreta. Por isso, 48 faixas estão como `no_direct_url` e Barber/Albinoni como `copyright_review`. O script não baixa nenhuma faixa até que `download_url`, licença e qualidade sejam preenchidos no CSV.

Não foram inventados URLs diretos. Faixas com páginas dinâmicas, autenticação ou seleção via JavaScript permanecem no inventário para revisão. A pasta `music/` é ignorada pelo Git para não publicar arquivos de áudio potencialmente grandes.

## Uso

    cd classical-playlist
    ./download-classicos.sh
    ./verify.sh

O download usa `curl` (fallback `wget`), arquivos temporários `.part`, tratamento de erros HTTP, validação contra HTML/JSON e não sobrescreve arquivos existentes. `verify.sh` usa `ffprobe` quando disponível. Apenas os estados `ready` e `mp3_only` entram na fila de download.

## Campos e status

playlist.csv e playlist.json registram compositor, obra, movimento, intérprete, fonte, página, URL direta, licença, formato, qualidade, nome e status. Estados: ready, mp3_only, no_direct_url, copyright_review e unavailable.

## Tabela resumida

| # | Faixa | Formato | Licença/observação | Fonte | Status |
|---:|---|---|---|---|---|
| 1 | Beethoven — Moonlight Sonata | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 2 | Beethoven — Moonlight Sonata | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 3 | Puccini — Nessun Dorma | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 4 | Vivaldi — The Four Seasons — Winter - I. Allegro non molto | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 5 | Vivaldi — The Four Seasons — Summer - III. Presto | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 6 | Vivaldi — The Four Seasons — Spring - I. Allegro | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 7 | Beethoven — Symphony No. 7 — II. Allegretto | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 8 | Beethoven — Symphony No. 5 — I. Allegro con brio | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 9 | Mozart — Requiem — Lacrimosa | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 10 | Mozart — Requiem — Dies Irae | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 11 | Mozart — Piano Concerto No. 20 — II. Romance | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 12 | Mozart — Symphony No. 40 — I. Molto Allegro | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 13 | Chopin — Nocturne Op. 9 No. 2 | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 14 | Chopin — Nocturne in C-sharp minor — posthumous | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 15 | Chopin — Ballade No. 1 in G minor | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 16 | Chopin — Prelude Op. 28 — No. 4 | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 17 | Rachmaninoff — Piano Concerto No. 2 — II. Adagio sostenuto | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 18 | Rachmaninoff — Prelude in C-sharp minor | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 19 | Tchaikovsky — Swan Lake — Scene | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 20 | Tchaikovsky — Swan Lake — Dance of the Little Swans | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 21 | Tchaikovsky — Piano Concerto No. 1 — I. Allegro non troppo | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 22 | Tchaikovsky — 1812 Overture — Finale | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 23 | Saint-Saëns — Danse Macabre | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 24 | Saint-Saëns — The Swan | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 25 | Dvořák — Symphony No. 9 — IV. Allegro con fuoco | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 26 | Dvořák — Symphony No. 9 — II. Largo | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 27 | Bach — Toccata and Fugue in D minor | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 28 | Bach — Air on the G String | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 29 | Bach — Cello Suite No. 1 — Prelude | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 30 | Albinoni — Adagio in G minor | FLAC | Composition/attribution and recording require specific review | [Musopen](https://musopen.org/music/) | copyright_review |
| 31 | Barber — Adagio for Strings | FLAC | Samuel Barber (d. 1981): composition/recording copyright review required | [Musopen](https://musopen.org/music/) | copyright_review |
| 32 | Pachelbel — Canon in D | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 33 | Debussy — Clair de Lune | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 34 | Satie — Gymnopédie No. 1 | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 35 | Schubert — Serenade (Ständchen) | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 36 | Schubert — Ave Maria | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 37 | Bizet — Carmen — Habanera | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 38 | Bizet — Carmen — Toreador Song | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 39 | Verdi — La Traviata — Libiamo ne' lieti calici | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 40 | Verdi — Requiem — Dies Irae | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 41 | Puccini — O mio babbino caro | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 42 | Puccini — E lucevan le stelle | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 43 | Puccini — Un bel dì vedremo | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 44 | Mascagni — Cavalleria Rusticana — Intermezzo | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 45 | Offenbach — Les Contes d'Hoffmann — Barcarolle | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 46 | Fauré — Requiem — In Paradisum | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 47 | Händel — Sarabande | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 48 | Händel — Messiah — Hallelujah | MP3 | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 49 | Holst — The Planets — Mars, the Bringer of War | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
| 50 | Holst — The Planets — Jupiter, the Bringer of Jollity | FLAC | Musopen catalog; recording license not yet verified | [Musopen](https://musopen.org/music/) | no_direct_url |
