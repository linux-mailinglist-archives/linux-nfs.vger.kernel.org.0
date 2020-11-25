Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B86B2C3612
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 02:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKYBHj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 20:07:39 -0500
Received: from mail-eopbgr770092.outbound.protection.outlook.com ([40.107.77.92]:26593
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgKYBHi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 20:07:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPMbWqzQooZq7hQVVXOMswKCdWzcRPUphSbjfH1glQ/539jqD6nLP01h+gjPdTMGxawuyxzrcupmE9N3+38AwuRGXRaA65ji6imHas8fr2m+hOjlkWJRKabWllLdoxsoIyq8BWCWoaMW+ecwlPw1qNgRHpEK9i4Xk79CjgDYMVxd7SNX9oiDg5NREBqmUUnwTj4zSuBHElnpo7yeWJW4EfgIwdy9N2gn3vwicxjODdFFFKVvfbVqCawbb19NjcHOqI/YVq9fMWu935PpsvWdhNzzwbJ8aD6HqWlvWMcl6blTYT8p5l/VjAHYVE5VGiw86XSIl9kqZ8IL5Zj+8RwkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyStEV3dDVM++2Gepr+NK7zjadQe98obDiA/Yl2rWAU=;
 b=h4OBhoTxyUVlMP3shG4IJiiUknIRw6srv6c+EQqsYAgXO4ES1WW7xp/rdXr/f0sK74I6ACQZjnHPLO1IPx3uN4NhInMqCM7bH5epXEw7C3XKT/QfR7QoE2BwUHV3nG5cuEelVddTHRiK99OxmXIqAhd/GJ8X4sSqN4XCaOM7fX3tloHbfeKqR6/scyDTfjPGbCH4JKd6UtuIP/OTCFKZFTpM4h8CwPZHtBUGf46GAFH9cUFl7edpTKTnIn/N83sT43FNKnG1Fxt3XY4wcXjAmMLe11tWuUe41LVbLt8KVZ+6jaYbjMZ8So4BoQWQ4PfVuVX7W9dVeq4YV1+Om9btog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyStEV3dDVM++2Gepr+NK7zjadQe98obDiA/Yl2rWAU=;
 b=LTwf6GimSplw3hjrlz14LiHlJE4kBsk66O/pPmfReiOgaQQKHFXNo+R7cPPxdMxDw07q3ZSfXUyXUBD48AbHD2IwTyFEkOwJhkumHA6n33s4/UJ4APYWxA8bjLJyQ2E0JnOMof1T3czl8ssA44BMPp4IbnshhwuAvcQiVBFkai4=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB4102.namprd13.prod.outlook.com (2603:10b6:208:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.9; Wed, 25 Nov
 2020 01:07:34 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3611.020; Wed, 25 Nov 2020
 01:07:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: NFS failure with generic/074 when lockdep is enabled - BUG:
 Invalid wait context
Thread-Topic: NFS failure with generic/074 when lockdep is enabled - BUG:
 Invalid wait context
Thread-Index: AQHWwqz9aN1vNyDjU0ur/hkP9gQDyqnYCVoA
Date:   Wed, 25 Nov 2020 01:07:34 +0000
Message-ID: <4f3a2c0de91ff3117ada740cc9b1a22eabb1375d.camel@hammerspace.com>
References: <CALF+zOntimx8nyiAUyN5Y58T9_-PztLpUU2vpYgOzQkcK7C09w@mail.gmail.com>
In-Reply-To: <CALF+zOntimx8nyiAUyN5Y58T9_-PztLpUU2vpYgOzQkcK7C09w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fd03b80-a8e1-4d59-4740-08d890de7dec
x-ms-traffictypediagnostic: MN2PR13MB4102:
x-microsoft-antispam-prvs: <MN2PR13MB4102FD567186FB7064077792B8FA0@MN2PR13MB4102.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7DHdg0O1aiZJabk4ihhigQyfDSttJGMxB6YQGvgblqxoPJn7Un9y7iyETx57uxRuX0OevmO9QU5Iusync4PDzlm864+Vq60jP6qxq3+66O91+Ij7df9XdawV/O3P/d37H01S1PnYK0KMq9lLc3ZKdIWZRabNc4FALTG3w8/vlGYo+gNqM57kcCv/i7pBjMSQpSmjbSBEgI2ZiazP/zZb9t/RP6C3sM0Nil0iaDCS+6guZWI5cCIcH2tWVctLQQZ7J77ukCIAM88qDqJxLwMj7anvTGnpzWcnO4G7w1+aCrxTYZLbW7TjPEXbYZmLx+gSL+ZVsgs8KhBUueR3Dc6Kgd9TwyTDQeXvKBv+Bn+5t26bC+gZQBB7iOXw7jv/Xjq2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(39840400004)(396003)(186003)(6486002)(478600001)(110136005)(83380400001)(86362001)(6512007)(8676002)(36756003)(71200400001)(2906002)(26005)(76116006)(6506007)(316002)(2616005)(5660300002)(91956017)(66446008)(64756008)(66946007)(4001150100001)(66476007)(8936002)(66556008)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BlqaMnXTmFA+JsPKHxB7fWuRGrwIYNu3e7MK0SWWi+bX7Osr1ZmoNs5RTTZ0s8ArnlxDIbTA5Isl70ubIq9orkMNJMtpH+y+A/2X2QkXndP608ua0aM/BUilQNnHZLQ6g6gd+WefnDdHv/gSnZlcie24eslZakYmooiyMiCXFcskRDIcHBXsmM7jRa/aQsZ9hS1+Ll6gr0YIykjE4sA2j/qCTm4SD/5ksgwXz1xo6s0CRcXNo9IvKoM3zMBfpP9FNyn4cQvD2ZLO6bbS0o8XiRyWYfNce7GRGiEggtoA11atUgiCkCvq6sB0CfSfse6wVLANIJNt8za1D7RK4l4uPAqPAOf+EPwbonJG2D6u4iZlv3PeHSbOLUWgwDgQlZo1LDde/d9w2zczEBSma/G4nOHEOQ69FmjyRlkTD2g+oOUWzjyco9aZO+4aUmu/LZI/EvxMdcje9XU36iC5vj9tPG5D8r8aem/Pn5LlFJe1XkHAEyBV2k+8iudkhNQ7QKffbxeVx3kF+ajleKvZoBGk+QO0yP2vaUZX8CnaJqoNaedv1LirDP2eDR6RdylmOb2vTNmdD/Ru5xzIWOJubuzacjnD41jHZPlLDjcDzdVV0aDU9gJ9xjcoayxwmx3+kSQemeskWfCqb+0SwaCLrAT9wylD0c8MVWk5xfQn8GoNw5M77oWmjh6nwvcGp8mxBTFCKvuzoEKpy+ohChpopL+gPlaZLSVgigy2kVv9IzZYjKcg6HVyhJ706b2v3JsPvut470LEiI3kheFM1gXVN+CsEmBaVNW+bcJ2zz+TS8d7+1XtRk28qULa0myzDq+Jhcp7XoaaWl5I1SKy16fM0qkUYMbnVPrmyUWAjaVTW+wfrV56gWzBAcnFNRpPQjovidA/nU5EFxm99H9rFMWHq9sEBg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <08895C08D052D440A49F56737173C883@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd03b80-a8e1-4d59-4740-08d890de7dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 01:07:34.2143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gg31pB9jcI6L2CB0hvAhM2WoOCopFnPB2fpQDQ9VZfdHQf9ARPPtZyLdXSwQ45iV1wAos799a3MXTQaThMB+Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4102
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTI0IGF0IDE2OjU2IC0wNTAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gSSd2ZSBzdGFydGVkIHNlZWluZyB0aGlzIGZhaWx1cmUgc2luY2UgdGVzdGluZyA1LjEw
LXJjNCAtIHRoaXMgZG9lcw0KPiBub3QgaGFwcGVuIG9uIDUuOQ0KPiANCj4gDQo+IGYzMS1ub2Rl
MSBsb2dpbjogW8KgIDEyNC4wNTU3NjhdIEZTLUNhY2hlOiBOZXRmcyAnbmZzJyByZWdpc3RlcmVk
IGZvcg0KPiBjYWNoaW5nDQo+IFvCoCAxMjUuMDQ2MTA0XSBLZXkgdHlwZSBkbnNfcmVzb2x2ZXIg
cmVnaXN0ZXJlZA0KPiBbwqAgMTI1Ljc3MDM1NF0gTkZTOiBSZWdpc3RlcmluZyB0aGUgaWRfcmVz
b2x2ZXIga2V5IHR5cGUNCj4gW8KgIDEyNS43ODA1OTldIEtleSB0eXBlIGlkX3Jlc29sdmVyIHJl
Z2lzdGVyZWQNCj4gW8KgIDEyNS43ODI0NDBdIEtleSB0eXBlIGlkX2xlZ2FjeSByZWdpc3RlcmVk
DQo+IFvCoCAxMjYuNTYzNzE3XSBydW4gZnN0ZXN0cyBnZW5lcmljLzA3NCBhdCAyMDIwLTExLTI0
IDExOjIzOjQ5DQo+IFvCoCAxNzguNzM2NDc5XQ0KPiBbwqAgMTc4Ljc1MTM4MF0gPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCj4gW8KgIDE3OC43NTMyNDldIFsgQlVHOiBJbnZhbGlkIHdh
aXQgY29udGV4dCBdDQo+IFvCoCAxNzguNzU0ODg2XSA1LjEwLjAtcmM0ICMxMjcgTm90IHRhaW50
ZWQNCj4gW8KgIDE3OC43NTY0MjNdIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFvC
oCAxNzguNzU4MDU1XSBrd29ya2VyLzE6Mi84NDggaXMgdHJ5aW5nIHRvIGxvY2s6DQo+IFvCoCAx
NzguNzU5ODY2XSBmZmZmODk0N2ZmZmQzM2Q4ICgmem9uZS0+bG9jayl7Li4tLn0tezM6M30sIGF0
Og0KPiBnZXRfcGFnZV9mcm9tX2ZyZWVsaXN0KzB4ODk3LzB4MjE5MA0KPiBbwqAgMTc4Ljc2MzMz
M10gb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcgdGhpczoNCj4gW8KgIDE3OC43
NjUzNTRdIGNvbnRleHQtezU6NX0NCj4gW8KgIDE3OC43NjY0MzddIDMgbG9ja3MgaGVsZCBieSBr
d29ya2VyLzE6Mi84NDg6DQo+IFvCoCAxNzguNzY4MTU4XcKgICMwOiBmZmZmODk0NmNlODI1NTM4
DQo+ICgod3FfY29tcGxldGlvbiluZnNpb2QpeysuKy59LXswOjB9LCBhdDogcHJvY2Vzc19vbmVf
d29yaysweDFiZS8weDU0MA0KPiBbwqAgMTc4Ljc3MTg3MV3CoCAjMTogZmZmZjllNmI0MDhmN2U1
OA0KPiAoKHdvcmtfY29tcGxldGlvbikoJnRhc2stPnUudGtfd29yaykjMil7Ky4rLn0tezA6MH0s
IGF0Og0KPiBwcm9jZXNzX29uZV93b3JrKzB4MWJlLzB4NTQwDQo+IFvCoCAxNzguNzc2NTYyXcKg
ICMyOiBmZmZmODk0N2Y3YzViMmIwIChrcmMubG9jayl7Li4tLn0tezI6Mn0sIGF0Og0KPiBrdmZy
ZWVfY2FsbF9yY3UrMHg2OS8weDIzMA0KPiBbwqAgMTc4Ljc3OTgwM10gc3RhY2sgYmFja3RyYWNl
Og0KPiBbwqAgMTc4Ljc4MDk5Nl0gQ1BVOiAxIFBJRDogODQ4IENvbW06IGt3b3JrZXIvMToyIEtk
dW1wOiBsb2FkZWQgTm90DQo+IHRhaW50ZWQgNS4xMC4wLXJjNCAjMTI3DQo+IFvCoCAxNzguNzg0
Mzc0XSBIYXJkd2FyZSBuYW1lOiBSZWQgSGF0IEtWTSwgQklPUyAwLjUuMSAwMS8wMS8yMDExDQo+
IFvCoCAxNzguNzg3MDcxXSBXb3JrcXVldWU6IG5mc2lvZCBycGNfYXN5bmNfcmVsZWFzZSBbc3Vu
cnBjXQ0KPiBbwqAgMTc4Ljc4OTMwOF0gQ2FsbCBUcmFjZToNCj4gW8KgIDE3OC43OTAzODZdwqAg
ZHVtcF9zdGFjaysweDhkLzB4YjUNCj4gW8KgIDE3OC43OTE4MTZdwqAgX19sb2NrX2FjcXVpcmUu
Y29sZCsweDIwYi8weDJjOA0KPiBbwqAgMTc4Ljc5MzYwNV3CoCBsb2NrX2FjcXVpcmUrMHhjYS8w
eDM4MA0KPiBbwqAgMTc4Ljc5NTExM13CoCA/IGdldF9wYWdlX2Zyb21fZnJlZWxpc3QrMHg4OTcv
MHgyMTkwDQo+IFvCoCAxNzguNzk3MTE2XcKgIF9yYXdfc3Bpbl9sb2NrKzB4MmMvMHg0MA0KPiBb
wqAgMTc4Ljc5ODYzOF3CoCA/IGdldF9wYWdlX2Zyb21fZnJlZWxpc3QrMHg4OTcvMHgyMTkwDQo+
IFvCoCAxNzguODAwNjIwXcKgIGdldF9wYWdlX2Zyb21fZnJlZWxpc3QrMHg4OTcvMHgyMTkwDQo+
IFvCoCAxNzguODAyNTM3XcKgIF9fYWxsb2NfcGFnZXNfbm9kZW1hc2srMHgxYjQvMHg0NjANCj4g
W8KgIDE3OC44MDQ0MTZdwqAgX19nZXRfZnJlZV9wYWdlcysweGQvMHgzMA0KPiBbwqAgMTc4Ljgw
NTk4N13CoCBrdmZyZWVfY2FsbF9yY3UrMHgxNjgvMHgyMzANCj4gW8KgIDE3OC44MDc2ODddwqAg
bmZzX2ZyZWVfcmVxdWVzdCsweGFiLzB4MTgwIFtuZnNdDQo+IFvCoCAxNzguODA5NTQ3XcKgIG5m
c19wYWdlX2dyb3VwX2Rlc3Ryb3krMHg0MS8weDgwIFtuZnNdDQo+IFvCoCAxNzguODExNTg4XcKg
IG5mc19yZWFkX2NvbXBsZXRpb24rMHgxMjkvMHgxZjAgW25mc10NCj4gW8KgIDE3OC44MTM2MzNd
wqAgcnBjX2ZyZWVfdGFzaysweDM5LzB4NjAgW3N1bnJwY10NCj4gW8KgIDE3OC44MTU0ODFdwqAg
cnBjX2FzeW5jX3JlbGVhc2UrMHgyOS8weDQwIFtzdW5ycGNdDQo+IFvCoCAxNzguODE3NDUxXcKg
IHByb2Nlc3Nfb25lX3dvcmsrMHgyM2UvMHg1NDANCj4gW8KgIDE3OC44MTkxMzZdwqAgd29ya2Vy
X3RocmVhZCsweDUwLzB4M2EwDQo+IFvCoCAxNzguODIwNjU3XcKgID8gcHJvY2Vzc19vbmVfd29y
aysweDU0MC8weDU0MA0KPiBbwqAgMTc4LjgyMjQyN13CoCBrdGhyZWFkKzB4MTBmLzB4MTUwDQo+
IFvCoCAxNzguODIzODA1XcKgID8ga3RocmVhZF9wYXJrKzB4OTAvMHg5MA0KPiBbwqAgMTc4Ljgy
NTMzOV3CoCByZXRfZnJvbV9mb3JrKzB4MjIvMHgzMA0KPiANCg0KSSBjYW4ndCB0aGluayBvZiBh
bnkgY2hhbmdlcyB0aGF0IG1pZ2h0IGhhdmUgY2F1c2VkIHRoaXMuIElzIHRoaXMNCk5GU3YzLCB2
NCBvciBvdGhlcj8gSSBoYXZlbid0IGJlZW4gc2VlaW5nIGFueSBvZiB0aGlzLg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
