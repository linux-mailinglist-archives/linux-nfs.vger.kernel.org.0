Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A00D65FFC
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2019 21:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGKT3w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jul 2019 15:29:52 -0400
Received: from mail-eopbgr730116.outbound.protection.outlook.com ([40.107.73.116]:8391
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfGKT3w (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Jul 2019 15:29:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klhOfv/xB3TfO2/zDgWNyg4Y3v6dCe9Gu1D4HbngCcfehRk+X1+3UfD7+CKCEVw3Uz/xb9HbJaS7Iqntf8FC0cYYHjs11OYYpHd5gn7KZd28CNd0KvaQVQXLKKZier/UbU4Kuim0megrdV8mtR1VijIJVO855LW5ypIKm/8enJUArHvUkaq9laHxG+RYP6Oa/Pwy31KXESppOmrbPAQhthlFOFRL3WBZmUYtrjaNM2x9RI6PXbkTdXmvdCheeBZ68n0Yzt6V75CrzCXEkszieEVu/c0laUqYmMklHm4DsrKUB0/kmty6JACcmW8cbQipPdYZ3FPcOJSfFUtwrGItDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueMRPUCbb7q4rhNAT20tEfsNc1Zuf0Bsq00h9l2nHRI=;
 b=c8yirkz3DURE4fpXLZCB3WBj9F4tanmy4li66AI/zCRYdZA45EP2PjKQJuhOf4mbMdEx/OcAm+O6R+TMzCgV2NzwXG6BzkUDqZSZekxMYIf2VplvKd4dmMi5E9RP/cbsAGuEIQYXoh4T+X9cpR2Oe6MlnPE/xMrx6dJsp1QDwblmiRs5GspZ1tdm7h2aVYOQVZTVDCmK+Vlu29X7aXfYhx1ZmbDC7YD6Ie+cBcuzbXOQFKuj5Sa3LBH12Q9x8zAQQlUR1e0HuvP7P6pMSOIR3/rPn6KMEXUjraR9Jl7fPiZcCpDbUHVnf4mBrUlefZdLoywCR5+QK+mVIMurle/Pgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=hammerspace.com;dmarc=pass action=none
 header.from=hammerspace.com;dkim=pass header.d=hammerspace.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueMRPUCbb7q4rhNAT20tEfsNc1Zuf0Bsq00h9l2nHRI=;
 b=dQh/cYbLHWewqDq0lC10UuyJ0Gj9phDlpGE1cXw2eRVHSe2InCDCesRpcHGS96qqupORIIFgtJpeizmjINpd5X0Y4oFauRIji/0xMAeRKGQ3Qw9Ybbkx27f1QT502jeaAJ88KKbbcmToHwPopB9CvJtTtvvdWhaIH/hwwe6NGnE=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1355.namprd13.prod.outlook.com (10.168.120.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.7; Thu, 11 Jul 2019 19:29:48 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93%5]) with mapi id 15.20.2094.007; Thu, 11 Jul 2019
 19:29:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>,
        "neilb@suse.com" <neilb@suse.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: multipath patches
Thread-Topic: multipath patches
Thread-Index: AQHVOBvNTX2CipqtKUShUmL2lFq8ZqbFzciA
Date:   Thu, 11 Jul 2019 19:29:48 +0000
Message-ID: <1d019c416f69aa7f3ba7fed3bcfd4c08088fba57.camel@hammerspace.com>
References: <CAN-5tyF2AL8Bx5QS3HGYzzvjw5vnkfmFxWEmqe_BWfvWCVtDFg@mail.gmail.com>
In-Reply-To: <CAN-5tyF2AL8Bx5QS3HGYzzvjw5vnkfmFxWEmqe_BWfvWCVtDFg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7fd4b21-5729-45ae-b740-08d706362367
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1355;
x-ms-traffictypediagnostic: DM5PR13MB1355:
x-microsoft-antispam-prvs: <DM5PR13MB135528834B50707E146F9C9AB8F30@DM5PR13MB1355.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(6506007)(4326008)(2616005)(486006)(76116006)(102836004)(7116003)(68736007)(3480700005)(2501003)(66946007)(446003)(66066001)(256004)(221733001)(11346002)(476003)(86362001)(36756003)(76176011)(478600001)(186003)(26005)(8936002)(99286004)(305945005)(8676002)(25786009)(81166006)(7736002)(81156014)(66446008)(3846002)(64756008)(53936002)(229853002)(66476007)(6436002)(2171002)(66556008)(6246003)(4744005)(6486002)(6512007)(110136005)(71200400001)(71190400001)(316002)(14454004)(5660300002)(2906002)(118296001)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1355;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rr9dgLu8z4QeZ1tGdh0ddgdVats/4A4ez/GlcZl51C1kvM1VOfBcdYmWuvZ2EsdfOyZGoprDCEil5V9AD4D1IgYQS8hOPIj2O7muzIP0XHi1UQaUBxIn+cb0nJr4lTb4ihntBFL4kPtZq6k0s2wNQXgL1DmrVKVsp1B9qG5MxR7ZrOO7bLF0BgS3SlLC9k7q0UfIa6Q6rr/6o3fPl/w4pdEssRmOtvnw03DPawJ5SYz3K6Vq8KWGiZ0LIl6nF3VB+LjEQBBWyupG2BCebMFV2yUh/SgvYn75UJ0eynTT+4PL73ZYzKxV2sm/04Gx58ZpUUoFQXrKUOYvdvoaLcI+Jgww0pYad2n992OLGK5VOZNQ8yoEY1THPx/NiiFEceQVO6bZTgpyOA5ebN0MS3UQ6E9x7HOD7zjYB3E2LRnY1bA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C6B3721209A1D459C16BFE4DCCA8865@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fd4b21-5729-45ae-b740-08d706362367
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 19:29:48.6225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1355
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA3LTExIGF0IDE1OjA2IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBJIHNlZSB0aGF0IHlvdSBoYXZlIG5jb25uZWN0IHBhdGNo
ZXMgaW4geW91ciB0ZXN0aW5nIGJyYW5jaCAoYXMgd2VsbA0KPiBhcyB5b3VyIGxpbnV4LW5leHQg
YW5kIEkgYXNzdW1lIHRoZXkgYXJlIHRoZSBzYW1lKS4gIFRoZXJlIGlzDQo+IHNvbWV0aGluZyB3
cm9uZyB3aXRoIHRoYXQgdmVyc2lvbi4gQSBtb3VudCBoYW5ncyB0aGUgbWFjaGluZS4NCj4gDQo+
IFsgIDEzMi4xNDMzNzldIHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzAgc3R1Y2sg
Zm9yIDIzcyENCj4gW21vdW50Lm5mczoyNjI0XQ0KPiANCj4gSSBkb24ndCBoYXZlIHN1Y2ggcHJv
YmxlbXMgd2l0aCB0aGUgcGF0Y2ggc2VyaWVzIHRoYXQgTmVpbCBoYXMNCj4gcG9zdGVkLg0KPiAN
Cj4gVGhhbmsgeW91Lg0KDQpIb3cgYXJlIHRoZSBwYXRjaHNldHMgZGlmZmVyZW50PyBBcyBmYXIg
YXMgSSBrbm93LCBhbGwgSSBkaWQgd2FzIGFwcGx5DQp0aGUgMyBwYXRjaGVzIHRoYXQgTmVpbCBh
ZGRlZCB0byBteSBleGlzdGluZyBicmFuY2guDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
