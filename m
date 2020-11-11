Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0EF2AF76A
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 18:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgKKRe2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Nov 2020 12:34:28 -0500
Received: from mail-bn7nam10on2099.outbound.protection.outlook.com ([40.107.92.99]:31712
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbgKKRe0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 11 Nov 2020 12:34:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCPbkWMNUdcKD44QB0BoX5gML3lP8j4A0BRYelDfuQqjFji4t+CkfuAuIgBDEe687FTjmX8yMEPwmZ4RvyUau3bhjSp0De1eA/B6lCBuJMYOzB7tmZXamlc2RWP8N4Url6Z+a14FPuiRNaHwQxFAVCmKl+GlQbhkdXYeKIR3adLkp/6VhEoQFx7bqa3Q5enpCECGxTYpBeGaCapj6tyqKWm946DNchXipOfa/88eibEI8mA8sPUvjH0b1mU8a+xkwbyzAB1GCNOiyfgD5wYjQPmTgyW2AdChk8HPxWhSYWokg9lVaD4qk5oSew0JBe8wDmo1GR04tQ5D7zBK+wPNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1NdArtnPf0tMhewixWXO9tqWJr75RTyLk8vHB3NkWI=;
 b=aMPIfrufc0SGPO6elEeHaumv1oHC4uzbxaBpOvJv+8GWI4vUImSinPHY0IbngxkqbygPzyKaGRrnFtLPl5gnPUFP6n1vQVfUn6e+MujOxi9pu4i5kw1+HyjgSNgZAoaZ+u1HrV6Lz0joW37Md0YTHKjlIIU1DtYUObtpg5NnH9qye/SLbKHpevdoECPzNLnAZDEMwnsxxB/Te7MD7mvpy1LlY6Q7a11IPDhiuZ7dwY3JQdDrbKzmUT5/Pg0EZvnM4g6eZMzl6lVtEIm1e5NZA/Y5Uj9A/lQCJ49liM4A7Ijr82MzH5dRAKCPRMq8gBNVx166V9ofBGT37HSF/Zr0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1NdArtnPf0tMhewixWXO9tqWJr75RTyLk8vHB3NkWI=;
 b=KE18IEGdyAtVsfDoqYfsFUQXx0pbmKsyON7SLzjT1Y/xHziK6Ws/Wpgy4/qFeBnZWFY/1Z+N/5CAoOBh/EXcmqWIlBRzsbZdRCJem46TiAKsaZDqJDPaHLJjYoG40Ok86zs8f3Bax/qu6SDn1cwI2zE/DyFvrsrc7ySJ1jBJbJo=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3870.namprd13.prod.outlook.com (2603:10b6:208:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.14; Wed, 11 Nov
 2020 17:34:22 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Wed, 11 Nov 2020
 17:34:22 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
Thread-Topic: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
Thread-Index: AQHWtRA6iwOeaceJLkybCI7SueOQ/6nAV/UAgAABg4CAAs/9gIAADjAA
Date:   Wed, 11 Nov 2020 17:34:22 +0000
Message-ID: <4e92cc94e4b10b42aee30e198c6474c72564cbaa.camel@hammerspace.com>
References: <20201107140325.281678-1-trondmy@kernel.org>
         <20201107140325.281678-2-trondmy@kernel.org>
         <20201107140325.281678-3-trondmy@kernel.org>
         <20201107140325.281678-4-trondmy@kernel.org>
         <20201107140325.281678-5-trondmy@kernel.org>
         <20201107140325.281678-6-trondmy@kernel.org>
         <20201107140325.281678-7-trondmy@kernel.org>
         <20201107140325.281678-8-trondmy@kernel.org>
         <20201107140325.281678-9-trondmy@kernel.org>
         <20201107140325.281678-10-trondmy@kernel.org>
         <20201107140325.281678-11-trondmy@kernel.org>
         <20201107140325.281678-12-trondmy@kernel.org>
         <20201107140325.281678-13-trondmy@kernel.org>
         <20201107140325.281678-14-trondmy@kernel.org>
         <20201107140325.281678-15-trondmy@kernel.org>
         <20201107140325.281678-16-trondmy@kernel.org>
         <20201107140325.281678-17-trondmy@kernel.org>
         <20201107140325.281678-18-trondmy@kernel.org>
         <20201107140325.281678-19-trondmy@kernel.org>
         <20201107140325.281678-20-trondmy@kernel.org>
         <20201107140325.281678-21-trondmy@kernel.org>
         <20201107140325.281678-22-trondmy@kernel.org>
         <86F25343-0860-44A2-BA40-CFB640147D50@redhat.com>
         <d31c1ca31e734d7566f3da6d1c1d651abc4101f7.camel@hammerspace.com>
         <6D043238-4C98-41B9-A890-B0897E7EFDBA@redhat.com>
In-Reply-To: <6D043238-4C98-41B9-A890-B0897E7EFDBA@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 125d2ac7-02a6-4302-c2d1-08d8866806ee
x-ms-traffictypediagnostic: MN2PR13MB3870:
x-microsoft-antispam-prvs: <MN2PR13MB3870248392C621FA9F7083FAB8E80@MN2PR13MB3870.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7eJkYcLglL598mLfmgcmpjmQ3eVwqK/Al1P7zhbHNTuIhrl+NfJbpKbW6NiBS9WgtsKWLEGGE04f0bmt/MdsReaaGJRm7mOg95ckdebuS6Tm/Av2zbVzVgwFFuxyb+3Pqjwr9Gqb+EqTzUSp/HVMxfrDRz1vv+8TgH3Qh0NuVJ3NB0QJ7qFhs1GNBIn0q9mSiMHwKXcYdckIpVqWDCr/cfweqiS1BrAIIhWEeZnWnlrIERBZVm/TvlyPl7urfvgXVbMYo4FESKcYYRNc847l/9rgsVh3KCxjj/ExWKJvXAC2kLWz1pdYMzWiRhHmu/Demfo51G5kfUN8bLNCt7V4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39840400004)(6512007)(478600001)(4326008)(2906002)(66556008)(66476007)(66946007)(64756008)(76116006)(66446008)(91956017)(8936002)(4001150100001)(83380400001)(36756003)(5660300002)(316002)(2616005)(6486002)(6916009)(6506007)(71200400001)(26005)(186003)(8676002)(86362001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1iZPZYSLG4KEr+/F/cjs/uik3B6riG/Bg3SI8w3EdZbqTYgpn6mXbm9jjmHos0VBOz7J1VdCp9n+cPdtWAq7YSDJBAQ43xM/YWmptiCPg7trqHoA9I//BkTWSJW7cEARNLT5HQ/vFHcDooD1PSQY5zNsCpuRsjyq5ODPf4L9DdaF4Es4ORQQB41McF/d+oGB41ZZOx3OyhVSe0FYfI4lEk8lkK5s5YdZml+Zi+HMnkGMPjVvwNJzOejTwjrKSF3rJprkLHaG1YAyvTxQMqsFqpYbPDAJxNCxqK5pl+ct7fp40oJGqkQFNWT8Jl0+a86kjLbCLvA1nHRbM1enGGAzfUptsNy1Vkv1ysD5fUAXSq/eFSdAURW/IqA5NovfJ5100JTWbIber7h9Z444OSR7A5czXGigiAU8zxpOkIskju2Api5hkdCW0zlXBrO+rfhyDHyNkdPyP51Kot4imwRpvrT8c9yr5ZDntKf9iinqj21ZDhkTejF1st63dQaIFv77e71I0uTDVuSom8DPdOI1nNZh+vaqJvuePRc1/LG0ZGqkVK4ILE+6laH1qt5WmdNxfl4qbzw8W9wApnUFhXEJGPHjDRNFFVNS/rfX16IIDKCCPIwX8iMGGPWje1vkkSz3oeN9WzVW21w1VouLU/ajNg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F10A6C64836ED04DAC20E395B0F2657F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125d2ac7-02a6-4302-c2d1-08d8866806ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 17:34:22.2771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/sJKuuaOV3XNMwViwUFAgP4tjKykKANcPTeY5Xf4J75IsZHFHfllbBmeJrEn0gymjJjK2Fjl5v0t75jo6aSeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3870
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTExIGF0IDExOjQzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA5IE5vdiAyMDIwLCBhdCAxNjo0NiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiANCj4gPiBPbiBNb24sIDIwMjAtMTEtMDkgYXQgMTY6NDEgLTA1MDAsIEJlbmphbWluIENvZGRp
bmd0b24gd3JvdGU6DQo+ID4gPiBPbiA3IE5vdiAyMDIwLCBhdCA5OjAzLCB0cm9uZG15QGtlcm5l
bC5vcmfCoHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IElmIHRoZSBk
aXJlY3RvcnkgaXMgY2hhbmdpbmcsIGNhdXNpbmcgdGhlIHBhZ2UgY2FjaGUgdG8gZ2V0DQo+ID4g
PiA+IGludmFsaWRhdGVkDQo+ID4gPiA+IHdoaWxlIHdlIGFyZSBsaXN0aW5nIHRoZSBjb250ZW50
cywgdGhlbiB0aGUgTkZTIGNsaWVudCBpcw0KPiA+ID4gPiBjdXJyZW50bHkNCj4gPiA+ID4gZm9y
Y2VkDQo+ID4gPiA+IHRvIHJlYWQgaW4gdGhlIGVudGlyZSBkaXJlY3RvcnkgY29udGVudHMgZnJv
bSBzY3JhdGNoLCBiZWNhdXNlDQo+ID4gPiA+IGl0DQo+ID4gPiA+IG5lZWRzDQo+ID4gPiA+IHRv
IHBlcmZvcm0gYSBsaW5lYXIgc2VhcmNoIGZvciB0aGUgcmVhZGRpciBjb29raWUuIFdoaWxlIHRo
aXMNCj4gPiA+ID4gaXMNCj4gPiA+ID4gbm90DQo+ID4gPiA+IGFuIGlzc3VlIGZvciBzbWFsbCBk
aXJlY3RvcmllcywgaXQgZG9lcyBub3Qgc2NhbGUgdG8NCj4gPiA+ID4gZGlyZWN0b3JpZXMNCj4g
PiA+ID4gd2l0aA0KPiA+ID4gPiBtaWxsaW9ucyBvZiBlbnRyaWVzLg0KPiA+ID4gPiBJbiBvcmRl
ciB0byBiZSBhYmxlIHRvIGRlYWwgd2l0aCBsYXJnZSBkaXJlY3RvcmllcyB0aGF0IGFyZQ0KPiA+
ID4gPiBjaGFuZ2luZywNCj4gPiA+ID4gYWRkIGEgaGV1cmlzdGljIHRvIGVuc3VyZSB0aGF0IGlm
IHRoZSBwYWdlIGNhY2hlIGlzIGVtcHR5LCBhbmQNCj4gPiA+ID4gd2UNCj4gPiA+ID4gYXJlDQo+
ID4gPiA+IHNlYXJjaGluZyBmb3IgYSBjb29raWUgdGhhdCBpcyBub3QgdGhlIHplcm8gY29va2ll
LCB3ZSBqdXN0DQo+ID4gPiA+IGRlZmF1bHQNCj4gPiA+ID4gdG8NCj4gPiA+ID4gcGVyZm9ybWlu
ZyB1bmNhY2hlZCByZWFkZGlyLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJv
bmQgTXlrbGVidXN0DQo+ID4gPiA+IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0K
PiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBmcy9uZnMvZGlyLmMgfCAxNyArKysrKysrKysrKysrKysr
Kw0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rpci5jIGIvZnMvbmZzL2Rpci5jDQo+ID4gPiA+
IGluZGV4IDIzODg3MmQxMTZmNy4uZDdhOWVmZDMxZWNkIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9m
cy9uZnMvZGlyLmMNCj4gPiA+ID4gKysrIGIvZnMvbmZzL2Rpci5jDQo+ID4gPiA+IEBAIC05MTcs
MTEgKzkxNywyOCBAQCBzdGF0aWMgaW50DQo+ID4gPiA+IGZpbmRfYW5kX2xvY2tfY2FjaGVfcGFn
ZShzdHJ1Y3QNCj4gPiA+ID4gbmZzX3JlYWRkaXJfZGVzY3JpcHRvciAqZGVzYykNCj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXM7DQo+ID4gPiA+IMKgfQ0KPiA+ID4gPiANCj4gPiA+
ID4gK3N0YXRpYyBib29sIG5mc19yZWFkZGlyX2RvbnRfc2VhcmNoX2NhY2hlKHN0cnVjdA0KPiA+
ID4gPiBuZnNfcmVhZGRpcl9kZXNjcmlwdG9yICpkZXNjKQ0KPiA+ID4gPiArew0KPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IGRlc2MtPmZpbGUt
PmZfbWFwcGluZzsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGlub2RlICpkaXIgPSBm
aWxlX2lub2RlKGRlc2MtPmZpbGUpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBp
bnQgZHRzaXplID0gTkZTX1NFUlZFUihkaXIpLT5kdHNpemU7DQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoGxvZmZfdCBzaXplID0gaV9zaXplX3JlYWQoZGlyKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqAvKg0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgKiBEZWZhdWx0IHRvIHVu
Y2FjaGVkIHJlYWRkaXIgaWYgdGhlIHBhZ2UgY2FjaGUgaXMNCj4gPiA+ID4gZW1wdHksDQo+ID4g
PiA+IGFuZA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgKiB3ZSdyZSBsb29raW5nIGZvciBhIG5v
bi16ZXJvIGNvb2tpZSBpbiBhIGxhcmdlDQo+ID4gPiA+IGRpcmVjdG9yeS4NCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgICovDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBkZXNjLT5kaXJf
Y29va2llICE9IDAgJiYgbWFwcGluZy0+bnJwYWdlcyA9PSAwDQo+ID4gPiA+ICYmDQo+ID4gPiA+
IHNpemUgPg0KPiA+ID4gPiBkdHNpemU7DQo+ID4gPiANCj4gPiA+IGlub2RlIHNpemUgPiBkdHNp
emUgaXMgYSBsaXR0bGUgaGFuZC13YXZ5LsKgIFdlIGhhdmUgYSBsb3Qgb2YNCj4gPiA+IGN1c3Rv
bWVycw0KPiA+ID4gdHJ5aW5nIHRvDQo+ID4gPiByZXZlcnNlLWVuZ2luZWVyIG5mc19yZWFkZGly
KCkgYmVoYXZpb3IgaW5zdGVhZCBvZiByZWFkaW5nIHRoZQ0KPiA+ID4gY29kZSwNCj4gPiA+IHRo
aXMNCj4gPiA+IGlzIHN1cmUgdG8gZHJpdmUgdGhlbSBjcmF6eS4NCj4gPiA+IA0KPiA+ID4gVGhh
dCBzYWlkLCBpbiB0aGUgYWJzZW5jZSBvZiBhbiBlYXN5IHdheSB0byBtYWtlIGl0IHR1bmFibGUs
IEkNCj4gPiA+IGRvbid0DQo+ID4gPiBoYXZlDQo+ID4gPiBhbnl0aGluZyBiZXR0ZXIgdG8gc3Vn
Z2VzdC4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IEJlbmphbWluIENvZGRpbmd0b24gPGJj
b2RkaW5nQHJlZGhhdC5jb20+DQo+ID4gDQo+ID4gDQo+ID4gUmlnaHQuIEl0IGlzIGEgaGV1cmlz
dGljLCBidXQgSSB3b3VsZCBleHBlY3QgdGhhdCB0aGUgZGlyZWN0b3J5DQo+ID4gc2l6ZSBpcw0K
PiA+IGdvaW5nIHRvIGJlIHNvbWV3aGF0IHByb3BvcnRpb25hbCB0byB0aGUgbnVtYmVyIG9mIFJQ
QyBjYWxscyB3ZQ0KPiA+IG5lZWQgdG8NCj4gPiBwZXJmb3JtIHRvIHJlYWQgaXQuIFRoYXQgbnVt
YmVyIGFnYWluIGlzIHNvbWV3aGF0IHByb3BvcnRpb25hbCB0bw0KPiA+IHRoZQ0KPiA+IGR0c2l6
ZS4NCj4gPiANCj4gPiBJT1c6IFRoZSBnZW5lcmFsIGlkZWEgaXMgY29ycmVjdC4NCj4gDQo+IEkg
Y2FuIGFncmVlIHdpdGggdGhhdCwgYnV0IEkgaGF2ZSBhbm90aGVyIHRob3VnaHQ6DQo+IA0KPiBJ
ZiB0aGUgcG9pbnQgb2YgdGhlIGhldXJpc3RpYyBpcyB0byBhbGxvdyBhIGZ1bGwgbGlzdGluZyB0
bw0KPiBldmVudHVhbGx5DQo+IGNvbXBsZXRlLCBpdCBzaG91bGQgbm90IGJlIGRlcGVuZGVudCBv
biBtYXBwaW5nLT5ucnBhZ2VzID09IDAuwqANCj4gT3RoZXJ3aXNlLA0KPiBvdGhlciBwcm9jZXNz
ZXMgY2FuIHN0YXJ0IGZpbGxpbmcgdGhlIGNhY2hlIGFuZCB3ZSdyZSBiYWNrIHRvIHRoZQ0KPiBz
aXR1YXRpb24NCj4gd2hlcmUgZmlsbGluZyB0aGUgY2FjaGUgY291bGQgdGFrZSBsb25nZXIgdGhh
biBhY2Rpcm1heCwgYW5kIHRoaW5ncw0KPiBldmVudHVhbGx5IGNvbmdlc3QgdG8gYSBoYWx0Lg0K
PiANCj4gRmxpcHBpbmcgYSBiaXQgb24gdGhlIGNvbnRleHQgdG8gcmVtYWluIHVuY2FjaGVkIGdp
dmVzIGEgYmV0dGVyDQo+IGFzc3VyYW5jZSB3ZQ0KPiBjYW4gY29udGludWUgdG8gbWFrZSBmb3J3
YXJkIHByb2dyZXNzLg0KDQpJIGRpc2FncmVlLiBUaGUgcG9pbnQgb2YgdGhlIHBhZ2UgY2FjaGUg
aXMgdG8gYWxsb3cgc2hhcmluZyBvZg0KaW5mb3JtYXRpb24gYmV0d2VlbiBwcm9jZXNzZXMgd2hl
cmUgcG9zc2libGUuIElmIHRoZXJlIGFyZSBtdWx0aXBsZQ0KcHJvY2Vzc2VzIGFsbCB0cnlpbmcg
dG8gbWFrZSBwcm9ncmVzcywgYW5kIG9uZSBvZiB0aGVtIHN0YXJ0cyBmaWxsaW5nDQp0aGUgcGFn
ZSBjYWNoZSBmcm9tIHNjcmF0Y2gsIHRoZW4gd2h5IHNob3VsZCB3ZSBub3QgdXNlIHRoYXQ/DQoN
ClRoZSBhbHRlcm5hdGl2ZSBpcyBub3Qgc2NhbGluZyB0byBtdWx0aXBsZSBwcm9jZXNzZXMuDQoN
Cj4gDQo+IEl0J3MgdG9vIGJhZCB3ZSdyZSBzdHVjayBjYWNoaW5nIGVudHJpZXMgbGluZWFybHku
wqAgV2hhdCBjaGFsbGVuZ2VzDQo+IG1pZ2h0DQo+IGV4aXN0IGlmIHdlIHRyaWVkIHRvIHVzZSBh
biBYQXJyYXkgdG8gbWFwIGRpcmVjdG9yeSBwb3NpdGlvbiB0bw0KPiBjb29raWU/wqAgSQ0KPiBp
bWFnaW5lIHdlIGNvdWxkIGltcGxlbWVudCB0aGlzIGluIGEgc2luZ2xlIFhBcnJheSBieSB1c2lu
ZyBib3RoDQo+IHBvc2l0aW9uDQo+IGFuZCBjb29raWUgdmFsdWVzIGFzIGluZGljZXMsIGFuZCBk
aWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlbSB1c2luZw0KPiB0d28gb2YNCj4gdGhlIHRocmVlIFhB
IG1hcmtzLCBhbmQgc3RvcmUgYSBzdHJ1Y3R1cmUgdG8gcmVwcmVzZW50IGJvdGguwqAgQWxzbw0K
PiB1bmNsZWFyDQo+IHdvdWxkIGJlIGhvdyB0byBoYW5kbGUgdGhlIGxpZmV0aW1lIG9mIHRoZSBY
QXJyYXksIHNpbmNlIHdlJ2Qgbm8NCj4gbG9uZ2VyIGJlDQo+IHVzaW5nIHRoZSBWTXMgcGFnZWNh
Y2hlIG1hbmFnZW1lbnQuLg0KPiANCg0KWW91IG1pZ2h0IGJlIGFibGUgdG8gc3BlZWQgdXAgZmly
c3QgY29va2llIGxvb2t1cCBieSBoYXZpbmcgYW4gWGFycmF5DQp0aGF0IG1hcHMgZnJvbSBhIDY0
LWJpdCBjb29raWUgdG8gYSBuZnNfY2FjaGVfYXJyYXlfZW50cnkgd2hpY2gNCmNvbnRhaW5zIHRo
ZSBuZXh0IGNvb2tpZSB0byBsb29rIHVwLiBIb3dldmVyIHRoYXQgd291bGQgb25seSB3b3JrIG9u
DQo2NC1iaXQgc3lzdGVtcyBzaW5jZSB4YXJyYXlzIHRha2UgYW4gdW5zaWduZWQgbG9uZyBpbmRl
eC4NCg0KRnVydGhlcm1vcmUsIHlvdSBzdGlsbCBuZWVkIGEgd2F5IHRvIG1hcCBvZmZzZXRzIHRv
IGVudHJpZXMgZm9yIHRoZQ0KY2FzZSB3aGVyZSB3ZSdyZSBub3QgYWJsZSB0byB1c2UgY29va2ll
cyBmb3IgbHNlZWsoKSBwdXJwb3Nlcy4gVGhhdCdzIGENCmxpbmVhciBzZWFyY2ggdGhyb3VnaCB0
aGUgZGlyZWN0b3J5LCB3aGljaCB3b3VsZCBiZSBob3JyaWJsZSB3aXRoIGFuDQp4YXJyYXkgb2Yg
bGlua2VkIGNvb2tpZSB2YWx1ZXMgKHNvIHlvdSdkIHByb2JhYmx5IG5lZWQgYSBzZWNvbmQgeGFy
cmF5DQpmb3IgdGhhdD8pLg0KDQpDb25zdHJ1Y3Rpb24gYW5kIHRlYXJkb3duIG9mIHRoYXQgc3Ry
dWN0dXJlIHdvdWxkIGJlIG5hc3R5IGZvciBsYXJnZQ0KZGlyZWN0b3JpZXMsIHNpbmNlIHlvdSBo
YXZlIGFzIG1hbnkgY29va2llcyBhcyB5b3UgaGF2ZSBlbnRyaWVzIGluIHlvdXINCmRpcmVjdG9y
eS4gSU9XOiBZb3UnZCBoYXZlIHRvIHRlYXIgZG93biAxMjcgdGltZXMgYXMgbWFueSB4YXJyYXkN
CmVudHJpZXMgYXMgd2UgaGF2ZSBub3cuDQoNCkl0IGlzIG5vdCBvYnZpb3VzIHRoYXQgd2Ugd291
bGQgYmUgYWJsZSB0byBiZW5lZml0IGZyb20gc3RhcnRpbmcgYXQgYW4NCmFyYml0cmFyeSBsb2Nh
dGlvbiBhbmQgY2FjaGluZyB0aGF0IGRhdGEsIHNpbmNlIGlmIHRoZSBkaXJlY3RvcnkNCmNoYW5n
ZWQsIHdlJ2QgaGF2ZSB0byByZWFkIGluIHRoZSBuZXcgZGF0YSBhbnl3YXkuDQoNCk1lbW9yeSBt
YW5hZ2VtZW50IHdvdWxkIG5lZWQgdG8gYmUgaW1wbGVtZW50ZWQgc29tZWhvdy4gWW91J2QgbmVl
ZCBhDQpzaHJpbmtlciBmb3IgdGhpcyB0cmVlIHRoYXQgY291bGQgaW50ZWxsaWdlbnRseSBwcnVu
ZSBpdC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
