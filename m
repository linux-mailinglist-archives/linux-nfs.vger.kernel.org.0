Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E602345335B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 14:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbhKPOAR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:00:17 -0500
Received: from mail-bn8nam11on2125.outbound.protection.outlook.com ([40.107.236.125]:18017
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236943AbhKPOAL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Nov 2021 09:00:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bedpfPN3k3ytWYETyjQgYxKwhqqpB1wB07HGHi3826YRFC0SLmYcVWDaiR386JygxuxMeQ04AD6eaX/D5nI3LOZwzXbdWrzW/0zW9+LxTW85UVg8jM8nlrr4xR0H9asof8XsyDUtaIY0i9W9/JKG+zrIj00cvQe/gOELAV79tmHeuzOOVxYY/1fSnIXqlknAIHkHkDrV2wKf6EldvtRZ6i1L3X9TZT1P3T2v2DgeA1AMK1zHceLuRNPlB81vVdvDi6hpzNNOynCqd9N9oHOGLFOtM+jl67wN+fiQ3ZiEPqYBmKaXaQCrLmcl+R4HsD2aBzfRIVqdd408RebJFZ2ITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRMjhVmt9y/ZohBjtG7R7qjwMLbFgQyPXX/IA7O+YE8=;
 b=QFUGkL2fJYpQG7I/TKXxHIAQtklrlBQSUbz+QZGE3eAlBOT8SzL5uT+yEbfGm3HkUm+twggboZ4MYxsB+YMRQvnVjTdFQcDU9tR6A8as3sjkVFZ8xq55YsU+vs8uPMNLut37P/lrgmrxwbhltvuXAEswr2f1KlTxNoLzl5/gH/ZSGTyZRpfPnG0H7cusofUkKp8VX7xpjeDlG5R6M/w7I3nhjwOStCAoiDMh5CIHq7/AGb/qmRjyXS5+i55iw5bxJRYQvwKpLnDqzfWIMLImhPaouBk47BB9ZXJ1gDrjAr5T3xB1g/szHwNCRyA9x3OHIFZ13YjXCQ83qRe0YTr7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRMjhVmt9y/ZohBjtG7R7qjwMLbFgQyPXX/IA7O+YE8=;
 b=D0997XWIR/E11BjYgRsZPMm134OmXXtucqZcZyb6GAEwVRrK/Gtz8huwsSU6NFknvGIwK7KoZMvWTxsrNIZFCYFsISqDhSAd6aQwAJ2cniJ3SpiOvuJQuwxF9ql/p3Gsu31sJakJ/aAi0iS2vIPJUKbkXrxpQoMRuU7V6yhTtmA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3413.namprd13.prod.outlook.com (2603:10b6:610:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15; Tue, 16 Nov
 2021 13:57:12 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 13:57:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] NFSv42: Fix pagecache invalidation after COPY/CLONE
Thread-Topic: [PATCH 1/3] NFSv42: Fix pagecache invalidation after COPY/CLONE
Thread-Index: AQHX2vDHrPesKFwW/0+/8ZVGKsEgtawGLdKA
Date:   Tue, 16 Nov 2021 13:57:12 +0000
Message-ID: <6dbcb2f39dcee7314bf772aaabf4923104ec7aee.camel@hammerspace.com>
References: <cover.1637069577.git.bcodding@redhat.com>
         <8b8ccdb69af2473eef4a36968894e7aee34d5851.1637069577.git.bcodding@redhat.com>
In-Reply-To: <8b8ccdb69af2473eef4a36968894e7aee34d5851.1637069577.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64311f69-b4d9-4ecc-0334-08d9a908fd47
x-ms-traffictypediagnostic: CH2PR13MB3413:
x-microsoft-antispam-prvs: <CH2PR13MB3413DD04DF4D954A4E94640AB8999@CH2PR13MB3413.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5P1u4pWsnDRs1zNmatn4Dx8AWl1yxODcSiWli7Su1cGDbdiioPynNwtPh3DZh5VaRCNzL1oluzyr5QbNoYMokhvPOio/JS/MrSo643JL2cD3xd0hmP6dXbEUt49ffUq7wU+5pQ00kQKjqcz4iJbbfoga175U+/3rX7S4okBSLZsuGaKXfnfI61kUo4CRbfYZzfPQJQHsmpVPHqIeIfzyz7wfbM6vXYwsORG37ZgmT1xe8qWYSmyuzQX7dzVHoWDr4JZfN01JvkmxvoW9bApfmsdMS5rO1UamJ2mUw80ztyCJ+KEUaXu1AouGvQzf/ALMn1TOnbG/Fr6mBLPKoDG4T/9ThoDzRoJmMQkgGoJWuMRmrN+uLmQKsrbBB1ifL10t3VFcLifYtFEwpizz8bg0WJnAIc1MI2oe2o3tMMpeGilrFwhvPNq5ypFMdk9TIV+fqgTfH39psB+m+WztbqMX9AO8vjBJ0jpbdIjG3rDmVZOEwEdW7NAeI+C/rSdKwLQHggjH/Pr5xp98aCL31mNxTQm/DPZkimiFDVqYHLDXqu/QxqVhyVEBo12R9YcbfcPcxnUN0d8pdDIKdgh6Ds4DoCt3L5whpOpPufYOWJhpsqqI5ZEy/gly4fWD+jqkFtCI1lXMzWTHx+Rz9v2y2HNKwu7PzqjM2S9rg3kC5YpW7yL35t79qOcFOIq/cMucxK6jq3tC4IMgFXQEGLdNMUEjxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39840400004)(366004)(6486002)(64756008)(66556008)(66446008)(66476007)(36756003)(66946007)(83380400001)(6506007)(38100700002)(4326008)(316002)(2906002)(38070700005)(76116006)(186003)(26005)(6512007)(86362001)(508600001)(2616005)(122000001)(8936002)(8676002)(71200400001)(4001150100001)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2FVZkRxa2Y1NXBtbWQwSVBSd3g2NlNncUZUamZVZEJUZHROYXJBdnA4V0JR?=
 =?utf-8?B?bVdKMlBxN1VBV1Y1a0FCSHJkS1ovSTZWS0UreG1pbkZKNFhMVHVmUG54aDdX?=
 =?utf-8?B?NVQ5d0dQcDZaWkNydE5WM1BYcktXaU1waEh3bmtqRk1EbXRBbitYWm5rK2s3?=
 =?utf-8?B?bDBwZis3VnNzRDk4b2ZKNTNYQUFwSDl3ZnZRNTJaN2JkcldFSHdPYkYreFpp?=
 =?utf-8?B?b1d0ZGZLNkxVMmUrc0UzbGF6VTFDSVBzTmJmMWFrK3pFMzFsYThocTdFZ2l2?=
 =?utf-8?B?WEpMNzdoanNySENkVjkwWUx3SG9QemxrT3FVdnI0WUxKUUdBdHZwdmZWWTBH?=
 =?utf-8?B?V044ZkpKTnl6akEvWUwrMmNQYlFEMm1xY3FoYkZ3ZG9WY3JzRVNPSGswOVll?=
 =?utf-8?B?Y0ZEZmp4Zit0TmI1a1BHajl1SmZjRXd0RFBsMXEwVGxOektydHZmVk9ReVB6?=
 =?utf-8?B?RERCckkvMUNMWk1CNEF5V1lkQUJ6SnZ5a1VoZjJHQmJnSDVmSW5LVmd2bTl3?=
 =?utf-8?B?a1NhKzZyYjB3WXpuZFQraHJxVUIzclJLNCthYVI1U3MyMHlYQ3N4cDhoRDUr?=
 =?utf-8?B?Q0ZibzBNYmZCdWFPMktXSWRZMEhSdUpDRG5lMDVYNWdtT3RQNzVxazM1d1dR?=
 =?utf-8?B?SzlQbGdtUkE1RDF3OFdtd3J1MDJXRk91OVAwUW1IVUtTRnE0K0grUlY2SGh0?=
 =?utf-8?B?a1N6R1NrTGR1aTBHdkRCT1QrN1JlRys2aXFpNnRZZ2xQVk9iYXFKam01V25t?=
 =?utf-8?B?RFppQ3J6Yll0b0o3UGlROFNkSXNOMk85eFNBQjBWeStYYzI4dFIzRGt4d1NB?=
 =?utf-8?B?Zk5wZGZmSCtab1VwS0dVbGZBb2ZabWhFcmxVbkhRQkx4K2l4cTVqekdkUkJS?=
 =?utf-8?B?enlhWHNxcUZTSTVmdVd4ZzlUMSs3RitDNTFuV3o4NWJlUjlWRmxwMFVwNjJa?=
 =?utf-8?B?dm56MTUzVUM1S2VwaHJpWEJiQ0JseEVhZ3JzTVcvbjlzL2VKTXVGbjNtZHJY?=
 =?utf-8?B?dUkvSzlkSE52emQyS1BOTDFHWTQxVlNQaUdXci9sdVRuR3V0amxFMDFtWWF1?=
 =?utf-8?B?cGVwN0swRSs0U2lYTDRlbHlLMUpQVFpKRitCeEF6UHJXTEsyczkzQ1RwV3N6?=
 =?utf-8?B?YnM1S1paSXlBT3FnK2llQWxOWWs0S1ZtTTdINU9Td2NOdlZxNEx1dlhjUlBV?=
 =?utf-8?B?aHoxS0pvU2I5T2tqNUFGODlYZDdSL1ZwVFpWeHhJZ0FyWWRVVi9DcFpRZmJ3?=
 =?utf-8?B?NFV1ODFTY2t0WjBWRXR3MUpPbVdVNFllQ3U3WGJNajRaRWV2S1RHbU9YdFND?=
 =?utf-8?B?eXlkbDcyaVNkMHdGVmtiQjQxRUJERDdsQU0vWmx1cm5oZnNOVExXem1VRWVi?=
 =?utf-8?B?NXVkT2pSRHU4c0xtOWhMTXQ4ZXgyYWNLMmF0VzhaNDI0eEJXYy9UL2dFUUgx?=
 =?utf-8?B?dDMzU0lNWHhtejBjYWVtZ0xsSVFPUkxUTmJxdVFuZ0Q3aWFvbWNzRlYrdGJL?=
 =?utf-8?B?aFFxekhjZEJzTDdjazRYR1o4UDJUbjFVWDBya0JVcU16QUhhUEJsQWg3Q3pK?=
 =?utf-8?B?ekhid253djNhSC9UWHJWMzdoWUdUYjZaVG1qcEdNUnAxQmUzdnprT3lDZ1Zo?=
 =?utf-8?B?R2lxelp0elREZkdtb3BlUjdWV2lUczMvZXRMNDRtc0M1RHdiQzJMc0lVeFVE?=
 =?utf-8?B?WTk0NnozMVBRRTByNGJPL0dTcW9BRmtoakM2d1ZWUWRHNGFpeGx3ZFRER21J?=
 =?utf-8?B?Nml4aDZJN2Z5MmJ3UGVPN3dKUlk4YmR2ZDhhTitDK01MUml3eUVNbHQyckRz?=
 =?utf-8?B?UWZHNkVxdVdWYitabHE0Z0JiSGFrL29wWjJQd1hOMXZ6NTZDTDRZbzBaTElU?=
 =?utf-8?B?SGhVYW5nbUYxVFFoL2kyWVlYS2VJSEdYbk5na3RDQXFuUkIrbVpmNENuUjBv?=
 =?utf-8?B?L1N4NmlwdUJPVFRPbXZmSGJUalZudXY5TmVzeWFzOGN6dEkvR3dSdG42em5t?=
 =?utf-8?B?U1JXVnRpOWdUMEwzV1Q0cUFncmI1akJtS25qUHlxM3Bhd1YyM2kxeDA3bHh6?=
 =?utf-8?B?dHJYcWpDb0ozRlhEanVMTWN6V01HZmFESWp0cm5FU1M2M1lmcTFEMms2eG5n?=
 =?utf-8?B?bDh2eS8vL3hkN29MVVhaR3BYSTRZMmMzakYvYUNJNXAyR0ZSVE41MFRHZFlL?=
 =?utf-8?Q?7IDOsa9NSDbP40xZv6lIR0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1846FDF682AC3942A8D164D899716049@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64311f69-b4d9-4ecc-0334-08d9a908fd47
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 13:57:12.3001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7Cy9mzy9gD7TsyF7x8PlziD3VfSfNex+1fZrSTlj3yQooBHdpwPRTqcewaHPD8j/8NQmuQ8UFIP0My6QKY+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3413
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTE2IGF0IDA4OjQ5IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBUaGUgbWVjaGFuaXNtIGluIHVzZSB0byBhbGxvdyB0aGUgY2xpZW50IHRvIHNlZSB0
aGUgcmVzdWx0cyBvZg0KPiBDT1BZL0NMT05FDQo+IGlzIHRvIGRyb3AgdGhvc2UgcGFnZXMgZnJv
bSB0aGUgcGFnZWNhY2hlLsKgIFRoaXMgZm9yY2VzIHRoZSBjbGllbnQgdG8NCj4gcmVhZA0KPiB0
aG9zZSBwYWdlcyBvbmNlIG1vcmUgZnJvbSB0aGUgc2VydmVyLsKgIEhvd2V2ZXIsDQo+IHRydW5j
YXRlX3BhZ2VjYWNoZV9yYW5nZSgpDQo+IHplcm9zIG91dCBwYXJ0aWFsIHBhZ2VzIGluc3RlYWQg
b2YgZHJvcHBpbmcgdGhlbS7CoCBMZXQgdXMgaW5zdGVhZCB1c2UNCj4gaW52YWxpZGF0ZV9pbm9k
ZV9wYWdlczJfcmFuZ2UoKSB3aXRoIGZ1bGwtcGFnZSBvZmZzZXRzIHRvIGVuc3VyZSB0aGUNCj4g
Y2xpZW50DQo+IHByb3Blcmx5IHNlZXMgdGhlIHJlc3VsdHMgb2YgQ09QWS9DTE9ORSBvcGVyYXRp
b25zLg0KPiANCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY0LjcrDQo+IEZpeGVz
OiAyZTcyNDQ4YjA3ZGMgKCJORlM6IEFkZCBDT1BZIG5mcyBvcGVyYXRpb24iKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPg0KPiAtLS0N
Cj4gwqBmcy9uZnMvbmZzNDJwcm9jLmMgfCA1ICsrKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9u
ZnM0MnByb2MuYyBiL2ZzL25mcy9uZnM0MnByb2MuYw0KPiBpbmRleCBhMjQzNDk1MTJmZmUuLmJi
Y2Q0YzgwYzVhNiAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczQycHJvYy5jDQo+ICsrKyBiL2Zz
L25mcy9uZnM0MnByb2MuYw0KPiBAQCAtMjg1LDcgKzI4NSwxMCBAQCBzdGF0aWMgdm9pZCBuZnM0
Ml9jb3B5X2Rlc3RfZG9uZShzdHJ1Y3QgaW5vZGUNCj4gKmlub2RlLCBsb2ZmX3QgcG9zLCBsb2Zm
X3QgbGVuKQ0KPiDCoMKgwqDCoMKgwqDCoMKgbG9mZl90IG5ld3NpemUgPSBwb3MgKyBsZW47DQo+
IMKgwqDCoMKgwqDCoMKgwqBsb2ZmX3QgZW5kID0gbmV3c2l6ZSAtIDE7DQo+IMKgDQo+IC3CoMKg
wqDCoMKgwqDCoHRydW5jYXRlX3BhZ2VjYWNoZV9yYW5nZShpbm9kZSwgcG9zLCBlbmQpOw0KPiAr
wqDCoMKgwqDCoMKgwqBpbnQgZXJyb3IgPSBpbnZhbGlkYXRlX2lub2RlX3BhZ2VzMl9yYW5nZShp
bm9kZS0+aV9tYXBwaW5nLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwb3MgPj4gUEFHRV9TSElGVCwgZW5kID4+DQo+IFBB
R0VfU0hJRlQpOw0KDQpTaG91bGRuJ3QgdGhhdCBiZSAiKGVuZCArIFBBR0VfU0laRSAtIDEpID4+
IFBBR0VfU0hJRlQiIGluIG9yZGVyIHRvDQphbGlnbiB0byB0aGUgc2V0IG9mIHBhZ2VzIHRoYXQg
ZnVsbHkgY29udGFpbnMgdGhlIGJ5dGUgcmFuZ2UgZnJvbSBwb3MNCnRvIGVuZD8NCg0KPiArwqDC
oMKgwqDCoMKgwqBXQVJOX09OX09OQ0UoZXJyb3IpOw0KPiArDQo+IMKgwqDCoMKgwqDCoMKgwqBz
cGluX2xvY2soJmlub2RlLT5pX2xvY2spOw0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG5ld3NpemUg
PiBpX3NpemVfcmVhZChpbm9kZSkpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aV9zaXplX3dyaXRlKGlub2RlLCBuZXdzaXplKTsNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=
