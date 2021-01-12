Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53F2F3637
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 17:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390495AbhALQye (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 11:54:34 -0500
Received: from mail-dm6nam10on2107.outbound.protection.outlook.com ([40.107.93.107]:46753
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729472AbhALQyd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 12 Jan 2021 11:54:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IimSp3kA1ebgOVsUGIZc3JarbGmOunpJ8dgvd3xLl3ei7XOA1OqEYm1EEVv2yOQ5PH3QvP9ubzvJE6CtSD9hF3JEo1sBa2bdbuYyBOjbFMXHUTqdcNgePf8NAeTmhjJZDoDf6BTb2AS+A91h2sL7KjMSwv1QVFh9L1CnGldtRQ2MW+ObZ10O4NCpv+tGgiWL085RsK7ael+hWUdiLmeDstbuOb65mHuvVV9eRcBGNoSBT39JUBCLJoG5lYNBf/a+8fdj2n4tTo9hmUDKEqqJ83aDwyeCi/vr1jiijkxzhIxHyU3Vrrxk2CbvJsx5xb1tNy9WlSekkBgurDmiCf/2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvU2i/+2zqBxRA/pLgPN+q9o+241tsj2mOMLKwhdbtM=;
 b=AkxcAjUvQSduSwCsx24L5nsl78raeG+GR5k+6V5M3aotvuI+fmV6UMHpfge/S5UrY/DmyT0JhOUCStwGZe+/7JrV4QQoWkJPJ2BhCOqfqBUNn+5h67VZMuxdphnJmWWjYSHnLR1zVFtfmD54gyH40tKo7kdNa+STnbLo2j+ciU4MklCFQ/w08f7MAikXagMTHrcmRxKoykRP0g1xM0+V46GLWDQg5WGVtYwoF1ETiS9KCsr4Ug/HyZ0SzBB95+tcBo6RTHA7LsQFeC8fXUDEkGdiarUvpa28OKc8q4rbQlj6UHYrm7BdU1F67xBgeqb4higMQK/Fht8jdEe/D5zixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvU2i/+2zqBxRA/pLgPN+q9o+241tsj2mOMLKwhdbtM=;
 b=ctZZdIBwA7HLY0VLzJ4DnDPn0dXTwzmoKfPibZ19p6lWoANBeI0Eer2RPsRiXy+BVZp+w2nRDpYkHpHyASe7cDx9jlhCQABY3Zxyv/wMZjtCK+jYqDEqe/vlj+Ut96rTACSaCkSbOrnh4xYpawxu9SCAtWx0e6PhdaNqmcQY02I=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3797.namprd13.prod.outlook.com (2603:10b6:610:99::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.6; Tue, 12 Jan
 2021 16:53:41 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc%6]) with mapi id 15.20.3763.009; Tue, 12 Jan 2021
 16:53:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>
CC:     "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: nfsd vurlerability submit
Thread-Topic: nfsd vurlerability submit
Thread-Index: AQHW6PgWrSMkggXjGU6epPPdOSc+z6okNQOA
Date:   Tue, 12 Jan 2021 16:53:40 +0000
Message-ID: <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
References: <CAHxDmpTKJfnhGY9CVupyVYhNCTDVKBB6KRwh-E6u_XEPJq4WJQ@mail.gmail.com>
         <20210105165633.GC14893@fieldses.org> <X/hEB8awvGyMKi6x@kroah.com>
         <20210108152017.GA4183@fieldses.org> <20210108152607.GA950@1wt.eu>
         <20210108153237.GB4183@fieldses.org> <20210108154230.GB950@1wt.eu>
         <20210111193655.GC2600@fieldses.org>
         <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
         <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
         <20210112153208.GF9248@fieldses.org>
In-Reply-To: <20210112153208.GF9248@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f56a99f-5fe7-413d-33f3-08d8b71a9d68
x-ms-traffictypediagnostic: CH2PR13MB3797:
x-microsoft-antispam-prvs: <CH2PR13MB379786BFAAB722405917D1CDB8AA0@CH2PR13MB3797.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpDZ++NcDGdM+7465I20QRR54gmajgrOtjYmwGucaWsxjMlqNCsN+wLovz3P1A88zNjsJliA5DsrjQ6N0WWl2EqeVdgQ9sxS11VLxSn6ezIBZLddUR2mGgr1TBAKIfBCszb/t7VcRfu+wgAg5b8kmeXjdtJdAz31qqu6pEB6m1At6/XcQYWc4H7T7s1OC9h+tum22v3saL9eiXJCH9kHyG7OrJY//WTNeWKeZFpjqQd8SmjxrcnxS2zS5Ad3zIe0EGeyQbiUvX6/GDFOSu14XDOOxO4ogd3cq5R7o7el8bEBuaVukhJRWcRs/BdeGMidbFyrNx9xxecQUYxbSa5oLDspbeX0NP34hCOGpNYdpaw27eRTTUIbfs1onr/YFGacT8He/MQGawrp0z96fp7HiktTi44053kS+/mJukqjviWh3hDijHT4IRrIMw+O/jwuzM7ha06dgPTRHq6au1zhbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(376002)(39830400003)(26005)(186003)(3480700007)(5660300002)(71200400001)(36756003)(4326008)(316002)(6512007)(6506007)(64756008)(66476007)(76116006)(54906003)(66446008)(66556008)(2616005)(66946007)(7116003)(83380400001)(110136005)(86362001)(8676002)(2906002)(478600001)(966005)(6486002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QlpIcENSbkRlUWtsYjdXaTB3M0Fmd2RjT1dBRGc1QW1uVVZWVTNlRk5kNXVR?=
 =?utf-8?B?bGVZZW9ybXJ6TGxNMkpqM2RDakM0ajBUVFJKSXp6WVExVnFvUDFRK2MySHBK?=
 =?utf-8?B?Z2RCQWZKMDc3Q0xaaGE4SVBwS1BJR0NTOGx6aStiQjUvL0kxdlZROUFKbnFh?=
 =?utf-8?B?ejhibWRkQUhwMzRGK1V6UXNaMUdJOFZSMnYrdzNLaFdFbTY0MnlET2J5eXNH?=
 =?utf-8?B?OEpVQUVlajk0ZXZEUG1NcWdpa0lKc3ZUczc3eU9sVTdQSXhMbTdjcWxOUldB?=
 =?utf-8?B?dW9Hb242ZmFpQnF4SC9KYk9xOFVzY3lHZ1RlTVljdXQ3ZlBaUG9ieHp4eFpv?=
 =?utf-8?B?dW9XNUc1UE4xOUZ2RzY3K0RadXVQc1BTTG5PMnZDTmZ5UWlmTEltQmJ5L1M3?=
 =?utf-8?B?aVg3TjZWb2RpVEJDT0c2bUdZVnNVaWpkNXZ3WVg2Y0RnRnlQVXBmak1GL2pW?=
 =?utf-8?B?aHdrL1RaR3R5MzZQS1RvN2NRYVUzRjFhR1YxK1NIRW5adm1MYkZmeXNGNjRD?=
 =?utf-8?B?S2o5cEJlbzJ4VllEbUx2eXIzdkhjRG1HdEdyN0JOUXZ0ZVZ2d04rZDczSTVI?=
 =?utf-8?B?TTVmRU1FTVlsUHg4WE9wcHBkcG03WmZuZUpSazVsWmcvQVlDNGRqY1llOG1i?=
 =?utf-8?B?cklsVjNWYWZ0b3ErSzBBODZybVQzVGl5RHZNMXFZcnlmMzBWTHJjUTcxelNE?=
 =?utf-8?B?TktkNEJuVnVSRm1SbHdldEE1REF6UDlwbjFUejZmMVYrRnRyUTdpa1R2amRS?=
 =?utf-8?B?dlV1eGJxaWxFRHM5NzQ1L1RaSHpTSVovejdhc0o5ck9wQkJEZDB2dmE5VVBn?=
 =?utf-8?B?R3ROTlh0NnRuZ1ZIYlNYRUlRY1ZlREp1dE41YWNHaVpBK1B6NSs2WjdZY2xQ?=
 =?utf-8?B?UWI2R2tIYVhsUXFSN0V6S2NscktseTVsaU9KMXlPN05IUHczbUUweW5aVlpH?=
 =?utf-8?B?NXJKeWtyMFVCNy9nOUZ5UmlWQVZMa2EyZnZva2lDdXFRbzZ4WTVscE9sd09M?=
 =?utf-8?B?OFJZTjkvaFlVazY0RWovMjVaYW1wajQ2SG5aNmZvb3IycFdrSFdXTmhNOWNI?=
 =?utf-8?B?U3pUeU5mbFNHSFNDMjg0cGt1VEJkZm5vYWJ0ZEp0cDdhOHh0VTNyUVY2LzJX?=
 =?utf-8?B?bE9mUGkyZ1Q1Nm1oeU9ycFdYTCtRRzhzL2x5TXN2M0FvVkFERXhQNFUreEVh?=
 =?utf-8?B?Ym5GMkFRWURFdjkvZitoSml4dGhjS0VERFRjQzEyaXZjTmlFdEYrY01NRGVY?=
 =?utf-8?B?WEdnd0FMRy9TRkpkV1B2d0JybytKREt0eEdoM0dTdUphdTdhaU9vT1ZRSjZX?=
 =?utf-8?Q?Miaba1Fb7fb1eivOW66dFZlOX657OksAgq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A6BE38AEEEB5047B4DAB7A38EA0C9E9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f56a99f-5fe7-413d-33f3-08d8b71a9d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 16:53:41.0120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuhlWgYft8VuRcvOXvwfZxEV4ZvI4aicVkC6w1TERC7XgVE2R6FlLQcaIssnlROcUtwp6Y/LGucF06IOc+mWDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3797
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTEyIGF0IDEwOjMyIC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgSmFuIDEyLCAyMDIxIGF0IDEwOjQ4OjAwUE0gKzA4MDAsIOWQtOW8giB3cm90
ZToNCj4gPiBUZWxsaW5nIHVzZXJzIGhvdyB0byBjb25maWd1cmUgdGhlIGV4cG9ydGVkIGZpbGUg
c3lzdGVtIGluIHRoZSBtb3N0DQo+ID4gc2VjdXJlDQo+ID4gd2F5IGRvZXMNCj4gPiBtaXRpZ2F0
ZSB0aGUgcHJvYmxlbSB0byBzb21lIGV4dGVudCwgYnV0IHRoaXMgZG9lcyBub3Qgc2VlbSB0bw0K
PiA+IGFkZHJlc3MgdGhlDQo+ID4gc2VjdXJpdHkgcmlza3MgcG9zZWQgYnkgbm9fIHN1YnRyZWVf
IGNoZWNrIGluIHRoZSBjb2RlLiBJbiBteQ0KPiA+IG9waW5pb24sd2hlbg0KPiA+IHRoZSBnZW5l
cmF0ZWQgZmlsZWhhbmRsZSBkb2VzIG5vdCBjb250YWluIHRoZSBpbm9kZSBpbmZvcm1hdGlvbiBv
Zg0KPiA+IHRoZQ0KPiA+IHBhcmVudCBkaXJlY3RvcnksdGhlIG5mc2RfYWNjZXB0YWJsZSBmdW5j
dGlvbiBjYW4gYWxzbyByZWN1cnNpdmVseQ0KPiA+IGRldGVybWluZSB3aGV0aGVyIHRoZSByZXF1
ZXN0IGZpbGUgZXhjZWVkcyB0aGUgZXhwb3J0IHBhdGgNCj4gPiBkZW50cnkuRW5hYmxpbmcNCj4g
PiBzdWJ0cmVlX2NoZWNrIHRvIGFkZCBwYXJlbnQgZGlyZWN0b3J5IGluZm9ybWF0aW9uIG9ubHkg
YnJpbmdzIHNvbWUNCj4gPiB0cm91Ymxlcy4NCj4gDQo+IEZpbGVzeXN0ZW1zIGRvbid0IG5lY2Vz
c2FyaWx5IHByb3ZpZGUgdXMgd2l0aCBhbiBlZmZpY2llbnQgd2F5IHRvDQo+IGZpbmQNCj4gcGFy
ZW50IGRpcmVjdG9yaWVzIGZyb20gYW55IGdpdmVuIGZpbGUuwqAgKEFuZCBub3RlIGEgc2luZ2xl
IGZpbGUgbWF5DQo+IGhhdmUgbXVsdGlwbGUgcGFyZW50IGRpcmVjdG9yaWVzLikNCj4gDQo+IChJ
IGRvIHdvbmRlciBpZiB3ZSBjb3VsZCBkbyBiZXR0ZXIgaW4gdGhlIGRpcmVjdG9yeSBjYXNlLCB0
aG91Z2guwqAgV2UNCj4gYWxyZWFkeSByZWNvbm5lY3QgZGlyZWN0b3JpZXMgYWxsIHRoZSB3YXkg
YmFjayB1cCB0byB0aGUgcm9vdC4pDQo+IA0KPiA+IEkgaGF2ZSBhIGJvbGQgaWRlYSwgd2h5IG5v
dCBkaXJlY3RseSByZW1vdmUgdGhlIGZpbGUgaGFuZGxlDQo+ID4gbW9kaWZpY2F0aW9uIGluDQo+
ID4gc3VidHJlZV9jaGVjaywgYW5kIHRoZW4gbm9ybWFsaXplIHRoZSBqdWRnbWVudCBvZiB3aGV0
aGVyIGRlbnRyeQ0KPiA+IGV4Y2VlZHMNCj4gPiB0aGUgZXhwb3J0IHBvaW50IGRpcmVjdG9yeSBp
biBuZnNkX2FjY2VwdGFibGUgKGxpbmUgMzggdG8gNTQgaW4NCj4gPiAvZnMvbmZzZC9uZnNmaC5j
KSAuDQo+ID4gDQo+ID4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCBpdCwgdGhlIHJlYXNvbiB3aHkg
c3VidHJlZV9jaGVjayBpcyBub3QNCj4gPiB0dXJuZWQgb24gYnkNCj4gPiBkZWZhdWx0IGlzIHRo
YXQgaXQgd2lsbCBjYXVzZSBwcm9ibGVtcyB3aGVuIHJlYWRpbmcgYW5kIHdyaXRpbmcNCj4gPiBm
aWxlcywNCj4gPiByYXRoZXIgdGhhbiBpdCB3YXN0ZXMgbW9yZSB0aW1lIHdoZW4gbmZzZF9hY2Nl
cHRhYmxlLg0KPiA+IA0KPiA+IEluIHNob3J0LEkgdGhpbmsgaXQncyBvcGVuIHRvIHF1ZXN0aW9u
IHdoZXRoZXIgdGhlIHNlY3VyaXR5IG9mIHRoZQ0KPiA+IHN5c3RlbQ0KPiA+IGRlcGVuZHMgb24g
dGhlIHVzZXIncyBjb21wbGV0ZSBjb3JyZWN0IGNvbmZpZ3VyYXRpb24odGhlIHN5c3RlbQ0KPiA+
IGRvZXMgbm90DQo+ID4gcHJvaGliaXQgdGhlIGV4cG9ydCBvZiBhIHN1YmRpcmVjdG9yeSkuDQo+
IA0KPiA+IEVuYWJsaW5nIHN1YnRyZWVfY2hlY2sgdG8gYWRkIHBhcmVudCBkaXJlY3RvcnlpbmZv
cm1hdGlvbiBvbmx5DQo+ID4gYnJpbmdzDQo+ID4gc29tZSB0cm91Ymxlcy4NCj4gPiANCj4gPiBJ
biBzaG9ydCxJIHRoaW5rIGl0J3Mgb3BlbiB0byBxdWVzdGlvbiB3aGV0aGVyIHRoZSBzZWN1cml0
eSBvZiB0aGUNCj4gPiBzeXN0ZW0gZGVwZW5kcyBvbiB0aGUgdXNlcidzIGNvbXBsZXRlIGNvcnJl
Y3QgY29uZmlndXJhdGlvbih0aGUNCj4gPiBzeXN0ZW0NCj4gPiBkb2VzIG5vdCBwcm9oaWJpdCB0
aGUgZXhwb3J0IG9mIGEgc3ViZGlyZWN0b3J5KS4NCj4gDQo+IEknZCBsb3ZlIHRvIHJlcGxhY2Ug
dGhlIGV4cG9ydCBpbnRlcmZhY2UgYnkgb25lIHRoYXQgcHJvaGliaXRlZA0KPiBzdWJkaXJlY3Rv
cnkgZXhwb3J0cyAob3IgYXQgbGVhc3QgbWFkZSBpdCBtb3JlIG9idmlvdXMgd2hlcmUgdGhleSdy
ZQ0KPiBiZWluZyB1c2VkLikNCj4gDQo+IEJ1dCBnaXZlbiB0aGUgaW50ZXJmYWNlIHdlIGFscmVh
ZHkgaGF2ZSwgdGhhdCB3b3VsZCBiZSBhIGRpc3J1cHRpdmUNCj4gYW5kDQo+IHRpbWUtY29uc3Vt
aW5nIGNoYW5nZS4NCj4gDQo+IEFub3RoZXIgYXBwcm9hY2ggaXMgdG8gYWRkIG1vcmUgZW50cm9w
eSB0byBmaWxlaGFuZGxlcyBzbyB0aGV5J3JlDQo+IGhhcmRlcg0KPiB0byBndWVzczsgc2VlIGUu
Zy46DQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgaHR0cHM6Ly93d3cuZnNsLmNzLnN0b255YnJvb2su
ZWR1L2RvY3MvbmZzY3JhY2stdHIvaW5kZXguaHRtbA0KPiANCj4gSW4gdGhlIGVuZCBub25lIG9m
IHRoZXNlIGNoYW5nZSB0aGUgZmFjdCB0aGF0IGEgZmlsZWhhbmRsZSBoYXMgYW4NCj4gaW5maW5p
dGUgbGlmZXRpbWUsIHNvIG9uY2UgaXQncyBsZWFrZWQsIHRoZXJlJ3Mgbm90aGluZyB5b3UgY2Fu
IGRvLsKgDQo+IFRoZQ0KPiBhdXRob3JzIHN1Z2dlc3QgTkZTdjQgdm9sYXRpbGUgZmlsZWhhbmRs
ZXMgYXMgYSBzb2x1dGlvbiB0byB0aGF0DQo+IHByb2JsZW0sIGJ1dCBJIGRvbid0IHRoaW5rIHRo
ZXkndmUgdGhvdWdodCB0aHJvdWdoIHRoZSBvYnN0YWNsZXMgdG8NCj4gbWFraW5nIHZvbGF0aWxl
IGZpbGVoYW5kbGVzIHdvcmsuDQo+IA0KPiAtLWIuDQoNClRoZSBwb2ludCBpcyB0aGF0IHRoZXJl
IGlzIG5vIGdvb2Qgc29sdXRpb24gdG8gdGhlICdJIHdhbnQgdG8gZXhwb3J0IGENCnN1YnRyZWUg
b2YgYSBmaWxlc3lzdGVtJyBwcm9ibGVtLCBhbmQgc28gaXQgaXMgcGxhaW5seSB3cm9uZyB0byB0
cnkgdG8NCm1ha2UgYSBkZWZhdWx0IG9mIHRob3NlIHNvbHV0aW9ucywgd2hpY2ggYnJlYWsgdGhl
IG9uZSBzYW5lIGNhc2Ugb2YNCmV4cG9ydGluZyB0aGUgd2hvbGUgZmlsZXN5c3RlbS4NCg0KSnVz
dCBhIHJlbWluZGVyIHRoYXQgd2Uga2lja2VkIG91dCBzdWJ0cmVlX2NoZWNrIG5vdCBvbmx5IGJl
Y2F1c2UgYQ0KdHJpdmlhbCByZW5hbWUgb2YgYSBmaWxlIGJyZWFrcyB0aGUgY2xpZW50J3MgYWJp
bGl0eSB0byBwZXJmb3JtIEkvTyBieQ0KaW52YWxpZGF0aW5nIHRoZSBmaWxlaGFuZGxlLiBJbiBh
ZGRpdGlvbiwgdGhhdCBvcHRpb24gY2F1c2VzIGZpbGVoYW5kbGUNCmFsaWFzaW5nIChpLmUuIG11
bHRpcGxlIGZpbGVoYW5kbGVzIHBvaW50aW5nIHRvIHRoZSBzYW1lIGZpbGUpIHdoaWNoIGlzDQph
IG1ham9yIFBJVEEgZm9yIGNsaWVudHMgdG8gdHJ5IHRvIG1hbmFnZSBmb3IgbW9yZSBvciBsZXNz
IHRoZSBzYW1lDQpyZWFzb24gdGhhdCBpdCBpcyBhIG1ham9yIFBJVEEgdG8gdHJ5IHRvIG1hbmFn
ZSB0aGVzZSBmaWxlcyB1c2luZw0KcGF0aHMuDQoNClRoZSBkaXNjdXNzaW9uIG9uIHZvbGF0aWxl
IGZpbGVoYW5kbGVzIGluIFJGQzU2NjEgZG9lcyB0cnkgdG8gYWRkcmVzcw0Kc29tZSBvZiB0aGUg
YWJvdmUgaXNzdWVzLCBidXQgZW5kcyB1cCBjb25jbHVkaW5nIHRoYXQgeW91IG5lZWQgdG8NCmlu
dHJvZHVjZSBQT1NJWC1pbmNvbXBhdGlibGUgcmVzdHJpY3Rpb25zLCBzdWNoIGFzIHRyeWluZyB0
byBiYW4NCnJlbmFtZXMgYW5kIGRlbGV0aW9ucyBvZiBvcGVuIGZpbGVzIGluIG9yZGVyIHRvIG1h
a2UgaXQgd29yay4NCg0KTm9uZSBvZiB0aGVzZSBjb21wcm9taXNlcyBhcmUgbmVjZXNzYXJ5IGlm
IHlvdSBleHBvcnQgYSB3aG9sZQ0KZmlsZXN5c3RlbSAob3IgYSBoaWVyYXJjaHkgb2Ygd2hvbGUg
ZmlsZXN5c3RlbXMpLiBUaGF0J3MgdGhlIHNhbmUgY2FzZS4NClRoYXQncyB0aGUgb25lIHRoYXQg
cGVvcGxlIHNob3VsZCBkZWZhdWx0IHRvIHVzaW5nLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
