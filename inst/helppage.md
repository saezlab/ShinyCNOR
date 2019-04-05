## Help page of the FUNKI application.

Dear User,

if your data files are sensitive or confidential we highly encourage you to run this app locally by typing 

```shiny::runGithub("ShinyCNOR", "saezlab")``` 

in an R session. **Please note that this feature will be enabled as soon as this App is published.**

---

### Upload Data

Please upload the input files for the CellNOptR packages i.e. the prior knowledge network (PKN) in the simple interaction file (SIF) format and the experimental data in the Minimum Information for DataAnalysis in Systems Biology (MIDAS) format. Users can also supply a tidy-style dataframe to convert it into the file in MIDAS format (still not working on R-Shiny... to be integrated...)

#### SIF format description
* Contains 3 columns without a header. Each column is separated by tabs.
* The first column contains the source node, the second column contains the type of interaction either activation (1)  or inhibition (-1) and the third column contains the list of target nodes. Each line refers to an individual interaction
* In an "AND" gate needs to be explicitly specified (without the use of expansion option in the pre-processing step), A specific type of SIF format with the node "andX" where X is the AND gate index in the model. For instance, Node1 AND Node2 activates Node3 could be coded into 3 interactions i.e. Node1 1 and1; Node2 1 and1; and1 1 Node3.

#### MIDAS format description
* Contains multiple columns referring to 1] Cell line, 2] Cues (activators or inhibitors), 3] Timepoint of measurements, and 4] Values of measurements. Each column is separated by commas (CSV file).
* The first Cell line takes numeric integer values (set to 1 by default)
* The cues columns list all the inputs with the prefix "TR:". The values are pre-filled with 0  or 1 according to the presence or absence of inputs in the respective measured condition.
* The timepoints of measurements columns list all measured time points with the prefix "DA:" in the respective experimental condition.
* The values of measurements columns list all measured values with the prefix "DV." in the respective experimental condition.
* All missing values must be filled with 'NA' value.

---

### CellNOptR

* Remark1
* Remark2

---

### CNORprob

* Remark1
* Remark2

---

### CNORode

* Remark1
* Remark2

---

