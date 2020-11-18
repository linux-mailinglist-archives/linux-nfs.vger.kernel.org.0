Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EBC2B749E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 04:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKRDRY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Nov 2020 22:17:24 -0500
Received: from mail-mw2nam12on2125.outbound.protection.outlook.com ([40.107.244.125]:27777
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbgKRDRX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Nov 2020 22:17:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZMOHle4FE7+PAthUqd4VlW6IBFflnjy6J12p9akXixTXLp3naeiiaecsU3eOH/By2ohgW/ahnZC6EYm5rmfVUuyDzAdlmkNYUCK+DFkFA7q/+4XuGKJsX+dkHou25VJ41nYX23lZYB32rS1hP/2raw1WN1C+X6zCg/BIuGe3z2s7gTTWAac5w0eh+9QYlJD6D5mNnp3KY40C7SGFAkMniLzJ/Nx6eoBmgZTgy1n5dD+246v91/Pdl/sC+P6NslsiLCW2FMolO1zLY+toBRgs2rlBGKAX5JkdEXvUwYdxRBwM3EtbrXt90BvqBGBS54u44KgaSZ2CBrgP79qYw35TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq57W+rGrGmOnJUbd1CZbY76Lb8HjcQ+MosLr64Uu7s=;
 b=hzvS4hOnUfr2tY0syy+I+lAxj1gF6VaLjyMR/NQKci1xlUEdcLDtet0cUiJqxPk0SFjbTC5oMkqEz11eJ1o5RrFwXKgYgPrB/yjvT615LtsX7xmHPNtic/aNZjhM/gOw/XKRAr8vNu8E+brWaMqlA30lx/vkwaLW8ZRZUNx2AjQ5GZRGaBUIf+Y5q87KCXzXix0TpMt1GCqY7gzoPQSUlOhR8cqWYmo3Yby1aj/Yght4+hKVkudv9Rjrjv73e3qr9QzJG5fxQWtkEV5lIQh+yXKfLmUEno+8rz1mGG0+GYMMuVVgTQ+w4ahVqT+bQR8QS76jog9RZ4Wivn3+1slcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq57W+rGrGmOnJUbd1CZbY76Lb8HjcQ+MosLr64Uu7s=;
 b=be9o3pYgely8PB63p7C63koshVwFj65JNxGfj/z9AxRyiTOER+OfsL0xtM2yHr63FWsgstLzVkMtP1eiNx1mZqFJ2V0TR/HMxlxOlMLwoQwr18gujHqlcha/85Z5WWsPxJ10qDx6QeJqVzbIMUlDURp4c2r1aCcoQ/CYw45LCas=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3773.namprd13.prod.outlook.com (2603:10b6:208:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15; Wed, 18 Nov
 2020 03:17:20 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3589.016; Wed, 18 Nov 2020
 03:17:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anchalag@amazon.com" <anchalag@amazon.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: Retry the CLOSE if the embedded GETATTR is rejected
 with ERR_STALE
Thread-Topic: [PATCH] NFS: Retry the CLOSE if the embedded GETATTR is rejected
 with ERR_STALE
Thread-Index: AQHWvUE2gwXXu4fTCEGnbxZoTu1/nanNOCKA
Date:   Wed, 18 Nov 2020 03:17:20 +0000
Message-ID: <a0babbb7d58f02769a6ce40d029768e7221acf24.camel@hammerspace.com>
References: <20201118002431.GA6941@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
In-Reply-To: <20201118002431.GA6941@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b584a7c-aedc-44e7-ce7b-08d88b7075ed
x-ms-traffictypediagnostic: MN2PR13MB3773:
x-microsoft-antispam-prvs: <MN2PR13MB377376560CF3BC0CCE17B04BB8E10@MN2PR13MB3773.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lm06AADgLQXna/SsxOU8/oXEISX3HG1ujqslR+DU2J2f7u3Mq/fy1MNEkclPoqc/km7a2u/Sd52rpxqks0vfqv1KkswZY23IF1ot05pvO2CHdf2W7OxBEUbdCLyoj7cffB4aUVba1j5zJrPVNVhKj4u6A5JTnkXZEgds57/JJ/JpGC1xWhSnA5+RpWI1SH385zjzFIUsjb/GcFBemEiBm+RkF11Ag2imBrzlcHdmYUYZE4/2h9rv7Whl4PQtb6i6JQfXoV9nXJoi5o4V98ItDePu4fOR3uCpt5JwuSkeFQE/ieKamRRMDQ81qGcxRWWCYRMt8OA1AIMj9epr39fNXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(366004)(346002)(376002)(136003)(2616005)(478600001)(8676002)(91956017)(6512007)(6486002)(186003)(6506007)(26005)(316002)(8936002)(110136005)(76116006)(4744005)(36756003)(83380400001)(66946007)(66476007)(66446008)(66556008)(2906002)(64756008)(86362001)(71200400001)(4001150100001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nM6KWZA4yz8ujzUOueQDASQ394ku6BeogAg+LPW9rcLo6GH5ZGwxtkeGHRP4uW/eNMoHFCgyQJX/nlJ29qZ78bWdHV+Lf3H7plsUjF1j7IE2IwMx2CUJjFPN70t5ESWOUKWZX3yXiCLL1sCso1Vg8zPNSbBmvZZD+FRuvZoTniy6hyoNRMw489iuiczjVCNkItWhRZ5057dOX+hf0UIUcgaZeBV2I0OtMZxjZNsqoD7mxUrC9CW5RydvogDQ4Dw6zmEqZIPydhfNr0x8dO2ImsbPleUPqiB2qI3yymKrLfLFO/aInkmNAAEVNM8Jf8lg2iwGRaKVInImHCTaAmdf8ur0DX+TgypCoVGCVGqHjxeJed4uxIilqmszhG7CV+phr4Bt3zDzIHf3ySU278FLRIQvKya1+nuf/2ZTXz8JsV0YbH4OB9NzjAC2fQvAkCI9qgCuRbVAoSdFuTjF4bdJggp2dCnwtvSgeTKc8CCYzoE6ssZ+Vm1KFqIgSGySxrvv+9Z4sLwY1EPo2f7EdH/d5/6fL5AvPhvgZNLZ0Xv74X5HXueeN0R4SH4J7Pz5bB53yzxBt1vNKK1bXXEHgVXv4sgOu4pRwpWomvIxZ5bFNmMlDRvLlDyMAet0yqm2Mrr7zCydX6GPoBq0ikLIlMrnmw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <25DFCF38299C1D46A6734E39B3118DBE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b584a7c-aedc-44e7-ce7b-08d88b7075ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 03:17:20.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4Q6rBIe04vpMD5rOm33sdqSnSaUbpW8McBKafVpAkNPiKYh4M470XWFmkDx3idyj258xVk5K93VDcCFwCqD8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3773
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTE4IGF0IDAwOjI0ICswMDAwLCBBbmNoYWwgQWdhcndhbCB3cm90ZToN
Cj4gSWYgb3VyIENMT1NFIFJQQyBjYWxsIGlzIHJlamVjdGVkIHdpdGggYW4gRVJSX1NUQUxFIGVy
cm9yLCB0aGVuIHdlDQo+IHNob3VsZCByZW1vdmUgdGhlIEdFVEFUVFIgY2FsbCBmcm9tIHRoZSBj
b21wb3VuZCBSUEMgYW5kIHJldHJ5Lg0KPiBUaGlzIGNvdWxkIGhhcHBlbiBpbiBhIHNjZW5hcmlv
IHdoZXJlIHR3byBjbGllbnRzIHRyaWVzIHRvIGFjY2Vzcw0KPiB0aGUgc2FtZSBmaWxlLiBPbmUg
Y2xpZW50IG9wZW5zIHRoZSBmaWxlIGFuZCB0aGUgb3RoZXIgY2xpZW50IHJlbW92ZXMNCj4gdGhl
IGZpbGUgd2hpbGUgaXQncyBvcGVuZWQgYnkgZmlyc3QgY2xpZW50LiBXaGVuIHRoZSBmaXJzdCBj
bGllbnQNCj4gYXR0ZW1wdHMgdG8gY2xvc2UgdGhlIGZpbGUgdGhlIHNlcnZlciByZXR1cm5zIEVT
VEFMRSBhbmQgdGhlIGZpbGUNCj4gZW5kcw0KPiB1cCBiZWluZyBsZWFrZWQgb24gdGhlIHNlcnZl
ci4gVGhpcyBkZXBlbmRzIG9uIGhvdyBuZnMgc2VydmVyIGlzDQo+IGNvbmZpZ3VyZWQgYW5kIGlz
IG5vdCByZXByb2R1Y2libGUgaWYgcnVubmluZyBhZ2FpbnN0IG5mc2QuDQoNClRoYXQgd291bGQg
YmUgYSBzZXJpb3VzbHkgYnJva2VuIHNlcnZlci4gSWYgeW91IHJldHVybiBORlM0RVJSX1NUQUxF
IHRvDQp0aGUgY2xpZW50LCB5b3UgY2Fubm90IGV4cGVjdCBhbnkgZnVydGhlciBpbnRlcmFjdGlv
biB3aXRoIHRoYXQgZmlsZQ0KZnJvbSB0aGUgY2xpZW50LiBJdCB3b24ndCB0cnkgdG8gc2VuZCBD
TE9TRSBvciBERUxFR1JFVFVSTiBvciBhbnkgb3RoZXINCnN0YXRlZnVsIG9wZXJhdGlvbi4NCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
