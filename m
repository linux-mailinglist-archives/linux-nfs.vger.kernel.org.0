Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A0D2E30B
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfE2RTu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 13:19:50 -0400
Received: from mail-eopbgr810092.outbound.protection.outlook.com ([40.107.81.92]:45781
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfE2RTt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 13:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpzdTQcuu2T8JKtyPXxQdPKNQGR0s8sINnNsNFavDEk=;
 b=FHn+Gw/ofUC4+7rE/jaQgibJQc5qiUfssjUKStBhoNksmYbRjvKBPs94IrTekkG29KewDMPekoyWrUOP6Wg2+KWVDx8nap8amuJbpKIyR6vqsSS81DFyzSNEqfg+VzWhiomeJvM9FagkOuC8QkYkzKauNayLEnAFZSBDv/8BUEc=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1017.namprd13.prod.outlook.com (10.168.240.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.10; Wed, 29 May 2019 17:19:45 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Wed, 29 May 2019
 17:19:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: client lookup_revalidate bug
Thread-Topic: client lookup_revalidate bug
Thread-Index: AQHVFjBscHUNWpoRAkCoQc0DC6hmgKaCSOAAgAAE14CAAAtQAA==
Date:   Wed, 29 May 2019 17:19:45 +0000
Message-ID: <b8e9ef022cb5ec1fef01e34890c3119463b0bd4b.camel@hammerspace.com>
References: <D4DAB8F2-CAA7-4BC3-B0A0-4EAF5E9DE261@redhat.com>
         <458733948202ed0fddf37cbb79730b5ebdabd551.camel@hammerspace.com>
         <66FFF553-5DEE-4B49-A207-7B0D63FBAECB@redhat.com>
In-Reply-To: <66FFF553-5DEE-4B49-A207-7B0D63FBAECB@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9aafaa15-55a2-4a4f-8e89-08d6e459d86a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1017;
x-ms-traffictypediagnostic: DM5PR13MB1017:
x-microsoft-antispam-prvs: <DM5PR13MB1017F2E062A95A00F7AD256BB81F0@DM5PR13MB1017.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(346002)(376002)(136003)(396003)(189003)(199004)(6512007)(25786009)(66476007)(66946007)(68736007)(316002)(229853002)(6486002)(118296001)(99286004)(71200400001)(66556008)(14454004)(76116006)(478600001)(73956011)(66446008)(64756008)(36756003)(486006)(76176011)(71190400001)(5640700003)(476003)(1730700003)(81156014)(6436002)(81166006)(6916009)(11346002)(186003)(66066001)(53546011)(8676002)(26005)(7116003)(6506007)(6246003)(53936002)(6116002)(14444005)(256004)(7736002)(4326008)(305945005)(5660300002)(446003)(2351001)(86362001)(3846002)(2616005)(2501003)(2906002)(102836004)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1017;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5qJdxgcGdRP5gy4YYHd0dbmT58puaQ0Y49XlriGwHFoKrj7OyNb4LCslDXrYyypFGqHhkjkQ56PEdgMJMsx1oTqCxUt5Zd/UrEzQMPYN+Qx8PRyTunhbPQfNgflArx4bs1M1rlyZjdbP+3IaWBH7PLX6wqC9ZZB2KLtwrLSrSb6h4qePpMeal6rGjGZAWwqqJGjtlQP3DUorvL7z1LkqXsYq0UjHF3JpTPU9+Pb2V99YRejr9WsDNzB5S1/D2JAkvyKaTdtazGmnnSKXdCAHqiwKer+oTG9iu83J+v5DKHyQH+1RBzo67heIKYXiNilNDmyfLDtVhh2Sa2eR0xKIYow2W0OAJd1iGO6yJMlcApojj+onLR08JiiExeTKhtLtPQp6bACZs0aJiF72wrPR+iGvvLjQ5x5NJzoVSM9HCsU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB6F60CB69EF864FB7384788636AB3CB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aafaa15-55a2-4a4f-8e89-08d6e459d86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 17:19:45.2126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1017
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTI5IGF0IDEyOjM5IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyOSBNYXkgMjAxOSwgYXQgMTI6MjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gV2VkLCAyMDE5LTA1LTI5IGF0IDExOjA4IC0wNDAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gSGV5LCBoZXJlJ3MgYW4gaW50ZXJlc3Rpbmcgb25lLCB0aGlz
IHNlZW1zIHdyb25nOg0KPiA+ID4gDQo+ID4gPiBbcm9vdEBmZWRvcmEyN19jMl92NSB+XSMgbWtk
aXIgL21udC9vbmUNCj4gPiA+IFtyb290QGZlZG9yYTI3X2MyX3Y1IH5dIyBta2RpciAvbW50L3R3
bw0KPiA+ID4gW3Jvb3RAZmVkb3JhMjdfYzJfdjUgfl0jIG1vdW50IC10IG5mcw0KPiA+ID4gLW92
NCxub2FjLHNlYz1zeXMsbm9zaGFyZWNhY2hlDQo+ID4gPiAxOTIuMTY4LjEyMi41MDovZXhwb3J0
cyAvbW50L29uZQ0KPiA+ID4gW3Jvb3RAZmVkb3JhMjdfYzJfdjUgfl0jIG1vdW50IC10IG5mcw0K
PiA+ID4gLW92NCxub2FjLHNlYz1zeXMsbm9zaGFyZWNhY2hlDQo+ID4gPiAxOTIuMTY4LjEyMi41
MDovZXhwb3J0cyAvbW50L3R3bw0KPiA+ID4gW3Jvb3RAZmVkb3JhMjdfYzJfdjUgfl0jIG1rZGly
IC9tbnQvb25lL0ENCj4gPiA+IFtyb290QGZlZG9yYTI3X2MyX3Y1IH5dIyBta2RpciAvbW50L29u
ZS9CDQo+ID4gPiBbcm9vdEBmZWRvcmEyN19jMl92NSB+XSMgdG91Y2ggL21udC9vbmUvQS9mb28N
Cj4gPiA+IFtyb290QGZlZG9yYTI3X2MyX3Y1IH5dIyBjYXQgL21udC90d28vQS9mb28NCj4gPiA+
IFtyb290QGZlZG9yYTI3X2MyX3Y1IH5dIyBtdiAvbW50L3R3by9BL2ZvbyAvbW50L3R3by9CL2Zv
bw0KPiA+ID4gW3Jvb3RAZmVkb3JhMjdfYzJfdjUgfl0jIG12IC9tbnQvb25lL0IvZm9vIC9tbnQv
b25lL0EvZm9vDQo+ID4gPiBbcm9vdEBmZWRvcmEyN19jMl92NSB+XSMgY2F0IC9tbnQvdHdvL0Ev
Zm9vDQo+ID4gPiBbcm9vdEBmZWRvcmEyN19jMl92NSB+XSMgc3RhdCAvbW50L3R3by9CL2Zvbw0K
PiA+ID4gICAgRmlsZTogL21udC90d28vQi9mb28NCj4gPiA+ICAgIFNpemU6IDAgICAgICAgICAJ
QmxvY2tzOiAwICAgICAgICAgIElPIEJsb2NrOiAyNjIxNDQNCj4gPiA+IHJlZ3VsYXINCj4gPiA+
IGVtcHR5DQo+ID4gPiBmaWxlDQo+ID4gPiBEZXZpY2U6IDJmaC80N2QJSW5vZGU6IDQzOTYwMyAg
ICAgIExpbmtzOiAxDQo+ID4gPiBBY2Nlc3M6ICgwNjQ0Ly1ydy1yLS1yLS0pICBVaWQ6ICggICAg
MC8gICAgcm9vdCkgICBHaWQ6DQo+ID4gPiAoICAgIDAvICAgIHJvb3QpDQo+ID4gPiBDb250ZXh0
OiBzeXN0ZW1fdTpvYmplY3RfcjpuZnNfdDpzMA0KPiA+ID4gQWNjZXNzOiAyMDE5LTA1LTI4IDE0
OjAwOjE4LjkyOTY2MzcwNSAtMDQwMA0KPiA+ID4gTW9kaWZ5OiAyMDE5LTA1LTI4IDE0OjAwOjE4
LjkyOTY2MzcwNSAtMDQwMA0KPiA+ID4gQ2hhbmdlOiAyMDE5LTA1LTI4IDE0OjAwOjU4Ljk5MDEy
NDU3MyAtMDQwMA0KPiA+ID4gICBCaXJ0aDogLQ0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IF5eIHRo
YXQgbHN0YXQgc2hvdWxkIHJldHVybiAtRU5PRU5ULg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHdl
IGRldGVjdCBhIHN0YWxlIGRpcmVjdG9yeSBieSBjb21wYXJpbmcgdGhlIGRpcmVjdG9yeSdzDQo+
ID4gPiBjaGFuZ2VfYXR0ciB3aXRoIHRoZSBkZW50cnkncyBkX3RpbWUuICBCdXQsIGhlcmUncyBh
IGNhc2Ugd2hlcmUNCj4gPiA+IHRoZXkNCj4gPiA+IGFyZQ0KPiA+ID4gdGhlIHNhbWUhDQo+ID4g
PiANCj4gPiA+IEFtIEkgd3JvbmcgYWJvdXQgdGhpcywgb3IgYW55IGNsZXZlciBpZGVhcyB0byBj
YXRjaCB0aGlzIGNhc2U/DQo+ID4gPiANCj4gPiANCj4gPiBXaGVuIHlvdSBhcmUgbW91bnRpbmcg
dXNpbmcgJ25vc2hhcmVjYWNoZScgdGhlbiB5b3UgYXJlIG1ha2luZw0KPiA+IC9tbnQvb25lDQo+
ID4gYW5kIC9tbnQvdHdvIGFjdCBhcyBpZiB0aGV5IGFyZSBkaWZmZXJlbnQgZmlsZXN5c3RlbXMu
IFRoZSBmYWN0DQo+ID4gdGhhdA0KPiA+IHRoZXkgYXJlIHRoZSBzYW1lIG9uIHRoZSBzZXJ2ZXIs
IG1lYW5zIHlvdSBhcmUgc2V0dGluZyB1cCBhDQo+ID4gdGVzdGNhc2UNCj4gPiB3aGVyZSB0aGUg
ZmlsZXMrZGlyZWN0b3JpZXMgYXJlIGFjdGluZyBsaWtlIHRoZSAiY2hhbmdpbmcgb24gdGhlDQo+
ID4gc2VydmVyIiBjYXNlIGFzIGZhciBhcyB0aGUgY2xpZW50IGlzIGNvbmNlcm5lZC4NCj4gPiAN
Cj4gPiBJZiB5b3Ugd2FudCB0aGUgYWJvdmUgdG8gd29yayBpbiBhIHNhbmUgZmFzaGlvbiwgdGhl
biBqdXN0IGRvbid0DQo+ID4gdXNlDQo+ID4gJ25vc2hhcmVjYWNoZScuDQo+IA0KPiBUaGF0IHdh
cyBkZWxpYmVyYXRlIHRvIGF2b2lkIGhhdmluZyB0byBzaG93IHR3byBjbGllbnRzIGluIHRoZQ0K
PiBleGFtcGxlLi4NCj4gc29ycnksIEkgc2hvdWxkIGhhdmUgYmVlbiBtb3JlIGV4cGxpY2l0Lg0K
PiANCj4gSSB0aGluayB0aGUgY2xpZW50IHNob3VsZCBiZSBhYmxlIHRvIGRldGVjdCB0aGlzIGNh
c2UsIHNpbmNlIGl0IGNhbg0KPiBzZWUgYW4NCj4gdXBkYXRlZCBjaGFuZ2VfYXR0ciBmb3IgdGhh
dCBwYXJ0aWN1bGFyIGRpcmVjdG9yeSAtLSB0aGF0IGlzDQo+ICIvbW50L3R3by9CL2ZvbyIsIGJ1
dCBtYXliZSBpdCBuZWVkcyB0byBjb21wYXJlIHRoZSBjaGFuZ2VfYXR0ciB0bw0KPiBpdHMNCj4g
cHJldmlvdXMgdmFsdWUgaW5zdGVhZCBvZiBjb21wYXJpbmcgaXQgdG8gdGhlIGNoaWxkJ3MgZF90
aW1lPw0KPiANCj4gVGhlIHBlcnNvbiB3aG8gcmVwb3J0ZWQgaXQgaGFzIHNvbWUgd29ya2xvYWQg
dGhhdCBmbGlwcyBmaWxlcyBiZXR3ZWVuDQo+IGRpcmVjdG9yaWVzIG9uIHNlcGFyYXRlIGNsaWVu
dHMsIGFuZCBkb2Vzbid0IGxpa2UgaXQgd2hlbiBgbXZgDQo+IHJlcG9ydHMNCj4gInNvdXJjZSBh
bmQgZGVzdGluYXRpb24gYXJlIHRoZSBzYW1lIGZpbGUiLg0KDQpTb3JyeSwgYnV0IHRoYXQncyBu
b3QgdGhlIGNhc2UsIGJlY2F1c2Ugb2YgdGhlIGFidXNlIG9mIHRoZQ0Kbm9zaGFyZWNhY2hlIGZs
YWcuIFlvdSBhcmUgbWFuaXB1bGF0aW5nIHRoZSBmaWxlIG9uIHRoZSBzZXJ2ZXIgYW5kDQpleHBl
Y3RpbmcgYW4gaW1tZWRpYXRlIGNhY2hlIGludmFsaWRhdGlvbi4gVGhhdCB3b3VsZCByZXF1aXJl
DQppbmZvcm1hdGlvbiB0aGF0IHRoZSBjbGllbnQgZG9lcyBub3QgaGF2ZS4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
