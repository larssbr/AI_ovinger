======================
FunkLoad_ bench report
======================


:date: 2014-12-02 21:58:26
:abstract: Try to test all xml rpc method
           Bench result of ``Credential.test_credential``: 
           Check all credentiald methods

.. _FunkLoad: http://funkload.nuxeo.org/
.. sectnum::    :depth: 2
.. contents:: Table of contents
.. |APDEXT| replace:: \ :sub:`1.5`

Bench configuration
-------------------

* Launched: 2014-12-02 21:58:26
* From: 169-231-148-55.wireless.ucsb.edu
* Test: ``test_Credential.py Credential.test_credential``
* Target server: http://localhost:44401/
* Cycles of concurrent users: [1, 20, 40, 60, 80, 100]
* Cycle duration: 10s
* Sleeptime between request: from 0.1s to 0.2s
* Sleeptime between test case: 0.5s
* Startup delay between thread: 0.05s
* Apdex: |APDEXT|
* FunkLoad_ version: 1.16.1


Bench content
-------------

The test ``Credential.test_credential`` contains: 

* 0 page(s)
* 0 redirect(s)
* 0 link(s)
* 0 image(s)
* 5 XML RPC call(s)

The bench contains:

* 1118 tests, 37 error(s)
* 5572 pages, 37 error(s)
* 5572 requests, 37 error(s)


Test stats
----------

The number of Successful **Tests** Per Second (STPS) over Concurrent Users (CUs).

 .. image:: tests.png

 ================== ================== ================== ================== ==================
                CUs               STPS              TOTAL            SUCCESS              ERROR
 ================== ================== ================== ================== ==================
                  1              0.800                  8                  8             0.00%
                 20             15.800                158                158             0.00%
                 40             24.800                249                248             0.40%
                 60             23.200                236                232             1.69%
                 80             22.700                247                227             8.10%
                100             20.800                220                208             5.45%
 ================== ================== ================== ================== ==================



Page stats
----------

The number of Successful **Pages** Per Second (SPPS) over Concurrent Users (CUs).
Note that an XML RPC call count like a page.

 .. image:: pages_spps.png
 .. image:: pages.png

 ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                CUs             Apdex*             Rating               SPPS            maxSPPS              TOTAL            SUCCESS              ERROR                MIN                AVG                MAX                P10                MED                P90                P95
 ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                  1              1.000          Excellent              3.900              5.000                 39                 39             0.00%              0.002              0.003              0.005              0.002              0.003              0.004              0.005
                 20              1.000          Excellent             78.800             85.000                788                788             0.00%              0.001              0.003              0.012              0.002              0.002              0.004              0.004
                 40              1.000          Excellent            120.800            163.000               1209               1208             0.08%              0.001              0.063              1.511              0.002              0.002              0.005              1.041
                 60              0.998          Excellent            119.000            174.000               1194               1190             0.34%              0.001              0.260              1.529              0.002              0.003              1.136              1.306
                 80              0.995          Excellent            120.400            177.000               1224               1204             1.63%              0.001              0.418              2.284              0.002              0.004              1.305              1.328
                100              0.954          Excellent            110.600            189.000               1118               1106             1.07%              0.001              0.557              3.881              0.002              0.004              1.350              2.217
 ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================

 \* Apdex |APDEXT|

Request stats
-------------

The number of **Requests** Per Second (RPS) successful or not over Concurrent Users (CUs).

 .. image:: requests_rps.png
 .. image:: requests.png

 ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                CUs             Apdex*            Rating*                RPS             maxRPS              TOTAL            SUCCESS              ERROR                MIN                AVG                MAX                P10                MED                P90                P95
 ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                  1              1.000          Excellent              3.900              5.000                 39                 39             0.00%              0.002              0.003              0.005              0.002              0.003              0.004              0.005
                 20              1.000          Excellent             78.800             85.000                788                788             0.00%              0.001              0.003              0.012              0.002              0.002              0.004              0.004
                 40              1.000          Excellent            120.900            163.000               1209               1208             0.08%              0.001              0.064              1.511              0.002              0.002              0.005              1.049
                 60              0.998          Excellent            119.400            174.000               1194               1190             0.34%              0.001              0.264              1.529              0.002              0.003              1.136              1.306
                 80              0.995          Excellent            122.400            177.000               1224               1204             1.63%              0.001              0.439              2.284              0.002              0.004              1.310              1.331
                100              0.954          Excellent            111.800            198.000               1118               1106             1.07%              0.001              0.591              3.881              0.002              0.004              1.446              2.362
 ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================

 \* Apdex |APDEXT|

Slowest requests
----------------

The 5 slowest average response time during the best cycle with **40** CUs:

* In page 001, Apdex rating: Excellent, avg response time: 0.15s, xmlrpc: ``http://localhost:44401/#getStatus``
  `Check getStatus`
* In page 005, Apdex rating: Excellent, avg response time: 0.05s, xmlrpc: ``http://localhost:44401/#listCredentials``
  `list credentials of group AdminZope`
* In page 004, Apdex rating: Excellent, avg response time: 0.04s, xmlrpc: ``http://localhost:44401/#listCredentials``
  `list all credential of the file`
* In page 003, Apdex rating: Excellent, avg response time: 0.04s, xmlrpc: ``http://localhost:44401/#listGroups``
  `list groups from the group file`
* In page 002, Apdex rating: Excellent, avg response time: 0.04s, xmlrpc: ``http://localhost:44401/#getCredential``
  `Get a credential from a file`

Page detail stats
-----------------


PAGE 001: Check getStatus
~~~~~~~~~~~~~~~~~~~~~~~~~

* Req: 001, xmlrpc, url ``http://localhost:44401/#getStatus``

     .. image:: request_001.001.png

     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                    CUs             Apdex*             Rating              TOTAL            SUCCESS              ERROR                MIN                AVG                MAX                P10                MED                P90                P95
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                      1              1.000          Excellent                  7                  7             0.00%              0.002              0.003              0.004              0.002              0.003              0.004              0.004
                     20              1.000          Excellent                158                158             0.00%              0.001              0.002              0.007              0.002              0.002              0.004              0.004
                     40              0.998          Excellent                244                244             0.00%              0.001              0.154              1.511              0.002              0.002              1.089              1.118
                     60              0.998          Excellent                243                241             0.82%              0.001              0.590              1.506              0.002              1.041              1.298              1.325
                     80              0.990          Excellent                262                259             1.15%              0.001              1.014              2.284              0.003              1.122              1.321              1.333
                    100              0.963          Excellent                230                228             0.87%              0.001              1.116              3.734              0.004              1.112              1.335              2.241
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================

     \* Apdex |APDEXT|

PAGE 002: Get a credential from a file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Req: 001, xmlrpc, url ``http://localhost:44401/#getCredential``

     .. image:: request_002.001.png

     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                    CUs             Apdex*             Rating              TOTAL            SUCCESS              ERROR                MIN                AVG                MAX                P10                MED                P90                P95
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                      1              1.000          Excellent                  8                  8             0.00%              0.002              0.003              0.004              0.002              0.003              0.004              0.004
                     20              1.000          Excellent                157                157             0.00%              0.001              0.003              0.007              0.002              0.002              0.004              0.004
                     40              1.000          Excellent                241                241             0.00%              0.001              0.037              1.332              0.002              0.002              0.004              0.005
                     60              0.998          Excellent                243                242             0.41%              0.001              0.175              1.514              0.002              0.003              1.090              1.293
                     80              0.996          Excellent                250                244             2.40%              0.001              0.259              1.504              0.002              0.003              1.306              1.328
                    100              0.956          Excellent                228                228             0.00%              0.001              0.479              3.736              0.002              0.004              1.456              2.362
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================

     \* Apdex |APDEXT|

PAGE 003: list groups from the group file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Req: 001, xmlrpc, url ``http://localhost:44401/#listGroups``

     .. image:: request_003.001.png

     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                    CUs             Apdex*             Rating              TOTAL            SUCCESS              ERROR                MIN                AVG                MAX                P10                MED                P90                P95
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                      1              1.000          Excellent                  8                  8             0.00%              0.002              0.002              0.004              0.002              0.002              0.004              0.004
                     20              1.000          Excellent                158                158             0.00%              0.001              0.002              0.006              0.002              0.002              0.004              0.004
                     40              1.000          Excellent                243                243             0.00%              0.001              0.040              1.322              0.002              0.002              0.004              0.006
                     60              0.998          Excellent                237                237             0.00%              0.001              0.204              1.529              0.002              0.003              1.106              1.307
                     80              0.996          Excellent                240                237             1.25%              0.001              0.325              1.521              0.002              0.003              1.300              1.325
                    100              0.971          Excellent                223                220             1.35%              0.001              0.306              3.881              0.002              0.003              1.302              1.531
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================

     \* Apdex |APDEXT|

PAGE 004: list all credential of the file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Req: 001, xmlrpc, url ``http://localhost:44401/#listCredentials``

     .. image:: request_004.001.png

     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                    CUs             Apdex*             Rating              TOTAL            SUCCESS              ERROR                MIN                AVG                MAX                P10                MED                P90                P95
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                      1              1.000          Excellent                  8                  8             0.00%              0.003              0.004              0.005              0.003              0.003              0.005              0.005
                     20              1.000          Excellent                159                159             0.00%              0.001              0.003              0.012              0.002              0.003              0.004              0.005
                     40              1.000          Excellent                241                240             0.41%              0.001              0.044              1.268              0.002              0.002              0.005              0.008
                     60              0.998          Excellent                236                235             0.42%              0.001              0.151              1.513              0.002              0.003              1.068              1.286
                     80              0.994          Excellent                238                236             0.84%              0.001              0.270              1.534              0.002              0.003              1.316              1.350
                    100              0.926               Good                224                220             1.79%              0.001              0.553              3.739              0.002              0.004              2.157              2.599
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================

     \* Apdex |APDEXT|

PAGE 005: list credentials of group AdminZope
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Req: 001, xmlrpc, url ``http://localhost:44401/#listCredentials``

     .. image:: request_005.001.png

     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                    CUs             Apdex*             Rating              TOTAL            SUCCESS              ERROR                MIN                AVG                MAX                P10                MED                P90                P95
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================
                      1              1.000          Excellent                  8                  8             0.00%              0.002              0.003              0.004              0.002              0.003              0.004              0.004
                     20              1.000          Excellent                156                156             0.00%              0.001              0.003              0.007              0.002              0.002              0.004              0.004
                     40              1.000          Excellent                240                240             0.00%              0.001              0.046              1.333              0.002              0.002              0.004              0.006
                     60              1.000          Excellent                235                235             0.00%              0.001              0.194              1.361              0.002              0.003              1.102              1.292
                     80              0.998          Excellent                234                228             2.56%              0.001              0.276              1.508              0.002              0.003              1.288              1.327
                    100              0.953          Excellent                213                210             1.41%              0.001              0.480              3.710              0.002              0.004              1.362              2.238
     ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ================== ==================

     \* Apdex |APDEXT|

Failures and Errors
-------------------


Failures
~~~~~~~~

* 37 time(s), code: -1::

    No traceback.


Definitions
-----------

* CUs: Concurrent users or number of concurrent threads executing tests.
* Request: a single GET/POST/redirect/xmlrpc request.
* Page: a request with redirects and resource links (image, css, js) for an html page.
* STPS: Successful tests per second.
* SPPS: Successful pages per second.
* RPS: Requests per second, successful or not.
* maxSPPS: Maximum SPPS during the cycle.
* maxRPS: Maximum RPS during the cycle.
* MIN: Minimum response time for a page or request.
* AVG: Average response time for a page or request.
* MAX: Maximmum response time for a page or request.
* P10: 10th percentile, response time where 10 percent of pages or requests are delivered.
* MED: Median or 50th percentile, response time where half of pages or requests are delivered.
* P90: 90th percentile, response time where 90 percent of pages or requests are delivered.
* P95: 95th percentile, response time where 95 percent of pages or requests are delivered.
* Apdex T: Application Performance Index, 
  this is a numerical measure of user satisfaction, it is based
  on three zones of application responsiveness:

  - Satisfied: The user is fully productive. This represents the
    time value (T seconds) below which users are not impeded by
    application response time.

  - Tolerating: The user notices performance lagging within
    responses greater than T, but continues the process.

  - Frustrated: Performance with a response time greater than 4*T
    seconds is unacceptable, and users may abandon the process.

    By default T is set to 1.5s this means that response time between 0
    and 1.5s the user is fully productive, between 1.5 and 6s the
    responsivness is tolerating and above 6s the user is frustrated.

    The Apdex score converts many measurements into one number on a
    uniform scale of 0-to-1 (0 = no users satisfied, 1 = all users
    satisfied).

    Visit http://www.apdex.org/ for more information.
* Rating: To ease interpretation the Apdex
  score is also represented as a rating:

  - U for UNACCEPTABLE represented in gray for a score between 0 and 0.5 

  - P for POOR represented in red for a score between 0.5 and 0.7

  - F for FAIR represented in yellow for a score between 0.7 and 0.85

  - G for Good represented in green for a score between 0.85 and 0.94

  - E for Excellent represented in blue for a score between 0.94 and 1.

Report generated with FunkLoad_ 1.16.1, more information available on the `FunkLoad site <http://funkload.nuxeo.org/#benching>`_.