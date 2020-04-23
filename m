Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109D11B64CA
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgDWTuM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:50:12 -0400
Received: from mail-co1nam11on2094.outbound.protection.outlook.com ([40.107.220.94]:47584
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbgDWTuM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 Apr 2020 15:50:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maooQEI+eymCRWWgqVnM4B+kJKEysQn8B+imhMQDfRYphZLS+j9kHTqc5OS5iFmViwytLednrus3uYYN5pRx698/XmaVIBAO9nxRPkNF4jUllRppjew9Na0LLBNAodDkQJ1Z0cgPcW9tbrD1FGAG/o5N7jfoTTiM03+fYJIJQkeHcCUrL04q26t8/s6tKRMegvK4R0jl75u1NWc9moGrWMT9073KtFrQVk6x4ETAeJJehj7frZvack2fhadxLnNVRoDRfduWLgvlk4jcmrbZiBBUYh+qJN27LdFiYRiDnslWg2smXZJLJTXtqEoCAfqDtD260FWCjkRVL6xjhY4AKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0DH55CMAdMA4LDkjYS2GPHMtJ7BC9kxQpLZ35NOEqE=;
 b=OaWR5qXEPONTIjQjtKTBlGZS6ikpOm2bnuFuvS3yQTKIYChS6nW8zhdA8EbR1fNasHE7WEU5jKJpaaNOxj2FqHYvU6PrKHwQ0zQkU96KnM9ASZiTM1TvKg05r2kU8K7rsLM0hF4nSq+/dAy26mdR/45czOjdi8Bpb5XzAtEfiwe3e7vu47oT60kn/m3FOJ2Dzl0n+wP/VHorF7X02e+yShbVobMGl0Jk/zEUj00TWWfwR321nkcfPiNwgNoHD42UClCYOoDahgjGoSDkf7BBegkIVmA+3KSbS9skzW4x3qrI4EXjJtk1MmgKBo0tU3uQlBONisAojJjDFa/l7RxhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0DH55CMAdMA4LDkjYS2GPHMtJ7BC9kxQpLZ35NOEqE=;
 b=gAtx1Fsbs/KPa6wHSeTsl3xeu0xCRiYzQQuVvl5KRNwZuf4hlIWtJlyE+Z/0s+YqUDGmDMn8rhnqSzYU3a9jtAD/bCsOmtMBvXZ6XPcsRGVObVgo3hbcIxbUF6qGgglJZ/ysxTgcsvFvRVlU/fBCegzFUTfQqVPLCnxiecGiY6w=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3848.namprd13.prod.outlook.com (2603:10b6:610:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.9; Thu, 23 Apr
 2020 19:50:09 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 19:50:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC2 1/2] SUNRPC: Set SOFTCONN when destroying GSS
 contexts
Thread-Topic: [PATCH RFC2 1/2] SUNRPC: Set SOFTCONN when destroying GSS
 contexts
Thread-Index: AQHWGaduuhGZXMpuMk+D4hjJ58U5PKiHHXiA
Date:   Thu, 23 Apr 2020 19:50:09 +0000
Message-ID: <1420699d1256f1808e5790e172bb3abd99ec7259.camel@hammerspace.com>
References: <20200423194311.7849.36326.stgit@manet.1015granger.net>
In-Reply-To: <20200423194311.7849.36326.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c916a71e-99ec-498f-19b2-08d7e7bf877d
x-ms-traffictypediagnostic: CH2PR13MB3848:
x-microsoft-antispam-prvs: <CH2PR13MB38486E94EB416BDC2D6A7CDBB8D30@CH2PR13MB3848.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(136003)(396003)(39830400003)(81156014)(71200400001)(66556008)(66946007)(186003)(66476007)(64756008)(2906002)(6916009)(91956017)(76116006)(66446008)(5660300002)(6506007)(26005)(316002)(478600001)(6512007)(8676002)(86362001)(2616005)(6486002)(4326008)(36756003)(8936002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPIQNlJzjxXLxXceAyJl72RAKxinfnhnWcMxtY/Sa4WL7AItLgcsvKSvI2rR6lAiaqWHwQvM7PE5vhx+11h8uZXv20zO6uqXvFO8JsqGcrAlTlWBoKVZhmxNSPZCxZ8poJd74H8uOaJnP1FwDPNpgYopx/Y+X2BCf3Gi6BqDMhzwLu9keUKZJ2GqtHPUwoLu2xnAp4zLEydxjjCT47w+2zEPAZFYiZyLdybq9Bxd55RVSuuFM7KwrbDZMejvmc7I6eZTXKzHF6CY8CfFDCp645enzPCBdwtgLWrQw9TMw2z++2R9uaV3JPGdFtb6UpOJ4ZOF3OhTUFA9YaTMhLqh4XB3Xdk1ujdI3qZFfPWna+K6czufVfT1lsM0We6JIINk9Fo0JOmXPBlS12RkQCZZ6IfVAlyRqnYfyAaAEOE7WIy2dhlYWOrsD5obnP5iInIX
x-ms-exchange-antispam-messagedata: KfIqZSzgvqkwxv6ToBxFmOeF41t79Sw5caZyZcRY0NDmcloB/yO85C7GQorqArHForhT2LbNqIwygn4VOS/7mj4EiugzWsAFXAbTSdyxKUBfQc4j488DTfSb/BCESIeP4u1MMJXDaYzBttCi5oSkgq+lWs3e+UGgWsjC7EgAXtXhmEHmTE5vGKYcGbC1jCe2GvKuUtP/geAb8b08VZ0KQK3akOV6ruX/RbxMWzeiCKVgG8+Jhtx+DDUXadzXfitE5krRxdOwD/0+H67A+vC9yPoxKtDt/004P3SB9iPqvoocbLA1TOXUW0Gj4HgQEaJVG5drp05mWVywy8iQKpnXEF7pxRO/aqDOEwRh7T4wSBn4MrO6qXVvnO0YUIJby+NqWkp3UrM17lD7UaxCTwOGXoa74fIzFfl5L0vY6z0DrXrOfcZRkdYfk6+00pwmY0f/Gzt0uHNkm9wimdWJ8/Iq3m0cfO1WHFMtda3yOqpz47xbzLD+AcpqQWq58KcIay6ixmKiMBa2KZva+7SoKcf+2Gs0jicMOVgMcCYGSg1i+euBydZZOqgcqXGJG9OwzDI8gCCwwmYRIVB+DChUj4OAbI3fXR6Ktwzywl7gEDDwZbGMUkaCVMi0vfaxmsa2Vx8v+W/+7ZfF1YxO2iKWfnqs2gS3h9fobYaiK07+iNYsJPEu24GQFoytoZwciB0zC3jY4yxgc2UQVh/VYudg3HbjaWVUiiySCcnG4ISmga8ql5+AJOWryoPEhFvp4zD6oQg7y7J4rLaN2N3Ig5f6mzWmaJ0BKraBnvv4jlPC+ZBWlGc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <86898DD04B90BA4F8CD3B61541CA5191@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c916a71e-99ec-498f-19b2-08d7e7bf877d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 19:50:09.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srVYs4WziqMrOnvevT6eQPzL+mVe7Rt9bfOu7CGW37mMXOHs77Gs6izG/PdXv8lLZ9WtP8mEcO9Vy4wG49onnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3848
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTIzIGF0IDE1OjQzIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
UHJldmVudCBhICh0ZW1wb3JhcnkpIGhhbmcgd2hlbiBzaHV0dGluZyBkb3duIGFuIHJwY19jbG50
IHRoYXQgaGFzDQo+IHVzZWQgb25lIG9yIG1vcmUgR1NTIGNyZWRzLg0KPiANCj4gSSBub3RpY2Vk
IHRoYXQgY2FsbGVycyBvZiBycGNfY2FsbF9udWxsX2hlbHBlcigpIHVzZSBhIGNvbW1vbiBzZXQg
b2YNCj4gZmxhZ3MsIHNvIEkgY29sbGVjdGVkIHRoZW0gYWxsIGluIHRoYXQgaGVscGVyIGZ1bmN0
aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNs
ZS5jb20+DQo+IC0tLQ0KPiAgbmV0L3N1bnJwYy9hdXRoX2dzcy9hdXRoX2dzcy5jIHwgICAgMiAr
LQ0KPiAgbmV0L3N1bnJwYy9jbG50LmMgICAgICAgICAgICAgIHwgICAxMCArKysrLS0tLS0tDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL2F1dGhfZ3NzL2F1dGhfZ3NzLmMNCj4gYi9uZXQvc3Vu
cnBjL2F1dGhfZ3NzL2F1dGhfZ3NzLmMNCj4gaW5kZXggYWM1Y2FjMGRkMjRiLi4xNmNlYzk3NTVi
ODYgMTAwNjQ0DQo+IC0tLSBhL25ldC9zdW5ycGMvYXV0aF9nc3MvYXV0aF9nc3MuYw0KPiArKysg
Yi9uZXQvc3VucnBjL2F1dGhfZ3NzL2F1dGhfZ3NzLmMNCj4gQEAgLTEyODUsNyArMTI4NSw3IEBA
IHN0YXRpYyB2b2lkIGdzc19waXBlX2ZyZWUoc3RydWN0IGdzc19waXBlICpwKQ0KPiAgCQljdHgt
PmdjX3Byb2MgPSBSUENfR1NTX1BST0NfREVTVFJPWTsNCj4gIA0KPiAgCQl0YXNrID0gcnBjX2Nh
bGxfbnVsbChnc3NfYXV0aC0+Y2xpZW50LCAmbmV3LT5nY19iYXNlLA0KPiAtCQkJCVJQQ19UQVNL
X0FTWU5DfFJQQ19UQVNLX1NPRlQpOw0KPiArCQkJCSAgICAgUlBDX1RBU0tfQVNZTkMpOw0KDQpO
by4gVGhpcyBtZWFucyB3ZSBjYW4gZW5kIHdpdGggc2lsZW50bHkgaGFuZ2luZyBjbGllbnRzIHRo
YXQgbmV2ZXIgZ28NCmF3YXkuIEJlc2lkZXMsIHRoaXMgZnVuY3Rpb24gaXMgZGVzdHJveWluZyB0
aGUgY3JlZHMsIHNvIHRoZXJlIHNob3VsZA0KYmUgbm8gcHJvYmxlbSB3aXRoIHRoZW0gdGltaW5n
IG91dC4NCg0KPiAgCQlpZiAoIUlTX0VSUih0YXNrKSkNCj4gIAkJCXJwY19wdXRfdGFzayh0YXNr
KTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9jbG50LmMgYi9uZXQvc3VucnBjL2Ns
bnQuYw0KPiBpbmRleCAzMjVhMDg1ODcwMGYuLmRkYzk4Yjk3YzE3MCAxMDA2NDQNCj4gLS0tIGEv
bmV0L3N1bnJwYy9jbG50LmMNCj4gKysrIGIvbmV0L3N1bnJwYy9jbG50LmMNCj4gQEAgLTI3NDIs
NyArMjc0Miw4IEBAIHN0cnVjdCBycGNfdGFzayAqcnBjX2NhbGxfbnVsbF9oZWxwZXIoc3RydWN0
DQo+IHJwY19jbG50ICpjbG50LA0KPiAgCQkucnBjX29wX2NyZWQgPSBjcmVkLA0KPiAgCQkuY2Fs
bGJhY2tfb3BzID0gKG9wcyAhPSBOVUxMKSA/IG9wcyA6ICZycGNfZGVmYXVsdF9vcHMsDQo+ICAJ
CS5jYWxsYmFja19kYXRhID0gZGF0YSwNCj4gLQkJLmZsYWdzID0gZmxhZ3MgfCBSUENfVEFTS19O
VUxMQ1JFRFMsDQo+ICsJCS5mbGFncyA9IGZsYWdzIHwgUlBDX1RBU0tfU09GVCB8IFJQQ19UQVNL
X1NPRlRDT05OIHwNCj4gKwkJCSBSUENfVEFTS19OVUxMQ1JFRFMsDQo+ICAJfTsNCj4gIA0KPiAg
CXJldHVybiBycGNfcnVuX3Rhc2soJnRhc2tfc2V0dXBfZGF0YSk7DQo+IEBAIC0yODA1LDggKzI4
MDYsNyBAQCBpbnQgcnBjX2NsbnRfdGVzdF9hbmRfYWRkX3hwcnQoc3RydWN0IHJwY19jbG50DQo+
ICpjbG50LA0KPiAgCQlnb3RvIHN1Y2Nlc3M7DQo+ICAJfQ0KPiAgDQo+IC0JdGFzayA9IHJwY19j
YWxsX251bGxfaGVscGVyKGNsbnQsIHhwcnQsIE5VTEwsDQo+IC0JCQlSUENfVEFTS19TT0ZUfFJQ
Q19UQVNLX1NPRlRDT05OfFJQQ19UQVNLX0FTWU5DfA0KPiBSUENfVEFTS19OVUxMQ1JFRFMsDQo+
ICsJdGFzayA9IHJwY19jYWxsX251bGxfaGVscGVyKGNsbnQsIHhwcnQsIE5VTEwsIFJQQ19UQVNL
X0FTWU5DLA0KPiAgCQkJJnJwY19jYl9hZGRfeHBydF9jYWxsX29wcywgZGF0YSk7DQo+ICAJaWYg
KElTX0VSUih0YXNrKSkNCj4gIAkJcmV0dXJuIFBUUl9FUlIodGFzayk7DQo+IEBAIC0yODUwLDkg
KzI4NTAsNyBAQCBpbnQgcnBjX2NsbnRfc2V0dXBfdGVzdF9hbmRfYWRkX3hwcnQoc3RydWN0DQo+
IHJwY19jbG50ICpjbG50LA0KPiAgCQlnb3RvIG91dF9lcnI7DQo+ICANCj4gIAkvKiBUZXN0IHRo
ZSBjb25uZWN0aW9uICovDQo+IC0JdGFzayA9IHJwY19jYWxsX251bGxfaGVscGVyKGNsbnQsIHhw
cnQsIE5VTEwsDQo+IC0JCQkJICAgIFJQQ19UQVNLX1NPRlQgfCBSUENfVEFTS19TT0ZUQ09OTiB8
DQo+IFJQQ19UQVNLX05VTExDUkVEUywNCj4gLQkJCQkgICAgTlVMTCwgTlVMTCk7DQo+ICsJdGFz
ayA9IHJwY19jYWxsX251bGxfaGVscGVyKGNsbnQsIHhwcnQsIE5VTEwsIDAsIE5VTEwsIE5VTEwp
Ow0KPiAgCWlmIChJU19FUlIodGFzaykpIHsNCj4gIAkJc3RhdHVzID0gUFRSX0VSUih0YXNrKTsN
Cj4gIAkJZ290byBvdXRfZXJyOw0KPiANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
