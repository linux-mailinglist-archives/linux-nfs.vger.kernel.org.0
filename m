Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1324219FA0
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2020 14:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgGIMIP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jul 2020 08:08:15 -0400
Received: from mail-mw2nam10on2130.outbound.protection.outlook.com ([40.107.94.130]:16672
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbgGIMIO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 Jul 2020 08:08:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNshQUQaE5sWkLg/4BpFKCx6rkVddeAm59IFkovZwIo8Ge6bxCoQpX5OFPngEQRfhFFT0xFVx1JeRUHrYERxBv/1ss9Dha56JPsei3W29yHnkh9RDlfdnTdaVh5lu9TYJG3WLw1Ust81/h/IWM17f0HdldHkYv1vH2CYOfJBEr2ofEfjeteTgGAnlZm++KEKZ+lpHIIxADmM1Uy2cTSeMqtODTQ2co6id2fYzGnFwhaQFUMgTRP6kmPVcxsPgI+neE/h6HuIQd4P6Npsf/k9ZflAyjUaFxnU8xt3xffDA/HuNApMY5QX3YfE8YoZWTfIRER1FkdbST0i9abh/EBcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8iQUUH7j3s+OW5h/zaLinfEkI+OGJBMlCV94GcedCE=;
 b=GXBfeaIs0qsc9DSoSsVl5hbrkmpZHtye4PIMT+lUf9LCB8hCPI46SGwZ/oBT5tbnCFl/vvbfeRTrAsW9uz4rEQsb1T9pVAWfn4n3fFjeZNPcktA8Ku/nd+nqopqLxrqztq9PRJIm/eXYg39Vd55cUBEKDiFq6ALCXzUtH4wBRu9JLpvlD37XRudTWu4/lQosn1ZnaGwASXv9i7K6Re65nIftWQMvDNZAbbrZok9x44/ZWZviekRVwG/5ldEXqE6PIWtAr74q3RgNAefCs8BI+80LJl7OhGwuvkmlz70p/kX73o74Y7whyop4041R0uztzHS0Gwul2gvl937U6up2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8iQUUH7j3s+OW5h/zaLinfEkI+OGJBMlCV94GcedCE=;
 b=Fnzyrc8Lb81iCyvsKauJcDvtziBxryOXNZkICUPCyx4+cIn6hENMIBDeb1Ruif9uDEmgjISChv46dGKXL+wpWfohp6troaz4fCDIEynLfjbmL4aQGKCJpbloVFhs4a6eAC1+Er/gGeFycEKRWRHCumGtQ7oqOUfSeMKtJZwS/NY=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.18; Thu, 9 Jul
 2020 12:08:10 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 12:08:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] SUNRPC dont update timeout value on connection reset
Thread-Topic: [PATCH 1/1] SUNRPC dont update timeout value on connection reset
Thread-Index: AQHWVWs8m1CKZ35+pUqHJLj6MBnD8Kj/KF+A
Date:   Thu, 9 Jul 2020 12:08:10 +0000
Message-ID: <41873966ea839cca97332df3c56612441f840e0d.camel@hammerspace.com>
References: <20200708210514.84671-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200708210514.84671-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [50.36.87.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83341765-30c2-4b18-a9f5-08d82400bf9b
x-ms-traffictypediagnostic: CH2PR13MB3398:
x-microsoft-antispam-prvs: <CH2PR13MB339876A985AF984133419D7FB8640@CH2PR13MB3398.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HrBDCQeEzKeFgUD29ftcXQ9y2TCKISXQXt3cVt7aERfk6SeBhklLg36N1fPQmRd79K2SM1MCICx8SC6l5XEmU18ZIr6qGnMP90doYF/F+Lc1lIDLMs/CJY2QE8+spCF5bdXCQZfFO/IjqzPp9/i9tEWx/5tHsbrZJlMhsJUxJuEHOyIerAyTSKRZdZfjLGC1aZdibzWdvqTGG8PkgqV2His6up6YMf1t+fzgGF+YrSd3BVEXcttLQOwJdx/ROksY7SLOGfiQx5VsUUK2T0xR7ZlfTqN7OaAQXyxB0qq7epdCW2AMZLxvcxPGYXnVjrPCM0bwL/nddvtB5SN3IhLKTuJMimVeHHMswmC3WcQ8UZ+sLu5rzqH6dMSRB/7LM8FZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39830400003)(376002)(346002)(2616005)(26005)(6506007)(8936002)(5660300002)(71200400001)(66476007)(86362001)(64756008)(15650500001)(66446008)(66946007)(76116006)(4326008)(36756003)(66556008)(2906002)(110136005)(83380400001)(6486002)(186003)(478600001)(316002)(8676002)(6512007)(192303002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: G7YksPLNlbiqDqDcTyte5NXjUHO8tip7S7WoelNWwY+cQ1rSTOKBEBAKkOstvfC30mx6f0j3b068lDp8x4t8Q78OEiexZqWiFNPN3x3RQ9osd5QpwhI0yea/LIPuYNOLO1XJd4ghWyxJVvhyQb5eCz0OZ4M0Jcg7uCzn2ge9PaBmFKvcwBR1DEQs3qY/G2+ZESh/jB0Ujy4dDw358HYpqKN6KBlN/IwZdorpodDRrbAgdNwx8OCSUK7gaOia1y9hyjmIHSz8R/8gJeC8HqaS+uNU7tdoAPCxdP/Lqueri4RpiGVMkmHJMhgC2HX/3dCbjvZip2KXMTXydNFeWePk0iEcTtxsyJBWO5vBk6KsVOnZq34GGqPHwWzarE6uamW0/Cdhh2+9+su2SBnv6jaTMfchcoqF5g9Ka016nxKv9lUyQpc6VHmH/jS56+V7RR4fYs8qtWFZtIRVKn3rVcxFZZyUwko3bbq/V1jhEx9gtyM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B82429071529D45A338528B9D7C1B19@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83341765-30c2-4b18-a9f5-08d82400bf9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 12:08:10.3696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctXPjh4k1OxBp5RDoeWDYLHYFPxFf7CdDLlL6VS0pJ89NXNWYq7AayoDvLMQaLiGifVtxxvt/1ztXA4lZ+bZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3398
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYQ0KDQpPbiBXZWQsIDIwMjAtMDctMDggYXQgMTc6MDUgLTA0MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPiBDdXJyZW50IGJlaGF2aW91cjogZXZlcnkgdGltZSBhIHYzIG9wZXJh
dGlvbiBpcyByZS1zZW50IHRvIHRoZSBzZXJ2ZXINCj4gd2UgdXBkYXRlIChkb3VibGUpIHRoZSB0
aW1lb3V0LiBUaGVyZSBpcyBubyBkaXN0aW5jdGlvbiBiZXR3ZWVuDQo+IHdoZXRoZXINCj4gb3Ig
bm90IHRoZSBwcmV2aW91cyB0aW1lciBoYWQgZXhwaXJlZCBiZWZvcmUgdGhlIHJlLXNlbnQgaGFw
cGVuZWQuDQo+IA0KPiBIZXJlJ3MgdGhlIHNjZW5hcmlvOg0KPiAxLiBDbGllbnQgc2VuZHMgYSB2
MyBvcGVyYXRpb24NCj4gMi4gU2VydmVyIFJTVC1zIHRoZSBjb25uZWN0aW9uIChwcmlvciB0byB0
aGUgdGltZW91dCkgKGVnLiwNCj4gY29ubmVjdGlvbg0KPiBpcyBpbW1lZGlhdGVseSByZXNldCkN
Cj4gMy4gQ2xpZW50IHJlLXNlbmRzIGEgdjMgb3BlcmF0aW9uIGJ1dCB0aGUgdGltZW91dCBpcyBu
b3cgMTIwc2VjLg0KPiANCj4gQXMgYSByZXN1bHQsIGFuIGFwcGxpY2F0aW9uIHNlZXMgMm1pbnMg
cGF1c2UgYmVmb3JlIGEgcmV0cnkgaW4gY2FzZQ0KPiBzZXJ2ZXIgYWdhaW4gZG9lcyBub3QgcmVw
bHkuDQo+IA0KPiBJbnN0ZWFkLCB0aGlzIHBhdGNoIHByb3Bvc2VzIHRvIGtlZXAgdHJhY2sgb2Zm
IHdoZW4gdGhlIG1pbm9yIHRpbWVvdXQNCj4gc2hvdWxkIGhhcHBlbiBhbmQgaWYgaXQgZGlkbid0
LCB0aGVuIGRvbid0IHVwZGF0ZSB0aGUgbmV3IHRpbWVvdXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRl
L2xpbnV4L3N1bnJwYy94cHJ0LmggfCAgMSArDQo+ICBuZXQvc3VucnBjL3hwcnQuYyAgICAgICAg
ICAgfCAxMSArKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdW5ycGMveHBydC5oDQo+IGIvaW5j
bHVkZS9saW51eC9zdW5ycGMveHBydC5oDQo+IGluZGV4IGU2NGJkODIuLmE2MDNkNDggMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnQuaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L3N1bnJwYy94cHJ0LmgNCj4gQEAgLTEwMSw2ICsxMDEsNyBAQCBzdHJ1Y3QgcnBjX3Jxc3Qg
ew0KPiAgCQkJCQkJCSAqIHVzZWQgaW4gdGhlDQo+IHNvZnRpcnEuDQo+ICAJCQkJCQkJICovDQo+
ICAJdW5zaWduZWQgbG9uZwkJcnFfbWFqb3J0aW1lbzsJLyogbWFqb3IgdGltZW91dA0KPiBhbGFy
bSAqLw0KPiArCXVuc2lnbmVkIGxvbmcJCXJxX21pbm9ydGltZW87CS8qIG1pbm9yIHRpbWVvdXQN
Cj4gYWxhcm0gKi8NCj4gIAl1bnNpZ25lZCBsb25nCQlycV90aW1lb3V0OwkvKiBDdXJyZW50IHRp
bWVvdXQNCj4gdmFsdWUgKi8NCj4gIAlrdGltZV90CQkJcnFfcnR0OwkJLyogcm91bmQtdHJpcCB0
aW1lICovDQo+ICAJdW5zaWduZWQgaW50CQlycV9yZXRyaWVzOwkvKiAjIG9mIHJldHJpZXMgKi8N
Cj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydC5jIGIvbmV0L3N1bnJwYy94cHJ0LmMNCj4g
aW5kZXggZDVjYzVkYi4uYzBjZTIzMiAxMDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy94cHJ0LmMN
Cj4gKysrIGIvbmV0L3N1bnJwYy94cHJ0LmMNCj4gQEAgLTYwNyw2ICs2MDcsMTEgQEAgc3RhdGlj
IHZvaWQgeHBydF9yZXNldF9tYWpvcnRpbWVvKHN0cnVjdA0KPiBycGNfcnFzdCAqcmVxKQ0KPiAg
CXJlcS0+cnFfbWFqb3J0aW1lbyArPSB4cHJ0X2NhbGNfbWFqb3J0aW1lbyhyZXEpOw0KPiAgfQ0K
PiAgDQo+ICtzdGF0aWMgdm9pZCB4cHJ0X3Jlc2V0X21pbm9ydGltZW8oc3RydWN0IHJwY19ycXN0
ICpyZXEpDQo+ICt7DQo+ICsJcmVxLT5ycV9taW5vcnRpbWVvID0gamlmZmllcyArIHJlcS0+cnFf
dGltZW91dDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgeHBydF9pbml0X21ham9ydGltZW8o
c3RydWN0IHJwY190YXNrICp0YXNrLCBzdHJ1Y3QNCj4gcnBjX3Jxc3QgKnJlcSkNCj4gIHsNCj4g
IAl1bnNpZ25lZCBsb25nIHRpbWVfaW5pdDsNCj4gQEAgLTYxOCw2ICs2MjMsNyBAQCBzdGF0aWMg
dm9pZCB4cHJ0X2luaXRfbWFqb3J0aW1lbyhzdHJ1Y3QgcnBjX3Rhc2sNCj4gKnRhc2ssIHN0cnVj
dCBycGNfcnFzdCAqcmVxKQ0KPiAgCQl0aW1lX2luaXQgPSB4cHJ0X2Fic19rdGltZV90b19qaWZm
aWVzKHRhc2stPnRrX3N0YXJ0KTsNCj4gIAlyZXEtPnJxX3RpbWVvdXQgPSB0YXNrLT50a19jbGll
bnQtPmNsX3RpbWVvdXQtPnRvX2luaXR2YWw7DQo+ICAJcmVxLT5ycV9tYWpvcnRpbWVvID0gdGlt
ZV9pbml0ICsgeHBydF9jYWxjX21ham9ydGltZW8ocmVxKTsNCj4gKwlyZXEtPnJxX21pbm9ydGlt
ZW8gPSB0aW1lX2luaXQgKyByZXEtPnJxX3RpbWVvdXQ7DQo+ICB9DQo+ICANCj4gIC8qKg0KPiBA
QCAtNjMxLDYgKzYzNywxMCBAQCBpbnQgeHBydF9hZGp1c3RfdGltZW91dChzdHJ1Y3QgcnBjX3Jx
c3QgKnJlcSkNCj4gIAljb25zdCBzdHJ1Y3QgcnBjX3RpbWVvdXQgKnRvID0gcmVxLT5ycV90YXNr
LT50a19jbGllbnQtDQo+ID5jbF90aW1lb3V0Ow0KPiAgCWludCBzdGF0dXMgPSAwOw0KPiAgDQo+
ICsJaWYgKHRpbWVfYmVmb3JlKGppZmZpZXMsIHJlcS0+cnFfbWlub3J0aW1lbykpIHsNCj4gKwkJ
eHBydF9yZXNldF9taW5vcnRpbWVvKHJlcSk7DQo+ICsJCXJldHVybiBzdGF0dXM7DQoNClNob3Vs
ZG4ndCB0aGlzIGNhc2UgYmUganVzdCByZXR1cm5pbmcgd2l0aG91dCB1cGRhdGluZyB0aGUgdGlt
ZW91dD8NCkFmdGVyIGFsbCwgdGhpcyBpcyB0aGUgY2FzZSB3aGVyZSBub3RoaW5nIGhhcyBleHBp
cmVkIHlldC4NCg0KPiArCX0NCj4gIAlpZiAodGltZV9iZWZvcmUoamlmZmllcywgcmVxLT5ycV9t
YWpvcnRpbWVvKSkgew0KPiAgCQlpZiAodG8tPnRvX2V4cG9uZW50aWFsKQ0KPiAgCQkJcmVxLT5y
cV90aW1lb3V0IDw8PSAxOw0KPiBAQCAtNjM4LDYgKzY0OCw3IEBAIGludCB4cHJ0X2FkanVzdF90
aW1lb3V0KHN0cnVjdCBycGNfcnFzdCAqcmVxKQ0KPiAgCQkJcmVxLT5ycV90aW1lb3V0ICs9IHRv
LT50b19pbmNyZW1lbnQ7DQo+ICAJCWlmICh0by0+dG9fbWF4dmFsICYmIHJlcS0+cnFfdGltZW91
dCA+PSB0by0+dG9fbWF4dmFsKQ0KPiAgCQkJcmVxLT5ycV90aW1lb3V0ID0gdG8tPnRvX21heHZh
bDsNCj4gKwkJeHBydF9yZXNldF9taW5vcnRpbWVvKHJlcSk7DQoNCi4uLmFuZCB0aGVuIHBlcmhh
cHMgdGhpcyBjYW4ganVzdCBiZSBtb3ZlZCBvdXQgb2YgdGhlIHRpbWVfYmVmb3JlKCkNCmNvbmRp
dGlvbiwgc2luY2UgaXQgbG9va3MgdG8gbWUgYXMgaWYgd2UgYWxzbyB3YW50IHRvIHJlc2V0IHJl
cS0NCj5ycV9taW5vcnRpbWVvIHdoZW4gYSBtYWpvciB0aW1lb3V0IG9jY3Vycy4NCg0KPiAgCQly
ZXEtPnJxX3JldHJpZXMrKzsNCj4gIAl9IGVsc2Ugew0KPiAgCQlyZXEtPnJxX3RpbWVvdXQgPSB0
by0+dG9faW5pdHZhbDsNCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==
