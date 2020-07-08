Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B6218C69
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgGHQAE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 12:00:04 -0400
Received: from mail-eopbgr770110.outbound.protection.outlook.com ([40.107.77.110]:57287
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730179AbgGHQAD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 Jul 2020 12:00:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbptcTmYApnpthxTe+6jNumqdTwBbNcOHH4LC2hTvsUp8BnXr9tuq1BZmpJIjRuzjTd39DJjuEU5kQXWHlgYKZ2XS2sNcZjc076s8s2eyNZEM2IdZYwY+1pmcqlgBdMnf1kuFwfNuNJbZmW/qsnacJmawB2MrCWFXhWZFfAF5JbLScMEiHuS1/Id0O73isEn+olUFR6+PkftXur1e9GUcVxqi5fR5sIY1PNxQp+TzoPlmifgW+U00oB/gsgvqkXaDSqqWU3A9r6d6cAzcvpFtRnAeOr9Yv/b7t+Cb0W8uh5sFhKA9s3XPz8ZKAODL8EFhxA8yY30j1jJOSv5c7X3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJCk0TPrvojhpbJeBbT12ZajnPwlGCARoIWZf7E8xOE=;
 b=MSVv7t3P32zTb8qc7IsfhjJjob4AyZipMYw5eTkkfqmqkIgfHurwIxMN2Z/wWmK+96i7Jn2FlQ9bHx1PpdGkwGjBsr5L7li/J4dHdbeG2yrSX9vPSVvJLhFtTBpiclm0R0y0nkn7ui7nilhPT26kSdr1Y3CP865irBaTIXiEUs8r+pIpgD/bzQ+siFyZkR+fNitf1NmaLAocqmMK1Zo92WpxnNLH2618TZ1cuAwy75gzRaM9q2NPO6axFM9kZmT2hGLwPKqee3pbfpTthrOIGXQGunMTdW6yRgFSA5omvdV7TiwtSdd0PNO6udwIKRsUYVbc/H62200Jcal7DlHt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJCk0TPrvojhpbJeBbT12ZajnPwlGCARoIWZf7E8xOE=;
 b=H6EOtoJOmVR8G0Y8GYB3xwePhW6MLFkCRF9aaMUcvuIOoBuwHXL+n1+lHu2BBNFIETNYjUfigUTozC4ZCpiv8yeTm1nyM9G5lPDVhkA2VzOnmS9f2aiuq7xuGVvq1u1A/ihqtQ/m7LPYCkykBc3VZ1uwwEy6WhTWLYDhtTuTycI=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3799.namprd13.prod.outlook.com (2603:10b6:610:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.14; Wed, 8 Jul
 2020 15:59:59 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 15:59:59 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH v1 1/1] NFS: Fix interrupted slots by sending a solo
 SEQUENCE operation
Thread-Topic: [PATCH v1 1/1] NFS: Fix interrupted slots by sending a solo
 SEQUENCE operation
Thread-Index: AQHWVT9/VOfEi2eJpk6jNF/llCNILKj91yWA
Date:   Wed, 8 Jul 2020 15:59:59 +0000
Message-ID: <25e89e208bd3c6e44f8041d64c96be238b78c3b6.camel@hammerspace.com>
References: <20200708155018.110150-1-Anna.Schumaker@Netapp.com>
         <20200708155018.110150-2-Anna.Schumaker@Netapp.com>
In-Reply-To: <20200708155018.110150-2-Anna.Schumaker@Netapp.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [50.36.87.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9556ee9a-290c-4f0b-f7f6-08d82357f773
x-ms-traffictypediagnostic: CH2PR13MB3799:
x-microsoft-antispam-prvs: <CH2PR13MB379902140A1EB0C7B0F88832B8670@CH2PR13MB3799.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2IEEewrjIjOIlFHSQk1cTeK6aOzxGSA2XQxURMoigySgyIIrYmOC9xxWescKYFlaklQBOiEAXcJYltBnpo4K7Q0juH3EE9iwxGdH8FdUd0iB6Z5NHQKmYtgfUWhocCzabotLsECu+IxsuGgvN8MTxhDo0XkIDyiKaTpudYje0Io85TjFJBGd9AcX/NQvfZxK3MqSy6pRAG2q+VM0piNtX65GMe2ejB603h/U6O4r/B/akLYCQyuoEKkLbrTD62STBSauw0+FbQEi8TykbF4tD+znai9XJ+mQuvEeBHVzf0qsJNQ1qIgHouvuOTYNohI4w2HHvv4zTcuL4f0EIrO76+Bnhj+mTg84MbfEa6dbumf1ZfD48ICl208b6jC6Dfq830rk2XMeB0EAByV5whBLlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39830400003)(136003)(396003)(346002)(376002)(8676002)(71200400001)(2906002)(5660300002)(83380400001)(2616005)(6486002)(316002)(4326008)(66946007)(91956017)(6506007)(76116006)(8936002)(86362001)(26005)(66476007)(66556008)(64756008)(66446008)(110136005)(6512007)(36756003)(186003)(15974865002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EeXILjEzcyFT+YvETiO78ydk1/OSX33VPNwsKt6gnMeDXAe3hHNphsmG6tPSi7t2jhfl+Fz/CDBSMQ7wu0HUTHBDpmSVKL14WEAMfEP+8WwhYNYA+K6Gou48KLFisHEhhPvTbTekX+KiUXlAtZxpwKat38swWK1MKB1lvIblF2+/ovVx2qLau5yd4UH0M1eKMA5OGvBArI3Dd36cOQCKza+9Wn0g/a5FrBdqdroXtajz4hwq7GZziTy+zC26wJnKcOdE+kB4lekRPUTtgZbcKorufUeiaD0S0MpAIq4nlqgeLO4XyPMi8tBalbnv59scrIlxnkDOfuWvCA7K+xxj49YSzf6nSxqKd/lhOmU0iT7heMWmgE3ifBBkXXwDgRfaS+9/a9QubJSyLoTDQiSSyhoSWrWlSaZRmLYd3Nz90HfEpZDl16GtVAjKRBjSc3AVJ8lehiqPl1GIvT+ND6ewuzO4PHq8vzrnUExchgUOeR8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DBC608AB3DA194B8C9AC35008E091CF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9556ee9a-290c-4f0b-f7f6-08d82357f773
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 15:59:59.1165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3kVgj9eFGBpfv2I+OGSuhSDlg2V9Z0Wg/OoJCgjf0Yox5elMDXMI4km0Aj1fhDrwRmvZXBS3Uoo1lqA67It9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3799
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTA4IGF0IDExOjUwIC0wNDAwLCBzY2h1bWFrZXIuYW5uYUBnbWFpbC5j
b20gd3JvdGU6DQo+IEZyb206IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAu
Y29tPg0KPiANCj4gV2UgdXNlZCB0byBkbyB0aGlzIGJlZm9yZSAzNDUzZDU3MDhiMzMsIGJ1dCB0
aGlzIHdhcyBjaGFuZ2VkIHRvDQo+IGJldHRlcg0KPiBoYW5kbGUgdGhlIE5GUzRFUlJfU0VRX01J
U09SREVSRUQgZXJyb3IgY29kZS4gVGhpcyBjb21taXQgZml4ZWQgdGhlDQo+IHNsb3QNCj4gcmUt
dXNlIGNhc2Ugd2hlbiB0aGUgc2VydmVyIGRvZXNuJ3QgcmVjZWl2ZSB0aGUgaW50ZXJydXB0ZWQN
Cj4gb3BlcmF0aW9uLA0KPiBidXQgaWYgdGhlIHNlcnZlciBkb2VzIHJlY2VpdmUgdGhlIG9wZXJh
dGlvbiB0aGVuIGl0IGNvdWxkIHN0aWxsIGVuZA0KPiB1cA0KPiByZXBseWluZyB0byB0aGUgY2xp
ZW50IHdpdGggbWlzLW1hdGNoZWQgb3BlcmF0aW9ucyBmcm9tIHRoZSByZXBseQ0KPiBjYWNoZS4N
Cj4gDQo+IFdlIGNhbiBmaXggdGhpcyBieSBzZW5kaW5nIGEgU0VRVUVOQ0UgdG8gdGhlIHNlcnZl
ciB3aGlsZSByZWNvdmVyaW5nDQo+IGZyb20NCj4gYSBTRVFfTUlTT1JERVJFRCBlcnJvciB3aGVu
IHdlIGRldGVjdCB0aGF0IHdlIGFyZSBpbiBhbiBpbnRlcnJ1cHRlZA0KPiBzbG90DQo+IHNpdHVh
dGlvbi4NCj4gDQo+IEZpeGVzOiAzNDUzZDU3MDhiMzMgKE5GU3Y0LjE6IEF2b2lkIGZhbHNlIHJl
dHJpZXMgd2hlbiBSUEMgY2FsbHMgYXJlDQo+IGludGVycnVwdGVkKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBwLmNvbT4NCj4gLS0tDQo+ICBm
cy9uZnMvbmZzNHByb2MuYyB8IDE3ICsrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9m
cy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IGluZGV4IGUzMjcxN2ZkMTE2
OS4uNWRlNDFhNTc3MmYwIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiArKysg
Yi9mcy9uZnMvbmZzNHByb2MuYw0KPiBAQCAtNzc0LDYgKzc3NCwxNCBAQCBzdGF0aWMgdm9pZCBu
ZnM0X3Nsb3Rfc2VxdWVuY2VfYWNrZWQoc3RydWN0DQo+IG5mczRfc2xvdCAqc2xvdCwNCj4gIAlz
bG90LT5zZXFfbnJfbGFzdF9hY2tlZCA9IHNlcW5yOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9p
ZCBuZnM0X3Byb2JlX3NlcXVlbmNlKHN0cnVjdCBuZnNfY2xpZW50ICpjbGllbnQsIGNvbnN0DQo+
IHN0cnVjdCBjcmVkICpjcmVkLA0KPiArCQkJCXN0cnVjdCBuZnM0X3Nsb3QgKnNsb3QpDQo+ICt7
DQo+ICsJc3RydWN0IHJwY190YXNrICp0YXNrID0gX25mczQxX3Byb2Nfc2VxdWVuY2UoY2xpZW50
LCBjcmVkLA0KPiBzbG90LCB0cnVlKTsNCj4gKwlpZiAoIUlTX0VSUih0YXNrKSkNCj4gKwkJcnBj
X3dhaXRfZm9yX2NvbXBsZXRpb25fdGFzayh0YXNrKTsNCg0KSG1tLi4uIEkgYW0gYSBsaXR0bGUg
Y29uY2VybmVkIGFib3V0IHRoZSB3YWl0IGhlcmUsIHNpbmNlIHdlIGRvbid0IGtub3cNCndoYXQg
a2luZCBvZiB0aHJlYWQgdGhpcyBpcy4NCg0KQW55IGNoYW5jZSB3ZSBjb3VsZCBraWNrIG9mZiBh
IF9uZnM0MV9wcm9jX3NlcXVlbmNlIGFzeW5jaHJvbm91c2x5LCBhbmQNCnRoZW4gcGVyaGFwcyBy
ZXF1ZXVlIHRoZSBvcmlnaW5hbCB0YXNrIHRvIHdhaXQgZm9yIHRoZSBuZXh0IGZyZWUgc2xvdD8g
DQpJIHN1cHBvc2Ugb25lIGlzc3VlIHRoZXJlIHdvdWxkIGJlIGlmIHRoZSAnb3JpZ2luYWwgdGFz
ayBpcyBhbiBlYXJsaWVyDQpjYWxsIHRvIF9uZnM0MV9wcm9jX3NlcXVlbmNlLCBidXQgcGVyaGFw
cyB0aGF0IGNhbiBiZSB3b3JrZWQgYXJvdW5kPw0KDQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQg
bmZzNDFfc2VxdWVuY2VfcHJvY2VzcyhzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2ssDQo+ICAJCXN0cnVj
dCBuZnM0X3NlcXVlbmNlX3JlcyAqcmVzKQ0KPiAgew0KPiBAQCAtNzkwLDYgKzc5OCw3IEBAIHN0
YXRpYyBpbnQgbmZzNDFfc2VxdWVuY2VfcHJvY2VzcyhzdHJ1Y3QgcnBjX3Rhc2sNCj4gKnRhc2ss
DQo+ICAJCWdvdG8gb3V0Ow0KPiAgDQo+ICAJc2Vzc2lvbiA9IHNsb3QtPnRhYmxlLT5zZXNzaW9u
Ow0KPiArCWNscCA9IHNlc3Npb24tPmNscDsNCj4gIA0KPiAgCXRyYWNlX25mczRfc2VxdWVuY2Vf
ZG9uZShzZXNzaW9uLCByZXMpOw0KPiAgDQo+IEBAIC04MDQsNyArODEzLDYgQEAgc3RhdGljIGlu
dCBuZnM0MV9zZXF1ZW5jZV9wcm9jZXNzKHN0cnVjdCBycGNfdGFzaw0KPiAqdGFzaywNCj4gIAkJ
bmZzNF9zbG90X3NlcXVlbmNlX2Fja2VkKHNsb3QsIHNsb3QtPnNlcV9ucik7DQo+ICAJCS8qIFVw
ZGF0ZSB0aGUgc2xvdCdzIHNlcXVlbmNlIGFuZCBjbGllbnRpZCBsZWFzZSB0aW1lcg0KPiAqLw0K
PiAgCQlzbG90LT5zZXFfZG9uZSA9IDE7DQo+IC0JCWNscCA9IHNlc3Npb24tPmNscDsNCj4gIAkJ
ZG9fcmVuZXdfbGVhc2UoY2xwLCByZXMtPnNyX3RpbWVzdGFtcCk7DQo+ICAJCS8qIENoZWNrIHNl
cXVlbmNlIGZsYWdzICovDQo+ICAJCW5mczQxX2hhbmRsZV9zZXF1ZW5jZV9mbGFnX2Vycm9ycyhj
bHAsIHJlcy0NCj4gPnNyX3N0YXR1c19mbGFncywNCj4gQEAgLTg1MiwxMCArODYwLDE1IEBAIHN0
YXRpYyBpbnQgbmZzNDFfc2VxdWVuY2VfcHJvY2VzcyhzdHJ1Y3QNCj4gcnBjX3Rhc2sgKnRhc2ss
DQo+ICAJCS8qDQo+ICAJCSAqIFdlcmUgb25lIG9yIG1vcmUgY2FsbHMgdXNpbmcgdGhpcyBzbG90
IGludGVycnVwdGVkPw0KPiAgCQkgKiBJZiB0aGUgc2VydmVyIG5ldmVyIHJlY2VpdmVkIHRoZSBy
ZXF1ZXN0LCB0aGVuIG91cg0KPiAtCQkgKiB0cmFuc21pdHRlZCBzbG90IHNlcXVlbmNlIG51bWJl
ciBtYXkgYmUgdG9vIGhpZ2guDQo+ICsJCSAqIHRyYW5zbWl0dGVkIHNsb3Qgc2VxdWVuY2UgbnVt
YmVyIG1heSBiZSB0b28gaGlnaC4NCj4gSG93ZXZlciwNCj4gKwkJICogaWYgdGhlIHNlcnZlciBk
aWQgcmVjZWl2ZSB0aGUgcmVxdWVzdCB0aGVuIGl0IG1pZ2h0DQo+ICsJCSAqIGFjY2lkZW50YWxs
eSBnaXZlIHVzIGEgcmVwbHkgd2l0aCBhIG1pc21hdGNoZWQNCj4gb3BlcmF0aW9uLg0KPiArCQkg
KiBXZSBjYW4gc29ydCB0aGlzIG91dCBieSBzZW5kaW5nIGEgbG9uZSBzZXF1ZW5jZQ0KPiBvcGVy
YXRpb24NCj4gKwkJICogdG8gdGhlIHNlcnZlciBvbiB0aGUgc2FtZSBzbG90Lg0KPiAgCQkgKi8N
Cj4gIAkJaWYgKChzMzIpKHNsb3QtPnNlcV9uciAtIHNsb3QtPnNlcV9ucl9sYXN0X2Fja2VkKSA+
IDEpDQo+IHsNCj4gIAkJCXNsb3QtPnNlcV9uci0tOw0KPiArCQkJbmZzNF9wcm9iZV9zZXF1ZW5j
ZShjbHAsIHRhc2stPnRrX21zZy5ycGNfY3JlZCwgDQo+IHNsb3QpOw0KPiAgCQkJZ290byByZXRy
eV9ub3dhaXQ7DQo+ICAJCX0NCj4gIAkJLyoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpDVE8sIEhh
bW1lcnNwYWNlIEluYw0KNDk4NCBFbCBDYW1pbm8gUmVhbCwgU3VpdGUgMjA4DQpMb3MgQWx0b3Ms
IENBIDk0MDIyDQp3d3cuaGFtbWVyLnNwYWNlDQoNCg0K
