Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7210276131
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 21:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIWTjx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 15:39:53 -0400
Received: from mail-bn8nam12on2124.outbound.protection.outlook.com ([40.107.237.124]:57056
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgIWTjx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 23 Sep 2020 15:39:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV0ycK9ibu9BSd/cvXh821gQpJj+g6Njaj4oj1yEKA85IJ798IUxELGZ4dqzo7B8/rH1uKR2w8sfC1y5H9nwlUZnxXrvgtaUNXuzWKbDd1FH/6LfURIb1C9LuxejOX+Zuw0rO7fz1mzqBpRmC9VdccY0YOlAfywo9JayUZ5TwHvHEyZXQTU+EcSgnFHF8QI9t/XqRFwcQxlY5XfOmGouv2yuj9kF+SWdmZOZYRbiaiRE8kpt+RvC8N4qYh7XZwo1rX0OxC58naRxtS2BLK5JZ70qdh8FffoW39vfPNK1hTs7LPRZMcyFmt1SmYthxqPI6GsRl751w33xBa0Go52+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHXL120T4HBWcILTBxB1c+YH78PVnxMgff6rqEtQkMc=;
 b=B9YrpHzBPpVTUuj0eIVruvnwFJLK3/I0380ou5NRvq+cpMx/lqAAN6JOudra41BiIMyHeffH1zehmSPG//QlCF1P/BlpAQ5osz/2cVv9WFdHkfLC8kP/UiaWhn50HHogsk+aYVf03WL3Bq1uORBKwswIJb4wCwSCNzCvZi7VOwWawA9dBfcdIrQl0x7iNehkIDPG28vK+KP+7132AvkmtfwwK+JrBYzsGVQ26rCfN6uCCp5DKspmIzEkojX358vgFq7Te9NMOPNQw32rp/esjMjIVoHoul3igCSIalOKIBHRUKWVQ4rb2yZHqyExua1eTjy1qxSVxZnyjvCJkWN7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHXL120T4HBWcILTBxB1c+YH78PVnxMgff6rqEtQkMc=;
 b=T4eurh5tbTq4zvSz2PKthySqp6kORY+H45KgBsgVu7sGqyNab2nuHwyTEn/OZh+m3Oa8Hp17SA05wmeYM8mf+WRd0jvn1EC1qc+q11mlbn6bhw4MDTSIv7VgVafEhf8I7ECAF4jKEHeceFButIYtWWq9etxb7fOt6qrhc/SMlbQ=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3120.namprd13.prod.outlook.com (2603:10b6:208:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.15; Wed, 23 Sep
 2020 19:39:48 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3433.013; Wed, 23 Sep 2020
 19:39:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/2 v3] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Topic: [PATCH 1/2 v3] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Index: AQHWkdAtEMKsMIWKs0WWIwkhmSwpm6l2kgaAgAAKGgCAAALUAA==
Date:   Wed, 23 Sep 2020 19:39:48 +0000
Message-ID: <3053ab24162fbb9431f4918373aaa919c3b55a34.camel@hammerspace.com>
References: <cover.1600882430.git.bcodding@redhat.com>
         <787d0d4946efb286f4dc51051b048277c0dc697e.1600882430.git.bcodding@redhat.com>
         <69ca1c64b0e7eb205e8f53af8febf6d688f65d80.camel@hammerspace.com>
         <24324678-510B-4524-8C17-EB7365C2A3CD@redhat.com>
In-Reply-To: <24324678-510B-4524-8C17-EB7365C2A3CD@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec605dd8-1316-4916-9b55-08d85ff86e96
x-ms-traffictypediagnostic: MN2PR13MB3120:
x-microsoft-antispam-prvs: <MN2PR13MB3120205BF43E1085FCC6B7D3B8380@MN2PR13MB3120.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsCNtNl6EOjzW/6bvGhVz+ATFm+LzH27LmdzXVcaUX/sFoHYu8HCACkCyURgGwmi2gZeY1PVT839UoyC7+fkR1gK6ZX8EUYEch3T1o1UAiEA4YhYEhT5P3SSet2UCKPYhgGP5EbnuE0PJNBnJsxFh8qMmWis/240Oar0njH7LXRJEUIT91ZnTl3MSXvoKUIgd3qvLaIf/DFulEOQ86ExjqibdYVxzCZDhaiQ+sc6CxxMpwGGhwYmIMjGBNfRcgckXiC2Gr0acvN9VQFesRe+VnzVBOfrw93UhRdzQe1nLnqXzPXe0HBMEvNwaCEVi7zK38h666F5qLaL0Jac8BAuD/AtFVfor/L0DSkSRSuru16gZe0/t2Fa8IbVfV3tolB+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(136003)(366004)(346002)(376002)(83380400001)(8676002)(6916009)(76116006)(66946007)(8936002)(6506007)(66556008)(91956017)(66476007)(66446008)(64756008)(71200400001)(2906002)(186003)(6486002)(53546011)(2616005)(26005)(5660300002)(36756003)(478600001)(4326008)(86362001)(316002)(54906003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2sqZf9D2MZBlZTEmRKyUHJ1iR5uRBGzUgDC+wo6Omtm1WrFcYmF9qBG1GcTsh6wLj8u9DEQCI2SD5lvvVxWO2Y+H7Yt9dh2OeTH4BOikPNckkaSoL/iPBVYptR69uKeKWv2hqzyszVqiyS1/jCkB3NqHHhqkNKwrmAEksn4aBKPOdUUX0Xrv2LZi8wZO4MzbJLjLlu7pluoeVaCZVDm9rtfdnx5huYc2HVMMoY2hwceGSa4l4yEb7lS7a721qGC7+VULJYfgPpV6wEXcGRDILr0kszlY0jI1pNuqobiDYCKmEW5QYTDzwWwHEadJswnmNoc73At8srecI5VB6BoLiMuM4VhU3+76IW/Z6p8hlZSLBEQU7AOiLjHRgKo3sbTnAGAbgFiFLdMNT84oWcuhCVFsO8oScOBRX4e26Zbc4pWCAvqTVTLarFoY65VLvN9M+4HrVUL1wyxhRIHsPmejaS+M2Bwp+bV6ez60t9YCjF6c9qg6YXBByzvGbA0Lq8V6rGIQ7TtA8IvKA8nRIS8voD43Fz/h99F+7x8MgWBlrAunG/QAbt1LFdJiTDGwMDYCiJl55Rw5XKJ0N83b/Uy8vRuqbrGO4Wivvlx/tJrguwj95fFuoQNAsawf5j4Yx11O4ReoZ13hiT9NJUmODRvl5Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F349F982BBCF34FA8479CA67532CFFB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec605dd8-1316-4916-9b55-08d85ff86e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 19:39:48.3712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f93jfIoAT+w1a0IbtOXhr++rrQ4WQH2gAXxdSvExE75yCUy+Gj7YjJ9BwFFCZLH6SCfTcTP9wFNWq/tGok9BAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTIzIGF0IDE1OjI5IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMyBTZXAgMjAyMCwgYXQgMTQ6NTMsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gV2VkLCAyMDIwLTA5LTIzIGF0IDEzOjM3IC0wNDAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gU2luY2UgY29tbWl0IDBlMGNiMzViNDE3ZiAoIk5GU3Y0OiBI
YW5kbGUgTkZTNEVSUl9PTERfU1RBVEVJRCBpbg0KPiA+ID4gQ0xPU0UvT1BFTl9ET1dOR1JBREUi
KSB0aGUgZm9sbG93aW5nIGxpdmVsb2NrIG1heSBvY2N1ciBpZiBhDQo+ID4gPiBDTE9TRQ0KPiA+
ID4gcmFjZXMNCj4gPiA+IHdpdGggdGhlIHVwZGF0ZSBvZiB0aGUgbmZzX3N0YXRlOg0KPiA+ID4g
DQo+ID4gPiBQcm9jZXNzIDEgICAgICAgICAgIFByb2Nlc3MgMiAgICAgICAgICAgU2VydmVyDQo+
ID4gPiA9PT09PT09PT0gICAgICAgICAgID09PT09PT09PSAgICAgICAgICAgPT09PT09PT0NCj4g
PiA+ICBPUEVOIGZpbGUNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgT1BFTiBmaWxlDQo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmVwbHkgT1BFTiAoMSkN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXBseSBPUEVO
ICgyKQ0KPiA+ID4gIFVwZGF0ZSBzdGF0ZSAoMSkNCj4gPiA+ICBDTE9TRSBmaWxlICgxKQ0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJlcGx5IE9MRF9TVEFU
RUlEICgxKQ0KPiA+ID4gIENMT1NFIGZpbGUgKDIpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgUmVwbHkgQ0xPU0UgKC0xKQ0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICBVcGRhdGUgc3RhdGUgKDIpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIHdhaXQg
Zm9yIHN0YXRlIGNoYW5nZQ0KPiA+ID4gIE9QRU4gZmlsZQ0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICB3YWtlDQo+ID4gPiAgQ0xPU0UgZmlsZQ0KPiA+ID4gIE9QRU4gZmlsZQ0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICB3YWtlDQo+ID4gPiAgQ0xPU0UgZmlsZQ0KPiA+ID4gIC4uLg0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAuLi4NCj4gPiA+IA0KPiA+ID4gQXMgbG9uZyBhcyB0aGUg
Zmlyc3QgcHJvY2VzcyBjb250aW51ZXMgdXBkYXRpbmcgc3RhdGUsIHRoZSBzZWNvbmQNCj4gPiA+
IHByb2Nlc3MNCj4gPiA+IHdpbGwgZmFpbCB0byBleGl0IHRoZSBsb29wIGluDQo+ID4gPiBuZnNf
c2V0X29wZW5fc3RhdGVpZF9sb2NrZWQoKS4gIFRoaXMNCj4gPiA+IGxpdmVsb2NrDQo+ID4gPiBo
YXMgYmVlbiBvYnNlcnZlZCBpbiBnZW5lcmljLzE2OC4NCj4gPiA+IA0KPiA+ID4gRml4IHRoaXMg
YnkgZGV0ZWN0aW5nIHRoZSBjYXNlIGluIG5mc19uZWVkX3VwZGF0ZV9vcGVuX3N0YXRlaWQoKQ0K
PiA+ID4gYW5kDQo+ID4gPiB0aGVuIGV4aXQgdGhlIGxvb3AgaWY6DQo+ID4gPiAgLSB0aGUgc3Rh
dGUgaXMgTkZTX09QRU5fU1RBVEUsIGFuZA0KPiA+ID4gIC0gdGhlIHN0YXRlaWQgc2VxdWVuY2Ug
aXMgPiAxLCBhbmQNCj4gPiA+ICAtIHRoZSBzdGF0ZWlkIGRvZXNuJ3QgbWF0Y2ggdGhlIGN1cnJl
bnQgb3BlbiBzdGF0ZWlkDQo+ID4gPiANCj4gPiA+IEZpeGVzOiAwZTBjYjM1YjQxN2YgKCJORlN2
NDogSGFuZGxlIE5GUzRFUlJfT0xEX1NUQVRFSUQgaW4NCj4gPiA+IENMT1NFL09QRU5fRE9XTkdS
QURFIikNCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjUuNCsNCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBmcy9uZnMvbmZzNHByb2MuYyB8IDE2ICsrKysrKysrKy0tLS0tLS0N
Cj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0K
PiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZz
NHByb2MuYw0KPiA+ID4gaW5kZXggNmU5NWM4NWZlMzk1Li44YzJiYjkxMTI3ZWUgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiA+ID4gKysrIGIvZnMvbmZzL25mczRwcm9j
LmMNCj4gPiA+IEBAIC0xNTg4LDE5ICsxNTg4LDIxIEBAIHN0YXRpYyB2b2lkDQo+ID4gPiBuZnNf
dGVzdF9hbmRfY2xlYXJfYWxsX29wZW5fc3RhdGVpZChzdHJ1Y3QgbmZzNF9zdGF0ZSAqc3RhdGUp
DQo+ID4gPiAgc3RhdGljIGJvb2wgbmZzX25lZWRfdXBkYXRlX29wZW5fc3RhdGVpZChzdHJ1Y3Qg
bmZzNF9zdGF0ZQ0KPiA+ID4gKnN0YXRlLA0KPiA+ID4gIAkJY29uc3QgbmZzNF9zdGF0ZWlkICpz
dGF0ZWlkKQ0KPiA+ID4gIHsNCj4gPiA+IC0JaWYgKHRlc3RfYml0KE5GU19PUEVOX1NUQVRFLCAm
c3RhdGUtPmZsYWdzKSA9PSAwIHx8DQo+ID4gPiAtCSAgICAhbmZzNF9zdGF0ZWlkX21hdGNoX290
aGVyKHN0YXRlaWQsICZzdGF0ZS0+b3Blbl9zdGF0ZWlkKSkgew0KPiA+ID4gKwlpZiAodGVzdF9i
aXQoTkZTX09QRU5fU1RBVEUsICZzdGF0ZS0+ZmxhZ3MpKSB7DQo+ID4gPiArCQkvKiBUaGUgY29t
bW9uIGNhc2UgLSB3ZSdyZSB1cGRhdGluZyB0byBhIG5ldyBzZXF1ZW5jZQ0KPiA+ID4gbnVtYmVy
ICovDQo+ID4gPiArCQlpZiAobmZzNF9zdGF0ZWlkX21hdGNoX290aGVyKHN0YXRlaWQsICZzdGF0
ZS0NCj4gPiA+ID4gb3Blbl9zdGF0ZWlkKSAmJg0KPiA+ID4gKwkJCW5mczRfc3RhdGVpZF9pc19u
ZXdlcihzdGF0ZWlkLCAmc3RhdGUtDQo+ID4gPiA+IG9wZW5fc3RhdGVpZCkpIHsNCj4gPiA+ICsJ
CQluZnNfc3RhdGVfbG9nX291dF9vZl9vcmRlcl9vcGVuX3N0YXRlaWQoc3RhdGUsDQo+ID4gPiBz
dGF0ZWlkKTsNCj4gPiA+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4gPiA+ICsJCX0NCj4gPiA+ICsJfSBl
bHNlIHsNCj4gPiA+ICsJCS8qIFRoaXMgaXMgdGhlIGZpcnN0IE9QRU4gKi8NCj4gPiA+ICAJCWlm
IChzdGF0ZWlkLT5zZXFpZCA9PSBjcHVfdG9fYmUzMigxKSkNCj4gPiA+ICAJCQluZnNfc3RhdGVf
bG9nX3VwZGF0ZV9vcGVuX3N0YXRlaWQoc3RhdGUpOw0KPiA+ID4gIAkJZWxzZQ0KPiA+ID4gIAkJ
CXNldF9iaXQoTkZTX1NUQVRFX0NIQU5HRV9XQUlULCAmc3RhdGUtPmZsYWdzKTsNCj4gPiANCj4g
PiBJc24ndCB0aGlzIGdvaW5nIHRvIGNhdXNlIGEgcmVvcGVuIG9mIHRoZSBmaWxlIG9uIHRoZSBj
bGllbnQgaWYgaXQNCj4gPiBlbmRzDQo+ID4gdXAgcHJvY2Vzc2luZyB0aGUgcmVwbHkgdG8gdGhl
IHNlY29uZCBPUEVOIGFmdGVyIGl0IHByb2Nlc3NlcyB0aGUNCj4gPiBzdWNjZXNzZnVsIENMT1NF
Pw0KPiANCj4gWWVzLCB0aGF0J3MgdHJ1ZSAtIGJ1dCB0aGF0J3MgYSBkaWZmZXJlbnQgYnVnIHRo
YXQgSSBoYXZlbid0IG5vdGljZWQNCj4gb3INCj4gY29uc2lkZXJlZC4gIFRoaXMgcGF0Y2ggaXNu
J3QgaW50cm9kdWNpbmcgaXQuDQo+IA0KPiA+IElzbid0IHRoZSByZWFsIHByb2JsZW0gaGVyZSBy
YXRoZXIgdGhhdCB0aGUgcmVwbHkgdG8gQ0xPU0UgbmVlZHMgdG8NCj4gPiBiZQ0KPiA+IHByb2Nl
c3NlZCBpbiBvcmRlciB0b28/DQo+IA0KPiBOb3QganVzdCB0aGUgcmVwbHksIHRoZSBhY3R1YWwg
cmVxdWVzdCBhcyB3ZWxsLiAgSWYgd2UgaGF2ZSBhIHdheSB0bw0KPiBwcm9wZXJseSBzZXJpYWxp
emUgcHJvY3NzaW5nIG9mIENMT1NFIHJlc3BvbnNlcywgd2UgY291bGQganVzdCBub3QNCj4gc2Vu
ZCB0aGUNCj4gQ0xPU0UgaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiANCj4gSSdkIHJhdGhlciBub3Qg
c2VuZCB0aGUgQ0xPU0UgaWYgdGhlcmUncyBhbm90aGVyIE9QRU4gaW4gcGxheSwgYW5kIGlmDQo+
IHRoYXQncw0KPiB0aGUgYmFycmllciB0byBnZXR0aW5nIHRoaXMgcGFydGljdWxhciBidWcgZml4
ZWQsIEknbGwgd29yayBvbg0KPiB0aGF0LiAgV2hhdA0KPiBtZWNoYW5pc20gY2FuIGJlIHVzZWQ/
ICBXaGF0IGlmIHRoZSBjbGllbnQga2VwdCBhIHNlcGFyYXRlICJwZW5kaW5nIg0KPiBzdGF0ZWlk
DQo+IHRoYXQgY291bGQgYmUgdXBkYXRlZCBiZWZvcmUgZWFjaCBvcGVyYXRpb24gdGhhdCB3b3Vs
ZCBhdHRlbXB0IHRvDQo+IHByZWRpY3QNCj4gd2hhdCB0aGUgc2VydmVyJ3MgcmVzdWx0aW5nIGNo
YW5nZSB3b3VsZCBiZT8NCj4gDQo+IE1heWJlIGJldHRlciB3b3VsZCBiZSBhIGNvdW50ZXIgdGhh
dCBnZXRzIGluY3JlbWVudGVkIGZvciBlYWNoDQo+IHRyYW5zaXRpb24NCj4gdG8vZnJvbSBORlNf
T1BFTl9TVEFURSBzbyB3ZSBjYW4gY2hlY2sgaWYgdGhlIHN0YXRlaWQgaXMgaW4gdGhlIHNhbWUN
Cj4gZ2VuZXJhdGlvbiBhbmQgYSBjb3VudGVyIGZvciBvdXRzdGFuZGluZyBvcGVyYXRpb25zIHRo
YXQgYXJlIGV4cGVjdGVkDQo+IHRvDQo+IGJ1bXAgdGhlIHNlcXVlbmNlLg0KPiANCg0KVGhlIGNs
aWVudCBjYW4ndCBwcmVkaWN0IHdoYXQgaXMgZ29pbmcgdG8gaGFwcGVuIHcuci50LiBhbiBPUEVO
IGNhbGwuDQpJZiBpdCBkb2VzIGFuIG9wZW4gYnkgbmFtZSwgaXQgZG9lc24ndCBldmVuIGtub3cg
d2hpY2ggZmlsZSBpcyBnb2luZyB0bw0KZ2V0IG9wZW5lZC4gVGhhdCdzIHdoeSB3ZSBoYXZlIHRo
ZSB3YWl0IGxvb3ANCmluIG5mc19zZXRfb3Blbl9zdGF0ZWlkX2xvY2tlZCgpLiBXaHkgc2hvdWxk
IHdlIG5vdCBkbyB0aGUgc2FtZSBpbg0KQ0xPU0UgYW5kIE9QRU5fRE9XTkdSQURFPyBJdCdzIHRo
ZSBzYW1lIHByb2JsZW0uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
