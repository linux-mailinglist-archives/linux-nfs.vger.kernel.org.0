Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8694DF59C8
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 22:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfKHVXA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 16:23:00 -0500
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:3040
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731637AbfKHVXA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Nov 2019 16:23:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2+K2MF14jRMsiCBaahOv6uLGXnwTnh4KiWcdqyPzyYansRiNY20w7bRNgrVfAXlD3dZlg7ZUQaueHm0GG1gZmB/XUFHzchPNU4GFeSq9cyl0604m6sLajIAGT1bJvW0HWWtw+fJ6AynfPvjUkOvinLBfHZpJuvgSPG9L+VF4cZVGKvd5Hrck1FOQNwAc9vBafXlitppuhtQMZtLsqx4pXg4dgeLmoJr5xOgAsIbvntVGm144VvMHvubgGeGj76f4P8SxDjduCqIUPfmU+ShGcXoLYG6CModxAqMY5IES1nOUaSSxWJJG2yVgIa8E2hBjTWk/oiRV8WIiuB20j9WQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxuwtcuzQUZfk9nmAMao7cWyXJRLZdgAqwnxRgvncQ4=;
 b=kdaC3PbnamssBhocPYnJ8W7x/hQph+t9SeDETguF5NWY3A+S6335dECwrcOm7j4gmh0tWl95XaFEiyD8J1zGM8SBiMH2JtF1PY++RHXzH277LuO+dGeTlp8hv54TVnpkpRyPpJ3aCbjn8L89JDMcC70HnTIpp93Hr2YqgXoPC+KrXNCyyoe89h+hJ/eZaGEDq3Tiaf1rHEhuI+Kb2ToobVte5ARO2V2eqWMd4Iv80rRKIfZv8J2h4DIYd3ZY9MkjQvK83S1NNtF0itLwA0Kh/kGjCsVGYNulgpN3mypG6UPDGOSrmqLQgkU4/s2HBHznWPfYQQ6H1kl8jopm2PXlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxuwtcuzQUZfk9nmAMao7cWyXJRLZdgAqwnxRgvncQ4=;
 b=SWM9MV5ZKQ/rXL0jL80ygxY5cPI/EmYBCtK4MlRscRPq0o6iAopOlQv9E17r4j4sUroQ9U/tEraV4FFsGOSTkAzOhc7H88G5IkWhuaQP2BYSM7IbYIi6nbfXi/fEHAOtuSYsxE2A8umwMFR9y+pahzEGjpOQa4W8n56PUTbornk=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1962.namprd13.prod.outlook.com (10.174.184.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Fri, 8 Nov 2019 21:22:16 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 21:22:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH 1/2] NFS: Add FATTR4_WORD1_SPACE_USED to the
 cache_consistency_bitmask
Thread-Topic: [PATCH 1/2] NFS: Add FATTR4_WORD1_SPACE_USED to the
 cache_consistency_bitmask
Thread-Index: AQHVlnfV1GjDP4EQhEGK5WFMRtsa06eByD4A
Date:   Fri, 8 Nov 2019 21:22:16 +0000
Message-ID: <1296f01521c89e00a9c5f4aff3332829415333c5.camel@hammerspace.com>
References: <20191108210224.33645-1-Anna.Schumaker@Netapp.com>
In-Reply-To: <20191108210224.33645-1-Anna.Schumaker@Netapp.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.243.139]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ae3291-607c-43aa-ce73-08d76491bb10
x-ms-traffictypediagnostic: DM5PR1301MB1962:
x-microsoft-antispam-prvs: <DM5PR1301MB19628B0BF88CA32182EFDF39B87B0@DM5PR1301MB1962.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(376002)(136003)(346002)(366004)(199004)(189003)(36756003)(26005)(71190400001)(99286004)(86362001)(66066001)(25786009)(71200400001)(6246003)(6486002)(6506007)(256004)(14444005)(2501003)(186003)(102836004)(76176011)(229853002)(2906002)(316002)(446003)(11346002)(2616005)(476003)(110136005)(486006)(14454004)(6116002)(3846002)(8936002)(8676002)(81166006)(81156014)(5660300002)(6436002)(6512007)(478600001)(305945005)(66946007)(64756008)(66476007)(76116006)(91956017)(66556008)(66446008)(4326008)(118296001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1962;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GifGC5EeXdLbnMpjh+fbkQaTBrgXQt6wrXLPiCPgbOJoI75dRA5xFnXKvdqv68qm+yVkEZtPnELX7HxArrnYQRBD9l+P12Cba0T2HyJmxIroS0j9txocQm43LaRFMlA8nKkfjeMuaaxgkloouI6XrMwfgpd1DInVyaLnxxbP/cZGA2cI2Fd8oaK4BzHs3LJLnBgr3LAk2M7C5unrko2or5sgdCpGbzGmLbKnHqpnvPs0xzMW+9phSfE2NyXP4VFxUtP6vsmS3NuriGNsMofroZ9fcOoxKGAIJ8kf8bE8LEve0WDSmldaqXK/IGOPiLjFcaTFurqPCheq9Tc2QwsKBEqTCWOt7ewrNk9weB1JzMA5tjn/bU8rwCSi4F02gfVnXa7xeQrCOoFgbRhavlgwofXEbx4/DbZdvuyB8H/uQ+JexCRNXJUFlyvlJTMVsly5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A845AD68158E4B478524103DD04F0CC1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ae3291-607c-43aa-ce73-08d76491bb10
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 21:22:16.6521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jETjRuxe7cQU5MyoN6P4mkinjTjPajYt+PekJD4ZU9k96vQlvoVpY+wHvVuoz9DwASWvJX5mRAl7yKB+2YrQbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1962
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDE5LTExLTA4IGF0IDE2OjAyIC0wNTAwLCBzY2h1bWFrZXIuYW5uYUBnbWFpbC5j
b20gd3JvdGU6DQo+IEZyb206IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAu
Y29tPg0KPiANCj4gQ2hhbmdpbmcgYSBzcGFyc2UgZmlsZSBjb3VsZCBoYXZlIGFuIGVmZmVjdCBu
b3Qgb25seSBvbiB0aGUgZmlsZQ0KPiBzaXplLA0KPiBidXQgYWxzbyBvbiB0aGUgbnVtYmVyIG9m
IGJsb2NrcyB1c2VkIGJ5IHRoZSBmaWxlIGluIHRoZSB1bmRlcmx5aW5nDQo+IGZpbGVzeXN0ZW0u
IExldCdzIHVwZGF0ZSB0aGUgU1BBQ0VfVVNFRCBhdHRyaWJ1dGUgd2hlbmV2ZXIgd2UgdXBkYXRl
DQo+IFNJWkUgdG8gYmUgYXMgYWNjdXJhdGUgYXMgcG9zc2libGUuDQo+IA0KPiBUaGlzIHBhdGNo
IGZpeGVzIHhmc3Rlc3RzIGdlbmVyaWMvNTY4LCB3aGljaCB0ZXN0cyB0aGF0IGZhbGxvY2F0aW5n
DQo+IGFuDQo+IHVuYWxpZ25lZCByYW5nZSBhbGxvY2F0ZXMgYWxsIGJsb2NrcyB0b3VjaGVkIGJ5
IHRoYXQgcmFuZ2UuIFdpdGhvdXQNCj4gdGhpcw0KPiBwYXRjaCwgYHN0YXRgIHJlcG9ydHMgMCBi
eXRlcyB1c2VkIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBmYWxsb2NhdGUuDQo+IEFkZGluZyBhIGBz
bGVlcCA1YCB0byB0aGUgdGVzdCBhbHNvIGNhdGNoZXMgdGhlIHVwZGF0ZSwgYnV0IGl0J3MNCj4g
YmV0dGVyDQo+IHRvIGp1c3QgZG8gaXQgd2hlbiB3ZSBrbm93IHNvbWV0aGluZyBoYXMgY2hhbmdl
ZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBO
ZXRhcHAuY29tPg0KPiAtLS0NCj4gIGZzL25mcy9uZnM0cHJvYy5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBpbmRleCBhYzkwNjNj
MDYyMDUuLjAwYTFmM2VjN2YyMiAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4g
KysrIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gQEAgLTM3NzUsNyArMzc3NSw3IEBAIHN0YXRpYyBp
bnQgX25mczRfc2VydmVyX2NhcGFiaWxpdGllcyhzdHJ1Y3QNCj4gbmZzX3NlcnZlciAqc2VydmVy
LCBzdHJ1Y3QgbmZzX2ZoICpmDQo+ICANCj4gIAkJbWVtY3B5KHNlcnZlci0+Y2FjaGVfY29uc2lz
dGVuY3lfYml0bWFzaywNCj4gcmVzLmF0dHJfYml0bWFzaywgc2l6ZW9mKHNlcnZlci0+Y2FjaGVf
Y29uc2lzdGVuY3lfYml0bWFzaykpOw0KPiAgCQlzZXJ2ZXItPmNhY2hlX2NvbnNpc3RlbmN5X2Jp
dG1hc2tbMF0gJj0NCj4gRkFUVFI0X1dPUkQwX0NIQU5HRXxGQVRUUjRfV09SRDBfU0laRTsNCj4g
LQkJc2VydmVyLT5jYWNoZV9jb25zaXN0ZW5jeV9iaXRtYXNrWzFdICY9DQo+IEZBVFRSNF9XT1JE
MV9USU1FX01FVEFEQVRBfEZBVFRSNF9XT1JEMV9USU1FX01PRElGWTsNCj4gKwkJc2VydmVyLT5j
YWNoZV9jb25zaXN0ZW5jeV9iaXRtYXNrWzFdICY9DQo+IEZBVFRSNF9XT1JEMV9USU1FX01FVEFE
QVRBfEZBVFRSNF9XT1JEMV9USU1FX01PRElGWXxGQVRUUjRfV09SRDFfU1BBQw0KPiBFX1VTRUQ7
DQoNCkknZCByYXRoZXIgbm90IGRvIHRoaXMuIFNwYWNlIHVzZWQgaXMgbm90IGEgY2FjaGUgY29u
c2lzdGVuY3kgYXR0cmlidXRlDQosIGFzIHdlIGRvIG5vdCB1c2UgaXQgdG8gcmV2YWxpZGF0ZSB0
aGUgY2FjaGUgYW5kIGl0IGNhbiBiZSByYXRoZXINCmV4cGVuc2l2ZSB0byByZXRyaWV2ZSBvbiBz
b21lIHBsYXRmb3Jtcy4NCg0KSSdkIHRoZXJlZm9yZSBwcmVmZXIgdGhhdCB3ZSBqdXN0IG1ha2Ug
c3VyZSB3ZSBtYXJrIHRoZSBjYWNoZSB2YWxpZGl0eQ0Kd2l0aCBORlNfSU5PX0lOVkFMSURfT1RI
RVIgd2hlbiB3ZSBoYXZlIGEgd3JpdGUgc3VjY2VlZCBvbiBhIHNwYXJzZQ0KZmlsZS4NCg0KPiAg
CQlzZXJ2ZXItPmNhY2hlX2NvbnNpc3RlbmN5X2JpdG1hc2tbMl0gPSAwOw0KPiAgDQo+ICAJCS8q
IEF2b2lkIGEgcmVncmVzc2lvbiBkdWUgdG8gYnVnZ3kgc2VydmVyICovDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
