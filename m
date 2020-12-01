Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65202CA772
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 16:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391858AbgLAPvX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 10:51:23 -0500
Received: from mail-co1nam11on2126.outbound.protection.outlook.com ([40.107.220.126]:26625
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731004AbgLAPvW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Dec 2020 10:51:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMbeBbHf6wSlEEtqU7OCsliGkcjcAR7NGmnRtbszGi7feyuGcsKDegxR+yMa+9ztUKJHnhC2ymCBIf44W3zOzgOskaLYc7SRshdEnQDJ4KZ+0qFosEYPRrYQzr9tJ8CR0XOXqwy+eLxSTwr5+oeCfMO50P7blBZqY8DY6HPw2CEOAqsYoFrF9mlj/swHswzKSd+5MiBL2hNGEF2yyfr93CgVm4VwPXgHVULDpzkITsWYgMs6iKyZyKS3cthik3+YngfNWhykRIrHYleRupwEFVQWO4kaXb3eKHORDEz0lGBr/krqLcMhLcZm/U0j3CX7XdHyWpQoUQpGW1uS76vsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy9rMh7EQbnk6JP8j/Xql9ZDvnQDxIZF54tLAFyYB/c=;
 b=bsg1uvJvmjoCMt/MrgMEHLoeiYOo90I0voc9ldTfSVsYJ134LJ8jl1T9ycRRHVjzxKl6+Pf60QVXWL3UMHnd2ZOTFDSU/iUuaPqwOqNMNc46yNG9iSBg1lE5H8P0jRmi5JYUE1oReRtvJynMVOAE+kZIu8ZIBR1sdYztnzwPAbHSNzC9zl1bA+0yDT1x5J+RhhVHdMAVfldnCLc3YBsdY0t5r52dXKwFmQvenD1r40uAxpDdyzcBmuYhB+pQ6yYmax7aoXCdtEyBfDH+Q3kk0Tg4UuLg1o4M7jZ/H1cn4kUUkjwWGw0yQO8Vu6ktgqe2z6CEImjHfJKXpie+++BR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy9rMh7EQbnk6JP8j/Xql9ZDvnQDxIZF54tLAFyYB/c=;
 b=WfE04Yxqfos2lo7GdytsvUP8+0JHUQJfwFz7qoDPIv1xoU6fvputuiGWpn42uzLrL3FGlJZRBnt51qpuWVd7MM9lcQ1z+ARIWjU3KaYIvY3zgbnhNvHn/20ReflcePOadbPzouKzvi7GWTUEIUyhj1mXTtrNiiWfYHYSouXbllE=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3901.namprd13.prod.outlook.com (2603:10b6:208:1e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Tue, 1 Dec
 2020 15:50:28 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 15:50:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Topic: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Index: AQHWx1999UsH3Pym/kCB2OnbCNS3q6nhSfMAgAAdxACAABzfAIAACquAgAABUwCAAAFoAIAAAc0AgADIRoCAAAh/gA==
Date:   Tue, 1 Dec 2020 15:50:27 +0000
Message-ID: <9ad643dbd4637e4d263392920e4d0b0e7cf1cf19.camel@hammerspace.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
         <20201130212455.254469-2-trondmy@kernel.org>
         <20201130225842.GA22446@fieldses.org>
         <1b525278a9a7541529290588a83852a0754cee3e.camel@hammerspace.com>
         <20201201022834.GA241188@pick.fieldses.org>
         <66f93208c6edf2dad70ee41c349c5130b30b8ed4.camel@hammerspace.com>
         <20201201031130.GD22446@fieldses.org>
         <213a0908e8c9e743d6ae4d6f3b2679e2e879cce4.camel@hammerspace.com>
         <a1db16841eb3e710a0245234c88ef2ceea2336fb.camel@hammerspace.com>
         <20201201151947.GA15368@fieldses.org>
In-Reply-To: <20201201151947.GA15368@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23e1b51f-8ea7-482a-a2e1-08d89610d323
x-ms-traffictypediagnostic: MN2PR13MB3901:
x-microsoft-antispam-prvs: <MN2PR13MB3901F53EE332E84AFB5836C8B8F40@MN2PR13MB3901.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LtSeICP2SaPX7ms4aVSJLSvJPQX0SrBUO7TDSuycb5z8Pbv6DjVYyWCa0/AGwODZZaXlHQNUbu3pMY2/Hg8fz+FTTGD9H1H/TOK/Oj+PFGS2U1OjDTfp/n5WJDhgb0JYUOU0De0x95F5ZqTn4VI6Ap4I8Y+xJ7v8FY3o1itGKWZn9qzMv44+p5zvgj82jQxZ/0r3OhnT1bHsveBRNYiGf1uDRo4fnI+uV9G/5046GtVrNO3WO4SB9m3DJAUUsMTfd/tJDk6/eFmn19ehJXUk5Ki0jV4wDJAuIhIZ14/Pdwf0BkDBhtzB4XY+iadN3KErZIwzbhQ4uhe0c4AnrJusrlumzaKNHus9yggmV7HiC3c0G4fuMDH3exYYk0t/pB2rglcDnethCzJffbkD0p0zAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39830400003)(346002)(366004)(2906002)(8676002)(6486002)(8936002)(316002)(86362001)(966005)(71200400001)(5660300002)(16799955002)(54906003)(6506007)(186003)(6512007)(26005)(6916009)(66556008)(66946007)(64756008)(66446008)(91956017)(2616005)(76116006)(66476007)(4326008)(36756003)(4001150100001)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K041cmNNV2J1WmdmUmhiQnVySzVjVEhjWFhPcnl4NHNyNHA0aUFwcE8rNmU3?=
 =?utf-8?B?WmRNdzlwbWIvb2pLMTdCU3hCa09IRkh3UnhJRHNqSTg2RGdmUUJNemZjT1RM?=
 =?utf-8?B?dG16R0RlR1RURU0wNUxrS3ZHcStNZ3Z2STBmZExEVElzUlk1aWNtMUJObUUx?=
 =?utf-8?B?dVlwdTE1STV5UFdlbmo2Z1dVVG1OUVFZK0k1MTh1L1VodEM4QTBLa3k1Zlp5?=
 =?utf-8?B?RjljdlYwcStPT0JQWWx1SXJHbW1iOU5SQmVtZ2Jzd3hUMStFeGtwRHp6RytP?=
 =?utf-8?B?WURjc1dyM0dIc09tL3YzOTJMajRlazdWRVVPQ2c3M2ZxelN0QkJYMkdONVp3?=
 =?utf-8?B?YTA2QXFJSXpCVjNvRE9GUDJMamNKZk5veWNmbTAxTTBuS0JrNlA1aHBxb3h1?=
 =?utf-8?B?UVVVbjE1YXU2MHdITmUrS01nVXVWWXU3WnB2eTFFQ3Z0dEFJbXByTG5IUzVh?=
 =?utf-8?B?TXpoU0QrUUFZcXVMbmhsRitZdGNPcHl3eFNFUzZ2TTJta1UyaGNpbGg1UUs4?=
 =?utf-8?B?SWxTYmsxb2EwSGNqWFlYQ25CdG1GaTJiMXFPMWFNTmpLb1pURVdmUGtQc3hk?=
 =?utf-8?B?ZlZLWG5ac2krOGhpU3FPQ2FtaW4rOUtVejhKd09JQmozZ25VU0FqMWpUL0JS?=
 =?utf-8?B?SHk3S2kzTXRWZkhPSmVmeGE1MFdpMmJVYXJlaVNRZlpINHpQSDV2UlpXRk1S?=
 =?utf-8?B?d2lZZHUwTkhDMUVTT1UrbzE3OGtsSmwxY1hsemIwa2RESm9WOENMaXh4SEF1?=
 =?utf-8?B?Zi83M25aMVd3Y29iM0N5LzdhZzVtcyt4VVVnWXYxdTd1dURLWkxvaEpSTE9C?=
 =?utf-8?B?QTNuaWZ5enZZdjRoWmMrRXU4ZWp4UVBkanUvU3ZBUWJqbEVIaThabnk4eHAx?=
 =?utf-8?B?VmVXN253OW9kWjQza0hYYUxhNnpYM28wT05FaU4xbEprWk9FaXJyOWdGTVhr?=
 =?utf-8?B?QXB6K05uaHh1bFR0bUoxSHY3Q0kzelc3QzRXTUZZRnF1bktBUm1zMWtUU0py?=
 =?utf-8?B?eGdOc1lhdG96eTNFUjR0dFFDY3EzTHVOa21Nai9pRnIxc3owV1p3MkF6M0pK?=
 =?utf-8?B?aDNhMmFPZytNd2FlQTFyc1V4RTU1bGQxSTRCT3lQcVpZZUw4QllKVkRnRGVC?=
 =?utf-8?B?NkZnRVdkTGJTeS9lSUFwWGtvT0R2dWdHUmRuQjJhSzlqUFhJcnFBeEUvbGtJ?=
 =?utf-8?B?ODJYNHJ3cDk5Q1JPbFAyclBiUjVUbkRKa3J5Mjg1SjdWeXU1eExnWk9rclRD?=
 =?utf-8?B?ZTlJdm9ONnQxTUlWMzNXN3lEOTd2a0kvVjZEU2NwVzk1VnliYzNDMEhOMG14?=
 =?utf-8?Q?S7j/EzmTa3OdeAVnOuBwsMKqXzyOHQqp1V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CAF8D60BCF3364380A30EA284FC7F56@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e1b51f-8ea7-482a-a2e1-08d89610d323
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 15:50:27.7034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnZE/hKRSEuTm9GTjxpG3CDITGSlapSQgtwZ3UmTuFIXm3wZOUm3Y/EdOeaKSAw6PHnJxlXUsuPnfjTHiGJVMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3901
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTAxIGF0IDEwOjE5IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVHVlLCBEZWMgMDEsIDIwMjAgYXQgMDM6MjM6MDBBTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMC0xMi0wMSBhdCAwMzoxNiArMDAwMCwg
VHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gT24gTW9uLCAyMDIwLTExLTMwIGF0IDIyOjEx
IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgRGVj
IDAxLCAyMDIwIGF0IDAzOjA2OjQ2QU0gKzAwMDAsIFRyb25kIE15a2xlYnVzdA0KPiA+ID4gPiB3
cm90ZToNCj4gPiA+ID4gPiBBIGxvY2FsIGZpbGVzeXN0ZW0gbWlnaHQgY2hvb3NlIHRvIHNldCB0
aGUgJ25vbi1hdG9taWMnIGZsYWcNCj4gPiA+ID4gPiB3aXRob3V0DQo+ID4gPiA+ID4gd2FudGlu
ZyB0byB0dXJuIG9mZiBORlN2MyBXQ0MgYXR0cmlidXRlcy4gWWVzLCB0aGUgbGF0dGVyIGFyZQ0K
PiA+ID4gPiA+IGFzc3VtZWQNCj4gPiA+ID4gPiB0byBiZSBhdG9taWMsIGJ1dCBhIG51bWJlciBv
ZiBjb21tZXJjaWFsIHNlcnZlcnMgZG8gYWJ1c2UNCj4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4g
YXNzdW1wdGlvbiBpbiBwcmFjdGljZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFdoYXQgZG8geW91IG1l
YW4gYnkgYWJ1c2luZyB0aGF0IGFzc3VtcHRpb24/DQo+ID4gPiA+IA0KPiA+ID4gPiBJIHRob3Vn
aHQgdGhhdCBsZWF2aW5nIG9mZiB0aGUgcG9zdC1vcCBhdHRycyB3YXMgdGhlIHYzDQo+ID4gPiA+
IHByb3RvY29sJ3MNCj4gPiA+ID4gd2F5DQo+ID4gPiA+IG9mIHNheWluZyB0aGF0IGl0IGNvdWxk
bid0IGdpdmUgeW91IGF0b21pYyB3Y2MgaW5mb3JtYXRpb24uDQo+ID4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBJIG1lYW4gdGhhdCBhIG51bWJlciBvZiBjb21tZXJjaWFsIHNlcnZlcnMgd2lsbCBoYXBw
aWx5IHJldHVybg0KPiA+ID4gTkZTdjMNCj4gPiA+IHByZS9wb3N0LW9wZXJhdGlvbiBXQ0MgaW5m
b3JtYXRpb24gdGhhdCBpcyBub3QgYXRvbWljIHdpdGggdGhlDQo+ID4gPiBvcGVyYXRpb24gdGhh
dCBpcyBzdXBwb3NlZCB0byBiZSAncHJvdGVjdGVkJy4gVGhpcyBpcywgYWZ0ZXIgYWxsLA0KPiA+
ID4gd2h5DQo+ID4gPiB0aGUgTkZTdjQgInN0cnVjdCBjaGFuZ2VfaW5mbzQiIGFkZGVkIHRoZSAn
YXRvbWljJyBmaWVsZCBpbiB0aGUNCj4gPiA+IGZpcnN0DQo+ID4gPiBwbGFjZS4NCj4gPiANCj4g
PiBCVFc6IFRvIGJlIGZhaXIsIHNvIGRvZXMga25mc2QuLi4NCj4gPiANCj4gPiBBdCBIYW1tZXJz
cGFjZSwgd2UgaGFkIHNvbWUgcmVhbCBwcm9ibGVtcyByZWNlbnRseSBkdWUgdG8gWEZTDQo+ID4g
ZXhwb3J0cw0KPiA+IHJldHVybmluZyBub24tYXRvbWljIHZhbHVlcyBmb3IgdGhlICJzcGFjZSB1
c2VkIiBmaWVsZC4gU3BlY3VsYXRpdmUNCj4gPiBwcmVhbGxvY2F0aW9uIGlzIGEgcmVhbCBiaXRj
aDoNCj4gPiBodHRwczovL3hmcy5vcmcvaW5kZXgucGhwL1hGU19GQVEjUTpfV2hhdF9pc19zcGVj
dWxhdGl2ZV9wcmVhbGxvY2F0aW9uLjNGDQo+IA0KPiBTbyB5b3UgdGhpbmsgeGZzIHNob3VsZCBv
bWl0IHYzIHBvc3Qtb3BlcmF0aW9uIGF0dHJpYnV0ZXMgYW5kIHN0aWxsDQo+IHNldA0KPiB0aGUg
YXRvbWljIGJpdCBpbiB2NCByZXBsaWVzPw0KPiANCj4gV291bGQgdGhhdCBoYXZlIGhlbHBlZCBp
biB0aGUgY2FzZXMgeW91IHNhdz/CoCBJdCBzZWVtcyBsaWtlDQo+IHNwZWN1bGF0aXZlDQo+IHBy
ZWFsbG9jYXRpb24gaXNuJ3QgYSBwcm9ibGVtIHdpdGggYXRvbWljaXR5IGV4YWN0bHktLWl0IGNv
dWxkbid0IGJlDQo+IGF2b2lkZWQgYnkgYXBwbGljYXRpb25zIGNvb3BlcmF0aW5nIHdpdGggc29t
ZSBsb2NraW5nIHNjaGVtZSwgZm9yDQo+IGV4YW1wbGUsIGlmIEknbSB1bmRlcnN0YW5kaW5nIHJp
Z2h0Lg0KPiANCg0KTG9ja2luZyBkb2Vzbid0IGhlbHAuIFRoaXMgaXNuJ3QgZXZlbiBzb21ldGhp
bmcgdGhhdCBuZWVkcyBtdWx0aXBsZQ0KY2xpZW50cy4gWEZTIHdpbGwgaGFwcGlseSBnaXZlIHRo
ZSBjbGllbnQgdGhhdCBzZW5kcyB0aGUgV1JJVEUgb25lDQphbnN3ZXIgZm9yICdzcGFjZSB1c2Vk
JyBpbiB0aGUgV0NDIGF0dHJpYnV0ZXMsIGFuZCB0aGVuIGEgZGlmZmVyZW50DQphbnN3ZXIgaW4g
YSBzdWJzZXF1ZW50IEdFVEFUVFIgKG5vIGNoYW5nZSBpbiBtdGltZSwgY3RpbWUgb3IgY2hhbmdl
DQphdHRyaWJ1dGUpIG9uY2UgdGhlIHNwZWN1bGF0aXZlIGFsbG9jYXRpb24gaGFzIGJlZW4gcmVz
b2x2ZWQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
