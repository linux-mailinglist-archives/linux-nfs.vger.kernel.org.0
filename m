Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABDF372BFA
	for <lists+linux-nfs@lfdr.de>; Tue,  4 May 2021 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEDO2B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 May 2021 10:28:01 -0400
Received: from mail-bn8nam08on2101.outbound.protection.outlook.com ([40.107.100.101]:23648
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230213AbhEDO2B (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 May 2021 10:28:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUknZQm9qhYr0bjsVAbUEx0EZLKlm12Vf66ySsKVUAKbxqTJKVjtLZo++ZvuL6So4x0sfXrkIe5oCRFuST99NK8i/9zmU8PXgwHvGtTqukxHLfMSYXg8p8waEHWGEny8mTVf8YNmGpTsQJRQ2WjW4lbCy/F7YduvcmuhkVr1qHKa+yNNWzDfZFKejTCoHOq0u8Kj/3STHSmR4aVqCKyMFWmFX4W0BXFr18WXFnca/8R//TuBusEnoo7w8vryGLYyHaW/kPOiQPE4GDPcN971+35fEH0n+xbE8QzO1rOoJa3PjTnsCWa1qW9EZvTB6XIpTczJSufB7ZEqpbF5jJYDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuypBICH2lArYrFn+xzHye51DuIptPldlzgq0ij9a2M=;
 b=CbrcZaCLvzEvXE649r7H7nYYRE7EtKaJrH85Tzh3/S91YQ4u2pgngi23Kfn9HWPuv37qgSL9B9NQl/cI6Xi5QGKEoCC1K8puFrI+r9Obr4RcSUe8XvKDS2GenI2OY7v+AkVP9hFPG7cQ9Ux5PyzsVTyDyXwzUPdmNsHNE3eXSB2+h/7b2+tjDaJmo1mHLCa0ToJZScsdBi3rmdUqg6qLoRu5UUbHFwh1pjWKFYI03g8BCuVlyeTEhbMHcKVfeR9Jv3AFZUvNmtvRSTSpTDN8uVuECpfb6FFYxRj7P1Jx/voYpWxDjivRK/aS7dt4BHZ1iUf+gLYFXP9nrCukR3NRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuypBICH2lArYrFn+xzHye51DuIptPldlzgq0ij9a2M=;
 b=cPycbnaakRNtaHePh2kRKnubXsQkdhjNB2KpAEujTIINLgojqx6tm2cl3SRbdhd2yW1iFiW7JlemDertxLXgEs7uTPQdHV/4gZmi/Hf9zW9mEVtmVharb7+xQiio6vIQXoA3NzIxPVn0JYMVXEBHn+KEikrsrB3qrkDuBxflttQ=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3897.namprd13.prod.outlook.com (2603:10b6:5:22a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8; Tue, 4 May
 2021 14:27:04 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4108.025; Tue, 4 May 2021
 14:27:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "fsorenso@redhat.com" <fsorenso@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "jshivers@redhat.com" <jshivers@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Re: unsharing tcp connections from different NFS mounts
Thread-Topic: Re: unsharing tcp connections from different NFS mounts
Thread-Index: AQHWm/NG4ET1NagHX0mhv4Iw/L0dZKmK9/iAgAAkV4CAACp7AIAAuvkAgAAYugCAAA3yAIAABV0AgAAC94CAAB7QAIAADG0AgKPPPoCAAA08gIABC5mAgKI0lACAAGRKgIAAzkKA
Date:   Tue, 4 May 2021 14:27:04 +0000
Message-ID: <4033e1e8b52c27503abe5855f81b7d12b2e46eec.camel@hammerspace.com>
References: <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>   ,
 <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>      ,
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>      ,
 <20201007140502.GC23452@fieldses.org>  ,
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>      ,
 <20201007160556.GE23452@fieldses.org>  ,
 <e06c31e4211cefda52091c7710d871f44dc9160e.camel@hammerspace.com>       ,
 <20210119222229.GA29488@fieldses.org>  ,
 <2d77534fb8be557c6883c8c386ebf4175f64454a.camel@hammerspace.com>       ,
 <20210120150737.GA17548@fieldses.org>  , <20210503200952.GB18779@fieldses.org>
         <162009412979.28954.17703105649506010394@noble.neil.brown.name>
In-Reply-To: <162009412979.28954.17703105649506010394@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b180f0cc-4c4d-4248-3c12-08d90f08b0a1
x-ms-traffictypediagnostic: DM6PR13MB3897:
x-microsoft-antispam-prvs: <DM6PR13MB3897C10A687B5946EE77BB2AB85A9@DM6PR13MB3897.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LiaURrcQFc6fYi8J4Mf7r9fSNPDDBcs9tpY0h5C6dtDHvyLY1HQ6mtJ6FppTwdZC7LGTIIMr3nG1zV31IUCPoqUE1l1s1cYVxOl2QYo1kvpZwu56ebV4/abIt+NcSyWwcB7FanNOti7FXjwRxjeO93/qjmdB64siCFQtDmNyxuvRYZHqWNxkHh/t/IatP/PZnQZPnrmHxx4T8PkYlL/JMjmhMtGdVKHYAvl4K5/daH+TlA0bibOntZTTxmDQ5L6ynyD2ahjWTUqyZf90DjHYJyQThUUmaRsyxsh5YClon1ofq728HCMpYJMeZd9A6IFEOgxOsP8U/orUad3vVeSY3LGjdAiUNGrg1WqfctL/vTdcwhZbsq4fMAhPepXv+td/9ysWsrQUm165oLCyUeC8v2CFqU6OPkQECfFhg7mc2PsEfZ93wWBPJafrmny+PHwOTvq+USlnupkz857sEAE4qRneobvcTh1cqTHjFhOJ9Kk9L0Rf961x/rmE3/75PuvVvIlWFdaI6XCFqYVMmN1FoCP2M5Cl34zUy9bvLuQRmrBIwLpgFaRnibddf6l4pBFmiL+i2KCbTiJ/Nouo78ltsDGJ3IgwQyJA8mK37PngjyY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(346002)(366004)(376002)(396003)(86362001)(2906002)(83380400001)(4326008)(6486002)(71200400001)(122000001)(36756003)(6512007)(38100700002)(5660300002)(6506007)(66446008)(64756008)(26005)(110136005)(8936002)(478600001)(54906003)(2616005)(66946007)(186003)(316002)(66556008)(8676002)(66476007)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UjVlY3A5a0dWblB2Wk1NcmFrbjFFVzBnVTYrSWhzcGJzV1lSSE5LaE11d2R3?=
 =?utf-8?B?L0ROMXJHT2RrVm0zbXAyMWlCei81dmg1dENXQzlybjBWYXJoaE1FS0ZLMkVl?=
 =?utf-8?B?Nm5RaXVxSm91ZXpHMi9hanpWOW14eHZ5N2xFbHNhc3FBYVdpQ29RR2FReW5p?=
 =?utf-8?B?R1NYTmFYNWp6bzdjSy9ka1ZUU3M4T0YzRHZnejFTdEFjdVMrU2I1c2k3N1Nt?=
 =?utf-8?B?TW4xU2d0eHRmbkRwZnUrQ3hqMnhWN0gzVnZvckdNWWJHSU5OU0xHc1A0YW5Y?=
 =?utf-8?B?eFp6REZpZDBMeFpaKzJ4SHlyVzlWQ29iUldFN3ZZQmdkeTZORlBhb3A0L1Zy?=
 =?utf-8?B?Rzh6OXdXMW9tajFrSEdJRERHNnN3M0I0ZXY4UkFXVVRTeTgyZElCeW94QkVZ?=
 =?utf-8?B?UVkyUzBqL0szOVhEN292ZHRFL1Zqc0FtcWFZd1BhbDFmN0dvbmhmTkVsZ0da?=
 =?utf-8?B?SlNpSzF6dTQrZ3ZqTHdqdGRaOGV0My96VkJENzdLc2JwNURqWXR5TVFRN0FK?=
 =?utf-8?B?RWtLZ3ZqSFhKQXhlSnBLaGhaR1RTRU9hWk1MN3FGRkJFdU1kQXRxY2JKZ0pW?=
 =?utf-8?B?SmVwcm9Xd3BFOWQxTzlCdFY0dm9sV1U4K3JNMFlIOTZsN3JLaTIrcHhCTEtv?=
 =?utf-8?B?M0M2RkhNTWRFWHdlakpRMCtOeXEzMUVMckt0V1pYNTdsV2RTUVpKYlVpdUE0?=
 =?utf-8?B?aHV5Z0U1MFl0bmVGUnRnU2RZV1NpYWVUNW52UjV4NUpRQ24ycUFmQWdYVmg4?=
 =?utf-8?B?eHZPb2VMQlBNdUZPU0N1LzI2azBHMzNpOVdYT1llZGZSODBNT1Npa2Erbnd0?=
 =?utf-8?B?Y2R0YUVHNWF4Nnppbzd6UWhDY01BZkFnRktEWVJzb1R0Zm5YOUhxS0RIRW1N?=
 =?utf-8?B?UDZGcXordHYvYS9HekxnVVZSRlFnTFAzRWUybGxQazhUNTl0MEhEVHlVUW1a?=
 =?utf-8?B?bXQwNEkrM25pcDNWZVVLcE54M3EwVFNrUnNQVjk1d0dIUC95bC9GTVNuOHl0?=
 =?utf-8?B?MjZtMkRXbjRjaE5OMmNwUVZlQW9LaHV3QWppRk9oTkQvRlpVbjZHNVNUTzNM?=
 =?utf-8?B?RmppVXg4bnVVTGhPN2VGdUQxZjdhckFnem5hV2tVMGM1K3BrbzZPcURiMURC?=
 =?utf-8?B?VG1OZFRuVWpJSSs4OWhWWnBxa1FhVHdYL3daTlE2NTZEcDM3bm5SRW5qTjk2?=
 =?utf-8?B?MDFPMm5Pb3ZRYUJ3NEU5ZEhDNUZUclIwbmxBSzdPeDFKMmNncFR4UGNLcjRJ?=
 =?utf-8?B?eDhwVW11NTBtenR5SzNtWjZtUnI0Y0tlTTVLNVVDcUlBRHpoRjFZZEdQRERP?=
 =?utf-8?B?ckFkbVhjek85NjgvTy9ENWtncGh5Q2xGN215bXh5N3VaV05mOU1WTm4vd25W?=
 =?utf-8?B?M3dyTjg3RzA5ZlJRTEcvdHVwdG1JRi84NzBaSUk5b29EUlNwUUdneDZLcS92?=
 =?utf-8?B?VlNsU043QjZjNngwMnA5VVpiMVlpTEhuTDJPaTR6QWZQU2xqaCtGM2pFc21a?=
 =?utf-8?B?VzJTaFpvQmtoYTkzUGc2VThpZGdWVFNIOGRYMnljMnlCV2hWTjFReFlwMFl0?=
 =?utf-8?B?VUdlMVQ0ZDlkK1ZpeVoraEp4U3VMaTRQWTBEUTZuQ2RLQmZKNmdIZ0poRDh5?=
 =?utf-8?B?TWg2MCszaDYwT1h2Nk84NDBDN25oWDF2TGVhMGhjTEljYkQ3OWRyMjkzb2VJ?=
 =?utf-8?B?azVWOGZwQ3ZLZHFqWWpBTTcrNDNzbnE0Nk5XeW4rN2RWRHFNMXBMSEVvcFZh?=
 =?utf-8?Q?SQijRr92ixnlswdR5quzRKC9TI/ZIVFzhgWILIG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5F1FF39092D824682160D33F3BC6F35@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b180f0cc-4c4d-4248-3c12-08d90f08b0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 14:27:04.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqBbfT2RmUa5leUKBNUCKsd7p0hFHFbUIpmkgYqB/qhIjZGngiaPXwiZKjnFQIuTIpbok7JnycjqzisKj0MyTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3897
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA1LTA0IGF0IDEyOjA4ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMDQgTWF5IDIwMjEsIGJmaWVsZHNAZmllbGRzZXMub3JnwqB3cm90ZToNCj4gPiBPbiBX
ZWQsIEphbiAyMCwgMjAyMSBhdCAxMDowNzozN0FNIC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9y
Z8Kgd3JvdGU6DQo+ID4gPiANCj4gPiA+IFNvIG1haW5seToNCj4gPiA+IA0KPiA+ID4gPiA+ID4g
V2h5IGlzIHRoZXJlIGEgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiBiZWluZyBzZWVuIGJ5IHRoZXNl
DQo+ID4gPiA+ID4gPiBzZXR1cHMNCj4gPiA+ID4gPiA+IHdoZW4gdGhleSBzaGFyZSB0aGUgc2Ft
ZSBjb25uZWN0aW9uPyBJcyBpdCByZWFsbHkgdGhlDQo+ID4gPiA+ID4gPiBjb25uZWN0aW9uLA0K
PiA+ID4gPiA+ID4gb3IgaXMgaXQgdGhlIGZhY3QgdGhhdCB0aGV5IGFsbCBzaGFyZSB0aGUgc2Ft
ZSBmaXhlZC1zbG90DQo+ID4gPiA+ID4gPiBzZXNzaW9uPw0KPiA+ID4gDQo+ID4gPiBJIGRvbid0
IGtub3cuwqAgQW55IHBvaW50ZXJzIGhvdyB3ZSBtaWdodCBnbyBhYm91dCBmaW5kaW5nIHRoZQ0K
PiA+ID4gYW5zd2VyPw0KPiA+IA0KPiA+IEkgc2V0IHRoaXMgYXNpZGUgYW5kIHRoZW4gZ2V0IGJ1
Z2dlZCBhYm91dCBpdCBhZ2Fpbi4NCj4gPiANCj4gPiBJIGFwb2xvZ2l6ZSwgSSBkb24ndCB1bmRl
cnN0YW5kIHdoYXQgeW91J3JlIGFza2luZyBmb3IgaGVyZSwgYnV0IGl0DQo+ID4gc2VlbWVkIG9i
dmlvdXMgdG8geW91IGFuZCBUb20sIHNvIEknbSBzdXJlIHRoZSBwcm9ibGVtIGlzIG1lLsKgIEFy
ZQ0KPiA+IHlvdQ0KPiA+IGZyZWUgZm9yIGEgY2FsbCBzb21ldGltZSBtYXliZT/CoCBPciBkbyB5
b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMgZm9yDQo+ID4gaG93DQo+ID4geW91J2QgZ28gYWJvdXQg
aW52ZXN0aWdhdGluZyB0aGlzPw0KPiANCj4gSSB0aGluayBhIHVzZWZ1bCBmaXJzdCBzdGVwIHdv
dWxkIGJlIHRvIHVuZGVyc3RhbmQgd2hhdCBpcyBnZXR0aW5nIGluDQo+IHRoZSB3YXkgb2YgdGhl
IHNtYWxsIHJlcXVlc3RzLg0KPiDCoC0gYXJlIHRoZXkgaW4gdGhlIGNsaWVudCB3YWl0aW5nIGZv
ciBzbG90cyB3aGljaCBhcmUgYWxsIGNvbnN1bWVkIGJ5DQo+IMKgwqAgbGFyZ2Ugd3JpdGVzPw0K
PiDCoC0gYXJlIHRoZXkgaW4gVENQIHN0cmVhbSBiZWhpbmQgbWVnYWJ5dGVzIG9mIHdyaXRlcyB0
aGF0IG5lZWQgdG8gYmUNCj4gwqDCoCBjb25zdW1lZCBiZWZvcmUgdGhleSBjYW4gZXZlbiBiZSBz
ZWVuIGJ5IHRoZSBzZXJ2ZXI/DQo+IMKgLSBhcmUgdGhleSBpbiBhIHNvY2tldCBidWZmZXIgb24g
dGhlIHNlcnZlciB3YWl0aW5nIHRvIGJlIHNlcnZlZA0KPiDCoMKgIHdoaWxlIGFsbCB0aGUgbmZz
ZCB0aHJlYWQgYXJlIGJ1c3kgaGFuZGxpbmcgd3JpdGVzPw0KPiANCj4gSSBjYW5ub3Qgc2VlIGFu
IGVhc3kgd2F5IHRvIG1lYXN1cmUgd2hpY2ggaXQgaXMuDQoNClRoZSBuZnM0X3NlcXVlbmNlX2Rv
bmUgdHJhY2Vwb2ludCB3aWxsIGdpdmUgeW91IGEgcnVubmluZyBjb3VudCBvZiB0aGUNCmhpZ2hl
c3Qgc2xvdCBpZCBpbiB1c2UuDQoNClRoZSBtb3VudHN0YXRzICdleGVjdXRlIHRpbWUnIHdpbGwg
Z2l2ZSB5b3UgdGhlIHRpbWUgYmV0d2VlbiB0aGUNCnJlcXVlc3QgYmVpbmcgY3JlYXRlZCBhbmQg
dGhlIHRpbWUgYSByZXBseSB3YXMgcmVjZWl2ZWQuIFRoYXQgdGltZQ0KaW5jbHVkZXMgdGhlIHRp
bWUgc3BlbnQgd2FpdGluZyBmb3IgYSBORlN2NCBzZXNzaW9uIHNsb3QuDQoNClRoZSBtb3VudHN0
YXRzICdiYWNrbG9nIHdhaXQnIHdpbGwgdGVsbCB5b3UgdGhlIHRpbWUgc3BlbnQgd2FpdGluZyBm
b3INCmFuIFJQQyBzbG90IGFmdGVyIG9idGFpbmluZyB0aGUgTkZTdjQgc2Vzc2lvbiBzbG90Lg0K
DQpUaGUgbW91bnRzdGF0cyAnUlRUJyB3aWxsIGdpdmUgeW91IHRoZSB0aW1lIHNwZW5kIHdhaXRp
bmcgZm9yIHRoZSBSUEMNCnJlcXVlc3QgdG8gYmUgcmVjZWl2ZWQsIHByb2Nlc3NlZCBhbmQgcmVw
bGllZCB0byBieSB0aGUgc2VydmVyLg0KDQpGaW5hbGx5LCB0aGUgbW91bnRzdGF0cyBhbHNvIHRl
bGwgeW91IGF2ZXJhZ2UgcGVyLW9wIGJ5dGVzIHNlbnQvYnl0ZXMNCnJlY2VpdmVkLg0KDQpJT1c6
IFRoZSBtb3VudHN0YXRzIHJlYWxseSBnaXZlcyB5b3UgYWxtb3N0IGFsbCB0aGUgaW5mb3JtYXRp
b24geW91DQpuZWVkIGhlcmUsIHBhcnRpY3VsYXJseSBpZiB5b3UgdXNlIGl0IGluIHRoZSAnaW50
ZXJ2YWwgcmVwb3J0aW5nJyBtb2RlLg0KVGhlIG9ubHkgdGhpbmcgaXQgZG9lcyBub3QgdGVsbCB5
b3UgaXMgd2hldGhlciBvciBub3QgdGhlIE5GU3Y0IHNlc3Npb24NCnNsb3QgdGFibGUgaXMgZnVs
bCAod2hpY2ggaXMgd2h5IHlvdSB3YW50IHRoZSB0cmFjZXBvaW50KS4NCg0KPiBJIGd1ZXNzIG1v
bml0b3JpbmcgaG93IG11Y2ggb2YgdGhlIHRpbWUgdGhhdCB0aGUgY2xpZW50IGhhcyBubyBmcmVl
DQo+IHNsb3RzIG1pZ2h0IGdpdmUgaGludHMgYWJvdXQgdGhlIGZpcnN0LsKgIElmIHRoZXJlIGFy
ZSBhbHdheXMgZnJlZQ0KPiBzbG90cywNCj4gdGhlIGZpcnN0IGNhc2UgY2Fubm90IGJlIHRoZSBw
cm9ibGVtLg0KPiANCj4gV2l0aCBORlN2MywgdGhlIHNsb3QgbWFuYWdlbWVudCBoYXBwZW5lZCBh
dCB0aGUgUlBDIGxheWVyIGFuZCB0aGVyZQ0KPiB3ZXJlDQo+IHNldmVyYWwgcXVldWVzIChSUENf
UFJJT1JJVFlfTE9XL05PUk1BTC9ISUdIL1BSSVZJTEVHRUQpIHdoZXJlIHJlcXVlc3RzDQo+IGNv
dWxkIHdhaXQgZm9yIGEgZnJlZSBzbG90LsKgIFNpbmNlIHdlIGdhaW5lZCBkeW5hbWljIHNsb3Qg
YWxsb2NhdGlvbiAtDQo+IHVwIHRvIDY1NTM2IGJ5IGRlZmF1bHQgLSBJIHdvbmRlciBpZiB0aGF0
IGhhcyBtdWNoIGVmZmVjdCBhbnkgbW9yZS4NCj4gDQo+IEZvciBORlN2NC4xKyB0aGUgc2xvdCBt
YW5hZ2VtZW50IGlzIGF0IHRoZSBORlMgbGV2ZWwuwqAgVGhlIHNlcnZlciBzZXRzDQo+IGENCj4g
bWF4aW11bSB3aGljaCBkZWZhdWx0cyB0byAobWF5YmUgaXMgbGltaXRlZCB0bykgMTAyNCBieSB0
aGUgTGludXgNCj4gc2VydmVyLg0KPiBTbyB0aGVyZSBhcmUgYWx3YXlzIGZyZWUgcnBjIHNsb3Rz
Lg0KPiBUaGUgTGludXggY2xpZW50IG9ubHkgaGFzIGEgc2luZ2xlIHF1ZXVlIGZvciBlYWNoIHNs
b3QgdGFibGUsIGFuZCBJDQo+IHRoaW5rIHRoZXJlIGlzIG9uZSBzbG90IHRhYmxlIGZvciB0aGUg
Zm9yd2FyZCBjaGFubmVsIG9mIGEgc2Vzc2lvbi4NCj4gU28gaXQgc2VlbXMgd2Ugbm8gbG9uZ2Vy
IGdldCBhbnkgcHJpb3JpdHkgbWFuYWdlbWVudCAoc3luYyB3cml0ZXMgdXNlZA0KPiB0byBnZXQg
cHJpb3JpdHkgb3ZlciBhc3luYyB3cml0ZXMpLg0KPiANCj4gSW5jcmVhc2luZyB0aGUgbnVtYmVy
IG9mIHNsb3RzIGFkdmVydGlzZWQgYnkgdGhlIHNlcnZlciBtaWdodCBiZQ0KPiBpbnRlcmVzdGlu
Zy7CoCBJdCBpcyB1bmxpa2VseSB0byBmaXggYW55dGhpbmcsIGJ1dCBpdCBtaWdodCBtb3ZlIHRo
ZQ0KPiBib3R0bGUtbmVjay4NCj4gDQo+IERlY3JlYXNpbmcgdGhlIG1heGltdW0gb2YgbnVtYmVy
IG9mIHRjcCBzbG90cyBtaWdodCBhbHNvIGJlIGludGVyZXN0aW5nDQo+IChiZWxvdyB0aGUgbnVt
YmVyIG9mIE5GUyBzbG90cyBhdCBsZWFzdCkuIA0KPiBUaGF0IHdvdWxkIGFsbG93IHRoZSBSUEMg
cHJpb3JpdHkgaW5mcmFzdHJ1Y3R1cmUgdG8gd29yaywgYW5kIGlmIHRoZQ0KPiBsYXJnZS1maWxl
IHdyaXRlcyBhcmUgYXN5bmMsIHRoZXkgbWlnaHQgZ2V0cyBzbG93ZWQgZG93bi4NCj4gDQo+IElm
IHRoZSBwcm9ibGVtIGlzIGluIHRoZSBUQ1Agc3RyZWFtICh3aGljaCBpcyBwb3NzaWJsZSBpZiB0
aGUgcmVsZXZhbnQNCj4gbmV0d29yayBidWZmZXJzIGFyZSBibG9hdGVkKSwgdGhlbiB5b3UnZCBy
ZWFsbHkgbmVlZCBtdWx0aXBsZSBUQ1ANCj4gc3RyZWFtcw0KPiAod2hpY2ggY2FuIGNlcnRhaW5s
eSBpbXByb3ZlIHRocm91Z2hwdXQgaW4gc29tZSBjYXNlcykuwqAgVGhhdCBpcyB3aGF0DQo+IG5j
b25uZWN0IGdpdmUgeW91LsKgIG5jb25uZWN0IGRvZXMgbWluaW1hbCBiYWxhbmNpbmcuwqAgSXQg
Z2VuZXJhbCBpdA0KPiB3aWxsDQo+IHJvdW5kLXJvYmluLCBidXQgaWYgdGhlIG51bWJlciBvZiBy
ZXF1ZXN0cyAobm90IGJ5dGVzKSBxdWV1ZWQgb24gb25lDQo+IHNvY2tldCBpcyBiZWxvdyBhdmVy
YWdlLCB0aGF0IHNvY2tldCBpcyBsaWtlbHkgdG8gZ2V0IHRoZSBuZXh0IHJlcXVlc3QuDQoNCkl0
J3Mgbm90IHJvdW5kLXJvYmluLiBUcmFuc3BvcnRzIGFyZSBhbGxvY2F0ZWQgdG8gYSBuZXcgUlBD
IHJlcXVlc3QNCmJhc2VkIG9uIGEgbWVhc3VyZSBvZiB0aGVpciBxdWV1ZSBsZW5ndGggaW4gb3Jk
ZXIgdG8gc2tpcCBvdmVyIHRob3NlDQp0aGF0IHNob3cgc2lnbnMgb2YgYWJvdmUgYXZlcmFnZSBj
b25nZXN0aW9uLg0KDQo+IFNvIGp1c3QgYWRkaW5nIG1vcmUgY29ubmVjdGlvbnMgd2l0aCBuY29u
bmVjdCBpcyB1bmxpa2VseSB0byBoZWxwLsKgDQo+IFlvdQ0KPiB3b3VsZCBuZWVkIHRvIGFkZCBh
IHBvbGljeSBlbmdpbmUgKHN0cnVjdCBycGNfeHByX2l0ZXJfb3BzKSB3aGljaA0KPiByZXNlcnZl
cyBzb21lIGNvbm5lY3Rpb25zIGZvciBzbWFsbCByZXF1ZXN0cy7CoCBUaGF0IHNob3VsZCBiZSBm
YWlybHkNCj4gZWFzeSB0byB3cml0ZSBhIHByb29mLW9mLWNvbmNlcHQgZm9yLg0KDQpJZGVhbGx5
IHdlIHdvdWxkIHdhbnQgdG8gdGllIGludG8gY2dyb3VwcyBhcyB0aGUgY29udHJvbCBtZWNoYW5p
c20gc28NCnRoYXQgTkZTIGNhbiBiZSB0cmVhdGVkIGxpa2UgYW55IG90aGVyIEkvTyByZXNvdXJj
ZS4NCg0KPiANCj4gTmVpbEJyb3duDQo+IA0KPiANCj4gPiANCj4gPiBXb3VsZCBpdCBiZSB3b3J0
aCBleHBlcmltZW50aW5nIHdpdGggZ2l2aW5nIHNvbWUgc29ydCBvZiBhZHZhbnRhZ2UNCj4gPiB0
bw0KPiA+IHJlYWRlcnM/wqAgKEUuZy4sIHJlc2VydmluZyBhIGZldyBzbG90cyBmb3IgcmVhZHMg
YW5kIGdldGF0dHJzIGFuZA0KPiA+IHN1Y2g/KQ0KPiA+IA0KPiA+IC0tYi4NCj4gPiANCj4gPiA+
IEl0J3MgZWFzeSB0byB0ZXN0IHRoZSBjYXNlIG9mIGVudGlyZWx5IHNlcGVyYXRlIHN0YXRlICYg
dGNwDQo+ID4gPiBjb25uZWN0aW9ucy4NCj4gPiA+IA0KPiA+ID4gSWYgd2Ugd2FudCB0byB0ZXN0
IHdpdGggYSBzaGFyZWQgY29ubmVjdGlvbiBidXQgc2VwYXJhdGUgc2xvdHMgSQ0KPiA+ID4gZ3Vl
c3MNCj4gPiA+IHdlJ2QgbmVlZCB0byBjcmVhdGUgYSBzZXBhcmF0ZSBzZXNzaW9uIGZvciBlYWNo
IG5mczRfc2VydmVyLCBhbmQNCj4gPiA+IGEgbG90DQo+ID4gPiBvZiBmdW5jdGlvbnMgdGhhdCBj
dXJyZW50bHkgdGFrZSBhbiBuZnM0X2NsaWVudCB3b3VsZCBuZWVkIHRvDQo+ID4gPiB0YWtlIGFu
DQo+ID4gPiBuZnM0X3NlcnZlcj8NCj4gPiA+IA0KPiA+ID4gLS1iLg0KPiA+IA0KPiA+IA0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
