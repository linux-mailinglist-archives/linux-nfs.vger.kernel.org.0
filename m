Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F407471D46
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Dec 2021 22:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhLLVUE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Dec 2021 16:20:04 -0500
Received: from mail-mw2nam08on2139.outbound.protection.outlook.com ([40.107.101.139]:63478
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229585AbhLLVUE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 12 Dec 2021 16:20:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOk4LbrDPNfPq0VE9VJjpMCalYpcPA4NdXUJoffTdYqn9eusx8LTH9u+XazTCzvlp73Agz88eEHuDwvHR0qFhGT5BkBvjPvHbvXkLhtvPrHYB7c3MmWhB6jt2K3X62GcR60Lp93G2DoQoHoKAG+CkbcjSqhrYmcmUBk1QjlU21HiIgVruWnZrmRg04xpfu5GXWknqtOEmKiV4D2yiOxs08HiR6p/J5PwckhVwG5hFypnp77uuSpQmX3sS8QcM5IUfuJ48gHgnqYjrXD/L8dNH2iXBWwylllh4zcZTY+zANjVQMvp6mXlBwAIyeh1Xl1FTdTBTiihC9CT64sgWSTkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILSfEMgpKwLKzvJslRFLzMTUjg1Z7I9j7LfysoyJ7WE=;
 b=Jjn2U0h0WlO/Ix9tqqmFnTSoCVoRm1Islao85E5FPBSalad6qBPaBRNEhQP3NSTb0XQ10Je1J9Wcb5yeG+OzOTJs2wofloeR4y6cvR9W19UzqBd/4ihBP1QBhJ9io4GRPvBqSnikidaj1IIIqusfY0AOOZNMeEYadb08ic/kxAvoUwOfVhACUd0XoUL9d/WtuLcjvwu1hp5zh3o3hxQAsC+BJeJnHWdb+bZ+ddqWafv3KNdwtlvOf1+VH8IZR7Sn8fUrGQ9TJqWegwYCSYkmVjqfua0dDRRm/voaCNI4WR1M+gg9Rw6cRtSM2CdTqDfrm28zaTt9aMgUxrAYTZSsEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILSfEMgpKwLKzvJslRFLzMTUjg1Z7I9j7LfysoyJ7WE=;
 b=PHW63lE0RCTrBsce/7YhG86CHXVSboO44GCuizPqqmQSZ1YibdLEqmJHrvEc5wweDFBOs265hTLQspA6MbefxxahF/dCtucYwr0qab5CNMl8NV68Qf1aK+e+g+ReaklHFjYfiWi+ZRgrHPpncANndUR/9IoJ+4oYTxwOjOppyAs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4716.namprd13.prod.outlook.com (2603:10b6:610:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.10; Sun, 12 Dec
 2021 21:20:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4801.013; Sun, 12 Dec 2021
 21:19:59 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "david@sigma-star.at" <david@sigma-star.at>
Subject: Re: [RFC PATCH] NFS: Save 4 bytes when re-exporting
Thread-Topic: [RFC PATCH] NFS: Save 4 bytes when re-exporting
Thread-Index: AQHX75ta92YY4WU8k06yTBIDlSm7OawvXNEA
Date:   Sun, 12 Dec 2021 21:19:59 +0000
Message-ID: <dd3aec8fed9bab9b3e62fc2093803688b7b71682.camel@hammerspace.com>
References: <20211212210044.16238-1-richard@nod.at>
In-Reply-To: <20211212210044.16238-1-richard@nod.at>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6b1f52b-0275-41f8-fecf-08d9bdb5277f
x-ms-traffictypediagnostic: CH0PR13MB4716:EE_
x-microsoft-antispam-prvs: <CH0PR13MB4716ABED92D01DC1C49826C9B8739@CH0PR13MB4716.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPO4hXCJvyhag3OcpZ21yHkmFAS6wlhLrmU5wHapLzWiyGiOKwlZbvtalR9DGsfYNe38/x5Dy6sKvRKv+m1yjoF+3h+EeyKdpcwv3iDGc0YUfjbwrEFaYj62TYC1xgBWLOwkD7pH3B1uP/Rm1QX1I+VaWxeYObYX6T4R8hMQqkCWBg4Rd0+Su2pgzJZDzAn+b3IAUG8iBdgCRbKGIcmxwu5h6HAe3iI9D8mhnY8/IkKVvYzQJbdeugSNi+1OMDeqbv8/NkFRKt7Gm7M6IOlJaiUgoQatDZ4CeiIpE1L7beWenuJDS5JERnTQ/j944oWefjMwi06/b5PgX4nniLOJrJgKAvmDG8Sh6ydYGNlbJnbIRxT3Ha4UaaP+gq/404eZhEw2NT5P02fJIg9xqZDyo6nL2zgLahaFj21kFt2+/721hW35fExoKvxdKBPbRH1gh/Fcqm+tjjZWhjGR1lTUK+Tc2trTJZFuHhstjwf/8jKG2vSEY2Xau1UvdoC2d+DM3K+Q3v+Y6UiEwMtDpRUzZ2puCchh94UbZTEV87fVR/pE2XOD3xexO1JITwC5UBNBJ/do5Vj7OAFe7TySrcSg42lXTzPLpYQ5FWk07oeTi52irZD32YJ/7tIqKjr7FkurBEsOqz/b/rOy/MkdJuoDKiSZapVyDmeq4tk0IQA/AKl9JLGgcsDsmzZ703/WHWirqysGjbqlzrpoJl1HoP4Jyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(396003)(136003)(376002)(66556008)(110136005)(26005)(186003)(316002)(6486002)(8936002)(8676002)(6506007)(5660300002)(4744005)(86362001)(508600001)(36756003)(6512007)(83380400001)(54906003)(2616005)(38070700005)(66946007)(4326008)(76116006)(38100700002)(122000001)(2906002)(71200400001)(4001150100001)(66476007)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3gxMlRhdzJqd1lrUzE1ZlRodUhlbFZWK3poUTNWK05ibHBuV3A0YnlCZzVO?=
 =?utf-8?B?bHJobnJPekVKTEtseHhURHRiMkpnU1RBNjVHNmgwQ3pQTnkxL0EvL29NYU5i?=
 =?utf-8?B?bGM3MVFOVkxtdFlPbkRpRHFFRE5kTEVQU1RnZXBhNTFEcGpadGdPYUNNN3I0?=
 =?utf-8?B?dUVZZ1NVellxVDc4V1YrUkV6eWIwcXlWVW1VU1hHVjlCZE9UNXBDbGhBUjhB?=
 =?utf-8?B?QXVUUXd4Mzl6b2F4VU9tM3JIOXRwMEdXWjBjYUVEdFFuVStCS2k1SEVVODV2?=
 =?utf-8?B?RUNya2QzMmZQL2huek13ZCtSL0hLN0oySkpkVGI0ZVdSRUpzT2ZBMEp5Y2RZ?=
 =?utf-8?B?RXRZcVBWWjU3WFhlazBzRnBzVmNjZWNoQUlTYXNmdTczMVVzNkV2QW1tOUlQ?=
 =?utf-8?B?em9QdTZ2dVVyblk0UWlLaXp4VjF4cms1U0pEWi8wUTdzWWdKMW9KbVlGY25U?=
 =?utf-8?B?bmllUk9nc2FLcFNFeDZrUUdpQXNsUUtwTTV3NUtSSzFVMGZXZVBxYXcwTEpF?=
 =?utf-8?B?OTVUUXJYYnY0elM2VjBBZVB0L29KelNTblRya1NONHF0ODVyRElEekYrZ0dN?=
 =?utf-8?B?WHZOMnhKOEdHZU9PNWZCbXlBRmVUNURuRUdpWlZhQ2RrdEd2MnN5bGZoeUNh?=
 =?utf-8?B?NUdWYVJ3VGN6VFlXcWpJckRzREZrWFMzMnJyc3J0dWtkOWZZVUEyMExPTVpF?=
 =?utf-8?B?TlcrOWp5MGxmMDE4RHNZb2I5Y0RnL2d0SnAvL1NGWHZqcThMMDZWb2RKcHNB?=
 =?utf-8?B?dzc3d08rSEcxczFHcThSSjJkSE1sWW4zSXNjc1FOQzRjRUVuYjQzOGJPbS9O?=
 =?utf-8?B?WDRpWFQzZExMYnpNckJFQXl6WkxNMCtQazZQckp4Yi9oRy9PRXlaa0pjeGgw?=
 =?utf-8?B?Q1duRUNIUVIyaERFSDdqT3N1Nit1OStVSUJ5NVV6Mmk5OW5LN1luLzJUM0lK?=
 =?utf-8?B?dUVXbVFQNHJJeUYyU0pOU2FYd001NEdrb1E4SXNzWmprZmV0aHMrbDRjT0JS?=
 =?utf-8?B?T05XMVludXZaUWtEaldDZkp4R0l2Rm44dDhTR25HYnBUZS9mRGFqY1d1UzFI?=
 =?utf-8?B?N2RYTTNXZ3hTTFN4d2tzbmUyVTZTdXZpSTJCSkxLRGt5cHFWVnRWd24rRDBH?=
 =?utf-8?B?RVcrVWhPdWt0a3VPNGlaaDdMSi9TZlZUeS9FQ0hrZkxYVWpiYVVFZU5Kb2Ns?=
 =?utf-8?B?YkdEYjBrWmlneW5CUlNLQWN5OGVRZmE5ZVVYRlhuT280TVo3ZGVQdk5ENEts?=
 =?utf-8?B?cWtTUVIvTklvV05keUxuWHkyaWxlRDJDc2crUVF5N1U3WVphNzJGNlNndGta?=
 =?utf-8?B?dUpRS2wzbVdQZzk0NWFibzhkRnRUdWEybDBzTXptcnNYQ0tWbXdIcDdvTElY?=
 =?utf-8?B?MnF5N2lHRkZDZ3R3NlplSldGZWtoQUk3K2RsQkM3RXlIT2tNNXNwSE01dEkz?=
 =?utf-8?B?OVhYdmY3V1AxKzVaczFLWi9UYW52aW41YnhmMWRjS2tyR3kyemgvc2xCenZa?=
 =?utf-8?B?NGs5cy9DQnpkdWlUbVpJQlNLd3ptcy84RFM2KzBkQkJ6ZjZzTGI1OUgzamEx?=
 =?utf-8?B?T21wa3NKSnBmY2xBVndmc1hOZzZueHFISUFwSTBlaFZaS2ZVaURyQXVPNVZH?=
 =?utf-8?B?M2JvNlE5Z2xwZUFocUJMNHdST0tsYm5FRXM3eU4wQVptVzE3eU9rUmpiNjRV?=
 =?utf-8?B?N2JMRklFNHRVbFc3ei9JTjMvOHl3M3YxcEdvc3BwN0Q3QUxyNHBaUUJyVTdv?=
 =?utf-8?B?ZXBDRHEzK1hDY3N3NFkwTEVmNjBYNE5nM1NTNXFkN0xJcVlyYm01RGR3Mm1v?=
 =?utf-8?B?MC85ZytUZG5XYk82cllNaFJxYW5hNFVrSnJ3d3pSVVFhVkpDeHlnTmJqNEJw?=
 =?utf-8?B?djBVR1QzTjRsdUUzYTJoV1REbVlYb1g5cmdYTHQrMTdvL3psSUl3d0xuREF1?=
 =?utf-8?B?VHRmbk9lazg0VUV0YVlobmd2RkRmTkRIQmFNZzgyTTI2czkwdXgySjdaUjJE?=
 =?utf-8?B?aGczVHY0RUN6a1dycGhsK0I0eHRDTGFGNDhZdzhXTVY1MFp5ODJMQmRaQy96?=
 =?utf-8?B?WUdwcE9EaUFLN2sxaDU5dmpaOGtDMEtDbGhiQlc5YTg3NTVZV3JMWXJvamxn?=
 =?utf-8?B?YlRPZFNRV2ZBeVFoNnRjbTVITUMyUEw0dXlIYndOOEt0bVZOdkJ4Y1hWWDA4?=
 =?utf-8?Q?hdDGDrh5cThXQyRlAL6STdY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30EF3009894CE446BFB0E3E794835B5B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b1f52b-0275-41f8-fecf-08d9bdb5277f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2021 21:19:59.6317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L76D9+Cqo9nh9Jp4tL1OZHoFR0KdBsCBDZQJfBKIad5ySFXuyhKK5l8DeKmkrbJdXeTpi/OroVLBvv0Ooh8xQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4716
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTEyLTEyIGF0IDIyOjAwICswMTAwLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3Jv
dGU6DQo+IFdoZW4gcmUtZXhwb3J0aW5nLCB0aGUgd2hvbGUgc3RydWN0IG5mc19maCBpcyBlbWJl
ZGRlZCBpbiB0aGUgbmV3DQo+IGZoYW5kbGUuDQo+IEJ1dCB3ZSBuZWVkIG9ubHkgbmZzX2ZoLT5k
YXRhW10sIG5mc19maC0+c2l6ZSBpcyBub3QgbmVlZGVkLg0KPiBTbyBza2lwIGZzX2ZoLT5zaXpl
IGFuZCBzYXZlIGEgZnVsbCB3b3JkICg0IGJ5dGVzKS4NCj4gVGhlIGRvd25zaWRlIGlzIHRoZSBl
eHRyYSBtZW1jcHkoKSBpbiBuZnNfZmhfdG9fZGVudHJ5KCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pg0KPiAtLS0NCj4gV2hpbGUgaW52
ZXN0aWdhdGluZyBpbnRvIGltcHJvdmluZyBORlMgcmUtZXhwb3J0IEkgbm90aWNlZCB0aGF0DQo+
IHdlIGNhbiBhbHJlYWR5IHNhdmUgNCBieXRlcyBvZiBvdmVyaGVhZC4NCj4gSSBkb24ndCB0aGlu
ayB3ZSBuZWVkIHRvIGVtYmVkZCB0aGUgZnVsbCBzdHJ1Y3QgbmZzX2ZoIGFuZA0KPiBjYW4gc2tp
cCAtPnNpemUuDQo+IA0KDQpOQUNLLiBUaGlzIHdpbGwgYnJlYWsgZXhpc3RpbmcgcnVubmluZyBj
bGllbnRzLiBBbnkgY29kZSB0byBjaGFuZ2UgdGhlDQpmaWxlaGFuZGxlIGZvcm1hdCBtdXN0IGJl
IGFjY29tcGFuaWVkIHdpdGggY29kZSB0byBkZXRlY3QgYW5kIHNlcnZpY2UNCmZpbGVoYW5kbGVz
IHRoYXQgYXJlIHByZXNlbnRlZCBpbiB0aGUgb2xkIGZvcm1hdC4NCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
