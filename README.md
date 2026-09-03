# The GPU Sweet Spot: Ready for GTA VI?

### A data-driven GPU market and gaming-demand analysis to identify the best-value hardware for mainstream gamers

---

## Executive Summary

The PC gaming GPU market presents a practical product-positioning question:

 >**Which GPUs should manufacturers and gamers focus on if the goal is to serve the largest mainstream gaming audience while providing enough performance and VRAM for modern AAA games and prepare for a future flagship title such as GTA VI?**

This project connects **GPU ownership, GPU pricing, game popularity, game genres, hardware requirements, performance, VRAM, and price efficiency** to answer that question.

Rather than treating GPU performance in isolation, the analysis follows the customer journey:

**Which GPUs are the most popular? → What games are the most popular? → What hardware do those games require? → Which GPUs satisfy those requirements? → Which GPUs price point is most popular? → Which GPU can offer best Value while still meeting latest AAA game requirements?**

The final recommendation focuses on GPUs within the **$300–$499 launch-MSRP segment**, evaluated against the requirements of the most relevant modern gaming genres and using **performance, VRAM, and price-to-performance** as the core decision criteria.

> **GTA VI is used as the strategic target use case—not as a measured hardware requirement.** The empirical hardware benchmark comes from modern 2023–2025 games, particularly the Action genre.

---

# 1. Business Questions

The analysis was designed around the decisions different stakeholders would need to make.

### Product / GPU Marketing

> **Which GPU price segment represents the strongest mainstream ownership opportunity, and what level of performance and VRAM should products in that segment target?**

### Product Management

> **What hardware specification is sufficient to serve the majority of gamers playing the most popular modern game genres?**

### Marketing

> **Which gaming audiences should GPU products be positioned toward, and what hardware capabilities matter most to those audiences?**

### Consumer / Buyer

> **Within a realistic $200–$599 budget, which GPUs provide the strongest combination of performance, VRAM, and price efficiency for modern AAA gaming?**

### Strategic / Future-Facing

> **Which mainstream GPU products are best positioned for gamers preparing for the next generation of major AAA releases, with GTA VI as the flagship use case?**

---

# 2. North Star Metrics

The project uses a small set of metrics that connect market demand to product fit.

| North Star Metric           | Why it matters                                                                    |
|-----------------------------|------------------------------------------------------------------------------------|
| **GPU Ownership Share (%)** | Measures the size of the existing hardware market                                 |
| **Recommended GPU**         | The GPU recommended by the game developer                                         |
| **Peak CCU**                | Measures the number of active players in-game                                     |
| **GPU Performance**         | Defines the performance level required to run the game smoothly                   |


Later in the analysis, the P75 of GPU_Performance is used for the main recommendation.

This avoids allowing a small number of extreme titles to determine the hardware recommendation while still targeting the demanding upper portion of the market.

---

# 3. Data

The project combines three analytical layers.

### GPU Ownership / Market Data

Provides:

* GPU model
* GPU ownership share
* historical SHS dates

### Game Data

Provides:

* Game
* AppID
* Release date
* Peak concurrent users
* CCU rank
* Recommended GPU
* Genre
* Genre classification

### GPU Model Data

Provides:

* GPU model
* GPU class
* GPU series
* VRAM
* performance
* launch year
* launch MSRP
* price-to-performance
* availability

The three datasets were joined to connect:

**Game demand → recommended GPU → GPU performance → VRAM → price → value**

This creates the analytical bridges between **what gamers play**, **what hardware they need** and **what GPU can we recommend to largest section of players**

---

# 4. Analytical Scope

To keep the analysis focused on modern, demanding PC gaming, the hardware requirement analysis uses:

* Games released from **2023 through 2025**
* Recommended GPU classes: **Mid, Mid+, Top, Top+**
* Recommended GPUs launched in **2018 or later**
* APUs, Bottom, and Lower GPU classes excluded from the demanding-game benchmark

The purpose of the GPU-class filter is deliberate.

A low-end GPU appearing as a recommendation does not provide useful information for defining the hardware threshold of modern demanding games. The analysis therefore focuses on the GPU tiers that represent meaningful performance requirements.

The SQL workflow explicitly implements these filters and calculates mean, median, P75, P90, and maximum GPU performance.

---

# 5. Data Preparation & Quality

The datasets were prepared across Excel, Power Query, SQL, and Python.

### Key preparation decisions

**1. Establishing analytical grain**

The game dataset contains multiple rows for the same game because a game can belong to multiple genres.

Therefore, genre-level analysis is performed at the:

> **Game × Genre**

level rather than treating every physical row as an independent game.

This prevents genre duplication from artificially increasing game counts or distorting the analysis.

**2. GPU history**

The GPU ownership dataset contains multiple observations of the same GPU across dates.

For current product comparison, the analysis uses the **latest available observation for each GPU model** rather than treating historical observations as separate products.

**3. Modern-game filtering**

The hardware requirement benchmark is restricted to recent games and meaningful GPU classes rather than allowing legacy or entry-level hardware to dilute the result.

**4. Requirement thresholds**

Percentiles are used instead of relying exclusively on averages because the objective is to identify a practical hardware threshold rather than describe a statistical center point.

---

# 6. Market Opportunity: Where Is the GPU Ownership Concentrated?

The first question is not "Which GPU is fastest?"

It is:

> **Where is the existing customer base?**
<img width="653" height="366" alt="Screenshot 2026-08-27 002706" src="https://github.com/user-attachments/assets/5878dc02-0dbf-4a95-8765-2f9e75012335" />

The latest SHS snapshot shows that GPU ownership is concentrated in the mainstream market rather than at the high end.
<img width="654" height="367" alt="GPU_price segments" src="https://github.com/user-attachments/assets/c6b55865-6c1f-4268-ba54-bcbb9ceda304" />

Within the Mid and Mid+ classes, the **$300–$399 launch-price band** is the largest individual bracket, with approximately **24.82% combined GPU ownership share** in the latest snapshot.
<img width="654" height="368" alt="GPU_price segments" src="https://github.com/user-attachments/assets/fd0c4d78-3997-42e1-9dba-7ef705753fd6" />

The adjacent **$400–$499 segment contributes another 19.62%**, giving the broader $300–$499 range a substantial mainstream installed base.

### Why this matters

This changes the product question.

A manufacturer does not necessarily maximize market opportunity by producing the fastest GPU.

The stronger opportunity is:

> **How much gaming capability can be delivered inside the price range where a large installed customer base already exists?**

This makes the $300–$499 range the project's primary product-positioning zone.

---

# 7. Where Is the Gaming Demand?

The next step is to identify the genres generating the largest player audiences.
<img width="653" height="368" alt="App_ID num" src="https://github.com/user-attachments/assets/e5851eb6-b669-4123-b3a1-523eb4dc0f92" />
<img width="652" height="366" alt="Player num" src="https://github.com/user-attachments/assets/1a27fa00-521f-4c40-adc3-91df64067dfb" />

Using Peak CCU as the player-demand metric, **Action is the dominant core gaming genre in the dataset**, with approximately **4.53 million aggregate peak concurrent users** across the games classified under Action.

Adventure follows at approximately **1.89 million**, while RPG contributes approximately **1.57 million**.

| Genre         | Games | Aggregate Peak CCU |
| ------------- | ----: | -----------------: |
| **Action**    |   499 |          **4.53M** |
| **Adventure** |   363 |          **1.89M** |
| **RPG**       |   317 |          **1.57M** |

### Business implication

Action is not simply another large genre.

Its player demand is substantially larger than Adventure or RPG in this dataset.

That makes Action the most important genre for the hardware recommendation:

> **A GPU positioned for the mainstream gaming market should be capable of serving the hardware requirements of modern Action titles.**
<img width="237" height="365" alt="Latest Gpu_perf_VRAM" src="https://github.com/user-attachments/assets/6ca5a8e7-5fbf-4633-99ea-e4ff66d634e2" />

This is also why GTA VI is an appropriate strategic use case for the project: the game is being treated as a future flagship Action title rather than as the source of the measured hardware requirement.

---

# 8. The Hardware Requirement: How Much GPU Is Actually Needed?

The analysis then moves from player demand to hardware requirements.

For modern games released between 2023 and 2025, only Mid through Top+ recommended GPU classes and GPUs launched from 2018 onward were retained.

For Action games specifically, the resulting hardware requirement distribution produces:
<img width="653" height="365" alt="Series" src="https://github.com/user-attachments/assets/99075ca5-fb65-45fa-b621-392a9b3ee959" />

### Performance

* **Median:** 65
* **P75:** **75**
* **P90:** 80
* **Maximum:** 85

### VRAM

* **Median:** 8 GB
* **P75:** **10.75 GB**
* **P90:** 12 GB
* **Maximum:** 16 GB

### Why P75 is the primary threshold

The objective is not to identify the single most demanding game.

Using the maximum would effectively turn the recommendation into an extreme high-end requirement.

Instead:

> **P75 Performance = 75**

means the recommended GPU performance threshold is positioned around the upper quartile of the selected Action-game requirement distribution.

Similarly:

> **P75 VRAM = 10.75 GB**

means a GPU needs roughly **12 GB of physical VRAM or more** to clear the practical threshold because real GPU memory configurations are discrete.

This produces the project's core hardware target:

## **Performance ≥ 75 + VRAM ≥ 12 GB**

That becomes the qualification threshold for candidate GPUs.

---

# 9. Translating Requirements Into Products

The analysis now connects the game requirement back to the GPU market.

Candidate products must satisfy:

* Launch MSRP: **$300–$499**
* Performance: **≥ 75**
* VRAM: **≥ 12 GB**
* Available product specifications in the latest GPU snapshot

This converts an abstract requirement into an actionable product shortlist.

The SQL analysis explicitly filters the latest GPU records to the $300–$499 segment and applies the performance and VRAM thresholds before ranking products by price-to-performance.

---

# 10. Candidate GPU Landscape

The qualifying products include GPUs such as:

| Model            | Performance | VRAM | Launch MSRP | Price per Dollar | GPU Class | GPU Series |
|------------------|------------:|-----:|------------:|-----------------:|-----------|------------|
| **RX 7600 XT**   | 75 | 16 GB | $329 | 23.000 | Mid | R7000 |
| **RX 9060 XT**   | 80 | 16 GB | $359 | 22.000 | Mid | R9000 |
| **RTX 5060 Ti**  | 85 | 16 GB | $429 | 20.000 | Mid | GF50 |
| **RX 9070 XT**   | 90 | 16 GB | $499 | 18.000 | Mid+ | R9000 |
| **RX 7800 XT**   | 80 | 16 GB | $499 | 16.000 | Top | R7000 |
| **RTX 4060 Ti**  | 80 | 16 GB | $499 | 16.000 | Mid | GF40 |
| **RX 6700 XT**   | 75 | 12 GB | $479 | 16.000 | Mid+ | R6000 |
| **RX 6750 XT**   | 75 | 12 GB | $499 | 15.000 | Mid+ | R6000 |

This reveals an important product-market trade-off.

### The cheapest qualifying product is not automatically the best product.

The RX 7600 XT provides:

* 16 GB VRAM
* Performance score of 75
* $329 launch MSRP
* High price-to-performance

But the RTX 5060 Ti provides:

* 16 GB VRAM
* Performance score of 85
* $429 launch MSRP
* substantially higher performance headroom

Therefore, **value and performance lead to different recommendations**.

That distinction becomes important in the final decision model.

---

# 11. The Three Buyer Profiles

Rather than claiming there is one objectively "best" GPU, the project evaluates three decision priorities.

### Value-focused

Prioritizes:

**Price-to-performance > Performance > VRAM**

This represents a budget-conscious buyer who wants to satisfy the gaming requirement at the lowest effective cost.

### Balanced

Prioritizes:

**Performance + VRAM + Price efficiency**

This represents the mainstream buyer who wants a reasonable combination of capability and longevity.

### Performance-focused

Prioritizes:

**Performance > VRAM > Price efficiency**

This represents a buyer willing to spend toward the upper end of the budget to gain additional performance headroom.

This framework is implemented in Python as a sensitivity analysis rather than being hard-coded into the SQL analysis.

---

# 12. Key Insights

## Insight 1 — The rising cost of GPUs and corresponding performance requirements for new games

The ownership data points toward people moving away from lower end sub $299 GPUs towards **$300–$399** range as the lower end cards of the new generation can't run modern games and haven't been updated like the Mid and Mid+ cards above them. The VRAM required to run the games is also not met by most of them. 
<img width="351" height="181" alt="GPU_VRAM Corealation" src="https://github.com/user-attachments/assets/3669fad9-edb0-4d9b-85a6-80d025cae46d" />


GPUs are themselves getting more pricy due to VRAM shortages and low margins on lower end cards vs higher end cards.
<img width="527" height="232" alt="GPU_MSRP" src="https://github.com/user-attachments/assets/34ea8ad6-d160-4752-bd7c-55bdb2ae00f6" />

And finally games too are becoming more taxing to run year by year.
<img width="654" height="328" alt="GPU_Perf creep" src="https://github.com/user-attachments/assets/2b81d595-9b8d-45d4-9290-5c5638a39f21" />

### Business value

For GPU manufacturers and marketers, the opportunity is not simply:

> "Build the fastest GPU."

It is:

> **"Deliver enough performance for the games customers actually care about inside the price band where a large installed base already exists."**

---
## Insight 2 — The opportunity is in mainstream capability, not maximum performance

The ownership data points toward the mainstream GPU market rather than the enthusiast segment.

The largest Mid/Mid+ launch-price bracket is **$300–$399**, while the adjacent $400–$499 range also carries meaningful ownership.

This suggests that a GPU product strategy focused around **$300–$499** is addressing a substantially larger potential customer base than an exclusively high-end strategy.

### Business value

For GPU manufacturers and marketers, the opportunity is not simply:

> "Build the fastest GPU."

It is:

> **"Deliver enough performance for the games customers actually care about inside the price band where a large installed base already exists."**

---

## Insight 3 — Action is the strongest gaming demand signal

Action games generate approximately **4.53M aggregate Peak CCU**, substantially ahead of Adventure and RPG.

This makes Action the most commercially important genre in the project's core gaming audience.

### Business value

If a GPU manufacturer wants a mainstream product to resonate with the largest gaming audience represented in the dataset, **Action-game performance should be a primary product-positioning benchmark**.

---

## Insight 4 — The Action-game performance threshold is surprisingly moderate relative to the high end

The Action-game distribution produces:

* P50 = 65
* P75 = **75**
* P90 = 80
* Maximum = 85

The gap between P75 and the maximum is only **10 performance points**.

This indicates that the requirement to cover most modern Action games is materially lower than the requirement implied by the single most demanding title.

### Business value

A mainstream GPU does not need flagship-class performance to serve a large portion of the Action-game market.

This supports a **mainstream-performance strategy rather than an enthusiast-only strategy**.

---

## Insight 5 — VRAM is the constraint that changes the shortlist
<img width="351" height="181" alt="GPU_VRAM Corealation" src="https://github.com/user-attachments/assets/7baa784c-22b1-44d6-979e-c17e4f912b9b" />

The Action-game P75 VRAM requirement is **10.75 GB**, effectively creating a **12 GB practical threshold**.

This immediately eliminates many otherwise capable 8 GB products from the recommendation pool.

### Business value

For modern AAA positioning, **VRAM capacity becomes a product qualification metric, not merely a specification to list on a product page**.

A GPU can have sufficient raw performance but still fail the project's practical requirement if its memory capacity is below the threshold.

---

## Insight 6 — Price efficiency alone produces a different answer from raw performance

The candidate list demonstrates a clear trade-off.

The **RX 7600 XT** has the strongest price-to-performance position among the qualifying candidates, while the **RTX 5060 Ti** delivers materially higher performance and still remains inside the target $300–$499 launch-price band.

This means:

> **"Best value" and "best performance" are not the same recommendation.**

### Business value

A GPU marketer should not position every product around a single universal value proposition.

Instead:

* Entry of the mainstream segment → **value**
* Middle of the target segment → **balanced performance/value**
* Upper end of the segment → **performance headroom**

This creates clearer product segmentation.

---

## Insight 7 — The $300–$499 range contains enough performance headroom for future-facing positioning

The candidate pool contains GPUs reaching **85 performance** with **16 GB VRAM**, while the Action P75 requirement is only 75 performance and 10.75 GB VRAM.

That creates meaningful headroom above the core requirement.

The implication is important:

> **The mainstream segment is not necessarily synonymous with low performance.**

A well-positioned $400–$499 GPU can provide substantially more headroom than the minimum threshold while remaining within the target consumer budget.

---

## Insight 8 — The recommendation should be framed as "fit," not "best GPU"

The analysis does not produce one universally superior product.

Instead, it identifies the best product **given a buyer's objective function**.

That is why the final Python model evaluates:

* Value-focused weighting
* Balanced weighting
* Performance-focused weighting

A recommendation that remains near the top under different weighting assumptions is more robust than one that wins only because of a single arbitrary metric.

---

# 13. Final Recommendation

The analysis does not identify one universally "best" GPU. Instead, the optimal product depends on the buyer's priority between **value, balanced capability, and performance headroom**.

The candidate pool contains eight GPUs that satisfy the project's core requirements:

- Launch MSRP: **$300–$499**
- GPU Performance: **≥ 75**
- VRAM: **≥ 12 GB**
- Latest available GPU specification
- Suitable for the modern Action-game requirement benchmark

The resulting recommendation is therefore segmented into three buyer profiles.

| Position | GPU | Performance | VRAM | Launch MSRP | Price/Performance | Fit Score |
|---|---|---:|---:|---:|---:|---:|
| **Best Value** | **RX 7600 XT** | 75 | 16 GB | $329 | 23 | **0.850** |
| **Best Balanced** | **RX 9060 XT** | 80 | 16 GB | $359 | 22 | **0.771** |
| **Best Performance** | **RX 9070 XT** | 90 | 16 GB | $499 | 18 | **0.969** |

---

## Best Value — RX 7600 XT

The **RX 7600 XT** is the strongest choice for a price-sensitive buyer.

At a **$329 launch MSRP**, it is the least expensive GPU in the qualifying pool while still meeting the project's Action-game thresholds:

- Performance = **75**
- VRAM = **16 GB**
- Price-to-performance = **23**

Its **0.850 Value-focused Fit Score** demonstrates that its competitive advantage comes from delivering the required gaming capability at the lowest entry price.

### Why it matters

The RX 7600 XT represents the **accessibility end of the $300–$499 opportunity**.

For a manufacturer targeting price-sensitive mainstream gamers, the proposition is straightforward:

> **Meet the identified gaming requirement while minimizing the customer's upfront cost.**

---

## Best Balanced — RX 9060 XT

The **RX 9060 XT** is the strongest overall fit for the project's mainstream positioning.

It combines:

- Performance = **80**
- VRAM = **16 GB**
- Launch MSRP = **$359**
- Price-to-performance = **22**

Most importantly, it occupies a compelling position between the two extremes.

It provides **5 points of additional performance above the Action P75 threshold** while remaining only **$30 more expensive than the RX 7600 XT**.

This makes it particularly attractive for the project's central objective:

> **Deliver enough performance and VRAM for modern AAA gaming without pushing the consumer toward the top of the budget range.**

### Why this is the overall recommendation

The RX 9060 XT is not the cheapest qualifying GPU and it is not the fastest.

That is precisely why it is the strongest **balanced** recommendation.

It sits in the middle of the performance/value trade-off:

**RX 7600 XT → lower cost / lower performance**

**RX 9060 XT → moderate cost / higher performance**

**RX 9070 XT → maximum performance / maximum budget**

For the mainstream customer the project is targeting, the RX 9060 XT provides the most compelling compromise between these objectives.

---

## Best Performance — RX 9070 XT

The **RX 9070 XT** is the performance leader within the target price segment.

Its specifications are:

- Performance = **90**
- VRAM = **16 GB**
- Launch MSRP = **$499**
- Price-to-performance = **18**
- Performance-focused Fit Score = **0.969**

Its performance is substantially above the Action-game P75 threshold of 75.

It also provides the highest performance score among the qualifying GPUs while remaining within the project's **$300–$499 price ceiling**.

### Why it matters

The RX 9070 XT represents the **upper boundary of the mainstream opportunity**.

It is appropriate for customers who are willing to spend the full budget in exchange for additional performance headroom.

Its positioning is therefore different from the RX 7600 XT:

> **RX 7600 XT sells affordability.**

> **RX 9070 XT sells performance headroom.**

---

# 14. Overall Recommendation

## **RX 9060 XT — Best Balanced Mainstream Recommendation**

For the specific objective of this project, the **RX 9060 XT is the strongest overall recommendation**.

The reason is not that it has the highest Fit Score under every weighting scenario. It does not.

Instead, it provides the strongest **market-positioning balance**:

- **$359** launch MSRP keeps it comfortably within the $300–$499 target segment.
- **16 GB VRAM** exceeds the practical P75 VRAM threshold of approximately 12 GB.
- **80 performance** exceeds the Action-game P75 performance threshold of 75.
- **Price-to-performance of 22** remains close to the value leader at 23.
- It provides additional performance headroom over the RX 7600 XT without requiring the full $499 budget of the RX 9070 XT.

This makes it the best representation of the project's central proposition:

> **A mainstream GPU should not simply meet the minimum requirement—it should provide meaningful performance and VRAM headroom while remaining accessible to the largest practical customer segment.**

---

# 15. Product Positioning Strategy

The analysis therefore supports a three-tier marketing strategy within the $300–$499 segment:

### $300–$399 — Accessible AAA Gaming

**RX 7600 XT**

Position around:

- affordability
- 16 GB VRAM
- meeting modern game requirements
- maximum value

**Target customer:** budget-conscious gamer.

---

### $350–$450 — Mainstream Sweet Spot

**RX 9060 XT**

Position around:

- balanced performance
- 16 GB VRAM
- strong price efficiency
- additional performance headroom
- next-generation AAA readiness

**Target customer:** mainstream gamer seeking the best overall balance.

---

### $450–$499 — Maximum Performance Within the Segment

**RX 9070 XT**

Position around:

- maximum performance
- 16 GB VRAM
- performance headroom
- premium experience without entering the high-end price tier

**Target customer:** performance-focused gamer willing to spend the full budget.

---

# 16. Strategic Conclusion

The central finding of the project is not that gamers need the most expensive GPU.

It is that:

> **The strongest mainstream GPU opportunity sits where market adoption, player demand, hardware requirements, and product value overlap.**

The analysis identifies:

**$300–$499**
→ meaningful mainstream ownership

**Action / Adventure / RPG**
→ major gaming audiences

**Action P75 Performance = 75**
→ practical performance threshold

**Action P75 VRAM = 10.75 GB**
→ approximately 12 GB practical VRAM requirement

**Performance + VRAM + Price efficiency**
→ product-selection criteria

This creates a product-positioning framework for a GPU that can serve today's mainstream gaming audience while giving consumers a reasonable hardware base for the next generation of major AAA releases.

### The strategic recommendation:

> **For a mainstream gamer preparing for future AAA gaming, the $300–$499 segment offers the strongest balance between market accessibility and gaming capability. Within that segment, products should be evaluated against a minimum 75-performance / 12-GB-VRAM target, with the final choice determined by the buyer's preference for value versus performance headroom.**

---

# 17. Analytical Workflow

```text
                    BUSINESS QUESTION
                           │
                           ▼
                  GPU Ownership Data
                           │
                           ▼
               Identify Market Opportunity
                           │
                    $300–$499
                           │
                           ▼
                   Game Demand Data
                           │
                           ▼
               Genre / Player Analysis
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
           Action      Adventure       RPG
              │
              ▼
        Hardware Requirements
              │
       2023–2025 Games
       Mid → Top+ GPUs
       GPU Launch ≥ 2018
              │
              ▼
       P75 Performance / VRAM
              │
              ▼
         GPU Candidate Pool
              │
              ▼
     Performance / VRAM / Value
              │
              ▼
       Python Sensitivity Model
              │
              ▼
        Final Product Fit
              │
              ▼
        GTA VI Target Use Case
```

---

# 18. Tools & Responsibilities

| Tool                     | Role                                                                                   |
| ------------------------ | -------------------------------------------------------------------------------------- |
| **Excel / Power Query**  | Initial data preparation, cleaning, transformation and exploratory analysis            |
| **Power BI**             | Interactive market and gaming-demand visualization                                     |
| **PostgreSQL / pgAdmin** | Structured querying, segmentation, percentile analysis and product filtering           |
| **Python / Pandas**      | Statistical analysis, distributions, recommendation modelling and sensitivity analysis |
| **Matplotlib / Seaborn** | Statistical and analytical visualization                                               |

SQL and Python implementation are maintained separately in the project files rather than reproduced in this README.

---

# 19. Evidence & Deep Dives

The conclusions above are supported by the project's analytical artifacts.

### Deep Dive 1 — GPU Ownership & Price Segmentation

**Power BI dashboard:**
`SHS_Price.pbix`

Shows:

* GPU ownership distribution
* GPU class
* GPU series
* Price segments
* Market-share concentration

---

### Deep Dive 2 — Gaming Demand & Genre Analysis

**Power BI dashboard:**
`GameID_Price.pbix`

Shows:

* Peak CCU
* Genre distribution
* Game popularity
* GPU requirements
* Game-level hardware relationships

---

### Deep Dive 3 — GPU Requirement Analysis

The SQL analysis evaluates modern games by GPU class and launch year, calculates performance percentiles by genre, and filters candidate GPUs using the P75 requirements.

**SQL file:**
`SQL.sql`

---

### Deep Dive 4 — GPU Recommendation Model

**Python notebook:**
`GPU_rec.ipynb`

Contains:

* Data preparation
* Requirement distributions
* GPU candidate filtering
* Performance / VRAM analysis
* GPU scoring
* Sensitivity analysis

---

### Supporting Data

* `GAMEID.xlsx`
* `GPU_SPECS.xlsx`
* `SHS2026.xlsx`
* `MergeGAME_GPU_SPECS.xlsx`
* `MergeSHS_GPU_SPECS.xlsx`

---

# Project Outcome

This project moves from **descriptive market data** to a **defensible product recommendation**:

> **Identify where gamers are → understand what they play → quantify what hardware they need → find the products that satisfy those requirements → evaluate the trade-off between value and performance → recommend the strongest mainstream GPU fit.**

The result is a framework that can be reused for future GPU launches, changing game requirements, and different consumer budgets.

