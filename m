Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BBC2C57D9
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Nov 2020 16:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbgKZPGp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Nov 2020 10:06:45 -0500
Received: from mail-dm6nam11on2118.outbound.protection.outlook.com ([40.107.223.118]:3457
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391244AbgKZPGp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Nov 2020 10:06:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmCUGBJes+IBHtg+3wi56w9MtDeThzMKWI+CobcYZg1NhmOJUAZ98DrOOx9kh6mRD7DqLcRZ7oLvwlWegZZ//cLUqBhi+TkCEzI3u0Qe9JwVM8n6Fueh0oeAbtK2UdobH23pRT+Gk74vEnPi8OK+l1PwDowncDFZhN7mPFMSi9EG9IuXBsCjIcDZAz7MZntgPaE1oVfhTJqO1T+eO/0A78B9LRi6ZLMbB7mb2Kzp1XleUC7pYLjvKnh7NjXk4V18WUHanYU/+Nqi0YLc0lpR+CABpKK4Pnu5wqMv8PE5Kn39LgpAgJS/JkjA8b/jMMbruS5FF88woexCc18xp8KbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rle0VHH55bptXoGskrvVORL+KT2KVqvnVkuV2CfRVrs=;
 b=Xl98yEFPR958Re6BEhYaxdIr9Nlc/sb9Sk/gfpfXWROa6wWL3xFKux8UvLO93JF9RFqJ9OZY/YIJAYN4DEcTHfXbY0YyhOdeqH2afxJFkjJV3/YZ8EYo2bKxSYb7NXzPIVw0KulJ/WkQCOXxwTFuiI99PrmUuORd90Nt56W0oCq22S87bTxsCcfCQ+s6jKwIReLSsdQCkW2jNjo92qMwFvpfQtnwGc+6R8bVkWjYScZqBpw7aarBgLiZOkJjifQR10h6oGEyXhmCJfaoXF9vCzLkv9Nqgz741oX1gqoBjsYcYo8saOs8TAH9FmYZqRWyh3VNTfWIdCSV0NoOPdSVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rle0VHH55bptXoGskrvVORL+KT2KVqvnVkuV2CfRVrs=;
 b=WkNstTmtYGs+Mn9po7WOdm6AOrUpjWu9CmngmAuCXd9PCRefjg4Jt7yu0c2ABoJXr1Ihnt2Lm2gY3IIdVoC7CsMPoub71hPunU4BX5ChoG1l83pXiRDIwmWUnarDIxaaKAzGjgz99Ps6PySU3F9SABRQsrmpqsLw8ob6VgMGskY=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3822.namprd13.prod.outlook.com (2603:10b6:208:19e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.9; Thu, 26 Nov
 2020 15:06:40 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3611.020; Thu, 26 Nov 2020
 15:06:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan@kernelim.com" <dan@kernelim.com>,
        "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS v3 soft mount semantics affected by commit ce368536d
Thread-Topic: NFS v3 soft mount semantics affected by commit ce368536d
Thread-Index: AQHWw+GE4ByGxrEvak+YHKx9ogrt6KnabdkAgAAV3gA=
Date:   Thu, 26 Nov 2020 15:06:40 +0000
Message-ID: <079895bc76b9542315750c6af41e829a7a15af17.camel@hammerspace.com>
References: <20201126104712.GA4023536@gmail.com>
         <dc888c162b3a30cd1c617072ae606d9d8c6d42f3.camel@hammerspace.com>
In-Reply-To: <dc888c162b3a30cd1c617072ae606d9d8c6d42f3.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f5ae561-59e8-4257-0386-08d8921ce0e0
x-ms-traffictypediagnostic: MN2PR13MB3822:
x-microsoft-antispam-prvs: <MN2PR13MB38224B92F79C93661E99340FB8F90@MN2PR13MB3822.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MeZtr0YtNHULJrWZsv8wP1iqizwoltIjHpXVX4bI6RAdHhUNoFKtTZd8r8tRRicRIIwVdFC3M3OAPfzO2AO/XGtOStUxwg+Be+wVY4g9TXGTLrbv2BtH0x6/I3+0yymnBuX0YkgQxeXdRkKfkgMqfQ8jAP5gvdgNwsGjZ0P7dUWxkB4wRb1IRxQVDb2ago06NhUIML7XKu3EFjywI+gNor+kltEsCoVFg4FQ85UWwfiPFlAqU/FpWRkEW/VektYooVGJqrQK+STrLdkoRspE4s4aUmIQ2wRYVy5Crbeuz/Z4JgAWUEBTQI5nIR0gHuKlrAQYAkZquGItzSvSOFaTTId7J/3JVk6QcHYA5K353TtPX2VZrbAQPdMJFElsa6XL7yhaxokJ0qdwaUhzl33Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39840400004)(136003)(396003)(4326008)(110136005)(4001150100001)(26005)(478600001)(2906002)(2616005)(86362001)(6486002)(966005)(186003)(316002)(5660300002)(6506007)(71200400001)(66446008)(66476007)(64756008)(66556008)(6512007)(8676002)(66946007)(76116006)(91956017)(36756003)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +UOXPltl6cM28O1o5DR5gpwe8c1IL7ZGCk1dwNSDmNTMfJqRvXCXVHHmF39w1ctYmZzpIiopKcMUXRTsup3zo6RhlT6cOgcFpCZgBtEOM/KTRrua/ICMEwwh3UnsmZzSsTRhEtqjs/xgzyocRJAg7e8YSbIwk93BQGCas8ovgkGuSKaWaeL9ueHbCfVFer15tzcBzBecDDiKuko7Uo/H984z6u/O7bZdmNQVJ58T9jBuzxhcjM83S1N+wSO+lt6f7R61gwuMAH+IZRYIEPRAy1wV7vejVrZU8w0JIrnoU60ijAXbN2Lot1I/BrCRRYQfkOhW08UeTQBHDMxnzYciJt2GU2x0RRvTd9sY2QKWO68eWDMqSZJ/IElzkMDa/cl0M7HQ1Zv7jdpk2Q7fgu+YCbfwMeG0f8WJWmuMAGRFW0sAkHh2piFV6qk7nJLwBv8Rrw0h6jbu+KzLX2CoZCCgU3LjzfkPDU7GvmTa7+qjJgKNQtNZ0+6MzlIJd11aOeTDAmeFq2fS4ep0EXuo1Kv6zbA9LyOn/hTd2QpaYrGihUM8B5Mr5ElLQbA6nNQ/UO90GiuKAbZhgvegtckU1e5AcHKxXK0o4Tp3HvkPKYlZnEoS0a27CijMRqiZBiYyT4w2C3tRFGpLGpxLeuJVs3sTjfSo2s5DtqmSvjG/aDz3PtCxb9O5/3NtCvbRWClN4bs5RN+p9GuPH9k23YpQnyr5TCfToAG5ZbRaSiksFYK+mYNVEvYb7qbQ+UOL30+ItD1eOR3HX2WY3cadpOVf6NqL3ayXMwXHOlg6YD4lqXICIEZYp5QqYqyQZRzR+12tKBp3O1+gaJ5jek2XxpHemaLtAXyK9YTQXoaMvorbbeASla7Z4vHzZ57sSkdIKC9GP6axkVFdF1ZaZ+Xdsae8dBgp+w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6BE03F2EE22A046A786660741ED96BF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5ae561-59e8-4257-0386-08d8921ce0e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 15:06:40.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asRE6KDguqZpnNfr97JmDD+M3PpHIy231FeOXW5IkrAfVpERYYU7CkvrL7x6hiwqxHFfgX0JahDvq+6UloJ3uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3822
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTI2IGF0IDA4OjQ4IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFRodSwgMjAyMC0xMS0yNiBhdCAxMjo0NyArMDIwMCwgRGFuIEFsb25pIHdyb3RlOg0K
PiA+IEhpIFNjb3R0LCBUcm9uZCwNCj4gPiANCj4gPiBDb21taXQgY2UzNjg1MzZkZDYxNDQ1MjQw
N2RjMzFlMjQ0OWViODQ2ODFhMDZhZiAoIm5mczoNCj4gPiBuZnNfZmlsZV93cml0ZSgpDQo+ID4g
c2hvdWxkIGNoZWNrIGZvciB3cml0ZWJhY2sgZXJyb3JzIikgc2VlbXMgdG8gaGF2ZSBhZmZlY3Rl
ZCBORlMgdjMNCj4gPiBzb2Z0DQo+ID4gbW91bnQgYmVoYXZpb3IsIGNhdXNpbmcgYXBwbGljYXRp
b25zIHRvIGZhaWwgb24gYSBzbG93IGJhbmQNCj4gPiBjb25uZWN0aW9uDQo+ID4gd2l0aCBhIHBy
b3Blcmx5IGZ1bmN0aW9uaW5nIHNlcnZlci4gSSBjaGVja2VkIHRoaXMgd2l0aCByZWNlbnQNCj4g
PiBMaW51eA0KPiA+IDUuMTAtcmM1LCBhbmQgb24gNS44LjE4IHRvIHdoZXJlIHRoaXMgY29tbWl0
IGlzIGJhY2twb3J0ZWQuDQo+ID4gDQo+ID4gUXVlc3Rpb246IHdoaWxlIHRoZSBORlMgdjQgcHJv
dG9jb2wgdGFsa3MgYWJvdXQgYSBzb2Z0IG1vdW50DQo+ID4gdGltZW91dA0KPiA+IGJlaGF2aW9y
IGF0ICJSRkM3NTMwIHNlY3Rpb24gMy4xLjEiIChzZWUgcmVmZXJlbmNlIGFuZCBwYXRjaHNldA0K
PiA+IGFkZHJlc3NpbmcgaXQgaW4gWzFdKSwgaXMgaXQgdmFsaWQgdG8gYXNzdW1lIHRoYXQgYSBz
aW1pbGFyDQo+ID4gZ3VhcmFudGVlDQo+ID4gZm9yIE5GUyB2MyBzb2Z0IG1vdW50cyBpcyBleHBl
Y3RlZD8NCj4gPiANCj4gPiBUaGUgcmVhc29uIHdoeSBpdCBpcyBpbXBvcnRhbnQsIGlzIGJlY2F1
c2UgdGhlIGZ1bGZpbG1lbnQgb2YgdGhpcw0KPiA+IGd1YXJhbnRlZSBzZWVtZWQgdG8gaGF2ZSBj
aGFuZ2VkIHdpdGggdGhpcyByZWNlbnQgcGF0Y2guDQo+ID4gDQo+ID4gRGV0YWlscyBvbiByZXBy
b2R1Y3Rpb24gLSB1c2luZyB0aGUgZm9sbG93aW5nIG1vdW50IG9wdGlvbjoNCj4gPiANCj4gPiDC
oMKgwqANCj4gPiB2ZXJzPTMscnNpemU9MTA0ODU3Nix3c2l6ZT0xMDQ4NTc2LHNvZnQscHJvdG89
dGNwLHRpbWVvPTUwLHJldHJhbnM9DQo+ID4gMTYNCj4gDQo+IFNvcnJ5LCBidXQgdGhvc2UgYXJl
IGNvbXBsZXRlbHkgc2lsbHkgdGltZW8gYW5kIHJldHJhbnMgdmFsdWVzIGZvciBhDQo+IFRDUCBj
b25uZWN0aW9uLiBJIHNlZSBubyByZWFzb24gd2h5IHdlIHNob3VsZCB0cnkgdG8gc3VwcG9ydCB0
aGVtLg0KDQpUbyBjbGFyaWZ5IF93aHlfIHRoZSB2YWx1ZXMgbWFrZSBubyBzZW5zZToNCg0KdGlt
ZW89NTAgbWVhbnMgIkkgZXhwZWN0IHRoYXQgYWxsIG15IFJQQyByZXF1ZXN0cyBhcmUgbm9ybWFs
bHkNCnByb2Nlc3NlZCAgYnkgdGhlIHNlcnZlciwgYW5kIGEgcmVwbHkgd2lsbCBiZSBzZW50IHdp
dGhpbiA1IHNlY29uZHMNCndoZXRoZXIgb3Igbm90IHRoZSBzZXJ2ZXIgaXMgY29uZ2VzdGVkIi4N
Ckkgc3VnZ2VzdCB5b3UgbG9vayBhdCB5b3VyIG5mc2lvc3RhdHMgb3V0cHV0IHRvIHNlZSBpZiB0
aGF0IGtpbmQgb2YNCmxhdGVuY3kgZXhwZWN0YW5jeSBpcyByZWFsbHkgd2FycmFudGVkIChsb29r
IGF0IHRoZSBtYXhpbXVtIGxhdGVuY3kNCnZhbHVlcykuDQoNCnJldHJhbnM9MTYgbWVhbnMgImhv
d2V2ZXIgSSBleHBlY3QgbXkgc2VydmVyIHRvIGRyb3AgUlBDIHJlcXVlc3RzIHNvDQpvZnRlbiwg
dGhhdCBzb21lIHJlcXVlc3RzIG5lZWQgdG8gYmUgcmV0cmFuc21pdHRlZCAxNiB0aW1lcyBpbiBv
cmRlciB0bw0KY29tcGVuc2F0ZSINCkRyb3BwaW5nIHJlcXVlc3RzIGlzIHR5cGljYWxseSBzb21l
dGhpbmcgcmFyZSBvbiBhIHNlcnZlci4gSXQgY2FuDQpoYXBwZW4gd2hlbiB0aGUgc2VydmVyIGlz
IGNvbmdlc3RlZCwgYnV0IHVzdWFsbHkgdGhhdCB3aWxsIGFsc28gY2F1c2UNCnRoZSBzZXJ2ZXIg
dG8gZHJvcCB0aGUgY29ubmVjdGlvbiBhcyB3ZWxsLiBJIHN1Z2dlc3QgeW91IGNoZWNrIHlvdXIN
Cm5mc3N0YXRzIG9uIHRoZSBzZXJ2ZXIgdG8gc2VlIGlmIHRoYXQgaXMgcmVhbGx5IHRoZSBjYXNl
Lg0KDQo+IA0KPiA+IA0KPiA+IFRoaXMgaXMgZG9uZSBhbG9uZyB3aXRoIHJhdGUgbGltaXRpbmcg
b24gdGhlIG91dGdvaW5nIGludGVyZmFjZToNCj4gPiANCj4gPiDCoMKgwqAgdGMgcWRpc2MgYWRk
IGRldiBldGgwIHJvb3QgdGJmIHJhdGUgNDAwMGtiaXQgbGF0ZW5jeSAxbXMgYnVyc3QNCj4gPiAx
NTQwDQo+ID4gDQo+ID4gQW5kIHBlcmZvcm1pbmcgZm9sbG93aW5nIHBhcmFsbGVsIHdvcmsgb24g
dGhlIG1vdW50cG9pbnQ6DQo+ID4gDQo+ID4gwqDCoMKgIGZvciBpIGluIGBzZXEgMSAxMDBgIDsg
ZG8gKGRkIGlmPS9kZXYvemVybyBvZj14JGkgJikgOyBkb25lDQo+ID4gDQo+ID4gUmVzdWx0IGlz
IHRoYXQgRUlPcyBhcmUgcmV0dXJuZWQgdG8gYGRkYCwgd2hlcmVhcyB3aXRob3V0IHRoaXMNCj4g
PiBjb21taXQNCj4gPiB0aGUgSU9zIHNpbXBseSBwZXJmb3JtZWQgc2xvd2x5LCBhbmQgbm8gZXJy
b3JzIG9ic2VydmVkIGJ5IGRkLiBJdA0KPiA+IGFwcGVhcnMgaW4gdHJhY2VzIHRoYXQgdGhlIE5G
UyBsYXllciBpcyBkb2luZyB0aGUgcmV0cmllcy4NCj4gPiANCj4gPiBbMV3CoCANCj4gPiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbmZzL2NvdmVyLzIwMTkwMzI4
MjA1MjM5LjI5Njc0LTEtdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbS8NCj4gPiANCj4g
DQo+IFllcy4gSWYgeW91IGFydGlmaWNpYWxseSBjcmVhdGUgY29uZ2VzdGlvbiBieSB0ZWxsaW5n
IHRoZSBjbGllbnQgdG8NCj4ga2VlcCByZXNlbmRpbmcgYWxsIHlvdXIgb3V0c3RhbmRpbmcgZGF0
YSBldmVyeSA1IHNlY29uZHMsIHRoZW4gaXQgaXMNCj4gdHJpdmlhbCB0byBzZXQgdXAgdGhpcyBr
aW5kIG9mIHNpdHVhdGlvbi4gVGhhdCBoYXMgYWx3YXlzIGJlZW4gdGhlDQo+IGNhc2UsIGFuZCB0
aGUgcGF0Y2ggeW91IHBvaW50IHRvIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggdGhpcy4NCj4gDQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
