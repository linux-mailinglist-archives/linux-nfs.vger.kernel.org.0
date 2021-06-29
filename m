Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37FF3B76E5
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhF2RHo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 13:07:44 -0400
Received: from mail-dm6nam12on2099.outbound.protection.outlook.com ([40.107.243.99]:45280
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232422AbhF2RHn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 29 Jun 2021 13:07:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7yzycYYTjKzLBcZmLVTFlz6yX4qwEV4b6z0PUcMW3TWIs16JTrARD665SyB+1g4h92aJyXAiNCItRu9yE954kfwc0Gm6VFnBDucfm9KiMDAsemcyBn5xPVZ6X2UIERVksomMVGR7iMJokzsYEERaxfRgmrjDTEfmCblasZ3ltX4xkIVppbPfzAAYQPZy5plH+IP+AGExQGzadSbqudx1+dEU069Aw9Eykp9OGkSJNYbZVCFHSn+RVDmhGEMdeC+bkvfyPv01IVs4Z5sZX4E17fInSN5zYLqKOyJs7hIIFP/8RrTbsS6G3RyZxg+93wKtGXcREx6AW42vrVkh6gKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UkwsQfGIqGGDLqnTz5aSqwxD5RZACoZgg7e/KdXCUU=;
 b=LrVtcfJYbaZcODNzvUrFgb0n8uFZ7Tkltj5AqKyJLeHws0g7YfXCXLdW2Wp9RIZutp0B1shYIPvm+/BWrHikeMkcvfIaet6akAtzbQ+aKga3urgykeQHm21qMG2KgACT1HuTmM+lyC5pBg6Lfe+cve/9XiU/rCH7hs0ITJTYPDp0KvXmeqIbZJq/a9sgA/VQrzjNyAsXaaaBnvGrDcbg7gPOU956d3HNr8G5YSQeGAYjiDMHzh9+VGZg0QoQTjDwShoOWxGB6F1J52HbupKDtxtPYh898z6aIwUM7j0h3UW81uC6WN1vHZo+N+JuduLR6kckNpRv2sASs20pUFHO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UkwsQfGIqGGDLqnTz5aSqwxD5RZACoZgg7e/KdXCUU=;
 b=A7RaRu7oCWtc4oXZi2hksjn9No7l18Ux7uNZmzdbpCeJSFWuKCIIC4E40/N5L6VKsblAC3asgup0EEDYDTO0fczs7eIxMkuIbl+FXHjZGnqLvjfIvh5VMwweN2TDbkLMHv/2q3GZ+n4DbDpqyYfmnvwtA78RzeW2r3oOVuDgKaw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4667.namprd13.prod.outlook.com (2603:10b6:610:d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Tue, 29 Jun
 2021 17:05:11 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4287.022; Tue, 29 Jun 2021
 17:05:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: client's caching of server-side capabilities
Thread-Topic: client's caching of server-side capabilities
Thread-Index: AQHXbFuMjtq3PRTcuEmeUcYpGr/LhKsp+uuAgAEFY4CAACowgIAADp+A
Date:   Tue, 29 Jun 2021 17:05:10 +0000
Message-ID: <32261d1738804120aa74d2953e4ebd3e3f28103b.camel@hammerspace.com>
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
         <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
         <CAN-5tyHTavHRmQKGhUmBvngMwAAK2pr89zBuppK_s27HduJfqQ@mail.gmail.com>
         <CAN-5tyHu3BQaCEvwewNEJnwJTiD9oLmYTUKchciP+1HP8v909Q@mail.gmail.com>
In-Reply-To: <CAN-5tyHu3BQaCEvwewNEJnwJTiD9oLmYTUKchciP+1HP8v909Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3dbc6e6-89af-4486-68dc-08d93b200e23
x-ms-traffictypediagnostic: CH0PR13MB4667:
x-microsoft-antispam-prvs: <CH0PR13MB466734487FE94EEB1635DA69B8029@CH0PR13MB4667.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HOcxhguYdbPXnWDFXPGrPF378cd2zRFUvVHc1Agfr0SzUT01RHgs+QqKGnT93eFOYGCW7x1iGVuwX94IHia6NOKHGPuA7ydKgRaM7H+JRNgVUuDX58XnSCrHn9yfBkMalv+oil9iL1Zk3PrVWSiQD9oFkYi8lVeSXQW2gBli2NeBupFkHKQKf9VtDFBWBBWiCxC2sJLFGUjWom4ge1zKeMcEnUTwhSev/ZYUupx9z32PVvvROQBfcofZCRjQGXGFHT7ljEW2saQ1loXp3oe0t5yUE+DSjTYYNWBfh2+EhHzxd300o8wRzHIF6Jan2TCeJABbY5sIyYxzn9PnW8PmYUF16togp4AUH+t3im7NN43C7Ho9NR/4PHO2aS+EHxOIlgAzHMWaE55zo85ebwL4ZygtBklyqbyhPSot8HIx9g/h8TzgcA8eJOGaE/lTvMuviYZ9GjFHdosP1duVMt0IYivFV265Yntf2Il6yBfk8OYktVXGHEFbH3WOlgp3J2fBZL2wFPhWwDoU3Tiar6md6vswtqD1UpYiHnB/H2+YbZRnmrVuMM2UKkHrbcSMO8tLmRJSNFx8uaM7eRB67baJAFNKeDy/z2x/yZigHXj75ns3+XL1YfeWTJqmeRH1iL6HgpwYE9kipB23Sc/4Cd/guA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39830400003)(396003)(346002)(316002)(6512007)(83380400001)(6486002)(478600001)(66556008)(66446008)(66476007)(53546011)(36756003)(6916009)(64756008)(66946007)(76116006)(26005)(2906002)(2616005)(6506007)(186003)(5660300002)(8676002)(4326008)(86362001)(38100700002)(8936002)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmRwRWdrc0NRdkszRURzcnpIZDdkMmJoMVc2dTRlajUwejF5WDRkVUE0WXll?=
 =?utf-8?B?TC9GSGVodXZyZVQ1TFFVb29iMzA5dWM4YXpYcVdReFBTQk5kVklUbk5laEJn?=
 =?utf-8?B?RDJia2U3Qm53YWtZMXo3ZmZKUTlmZEU1ODRnQlpHTXFoUEpsS2VOWkd3TVd2?=
 =?utf-8?B?ZUdGNkZWa08rbWxEckVzYmVxQ0gxdFJjbEVBTVBEN01aRGZ6MXNkdWZDN1VQ?=
 =?utf-8?B?Rkg0cVBaYkpKV2JhNmZiU0F4M1I2MUg2dmFHNWhkUEx2Ly93L3psQ3JsU0Jw?=
 =?utf-8?B?V2t5b2tQRXZjRmtTSk1OZmRYakhwL2toaVE1WEtQa1FCaUordHRJTTFkajZt?=
 =?utf-8?B?eXc3aTFKOXRoUWtRajBwSnlobmUyVUFyQ0VuYmdBQ0N6UWo2U3ZFM0Nub0Fy?=
 =?utf-8?B?djRVTUNxaVN1Q040VldRTFVxcnZaWml5a0ZUODAxZkk3VEMxN2lMWmMwK0pT?=
 =?utf-8?B?M29lbW9LMEI3YVc1S2RPQnhMazJTWWVpa214RWo3YkJGTktjeW82SUpiYk80?=
 =?utf-8?B?MGkvbnlBS1EyamYrN3Z4STR3cklJeXBMVzVkZ1UrUVo4YTdkcCtUNE5TNVZD?=
 =?utf-8?B?Ny8rcFpvZ281WG9xK2FNQUNVc3R4blBGZ0RaRytTK3BrWGMxTDBrd0xyZmxR?=
 =?utf-8?B?WGZuM0hRYW91ZUl4VElGWVVyWGI2d0E3YXZtb3lNS1o3UHlBenkwVUR6YllL?=
 =?utf-8?B?Zm9yeFNpbFVwRTFwbjIxTWx3Nll0OGlUTXV0L3h2NnRTa2JqSno0Sm1VMUVk?=
 =?utf-8?B?akFSMDVjaGJQYjROK1FwOTlROS9IVStEOVRUbDNOdmZTL25IVTF1U2FIcm1B?=
 =?utf-8?B?K3BpTm95WldLblJDZENnM1JUTC9qOVYrd0YxY3RPZlV4Z3BjeGtDL2NjSTFS?=
 =?utf-8?B?ZTVQZlBNT0lUQ0NLdlBCdEU2L25jVzJva1ZGTTBpUDRLMDFPdjJpK1lvRmJH?=
 =?utf-8?B?NnhrSk1xVzBsd0VUd1ViamlXTiswQy93Um5DUUhTNjlBSUlGdVlrVnhKRW40?=
 =?utf-8?B?R09Nd0N6bmdMYzJCMzVuUW4yczFHM0xyY1RLYWtxc0M0YndqVUR1OUVzdTIx?=
 =?utf-8?B?UlFBV1YyWU5qTG5rV0ZaTGYwYTU2dkZNclRYSEMvRUVLTjR3anBGb2xCK1Nx?=
 =?utf-8?B?dFI3QTJSTkZTcGxFNWVaWjlsRXFoZG0wcVdOTU80aGhRV0JXbGZBb2NzOWwr?=
 =?utf-8?B?alJlRkJHdmp0bHExLzdsS0VsOEhWSnN4Q0huNC81eG1ydzh6R1pXRHExbUlt?=
 =?utf-8?B?NndTNk5qMi9VMFo0WjNlTnF2dmdYbmNBNXNaeldVS1BMV1ZJL044UkcvS3Zt?=
 =?utf-8?B?MlRVR2Y5dEY3dUIwTHY2bmEvRzVIalRYVlRPZzMxRjQ1L0hPTitJK3AyUzRx?=
 =?utf-8?B?ajQ5T0hFN1NjMDgyRGJxMnhUL0lacGI4MDlWTVQ5VWFmRGFQQVU2dnI5akVw?=
 =?utf-8?B?SWQyVWszWGRmWGNMVFdsazc0UFJ5aVF0R1V4YmM3ZXBxZG80QnBWcmZVeExl?=
 =?utf-8?B?KzVpUVYwV2ltSVpoaExjRG1CMHJEc25XUS9La2VRSVlkayt0NEMyakZ3ZDFm?=
 =?utf-8?B?NzhHczlRelE1b1BKNUl0VG56eUZweEk2TDQ1elV5ZlRqMUlqbzc3RGNGaDh6?=
 =?utf-8?B?OTBuTVFoVGVHR0lFaXNMSDVMWi9SQmVZeGliY1huUDgraldpbGRQc1ZUUisx?=
 =?utf-8?B?em5rQkZmc3liei9hRnNmN1o3bEF5MFdZVW51S2VHTTJBYnBYRTZqWDRaOGNZ?=
 =?utf-8?B?QUpXdURmYzFtMVZLRzk2NHhSeHR0TGFPS3lJYUxMU0krTzN0OFVJRVlXMDNp?=
 =?utf-8?B?VHZXUzlVWUdOMFdXMWQ0UT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F5DBC71B492DF45AA5E0FCFA783E243@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dbc6e6-89af-4486-68dc-08d93b200e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 17:05:10.9908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W69WaAZkBQCNfUU2kCsBMDkfrVsDV7PVAeJx/IJAaYmPB6lupFvsN0BVB+da5odAmkEKuzwDE3dgJQTsCrh9TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4667
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTI5IGF0IDEyOjEyIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBKdW4gMjksIDIwMjEgYXQgOTo0MSBBTSBPbGdhIEtvcm5pZXZza2FpYSA8
YWdsb0B1bWljaC5lZHU+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgSnVuIDI4LCAyMDIx
IGF0IDY6MDYgUE0gVHJvbmQgTXlrbGVidXN0DQo+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29t
PiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gTW9uLCAyMDIxLTA2LTI4IGF0IDE2OjIzIC0wNDAw
LCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+ID4gSGkgZm9sa3MsDQo+ID4gPiA+IA0K
PiA+ID4gPiBJIGhhdmUgYSBnZW5lcmFsIHF1ZXN0aW9uIG9mIHdoeSB0aGUgY2xpZW50IGRvZXNu
J3QgdGhyb3cgYXdheQ0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gY2FjaGVkIHNlcnZlcidzIGNhcGFi
aWxpdGllcyBvbiBzZXJ2ZXIgcmVib290LiBTYXkgYSBjbGllbnQNCj4gPiA+ID4gbW91bnRlZCBh
DQo+ID4gPiA+IHNlcnZlciB3aGVuIHRoZSBzZXJ2ZXIgZGlkbid0IHN1cHBvcnQgc2VjdXJpdHlf
bGFiZWxzLCB0aGVuIHRoZQ0KPiA+ID4gPiBzZXJ2ZXINCj4gPiA+ID4gd2FzIHJlYm9vdGVkIGFu
ZCBzdXBwb3J0IHdhcyBlbmFibGVkLiBDbGllbnQgcmUtZXN0YWJsaXNoZXMgaXRzDQo+ID4gPiA+
IGNsaWVudGlkL3Nlc3Npb24sIHJlY292ZXJzIHN0YXRlLCBidXQgYXNzdW1lcyBhbGwgdGhlIG9s
ZA0KPiA+ID4gPiBjYXBhYmlsaXRpZXMNCj4gPiA+ID4gYXBwbHkuIEEgcmVtb3VudCBpcyByZXF1
aXJlZCB0byBjbGVhciBvbGQvZmluZCBuZXcNCj4gPiA+ID4gY2FwYWJpbGl0aWVzLiBUaGUNCj4g
PiA+ID4gb3Bwb3NpdGUgaXMgdHJ1ZSB0aGF0IGEgY2FwYWJpbGl0eSBjb3VsZCBiZSByZW1vdmVk
IChidXQgSSdtDQo+ID4gPiA+IGFzc3VtaW5nDQo+ID4gPiA+IHRoYXQncyBhIGxlc3MgcHJhY3Rp
Y2FsIGV4YW1wbGUpLg0KPiA+ID4gPiANCj4gPiA+ID4gSSdtIGN1cmlvdXMgd2hhdCBhcmUgdGhl
IHByb2JsZW1zIG9mIGNsZWFyaW5nIHNlcnZlcg0KPiA+ID4gPiBjYXBhYmlsaXRpZXMgYW5kDQo+
ID4gPiA+IHJlZGlzY292ZXJpbmcgdGhlbSBvbiByZWJvb3Q/IElzIGl0IGJlY2F1c2UgYSBsb2Nh
bCBmaWxlc3lzdGVtDQo+ID4gPiA+IGNvdWxkDQo+ID4gPiA+IG5ldmVyIGhhdmUgaXRzIGF0dHJp
YnV0ZXMgY2hhbmdlZCBhbmQgdGh1cyBhIG5ldHdvcmsgZmlsZQ0KPiA+ID4gPiBzeXN0ZW0NCj4g
PiA+ID4gY2FuJ3QNCj4gPiA+ID4gZWl0aGVyPw0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmsgeW91
Lg0KPiA+ID4gDQo+ID4gPiBJbiBteSBvcGluaW9uLCB0aGUgY2xpZW50IHNob3VsZCBhaW0gZm9y
IHRoZSBhYnNvbHV0ZSBtaW5pbXVtDQo+ID4gPiBvdmVyaGVhZA0KPiA+ID4gb24gYSBzZXJ2ZXIg
cmVib290LiBUaGUgZ29hbCBzaG91bGQgYmUgdG8gcmVjb3ZlciBzdGF0ZSBhbmQgZ2V0DQo+ID4g
PiBJL08NCj4gPiA+IHN0YXJ0ZWQgYWdhaW4gYXMgcXVpY2tseSBhcyBwb3NzaWJsZS4gRGV0ZWN0
aW9uIG9mIG5ldyBmZWF0dXJlcywNCj4gPiA+IGV0Yw0KPiA+ID4gY2FuIHdhaXQgdW50aWwgdGhl
IGNsaWVudCBuZWVkcyB0byByZXN0YXJ0Lg0KPiA+IA0KPiA+IERvIEkgaW50ZXJwcmV0IHRoaXMg
Y29ycmVjdGx5OiBubyBjYXBhYmlsaXR5IGRpc2NvdmVyaWVzIGJlZm9yZQ0KPiA+IFJFQ0xBSU1f
Q09NUExFVEUgYnV0IHBlcmhhcHMgYWZ0ZXI/IEkgYWdyZWUgdGhhdCByZWJvb3QgcmVjb3ZlcnkN
Cj4gPiBzaG91bGQgYmUgZG9uZSBhcyBxdWlja2x5IGFzIHBvc3NpYmxlLiBJZiBpdCdzIHNvbWUg
dGltZSBhZnRlciwNCj4gPiB0aGVuDQo+ID4gcGVyaGFwcyBpdCBjYW4gYmUgZG9uZSBvbi1kZW1h
bmQgdGhydSBzYXkgbmZzIHN5c2ZzIGFwaTogaGF2ZQ0KPiA+IGFiaWxpdHkNCj4gPiB0byBjbGVh
ciBjdXJyZW50IGNhcGFiaWxpdGllcyAob3IgYSBzcGVjaWZpYyBvbmUpIGFuZCBkbyBkaXNjb3Zl
cg0KPiA+IG5ldw0KPiA+IG9uZXM/DQo+ID4gDQo+ID4gVGhlIHVzZSBjYXNlIEknbSBnb2luZyBm
b3IgaXMgd2hlbiBhIHNlcnZlciB1cGdyYWRlcyBhbmQgY29tZXMgdXANCj4gPiB3aXRoDQo+ID4g
c3VwcG9ydCBmb3IgbmV3IGZlYXR1cmVzLiBDdXJyZW50bHksIGl0IHJlcXVpcmVzIGEgY2xpZW50
IHJlLW1vdW50Lg0KPiA+IEJ1dCBwZXJoYXBzIHJlcXVpcmluZyAibW91bnQgLW8gcmVtb3VudCIg
aW4gdGhhdCBjYXNlIGlzbid0IGFueQ0KPiA+IGRpZmZlcmVudCB0aGFuIHJlcXVpcmluZyB1c2Ug
b2Ygc3lzZnMuDQo+IA0KPiBBY3R1YWxseSwgSSB0cmllZCB0byBkbyBhICJtb3VudCAtbyByZW1v
dW50IiBhZnRlciB0YWtpbmcgZG93biB0aGUNCj4gc2VydmVyIGFuZCBjaGFuZ2luZyBpdHMgZmVh
dHVyZXMgKGllIHNlY3VyaXR5IGxhYmVsIHN1cHBvcnQpLCBhbmQgdGhlDQo+IGNsaWVudCBkb2Vz
IG5vdCBxdWVyeSBmb3Igc3VwcG9ydGVkIGF0dHJpYnV0ZXMuIFNvIEkgdGhpbmsgZWl0aGVyIGF0
DQo+IGxlYXN0IHBlcmhhcHMgdGhhdCBjYW4gYmUgY2hhbmdlZCBzb21laG93IG9yIHdlIGRvIG5l
ZWQgYSBzeXNmcyBhcGkNCj4gdG8NCj4gYmUgYWJsZSB0byBjaGFuZ2Ugc2VydmVyJ3MgY2FwYWJp
bGl0aWVzIG9mIGEgZ2l2ZW4gbW91bnQuDQo+ID4gPiANCg0KDQonLW8gcmVtb3VudCcgZG9lcyBu
b3QgY3VycmVudGx5IHRyeSB0byByZXByb2JlIHNlcnZlciBjYXBhYmlsaXRpZXMsIGJ1dA0Kd2Ug
Y291bGQgaGF2ZSBpdCBkbyB0aGF0Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
