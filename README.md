# Example InSpec Profile

(WIP) InSpec profile for CIS Apache Tomcat v8 Benchmark helps you validate your Tomcat install to the CIS Benchmark recomendations.

## Versioning and State of Development

This project uses the [Semantic Versioning Policy](https://semver.org/).

### Branches

The master branch contains the latest version of the software leading up to a new release.

Other branches contain feature-specific updates.

### Tags

Tags indicate official releases of the project.

Please note 0.x releases are works in progress (WIP) and may change at any time.

#### NOTE

##### There be dragons

The controls **still use** the `xml` resource and function correctly but **help / interest welcome** on completing the `tomcat_*` resources (see the start in the [libraries](./libraries/) directory) in the _other branches_ off `master`.

#### ALPHA: Custom Tomcat Resources

Our current implamentation in the controls use the InSpec `xml` resource which is a bit complicated but works fine.

We are working on moving to a custom set of `tomcat_*` resources for much clearner and more direct InSpec controls.

**_the custom `tomcat\__` resource is in very early alpha not yet complete and is not complete\***

## NOTICE

© 2018 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

## NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

## NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA 22102-7539, (703) 983-6000.

## NOTICE

CIS Benchmarks are published by the Center for Internet Security (CIS), see: https://www.cisecurity.org/.
