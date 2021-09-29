Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F269041CA05
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbhI2QZ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 12:25:27 -0400
Received: from mail-bn8nam11on2124.outbound.protection.outlook.com ([40.107.236.124]:58795
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233501AbhI2QZ1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Sep 2021 12:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddQl73qCIro5193QVtOh64HRPxfYtlntjdGg/jitE9OMjy1vStD85+aDU3GtjlOixhN78xOQiAhAiW8+DiFDDWtnHQ5daH0yplNArpoZD9DWrAhrsHxQDVhvSKfIX9VCmVqSE6WzMFbFkE22botKXeAXtE5V+veGGfQD21wr1iqJHYTzFzKPywkcP8D3FdHiJZR4BmP8XaO7q2/P6HjM2/bBX9Th8gugP149vq5mDfLGkw38MwvVesaAppGC4ZpCX6fPum+udTFVCy81/BSbdstuByK2IAHcfKG1yJffEnmGNA4ui4LpV+yTdmbmVN0mgk9biuxd6EZXGwshc/STwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5o9tIDYqb5m4c61AhlEOi9e17z7cuFAe5cuk6HXQrs=;
 b=U2bi4NsKSA99GQzYrrruJkC6sFR+ETBSt6XpIw7k7CsmR1ni1APzk9rf1ahNKmtxCqcCvcn3pLu+npqN8236FTGk1s2EKt1fJeOm1PRzCVV8YGA1plDYM4akzhVrhaf4QV/BazmVHjR/wPtEYyL+PLTnaMal1lHrCMMOkaGh7ltEQglT4/waZ9M5yU6LhNLamNgfpQ5bnmIPsUSMUho1B95c181jdtOwKFTCJrPI0s2ozx9i1zuI7yEFY4wqh5RR38asPHDgWI0+JluECWw7ofxz3joCyUht09xTyEpJgX6cGtpgq/UObCBUGbfERv6GWPdcu4z3MkskgDgZFY8KRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5o9tIDYqb5m4c61AhlEOi9e17z7cuFAe5cuk6HXQrs=;
 b=RHm9b32Iu5lzxYeshnVDFIp5O72AH3W4ErcM60P0ez4SWod2zmOt3a8xqZIIdoo0yVYiw0N5peZJzrlQWDS+eaSdWqUa+I+YTnFrwR2c8/1LLdZduf4iaEu9pCIPV6o4IunpCxfddTewHjykJqupUbs2vgkT5dfXk5zEbMkAhuc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3800.namprd13.prod.outlook.com (2603:10b6:610:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.9; Wed, 29 Sep
 2021 16:23:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4566.014; Wed, 29 Sep 2021
 16:23:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] NFS: Further optimisations for 'ls -l'
Thread-Topic: [PATCH 4/5] NFS: Further optimisations for 'ls -l'
Thread-Index: AQHXtTjgd3gxxmyKIUOhzT+omYBuM6u7GfkAgAAYUIA=
Date:   Wed, 29 Sep 2021 16:23:43 +0000
Message-ID: <f09a7c00b70d51a442542dec1e1ba98289ad612c.camel@hammerspace.com>
References: <20210929134944.632844-1-trondmy@kernel.org>
         <20210929134944.632844-2-trondmy@kernel.org>
         <20210929134944.632844-3-trondmy@kernel.org>
         <20210929134944.632844-4-trondmy@kernel.org>
         <C9ED123C-A092-4417-8597-AB6267379E2F@redhat.com>
In-Reply-To: <C9ED123C-A092-4417-8597-AB6267379E2F@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7839fb84-dff0-4d9f-866a-08d983658163
x-ms-traffictypediagnostic: CH2PR13MB3800:
x-microsoft-antispam-prvs: <CH2PR13MB38002E697A52BC7BBB2C740FB8A99@CH2PR13MB3800.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: doYVLpSoLevSRPCJh6XjOES/REvdEH1s7OXW/APl6CJub1AgTcQ7AjWibkz0unwYY7+hh1honbYsYkeUiQfo2HGU/Fy7aSkUu+ecXZXcfcpC2Y5L5ZJ1Aicr1h31Tx4cdUUvdIDCcDleW2poKtPFQJJ2/SbaR62I/BZQadApkTgEAT9Gt2c00Bv81+x+5QOkiJtn3niAKTvD7doiSaRZ56eKWz1uOMdpEreBBwZo6LyXSCd251YZXxsNqAlFN/v1lh1c+ey81rrm0z5X74zwukuYdxwNmvCFbwzktG0YDA1HPf0G7BNsv5k97Faanok8sL8HFxmQC2vLTsh9QnvJtd0b4OjtcAGFBPP02K9uS/GHgC/Ua5m88xgzEgfmmb1R2AGPEQx+y4Z7BYh9E3FzelNraychnhjph00DD9A7P0OTjkMU232y2TqX1/0vsc//hIJIwG2bnWWhec4zLXuEJWOtweZCOn5xQ2JX3yBHJ7gpU9sMU7i11TplFjz5XAVtqC2Eo2G7vk/piDtGt7Ytoj1M3WQqHOI09YyD2CxU+vMw/7TWEgfEvb5paiDjTkM752SOBqHVumKLlzgBw8hduNarHJuS0AJzERqa2BTM+eD+t3JQw5/0w1a3YL5U0iN/yrriZ4cB1aJ0Vo2fBE1NmQKQkMWjYl6nQoxCimLkjJ98C5Wu2mu7qRCD78Mr0wpQGNXQASLkr+pqkbRpMyHoKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(316002)(38070700005)(6506007)(71200400001)(8936002)(53546011)(6486002)(36756003)(186003)(26005)(5660300002)(2616005)(2906002)(76116006)(38100700002)(8676002)(122000001)(6916009)(83380400001)(66556008)(64756008)(66946007)(86362001)(66446008)(66476007)(4326008)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnV4Q2k1RmIvT0czWGhuUkczTTEyc3dJU2IyVjQyWllQamZTV243ZEhKTGlp?=
 =?utf-8?B?R1ZHYnZxNzhiNzJyeWYvTWdONWNWb0lscEZ3YXBSc1E2Mlc4Y2tJaENLbjk5?=
 =?utf-8?B?Z2RnZ3djR0g0TEFtTVRyOWxJTGF0dmpFcklOVy9QM3Mwc01LUlU2VnhhL2M3?=
 =?utf-8?B?ekRmY3ZhVURnS1lPa2djWTRVMmZ1dmorVHcrZlhVL21ycVNKVTdXby9XOU5u?=
 =?utf-8?B?UXkzRUFHNmFCdFFyL3NDZG1zT3FlM2UyeVVlSzd2dEU5ZnNBb2JiTks5dmF1?=
 =?utf-8?B?Ri9lbHpmN2gzbW5KS09GaDJHR0lXSDk3VHFtbmFaUTg5TE1JRU85L1VSTTl2?=
 =?utf-8?B?RFZRcml4MFU2N1ZlajJBYVo3VEhTUnVTM0xwenJoNXZWVUFuYWVxWWtlc1VM?=
 =?utf-8?B?RW1FOXVLYVR6ejNlRVJtTjRDR0VySDJnS1IwWllQQnB2ODVsUlZSaXFaTjdr?=
 =?utf-8?B?VEJhS2V6VXJ3ck9WR0lwekZWaE42L1Y3akt0bEdDZ0JUN0d0aGpxdDd6US9s?=
 =?utf-8?B?Y3RMMnJGbXE2SzhNZ1ZaUWhIRno0OTBzQVJqNEpLeXlWMEoxd1dEandWWmJC?=
 =?utf-8?B?LzRCNWdRSHV5WElvSGVldjdJb2ZLbjJMZHpSL3ZHLzNXRkZSL0dyK25KMHAw?=
 =?utf-8?B?YS8yWU9zUUVXM3lteWFpMDIwNGZMZzZHTTZTWDNzbE52QStTbTVhZXJOZGJk?=
 =?utf-8?B?MWJaRHorYnVkZDlkQVh0TU9jclpnVHBQZFBaQlRnUUVsVWozdm8zRXhsbGJP?=
 =?utf-8?B?YjZ1alRiQk1pVExEeHpZNzF5c2g1WWd1NVM1QXZCQXdnbnRaaXBmK2E4RU01?=
 =?utf-8?B?d1VHYVJjSmV2SEM4UzRBbFBoKzRuamlCNkNqOGpNbFhKYzBhenBnVThnUWVr?=
 =?utf-8?B?YUdVZUF1WmZTN1l1SVVQa2NnWjRuSDM2b0JCWUtnZ2ltY3dhQVhMY0djWHRS?=
 =?utf-8?B?RWJFQzlDaVBxOE9hWFlOSGJ1b2dCUVBCRXhMSDAyb3h6R0VQRjFSSkRYaGpN?=
 =?utf-8?B?SWQ0K3Y4dUw3bEtCbWJHclVaa3lKdFJ0QXl4OWFCYXJkMEQ2U0dwa2pjZ3Mz?=
 =?utf-8?B?VDU3N1lRSUJBV2tnUjM1em9lVnI0SkVWV1hIdTAyVHRnQStpYUc4Qllzcysx?=
 =?utf-8?B?N2RndXBtdmVyN202a1FjSFJzbld0T0swUy81aVNBbEx2RDNvVXk3Tk9kTFRV?=
 =?utf-8?B?Ty9pVE14dTZlOHI5Y21DdmY2V0JKUTF4Q3QyNHhyenRuRGFVVHJJcWZkekFY?=
 =?utf-8?B?akRvZGo0aFhhS0lLLzlmYXBRenJPQkVueUJZR0t5T2Q0ZjZvNTg5T01uUC9P?=
 =?utf-8?B?cHAyQ2JGbHF6aU51ZklhTG9yMlNsZlRrNm5lRFM1Y2dwMTNzZmpqRzh0cDIx?=
 =?utf-8?B?aDhCUllyOEthTVBGQTU4TVhLV202YlF4ZTB4UmJKcTg2TVFJWEp5OVM0dzY3?=
 =?utf-8?B?VFQ3a0xpZ0U1RU9ZLzJmT2llYlVnUnh4YWlhOXBzYmlEOW4yUXE3bDJqejI0?=
 =?utf-8?B?SXlwQjZJMUQ3bHhGTW1NUWNRU09tVGJibStiK1lIVWgrUG9DM2lzcHR6ZUc3?=
 =?utf-8?B?MmROWEhCdlpKdWljQk9ja0h0VGg0MVJTSzNKM1dQYjM2STlEYUlNd3UyelJH?=
 =?utf-8?B?SzBUNTFvc0lDU1kxVEJkamZpU1hQbkx1bWJ0dTgySTFkS0ExRXZBb013M2hw?=
 =?utf-8?B?SWF1OTBqNUFUOEJ1a1grZkJ5b0FDYVNqVjZzTWd2ZEMxTFZ1N0VTeVVLK0J3?=
 =?utf-8?Q?t1xlFvGEDil7Rae+ZgLjGdCDUGxPq9SeyhxngXu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <19405DF7112E4046BA5F97B25540931A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7839fb84-dff0-4d9f-866a-08d983658163
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 16:23:43.4408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ga1f5KJE0lKGiRwowDGc5E7heQACPfqpdRMl9dSDJb+o1h+yy7Z7nC3T11JIVotyzMh4PMgBDuRarWLu1KarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3800
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA5LTI5IGF0IDEwOjU2IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyOSBTZXAgMjAyMSwgYXQgOTo0OSwgdHJvbmRteUBrZXJuZWwub3JnwqB3cm90
ZToNCj4gDQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tPg0KPiA+IA0KPiA+IElmIGEgdXNlciBpcyBkb2luZyAnbHMgLWwnLCB3ZSBoYXZl
IGEgaGV1cmlzdGljIGluIEdFVEFUVFIgdGhhdA0KPiA+IHRlbGxzDQo+ID4gdGhlIHJlYWRkaXIg
Y29kZSB0byB0cnkgdG8gdXNlIFJFQURESVJQTFVTIGluIG9yZGVyIHRvIHJlZnJlc2ggdGhlDQo+
ID4gaW5vZGUNCj4gPiBhdHRyaWJ1dGVzLiBJbiBjZXJ0YWluIGNpcnVtc3RhbmNlcywgd2UgYWxz
byB0cnkgdG8gaW52YWxpZGF0ZSB0aGUNCj4gPiByZW1haW5pbmcgZGlyZWN0b3J5IGVudHJpZXMg
aW4gb3JkZXIgdG8gZW5zdXJlIHRoaXMgcmVmcmVzaC4NCj4gPiANCj4gPiBJZiB0aGVyZSBhcmUg
bXVsdGlwbGUgcmVhZGVycyBvZiB0aGUgZGlyZWN0b3J5LCB3ZSBwcm9iYWJseSBzaG91bGQNCj4g
PiBhdm9pZA0KPiA+IGludmFsaWRhdGluZyB0aGUgcGFnZSBjYWNoZSwgc2luY2UgdGhlIGhldXJp
c3RpYyBicmVha3MgZG93biBpbg0KPiA+IHRoYXQNCj4gPiBzaXR1YXRpb24gYW55d2F5Lg0KPiAN
Cj4gSGkgVHJvbmQsIEknbSBjdXJpb3VzIGFib3V0IHRoZSBtb3RpdmF0aW9uIGZvciB0aGlzIHdv
cmsgYmVjYXVzZQ0KPiB3ZSdyZSBvZnRlbg0KPiBtYW5hZ2luZyBleHBlY3RhdGlvbnMgYWJvdXQg
cGVyZm9ybWFuY2UgYmV0d2VlbiB2YXJpb3VzIHdvcmtsb2Fkcy7CoA0KPiBXaGF0DQo+IGRvZXMg
dGhlIHdvcmtsb2FkIGxvb2sgbGlrZSB0aGF0IHByb21wdGVkIHlvdSB0byBtYWtlIHRoaXMNCj4g
b3B0aW1pemF0aW9uPw0KPiANCj4gSSdtIGFsc28gaW50ZXJlc3RlZCBiZWNhdXNlIEkgaGF2ZSBz
b21lIHdvcmsgdGhhdCBpbXByb3ZlcyByZWFkZGlyDQo+IHBlcmZvcm1hbmNlIGZvciBtdWx0aXBs
ZSByZWFkZXJzIG9uIGxhcmdlIGRpcmVjdG9yaWVzLCBidXQgaXMgcm90dGluZw0KPiBiZWNhdXNl
IHRoaW5ncyBoYXZlIGJlZW4gImdvb2QgZW5vdWdoIiBmb3IgZm9sa3Mgb3ZlciBoZXJlLg0KPiAN
Cg0KQXJlIHlvdSB0YWxraW5nIGFib3V0IHRoaXMgcGF0Y2ggc3BlY2lmaWNhbGx5LCBvciB0aGUg
c2VyaWVzIGluDQpnZW5lcmFsPw0KDQpUaGUgZ2VuZXJhbCBtb3RpdmF0aW9uIGZvciB0aGUgc2Vy
aWVzIGlzIHRoYXQgaW4gY2VydGFpbiBjaXJjdW1zdGFuY2VzDQppbnZvbHZpbmcgYSByZWFkLW9u
bHkgc2NlbmFyaW8gKG5vIGNoYW5nZXMgdG8gdGhlIGRpcmVjdG9yeSkgYW5kDQptdWx0aXBsZSBw
cm9jZXNzZXMgd2UncmUgc2VlaW5nIGEgcmVncmVzc2lvbiB3LnIudC4gb2xkZXIga2VybmVscy4N
Cg0KVGhlIG1vdGl2YXRpb24gZm9yIHRoaXMgcGFydGljdWxhciBwYXRjaCBpcyB0d29mb2xkOg0K
ICAgMS4gSSB3YW50IHRvIGdldCByaWQgb2YgdGhlIGNhY2hlZCBwYWdlX2luZGV4IGluIHRoZSBp
bm9kZSBhbmQNCiAgICAgIHJlcGxhY2UgaXQgd2l0aCBzb21ldGhpbmcgbGVzcyBwZXJzaXN0ZW50
IChpbm9kZXMgYXJlIGZvcmV2ZXIsDQogICAgICB1bmxpa2UgZmlsZSBkZXNjcmlwdG9ycykuDQog
ICAyLiBUaGUgaGV1cmlzdGljIGluIHF1ZXN0aW9uIGlzIGRlc2lnbmVkIHRvIG9ubHkgd29yayBp
biB0aGUgc2luZ2xlDQogICAgICBwcm9jZXNzL3NpbmdsZSB0aHJlYWRlZCBjYXNlLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdCBMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo=
