Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3299245CFF5
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 23:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhKXWVH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Nov 2021 17:21:07 -0500
Received: from mail-co1nam11on2133.outbound.protection.outlook.com ([40.107.220.133]:60768
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244160AbhKXWVE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Nov 2021 17:21:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfB17K/wp/i2gZIxuT2OpnPJUTtseWmXythneL9AtJCT2m2lQAoZjZ0r3uIl6NLrM9Q6ve7VsTT/rhsRsUoKAfwfMOC80xBGEms5W/77Du68imNlLkgFVtW29VBue0EsTf4jaKdz/VVBxRHdbdEd4q9zT2JJH6UV10vExqTKDBLqeeFATC6PraseHsoQ0aqhUb+7pab7SSVdo0Ou8jwasJbRs/BLfQXtMizkgexfxR5ARnBTV7DN1vc3dqrsi/D4nOEw1EcgMfBlGLEvFTEXzheoy8+A9Ra3Drde00ZoYh1wG0gGV0PBtkTw/wI8UhH4aMmGOLLe0ED1urzLqgb6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMmqccqIXC4odrKBQa9K4SZ/ykDUOeS9FCYePnFOEjg=;
 b=QUJX/Juc4p6zgCXniOtzRUH3QDE8jX56ZWrTGqdJrSjgOgPfB+PN4sCf42mhfM8fg3pRKvnoOY0iPE3neoImyeStWgwDfW3ByTfNVCDBCHz8ABqrwHB9ErPS7PTif4jVgmbbNlmH6Z/snxQJo09xtOSfOQgTLy6jWRAvy9COXGqMDExXMjhKnvMyB7pqeGKqO/vZpXMoTpy0RwD030Hvz5rLY8GTjamDgb+L755VmTsYgQvTtcn8bosReZwVXMGPoV1bxfDCs3rDLvAEBooEg32K4O/0IKj5TSNmbPYfHxrvkV+9ESxKUe8vsqQsDGE7FNumrGzt3dwxFWNVF+jJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMmqccqIXC4odrKBQa9K4SZ/ykDUOeS9FCYePnFOEjg=;
 b=L4hQV++NJftoi7BRv9IW7PcsszMb8mNjCOUp/lusHV5Uu7YtZqc7KNlk/O+Mt+Q4+gmgVdBzpg6+yQup9lybk/EI6lqSXXqMH5za5wwZz6JfRbW4x5Nm9n8sV7pNXldo1i8vrLdUTWSCBUzM65EOSIMEJPyN7kc2cvZ1r6aCqOI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3685.namprd13.prod.outlook.com (2603:10b6:610:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.14; Wed, 24 Nov
 2021 22:17:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 22:17:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "olivier@bm-services.com" <olivier@bm-services.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "carnil@debian.org" <carnil@debian.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Topic: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Index: AQHWn6R0BWW7FfEHY0ewFe9+CvNb36mUB/AAgAAVOICAAA6DgIAI+hOAgitf9YCAST4LAIAAZRgAgAMoGoCAAAhggIAAAwoAgAAP/YCAAFN+gIAAAx0A
Date:   Wed, 24 Nov 2021 22:17:51 +0000
Message-ID: <9de992c0e9dc866c08f30587ce3fd99eaea9431a.camel@hammerspace.com>
References: <20201012154159.GA49819@eldamar.lan>
         <20201012163355.GF26571@fieldses.org> <20201018093903.GA364695@eldamar.lan>
         <YV3vDQOPVgxc/J99@eldamar.lan>
         <3899037dd7d44e879d77bba67b3455ee@bm-services.com>
         <DACA385D-5BBF-46D0-890D-71572BD0CB8A@oracle.com>
         <20211124152947.GA30602@fieldses.org>
         <0dbe620703eb27f36c02b4e001e74d67390bce9e.camel@hammerspace.com>
         <20211124161038.GC30602@fieldses.org>
         <e17bbb0a22b154c77c6ec82aad63424f70bfda94.camel@hammerspace.com>
         <20211124220640.GE30602@fieldses.org>
In-Reply-To: <20211124220640.GE30602@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47df6fca-9942-440a-bc97-08d9af984170
x-ms-traffictypediagnostic: CH2PR13MB3685:
x-microsoft-antispam-prvs: <CH2PR13MB3685E4C6E20783C2FAACCD80B8619@CH2PR13MB3685.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnqeoiMOKQG8WH8ucR/8mF1FMEA46mRzF6mq8aJWU7KvRS1wH5y6536I9IcgC5XGxNgFCWkn2PFZomwT+08c329ejzKJTWgty1ucFy2Y6SNuo+vad/L/YcVDov/fNQwGAhCmrbJLuV6jXmDofBvw1luNHgVal1nrWRpqnvCt3j0GMKIQWA/q2d5Z3sUEz41uQ4ahDiqGho5NTs6zk63MjBRAcRPfhyOh0f4TcXn93h/dXtEIuspqI5c85gFOOLyuifKYZrGbP7UUj7zEzdC+FM1kOQy/Zge/iO5lS0l+gd9gIOQ/1LfU+P4DkrZuqTL8CGyUQeSV6nWrlBtwjd0pvn+d9i/o5ERDwoSVw/ZjrlELbhvs9AWI/UyQPZQjMGEGWi/iFeFoju0RrvYGbV+ToMJSuPJI8YlbwStNEgpaHISaXeuW8gwfIcFaj7Zf7oyZtLKuA7mHaGzUKLTtxpTW+56fhUpwq9RIHZmzPU4IMAwBGRNG1bJD8Q5R1wor0KBI3UJDRVrlGDO1KByp2k9MutcGMOu5V1YWByYJFbFtsob9vcX4BFm5WE+2bfX8OD2+6yOnZW84NR//CQttGOpTUYfgRtadTENf5rR8gEnrDoMpLBF7MlMo0liyTJRNp3g6mC6b8DWfZoArKfetiE1ZHU/kGAeDD2PFum0KA/Y51zwJQAY+TZ3hqMfHL2r/gNnYE48eKyBcVHOhwfHPXUaLLcZXXrh/GjQqzTDflh0il7jVSqihOQOh5eQOPMe/Lq6F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39840400004)(6512007)(6486002)(2906002)(6506007)(54906003)(5660300002)(38070700005)(83380400001)(71200400001)(8676002)(2616005)(86362001)(6916009)(76116006)(66556008)(66946007)(66446008)(36756003)(66476007)(316002)(64756008)(122000001)(8936002)(26005)(4001150100001)(508600001)(38100700002)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRVRVdXTnRUeWlCWVdIYkJ5d0I0d1V5UDRmUHRtbEJPRmJpQ041ZEJFMXVa?=
 =?utf-8?B?cWpUNzdUZTg0UnRpQ29OUWR2YzRPQllubXcxM2JMc0V4ZXFZaTREemhsRzh3?=
 =?utf-8?B?bFkvTW4waHNpaGE4bFdQTEpCQS9IQzNpc2xqVXF5bTRwSzhxS0ZaRW5rQzlF?=
 =?utf-8?B?djM2OGwrUk45N3NyM043T0VFVHY5eFJpVWhxSVhYQldIQ2lTUlZhVmFrTnlm?=
 =?utf-8?B?Ym14SytmTzJIYllMeUFyVWtzY2xNVTdBM1FaL3pDL3RETm1NL0szUWJ3Z1gv?=
 =?utf-8?B?MWdKaXI1ZkNRd08xcGoreDN5RkhMd1ZNc2dGQlRMWWRPSEJucHlLUGY5TDNY?=
 =?utf-8?B?WmtiWmpiVUhhS1lJejE1d3h2eXBYaS9PdkNjU0VOYTlyQy9FRGo2UFNQRmVl?=
 =?utf-8?B?QXduK3BkSHFieXMxNTRmZjI1NFdNQ2NLUkp6V25KSVcrd0xiaWpxTGdvL2FV?=
 =?utf-8?B?RGJmUXVneUJINVY0elRvejlJdzUzTTZiL0grTzRQS1dQV1llRDR1cSsyeXhY?=
 =?utf-8?B?Zlc3OXV5VkhOSEorNmFIVUJMNVB4RHRNNThyNXBoNHVNZStxUm5pZy9kQ0dr?=
 =?utf-8?B?WVdXQ255ZDVjenFHTExFOU1BWXBJYThITkE4cnFKVGE3YUxmTWNsWlcxSjRN?=
 =?utf-8?B?emlRK3pVemxXTThNL2Y0U0Rmb0trTldXWFdQaEMxQnpaQ1JsaGVncGVzMXFY?=
 =?utf-8?B?M1NzalBEQm4yMzI2Q3NxM2MzRkQxVEYwazJVTXowVFZqMHo2TzEwb3Fvd3Q3?=
 =?utf-8?B?Z3RVK2hxU3RudnhhTURDM3g3eTNoZ3FsTkNwSXo1d1V3MGZHMUxsakl3VFY5?=
 =?utf-8?B?NDdFZTVHLzVSZVRMci9VK0dTQUxBeUpMRENoYytzajBWK1poRXBkT1duV2M0?=
 =?utf-8?B?Rjg4L1pMUlNVNTBxWGVaU3NaL0huMEUrMXNyRStGN3V2cThLcmFjVFZ5M3o1?=
 =?utf-8?B?Qk9sTmdVeE5mMmVTMzI1V2laVjl6bWtGS0U5dytUMmhGenlqbElIVU1UVUZE?=
 =?utf-8?B?dUpQN0szYms1QVNrMERXZ1FBN2NxckxLbXVaQUlmRFFXaU5TM0hpc2hZQ2NE?=
 =?utf-8?B?NERRbVFnTVFjNUpKK1FqeXd0V2p4QTgrZXJYKzdOQ1dnM2dtcm1PeWE4TXU5?=
 =?utf-8?B?WkNXZnpzL081b25aNDhwZFZrbmhpZU1tSGgydTRCYnl5WmEyazNhVVRMb1Jt?=
 =?utf-8?B?RkNoY3V3czI2cDN3bTBybk5NK203QXhrd0RJM2lRcU9rWjMzbkdJMUpOTkNT?=
 =?utf-8?B?ZWFVeW1pZS9sVUk5c04zZi8weTBXS0tDczNZMG1kTkd6UnNCVGt0UXFxQXhO?=
 =?utf-8?B?VDdyYjIzb20xeEVnZGFwSXMycVNWQzVsd2plcDJ2ZmRId1BSN1lEd3VnSElt?=
 =?utf-8?B?NXpQVitPVTQ2clFPL1I5eXFFYXgrL005T21Uc1kxN080d2tPelU1OFRacm5F?=
 =?utf-8?B?M0x4RnNvaVpnaVlpay9PMzlscGxIMDRSU3J5VnlSWDNvRENWMnFIZFNNb2NK?=
 =?utf-8?B?dkxNNmh6Yk94NU5DUjg5cmdFVFRpWURFM0xhQUJzUW5xVHBQMFB3TEF3Wmxq?=
 =?utf-8?B?d0JlUEpJdzJlTDlaeURTL1o5YmlCd28xS2pnTm5HalIweHprdVd1VEpPMnha?=
 =?utf-8?B?NUl2YjdjYzR0UC9yRTExcjdKaFc4YVhnNi8yWnVaUGFLeEVuWVZ5KzIzelV1?=
 =?utf-8?B?L1JUUWlEVnhrODZWQ05lS3BLNUQvNFN6anhKVWNLRlZNbkpqMDlleWdZUzlR?=
 =?utf-8?B?NnlNMmIvVXNjaVFBMVJyWWpzREtrRVhOMjVVSmJzVmE4RVRaSmxYbjFxRnJi?=
 =?utf-8?B?VjkxMmtBRTBENVIxMGdxMGZmblA1eERaT0NmUVdtWVhzaEY5akcyT3ZIYVp2?=
 =?utf-8?B?bExTSUpjVGNTc3VJV1YyN0h1UnNTUlVsTmtPVS9ZQXVEOURwS1RRYlk5T1hX?=
 =?utf-8?B?OGtvSnJGWHNRb056aEZyWFdCR0tGVFQ1Si9pa0xRcklIVnNFYUZ5NFU4VEoy?=
 =?utf-8?B?ZWFDUFNqaHdMM3M1dnNBZDM5b004WjN3TTRYL0lJRXB0OVVZQXRpNWZVdEVy?=
 =?utf-8?B?enBPREpxOG5EeWpsaTY5YmZkNFJZMnNVS0c2NUQrVHd3dWdGeStwcWFkOVp3?=
 =?utf-8?B?YWxyVk9FNFp4dGU3L0VjWkpnY0pKMU54dzBGUTZzZFpoN3FsUUxZeVBsWFZG?=
 =?utf-8?Q?fF5aUlwW7TR877jSiXz8aLs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <155DB88BDF457E42995D209A19CB1E2F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47df6fca-9942-440a-bc97-08d9af984170
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 22:17:51.6337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCbRqEyAEtko+C8gDFiUrlKePU0JUf3521dmZe5f4ztt9EPD0vI76wmiSRW2w5mgpOhyzMVXSlS2TW1CFKBpCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3685
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTExLTI0IGF0IDE3OjA2IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gV2VkLCBOb3YgMjQsIDIwMjEgYXQgMDU6MTQ6NTNQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IEl0IGlzIGEgbGl0dGxlIG5hc3R5IHRoYXQgd2UgaGlkZSB0
aGUgbGlzdF9kZWwoKSBjYWxscyBpbiBzZXZlcmFsDQo+ID4gbGV2ZWxzIG9mIGZ1bmN0aW9uIGNh
bGwsIHNvIHRoZXkgcHJvYmFibHkgZG8gZGVzZXJ2ZSBhIGNvbW1lbnQuDQo+ID4gDQo+ID4gVGhh
dCBzYWlkLCBpZiwgYXMgaW4gdGhlIGNhc2UgaGVyZSwgdGhlIGRlbGVnYXRpb24gd2FzIHVuaGFz
aGVkLCB3ZQ0KPiA+IHN0aWxsIGVuZCB1cCBub3QgY2FsbGluZyBsaXN0X2RlbF9pbml0KCkgaW4N
Cj4gPiB1bmhhc2hfZGVsZWdhdGlvbl9sb2NrZWQoKSwNCj4gPiBhbmQgc2luY2UgdGhlIGxpc3Rf
YWRkKCkgaXMgbm90IGNvbmRpdGlvbmFsIG9uIGl0IGJlaW5nIHN1Y2Nlc3NmdWwsDQo+ID4gdGhl
DQo+ID4gZ2xvYmFsIGxpc3QgaXMgYWdhaW4gY29ycnVwdGVkLg0KPiA+IA0KPiA+IFllcywgaXQg
aXMgYW4gdW5saWtlbHkgcmFjZSwgYnV0IGl0IGlzIHBvc3NpYmxlIGRlc3BpdGUgeW91cg0KPiA+
IGNoYW5nZS4NCj4gDQo+IFRoYW5rcywgZ29vZCBwb2ludC4NCj4gDQo+IFByb2JhYmx5IG5vdCBz
b21ldGhpbmcgYW55b25lJ3MgYWN0dWFsbHkgaGl0dGluZywgYnV0IGFub3RoZXIgc2lnbg0KPiB0
aGlzDQo+IGxvZ2ljIG5lZWQgcmV0aGlua2luZy4NCj4gDQoNCkkgdGhpbmsgaXQgc2hvdWxkIGJl
IHN1ZmZpY2llbnQgdG8gbGV0IHRoZSBsYXVuZHJvbWF0IHNraXAgdGhhdCBlbnRyeQ0KYW5kIGxl
YXZlIGl0IG9uIHRoZSBsaXN0IGlmIHRoZSB1bmhhc2hfZGVsZWdhdGlvbl9sb2NrZWQoKSBmYWls
cywgc2luY2UNCnlvdXIgZml4IHNob3VsZCB0aGVuIGJlIGFibGUgdG8gcGljayB0aGUgZGVsZWdh
dGlvbiB1cCBhbmQgZGVzdHJveSBpdA0Kc2FmZWx5Lg0KDQpXZSBjYW4ga2VlcCB0aGUgY29kZSBp
biBfX2Rlc3Ryb3lfY2xpZW50KCkgYW5kDQpuZnM0X3N0YXRlX3NodXRkb3duX25ldCgpIHVuY2hh
bmdlZCwgc2luY2UgdGhvc2UgYXJlIHByZXN1bWFibHkgbm90DQphZmZlY3RlZCBieSB0aGlzIHJh
Y2UuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
