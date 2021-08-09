Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3113F3E4E2A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 22:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhHIUyl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 16:54:41 -0400
Received: from mail-co1nam11on2120.outbound.protection.outlook.com ([40.107.220.120]:61800
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234454AbhHIUyl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 16:54:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtQ0Hg7GV0i7T4lHRT7aMgx2ZSNgNJC75FBIns0mn09KBpG4tvHlbjv43REbl2wcSMuZHjDsi15r9Qqzz784UpP0oFAi5nGjFsnjQSeAdWcvW3Yr/qx2cpgjPzKU9b5qU8wxCXSaw5SWmzp07S/jNrn2khhDufTB+uJjPE/bxD0Lg0yHP5sHk/Cdgp2hSs3lcBuxy+4vNGJXOObBhHDs/r6cWSl3dc5RGOZXGG/AJLpSniBZBWDgmd5SrNLQiOlr+pv0fJ5QLaMAR6jvjvyDlwQont9jB0w2G7uh8ye4X7zsXR8x0B1yqgtUDDs47OF5NrjHUIrmhtmA27Oc1nZlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UifWVoVf22IWqEc+864t4aVdpMHco8vJzlvC4HLj1n8=;
 b=GX9YOA1vqSaH/SXtV/J1kz98u2aIMf5DXFG/9xKGkpwChAnDIvaHvyi5QpumJONWNjlug17+rUZZdef4IS2kJxqoPw/iU4SewJjX36EG8+pYUU8qla3kEK+r/Hls+2UlX1wOPowPk7k5pGYsaHhn5ZTwn0i/zcG8I32prCOJ/kyYessWhbGChXmSarq1l+gIs1D31QDb9VoPgKDqV+GGuWzpLCQkRDS+V6yY7gGpSJLZb98oR4JssDbEJvsbADRol+31qBYhy5XKIzZ37F3/f0VEAIBAmVhGND5MvzoHViAWGXMoe+L5nr9KIHFAg9WU32WTxUprmUmEy6yhobd0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UifWVoVf22IWqEc+864t4aVdpMHco8vJzlvC4HLj1n8=;
 b=yHF2BQq+LWK+cvlwfxVyiT4u9g6+4h3Wyt4YSr8WoX07FXOp5WT6tSvx5KGvEuXMpUV9WRFnC2CGQ0X3dSiSc3vG6dlf6vqHomNBG9eu7ejMq4FGHVU/CptrvP+t4up4cAUyv5uubVbmp0rERaAES3tbvcZDximZ8lMKHJnpkbA=
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL0PR14MB3539.namprd14.prod.outlook.com (2603:10b6:208:1ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 20:54:18 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 20:54:18 +0000
From:   Charles Hedrick <hedrick@rutgers.edu>
To:     Timothy Pearson <tpearson@raptorengineering.com>
CC:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRnsuG+zO3JoCWACAAAPHgIAACdwAgAACeYCAAAYTAIAADpYAgAAAaoCAAAIdgIAAAvmAgAAAhwASVj4mvf9tcHuA
Date:   Mon, 9 Aug 2021 20:54:17 +0000
Message-ID: <FE5ABF17-F030-4A58-9150-49BAB4E8D208@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
 <77ED566A-7738-4F62-867C-1C2DFC5D34AB@oracle.com>
 <F5179A41-FB9A-4AB1-BE58-C2859DB7EC06@rutgers.edu>
 <1065010667.1047836.1628533859535.JavaMail.zimbra@raptorengineeringinc.com>
 <19368DD0-74CA-4DB7-9C1F-707106B50635@rutgers.edu>
 <20210809184911.GD8394@fieldses.org>
 <15AD846A-4638-4ACF-B47C-8EF655AD6E85@rutgers.edu>
 <81413392.1050622.1628535375526.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <81413392.1050622.1628535375526.JavaMail.zimbra@raptorengineeringinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: raptorengineering.com; dkim=none (message not signed)
 header.d=none;raptorengineering.com; dmarc=none action=none
 header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f4b64e9-9336-460a-1bd7-08d95b77dad9
x-ms-traffictypediagnostic: BL0PR14MB3539:
x-microsoft-antispam-prvs: <BL0PR14MB3539E06A8D03ACAD29A45636AAF69@BL0PR14MB3539.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVt/FEu6jQjiP5uuQlVX9w8nuU/L7P+0ImwVknx+/QeooNRywbg1Uy+LCdo0biY1gFb5pOANih7LwWXaK9SgPXc2/fZpn9l85Bu+P/hufELhRR8QJfaUEbZ2WdL6pZ3zis6b/V/mVa/zKIBRANWxkFl40f2AbUqDUsvl2wInG0jnWgtGgB9cw0lMv+eMDNzxg+on41QAFKKiZcQhkQBM87kwbkWCMhontYE/Rfucr4uLpBM4WqIT6YlOs0Dui1GrCvBSebmdzmxlUPtvUJB1vOhgjFC/bOESdS2IgvpYd+DJWs2RrlT1xH6ZM4lyygIJt0GYgcfHqDhSmU9bgGTP0mJRAT+zilqX2TM/YbFYwwFnz4rEVD9fW32F4+GrlSKNU+AUoYszYM31Se0UjE8qxfiwY18Ov0aomDJok+XdDwXKYUNnNUCGwWUSKO/7RgxuywKK3D30hHCl3/8H07pe7BZ3S8QaK3u9behxP3kEmdnQ3Z9HbH+fvzwHSBJdIxb18pcZDEp76XfJLpxKNNE1vXOjstc6gMFvYymYVK8m6cr9Nzs3TkY9p1hUvZ27SN0XG4HP/x5cClhkQs4xej6nKXKJc728hBKjTUsJDFSxKN7uUb4slvWrMDhcVOC4JbIsXnrdyQHxzM562GvLWTmF7SCYWXbnx2NvUWWeSqBhDHB5bKzHf1FIe4x4j8O1bNBvbUJti0CPB3CxdqJoy+otPj4CpS/uK29DrMmVkZyhDho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(4326008)(8936002)(122000001)(54906003)(38100700002)(8676002)(2616005)(71200400001)(2906002)(53546011)(478600001)(6506007)(36756003)(38070700005)(33656002)(316002)(786003)(6512007)(75432002)(66946007)(83380400001)(6916009)(5660300002)(64756008)(26005)(186003)(66574015)(66476007)(66556008)(76116006)(66446008)(6486002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmMzWXIvcWlPeGZLTGs5UGRWQ0ZoZUFLOGt3b0dIa3FGZDIxbWNhR3p0TGVm?=
 =?utf-8?B?RWNwNWFFOFlTeTJ6eFJqTm5QM2RZSTdsY2tkTkRlSVZMVWxJTGZoNEsyQzFj?=
 =?utf-8?B?UUllazUveXFyemR5S2RBU0FLMGVaTTE2c1hDQkZNKzB4YVBzUCtuei9lTjJo?=
 =?utf-8?B?T1l4L3dGMGdoSHNvUTRhMkMza2ZYcmR1VlZzYWlVV2VPMEN3UnRkZVE2R3hX?=
 =?utf-8?B?Z1Q0MlhmOGtOSUtSQ1RLR0NiZ2EwemM5K2Jhdi94RFNaanJhTmpQR255V3Bs?=
 =?utf-8?B?Q1BZZkM2Q1gzWWhJNk43U2w5T2RqbSs5RE9JbmNpL2ZtUnI1cCt3d3gyQnFx?=
 =?utf-8?B?eEZ0dGNmOWo0YllYN2xta1hFTnRmaWViS3BzLzFXdERqUlJWaE56Nll1M1B1?=
 =?utf-8?B?UU5OWGJNNFYwaEhUYVZZemRFaHdaM3pXMjNtY1dLUktVOE8xYU5FSlVsNXh3?=
 =?utf-8?B?WUU2a0ZzWlA4WVVnK3h1NW9ydVdEdnhBcFdOejJwVnZxOFNsVjJCeWU5c3Fl?=
 =?utf-8?B?dVFqWC9YZll5U2hOYzRORDRhQ0djQjVqUmFNMFo3VC8vSUd2U0VGdEFFbmRY?=
 =?utf-8?B?eEhXSVNYRWYzMklXN1B2dU42aXlUVWVlTlFVUjd5SXlCSnR1bW9kOHl2akx5?=
 =?utf-8?B?SWJVZUR5Y0FQakJqMEEyaG1RZE1kamZBS3pZVE1sSCtBSERSMm5MNERqTmpr?=
 =?utf-8?B?UXpOWXBkS1lieHRuaHFSMXNWU3hhNWZGTVFoTDFieDBkdzFVL0RSdGErdFph?=
 =?utf-8?B?Qnh4U3JHUHUrakFDOWxxMENEMjExd1VpSFZyeWdYdlFkT1RHWklRV05jbUFZ?=
 =?utf-8?B?Mi90alp0ckc3QmtPV2t6RkdtdTM2Yk05bVgveTNMMmhxTC9mb2J6ZTlSa2dJ?=
 =?utf-8?B?SU9STEtueHdNNHo0VEJVdGN4WE5VbzVwbXJTUVdzRk5vNFl4WUMrTG82OUpq?=
 =?utf-8?B?S3FNazZTUzlZLzRHNTBCcVFYNFpmZXluem5aQVlxUStBOXJBbUN4a2k1Q2Z5?=
 =?utf-8?B?UUN5NCtHelNLSG5kYWpCRngxN1haemRZanRodXdzL21RRFhrd3VTUTBaajNE?=
 =?utf-8?B?L2ZjMkQ0WmxvV0NjQnljcUdoc1BtTEtNSGNsaENNeG5waU9DWUxJUk9Cam96?=
 =?utf-8?B?S3ZxbUF0MVRyOW9BdDJFODB3d1oweTBUSVA3aS9HUlRIeEtUMHpBRi9YV3Fa?=
 =?utf-8?B?QW5jR2ZJT09ValZFRDJTdUhXNXd1R0gzK25qeHRuK2lOWnJKS3ptZERJSS93?=
 =?utf-8?B?SFAzTnhQbE0xVlBMV0xnOGhTM2VVK2JlODFnK3IzSCtvOE5xQng3UjdpTllQ?=
 =?utf-8?B?dVdpUlZGYVlnaWw5U3hEOWFmYmVJS0t1K2tIODczWVV5SkFUUUVSTmYzbERB?=
 =?utf-8?B?a1BuZGtnRzF4MENNRDQvbnQ0dWVZSS9KOGl4L0V1RG9PNWUvSzJqWDFlMW4r?=
 =?utf-8?B?SnVZbXBTT01lQkZvTDR2cWIzUVhXaG92RkRad0RmSEtISzJzVC82TXVicWpm?=
 =?utf-8?B?YVBYYkxYYXI3VmZHV0gzN01DOWp2T0pxekxvNTNYRVN4N2U1NDRKWktzcDNU?=
 =?utf-8?B?aWlEU3pJcW4yMXBabWpmOWpWOGFLZ3BHRGpreXlqa3RmaXEvb1p2Zm41UmVU?=
 =?utf-8?B?RlpmV0xEUTZvSEVLTFhTZzJoNzFkVzcxOTV1Snl5OHlZZjAyL3lLdUZlYnJK?=
 =?utf-8?B?SmlzbGdRb1hTazE5bUpYczhLWlFBTE52UndWUkZrRWoxbzZNWWRQSzFEZTVR?=
 =?utf-8?Q?CnWTHiM6lNoiRpRcahVOxizsL+BTwKhmuGA+P6d?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C43962572386F47AA19AC0A79C2B49B@namprd14.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4b64e9-9336-460a-1bd7-08d95b77dad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 20:54:17.8910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5zSRBEyQBtV/lKsL3uBV/OMejr/8/3Y4avbZ7HKCUItLtVyT7R/QGpNoUr3zUfQylv3SzGSFcO6LdL2JiDnww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3539
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SSBqdXN0IHJlYWxpemVkIHRoZXJl4oCZcyBvbmUgdGhpbmcgeW91IHNob3VsZCBrbm93LiBXZSBy
dW4gQ2lzY2/igJlzIEFNUCBmb3IgRW5kcG9pbnRzIG9uIHRoZSBzZXJ2ZXIuIFRoZSBnb2FsIGlz
IHRvIGRldGVjdCBtYWx3YXJlIHRoYXQgb3VyIHVzZXJzIG1pZ2h0IHB1dCBvbiB0aGUgZmlsZSBz
eXN0ZW0uIFR5cGljYWxseSBvbmUgaXMgd29ycmllZCBhYm91dCBtYWx3YXJlIGluc3RhbGxlZCBu
IGNsaWVudCwgYnV0IHdl4oCZcmUgY29uY2VybmVkIHRoYXQgZGV2ZWxvcGVycyBtYXkgYmUgdXNp
bmcgamF2YSBhbmQgcHl0aG9uIGxpYnJhcmllcyB3aXRoIGtub3duIGlzc3VlcywgYW5kIHRob3Nl
IHdpbGwgY29tbW9ubHkgYmUgc3RvcmVkIG9uIHRoZSBzZXJ2ZXIuDQoNCklmIEFNUCBpcyBkb2lu
ZyBpdHMgam9iLCBpdCB3aWxsIGNoZWNrIG1vc3QgbmV3IGZpbGVzLiBJ4oCZbSBub3Qgc3VyZSB3
aGV0aGVyIHRoYXQgY3JlYXRlcyBhdHlwaWNhbCB1c2FnZSBvciBub3QuDQoNCj4gT24gQXVnIDks
IDIwMjEsIGF0IDI6NTY6MTUgUE0sIFRpbW90aHkgUGVhcnNvbiA8dHBlYXJzb25AcmFwdG9yZW5n
aW5lZXJpbmcuY29tPiB3cm90ZToNCj4gDQo+IENhbiBjb25maXJtIC0tIHNhbWUgZ2VuZXJhbCBi
YWNrdHJhY2UgSSBzZW50IGluIGVhcmxpZXIuDQo+IA0KPiBUaGF0IG1lYW5zIHRoZSBidWcgaXM6
DQo+IDEuKSBOb3QgYXJjaGl0ZWN0dXJlIHNwZWNpZmljDQo+IDIuKSBOb3QgZmlsZXN5c3RlbSBz
cGVjaWZpYw0KPiANCj4gSSB3YXMgb3JpZ2luYWxseSBjb25jZXJuZWQgaXQgd2FzIHJlbGF0ZWQg
dG8gQlRSRlMgb3IgUE9XRVItc3BlY2lmaWMsIGdvb2QgdG8gc2VlIGl0IGlzIG5vdC4NCj4gDQo+
IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0NCj4+IEZyb206ICJoZWRyaWNrIiA8aGVkcmlj
a0BydXRnZXJzLmVkdT4NCj4+IFRvOiAiSi4gQnJ1Y2UgRmllbGRzIiA8YmZpZWxkc0BmaWVsZHNl
cy5vcmc+DQo+PiBDYzogIlRpbW90aHkgUGVhcnNvbiIgPHRwZWFyc29uQHJhcHRvcmVuZ2luZWVy
aW5nLmNvbT4sICJDaHVjayBMZXZlciIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+LCAibGludXgt
bmZzIg0KPj4gPGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmc+DQo+PiBTZW50OiBNb25kYXksIEF1
Z3VzdCA5LCAyMDIxIDE6NTE6MDUgUE0NCj4+IFN1YmplY3Q6IFJlOiBDUFUgc3RhbGwsIGV2ZW50
dWFsIGhvc3QgaGFuZyB3aXRoIEJUUkZTICsgTkZTIHVuZGVyIGhlYXZ5IGxvYWQNCj4gDQo+PiBJ
IGhhdmUuIEkgd2FzIHRyeWluZyB0byBhdm9pZCBhIHJlYm9vdC4NCj4+IA0KPj4gQnkgdGhlIHdh
eSwgYWZ0ZXIgdGhlIGZpcnN0IGZhaWx1cmUsIGR1cmluZyByZWJvb3QsIHN5c2xvZyBzaG93ZWQg
dGhlIGZvbGxvd2luZy4NCj4+IEnigJltIHVuY2xlYXIgd2hhdCBpdCBtZWFucywgYnUgdGl0IGxv
b2tzIGlrZSBpdCBtaWdodCBiZSBmcm9tIHRoZSBmYWlsdXJlDQo+PiANCj4+IA0KPj4gDQo+Pj4g
T24gQXVnIDksIDIwMjEsIGF0IDI6NDkgUE0sIEouIEJydWNlIEZpZWxkcyA8YmZpZWxkc0BmaWVs
ZHNlcy5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIE1vbiwgQXVnIDA5LCAyMDIxIGF0IDAyOjM4
OjMzUE0gLTA0MDAsIGhlZHJpY2tAcnV0Z2Vycy5lZHUgd3JvdGU6DQo+Pj4+IERvZXMgc2V0dGlu
ZyAvcHJvYy9zeXMvZnMvbGVhc2VzLWVuYWJsZSB0byAwIHdvcmsgd2hpbGUgdGhlIHN5c3RlbSBp
cw0KPj4+PiB1cD8gSSB3YXMgZXhwZWN0aW5nIHRvIHNlZSBsc2xvY2tzIHwgZ3JlcCBERUxFIHwg
d2MgZ28gZG93bi4gSXTigJlzIG5vdC4NCj4+Pj4gSXTigJlzIHN0YXlpbmcgYXJvdW5kIDE4NTAu
DQo+Pj4gDQo+Pj4gQWxsIGl0IHNob3VsZCBkbyBpcyBwcmV2ZW50IGdpdmluZyBvdXQgKm5ldyog
ZGVsZWdhdGlvbnMuDQo+Pj4gDQo+Pj4gQmVzdCBpcyB0byBzZXQgdGhhdCBzeXNjdGwgb24gc3lz
dGVtIHN0YXJ0dXAgYmVmb3JlIG5mc2Qgc3RhcnRzLg0KPj4+IA0KPj4+Pj4gT24gQXVnIDksIDIw
MjEsIGF0IDI6MzAgUE0sIFRpbW90aHkgUGVhcnNvbg0KPj4+Pj4gPHRwZWFyc29uQHJhcHRvcmVu
Z2luZWVyaW5nLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IEZXSVcgdGhhdCdzICpleGFjdGx5
KiB3aGF0IHdlIHNlZS4gIEV2ZW50dWFsbHksIGlmIHRoZSBzZXJ2ZXIgaXMNCj4+Pj4+IGxlZnQg
YWxvbmUgZm9yIGVub3VnaCB0aW1lLCBldmVuIHRoZSBsb2dpbiBzeXN0ZW0gc3RvcHMgcmVzcG9u
ZGluZw0KPj4+Pj4gLS0gaXQncyBhcyBpZiB0aGUgSS9PIHN1YnN5c3RlbSBkZWdyYWRlcyBhbmQg
ZXZlbnR1YWxseSBibG9ja3MNCj4+Pj4+IGVudGlyZWx5Lg0KPj4+IA0KPj4+IFRoYXQncyBwcmV0
dHkgY29tbW9uIGJlaGF2aW9yIGFjcm9zcyBhIHZhcmlldHkgb2Yga2VybmVsIGJ1Z3MuICBTbyBv
bg0KPj4+IGl0cyBvd24gaXQgZG9lc24ndCBtZWFuIHRoZSByb290IGNhdXNlIGlzIHRoZSBzYW1l
Lg0KPj4+IA0KPj4+IC0tYi4NCg0K
