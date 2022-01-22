Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D2E496DFD
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 21:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiAVUal (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 15:30:41 -0500
Received: from mail-mw2nam12on2138.outbound.protection.outlook.com ([40.107.244.138]:3040
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229908AbiAVUal (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 22 Jan 2022 15:30:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAi4UBw30lZzCm+g5a9Z8wUEQJdvwVwZxWkxtgSSr300Z1ScldYNCsNgRuvUdTZY5HK1ifiCP2Ny4zpyByGknhpZArf0LPvIiKVPQ2JkAcgWiy9RzOiqIt/ddO36TihaBIMcUM6ak9fQ8ag69IEPVJPUGZkJFYS83zN18TnBryZAkpIZV9w70pCuykFzDAZeOKSIBg9NjbgIrUnhMg7AgQV02t35giVYHENs5gZSe8BCCqHrTLMrjrzh8vJFMwDk9tSIInOGInCzC8LlbIhMEIuyMXVW+ff449gAcQzwYqtUuxAh69Az1Z0ROr7vEdE9QkIrIOv3az8IithxN83GtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUbM1bJRQ1BysfYNpQWwk/NKa8+GPEQFZeCYz+QM/Vc=;
 b=RKChXjl4QnqhwXEcQaQ1cMn+m1kcHb9mgvwwkolq+BNnKY0ZtehFH6GOtgj/z86NJ6FpptXLQcC7RO8Im3hXK8v3KdIw7f+KbhWPMImLB+N8Z+X0PjgETyzUgQ9Bv4u5MKqdWBQiv5eraEk3PwGgg3z5S+sV4WEFaqC9dBhB03TSyFM1lYW6q9mq1yg++EPVHymbmyE47Yabh8Ft2zVxYhSrW5sIgEJpVGau9Ocfwi5rOIW+5qgGHO1Knxc8dblUKNpFavp6u++LBHswxV1q5AnxozdWsg0QVE9ALYQvKAABSQU3IaFrsdmjRZpZEGTvBCxjvufxkvwUwm2X7AYMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUbM1bJRQ1BysfYNpQWwk/NKa8+GPEQFZeCYz+QM/Vc=;
 b=bjISIlTPWxHFE0b6/GwbjikelZ228GKAaArbEmeTRNhqNUFimTy5bueDOvhHWhTroklzNxY3BVSRlV1T640EYbYfZYNf6VcqZbuGnxB2PNy612tJTuWs4/aMneiV0gTywe0rHKp5E33t2rfoza7qhBOa4O8MsG/gQ9dd/KPKeVQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3346.namprd13.prod.outlook.com (2603:10b6:a03:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.9; Sat, 22 Jan
 2022 20:30:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%5]) with mapi id 15.20.4930.009; Sat, 22 Jan 2022
 20:30:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Topic: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Index: AQHYDvfQx4I0NsJdCEimB7zH1Nz4w6xuD5oAgADuzQCAAEhEgIAAFvGAgAAd+wCAAARMAA==
Date:   Sat, 22 Jan 2022 20:30:37 +0000
Message-ID: <93ef05db51a61c9d2d31788ec96f477502ea2a1a.camel@hammerspace.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
         <20220121185023.260128-1-dan.aloni@vastdata.com>
         <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
         <20220122124710.4l5bzmfxhf2o2yee@gmail.com>
         <04E4C6DC-B78F-45DA-871A-296379B2D484@oracle.com>
         <b780f2adabad8beb13c0deca62561116b61e2402.camel@hammerspace.com>
         <D583D8ED-8E59-4CB2-B65C-AD1C0B332DAD@oracle.com>
In-Reply-To: <D583D8ED-8E59-4CB2-B65C-AD1C0B332DAD@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ea204c0-f48b-4ead-b627-08d9dde60d0a
x-ms-traffictypediagnostic: BY5PR13MB3346:EE_
x-microsoft-antispam-prvs: <BY5PR13MB3346A1D8F2E773CC2F0811A5B85C9@BY5PR13MB3346.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+4DCjXKYaBXTviYrsnV2Fuv0IuNgASUA0UiLZiU77b1TWN+Juhdp4CKxOJcSBaq7Qr4MnDig4o4NNsaa4nmmWq/lHtrcBueqWegWKGw4Fz5FNj0gO3r5NvcMNlTmX7J1TdPe6Ae4xo9a6a3fNOKgNnNkIDFj47NIzAgtVV9hiy7iciWkSK+eZ2BwLZH6TZ4kdLIIgLh9vT+ZmskR8X0yzE8BCUqXKpmwLJTcbJS7RgPB01idBOacO4UU9MR5vBpt3V0ZZTH5wb1NAQn6B+UJBztGV0NKZQV9wrlsOy2CsZfCQSIaugENZYNt3tsP1HxYn01eyqPuKMkpSUmDkZlrEf88zzmtQY3zdKC0M4bwsqZ50st/8QsvXJFGEtRfknkWwaXC9mhqAnh4D9ZqK95FO1NPZiXCQ1dWomN4fr9XUpwJVC9+UjWEk9Ydq8+Bwff6URKfOoOMkVvHwogtNL1XiU9XoR3l6KKp1DvyI3CYk63apnYPQgbxKBQEjZ86e5YNovNWrY+bVT5Lzvdv1kDsZw27Ee7FPZY33n6IBg102BiBtxQhX5pCrQLdBZRc9vyVHmP9vt8GAmsBuNlYntWkF2ob9cKvqHSQvBJQGFv1AWplbj6sVYoiILyA/W11GtRaCYm6EYAQhndsZvIwXx83szQCzZfBd89PbzY4T/GO/TjF6yleN+ol8NuTGDx7FRCUQM4IoSSODVMcAOyd6fvS0/IXvnqe655RdfZU0O76f9NM5VjE3ILRVF4lZkkX9rT75owciTdVpSz30/2F1mm9jcZKj0V/wNQUXsq1/cvpXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(396003)(136003)(39830400003)(366004)(83380400001)(76116006)(54906003)(6916009)(71200400001)(36756003)(316002)(2616005)(6512007)(5660300002)(26005)(6506007)(86362001)(8936002)(4326008)(64756008)(186003)(8676002)(2906002)(66446008)(66476007)(53546011)(66556008)(66946007)(6486002)(38100700002)(38070700005)(966005)(122000001)(508600001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHQxanUrWjVESUtWMkVDMXNPSWlTNGNCdUVlakdCcnJ0NkNDc3hJbk5UUFkw?=
 =?utf-8?B?VEdqTXNBeVBXK2hrQWVoY0tKRC9jZHFJU3B4bnVxeStMV0JpdjIzN2E3NVZ4?=
 =?utf-8?B?cEVlK0kyTE9oTmVDOVp5VllYR2NIWnRSTlh4bVZ1UWVHb2RsY3JNSzZUNGdO?=
 =?utf-8?B?STNZa3RYOVhFcHN3NW5kOVZiRE5rUGNqQ0hVd2pHWWlueWZWTEFRTlplL0o0?=
 =?utf-8?B?WGIwSHlmZWJUMTdQRlc3akZVK1ZEUmdOdURUQnFPOWFJcDRNMXo3MU9RVkRt?=
 =?utf-8?B?VytZS0JBNWJzcmJjUlpqeU52YVdEa25DbGluWnJVK3NSOC91WndDNlhCdUo0?=
 =?utf-8?B?TnV4cU1MQ3pxZ1ZWcGZMVEF6cVBEL2krRXNsSnNlUjF2Y3RxZWNoSHFHdlRH?=
 =?utf-8?B?VkVGSTMvUjdIWUpZTC94VU9zRmxlb2o2S0xIam5oaDlVRm5YVkQ0M0psVUFy?=
 =?utf-8?B?aFYraXBQcmpjTkJ4dk5aMjZMVXFLQlZHbk9aOVhvcnhXV2t3YmJPMHNwK2F4?=
 =?utf-8?B?aEhJWHB0Sk9yeDFWdlBuVlhST1hSOEw3UEtpRldRcW1sV0puajVDejNKK1lV?=
 =?utf-8?B?ZlhQSE50ZzdXOW5IY0FsamEwM2wyY1ZUYm5UWG5PNkgrMmlDRm56emdKWTZV?=
 =?utf-8?B?RnpySVI2Uk12clV2N1p1bE1CODgraVREOHJqTmFkanRES3hWRjRoY01UV1Q0?=
 =?utf-8?B?MmdnRkE2ZDRqR01TS3BFK2VtcWR5WXZxSng3NjdwdllZWHEweTJoMnkxd2Jp?=
 =?utf-8?B?OWtjOW1WWlMyaC9Hejl4REFOYWhtaHUrNlI1eUlNQ0VqSHg4aVdyTFE1WXBN?=
 =?utf-8?B?V0VVT1gyVWlvOG1SamRTdWNFa2luRnNybVNvZFpBdXVpTWNKTy9sTEp5WjdY?=
 =?utf-8?B?RndmNVJ6UDdtN3o0OVpxU2tvRGU4SEQ5M25ZdUZKL0s5QjR2TnF3MkJVSmxV?=
 =?utf-8?B?TkFvazJBWVNhNUZtQVhlbEZxSEZpRmtlUmF5RnVWYUZCZWFucWxhZklsTUpL?=
 =?utf-8?B?dFFRNUxQL1ZVTFliK0dESXZSRVdjb052UUxsWWNoYWxYZ0o4L2NETlpBSk4z?=
 =?utf-8?B?V3NJTWZFYy9MSHlLNkF2QU9tWWpLMnBIYVBCMXY0azlGV05JeVdxSmVNbGxi?=
 =?utf-8?B?eW02WXM5UHlRQWhXQWVhSmhoZWZtUVBXRlg0VE1YdTRHK1BMN2RYUVpWQ0J6?=
 =?utf-8?B?ZGUydDFpN1ZWcldVVUVCUmVxemJabkdlMHg2dzBFQjErVGJVTzc1MmRZZEcv?=
 =?utf-8?B?aTZIYmVJcjhyTmNCZE5rcnptVjFSMjFnZkVsODhaZ0t3bTMyOUU3bXVrODRi?=
 =?utf-8?B?WHdnM1F4cHBjQzRiYkFlNEVkOUYrckNBUEx0MUNRVVcwTzNmUlB5NUtFbCts?=
 =?utf-8?B?UXcva1h4K3k0aGp3bE5kaC82MjFiL3B5Qk5HVVdwd2owZURvZXBaNmJwVHRZ?=
 =?utf-8?B?alFXdzRTRHVVRXFWaU4rakgyYlNlei9xakFBdGJGVVpYRWVCQUc2WGprTy9P?=
 =?utf-8?B?SERjclZwR2wrLzVTeTR2bFN0Um83MjdsVUFLZWp5YmI5SXhFbmwzeTRMS0d6?=
 =?utf-8?B?dnE1c2I3S1JxbUNlMm9oMHBqL2xhK0F5eUc3UFNlZmZvT2U4N3lWMUtkT0xJ?=
 =?utf-8?B?OXpRQXQxWi9KTENvLy9JVlFTSC9Ha0ZzZFdyWm43enVjaVJtOHZEWVdVK2Fm?=
 =?utf-8?B?ZVVsc3ZhbTA2TEcya2hIZDdtWGl5TzNrUzYrd3ZzM3lDZGNlc3AwT0ppdXkx?=
 =?utf-8?B?dnh1T050QkFVVDRzS0dTQkhZNVgyU1FLOGFZbHZhTmhpS01xbDRKY1A2NVVK?=
 =?utf-8?B?Y210MDJlZ0NhcHExanA1M0c0cGllRkZ0U09jQ1lhbXpDamswMm5iTk9ZcXlT?=
 =?utf-8?B?dUVrZ0t1NkRZUWhKak5oTEtFUGtaWE9RM2ZwK21RYzhYNzh5emRqTmtiYmgz?=
 =?utf-8?B?SUhWMzV4YVR1WkRJSXNCc2lMYjdLNVRtTGI5TGpjSTdNampDdHhncXQwMHlE?=
 =?utf-8?B?NjNkZXYzY01LSExHK2lzZ1FLbSt4NVdCTFhkdHBpNTV4OVMrenBydnlaUE0r?=
 =?utf-8?B?alNabVBBRTJGbGhaTWF1Q3hCeEhvUWpYbXgrQjNOYVRubk1yTVdTY2FiK3J1?=
 =?utf-8?B?akltaTdYL01udVVjaDdha09hblJCQWx2ZC92VEQrbEtiS3p1U1RqcHh5ZTBV?=
 =?utf-8?Q?4YdN0I66iy9KtZeMI/xuri8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <340F12F8B4B98D41A4F8A0FB298F9E16@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea204c0-f48b-4ead-b627-08d9dde60d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 20:30:37.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjAnuRlxNwoxDHsPK27V1QhDpQXHcBbqzoDXgjR/wTwQRtnIBCZNhYlzn0m+OXXYKTqPnLmTinIhrsW3COl3uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3346
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTAxLTIyIGF0IDIwOjE1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKYW4gMjIsIDIwMjIsIGF0IDE6MjcgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gU2F0
LCAyMDIyLTAxLTIyIGF0IDE3OjA1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiANCj4gPiA+ID4gT24gSmFuIDIyLCAyMDIyLCBhdCA3OjQ3IEFNLCBEYW4gQWxvbmkgPGRhbi5h
bG9uaUB2YXN0ZGF0YS5jb20+DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24g
RnJpLCBKYW4gMjEsIDIwMjIgYXQgMTA6MzI6MjhQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJDQo+
ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gSmFuIDIxLCAyMDIyLCBhdCAxOjUwIFBNLCBE
YW4gQWxvbmkNCj4gPiA+ID4gPiA+IDxkYW4uYWxvbmlAdmFzdGRhdGEuY29tPg0KPiA+ID4gPiA+
ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IER1ZSB0byBjaGFuZ2UgOGNmYjkw
MTUyODBkICgiTkZTOiBBbHdheXMgcHJvdmlkZSBhbGlnbmVkDQo+ID4gPiA+ID4gPiBidWZmZXJz
IHRvIHRoZQ0KPiA+ID4gPiA+ID4gUlBDIHJlYWQgbGF5ZXJzIiksIGEgcmVhZCBvZiAweGZmZiBp
cyBhbGlnbmVkIHVwIHRvIHNlcnZlcg0KPiA+ID4gPiA+ID4gcnNpemUgb2YNCj4gPiA+ID4gPiA+
IDB4MTAwMC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQXMgYSByZXN1bHQsIGluIGEgdGVz
dCB3aGVyZSB0aGUgc2VydmVyIGhhcyBhIGZpbGUgb2Ygc2l6ZQ0KPiA+ID4gPiA+ID4gMHg3ZmZm
ZmZmZmZmZmZmZmZmLCBhbmQgdGhlIGNsaWVudCB0cmllcyB0byByZWFkIGZyb20gdGhlDQo+ID4g
PiA+ID4gPiBvZmZzZXQNCj4gPiA+ID4gPiA+IDB4N2ZmZmZmZmZmZmZmZjAwMCwgdGhlIHJlYWQg
Y2F1c2VzIGxvZmZfdCBvdmVyZmxvdyBpbiB0aGUNCj4gPiA+ID4gPiA+IHNlcnZlciBhbmQgaXQN
Cj4gPiA+ID4gPiA+IHJldHVybnMgYW4gTkZTIGNvZGUgb2YgRUlOVkFMIHRvIHRoZSBjbGllbnQu
IFRoZSBjbGllbnQgYXMNCj4gPiA+ID4gPiA+IGENCj4gPiA+ID4gPiA+IHJlc3VsdA0KPiA+ID4g
PiA+ID4gaW5kZWZpbml0ZWx5IHJldHJpZXMgdGhlIHJlcXVlc3QuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gQW4gaW5maW5pdGUgbG9vcCBpbiB0aGlzIGNhc2UgaXMgYSBjbGllbnQgYnVnLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFNlY3Rpb24gMy4zLjYgb2YgUkZDIDE4MTMgcGVybWl0cyB0aGUg
TkZTdjMgUkVBRCBwcm9jZWR1cmUNCj4gPiA+ID4gPiB0byByZXR1cm4gTkZTM0VSUl9JTlZBTC4g
VGhlIFJFQUQgZW50cnkgaW4gVGFibGUgNiBvZiBSRkMNCj4gPiA+ID4gPiA1NjYxIHBlcm1pdHMg
dGhlIE5GU3Y0IFJFQUQgb3BlcmF0aW9uIHRvIHJldHVybg0KPiA+ID4gPiA+IE5GUzRFUlJfSU5W
QUwuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2FzIHRoZSBjbGllbnQgc2lkZSBmaXggZm9yIHRo
aXMgaXNzdWUgcmVqZWN0ZWQ/DQo+ID4gPiA+IA0KPiA+ID4gPiBZZWFoLCBzZWUgVHJvbmQncyBy
ZXNwb25zZSBpbg0KPiA+ID4gPiANCj4gPiA+ID4gwqANCj4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtbmZzL2ZhOTk3NDcyNDIxNmM0M2Y5YmRiM2ZkMzk1NTVkMzk4ZmRlMTFl
NTkuY2FtZWxAaGFtbWVyc3BhY2UuY29tLw0KPiA+ID4gPiANCj4gPiA+ID4gU28gaXQgaXMgYm90
aCBhIGNsaWVudCBhbmQgc2VydmVyIGJ1Z3M/DQo+ID4gPiANCj4gPiA+IFNwbGl0dGluZyBoYWly
cywgYnV0IHllcyB0aGVyZSBhcmUgaXNzdWVzIG9uIGJvdGggc2lkZXMNCj4gPiA+IElNTy4gQmFk
IGJlaGF2aW9yIGR1ZSB0byBidWdzIG9uIGJvdGggc2lkZXMgaXMgYWN0dWFsbHkNCj4gPiA+IG5v
dCB1bmNvbW1vbi4NCj4gPiA+IA0KPiA+ID4gVHJvbmQgaXMgY29ycmVjdCB0aGF0IHRoZSBzZXJ2
ZXIgaXMgbm90IGRlYWxpbmcgdG90YWxseQ0KPiA+ID4gY29ycmVjdGx5IHdpdGggdGhlIHJhbmdl
IG9mIHZhbHVlcyBpbiBhIFJFQUQgcmVxdWVzdC4NCj4gPiA+IA0KPiA+ID4gSG93ZXZlciwgYXMg
SSBwb2ludGVkIG91dCwgdGhlIHNwZWNpZmljYXRpb24gcGVybWl0cyBORlMNCj4gPiA+IHNlcnZl
cnMgdG8gcmV0dXJuIE5GU1szNF1FUlJfSU5WQUwgb24gUkVBRC4gQW5kIGluIGZhY3QsDQo+ID4g
PiB0aGVyZSBpcyBhbHJlYWR5IGNvZGUgaW4gdGhlIE5GU3Y0IFJFQUQgcGF0aCB0aGF0IHJldHVy
bnMNCj4gPiA+IElOVkFMLCBmb3IgZXhhbXBsZToNCj4gPiA+IA0KPiA+ID4gwqA3ODXCoMKgwqDC
oMKgwqDCoMKgIGlmIChyZWFkLT5yZF9vZmZzZXQgPj0gT0ZGU0VUX01BWCkNCj4gPiA+IMKgNzg2
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG5mc2Vycl9pbnZhbDsNCj4g
PiA+IA0KPiA+ID4gSSdtIG5vdCBzdXJlIHRoZSBzcGVjaWZpY2F0aW9ucyBkZXNjcmliZSBwcmVj
aXNlbHkgd2hlbg0KPiA+ID4gdGhlIHNlcnZlciAvbXVzdC8gcmV0dXJuIElOVkFMLCBidXQgdGhl
IGNsaWVudCBuZWVkcyB0bw0KPiA+ID4gYmUgcHJlcGFyZWQgdG8gaGFuZGxlIGl0IHJlYXNvbmFi
bHkuIElmIElOVkFMIHJlc3VsdHMgaW4NCj4gPiA+IGFuIGluZmluaXRlIGxvb3AsIHRoZW4gdGhh
dCdzIGEgY2xpZW50IGJ1Zy4NCj4gPiA+IA0KPiA+ID4gSU1PIGNoYW5naW5nIHRoZSBhbGlnbm1l
bnQgZm9yIHRoYXQgY2FzZSBpcyBhIGJhbmQtYWlkLg0KPiA+ID4gVGhlIHVuZGVybHlpbmcgbG9v
cGluZyBiZWhhdmlvciBpcyB3aGF0IGlzIHRoZSByb290DQo+ID4gPiBwcm9ibGVtLiAoU28uLi4g
SSBhZ3JlZSB3aXRoIFRyb25kJ3MgTkFDSywgYnV0IGZvcg0KPiA+ID4gZGlmZmVyZW50IHJlYXNv
bnMpLg0KPiA+IA0KPiA+IElmIEknbSByZWFkaW5nIERhbidzIHRlc3QgY2FzZSBjb3JyZWN0bHks
IHRoZSBjbGllbnQgaXMgdHJ5aW5nIHRvDQo+ID4gcmVhZA0KPiA+IGEgZnVsbCBwYWdlIG9mIDB4
MTAwMCBieXRlcyBzdGFydGluZyBhdCBvZmZzZXQgMHg3ZmZmZmZmZmZmZmZmZjAwMC4NCj4gPiBU
aGF0IG1lYW5zIHRoZSBlbmQgb2Zmc2V0IGZvciB0aGF0IHJlYWQgaXMgMHg3ZmZmZmZmZmZmZmZm
ZjAwMCArDQo+ID4gMHgxMDAwDQo+ID4gLSAxID0gMHg3ZmZmZmZmZmZmZmZmZmZmLg0KPiA+IA0K
PiA+IElPVzogYXMgZmFyIGFzIHRoZSBzZXJ2ZXIgaXMgY29uY2VybmVkLCB0aGVyZSBpcyBubyBs
b2ZmX3Qgb3ZlcmZsb3cNCj4gPiBvbg0KPiA+IGVpdGhlciB0aGUgc3RhcnQgb3IgZW5kIG9mZnNl
dCBhbmQgc28gdGhlcmUgaXMgbm8gcmVhc29uIGZvciBpdCB0bw0KPiA+IHJldHVybiBORlM0RVJS
X0lOVkFMLg0KPiANCj4gWWVwLCBJIGFncmVlIHRoZXJlJ3Mgc2VydmVyIG1pc2JlaGF2aW9yLCBh
bmQgSSB0aGluayBEYW4ncw0KPiBzZXJ2ZXIgZml4IGlzIG9uIHBvaW50Lg0KPiANCj4gSSB3b3Vs
ZCBsaWtlIHRvIGtub3cgd2h5IHRoZSBjbGllbnQgaXMgbG9vcGluZywgdGhvdWdoLiBJTlZBTA0K
PiBpcyBhIHZhbGlkIHJlc3BvbnNlIHRoZSBMaW51eCBzZXJ2ZXIgYWxyZWFkeSB1c2VzIGluIG90
aGVyDQo+IGNhc2VzIGFuZCBieSBpdHNlbGYgc2hvdWxkIG5vdCB0cmlnZ2VyIGEgUkVBRCByZXRy
eS4NCj4gDQo+IEFmdGVyIGNoZWNraW5nIHRoZSByZWxldmFudCBYRFIgZGVmaW5pdGlvbnMsIGFu
IE5GUyBSRUFEIGVycm9yDQo+IHJlc3BvbnNlIGRvZXNuJ3QgaW5jbHVkZSB0aGUgRU9GIGZsYWcs
IHNvIEknbSBhIGxpdHRsZSBteXN0aWZpZWQNCj4gd2h5IHRoZSBjbGllbnQgd291bGQgbmVlZCB0
byByZXRyeSBhZnRlciByZWNlaXZpbmcgSU5WQUwuDQoNCldoaWxlIHdlIGNvdWxkIGNlcnRhaW5s
eSBhZGQgdGhhdCBlcnJvciB0byBuZnNfZXJyb3JfaXNfZmF0YWwoKSwgdGhlDQpxdWVzdGlvbiBp
cyB3aHkgdGhlIGNsaWVudCBzaG91bGQgbmVlZCB0byBoYW5kbGUgTkZTNEVSUl9JTlZBTCBpZiBp
dCBpcw0Kc2VuZGluZyB2YWxpZCBhcmd1bWVudHM/DQoNCjE1LjEuMS40LiAgTkZTNEVSUl9JTlZB
TCAoRXJyb3IgQ29kZSAyMikNCg0KICAgVGhlIGFyZ3VtZW50cyBmb3IgdGhpcyBvcGVyYXRpb24g
YXJlIG5vdCB2YWxpZCBmb3Igc29tZSByZWFzb24sIGV2ZW4NCiAgIHRob3VnaCB0aGV5IGRvIG1h
dGNoIHRob3NlIHNwZWNpZmllZCBpbiB0aGUgWERSIGRlZmluaXRpb24gZm9yIHRoZQ0KICAgcmVx
dWVzdC4NCg0KDQpTdXJlLi4uIFdoYXQgZG9lcyB0aGF0IG1lYW4sIGFuZCB3aGF0IGRvIEkgZG8/
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
