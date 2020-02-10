Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7691582F1
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 19:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBJSr6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 13:47:58 -0500
Received: from mail-dm6nam10on2091.outbound.protection.outlook.com ([40.107.93.91]:16384
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726991AbgBJSr6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 Feb 2020 13:47:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBLBtvc9eWr4BMSoaX7mUhHIC9j8OUrdVR53sWgiQqYdN0bMxwS5cY0Oe86HPcbd7A8jB9prLiBvf2meJnt8EE72h2WXwBThr+Nrp706EMbvyBNBw08ezQmtWs+Rls0bllRzJ1gAsol+YfvZ2KLv0mzXQbsnJrEF42hLnAsP0iK3gLt6rHGF2L726vGfbbB6Qv7RvcKsMxZeRO0DbUKKZrvAhoScnLLDcNxeVM5hQRfdd6xD2KhHFuXPQKExu+bAsXlLCDhX7sOlOC6Z++lPeTVEhsqi4zDttFP+j5BLEoUvaDHEvvqGoeu7euRp0MM/pS29aUzdDQ7Bw7rO6mXrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rGiJ19I4zHkNB8QhuorYywfR6tAOXuJsb4568WukEU=;
 b=fli+8doSQpC3pAlFxnz9RobBQqicuRAWEXWluIU8JL7tXIGwTCKeQ2RBMLp6SkrSFyM4cDrDkK6B3uYRvd9UziWNAhQrvRJTSoIsz9n8Sqg6pUcfEZgVf193UM75MJvTMHuJsvy1JacUcjYBVhQLcIwMoDOgh5eCxvpkRW/gAOK4xfpmocdBgRpAVAngTXvpdyOkh1oR4Aowcxdq2se2sUKBKYdCstZSNk1+QGpPHv0RL6TAzd2NfmCon+xbH5P8700kXMlsJDaqgflWJuWuTiLPjktJJKid+e5xzY+yW6QPybANh+0Z6R9vj0TvxIRcZvVIGFHyXffMB9Zk5VEaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rGiJ19I4zHkNB8QhuorYywfR6tAOXuJsb4568WukEU=;
 b=OFi0PI5ep+lFga7I4rb8W3SUJH8HyOYJdBLnceh1P6vwc2BoAZ1Eg0k554pKzSmP4sl4YlHsulz/tzb9skSUjNpHZzk33P4gpVkgaAsChEIXdcm6ESLMyiZI3hDZqU8QXPa7/4kPwUw2G6Md3ZpJBVskhjkPWJh7bqsZNoo3VOY=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1994.namprd13.prod.outlook.com (10.174.182.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.21; Mon, 10 Feb 2020 18:47:54 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2729.018; Mon, 10 Feb 2020
 18:47:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Thread-Topic: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Thread-Index: AQHVyvwJPYRIWp4ZtEelpB+N9lu4ZqgOgFIAgAFulwCAAEEOgIAEv0MA
Date:   Mon, 10 Feb 2020 18:47:54 +0000
Message-ID: <9cb604f804e8be5a689cf6e5ee7c517dd0c6e8f8.camel@hammerspace.com>
References: <20200114165738.922961-1-trond.myklebust@hammerspace.com>
         <20200206163322.GB2244@fieldses.org>
         <8dc1ed17de98e4b59fb9e408692c152456863a20.camel@hammerspace.com>
         <20200207181817.GC17036@fieldses.org>
In-Reply-To: <20200207181817.GC17036@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e624a380-3ec8-4a9c-f363-08d7ae59bcf5
x-ms-traffictypediagnostic: DM5PR1301MB1994:
x-microsoft-antispam-prvs: <DM5PR1301MB1994950FD25B11001C2DA3E7B8190@DM5PR1301MB1994.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39830400003)(136003)(366004)(189003)(199004)(6486002)(36756003)(54906003)(316002)(26005)(6512007)(2616005)(4326008)(186003)(66446008)(8676002)(86362001)(71200400001)(5660300002)(64756008)(66556008)(66476007)(8936002)(91956017)(6506007)(81156014)(66946007)(81166006)(76116006)(478600001)(15974865002)(2906002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1994;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FqBfv9pGOibB5bkq+UisFBNK3vH1hv5YQCy7wouuB7FF+NtCUBfd58GYEsZTyUalGEuSfbDYHhZpRTwrrBGIXxsiw24nGSr2VqxaI//ayJ/ClgD8RtbBgl/3A0Pdq9jsjt8dGfVCzAf/WisQdNjUKEW+5INv01jAlbKgtHJyck6ZYYXQ8KjWIs4naJ+HzQAkhCZ5EzVTLW3/N4HOKBe+c8lWFSVMNKuNE9WkdA20yGladZFW6Gh856/T/A6Hj+K6rFSyRLIZ3pk3dIZepJGgbhpNurdtXQsHJgicnMi1lXVNXXjTVOYK4A9K7PjnNwMmPCEIF2FWlJd+J+EXfiII5p8NpWe7vDSBMuO/bKFirojdHSQiZlZB4zUVqk/bgcUq0H1PPbm7LwsXXMn8LairCvCsr7gjCN0aoqeQ15RDbR2Dt9B4RclPpsx8V9F/4WrBqAb5lwv1DqaiphYoU61JXQ1+FnYCv8J9kTV1bLn2dLzWrJdFyx9XZXeKJ5sQVDfWGxpTofBensoMxyTL/r8Nyg==
x-ms-exchange-antispam-messagedata: aDtEa4x0fOlBk+pSP73LBf1RplTSH+dFF4dZ3ceQENuzzRpr4pIHrEfesWCa1w4i2jO8N7cv86844rdEoAl47MVO4wrUVC/PLIgkR3WPEGUc1jom7Q252qdi1y2GqeeeA3VOS2XE3oOLkoK1l0pozg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C646D8C0C85FC24397442D557177FF09@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e624a380-3ec8-4a9c-f363-08d7ae59bcf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 18:47:54.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StFe70mnttk7xLhmLl+mtQWY5zK1el0LUHSrNW4cFQZrNwZ3/TwN6+V0cz9swWfKYnqpSUMvLK7q7cDK54v8Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1994
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTA3IGF0IDEzOjE4IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gRnJpLCBGZWIgMDcsIDIwMjAgYXQgMDI6MjU6MjdQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMC0wMi0wNiBhdCAxMTozMyAtMDUwMCwg
Si4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBKYW4gMTQsIDIwMjAgYXQgMTE6
NTc6MzhBTSAtMDUwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBJZiB0aGUgY2Fj
aGUgZW50cnkgbmV2ZXIgZ2V0cyBpbml0aWFsaXNlZCwgd2Ugd2FudCB0aGUgZ2FyYmFnZQ0KPiA+
ID4gPiBjb2xsZWN0b3IgdG8gYmUgYWJsZSB0byBldmljdCBpdC4gT3RoZXJ3aXNlIGlmIHRoZSB1
cGNhbGwNCj4gPiA+ID4gZGFlbW9uDQo+ID4gPiA+IGZhaWxzIHRvIGluaXRpYWxpc2UgdGhlIGVu
dHJ5LCB3ZSBlbmQgdXAgbmV2ZXIgZXhwaXJpbmcgaXQuDQo+ID4gPiANCj4gPiA+IENvdWxkIHlv
dSB0ZWxsIHVzIG1vcmUgYWJvdXQgd2hhdCBtb3RpdmF0ZWQgdGhpcz8NCj4gPiA+IA0KPiA+ID4g
SXQncyBjYXVzaW5nIGZhaWx1cmVzIG9uIHB5bmZzIHNlcnZlci1yZWJvb3QgdGVzdHMuICBJIGhh
dmVuJ3QNCj4gPiA+IHBpbm5lZA0KPiA+ID4gZG93biB0aGUgY2F1c2UgeWV0LCBidXQgaXQgbG9v
a3MgbGlrZSBpdCBjb3VsZCBiZSBhIHJlZ3Jlc3Npb24gdG8NCj4gPiA+IHRoZQ0KPiA+ID4gYmVo
YXZpb3IgS2luZ2xvbmcgTWVlIGRlc2NyaWJlcyBpbiBkZXRhaWwgaW4gaGlzIG9yaWdpbmFsIHBh
dGNoLg0KPiA+ID4gDQo+ID4gDQo+ID4gQ2FuIHlvdSBwb2ludCBtZSB0byB0aGUgdGVzdHMgdGhh
dCBhcmUgZmFpbGluZz8NCj4gDQo+IEknbSBiYXNpY2FsbHkgZG9pbmcNCj4gDQo+IAkuL25mczQu
MS90ZXN0c2VydmVyLnB5IG15c2VydmVyOi9wYXRoIHJlYm9vdA0KPiAJCQktLXNlcnZlcmhlbHBl
cj1leGFtcGxlcy9zZXJ2ZXJfaGVscGVyLnNoDQo+IAkJCS0tc2VydmVyaGVscGVyYXJnPW15c2Vy
dmVyDQo+IA0KPiBGb3IgYWxsIEkga25vdyBhdCB0aGlzIHBvaW50LCB0aGUgY2hhbmdlIGNvdWxk
IGJlIGV4cG9zaW5nIGEgcHluZnMtDQo+IHNpZGUNCj4gYnVnLg0KPiANCj4gPiBUaGUgbW90aXZh
dGlvbiBoZXJlIGlzIHRvIGFsbG93IHRoZSBnYXJiYWdlIGNvbGxlY3RvciB0byBkbyBpdHMgam9i
DQo+ID4gb2YNCj4gPiBldmljdGluZyBjYWNoZSBlbnRyaWVzIGFmdGVyIHRoZXkgYXJlIHN1cHBv
c2VkIHRvIGhhdmUgdGltZWQgb3V0Lg0KPiANCj4gVW5kZXJzdG9vZC4gIEkgd2FzIGN1cmlvdXMg
d2hldGhlciB0aGlzIHdhcyBmb3VuZCBieSBjb2RlIGluc3BlY3Rpb24NCj4gb3INCj4gYmVjYXVz
ZSB5b3UnZCBydW4gYWNyb3NzIGEgY2FzZSB3aGVyZSB0aGUgbGVhayB3YXMgY2F1c2luZyBhDQo+
IHByYWN0aWNhbA0KPiBwcm9ibGVtLg0KDQpJIHdhcyBzZWVpbmcgaGFuZ3MgaW4gc29tZSBjYXNl
cyB3aGVyZSB0aGUgcGF0aCBsb29rdXAgd2FzIHRlbXBvcmFyaWx5DQpmYWlsaW5nIGluIHRoZSBl
eHBvcnQgcGF0aCBkb3duY2FsbC4gSW4gdGhhdCBjYXNlLCB0aGUgbW91bnQgZGFlbW9uDQpqdXN0
IGlnbm9yZXMgdGhlIHJldHVybmVkIGVycm9yLCBhbmQgbGVhdmVzIGl0IHVwIHRvIHRoZSBrZXJu
ZWwgdG8gZml4DQp3aGF0IGlzIGhhcHBlbmluZy4NCg0KVGhlIHByb2JsZW0gaXMgdGhhdCBzaW5j
ZSB0aGUgZ2FyYmFnZSBjb2xsZWN0b3IgaXMgY3VycmVudGx5IHRvbGQgdG8NCmlnbm9yZSBzdHVm
ZiBpZiBDQUNIRV9WQUxJRCBpcyBub3Qgc2V0LCBhbmQgc2luY2UgY2FjaGVfY2hlY2soKSB3b24n
dA0KZG8gYSBzZWNvbmQgdXBjYWxsLCB0aGVuIGFueSBSUEMgY2FsbCB0cnlpbmcgdG8gYWNjZXNz
IGRhdGEgb24gdGhlIHBhdGgNCnRoYXQgd2FzIGFmZmVjdGVkIGp1c3QgaGFuZ3MgYW5kIGV2ZW50
dWFsbHkgdGltZXMgb3V0LiBOb3RoaW5nIHByb21wdHMNCmZvciB0aGlzIGNvbmRpdGlvbiB0byBi
ZSBmaXhlZC4NCg0KPiANCj4gLS1iLg0KPiANCj4gPiBUaGUgZmFjdCB0aGF0IHVuaW5pdGlhbGlz
ZWQgY2FjaGUgZW50cmllcyBhcmUgZ2l2ZW4gYW4gaW5maW5pdGUNCj4gPiBsaWZldGltZSwgYW5k
IGFyZSBuZXZlciBldmljdGVkIGlzIGEgZGUgZmFjdG8gbWVtb3J5IGxlYWsgaWYsIGZvcg0KPiA+
IGluc3RhbmNlLCB0aGUgbW91bnRkIGRhZW1vbiBpZ25vcmVzIHRoZSBjYWNoZSByZXF1ZXN0LCBv
ciB0aGUNCj4gPiBkb3duY2FsbA0KPiA+IGluIGV4cGtleV9wYXJzZSgpIG9yIHN2Y19leHBvcnRf
cGFyc2UoKSBmYWlscyB3aXRob3V0IGJlaW5nIGFibGUgdG8NCj4gPiB1cGRhdGUgdGhlIHJlcXVl
c3QuDQo+ID4gDQo+ID4gVGhlIHRocmVhZHMgdGhhdCBhcmUgd2FpdGluZyBmb3IgdGhlIGNhY2hl
IHJlcGxpZXMgYWxyZWFkeSBoYXZlIGENCj4gPiBtZWNoYW5pc20gZm9yIGRlYWxpbmcgd2l0aCB0
aW1lb3V0cyAod2l0aCBjYWNoZV93YWl0X3JlcSgpIGFuZA0KPiA+IGRlZmVycmVkIHJlcXVlc3Rz
KSwgc28gdGhlIHF1ZXN0aW9uIGlzIHdoYXQgaXMgc28gc3BlY2lhbCBhYm91dA0KPiA+IHVuaW5p
dGlhbGlzZWQgcmVxdWVzdHMgdGhhdCB3ZSBoYXZlIHRvIGxlYWsgdGhlbSBpbiBvcmRlciB0byBh
dm9pZA0KPiA+IGENCj4gPiBwcm9ibGVtIHdpdGggcmVib290Pw0KVHJvbmQgTXlrbGVidXN0DQpD
VE8sIEhhbW1lcnNwYWNlIEluYw0KNDMwMCBFbCBDYW1pbm8gUmVhbCwgU3VpdGUgMTA1DQpMb3Mg
QWx0b3MsIENBIDk0MDIyDQp3d3cuaGFtbWVyLnNwYWNlDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0
DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
