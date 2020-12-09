Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C442D4802
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbgLIRdg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:33:36 -0500
Received: from mail-mw2nam12on2104.outbound.protection.outlook.com ([40.107.244.104]:61217
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732153AbgLIRdf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 12:33:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R70I0DVFswZmfmCnB8XIl84fHIFObzx/dAmyKTeSAZcTX2xb91LyFsD95LGRfTNWWNunUej/nVtJjF9q7fCdN/i3jdMbDov4EZlExTWZ3uqeZCP4eSL1yPqizYkVyvwFq46DNqRIsWZVKeFBQ0hQg7B+emDoy/wM4lj2TL651StCviH/0hx6LW5wvvRTwFjEdLKclONwIWUX7ht0GiKYVoRj0qRIAbVy1BBQXiCp6lygkKvscKY2Wf3Mnyqf0bIs/vuKRdlSVeEWtAtFhf6/myVjCnPOMdzNfURTnJoN6bNUJ/nuRK8zHpe3AZMX7bWMoUVkPwJDbI65Qe+8Js7QpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZrhJcsyx5iT1ZA3PGGBxDXlggC2DgmcRmFaQ1BdpRE=;
 b=AmOzqlSaaNETHUek/L0Gd+8Uo6Y7x4zx1PKdhyPE5iIFXmLcAjcmPgyglbbrjmyBXttK4e1vD7HgE5VFruLfNi1RZiDkjej1yUQl6jINzimDlIj2fOR1vYFI5Xuen01K2cua/UjLW0ZPD4CvmqtM+QPCBhjrQNUt0uUbwb8HcaOqLStqUMnr4AQSAA+GiZP7w3BlM/gGWZyiozkUDI/EUgYLxXxtBv3Affanemzx96dc6d3YuS2rFoCkCuVIQ+1lSW65B/DdbifFDIMRPfhSMVOG9XVYi55lFpdUrd/E3TShg6NeHj3ThXLsMPGUfVQ2VO08FY7BiogOQpOsKzsgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZrhJcsyx5iT1ZA3PGGBxDXlggC2DgmcRmFaQ1BdpRE=;
 b=gQghNO61ZfKj/oJdl0AlvVBjcZdrqsva2FQyQK+xj1W5eYeoLLwyY3k2LBqwsIx6LyuEyuHyb9TJCxFfEo8QmACtLwcT3dOgOjynSNEnPCqxdgmbDgDrb2ASE2AHWajn9EVVhtSJZaS5d7IJzJMThZkqJl2veG+IrtjnASLmhd0=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2830.namprd13.prod.outlook.com (2603:10b6:208:f5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 17:32:39 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3654.009; Wed, 9 Dec 2020
 17:32:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
Thread-Topic: [PATCH 0/3] NFS: Disable READ_PLUS by default
Thread-Index: AQHWybGmaIjlThqGT0GKib773fRGxannFjQAgABGpgCAB6kDAIAAAlcAgAABagCAAALRgIAAAsEA
Date:   Wed, 9 Dec 2020 17:32:39 +0000
Message-ID: <b61c9e480cd2cc516d64d1f3e0376a748dbb3be9.camel@hammerspace.com>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
         <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de>
         <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
         <14eac8ec352c76206c811f75b130957bb75ff590.camel@hammerspace.com>
         <CAN-5tyFwgWTBsCOBJ=7ELS4md4SBgiMQ4EPAS7LCxzCK74X13g@mail.gmail.com>
         <a70034b9506c650aa10480727f9f5e00cc71e25a.camel@hammerspace.com>
         <CAN-5tyFUmQQeQQjHtmetvTN2rcJpf3KwPbhm+6TB_N33auirag@mail.gmail.com>
In-Reply-To: <CAN-5tyFUmQQeQQjHtmetvTN2rcJpf3KwPbhm+6TB_N33auirag@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bc41538-3322-4365-79fd-08d89c686d44
x-ms-traffictypediagnostic: MN2PR13MB2830:
x-microsoft-antispam-prvs: <MN2PR13MB283062734CA94334C4BCBA1BB8CC0@MN2PR13MB2830.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3kSXQZNXgWhWIjp4Qao1QNRbAS/np3lTZ8pf85YwzI4F9MucOB+uo57XowhqvjuG/WATqGuMBQQtlwuvNvRMJ6B3bD+2PkjCPHMy5HneSB6IoWqu1p5HX/a/pwu+sJVoa2dfES8dYHh8bX0GoKAuVJ8yoL8zhXAqq0QqcRq1XrluCp0EUzVR7FAil0mGedWhALbKoMjVPta8ZbFmDw6ZlubERO32c9ZNwLdCmwaUjKSJyb18lOZFmVVf94C5qRm8tHaxIv4nrCF/RUJFG26iuGLHqSHgA4lb+EdWYj4pc6ICebmCoXAVaMGk5+AQAQeeiZCdk1Jm+meK3cQKGxQSPT7tgL5IwO4t8y8PsUbwNtygpUmNIQGljVsB8MH/GUymlwKW9RS2hHeOXb46AVTgpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(76116006)(53546011)(6486002)(8936002)(83380400001)(66446008)(2906002)(2616005)(91956017)(966005)(8676002)(86362001)(71200400001)(66946007)(5660300002)(6506007)(54906003)(6512007)(508600001)(66476007)(186003)(64756008)(36756003)(6916009)(4326008)(26005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZlRGd3k5bjF2YnVXUk9oMUFNTUFFOElDYUwyZzhVYk5aV1RGdVlpUEtVUVRp?=
 =?utf-8?B?anFKQWt0L3hRQjVmRFVJK0RNamRwdVVraktPWmhCVTV5THQ2Q1N5bnVxZzl4?=
 =?utf-8?B?bkFLZ29wYnhQcmZTVm9qM3N3K1ZwdnFlYlhHS1NvSmdzTStlVmFJUWMzZ2V1?=
 =?utf-8?B?R1BSMUttRWdwajA5ZFliekJOdy9xMzJ1anNEOHo1WVBiQm9heGEwZU1rZUQ3?=
 =?utf-8?B?cDIwMmd5czl4UFJCa0c2djhITkZCQ2R4NXJ1WXU2MHhRZHVPdmJrc1c1ZTVF?=
 =?utf-8?B?ekd6K1BFQlVhNlgrekErN2luWUl5SllCenpFWWJpVHJQMno1Q2tVcmd0a0NH?=
 =?utf-8?B?ZDk3Q3p5cSthUWN4RTRpZkgvbmRGZWhPRDdFeng0dTJlUDlUdzBkSy9JVkNQ?=
 =?utf-8?B?T1kxdmtrUnFXMTVMdndQK3NHdkVZK2FCUWJRYkVvaGNWeDRFU01GZ0VDQWtv?=
 =?utf-8?B?NVc2TW9DenlVQmVwUmJUMkZ6bkhVcUYyTXU2aGljck1QMy9lVHcwTzY2MHVE?=
 =?utf-8?B?M3RrV04zbWl0aWp2SGtUb1Q3L0pBcEROMFZ4T2d2TU12eDJSTHlIRmZNZm1k?=
 =?utf-8?B?MVlTekVEbmRNa2pqUVhkTHRIM05XWW1nOE9WWUZsMElWNW9BYTg1WEVPdDI4?=
 =?utf-8?B?cWg2QjJlOXBuOTFnUEN2SU9oYTlMUmlGNndZSFd3OUVhaElwdmw4K1RZS3JM?=
 =?utf-8?B?V3RnU0pRSmxCWlJxNFJFUUt4TVBhZklsYUt4dUMybWxZY25oRFlteGR4dGVn?=
 =?utf-8?B?ZUVrUUY0NWdQZWxJZlUxVlBTNXBPUnM0RVUwbElaVGdOWUpZV0FQdTV0YWdK?=
 =?utf-8?B?M1VEbUVrcEJmaytTVUx0QUtVb1dIeDlTRWV1bHYvQkRyNk1XU1Z2THR3VFBJ?=
 =?utf-8?B?YjdpZUhuNTNNanN0VndscnFMejY3VjVuaUpCdDlQczkvTlE3NGNjUysyWEtO?=
 =?utf-8?B?VC9aaTVzZWEyZTErLzlYOTBKN3NiMUhCSW80Z3IxZDYrUDJEVEtPbjQ0NDU5?=
 =?utf-8?B?b05IblRQaWxuYkxJNGF4cEt3bDdnY0RNdjliYm0zTnZDMXpZdWI3V3IvcGVS?=
 =?utf-8?B?ZkoxYkd4czFRUEpWWWN4c3ZhaDZwK0xrR0x5TWVwem5ScTFvQ0RBNXl6WkIr?=
 =?utf-8?B?VTJaU0N6VW1TV203c3UxNjEySi9Rd3MyV1pJZmQxMS9YUmM5RmNEaVVKNUJB?=
 =?utf-8?B?R3ZORFAvRlowM0ZtV01BVjZjS1FuTHhINTBqWVpwcFVxYlFpMlBFNFl0QXYy?=
 =?utf-8?B?dnJsVytLV1UyQzd1d3R0ZGdCR3lRL1RHOFczZlMyQVp3OVVnS001SjV2UGlq?=
 =?utf-8?Q?/RFWkJJMqd9D8i76cPY4X2XqGLVdrCkXFH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACCC259AB49BB946A11374B0650F15C6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc41538-3322-4365-79fd-08d89c686d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 17:32:39.5337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJDs3WZNYTLWTHxiWnXsgxk1x1m6M9nCrVdskl/xJTqD7R1wLmpFtguPFJzVP0rkNIfZGhSTEyM2n7flayTzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2830
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTA5IGF0IDEyOjIyIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gV2VkLCBEZWMgOSwgMjAyMCBhdCAxMjoxMiBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAyMDIw
LTEyLTA5IGF0IDEyOjA3IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IE9u
IFdlZCwgRGVjIDksIDIwMjAgYXQgMTE6NTkgQU0gVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gRnJpLCAy
MDIwLTEyLTA0IGF0IDE1OjAwIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+
ID4gPiBJIG9iamVjdCB0byBwdXR0aW5nIHRoZSBkaXNhYmxlIHBhdGNoIGluLCBJIHRoaW5rIHdl
IG5lZWQgdG8NCj4gPiA+ID4gPiBmaXgNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBwcm9ibGVt
Lg0KPiA+ID4gPiANCj4gPiA+ID4gSSBjYW4ndCBzZWUgdGhlIHByb2JsZW0gaXMgZml4YWJsZSBp
biA1LjEwLiBUaGVyZSBhcmUgd2F5IHRvbw0KPiA+ID4gPiBtYW55DQo+ID4gPiA+IGNoYW5nZXMg
cmVxdWlyZWQsIGFuZCB3ZSdyZSBpbiB0aGUgbWlkZGxlIG9mIHRoZSB3ZWVrIG9mIHRoZQ0KPiA+
ID4gPiBsYXN0IC0NCj4gPiA+ID4gcmMNCj4gPiA+ID4gZm9yIDUuMTAuIEZ1cnRoZXJtb3JlLCB0
aGVyZSBhcmUgbm8gcmVncmVzc2lvbnMgaW50cm9kdWNlZCBieQ0KPiA+ID4gPiBqdXN0DQo+ID4g
PiA+IGRpc2FibGluZyB0aGUgZnVuY3Rpb25hbGl0eSwgYmVjYXVzZSBSRUFEX1BMVVMgaGFzIG9u
bHkganVzdA0KPiA+ID4gPiBiZWVuDQo+ID4gPiA+IG1lcmdlZCBpbiB0aGlzIHJlbGVhc2UgY3lj
bGUuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHRoZXJlZm9yZSBzdHJvbmdseSBzdWdnZXN0IHdlIGp1
c3Qgc2VuZCBbUEFUQ0ggMS8zXSBORlM6DQo+ID4gPiA+IERpc2FibGUNCj4gPiA+ID4gUkVBRF9Q
TFVTIGJ5IGRlZmF1bHQgYW5kIHRoZW4gZml4IHRoZSByZXN0IGluIDUuMTEuDQo+ID4gPiANCj4g
PiA+IFN1cmUsIGJ1dCBzaG91bGRuJ3QgdGhlcmUgYmUgbW9yZSBpZmRlZnMgaW5zaWRlIG9mIHRo
ZSB4ZHIgY29kZQ0KPiA+ID4gdG8NCj4gPiA+IHR1cm4gaXQgb2ZmIGNvbXBsZXRlbHk/DQo+ID4g
DQo+ID4gQUZBSUNULCB0aG9zZSBmdW5jdGlvbnMgYXJlIG5vdCBjYWxsZWQgYnkgYW55dGhpbmcg
ZWxzZSwgc28gYXMgbG9uZw0KPiA+IGFzDQo+ID4gdGhlIFJFQURfUExVUyBjbGllbnQgZnVuY3Rp
b25hbGl0eSBpcyBkaXNhYmxlZCwgdGhleSBzaG91bGQgYmUNCj4gPiBoYXJtbGVzcy4NCj4gDQo+
IElzIGl0IGJlbmlnbiB0aGF0IGluIHRoZSBub3JtYWwgcmVhZCBwYXRoIHN1bnJwYyB3aWxsIGJl
IGNhbGxpbmcgYQ0KPiBuZXcNCj4gZnVuY3Rpb24gb2YgeGRyX3JlYWxpZ25fcGFnZXMoKT8gTm9u
IHJlYWRwbHVzIGNvZGUgZGlkbid0IGhhdmUgaXQuDQo+ID4gDQoNCkxvb2tpbmcgYXQgY29tbWl0
IDA2MjE2ZWNiZDkzNjggKA0KaHR0cHM6Ly9naXQubGludXgtbmZzLm9yZy8/cD10cm9uZG15L2xp
bnV4LW5mcy5naXQ7YT1jb21taXRkaWZmO2g9MDYyMTZlY2JkOTM2OA0KKSBpdCBpcyBub3QgYWN0
dWFsbHkgY2hhbmdpbmcgdGhlIExpbnV4LTUuOSBjb2RlLCBidXQgaXMganVzdA0KcGVyZm9ybWlu
ZyBhIHRyaXZpYWwgcmVmYWN0b3Jpbmcgb2YgdGhhdCBjb2RlIGludG8gYSBuZXcgZnVuY3Rpb24u
IEknbQ0KT0sgd2l0aCB0aGF0Lg0KDQpUaGUgcmVzdCBvZiB0aGUgUkVBRCBjb2RlIGxvb2tzIHVu
Y2hhbmdlZCB0byBtZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
