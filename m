Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E071394699
	for <lists+linux-nfs@lfdr.de>; Fri, 28 May 2021 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhE1RnN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 May 2021 13:43:13 -0400
Received: from mail-bn8nam12on2113.outbound.protection.outlook.com ([40.107.237.113]:20960
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhE1RnN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 May 2021 13:43:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fstW3UagvFxGIsnK5B/Zg37MnuOP3u5GvWC5DkIxhtCWiHl4q+wlDIUHlBR6S26+vDpCiuJqQRUaUWfSs+mJ9NdTpvsL2WB0FpdSrNbXgpyMmWQ++qimYA7ugSS5ywCZgm8Gb0a09pDRSPyyHaXIACfsjdrAkjen4bzlrRSP4KsW6YutboY3eAR3PZfiDgDTPwce9nDsXHKZgWSxAj+D1gol96/aeSafujweGji1fqY+ioix+62hBNm1qd4JXCmqkCHH1y4csnsoz4c7puKrxZPiOgVXg7Wp8G/RGxMO09Xh/r0ug/EvxyAgT2IBbnf5SLnVhZ6gTkNOlNMPbojWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiwNm1GLn0CKrHTpBSY/5UVvOqsUee8vpg7dNc/svAM=;
 b=exMp1FTn5UFEJsdw4kdabYVVTddsg3Gog2nqgDZUqTJSfjOdMaHPFU0+nFHtSLaRD4Wm1SCBlSw8Dc5VNgdF+jMQFSKJIkdZYZ+N1H0ErJoYQzu132Y354OJ36ytUUuKkX9jp+YkJME5lC5EbDCJ13YA1XFR9xYf1fMzMWPu/q5zfpNhonpKtDIoY5ckIzAB2WGsU1YXq+TM7lHcL2Urp8n4EFWOgRz7sW5sy1jYgB3eoLk3g0q/x8CglGRYAeszZoTNIXgAJVWUDSfd4uo5tff5bo122xvephUkV9CDYJ+YFnOCD4W0JkCEYibEjVx0KaCxFKMvoTYP2aVptYgNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiwNm1GLn0CKrHTpBSY/5UVvOqsUee8vpg7dNc/svAM=;
 b=csUcVUWDwkavaAZyySHQGIiu+6PoAGEMFln2TCwxpiU/K6QqkdVyBocAfvNHWmMZOHt7RWzEjvmmq6bRTH1SnZgNLUqd3r0Yb5RAmkOvad4sSuVbM+efRBoUr7Q/WP507OfWNXEYACKfESWISat/Fhidl4dI7rNxopIKwxKLDcI=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB1723.namprd13.prod.outlook.com (2603:10b6:3:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.11; Fri, 28 May
 2021 17:41:24 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4195.011; Fri, 28 May 2021
 17:41:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSv4: nfs4_proc_set_acl needs to restore
 NFS_CAP_UIDGID_NOMAP on error.
Thread-Topic: [PATCH v2 1/1] NFSv4: nfs4_proc_set_acl needs to restore
 NFS_CAP_UIDGID_NOMAP on error.
Thread-Index: AQHXTPQULK4Vxz5yo0GK1913tZbI86r5NHKAgAAC/gA=
Date:   Fri, 28 May 2021 17:41:23 +0000
Message-ID: <7ebfc2c9dc69bd44836bdf7c9c96d9b915b76d4c.camel@hammerspace.com>
References: <20210519211510.60253-1-dai.ngo@oracle.com>
         <f019e70d-d677-b0b7-3ac0-8f374430804e@oracle.com>
In-Reply-To: <f019e70d-d677-b0b7-3ac0-8f374430804e@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [50.36.171.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf21e9d2-361a-4abd-ec62-08d921ffd02b
x-ms-traffictypediagnostic: DM5PR13MB1723:
x-microsoft-antispam-prvs: <DM5PR13MB172303D469113E1CD1708268B8229@DM5PR13MB1723.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HnW2dfZRHXGKuY1pSsNoCMfDWfZys38gzv0cxG5wAioW88wVarHwAk/hLGIN+j0v4fqZkSawCdr1cbfM5FC63Q80Av39f5qOcDDeEFLFJer1VUTsS+8CSSc5UntTQj1opPwuaDeSGPHXNIfwf72f1NUeJBkUiYhBFXpZ/KB+fB/l5JVotdKmpyh/lfaSceSSjo47joIwR47hMAibuDatgK3sUNdRAjDD7T9BkCJMiK2iSHEXUDZjsBbP6CUVfXeAevtBJq71lQ23vzCwVPsSv3Jzyv8sWtjNwzhdx9UW/WrCKZrQslzpKf64qG2Yn1c32nHS2P7UAWFSVvSQdUqoZIwkkO9LJ6buFYy53dM5iqIouc/h8ZIOSK4HVI6O7mKSzI/HpHoNHiJsx8Vy7N07PS1XrgFAO/kppFpukPK3Z0YeSxTd+EZMLwkxebdxavh3V05vq/aseoV74Vz1Tsd4hd8NRyI2Eq+1n/nPfNBZ3yMfGwlF+Rqv2vm7ui6SuanY+yFYD/DFsGFwkIlew2Gc8uZDSahA0ucYKWU/0IaSJ8X7Zkadbal44kBLqRETpUkw1o9HUwgHPukJx39oISRfd9O3VExLvUGRBoT2pwMH9JU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(376002)(346002)(396003)(366004)(2906002)(36756003)(38100700002)(122000001)(83380400001)(478600001)(26005)(8676002)(316002)(4326008)(71200400001)(6486002)(8936002)(66946007)(6512007)(5660300002)(66556008)(64756008)(6506007)(66476007)(53546011)(76116006)(91956017)(186003)(6916009)(86362001)(2616005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eDBEOE1RRUtCQkRwQ2FBUkU4VG1xa2xEYVBKeUMxekRNNjI3YWtmQ3JldVZq?=
 =?utf-8?B?M3dWN1lyTlpDYS9lRWJzblRUMkRaTlVZZTZSOVczK0pFQnN3clZjc29qM2FY?=
 =?utf-8?B?Yjg0NGQ3ZEtGVE43eFhHRFdGWVMwWHRqUTFsRVVTYXV5TVZmUmNRbUJCYW5m?=
 =?utf-8?B?aUlUdW5lT0xOZGFmdjFOeVFCNU41S1RwRFhyaTcvbVhHUWdZRmlBOWlaOTV5?=
 =?utf-8?B?TTI4dzI3V0lyYTg5aEUvK0xVNFllVFd2Q3N6aVM4TmlRdWRGQ1BwenVPUE9h?=
 =?utf-8?B?Rjg4SWdITFd5M3dEUGZ4aCs1SzZtZTN1QWFMK1VRUlJLNk9MTjBEVEdXT2o1?=
 =?utf-8?B?bzF6bW9HdTJPc2FEbmw2OVdDMk1QYkFvelVQeUJGVHc2c0h3M2E4MTFkaWQ5?=
 =?utf-8?B?UlNiZ1lFTTFwWnJhK1VqSTNDYnR6S00vVmQ2dERCQisxM0JMT2xQblNXQ0RF?=
 =?utf-8?B?OCs0aE41NS8vVEhDOW1hM0FYNTFqbDVqUngvQnZadTlpV0gyT2ZHdm9PV3JY?=
 =?utf-8?B?TldvazA5Rnl3YzNZOXpwSHB0Ym1yTzhlQ2NHNHJNNW45a3NBQ1ZybWtXbWp3?=
 =?utf-8?B?TFdCK1RyQU1DYTM4R3U3K0JRUGMrcWo4UmRzV2tlZlAvS2F4aytZZVlybmNL?=
 =?utf-8?B?N3NJSzA1dGlhMzllUkdXQWM0eFRVRmY4VUJBOU8wTXpwOGNJVTBDakRQTjNz?=
 =?utf-8?B?ZEVIaFVpRERiNlVXZ0kwNCtpbVdGamFUdjE0RS9NbWtMMEIyODE4TVd2YjVZ?=
 =?utf-8?B?R0grZEVQNHIvQm9XRWpDbjAzbFVIWnM5ak1BN253YWVXcUxWOWNZQW4rcWZX?=
 =?utf-8?B?OVRXaHNUYUJXdUxnQTZmU1FPOWpIT3hNeCtxR1Q3aG91Y296TFQ4MnM1MUE0?=
 =?utf-8?B?dE40WnZNRWN1a0JlS2ZMbFNkbmZQOFU1RG43VzR4Z0lraDg0OGR1b1BIRWxa?=
 =?utf-8?B?RmtRS1dQelVLcHAyb3NWWnFzd1B0bG56c2J4UXltc3dGaFdFTThnVFM0aTBE?=
 =?utf-8?B?QTVsdkhDTXN2Tk5SMXhhbUZwTzN1VnJvZ1UvRWFCQlo5UzJ4MFVtbE13ZjZn?=
 =?utf-8?B?RllJWWNwWXdhNkxHV1NqVklEU1JtWUJaT1grOSsvMWVJMVY2WElTVVJnZzBV?=
 =?utf-8?B?aVljTWlMM0lSQUJkanhwZDMxYzRLQzdjdVcvZlJzYmk0RERvbFJiU0x3a09X?=
 =?utf-8?B?ZmduODYxMm1kT3hwQ1FmbzQxMjMvYWltUGZWQ2hzNUI3ZC91U3hRdGpidis0?=
 =?utf-8?B?SWUxMkgyZUVyajQraWpzWlBHd01Xa05HTWlqc2dqQ3pGeHpJajM3elZFU3Ir?=
 =?utf-8?B?VXdKeGxMSXRwL3l6QUN3VVB2cU9ubTZ4SUZNc2pCVnF6SU1WK1BaQ1ZRMGFj?=
 =?utf-8?B?Ui8vWFFhQVYzZ1JEcGtYbEUwVThiTndHVldtUXlrOU1oMWNvUkZieFQ0L1Zm?=
 =?utf-8?B?SGhKejBibisvUnBiSmdvTW5wZmdIRUE0a1JSY1dtZlhoVWZLbTZqL0I3NmFN?=
 =?utf-8?B?bUh5QWFDMTVBZlo2OHBKTndFMWI5Ui9lc0ZWZERFYXIyQm9INksxcEpDeVBE?=
 =?utf-8?B?ZUMrRjQrWmFuRlJvSlFRZGFYRjVjQ3Yza2tPVVdHSno3QkN4ZmJJckk1ajM2?=
 =?utf-8?B?eUhiMVhOeHk3aXhxZUpZaFhVemdqK0twUk5TWUx5bzRzNHZzcThOYkk3bG1D?=
 =?utf-8?B?eVVIeHVVSGo4MDBrSGtTWjlDTmVMYVhjQmQ0alBEbGY3U3BGaHZIMThpc2t5?=
 =?utf-8?Q?BibRST1DHlhj1/KimyHgbIqSPmAHhW3ac6Xw7pl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <32EADA0CCF42A94FBA291B13EB13103B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf21e9d2-361a-4abd-ec62-08d921ffd02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 17:41:24.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWEFEKStG0RohRaJt63ssG6gfgoXAiviNjBMe9YEWLGYdgF8PQRbKheqRSjRorHP6ROiVZhaSvgXK0YadcpAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1723
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA1LTI4IGF0IDEwOjMwIC0wNzAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6DQo+IEhpIFRyb25kLA0KPiANCj4gSnVzdCBhIHJlbWluZGVyIHRoYXQgdGhpcyBwYXRjaCBp
cyByZWFkeSBmb3IgeW91ciByZXZpZXcuDQoNClNvcnJ5LiBJIG1pc3NlZCB0aGF0IHVwZGF0ZSBm
b3Igc29tZSByZWFzb24uDQoNCj4gDQo+IFRoYW5rcywNCj4gLURhaQ0KPiANCj4gT24gNS8xOS8y
MSAyOjE1IFBNLCBEYWkgTmdvIHdyb3RlOg0KPiA+IEN1cnJlbnRseSBpZiBfX25mczRfcHJvY19z
ZXRfYWNsIGZhaWxzIHdpdGggTkZTNEVSUl9CQURPV05FUiBpdA0KPiA+IHJlLWVuYWJsZXMgdGhl
IGlkbWFwcGVyIGJ5IGNsZWFyaW5nIE5GU19DQVBfVUlER0lEX05PTUFQIGJlZm9yZQ0KPiA+IHJl
dHJ5aW5nIGFnYWluLiBUaGUgTkZTX0NBUF9VSURHSURfTk9NQVAgcmVtYWlucyBjbGVhcmVkIGV2
ZW4gaWYNCj4gPiB0aGUgcmV0cnkgZmFpbHMuIFRoaXMgY2F1c2VzIHByb2JsZW0gZm9yIHN1YnNl
cXVlbnQgc2V0YXR0cg0KPiA+IHJlcXVlc3RzIGZvciB2NCBzZXJ2ZXIgdGhhdCBkb2VzIG5vdCBo
YXZlIGlkbWFwcGluZyBjb25maWd1cmVkLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggbW9kaWZpZXMg
bmZzNF9wcm9jX3NldF9hY2wgdG8gZGV0ZWN0IE5GUzRFUlJfQkFET1dORVINCj4gPiBhbmQgTkZT
NEVSUl9CQUROQU1FIGFuZCBza2lwcyB0aGUgcmV0cnksIHNpbmNlIHRoZSBrZXJuZWwgaXNuJ3QN
Cj4gPiBpbnZvbHZlZCBpbiBlbmNvZGluZyB0aGUgQUNFcywgYW5kIHJldHVybiAtRUlOVkFMLg0K
PiA+IA0KPiA+IFN0ZXBzIHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbToNCj4gPiANCj4gPiDCoCAj
IG1vdW50IC1vIHZlcnM9NC4xLHNlYz1zeXMgc2VydmVyOi9leHBvcnQvdGVzdCAvdG1wL21udA0K
PiA+IMKgICMgdG91Y2ggL3RtcC9tbnQvZmlsZTENCj4gPiDCoCAjIGNob3duIDk5IC90bXAvbW50
L2ZpbGUxDQo+ID4gwqAgIyBuZnM0X3NldGZhY2wgLWEgQTo6dW5rbm93bi51c2VyQHh5ei5jb206
d3J0bmN5IC90bXAvbW50L2ZpbGUxDQo+ID4gwqAgRmFpbGVkIHNldHhhdHRyIG9wZXJhdGlvbjog
SW52YWxpZCBhcmd1bWVudA0KPiA+IMKgICMgY2hvd24gOTkgL3RtcC9tbnQvZmlsZTENCj4gPiDC
oCBjaG93bjogY2hhbmdpbmcgb3duZXJzaGlwIG9mIOKAmC90bXAvbW50L2ZpbGUx4oCZOiBJbnZh
bGlkIGFyZ3VtZW50DQo+ID4gwqAgIyB1bW91bnQgL3RtcC9tbnQNCj4gPiDCoCAjIG1vdW50IC1v
IHZlcnM9NC4xLHNlYz1zeXMgc2VydmVyOi9leHBvcnQvdGVzdCAvdG1wL21udA0KPiA+IMKgICMg
Y2hvd24gOTkgL3RtcC9tbnQvZmlsZTENCj4gPiDCoCAjDQo+ID4gDQo+ID4gdjI6IGRldGVjdCBO
RlM0RVJSX0JBRE9XTkVSIGFuZCBORlM0RVJSX0JBRE5BTUUgYW5kIHNraXAgcmV0cnkNCj4gPiDC
oMKgwqDCoMKgwqDCoCBpbiBuZnM0X3Byb2Nfc2V0X2FjbC4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBE
YWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+DQo+ID4gLS0tDQo+ID4gwqAgZnMvbmZzL25mczRw
cm9jLmMgfCA4ICsrKysrKysrDQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0
cHJvYy5jDQo+ID4gaW5kZXggODdkMDRmMmM5Mzg1Li40ZTA1MmM3ZjA2MTQgMTAwNjQ0DQo+ID4g
LS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4gPiArKysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiA+
IEBAIC01OTY4LDYgKzU5NjgsMTQgQEAgc3RhdGljIGludCBuZnM0X3Byb2Nfc2V0X2FjbChzdHJ1
Y3QgaW5vZGUNCj4gPiAqaW5vZGUsIGNvbnN0IHZvaWQgKmJ1Ziwgc2l6ZV90IGJ1Zmxlbg0KPiA+
IMKgwqDCoMKgwqDCoMKgwqBkbyB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBlcnIgPSBfX25mczRfcHJvY19zZXRfYWNsKGlub2RlLCBidWYsIGJ1Zmxlbik7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0cmFjZV9uZnM0X3NldF9hY2woaW5vZGUsIGVy
cik7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChlcnIgPT0gLU5GUzRF
UlJfQkFET1dORVIgfHwgZXJyID09IC0NCj4gPiBORlM0RVJSX0JBRE5BTUUpIHsNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBubyBuZWVkIHRvIHJl
dHJ5IHNpbmNlIHRoZSBrZXJuZWwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIGlzbid0IGludm9sdmVkIGluIGVuY29kaW5nIHRoZSBBQ0VzLg0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIgPSAt
RUlOVkFMOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYnJlYWs7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IG5mczRfaGFuZGxlX2V4Y2VwdGlvbihO
RlNfU0VSVkVSKGlub2RlKSwgZXJyLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAmZXhjZXB0aW9uKTsNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgfSB3aGlsZSAoZXhjZXB0aW9uLnJldHJ5KTsNCg0KWWVzLCB0aGlzIGxvb2tz
IE9LLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
