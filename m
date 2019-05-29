Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D002E048
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 16:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE2Ozv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 10:55:51 -0400
Received: from mail-eopbgr710138.outbound.protection.outlook.com ([40.107.71.138]:12111
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfE2Ozv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 10:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PVEM8a5C3WOCo8DqewY1d2zL9nudeaNmZoCZGO0HMY=;
 b=CDOjTW1ge9w2EiqmBRt04nM4szxVDx20o76bO1jJwFvR6ardftaEAOvV7Y2/pRL20siU6AXrV83tztieqTJu/YnZq4MiQaEbbTLfai2uL2gHzpVOH1VCDuRCfeRJMZ8n8GQVN9ohw9fooOl4GiPJemKZawXfqSoidS9xgRExFKY=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1210.namprd13.prod.outlook.com (10.168.238.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.13; Wed, 29 May 2019 14:55:46 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Wed, 29 May 2019
 14:55:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "SteveD@RedHat.com" <SteveD@RedHat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] Add a helper to return the real path given an
 export entry
Thread-Topic: [PATCH v3 07/11] Add a helper to return the real path given an
 export entry
Thread-Index: AQHVFZSjTcgKpwX6qUipeJy0WrIdjKaCLVeAgAAErYA=
Date:   Wed, 29 May 2019 14:55:46 +0000
Message-ID: <af2a0606934feb5313ef5e5bfe53a8e3e3c137dc.camel@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
         <20190528203122.11401-2-trond.myklebust@hammerspace.com>
         <20190528203122.11401-3-trond.myklebust@hammerspace.com>
         <20190528203122.11401-4-trond.myklebust@hammerspace.com>
         <20190528203122.11401-5-trond.myklebust@hammerspace.com>
         <20190528203122.11401-6-trond.myklebust@hammerspace.com>
         <20190528203122.11401-7-trond.myklebust@hammerspace.com>
         <20190528203122.11401-8-trond.myklebust@hammerspace.com>
         <341a5328-ae6e-755d-6351-8e764d429e61@RedHat.com>
In-Reply-To: <341a5328-ae6e-755d-6351-8e764d429e61@RedHat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8b2af9b-2224-4f9c-465b-08d6e445bb56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1210;
x-ms-traffictypediagnostic: DM5PR13MB1210:
x-microsoft-antispam-prvs: <DM5PR13MB12101712413C7CC88C05C311B81F0@DM5PR13MB1210.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39830400003)(366004)(136003)(189003)(199004)(14454004)(66946007)(66446008)(8676002)(5640700003)(229853002)(81156014)(99286004)(7736002)(6486002)(73956011)(6512007)(6916009)(6436002)(11346002)(64756008)(6506007)(8936002)(66476007)(76116006)(316002)(76176011)(2906002)(118296001)(446003)(81166006)(66556008)(53936002)(102836004)(26005)(3846002)(305945005)(186003)(6116002)(53546011)(256004)(476003)(71190400001)(71200400001)(6246003)(66066001)(68736007)(36756003)(478600001)(2351001)(4326008)(2501003)(25786009)(86362001)(486006)(5660300002)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1210;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ByEDLI2rJUL/gEQDVBjm5wJgXZqALn/fyF22qFpo/1XvbRhEdO0fDYGU5flqi+3nHLU2Uox/yAKppLU9V//9RAJSGV9XDigSnQUvyuDBIUCMbsOhGjO+kBuhymdOuQlL+GN3LatMeaGWq8dMabOuSUe2iG/PRnvqUGoCXMmoDnmGV6IvU/DIK4tTG7+doESLhMnXSBDGes+i2a6LZQSRwAGHeIdos+dXDLK4ZzXwJFAwVQqJ/ZKJuMG63tKDUAJZuAiGjOPPXpYd22/987ZCrJexzIQkvjPP1bP1IlyauOXaUXLwTHE5bWCrVtdrmmB8kZQXY3TgoHihWmbbGu8jNc3/0n3Mr5wRU0olHdK7Th9qunVBbG7Luj7WByzQywyr5reDooGrzGLHL8MoKm89Z2CQgKqx6ZtUz+d74/+j3pg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6D8C373C61058468592083B3FAA24AB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b2af9b-2224-4f9c-465b-08d6e445bb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 14:55:46.4932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1210
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTI5IGF0IDEwOjM4IC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiBIZXkgVHJvbmQsDQo+IA0KPiBPbiA1LzI4LzE5IDQ6MzEgUE0sIFRyb25kIE15a2xlYnVzdCB3
cm90ZToNCj4gPiBBZGQgYSBoZWxwZXIgdGhhdCBjYW4gcHJlcGVuZCB0aGUgbmZzZCByb290IGRp
cmVjdG9yeSBwYXRoIGluIG9yZGVyDQo+ID4gdG8gYWxsb3cgbW91bnRkIHRvIHBlcmZvcm0gaXRz
IGNvbXBhcmlzb25zIHdpdGggbXRhYiBldGMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJv
bmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0K
PiA+ICBzdXBwb3J0L2V4cG9ydC9leHBvcnQuYyAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ICBzdXBwb3J0L2luY2x1ZGUvZXhwb3J0ZnMuaCB8ICAxICsNCj4gPiAgc3VwcG9y
dC9pbmNsdWRlL25mc2xpYi5oICAgfCAgMSArDQo+ID4gIHN1cHBvcnQvbWlzYy9uZnNkX3BhdGgu
YyAgIHwgIDQgKysrLQ0KPiA+ICBzdXBwb3J0L25mcy9leHBvcnRzLmMgICAgICB8ICA0ICsrKysN
Cj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3N1cHBvcnQvZXhwb3J0L2V4cG9ydC5jIGIvc3VwcG9ydC9l
eHBvcnQvZXhwb3J0LmMNCj4gPiBpbmRleCBmYmU2OGU4NGU1YjMuLjgyYmJiNTRjNWU5ZSAxMDA2
NDQNCj4gPiAtLS0gYS9zdXBwb3J0L2V4cG9ydC9leHBvcnQuYw0KPiA+ICsrKyBiL3N1cHBvcnQv
ZXhwb3J0L2V4cG9ydC5jDQo+ID4gQEAgLTIwLDYgKzIwLDcgQEANCj4gPiAgI2luY2x1ZGUgInht
YWxsb2MuaCINCj4gPiAgI2luY2x1ZGUgIm5mc2xpYi5oIg0KPiA+ICAjaW5jbHVkZSAiZXhwb3J0
ZnMuaCINCj4gPiArI2luY2x1ZGUgIm5mc2RfcGF0aC5oIg0KPiA+ICANCj4gPiAgZXhwX2hhc2hf
dGFibGUgZXhwb3J0bGlzdFtNQ0xfTUFYVFlQRVNdID0ge3tOVUxMLCB7e05VTEwsTlVMTH0sDQo+
ID4gfX0sIH07IA0KPiA+ICBzdGF0aWMgaW50IGV4cG9ydF9oYXNoKGNoYXIgKik7DQo+ID4gQEAg
LTMwLDYgKzMxLDI4IEBAIHN0YXRpYyB2b2lkCWV4cG9ydF9hZGQobmZzX2V4cG9ydCAqZXhwKTsN
Cj4gPiAgc3RhdGljIGludAlleHBvcnRfY2hlY2soY29uc3QgbmZzX2V4cG9ydCAqZXhwLCBjb25z
dCBzdHJ1Y3QNCj4gPiBhZGRyaW5mbyAqYWksDQo+ID4gIAkJCQljb25zdCBjaGFyICpwYXRoKTsN
Cj4gPiAgDQo+ID4gKy8qIFJldHVybiBhIHJlYWwgcGF0aCBmb3IgdGhlIGV4cG9ydC4gKi8NCj4g
PiArc3RhdGljIHZvaWQNCj4gPiArZXhwb3J0ZW50X21rcmVhbHBhdGgoc3RydWN0IGV4cG9ydGVu
dCAqZWVwKQ0KPiA+ICt7DQo+ID4gKwljb25zdCBjaGFyICpjaHJvb3QgPSBuZnNkX3BhdGhfbmZz
ZF9yb290ZGlyKCk7DQo+ID4gKwljaGFyICpyZXQgPSBOVUxMOw0KPiA+ICsNCj4gPiArCWlmIChj
aHJvb3QpDQo+ID4gKwkJcmV0ID0gbmZzZF9wYXRoX3ByZXBlbmRfZGlyKGNocm9vdCwgZWVwLT5l
X3BhdGgpOw0KPiA+ICsJaWYgKCFyZXQpDQo+ID4gKwkJcmV0ID0geHN0cmR1cChlZXAtPmVfcGF0
aCk7DQo+ID4gKwllZXAtPmVfcmVhbHBhdGggPSByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK2No
YXIgKg0KPiA+ICtleHBvcnRlbnRfcmVhbHBhdGgoc3RydWN0IGV4cG9ydGVudCAqZWVwKQ0KPiA+
ICt7DQo+ID4gKwlpZiAoIWVlcC0+ZV9yZWFscGF0aCkNCj4gPiArCQlleHBvcnRlbnRfbWtyZWFs
cGF0aChlZXApOw0KPiA+ICsJcmV0dXJuIGVlcC0+ZV9yZWFscGF0aDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiAgdm9pZA0KPiA+ICBleHBvcnRlbnRfcmVsZWFzZShzdHJ1Y3QgZXhwb3J0ZW50ICplZXAp
DQo+ID4gIHsNCj4gPiBAQCAtMzksNiArNjIsNyBAQCBleHBvcnRlbnRfcmVsZWFzZShzdHJ1Y3Qg
ZXhwb3J0ZW50ICplZXApDQo+ID4gIAlmcmVlKGVlcC0+ZV9mc2xvY2RhdGEpOw0KPiA+ICAJZnJl
ZShlZXAtPmVfdXVpZCk7DQo+ID4gIAl4ZnJlZShlZXAtPmVfaG9zdG5hbWUpOw0KPiA+ICsJeGZy
ZWUoZWVwLT5lX3JlYWxwYXRoKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHZvaWQNCj4g
PiBkaWZmIC0tZ2l0IGEvc3VwcG9ydC9pbmNsdWRlL2V4cG9ydGZzLmgNCj4gPiBiL3N1cHBvcnQv
aW5jbHVkZS9leHBvcnRmcy5oDQo+ID4gaW5kZXggNGUwZDlkMTMyYjRjLi5kYWE3ZTJhMDZkODIg
MTAwNjQ0DQo+ID4gLS0tIGEvc3VwcG9ydC9pbmNsdWRlL2V4cG9ydGZzLmgNCj4gPiArKysgYi9z
dXBwb3J0L2luY2x1ZGUvZXhwb3J0ZnMuaA0KPiA+IEBAIC0xNzEsNSArMTcxLDYgQEAgc3RydWN0
IGV4cG9ydF9mZWF0dXJlcyB7DQo+ID4gIA0KPiA+ICBzdHJ1Y3QgZXhwb3J0X2ZlYXR1cmVzICpn
ZXRfZXhwb3J0X2ZlYXR1cmVzKHZvaWQpOw0KPiA+ICB2b2lkIGZpeF9wc2V1ZG9mbGF2b3JfZmxh
Z3Moc3RydWN0IGV4cG9ydGVudCAqZXApOw0KPiA+ICtjaGFyICpleHBvcnRlbnRfcmVhbHBhdGgo
c3RydWN0IGV4cG9ydGVudCAqZWVwKTsNCj4gPiAgDQo+ID4gICNlbmRpZiAvKiBFWFBPUlRGU19I
ICovDQo+ID4gZGlmZiAtLWdpdCBhL3N1cHBvcnQvaW5jbHVkZS9uZnNsaWIuaCBiL3N1cHBvcnQv
aW5jbHVkZS9uZnNsaWIuaA0KPiA+IGluZGV4IGIwOWZjZTQyZTY3Ny4uODRkODI3MGIzMzBmIDEw
MDY0NA0KPiA+IC0tLSBhL3N1cHBvcnQvaW5jbHVkZS9uZnNsaWIuaA0KPiA+ICsrKyBiL3N1cHBv
cnQvaW5jbHVkZS9uZnNsaWIuaA0KPiA+IEBAIC04NCw2ICs4NCw3IEBAIHN0cnVjdCBleHBvcnRl
bnQgew0KPiA+ICAJY2hhciAqCQllX3V1aWQ7DQo+ID4gIAlzdHJ1Y3Qgc2VjX2VudHJ5IGVfc2Vj
aW5mb1tTRUNGTEFWT1JfQ09VTlQrMV07DQo+ID4gIAl1bnNpZ25lZCBpbnQJZV90dGw7DQo+ID4g
KwljaGFyICoJCWVfcmVhbHBhdGg7DQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdHJ1Y3Qgcm10YWJl
bnQgew0KPiA+IGRpZmYgLS1naXQgYS9zdXBwb3J0L21pc2MvbmZzZF9wYXRoLmMgYi9zdXBwb3J0
L21pc2MvbmZzZF9wYXRoLmMNCj4gPiBpbmRleCA1NWJjYTliZGY0YmQuLjhkZGFmZDY1YWI3NiAx
MDA2NDQNCj4gPiAtLS0gYS9zdXBwb3J0L21pc2MvbmZzZF9wYXRoLmMNCj4gPiArKysgYi9zdXBw
b3J0L21pc2MvbmZzZF9wYXRoLmMNCj4gPiBAQCAtODEsOSArODEsMTEgQEAgbmZzZF9wYXRoX3By
ZXBlbmRfZGlyKGNvbnN0IGNoYXIgKmRpciwgY29uc3QNCj4gPiBjaGFyICpwYXRobmFtZSkNCj4g
PiAgCQlkaXJsZW4tLTsNCj4gPiAgCWlmICghZGlybGVuKQ0KPiA+ICAJCXJldHVybiBOVUxMOw0K
PiA+ICsJd2hpbGUgKHBhdGhuYW1lWzBdID09ICcvJykNCj4gPiArCQlwYXRobmFtZSsrOw0KPiA+
ICAJbGVuID0gZGlybGVuICsgc3RybGVuKHBhdGhuYW1lKSArIDE7DQo+ID4gIAlyZXQgPSB4bWFs
bG9jKGxlbiArIDEpOw0KPiA+IC0Jc25wcmludGYocmV0LCBsZW4sICIlLipzLyVzIiwgKGludClk
aXJsZW4sIGRpciwgcGF0aG5hbWUpOw0KPiA+ICsJc25wcmludGYocmV0LCBsZW4rMSwgIiUuKnMv
JXMiLCAoaW50KWRpcmxlbiwgZGlyLCBwYXRobmFtZSk7DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+
ICB9DQo+ID4gIA0KPiA+IGRpZmYgLS1naXQgYS9zdXBwb3J0L25mcy9leHBvcnRzLmMgYi9zdXBw
b3J0L25mcy9leHBvcnRzLmMNCj4gPiBpbmRleCA1ZjRjYjk1Njg4MTQuLjNlY2ZkZTc5N2UzYiAx
MDA2NDQNCj4gPiAtLS0gYS9zdXBwb3J0L25mcy9leHBvcnRzLmMNCj4gPiArKysgYi9zdXBwb3J0
L25mcy9leHBvcnRzLmMNCj4gPiBAQCAtMTU1LDYgKzE1NSw3IEBAIGdldGV4cG9ydGVudChpbnQg
ZnJvbWtlcm5lbCwgaW50IGZyb21leHBvcnRzKQ0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCXhmcmVl
KGVlLmVfaG9zdG5hbWUpOw0KPiA+ICsJeGZyZWUoZWUuZV9yZWFscGF0aCk7DQo+ID4gIAllZSA9
IGRlZl9lZTsNCj4gPiAgDQo+ID4gIAkvKiBDaGVjayBmb3IgZGVmYXVsdCBjbGllbnQgKi8NCj4g
PiBAQCAtMzU4LDYgKzM1OSw3IEBAIGR1cGV4cG9ydGVudChzdHJ1Y3QgZXhwb3J0ZW50ICpkc3Qs
IHN0cnVjdA0KPiA+IGV4cG9ydGVudCAqc3JjKQ0KPiA+ICAJaWYgKHNyYy0+ZV91dWlkKQ0KPiA+
ICAJCWRzdC0+ZV91dWlkID0gc3RyZHVwKHNyYy0+ZV91dWlkKTsNCj4gPiAgCWRzdC0+ZV9ob3N0
bmFtZSA9IE5VTEw7DQo+ID4gKwlkc3QtPmVfcmVhbHBhdGggPSBOVUxMOw0KPiA+ICB9DQo+ID4g
IA0KPiA+ICBzdHJ1Y3QgZXhwb3J0ZW50ICoNCj4gPiBAQCAtMzY5LDYgKzM3MSw4IEBAIG1rZXhw
b3J0ZW50KGNoYXIgKmhuYW1lLCBjaGFyICpwYXRoLCBjaGFyDQo+ID4gKm9wdGlvbnMpDQo+ID4g
IA0KPiA+ICAJeGZyZWUoZWUuZV9ob3N0bmFtZSk7DQo+ID4gIAllZS5lX2hvc3RuYW1lID0geHN0
cmR1cChobmFtZSk7DQo+ID4gKwl4ZnJlZShlZS5lX3JlYWxwYXRoKTsNCj4gPiArCWVlLmVfcmVh
bHBhdGggPSBOVUxMOw0KPiA+ICANCj4gPiAgCWlmIChzdHJsZW4ocGF0aCkgPj0gc2l6ZW9mKGVl
LmVfcGF0aCkpIHsNCj4gPiAgCQl4bG9nKExfRVJST1IsICJwYXRoIG5hbWUgJXMgdG9vIGxvbmci
LCBwYXRoKTsNCj4gPiANCj4gSSdtIG5vdCByZWFsbHkgc3VyZSB3aHkgdGhpcyBpcyBoYXBwZW5p
bmcgb24gdGhpcyBwYXRjaCBhbmQgaG93DQo+IEkgbWlzc2VkIHRoaXMgaW4gdGhlIGZpcnN0IHZl
cnNpb24uLiBidXQgSSdtIGdldHRpbmcgdGhlIGZvbGxvd2luZw0KPiBsaW5raW5nIGVycm9yIGFm
dGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2gNCj4gDQo+IC91c3IvYmluL2xkOiAuLi8uLi9zdXBwb3J0
L21pc2MvbGlibWlzYy5hKHdvcmtxdWV1ZS5vKTogaW4gZnVuY3Rpb24NCj4gYHh0aHJlYWRfd29y
a3F1ZXVlX3dvcmtlcic6DQo+IC9ob21lL3NyYy91cC9uZnMtdXRpbHMvc3VwcG9ydC9taXNjL3dv
cmtxdWV1ZS5jOjEzMzogdW5kZWZpbmVkDQo+IHJlZmVyZW5jZSB0byBgX19wdGhyZWFkX3JlZ2lz
dGVyX2NhbmNlbCcNCj4gL3Vzci9iaW4vbGQ6IC9ob21lL3NyYy91cC9uZnMtdXRpbHMvc3VwcG9y
dC9taXNjL3dvcmtxdWV1ZS5jOjEzNToNCj4gdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgX19wdGhy
ZWFkX3VucmVnaXN0ZXJfY2FuY2VsJw0KPiAvdXNyL2Jpbi9sZDogLi4vLi4vc3VwcG9ydC9taXNj
L2xpYm1pc2MuYSh3b3JrcXVldWUubyk6IGluIGZ1bmN0aW9uDQo+IGB4dGhyZWFkX3dvcmtxdWV1
ZV9hbGxvYyc6DQo+IC9ob21lL3NyYy91cC9uZnMtdXRpbHMvc3VwcG9ydC9taXNjL3dvcmtxdWV1
ZS5jOjE0OTogdW5kZWZpbmVkDQo+IHJlZmVyZW5jZSB0byBgcHRocmVhZF9jcmVhdGUnDQo+IGNv
bGxlY3QyOiBlcnJvcjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cw0KPiANCj4gVG8gZ2V0IHRo
aW5ncyB0byBsaW5rIEkgbmVlZCB0aGlzIHBhdGNoDQo+IA0KDQpIdWgsIHRoYXQncyB3ZWlyZC4u
LiBJJ3ZlIGJlZW4gY29tcGlsaW5nIHRoaXMgb3ZlciBhbmQgb3ZlciBhbmQgaGF2ZQ0KeWV0IHRv
IHNlZSB0aGF0IGNvbXBpbGUgZXJyb3IuDQoNCkRvIHlvdSB3YW50IG1lIHRvIGludGVncmF0ZSB5
b3VyIGZpeCBhbmQgcmVzZW5kLCBvciBkbyB5b3UgcHJlZmVyIGp1c3QNCnRvIGFwcGx5IHlvdXIg
Zml4IHRvIHRoZSBleGlzdGluZyBzZXJpZXMgYXMgYSBzZXBhcmF0ZSBjb21taXQNCmltbWVkaWF0
ZWx5IGJlZm9yZSB0aGlzIHBhdGNoPw0KDQpDaGVlcnMNCiAgVHJvbmQNCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
