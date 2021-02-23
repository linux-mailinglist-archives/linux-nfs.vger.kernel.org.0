Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6300322D13
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Feb 2021 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhBWPDr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Feb 2021 10:03:47 -0500
Received: from mail-dm6nam10on2108.outbound.protection.outlook.com ([40.107.93.108]:35552
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232642AbhBWPDe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Feb 2021 10:03:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8CTgtzautJkx2OoWt0M1jrWE+kq1Df5wnhof40DXY+uDi6ox24ivAsMxhHxyu3z4luOPbWlBmPCv3ZWM2dQ5tGC0QZy8uSr/T1il+zRsv0li0z2M9xw6ilVacFYTCWjkwArw+jtnPD1suMfunUYiTygQwV+kU0yFSlsAG7b70wZOAX7Ddr95bymjE51SSabkNIbhMfmBbE7U08+yi3uP1iFkv1x5kkdf834PzkuoWZl1lR8mkpPXri5k/r/Fj90RbimMVypY2S8GqON4h4RfO2glV73ctLj1HcEbCc6XhFhjLhnRC8u1W91gVjQ9lf/ePr4mtZPaQiuB18v3Gy9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbHKZkizTdp/nLcrRBxWC56SOL3txFNyV7oFcpShvBE=;
 b=RQBOyGT+eIEFeTSvI+wwC6pnaUskwFMXQFowDHLCFrHe346jB7K5M41lbpt+O76vtWvnyDNaEG+PNpgILZvr358y0yHMLRwpNwABqGB1prIo8f2xwiTorDb2v++tQr3A+JKLkWU4MLQitCQdiemdWsqBfcHSbj2rqf9pZuT4Knu+MGVRDpPx7Vr0l69jpjabhEtJESuENoGidXAFv2/N/EJi3rD4NNaYGo6haOtEDm2/fE7v0B8SxBgVyZF5Q40gHTIhAjLOMiDuDNScph+DgsQi/sAFfy3MAQGkCwUA3hr6QIIKmspFJ7hXPN8ghwaiaNQ+r8TfOB02p4wHfkSdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbHKZkizTdp/nLcrRBxWC56SOL3txFNyV7oFcpShvBE=;
 b=GfTb0kmwWiykJr72PTyR/dzZs07BrnPhdyJU/UQPp7UUzzAfXSSnuqOOzQSTwU1WfSnNtDU380zqrLHwYAiZoZs7ctbGlHSXgZVNJRQSQdY+fXiONyrkahYSsvk3q0TSdoTXK1eVDFcy0XOegzql37T6lteSIUKD3QskMxQlvh0=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH0PR13MB4620.namprd13.prod.outlook.com (2603:10b6:610:c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.14; Tue, 23 Feb
 2021 15:02:41 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3890.018; Tue, 23 Feb 2021
 15:02:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "timo@rothenpieler.org" <timo@rothenpieler.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
Thread-Topic: [PATCH] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
Thread-Index: AQHXCe8dex9I+OTxNEGYGDFZCJLwZapl0u8AgAAA2ICAAAI1gA==
Date:   Tue, 23 Feb 2021 15:02:40 +0000
Message-ID: <789e6d842892d9f452095589188b00ea54b94613.camel@hammerspace.com>
References: <20210223141901.1652-1-timo@rothenpieler.org>
         <6626a1877551f25f8e57addc720acba5af674d1f.camel@hammerspace.com>
         <4a53c37a-89bd-d7e7-9597-4117825b4a19@rothenpieler.org>
In-Reply-To: <4a53c37a-89bd-d7e7-9597-4117825b4a19@rothenpieler.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07ad1164-d32c-4675-8f36-08d8d80c1114
x-ms-traffictypediagnostic: CH0PR13MB4620:
x-microsoft-antispam-prvs: <CH0PR13MB46203B14341773DFFC1A1A81B8809@CH0PR13MB4620.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qbvZ3LBniZTKzxNHujcL9d7EzxGexCQjc9/yLnFP1rPPyvsEAxGn1/PlKqE30xd+HL8E78gnKFZuWhf07CF0/ymzQj2yJlsuFv2/EvdsP3i8QJ7NJ/xa+YoHdEck5iyTKcumQ4CyJGLWrZP9HzyKrvRqhsSOjjNUOOO19TkibU9xDUk79+wbgRxMdLneQYWqkiurW1KIkPLy6Nr8kW+050TaPAJCJJIoX4AMYuix2rA/5aaD/4cNfWYsMcl5HqCyuz7frfvYDH3kLhdOQ1X2DUAoa/iSyy5nQY2WTPC6hYcoXa4AyOC0r7lLGhB7ZCNpnEGPTEcoNEv/Bv18Duzea+Nyl5WI4Djq6NE5fDjnkR1305R9INldrlSA9Iw0nzotPjnkLijtqEqMcyWuHUYrZu5IZiMifm19+DYeWYthe4n0sCkmnqbOZYsOfnjzFGVjqaCFGURr2sVkCUj3yNJqe09zDv1R4ZS3VJQOrmGDtMTHCbMOp6Q3ltr61sH8mX8zR8TLGKjnZCOB9fysaqhzJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(346002)(366004)(376002)(396003)(2906002)(2616005)(66556008)(76116006)(36756003)(8936002)(26005)(5660300002)(83380400001)(71200400001)(64756008)(66446008)(86362001)(316002)(478600001)(8676002)(6512007)(6486002)(110136005)(66946007)(186003)(66476007)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TEJFaWZURXVOMjZjaElwOFdGVXQ5WHFtaStXMkJzWEt0aENUK1RWUWMzczEz?=
 =?utf-8?B?VDkyVGx3T3BVcE5LNGpacEUyWldCaW1JaDE4TDZEa3pqNi9BaG5UaXM2bDdP?=
 =?utf-8?B?dzBpN0o3dXBmbHFYcnE3STcxVzh4ZjdwaHZEZTM4UFhrVVk0RC9uS29uWkpu?=
 =?utf-8?B?Z0dlRFpzRkE5SGp3UEVXSUcyS3BwcGJjUm9hYmpweDJld2kwYTIwM3pLOUwr?=
 =?utf-8?B?dW83akduM1I4a0U3TkFOeHB3QTZHYnFGSDVvdVdwRE5NTVFLYmIwalBLRmY4?=
 =?utf-8?B?NjFxeUdnUFI3b0NXYkYzTm1UMFdpMWRLTWh1cFpZbGVlNEJNYVdKSDJxVzVZ?=
 =?utf-8?B?NWtZdkRwcEVvcUlEcmh1RFFVSWNRbXFDWWl3SmtNOVhpV254TFFUbVprZjU0?=
 =?utf-8?B?cVovRVZFUmdHYmxNU2ZIOUswckMyVE1jdTJ3QmloWGhwUWtvWTZYQmRrTW5h?=
 =?utf-8?B?WWROYmxKZUxVc1hzZ0NGbC81aUM4elBzOEdBSFJWbU82Z2h4czRuc09yYXAx?=
 =?utf-8?B?Rjg1Y0pGREpaSGljME5tdkI2S0VjYnhOS3FrZDg1K1pmLyszTTE5aWtoeExz?=
 =?utf-8?B?S01ETHRRU3htZ1laQStDeFcvRlVjSGFzNC9DSnJsUWJuZWo4QVdIR1BPemIr?=
 =?utf-8?B?ck9CTUdIOE5zZkpqU0Y3N1ZSTUN2blZZSWdNVXFmZWZCWE1kT2gwZlp0dFZM?=
 =?utf-8?B?VlFoRDMzamhrNDFPbXdtNk14RGk5WnA4RUZrMzhqcy9OaUVBek5kbkZlaDJu?=
 =?utf-8?B?VklWdzBVWHhPbmV5akVpV04vbkltNkNWNVhBZURBQUFmampnVkxZTDlrdXNi?=
 =?utf-8?B?TTFxcURZb1hrRW1tblJOVUMvNWhyZFFRZ0VJVUxpZFhwVTFoWW9aRFZnQmVK?=
 =?utf-8?B?V29Ha0htQTY3SUdMUk9FdDhiSW4yclNjMG5FK1lsS0NhbUdxRGRSVHRzdzdZ?=
 =?utf-8?B?R2Y0V2VyT25KWFBFVlhyQ3krYUNDTWlzQzk5cGV0Qll3a08zNHp2aGdjL1Bw?=
 =?utf-8?B?UkE1YXpGT0hKekcwbXFzdlVWeWYrRmNhNitsZlFtK2dRRnpZVUV1YzhLVTlF?=
 =?utf-8?B?cCtFa1lPQm1GZmdEcS91Wk93NTRuWkFNeEdPODdTM1V5NFFGdFhZSVlNYk9x?=
 =?utf-8?B?QzVSK3BJZ2JvcU5JZXEyL3NidFBmcXhVWXZYWGRqbllGRU96cEhaL242ckg4?=
 =?utf-8?B?Wkd4cWVUTlp4V0xJY0pSdnY5aWswTUVhUVppQ0Vucm1tOVlPY0VqVWg5THhD?=
 =?utf-8?B?NUlBaFp4UnV4eUlBOVhMbktpdE5qQlpFVStrak9CWEd5eGc5RmpEZERjZVdk?=
 =?utf-8?B?M0YyRzl1Nnd2MzhlRWdtQkpGWEpFdXNRNEg3SnpmN3l1ek1FY2JWVGpWdG9B?=
 =?utf-8?B?a0ZGWFUzN0JLVDhGSG03Y0p1TGUxdTRxd2dZcDlkOEE3OUZXZUllUFN0aDVM?=
 =?utf-8?B?VytLNUQ0TFhmVkFyb2lCeDE4U3VZL2JXaTF5WVJuUlByRW9SckVMWUhhZ1Vq?=
 =?utf-8?B?V2pCNCtwY1oyZkxLbGpFa1ZHNTFjQ29PZ0o4RTBzbDJwMXg0M1dVTndMcjRz?=
 =?utf-8?B?NDA0VldRL3BhaTFaSXJialhsSEdoZ0YwdFZETm5lWWk2dHlmbVdDbjBiNm84?=
 =?utf-8?B?bGhpUkliYjJxWExMZG41SlhyU3pxVm82dGwxYlB4VTRiQmhsWUU0V1JFVjNS?=
 =?utf-8?B?Um54MEZia1VQV2N3WlBVQ0E2VFlRMEFhQ2VWTkk3QmRWSWZNWU9vSTJqam9T?=
 =?utf-8?Q?3Ft34Z7p013YJ4vKYRT460Ghz/sIZlB9Fv4HXpQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5538D748D375CC44BCCA36B23649FB1D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ad1164-d32c-4675-8f36-08d8d80c1114
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 15:02:40.9343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gHBQkz1nYUClteeYWYzdsrPKVqQpuSACL2K08Nu+MJrHN3Kwrh4IrJUnhnNA3h4G/A9smPhqEZeU9httXvtjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4620
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAyLTIzIGF0IDE1OjU0ICswMTAwLCBUaW1vIFJvdGhlbnBpZWxlciB3cm90
ZToNCj4gT24gMjMuMDIuMjAyMSAxNTo1MSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+IE9u
IFR1ZSwgMjAyMS0wMi0yMyBhdCAxNToxOSArMDEwMCwgVGltbyBSb3RoZW5waWVsZXIgd3JvdGU6
DQo+ID4gPiBUaGlzIGZvbGxvd3Mgd2hhdCB3YXMgZG9uZSBpbg0KPiA+ID4gOGMyZmFiYzY1NDJk
OWQwZjhiMTZiZDEwNDVjMmVkYTU5YmRjZGUxMy4NCj4gPiA+IFdpdGggdGhlIGRlZmF1bHQgYmVp
bmcgbSwgaXQncyBpbXBvc3NpYmxlIHRvIGJ1aWxkIHRoZSBtb2R1bGUNCj4gPiA+IGludG8NCj4g
PiA+IHRoZQ0KPiA+ID4ga2VybmVsLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUaW1v
IFJvdGhlbnBpZWxlciA8dGltb0Byb3RoZW5waWVsZXIub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiDC
oMKgZnMvbmZzL0tjb25maWcgfCAyICstDQo+ID4gPiDCoMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9u
ZnMvS2NvbmZpZyBiL2ZzL25mcy9LY29uZmlnDQo+ID4gPiBpbmRleCBlMmE0ODhkNDAzYTYuLjE0
YTcyMjI0YjY1NyAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25mcy9LY29uZmlnDQo+ID4gPiArKysg
Yi9mcy9uZnMvS2NvbmZpZw0KPiA+ID4gQEAgLTEyNyw3ICsxMjcsNyBAQCBjb25maWcgUE5GU19C
TE9DSw0KPiA+ID4gwqDCoGNvbmZpZyBQTkZTX0ZMRVhGSUxFX0xBWU9VVA0KPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgdHJpc3RhdGUNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24g
TkZTX1Y0XzEgJiYgTkZTX1YzDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqBkZWZhdWx0IG0NCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoGRlZmF1bHQgTkZTX1Y0DQo+ID4gPiDCoCANCj4gPiANCj4gPiBMZXQn
cyBqdXN0IG1ha2UgdGhhdA0KPiA+IA0KPiA+IMKgwqDCoMKgIGRlZmF1bHQgeQ0KPiA+IA0KPiA+
IC4uLmFuZCBsZXQgdGhlIGRlcGVuZGVuY2llcyB3b3JrIG91dCB3aGV0aGVyIG9yIG5vdCB0aGlz
IG5lZWRzIHRvDQo+ID4gYmUgYQ0KPiA+ICd5JywgJ20nIG9yICdOJy4gVHlpbmcgaXQgdG8gTkZT
X1Y0IGp1c3QgbWFrZXMgdGhlIEtjb25maWcgaGFyZGVyDQo+ID4gdG8NCj4gPiByZWFkLCB3aXRo
IHRoZSByZXN1bHQgYmVpbmcgdGhlIHNhbWUgYW55d2F5Lg0KPiANCj4gU3VyZS4gU2hvdWxkIEkg
Y2hhbmdlIHRoZSBvdGhlciB0d28gUE5GU18gY29uZmlncyB0byBkZWZhdWx0IHRvIHkgYXMgDQo+
IHdlbGwgd2hpbGUgYXQgaXQ/DQo+IA0KDQpPaCBoYW5nIG9uLi4uIEJyYWluIGZhcnQuLi4gSSB0
aG91Z2h0IHRoZSBkZXBlbmRlbmN5IG9uIE5GU19WNF8xIHdvdWxkDQpzdWZmaWNlIHRvIG1ha2Ug
dGhlIGNvcnJlY3QgY2hvaWNlLCBidXQgaXQgbG9va3MgbGlrZSB0aGF0IGlzIGEgJ2Jvb2wnDQph
bmQgc28gaXQgd29uJ3QgcHJvcGFnYXRlIHRoZSAnbScgY2hvaWNlIGZyb20gTkZTX1Y0LiBUaGF0
IGlzIHByb2JhYmx5DQp3aHkgQ2hyaXN0b3BoIGRpZCB0aGUgTkZTX1Y0IGRlZmF1bHQuDQoNCk5l
dmVyIG1pbmQsIHRoZW4uIExldCdzIGtlZXAgeW91ciBmaXJzdCBwYXRjaC4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
