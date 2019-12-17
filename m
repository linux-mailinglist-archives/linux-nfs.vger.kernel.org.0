Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C7122EEA
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2019 15:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfLQOhk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 09:37:40 -0500
Received: from mail-eopbgr690099.outbound.protection.outlook.com ([40.107.69.99]:11141
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbfLQOhk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Dec 2019 09:37:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U13xv9OEFioB7VPW2uqTl5+f+eYvtEtcK+5RprHJOuJ+Y4YDTs+D/bg8Tv8L7KJPevxJ1s5IeHXTFZlb1pP7AiPaDZ3F49aRqrJPEZrQeAc3XzvN8c3Dl2ip2BIA9OG7Eh+z3X7i38WpujafB1E7KqLbj6UxMVigQ47xZnBGbn6KwZ8jPPdqCaXH4h50oZxJgrkBByns0Kd/Ani9f/Trks2m5pnT+Xah9G2m6DiYkPL7OBaFnJgW/Rw31R6KJVe5UbGM+wxWH88g9GZo1E8hjO8/tGoyJ5TI1wH3xHMrbAKNiCLx9VVgaw7GNVSsOdjsB0/EQYpk+df4g0cx3ZJlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh6NrdW2ka+MOhZf8qmIXu7HDKreWJWTR4Y95cu5gAU=;
 b=L/Wd3Gnp9lx0/oswvwTnTEjj8xpGKY31AOxBGjVx4x3a1LOD3xYF+a7mi+f54Lc6gzWHbzT2jV/J7GFWpFII44Y8rqeUcm4jSKwpnVcU4cEvMYGghkHg0fBAjKSy5eDxC86jxb5MniGPxP0fZRIjsyrhqRTBJbKGKtanGR6KjDf1u4vc6aIyiP1QAjmzdhk0xPusPQHCOv1zDlhHTHHD/Z9guk9+YW4K81TemsP6Vli61Zuusjx33vDUSv2BCat2sqRRVA8hpQOEW5OMNh+HiKQRwhO6ErGs5iHeDGCsHZJ0NAPg/EAiLhep+DHbR0DlG4tfEPWEFOQr48y4y/DzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh6NrdW2ka+MOhZf8qmIXu7HDKreWJWTR4Y95cu5gAU=;
 b=ABG56beS6uwFD9GFUFMKGfu+MTQCPNrkw8eXuU9XfYCi2MryzCGBG52SEYChp0WNOc8c0UhuD05zghnVNMwwsnKTe9wT/CM3FMbYG5JFQyOCcY/kCuJin17RPU70ljtPgdlSt9u8ENxyQzn++Rskikwm6KJkCL1lqd+prOvilNc=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2043.namprd13.prod.outlook.com (10.174.185.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.12; Tue, 17 Dec 2019 14:37:37 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Tue, 17 Dec 2019
 14:37:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: nfs: fix a possible sleep-in-atomic-context bug in
 _pnfs_grab_empty_layout()
Thread-Topic: [PATCH] fs: nfs: fix a possible sleep-in-atomic-context bug in
 _pnfs_grab_empty_layout()
Thread-Index: AQHVtN6WwQ38ew9BeEuIRI7sF9jXW6e+ZU8A
Date:   Tue, 17 Dec 2019 14:37:37 +0000
Message-ID: <ff4e1443d70acc88bba68f87650c7b5118c63f2b.camel@hammerspace.com>
References: <20191217133319.11861-1-baijiaju1990@gmail.com>
In-Reply-To: <20191217133319.11861-1-baijiaju1990@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c90bfc07-fb72-4f56-8594-08d782fea97b
x-ms-traffictypediagnostic: DM5PR1301MB2043:
x-microsoft-antispam-prvs: <DM5PR1301MB2043CBD1EFDD781ACAD50DBAB8500@DM5PR1301MB2043.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(39840400004)(346002)(199004)(189003)(186003)(26005)(508600001)(81166006)(8676002)(71200400001)(81156014)(86362001)(2906002)(64756008)(6506007)(66446008)(8936002)(66476007)(66556008)(36756003)(4001150100001)(66946007)(54906003)(76116006)(91956017)(5660300002)(6486002)(6512007)(2616005)(4326008)(110136005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2043;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHYEsrmn5dfkDyNpdq4mKSSUjhkpic4vOng09PE8Iq8U7m6QLU05vjxRdQmr2glwKnv8eGnq4Rp1saD56BMngtBOxOtL9kC4nIHXsl5Tu+OdqOlcTYu0+xqx+Go05q8JiQoo8CqV25IFe47bGXJI4nX+oG075OVkv5AQTD0ekBQopDFvDDmp9pd7kSBgStqK4w4V0m4svc0yg9ATFSUv/F2rOdVjkbb6GEj2dnmnNyLn8DCmEL4xPuPWquzxr+zwP/FZJzHHrGh/OPBqgfpsJIIxanBiCsX38fYAKJ2Yzj4QG65Vd4lXvaJ7REy8DUUS9iE6VSPml0eSdxg3UWmnoRknAOruviwLOEqdP5ATFcSE1a4S6+DMKipN+AKGNWSxMTgQqroZXQb4+yylEUTkUnNvZ6jKp3fcRwVWXy15/TNneSs1uui6unm7W0ChUxLf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C9FED5191AF27418000065ED4685C04@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90bfc07-fb72-4f56-8594-08d782fea97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 14:37:37.2663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJqxAIUuI3KLKGFHPjyLgdkMM2Fysb10ayhh9nd4z/6M4C5CmPmCSfNvPtMzm0Mt74g0wFPOrvI5I3qVP79yAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2043
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDIxOjMzICswODAwLCBKaWEtSnUgQmFpIHdyb3RlOg0KPiBU
aGUgZmlsZXN5c3RlbSBtYXkgc2xlZXAgd2hpbGUgaG9sZGluZyBhIHNwaW5sb2NrLg0KPiBUaGUg
ZnVuY3Rpb24gY2FsbCBwYXRoIChmcm9tIGJvdHRvbSB0byB0b3ApIGluIExpbnV4IDQuMTkgaXM6
DQo+IA0KPiBmcy9uZnMvcG5mcy5jLCAyMDUyOiANCj4gCXBuZnNfZmluZF9hbGxvY19sYXlvdXQo
R0ZQX0tFUk5FTCkgaW4gX3BuZnNfZ3JhYl9lbXB0eV9sYXlvdXQNCj4gZnMvbmZzL3BuZnMuYywg
MjA1MTogDQo+IAlzcGluX2xvY2sgaW4gX3BuZnNfZ3JhYl9lbXB0eV9sYXlvdXQNCj4gDQo+IHBu
ZnNfZmluZF9hbGxvY19sYXlvdXQoR0ZQX0tFUk5FTCkgY2FuIHNsZWVwIGF0IHJ1bnRpbWUuDQo+
IA0KPiBUbyBmaXggdGhpcyBwb3NzaWJsZSBidWcsIEdGUF9LRVJORUwgaXMgcmVwbGFjZWQgd2l0
aCBHRlBfQVRPTUlDIGZvcg0KPiBwbmZzX2ZpbmRfYWxsb2NfbGF5b3V0KCkuDQo+IA0KPiBUaGlz
IGJ1ZyBpcyBmb3VuZCBieSBhIHN0YXRpYyBhbmFseXNpcyB0b29sIFNUQ2hlY2sgd3JpdHRlbiBi
eQ0KPiBteXNlbGYuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaWEtSnUgQmFpIDxiYWlqaWFqdTE5
OTBAZ21haWwuY29tPg0KPiAtLS0NCj4gIGZzL25mcy9wbmZzLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9uZnMvcG5mcy5jIGIvZnMvbmZzL3BuZnMuYw0KPiBpbmRleCBjZWMzMDcwYWI1NzcuLmNm
YmUxNzBmMDY1MSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL3BuZnMuYw0KPiArKysgYi9mcy9uZnMv
cG5mcy5jDQo+IEBAIC0yMTM4LDcgKzIxMzgsNyBAQCBfcG5mc19ncmFiX2VtcHR5X2xheW91dChz
dHJ1Y3QgaW5vZGUgKmlubywNCj4gc3RydWN0IG5mc19vcGVuX2NvbnRleHQgKmN0eCkNCj4gIAlz
dHJ1Y3QgcG5mc19sYXlvdXRfaGRyICpsbzsNCj4gIA0KPiAgCXNwaW5fbG9jaygmaW5vLT5pX2xv
Y2spOw0KPiAtCWxvID0gcG5mc19maW5kX2FsbG9jX2xheW91dChpbm8sIGN0eCwgR0ZQX0tFUk5F
TCk7DQo+ICsJbG8gPSBwbmZzX2ZpbmRfYWxsb2NfbGF5b3V0KGlubywgY3R4LCBHRlBfQVRPTUlD
KTsNCj4gIAlpZiAoIWxvKQ0KPiAgCQlnb3RvIG91dF91bmxvY2s7DQo+ICAJaWYgKCF0ZXN0X2Jp
dChORlNfTEFZT1VUX0lOVkFMSURfU1RJRCwgJmxvLT5wbGhfZmxhZ3MpKQ0KDQpJJ20gbm90IHNl
ZWluZyB3aHkgdGhpcyBpcyBuZWNlc3NhcnkuIEFzIGZhciBhcyBJIGNhbiBzZWUsDQpwbmZzX2Zp
bmRfYWxsb2NfbGF5b3V0KCkgd2lsbCByZWxlYXNlIHRoZSBpbm8tPmlfbG9jayBiZWZvcmUgc2xl
ZXBpbmcuDQoNCkZhbHNlIHBvc2l0aXZlPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
