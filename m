Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED47C8AA1
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 16:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfJBOMt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 10:12:49 -0400
Received: from mail-eopbgr810044.outbound.protection.outlook.com ([40.107.81.44]:64640
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfJBOMt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 2 Oct 2019 10:12:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQF4d/bN5vM7xPLHMhpaJIrnaVhKNz68hUpcAbVHz8EqFL6pnrXjPUydDDtIkngD2mu3CniooAN8zbCuvTVD0R9d++1r83IMbROp7B0KsA6d1cmaT/bzHngE7SlZthz8Tzq7ItojR6FyUdVKqlwlLGUZkVxjvBiMyacBdJRMgz2wiVRGeew8ZtEWmSQ74+cwKhIZTKzpYv0y2ONDL/gm+5m0vpnCx0pc/1PpAdK7+gXWMbVkJOeHDwXCrfG9oDM3RcKaPZmJ40HUAXIVmhWi6y6lMMd8ZKMqHTTiNU3BiVG3vCIbAp7WPXRzd3FEqh9/EO2FmpGaW4vVNLZPlw7roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuqqrlYWuqzNKdl5wp0w+o/UEtczxx5Mu/faZ4hYnDo=;
 b=jL6l22b/O/zryvUWr/wGllgJpobYiYB2EMzkfYVV6LTO+PyY6mLWUF4TXoUKhcwyXhWkK5FzTKZ8kJhvxDlncgJ8vvTRNzs8hMCgqd44P5upme267YkDHdrF0bvvh60t1rATcU8xAlZTMJzOZ7oaZIvZNmiOQduHBnPryh4jOpo5wwPVCPJJMqYJM6w9ym3SOGP0wTX9qmQhCFdeaX1WU7Z63eZMUGP8gIlaBT82UL/IfIZiXsU4nfluE4+0ujA+MN55l2ai8eht5+dZy24VarC00NQ0/2P7D+iix4DAmI/rlLoyRG3w9XgYwb7W+2pw1/ENgstlbXgiLUQRUyue5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuqqrlYWuqzNKdl5wp0w+o/UEtczxx5Mu/faZ4hYnDo=;
 b=Wh7Z0YDXxSED3C+A5+KVykO/eQijifPHf72444VYsyXq7mvDWuxQFD4l5P1i/H3ky1/aDc3+58cdGq/lrVRCI48Akfv72CkBYIaBep1phKt5AhBqLPM1RsRLU1rAaVKkeJqTLWOxS+cr/oRWqrJm2/0xvh04NU43Wx3p0HWrj3A=
Received: from BYAPR06MB6054.namprd06.prod.outlook.com (20.178.51.83) by
 BYAPR06MB6390.namprd06.prod.outlook.com (20.178.48.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Wed, 2 Oct 2019 14:12:43 +0000
Received: from BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::e8e1:5cc3:c597:60b4]) by BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::e8e1:5cc3:c597:60b4%3]) with mapi id 15.20.2305.022; Wed, 2 Oct 2019
 14:12:42 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "trondmy@gmail.com" <trondmy@gmail.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jamespharvey20@gmail.com" <jamespharvey20@gmail.com>
Subject: Re: [PATCH v2] SUNRPC: fix race to sk_err after xs_error_report
Thread-Topic: [PATCH v2] SUNRPC: fix race to sk_err after xs_error_report
Thread-Index: AQHVeREXEaO2/1vcukyxKnZZ4DV/FqdHZMWA
Date:   Wed, 2 Oct 2019 14:12:42 +0000
Message-ID: <4aad6fda0afd63e6020dfe843004fa73edf665a5.camel@netapp.com>
References: <d851f5c2e3aa2b1784a0cc7d42858781b6d07ab8.1570014121.git.bcodding@redhat.com>
In-Reply-To: <d851f5c2e3aa2b1784a0cc7d42858781b6d07ab8.1570014121.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.0 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 538ed9d3-c353-410d-050f-08d747429759
x-ms-traffictypediagnostic: BYAPR06MB6390:
x-microsoft-antispam-prvs: <BYAPR06MB639068B2A2E08B2314406B26F89C0@BYAPR06MB6390.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(6246003)(99286004)(6506007)(81166006)(8936002)(14444005)(256004)(58126008)(54906003)(71190400001)(8676002)(71200400001)(76176011)(110136005)(81156014)(91956017)(66946007)(118296001)(36756003)(4326008)(305945005)(76116006)(7736002)(66446008)(64756008)(6116002)(446003)(11346002)(26005)(102836004)(186003)(3846002)(2616005)(486006)(2501003)(476003)(66066001)(6512007)(229853002)(66556008)(66476007)(14454004)(6436002)(2906002)(86362001)(316002)(25786009)(5660300002)(6486002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR06MB6390;H:BYAPR06MB6054.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQBv264UrEzDMIzCR/2ddNLbT4QTUVoocysQ5ljUhF1x1HM0hXKJB5G1pC4CDv36l4r/uAB7inThgXLSYXV/MGvlaMCGXOG5FCBk+KYQyHEqNTyoaSy60wuCZ8uqnH1rXEphj5sq1XPK4d6/hgN5dkFYuRzAc5aaeWk+JplctBYwLnllCVAjY6m37bZ3BXeBkSHPCopyhhCGJhVKZR3hGXXWZrLhh9OlG7Qw4Gb5vqAyFpGTJglzY3oPFOYLr0QOFS+/JFBFX2oxEnN19fVFhin4hxY0rySSTjgOLJJPtvq+YON9R2F2mR6XZm6j5wgeMft1U2hm9jydLAyGFaHf2i/66xpNBOZprwTeQqHsQq8MrBpc1GyrTBjfOcd73A0+qdcce1Z2bJ9Jlsc9lh6SKzNw+1MQzyfMDjVaOYez5S8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1456EA932DEF674FB423DF766D0D7F8B@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538ed9d3-c353-410d-050f-08d747429759
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 14:12:42.7832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nH13ZnzxLq1WvNnGjW1QSXZOvyqMRr541oLs6c8d9k1TQW6yUQUIMlMW+lUIqorq9ywMtYmjPJXhr13YKnozDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB6390
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgQmVuLA0KDQpPbiBXZWQsIDIwMTktMTAtMDIgYXQgMDc6MDMgLTA0MDAsIEJlbmphbWluIENv
ZGRpbmd0b24gd3JvdGU6DQo+IFNpbmNlIGNvbW1pdCA0Zjg5NDNmODA4ODMgKCJTVU5SUEM6IFJl
cGxhY2UgZGlyZWN0IHRhc2sgd2FrZXVwcyBmcm9tDQo+IHNvZnRpcnEgY29udGV4dCIpIHRoZXJl
IGhhcyBiZWVuIGEgcmFjZSB0byB0aGUgdmFsdWUgb2YgdGhlIHNrX2VyciBpZiBib3RoDQo+IFhQ
UlRfU09DS19XQUtFX0VSUk9SIGFuZCBYUFJUX1NPQ0tfV0FLRV9ESVNDT05ORUNUIGFyZSBzZXQu
ICBJbiB0aGF0IGNhc2UsDQo+IHdlIG1heSBlbmQgdXAgbG9zaW5nIHRoZSBza19lcnIgdmFsdWUg
dGhhdCBleGlzdGVkIHdoZW4geHNfZXJyb3JfcmVwb3J0IHdhcw0KPiBjYWxsZWQuDQo+IA0KPiBG
aXggdGhpcyBieSByZXZlcnRpbmcgdG8gdGhlIHByZXZpb3VzIGJlaGF2aW9yOiBpbnN0ZWFkIG9m
IHVzaW5nIFNPX0VSUk9SDQo+IHRvIHJldHJpZXZlIHRoZSB2YWx1ZSBhdCBhIGxhdGVyIHRpbWUg
KHdoaWNoIG1pZ2h0IGFsc28gcmV0dXJuIHNrX2Vycl9zb2Z0KSwNCj4gY29weSB0aGUgc2tfZXJy
IHZhbHVlIG9udG8gc3RydWN0IHNvY2tfeHBydCwgYW5kIHVzZSB0aGF0IHZhbHVlIHRvIHdha2UN
Cj4gcGVuZGluZyB0YXNrcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIENvZGRpbmd0
b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+IEZpeGVzOiA0Zjg5NDNmODA4ODMgKCJTVU5SUEM6
IFJlcGxhY2UgZGlyZWN0IHRhc2sgd2FrZXVwcyBmcm9tIHNvZnRpcnEgY29udGV4dCIpDQo+IDg8
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IENoYW5nZXMgb24gVjI6DQo+IAktIG1vdmUgeHBy
dF9lcnIgaW50byBhIGhvbGUgaW4gc3RydWN0IHNvY2tfeHBydA0KPiAJLSBhZGQgYW4gbWVtb3J5
IGJhcnJpZXIgdG8gZW5zdXJlIHRoZSBlcnJvciBpcyB2aXNibGUgdG8gdGhlDQo+IAkgIGVycm9y
X3dvcmtlcg0KPiANCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0c29jay5oIHwg
IDEgKw0KPiAgbmV0L3N1bnJwYy94cHJ0c29jay5jICAgICAgICAgICB8IDE2ICsrKysrKysrLS0t
LS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnRzb2NrLmggYi9p
bmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0c29jay5oDQo+IGluZGV4IDc2MzhkYmU3YmM1MC4uYTk0
MGRlMDM4MDhkIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0c29jay5o
DQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnRzb2NrLmgNCj4gQEAgLTYxLDYgKzYx
LDcgQEAgc3RydWN0IHNvY2tfeHBydCB7DQo+ICAJc3RydWN0IG11dGV4CQlyZWN2X211dGV4Ow0K
PiAgCXN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlCXNyY2FkZHI7DQo+ICAJdW5zaWduZWQgc2hvcnQJ
CXNyY3BvcnQ7DQo+ICsJaW50CQkJeHBydF9lcnI7DQo+ICANCj4gIAkvKg0KPiAgCSAqIFVEUCBz
b2NrZXQgYnVmZmVyIHNpemUgcGFyYW1ldGVycw0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94
cHJ0c29jay5jIGIvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+IGluZGV4IGUyMTc2YzE2N2E1Ny4u
MjVmZjA5N2Q2ZTIxIDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gKysr
IGIvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+IEBAIC0xMjUwLDEyICsxMjUwLDE1IEBAIHN0YXRp
YyB2b2lkIHhzX2Vycm9yX3JlcG9ydChzdHJ1Y3Qgc29jayAqc2spDQo+ICAJCWdvdG8gb3V0Ow0K
PiAgDQo+ICAJdHJhbnNwb3J0ID0gY29udGFpbmVyX29mKHhwcnQsIHN0cnVjdCBzb2NrX3hwcnQs
IHhwcnQpOw0KPiAtCWVyciA9IC1zay0+c2tfZXJyOw0KDQpJdCBsb29rcyBsaWtlICJlcnIiIGlz
IHVudXNlZCBhZnRlciB0aGlzIGNoYW5nZSwgc28gY2FuIHlvdSByZW1vdmUgdGhlIHZhcmlhYmxl
IGRlY2xhcmF0aW9uIGFzDQp3ZWxsPw0KDQpUaGFua3MsDQpBbm5hDQoNCj4gLQlpZiAoZXJyID09
IDApDQo+ICsJdHJhbnNwb3J0LT54cHJ0X2VyciA9IC1zay0+c2tfZXJyOw0KPiArCWlmICh0cmFu
c3BvcnQtPnhwcnRfZXJyID09IDApDQo+ICAJCWdvdG8gb3V0Ow0KPiAgCWRwcmludGsoIlJQQzog
ICAgICAgeHNfZXJyb3JfcmVwb3J0IGNsaWVudCAlcCwgZXJyb3I9JWQuLi5cbiIsDQo+IC0JCQl4
cHJ0LCAtZXJyKTsNCj4gLQl0cmFjZV9ycGNfc29ja2V0X2Vycm9yKHhwcnQsIHNrLT5za19zb2Nr
ZXQsIGVycik7DQo+ICsJCQl4cHJ0LCAtdHJhbnNwb3J0LT54cHJ0X2Vycik7DQo+ICsJdHJhY2Vf
cnBjX3NvY2tldF9lcnJvcih4cHJ0LCBzay0+c2tfc29ja2V0LCB0cmFuc3BvcnQtPnhwcnRfZXJy
KTsNCj4gKw0KPiArCS8qIGJhcnJpZXIgZW5zdXJlcyB4cHJ0X2VyciBpcyBzZXQgYmVmb3JlIFhQ
UlRfU09DS19XQUtFX0VSUk9SICovDQo+ICsJc21wX21iX19iZWZvcmVfYXRvbWljKCk7DQo+ICAJ
eHNfcnVuX2Vycm9yX3dvcmtlcih0cmFuc3BvcnQsIFhQUlRfU09DS19XQUtFX0VSUk9SKTsNCj4g
ICBvdXQ6DQo+ICAJcmVhZF91bmxvY2tfYmgoJnNrLT5za19jYWxsYmFja19sb2NrKTsNCj4gQEAg
LTI0NzAsNyArMjQ3Myw2IEBAIHN0YXRpYyB2b2lkIHhzX3dha2Vfd3JpdGUoc3RydWN0IHNvY2tf
eHBydCAqdHJhbnNwb3J0KQ0KPiAgc3RhdGljIHZvaWQgeHNfd2FrZV9lcnJvcihzdHJ1Y3Qgc29j
a194cHJ0ICp0cmFuc3BvcnQpDQo+ICB7DQo+ICAJaW50IHNvY2tlcnI7DQo+IC0JaW50IHNvY2tl
cnJfbGVuID0gc2l6ZW9mKHNvY2tlcnIpOw0KPiAgDQo+ICAJaWYgKCF0ZXN0X2JpdChYUFJUX1NP
Q0tfV0FLRV9FUlJPUiwgJnRyYW5zcG9ydC0+c29ja19zdGF0ZSkpDQo+ICAJCXJldHVybjsNCj4g
QEAgLTI0NzksOSArMjQ4MSw3IEBAIHN0YXRpYyB2b2lkIHhzX3dha2VfZXJyb3Ioc3RydWN0IHNv
Y2tfeHBydCAqdHJhbnNwb3J0KQ0KPiAgCQlnb3RvIG91dDsNCj4gIAlpZiAoIXRlc3RfYW5kX2Ns
ZWFyX2JpdChYUFJUX1NPQ0tfV0FLRV9FUlJPUiwgJnRyYW5zcG9ydC0+c29ja19zdGF0ZSkpDQo+
ICAJCWdvdG8gb3V0Ow0KPiAtCWlmIChrZXJuZWxfZ2V0c29ja29wdCh0cmFuc3BvcnQtPnNvY2ss
IFNPTF9TT0NLRVQsIFNPX0VSUk9SLA0KPiAtCQkJCShjaGFyICopJnNvY2tlcnIsICZzb2NrZXJy
X2xlbikgIT0gMCkNCj4gLQkJZ290byBvdXQ7DQo+ICsJc29ja2VyciA9IHhjaGcoJnRyYW5zcG9y
dC0+eHBydF9lcnIsIDApOw0KPiAgCWlmIChzb2NrZXJyIDwgMCkNCj4gIAkJeHBydF93YWtlX3Bl
bmRpbmdfdGFza3MoJnRyYW5zcG9ydC0+eHBydCwgc29ja2Vycik7DQo+ICBvdXQ6DQo=
