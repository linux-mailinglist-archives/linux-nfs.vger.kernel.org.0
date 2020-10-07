Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D95286ADE
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Oct 2020 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgJGW2R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 18:28:17 -0400
Received: from mail-dm6nam10on2111.outbound.protection.outlook.com ([40.107.93.111]:47841
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728275AbgJGW2Q (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 18:28:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcNCLJDh99W2tceK6P4lUsDOvDS3DVRiefClxMxEh252xlv2OCpZYZ/dl0wdBNSUYJ7bD3Ei4X4R5XU/xsIvgRRZJD9bNi+RgOIImkA/xo+4LqJ+oN/JmRwPQ9z3JPUpIHsq0K5oqbRtC4tl1ltDiwNK+6glKwQzYwFxnT4gTmZ1ILI4LC7az4vwjSs0NiH38vrPRvZ+3zfPVxNixFzEghi0FQs2xPXI405zeTBvKWp/75WobcakMVEQ+V5kazlXq6/367HEY593uffe++MgCbs7qCXBftviVOugMGsh2g7BNTLQ2gU62kSuGdQuTWvKUdS5SckhGLHgRAHDcis8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5iG2DyDmvExYTYocW4tBkXe38awJKuiUFVszGzbhSQ=;
 b=Ygs38kNM2fOnXTraivEnh1rRbEELf+9DIB9y2ClhFDeXLlmeVlBBX8w+GXHzt4ziKivN6vuFy3irtbehUwGMFUMCKpPE4XyGxbuQNGDQeRln7KJETDjbgVYUN09ZeVFMQI6+Hgqey67VSw/zHbMgHiXZGBfRTc1Whhty/gcVHaLfvNYJjXqca04tYg6K99YObDDEzCWPCP5aonop7MxO6+Zs0WT/lVsifQk8TpJr5BTUIkgT1w3qX6Fr+j2ywphaDrCgujh3N8PBhTV8UOhYeiOZwEYYnnv+RR1VRTrVe7dJ2Wo0pTOgYevsD1KwdzwHlk8GxgyErsDLSf4LghCePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5iG2DyDmvExYTYocW4tBkXe38awJKuiUFVszGzbhSQ=;
 b=PJt83JQBVnW3nem+QGTacT5tQDJB9PK0feqYDW4+YtQV3qC/s0kaMhCJCn1GUJbSOFkdd6kp0Ix+PleQTUszv7G6VBBiVTxGeZDFQZ9u39+tPItyEeZjGZF6ufySRk+s1mGUH6q94bai1v+nwUxC2QXY4pGl+YpxAcjW4Q2qhZc=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3261.namprd13.prod.outlook.com (2603:10b6:208:152::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13; Wed, 7 Oct
 2020 22:28:11 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%7]) with mapi id 15.20.3455.021; Wed, 7 Oct 2020
 22:28:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] NFSv4: Use the net namespace uniquifier if it is set
Thread-Topic: [PATCH 2/2] NFSv4: Use the net namespace uniquifier if it is set
Thread-Index: AQHWnO4nXiEOgG0hTESyzGmpb01iBamMsTQAgAAHNIA=
Date:   Wed, 7 Oct 2020 22:28:11 +0000
Message-ID: <d716cee24b7cc317b99beeefaa61e8db2a0e527a.camel@hammerspace.com>
References: <20201007210720.537880-1-trondmy@kernel.org>
         <20201007210720.537880-2-trondmy@kernel.org>
         <20201007210720.537880-3-trondmy@kernel.org>
         <7eea5363-6f0c-0897-98e4-5a745130a1eb@oracle.com>
In-Reply-To: <7eea5363-6f0c-0897-98e4-5a745130a1eb@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb730da4-1869-40ff-6a45-08d86b104637
x-ms-traffictypediagnostic: MN2PR13MB3261:
x-microsoft-antispam-prvs: <MN2PR13MB3261DD9D71B0F5539685FE06B80A0@MN2PR13MB3261.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nbudUz3jPQY5DuHXuhKnbEaa/LCknOQg5z3ZKcUIvHi+2F2wkWpKtatnAhZTSS+IoDZVQSba4CTQ0lghW0PIxzbHYkGBNdLizDDD9yTaUgzVPjpu9AEBa4QMfzkBrM2aCg52S+NdJIy72pw5rX764De6WNHp6zwr987541CkDN66Jb5ct/Vr49MnR3OxN0ydUGbDelF1ZXDl/4o4jqJmb/+DFpAhA+QkKPGqDAZlt9hwnJUK8JYC0A5ep9hqwYW61xsvDFr5CkkWZicbj9irOHL8Vv+5g5CBdnDYgA4nPmTExdNkKX6fFwh5jFg4mHH4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(366004)(396003)(346002)(376002)(136003)(71200400001)(478600001)(186003)(91956017)(53546011)(26005)(6506007)(83380400001)(110136005)(66446008)(316002)(66556008)(76116006)(64756008)(66946007)(66476007)(8676002)(6486002)(8936002)(4326008)(6512007)(5660300002)(36756003)(2616005)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FHAXySdpmbtlW+inscfiD47ZmdVhK87E/MZ9Y0bfbYIhG2LRcn0BbpfyqAMjC7HKdsPFEYUuv7oJEdsYHrjhPU0KQDa2XQOsms/J4U4sbSdjihit8XWrYY1WMeKINN/6A1RUjThWgNRdH9zxSmjNCz/4lI+N10XU19ZNCEzJDaCcITGd6tex6hNZWcYlmR+XU8bFs1QYhHFamLHIKXvU+ta3qPHVOMAOpbKMjhO2etAZj0fh6kyY/kI6fIw/MljspTqzh/zNu4yDdjOZy9v+S+rrun7g/mo2PsgIvfjAvOSNEmfndtrzpFg5e/u0nlMct79xxaotzp4Pmr/bByjPB8Ws2cf+zpG2rDwVcvNl1CV07SBlx0gWphzb/rzNM5SuJF4drNDf9pyhiVxdycojaPqJX/hRlwKaphhjXj/5cwXBk2V6ywcfQBWaIupW7TKfbZ0M9v6d62q2x5xWgXAPwXprLLAC40TjrR9Gg1N6wSdIQAnnScZwhpfxM1S7L89HDltv/ZXF/k+8K54YGBpRwjFRmsVTV2bIeSS9XsM8uvNfjnWZUCTwbEZqibhgHmPy3ygftpHSvAOv9hZrHu0R/3LWMr2N6KiW9emrGl3avvJjHPjZL5GiVdshzgkjZ3lHxZCLJhaqqUAfTNaOQTdAZw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D179818EC164B7499C4A06FE8D073407@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb730da4-1869-40ff-6a45-08d86b104637
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 22:28:11.3425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYprMDCzZ0omNtkPTVlKVk2rcpXNa6biYx3uMezll88EBjjX6qh+UKNUwAzZrnzbMa/ilW+fnGVaKo0sghPFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3261
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTA3IGF0IDE1OjAyIC0wNzAwLCBEYWkgTmdvIHdyb3RlOg0KPiBPbiAx
MC83LzIwIDI6MDcgUE0sIHRyb25kbXlAa2VybmVsLm9yZyB3cm90ZToNCj4gPiBGcm9tOiBUcm9u
ZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4g
SWYgYSBjb250YWluZXIgc2V0cyBhIG5ldCBuYW1lc3BhY2Ugc3BlY2lmaWMgdW5pcXVpZmllciwg
dGhlbiB1c2UNCj4gPiB0aGF0DQo+ID4gaW4gdGhlIHNldGNsaWVudGlkL2V4Y2hhbmdlaWQgcHJv
Y2Vzcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gLS0tDQo+ID4gICBmcy9uZnMvbmZzNHByb2Mu
YyB8IDIzICsrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjAg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZnMv
bmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiA+IGluZGV4IDNhMzk4ODdlMGU2
ZS4uYTFkZDQ2ZTc0NDBiIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4g
KysrIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gPiBAQCAtNjMsNiArNjMsNyBAQA0KPiA+ICAgI2lu
Y2x1ZGUgImNhbGxiYWNrLmgiDQo+ID4gICAjaW5jbHVkZSAicG5mcy5oIg0KPiA+ICAgI2luY2x1
ZGUgIm5ldG5zLmgiDQo+ID4gKyNpbmNsdWRlICJzeXNmcy5oIg0KPiA+ICAgI2luY2x1ZGUgIm5m
czRpZG1hcC5oIg0KPiA+ICAgI2luY2x1ZGUgIm5mczRzZXNzaW9uLmgiDQo+ID4gICAjaW5jbHVk
ZSAiZnNjYWNoZS5oIg0KPiA+IEBAIC02MDA3LDkgKzYwMDgsMjUgQEAgc3RhdGljIHZvaWQgbmZz
NF9pbml0X2Jvb3RfdmVyaWZpZXIoY29uc3QNCj4gPiBzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwLA0K
PiA+ICAgfQ0KPiA+ICAgDQo+ID4gICBzdGF0aWMgc2l6ZV90DQo+ID4gLW5mczRfZ2V0X3VuaXF1
aWZpZXIoY2hhciAqYnVmLCBzaXplX3QgYnVmbGVuKQ0KPiA+ICtuZnM0X2dldF91bmlxdWlmaWVy
KHN0cnVjdCBuZnNfY2xpZW50ICpjbHAsIGNoYXIgKmJ1Ziwgc2l6ZV90DQo+ID4gYnVmbGVuKQ0K
PiA+ICAgew0KPiA+ICsJc3RydWN0IG5mc19uZXQgKm5uID0gbmV0X2dlbmVyaWMoY2xwLT5jbF9u
ZXQsIG5mc19uZXRfaWQpOw0KPiA+ICsJc3RydWN0IG5mc19uZXRuc19jbGllbnQgKm5uX2NscCA9
IG5uLT5uZnNfY2xpZW50Ow0KPiA+ICsJY29uc3QgY2hhciAqaWQ7DQo+ID4gKwlzaXplX3QgbGVu
Ow0KPiA+ICsNCj4gPiAgIAlidWZbMF0gPSAnXDAnOw0KPiA+ICsNCj4gPiArCWlmIChubl9jbHAp
IHsNCj4gPiArCQlyY3VfcmVhZF9sb2NrKCk7DQo+ID4gKwkJaWQgPSByY3VfZGVyZWZlcmVuY2Uo
bm5fY2xwLT5pZGVudGlmaWVyKTsNCj4gPiArCQlpZiAoaWQgJiYgKmlkICE9ICdcMCcpDQo+ID4g
KwkJCWxlbiA9IHN0cmxjcHkoYnVmLCBpZCwgYnVmbGVuKTsNCj4gPiArCQlyY3VfcmVhZF91bmxv
Y2soKTsNCj4gPiArCQlpZiAobGVuKQ0KPiANCj4gSSB0aGluayAnbGVuJyBjYW4gYmUgdW5pbml0
aWFsaXplZCBoZXJlLg0KDQpUaGFua3MuIFllcywgYWxyZWFkeSBub3RlZCBhbmQgZml4ZWQgaW4g
djIuDQoNCj4gDQo+IC1EYWkNCj4gDQo+ID4gKwkJCXJldHVybiBsZW47DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICAgCWlmIChuZnM0X2NsaWVudF9pZF91bmlxdWlmaWVyWzBdICE9ICdcMCcpDQo+ID4g
ICAJCXJldHVybiBzdHJsY3B5KGJ1ZiwgbmZzNF9jbGllbnRfaWRfdW5pcXVpZmllciwgYnVmbGVu
KTsNCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiBAQCAtNjAzNCw3ICs2MDUxLDcgQEAgbmZzNF9pbml0
X25vbnVuaWZvcm1fY2xpZW50X3N0cmluZyhzdHJ1Y3QNCj4gPiBuZnNfY2xpZW50ICpjbHApDQo+
ID4gICAJCTE7DQo+ID4gICAJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gICANCj4gPiAtCWJ1Zmxl
biA9IG5mczRfZ2V0X3VuaXF1aWZpZXIoYnVmLCBzaXplb2YoYnVmKSk7DQo+ID4gKwlidWZsZW4g
PSBuZnM0X2dldF91bmlxdWlmaWVyKGNscCwgYnVmLCBzaXplb2YoYnVmKSk7DQo+ID4gICAJaWYg
KGJ1ZmxlbikNCj4gPiAgIAkJbGVuICs9IGJ1ZmxlbiArIDE7DQo+ID4gICANCj4gPiBAQCAtNjA4
MSw3ICs2MDk4LDcgQEAgbmZzNF9pbml0X3VuaWZvcm1fY2xpZW50X3N0cmluZyhzdHJ1Y3QNCj4g
PiBuZnNfY2xpZW50ICpjbHApDQo+ID4gICAJbGVuID0gMTAgKyAxMCArIDEgKyAxMCArIDEgKw0K
PiA+ICAgCQlzdHJsZW4oY2xwLT5jbF9ycGNjbGllbnQtPmNsX25vZGVuYW1lKSArIDE7DQo+ID4g
ICANCj4gPiAtCWJ1ZmxlbiA9IG5mczRfZ2V0X3VuaXF1aWZpZXIoYnVmLCBzaXplb2YoYnVmKSk7
DQo+ID4gKwlidWZsZW4gPSBuZnM0X2dldF91bmlxdWlmaWVyKGNscCwgYnVmLCBzaXplb2YoYnVm
KSk7DQo+ID4gICAJaWYgKGJ1ZmxlbikNCj4gPiAgIAkJbGVuICs9IGJ1ZmxlbiArIDE7DQo+ID4g
ICANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
