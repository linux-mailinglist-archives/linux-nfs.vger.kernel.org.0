Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4105A2A6B5A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 18:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgKDREs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 12:04:48 -0500
Received: from mail-mw2nam12on2120.outbound.protection.outlook.com ([40.107.244.120]:7393
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731040AbgKDREr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Nov 2020 12:04:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpV/9AlLyDIFt4UdaUwJX1dqS8BXJuK0DWuYMPBIXdQ2TWhDonp+k3Glq2RUffi2jx3bMIzVq+M7wiA9t6b6VFhhg8IUbnk0CRodf+YQuf5blRgkh/7JazPmWtXm6a3GbUPNU6mzXljyxKLVH3zAc1vvW+onHAVerqfrXH79lxDGM2uMy+7eKFgytQSMaU0b7RsYJNULHRceReufAHdxVvUEafzGBXtBs5XuALgnNKsgLJFu65cSrbgdughZheEcr6nb2IU++o6K/XHGxJ3rWLa6K/E8iAX/WrM50TtrN90AFXdKvUIZReAgtEf+/h19hbztf2d/Ty6oPEMiOWBfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqGGMUSvvTWbdvY0gRQW56LMjOPdPAlpnNpi9VeCrJY=;
 b=UdXg3GGT0fbRI0GIprUScMjZuaRsJw/Bai8P0/7cA4+5tXy7VnT+EXqPvKsX9Vsc22WnpWRcNjAaYIziublBzIC8KkdxfI86tLv5mF0q8hVvbCHwT2ys+anmOH308Kao3A2enW5IANtMR7tDKYzAoQuHFqdYwgYq3sm6p6ec+7oGbJmXuZNhOkRqcqlpW3NsrqR9CkLymVYbDiHRUl9ZyMQbz2fv/570uiI9sdv9sF61X3IB5QuHsC5wtHD/JywO8QxQ7VNzXvBGa1si0uJMYVVAJBENSQLXdP9V40NVxP+82Iy2ouFWFdl5+m5pUKLyVVuSxTSa6W1NqUpS1hEUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqGGMUSvvTWbdvY0gRQW56LMjOPdPAlpnNpi9VeCrJY=;
 b=fp04wFV2PhgFVNicLC12kx8zbjY7SbxIEFRzpo6qhrjM6U4UPql7RZ0Z4o3M69+cNe/lA+HLokxLHmlNclbqvKHrApukqgNw4zz5I+9G/8e2zRuA4N4mwq28zAR9D7u4glh0rat2/TSEagqW6FlDHICzC1q97N52hswC81EdxnE=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3055.namprd13.prod.outlook.com (2603:10b6:208:155::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Wed, 4 Nov
 2020 17:04:44 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Wed, 4 Nov 2020
 17:04:44 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/16] Readdir enhancements
Thread-Topic: [PATCH v2 00/16] Readdir enhancements
Thread-Index: AQHWsfgdekTUB9i/oEC0mC6KcyZv3am4J06AgAAN7gA=
Date:   Wed, 4 Nov 2020 17:04:43 +0000
Message-ID: <50bf1f5c78d16d1018741febf822a00142a07b5b.camel@hammerspace.com>
References: <20201103153329.531942-1-trondmy@kernel.org>
         <FEA7C67B-4091-4797-B05E-D762F0D0B3A1@redhat.com>
In-Reply-To: <FEA7C67B-4091-4797-B05E-D762F0D0B3A1@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6667c65-779f-41e5-a103-08d880e3ba10
x-ms-traffictypediagnostic: MN2PR13MB3055:
x-microsoft-antispam-prvs: <MN2PR13MB305531188961603BC346A496B8EF0@MN2PR13MB3055.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxeMuJqKE9MijXX/Cis5IhGY9GwVXUBBWomxo3BLO1f4NZh6KG/Xdu1F6N/UiwgcXSX/F2tuzFHOmVO7z5bs8tHPIv/6tQS65nC73HiwuJdc73fMRs+PZtBjJSBhYzusJp/s2a9+Db2owfLaRNU20Zex1n38nBet+KshhNr4Me5Bn2An0hqhzDZANmEGBqOgHHt98B9+h03WvZ9TkGa1QtrcmLloCbm4x6rpD4xlwL6NyQFFHG9R2D6inS83OxEV5z9XlTkaz1Yrw7FxGnggr/ly+bvsCVXVGXhGrftCldjIpNSCFL8hnRf/9XCPMwpqwr5ivCMXLCy2/d05yU6f+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(136003)(346002)(366004)(396003)(66556008)(83380400001)(6512007)(86362001)(5660300002)(71200400001)(2616005)(4326008)(186003)(2906002)(36756003)(66446008)(64756008)(26005)(478600001)(91956017)(6506007)(6916009)(316002)(66476007)(66946007)(6486002)(8676002)(8936002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bI3B8ytq72yjd//9/V6lFHmMZcaChLFIMtX5437qVnTfZ8JCvd1Tqv85Qm1EN+hkt59Va7MqWivPbllny1ojeWNmYty9V/u+kjId9M94N6NXpBXeP1bsrhrsVdNmd0/ir6m8eELDcursiC2PMxsobtqJwY0zJa9x5Zmzd72qkQ3eUljAcdD+xX7GJo2JzA7TMXEZ1AFSzhfy1Fm5I3t9HHbo/5jiDdptEW/6rzltYpEibTeCGkKWPilbPhQw78nf6ldGKZ21j1QBKBLOc8nxkoyw4cEtvvTRRc3bpOI3S7jRk+XR03mlgLFzSnkB3RZm6PZXyy/NkiWaRsP0Gw9+k+WK7au3BxgWLtpyeYbbZX4SMHMEvO2l6cbhw5FUZiO8CsaTOqrrT+q19kXwgruauDD5E5/fw/94VCiIbuKnOR2V2jxwJzBLj0fpPKVO43bRrHxV8kZqWpW9ZR5lYpmhiImVk9fod6ajUkEycRqNhe2723g+6GNNB++U9t195psgJcHbKLYQMd0iUGHraE9DVU7zROqnCkEZmT56ojJ6onp1wdHmY4lkzsBcVniKepdOml6EGTYlMdzmk2l97yq5+KHgAvQD8nZxXlSd0Uomf2yK9gBjkvjaZdOyJXyClcWOMxPvq5hXjyg5Qq473n0aGQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4A1BBD6F3D9BB4EBD3C0A6D5944CBCC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6667c65-779f-41e5-a103-08d880e3ba10
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 17:04:43.9751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cd5wbRTp9pSMucq+qz7nuwL0q4Kjh5ruU2ZsSb/lEmZ6L21QsFS/qnmiQgqjZvWXgam/7MSegxtVQofWqxahyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3055
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgQmVuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgdGhlIHRlc3RpbmchDQoNCk9uIFdl
ZCwgMjAyMC0xMS0wNCBhdCAxMToxNCAtMDUwMCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToN
Cj4gSGkgVHJvbmQsIHRoZXNlIGxvb2sgZ3JlYXQhDQo+IA0KPiBJJ20gZG9pbmcgc29tZSBjb21w
YXJpc29uIHRlc3RpbmcgYmVmb3JlL2FmdGVyIHRoaXMgc2V0LCBhbmQgSSdtDQo+IGdldHRpbmcN
Cj4gaW50byBzb21lIG1lbW9yeSBwcmVzc3VyZSBvbiBhIGNsaWVudCB3aXRoIDRHIHJhbSBsaXN0
aW5nIDEuNU0NCj4gZGVudHJpZXMgDQo+IHdpdGgNCj4gMTIgY2hhciBmaWxlbmFtZXMuDQo+IA0K
PiBJdCBsb29rcyBsaWtlIGJlZm9yZSB0aGlzIHNldCwgdGhlIHJlYWRkaXIgY29kZSB3YXMgYSBi
aXQgbW9yZQ0KPiByZXNpbGllbnQgDQo+IGluDQo+IHRoZSBmYWNlIG9mIG1lbW9yeSBwcmVzc3Vy
ZSwgYW5kIEknbSB3b25kZXJpbmcgaWYgd2UndmUgZHJvcHBlZCBhDQo+IGNhbGwgDQo+IHRvDQo+
IG1hcmtfcGFnZV9hY2Nlc3NlZCgpLg0KPiANCj4gKiBCZW4gYWRkczoNCj4gDQo+IEBAIC00NjAs
NyArNDYxLDggQEAgc3RhdGljIGludCBuZnNfcmVhZGRpcl9zZWFyY2hfYXJyYXkoc3RydWN0IA0K
PiBuZnNfcmVhZGRpcl9kZXNjcmlwdG9yICpkZXNjKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkZXNjLT5sYXN0X2Nvb2tpZSA9IGFycmF5LT5sYXN0X2Nvb2tpZTsNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzYy0+Y3VycmVudF9pbmRleCArPSBhcnJh
eS0+c2l6ZTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzYy0+cGFnZV9p
bmRleCsrOw0KPiAtwqDCoMKgwqDCoMKgIH0NCj4gK8KgwqDCoMKgwqDCoCB9IGVsc2UNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFya19wYWdlX2FjY2Vzc2VkKGRlc2MtPnBhZ2Up
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgIGt1bm1hcF9hdG9taWMoYXJyYXkpOw0KPiDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiBzdGF0dXM7DQo+IMKgIH0NCj4gDQo+IC4uIG5vLCB0aGF0J3Mgbm90IGFu
eSBiZXR0ZXIuwqAgSSdtIHN0aWxsIGdldHRpbmcgZXZpY3RlZCBwYWdlcyAob3IsDQo+IGF0DQo+
IGxlYXN0LCBsb3ctaW5kZXhlZCBwYWdlcyB0aGF0IGRvbid0IGhhdmUgUGFnZVVwdG9kYXRlKCkg
c2V0KSwgd2hpY2ggDQo+IG1ha2VzDQo+IGl0IG5lYXJseSBpbXBvc3NpYmxlIHRvIGZpbmlzaCBs
aXN0aW5nIHRoaXMgZGlyZWN0b3J5IGJlY2F1c2Ugd2UganVzdA0KPiBrZWVwDQo+IGludmFsaWRh
dGluZyB0aGUgbWFwcGluZy4NCj4gDQoNCllvdSdyZSByaWdodCB0aGF0IEkgaGFkIHNjcmV3ZWQg
dXAgdGhlIHBhZ2UgYWNjZXNzIG1hcmtpbmcgaW4gdGhlDQpwcmV2aW91cyBwYXRjaHNldHMuIEkg
YmVsaWV2ZSB0aGlzIHNob3VsZCBiZSBmaXhlZCBpbiB2MyBieSB0aGUNCmNvbnZlcnNpb24gdG8g
dXNlIGdyYWJfY2FjaGVfcGFnZSgpLCB3aGljaCBjYWxscyBmaW5kX29yX2NyZWF0ZV9wYWdlKCkN
CmFuZCBzaG91bGQgdGhlcmVmb3JlIGRvIHRoZSByaWdodCB0aGluZyB3aXRoIHRoZSBGR1BfQUND
RVNTRUQgZmxhZy4NCg0KSSBiZWxpZXZlIHRoZSByZWFzb24gd2h5IHlvdXIgcGF0Y2ggYWJvdmUg
ZmFpbHMgdG8gZnVsbHkgY29ycmVjdCB0aGUNCmlzc3VlIGlzIGJlY2F1c2Ugd2UgYWx3YXlzIHdh
bnQgdG8gbWFyayB0aGUgcGFnZSBhcyBhY2Nlc3NlZCBpZiB3ZSd2ZQ0Kc2Nhbm5lZCBpdC4NCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
