Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0DA2D4760
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgLIRB6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:01:58 -0500
Received: from mail-co1nam11on2110.outbound.protection.outlook.com ([40.107.220.110]:60256
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728082AbgLIRB6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 12:01:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX9AFYnjUl/RqmAis6MNt/wUJggbI7RH1k23yuwI0bMy6vHmuKkaF731lS6GHoYjud6yLmeVO4lujIFA047gj2eNspcIfvITyBMDAVeNYKAwLm+TGcHa4MuSx+3ssq4gzi+PjQn7n0Ak35AYnIdS5fW+dge7FlO0bi6NJeZJl7iE1xeajIstEQXiqs05cpN0js4VvjdlSH7FL/VwkKpgl6ZzYZ3lV+fpZoelUZThm8EhxQvV8h93VAghpU6zOfzNPIV0oOM0c/qFt4DEZPZQXinQMte3JuAgTk7GUXXwYuFdQ9t8jX2u/UHbLdg08HCbBKWGd5Eqe+ixGVgoPIHBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1rhBJLvXLi2Xt9+p7uhqQYn6QRt+fchJxw06c9cb/I=;
 b=hHyYE6EdN6JG/+NuagPLI3/+GnAHS1jw34Ce/sahyYZF4uu+f20VlbBJLzeRAadbDJF8id6Lxu9mvfygWW/Kan0iTflcBUngyVNVXY0ASmEYeYGs7wm50QjGz/CbJu72A5wl67Vjq2vvjG+l0mscbTGEKLv7LAmnTchRA7TUOtGXyBZuKbYx4xKiP8UnP9bfmpaKFBrw3r0yM9H0EErawHAi0Bf132VrMr2SXJHAkxiFg1j9glznqScNxC+OFGy8nHa90r1UfngrN8+1N+vgnbqCinlk853stmluXCzqY7eqhaEf5DusrfGwfMwVtYqSioC0xJcnITNaK7rpuAETMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1rhBJLvXLi2Xt9+p7uhqQYn6QRt+fchJxw06c9cb/I=;
 b=bQNS3YDdxlHY2WH/juywcCOq9bFsZ/hDOWvCXco6jfwBGsGiZpYSsUdMwFO4HTPKyDI8dC/7xrNVpAsz7eynYNZTL9BnJx05Zytsz3dK0bzX1eYFzB7Ft1JWouyGINmSIuaCORLoa9XdYz8KipW0J+TX7U5RiqxnuWdjZbrFPE8=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3152.namprd13.prod.outlook.com (2603:10b6:208:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5; Wed, 9 Dec
 2020 17:01:03 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3654.009; Wed, 9 Dec 2020
 17:01:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 15/16] nfsd: Fixes for nfsd4_encode_read_plus_data()
Thread-Topic: [PATCH 15/16] nfsd: Fixes for nfsd4_encode_read_plus_data()
Thread-Index: AQHWzjqrXvJmu+c15kOF+vAO2VLZ76nu8PAAgAAGQYCAAAU7AIAAAN4A
Date:   Wed, 9 Dec 2020 17:01:03 +0000
Message-ID: <2f9659232d159e2992960ec5000bca4275412fe2.camel@hammerspace.com>
References: <20201209144801.700778-1-trondmy@kernel.org>
         <20201209144801.700778-2-trondmy@kernel.org>
         <20201209144801.700778-3-trondmy@kernel.org>
         <20201209144801.700778-4-trondmy@kernel.org>
         <20201209144801.700778-5-trondmy@kernel.org>
         <20201209144801.700778-6-trondmy@kernel.org>
         <20201209144801.700778-7-trondmy@kernel.org>
         <20201209144801.700778-8-trondmy@kernel.org>
         <20201209144801.700778-9-trondmy@kernel.org>
         <20201209144801.700778-10-trondmy@kernel.org>
         <20201209144801.700778-11-trondmy@kernel.org>
         <20201209144801.700778-12-trondmy@kernel.org>
         <20201209144801.700778-13-trondmy@kernel.org>
         <20201209144801.700778-14-trondmy@kernel.org>
         <20201209144801.700778-15-trondmy@kernel.org>
         <20201209144801.700778-16-trondmy@kernel.org>
         <4BA2AAC7-C4F5-4740-B10F-D34022A58722@gmail.com>
         <55246c5db6ec550827f1f230bd980760db28a689.camel@hammerspace.com>
         <DF972250-F1EA-4996-8CEB-18171BD346C2@gmail.com>
In-Reply-To: <DF972250-F1EA-4996-8CEB-18171BD346C2@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c681662-c566-43a6-92ae-08d89c64031c
x-ms-traffictypediagnostic: MN2PR13MB3152:
x-microsoft-antispam-prvs: <MN2PR13MB31523649BBD42B4CA09C067CB8CC0@MN2PR13MB3152.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EsFzeVrOSiJMly8JsK27WxyZuwAJB1/wwob8RpW57QCcq6kmC67gKnQ64Ma2y0QcY1Uy3b7zfIO2kwvrm3Jqg6Zs1CvJWo36BylbTlY2QCfSNC49o6gNk7QpeEAsDnMG3RsESvCzxkzqNiIVrG3QG6HTCacqkDGks2FtG7CJCLwoAxfwwi1N+1I6jmL0fUXUl/F9Hv330GVJkwM91AkZaF6yXs3QufCoG/YOsw2u5F3+dkPS5iSxBvWVlMNctLPoB4vYmASIZ9eYXMFxF/M7dgbyE/0m/Qwq4Q8DAaTsdvJAcjQUjRcKl3PjBklQE5UZAVzonGQcJNoF6BFK6Gf2WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(6916009)(26005)(91956017)(5660300002)(66556008)(6486002)(66446008)(76116006)(6506007)(66476007)(4326008)(36756003)(71200400001)(53546011)(86362001)(66946007)(64756008)(8676002)(508600001)(8936002)(2616005)(186003)(2906002)(83380400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZTBMTS9qZlZINGozSXpJeXkzbHFTa3NhUXErMmMxbFdRejgyYmtLSjZDL044?=
 =?utf-8?B?Y3l0U1REOGdkN2EwOFZQc0JUNWNFOXZoMlFDZ3NGVHhNZmk5SUdWVEp1SDgr?=
 =?utf-8?B?ZUtnaFhQaDM5OFlQMHNZUWFXQ1U2anZ3d1FoYnE1RGV6L0NVanFZd3d1MWhl?=
 =?utf-8?B?dkk1bWw2OWxqTlo2cFpHYWhtRnVLdnE2STBkeUFVWUd5aXFhQ3B0cGxqYWVy?=
 =?utf-8?B?QjJBdi9NVFdNQm9sa3RVdktpZjhlcHVNVndoNkt6L0hyWVQvWWVWTnBGOTZL?=
 =?utf-8?B?NU5MYjlUVXdyMXoxeUhYRGJVRVpYczRvcW5HMkdRNFhzcmJIUFlRczFFcXpx?=
 =?utf-8?B?QTExM3VQYi9INnpvR3JyRm9PYjY0V1BzRXVnWXVSMllHcVR5b1AzQXBYOU9x?=
 =?utf-8?B?SkRSSTBtTWFMM3BrVmZnVTUxdy9UTTRxOUxmek96VWFCQWExdWVVc2daS0Rz?=
 =?utf-8?B?MFE5T3ZCOWhvNVEzMHJ4K2JRL3Rzam0wRWlyWG5tSFFDOGsvN05xeS9RV0J5?=
 =?utf-8?B?eW9PYXJQOTg0Wk9sOEU2bUdTSmp3N2RBcTFjajRCdXBja01ZZ3JzcDlIRXo4?=
 =?utf-8?B?NVpXN0NST2llaEtrakdER1h0RndHK2ZDUThlbHV4aEFXV3kvcmFXYzU0V0NQ?=
 =?utf-8?B?MDhJalF5Ry81NVRvblp2alBvRkY0QllMWHhKMkVicGpEZVg2azFDUHJuSkNJ?=
 =?utf-8?B?M0ZQWWx5UkkxU2t0K2UrbVFRaEVBWUpKQm9LZUw3MTQ3UkFYVndsQVJpZVYw?=
 =?utf-8?B?V25UUlB4enpHRklzajRJUjJkTUh6RTgrZFBCVHF0dlhQdGxqZ1NlSFpreURU?=
 =?utf-8?B?RU1yVXdRK0o0NGNQeElOejd4dTBGMXU1ZE5uaUN6cWllalVta05yTFhiTllJ?=
 =?utf-8?B?UUUvcG9Vbjc2ZzBCaWlxQ1NvSG1oN0JpQi9MTnNhanBJbG1JMEFPZThkU09n?=
 =?utf-8?B?ZDNHWDdnYWR0QnhtK3dYUHN6dlNqS3FlMFpKMGU3d1A0VlRRR0Y5dytTUWY0?=
 =?utf-8?B?b1pEK3J1V0xVYjZ0Q0s1OVFqVE5SV2pyMVRBUmVGS05lcXBoZVkxRjZaL05m?=
 =?utf-8?B?R3NIQlJ2Qmx6RFFrV0Rtek9tMUI3clBOUFJnb2ZXREI4cXk2UUpuTjhpeU9E?=
 =?utf-8?B?MEZzdWF4a09iY0VuWEljVCtXdFVZUTBNejJVZWxrZnNtVnVlekNiYW8wVE80?=
 =?utf-8?B?L0lZOWQrN09TeTZuaEhKQUpoYmdXTzdQL0xWcmRaU01vWTkwUlFRaGloZDkx?=
 =?utf-8?B?Z2Uxa0ZINFpNT2VSa0dSY1RhV21MN000L04yNko0N3liVzdsQ1l4THlWdW5v?=
 =?utf-8?Q?p2dspSyoSUZZFmM3km7Yf/ll6tGr9WsQP1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <43E9E71AA6C55640864E38FD2FA50981@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c681662-c566-43a6-92ae-08d89c64031c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 17:01:03.4945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMS9H8si6OA1n64duqIzvmJUiezD2s3T9UGI8pAdumIFszA7MyTy04fiCdzJoyURsSYTBPE71BcXNCJ4IVgHig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3152
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTA5IGF0IDExOjU3IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIERlYyA5LCAyMDIwLCBhdCAxMTozOSBBTSwgVHJvbmQgTXlrbGVidXN0IDwN
Cj4gPiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAy
MDIwLTEyLTA5IGF0IDExOjE2IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+IEhleS0N
Cj4gPiA+IA0KPiA+ID4gPiBPbiBEZWMgOSwgMjAyMCwgYXQgOTo0OCBBTSwgdHJvbmRteUBrZXJu
ZWwub3JnwqB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IEVuc3Vy
ZSB0aGF0IHdlIGVuY29kZSB0aGUgZGF0YSBwYXlsb2FkICsgcGFkZGluZywgYW5kIHRoYXQgd2UN
Cj4gPiA+ID4gdHJ1bmNhdGUNCj4gPiA+ID4gdGhlIHByZWFsbG9jYXRlZCBidWZmZXIgdG8gdGhl
IGFjdHVhbCByZWFkIHNpemUuDQo+ID4gPiANCj4gPiA+IERpZCB5b3UgaW50ZW5kIHRvIG1lcmdl
IDE1LzE2IGFuZCAxNi8xNiB0aHJvdWdoIHlvdXIgdHJlZT8NCj4gPiANCj4gPiBOby4gVGhleSBj
YW4gZ28gdGhyb3VnaCB0aGUgbmZzZCB0cmVlLiBJIGluY2x1ZGVkIHRoZW0gaGVyZSBiZWNhdXNl
DQo+ID4gdGhleSBhcmUgbmVjZXNzYXJ5IGluIG9yZGVyIHRvIHBhc3MgdGhlIHhmc3Rlc3RzLg0K
PiANCj4gV291bGQgaXQgYmUgT0sgaWYgdGhleSB3ZW50IGluIDUuMTEtcmM/IEkndmUgZ290IHRo
ZSBpbml0aWFsDQo+IG1lcmdlIHRhZyBwcmVwYXJlZCBhbHJlYWR5LiBJZiB0aGV5IGNhbid0IHdh
aXQsIGxldCBtZSBrbm93Lg0KDQpJJ20gZmluZSB3aXRoIHRoYXQuDQoNCj4gDQo+IA0KPiA+ID4g
Q2FuIHRoZSBwYXRjaCBkZXNjcmlwdGlvbnMgc2F5IGEgbGl0dGxlIG1vcmUgYWJvdXQgd2h5IHRo
ZXNlDQo+ID4gPiBjaGFuZ2VzIGFyZSBuZWNlc3Nhcnk/IElmIHRoZXkgZml4IGEgbWlzYmVoYXZp
b3IsIGRlc2NyaWJlDQo+ID4gPiB0aGUgcHJvYmxlbS4NCj4gPiANCj4gPiBJdCdzIHRoZSBzYW1l
IHByb2JsZW0gYW5kIHNvbHV0aW9uIHRoYXQgZXhpc3RzIGluIHRoZSBSRUFEIGNvZGUuDQo+ID4g
DQo+ID4gbmZzZF9yZWFkdigpIGRvZXNuJ3QgbmVjZXNzYXJpbHkgcmV0dXJuIHRoZSBzYW1lIG51
bWJlciBvZiBieXRlcw0KPiA+IHRoYXQNCj4gPiB3ZSByZXF1ZXN0ZWQgYW5kIHByZWFsbG9jYXRl
ZCBidWZmZXIgc3BhY2UgZm9yLiBTbyB0byBkZWFsIHdpdGgNCj4gPiB0aGF0LA0KPiA+IHdlIGhh
dmUgdG8gdHJ1bmNhdGUgdGhlIHByZWFsbG9jYXRlZCBidWZmZXIuDQo+IA0KPiBIdWguIEkgdGhv
dWdodCBpdCB3YXMgZG9pbmcgdGhhdCBhbHJlYWR5PyBPaCwgdGhhdCdzIGp1c3QgZm9yDQo+IHRo
ZSBjYXNlcyB3aGVyZSB0aGUgc2VydmVyIHJldHVybnMgYW4gZXJyb3Igc3RhdHVzLiBUaGUNCj4g
UkVBRF9QTFVTIGVuY29kZXIgaW5jb3JyZWN0bHkgZG9lcyBub3QgZG8gdGhhdCB0cnVuY2F0aW9u
IGZvcg0KPiBzaG9ydCBSRUFEcy4uLiBnb3QgaXQuDQo+IA0KPiANCj4gPiBGaW5hbGx5LCB3ZSBo
YXZlIHRvIHdyaXRlIHplcm9zIGludG8gdGhlIHBhZGRpbmcgYnl0ZXMgYWZ0ZXIgdGhlDQo+ID4g
cmVhZA0KPiA+IGJ1ZmZlci4NCj4gDQo+IFJpZ2h0LiBUaGVuIHRoZSBwcm9ibGVtIHN0YXRlbWVu
dCBpcyB0aGF0IHRoZSBzZXJ2ZXIncyBSRUFEX1BMVVMNCj4gWERSIGVuY29kZXIgaXNuJ3QgcGFk
ZGluZyB0aGUgcmVhZCBidWZmZXIgcHJvcGVybHkuDQo+IA0KPiBRdWliYmxlOiBwZXJoYXBzIHRo
ZXNlIGFyZSB0d28gc2VwYXJhdGUgaXNzdWVzIHRoYXQgZWFjaCBkZXNlcnZlDQo+IHRoZWlyIG93
biBwYXRjaGVzIHdpdGggRml4ZXM6IHRhZ3MgKGFuZCBpZiB5b3UgcmUtcG9zdCB0aGVzZSwNCj4g
cGxlYXNlIGFkZCBhIEZpeGVzOiB0YWcgdG8gMTYvMTYgdG9vKS4NCg0KSSdtIG5vdCBwbGFubmlu
ZyBvbiByZXBvc3RpbmcuDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
