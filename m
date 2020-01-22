Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7D145BA5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 19:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgAVSlA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 13:41:00 -0500
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:6218
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbgAVSlA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Jan 2020 13:41:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFUUsyPAjJwXTEY9kfMgPZSTTz6Kx5J+j8ZSKJ0uVnUf+1Tf9B5fT0gb/EfbZgVJMGqfg55w+DRlrkpEL1OaFo+Oifw/DltF0uL6MboQdOsHIfPw/+4I9wdBxN5iCjl/2z3VT6hSZil4OvpUSNEmu6xCH+yiwpPhZCEqRfJhjEYu2xImkKQKPcDuhZJaHXpBIvf42kug6+8ElCoYsDp5wYoDMgCPHeQ4sY8K9IT0Bnog4MyiN2TxACibyc3SfbJllyZ7aOxdZlKTuh+fLPOqoZA2oUDqzoGpjavz6O9jQ8FJjNIb+eI9MlNv4oqvTa0yFyXq++ZOAHt8jwx2ArXp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt5vZBOQEYC5Ju00mOcAKSRI85DWXKzvgRz9MT9bujY=;
 b=gqAY/LizXDGfDsZ1G7rNkhhKE7GEaYL3y+BU/YYAZtiY33oODd9/Y3tH+Nw1AhDF9NKszAiwiKh9rypsBC6Aa/3sye67tGx91Dvwh+twc3jdppT3d2luNPtEjY4N8Nn5fystwZrKFnrZztDGIvqokPykt+JTfNTWbGb5LjQjILXjNnEh0z9PmJG8qEPdy82uFXjLTkY775CANJ3uKy785ruFA0qFeegH6hughRi8P7Z5YySLNGQNzL6O8E23PwH5UZPzNXFnIlJJaTtTdvYZAHdn2iAEeCdNqtRUxm7BC/6x0BMYWwbKZeJ0Di6+PR1Xo0AyqpbK0OfpKcjX4s/Uvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt5vZBOQEYC5Ju00mOcAKSRI85DWXKzvgRz9MT9bujY=;
 b=GZQFTh1YgdPCCtuFldT9Qn8CcL/Nr4QT4aVm7qDUKZdOwtwHryWfKztz0dYRNAnS3Se0t308KQx7AilrSo+pEcCbd+67qWCT7WoEnW5YK/ZicPrXZ/Te80NdRn13kBNMfDms2XJ+eqK37wgEjU8bGWZfZTnNXCIWbeJpshMqkJU=
Received: from BL0PR06MB4370.namprd06.prod.outlook.com (10.167.241.142) by
 BL0PR06MB4770.namprd06.prod.outlook.com (52.132.14.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 18:40:53 +0000
Received: from BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1]) by BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 18:40:52 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.2 re-initialize cn_resp in case of a retry
Thread-Topic: [PATCH 1/1] NFSv4.2 re-initialize cn_resp in case of a retry
Thread-Index: AQHV0Kgxn+Q9LFFMGEeTzJegXvI3FKf3BZ6A
Date:   Wed, 22 Jan 2020 18:40:50 +0000
Message-ID: <a4b08f6ae6cd6edd62a0d26448d6082c35dd5049.camel@netapp.com>
References: <20200121221441.29521-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200121221441.29521-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c00ebd3-c906-4341-0745-08d79f6a9bf4
x-ms-traffictypediagnostic: BL0PR06MB4770:
x-microsoft-antispam-prvs: <BL0PR06MB47708F3FFD401A265CB030E3F80C0@BL0PR06MB4770.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(66556008)(66446008)(64756008)(478600001)(110136005)(91956017)(36756003)(8936002)(71200400001)(66946007)(6506007)(186003)(76116006)(81156014)(316002)(81166006)(66476007)(86362001)(8676002)(2616005)(26005)(5660300002)(4326008)(6512007)(6486002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR06MB4770;H:BL0PR06MB4370.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGavC8Df7IhVhInxAForLUsVaeR+p+/+RGeG64tZ+RLAXARiQVUncedD57ic7ZhXjrHIhTpA5SS3LKaBizGVrqCXmVaZL1InWPgS2/zO8C/HFDeUMQOSGQlfGxI6rSaRPGHkdLu4/i+7xTKlsppU+ooX4kNJRwSoR9tvVU699zKiqC005A5PWyv+ZD7YhfSJ9vcZMl9MJj0YlNN5S09zQW2zZeAtZ1w6uRh6Xd1+FoH7CSWrXc/6qcTygVBUC61YxeB7ImCxTFXG9hjN/spW+RZCaWQGFBO0J1Sg2RfQItcfvuXWBTSBYKikgFivHklK/cgB1s8xLJGof4tUKpyiQMItlNGf271Q2nLyOsnkxgCN7mmEBvRM+Ja8vjMhJOjcBIM1c1Raevo+lc0buG/MveWx9ZS8ljUZv90xh14BOC0bwlJ5aIvx1b9E5hLQ1GzU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF4C28AB2A248544AE5CFDCC4D7861E8@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c00ebd3-c906-4341-0745-08d79f6a9bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 18:40:51.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nr1kl5+PuN8AEuinxySDaSztubj+14NxMa7B8F6vgj+WMQDUGUAIWGjYi1eFncMZzBouFvCd4wnFgNUu5AfkHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4770
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gVHVlLCAyMDIwLTAxLTIxIGF0IDE3OjE0IC0wNTAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5j
b20+DQo+IA0KPiBJZiBuZnM0Ml9wcm9jX2NvcHkgcmV0dXJuZWQgYSBFQUdBSU4sIHdlIG5lZWQg
dG8gcmUtaW5pdGlhbGl6ZSB0aGUNCj4gbWVtb3J5IGluIGNhc2UgbWVtb3J5IGFsbG9jYXRpb24g
ZmFpbHMuDQoNCkkgZ3Vlc3MgSSdtIG5vdCBzdXJlIGhvdyB3ZSB3b3VsZCBoaXQgdGhpcy4gRG9l
c24ndCBremFsbG9jKCkgcmV0dXJuIE5VTEwgaWYgdGhlDQptZW1vcnkgYWxsb2NhdGlvbiBmYWls
cz8NCg0KPiANCj4gRml4ZXM6IDY2NTg4YWJlMiAoIk5GU3Y0LjIgZml4IGtmcmVlIGluIF9fbmZz
NDJfY29weV9maWxlX3JhbmdlIikNCj4gUmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxs
a3BAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogSnVsaWEgTGF3YWxsIDxqdWxpYS5sYXdhbGxA
bGlwNi5mcj4NCj4gU2lnbmVkLW9mZi1ieTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFw
cC5jb20+DQo+IC0tLQ0KPiAgZnMvbmZzL25mczRmaWxlLmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9uZnMvbmZzNGZpbGUuYyBiL2ZzL25mcy9uZnM0ZmlsZS5jDQo+IGluZGV4IDYyMGRlOTAu
LjlmNzJlZmUgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0ZmlsZS5jDQo+ICsrKyBiL2ZzL25m
cy9uZnM0ZmlsZS5jDQo+IEBAIC0xNzcsOCArMTc3LDEwIEBAIHN0YXRpYyBzc2l6ZV90IF9fbmZz
NF9jb3B5X2ZpbGVfcmFuZ2Uoc3RydWN0IGZpbGUNCj4gKmZpbGVfaW4sIGxvZmZfdCBwb3NfaW4s
DQo+ICAJcmV0ID0gbmZzNDJfcHJvY19jb3B5KGZpbGVfaW4sIHBvc19pbiwgZmlsZV9vdXQsIHBv
c19vdXQsIGNvdW50LA0KPiAgCQkJCW5zcywgY25ycywgc3luYyk7DQo+ICBvdXQ6DQo+IC0JaWYg
KCFuZnM0Ml9maWxlc19mcm9tX3NhbWVfc2VydmVyKGZpbGVfaW4sIGZpbGVfb3V0KSkNCj4gKwlp
ZiAoIW5mczQyX2ZpbGVzX2Zyb21fc2FtZV9zZXJ2ZXIoZmlsZV9pbiwgZmlsZV9vdXQpKSB7DQo+
ICAJCWtmcmVlKGNuX3Jlc3ApOw0KPiArCQljbl9yZXNwID0gTlVMTDsNCj4gKwl9DQo+ICAJaWYg
KHJldCA9PSAtRUFHQUlOKQ0KPiAgCQlnb3RvIHJldHJ5Ow0KPiAgCXJldHVybiByZXQ7DQo=
