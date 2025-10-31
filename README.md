# titanic-ml-project
MLDS 400 Homework 3 - Titanic prediction with Python and R Docker

## Project Overview

This project implements survival prediction models for the 1912 Titanic disaster using both Python and R programming languages. Each analysis runs in isolated Docker containers to ensure reproducible results.

### Technical Stack
- **Languages**: Python 3.11, R 4.3
- **ML Framework**: scikit-learn, base R GLM
- **Containerization**: Docker 
- **Data Source**: Kaggle Titanic competition dataset

## Repository Structure
```
titanic-ml-project/
├── README.md                 # Project documentation
├── .gitignore               # Version control exclusions
├── Dockerfile               # Python container configuration
├── requirements.txt         # Python dependencies
├── outputs/                 # Analysis results directory
│   ├── .gitkeep
│   ├── python_predictions.csv
│   └── r_predictions.csv
└── src/
    ├── python/
    │   └── analysis.py      # Python ML implementation
    ├── r/
    │   ├── Dockerfile       # R container configuration
    │   ├── packages.R       # R package installation
    │   └── analysis.R       # R statistical implementation
    └── data/
        ├── .gitkeep
        ├── train.csv        # Training dataset (download from Kaggle/local only)
        └── test.csv         # Test dataset (download from Kaggle/local only)
```
### Prerequisites
- Docker Desktop installed and running
- Git for repository management

### Setup Instructions

1. **Clone Repository**
```bash
   git clone https://github.com/yourusername/titanic-ml-project.git
   cd titanic-ml-project
```

2. **Download Dataset**
   - Visit [Kaggle Titanic Competition](https://www.kaggle.com/competitions/titanic/data)
   - Download `train.csv` and `test.csv`
   - Place files in `src/data/` directory

3. **Run Python Analysis**
```bash
   docker build -t titanic-python .
   docker run --rm \
     -v "$PWD/src/data:/app/src/data" \
     -v "$PWD/outputs:/app/outputs" \
     titanic-python
```

4. **Run R Analysis**
```bash
   docker build -t titanic-r -f src/r/Dockerfile .
   docker run --rm \
     -v "$PWD/src/data:/app/src/data" \
     -v "$PWD/outputs:/app/outputs" \
     titanic-r
```

### Data Processing Steps (Q13-Q18)
- **Q13**: Load training data and display basic statistics
- **Q14**: Feature engineering (family size, gender encoding, missing value imputation)
- **Q15**: Train logistic regression model
- **Q16**: Calculate training accuracy
- **Q17**: Process test data with identical transformations
- **Q18**: Generate survival predictions and export results

### Feature Engineering
- Family size calculation: SibSp + Parch + 1
- Solo traveler indicator: 1 if family size equals 1
- Gender encoding: Male=1, Female=0
- Missing value imputation using median/mode

### Model Configuration
- Algorithm: Logistic Regression
- Features: Pclass, Sex, Age, Fare, FamilySize, IsAlone
- Expected accuracy: 80-82%

## Expected Output

Both implementations will display:
```
TITANIC SURVIVAL ANALYSIS
Northwestern MLDS 400 Assignment 3

[Q13] Loading training data
Data shape: (891, 12)
Survival rate: 0.384

[Q14] Feature engineering
Created FamilySize feature
Created IsAlone feature
Applied gender encoding

[Q15] Model training
Logistic regression trained

[Q16] Training accuracy
Accuracy: 0.8123

[Q17] Test data processing
Applied transformations

[Q18] Predictions generated
Saved to outputs directory
```

## Assignment Compliance(completed)

- GitHub repository with proper structure
- Working Docker containers for Python and R
- Complete Q13-Q18 analysis implementation
- Clear documentation and usage instructions
- Prediction results exported to CSV files

.vscode/
.idea/

# System
.DS_Store
Thumbs.db
