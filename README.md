# 🚧 Impact of Delhi-Meerut Expressway on Regional Development in India

This repository hosts the research project conducted under **SURGE 2024 at IIT Kanpur**, assessing the economic and spatial impact of the **Delhi-Meerut Expressway (DME)** on nearby regions using **Difference-in-Difference (DiD)** econometric modeling, **GIS tools**, and firm-level data from the **World Bank Enterprise Survey**.

> **Author**: Ishaan Gupta (2430148)  
> **Mentor**: Prof. Somesh K. Mathur  
> **Department**: Economic Sciences, IIT Kanpur  

---

## 📌 Objective

To empirically evaluate how the DME, inaugurated in 2021, influenced regional economic performance and infrastructure perception in Delhi, Ghaziabad, and Meerut by comparing firms within and outside proximity zones.

---

## 🧠 Key Research Questions

- Did the expressway improve firm-level economic outcomes?
- How did proximity to the expressway alter the perception of transport as a barrier?
- Can infrastructural investment catalyze regional development and urbanization?

---

## 📊 Methodology

### ➤ Data Sources

- **World Bank Enterprise Surveys** (2014 & 2022)
- **Geo-coordinates** from the World Bank
- **QGIS** for spatial mapping and buffer creation
- **Google Earth Engine** for analyzing urbanization

### ➤ Econometric Models

#### 📌 DiD Regression Model

$$
y_{it} = \alpha + \beta \cdot Treatment_i + \gamma \cdot Post_t + \delta \cdot (Treatment_i \cdot Post_t) + \Omega \cdot X + \varepsilon_{it}
$$

#### 📌 Tobit DiD Model (Censored Dependent Variable)

$$
y_{it} = \alpha + \beta \cdot Treatment_i + \gamma \cdot Post_t + \delta \cdot (Treatment_i \cdot Post_t) + \Omega \cdot X + \varepsilon_{it}
$$

---

## 🔍 Results

| Metric                      | Model           | Coefficient | Significance |
|----------------------------|-----------------|-------------|--------------|
| Standardized Annual Sales  | DiD Regression  | **+0.365**  | *** (p < 0.01) |
| Transport as an Obstacle   | Tobit-DiD       | **–0.822**  | *** (p < 0.01) |

- Firms near the expressway show **36.5% standard deviation increase in annual sales**  
- **82% reduction in perception of transport as an obstacle** post-DME

---

## 🛠 Tools & Tech Stack

- **Python** (`pandas`, `geopy`, `statsmodels`)
- **QGIS** for spatial analysis
- **Google Earth Engine**
- **DiD & Tobit econometric models**

---

## 📈 Future Scope

- Integrate **CMIE Prowess** for enhanced firm data
- Expand from firm-level to **regional satellite-based analysis**
- Explore impacts of **other infrastructure projects** (e.g., freight corridors, high-speed rail)
- Collaborate with **GIS & Earth Sciences** for advanced spatial analytics

---

## 📚 References

- Datta, S. (2012). *The Impact of Improved Highways on Indian Firms.*
- Ghani, E., Goswami, A. G., & Kerr, W. R. (2016). *Highway to Success.*
- Rao, P. M., & Vinod, H. D. (2023). *Economic Performance of Indian IT Export Firms.*

---

## 🤝 Acknowledgements

This project was conducted under the **SURGE 2024 Program** at **IIT Kanpur**, with mentorship from **Prof. Somesh K. Mathur** and data support from the **World Bank**.

---
