Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68367DAC8A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfJQMnw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 08:43:52 -0400
Received: from mail-eopbgr800127.outbound.protection.outlook.com ([40.107.80.127]:47910
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731530AbfJQMnw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 08:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4ljhxwzgF17KKn4NnQgvHJ862bf9zQctpo+5X8lGBM1+VrXzkEKxkGhtUWXKO7m+PNpYkuVwwbNegw+rMK2GJ25TwaY9mvWcJ64+A/F08SK3tJUoiYkhF3CKCyM12uolXqjz+N9czm4FUps/7mDnWSa4bVgSrjQLwLE0AqKSRPodbSf2dxfFOpciC4x4hFlIZDPENnsSElrspeR6B5M1ZjcJGL1I5ZkaQTgSBs8dSivnusTQNZJaZvknxkCKf5gWPyGPi3GKhI9x6brMzMgsFPpLBaVpdNC+UQpKhQOTE8Sx0Tw1rjA5epQ+j2kkjNRY+wJUpU74szPoatY+CZRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frse0ZhwE3Rwwp+h6AloQE2hnYmPpBI1IvT0ZZfJeNM=;
 b=AZjwfxcE4OrpnyTNZe4it9piYH3HxhlSsoS61QhF1CE7Gux0WVwAitNPtkkdFBmMWFHjhBGwF7qPqVz0yHOjFmNLPrUIP+/duucvqYEdD+62x33uwgZVbd7m4i0W/UZQYt82ERnfGVxWSPC5MxDbZfseJ+AdFA/x8GVjN96BFnqsSC3N3lcxvfiIDGXNgtQMNTTW7w7erz3Lp+o4rgsCa4b9yDXjn3xNKZwPX/x21n+MzZKL9LUgRKaaxFEdyACnfhgpZNZ76n2o8TuQXuF1Rao02v8rR25T6YIpcBwibE45tu5HHHnzB8ZcqVFKJd/DHkYFP/KMg6dVY6GrTD71rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frse0ZhwE3Rwwp+h6AloQE2hnYmPpBI1IvT0ZZfJeNM=;
 b=ZSBT17Rqgqwghbv/MO4jc979mfy49a8LOOCkKikL1w881mye3IgtZ80NpxCbsSIAbsNwYeIUsQ2h0LPkgXM6Wm2pGuRz0vB4/puyowIKxdeWGnkJwuoAkuZ1Dl+F82rJHaTDozYd/qRuj8gCO3VxMhz6ymmbZUTMfQdTNZXVEg8=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1884.namprd13.prod.outlook.com (10.174.187.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14; Thu, 17 Oct 2019 12:43:47 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c%3]) with mapi id 15.20.2367.016; Thu, 17 Oct 2019
 12:43:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/3] SUNRPC: The TCP back channel mustn't disappear while
 requests are outstanding
Thread-Topic: [PATCH 1/3] SUNRPC: The TCP back channel mustn't disappear while
 requests are outstanding
Thread-Index: AQHVhCyEdkNBkaXjMUiLB8A5l/KGL6dd2LaAgADv94A=
Date:   Thu, 17 Oct 2019 12:43:47 +0000
Message-ID: <3a20dd4df760111365b381e1cc1fe778ef2dc141.camel@hammerspace.com>
References: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
         <87pniwpbuy.fsf@notabene.neil.brown.name>
In-Reply-To: <87pniwpbuy.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [66.187.232.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 176b0297-40b7-4a3c-2e2b-08d752ffa78c
x-ms-traffictypediagnostic: DM5PR1301MB1884:
x-microsoft-antispam-prvs: <DM5PR1301MB1884D6816FDDADC82CBD8692B86D0@DM5PR1301MB1884.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(396003)(366004)(189003)(199004)(446003)(66946007)(99286004)(66446008)(478600001)(14454004)(8936002)(36756003)(2501003)(91956017)(76116006)(64756008)(66556008)(66476007)(102836004)(71190400001)(66066001)(76176011)(26005)(71200400001)(4326008)(4001150100001)(6506007)(14444005)(110136005)(7736002)(486006)(256004)(6512007)(81156014)(6436002)(81166006)(186003)(229853002)(86362001)(6116002)(3846002)(305945005)(11346002)(2616005)(54906003)(2906002)(5660300002)(6486002)(25786009)(8676002)(118296001)(6246003)(316002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1884;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMYFLXfGxtaWma3PVLAL7/PWvfoTyX1qQnj7VX3NIVcck/9wR0pE2EtCnrtiIZwukELaqRiVzJsDsGE2E5a8ctrUOGRlio5KBZL4y6EDZir/kXSPYh2Kb0BWUS8td8UegeuPETm2yaT5HZl55me2NYcJBw5MsM1ivsAUcYqjsELMf0Zs+LtFcKF9PntOUFQNB3JNWrV2MLO/V9SkTFb+gpa8TYq2m5BrKua9HZ8wYC1Fy53Wv1e1pGC7SJDt5vBv+R1rWBV7RF4bAR/joRnUmLpOPCCLmX4ZAK8OkWpntUAgYpv4TkMH8ERVTu1f//xOJqJ6jrF3+fMJqBxZ465N/5j3fm9WXNQY9KhkP5pV9vhvzuEJlXPVcM2OM2BhbCFl7/ModZW/T+pSiM+mX9uUGy2Y9Lk/X1szlETavRR7wak=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C144DE22CAA7948A23168BBAE442BAD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176b0297-40b7-4a3c-2e2b-08d752ffa78c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 12:43:47.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ppy+UDTfDr8ig2GKCb1Duaeg/ZW2FcY8D4zMvCZwoSuTP7wSpEUkV44lttK96EJ4uFIYYJ+puuBKe7hesvJP9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1884
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTE3IGF0IDA5OjI0ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgT2N0IDE2IDIwMTksIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gSWYgdGhl
cmUgYXJlIFRDUCBiYWNrIGNoYW5uZWwgcmVxdWVzdHMgZWl0aGVyIGJlaW5nIHByb2Nlc3NlZCBi
eQ0KPiA+IHRoZQ0KPiA+IHNlcnZlciB0aHJlYWRzLCB0aGVuIHdlIHNob3VsZCBob2xkIGEgcmVm
ZXJlbmNlIHRvIHRoZSB0cmFuc3BvcnQNCj4gPiB0byBlbnN1cmUgaXQgZG9lc24ndCBnZXQgZnJl
ZWQgZnJvbSB1bmRlcm5lYXRoIHVzLg0KPiA+IA0KPiA+IFJlcG9ydGVkLWJ5OiBOZWlsIEJyb3du
IDxuZWlsYkBzdXNlLmRlPg0KPiA+IEZpeGVzOiAyZWEyNDQ5N2ExYjMgKCJTVU5SUEM6IFJQQyBj
YWxsYmFja3MgbWF5IGJlIHNwbGl0IGFjcm9zcw0KPiA+IHNldmVyYWwuLiIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBuZXQvc3VucnBjL2JhY2tjaGFubmVsX3Jxc3QuYyB8IDUgKysrLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9iYWNrY2hhbm5lbF9ycXN0LmMNCj4gPiBi
L25ldC9zdW5ycGMvYmFja2NoYW5uZWxfcnFzdC5jDQo+ID4gaW5kZXggMzM5ZThjMDc3YzJkLi43
ZWIyNTEzNzJmOTQgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3N1bnJwYy9iYWNrY2hhbm5lbF9ycXN0
LmMNCj4gPiArKysgYi9uZXQvc3VucnBjL2JhY2tjaGFubmVsX3Jxc3QuYw0KPiA+IEBAIC0zMDcs
OCArMzA3LDggQEAgdm9pZCB4cHJ0X2ZyZWVfYmNfcnFzdChzdHJ1Y3QgcnBjX3Jxc3QgKnJlcSkN
Cj4gPiAgCQkgKi8NCj4gPiAgCQlkcHJpbnRrKCJSUEM6ICAgICAgIExhc3Qgc2Vzc2lvbiByZW1v
dmVkIHJlcT0lcFxuIiwNCj4gPiByZXEpOw0KPiA+ICAJCXhwcnRfZnJlZV9hbGxvY2F0aW9uKHJl
cSk7DQo+ID4gLQkJcmV0dXJuOw0KPiA+ICAJfQ0KPiA+ICsJeHBydF9wdXQoeHBydCk7DQo+ID4g
IH0NCj4gPiAgDQo+ID4gIC8qDQo+ID4gQEAgLTMzOSw3ICszMzksNyBAQCBzdHJ1Y3QgcnBjX3Jx
c3QgKnhwcnRfbG9va3VwX2JjX3JlcXVlc3Qoc3RydWN0DQo+ID4gcnBjX3hwcnQgKnhwcnQsIF9f
YmUzMiB4aWQpDQo+ID4gIAkJc3Bpbl91bmxvY2soJnhwcnQtPmJjX3BhX2xvY2spOw0KPiA+ICAJ
CWlmIChuZXcpIHsNCj4gPiAgCQkJaWYgKHJlcSAhPSBuZXcpDQo+ID4gLQkJCQl4cHJ0X2ZyZWVf
YmNfcnFzdChuZXcpOw0KPiA+ICsJCQkJeHBydF9mcmVlX2FsbG9jYXRpb24obmV3KTsNCj4gPiAg
CQkJYnJlYWs7DQo+ID4gIAkJfSBlbHNlIGlmIChyZXEpDQo+ID4gIAkJCWJyZWFrOw0KPiA+IEBA
IC0zNjgsNiArMzY4LDcgQEAgdm9pZCB4cHJ0X2NvbXBsZXRlX2JjX3JlcXVlc3Qoc3RydWN0IHJw
Y19ycXN0DQo+ID4gKnJlcSwgdWludDMyX3QgY29waWVkKQ0KPiA+ICAJc2V0X2JpdChSUENfQkNf
UEFfSU5fVVNFLCAmcmVxLT5ycV9iY19wYV9zdGF0ZSk7DQo+ID4gIA0KPiA+ICAJZHByaW50aygi
UlBDOiAgICAgICBhZGQgY2FsbGJhY2sgcmVxdWVzdCB0byBsaXN0XG4iKTsNCj4gPiArCXhwcnRf
Z2V0KHhwcnQpOw0KPiA+ICAJc3Bpbl9sb2NrKCZiY19zZXJ2LT5zdl9jYl9sb2NrKTsNCj4gPiAg
CWxpc3RfYWRkKCZyZXEtPnJxX2JjX2xpc3QsICZiY19zZXJ2LT5zdl9jYl9saXN0KTsNCj4gPiAg
CXdha2VfdXAoJmJjX3NlcnYtPnN2X2NiX3dhaXRxKTsNCj4gPiAtLSANCj4gPiAyLjIxLjANCj4g
DQo+IExvb2tzIGdvb2QuDQo+IFRoaXMgYW5kIHRoZSBuZXh0IHR3bzoNCj4gIFJldmlld2VkLWJ5
OiBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+DQo+IA0KPiBJdCB3b3VsZCBoZWxwIG1lIGlmIHlv
dSBjb3VsZCBhZGQgYSBGaXhlczogdGFnIHRvIGF0IGxlYXN0IHRoZSBmaXJzdA0KPiB0d28uDQoN
Ck5laXRoZXIgaGF2ZSBDYzpzdGFibGUsIGJ1dCB0aGV5IGJvdGggYWxyZWFkeSBoYXZlIEZpeGVz
OiB0YWdzLiBTZWUNCmFib3ZlLg0KDQo+IA0KPiBCVFcsIHdoaWxlIHJldmlld2luZyBJIG5vdGlj
ZXMgdGhhdCBiY19hbGxvY19jb3VudCBhbmQgYmNfc2xvdF9jb3VudA0KPiBhcmUNCj4gYWxtb3N0
IGlkZW50aWNhbC4gIFRoZSB0aHJlZSBwbGFjZXMgd2VyZSB0aGF0IGFyZSBjaGFuZ2VkIHNlcGFy
YXRlbHkNCj4gYXJlDQo+IHByb2JhYmx5IChtaW5vcikgYnVncy4NCj4gRG8geW91IHJlY2FsbCB3
aHkgdGhlcmUgd2VyZSB0d28gZGlmZmVyZW50IGNvdW50ZXJzPyAgSGFzIHRoZSByZWFzb24NCj4g
ZGlzYXBwZWFyZWQ/DQoNCklJUkMsIHRoZSBmb3JtZXIgY29udGFpbnMgdGhlIGNvdW50IG9mIHBy
ZWFsbG9jYXRlZCBzbG90cywgYW5kIHRoZQ0KbGF0dGVyIHRoZSBjb3VudCBvZiBwcmVhbGxvY2F0
ZWQrZHluYW1pYyBzbG90cy4NCg0KVGhhbmtzDQogIFRyb25kDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
