Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FBC234B83
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jul 2020 21:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgGaTQn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jul 2020 15:16:43 -0400
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:10465
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730850AbgGaTQn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 31 Jul 2020 15:16:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiqTI9+KCRw3jpLwSpajpRPLJDXKROiLxMK1sW5tWmWPsdVN3O1k+egwapYQrXEhaxYIMt3qLOLxIkGx28QbjSHvPFh7u+LIhQtxQjlhEwMiWHWjdBUXsfKX+cMYAFUSkXa4DPbuOkQ02/L8JF+mfLf+f4p4njTf+vLfRgWKqMBHQ0KuCHFvJjonTAb1w90yfqHYvGxYRcKspwz5mayvNOCb2+RvPcshtu1193NLupLEezE0CYdaQLeWMAXJyx9QV601rcWsNXwKuTudjWTxATUT9qCOmf2VB3e1rLe2yzx80d2FZSs3wyvQcya8Q7crU4tlENSAljZ4iYfMBYx9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scKuHGQQpn/mwTJPaPF5P780VY74jg1cA5UllJwPjl8=;
 b=NU6DFCLBnjJnN/j6KHxm5rIO1DRiyXWjxCDWS6N5Vkqcx/GwCXxdHtDV5Kfi3cfWEBbEaldQbjdDPVayOLn4ZVF/rp0pkcZ32tR1SVCBf2dY47aPG4LlepDwmCEz/lO6bFoQr5YfZuJ7LCYaGkLqfXNh/HFjTnd/pKC53orkez45udh/ym7yKzxJNJVg7fgx5l3OO2z0FPuCOlKbgxhzzskm1nNdvMGKjA/v0O08wq92LEhkTjG/NJD+jxz+Q06Ud/vr8Lw3EJqsMVhzTDP6ak4PFJTpCvV/ASr3EtExmRmjKCRu4esIKtrEqM8MipRqvsxzo32QQ0jkgy+52Ze/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scKuHGQQpn/mwTJPaPF5P780VY74jg1cA5UllJwPjl8=;
 b=QM+Kuk4OWT34ckeYeViywJbI6zB6CUsClHMxQ9LA5nwEPdmLaXS7TvmYj0CagGhhngGcSGzOdSwTlUKLO1fmpHSDmq3D8BgEKIU8NUNmaoaKWROMqxiYLobA19YiB6PiIEaHt4FM4vwAlhhmpugdLjziW6BK5hpKBbd1GlSQcdg=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3655.namprd13.prod.outlook.com (2603:10b6:610:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9; Fri, 31 Jul
 2020 19:16:40 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 19:16:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] nfs: ensure correct writeback errors are returned on
 close()
Thread-Topic: [PATCH 1/2] nfs: ensure correct writeback errors are returned on
 close()
Thread-Index: AQHWZ2KCzX0RO9Uux0q5FOOKww0hCqkiD3OA
Date:   Fri, 31 Jul 2020 19:16:39 +0000
Message-ID: <cbd94bd68cbdefd06591ae7ba4d57fdd8b619ebf.camel@hammerspace.com>
References: <20200731174614.1299346-1-smayhew@redhat.com>
         <20200731174614.1299346-2-smayhew@redhat.com>
In-Reply-To: <20200731174614.1299346-2-smayhew@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fc6fd01-1dbb-4a90-0046-08d8358640b0
x-ms-traffictypediagnostic: CH2PR13MB3655:
x-microsoft-antispam-prvs: <CH2PR13MB3655E1ABAC8D951CED6860D5B84E0@CH2PR13MB3655.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SNeJ21tPV4MB/lmHkiSOopRevKfAfW2vpNflfl/wtSdTarKzuRxNtKUJtsmu2PCu7U+JqHUtWvijZhsoWCF73Snq8h09f4IoBulwcrAfPYby8dJ7TXLMmtwWtRoT2z9mL+3DfJpNFi3dRt8fzZ6o9lCCIe4ltazzTKK/BYHs6PkmdCjuawkyrC0VrpGIi3IujvraIZyUyv1gp/PhvF7nAy7J2mRvZLjfAWKwvJdNnjo7fQU39oKZ2S76vtgY1hS8ZmLHuv07DfogHjDRC5Phnx+0UB3RVD/5KJpV/h9xetebBaK8qs3p+R8qpr1y4XZZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(376002)(39830400003)(136003)(71200400001)(86362001)(316002)(6512007)(110136005)(186003)(66946007)(76116006)(6486002)(6506007)(91956017)(2616005)(478600001)(66556008)(64756008)(83380400001)(8936002)(2906002)(66476007)(26005)(4326008)(8676002)(36756003)(5660300002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MY1kLWr5e8aviVY31EPAzmqjSaGvLNUFDtRfznlI5D4BxxB0LHrDgyTH5OE98+2+gj9Lb0GrWFitnaoopbWcxfDvbUBRh8J6fMnOcRiTpqykQ9pSJuvbnLrnDjFeOCvRTByHmXi11NXQYf8VOOkB0yeda7JimHF4puFEoS5j46qVyjjMkTuDbaaUC+egEr9ddoSmCC3EC76BcFJnVSkrDG0uRoB4+p6x60lqjfdEDC7RBipxeLKFqLQa/j/VOXvnY8xCh3+Dg7BWFyYGWKuUo0r0rJBuP/rNjeYefLkM/aEbnLn3Nwg0ioZk5gS29UgZBb5ssM8dNdQMByOPdm7ICZvovfwUb4epaG5QBLVvR77kXzftZjRO3gZCIWqRQKPPtHpf63pMIzRSOPqtiWQzlXl4ttlgaYlxG1E5bNojFbOmjaZe9sww2RJtFNmjPCcEMznIr1yyWBriWLoZOKE49QKXLohmgTqL2lATPZjvYKupNgIPiVRAnevfLESJmNXd/m1FZMVM0g+ozxSKpxiIqqNf5FASAWO5hdLdvmWNY0HgCsIc+EeW0CZPlxvCd1HonODv/yXOowFwU/WBo8bUxSBHdt02UOaParaHquXfsAEYTK2w+b1k0yNW5Rz9POANb+zj6yN57R92laVDYzRP6w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBDF1A17D33E2542AB464D0D284668F2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc6fd01-1dbb-4a90-0046-08d8358640b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 19:16:39.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQixAMnO1/atlrbeL3sU0yhIltCQ0VllzQ2DzEQouXC07BKSeJ64iez/qDrxKaIS5JTp0zhXStiHsalhJTWTyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3655
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTMxIGF0IDEzOjQ2IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IG5mc193Yl9hbGwoKSBjYWxscyBmaWxlbWFwX3dyaXRlX2FuZF93YWl0KCksIHdoaWNoIHVzZXMN
Cj4gZmlsZW1hcF9jaGVja19lcnJvcnMoKSB0byBkZXRlcm1pbmUgdGhlIGVycm9yIHRvIHJldHVy
bi4NCj4gZmlsZW1hcF9jaGVja19lcnJvcnMoKSBvbmx5IGxvb2tzIGF0IHRoZSBtYXBwaW5nLT5m
bGFncyBhbmQgd2lsbA0KPiB0aGVyZWZvcmUgb25seSByZXR1cm4gZWl0aGVyIC1FTk9TUEMgb3Ig
LUVJTy4gIFRvIGVuc3VyZSB0aGF0IHRoZQ0KPiBjb3JyZWN0IGVycm9yIGlzIHJldHVybmVkIG9u
IGNsb3NlKCksIG5mc3ssNH1fZmlsZV9mbHVzaCgpIHNob3VsZA0KPiBjYWxsDQo+IGZpbGVfY2hl
Y2tfYW5kX2FkdmFuY2Vfd2JfZXJyKCkgd2hpY2ggbG9va3MgYXQgdGhlIGVycnNlcSB2YWx1ZSBp
bg0KPiBtYXBwaW5nLT53Yl9lcnIuDQo+IA0KPiBGaXhlczogNmZiZGE4OWIyNTdmICgiTkZTOiBS
ZXBsYWNlIGN1c3RvbSBlcnJvciByZXBvcnRpbmcgbWVjaGFuaXNtDQo+IHdpdGgNCj4gZ2VuZXJp
YyBvbmUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTY290dCBNYXloZXcgPHNtYXloZXdAcmVkaGF0LmNv
bT4NCj4gLS0tDQo+ICBmcy9uZnMvZmlsZS5jICAgICB8IDMgKystDQo+ICBmcy9uZnMvbmZzNGZp
bGUuYyB8IDMgKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvZmlsZS5jIGIvZnMvbmZzL2ZpbGUu
Yw0KPiBpbmRleCBmOTYzNjdhMjQ2M2UuLmVlZWY2NTgwMDUyZiAxMDA2NDQNCj4gLS0tIGEvZnMv
bmZzL2ZpbGUuYw0KPiArKysgYi9mcy9uZnMvZmlsZS5jDQo+IEBAIC0xNDgsNyArMTQ4LDggQEAg
bmZzX2ZpbGVfZmx1c2goc3RydWN0IGZpbGUgKmZpbGUsIGZsX293bmVyX3QgaWQpDQo+ICAJCXJl
dHVybiAwOw0KPiAgDQo+ICAJLyogRmx1c2ggd3JpdGVzIHRvIHRoZSBzZXJ2ZXIgYW5kIHJldHVy
biBhbnkgZXJyb3JzICovDQo+IC0JcmV0dXJuIG5mc193Yl9hbGwoaW5vZGUpOw0KPiArCW5mc193
Yl9hbGwoaW5vZGUpOw0KPiArCXJldHVybiBmaWxlX2NoZWNrX2FuZF9hZHZhbmNlX3diX2Vycihm
aWxlKTsNCj4gIH0NCj4gIA0KPiAgc3NpemVfdA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRm
aWxlLmMgYi9mcy9uZnMvbmZzNGZpbGUuYw0KPiBpbmRleCA4ZTVkNjIyM2RkZDMuLjc3YmY5YzEy
NzM0YyAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRmaWxlLmMNCj4gKysrIGIvZnMvbmZzL25m
czRmaWxlLmMNCj4gQEAgLTEyNSw3ICsxMjUsOCBAQCBuZnM0X2ZpbGVfZmx1c2goc3RydWN0IGZp
bGUgKmZpbGUsIGZsX293bmVyX3QgaWQpDQo+ICAJCXJldHVybiBmaWxlbWFwX2ZkYXRhd3JpdGUo
ZmlsZS0+Zl9tYXBwaW5nKTsNCj4gIA0KPiAgCS8qIEZsdXNoIHdyaXRlcyB0byB0aGUgc2VydmVy
IGFuZCByZXR1cm4gYW55IGVycm9ycyAqLw0KPiAtCXJldHVybiBuZnNfd2JfYWxsKGlub2RlKTsN
Cj4gKwluZnNfd2JfYWxsKGlub2RlKTsNCj4gKwlyZXR1cm4gZmlsZV9jaGVja19hbmRfYWR2YW5j
ZV93Yl9lcnIoZmlsZSk7DQo+ICB9DQo+ICANCj4gICNpZmRlZiBDT05GSUdfTkZTX1Y0XzINCg0K
SSBkb24ndCB0aGluayB0aGlzIG9uZSBpcyBjb3JyZWN0LiBUaGUgY29udHJhY3Qgd2l0aCBQT1NJ
WCBpcyB0aGF0IHdlDQphbHdheXMgZGVsaXZlciB0aGUgZXJyb3Igb24gZnN5bmMoKS4gSWYgd2Ug
Y2FsbA0KZmlsZV9jaGVja19hbmRfYWR2YW5jZV93Yl9lcnIoKSBoZXJlIGluIG5mc19maWxlX2Zs
dXNoKCksIHRoZW4gdGhhdA0KbWVhbnMgd2UgZWF0IHRoZSBlcnJvciBiZWZvcmUgaXQgY2FuIGdl
dCBkZWxpdmVyZWQgdG8gZnN5bmMoKS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=
