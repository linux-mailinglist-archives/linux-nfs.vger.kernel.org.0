Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A175079DED5
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Sep 2023 05:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjIMD5O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 23:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjIMD5N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 23:57:13 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 20:57:09 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC421722
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1694577430; x=1726113430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GHzz7Vyz1KRaVRT8ER6LEZ+GJhCZIhbl6JRkTLeLeXc=;
  b=C4jtfl0Xajcz+eDkBYK6L3eeZd9T9jB1D7L7g6eSCysWOy5uyLXIkl+J
   M054mc0J8Jz0kCQb8odRb5E9bKVWL9sbZ9WqsBq8TRo+hx88IIckcouPL
   1fmUMyoyDof2pTGu1EcVtYvP/2iXCLyjDCtcXR2Q1+7UnsS+LtzTueBbS
   UxAdNxRShzOfcX8HGYSgXxy0j1rdDloA3wLGRFWh77Fnhat5e6uBZeYOL
   Bk7gKJ/KDAlL7hv/ctEHd8VWdEhEVv/MzzaZHiOfdqim3GaJFuGmfLyxf
   kuLSmoIhDDVg+Zom/NVux5u+ru+MiBlpKTlW7hMINedP7W+1ugJEfyxpQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="6147360"
X-IronPort-AV: E=Sophos;i="6.02,142,1688396400"; 
   d="scan'208";a="6147360"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:56:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1IrpnZKyo9p7oEg5EA280Illjrd2kVmTp7B+PTcz5jaxXM5suBHV6jW8LUopM7rKo86riakMyyV6m/vonEWvimJOxSr4XtQ1FHT5lDjo+lweok/3Xu+55Dk8Wrg5/BKiNVZ1fGyHrJ9ybpu64E1fgySMOmqjsOmav550OLK+bq0PAV0opYZqfhxiEodpnCUaDKiSa3eMsl6oYcPQBvIXWvtDVZ5BySnHNhP1ntn9B+yQdZRuVxqhgMA9p9kjK1h4t+r1tay2zT+eGh75tTQQsEit7qEa5yf59etnVWqIN2ecXSKBNIqxo5NiyJFmeC/79Et7KoANhp5QRicdkM8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHzz7Vyz1KRaVRT8ER6LEZ+GJhCZIhbl6JRkTLeLeXc=;
 b=BqQWwE6Z2xqLF9kVuu3VmJtKsDDjSSQq+6qyo+1z7RIqzDGzdfyhF8Bp2idBve/PwKctL6TrbSHXSIdwgj9fjc+cncyQgTyDHO15yPLoZNRn+VL4ntMWStxZjQtdSZp650d1/F9GLjZN63s3ScjzatD8hjZ6oH52l7d4EIeylT0OkiAUtk4bnsgzT+WvFLnndezLCj/MyjZ1i0urP1Qw9h4iojspRB1oL9rVscJUs3/VRmarl3m+uDQSMg07jrgTNeh3K0UstTZzuCcJmZ+SRRS3SWsAXzEp+a98oZXC41IObtExg/DJxfTJ1GbyV8kUgOwKJQYn1FWKT1jzSfBhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB5640.jpnprd01.prod.outlook.com (2603:1096:604:c1::6)
 by OS3PR01MB9530.jpnprd01.prod.outlook.com (2603:1096:604:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 03:56:00 +0000
Received: from OS3PR01MB5640.jpnprd01.prod.outlook.com
 ([fe80::8b3d:4589:cbbe:5f19]) by OS3PR01MB5640.jpnprd01.prod.outlook.com
 ([fe80::8b3d:4589:cbbe:5f19%4]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 03:55:58 +0000
From:   "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MiAxLzFdIE5GU0Q6IGFkZCB0cmFj?=
 =?utf-8?Q?e_points_to_track_server_copy_progress?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMS8xXSBORlNEOiBhZGQgdHJhY2UgcG9pbnRz?=
 =?utf-8?Q?_to_track_server_copy_progress?=
Thread-Index: AQHZ3EJsStxMM7ool0OOWPzU9Oq3YbAVfjuggAHLxQCAAOi0UA==
Date:   Wed, 13 Sep 2023 03:55:58 +0000
Message-ID: <OS3PR01MB564013FE2F7EB881ED6F1BFDE6F0A@OS3PR01MB5640.jpnprd01.prod.outlook.com>
References: <1693510547-29288-1-git-send-email-dai.ngo@oracle.com>
 <OS3PR01MB564053F04D4B2BDE86B5051BE6F1A@OS3PR01MB5640.jpnprd01.prod.outlook.com>
 <08aebfbb-549e-b797-471d-acd8b5c05454@oracle.com>
In-Reply-To: <08aebfbb-549e-b797-471d-acd8b5c05454@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YWRiNTg1NjYtYmRiMS00ODE2LTg4YjAtMjU3ZTE3YzVk?=
 =?utf-8?B?NjgxO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOS0xM1QwMzo1MTo0NFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5640:EE_|OS3PR01MB9530:EE_
x-ms-office365-filtering-correlation-id: 0fec5da3-7bbc-4638-62e2-08dbb40d568b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umw1yoc1GgZKJPM6YYCMLoUpz02eizyD9AAYF/ttcq3j0sC/0VcDQVKv3nHTN1pwB234+0QZ72wMw8kjthfkeKP2DCszNrIihN3uRr2BbYNL6zuCemNBH7ELIRdwpm0p2YWCRB5fiHaW7ZWDBZGIQUr5R/Oqc24d4iX4LVKf9aguZu/bSvWg0g/ZH4WXmhF/1W7OaTPeC5CtnerQPV13QnkG1JIVh581IOQgeICmxPCs7feEv/fva0IYVLS+J4fn0JvnYfkpzu6EzcQUn3ds5DiY58t8MWz+YGnpQc3xj2g9kWP45xPrX6krdHfX1bc8uIeGQO7fVUx4RK0apSFmzA8fUcDh4jqPcwHBhOPN0eiY9/RHtsXBYXAV+HpUz9q0EW7Pi1RuYLSH3PLdwEwCtFALSzjJsMYkbMrrJl2SW3XBzBDOOfqRvuc3BGcQ6v/Rv2WVQfzXsCtmJh5DETMzJVMZjV9PLFXsKELVS0ksbmrMYc/bLwp0u5HJJyz1TTrPv/O/jYaDgCRxnDSyEasThBeLAnIE3kTDBwdeIoeTm1c7S5BBOuxuPwRBghX+wbABYbHarb1PaxmmZdQa2LPnoLbzT9l71pg0qrun/hlHnpu/MdeD+yXbQzK6pJN9U/uVNysdQIR5kNcylOf5O0yGtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5640.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(1590799021)(186009)(1800799009)(451199024)(66556008)(1580799018)(71200400001)(8936002)(41300700001)(4326008)(478600001)(66446008)(110136005)(76116006)(66946007)(64756008)(6506007)(26005)(316002)(7696005)(9686003)(4744005)(2906002)(66476007)(86362001)(38070700005)(82960400001)(52536014)(5660300002)(55016003)(122000001)(85182001)(33656002)(224303003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFdBREdod01uelRPWTAweC84QjhGdGl1MVpjVDdHSlZiMXR2UkJ2Z2VlUEtB?=
 =?utf-8?B?Y0pZK3ZHOXBQc05ZWDNxK3AyYXZWd3VYem1jME1FWFoyWlppKzQ5NWFZWU0z?=
 =?utf-8?B?RlVuNlNvVTFGUUNqRWt2Tk5YeGIvR002S1IzOHBjbEppaG9pUkpqeWFObnVG?=
 =?utf-8?B?RE5kYjNZZUMyVGRiT1pQYWJNV0xEQWRXYXIxUlZmVytibjNZTC9wUDg4Ylg1?=
 =?utf-8?B?bHg2ZVlPZFNteHVVRHFQNDB5cm5SY1VHcXhoamVGUjdCUGFScnUzVjhadkNi?=
 =?utf-8?B?cUh2UDJFSFF6RFZwZlM0VVVMaUVjOUlCT001cUFGQWZISGdCVlZKczJKZlR6?=
 =?utf-8?B?TEtLSTRSNWdaWTQ3RlROSjJ0UTdCb1lxYm1udGxzdC9IVWhyQlVBVFhFcS9F?=
 =?utf-8?B?SGU4Nk1HQVNhS0V6UnVFVmlUR3BzRVZrUS9HS21rQmtUSDFPWnNzMFlMRjdT?=
 =?utf-8?B?QUhxNW1lM2JZTkEyeEQ5aTU3bEZTY1pxbUU4UFJtS2cwSnFSNndQNzdmNmUx?=
 =?utf-8?B?Y0NwNldnMFN6aDJLY2xFUmNpdkRNcWZiN1k4M04yNjBwMXFGMXNNdFljY3V6?=
 =?utf-8?B?L0RKWWV0SGN6Mm9UL3BiczE5all6NG1SaHVwUURqRUk1cVpId3NOVXZTRFIx?=
 =?utf-8?B?NDhXdnE5NW94Y2ZPNGJTVFdPa1ZSeXZKeHFWb0pTUHc2K2o4cGdUV3B5KzhN?=
 =?utf-8?B?Ny9aTkI2UnhZenJrZGFoK3lFOWg2UFJWaFYxUlhOcDdaUmdiVDg3UnBwNUVW?=
 =?utf-8?B?MENGSDhHQXJKMElnRlA1VEtYZ2NSZ0I1OE11cUoyenFXSWRtVUF2eU1sQm9q?=
 =?utf-8?B?WG93WC9VVWhXRHRlK2FQT1FnNmFwN2MvOFoyaDQ3Z1FPNm9YMk1nMEsvTS9z?=
 =?utf-8?B?Y2FuVHJTNXMxdGxZRmhjT1o5YXV3Wi9CZmZlSUVKVGpRNWRDZTRIdm00akxG?=
 =?utf-8?B?VVplQ2ova0h1NkR0OFlWKzBHL0JvZnJ6V0svbEQyNm1nMWRObCtCVzlUZU03?=
 =?utf-8?B?cTNNdTM0TVJ0elp5Z1hBb3hsNGlxRFd3c2VnSmUvc0NMT3RNdm01S0kxOGlI?=
 =?utf-8?B?WUNuL1IyNGh4RU56QXdBVFRsanZlWmhpYll5K0J2b1pVdXpITURpM1BiT1Rm?=
 =?utf-8?B?cGVoblRsWFBiTXczOU0vQ3ZFMGltR2ZhVFNob1hZcWlUYzI0V0plYjRlYkls?=
 =?utf-8?B?ZmFqc2E2d044WHlVekRHV1JZUlNISVVKM3E0SEhCYzFaZFlhRi81V0d5ZURW?=
 =?utf-8?B?S2N1eVVpU1J4bGh2TFQ0SFVQTVBud3hYd2lLMEdFMGJPVTBZWTgrOGVSbXhH?=
 =?utf-8?B?MldpN2N0SVBteW5CaXBld0M5eTNhM3MyTGErWkZDRkl3SkxmOVowdk1BTGdU?=
 =?utf-8?B?bm5vNkF3K25VZFhacjRCS2creWJjVytkb2EreDR5N0JaeHRVSVFpY0VKb2JK?=
 =?utf-8?B?LzROcU5iU1Iybm1idkk3c3kralhEekR4SzRTRU16bGVNTG1SR1VLUlhYMHF0?=
 =?utf-8?B?b1Fza1hXemEwYWdWRkV0SjR0U1JaMVJKWkVXdWFGRHVTWXZUallPOTBQK3Bq?=
 =?utf-8?B?R2VrVTdJZFpFSG9nSFVndXdnQVJjdzM4N25uRXBnVWRIRzIyQTl6MjRNUWtU?=
 =?utf-8?B?Qzc0MlNNU29ya3FxOFlzNDZJS20zQnoyRmQyNWkrOVZid3JMSERJRDJyeVBL?=
 =?utf-8?B?SzlPZG5IMGdGSExTZDhZc2NtTlVvcm9QZ2hGSVFFRXpGQUVISW9nOFdCTGxF?=
 =?utf-8?B?MDJHc1RRSWJNQ2lFV091RWlxUGtOTWZEVkhxc2YzUVhhNEQ0a2s5RmlBTHc5?=
 =?utf-8?B?eGVYYmVHZUw1bkEwVjBBbWpTcXc0Mm9UOTQ1WFBIOU9QbFFibkZPYmEybDBP?=
 =?utf-8?B?bWJaOGhYdXdCZXJKVFNNcTdHWmIyRVpHb1ZKY1BWQXprc2E3ZE0zNU5hMGhl?=
 =?utf-8?B?UG4yWXowdzJmcWF2L25laS9MN05leW4vVHRUTTlTY2ZYL2ZPUHZnQWx0bUdX?=
 =?utf-8?B?ZEFpSlNCTmplN3h0YldFdm9TRmhYRm5OQnJIellVeE5xbDFpZkpTYWdVM0dO?=
 =?utf-8?B?UFlxU21LL1JlN0dhbUhyaEl4S0tFSXZkeVpOVzVTLzhKNGNoR2RmWStGditL?=
 =?utf-8?Q?QOl9GHTiBIArlMkWIBigOQO9I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ij67GCCbTeh39/PPSZ8s04VN2eR5PDwvClj5cF+uI1SJi7rxXimcjmUOQ0IOSHqnqKGbdm1lwliAA+G+x5hNNFPOMqiQDQd/tQf0UoN3IbEDxgxH5U7wVLJvK0c4Wxo0NGdvA73HeUS4OCXO3WDXfhqs4pvHYdolx6F0AvVVy31p0GJRVJSKgdGGRk6XAxWQSmgLG8H1xaru2nJHvDKkbFf81rk6IT7t4z2MYTsAINX+yYTCBB7OA6+LXovlyosqm1NtbKOy+WAfZWucvpHtxlU6Q46SOY/XL+G4Trz55ICMZli/7GUks/a1IhgnrVWTLXNTXw9BkOnr4ar/JiJbiTbEyjCJ58Yh8qsVWiJNNmjrbtW08MRI8uoZQ6nd3Bi+jPzxpbCCLhZzdjIRz8KyhIf8/SDenzuc22+noFey20dJJ55qHyCYtNBDPTZSCYjOIcXfN+kuo3F4cg1sWuv7a00dgW1OnWiHX0eW4/TFdmFXHep+5hVNX2w/sQgLb75Agxry/iSfjQhv2cNKyMkd3Wod9XUrmZBYCBfrxSOvUPY3elfDFgnu9bdfhgc1u2Rqkpt0Ve9iao7WCOa/jfzCIeLHF8dYAzXbP+ENgtugT65YVKvFomCekLY5x0q+w4VoknI8zVVHOjg67054gnR+uY5F5CicUXgLYkw7CMAxwgMFwpFzETk+8SprIzpuwZF+lJks1K9o1sFpHwFRj3UnvYC7oe+7WybSv5XxlA1Qovsy0niPfeEClUZ9e29O6kGUdTx3AqdO0/I0QFR/xRYf3sEY5z15IxHX/GDk8Kzm85THoSG0Lkv3bHzkeZQtDwWrWd+jP2yCs4qg270ASnXUDw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5640.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fec5da3-7bbc-4638-62e2-08dbb40d568b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 03:55:58.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1T1cnUHBmZkbKIZEzQIo2nyFRYrM2JGdLn8vvhAGlWM////aENEwLyvPNXYvDvXsldB6FSl9+eWMTPCAKkwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9530
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBkYWkubmdvQG9yYWNsZS5j
b20gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIz5bm0OeaciDEy5pel
IDIxOjU5DQo+IOS4u+mimDogUmU6IOWbnuWkjTogW1BBVENIIHYyIDEvMV0gTkZTRDogYWRkIHRy
YWNlIHBvaW50cyB0byB0cmFjayBzZXJ2ZXIgY29weQ0KPiBwcm9ncmVzcw0KPiANCj4gSGkgQ2hl
biwNCj4gDQo+IERpZCB5b3UgYWxzbyBhcHBseSB0aGlzIHBhdGNoOg0KPiANCj4gW1BBVENIIDEv
Ml0gTkZTRDogaW5pdGlhbGl6ZSBjb3B5LT5jcF9jbHAgZWFybHkgaW4gbmZzZDRfY29weSBmb3Ig
dXNlIGJ5IHRyYWNlDQo+IHBvaW50DQo+IA0KPiBUaGlzIHBhdGNoIGlzIGEgcHJlcmVxdWlzaXRl
IGZvcg0KPiBbUEFUQ0ggdjIgMS8xXSBORlNEOiBhZGQgdHJhY2UgcG9pbnRzIHRvIHRyYWNrIHNl
cnZlciBjb3B5IHByb2dyZXNzDQo+IA0KPiBTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4NCj4gDQo+
IC1EYWkNCj4gDQpIaSwgRGFpDQoNCglbUEFUQ0ggdjIgMS8xXSBORlNEOiBhZGQgdHJhY2UgcG9p
bnRzIHRvIHRyYWNrIHNlcnZlciBjb3B5IHByb2dyZXNzDQogICAgd29yayBhcyBleHBlY3RlZCB3
aXRoOg0KCVtQQVRDSCAxLzJdIE5GU0Q6IGluaXRpYWxpemUgY29weS0+Y3BfY2xwIGVhcmx5IGlu
IG5mc2Q0X2NvcHkgZm9yIHVzZSBieSB0cmFjZQ0KDQpTbw0KCVRlc3RlZC1ieTogQ2hlbiBIYW54
aWFvIDxjaGVuaHguZm5zdEBmdWppdHN1LmNvbT4NCg0KUmVnYXJkcywNCi0gQ2hlbg0K
