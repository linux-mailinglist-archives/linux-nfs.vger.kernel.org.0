Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18024AA172
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 21:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiBDUzw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Feb 2022 15:55:52 -0500
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:54554 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiBDUzt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Feb 2022 15:55:49 -0500
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 324545467
X-IPAS-Result: =?us-ascii?q?A2FaAACWkv1hh2Y6L2haHQEBAQEJARIBBQUBQIFIBgELA?=
 =?us-ascii?q?YFRVn5Ye4RVg0sBAYU5hQ6CVC4DnFOBJQMYPAIJAQEBAQEBAQEBBwI1DAQBA?=
 =?us-ascii?q?QMEhH4Cg2QmNgcOAQIEAQEBAQMCAwEBAQEBAQMBAQYBAQEBAQEFBAICEAEBA?=
 =?us-ascii?q?QELDQkFCAoHDhAFIoUvOQ2DU007AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBBQINUik9AQEBAQIBEhEVCAEBOAQLCxgCAiYCAjIlBg0GA?=
 =?us-ascii?q?gEBHoJiAYJlAw0hAQ6hFwGBEwEWPgIjAUABAQuBCIkMeoExgQGCCAEBBgQEg?=
 =?us-ascii?q?lOCOhhGCQ2BWwMGCQGBBiqDDoslQ4FJRIE8D4J0PoJjBBiBLgKDLhOCMCKTB?=
 =?us-ascii?q?QeBDiYGVD00eA0tA6ETYJ4Eg1CLApRIBg8FLoNyknmRH5ZKjRGULxiEbAIEA?=
 =?us-ascii?q?gQFAg4BAQaBaApygRMzGggdE4MkURkPjiAMDQmDT4UUhWkjMgI2AgYLAQEDC?=
 =?us-ascii?q?Y4KgkUBAQ?=
IronPort-PHdr: A9a23:3+SY2RY2xqevGsPcmZBOes//LTAjhN3EVzX9orIriLNLJ6Kk+Zmqf
 EnS/u5kg1KBW4LHo+lFhOzbv+GFOyQA7J+NvWpEfMlKUBkI2skTlhYrVciCD0CzJfX2bis8S
 cJFUlIt/3yyPUVPXsjkYFiHp3Su7XgPBhjvPBEzK+joSebv
IronPort-Data: A9a23:o8DXwqJLhPRo2duSFE+RIpUlxSXFcZb7ZxGr2PjKsXjdYENS1D1Wy
 GBNW23TPPiOamX2eYhxbYi28kxUuZ/SydUwGQAd+CA2RRqmiyZl6fd1j6vUF3nPRiEWZB8/h
 ykmh12pwPkcFhcwnD/0WlTahSQ6hfHgqobUUraeYHgrHVM8E0/NtDo68wIHqt8w6TSGK17V0
 T/Ci5W31IiNgmMc3so8sspvmTs31BjAkGpwUm8WOZiniGTje0w9V/rzE00Qw0zQGeG4FsbiL
 wrKISrQEmnxp3/BAfv9+lr3n9Fjrhc/8mFih1IPM5VOjCSuqQQR8oMpKP4ZZnt8km+lxcFv6
 OQXqLCZHFJB0q3kwIzxUjF+OgQnZehq3eGCJnKy98uO00fBbn3ghe10C107NpEZ/eAxBnxS8
 fsfK3YGaRXra+CemernDLUzwJlzapCzZuvzuVk5pd3dJe4pRp3fUY3P7MNYmiosi9BHBrDTa
 9dxhT9HN06cPkESZglIYH44tOWLvFageSV2k1mqrrcnzViO0jxJ06e4ZbI5ffTRHJ4OwS50v
 Fnu+2X/HwFfMtKE4SSK/2jqheLVmy7/HoUIG9WFGuVChVSSwikfDUMQXF7i+f2h0BfmAZRYN
 lAe/Tcooe4q7ku3Q9LhXhq+5nmZohobXNkWGOo/gO2Q9kbKyyW5I3oYSjtOVPc/7uNsVCIK5
 wWUs/q8UFSDr4apYX6a876Vqxa7Ni4UMXIOaEc4cOcV3zXwiN1q0EqVF76PBIbw34arQGurq
 9yfhHFm3+17sCId60msEbkraRqAq4OBawk04AjMNo5Oxl4hP9b6D2BEBEiy0BqtBIOQT13Es
 H1ancGbtbgKFcvUzHbLR/gRFra04frDKCfbnVNkA5gm8XKq5mKneodTpjp5IS+F0/romxe2P
 Sc/WisIu/e/2UdGi4cqP+pd7Ox3lsDd+SzNDKy8Uza3SsEZmPW71C9vf1WM+GvmjVIhl6oyU
 b/CL5r3XS1GU/0+k2LvLwv47VPN7nBvrY80bcCrpylLLZLCPhZ5tJ9ZbQffM7hltMtoXi2Mo
 4YOaZHiJ+pjvB3WOXCMqtF7waEiKHkwH5ftrMJLPuWEOBJhAmg9CvjXqY7NiKQ095m5Ytzgp
 ynnMmcBkASXrSSedW2iNy4/AJuyA8cXhS9qZUQEYAfzs1B+MNbHxPlELfMfI+J4nNGPONYvE
 pHpje3bXq8QItkGkhxBBaTAQHtKLU/63lrXZHD9OlDSvfdIHmT0xzMtRSO3nAFmM8Z9nZJWT
 2GIvu8Dfac+eg==
IronPort-HdrOrdr: A9a23:1ehQdqsKTUqDCnGgXth6KLCA7skC/IMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJhBo7+90dq7MBfhHPlOkPMs1NaZLXLbUQ6TQL2KgrGSoAEIdxeOj9K1kJ
 0QC5SWa+eAcmSS7/yb3ODQKb9Jrri6GeKT9IHjJh9WPH1XgspbnmJE42igYypLrUV9dPgE/M
 323Ls7m9PsQwVeUu2LQl0+G8TTrdzCk5zrJTYAGh4c8QGLyRel8qTzHRS01goXF2on+8ZpzU
 H11yjCoomzufCyzRHRk0fV8pRtgdPkjv9OHtaFhMQ5IijlziyoeINicbufuy1dmpDl1H8a1P
 335zswNcV67H3cOkmzvBvWwgHllA0j7nfzoGXo9kfLkIjcfnYXGsBBjYVWfl/y8Ew7puxx16
 pNwiawq4dXJQmoplWy2/H4EzVR0makq3srluAey1ZFV5EFVbNXpYsDuGtIDZY7Gj7g4oxPKp
 ggMCjl3ocXTbqmVQGbgoE2q+bcHEjbXy32DnTqg/blkgS/xxtCvg4lLM92pAZ1yHtycegB2w
 3+CNUYqFh5dL5iUUtMPpZ+fSKJMB28ffvtChPlHb21LtBPB5ryw6SHk4ndotvaNaAg/d8PhZ
 jRWEkdmnU1fwbDGOvm5uw4zizw
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,343,1635224400"; 
   d="scan'208";a="324545467"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 14:55:47 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEylw+OqFX3xj0W5Xr0ruT3C2hcDlwC1dRjU2yGXpTPgzgaOevZbXua8f1Ox69RUs4/KLIqjwJc/oDOrgiAkYCs4CKTZ7aWXE6TjcdQ9r+0usBmNTJoEJgOB39WpmIsxDlgSvzvdp38a2FuSmBEpqWGOTs82rfx53PxuRRj1nUethZlokQCp35/J52+UcZzQ52n4EoaVX/zSUcqHr4qUBTmtD9A1QrWkP2mzCKpLwv4yySwWvblc/HAQ7xhzzhSgQXLwNhonGRGutPKAFn4yuO6eBqRxs8tYglbNeJdwe1eORWT5XHdqwU+XJteUazo3ybPsbkXt+Pgqwycz0x5NSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2C+5VmNU0kMO2/CyH77Nuu5UKkpCyVVrg+V/3YsJyE=;
 b=MkPwuDmyg+1u+TquyX1qQMoz3/v2cmozrRynMN1/HPj6bz22NpVHxTB65+WI7aWs94oCk0yrYNhfMXV2Lwrd4DPtD5tTVVo/SXEvEEzGHc5wvqeijZuIV56oL7NokW4gQ9fjCY2dZ07/xP2mHIxVHSio+Z8Lb/GXokDc3oEgFezrLMSc2dP70YITPzlD1892SQj18+JuSTKUoQZU8CyDIER0PcYJbR4pXqQ7khNdWc1MTdHDbESa1qBeLPvZEoP6wFiQQdkbnoFkH1OFIdQi5B8yE9kA7CLsv1IhQ6lqJ1H3QKKiZRM/Tbz9y8BXm4s4jkVdj0pyN1q2K0qz2nCInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2C+5VmNU0kMO2/CyH77Nuu5UKkpCyVVrg+V/3YsJyE=;
 b=K9ifQ728R+jYZhoiLShipRIqVQEHnjLMM4OOLORaH5xEPI9cOXy2nSNmgs9vy1CzbVBG48Ue+Z1VFn4jIai2Bh6brPyZwxmoV42auBEfSbkcpZSlj4d2xVk85G7iLPO7z9h6qzXWPqIXiWnX764KLMALznwNVGGysfwlcyfkK/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by MWHPR0601MB3689.namprd06.prod.outlook.com (2603:10b6:301:7b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 20:55:46 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2%5]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 20:55:46 +0000
Message-ID: <309e27b9-da26-bcd0-dc55-1b63cb93203f@math.utexas.edu>
Date:   Fri, 4 Feb 2022 14:55:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Cache flush on file lock
Content-Language: en-US
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20220202014111.GA7467@hostway.ca>
 <4691F0AB-FCDB-49EF-B62B-51F135F692A5@oracle.com>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
In-Reply-To: <4691F0AB-FCDB-49EF-B62B-51F135F692A5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:805:66::21) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194a2d33-c417-4d44-f68c-08d9e820b741
X-MS-TrafficTypeDiagnostic: MWHPR0601MB3689:EE_
X-Microsoft-Antispam-PRVS: <MWHPR0601MB3689AF425CFE41F6135FB17283299@MWHPR0601MB3689.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVE7FUbb9x/rVWWeYUUJJct3ng7NDmglc6B2fPIYdLnlve/2HIxhhKyciUfUtyIa7APpx8v/+cggMgHTGtUJ33DPdB6OzIowlIiPAVnaWWMwHE7tz/QAbEXBL1dscPRBUfj+233tp+ebUJqp8nkdajX/JWQmktKc9MhcmSnT2x16EYfsT0yAFiuyEr198ZueZUJl0QdUjuwAjR+029oIyL/9qHJ/E1a8KJVK3X8vCPxaxb22t4huo5V4iFvzezHVugKKNOa6youI+bfiun8I/pqA9rZ49YafSiNda7Ai9uIvEKxtgl+x7VZeKBxtqw1CLR4+9e7MwvoiRuJgOQoKecen5wUeud6D6Sn/QubKOfuZdtgCdJL5REP/o2o7O4WFnZ5RwkSgGK/N5+SjF1iav9hu8KWX0TbHzkPy6HEAXVqkx6FP1ubh1LBg4Ov8rIIyM1/T8C4Lg72USSgLZQLgdHgUoYO4JkENWvpbHGo0ty+8a86TOV1+dMslwLL3GHmHqMmQKK36aMhLogKl/tICiVWpV4QLu+HG1fwFnRWKaNmchUZayDImU5gdEwNMvqD1l3mL2BqA3TyXVRtc4qHmrKwCHhR36t1+hhRNiSg7pnf0ilUO9bFeUQhc+Zx1JczPIHwjxyL7zMHcKLElDr+q2WO3bvWAn4gpgHlbaYQaOsfEyVY3XrTdsnifDF9/i8haktWXGAlPOVBnP5KucXub91spIgvTPUgMNxTYSEcqms7p7T/6GLRU5sMIC8WYqpZUjTNfjmGo/LguELeGv/VHpyiHIH2Ofmgd6g0rClTSEjSpIzVbYCiEFN5td7umgeoIz70O0w3d2asbbgktbGFZEEVZxtGL4tCVzDU4BuTRSGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(75432002)(8676002)(53546011)(6666004)(31696002)(5660300002)(2616005)(8936002)(6506007)(66556008)(66476007)(2906002)(66946007)(52116002)(86362001)(508600001)(6916009)(6486002)(966005)(83380400001)(6512007)(31686004)(786003)(186003)(38350700002)(38100700002)(316002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TElvUndBMDNaRXF5eEJDazBKUWJJNWJaTFo3N05jQnVuUHB3TGVabC8rdXpi?=
 =?utf-8?B?K3dRMFVmcTRzQWlzMnBTZ2VjZ204RXJaZ3JoV3o4U3JpN2IzMUZjRFBuNFhE?=
 =?utf-8?B?Ry9KNjlWYVJaYlovTzR1ZElRcXlnRFRJeHlud0dEZjhSRy8rbFVQTC9GQnhU?=
 =?utf-8?B?ek1lc2t6MHlWOGFPWmhKZGllV2t4cm5lZ09Hand3MTM2WlNQTkZCdjJmdUtN?=
 =?utf-8?B?NE00ZXJqejZDUCsvVHZGb0drTXZ3M21HUWdBM2tjTjN1ZXZnelJoNnZzVTd6?=
 =?utf-8?B?amR5WFlsOWJzWVB3eS9OdmdONUpYR2t2NFZNci80TVUvNXlFVm1zeHJvcllK?=
 =?utf-8?B?NWl5aUhUQXVaTW1pbUJUMHJSQ25qMlRRaDU5c1paSmVxNG1DelI0SlRlREFP?=
 =?utf-8?B?RkxFQllYYkxHbHdvSVlPR1pCWU5uU2hTMXV5eVFVdEZwS3pGSEJVblc0Ukl2?=
 =?utf-8?B?NkJIcXJESFRqMmRVRzlBUGxQRzNaaVpQcnJKODNVOUcycHV4dkk2MEFxRE9M?=
 =?utf-8?B?MlV3TnlyL1VCK29pSzk4T2lBaTNiWHh5elkrc0VranhzN3UzSUg4L1RmZ0tu?=
 =?utf-8?B?WU9xOUJQSk5TY2poUDVHTGRoZmxvOEtWSHdNVmpWam9MMGpob1NLMFFGVGF3?=
 =?utf-8?B?dHJqdDRtU21ROTh1TUQ5SEFkMkRIQkpZV2lrRzlaY2Jjb0swOUJQOTQvejNx?=
 =?utf-8?B?QVp4bVJjYXhlQmFDRXdsSDhLY0NvR1NROGRTdnZsR0laZm5PQ0p6MkQwQ0k1?=
 =?utf-8?B?QW5ZWUlXNnNsbWVTU1JGeGJEaXBJTGhMSE9lK1lHbDFnNi9UYjVORjZqSll6?=
 =?utf-8?B?c2EybXRSZ2pnOHVoTjdLNFZnK2hSSXZ0K085YlhGYWk2L0dCWHdWUXhhSVN0?=
 =?utf-8?B?R1lIemR2aDJSRDZOeXVZVkxqUlNJL09rdXR6OHdYOEtCTTJnTDltNThUcm1J?=
 =?utf-8?B?NzJJbGlwWlZDR0JOT2ZrWkdkUk5PWXo3SkcrYTRpOWVGb2JIR2V1dW8wclRZ?=
 =?utf-8?B?REdkV05KTjdTTDR2TDJlbG5udHBpZVErczhGSmpyaWJja2NFZEx4VkJWd3R1?=
 =?utf-8?B?cVVJb2ZmZVhabzB2VFJ6VXRBUkpCdDlaM2VzSTNnWDExNENsZGJDOVNQSWUx?=
 =?utf-8?B?SUNlTjg3UHZ4b0NtYzBmTlp0NWZCUVM2ejc5UFNBZGdwekZLZytyQjlYZ3F4?=
 =?utf-8?B?dWtJVW1EV0ZZb2R4MmNrTkp1RGM4M1lnS2RqVU5rRkZKL0puUFNYVGxwZUxy?=
 =?utf-8?B?KzEvOUtabVJLcHZHRFdkSGl3blkySHNXU0IwS3hiRFpWRkJXVXd2YmZINnNG?=
 =?utf-8?B?UTc4dnNZMzlJblhoV0EzaW5Odm9VOTBzcnZjRTVROXJUOVRlaXRWaC8zRGVQ?=
 =?utf-8?B?QVhERlFuRG1jWElFZ3dndS9RQTAvSWUyOUZmdlpMWSt5TS85NnVadEk5MGp6?=
 =?utf-8?B?WDV0QmszUFI3YnFxRUFCOGRrRXVlMEJkZkVIVk5XejFGbjZlSHJsTjZRWEVr?=
 =?utf-8?B?cDBCU2hTMDdjc1RyaDcyaEl2ZXJHWFBoZnQ1S1MxQXhwQm9RMUVTLzJYMURD?=
 =?utf-8?B?TU5waWlWUVlQdzlaWE0weldQS3EyQVZXY2k4c3hjc0txam9TNXRmaW1xeVNN?=
 =?utf-8?B?OTJneFJ0cFFRcklCNVRESE5uaEp6TXl3dXZEeXpDRGhud2NmUXpUeTRSQk9t?=
 =?utf-8?B?UDhTRTFZaEszU1g2L3FuVGFYQldMeGl0aDdtbDh0QUN3MXo4UHltZm1NTm1O?=
 =?utf-8?B?MGtGYlZCQUNnd3FOUkZZOVZYNVp4KytLZk40TUJFY3hoQkpOcDNmRFpzUTdz?=
 =?utf-8?B?WU1aeHlDNDFZYU5FV1hmcjRiYk13aytOMUtFL25yWnJaYytTUjVXVU00cGNH?=
 =?utf-8?B?b3JTMXJFREJvL052UU5KQ1YvUWUvNXhveUhSZkNYZ0J4UnRaTUpTTE1jVDdj?=
 =?utf-8?B?K3ZIanRZMDdtSEZsa1BkZk8yTTBXRnlBeDVXVU9HZXgva2JzYVhLQ04zc3Uz?=
 =?utf-8?B?RDF1Z2ZkSFpDYnk3TUVQaU9IRWlreEdFTzVPaXR2N0pBU3pTeG8zUDVBZjhZ?=
 =?utf-8?B?RzVaSzI5K0UzOFhBS1JLd2JxVk1QcUlKcUUrLzZldG10dEJ2bzZYZERVd2ZH?=
 =?utf-8?B?NWZ0SC8vYjVMMmVXT0g1LzJSU3h5UTFTZTZsVHhNajM5aVVxVTRYcEZkRFBP?=
 =?utf-8?Q?WmNtjOzky+v+gN3yWHtqiH0=3D?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 194a2d33-c417-4d44-f68c-08d9e820b741
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 20:55:46.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1MqnNa47V40Ii/26x6puwqb+XtL4sTdZl6LCcbEBBHATaDI53ziKKU+bOQ40xtPJXaE7oFYyv+b/D6TIV81hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3689
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/2/22 13:55, Chuck Lever III wrote:
> 
> 
>> On Feb 1, 2022, at 8:41 PM, Simon Kirby <sim@hostway.ca> wrote:
>>
>> How far off would we be from write delegations happening here?
> 
> We are tracking a "feature request" for write delegation support
> in the Linux NFS server:
> 
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=348
> 
> At this point the effort is not resourced. It's not clear how
> much benefit it would be.
> 

First shock is I thought write delegation was already supported.

But especially for users who have NFS mounted home directories, how 
could there not be a major performance benefit? To cite one example that 
has been a problem before (in particular, on Mac OSX clients with NFSv3 
home directories mounted from a linux fileserver), facilitating the 
firefox "awesome" bar, which writes to a SQLlite database in 
~/.mozilla/fireworks with alarming frequency in order to keep up the 
awesomeness.

This flat out didn't work previously unless you went to about:config and 
set

   storage.nfs_filesystem = true

Not at all sure how this changed the execution of firefox though.


> That said, it seems to me that your use case might benefit if
> the Linux NFS server offered a READ delegation for the SQLite
> database file even when it is open R/W. It might be appropriate
> if the server offered such a delegation when there are no other
> clients that have the file open for write or that hold write
> delegations.
> 
> Patches and performance data are, as always, welcome.
> 
> 
> --
> Chuck Lever
> 
> 
> 
