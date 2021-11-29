Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654FF460C3F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 02:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbhK2BcK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 20:32:10 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:1511 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238815AbhK2BaK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 20:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638149214; x=1669685214;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=VDWw3EZ1lvOIx1xQk5zqOV92KhHMLpOPah+FAMCtp4I=;
  b=cBV8vZfjTmLq34D4L8GG3EwPZQ/VBsYvKmSWpVDecFknbJs92KKo6dD0
   BRhyND3U1lbERAOzMAcx0zPij5eo8Pe6urNFjEHOKD8ZCJN9jNfyE8xT0
   8+oXX6XzlVYwRI8MiCK4JKFgOfq2wIfFlJqBSCl3RzSLhxnVMoyjcshmj
   e9kIH/LVKhNA29xUEKB9wdCk/09R14xttXwhkamFFz3gnKDHZ6YPHFjrY
   upkcrW0zBnKyv9zDFXGxC1A52cj1k1Ta5oupd8+mL4M6jthLLgRrBWDfI
   lIXXIbyldVjfclgURRKxs+ZJJoCVkzTaFpd/+6WQRcawBFNDKXcQH+c0q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="44650897"
X-IronPort-AV: E=Sophos;i="5.87,272,1631545200"; 
   d="scan'208";a="44650897"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 10:26:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq59uS6Eeftp5x/AWaNfqY5Mb3nZ3fkCvhbh9utbmF54FBEtBH39Xd1IEsh7c1MxJ3x9dzSzZYR/EQEQPmOmvYJJQ5KD1PmAynoYE3zCXByXVM0jj3sA2a5+O7qi03pdiJYKeqZfAtDYFj3grBO9dDKpHN1ctGyu3zxZsooU4/sZ+9chFG778yfr/uF0HzwvlVEKf9oDpmGf2JW1b3h2Da5Zp64s/K+2LhH77/YBkqTQAW4vDBptoQeVmWE2zLJ51jdz0ZkO8hASPDo74IRIIeqkY1PpP1sKqk2S+wvPo3VWe25K1wuhwK2dW46QjRdiTbtPGN4A15a3l/MKJezAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDWw3EZ1lvOIx1xQk5zqOV92KhHMLpOPah+FAMCtp4I=;
 b=S1t89l75FzzodwAAXQXDKqpfyBISfiWd4SNDVZ1/pQIBg9cq4xzvuZoQOQ6A8ZfJi5bWoCRStQ7d+vbL5+2yOValP0YedQguT1cL4P8sBM0Q1oN4IIim6h8IJNDai83biHJD+f/dIGEH/jfR7sjNWnS0cL80B2RtZEcR8rhwrlhxtjvhOFXXoTJn3PCUFnKVewmmf3puoXeOp3G3IRI6IOrWuUdu10LACLP7QJ3mE91grk3kgWJRk1f+PDiihQPShiOAHum8xlQ/14X+8+2ckjPE519KUXCCdN8z0SBiyYzfW+dugnyQLeMbApm3Ro/mgq6RRF9c/FJzxAyiiyNf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDWw3EZ1lvOIx1xQk5zqOV92KhHMLpOPah+FAMCtp4I=;
 b=pT9SSd30dkLRLRWR5apfAUby2hpyOZoGyY7Az9Z++UQn7aVpptoA3NhlzWaSgx9HlzROuh8Bb73SLGxlrqCh/Raf4yHEjXOphK4WipzG53QEGz101Vcxq2c5ryVsm3bBnLxre2EXXI+jYMdMCBUciGoDnSH7IIsnvthWcxQGvH4=
Received: from OS3PR01MB7705.jpnprd01.prod.outlook.com (2603:1096:604:17c::12)
 by OS3PR01MB7334.jpnprd01.prod.outlook.com (2603:1096:604:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 01:26:48 +0000
Received: from OS3PR01MB7705.jpnprd01.prod.outlook.com
 ([fe80::f435:c43f:4ecd:969e]) by OS3PR01MB7705.jpnprd01.prod.outlook.com
 ([fe80::f435:c43f:4ecd:969e%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 01:26:48 +0000
From:   "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
Subject: [PATCH] fstests: generic/571: skip test if locktest -t on NFS returns
 EAGAIN
Thread-Topic: [PATCH] fstests: generic/571: skip test if locktest -t on NFS
 returns EAGAIN
Thread-Index: AQHX5L9++ugC2JlPXku1x/1AIxZKKg==
Date:   Mon, 29 Nov 2021 01:26:48 +0000
Message-ID: <OS3PR01MB77050F630296BA0D927AD63C89669@OS3PR01MB7705.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: ad98ab68-ef58-4f05-bc9f-fda4b97fbddc
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43c6e25e-d48f-4fba-7c49-08d9b2d7506d
x-ms-traffictypediagnostic: OS3PR01MB7334:
x-microsoft-antispam-prvs: <OS3PR01MB7334815332DFBDC78FE23CC989669@OS3PR01MB7334.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:220;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CeA08Z6kUBwYlaiychpRAHBZ44Z+KzaFD2XDVbJlxE9jrErcVCjcoy1nGzIowE4nG80pNcigjKxq8yuCjGpK0bOUNYmh0Ni0+7wPtk8SPPnNNsOKdXz9svI5I5C+KJoWgYZESsxyxZdmnCp3w/Eb8VYsYP+pcHFbJzBSQGWIURXQYux8v1UhjU25CCXxWvNjR7AQqcxzMRaoNDGfP47sZTiCOjXxcqPNtxzLr/s2Pb5z8kXsMzrvdtVr9EAuiCraQ+cDkW4IrubZxZLNsoFhV4AQSRbV+j+Z24eGcyTMPji8pYUoMSGblggsZKUcTMmWeHLkn7S22RdwDDZnp+0JL9m0scmRAp5H7H6G/6bTqnP3uPIRAp3NkQETMk9Uw2uWQcKsd8g0R5GvT7fSEc8/BL9NvTGkn+qdPcek4r/2kXUoOVAth9v9FiNd4BujV6wXRO7IbFK85/REJTM37TUGOrS16K/1/+hfM0I+vWcNz13wrg+Ohj3Hs9abpmkuoOgLqWEXKAKIKfapRNMguiA2i/KZVIZOCDHtzkuTPST6klvk9crh9nVxXGR3ya9J8v3FJxIcTNVKLcsoKQ4cqI0Pi6PDgQJzBqh1tJRNZqnx1Vl2M6xpg9FFXibk4p1sFWp36i0h4rlv+XIcFPiVOPWTtCBzdQPruO4fGhmz6MPNNqFumrwlZwCLL+vof9rr7rMeiENjX902zPhuMWF1ZFVkuhIVSOkVvIIYDvsoNJH4Wvo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7705.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(4326008)(55016003)(52536014)(5660300002)(54906003)(76116006)(450100002)(122000001)(508600001)(82960400001)(26005)(8676002)(38100700002)(6916009)(7696005)(6506007)(66476007)(66946007)(64756008)(66556008)(2906002)(107886003)(83380400001)(9686003)(91956017)(186003)(33656002)(71200400001)(86362001)(316002)(66446008)(85182001)(8936002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S0lLRmtSSlkxSVhkNFlZcjdUdytsdEhINmJLcUNYc1BTTDNGcEc0ZzhwU202?=
 =?gb2312?B?SkFFY3NyM2VGLzNRSHdjdG5IZnFhdGw0UFZhbnRZdnd6bllYVDM5WXBkUDY4?=
 =?gb2312?B?Z2JIbHBTcHNIdnpRS3d6TUtsN1VpZ05XaXNOcnB1VW1SVFBucTJnaFZCQlFD?=
 =?gb2312?B?U3lXN05oMDhuQWxERFhIRzR5NVptMVZWRW1rQUlORi90M25TS1RhcXVlZjlm?=
 =?gb2312?B?RVdzRERJK3ZwTVR5ZEhyZTdtYW9mUmJBclAzR3RJb0F3cm5KZUFkM053V1Zs?=
 =?gb2312?B?M2t4Rjl4aytnR1VPUlBYVkJwb0F5UjRlTXF1RmVvbmt3UUozODhLTjc5SDBH?=
 =?gb2312?B?MnNWUkVWdXkxY3hNbDdqZFdlTjRTOUQ1dkh3eXpxanJQbExHY1laOHpOU090?=
 =?gb2312?B?YitOeFRvMnZ1Z2tTNkVDMTZVeTd2MlR1Q0FBeGVSTkppUWhTZVdiOVRWcEpK?=
 =?gb2312?B?Y2VHQXpsZnlIb2JvREIrSlJtTUFibnduUXJkUlFiMHF0K1JwdjVKNG4yZDJa?=
 =?gb2312?B?aUxsNzZ1NDVENnN6TWFQOFp6V1BiczZ2VWVLd3ViVGxLcHJieWcwN2VGcTVx?=
 =?gb2312?B?eWhMUnRYM3pOdnl3WUYxREhnTFlMazFGNFNKRjEwY2llUE1GRWxpUFExT2RW?=
 =?gb2312?B?L3M5MTNQYkxmbkl5aEhuUVYzbXZsRGphaDB2aDFoNE04Rm5LakRmcVNNMDJh?=
 =?gb2312?B?OW5OZmg4MDluM3ZtSFIvbGVqYXVzbTRKZEQvVkFPc2Zsb0VNTHRRMTgxQUg3?=
 =?gb2312?B?bnNmNktoYjdpd0JnWWxpVTdrMDNrME5wNHBTbGpZUHhvL3hneTRhdnF5V1k5?=
 =?gb2312?B?QmUxTFVwRGlFUnllOHZJTzBEU2Z0RlFiUzZTdjc3UnpxWktaY3hIQWx1cHZT?=
 =?gb2312?B?RzRGQ2xZZEF6WFRvYTZhQzY3bzYxK3dLZXJ2T2toNUwxOUJ4enBSaUNqQ3pF?=
 =?gb2312?B?NnpIQm4zMkJjVUNRa21Va2s5YTJ5Uk5iaGswajk4aHllWGRGSmFoTUNBdEpi?=
 =?gb2312?B?ZTdFbUFKbllZVDBNRXEyYTJCYW1wOGY4YUgzdzA1a2RGSko2M2VwMThZZlRS?=
 =?gb2312?B?cktXN3U1dXA2T2FVVWpLTVdKbFJnVUY4Z2FsK2FCQldaU0VNN25UZmdrWDlz?=
 =?gb2312?B?ekpoT3Zka1V5emxITkxiZ2VkVDNzZ0dNay9tYTI4S3ZvMS9rQUdXcXN3elFC?=
 =?gb2312?B?OGk4SW1rSklqQU9nUzhndk9HUmFaWHczZkFwaHQ1MlhLUXdGUTNCTzlETWN1?=
 =?gb2312?B?d1B0cTlFTzh6QytFU0pPR1BUM3greW5acWdtUFlqS2tpK1ZGV2pvTHZYMDZt?=
 =?gb2312?B?ZDFSL1kwMmw2NmZoc0VNdTdOb2s5Z3JETEpiRlFiSlZPcFV5WUFlbmRJclRp?=
 =?gb2312?B?NnVSQWlXRW82YkYxOHZCMTNnQVUxNG5KZnllTCt0TVhHMGJscUswMlFiNWg5?=
 =?gb2312?B?alFpVTFzaHF6Qjk4TEpXSFBicFN3RGpTeVJxMGw3R25zS3lJcUJpQzgwcDhE?=
 =?gb2312?B?bWlHcmhyNnpuRHhCSXZQalBRUDR5MWhMSFNGZy9ka09pMXJSQ1VZdDlwMGV2?=
 =?gb2312?B?MldtL1R1TzlIaUxydEI3clVVNFU1aGtRVmxBS3RUSXZ0dVdnOGs5SWUrUmtC?=
 =?gb2312?B?NGUxenhxb2l2QU1JN2RxL2xKTm5QaXoyNHBBOXVKczBGUnVFZXI2Uzh1dU5n?=
 =?gb2312?B?cWNSNE44cWw3dURUR1E1bTJpQXNCMkRSYW04d3Fia2dEMVRhSXVuNndaWSt5?=
 =?gb2312?B?c0twUmRtblBEOUVYSGFVOFFDaUxiTE1MYlhpL0IyUUZybHdrM0JpZ01TOElt?=
 =?gb2312?B?Si81OXV2R3J4K0tDT3BZazdoT3lRN1ZPYkF0RnpUS3VxajNudGhHQUNoR3VZ?=
 =?gb2312?B?M2VBT3BMZ09vTFBRUWlOSDE5MW84QVN3cXlmNytjYkZzSnlzUFZNYmZDQmJY?=
 =?gb2312?B?dW5SSUVxNWo0K3cwOEhoUkRTSVpyTzZKc1JKNkdPV3p5eE5jcmpUT0ZwcEZ4?=
 =?gb2312?B?QTNiMElYMXluWGZyelFhaU5oRHpSMFNrcGFjZ2Z6WWpPWWh2dUxmZFJJWVZl?=
 =?gb2312?B?U21sWDRXZUFrbnBTYzRFeXJWVVhSeFNXdEh1YXRHWXBXNkxYbDF4REgvbnlX?=
 =?gb2312?B?ZnZsaTNodkQ5SWtIbXN5TnlOeFBTcUVqZWFWUC9wUERUWDc3cS9mOGFyUWps?=
 =?gb2312?B?akE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7705.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c6e25e-d48f-4fba-7c49-08d9b2d7506d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 01:26:48.5735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74RNBI7cBHNP8q9pJEQRxCnasaqZU40OSMiHg6gnfO5CbEqKVVFiBCRKTRstg0dOzyEzyU1ZcFjQ3TZ2Q9nl2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7334
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

QXMga2VybmVsIGNvbW1pdCBlOTNhNWU5MzA2YTUgKCJORlN2NDogQWRkIHN1cHBvcnQgZm9yCmFw
cGxpY2F0aW9uIGxlYXNlcyB1bmRlcnBpbm5lZCBieSBhIGRlbGVnYXRpb24iKSBkZXNjcmliZXMs
Ck5GUyBub3cgc3VwcG9ydHMgZmlsZSBsZWFzZXMgb25seSBhZnRlciBkZWxlZ2F0aW9ucy4KSG93
ZXZlciwgZnN0ZXN0cyBsYWNrcyBtYW55IE5GUyBmdW5jdGlvbmFsaXRpZXMgaW5jbHVkaW5nCmRl
bGVnYXRpb24uCgpTbyBsZXQncyBza2lwIGdlbmVyaWMvNTcxIGlmIGxvY2t0ZXN0IC10IG9uIE5G
UyByZXR1cm5zIEVBR0FJTgpiZWNhdXNlIG9mIGNvbW1pdCBkZjJjN2I5NTFmNDMgKCJORlN2NDog
c2V0bGVhc2Ugc2hvdWxkIHJldHVybiBFQUdBSU4KaWYgbG9ja3MgYXJlIG5vdCBhdmFpbGFibGUi
KS4KClNpZ25lZC1vZmYtYnk6IFN1IFl1ZSA8c3V5LmZuc3RAZnVqaXRzdS5jb20+Ci0tLQogY29t
bW9uL3JjIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2NvbW1vbi9yYyBiL2NvbW1vbi9yYwppbmRleCBjMGZiMTFj
NjY5MmYuLjVkYTEyNzQ0MjQyYiAxMDA2NDQKLS0tIGEvY29tbW9uL3JjCisrKyBiL2NvbW1vbi9y
YwpAQCAtMzk2Nyw3ICszOTY3LDEwIEBAIF9yZXF1aXJlX3Rlc3RfZmNudGxfc2V0bGVhc2UoKQog
CV9yZXF1aXJlX3Rlc3RfcHJvZ3JhbSAibG9ja3Rlc3QiCiAJdG91Y2ggJFRFU1RfRElSL3NldGxl
YXNlX3Rlc3RmaWxlCiAJJGhlcmUvc3JjL2xvY2t0ZXN0IC10ICRURVNUX0RJUi9zZXRsZWFzZV90
ZXN0ZmlsZSA+L2Rldi9udWxsIDI+JjEKLQlbICQ/IC1lcSAyMiBdICYmIF9ub3RydW4gIlJlcXVp
cmUgZmNudGwgc2V0bGVhc2Ugc3VwcG9ydCIKKwlsb2NhbCByZXQ9JD8KKwlbICRyZXQgLWVxIDIy
IF0gJiYgX25vdHJ1biAiUmVxdWlyZSBmY250bCBzZXRsZWFzZSBzdXBwb3J0IgorCVsgIiRGU1RZ
UCIgPT0gIm5mcyIgLWEgJHJldCAtZXEgMTEgXSAmJiBcCisJCV9ub3RydW4gIk5GUyByZXF1aXJl
cyBkZWxlZ2F0aW9uIGJlZm9yZSBzZXRsZWFzZSIKIH0KIAogX3JlcXVpcmVfb2ZkX2xvY2tzKCkK
LS0gCjIuMzAuMQoK
