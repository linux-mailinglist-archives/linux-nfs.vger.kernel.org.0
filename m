Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280D62213D6
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 19:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgGOR6U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 13:58:20 -0400
Received: from mail-co1nam11on2128.outbound.protection.outlook.com ([40.107.220.128]:50849
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbgGOR6T (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 Jul 2020 13:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9v2+VjDh1A80u+3+jsGQwQqD9/eCryU0HVplX2nY4VYVdAWB9gygC2rEh9Y4nOAqmmQFQAJ08xl6wDxyGv3sr+B/5ZuWhhfLtfT3u66WMzaT5SApIfQrbpiQT2mHVtA2ejBHw2yreNzPBzBHamXM/GKlmW6ijAXQZvUpmSu241tSBvnZO0dz8jNHx+hUG6Q8+gxK92WpiPh8sRbfeAcf6xPGaFsZXV0ohyEjwQDR3Pg+WRGt5pboTzr85wiVwmDxXAEUUmWyeoimzet2PYalxbGU75kRgRFuDxZMo66LBx0ZEllr0TVpdrLq9QgiJAmxWurqxxpwHi9S9BUtyneFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/7c4v8XdvrojIC+Cg9YWebqlRN+4SvWAOu1cHH4BIk=;
 b=GUGJIVCMiupOvZ9gPMHdV+e+nkL7+JTaZFtcxaA230icbINrcWDaVi2szzYiCi0/giReay2yVQmLQ1bItqrhHwZJfQxxU+9EuoPtbS1o0Lc+RyA1q95hB8i1EgKs4beFUdDA2BGLzjh0ITGSnuAeNMQe/0z0ftKBsCB3qhlWmXqWrolpm6aGS0xntbVt8se32GoOidOlaSzy9RkmACSFRFDjizr4+s7w2/jf6tgcCPMrnsJKY97t6GBoVluZUUSWysRkIct2dhuxvW6p73iWIUfqRFumPPA+7SP6FQFIkK5X25Cl/xMi9un0dfjQZrqhzIjLnDmHABT44YBlFua+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/7c4v8XdvrojIC+Cg9YWebqlRN+4SvWAOu1cHH4BIk=;
 b=bJniY4nwKbbVGAulpdJn2x/L80rCjwcupe1IGy8IpvWhKy12cCa+L0Q1nCUufhixKSz7fyI4DRQ6kJVBE06JhMNq8CQMa2o1vBUMzyO5NJcg8oDayfNtcXr4r9vY6lurFEuc3k0PoTHtrpQNklaoKK6IVT7JwOtDbYXjX4HeJtk=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3400.namprd13.prod.outlook.com (2603:10b6:610:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.10; Wed, 15 Jul
 2020 17:58:13 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3195.017; Wed, 15 Jul 2020
 17:58:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] SUNRPC dont update timeout value on connection
 reset
Thread-Topic: [PATCH v3 1/1] SUNRPC dont update timeout value on connection
 reset
Thread-Index: AQHWWsufpqOIiT4bSEuypkqE+BTdR6kI7WsA
Date:   Wed, 15 Jul 2020 17:58:13 +0000
Message-ID: <74d3a7e4bfc6ca9d3130ecb9be96eb59c7796497.camel@hammerspace.com>
References: <20200715171752.94224-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200715171752.94224-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 192fb628-95c1-4c6e-6606-08d828e8a4f7
x-ms-traffictypediagnostic: CH2PR13MB3400:
x-microsoft-antispam-prvs: <CH2PR13MB3400C91022C72D86CD23DDC8B87E0@CH2PR13MB3400.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KjuDAEOrZ2LcNKijJTJOajLrGytPH/H6JYSn84yN10eLuXDHInhdjF9iUFlhVoMVD8yIEyof1nCBpAqAgNECRyvwO1dA/lkM6jJJKpFkMRdBrf6v+wXsRwNBsdbnxcAGSLwJvI6fsT+AUouw/+sHsnohVZPqSEO7kqTEwjmF//kx602vCEx+TL4dVLprUlc1g+mHxytmX55Kvss1/gZnOIOywH+qepQTxt68kUAnQgHVe1LDCBSHl3aFNzzzOgvlo0yKcVYjfUDcW7zE7ad9cB9/zq8u1Vi2BFNPJhBnpx+iGfC5mFG89Q2CKsPjB01/mxj/0mZu7Ac5/hvBam1BdEH7dQy2Ffkfl9/698IIbva/g/45f1wfzwFDefvq2iNL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(39840400004)(136003)(346002)(71200400001)(8936002)(83380400001)(6512007)(316002)(6486002)(2906002)(15650500001)(478600001)(66476007)(6506007)(86362001)(4326008)(186003)(110136005)(36756003)(26005)(76116006)(66946007)(66446008)(66556008)(8676002)(64756008)(2616005)(5660300002)(192303002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tPdcS3KV256vQnWkd+nQerRCK+ZfFbeVNTOpKBQKFECsUjKSjrR/GGjnqnUbnpKGbU2CW433vurMUoRNla2w062NB7qji4+7xzVKQB5G73FFMhHG5KwCVBJMYGNYH/JiDFxrgG6OX3eyZ91dLr0pg4IEPHwuoMVmvjFlQyosJRzzt9QopUX5NILimDalUBskCAlcyb+Bf+dBSy7t/tmjmxB/+3s2K0MTMDfsfWF74yF9NW1IdDZIatSi2Z4jqWECdVRe42/umucAzevEoPxGutkuGdLnkiGw5loXzL/K4OzpP9nlz8nrCMgD7KcBA/myf5efo8ba+qGWPyjAxmdqDLjkzOFOYXwRnhzrmaMCgb3tW4Q1LXyfbbcVUJ4reiA/5pngdW4rDQ2AV6OLgvVTWG6Ymk82fqJx3SRaJ7F8FOCVMbW2I/1EMjaj5aa66oEp6yj3typMqszdnCo4P7XPbSFI65xUydxahh7w6bzSSw8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB792E128613234DA3CD77B2B07DD955@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192fb628-95c1-4c6e-6606-08d828e8a4f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 17:58:13.7106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7hTOH+cNa3Q1Qg0iibQvKICXFexcY90KI/RKNqUq+G0BKOMuwmxn5H/0S+0+m/8FxIyv0DLPk5eix0BTyzYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3400
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTE1IGF0IDEzOjE3IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gQ3VycmVudCBiZWhhdmlvdXI6IGV2ZXJ5IHRpbWUgYSB2MyBvcGVyYXRpb24gaXMgcmUt
c2VudCB0byB0aGUgc2VydmVyDQo+IHdlIHVwZGF0ZSAoZG91YmxlKSB0aGUgdGltZW91dC4gVGhl
cmUgaXMgbm8gZGlzdGluY3Rpb24gYmV0d2Vlbg0KPiB3aGV0aGVyDQo+IG9yIG5vdCB0aGUgcHJl
dmlvdXMgdGltZXIgaGFkIGV4cGlyZWQgYmVmb3JlIHRoZSByZS1zZW50IGhhcHBlbmVkLg0KPiAN
Cj4gSGVyZSdzIHRoZSBzY2VuYXJpbzoNCj4gMS4gQ2xpZW50IHNlbmRzIGEgdjMgb3BlcmF0aW9u
DQo+IDIuIFNlcnZlciBSU1QtcyB0aGUgY29ubmVjdGlvbiAocHJpb3IgdG8gdGhlIHRpbWVvdXQp
IChlZy4sDQo+IGNvbm5lY3Rpb24NCj4gaXMgaW1tZWRpYXRlbHkgcmVzZXQpDQo+IDMuIENsaWVu
dCByZS1zZW5kcyBhIHYzIG9wZXJhdGlvbiBidXQgdGhlIHRpbWVvdXQgaXMgbm93IDEyMHNlYy4N
Cj4gDQo+IEFzIGEgcmVzdWx0LCBhbiBhcHBsaWNhdGlvbiBzZWVzIDJtaW5zIHBhdXNlIGJlZm9y
ZSBhIHJldHJ5IGluIGNhc2UNCj4gc2VydmVyIGFnYWluIGRvZXMgbm90IHJlcGx5Lg0KPiANCj4g
SW5zdGVhZCwgdGhpcyBwYXRjaCBwcm9wb3NlcyB0byBrZWVwIHRyYWNrIG9mZiB3aGVuIHRoZSBt
aW5vciB0aW1lb3V0DQo+IHNob3VsZCBoYXBwZW4gYW5kIGlmIGl0IGRpZG4ndCwgdGhlbiBkb24n
dCB1cGRhdGUgdGhlIG5ldyB0aW1lb3V0Lg0KPiBWYWx1ZSBpcyB1cGRhdGVkIGJhc2VkIG9uIHRo
ZSBwcmV2aW91cyB2YWx1ZSB0byBtYWtlIHRpbWVvdXRzDQo+IHByZWRpY3RhYmxlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+IC0t
LQ0KPiAgaW5jbHVkZS9saW51eC9zdW5ycGMveHBydC5oIHwgMSArDQo+ICBuZXQvc3VucnBjL3hw
cnQuYyAgICAgICAgICAgfCA5ICsrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdW5ycGMveHBydC5o
DQo+IGIvaW5jbHVkZS9saW51eC9zdW5ycGMveHBydC5oDQo+IGluZGV4IGU2NGJkODIuLmE2MDNk
NDggMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnQuaA0KPiArKysgYi9p
bmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0LmgNCj4gQEAgLTEwMSw2ICsxMDEsNyBAQCBzdHJ1Y3Qg
cnBjX3Jxc3Qgew0KPiAgCQkJCQkJCSAqIHVzZWQgaW4gdGhlDQo+IHNvZnRpcnEuDQo+ICAJCQkJ
CQkJICovDQo+ICAJdW5zaWduZWQgbG9uZwkJcnFfbWFqb3J0aW1lbzsJLyogbWFqb3IgdGltZW91
dA0KPiBhbGFybSAqLw0KPiArCXVuc2lnbmVkIGxvbmcJCXJxX21pbm9ydGltZW87CS8qIG1pbm9y
IHRpbWVvdXQNCj4gYWxhcm0gKi8NCj4gIAl1bnNpZ25lZCBsb25nCQlycV90aW1lb3V0OwkvKiBD
dXJyZW50IHRpbWVvdXQNCj4gdmFsdWUgKi8NCj4gIAlrdGltZV90CQkJcnFfcnR0OwkJLyogcm91
bmQtdHJpcCB0aW1lICovDQo+ICAJdW5zaWduZWQgaW50CQlycV9yZXRyaWVzOwkvKiAjIG9mIHJl
dHJpZXMgKi8NCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydC5jIGIvbmV0L3N1bnJwYy94
cHJ0LmMNCj4gaW5kZXggZDVjYzVkYi4uNmJhOWQ1OCAxMDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJw
Yy94cHJ0LmMNCj4gKysrIGIvbmV0L3N1bnJwYy94cHJ0LmMNCj4gQEAgLTYwNyw2ICs2MDcsMTEg
QEAgc3RhdGljIHZvaWQgeHBydF9yZXNldF9tYWpvcnRpbWVvKHN0cnVjdA0KPiBycGNfcnFzdCAq
cmVxKQ0KPiAgCXJlcS0+cnFfbWFqb3J0aW1lbyArPSB4cHJ0X2NhbGNfbWFqb3J0aW1lbyhyZXEp
Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCB4cHJ0X3Jlc2V0X21pbm9ydGltZW8oc3RydWN0
IHJwY19ycXN0ICpyZXEpDQo+ICt7DQo+ICsJcmVxLT5ycV9taW5vcnRpbWVvICs9IHJlcS0+cnFf
dGltZW91dDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgeHBydF9pbml0X21ham9ydGltZW8o
c3RydWN0IHJwY190YXNrICp0YXNrLCBzdHJ1Y3QNCj4gcnBjX3Jxc3QgKnJlcSkNCj4gIHsNCj4g
IAl1bnNpZ25lZCBsb25nIHRpbWVfaW5pdDsNCj4gQEAgLTYxOCw2ICs2MjMsNyBAQCBzdGF0aWMg
dm9pZCB4cHJ0X2luaXRfbWFqb3J0aW1lbyhzdHJ1Y3QgcnBjX3Rhc2sNCj4gKnRhc2ssIHN0cnVj
dCBycGNfcnFzdCAqcmVxKQ0KPiAgCQl0aW1lX2luaXQgPSB4cHJ0X2Fic19rdGltZV90b19qaWZm
aWVzKHRhc2stPnRrX3N0YXJ0KTsNCj4gIAlyZXEtPnJxX3RpbWVvdXQgPSB0YXNrLT50a19jbGll
bnQtPmNsX3RpbWVvdXQtPnRvX2luaXR2YWw7DQo+ICAJcmVxLT5ycV9tYWpvcnRpbWVvID0gdGlt
ZV9pbml0ICsgeHBydF9jYWxjX21ham9ydGltZW8ocmVxKTsNCj4gKwlyZXEtPnJxX21pbm9ydGlt
ZW8gPSB0aW1lX2luaXQgKyByZXEtPnJxX3RpbWVvdXQ7DQo+ICB9DQo+ICANCj4gIC8qKg0KPiBA
QCAtNjMxLDYgKzYzNyw4IEBAIGludCB4cHJ0X2FkanVzdF90aW1lb3V0KHN0cnVjdCBycGNfcnFz
dCAqcmVxKQ0KPiAgCWNvbnN0IHN0cnVjdCBycGNfdGltZW91dCAqdG8gPSByZXEtPnJxX3Rhc2st
PnRrX2NsaWVudC0NCj4gPmNsX3RpbWVvdXQ7DQo+ICAJaW50IHN0YXR1cyA9IDA7DQo+ICANCj4g
KwlpZiAodGltZV9iZWZvcmUoamlmZmllcywgcmVxLT5ycV9taW5vcnRpbWVvKSkNCj4gKwkJcmV0
dXJuIHN0YXR1czsNCj4gIAlpZiAodGltZV9iZWZvcmUoamlmZmllcywgcmVxLT5ycV9tYWpvcnRp
bWVvKSkgew0KPiAgCQlpZiAodG8tPnRvX2V4cG9uZW50aWFsKQ0KPiAgCQkJcmVxLT5ycV90aW1l
b3V0IDw8PSAxOw0KPiBAQCAtNjQ5LDYgKzY1Nyw3IEBAIGludCB4cHJ0X2FkanVzdF90aW1lb3V0
KHN0cnVjdCBycGNfcnFzdCAqcmVxKQ0KPiAgCQlzcGluX3VubG9jaygmeHBydC0+dHJhbnNwb3J0
X2xvY2spOw0KPiAgCQlzdGF0dXMgPSAtRVRJTUVET1VUOw0KPiAgCX0NCj4gKwl4cHJ0X3Jlc2V0
X21pbm9ydGltZW8ocmVxKTsNCj4gIA0KPiAgCWlmIChyZXEtPnJxX3RpbWVvdXQgPT0gMCkgew0K
PiAgCQlwcmludGsoS0VSTl9XQVJOSU5HICJ4cHJ0X2FkanVzdF90aW1lb3V0OiBycV90aW1lb3V0
ID0NCj4gMCFcbiIpOw0KDQpUaGlzIHZlcnNpb24gbG9va3MgZ29vZCB0byBnbyB0byBtZS4gVGhh
bmtzIE9sZ2EhDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
