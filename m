Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB4A9D0D4
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfHZNo2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 09:44:28 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:14054 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbfHZNo2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 09:44:28 -0400
IronPort-SDR: nKIZBZwKsy+DY9A+hDhfHJwCeIRnZTodOeMU1/xtZ58m357aS5tGkAygYHLZ2VKJeJTgr0c0jj
 ID5KYHIUOG5f7vOlxM+g7IOQx099l017G3ERu+2L0v+kVEz5VSY0IsMXq+UK/sNOLAsJiIr4UE
 SLvGnrY0rCZCRtVqHdub048w6h2Np7E5GyRfAwRuL8fsnv6iIuOqAz3r8JVFQOe5nG7T4nrpZt
 TLheLEQYvhwqO5V6kuJOeQJZwCo+dwD7VqzW86T+FfVwQkCeFDAakgM6hBevAbTTUlVvCbo4gp
 Kh8=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 150419256
IronPort-PHdr: =?us-ascii?q?9a23=3AIVJ4CxwLwShshIHXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5YhGN/u1j2VnOW4iTq+lJjebbqejBYSQB+t7A1RJKa5lQT1?=
 =?us-ascii?q?kAgMQSkRYnBZudBkr2MOzCaiUmHIJfSFJ19mr9PERIS47z?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EnAACZ4WNdhzklL2hkGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBZ4FFUHBzAwQLKgqEF4NHA4UyhTuCLy2aOgMYPAEIAQEBAQE?=
 =?us-ascii?q?BAQEBBwEfDgIBAQKEPQIXgnQ4EwIKAQEFAQEBAQEGBAICEAEBAQgNCQgphTQ?=
 =?us-ascii?q?MgnhNOTIBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAhQ?=
 =?us-ascii?q?kOQEBBBIREQwBATgPAgEIGAICJgICAjAVEAEBBAE0gwABgWoDHQGbdD0CYgI?=
 =?us-ascii?q?LgQQpiGABAXKBMoJ7AQEFhH4YQgiBTAMGgQwojAQGgUE+gTgMgjEuPoJhBYE?=
 =?us-ascii?q?4EBaDC4JYjDqCY4dDlQ4JAoIehmqNUwYbmE+NaIdRGpA7AgQCBAUCDgEBBYF?=
 =?us-ascii?q?ngXpyE4MngkIMDgmDT2qJaUABMYEpizWBMAGBIAEB?=
X-IPAS-Result: =?us-ascii?q?A2EnAACZ4WNdhzklL2hkGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?4FFUHBzAwQLKgqEF4NHA4UyhTuCLy2aOgMYPAEIAQEBAQEBAQEBBwEfDgIBA?=
 =?us-ascii?q?QKEPQIXgnQ4EwIKAQEFAQEBAQEGBAICEAEBAQgNCQgphTQMgnhNOTIBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAhQkOQEBBBIREQwBA?=
 =?us-ascii?q?TgPAgEIGAICJgICAjAVEAEBBAE0gwABgWoDHQGbdD0CYgILgQQpiGABAXKBM?=
 =?us-ascii?q?oJ7AQEFhH4YQgiBTAMGgQwojAQGgUE+gTgMgjEuPoJhBYE4EBaDC4JYjDqCY?=
 =?us-ascii?q?4dDlQ4JAoIehmqNUwYbmE+NaIdRGpA7AgQCBAUCDgEBBYFngXpyE4MngkIMD?=
 =?us-ascii?q?gmDT2qJaUABMYEpizWBMAGBIAEB?=
X-IronPort-AV: E=Sophos;i="5.64,433,1559538000"; 
   d="scan'208";a="150419256"
X-Utexas-Seen-Outbound: true
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 08:44:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9ssloCGQQIiEFDnUcQT78d/gOZ/+gFEzhmPp9w3Lt+899NM1mDf6qN60I2km99y0jOWLZXpq2EeYFZfA6/kihtqvxgn9uGf4DpUealJfGtMaXpVrT0TEGEmUw6/lrxoPEMWA7B8pvNFBPasa9jOFOW+w7HLgdpwc6EZCY4m2IYcOgL+Kb7eh19Hb5zNG35+bWCIm0Kud5yQDQBJKqP+HNHU0TuXyKJtMUyt9NlcfTWGDbKE6kFoXuzM++RiInBEBfuaDu7yQsKbb1fbG/UoE7+8YzOHzg/3oe2I88URjJZsRceZetEwaqoNGS+M4V9h+ucVQpNgWnIRB8kzocdT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQXvrN6Zrnd+3LaRs6hK+ZxHEr/NFXoxpgsHfUIo7Fw=;
 b=VGyKIKsyEmTJ9NVX54shV9ApnkxswLqapgcoDpLkMcpuGnyw7QmoG2MgCskF+Bpz6SAVSyLlh/M8HeEips+ZipDw0WnUxHePmdMNsUhEEBbNxRAVeFh43ZiBUboBBmCo3OeexLBFrKt45ZWE/QPvCfCE1XDwQzkMy5aPjbz5jpiEPgG73dx2L13v9bC56ZaKTYExwJQ+C+8frxTugrOiucko7OC9jfRBRYmckYDdd3raoGaplXpZDJr4WqvT+STJsgqzgnvBhrrwmLkpcU2uLSzlRcESxjFb0oBSVX/oxe5+esf/zbL+2LcOdgBKphgNLw5ULth1+YbNn41JUf1avw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector2-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQXvrN6Zrnd+3LaRs6hK+ZxHEr/NFXoxpgsHfUIo7Fw=;
 b=oTYYPQGBAigyUpHySwOPV3BBO2cjQQGRfu0XdSb/+2E1d4IdgxEL3Ug1PH7elKzbVRSaxtYqJI3/FMVl1g7LVm8XmWdG63YxI3vm6TMatQq/OQzze4g1HW55C1xKfdISFHErJPvzVOl41uPxovsrNQUeTvW0iPLY8YbR7Gx1siQ=
Received: from MWHPR0601MB3610.namprd06.prod.outlook.com (10.167.236.12) by
 MWHPR0601MB3721.namprd06.prod.outlook.com (10.167.236.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 13:44:25 +0000
Received: from MWHPR0601MB3610.namprd06.prod.outlook.com
 ([fe80::1d3a:f9dd:9d6f:1b51]) by MWHPR0601MB3610.namprd06.prod.outlook.com
 ([fe80::1d3a:f9dd:9d6f:1b51%7]) with mapi id 15.20.2199.020; Mon, 26 Aug 2019
 13:44:25 +0000
From:   "Goetz, Patrick G" <pgoetz@math.utexas.edu>
To:     "de Vandiere, Louis" <louis.devandiere@atos.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Maximum Number of ACL on NFSv4
Thread-Topic: Maximum Number of ACL on NFSv4
Thread-Index: AdVZ/zHAXlVbOFcuRg6ALmyIfYKMtQAAvtpwAISMAoA=
Date:   Mon, 26 Aug 2019 13:44:25 +0000
Message-ID: <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu>
References: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
In-Reply-To: <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0006.namprd07.prod.outlook.com
 (2603:10b6:803:28::16) To MWHPR0601MB3610.namprd06.prod.outlook.com
 (2603:10b6:301:7c::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgoetz@math.utexas.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.198.113.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 057aacbc-6522-464b-ae95-08d72a2b81ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR0601MB3721;
x-ms-traffictypediagnostic: MWHPR0601MB3721:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR0601MB3721E944AF47F0E5CCD09CAD83A10@MWHPR0601MB3721.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(42274003)(256004)(14444005)(8936002)(66946007)(11346002)(5660300002)(966005)(110136005)(14454004)(229853002)(786003)(316002)(66066001)(66574012)(478600001)(64756008)(3846002)(31686004)(66446008)(6116002)(7736002)(53936002)(53546011)(66556008)(6506007)(386003)(66476007)(31696002)(52116002)(76176011)(6246003)(2616005)(446003)(476003)(2906002)(486006)(6306002)(26005)(6512007)(102836004)(305945005)(6436002)(6486002)(186003)(8676002)(81156014)(71200400001)(71190400001)(81166006)(86362001)(75432002)(88552002)(25786009)(99286004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0601MB3721;H:MWHPR0601MB3610.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: math.utexas.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0f9cbJB5ddp+hmqZl5pR/ptn5AZ5Ew2vYhh+uT6c1A266+zymwm89DbXIPQi3qEsyny4WP7s4aBnXR0MFXiQI36ggjlwjmOCTjS2i8yDSBmOkl78A4lmRwWnM3yToCIvVBwnE4bMYxbjnPH4ADvwIrEuvaE5A0GmeP74IJ7aFcMt3kbN4QPFBkOzdbNICJ8ybguLCh8NIKB7QmT3dugaZGUpMwptHnuQCTKyC2Nv70+QGH1C/VXL6XB8l1XH0z1OsH52HNITm6YArbjs0yDF8M2g8CF2bbTqWqMXp685JoxE1bdey3Vdtd1vFhHM1C+bUafWsLXJKF7p6fuU9jO7JOVuFDd0VIIqcYCUN0lGJBApam+2thjBkr9BNfi9pwKvR/8mBk8XFjNwhk6Xr5/RUc0ksNR/MmXBGDRQXB5UjwU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE9D725E54732948937025928B4D9FBF@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 057aacbc-6522-464b-ae95-08d72a2b81ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 13:44:25.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGh3QNn1ld/BYViLX96Cu1JGJGCapq71xj72wuVdpTmIEluFEJpn9kv0rXU70drWqoke+IcCVdqlUwvkvP0LgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3721
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SSdtIGR5aW5nIHRvIGtub3cgd2hhdCB0aGUgdXNlIGNhc2UgaXMgZm9yIHRoaXMsIGFuZCB3aHkg
eW91IGNhbid0IGp1c3QgDQpkbyB0aGlzIHdpdGggZ3JvdXAgcGVybWlzc2lvbnMgKHVubGVzcyB5
b3UncmUgdGFsa2luZyBhYm91dCBodW5kcmVkcyBvZiANCmdyb3VwIEFDTHMpLg0KDQpPbiA4LzIz
LzE5IDU6MzEgUE0sIGRlIFZhbmRpZXJlLCBMb3VpcyB3cm90ZToNCj4gSGksDQo+IA0KPiBJJ20g
Y3VycmVudGx5IHRyeWluZyB0byBhcHBseSBodW5kcmVkcyBvZiBBQ0xzIG9uIGZpbGUgaG9zdGVk
IG9uIGEgTkZTdjQgc2VydmVyIChuZnMtdXRpbHMtMS4zLjAtMC42MS5lbDcueDg2XzY0IGFuZCBu
ZnM0LWFjbC10b29scy4wLjMuMy0xOS5lbDcueDg2XzY0KS4gSXQgYXBwZWFycyB0aGF0IHRoZSBs
aW1pdCBJIGNhbiBhcHBseSBpcyAyMDcuIEFmdGVyIHRoZSBsaW1pdCBpcyByZWFjaGVkLCB0aGUg
Y29tbWFuZCAibmZzNF9zZXRmYWNsIC1hIiByZXR1cm5lZCB0aGUgZXJyb3IgIkZhaWxlZCBzZXR4
YXR0ciBvcGVyYXRpb246IEZpbGUgdG9vIGxhcmdlIi4gVGhlIHNhbWUgcHJvYmxlbSBoYXBwZW5z
IGlmIEkgdXNlIGFuIEFDTCB3aXRoIG1vcmUgdGhhbiAyMDAgbGluZSBpbiBpdC4gSSBkaWQgYSBs
aXR0bGUgZGVidWdnaW5nIHNlc3Npb24gYnV0IEkgd2FzIG5vdCBhYmxlIHRvIGNvbWUgdXAgd2l0
aCBhbiBleHBsYW5hdGlvbiBvbiB3aHkgSSdtIGZhY2luZyBzdWNoIGFuIGlzc3VlLg0KPiANCj4g
T24gdGhlIG90aGVyIGhhbmQsIEkgY2FuIGFwcGx5IGh1bmRyZWRzIG9mIEFDTHMgb24gWEZTIHdp
dGhvdXQgaXNzdWUuIERvIHlvdSBrbm93IGlmIGl0IGNvdWxkIGJlIGEgYnVnIHdpdGggdGhlIG5m
czQtYWNsLXRvb2xzIHBhY2thZ2U/DQo+IFRoYW5rIHlvdSBmb3IgeW91ciBzdXBwb3J0Lg0KPiBC
ZXN0LA0KPiBMb3VpcyBkZSBWYW5kacOocmUNCj4+PiBUaGlzIG1lc3NhZ2UgaXMgZnJvbSBhbiBl
eHRlcm5hbCBzZW5kZXIuIExlYXJuIG1vcmUgYWJvdXQgd2h5IHRoaXMgPDwNCj4+PiBtYXR0ZXJz
IGF0IGh0dHBzOi8vbGlua3MudXRleGFzLmVkdS9ydHljbGYuICAgICAgICAgICAgICAgICAgICAg
ICAgPDwNCj4gDQo=
