Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CFAD4296
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfJKOTA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 10:19:00 -0400
Received: from mail-eopbgr820122.outbound.protection.outlook.com ([40.107.82.122]:6327
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728138AbfJKOS7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Oct 2019 10:18:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1QbRBSUyTnme7rS1pS2EOC6/Hl0KZWd1ktSb27vhaJmScBMz+r4SfGN/qpGyP7UXSvNnRyc5oqsXRXVcsoOH92Vg/8Vc5nO3JhKm0cCLSY7D93NWGcW9+GX6F4fLaB0o8z2BbJ/Ht0XcDwMz2HgNJm4PGED5wBzSvxGOALKbxajg6vJyGT/htUP9JT+rinO2MsrhdDwamMZEl5ljtjxyP0mYFpMQ5w3W/Jvc6vzBPhAD/ef0Eswc9Mf7PcXbS5wovPfmoxyckO5WkdDE/IAbRovLynp2Jzfy4Skmhkn7tOZ23kAdHmef9UUe9e4mJjjEA7H1tXqoiLTLTj53W+50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EtTnkFqb6WM/HTvl+t7KhvqzLLvBZKLSK0wKm8+rO0=;
 b=kFInT3yQ4RcoQy8G6gS5f6mShWLbaCuYHp53FOeEC63jRhNqWZF1LYvpKhcN1BOMKwNKBqUvUQp/foMpIxuGjwIA/QDOUKxeYBwBoX0JytZgH/kbnOTmc6MWp5G60W4hV7LLX4Y20gTWLvLNVHKGfJ+qOxPWk14HfdKXLfW9dx15y+XTA1T+6IVgGfbX2v85IsYAXc8B+p9b+5WMQsMa1W19fX1Vac3cCe5o+0Z+15dtwU2UTltPN0LnrIM5TUTL1dua1+iDr9KdaurgorhmgVNDCyjrNFMUxebXE9LOkIUDCpNmkpHMeQMdpEPXbs2wWw/iFsQhLJuqy1ZdjhpxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EtTnkFqb6WM/HTvl+t7KhvqzLLvBZKLSK0wKm8+rO0=;
 b=E35RGOvOlCRiAURPiUn+a5oWRRQltX5dP3s1iLAX3p3eAg7pnHYNevPEmwEsnw7bEqg9gw1rdESgyT3RUtfR/QWovcVz9LLRU6c91mxK+BEFXk7JyhvVOU1NTZ/w95058Wx6zxviXxcpMhkCwg9zFPoi0HAtK9jhWEqAKHUL/No=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1545.namprd13.prod.outlook.com (10.175.109.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.13; Fri, 11 Oct 2019 14:18:43 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e%10]) with mapi id 15.20.2347.021; Fri, 11 Oct
 2019 14:18:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>,
        "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
Thread-Topic: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with
 OPEN
Thread-Index: AQHVfz4Dej3IfeNfekKrfX0XpGLKm6dUIv0AgAFcF4A=
Date:   Fri, 11 Oct 2019 14:18:43 +0000
Message-ID: <2597b15558e1195436db68f019899694c796fef6.camel@hammerspace.com>
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
         <CAN-5tyGKNFsxQHne4hFhON1VRZzCkUjwFMX3ZuzfLASgEN0pMw@mail.gmail.com>
In-Reply-To: <CAN-5tyGKNFsxQHne4hFhON1VRZzCkUjwFMX3ZuzfLASgEN0pMw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b631f548-0340-4a8b-b111-08d74e55ec05
x-ms-traffictypediagnostic: DM5PR13MB1545:
x-microsoft-antispam-prvs: <DM5PR13MB154559412E6D191D879CE378B8970@DM5PR13MB1545.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39840400004)(366004)(376002)(199004)(189003)(118296001)(110136005)(2501003)(316002)(2906002)(66066001)(8936002)(8676002)(81156014)(81166006)(4001150100001)(2616005)(476003)(11346002)(446003)(486006)(6486002)(5660300002)(229853002)(36756003)(186003)(26005)(99286004)(53546011)(6506007)(76176011)(102836004)(478600001)(71190400001)(71200400001)(91956017)(66946007)(76116006)(66476007)(66446008)(66556008)(64756008)(14454004)(6116002)(3846002)(256004)(2171002)(6246003)(14444005)(86362001)(6436002)(6512007)(25786009)(4326008)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1545;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h925ISN6YqNByRreg39G784GJJVJiDF/81VhBG9xlDuwBMAPUvNlKfmk9CUCwq1NZl8wkaVlVEM8zB+9kIKznqhZk82PmDoLplh0F8PPv2jw0U9xMip1g9BMcNKVcEeV31iCBdTr92q5wWcAWrpm0gdvIqXzfEswI33o4MK1p+CcokPXPbkQRBBKUwSJkz0KBWPFsZIDnibRzYMRtKYQK8a5OPZWdGOHV5Pp3mXko+6l4gcSDKJgSuIAuHh3BDhN1InA9H4cSgrjSTsF0IqxelSo7Mxh/3A9pHTRXpJRsjDYWpJ3goQzWb2q5ahbgb9bxF6jFqbcHb/P3bt3DkObMh2i0mhG27aXjUGQPS7q/EPYEKzPw+hGmiF/ICy5QSh5C02mTGnd0rMjlLvXtfHLPRkQxS9K4h3QpmqgLLGBd3Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <207385D9594B9A40B6E3FF130EA5EE75@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b631f548-0340-4a8b-b111-08d74e55ec05
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 14:18:43.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2h0V6JAqmPScC8chi+T/KAxZp+5x/6N+zySr1iwf/NqKv1hAXxaK4McuJpZfz0FRWsC4uQZlsVym0mREoSdKbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1545
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTEwIGF0IDEzOjMyIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVGh1LCBPY3QgMTAsIDIwMTkgYXQgMzo0MiBBTSBNdXJwaHkgWmhvdSA8amVuY2Nl
Lmtlcm5lbEBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+IFNpbmNlIGNvbW1pdDoNCj4gPiAgIFsw
ZTBjYjM1XSBORlN2NDogSGFuZGxlIE5GUzRFUlJfT0xEX1NUQVRFSUQgaW4NCj4gPiBDTE9TRS9P
UEVOX0RPV05HUkFERQ0KPiA+IA0KPiA+IHhmc3Rlc3RzIGdlbmVyaWMvMTY4IG9uIHY0LjIgc3Rh
cnRzIHRvIGZhaWwgYmVjYXVzZSByZWZsaW5rIGNhbGwNCj4gPiBnZXRzOg0KPiA+ICAgK1hGU19J
T0NfQ0xPTkVfUkFOR0U6IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlDQo+IA0KPiBJ
IGRvbid0IGJlbGlldmUgdGhpcyBmYWlsdXJlIGhhcyB0byBkbyB3aXRoIGdldHRpbmcgRVJSX09M
RF9TVEFURUlEDQo+IG9uDQo+IHRoZSBDTE9TRS4gV2hhdCB5b3Ugc2VlIG9uIHRoZSBuZXR3b3Jr
IHRyYWNlIGlzIGV4cGVjdGVkIGFzIHRoZQ0KPiBjbGllbnQNCj4gaW4gcGFyYWxsZWwgc2VuZHMg
T1BFTi9DTE9TRSB0aHVzIHNlcnZlciB3aWxsIGZhaWwgdGhlIENMT1NFIHdpdGggdGhlDQo+IEVS
Ul9PTERfU1RBVEVJRCBzaW5jZSBpdCBhbHJlYWR5IHVwZGF0ZWQgaXRzIHN0YXRlaWQgZm9yIHRo
ZSBPUEVOLg0KPiANCj4gPiBJbiB0c2hhcmsgb3V0cHV0LCBORlM0RVJSX09MRF9TVEFURUlEIHN0
YW5kcyBvdXQgd2hlbiBjb21wYXJpbmcNCj4gPiB3aXRoDQo+ID4gZ29vZCBvbmVzOg0KPiA+IA0K
PiA+ICA1MjEwICAgTkZTIDQwNiBWNCBSZXBseSAoQ2FsbCBJbiA1MjA5KSBPUEVOIFN0YXRlSUQ6
IDB4YWRiNQ0KPiA+ICA1MjExICAgTkZTIDMxNCBWNCBDYWxsIEdFVEFUVFIgRkg6IDB4OGQ0NGE2
YjENCj4gPiAgNTIxMiAgIE5GUyAyNTAgVjQgUmVwbHkgKENhbGwgSW4gNTIxMSkgR0VUQVRUUg0K
PiA+ICA1MjEzICAgTkZTIDMxNCBWNCBDYWxsIEdFVEFUVFIgRkg6IDB4OGQ0NGE2YjENCj4gPiAg
NTIxNCAgIE5GUyAyNTAgVjQgUmVwbHkgKENhbGwgSW4gNTIxMykgR0VUQVRUUg0KPiA+ICA1MjE2
ICAgTkZTIDQyMiBWNCBDYWxsIFdSSVRFIFN0YXRlSUQ6IDB4YTgxOCBPZmZzZXQ6IDg1MTk2OCBM
ZW46DQo+ID4gNjU1MzYNCj4gPiAgNTIxOCAgIE5GUyAyNjYgVjQgUmVwbHkgKENhbGwgSW4gNTIx
NikgV1JJVEUNCj4gPiAgNTIxOSAgIE5GUyAzODIgVjQgQ2FsbCBPUEVOIERIOiAweDhkNDRhNmIx
Lw0KPiA+ICA1MjIwICAgTkZTIDMzOCBWNCBDYWxsIENMT1NFIFN0YXRlSUQ6IDB4YWRiNQ0KPiA+
ICA1MjIyICAgTkZTIDQwNiBWNCBSZXBseSAoQ2FsbCBJbiA1MjE5KSBPUEVOIFN0YXRlSUQ6IDB4
YTM0Mg0KPiA+ICA1MjIzICAgTkZTIDI1MCBWNCBSZXBseSAoQ2FsbCBJbiA1MjIwKSBDTE9TRSBT
dGF0dXM6DQo+ID4gTkZTNEVSUl9PTERfU1RBVEVJRA0KPiA+ICA1MjI1ICAgTkZTIDMzOCBWNCBD
YWxsIENMT1NFIFN0YXRlSUQ6IDB4YTM0Mg0KPiA+ICA1MjI2ICAgTkZTIDMxNCBWNCBDYWxsIEdF
VEFUVFIgRkg6IDB4OGQ0NGE2YjENCj4gPiAgNTIyNyAgIE5GUyAyNjYgVjQgUmVwbHkgKENhbGwg
SW4gNTIyNSkgQ0xPU0UNCj4gPiAgNTIyOCAgIE5GUyAyNTAgVjQgUmVwbHkgKENhbGwgSW4gNTIy
NikgR0VUQVRUUg0KPiANCj4gInJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlIiBpcyBt
b3JlIGxpa2VseSB0byBkbyB3aXRoIHVsaW1pdA0KPiBsaW1pdHMuDQo+IA0KPiBJIGFsc28gc2F3
IHRoZSBzYW1lIGVycm9yLiBBZnRlciBJIGluY3JlYXNlZCB0aGUgdWxpbWl0IGZvciB0aGUgc3Rh
Y2sNCj4gc2l6ZSwgdGhlIHByb2JsZW0gd2VudCBhd2F5LiBUaGVyZSBtaWdodCBzdGlsbCBiZSBh
IHByb2JsZW0gc29tZXdoZXJlDQo+IGluIHRoZSBrZXJuZWwuDQo+IA0KPiBUcm9uZCwgaXMgaXQg
cG9zc2libGUgdGhhdCB3ZSBoYXZlIHRvbyBtYW55IENMT1NFIHJlY292ZXJ5IG9uIHRoZQ0KPiBz
dGFjayB0aGF0J3MgZWF0aW5nIHVwIHN0YWNrIHNwYWNlPw0KDQpUaGF0IHNob3VsZG4ndCBub3Jt
YWxseSBoYXBwZW4uIENMT1NFIHJ1bnMgYXMgYW4gYXN5bmNocm9ub3VzIFJQQyBjYWxsLA0Kc28g
aXRzIHN0YWNrIHVzYWdlIHNob3VsZCBiZSBwcmV0dHkgbWluaW1hbCAobGltaXRlZCB0byB3aGF0
ZXZlciBlYWNoDQpjYWxsYmFjayBmdW5jdGlvbiB1c2VzKS4NCg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
