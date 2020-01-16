Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5758D13DF7E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 17:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPQCP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 11:02:15 -0500
Received: from mail-eopbgr760121.outbound.protection.outlook.com ([40.107.76.121]:33602
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbgAPQCP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Jan 2020 11:02:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRlDxBwZe0UzEYCZDPmCnJXqcB4vGmMTzD0gq7Cpqj6mjbI5wwLSTW/g9NYaxeMNXMghUh5hEijbZcstN4PNCHkgt2IIjYV9jezNW7fbIJPZUtiOmcvnlnYo7o/obG0IdAjvQZxczwEoZA7rU0OI9zcxIBnfh0h5VPPbCCdGEYRVWPRLTKYym+GU8vCK5oJjMiFvBAIA32G1KlX8KxHSQXpnd3LaUXNRA4P8/EeMl5r6Oy7KwlYDQURXqoxaKH5ZfHNWm2O4X5I6tJRigImLsVaoOh8ogvfI7SK0uCfv32nOeOcS3NadOQVn+y5bxR3XWIJ4Qb4G3Kca07VX62bHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDx446LktZ630mk09IF1jVaaA7zFKTykb7hwyGNq7ew=;
 b=BH+Q2lx1HWIR3ER+tY3X/KvqYnItRqRZ0x1CEKIUZSU6UvxG/7IYL9Kgmzb7Y3FJ2qIlJIDkqcJMGGYylOuMTeaOz1xxeX7rt9B2fAPR12LIsZ+AauzPV/ZYPJXxFgpGfzz3RqcIfJZuUF2cBwhDFjkiqkPKMb25SmVLR2kJbhfA2MQRyZl9ooaQnAO89INDFfnJfyzu/yc8/oZyGPmPJpmjfXEuJbuzHKp6Umo7oPVrWlUQZy2/HpbTRaTvdZCTOKJHvwsofV1/9+TcBJbY2qSi8PWfynML0OuVEZZ61ofwUKd9BpbNxrUcdEv5HGMVqGxm300qUpdDrs6UFmErzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDx446LktZ630mk09IF1jVaaA7zFKTykb7hwyGNq7ew=;
 b=BPq4YtpAG3h8TbFzsRKpriocnXg9uj7XvNyl3QRSknPIkw+ExOJXvBidHk6H5Kjt8UIZmwUOTcx6Cot48GRMK31H/z54Xklsk5SP4TvC65/bk6bmYv/LoHOZFNMbg+toNUe+A6N5CLmb2YJsMQr8JqnqxLk3WW12jdK/E/9TmfY=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2075.namprd13.prod.outlook.com (10.174.185.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.14; Thu, 16 Jan 2020 16:02:11 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.021; Thu, 16 Jan 2020
 16:02:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFS: Don't skip lookup when holding a delegation
Thread-Topic: [PATCH v2] NFS: Don't skip lookup when holding a delegation
Thread-Index: AQHVbvlhXK/ljPJmmUKulFnJAnn0pafuIqIAgAAMCIA=
Date:   Thu, 16 Jan 2020 16:02:10 +0000
Message-ID: <d8639ad40df3b0a814e7396e1e824220c4d21a55.camel@hammerspace.com>
References: <77be993185fa7f114f6856f74f2f7affb5bd411d.1568904510.git.bcodding@redhat.com>
         <6399DBA2-DA9D-40C3-80BC-6DCE94BB9C49@redhat.com>
In-Reply-To: <6399DBA2-DA9D-40C3-80BC-6DCE94BB9C49@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4a761af-43a3-453a-eef6-08d79a9d7204
x-ms-traffictypediagnostic: DM5PR1301MB2075:
x-microsoft-antispam-prvs: <DM5PR1301MB207591C089715BA57444F0B0B8360@DM5PR1301MB2075.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39830400003)(346002)(136003)(189003)(199004)(71200400001)(2616005)(66556008)(36756003)(91956017)(66446008)(64756008)(6512007)(76116006)(66476007)(5660300002)(66946007)(81156014)(4326008)(86362001)(478600001)(8936002)(316002)(186003)(8676002)(53546011)(6506007)(110136005)(2906002)(6486002)(26005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2075;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0LCYZBuyBgkIwa1Gdw+UJG+1O1f1P39BEG5WgRz39UXQf9azXiITU+6Ppn90g69I6d1SIev3rxSily9sVq009KDL1igO7HOTodtknd3uoL/bRZcPSysA3DjpBzGgKAHl3d2ZXo3xmcnBZ38jasXwbfykEtMXnkJe4hXW5lQsVPerIO7wGsaFnkTKsKNT+toIQNodhL8Wp55ko85gpVL8YtuldNZ6X04dWs+oHlYRSJzk/F7nSknlN87KiJpBno9UEuLP6UiUAb7oWyBZTiiSnrL7xzQPcpNQu+LFE2aoGVWH0C6IYIn4WNerPm3i36qG8MmY+/kbyRely7kLiaW+IECWXuD8qoUCrOFRkRqmYF9z19jt5Ev0CKlLkHewvbsMGPxX42wW7B/QTvnuC3SCyGefvPnw0PYtSa+ZwAOuXzfUXwHFr83BwTBRtI1cVeU3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D856DA9D99983841AC9DFF394384510A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a761af-43a3-453a-eef6-08d79a9d7204
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 16:02:10.8334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PvliCgDPAygJqStHZKGzyRyetJU9IJ3Q2LVuTGSoDZCqNRQ218PYXU2SXDPLYXJSlXkTbhU3/PtL7+n7jDjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2075
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTE2IGF0IDEwOjE5IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBJJ2QgbGlrZSB0byBidW1wIHRoaXMgb25lIGFnYWluIHdoaWxlIHdlJ3JlIHRhbGtp
bmcgYWJvdXQgDQo+IGxvb2t1cC9yZXZhbGlkYXRpb24uDQo+IA0KPiBXZSBoYXZlIGZvbGtzIHRo
YXQgaGl0IHRoaXMgcHJvYmxlbSBpbiB0aGUgZmllbGQ6DQo+ICAgICAgLSBjbGllbnQgY2FjaGVz
IGEgZGVudHJ5DQo+ICAgICAgLSBmaWxlIGdldHMgbW92ZWQNCj4gICAgICAtIHNlcnZlciBnaXZl
cyBvdXQgYSBkZWxlZ2F0aW9uDQo+ICAgICAgLSBjbGllbnQgbmV2ZXIgbm90aWNlcyB0aGUgY2hh
bmdlIGJlY2F1c2Ugd2UgYWx3YXlzIHNraXAgDQo+IHJldmFsaWRhdGlvbg0KPiANCj4gSXMgdGhp
cyB0aGUgd3JvbmcgcGxhY2UgdG8gZml4IHRoaXM/ICBBbnkgb3RoZXIgZmVlZGJhY2s/DQo+IA0K
PiBCZW4NCj4gDQo+IE9uIDE5IFNlcCAyMDE5LCBhdCAxMDo0OSwgQmVuamFtaW4gQ29kZGluZ3Rv
biB3cm90ZToNCj4gDQo+ID4gSWYgd2Ugc2tpcCBsb29rdXAgcmV2YWxpZGF0aW9uIHdoaWxlIGhv
bGRpbmcgYSBkZWxlZ2F0aW9uLCB3ZQ0KPiA+IG1pZ2h0IA0KPiA+IG1pc3MNCj4gPiB0aGF0IHRo
ZSBmaWxlIGhhcyBjaGFuZ2VkIGRpcmVjdG9yaWVzIG9uIHRoZSBzZXJ2ZXIuICBUaGUNCj4gPiBk
aXJlY3Rvcnkncw0KPiA+IGNoYW5nZSBhdHRyaWJ1dGUgc2hvdWxkIHN0aWxsIGJlIGNoZWNrZWQg
YWdhaW5zdCB0aGUgZGVudHJ5J3MNCj4gPiBkX3RpbWUgDQo+ID4gdG8NCj4gPiBwZXJmb3JtIGEg
Y29tcGxldGUgcmV2YWxpZGF0aW9uLg0KPiA+IA0KPiA+IFYyIC0gQWRkIHNvbWUgY29tbWVudGFy
eSBhcyBzdWdnZXN0ZWQtYnkgSi4gQnJ1Y2UgRmllbGRzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+ID4gLS0tDQo+
ID4gIGZzL25mcy9kaXIuYyB8IDE3ICsrKysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9mcy9uZnMvZGlyLmMgYi9mcy9uZnMvZGlyLmMNCj4gPiBpbmRleCAwYWRmZDg4NDAxMTAu
Ljg3MjNlODJmNWM5ZCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4gPiArKysgYi9m
cy9uZnMvZGlyLmMNCj4gPiBAQCAtMTE5NywxMiArMTE5NywyMCBAQCBuZnNfZG9fbG9va3VwX3Jl
dmFsaWRhdGUoc3RydWN0IGlub2RlDQo+ID4gKmRpciwgDQo+ID4gc3RydWN0IGRlbnRyeSAqZGVu
dHJ5LA0KPiA+ICAJCWdvdG8gb3V0X2JhZDsNCj4gPiAgCX0NCj4gPiANCj4gPiAtCWlmIChORlNf
UFJPVE8oZGlyKS0+aGF2ZV9kZWxlZ2F0aW9uKGlub2RlLCBGTU9ERV9SRUFEKSkNCj4gPiAtCQly
ZXR1cm4gbmZzX2xvb2t1cF9yZXZhbGlkYXRlX2RlbGVnYXRlZChkaXIsIGRlbnRyeSwNCj4gPiBp
bm9kZSk7DQo+ID4gLQ0KPiA+ICAJLyogRm9yY2UgYSBmdWxsIGxvb2sgdXAgaWZmIHRoZSBwYXJl
bnQgZGlyZWN0b3J5IGhhcyBjaGFuZ2VkICovDQo+ID4gIAlpZiAoIShmbGFncyAmIChMT09LVVBf
RVhDTCB8IExPT0tVUF9SRVZBTCkpICYmDQo+ID4gIAkgICAgbmZzX2NoZWNrX3ZlcmlmaWVyKGRp
ciwgZGVudHJ5LCBmbGFncyAmIExPT0tVUF9SQ1UpKSB7DQo+ID4gKw0KPiA+ICsJCS8qDQo+ID4g
KwkJICogTm90ZSB0aGF0IHRoZSBmaWxlIGNhbid0IG1vdmUgd2hpbGUgd2UgaG9sZCBhDQo+ID4g
KwkJICogZGVsZWdhdGlvbi4gIEJ1dCB0aGlzIGRlbnRyeSBjb3VsZCBoYXZlIGJlZW4gY2FjaGVk
DQo+ID4gKwkJICogYmVmb3JlIHdlIGdvdCBhIGRlbGVnYXRpb24uICBTbyBpdCdzIG9ubHkgc2Fm
ZSB0bw0KPiA+ICsJCSAqIHNraXAgcmV2YWxpZGF0aW9uIHdoZW4gdGhlIHBhcmVudCBkaXJlY3Rv
cnkgaXMNCj4gPiArCQkgKiB1bmNoYW5nZWQ6DQo+ID4gKwkJICovDQo+ID4gKwkJaWYgKE5GU19Q
Uk9UTyhkaXIpLT5oYXZlX2RlbGVnYXRpb24oaW5vZGUsIEZNT0RFX1JFQUQpKQ0KPiA+ICsJCQly
ZXR1cm4gbmZzX2xvb2t1cF9yZXZhbGlkYXRlX2RlbGVnYXRlZChkaXIsDQo+ID4gZGVudHJ5LCBp
bm9kZSk7DQo+ID4gKw0KPiA+ICAJCWVycm9yID0gbmZzX2xvb2t1cF92ZXJpZnlfaW5vZGUoaW5v
ZGUsIGZsYWdzKTsNCj4gPiAgCQlpZiAoZXJyb3IpIHsNCj4gPiAgCQkJaWYgKGVycm9yID09IC1F
U1RBTEUpDQo+ID4gQEAgLTE2MzUsOSArMTY0Myw2IEBAIG5mczRfZG9fbG9va3VwX3JldmFsaWRh
dGUoc3RydWN0IGlub2RlICpkaXIsIA0KPiA+IHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4gPiAg
CWlmIChpbm9kZSA9PSBOVUxMKQ0KPiA+ICAJCWdvdG8gZnVsbF9yZXZhbDsNCj4gPiANCj4gPiAt
CWlmIChORlNfUFJPVE8oZGlyKS0+aGF2ZV9kZWxlZ2F0aW9uKGlub2RlLCBGTU9ERV9SRUFEKSkN
Cj4gPiAtCQlyZXR1cm4gbmZzX2xvb2t1cF9yZXZhbGlkYXRlX2RlbGVnYXRlZChkaXIsIGRlbnRy
eSwNCj4gPiBpbm9kZSk7DQo+ID4gLQ0KPiA+ICAJLyogTkZTIG9ubHkgc3VwcG9ydHMgT1BFTiBv
biByZWd1bGFyIGZpbGVzICovDQo+ID4gIAlpZiAoIVNfSVNSRUcoaW5vZGUtPmlfbW9kZSkpDQo+
ID4gIAkJZ290byBmdWxsX3JldmFsOw0KPiA+IC0tIA0KPiA+IDIuMjAuMQ0KDQpXZSBzaG91bGQg
bmVlZCB0byBwZXJmb3JtIHRoaXMgcmV2YWxpZGF0aW9uIG9uY2UsIGFuZCBvbmx5IG9uY2UgZm9y
DQp0aGF0IGRpcmVjdG9yeSwgYW5kIG9ubHkgaWYgd2Ugb3BlbmVkIHRoZSBmaWxlIHVzaW5nIGEg
Q0xBSU1fRkggb3BlbiwNCm9yIGlmIHdlIG9wZW5lZCBpdCB0aHJvdWdoIGEgZGlmZmVyZW50IGhh
cmQgbGlua2VkIG5hbWUgKGFuZCBkaWQgbm90DQpjcmVhdGUgdGhpcyBoYXJkIGxpbmsgYWZ0ZXIg
d2UgZ290IHRoZSBkZWxlZ2F0aW9uKS4NCg0KUGVyaGFwcyB3ZSBjb3VsZCBkZWZpbmUgYSBtYWdp
YyB2YWx1ZSBmb3IgZGVudHJ5LT5kX3RpbWUgdGhhdCBjYXVzZXMgdXMNCnRvIHNraXAgcmV2YWxp
ZGF0aW9uIGlmIGFuZCBvbmx5IGlmIHdlIGhvbGQgYSBkZWxlZ2F0aW9uPw0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
