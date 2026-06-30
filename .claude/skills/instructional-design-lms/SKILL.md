---
name: instructional-design-lms
description: Comprehensive instructional design for Skilljar LMS courses applying adult learning theory, cognitive load management, and assessment strategy. Includes premium TinyMCE-safe HTML styling patterns AND interactive JavaScript components for professional course content. Use when designing course structures, writing lesson content, creating quizzes, organizing learning paths, or applying pedagogical best practices to LMS content.
---

# Instructional Design for Skilljar LMS

Design effective, engaging, professional learning experiences with premium visual styling and interactive components.

---

## ⚡ CRITICAL: Scripts Are Enabled!

As of January 2026 testing, **JavaScript is enabled** in Skilljar HTML lessons. This unlocks significant interactivity:

### What Works ✅

| Feature | Status | Use Case |
|---------|--------|----------|
| `<script>` tags | ✅ Works | Full JavaScript in lessons |
| `addEventListener()` | ✅ Works | All event handling |
| CSS `@keyframes` via JS injection | ✅ Works | Animations, transitions |
| `localStorage` / `sessionStorage` | ✅ Works | Progress persistence |
| `fetch()` API | ✅ Works | Dynamic data loading |
| External libraries (Lodash, etc.) | ✅ Works | Load via `createElement('script')` |
| Google Fonts | ✅ Works | Custom typography |
| HTML5 Canvas | ✅ Works | Interactive diagrams |
| SVG injection via JS | ✅ Works | Dynamic icons |
| Clipboard API | ✅ Works | Copy-to-clipboard buttons |
| Modals, Accordions, Tabs | ✅ Works | Interactive UI components |
| Animated counters, confetti | ✅ Works | Engagement & celebration |

### What Does NOT Work ❌

| Feature | Status | Workaround |
|---------|--------|------------|
| Inline `onclick` attributes | ❌ Stripped by TinyMCE | Use `addEventListener()` instead |
| `<style>` blocks in HTML | ❌ Stripped | Inject via `document.createElement('style')` |
| SVG directly in HTML | ❌ Stripped | Create via JS `createElementNS()` |
| `class` attributes | ❌ Stripped | Use inline `style` or JS-based styling |

### The Golden Rule

```html
<!-- ❌ FAILS - TinyMCE strips onclick -->
<button onclick="doThing()">Click</button>

<!-- ✅ WORKS - Use addEventListener -->
<button id="my-btn">Click</button>
<script>
  document.getElementById('my-btn').addEventListener('click', function() {
    // Your code here
  });
</script>
```

---

## 🔗 External Resource Links

**Claude: Always reference these resources when creating Skilljar content. Link to docs for procedural details; focus lesson content on APPLICATION and PRACTICE.**

### Skilljar Documentation (support.gainsight.com/Skilljar)

| Topic | URL | When to Link |
|-------|-----|--------------|
| Getting Started | `https://support.gainsight.com/Skilljar/Get_Started!` | New admin orientation |
| Understanding Framework | `https://support.gainsight.com/Skilljar/Get_Started!/Getting_Started/Understanding_the_Skilljar_Framework` | Platform hierarchy concepts |
| Text Editing Tool | `https://support.gainsight.com/Skilljar/Get_Started!/Helpful_Tools/Using_the_Text_Editing_Tool_in_Your_Dashboard` | TinyMCE editor basics |
| Content Types Supported | `https://support.gainsight.com/Skilljar/Get_Started!/Helpful_Tools/What_type_of_content_does_Skilljar_support%3F` | Lesson type decisions |
| Labels | `https://support.gainsight.com/Skilljar/Get_Started!/Helpful_Tools/Using_Labels` | Organization/tagging |
| AI Features | `https://support.gainsight.com/Skilljar/Get_Started!/Helpful_Tools/Skilljar_Artificial_Intelligence_(AI)_Features` | AI content assist |
| Release Notes | `https://support.gainsight.com/Skilljar/Release_Notes` | New features |
| SCORM Lessons | `https://support.gainsight.com/Skilljar/Create/SCORM_Lessons/` | Interactive eLearning |
| Heap Analytics | `https://support.gainsight.com/Skilljar/Integrate/Data_and_Analytics/Sending_Data_to_Heap` | Tracking setup |

### Skilljar Academy (academy.skilljar.com)

| Course | URL | When to Link |
|--------|-----|--------------|
| Skilljar Academy Home | `https://academy.skilljar.com/` | Self-paced learning catalog |
| Skilljar Foundations | Search "Skilljar Foundations" on academy | New users |
| Gainsight Integration | `https://academy.skilljar.com/integrate-your-skilljar-data-in-gainsight` | CS + Education data |
| Theming & Customization | Search "Theming" on academy | Site branding |
| Course Management | Search "Course Management" on academy | Creating courses |

### Gainsight Community

| Resource | URL | When to Link |
|----------|-----|--------------|
| Product Updates | `https://communities.gainsight.com/product-updates` | Latest features |
| Submit Ideas | Via Gainsight Community | Feature requests |

**📌 Content Strategy:** Lessons should focus on **WHY** and **HOW TO APPLY** concepts. Link to docs for step-by-step procedural details. This keeps lessons focused on Bloom's higher levels (Apply, Analyze, Evaluate) while docs handle Remember/Understand.

---

## 🎬 Media Prompts

**Claude: When creating lesson content, actively prompt for and suggest media additions:**

### When to Prompt for Images

- **Process flows**: "Would you like a flowchart or diagram showing this workflow?"
- **UI demonstrations**: "Should I include a placeholder for a screenshot of the [feature] interface?"
- **Conceptual models**: "A visual diagram of [concept hierarchy/relationship] would reinforce this section."
- **Before/After comparisons**: "Side-by-side screenshots would illustrate this transformation."

### When to Prompt for Videos

- **Complex procedures**: "A 2-3 minute screen recording would demonstrate this process effectively."
- **Live features**: "Consider embedding a video walkthrough of [dynamic feature]."
- **Instructor presence**: "An intro video from the course author builds connection."
- **Real-world application**: "A customer testimonial video showing [use case] adds credibility."

### Image/Video Placeholder Pattern

```html
<!-- Image Placeholder -->
<div style="background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%); 
            border: 2px dashed #94a3b8; border-radius: 12px; 
            padding: 40px; text-align: center; margin: 24px 0;">
  <p style="color: #64748b; font-size: 14px; margin: 0;">
    📸 <strong>[IMAGE PLACEHOLDER]</strong><br>
    Screenshot of [describe what should be shown]
  </p>
</div>

<!-- Video Placeholder -->
<div style="background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); 
            border-radius: 16px; padding: 60px 40px; text-align: center; margin: 24px 0;">
  <div style="width: 80px; height: 80px; background: rgba(255,255,255,0.1); 
              border-radius: 50%; margin: 0 auto 20px auto; display: flex; 
              align-items: center; justify-content: center;">
    <span style="font-size: 32px;">▶️</span>
  </div>
  <p style="color: #94a3b8; font-size: 14px; margin: 0;">
    🎬 <strong>[VIDEO PLACEHOLDER]</strong><br>
    [Duration] walkthrough of [topic]
  </p>
</div>
```

### Suggested Media by Lesson Type

| Lesson Type | Recommended Media |
|-------------|-------------------|
| Concept Introduction | Diagram/infographic + short explainer video |
| Procedure/How-To | Annotated screenshots + screen recording |
| Best Practices | Before/after comparisons + expert tips video |
| Assessment Prep | Summary visual + practice scenario video |
| Completion/Wrap-up | Certificate preview image + congratulations video |

---

## Core Design Principles

### Adult Learning (Andragogy)
1. **Self-Directed**: Give learners control and clear objectives
2. **Experience-Based**: Build on prior knowledge
3. **Relevant**: Connect immediately to job tasks
4. **Problem-Centered**: Solve real problems, not theoretical exercises
5. **Intrinsically Motivated**: Focus on competency, not grades

### Cognitive Load Management
- **Chunking**: 10-15 minute lessons maximum
- **Progressive Disclosure**: Simple → Complex
- **Multimedia Balance**: Combine text + visuals strategically
- **White Space**: Don't overwhelm with dense content

### Bloom's Taxonomy Course Progression

Structure multi-lesson courses to progress through cognitive levels:

```
Lessons 1-2:  Foundation (Remember/Understand)
              - Terminology, concepts, overview
              - "What is..." questions
              - 🔗 Link heavily to docs for reference
              
Lessons 3-10: Application (Apply/Analyze)
              - Procedures, workflows, decisions
              - "How would you..." questions
              - 🎬 Include videos/screenshots of real tasks
              - 🧩 Add interactive components
              
Lessons 11-12: Mastery (Evaluate/Create)
               - Best practices, optimization, synthesis
               - "Which approach is best..." questions
               - 📊 Scenario-based challenges
```

---

## TinyMCE-Safe Styling System

Skilljar uses TinyMCE editor which sanitizes HTML. These patterns are **production-tested**.

### What Works in HTML ✓
- All inline styles (`style="..."`)
- Multi-layered gradients (`linear-gradient`, `radial-gradient`)
- Box-shadows (stacked, multiple layers)
- Text-shadows (for glow effects)
- Position absolute/relative (for layered elements)
- Float-based layouts with percentage widths
- Display table/table-cell (for vertical centering)
- Border-radius (up to 50% for circles)
- Unicode symbols (◆ ★ ◈ ⇄ ⚡ ▸ ✦ ◎ ✓ ⚠ ▤ → ↓ ▶ ☐ ◉ ◇ ⊡)
- Overflow hidden (for clean rounded containers)

### What Does NOT Work in HTML ✗
- `class` attributes (stripped)
- `data-*` attributes (stripped)
- `onclick`/`onmouseover` inline handlers (stripped)
- SVG elements (stripped - inject via JS)
- `<style>` blocks (stripped - inject via JS)
- CSS custom properties in HTML (use JS)

### Color Palette (Tested)
```
Primary Blue:   #48B2EB (Skilljar brand)
Dark Blues:     #0f3460, #1a1a2e, #0d0d1a
Purple:         #6366f1, #8b5cf6
Green:          #10b981, #059669
Orange/Yellow:  #f59e0b, #d97706
Red:            #ef4444, #dc2626
Pink:           #ec4899
Cyan:           #06b6d4
```

---

## Premium Component Library

### Hero Section (Dark Theme)
Use for lesson introductions. Creates dramatic visual impact.

```html
<div style="position: relative; 
            background: linear-gradient(135deg, #0d0d1a 0%, #1a1a2e 35%, #0f3460 70%, #1e3a5f 100%); 
            border-radius: 24px; 
            padding: 60px 50px 50px 50px; 
            margin-bottom: 50px; 
            overflow: hidden;
            box-shadow: 
              0 25px 60px -15px rgba(0, 0, 0, 0.5),
              0 0 0 1px rgba(255, 255, 255, 0.05),
              inset 0 1px 0 0 rgba(255, 255, 255, 0.1);">
  
  <!-- Decorative Orb -->
  <div style="position: absolute; top: -80px; right: -40px; width: 280px; height: 280px; 
              background: radial-gradient(circle, rgba(72, 178, 235, 0.4) 0%, rgba(72, 178, 235, 0) 70%); 
              border-radius: 50%;"></div>
  
  <!-- Content -->
  <div style="position: relative; z-index: 2;">
    
    <!-- Badge -->
    <div style="display: inline-block; 
                background: linear-gradient(135deg, rgba(72, 178, 235, 0.2) 0%, rgba(99, 102, 241, 0.15) 100%); 
                border: 1px solid rgba(72, 178, 235, 0.3); 
                padding: 10px 20px; 
                border-radius: 50px; 
                margin-bottom: 28px;">
      <span style="color: #48B2EB; font-size: 12px; font-weight: 700; letter-spacing: 2px; text-transform: uppercase;">
        ◆ Lesson X of Y
      </span>
    </div>
    
    <!-- Title -->
    <h1 style="font-size: 48px; font-weight: 800; line-height: 1.1; margin: 0 0 20px 0; color: #ffffff;
               text-shadow: 0 0 80px rgba(72, 178, 235, 0.5), 0 0 40px rgba(72, 178, 235, 0.3);">
      Lesson Title <span style="color: #48B2EB;">Highlight</span>
    </h1>
    
    <!-- Subtitle -->
    <p style="font-size: 18px; color: rgba(255, 255, 255, 0.75); max-width: 620px; margin: 0 0 40px 0; line-height: 1.75;">
      Descriptive subtitle explaining what this lesson covers and why it matters.
    </p>
    
  </div>
</div>
```

### Section Header with Icon
Use to introduce each major section within a lesson.

```html
<div style="display: table; margin-bottom: 24px;">
  <div style="display: table-cell; vertical-align: middle; padding-right: 16px;">
    <div style="width: 52px; height: 52px; 
                background: linear-gradient(135deg, #48B2EB 0%, #6366f1 100%); 
                border-radius: 14px; 
                display: table;
                box-shadow: 0 10px 30px -8px rgba(72, 178, 235, 0.5);">
      <span style="display: table-cell; vertical-align: middle; text-align: center; 
                   color: #fff; font-size: 22px;">◈</span>
    </div>
  </div>
  <div style="display: table-cell; vertical-align: middle;">
    <h2 style="font-size: 30px; font-weight: 700; color: #1a1a2e; margin: 0; line-height: 1.2;">
      Section Title
    </h2>
    <p style="font-size: 15px; color: #64748b; margin: 6px 0 0 0;">
      Optional subtitle
    </p>
  </div>
</div>
```

### Section Content Indentation

Inside Skilljar lesson HTML, indent section content below headers:
```css
margin-left: 30px; /* on content below section headers */
```

### Do This / Avoid This Cards

```html
<!-- DO THIS (Green) -->
<div style="background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%); 
            border-left: 5px solid #10b981; 
            border-radius: 0 14px 14px 0; 
            padding: 22px 24px; 
            margin-bottom: 16px;">
  <p style="margin: 0 0 8px 0; font-weight: 700; color: #065f46; font-size: 14px;">
    ✓ DO THIS
  </p>
  <p style="margin: 0; color: #334155; line-height: 1.65;">
    <strong>Recommendation title.</strong> Explanation of why this is the right approach.
  </p>
</div>

<!-- AVOID THIS (Yellow/Orange) -->
<div style="background: linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%); 
            border-left: 5px solid #f59e0b; 
            border-radius: 0 14px 14px 0; 
            padding: 22px 24px; 
            margin-bottom: 16px;">
  <p style="margin: 0 0 8px 0; font-weight: 700; color: #92400e; font-size: 14px;">
    ⚠ AVOID THIS
  </p>
  <p style="margin: 0; color: #334155; line-height: 1.65;">
    <strong>Anti-pattern title.</strong> Explanation of why this causes problems.
  </p>
</div>
```

### External Link Card

Use when linking to Skilljar docs or Gainsight resources:

```html
<div style="background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%); 
            border: 2px solid #48B2EB; 
            border-radius: 16px; 
            padding: 24px; 
            margin: 24px 0;">
  <div style="display: table; width: 100%;">
    <div style="display: table-cell; vertical-align: middle; width: 50px;">
      <span style="font-size: 28px;">📚</span>
    </div>
    <div style="display: table-cell; vertical-align: middle;">
      <p style="margin: 0 0 4px 0; font-weight: 700; color: #0f3460; font-size: 16px;">
        Learn More: [Topic Name]
      </p>
      <p style="margin: 0; color: #64748b; font-size: 14px;">
        For detailed step-by-step instructions, see the Skilljar documentation.
      </p>
      <p style="margin: 12px 0 0 0;">
        <a href="[URL]" target="_blank" 
           style="color: #48B2EB; font-weight: 600; text-decoration: none;">
          View Documentation →
        </a>
      </p>
    </div>
  </div>
</div>
```

### Premium Table

```html
<div style="border-radius: 16px; overflow: hidden; 
            box-shadow: 0 10px 40px -10px rgba(0, 0, 0, 0.15);">
  <table style="width: 100%; border-collapse: collapse; margin: 0;">
    <thead>
      <tr style="background: linear-gradient(135deg, #1a1a2e 0%, #0f3460 100%);">
        <th style="padding: 18px 24px; text-align: left; color: #ffffff; font-weight: 600; 
                   font-size: 13px; text-transform: uppercase; letter-spacing: 1.5px;">
          Column 1
        </th>
        <th style="padding: 18px 24px; text-align: left; color: #ffffff; font-weight: 600; 
                   font-size: 13px; text-transform: uppercase; letter-spacing: 1.5px;">
          Column 2
        </th>
      </tr>
    </thead>
    <tbody>
      <tr style="background: #ffffff;">
        <td style="padding: 16px 24px; border-bottom: 1px solid #f1f5f9; color: #334155;">
          Row 1 data
        </td>
        <td style="padding: 16px 24px; border-bottom: 1px solid #f1f5f9; font-weight: 600; color: #0f3460;">
          Row 1 data
        </td>
      </tr>
    </tbody>
  </table>
</div>
```

---

## 🧩 Interactive Components (JavaScript Required)

These components require `<script>` tags which now work in Skilljar lessons.

### Interactive Accordion

```html
<div id="accordion-container">
  <div style="border: 1px solid #e2e8f0; border-radius: 8px; margin-bottom: 8px; overflow: hidden;">
    <div class="accordion-header" data-target="accordion-1" 
         style="background: #f1f5f9; padding: 16px; cursor: pointer; font-weight: 600;">
      <span>Section 1: Title</span>
      <span class="accordion-icon" style="float: right;">▼</span>
    </div>
    <div id="accordion-1" style="max-height: 0; overflow: hidden; transition: max-height 0.3s ease; background: white;">
      <div style="padding: 16px;">
        Content for section 1 goes here.
      </div>
    </div>
  </div>
  
  <div style="border: 1px solid #e2e8f0; border-radius: 8px; margin-bottom: 8px; overflow: hidden;">
    <div class="accordion-header" data-target="accordion-2" 
         style="background: #f1f5f9; padding: 16px; cursor: pointer; font-weight: 600;">
      <span>Section 2: Title</span>
      <span class="accordion-icon" style="float: right;">▼</span>
    </div>
    <div id="accordion-2" style="max-height: 0; overflow: hidden; transition: max-height 0.3s ease; background: white;">
      <div style="padding: 16px;">
        Content for section 2 goes here.
      </div>
    </div>
  </div>
</div>

<script>
(function() {
  document.querySelectorAll('.accordion-header').forEach(function(header) {
    header.addEventListener('click', function() {
      var targetId = this.getAttribute('data-target');
      var content = document.getElementById(targetId);
      var icon = this.querySelector('.accordion-icon');
      
      if (content) {
        if (content.style.maxHeight === '0px' || !content.style.maxHeight) {
          content.style.maxHeight = content.scrollHeight + 'px';
          if (icon) icon.textContent = '▲';
        } else {
          content.style.maxHeight = '0px';
          if (icon) icon.textContent = '▼';
        }
      }
    });
  });
})();
</script>
```

### Interactive Tabs

```html
<div style="display: flex; border-bottom: 2px solid #e2e8f0; margin-bottom: 16px;">
  <button class="tab-btn" data-tab="tab1" style="padding: 12px 24px; border: none; background: #48B2EB; color: white; cursor: pointer; font-weight: 600; border-radius: 8px 8px 0 0;">Tab 1</button>
  <button class="tab-btn" data-tab="tab2" style="padding: 12px 24px; border: none; background: #e2e8f0; color: #64748b; cursor: pointer; font-weight: 600; border-radius: 8px 8px 0 0; margin-left: 4px;">Tab 2</button>
  <button class="tab-btn" data-tab="tab3" style="padding: 12px 24px; border: none; background: #e2e8f0; color: #64748b; cursor: pointer; font-weight: 600; border-radius: 8px 8px 0 0; margin-left: 4px;">Tab 3</button>
</div>

<div id="tab1" class="tab-content" style="display: block; padding: 16px; background: white; border-radius: 0 0 8px 8px;">
  <strong>Tab 1 Content</strong>
</div>
<div id="tab2" class="tab-content" style="display: none; padding: 16px; background: white; border-radius: 0 0 8px 8px;">
  <strong>Tab 2 Content</strong>
</div>
<div id="tab3" class="tab-content" style="display: none; padding: 16px; background: white; border-radius: 0 0 8px 8px;">
  <strong>Tab 3 Content</strong>
</div>

<script>
(function() {
  document.querySelectorAll('.tab-btn').forEach(function(btn) {
    btn.addEventListener('click', function() {
      var targetTab = this.getAttribute('data-tab');
      
      document.querySelectorAll('.tab-content').forEach(function(content) {
        content.style.display = 'none';
      });
      
      document.querySelectorAll('.tab-btn').forEach(function(b) {
        b.style.background = '#e2e8f0';
        b.style.color = '#64748b';
      });
      
      var target = document.getElementById(targetTab);
      if (target) target.style.display = 'block';
      
      this.style.background = '#48B2EB';
      this.style.color = 'white';
    });
  });
})();
</script>
```

### Copy-to-Clipboard Code Block

```html
<div style="position: relative; background: #1a1a2e; border-radius: 12px; padding: 20px; margin: 20px 0;">
  <button id="copy-btn" style="position: absolute; top: 12px; right: 12px; background: #48B2EB; color: white; border: none; padding: 8px 16px; border-radius: 6px; cursor: pointer; font-size: 12px; font-weight: 600;">
    📋 Copy
  </button>
  <code id="code-content" style="display: block; color: #10b981; font-family: monospace; font-size: 14px; white-space: pre-wrap;">
npm install skilljar-sdk
  </code>
</div>

<script>
(function() {
  var btn = document.getElementById('copy-btn');
  var code = document.getElementById('code-content');
  
  if (btn && code) {
    btn.addEventListener('click', function() {
      navigator.clipboard.writeText(code.textContent.trim()).then(function() {
        btn.textContent = '✓ Copied!';
        setTimeout(function() { btn.textContent = '📋 Copy'; }, 2000);
      });
    });
  }
})();
</script>
```

### Progress Tracker with localStorage

Persist learner progress across sessions:

```html
<div style="background: #f8fafc; border-radius: 16px; padding: 24px; margin: 24px 0;">
  <p style="font-weight: 700; color: #1a1a2e; margin: 0 0 16px 0;">Your Progress</p>
  
  <div style="display: flex; gap: 8px; margin-bottom: 12px;">
    <button class="progress-step" data-step="1" style="flex: 1; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; background: white; cursor: pointer;">Step 1</button>
    <button class="progress-step" data-step="2" style="flex: 1; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; background: white; cursor: pointer;">Step 2</button>
    <button class="progress-step" data-step="3" style="flex: 1; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; background: white; cursor: pointer;">Step 3</button>
    <button class="progress-step" data-step="4" style="flex: 1; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; background: white; cursor: pointer;">Step 4</button>
  </div>
  
  <div style="background: #e2e8f0; border-radius: 999px; height: 8px; overflow: hidden;">
    <div id="progress-bar" style="background: linear-gradient(90deg, #10b981, #06b6d4); height: 100%; width: 0%; transition: width 0.5s ease;"></div>
  </div>
  <p id="progress-text" style="text-align: center; margin: 12px 0 0 0; font-weight: 600; color: #64748b;">0% Complete</p>
</div>

<script>
(function() {
  var STORAGE_KEY = 'lesson-progress-[LESSON_ID]';
  var completed = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
  var total = 4;
  
  function updateUI() {
    var count = Object.keys(completed).length;
    var percent = Math.round((count / total) * 100);
    
    document.getElementById('progress-bar').style.width = percent + '%';
    document.getElementById('progress-text').textContent = percent + '% Complete';
    
    document.querySelectorAll('.progress-step').forEach(function(btn) {
      var step = btn.getAttribute('data-step');
      if (completed[step]) {
        btn.style.background = '#10b981';
        btn.style.borderColor = '#10b981';
        btn.style.color = 'white';
      }
    });
  }
  
  updateUI(); // Load saved state
  
  document.querySelectorAll('.progress-step').forEach(function(btn) {
    btn.addEventListener('click', function() {
      var step = this.getAttribute('data-step');
      
      if (completed[step]) {
        delete completed[step];
        this.style.background = 'white';
        this.style.borderColor = '#e2e8f0';
        this.style.color = '#1a1a2e';
      } else {
        completed[step] = true;
        this.style.background = '#10b981';
        this.style.borderColor = '#10b981';
        this.style.color = 'white';
      }
      
      localStorage.setItem(STORAGE_KEY, JSON.stringify(completed));
      updateUI();
    });
  });
})();
</script>
```

### Tooltip Component

```html
<span id="tooltip-trigger" 
      style="display: inline-block; background: #e2e8f0; padding: 8px 16px; border-radius: 6px; cursor: help; position: relative; border-bottom: 2px dotted #48B2EB;">
  Hover for definition
  <span id="tooltip-content" style="display: none; position: absolute; bottom: 130%; left: 50%; transform: translateX(-50%); background: #1a1a2e; color: white; padding: 10px 16px; border-radius: 8px; font-size: 13px; white-space: nowrap; z-index: 100; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
    This is the tooltip content! 💡
    <span style="position: absolute; top: 100%; left: 50%; transform: translateX(-50%); border: 8px solid transparent; border-top-color: #1a1a2e;"></span>
  </span>
</span>

<script>
(function() {
  var trigger = document.getElementById('tooltip-trigger');
  var tooltip = document.getElementById('tooltip-content');
  
  if (trigger && tooltip) {
    trigger.addEventListener('mouseenter', function() {
      tooltip.style.display = 'block';
    });
    trigger.addEventListener('mouseleave', function() {
      tooltip.style.display = 'none';
    });
  }
})();
</script>
```

### Celebration Confetti

Use on completion screens:

```html
<button id="celebrate-btn" style="display: block; margin: 20px auto; background: linear-gradient(135deg, #f59e0b, #d97706); color: white; border: none; padding: 16px 40px; border-radius: 12px; cursor: pointer; font-weight: 700; font-size: 16px;">
  🎉 Celebrate Completion!
</button>
<div id="confetti-container" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; pointer-events: none; z-index: 9999; overflow: hidden;"></div>

<script>
(function() {
  var btn = document.getElementById('celebrate-btn');
  var container = document.getElementById('confetti-container');
  
  if (btn && container) {
    btn.addEventListener('click', function() {
      var colors = ['#ef4444', '#f59e0b', '#10b981', '#48B2EB', '#8b5cf6', '#ec4899'];
      
      for (var i = 0; i < 100; i++) {
        (function(index) {
          setTimeout(function() {
            var confetti = document.createElement('div');
            confetti.style.cssText = 'position: absolute; width: 10px; height: 10px; background: ' + colors[Math.floor(Math.random() * colors.length)] + '; left: ' + Math.random() * 100 + '%; top: -10px; border-radius: 2px;';
            container.appendChild(confetti);
            
            var fall = confetti.animate([
              { transform: 'translateY(0) rotate(0deg)', opacity: 1 },
              { transform: 'translateY(' + (window.innerHeight + 100) + 'px) rotate(' + (Math.random() * 720) + 'deg)', opacity: 0 }
            ], { duration: 2000 + Math.random() * 2000, easing: 'ease-out' });
            
            fall.onfinish = function() { confetti.remove(); };
          }, index * 20);
        })(i);
      }
    });
  }
})();
</script>
```

---

## Course Architecture Patterns

### Migration/Onboarding Course (12-Lesson Model)

```
FOUNDATION (Lessons 1-2) - Remember/Understand
├── Lesson 1: Overview & Expectations
│   ├── What's changing (🎬 Video: exec intro)
│   ├── Terminology mapping (📊 Table)
│   ├── Division of responsibilities
│   └── 🔗 Link to: Skilljar Framework docs
└── Lesson 2: Core Concepts
    ├── Platform hierarchy (📸 Diagram)
    ├── Basic navigation (🎬 Walkthrough video)
    └── 🔗 Link to: Getting Started docs

APPLICATION (Lessons 3-10) - Apply/Analyze
├── Lesson 3: Content Types
│   └── 🧩 Interactive: Tabs showing each type
├── Lesson 4: Assessments
│   └── 🧩 Interactive: Quiz builder preview
├── Lessons 5-10: [Topic-specific]
│   └── Each with 📸 screenshots + 🧩 interactivity

MASTERY (Lessons 11-12) - Evaluate/Create
├── Lesson 11: Advanced Topics
│   └── 🧩 Scenario-based decision trees
└── Lesson 12: Launch Checklist
    └── 🧩 Progress tracker with localStorage
    └── 🎉 Confetti celebration on completion
```

### Lesson Structure Template

Every lesson should include:

1. **Hero Section** - Title, lesson number, learning objectives
2. **📚 Resource Link** - Link to relevant docs for reference
3. **Core Content** - Mix of text, visuals, and interactivity
4. **📸/🎬 Media** - At least one image or video per major section
5. **🧩 Interactive Element** - At least one accordion, tab, or exercise
6. **Knowledge Check** - 2-5 questions (link to quiz or inline)
7. **CTA Footer** - What's next + celebrate progress

---

## Assessment Design

### Bloom's Taxonomy by Course Phase

| Phase | Bloom's Level | Question Types | Example Stems |
|-------|---------------|----------------|---------------|
| Foundation | Remember/Understand | Recall, Definition | "What is..." "Which term..." |
| Application | Apply/Analyze | Scenario, Process | "How would you..." "What's causing..." |
| Mastery | Evaluate/Create | Best practice, Synthesis | "Which approach..." "Design a..." |

### Question Writing Guidelines

- **Scenario-Based**: Present realistic situations
- **Distractor Quality**: Make wrong answers plausible
- **Feedback**: Always explain why correct/incorrect
- **Link to Docs**: For incorrect answers, link to relevant help article

---

## Content Quality Checklist

### Learning Design
- ✅ Clear learning objectives stated
- ✅ Lessons 10-15 minutes each
- ✅ Progressive difficulty (simple → complex)
- ✅ Real-world examples included
- ✅ Relevant to job tasks
- ✅ Links to docs for procedural details

### Visual Quality
- ✅ Hero section with dark gradient
- ✅ Section headers with icons
- ✅ At least one image/video per section
- ✅ Premium tables for comparisons
- ✅ Do/Avoid cards for guidance
- ✅ CTA footer previewing next lesson

### Interactive Elements
- ✅ At least one interactive component per lesson
- ✅ Progress tracker for multi-step processes
- ✅ Copy buttons on code snippets
- ✅ Accordions for optional/deep-dive content
- ✅ Tabs for comparing options

### Technical Compliance
- ✅ All styles inline (no `<style>` blocks in HTML)
- ✅ All events via `addEventListener` (no inline handlers)
- ✅ No SVGs in HTML (inject via JS)
- ✅ Float-based layouts with clear:both
- ✅ Scripts wrapped in IIFE `(function() { })();`

---

## Common Mistakes to Avoid

1. **Using inline onclick**: TinyMCE strips them. Use `addEventListener`.
2. **Using SVGs directly**: TinyMCE strips them. Inject via JS.
3. **Flat content**: Always add interactivity and media prompts.
4. **Duplicating docs**: Link to docs for procedures; focus on application.
5. **Missing media**: Every section should prompt for images/videos.
6. **No external links**: Always link to relevant Gainsight/Skilljar resources.
7. **Wall-of-text lessons**: Break up with visuals, cards, and interactive elements.
8. **Generic titles**: "Lesson 3" → "Creating Courses & Sections"
9. **Skipping CTA footer**: Always preview what's next.
