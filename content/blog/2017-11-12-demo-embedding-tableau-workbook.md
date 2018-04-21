---
title: "Demo: Embedding Tableau public Visualizations"
subtitle: "Through Tableau public integration"
author: Aaron Simumba
date: '2017-11-12'
slug: demo-embedding-tableau-workbook
tags:
- tableau 
- Visualization
- iframe
toc: true
---
In this short demo, I implement how to embed Tableau public visualizations on the personal website.This implementation is achieved through using `iframe.` The embed link from a Tableau public visualization has to be enclosed with the `<iframe> </iframe>` tag. The public visualisation used for demonstration is from [Jack Dougherty](http://internet2.trincoll.edu/facProfiles/Default.aspx?fid=1004266) on CT schools.

The visualization below is embedded with the following code:

    <iframe 
    src="https://public.tableau.com/views/CTSchoolDistrictsbyIncomeandGradeLevels2009-13/Sheet1?:showVizHome=no&:embed=true" width="652px" height="756px" style="border: 0px;" scrolling="no">
    </iframe>

**NOTE:** You must strip off the extra text from the URL to the right side of the `?` from the URL obtained from the Tableau public viz. There after add the colon followed by other arguments as indicated above.

Here is the breakdown of each argument and value:

- **src** - This is the source URL from the tableau public visualisation dashboard. 
- **showVizHome=no&:embed=true"** - This allows the visualization to display on the external site its being embedded.
- **width="652px" height="756px"** - You can set the width to height ratio, expressed either as `px` or as `%`.
- **style="border: 0px;"** - This eliminates the shadow border around the visualization.
- **scrolling="no"** - setting this to `no` allows for the visualization to fully occupy the available space, and not have extended scrolling bars.


<iframe src="https://public.tableau.com/views/CTSchoolDistrictsbyIncomeandGradeLevels2009-13/Sheet1?:showVizHome=no&:embed=true" width="95%" height="500"></iframe>

 That is all. It is that simple to leverage Tableau public infrastructure  for great visualizations which can be shared on private websites.