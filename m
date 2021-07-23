Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036593D4177
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jul 2021 22:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhGWToG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jul 2021 15:44:06 -0400
Received: from mail-dm3nam07on2133.outbound.protection.outlook.com ([40.107.95.133]:38465
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229762AbhGWToG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 23 Jul 2021 15:44:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDknGEsOoVs2xbSBqaHHS2rvp9tq/LErrTV8vRB+Vj/5cS6vebm+cWrlaJS+dAfPt0vAG6/Fces83dNf2pCpSkRKmdaQz8HM14zh5g8wh2rPeuaQucUooRpu1m2gTfSPHP0e3UWdebyMVRn9jnrbdAol6uLDo+q3e6IZQqz4AIxUibeOTMRHUxzzHurY6QvI6dd7WhOwfFVqbvoEMlsuF1D4TfOcsv2w8kC7U8xuD30yZyAKn+e9tB2YtfurJXm22Rygf0w5DDMtPbRPAol/Yd9Irq4yv+Y6ZBzYVxneB0xBsOlyyjU/1c1T6h/z/rst0vPH5lD0eUOjr0HEzGMQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwVvMlt7DoXzdXh6I8WhDbddOwri3GB9/kBhoy997aQ=;
 b=N4O6hiRpC8o6yENHWzaHKkqwaIi4t3ccwoMraCT1ah6BGizkldifjKB9xtzP1oZk8jYJGj/V+PxNb6gIXWc9sGYgZ9nSor90Ef6aEozggIfXATf3OIRCFH3J/Fje+L3pF4ojTzkBsFTrVlGOC0nu2Wrl+URDAHelcCRqBMAPU7yfX8OJ5qIpbAHZ5Mfz6oha5Ef6H+5OR9KJ9jO2CsCun0zhXm9K4l/NE4DiMj5g5p+K65x0kkLkEOFMFnyssnPU9qlDXfwdZ4fkO2Vh6OjuZTibazjZnKEyXW0iGdNyCBXeIwbD8exCUmLxS2pbLlsf2rAW+/lwipBjkZRZ/nK0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwVvMlt7DoXzdXh6I8WhDbddOwri3GB9/kBhoy997aQ=;
 b=Es1qoeFvcy3eJlZnqsuhdtywkSuuifEe/NwzBEDR3/RnrUpi/q9v9rXonbxWabnWw/2LEasDt7GjK6MadlwgE71Xf77dv/30k46KccH2gjEyk7dc2LI9m53F0mVEz5kbjY3SwCLRk2pd+rVc6LF6Wr06Pe9EB0pBT8Am7dIfkD0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3895.namprd13.prod.outlook.com (2603:10b6:610:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.9; Fri, 23 Jul
 2021 20:24:35 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4373.009; Fri, 23 Jul 2021
 20:24:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fcA3+DfY3OUmOk0QnMZuIQ6tRAXuA
Date:   Fri, 23 Jul 2021 20:24:35 +0000
Message-ID: <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
In-Reply-To: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eee2fa8b-2b51-4bb3-1f50-08d94e17e38c
x-ms-traffictypediagnostic: CH2PR13MB3895:
x-microsoft-antispam-prvs: <CH2PR13MB3895A9192DA9C10641093F7FB8E59@CH2PR13MB3895.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dp2Wr+iwpLAf6zgKIEtc3DXKrlxCsqN9BouWy6fYWZaHq5xEllr9wXVC7ULKcOgu7uRl5jhGqFta1XQqhRs9eDJoBxbg0IgWyrHdd7CUpChtkFnSw72vMg8wh+GLeXD1awNWxlHYylE6gnPihEXw/oJ7tdzl4yfPslimYL+GdGI+QqOlnjRxQaQ/b1zbJeLAoneeRxYDzIiJX2GBytPKLlwZODXvnS8ZfAVWk3eYQ1kjzbVbI2H3XfvoGXzSf2eR7/IcLVWfEEMIOr/RR+mZbxdhksCyNcoa2uAmyPE5/rYvOFLpSzcfRb1zQzq+8Ct83pV6ipNfjw5cBtv9lRnOYZ7ZwJKwrZQ6FmyMRfGejobv4HwRYHAfRFX79U2TYmAULQ4AQ3iGnbjn+H1JYNzVbezTd4FtQw/Qxj5b/Vu9k+5+AfsCtZ1rTwPjxin+QkOt9fdoG7XgRKhkK53ZdX3XKCSbsdN+OMSGYrkxu8cEs8SEZta4BfySVg1oaYvr4V26lVP7xu4xTosNk7Xbjy/KRQliYe3ZvIK4u0q6D+jzNSOrJAPN+uRiS4UdYP5XK/vVpbSLnNNgyFVrypPYAMXd1mvJB+Am1d0CWTJgubcY7BPMgkv9YWhXSr0BUWeUDoops0tnzGlhFQgHmRhokdT1rdcVwgxgk0SX9GRa/G/HRFT/jxhPnmF9BpcXOcuiKKG37AGmZhasmkSQckvm3dmmZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(122000001)(6916009)(86362001)(6506007)(38100700002)(316002)(8676002)(2906002)(4744005)(2616005)(71200400001)(64756008)(36756003)(66476007)(6512007)(186003)(3480700007)(8936002)(83380400001)(4326008)(26005)(6486002)(66556008)(76116006)(508600001)(66446008)(66946007)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU1XUmg1WDFRZHg2Z1dXejFTeFV6M05WV0M3QXVmbXV6WHA4a2FtMTBYSkV2?=
 =?utf-8?B?elVrOGRaMWxBN2UwSDNabnUyNElyakE5T3FoT2lxV0NCTjVzbHJPZ0U3RlBZ?=
 =?utf-8?B?ajBkR1JGdVN1ZldmSEVlTHVXTDBOMHZUcHRDcEpvbktwbUxRUTJaQ1V3anRF?=
 =?utf-8?B?U1l2OGtJWnJZTkFlSkxhL1c3S0xmTUg2aFJqRXZqU2lneXpEYWNSVkhuRHhk?=
 =?utf-8?B?VW1TOUgwL2NXWUhLMENkc3dzdFhVOEJwaUJDTXI1SU1BRGtXaGorZXJBamJQ?=
 =?utf-8?B?bVExaFFjZ0oyalJnR3VZTEF5MEovWXZUemk5QVV0eWFHWmxUYUtxTjRkQUNx?=
 =?utf-8?B?bWNySU1YWWRqcGlNczQvS3dGVnplTkxZNXlJSTl2aTdyencvMVZITWtnMGV2?=
 =?utf-8?B?ZXhBQzZ1Y2RCMzNtbXRzb29vUk1OUnRzL01UUkpxQ0VGSGpibkxZSmFWL0Np?=
 =?utf-8?B?NXdMVjkyY0prU1dtZHJHNHVneHk4aU9KTnRrejhJK1RhY0VMaHhUVUIzQlcz?=
 =?utf-8?B?bHpGZ2ZNZGxmclUxMUtHTXJQZHVlbWcrUkNZQmJQN1IycXVueUFUcEEybEZJ?=
 =?utf-8?B?Ulp5MGVyQVhZcEJQOU04Tk45SHE4MktwRXVGVEhnYlVkYmk0UUJVVUZlL01L?=
 =?utf-8?B?cURVZXp6VUdha1ozbTdBb2NxVlVWMjBySmFVbjFTQlZkV2FZVnltcUNuNGs4?=
 =?utf-8?B?VmNkdVd3ejB0cXRFRlloY3UxZElabksyWUlLZTEyUnlPZVkvMHhJbys5MTVq?=
 =?utf-8?B?a1RNekNvS29MaUQ2WGNjZXdkd0ZFOCtjWE8rSjdPOG5tMXA2MTNZdWk2bk0v?=
 =?utf-8?B?cXBseE0zdFZldGZaK004Y0lxQXFoYWhMUXIvNlJyeUFUcytwN0ttd1d5RCtQ?=
 =?utf-8?B?UXc3Q1JRbDBZZ0Vha1VidkNnWHRUM3N2Q0s2SnZlblk4NEUzVlB0VGxzZ3Q5?=
 =?utf-8?B?TXQwTGNOdm43S2I1RFd1UmlpZnZKWktUTFdTb0FqRlNDMFlWVHhCajJIV3dR?=
 =?utf-8?B?dm4rNllpbUZJVjN0ZUNmaHM5V1N6YWUwL0R0WG5ZWTYyWWkrdFM0b3lTNTU2?=
 =?utf-8?B?Z1hkRVQ1R1BBYk1wVFYwbVRmcXZIcEZuUXNyVXlvUXZVZDZCb0N2UHV2a0pp?=
 =?utf-8?B?a1RGY0kxSGtaM0NkY2kxRlM4VDV3RUQwalJHbmo1Z2JQalo5NUxoNXRxc0VE?=
 =?utf-8?B?RmV6VlB1OHdrNUlqSjNjc1BKMjdta0pscjVtTTQvTmFBZ2F6aVIydWQrSE5s?=
 =?utf-8?B?NnJ6OXVTOWlRY3Rrdkc2L3g3ay9MdkNWZUxva3ZHTE9GZWVXU3ZiTDQ2SFUy?=
 =?utf-8?B?OEhVVjVHbG9HbFN2V2FRRGFRYlZjZmRCam5Qa3hVc0pXN2s4ZStEZ05FQ1VL?=
 =?utf-8?B?c0tXbFIvbU9ydVk4ZDJKMEQyU1BmUkQyRTRRcUVyVUY2T0pReE5ERnNBU1di?=
 =?utf-8?B?WHR3QmtPQXRselNaeE9lYUlLckc5Sm1VbUFCakNrWFlrMlMyQ2ZzMlZIT3Qr?=
 =?utf-8?B?VjM0YUJkeStTdDFJbE5iRHVpdHhrbnpuQ2RPMGFySmVWQ1lpOFlQUVdQUllS?=
 =?utf-8?B?Qk9HWHRUeGdLUkdlb3RqR1V5S2xTVXpjd3VvblkrZm1YM2J5bFVvczhnZjdY?=
 =?utf-8?B?aCtPZnZac0dhTzJZWTZVUEdROHQ0OTl0RkhuSUZFR1ZqNTQvbVEwOWczRkwr?=
 =?utf-8?B?K2w4NTFPTmNNV1pZVVM5b1U0dXl1QStjdVV5cWZ2NUdhOGZHdXpPWU5ZQnNZ?=
 =?utf-8?Q?KG/JBSsJAg9fslomsEcNdyF2X3n1yA//+GKejR5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A38AFBA907E13841ADF80293145635FC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee2fa8b-2b51-4bb3-1f50-08d94e17e38c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 20:24:35.6738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFb/M5KrNfIRs1toFYfdz5T8diOt0/ebRP87UzxXoq1z5ktMiBNVOLWBKYlCLguMHhzD35L2cewBYog5ds6l9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3895
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA3LTIzIGF0IDIwOjEyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEhpLQ0KPiANCj4gSSBub3RpY2VkIHJlY2VudGx5IHRoYXQgZ2VuZXJpYy8wNzUsIGdlbmVy
aWMvMTEyLCBhbmQgZ2VuZXJpYy8xMjcNCj4gd2VyZQ0KPiBmYWlsaW5nIGludGVybWl0dGVudGx5
IG9uIE5GU3YzIG1vdW50cy4gQWxsIHRocmVlIG9mIHRoZXNlIHRlc3RzIGFyZQ0KPiBiYXNlZCBv
biBmc3guDQo+IA0KPiAiZ2l0IGJpc2VjdCIgbGFuZGVkIG9uIHRoaXMgY29tbWl0Og0KPiANCj4g
N2IyNGRhY2YwODQwICgiTkZTOiBBbm90aGVyIGlub2RlIHJldmFsaWRhdGlvbiBpbXByb3ZlbWVu
dCIpDQo+IA0KPiBBZnRlciByZXZlcnRpbmcgN2IyNGRhY2YwODQwIG9uIHY1LjE0LXJjMSwgSSBj
YW4gbm8gbG9uZ2VyIHJlcHJvZHVjZQ0KPiB0aGUgdGVzdCBmYWlsdXJlcy4NCj4gDQo+IA0KDQpT
byB5b3UgYXJlIHNlZWluZyBmaWxlIG1ldGFkYXRhIHVwZGF0ZXMgdGhhdCBlbmQgdXAgbm90IGNo
YW5naW5nIHRoZQ0KY3RpbWU/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
