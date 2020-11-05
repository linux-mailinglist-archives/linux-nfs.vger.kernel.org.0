Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058C52A86FC
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 20:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKETX1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 14:23:27 -0500
Received: from mail-bn7nam10on2124.outbound.protection.outlook.com ([40.107.92.124]:9568
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbgKETX0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 5 Nov 2020 14:23:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1w24n67CUIJiZbUnxYFgYUqzbZFxrDy9ac3Vj2s0nUmitHS2ZB7u8KXXoy9JvS5cKzWQgK3lMYKBq7fBgq585YLJW3zMP5lwzc37WeCUiHWvqatJSXM3RS06OPBRa3W8yG8EMF9WhZZH4ppOSnK33uiQp9lQFY/ViyS1lYKUAPtB3BezWVywdL21lbSlFCwOPf/IqIc4/QD6K6gUYwA3d8tvhlu4Vr2SNgkugOYzMIhMyjXEFMM3ONKCfnO9OM7hNW4qxsl9oHHXWJ2jdboImnDzVid8TP3qogcAhYbwF2k8ZYC9mYgswgB6q96gXIOqbPFFIBYT+/1KgV0OA50dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pU1y6H/NLmQ1pDGdWZRnT8BYU1MTNvsD7mCtWD2uWY=;
 b=T10ambHubaLsWw2OasjgrYeWmCiScsTqNARl04N7YWzX9YFi5J1tkpovjxmlwkhevGAHmqz+jkA81eN2oUfRClI+HgnCxjSx87REDEou3ZL9nNGdpG3Vw9/JU4ktqXGKgokvpwckKk07oG7h8zV4ewyhgf5Bhy0SWXcZRJw59Lf+T9C/0Wmj13ZPu9FrNI+a8kw42mEOHXjauMp4mm2avEsw7o05+HtFqxAcn5nZIkuPxZonDxDoQvce+S5nhwcec9zClOokaBO1dQ00xj+jF3QUn72uzWmWcf40GSqnFyvemiSHuij/FKJ0qv7UfCO6kf1Ih1ErGCGQBqCuw//4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pU1y6H/NLmQ1pDGdWZRnT8BYU1MTNvsD7mCtWD2uWY=;
 b=dHPkUjw3huweOzRtFDJDeoFhMpvPyNxZ9Yvlq2x5OQSBlge/9NYDLqZHNVfuCUAeg/Lp6VPpu4dsUBvP4GKnHIvdYjHU2j1iLXZRV9FPTmExYgtYLmTEUjTUOXEC5uhhSrSgOzkevdeAnBf/mPdg8cH79FnZ1gF+IZ60gJJ814o=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3773.namprd13.prod.outlook.com (2603:10b6:208:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13; Thu, 5 Nov
 2020 19:23:23 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Thu, 5 Nov 2020
 19:23:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH/RFC] Does nfsiod need WQ_CPU_INTENSIVE?
Thread-Topic: [PATCH/RFC] Does nfsiod need WQ_CPU_INTENSIVE?
Thread-Index: AQHWswhvhyJSBmabJkyvO3MOSPUiVqm57C2A
Date:   Thu, 5 Nov 2020 19:23:22 +0000
Message-ID: <37ec02047951a5d61cf9f9f5b4dc7151cd877772.camel@hammerspace.com>
References: <87sg9or794.fsf@notabene.neil.brown.name>
In-Reply-To: <87sg9or794.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c372cf91-7949-4314-d914-08d881c04315
x-ms-traffictypediagnostic: MN2PR13MB3773:
x-microsoft-antispam-prvs: <MN2PR13MB37738DC8B4800BA854D8026FB8EE0@MN2PR13MB3773.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQ5BS/PSJMjiAhqcyat4u0N/bw9fA9f4g4Rm3vLa6hA7vFuzeXvZVwzUxjHMuynKUcE2E1CBPbD97QVhHmXgaXPkUu0PS7KE3ijE4YZfMyn/ocI7YxqjIDQDemfTxLeEYY+Dk+575/ybYNM9wLwJ0ZuqT1b5kK7R8Tf86IisSWyqF9/Lz5h88Q+9F4HkCheHoX6+xRehc+QGJa026f6ZplELPhE3pfwflERvSkvPxxQdensQlx3GtFQoMY9mjs4oQZ8WRd/1GrZe0PlBSr6NQrITmvNjzTbpBXVe+8TkRcwi97PtVU4wMSD4ugLY/W5PCfMO6JORHjCMheYkb27Gzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(136003)(396003)(366004)(376002)(76116006)(2906002)(110136005)(86362001)(36756003)(71200400001)(6512007)(316002)(91956017)(66476007)(66556008)(66946007)(64756008)(66446008)(8936002)(5660300002)(8676002)(83380400001)(478600001)(26005)(6506007)(186003)(6486002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CJZp9IcGSXITZ42JlYJbEPv/16DwplJVOvUOQ40WTUGq99Nn3FatO/Y6kkF8H11JcyQHI79SUztz0dpg/HHwo6ljC7IwN2jEHXURhOphht1Mw4riWd4EROWQ0jQ1PZYhn4hBEA+FHYT5iCOSvoyK+t0U/eIZOiDR6SZuXgjN9dSoRZqlkw1VYjLYlV5UhgLB2QsYUFB2jPkqkmF1nW3/KVXB2xUMGtEgDynvYi3ZWO53vaV3D0XNH1/2uVvp7tzhbyceyVC132/RQzBW6W560EV83f3dbyKZ0GCMQUsHrLqPJUFveKsxzmcdnPtJCxzORJEqFAfLHlKrWV4xZyMREYBHSAoEd7mt6l589q1fWYKsX4/3SxY6U36tYm7y3tcMTm4ToJZ+reCF0u8rYh/sbh1kx+22vtHiBrUbd27CEvJHYTPTZ8m8086Py2Hw4ppR588qvpi4QAMEfJhbyoxJPO/y2JuRw0SwewdDt7J3fSPnSRYNu3v7z+o7OW22/WFAoN19ayFJuNfGiXll0VlqkfjPGI9CYIDxIUNMZHzIT01OpWvWp6LIHMr7XOxZpvTrRbzSzjOnQfsxRBLcAUag+SU8jh5B/MMDTXRYAYIcdA04mEbRj3XjL4uBigOESh+1HYn15KtrSQOK/PS4qQE82g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F08187C73B8FF54C872A044CB0437BBB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c372cf91-7949-4314-d914-08d881c04315
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 19:23:22.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrUP3DjX68voV9mXeUnBU2Y2LfyFuWdCv/XkkEIEZldQoSeXo/pB4f8XzDTJoF3/jYoQDsCcXQYzNENZJtGxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3773
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTA1IGF0IDExOjEyICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBIaSwNCj4gwqBJIGhhdmUgYSBjdXN0b21lciByZXBvcnQgb2YgTkZTIGdldHRpbmcgc3R1Y2sg
ZHVlIHRvIGEgd29ya3F1ZXVlDQo+IMKgbG9ja3VwLg0KPiANCj4gwqBUaGlzIGFwcGVhcnMgdG8g
YmUgdHJpZ2dlcmVkIGJ5IGNhbGxpbmcgJ2Nsb3NlJyBvbiBhIDVUQiBmaWxlLg0KPiDCoFRoZSBy
cGNfcmVsZWFzZSBzZXQgdXAgYnkgbmZzNF9kb19jbG9zZSgpIGNhbGxzIGEgZmluYWwgaXB1dCgp
DQo+IMKgb24gdGhlIGlub2RlIHdoaWNoIGxlYWRzIHRvIG5mczRfZXZpY3RfaW5vZGUoKSB3aGlj
aCBjYWxscw0KPiDCoHRydW5jYXRlX2lub2RlX3BhZ2VzX2ZpbmFsKCkuwqAgT24gYSA1VEIgZmls
ZSwgdGhpcyBjYW4gdGFrZSBhIGxpdHRsZQ0KPiDCoHdoaWxlLg0KPiANCj4gwqBEb2N1bWVudGF0
aW9uIGZvciB3b3JrcXVldWUgc2F5cw0KPiDCoMKgIEdlbmVyYWxseSwgd29yayBpdGVtcyBhcmUg
bm90IGV4cGVjdGVkIHRvIGhvZyBhIENQVSBhbmQgY29uc3VtZQ0KPiBtYW55DQo+IMKgwqAgY3lj
bGVzLg0KPiANCj4gwqBzbyBtYXliZSB0aGF0IGlzbid0IGEgZ29vZCBpZGVhLg0KPiDCoHRydW5j
YXRlX2lub2RlX3BhZ2VzX2ZpbmFsKCkgZG9lcyBjYWxsIGNvbmRfcmVzY2hlZCgpLCBidXQgd29y
a3F1ZXVlDQo+IMKgZG9lc24ndCB0YWtlIG5vdGljZSBvZiB0aGF0LsKgIEJ5IGRlZmF1bHQgaXQg
b25seSBydW5zIG1vcmUgdGhyZWFkcw0KPiBvbg0KPiDCoHRoZSBzYW1lIENQVSBpZiB0aGUgZmly
c3QgdGhyZWFkIGFjdHVhbGx5IHNsZWVwcy7CoCBTbyB0aGUgbmV0IHJlc3VsdA0KPiBpcw0KPiDC
oHRoYXQgdGhlcmUgYXJlIGxvdHMgb2YgcnBjX2FzeW5jX3NjaGVkdWxlIHRhc2tzIHF1ZXVlZCB1
cCBiZWhpbmQgdGhlDQo+IMKgaXB1dCwgd2FpdGluZyBmb3IgaXQgdG8gZmluaXNoIHJhdGhlciB0
aGFuIHJ1bm5pbmcgY29uY3VycmVudGx5Lg0KPiANCj4gwqBJIGJlbGlldmUgdGhpcyBjYW4gYmUg
Zml4ZWQgYnkgc2V0dGluZyBXUV9DUFVfSU5URU5TSVZFIG9uIHRoZQ0KPiBuZnNpb2QNCj4gwqB3
b3JrcXVldWUuwqAgVGhpcyBmbGFnIGNhdXNlcyB0aGUgd29ya3F1ZXVlIGNvcmUgdG8gc2NoZWR1
bGUgbW9yZQ0KPiDCoHRocmVhZHMgYXMgbmVlZGVkIGV2ZW4gaWYgdGhlIGV4aXN0aW5nIHRocmVh
ZHMgbmV2ZXIgc2xlZXAuDQo+IMKgSSBkb24ndCBrbm93IGlmIHRoaXMgaXMgYSBnb29kIGlkZWEg
YXMgaXQgbWlnaHQgc3BhbnMgbG90cyBvZg0KPiB0aHJlYWRzDQo+IMKgbmVlZGxlc3NseSB3aGVu
IHJwY19yZWxlYXNlIGZ1bmN0aW9ucyBkb24ndCBoYXZlIGxvdHMgb2Ygd29yayB0byBkby4NCj4g
DQo+IMKgQW5vdGhlciBvcHRpb24gbWlnaHQgYmUgdG8gY3JlYXRlIGEgc2VwYXJhdGUNCj4gbmZz
aW9kX2ludGVuc2l2ZV93b3JrcXVldWUNCj4gwqB3aXRoIHRoaXMgZmxhZyBzZXQsIGFuZCBoYW5k
IGFsbCBpcHV0IHJlcXVlc3RzIG92ZXIgdG8gdGhpcw0KPiB3b3JrcXVldWUuDQo+IA0KPiDCoEkn
dmUgYXNrZWQgZm9yIHRoZSBjdXN0b21lciB0byB0ZXN0IHdpdGggdGhpcyBzaW1wbGUgcGF0Y2gu
DQo+IA0KPiDCoEFueSB0aG91Z2h0cyBvciBzdWdnZXN0aW9ucyBtb3N0IHdlbGNvbWUsDQo+IA0K
DQpJc24ndCB0aGlzIGEgZ2VuZXJhbCBwcm9ibGVtIChpLmUuIG9uZSB0aGF0IGlzIG5vdCBzcGVj
aWZpYyB0byBORlMpDQp3aGVuIHlvdSBoYXZlIG11bHRpLXRlcmFieXRlIGNhY2hlcz8gV2h5IHdv
dWxkbid0IGlvX3VyaW5nIGJlDQp2dWxuZXJhYmxlIHRvIHRoZSBzYW1lIGlzc3VlLCBmb3IgaW5z
dGFuY2U/DQoNClRoZSB0aGluZyBpcyB0aGF0IHRydW5jYXRlX2lub2RlX3BhZ2VzKCkgaGFzIHBs
ZW50eSBvZiBsYXRlbmN5IHJlZHVjaW5nDQpjb25kX3NjaGVkKCkgY2FsbHMgdGhhdCBzaG91bGQg
ZW5zdXJlIHRoYXQgb3RoZXIgdGhyZWFkcyBnZXQgc2NoZWR1bGVkLA0Kc28gdGhpcyBwcm9ibGVt
IGRvZXNuJ3Qgc3RyaWN0bHkgbWVldCB0aGUgJ0NQVSBpbnRlbnNpdmUnIGNyaXRlcmlvbg0KdGhh
dCBJIHVuZGVyc3RhbmQgV1FfQ1BVX0lOVEVOU0lWRSB0byBiZSBkZXNpZ25lZCBmb3IuDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
