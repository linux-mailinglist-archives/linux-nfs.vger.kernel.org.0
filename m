Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81713D8635
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 05:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfJPDJf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 23:09:35 -0400
Received: from mail-eopbgr740097.outbound.protection.outlook.com ([40.107.74.97]:28698
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbfJPDJf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Oct 2019 23:09:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW++LaAb2SY69VnNsNoQnmb6MKJ1X3jqhaolVr/rdjYcV4csWEleHMNWyLI2Vq+pvSa88+G+vygNBudoKQnZx1C7FO6SLf5FNBmankCfL0JEUVMNpeJvxr327ZwryefSVVnV7kefhMPrIoaz1ubXcW++DLd9L/n2V7rlaDVbjYufEboH/1n1Z6hUP//1GqQCS5Xz8uaOIq0hrgP8BfkZ3BEnh19ctjWay/sMrkDoFFfZOuRmKvQsacfUXPnNiwdGQZHA5jmJ5q+Ez1sqGS5tJFO2WaEnNKnAeGB0Qr6fVizIeKCcVXxeK/dhCjl5LJj68dbXu6HhjE4uQfx+xwlE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYqiARXwLXYngOzh8qR594QbWumrl9KKHlCx+EVvWrc=;
 b=YpKMV4/IxRtW9Og1z128QaCa1sABsA5OQHn96dstOHsUyCZa/5A2h7Wk7BfpZawzMUwYkObPutll1aKZdsC6iYdXFUKsqVaxgOQk0iwKPKx+b3nkkIo3gCAx5RyQ/IidgrPB6nr+BsP3XQHfLFjBI78igkdc7Y0W1Q5DNvHWWLZrXJS1GPm+Rj5880xYvNncq/VKVe+KS8qbTPqzszb+CdQwJDrj4XOCc7LqhP6p60oRh937L0CQUdC+YNOxXHDoSklVRM8O51Z1odZIo2trzemcCK8Cjk4DuC1y/C/0Jw0/jtw0PdmSuy4UFVqbjRAeHiLmz86VUZFaLeDHu6dFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYqiARXwLXYngOzh8qR594QbWumrl9KKHlCx+EVvWrc=;
 b=WUPyGUzQwhrsCvTd+QlusupO1TkVAp+IdPJJDfdRMj7v5soZVqMFo31tFtPq/vg5G8daaiR2a41JhpqV7Geovtt9DXaCXl3KVAtiUi6doYyQ3tw96PMY1jCW8Rkn0j/d9RyEVEG7gITN16q7RKlAptSxU3YTZ7TIkVtA4qAbqvY=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB0969.namprd13.prod.outlook.com (10.168.239.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.13; Wed, 16 Oct 2019 03:09:31 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e%10]) with mapi id 15.20.2347.023; Wed, 16 Oct
 2019 03:09:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "suyj.fnst@cn.fujitsu.com" <suyj.fnst@cn.fujitsu.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: About patch NFS: Fix O_DIRECT accounting of number of bytes
 read/written
Thread-Topic: About patch NFS: Fix O_DIRECT accounting of number of bytes
 read/written
Thread-Index: AdWDupUDFq5cvVv1QGGoMCLng+/bzAAFIhGA
Date:   Wed, 16 Oct 2019 03:09:29 +0000
Message-ID: <ee3fc922be7850532a6625a09569b74e24d75b15.camel@hammerspace.com>
References: <9608C5E5429A7846A89FDA46D5296B97334E3824@G08CNEXMBPEKD03.g08.fujitsu.local>
In-Reply-To: <9608C5E5429A7846A89FDA46D5296B97334E3824@G08CNEXMBPEKD03.g08.fujitsu.local>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [107.1.192.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 407c5ed3-d705-4b28-07dc-08d751e643b5
x-ms-traffictypediagnostic: DM5PR13MB0969:
x-microsoft-antispam-prvs: <DM5PR13MB09692BEF049FF291FE8D6BBFB8920@DM5PR13MB0969.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(136003)(39840400004)(346002)(199004)(189003)(256004)(14444005)(99286004)(6916009)(25786009)(478600001)(118296001)(2906002)(6486002)(8676002)(86362001)(6246003)(6512007)(6436002)(54906003)(81156014)(2501003)(5640700003)(8936002)(81166006)(71200400001)(3846002)(4326008)(6116002)(229853002)(4001150100001)(36756003)(2351001)(316002)(14454004)(66446008)(66556008)(2616005)(186003)(6506007)(66066001)(71190400001)(476003)(66476007)(64756008)(11346002)(66946007)(76116006)(91956017)(26005)(446003)(102836004)(5660300002)(305945005)(76176011)(486006)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB0969;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ky3/gnLdDJHTNHDvFrhtVGO3Zsp6jTsMPlx8GZgXnJE8mAq8rO8YUYrWPL709vdIWRXY6e6KkC7E3T7DAaQCtVaCLLbLywxXImAHxzCcIlmJXqlYMK8OEW7VjKN9/GpzMj9F0UYnCxYwTnS2JJ4RpOgrlnlw3u4MDJn7xwc9SYpGxbobrFVxQPryqzq59efT6eL2JHogauDMQ6nzGqod0rITUNx3Gi2qRkczbHrehIzpLWSh+cq3FfKVOr+GaUHJQm4kHyGATGMOpdKw4aL3Y+R/MzY29E+cg6EBeWR+R8NiUNmQ8iQsbOU2TYYpRbCj5oxSGLgqvmd85+cpN9FqtE/8DpB4o791xYss77hIkfv2rJetlEjA7tV2zcLRZFLQItzcoyiwlaJoKeChWv7Y644oAD7yxha0S6CQu2w0ea8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C96EDE7DF36D4D469BD597B5F8DB93D1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407c5ed3-d705-4b28-07dc-08d751e643b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 03:09:29.8818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yX6EYKSb0A3KjSzCWyZQJJtTEn1aoW7jBd6KivajOsSpCe8qT3F2uV898MXNQpPnG6+9/7qJHB6qg1fwLPqyhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0969
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTE2IGF0IDAxOjAwICswMDAwLCBTdSwgWWFuanVuIHdyb3RlOg0KPiBI
aSB0cm9uZCwNCj4gQmVjYXVzZSBNeSBtYWlsIHN5c3RlbSBjYW50IHJlY2VpdmUgbmZzIG1haWwg
bGlzdOKAmXMgbWFpbHMsIEkgcmVwbHkNCj4geW91ciBwYXRjaCBoZXJlLg0KPiBJIGhhdmUgc29t
ZSBxdWVzdGlvbiBmb3IgdGhlIHBhdGNoLg0KPiANCj4gPiBOby4gQmFzaWMgT19ESVJFQ1QgZG9l
cyBub3QgZ3VhcmFudGVlIGF0b21pY2l0eSBvZiByZXF1ZXN0cywgd2hpY2gNCj4gPiBpcw0KPiA+
IHdoeSB3ZSBkbyBub3QgaGF2ZSBnZW5lcmljIGxvY2tpbmcgYXQgdGhlIFZGUyBsZXZlbCB3aGVu
IHJlYWRpbmcNCj4gPiBhbmQNCj4gPiB3cml0aW5nLiBUaGUgb25seSBndWFyYW50ZWUgYmVpbmcg
b2ZmZXJlZCBpcyB0aGF0IE9fRElSRUNUIGFuZA0KPiA+IGJ1ZmZlcmVkDQo+ID4gd3JpdGVzIGRv
IG5vdCBjb2xsaWRlLg0KPiBEbyB5b3UgbWVhbiBvdGhlciBmcyBhbHNvIGNhbnQgZ3VhcmFudGVl
IGF0b21pY2l0eSBvZiBPX0RJUkVDVA0KPiByZXF1ZXN0IG9yIGp1c3QgbmZzPw0KPiANCj4gPiBJ
T1c6IEkgdGhpbmsgdGhlIGJhc2ljIHByZW1pc2UgZm9yIHRoaXMgdGVzdCBpcyBqdXN0IGJyb2tl
biAoYXMgSQ0KPiA+IGNvbW1lbnRlZCBpbiB0aGUgcGF0Y2ggc2VyaWVzIEkgc2VudCkgYmVjYXVz
ZSBpdCBpcyBhc3N1bWluZyBhDQo+ID4gYmVoYXZpb3VyIHRoYXQgaXMgc2ltcGx5IG5vdCBndWFy
YW50ZWVkLg0KPiBTbyB0aGUgZ2VuZXJpYy80NjUgb2YgeGZzdGVzdHMgY2Fu4oCZdCBhcHBseSB0
byBuZnMgZm9yIG5vdywgYW0gSQ0KPiByaWdodD8NCg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwgaXQg
aXMgZG9lcyBub3QgYmVsb25nIGluIHRoZSAnZ2VuZXJpYycgY2F0ZWdvcnkgYXQNCmFsbC4NCg0K
PiANCj4gPiBCVFc6IG5vdGUgdGhhdCBidWZmZXJlZCB3cml0ZXMgaGF2ZSB0aGUgc2FtZSBwcm9w
ZXJ0eS4gVGhleSBhcmUNCj4gPiBvcmRlcmVkDQo+ID4gd2hlbiBiZWluZyB3cml0dGVuIGludG8g
dGhlIHBhZ2UgY2FjaGUsIG1lYW5pbmcgdGhhdCByZWFkcyBvbiB0aGUNCj4gPiBzYW1lDQo+ID4g
Y2xpZW50IHdpbGwgc2VlIG5vIGhvbGVzLCBob3dldmVyIGlmIHlvdSB0cnkgdG8gcmVhZCBmcm9t
IGFub3RoZXINCj4gPiBjbGllbnQsIHRoZW4geW91IHdpbGwgc2VlIHRoZSBzYW1lIGJlaGF2aW91
ciwgd2l0aCB0ZW1wb3JhcnkgaG9sZXMNCj4gPiBtYWdpY2FsbHkgYXBwZWFyaW5nIGluIHRoZSBm
aWxlLg0KPiBBcyB5b3Ugc2F5LCBuZnMgYnVmZmVyZWQgd3JpdGUgYWxzbyBoYXMgdGhlIGhvbGUg
cHJvYmxlbSB3aXRoDQo+IG11bHRpcGxlIHIvdyBvbiBkaWZmZXJlbnQgY2xpZW50cy4NCj4gSSB3
YW50IHRvIGtub3cgaWYgdGhlIHByb2JsZW0gZXhpc3RzIGluIG90aGVyIGxvY2FsIGZzIHN1Y2gg
YXMNCj4geGZzLGV4dDQ/DQo+IA0KDQpUaGVyZSBpcyBubyBWRlMgbG9ja2luZyB0aGF0IGVuZm9y
Y2VzIGFueSBzZXJpYWxpc2F0aW9uIGZvciBPX0RJUkVDVC4NClNvIHVubGVzcyB0aGUgZmlsZXN5
c3RlbSBpbXBsZW1lbnRzIGl0cyBvd24gc2VyaWFsaXNhdGlvbiAod2hpY2ggeGZzDQpkb2VzKSB0
aGVuIHRoZXJlIGlzIG5vIGd1YXJhbnRlZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
