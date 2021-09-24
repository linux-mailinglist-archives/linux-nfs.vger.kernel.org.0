Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B9417D86
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Sep 2021 00:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbhIXWLX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 18:11:23 -0400
Received: from mail-bn8nam08on2099.outbound.protection.outlook.com ([40.107.100.99]:7904
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345010AbhIXWLW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 24 Sep 2021 18:11:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdUyexaR3SmCZZOVw1Z/AQqFS/GI8Pm3rvA0xizCRFNhdSDOC/vfZqLC+W1GAjprj1nC1G5HIIkshcv5a2/3nneuI9wGGfADLig9wRjOmpUOa0Q6mDjfPVDhyeK2lFrL0PfStDa085XRyET/XCu0X8/GuiFhftt9WdfZzcG/Vq4lF0Q55xKzW7vQAezizwQRi5aP7tlZ5Q/VqpK5a6agbxoliT1X5nRa6bZ/QWlo4jWlvgRG6BglpvUVTu360ZGKMY4zx1zpv1YrsUJRNR7SHkBvb0LreQ5SgbyvYFpuauBJBWRrJCCmbBvtA7zqsToGwSnvsU58fROK/Ezji/sL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siYkL0qFHFeLcD2bk7pLbofnTj2ryUU9yqgYcsnME60=;
 b=JIybXCKGEHe2P9QGfeGubiGxebBbuF5hugnucFEo/2sytTyX9Ou7XfXWB84F8IMQjHkuQYhf0M2gF/+DiN49nfBW3tqSMNG6fVn1/5t9GJOD4KIQjN9oHU9ybuJWMNKJkzg7KINVzStG29++Az7zcw4Z2isE0RioUJs8UidHTWElHjQ9zliruHuz+J1Hi9rdrRa7IJTl399QFm5T5+vB4ym2Trr5t7rVOFLd+MuIZ22e0iqenArErUF2br5iuvZEVG/JpLMBEwCM6gHzh4QUqeAXYTSVIcNMdMH8xoa7sc84vZVGARjAo3dxcqRJgSZT26C0CBiYxn3hjYO0s/xhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siYkL0qFHFeLcD2bk7pLbofnTj2ryUU9yqgYcsnME60=;
 b=BK6C3/kiypXObaDgfTmYMuHtk07HzrJcIcFdFNQAHdq0a5JdhX38GmGA/1+16BCPOY85yd1K1WNOR4ecVRFzWjgN+reMSDYyJ3f3oLmngLbYPUwXt3ME+NNHDIGurGJTnTn7yoC43sr7W/mpE1byD9vi4i4r/YGtzq9AXR1AJTA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3432.namprd13.prod.outlook.com (2603:10b6:610:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.11; Fri, 24 Sep
 2021 22:09:44 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4544.013; Fri, 24 Sep 2021
 22:09:44 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fcA3+DfY3OUmOk0QnMZuIQ6tRAXuAgFtTrwCAAuCsgIAEfGqAgABvgQA=
Date:   Fri, 24 Sep 2021 22:09:44 +0000
Message-ID: <aa2ef2bbb991d693009fb5cf130462a366f5d459.camel@hammerspace.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
         <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
         <680A4FB2-B90D-47E1-A390-36B3081B1464@oracle.com>
         <da6ef7efef96f126f89a70446eaf643ab0bcbe26.camel@hammerspace.com>
         <EA26A03F-962E-4561-9A70-C97D19574993@oracle.com>
In-Reply-To: <EA26A03F-962E-4561-9A70-C97D19574993@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16c17625-6998-4ea6-55e5-08d97fa803a5
x-ms-traffictypediagnostic: CH2PR13MB3432:
x-microsoft-antispam-prvs: <CH2PR13MB3432D938CD4CFA05828CB2CDB8A49@CH2PR13MB3432.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0394Zb4RMmXYprXN8bODtlNPzXcQSTNEtUpzlswl5rsetO1aDeMhATHbzMCcaAAWTC0wPgaEiq/uYabiYAoS+SwJ26Nw6nSUjwNZlhrFtltbokjFBeB1lXJ20vNxyrRYavyctGQTbm+zVpOkgkvTeo0nqJK7LdQTDgy+pc6zAvUkai0lhQsjoaH+fnwWU5o5eDnDt3hdM2Ns5OQmLtUThbRvz42ujbTwLGlmgLvo80qKBVyQDI6e5nornajse7i7n6B3xH2fSxHLCfsXy19+847/ubuXHcN1QZvViteFKiYQ4QJuVj6JFSeMLz2Giy/QLsUZGZgEaHH6VaXu2MD3YdadQaVvokCZU4f10U1A3vkQXPkONHj292gwjBDWtHXeiwpyDU5+LeAflKurjNUhAGTA4skQoszI6TW7qg+AWlP2eejVX9mkMLvqgzgkI1Nrdyui3oDJLZzhGpzXL+dCZuQwrHfV3LukEUmwZeyLt6ZmS1DJcCrkPpBqce5cjRvwRoVG1doceNE4h1KSCPh8yDI9sr1vliEkg9GYYkJ5ybZ0uBoNjKDaMLNKO3DFos6Czl6rC5PZu+2MIdAb6YKjFw/NJVKmE4rgCEBT2Cu3ndWhd5pASf/hkKx6gsMDrNEfhc19a3t0qWeIr/xliVnvxolD+pIlfQLJi9FnvgjZzOGiFQRpl/KpDSqpBWeQxOPCMcZM9tWpaJd45RJGSRzKIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(39840400004)(396003)(5660300002)(83380400001)(316002)(36756003)(6486002)(8676002)(38070700005)(86362001)(76116006)(26005)(6916009)(6506007)(186003)(8936002)(2616005)(6512007)(66946007)(508600001)(4326008)(64756008)(66556008)(2906002)(38100700002)(53546011)(122000001)(66446008)(66476007)(71200400001)(3480700007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUhGdnl1SkNOalMrOTJKNGtXUUxIZjVKajVTc3U3dHFOS2tIR2ViREF0dGhk?=
 =?utf-8?B?a2cvbFJYeStLNVRPUFFPYjNTbGxpVEVSUUd6ajJhamRuY1JuU2s3VHFrcE5O?=
 =?utf-8?B?cFg3OXdVQ2NDUXBBVU8zdUwzdjMrKzBsczdHanNiSkhJcWlHMERRUFdVUVZD?=
 =?utf-8?B?b254M25zUmdXMWpDcm95VnQ1Z25kVC8rTzJHbklkWVdaSTR2MDVmdUtMY3l5?=
 =?utf-8?B?Zk9qbEVMUlI4dHkvT1ZhR2owRGpiZFpGNHNvOGc5QUhjZTl0KzBBNDZhWjky?=
 =?utf-8?B?dnRNdHNkeWMxNVdlKzU0VEQyYXZSZ1Yrc0ZORVc1OVpkVFd0MW9yeTFhUWth?=
 =?utf-8?B?R0gwY1IySzNVYVFzVVlzcS9vTGtXU24rZ1k2UjZDVlFlQTJJL1EyeTQ3c053?=
 =?utf-8?B?dHBWS2NiZDlnL2tRWjRKTUp6ZFQ5dmpMMklmZnNnUHFWOXFRdzJlQ3Q0L3dw?=
 =?utf-8?B?TUNIZG1xd0U5SXRNR1JjakZHYW41Q1pCVXdpS3I5ZE1mM1QrbEQ4UExKK0h5?=
 =?utf-8?B?YnZOOWJFRktpR0JRT1VUYjZXOTVraHlUOEhPT1E1ZDZvckFFeVdCdmFvY1B6?=
 =?utf-8?B?QkVQTTFtbUU5R2RtaCt1Qlk0RTBPeUJyb1p1QjFyNjhlbzVRRWlmSG5xYXVR?=
 =?utf-8?B?ajRXRDA2R2hCSVQ4Y0M2NDN0T2xNVDhkK21OMk0xaWFpNkZnZjJBWlhWZnZh?=
 =?utf-8?B?ZEFrZGUwdm5xWC9pYk16QWhVZ09DOUMzVHZ6MU5LbGM5YUh4ZnFad2ppdUZn?=
 =?utf-8?B?VG03dDFxd204TmVuQk9NNmd1SnhQeVZlQ1ViRWVrVVdaT3dMdWZXSmxjZ1ZR?=
 =?utf-8?B?TExEdk9EZTZpc0VueDBuN2ZJVWxQakpQeW4ycTVoRitLTzBFM3YzbEg5Z2FC?=
 =?utf-8?B?WFNsbksreDJWZFFKcFFSaWJGeGREN09yeWp1ZXBTV1JBK3VaejBsVXp4Mm1B?=
 =?utf-8?B?emk4Mm5Jdk1lQVJQSkdzOHhGMUdrK2FTNW1KU1BDTys5TWFERFVPV2lKd3Uv?=
 =?utf-8?B?Qk5oemRYUlhma29Odm5QTXU3TzA0dFVCK20rTHNiRFlVYmhUaTkvc1NhaXhV?=
 =?utf-8?B?V0tDdmxoUWRMWU9lcldEalJXR09ub3RxcUJmb1NpVko3MGdRMVB5NXRXb1Jr?=
 =?utf-8?B?Yi9oTzFJQVZneHBPaGp4UHpTRCtjRmkyY1kxaGlkQ0FZMnh2TzFCcWYvZnNJ?=
 =?utf-8?B?TGFKcUZjd0JmckNLQUp4MWRNSGhFRUVsL0ExMVFSRFFqVy9jMmQrd3VuNzJQ?=
 =?utf-8?B?Y0tZV211UnFHNFcyOVVEMjdhZ0ltNis4bGFsVW5SNFpmTzdSL0praXViNGl6?=
 =?utf-8?B?ZDRJNEdhUUVnWWtEclhMZFhYWUMyZDZ4eW93bHB4Q0pWMVROMHAxTjk5ZG5M?=
 =?utf-8?B?amFvejBaQlBDeTBRbUM3aC8yVktKeUFIT0c4aDdGYzZPRi9oQ3FUdFpxay9N?=
 =?utf-8?B?YTFJTFl4WHFpUkZpTjJDRS9Yb0J3WGFTa2gyTkY0bGhzZmxHQWhmb3JyUXdZ?=
 =?utf-8?B?UE9KUUlJNHUwenNqdGdHV3Z5WWZEQVRwdTJ3cGtrZURUd0FqdzJRRXBXS0Jx?=
 =?utf-8?B?Mnovb1pxZC9HN0ErdkNzOCt4K0QxZXRmd09PUlpMMmt4SEdIcjY2alVtWGpm?=
 =?utf-8?B?QVBlMG9rY0hEZC9YYm43b0dBaEJ3QmNOM0JUdnBKZmxNMjF3UHpocm9oOWZN?=
 =?utf-8?B?Q1dkQnUvOEF4Zno5OS9oekFZc3pFaUJXdmNKRU1vU1ZsUkUwR2V4K2pZbkd6?=
 =?utf-8?Q?Tru1893ioN0+mVZdgy3SzlJczW8zH+JZTdi/Dqc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6D8EDF3919A11469D1A8D8939786E92@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c17625-6998-4ea6-55e5-08d97fa803a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 22:09:44.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDQ/1IRO0OhbKK+MJDswtRaQRpRNvIUwZB5YJJ4DGdtQ9MMP7zzUiqJQ6K71NFWMOOGHWwpWx2viRzmOBHlmuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3432
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA5LTI0IGF0IDE1OjMwICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBTZXAgMjEsIDIwMjEsIGF0IDM6MDAgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gU3Vu
LCAyMDIxLTA5LTE5IGF0IDIzOjAzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gPiBPbiBKdWwgMjMsIDIwMjEsIGF0IDQ6MjQgUE0sIFRyb25kIE15
a2xlYnVzdA0KPiA+ID4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4g
PiANCj4gPiA+ID4gT24gRnJpLCAyMDIxLTA3LTIzIGF0IDIwOjEyICswMDAwLCBDaHVjayBMZXZl
ciBJSUkgd3JvdGU6DQo+ID4gPiA+ID4gSGktDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSBub3Rp
Y2VkIHJlY2VudGx5IHRoYXQgZ2VuZXJpYy8wNzUsIGdlbmVyaWMvMTEyLCBhbmQNCj4gPiA+ID4g
PiBnZW5lcmljLzEyNw0KPiA+ID4gPiA+IHdlcmUNCj4gPiA+ID4gPiBmYWlsaW5nIGludGVybWl0
dGVudGx5IG9uIE5GU3YzIG1vdW50cy4gQWxsIHRocmVlIG9mIHRoZXNlDQo+ID4gPiA+ID4gdGVz
dHMNCj4gPiA+ID4gPiBhcmUNCj4gPiA+ID4gPiBiYXNlZCBvbiBmc3guDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gImdpdCBiaXNlY3QiIGxhbmRlZCBvbiB0aGlzIGNvbW1pdDoNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA3YjI0ZGFjZjA4NDAgKCJORlM6IEFub3RoZXIgaW5vZGUgcmV2YWxpZGF0aW9u
IGltcHJvdmVtZW50IikNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZnRlciByZXZlcnRpbmcgN2Iy
NGRhY2YwODQwIG9uIHY1LjE0LXJjMSwgSSBjYW4gbm8gbG9uZ2VyDQo+ID4gPiA+ID4gcmVwcm9k
dWNlDQo+ID4gPiA+ID4gdGhlIHRlc3QgZmFpbHVyZXMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiBTbyB5b3UgYXJlIHNlZWluZyBmaWxlIG1ldGFkYXRhIHVwZGF0
ZXMgdGhhdCBlbmQgdXAgbm90DQo+ID4gPiA+IGNoYW5naW5nDQo+ID4gPiA+IHRoZQ0KPiA+ID4g
PiBjdGltZT8NCj4gPiA+IA0KPiA+ID4gQXMgZmFyIGFzIEkgY2FuIHRlbGwsIGEgV1JJVEUgYW5k
IHR3byBTRVRBVFRScyBhcmUgaGFwcGVuaW5nIGluDQo+ID4gPiBzZXF1ZW5jZSB0byB0aGUgc2Ft
ZSBmaWxlIGR1cmluZyB0aGUgc2FtZSBqaWZmeS4gVGhlIFdSSVRFIGRvZXMNCj4gPiA+IG5vdCBy
ZXBvcnQgcHJlL3Bvc3QgYXR0cmlidXRlcywgYnV0IHRoZSBTRVRBVFRScyBkby4gVGhlIHJlcG9y
dGVkDQo+ID4gPiBwcmUtIGFuZCBwb3N0LSBtdGltZSBhbmQgY3RpbWUgYXJlIGFsbCB0aGUgc2Ft
ZSB2YWx1ZSBmb3IgYm90aA0KPiA+ID4gU0VUQVRUUnMsIEkgYmVsaWV2ZSBkdWUgdG8gdGltZXN0
YW1wX3RydW5jYXRlKCkuDQo+ID4gPiANCj4gPiA+IE15IHRoZW9yeSBpcyB0aGF0IHBlcnNpc3Rl
bnQtc3RvcmFnZS1iYWNrZWQgZmlsZXN5c3RlbXMgc2VlbSB0bw0KPiA+ID4gZ28gc2xvdyBlbm91
Z2ggdGhhdCBpdCBkb2Vzbid0IGJlY29tZSBhIHNpZ25pZmljYW50IHByb2JsZW0uIEJ1dA0KPiA+
ID4gd2l0aCB0bXBmcywgdGhpcyBjYW4gaGFwcGVuIG9mdGVuIGVub3VnaCB0aGF0IHRoZSBjbGll
bnQgZ2V0cw0KPiA+ID4gY29uZnVzZWQuIEFuZCBJIGNhbiBtYWtlIHRoZSBwcm9ibGVtIHVucmVw
cm9kdWNhYmxlIGlmIEkgZW5hYmxlDQo+ID4gPiBlbm91Z2ggZGVidWdnaW5nIHBhcmFwaGVybmFs
aWEgb24gdGhlIHNlcnZlciB0byBzbG93IGl0IGRvd24uDQo+ID4gPiANCj4gPiA+IEknbSBub3Qg
ZXhhY3RseSBzdXJlIGhvdyB0aGUgY2xpZW50IGJlY29tZXMgY29uZnVzZWQgYnkgdGhpcw0KPiA+
ID4gYmVoYXZpb3IsIGJ1dCBmc3ggcmVwb3J0cyBhIHN0YWxlIHNpemUgdmFsdWUsIG9yIGl0IGNh
biBoaXQgYQ0KPiA+ID4gYnVzIGVycm9yLiBJJ20gc2VlaW5nIGF0IGxlYXN0IGZvdXIgb2YgdGhl
IGZzeC1iYXNlZCB4ZnMgdGVzdHMNCj4gPiA+IGZhaWwgaW50ZXJtaXR0ZW50bHkuDQo+ID4gPiAN
Cj4gPiANCj4gPiBUaGUgY2xpZW50IG5vIGxvbmdlciByZWxpZXMgb24gcG9zdC1vcCBhdHRyaWJ1
dGVzIGluIG9yZGVyIHRvDQo+ID4gdXBkYXRlDQo+ID4gdGhlIG1ldGFkYXRhIGFmdGVyIGEgc3Vj
Y2Vzc2Z1bCBTRVRBVFRSLiBJZiB5b3UgbG9vayBhdA0KPiA+IG5mc19zZXRhdHRyX3VwZGF0ZV9p
bm9kZSgpIHlvdSdsbCBzZWUgdGhhdCBpdCBwaWNrcyB0aGUgdmFsdWVzIHRoYXQNCj4gPiB3ZXJl
IHNldCBkaXJlY3RseSBmcm9tIHRoZSBpYXR0ciBhcmd1bWVudC4NCj4gPiANCj4gPiBUaGUgcG9z
dC1vcCBhdHRyaWJ1dGVzIGFyZSBvbmx5IHVzZWQgdG8gZGV0ZXJtaW5lIHRoZSBpbXBsaWNpdA0K
PiA+IHRpbWVzdGFtcCB1cGRhdGVzLCBhbmQgdG8gZGV0ZWN0IGFueSBvdGhlciB1cGRhdGVzIHRo
YXQgbWF5IGhhdmUNCj4gPiBoYXBwZW5lZC4NCj4gDQo+IEkndmUgYmVlbiBhYmxlIHRvIGRpcmVj
dGx5IGFuZCByZXBlYXRlZGx5IG9ic2VydmUgdGhlIHNpemUgYXR0cmlidXRlDQo+IHJldmVydGlu
ZyB0byBhIHByZXZpb3VzIHZhbHVlLg0KPiANCj4gVGhlIGlzc3VlIHN0ZW1zIGZyb20gdGhlIE1N
IGRyaXZpbmcgYSBiYWNrZ3JvdW5kIHJlYWRhaGVhZCBvcGVyYXRpb24NCj4gYXQgdGhlIHNhbWUg
dGltZSB0aGUgYXBwbGljYXRpb24gdHJ1bmNhdGVzIG9yIGV4dGVuZHMgdGhlIGZpbGUuIFRoZQ0K
PiBSRUFEIHN0YXJ0cyBiZWZvcmUgdGhlIHNpemUtbXV0YXRpbmcgb3BlcmF0aW9uIGFuZCBjb21w
bGV0ZXMgYWZ0ZXINCj4gaXQuDQo+IA0KPiBJZiB0aGUgc2VydmVyIGhhcHBlbnMgdG8gaGF2ZSBk
b25lIHRoZSBSRUFEIGJlZm9yZSB0aGUgc2l6ZS1tdXRhdGluZw0KPiBvcGVyYXRpb24sIHRoZSBS
RUFEIHJlc3VsdCBjb250YWlucyB0aGUgcHJldmlvdXMgc2l6ZSB2YWx1ZS4gV2hlbg0KPiB0aGUg
UkVBRCBjb21wbGV0ZXMsIHRoZSBjbGllbnQgb3ZlcndyaXRlcyB0aGUgbW9yZSByZWNlbnQgc2l6
ZQ0KPiB2YWx1ZSB3aXRoIHRoZSBzdGFsZSBvbmUuDQo+IA0KPiBJJ20gbm90IHlldCBzdXJlIGhv
dyB0aGlzIHJlbGF0ZXMgdG8NCj4gDQo+IDdiMjRkYWNmMDg0MCAoIk5GUzogQW5vdGhlciBpbm9k
ZSByZXZhbGlkYXRpb24gaW1wcm92ZW1lbnQiKQ0KPiANCj4gYW5kIG1heWJlIGl0IGRvZXNuJ3Qu
ICJnaXQgYmlzZWN0IiB3aXRoIGFuIHVucmVsaWFibGUgcmVwcm9kdWNlcg0KPiBnZW5lcmF0ZXMg
bm90b3Jpb3VzbHkgbm9pc3kgZGF0YS4gDQo+IA0KDQpIbW0uLi4gVGhhdCBtYWtlcyBzZW5zZS4g
SWYgc28sIHRoZSBpc3N1ZSBpcyB0aGUgYXR0cmlidXRlcyBmcm9tIHRoZQ0KUkVBRCBlbmQgdXAg
dHJpY2tpbmcgbmZzX2lub2RlX2ZpbmlzaF9wYXJ0aWFsX2F0dHJfdXBkYXRlKCkgaW50byBPS2lu
Zw0KdGhlIHVwZGF0ZSBiZWNhdXNlIHRoZSBjdGltZSBlbmRzIHVwIGxvb2tpbmcgdGhlIHNhbWUs
IGFuZCBzbyB0aGUNCmNsaWVudCB0cmllcyB0byBvcHBvcnR1bmlzdGljYWxseSByZXZhbGlkYXRl
IHRoZSBjYWNoZSB0aGF0IHdhcyAoZm9yDQpzb21lIHJlYXNvbikgYWxyZWFkeSBtYXJrZWQgYXMg
YmVpbmcgaW52YWxpZC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
