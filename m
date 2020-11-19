Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12362B949D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Nov 2020 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKSOaO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 09:30:14 -0500
Received: from mail-bn8nam12on2096.outbound.protection.outlook.com ([40.107.237.96]:11616
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbgKSOaO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Nov 2020 09:30:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMkkKvyvBFlRuHg7w/mvaIti/VMDdubV1DrEaGkff4yEtd5tjHFSWb2+cPwFCxTksHpuT2PB6N3S3hTotKSD/j2Y0zAisx/OBvAqXeqeTsEnPgy+Hhpf1WjXdKrsCZQ08BxdPIfICsukogVqiMGNjflRjI/JVOwg9K0uftuJHeHRXp/27qc04Jwu+nJJgAWvmF2C4B5wCyPDBvP3oTGPtBtRmhJQhY23OOCs12XKEOpsdv04D1/yLOusPpP5tuE8gEW1eJV9+URkQSKeG72zr4zRvbxteKKEUPQuyBrXrlt57rOK44yV9NKmws3RtNrQlQOgFXrvOGvCadJT8H8eLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejEFV1rfgPAsNVvpkUkXXCmSI87ZQSnpyHFUJvscNtw=;
 b=dCB+2/ZPxF8uCvM4c3xMshXo/Vp1Wh2a7VGjAl8fybuN+y4qRv9kgBDxIHsb7qNQwN1JCDet/04IxPqd3ULJ233qjQfqddM/GHdAo2HB5e3dM6h0FsXX0pBqut5D9FUH7+e//FmywxMq1RtW4EkQTPOynCNcI6Gy7iQaSyOMftRbD2DfJlUMSSuPNbapTjcr89tZbNfSNjJNx0WMXbjJ4qcC4oRsGORdHxWsGstOMGeXSS/Vf5Spib6t1FzxnbuzW87hNCRKufp8VgHh0BNkfw3Ojitzn3G57ttuI7X+QKZm+/XqpY/oPBv/EUzcEBOkKDaQeUGbVXI360gxVPv5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejEFV1rfgPAsNVvpkUkXXCmSI87ZQSnpyHFUJvscNtw=;
 b=Xti1sqBxjbyRTE1t+IJEUZyCG50/7As6SZc3cynKJABWyfEs/edoNDxdMofps9gSw1zB9Jt/u9s5uSc4rG3JI6+kATXRUj6Fcz9aAyd/HXWASbZ7vQvquB/e9Kc2INQnDDOG4LmcS4bjlR/0e4qxm7g4ShdZvh0e5N/6cXUC5To=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB4101.namprd13.prod.outlook.com (2603:10b6:208:268::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.11; Thu, 19 Nov
 2020 14:30:08 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3589.016; Thu, 19 Nov 2020
 14:30:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
Thread-Topic: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
Thread-Index: AQHWvfkXUHuTZLUV8keMpBIY5a4z6anPgYwAgAADcYA=
Date:   Thu, 19 Nov 2020 14:30:07 +0000
Message-ID: <57b085d32f624986412770d10cc4daa8211ee0f4.camel@hammerspace.com>
References: <20201118221939.20715-1-trondmy@kernel.org>
         <20201118221939.20715-2-trondmy@kernel.org>
         <20201118221939.20715-3-trondmy@kernel.org>
         <42FFB4EC-5E31-4002-92FC-7CA329479D78@oracle.com>
In-Reply-To: <42FFB4EC-5E31-4002-92FC-7CA329479D78@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0623a199-e3b1-4b9e-d526-08d88c979d4b
x-ms-traffictypediagnostic: MN2PR13MB4101:
x-microsoft-antispam-prvs: <MN2PR13MB4101CE9C023981639D6D97FCB8E00@MN2PR13MB4101.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4c4ggbTQSZxhda5A5CTJq/a9JVIbvDKV1hVU7YxRqmKD8mX9mIUN+2deY5BWkwlaQx+VoncKIGQnLMLiKJm5MDhMmT4iGMfA7L4j+1M1DMzw9Vbh4KHQKm/9pvCUNmJTaPpX3G498Rxpav4DyvFKM2mvIrkL4tvG+KC1NqFpfi7r2IJfvw8YTi2YknIe+HIaoFIyDFceeKbnjFFsKoAMR7aEbA1SepkQA+LC4KNJRUa94/RWpHIzfYm1d57K2yEAWLSYo9oNyBuxSsSmttoMo8X0wnMSNDKNT0hm58/N2zu8BiUWfJHYGbrUSIjmhehZRCqRSKfXJNQsTOTXMmBgyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39840400004)(136003)(346002)(396003)(376002)(53546011)(6506007)(4001150100001)(83380400001)(316002)(4326008)(86362001)(2616005)(8936002)(110136005)(26005)(186003)(6486002)(66946007)(5660300002)(76116006)(91956017)(71200400001)(2906002)(66476007)(66556008)(64756008)(66446008)(8676002)(36756003)(478600001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CGd/IhEShuFKmxIh9RmAi8TbhE9Sa38JbAo/PhP6aY07SbG7Xy5InBOKReFZeTYbdsFA0C3OejTDPWBFMyQPBh6un62LVbo6UqwVgqYnf+Cjspkvz2dm+H4qjNwRQuAol0VRtFfgIHfaYI1ylo/3YyPPF0xmotqPAImByVO0Q98FOebdXplLwvsV0weV3aMU7y/K3FRFlhIapmEELs8A26jIVkvGT+dcMXf2hrJ/kk8Bc5ZPbvqBB187aLUoeeVnZFCwvo+w72C2K5NQMwm7g9wwUyLAk2Oqx7psMYNgrfOUOhKlRQbE9r/yco3uSpXFxKvJj8cum03ZaMtP4p4SBiFuEkVsgF0zpt1v56bEXFib53GmwsikXReZ07VL4XASKjpBuVr3o3ZvuHnQXw1l8ukOzwsm4xJa/qXoruSAq2j6rp+TnUMtMwdcVlVbE49dveiqpJTe0suWfgt7/ueA4cxaVX3FZ8vVW54eoA2i8lLmqyxmUXszvBhtl6fnpb2dcIXEaSveqU3nIt+SUfjJgJsXBR2fSHL2iT3bkgyC3+j71QQfJvytDpc2VFi4BZhkspeyaXy3Ck5xAjAv2B+s4VZ+772JgmLTe2qdl4bhLy90Fq95sUtqCMdaotKIFvc/rRo96819oh4Z2lhKq3f1ag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1637333D89C63246B05EE4515D744948@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0623a199-e3b1-4b9e-d526-08d88c979d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 14:30:07.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcfjE1dF8gHhIKUwufPJXdWPBmyp4mu31e7ShhwY86bV6MWCVbY09igIJ9EpZiOI7tq4xq3wu712Bb6vniB65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4101
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTE5IGF0IDA5OjE3IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIE5vdiAxOCwgMjAyMCwgYXQgNToxOSBQTSwgdHJvbmRteUBrZXJuZWwub3Jn
wqB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gV2hlbiBkb2luZyBhIHJlYWQoKSBpbnRvIGEg
cGFnZSwgd2UgYWxzbyBkb24ndCBjYXJlIGlmIHRoZSBudWwNCj4gPiBwYWRkaW5nDQo+ID4gc3Rh
eXMgaW4gdGhhdCBsYXN0IHBhZ2Ugd2hlbiB0aGUgZGF0YSBsZW5ndGggaXMgbm90IDMyLWJpdCBh
bGlnbmVkLg0KPiANCj4gV2hhdCBpZiB0aGUgUkVBRCBwYXlsb2FkIGxhbmRzIGluIHRoZSBtaWRk
bGUgb2YgYSBmaWxlPyBUaGUNCj4gcGFkIG9uIHRoZSBlbmQgd2lsbCBvdmVyd3JpdGUgZmlsZSBj
b250ZW50IGp1c3QgcGFzdCB3aGVyZQ0KPiB0aGUgUkVBRCBwYXlsb2FkIGxhbmRzLg0KDQpJZiB0
aGUgc2l6ZSA+IGJ1Zi0+cGFnZV9sZW4sIHRoZW4gaXQgZ2V0cyB0cnVuY2F0ZWQgaW4NCnhkcl9h
bGlnbl9wYWdlcygpIGFmYWlrLg0KDQo+IA0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBN
eWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gLS0tDQo+ID4g
ZnMvbmZzL25mczJ4ZHIuYyB8IDIgKy0NCj4gPiBmcy9uZnMvbmZzM3hkci5jIHwgMiArLQ0KPiA+
IGZzL25mcy9uZnM0eGRyLmMgfCAyICstDQo+ID4gMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnMy
eGRyLmMgYi9mcy9uZnMvbmZzMnhkci5jDQo+ID4gaW5kZXggZGI5YzI2NWFkOWUxLi40NjhiZmJm
ZTQ0ZDcgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL25mczJ4ZHIuYw0KPiA+ICsrKyBiL2ZzL25m
cy9uZnMyeGRyLmMNCj4gPiBAQCAtMTAyLDcgKzEwMiw3IEBAIHN0YXRpYyBpbnQgZGVjb2RlX25m
c2RhdGEoc3RydWN0IHhkcl9zdHJlYW0NCj4gPiAqeGRyLCBzdHJ1Y3QgbmZzX3BnaW9fcmVzICpy
ZXN1bHQpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmICh1bmxpa2VseSghcCkpDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTzsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgY291bnQgPSBiZTMyX3RvX2NwdXAocCk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgcmVjdmQgPSB4
ZHJfcmVhZF9wYWdlcyh4ZHIsIGNvdW50KTsNCj4gPiArwqDCoMKgwqDCoMKgwqByZWN2ZCA9IHhk
cl9yZWFkX3BhZ2VzKHhkciwgeGRyX2FsaWduX3NpemUoY291bnQpKTsNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKHVubGlrZWx5KGNvdW50ID4gcmVjdmQpKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZ290byBvdXRfY2hlYXRpbmc7DQo+ID4gb3V0Og0KPiA+IGRpZmYgLS1n
aXQgYS9mcy9uZnMvbmZzM3hkci5jIGIvZnMvbmZzL25mczN4ZHIuYw0KPiA+IGluZGV4IGQzZTE3
MjZkNTM4Yi4uOGVmN2M5NjFkM2UyIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9uZnMzeGRyLmMN
Cj4gPiArKysgYi9mcy9uZnMvbmZzM3hkci5jDQo+ID4gQEAgLTE2MTEsNyArMTYxMSw3IEBAIHN0
YXRpYyBpbnQgZGVjb2RlX3JlYWQzcmVzb2soc3RydWN0DQo+ID4geGRyX3N0cmVhbSAqeGRyLA0K
PiA+IMKgwqDCoMKgwqDCoMKgwqBvY291bnQgPSBiZTMyX3RvX2NwdXAocCsrKTsNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKHVubGlrZWx5KG9jb3VudCAhPSBjb3VudCkpDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9taXNtYXRjaDsNCj4gPiAtwqDCoMKgwqDC
oMKgwqByZWN2ZCA9IHhkcl9yZWFkX3BhZ2VzKHhkciwgY291bnQpOw0KPiA+ICvCoMKgwqDCoMKg
wqDCoHJlY3ZkID0geGRyX3JlYWRfcGFnZXMoeGRyLCB4ZHJfYWxpZ25fc2l6ZShjb3VudCkpOw0K
PiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAodW5saWtlbHkoY291bnQgPiByZWN2ZCkpDQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9jaGVhdGluZzsNCj4gPiBvdXQ6
DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0eGRyLmMgYi9mcy9uZnMvbmZzNHhkci5jDQo+
ID4gaW5kZXggNzU1YjU1NmU4NWMzLi41YmFhNzY3MTA2ZGMgMTAwNjQ0DQo+ID4gLS0tIGEvZnMv
bmZzL25mczR4ZHIuYw0KPiA+ICsrKyBiL2ZzL25mcy9uZnM0eGRyLmMNCj4gPiBAQCAtNTIwMiw3
ICs1MjAyLDcgQEAgc3RhdGljIGludCBkZWNvZGVfcmVhZChzdHJ1Y3QgeGRyX3N0cmVhbQ0KPiA+
ICp4ZHIsIHN0cnVjdCBycGNfcnFzdCAqcmVxLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIC1FSU87DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGVvZiA9IGJlMzJfdG9f
Y3B1cChwKyspOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBjb3VudCA9IGJlMzJfdG9fY3B1cChwKTsN
Cj4gPiAtwqDCoMKgwqDCoMKgwqByZWN2ZCA9IHhkcl9yZWFkX3BhZ2VzKHhkciwgY291bnQpOw0K
PiA+ICvCoMKgwqDCoMKgwqDCoHJlY3ZkID0geGRyX3JlYWRfcGFnZXMoeGRyLCB4ZHJfYWxpZ25f
c2l6ZShjb3VudCkpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoY291bnQgPiByZWN2ZCkgew0K
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHByaW50aygiTkZTOiBzZXJ2ZXIg
Y2hlYXRpbmcgaW4gcmVhZCByZXBseTogIg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiY291bnQgJXUgPiByZWN2ZCAl
dVxuIiwgY291bnQsDQo+ID4gcmVjdmQpOw0KPiA+IC0tIA0KPiA+IDIuMjguMA0KPiA+IA0KPiAN
Cj4gLS0NCj4gQ2h1Y2sgTGV2ZXINCj4gDQo+IA0KPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
