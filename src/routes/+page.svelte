<script>
  import { browser } from '$app/environment';
  import { onDestroy } from 'svelte';
  import galleryBoardManifest from '$lib/data/gallery-board-manifest.json';

  const navLinks = [
    { href: '#home', label: 'Home' },
    { href: '#selected', label: 'Portfolio' },
    { href: '#process', label: 'Profile' },
    { href: '#gallery', label: 'Gallery' }
  ];

  const scrollFinishGalleryNumbers = [15, 9, 18, 36];
  const portraitRhythmSoftLightNumber = 11;
  const profileCardGalleryNumber = 4;
  const editorialPresenceFrameNumbers = [39, 5, 29];

  function getGalleryNumber(item) {
    const match = item.src.match(/gallery-upload-(\d+)\.jpeg$/);
    return match ? Number.parseInt(match[1], 10) : null;
  }

  const scrollFinishGalleryImages = scrollFinishGalleryNumbers
    .map((number) => {
      const match = galleryBoardManifest.find((item) => getGalleryNumber(item) === number);

      if (!match) return null;

      return {
        src: match.src,
        alt: match.alt,
        label: `Gallery ${String(number).padStart(2, '0')}`
      };
    })
    .filter(Boolean);

  const portraitRhythmSoftLightImage = galleryBoardManifest.find(
    (item) => getGalleryNumber(item) === portraitRhythmSoftLightNumber
  );

  const profileCardGalleryImage = galleryBoardManifest.find(
    (item) => getGalleryNumber(item) === profileCardGalleryNumber
  );

  const editorialPresenceFrames = editorialPresenceFrameNumbers
    .map((number) => {
      const match = galleryBoardManifest.find((item) => getGalleryNumber(item) === number);

      if (!match) return null;

      return {
        src: match.src,
        alt: match.alt,
        label:
          number === 3 ? 'Close crop' : number === 5 ? 'Movement' : 'Studio'
      };
    })
    .filter(Boolean);

  const removedGalleryNumbers = [
    ...scrollFinishGalleryNumbers,
    portraitRhythmSoftLightNumber,
    ...editorialPresenceFrameNumbers,
    profileCardGalleryNumber
  ];

  const motionCards = [
    {
      title: 'Editorial Presence',
      eyebrow: '01 / Editorial',
      body:
        'A composed editorial profile shaped by fashion work across Italy, France, and Moldova, with a focus on clean styling and strong visual presence.',
      note: 'Editorial focus',
      detail: 'Fashion / beauty / campaign',
      mediaClass: 'motion-cover',
      heroImage: {
        src: '/images/mary-01.jpeg',
        alt: 'Mary editorial portrait'
      },
      filmFrames:
        editorialPresenceFrames.length === 3
          ? editorialPresenceFrames
          : [
              { src: '/images/selected-work-01.jpeg', alt: 'Editorial detail frame', label: 'Close crop' },
              { src: '/images/selected-work-07.jpeg', alt: 'Movement study frame', label: 'Movement' },
              { src: '/images/selected-work-10.jpeg', alt: 'Studio frame', label: 'Studio' }
            ]
    },
    {
      title: 'Portrait Rhythm',
      eyebrow: '02 / Casting',
      body:
        'Portrait work built around softness, confidence, and direct camera connection for beauty stories, editorials, and agency-facing updates.',
      note: 'Casting energy',
      detail: 'Portrait / beauty / close-up',
      mediaClass: 'motion-portrait',
      heroImage: {
        src: '/images/mary-02.jpeg',
        alt: 'Mary portrait sequence'
      },
      filmFrames: [
        { src: '/images/mary-04.jpeg', alt: 'Portrait detail image', label: 'Profile' },
        { src: '/images/mary-05.jpeg', alt: 'Editorial texture image', label: 'Texture' },
        portraitRhythmSoftLightImage
          ? {
              src: portraitRhythmSoftLightImage.src,
              alt: portraitRhythmSoftLightImage.alt,
              label: 'Soft light'
            }
          : { src: '/images/mary-06.jpeg', alt: 'Soft light image', label: 'Soft light' }
      ]
    },
    {
      title: 'Booking Ready',
      eyebrow: '03 / Availability',
      body:
        'A closing section that brings together archive imagery, motion, and clear availability details for international clients, brands, and creative teams.',
      note: 'Booking surface',
      detail: 'Archive / reel / travel',
      mediaClass: 'motion-finish',
      heroImage: scrollFinishGalleryImages[0] ?? {
        src: '/images/gallery-board.jpeg',
        alt: 'Gallery board collage'
      },
      filmFrames: scrollFinishGalleryImages.slice(1)
    }
  ];

  const timelineItems = [
    {
      value: '4+',
      label: 'Years experience',
      copy: 'Maria has built over four years of professional experience across fashion and editorial modeling.'
    },
    {
      value: '03',
      label: 'Countries worked',
      copy: 'Her portfolio has grown through work in Italy, France, and Moldova.'
    },
    {
      value: '170',
      label: 'Height in cm',
      copy: 'A clean international model profile with balanced runway and editorial proportions.'
    },
    {
      value: '92-60-90',
      label: 'Measurements',
      copy: 'Professional format: bust 92, waist 60, hips 90.'
    },
    {
      value: 'EU',
      label: 'Travel ready',
      copy: 'Available for international collaborations and travel across Germany and Switzerland.'
    }
  ];

  const measurementCards = [
    {
      type: 'photo',
      src: profileCardGalleryImage?.src ?? '/images/mary-06.jpeg',
      alt: profileCardGalleryImage?.alt ?? 'Mary portrait for profile section',
      label: 'Profile card'
    },
    {
      type: 'metric',
      label: 'Professional format',
      value: 'Age 25 / 50 kg',
      copy: 'Height 170 cm with measurements 92 - 60 - 90 for fashion, editorial, and commercial bookings.'
    },
    {
      type: 'metric',
      label: 'Sizing',
      value: 'S / EU 36 / 37-38',
      copy: 'Dress size S (EU 36) and shoe size 37/38 for sample-size and styled production work.'
    },
    {
      type: 'metric',
      label: 'Features',
      value: 'Light Blonde / Brown',
      copy: 'Hair light blonde, eyes brown, with no tattoos and no piercings.'
    }
  ];

  const selectedWorks = [
    { src: '/images/selected-01.jpeg', alt: 'Portfolio image 01', label: 'Portrait study' },
    { src: '/images/selected-02.jpeg', alt: 'Portfolio image 02', label: 'Soft daylight' },
    { src: '/images/selected-03.jpeg', alt: 'Portfolio image 03', label: 'Studio still' },
    { src: '/images/selected-04.jpeg', alt: 'Portfolio image 04', label: 'Editorial frame' },
    { src: '/images/selected-05.jpeg', alt: 'Portfolio image 05', label: 'Motion pause' },
    { src: '/images/selected-06.jpeg', alt: 'Portfolio image 06', label: 'Monochrome note' },
    { src: '/images/selected-07.jpeg', alt: 'Portfolio image 07', label: 'Quiet profile' },
    { src: '/images/selected-08.jpeg', alt: 'Portfolio image 08', label: 'Natural texture' },
    { src: '/images/selected-09.jpeg', alt: 'Portfolio image 09', label: 'Closing look' }
  ];

  const processNotes = [
    {
      label: 'Base',
      copy: 'Based near Milan, Maria is well positioned for productions in Italy and across the wider European market.'
    },
    {
      label: 'Experience',
      copy: 'With over four years of experience, her portfolio is built around fashion, editorial, and clean international presentation.'
    },
    {
      label: 'Travel',
      copy: 'She is available for international collaborations and travel across Germany and Switzerland.'
    },
    {
      label: 'Profile',
      copy: 'Her professional details include age 25, height 170 cm, measurements 92 - 60 - 90, dress size S, and shoe size 37/38.'
    }
  ];

  const currentShows = [
    {
      src: '/images/selected-work-13.jpeg',
      alt: 'Showreel frame 01',
      label: 'Fashion reel',
      copy: 'A polished portrait-led reel suited to fashion campaigns, editorials, and international castings.'
    },
    {
      src: '/images/showreel-02.jpeg',
      alt: 'Showreel frame 02',
      label: 'Editorial reel',
      copy: 'Closer portrait framing with quieter pacing for editorial decks and beauty presentations.'
    },
    {
      src: '/images/selected-work-16.jpeg',
      alt: 'Showreel frame 03',
      label: 'Studio reel',
      copy: 'A clean studio-focused image with sharper lines for agency submissions and commercial selections.'
    }
  ];

  const galleryBoardItems = galleryBoardManifest.filter(
    (item) => !removedGalleryNumbers.includes(getGalleryNumber(item))
  );

  const galleryBoardRatioWeights = { short: 1, landscape: 1.05, portrait: 1.66, tall: 2.08 };
  const galleryColumns = [[], [], []];
  const galleryHeights = [0, 0, 0];

  galleryBoardItems.forEach((item, index) => {
    const shortestColumnHeight = Math.min(...galleryHeights);
    const columnIndex = galleryHeights.indexOf(shortestColumnHeight);
    const enrichedItem = { ...item, index };

    galleryColumns[columnIndex].push(enrichedItem);
    galleryHeights[columnIndex] +=
      galleryBoardRatioWeights[item.ratio] ?? galleryBoardRatioWeights.portrait;
  });

  let activeGalleryIndex = null;
  let isMobileNavOpen = false;

  function openLightbox(index) {
    activeGalleryIndex = index;
  }

  function closeLightbox() {
    activeGalleryIndex = null;
  }

  function showPrevious() {
    if (activeGalleryIndex === null) return;
    activeGalleryIndex =
      (activeGalleryIndex - 1 + galleryBoardItems.length) % galleryBoardItems.length;
  }

  function showNext() {
    if (activeGalleryIndex === null) return;
    activeGalleryIndex = (activeGalleryIndex + 1) % galleryBoardItems.length;
  }

  function toggleMobileNav() {
    isMobileNavOpen = !isMobileNavOpen;
  }

  function closeMobileNav() {
    isMobileNavOpen = false;
  }

  let lightboxTouchStartX = 0;

  function handleLightboxTouchStart(event) {
    lightboxTouchStartX = event.changedTouches[0]?.clientX ?? 0;
  }

  function handleLightboxTouchEnd(event) {
    const endX = event.changedTouches[0]?.clientX ?? 0;
    const deltaX = endX - lightboxTouchStartX;

    if (Math.abs(deltaX) < 40) return;

    if (deltaX > 0) showPrevious();
    else showNext();
  }

  function handleKeydown(event) {
    if (event.key === 'Escape' && isMobileNavOpen) {
      closeMobileNav();
    }

    if (activeGalleryIndex === null) return;

    if (event.key === 'Escape') closeLightbox();
    if (event.key === 'ArrowLeft') showPrevious();
    if (event.key === 'ArrowRight') showNext();
  }

  $: activeGalleryItem =
    activeGalleryIndex === null ? null : galleryBoardItems[activeGalleryIndex];

  $: activeGalleryNumber = activeGalleryItem ? getGalleryNumber(activeGalleryItem) : null;

  $: lightboxThumbItems =
    activeGalleryIndex === null
      ? []
      : galleryBoardItems.filter((_, index) => Math.abs(index - activeGalleryIndex) <= 2);

  $: if (browser) {
    document.body.classList.toggle('lightbox-open', activeGalleryIndex !== null);
  }

  onDestroy(() => {
    if (browser) {
      document.body.classList.remove('lightbox-open');
    }
  });
</script>

<svelte:window on:keydown={handleKeydown} />

<nav class="site-nav">
  <div class="site-nav-inner">
    <div class="site-brand">
      <small>International model</small>
      <span>Maria</span>
    </div>

    <div class="site-nav-links desktop-nav">
      {#each navLinks as link}
        <a class="site-nav-link" href={link.href}>{link.label}</a>
      {/each}
    </div>

    <div class="site-nav-actions">
      <a class="site-nav-cta" href="#gallery">Open Gallery</a>
      <button
        class="site-nav-toggle"
        type="button"
        aria-label={isMobileNavOpen ? 'Close navigation menu' : 'Open navigation menu'}
        aria-expanded={isMobileNavOpen}
        on:click={toggleMobileNav}
      >
        <span class="site-nav-toggle-dots" aria-hidden="true">
          <span></span>
          <span></span>
          <span></span>
        </span>
      </button>
    </div>
  </div>

  {#if isMobileNavOpen}
    <button
      class="mobile-nav-backdrop"
      type="button"
      aria-label="Close navigation menu"
      on:click={closeMobileNav}
    ></button>

    <div class="mobile-nav-panel">
      <div class="mobile-nav-links">
        {#each navLinks as link}
          <a class="mobile-nav-link" href={link.href} on:click={closeMobileNav}>
            <span>{link.label}</span>
          </a>
        {/each}
      </div>
    </div>
  {/if}
</nav>

<main class="page-shell">
  <section class="section hero" id="home">
    <div class="hero-grid editorial-photo">
      <div class="photo-surface hero-image">
        <img class="photo-img" src="/images/landing-maria.jpeg" alt="Maria portfolio hero portrait" />
      </div>

      <div class="hero-copy">
        <div>
          <div class="eyebrow">International model portfolio</div>
          <h1>Maria for fashion, editorial, and international bookings.</h1>
        </div>

        <p>
          Based near Milan, Maria is available for editorials, campaigns, lookbooks,
          and travel-ready bookings across Europe.
        </p>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="section-head">
      <span class="section-tag">At a glance</span>
      <span>Layout metrics</span>
    </div>

    <div class="timeline">
      {#each timelineItems as item}
        <article class="timeline-item">
          <span class="mini-label">{item.label}</span>
          <strong>{item.value}</strong>
          <p>{item.copy}</p>
        </article>
      {/each}
    </div>
  </section>

  <section class="section">
    <div class="section-head">
      <span class="section-tag">Measurements</span>
      <span>Profile snapshot</span>
    </div>

    <div class="text-block">
      <h2>Professional details for agencies, editors, and international bookings.</h2>
      <p>
        Maria is 25 years old and based near Milan, with a profile tailored for fashion,
        editorial, and travel-ready bookings across Europe.
      </p>
    </div>

    <div class="figures-grid">
      {#each measurementCards as item}
        {#if item.type === 'photo'}
          <article class="figure-card photo-card">
            <span class="metric-label">{item.label}</span>
            <div class="editorial-photo">
              <div class="photo-surface profile-card-surface">
                <img class="photo-img" src={item.src} alt={item.alt} />
              </div>
            </div>
          </article>
        {:else}
          <article class="figure-card">
            <span class="metric-label">{item.label}</span>
            <strong>{item.value}</strong>
            <p>{item.copy}</p>
          </article>
        {/if}
      {/each}
    </div>
  </section>

  <section class="section motion-sequence">
    <div class="section-head">
      <span class="section-tag">Flow</span>
      <span>Three-part scroll</span>
    </div>

    <div class="stack-scene">
      {#each motionCards as card, index}
        <article class="stack-card" style={`--card-index: ${index};`}>
          <div class="stack-card-top">
            <span>{card.eyebrow}</span>
            <span>{card.detail}</span>
          </div>

          <div class="stack-card-body">
            <div class="stack-copy">
              <h2>{card.title}</h2>
              <p>{card.body}</p>
            </div>

            <div class="stack-side">
              <div class={`stack-media ${card.mediaClass}`}>
                <img class="photo-img" src={card.heroImage.src} alt={card.heroImage.alt} />
                <div class="stack-media-caption">
                  <span>{card.note}</span>
                  <span>{card.detail}</span>
                </div>
              </div>

              <div class="film-grid">
                {#each card.filmFrames as frame}
                  <figure class="film-item">
                    <div class="editorial-photo film-thumb">
                      <div class="photo-surface film-thumb">
                        <img class="photo-img" src={frame.src} alt={frame.alt} />
                      </div>
                    </div>
                    <figcaption class="film-caption-compact">{frame.label}</figcaption>
                  </figure>
                {/each}
              </div>
            </div>
          </div>
        </article>
      {/each}
    </div>
  </section>

  <section class="section selected-works" id="selected">
    <div class="section-head">
      <span class="section-tag">Portfolio</span>
      <span>Core portfolio frames</span>
    </div>

    <div class="selected-gallery">
      {#each selectedWorks as item, index}
        <figure class="selected-gallery-card" style={`--portfolio-index: ${index};`}>
          <div class="editorial-photo selected-gallery-photo">
            <div class="photo-surface selected-gallery-photo">
              <img class="photo-img" src={item.src} alt={item.alt} />
            </div>
          </div>
          <figcaption class="selected-label">{item.label}</figcaption>
        </figure>
      {/each}
    </div>
  </section>

  <section class="section manifesto" id="process">
    <div class="section-head">
      <span class="section-tag">Profile</span>
      <span>Availability and booking notes</span>
    </div>

    <div class="manifesto-grid">
      <div class="gallery-copy">
        <div class="eyebrow">International availability</div>
        <h2>Maria is available for fashion, editorial, and travel-based collaborations across Europe.</h2>
        <p>
          Based near Milan, Maria offers a polished international profile suited to
          agency submissions, castings, brand campaigns, editorials, and cross-border productions.
        </p>
        <div class="gallery-notes">
          <span>Italy / Milan</span>
          <span>Germany travel</span>
          <span>Switzerland travel</span>
        </div>
      </div>

      <div>
        <div class="route-map">
          <div class="route-line"></div>
          <div class="route-dot dot-a"></div>
          <div class="route-dot dot-b"></div>
          <div class="route-dot dot-c"></div>
          <div class="route-dot dot-d"></div>
          <div class="route-copy copy-a">Editorial profile</div>
          <div class="route-copy copy-b">Portfolio edit</div>
          <div class="route-copy copy-c">International availability</div>
          <div class="route-copy copy-d">Booking contact</div>
        </div>
      </div>
    </div>

    <div class="process-notes">
      {#each processNotes as note}
        <article class="process-note">
          <span>{note.label}</span>
          <p>{note.copy}</p>
        </article>
      {/each}
    </div>
  </section>

  <section class="section current-shows">
    <div class="section-head">
      <span class="section-tag">Current reels</span>
      <span>Movement and casting clips</span>
    </div>

    <div class="film-grid">
      {#each currentShows as show}
        <figure class="film-item">
          <div class="editorial-photo current-reel-photo">
            <div class="photo-surface current-reel-photo">
              <img class="photo-img" src={show.src} alt={show.alt} />
            </div>
          </div>
          <span>{show.label}</span>
          <figcaption class="film-caption-compact">{show.copy}</figcaption>
        </figure>
      {/each}
    </div>
  </section>

  <section class="section gallery-feature" id="gallery">
    <div class="section-head">
      <span class="section-tag">Gallery board</span>
      <span>{galleryBoardItems.length} uploaded frames</span>
    </div>

    <div class="gallery-layout">
      <div class="gallery-copy">
        <div class="eyebrow">Portfolio archive</div>
        <h2>An extended image archive for agencies, brands, and editorial teams.</h2>
        <p>
          This gallery board expands the portfolio beyond the hero and core portfolio edits,
          offering a broader archive of portrait, fashion, and editorial imagery.
        </p>
        <div class="gallery-notes">
          <span>Editorial archive</span>
          <span>Portrait selection</span>
          <span>Full-screen preview</span>
        </div>
      </div>

      <div class="gallery-board-app">
        <div class="gallery-board-feed">
          {#each galleryColumns as column}
            <div class="gallery-feed-column">
              {#each column as item}
                <figure class={`gallery-feed-card gallery-feed-${item.ratio}`}>
                  <button
                    class="gallery-feed-trigger"
                    type="button"
                    aria-label={`Open ${item.alt}`}
                    on:click={() => openLightbox(item.index)}
                  >
                    <img
                      class="photo-img"
                      src={item.src}
                      alt={item.alt}
                      style={`object-position: ${item.position};`}
                    />
                  </button>
                </figure>
              {/each}
            </div>
          {/each}
        </div>
      </div>
    </div>
  </section>
</main>

<footer class="footer" id="contact">
  <div class="footer-inner">
    <div class="footer-top">
      <a class="footer-mark-link" href="#home">
        <span class="footer-mark">
          <small>International model</small>
          Maria
        </span>
      </a>

      <div class="footer-top-side">
        <div class="footer-meta">Based near Milan and available across Europe</div>

        <div class="footer-contact-icons" aria-label="Contact channels">
          <span class="footer-contact-button" role="img" aria-label="Instagram">
            <span class="footer-link-icon">
              <svg viewBox="0 0 24 24" aria-hidden="true">
                <rect x="3.5" y="3.5" width="17" height="17" rx="5"></rect>
                <circle cx="12" cy="12" r="4.2"></circle>
                <circle class="filled" cx="17.4" cy="6.7" r="1.1"></circle>
              </svg>
            </span>
            <span>Instagram</span>
          </span>

          <span class="footer-contact-button" role="img" aria-label="Email">
            <span class="footer-link-icon">
              <svg viewBox="0 0 24 24" aria-hidden="true">
                <path d="M4 6.5h16v11H4z"></path>
                <path d="m5.5 8 6.5 5 6.5-5"></path>
              </svg>
            </span>
            <span>Email</span>
          </span>
        </div>
      </div>
    </div>

    <div class="footer-note">
      <div class="footer-copy-block">
        <span class="footer-note-label">Availability</span>
        <p>
          Available for editorials, campaigns, lookbooks, beauty stories, and travel-based bookings across Europe.
        </p>
      </div>

      <div class="footer-copy-block">
        <span class="footer-note-label">Approach</span>
        <p>
          Maria’s portfolio is built around calm camera presence, clean portraiture, and modern fashion direction for agencies and creative teams.
        </p>
      </div>

    </div>

  </div>
</footer>

{#if activeGalleryItem}
  <div class="gallery-lightbox" role="dialog" aria-modal="true" aria-label="Gallery lightbox">
    <button
      class="gallery-lightbox-backdrop"
      type="button"
      aria-label="Close gallery lightbox"
      on:click={closeLightbox}
    ></button>

    <div class="gallery-lightbox-panel">
      <div class="gallery-lightbox-topbar">
        <button
          class="gallery-lightbox-close"
          type="button"
          aria-label="Close gallery lightbox"
          on:click={closeLightbox}
        >
          &times;
        </button>
      </div>

      <div class="gallery-lightbox-body">
        <button
          class="gallery-lightbox-nav"
          type="button"
          aria-label="Show previous image"
          on:click={showPrevious}
        >
          ‹
        </button>

        <div
          class="gallery-lightbox-stage"
          role="group"
          aria-label="Gallery image viewer"
          on:touchstart={handleLightboxTouchStart}
          on:touchend={handleLightboxTouchEnd}
        >
          <div class="gallery-lightbox-image-shell">
            <img class="gallery-lightbox-image" src={activeGalleryItem.src} alt={activeGalleryItem.alt} />
          </div>

          <div class="gallery-lightbox-caption">
            <div class="gallery-lightbox-caption-copy">
              <strong>{activeGalleryItem.alt}</strong>
              <p>
                Gallery board image
                {#if activeGalleryNumber}
                  {String(activeGalleryNumber).padStart(2, '0')}
                {/if}
                {#if activeGalleryItem.sourceName}
                  · {activeGalleryItem.sourceName}
                {/if}
              </p>
            </div>

            <div class="gallery-lightbox-hint">Keyboard: left, right, escape</div>
          </div>

          {#if lightboxThumbItems.length > 1}
            <div class="gallery-lightbox-strip">
              {#each lightboxThumbItems as item}
                <button
                  class:active-thumb={item.index === activeGalleryIndex}
                  class="gallery-lightbox-thumb"
                  type="button"
                  aria-label={`Open ${item.alt}`}
                  on:click={() => openLightbox(item.index)}
                >
                  <img
                    class="gallery-lightbox-thumb-image"
                    src={item.src}
                    alt={item.alt}
                    style={`object-position: ${item.position};`}
                  />
                </button>
              {/each}
            </div>
          {/if}
        </div>

        <button
          class="gallery-lightbox-nav"
          type="button"
          aria-label="Show next image"
          on:click={showNext}
        >
          ›
        </button>
      </div>
    </div>
  </div>
{/if}

<style>
  .profile-card-surface {
    aspect-ratio: 1 / 1;
    width: 100%;
  }

  .selected-label {
    padding-top: 8px;
  }

  .gallery-lightbox-panel {
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 28px;
    overflow: hidden;
    background:
      radial-gradient(circle at top left, rgba(255, 255, 255, 0.08), transparent 24%),
      linear-gradient(180deg, rgba(23, 23, 27, 0.98), rgba(9, 9, 12, 1));
    box-shadow: 0 28px 90px rgba(0, 0, 0, 0.42);
  }

  .gallery-lightbox-topbar {
    display: flex;
    justify-content: flex-end;
    padding-bottom: 4px;
  }

  .gallery-lightbox-close,
  .gallery-lightbox-thumb {
    transition:
      transform 0.2s ease,
      background-color 0.2s ease,
      border-color 0.2s ease,
      opacity 0.2s ease;
  }

  .gallery-lightbox-close {
    min-height: 48px;
    width: 48px;
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 999px;
    font-size: 1.4rem;
    line-height: 1;
  }

  .gallery-lightbox-close:hover,
  .gallery-lightbox-thumb:hover {
    transform: translateY(-1px);
    background: rgba(255, 255, 255, 0.12);
    border-color: rgba(255, 255, 255, 0.22);
  }

  .gallery-lightbox-stage {
    display: grid;
    gap: 14px;
  }

  .gallery-lightbox-image-shell {
    border-radius: 20px;
    overflow: hidden;
    padding: 16px;
    border: 1px solid rgba(255, 255, 255, 0.06);
    background:
      linear-gradient(180deg, rgba(255, 255, 255, 0.05), rgba(255, 255, 255, 0.02)),
      rgba(255, 255, 255, 0.03);
  }

  .gallery-lightbox-nav,
  .gallery-lightbox-caption {
    display: none;
  }

  .gallery-lightbox-strip-wrap {
    display: grid;
    gap: 8px;
  }

  .gallery-lightbox-strip-label {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.62rem;
    letter-spacing: 0.14em;
    text-transform: uppercase;
  }

  .gallery-lightbox-strip {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(64px, 1fr));
    gap: 8px;
  }

  .gallery-lightbox-thumb {
    width: 100%;
    padding: 0;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 14px;
    overflow: hidden;
    background: rgba(255, 255, 255, 0.04);
    aspect-ratio: 1 / 1;
    cursor: pointer;
  }

  .gallery-lightbox-thumb.active-thumb {
    border-color: rgba(255, 255, 255, 0.4);
    background: rgba(255, 255, 255, 0.12);
  }

  .gallery-lightbox-thumb-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  @media (max-width: 720px) {
    .gallery-lightbox {
      padding: 10px;
    }
  }
</style>
