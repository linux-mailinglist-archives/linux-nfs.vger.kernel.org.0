Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F443B0FAA
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfILNPI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 09:15:08 -0400
Received: from mail-eopbgr810134.outbound.protection.outlook.com ([40.107.81.134]:9568
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731283AbfILNPI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 09:15:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmjtLoTTyok9MZXyL+iJ10w5XKvm4VRaL1l/2ktOuZWT0X9GMwIPaYwv08r7domcGi0fa7iNdgRTtDxLNUjeKSNzUxfyPA7UMf1+ZkIGUP7rL9MqHpenUEZIXRDKZCupxNqtL1S2QBSMMDbPLChgzI76CwZCiblKHKKAPP8irkLq6PjuNoNdYP5m6jsDKz6xRxIJhKZaTPZJ8aOLcU4k0vmZqLDBrLdH9ybfvyiQrY1GbzP0aWIjyiktoRTzevj5MiCxAhYBqM7cDnECivffdX33Bt6ymcBWa/CEArsS/fGrutFqMRC2DNS+gTu+u/llzYrlih7MPaQ08Jlw6D36Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBdHysx2Cr7wPbHrjPDDec+qrq99Zx1GbNuOAkMXx9M=;
 b=cE4JwNIX0/KS6AcQbQDMgYXm4itQDRQ4U8/WI8La2Ls1UYsbw5E1T9mEBn9bRdDBMHg8ZSUgOH/6xOIkvuIOpFYpgkndVC6rPz2o+86UynphwWt8rKi9qrZiYSINaGukcH4UIznlAhneCzlM4FJncYVuA/sz/TgvdBPMRsTcYy/taSPLhQgjNOxJdeWGbWUlOeQj1gvpS4uAPCqdMlD587jgIqyogYKcX1wIyj2l3+hFwnSfq3rLtNKhpFHhraA4Ea/i/7+gP45iXW8fZgJWNh65/cMvWn4Q1P4C/agZSm4Cgir2il2cYVydW/OkK2DEYxPsWXpA+h3OJI3V6FTWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBdHysx2Cr7wPbHrjPDDec+qrq99Zx1GbNuOAkMXx9M=;
 b=LiC0J+9Tja9i5z5otEMZhfCicYwVhROGrje2vwUmM8W/TGvQfz2MLpHJ2Pu5hMVFGqRSgsYYotp9cUi63vBxAAr3ijVIcQBtVeX986+4iM7GGN7kL/jBH9YJ2ilh+fN+AJbof+nCnk3oWtpNafDOKp8oUoLjmhwCfmzrWuUxFnQ=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1500.namprd13.prod.outlook.com (10.175.109.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Thu, 12 Sep 2019 13:14:24 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 13:14:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "tibbs@math.uh.edu" <tibbs@math.uh.edu>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux@stwm.de" <linux@stwm.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "km@cm4all.com" <km@cm4all.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Regression in 5.1.20: Reading long directory fails
Thread-Topic: Regression in 5.1.20: Reading long directory fails
Thread-Index: AQHVUfDuoAq39fX+s0K+L+pluMBkM6cHnsTegAlOTYCAAAwCNIAJQZHggAAlEwCAABHoXoAAKhIAgABG1wuAA/3qgIAAZExXgAAA1wCAB5GfgIAAA/sAgAAM/YCAAADmAIAAAysAgAACpICAAAEVAIABN6+AgAAGjQCAAARdgIAAAYsA
Date:   Thu, 12 Sep 2019 13:14:24 +0000
Message-ID: <274f7ceff9a840023c299ba750ff7ccc0d00897c.camel@hammerspace.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
         <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
         <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
         <ufad0ggrfrk.fsf@epithumia.math.uh.edu>
         <20190906144837.GD17204@fieldses.org>
         <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
         <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
         <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
         <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
         <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
         <F1EC95D2-47A3-4390-8178-CAA8C045525B@oracle.com>
         <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
         <FAA4DD3D-C58A-4628-8FD5-A7E2E203B75A@redhat.com>
         <B8CDE765-7DCE-4257-91E1-CC85CB7F87F7@oracle.com>
         <EC2B51FB-8C22-4513-B59F-0F0741F694EB@redhat.com>
         <c8bc4f95e7a097b01e5fff9ce5324e32ee9d8821.camel@hammerspace.com>
         <57185A91-0AC8-4805-B6CE-67D629F814C2@redhat.com>
In-Reply-To: <57185A91-0AC8-4805-B6CE-67D629F814C2@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.167.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ff91e6b-de47-4689-3c55-08d7378321e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1500;
x-ms-traffictypediagnostic: DM5PR13MB1500:
x-microsoft-antispam-prvs: <DM5PR13MB150010D3E0C9AB9A7CAA2EFAB8B00@DM5PR13MB1500.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39830400003)(346002)(396003)(136003)(189003)(199004)(53936002)(26005)(4744005)(102836004)(53546011)(256004)(2906002)(6512007)(71200400001)(71190400001)(5640700003)(186003)(6506007)(476003)(2616005)(11346002)(446003)(229853002)(305945005)(81166006)(81156014)(1730700003)(8676002)(7736002)(6436002)(6486002)(14454004)(486006)(99286004)(64756008)(6916009)(316002)(76116006)(91956017)(478600001)(8936002)(118296001)(5660300002)(76176011)(4326008)(86362001)(6246003)(54906003)(25786009)(66556008)(66446008)(6116002)(66946007)(66066001)(66476007)(3846002)(2351001)(36756003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1500;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4aYIdw14eWjYbcFdk/2GCFVT+LiAIpWOD/5f0CEtNwArvq5RCFaX+CygAcpEU1MFWPL0rrlBr7ZQ0W+F2swqQnDuIDinjh828Z4Rf/cjUQfGgPNyN88WWQytZaHQIW6SXVwLUU88KInw+svTuVvmbOl9oIFDzYLwGLzkYJwvXUNLbuyHoyQlnWRJqRvu4TFVLY9IkaG9X+BAqwgBlcmPxV5nxgBx309yYL03oET3hsY4muudcDUCKq10/2aAu8nbItpbikucwwW9o4rKUF60W84vX7ucOWsvKx8xotL/QD8/c/oJHZQSvgp79705PUST3nqODPp9aWNtqcxWjQ/+mwMYPCnDaeDZ+foTV/m6pEZqACQAn9gIzXctc6lh9p3S4pbzNBe1NXR95JobduYvBVTsq/UQRTaQ+rHrMg1kkfE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BD7AC8C79A3FB4B9A495B20563BF7BC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff91e6b-de47-4689-3c55-08d7378321e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:14:24.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gU040V/3D1tDYeLdxtBX1iqagLv9aoKdhQ8T0jBoVxPMkA4CNFY1QKVcV4AwuFCu3KGvsDkSpGDw+bxl1tRsqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1500
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDA5OjA4IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxMiBTZXAgMjAxOSwgYXQgODo1MywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiA+IExldCdzIHBsZWFzZSBqdXN0IHNjcmFwIHRoaXMgZnVuY3Rpb24gYW5kIHJld3JpdGUgaXQg
YXMgYSBnZW5lcmljDQo+ID4gZnVuY3Rpb24gZm9yIHJlYWRpbmcgdGhlIE1JQy4gSXQgY2xlYXJs
eSBpcyBub3QgYSBnZW5lcmljIGZ1bmN0aW9uDQo+ID4gZm9yDQo+ID4gcmVhZGluZyBhcmJpdHJh
cnkgbmV0b2JqcywgYW5kIG1vZGlmaWNhdGlvbnMgbGlrZSB0aGUgYWJvdmUganVzdA0KPiA+IG1h
a2UNCj4gPiB0aGUgbWlzbm9tZXIgcGFpbmZ1bGx5IG9idmlvdXMuDQo+ID4gDQo+ID4gTGV0J3Mg
cmV3cml0ZSBpdCBhcyB4ZHJfYnVmX3JlYWRfbWljKCkgc28gdGhhdCB3ZSBjYW4gc2ltcGxpZnkg
aXQNCj4gPiB3aGVyZQ0KPiA+IHBvc3NpYmxlLg0KPiANCj4gT2suICBJIHdhbnQgdG8gYXNzdW1l
IHRoZSBtaWMgd2lsbCBub3QgbGFuZCBpbiB0aGUgaGVhZCwgYnV0IEkgYW0gbm90DQo+IHN1cmUu
Lg0KPiBJcyB0aGVyZSBhIHNjZW5hcmlvIHdoZXJlIHRoZSBtaWMgbWlnaHQgbGFuZCBpbiB0aGUg
aGVhZCwgb3IgaXMgdGhhdA0KPiBiaXQgb2YNCj4gdGhlIGN1cnJlbnQgZnVuY3Rpb24gbGVmdCBv
dmVyIGZyb20gb3RoZXIgdXNlcz8NCg0KSXQgaXMgbGlrZWx5IHRvIGxhbmQgaW4gdGhlIGhlYWQg
Zm9yIG1vc3QgUlBDIGNhbGxzIHRoYXQgaGF2ZSBzaG9ydA0KcmVwbGllcy4gUGFydGljdWxhcmx5
IGluIGVycm9yIGNhc2VzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==
