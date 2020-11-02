Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F742A363A
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 23:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgKBWEJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 17:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgKBWEI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 17:04:08 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Nov 2020 14:04:07 PST
Received: from vic-MTAout5.csiro.au (vic-mtaout5.csiro.au [IPv6:2405:b000:b00:220::64:42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E09C0617A6
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1604354647; x=1635890647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N0tPbthahXJTIFUkthG+8RmpqJ4zHTab67vwA+3C1m8=;
  b=K04OREkkGMi0a3W9fO3DylkykzWkJ/n9AtmerI3XHEYCoLr0HYUA9+7S
   WNJpATJtrKLHFCkCcRinN1FqQxhnMT8jNBFUkgQnSQNXZyLrZGfzxOhFl
   4TuKQwh3ROYrEmZ3TtbeFiqx0K8QlLfmLOT00r8zEJPGHMKhmEcWqWtWP
   U=;
IronPort-SDR: 77K+RK7XvW/2WXMZXjuAnVTRgPxcHiwp7iUCfpkbDgwMmvyi+zIOQpMsluFkWVb8FZ5dzflmGY
 rDfwj1qMNtAg==
X-SBRS: 5.1
IronPort-PHdr: =?us-ascii?q?9a23=3A7JZRRRFgp5kwB//Ebrz4JZ1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e401QKbZ4jXy/tYzeHRtvOoVW8B5MOHt3YPONxJWg?=
 =?us-ascii?q?QegMob1wonHIaeCEL9IfKrCk5yHMlLWFJ/uX3uN09TFZXEalHyq2H05jkXSV?=
 =?us-ascii?q?3zMANvLbHzHYjfx828y+G1/cjVZANFzDqwaL9/NlO4twLU48INgJFlbK8smR?=
 =?us-ascii?q?Y=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+HRAAAZgaBflwCwBSSYiIBxAISUgiJ?=
 =?us-ascii?q?igQmDIVFigUsKhDODSQOEe6QmA1QLAQEBDQItAgQBAQKESAIXgXICJTgTAgM?=
 =?us-ascii?q?BAQsBAQYBAQEBAQYEAgIQAQEBAQEBAQEfBoYRDINUgQcBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgIBAxIREQwBATcBDwIBCBo?=
 =?us-ascii?q?CJgICAhIeFRIEDieDBIJMAy0BAQQBpHUCgTuJXoEygwQBAQWFHRiCEAkJAYE?=
 =?us-ascii?q?EKoJyg3GGV4FdPoN1Lj6EPoMXM4Isk2SkPgcDIIJMkCmKTgINIoMGAZ5jtAk?=
 =?us-ascii?q?CBAIEBQIOAQEFgWuBe2yDPVAXAg2OOYNXilh0OAIGCgEBAwl8jDsBgRABAQ?=
X-IPAS-Result: =?us-ascii?q?A+HRAAAZgaBflwCwBSSYiIBxAISUgiJigQmDIVFigUsKh?=
 =?us-ascii?q?DODSQOEe6QmA1QLAQEBDQItAgQBAQKESAIXgXICJTgTAgMBAQsBAQYBAQEBA?=
 =?us-ascii?q?QYEAgIQAQEBAQEBAQEfBoYRDINUgQcBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEFAoEMPgIBAxIREQwBATcBDwIBCBoCJgICAhIeFRIED?=
 =?us-ascii?q?ieDBIJMAy0BAQQBpHUCgTuJXoEygwQBAQWFHRiCEAkJAYEEKoJyg3GGV4FdP?=
 =?us-ascii?q?oN1Lj6EPoMXM4Isk2SkPgcDIIJMkCmKTgINIoMGAZ5jtAkCBAIEBQIOAQEFg?=
 =?us-ascii?q?WuBe2yDPVAXAg2OOYNXilh0OAIGCgEBAwl8jDsBgRABAQ?=
Received: from exch2-mel.nexus.csiro.au ([IPv6:2405:b000:302:71::85:122])
  by vic-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 03 Nov 2020 09:01:49 +1100
Received: from exch4-mel.nexus.csiro.au (2405:b000:302:71::85:124) by
 exch2-mel.nexus.csiro.au (2405:b000:302:71::85:122) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 3 Nov 2020 09:01:49 +1100
Received: from exedge2.csiro.au (150.229.64.34) by exch4-mel.nexus.csiro.au
 (138.194.85.124) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Nov 2020 09:01:49 +1100
Received: from AUS01-SY3-obe.outbound.protection.outlook.com (104.47.117.52)
 by exedge2.csiro.au (150.229.64.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Nov 2020 09:01:44 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKnhV9LwqDhhsm/r8n4qPWHdG57meMPG0JkUCUdk/WzcveXTTqNU6RYuMRSxSwlghqhJey2VgzU5l+/f0NoEO1bgyzgqcOYxXjqVIK0uEHALDUaemapEa+u8vvVz8DCs79nMRxFMUTqG8/549ydOKYmNYD55mpbpYFLwOO4DFOdtx/hFDDLLHR3fasDnHOIO6aZKCygAC0lNi6R7/j1THok8+w99HUs8Rt+jmUomlLxeAcFdfmdK73pHrENWic/8GBDze8rjr1gFKvpGbezWWdbabUZpKSTAPcpukvZKOWObsBJ+g0AmZP1u02ouTXLysqEOizlxlsuAw9Xeu2JJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0tPbthahXJTIFUkthG+8RmpqJ4zHTab67vwA+3C1m8=;
 b=SllsC0rjZKeXZLiHx0IP3wlSK4oZ3V6NolOf1mlDtm0gTabRoZ1ghfnlqkIxvud8hTCeKEMdbKT3uet40rUv8qa7LAh2XXWT/ysvhLmjPn/PcyP5glzuVWPS8J8duyI2pMgwQSFI1ZH6ez3S9YesEYhucFPV4h7Bon7FTSNcRShb4yxp0eJga+hCjxlbf76Vsg1MsDDRY/+mnBx7QF/2HwLeZqlENezC9sy1377io94/dBba7XuG4jKJZtfupocsjLddpKv00gL7K7YMHMawYCpNhw2KVW/MoM0AoLPJKugs5K2NebUd3dj5SERoSyKvEJhgfP9fHEJJqAUHpRqoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csiro.au; dmarc=pass action=none header.from=csiro.au;
 dkim=pass header.d=csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0tPbthahXJTIFUkthG+8RmpqJ4zHTab67vwA+3C1m8=;
 b=Gqbvb+RUA5ZGN7xorFtRHAqVA0MzxBL06KAJDrS97f3XLqzfZwRXlUhoLzvXCsR+7Yoc0DB2cPkETn4I0xKwDunuidkHlF+04JZUxj8xh3OBIMkiMhpNyfjRqQOgsF84uylsG7KpDuws+AyfawJ06Ynb2WbDB1OvnLqU9fGR1NA=
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com (2603:10c6:220:3c::18)
 by MEAPR01MB2262.ausprd01.prod.outlook.com (2603:10c6:201:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Mon, 2 Nov
 2020 22:01:48 +0000
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::ac28:5cc2:6ae9:4911]) by MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::ac28:5cc2:6ae9:4911%3]) with mapi id 15.20.3499.029; Mon, 2 Nov 2020
 22:01:48 +0000
From:   "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
To:     Steve Dickson <SteveD@RedHat.com>
CC:     Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
Thread-Topic: [RFC PATCH 0/1] Enable config.d directory to be processed.
Thread-Index: AQHWsRiaVDw9YCWSPkqFyf/znCbiE6m01MOAgAAQYoCAABpFAIAAPuqAgAAm/oA=
Date:   Mon, 2 Nov 2020 22:01:48 +0000
Message-ID: <20201102220147.GB29519@mayhem.atnf.CSIRO.AU>
References: <20201029210401.446244-1-steved@redhat.com>
 <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
 <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
 <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
 <1ac387a1ef608258b2e23e7923a1c4e2ec6b25b3.camel@redhat.com>
 <5d090330-d67f-4bf0-ca91-e30772bd87b2@RedHat.com>
In-Reply-To: <5d090330-d67f-4bf0-ca91-e30772bd87b2@RedHat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: RedHat.com; dkim=none (message not signed)
 header.d=none;RedHat.com; dmarc=none action=none header.from=csiro.au;
x-originating-ip: [130.155.194.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7af4a1c-2232-4754-f51f-08d87f7ae53c
x-ms-traffictypediagnostic: MEAPR01MB2262:
x-microsoft-antispam-prvs: <MEAPR01MB2262FA56E72A73401B83FA78F4100@MEAPR01MB2262.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XezoF7ln0BlSCw0ZZSPq1lDSInWcX6TM7Dzfwb6/YrYijlMf1C+cyV35/R6A1LZfqrwOZa2i5o0N9zdGqF505RfQIZH3N7bTVv7yWAV6DeHUvOGk2u1i7nerqiBXX/FN37Aw9BVmNHLm88ecvplgUXdmiEMkN7vMAE5BJHwsNg//aiByox+8hJZdYhaRSASLbqcFqEq/YL5R71uf39MMdDdtgBpyD+MoF+YuYKkAK75TzuLU3Q7rEc/z9OB80EBd0toqI4Uqgxrx6RaZ1gTNgcqyIyInvCHBZXNDiuBAv2FwILdm4XDs2IkImx5CALYC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MEAPR01MB4517.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(8936002)(86362001)(6506007)(6916009)(6486002)(66946007)(66556008)(66476007)(1076003)(64756008)(66446008)(558084003)(2906002)(316002)(186003)(54906003)(5660300002)(91956017)(478600001)(4326008)(8676002)(76116006)(71200400001)(33656002)(6512007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iOoDQ19uGXG4JMbGynFkxxuOjHiOZNVv3ZMkONkf7nrY5Zwzi9xFOR2dfTplfjw7h8q33gGNXVvQVK7t/TG1V3smXGHwJsfwu2A9/WUaw+KJ8rPv7vKqgDOig2zWaGpXoY/xvdMbYLcx/p2mg1bf4Ub2dzfsFmsYxUORwcdHNxFp1OwXGPqF2oXSPCPk5VXr2MKTtsb9bvxdU1+vQzsWpYneQVqDTyryB+i5nk9CP6BCHDtK7+xX4PUa+dhaEJXM+xmDdgsVNqd2KxnVo2kodJIAVGCT+ReRcmrncywB+Rd8GPeGthECsjergjGrj3onk8+6+f5jusi/tIZwU+3DbvkDDDpupfWOoMJsKYMMX3B4D+EI4HVNjZE0IH3F4UfihET5adptS7/ClO5F2rKsH6Bs3u7b2jxa3TOQKXn8u4sJkocDHolBgKWXFZJZUD58mkmeYTZUTOnLGRowfkgwO1lUMGOcb26tAAAYvCeA9oKLZJZlsArAvitkFHKb5MOz+5rgIzX//jhW8YiVLjVJdhCQQcMOfhPlPGTGTo5SxBQGaNQEgJ5bayBwy/q/dv2TukLi77ZIHLs6yqECyC2FzW3dWzGbikCE2RPmY9OA4p/+/Mmmy3ir++AV7Gx/HUT1KUnVkwecILM/0tNT/b8Vgg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <994537BE457DBA4290CF10382B39B49E@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEAPR01MB4517.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7af4a1c-2232-4754-f51f-08d87f7ae53c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 22:01:48.0620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fguWbQSNpP3ebTwaY4mL/iJoF2Bgw+muj3WS8HJ04jnmMQQHfvj4+dhj13UNgYW1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB2262
X-OriginatorOrg: csiro.au
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQpXb3VsZCBpdCBiZSB1c2VmdWwgYXQgdGhpcyBwb2ludCB0byBsb29rIGF0IGhvdyBhdXRvZnMg
aGFuZGxlcyB0aGlzDQphbmQgY29udGVtcGxhdGUgYW4gaW1wbGVtZW50YXRpb24gY29uc2lzdGVu
dCB3aXRoIHRoZSB3YXkgdGhhdCB3b3Jrcz8NCg0KS2luZCByZWdhcmRzDQpWaW5jZQ==
