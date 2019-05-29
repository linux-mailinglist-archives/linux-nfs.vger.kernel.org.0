Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527222E230
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfE2QWA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 12:22:00 -0400
Received: from mail-eopbgr810138.outbound.protection.outlook.com ([40.107.81.138]:20064
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfE2QWA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 12:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNMwby4zzB8hvpmguuw46G1QyRnEh0Q7ImEDLXY9Uew=;
 b=b6OaBqbPwfczd1TwaMYVr5zjWZBIh/HIQoy6/1cTm5ELahmZMDShkapbfGkYNm0NayJfvac0dT8uprzEY5SRYtLWIp/7FKgdzvxPF7mIqdznD77LYy24dOPkDPKfXH2Qqd7577akiyxJJPt5XXe1K4QnPfqwFRiWETcUY+Y7eoc=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1850.namprd13.prod.outlook.com (10.171.155.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.10; Wed, 29 May 2019 16:21:57 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Wed, 29 May 2019
 16:21:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: client lookup_revalidate bug
Thread-Topic: client lookup_revalidate bug
Thread-Index: AQHVFjBscHUNWpoRAkCoQc0DC6hmgKaCSOAA
Date:   Wed, 29 May 2019 16:21:56 +0000
Message-ID: <458733948202ed0fddf37cbb79730b5ebdabd551.camel@hammerspace.com>
References: <D4DAB8F2-CAA7-4BC3-B0A0-4EAF5E9DE261@redhat.com>
In-Reply-To: <D4DAB8F2-CAA7-4BC3-B0A0-4EAF5E9DE261@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1ad41fe-72eb-4d7d-c0e7-08d6e451c52f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1850;
x-ms-traffictypediagnostic: DM5PR13MB1850:
x-microsoft-antispam-prvs: <DM5PR13MB18501374A70F99F01BC70D61B81F0@DM5PR13MB1850.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(396003)(39830400003)(199004)(189003)(7116003)(8676002)(6486002)(64756008)(76176011)(66066001)(66446008)(76116006)(446003)(73956011)(81156014)(229853002)(81166006)(118296001)(26005)(186003)(316002)(71200400001)(8936002)(36756003)(5660300002)(71190400001)(6436002)(66946007)(66556008)(53936002)(99286004)(2616005)(7736002)(68736007)(476003)(2906002)(86362001)(478600001)(305945005)(486006)(6116002)(3846002)(14444005)(6506007)(102836004)(110136005)(2501003)(25786009)(6246003)(14454004)(11346002)(66476007)(6512007)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1850;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: awRO2Mb5LMcjus3quD3zykXwRx4tHZiMpEtjauG9uAUyeu/qXg365ajPXQyp29O6yNMe9Wb3T/pwbTL9bqIRZX/eilCkK711Md4KuxTduv5TXpXeJdpmNmPU8p8uzU0uAKV5D1kaBIIPQWjbuQWYajzDR3HLBd5FCSeYEoM00RnS9bsZyIM6kr9kaG456r+Wz8wfCyut341kg0ldg96haNNf2kroohDmm/8sUM2bngYjrMJGFErxfsgoo/lUvmzzdxsVfNIy+PniZ3M0seeQ1fMmFry+b+6oT2KqF9Abr5t0rhHQyttGjiJy1SzYxPkkDn33Kv06dD9cbYkdg1jLGg5m9woA8OE4CWkPLj+HWbdoVDBofrRiM7HGFsgb1PWf/IpHUXjWm3Suf6vYiwywBArVKTZZ8YdEe7Ex+Xk3TMY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <073BDEC7B6F22A4DBF9B7E929DD5947C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ad41fe-72eb-4d7d-c0e7-08d6e451c52f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 16:21:56.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1850
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTI5IGF0IDExOjA4IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBIZXksIGhlcmUncyBhbiBpbnRlcmVzdGluZyBvbmUsIHRoaXMgc2VlbXMgd3Jvbmc6
DQo+IA0KPiBbcm9vdEBmZWRvcmEyN19jMl92NSB+XSMgbWtkaXIgL21udC9vbmUNCj4gW3Jvb3RA
ZmVkb3JhMjdfYzJfdjUgfl0jIG1rZGlyIC9tbnQvdHdvDQo+IFtyb290QGZlZG9yYTI3X2MyX3Y1
IH5dIyBtb3VudCAtdCBuZnMgLW92NCxub2FjLHNlYz1zeXMsbm9zaGFyZWNhY2hlIA0KPiAxOTIu
MTY4LjEyMi41MDovZXhwb3J0cyAvbW50L29uZQ0KPiBbcm9vdEBmZWRvcmEyN19jMl92NSB+XSMg
bW91bnQgLXQgbmZzIC1vdjQsbm9hYyxzZWM9c3lzLG5vc2hhcmVjYWNoZSANCj4gMTkyLjE2OC4x
MjIuNTA6L2V4cG9ydHMgL21udC90d28NCj4gW3Jvb3RAZmVkb3JhMjdfYzJfdjUgfl0jIG1rZGly
IC9tbnQvb25lL0ENCj4gW3Jvb3RAZmVkb3JhMjdfYzJfdjUgfl0jIG1rZGlyIC9tbnQvb25lL0IN
Cj4gW3Jvb3RAZmVkb3JhMjdfYzJfdjUgfl0jIHRvdWNoIC9tbnQvb25lL0EvZm9vDQo+IFtyb290
QGZlZG9yYTI3X2MyX3Y1IH5dIyBjYXQgL21udC90d28vQS9mb28NCj4gW3Jvb3RAZmVkb3JhMjdf
YzJfdjUgfl0jIG12IC9tbnQvdHdvL0EvZm9vIC9tbnQvdHdvL0IvZm9vDQo+IFtyb290QGZlZG9y
YTI3X2MyX3Y1IH5dIyBtdiAvbW50L29uZS9CL2ZvbyAvbW50L29uZS9BL2Zvbw0KPiBbcm9vdEBm
ZWRvcmEyN19jMl92NSB+XSMgY2F0IC9tbnQvdHdvL0EvZm9vDQo+IFtyb290QGZlZG9yYTI3X2My
X3Y1IH5dIyBzdGF0IC9tbnQvdHdvL0IvZm9vDQo+ICAgIEZpbGU6IC9tbnQvdHdvL0IvZm9vDQo+
ICAgIFNpemU6IDAgICAgICAgICAJQmxvY2tzOiAwICAgICAgICAgIElPIEJsb2NrOiAyNjIxNDQg
cmVndWxhcg0KPiBlbXB0eSANCj4gZmlsZQ0KPiBEZXZpY2U6IDJmaC80N2QJSW5vZGU6IDQzOTYw
MyAgICAgIExpbmtzOiAxDQo+IEFjY2VzczogKDA2NDQvLXJ3LXItLXItLSkgIFVpZDogKCAgICAw
LyAgICByb290KSAgIEdpZDoNCj4gKCAgICAwLyAgICByb290KQ0KPiBDb250ZXh0OiBzeXN0ZW1f
dTpvYmplY3RfcjpuZnNfdDpzMA0KPiBBY2Nlc3M6IDIwMTktMDUtMjggMTQ6MDA6MTguOTI5NjYz
NzA1IC0wNDAwDQo+IE1vZGlmeTogMjAxOS0wNS0yOCAxNDowMDoxOC45Mjk2NjM3MDUgLTA0MDAN
Cj4gQ2hhbmdlOiAyMDE5LTA1LTI4IDE0OjAwOjU4Ljk5MDEyNDU3MyAtMDQwMA0KPiAgIEJpcnRo
OiAtDQo+IA0KPiANCj4gXl4gdGhhdCBsc3RhdCBzaG91bGQgcmV0dXJuIC1FTk9FTlQuDQo+IA0K
PiBJIHRoaW5rIHdlIGRldGVjdCBhIHN0YWxlIGRpcmVjdG9yeSBieSBjb21wYXJpbmcgdGhlIGRp
cmVjdG9yeSdzIA0KPiBjaGFuZ2VfYXR0ciB3aXRoIHRoZSBkZW50cnkncyBkX3RpbWUuICBCdXQs
IGhlcmUncyBhIGNhc2Ugd2hlcmUgdGhleQ0KPiBhcmUgDQo+IHRoZSBzYW1lIQ0KPiANCj4gQW0g
SSB3cm9uZyBhYm91dCB0aGlzLCBvciBhbnkgY2xldmVyIGlkZWFzIHRvIGNhdGNoIHRoaXMgY2Fz
ZT8NCj4gDQoNCldoZW4geW91IGFyZSBtb3VudGluZyB1c2luZyAnbm9zaGFyZWNhY2hlJyB0aGVu
IHlvdSBhcmUgbWFraW5nIC9tbnQvb25lDQphbmQgL21udC90d28gYWN0IGFzIGlmIHRoZXkgYXJl
IGRpZmZlcmVudCBmaWxlc3lzdGVtcy4gVGhlIGZhY3QgdGhhdA0KdGhleSBhcmUgdGhlIHNhbWUg
b24gdGhlIHNlcnZlciwgbWVhbnMgeW91IGFyZSBzZXR0aW5nIHVwIGEgdGVzdGNhc2UNCndoZXJl
IHRoZSBmaWxlcytkaXJlY3RvcmllcyBhcmUgYWN0aW5nIGxpa2UgdGhlICJjaGFuZ2luZyBvbiB0
aGUNCnNlcnZlciIgY2FzZSBhcyBmYXIgYXMgdGhlIGNsaWVudCBpcyBjb25jZXJuZWQuDQoNCklm
IHlvdSB3YW50IHRoZSBhYm92ZSB0byB3b3JrIGluIGEgc2FuZSBmYXNoaW9uLCB0aGVuIGp1c3Qg
ZG9uJ3QgdXNlDQonbm9zaGFyZWNhY2hlJy4NCg0KQ2hlZXJzDQogICBUcm9uZA0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
