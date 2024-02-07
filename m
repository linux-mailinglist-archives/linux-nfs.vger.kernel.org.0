Return-Path: <linux-nfs+bounces-1816-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414684CC8A
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 15:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEC02877F0
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5BE7A727;
	Wed,  7 Feb 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="K0bDU4lf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2090.outbound.protection.outlook.com [40.107.93.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08A7C088
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315699; cv=fail; b=lP7EO2iE0pQ2HzhZZrvaO1PVUREf4+YvtBglJBgRrDEfZEG0pooG7VuuvCjvR2SvFi2hqN+yA1eXKerR/J6T1cjTyjLzN8OmuPVJXMY7uUWb+p/3sSMnWpdjY+UoWqSUr+RgR4aYY5TPyQh6Qummt1Me9ZgmBbk+Oka1c8b6YdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315699; c=relaxed/simple;
	bh=GbppZw+BfXxxnpA7p28JKcRbILGGk8FDuI4giQRnrZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQKAxC1qpofMTK16B/nf0BHCHk7y76FEbUn4rvMmw2lbGdjsg9+v4N9tIPZqJxKgG8p8eKgAmLVSJxNpTwgd/0CFT2uDGvDhAsbR9XP0mrMZqebzWEhtT72Ms9jHZ2SwTnmXlJwsx+1J23bSz+pZR4WvpU7LTkgwooH1DbWSxRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=K0bDU4lf; arc=fail smtp.client-ip=40.107.93.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTGKT1m4rsa8DltqCKkKQJeUwzh3q9NwMqYr+8teCR7Xo5gxiyPj0pqSBEPgSetNLnrkfkJRUJSj2aSixt97/S87auNGKCxEDCM84n4iNxzQZW/5IouuMJs9dSeXGgPVIikp+S/q6i/SFoEVAiZKWuEbgItlSz4BwBkoLMdcWaZLwnhBtzpgRWhrgGMUn0f19bY1SqW36aqLXC8++BUaJINxzR8uYgHGVO7/Ox9N6nHi/pSXO8MILy2BFTY2XdlIhKGmrjBxWctFrQYAd6UT4fG06/tHWvqIxqcSuMDK4/uVwge94xoMyis5kKKhNLKp3TPUwWsUlSGTDF422zHdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbppZw+BfXxxnpA7p28JKcRbILGGk8FDuI4giQRnrZw=;
 b=E3/dH1nw8FxUOtlB1Or/0xKxvMUhsskmooUDUeutEJ+pyQnbWP2kqJ5MIZaKrikaOoTpS+ZHB3miQXZm+RsZZ1GHTCw7on+wle+l3tt7vxtCfQdBQaK1T3C6s2UgytNvVR/7U8v6LOBgYRa/AJqwTWFcWuAl2ML5aYUZJfchonGWYnGG8RyagDqJyZ9glAkFHw7/7vf5Vuoya833HtxIG7/4fSI+5hrx0+k7nFkX1GlVN81wjSW5I/B13QBF59ACAysT+T1g2KGU3jOe7sgx4N51pSMkPJ9KQwBg8g3UEPO+s6MojBZrQsYlcQUZ8hmb+lFsIe4Wcs1zXnDkr1ZolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbppZw+BfXxxnpA7p28JKcRbILGGk8FDuI4giQRnrZw=;
 b=K0bDU4lfyO6UPGL3g2js2vEXBWDgeBMgaStPj7wBFaX2I6cHmVckf5zlJFKkGUSSAIGo9ZMNJHcJYRHn6Xqnt/ocOzLIF9I2Jgh/skiZi76S+sNemDkkFooZqHZpyvUZcplc2GtoJNfRpGbtF3MJI3k6HFdNx6HSFjigVsVi98k=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO3PR13MB5813.namprd13.prod.outlook.com (2603:10b6:303:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 14:21:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 14:21:33 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
CC: "rick.macklem@gmail.com" <rick.macklem@gmail.com>
Subject: Re: when should the client request a directory delegation?
Thread-Topic: when should the client request a directory delegation?
Thread-Index: AQHaWcppe3dWAatSzkyuu9kjNEc7UrD+7lAA
Date: Wed, 7 Feb 2024 14:21:33 +0000
Message-ID: <71e5d519411330ee608415fa629322fc84de8139.camel@hammerspace.com>
References: <57b9f5e0c3ec7bc09044b016a3822d0700760c55.camel@kernel.org>
In-Reply-To: <57b9f5e0c3ec7bc09044b016a3822d0700760c55.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO3PR13MB5813:EE_
x-ms-office365-filtering-correlation-id: f2dc22a4-6c29-43bd-cc84-08dc27e81629
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WC4pQxVW9DlfKDmJysd2TuRjEdHVUMQgU3csxAxaMgN7Px9ZjWOzcC0V4WIEa2JSLPPVDxa1vaVDab/Zn5spS9vavH+IyygorbfMud1sLBY+woaNssSbZ0Xe/70sZmkpY/CSfRt1y2K9YOvfMIugjWAtUOaQOE7Wq1XPzPewcM8Tk71Wfk7ELxkWORkpENLvJ96H9x7m5R0tEdK6zmG6GzV3z6l5QUVKsRZjzBEAyQGFaC4ZoEjK9aJ2Pw5EgLtRNpXBaoHb+TDsRAfVQja/FrpnYHw1m2yopdRY2+3Gt/AtnRnG8f3eTDTL5fpEHYy0RmCVtx8d4milFztFsx2js53cpn/vQprIQhWNiRRlCg3xd2cDkIHjzdeTUi4ofWuVnDXPK2voIIYLbzh+MtQmHD4qzmx9hY5fHjHOC2LOcaLytSETa4sj/mp8ASTSDcZ/dD/NqRWdj2yFmTtaVa8TggqljXY3FLQMu0vXrOZxS9/TKYvAIrCf2jkQbU1NJ0B3WEO/5CgIRL+L1YH8nxseFCl0xipJLEsv4SvyXgmGoTq0wjM334Kw1L0iajqaYNj43AQNgOZs6XfUnwfFxKX0N/6WzJsWZD1N2mPq1Fd80lPOA4R7pFu1ecBTVHmFV/9A
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39840400004)(366004)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(38100700002)(122000001)(2906002)(5660300002)(478600001)(71200400001)(6506007)(2616005)(6486002)(6512007)(316002)(8936002)(8676002)(4326008)(66556008)(110136005)(76116006)(66946007)(66446008)(66476007)(64756008)(38070700009)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTE0ZUc5Sk1ZWDJRYmg4QmJwYW1RYVd0Z3lsazVGWjBobmQxVEpYZW1zaSt5?=
 =?utf-8?B?QndVSXJ2d3VPbStXR0hMdUpTOGhtYWlQa0NRNUx2QXJsbVpsNUw2STJ6Y1pM?=
 =?utf-8?B?djRLMjZuMVFoSkVsWWRjbWtGN2FrREVWekJZbXZQaEdWa1VNcEpMMmY3SXNZ?=
 =?utf-8?B?VUxlTnk2dG1KdzJPRjcyTU4zaHFNY1BXQjI4d0VnOEkxb1pERWJiTVhBZHEv?=
 =?utf-8?B?VG9jNnNTNE1lc2c5NmRsK1g5UXkwbFE5ZDgzWDMvcUduNDVVb0hrbDZZaDFI?=
 =?utf-8?B?eE1VOFcvY1NwaUVOaXVtMzBucUNrWjkwMThwUktaVHcxY2FzWXB5VE1wUndz?=
 =?utf-8?B?UUIrVDE2YVZTWmNsclhzTkVkNlVDaGEwTjFESm83a1BrMFcrRlRGYUg4SW9W?=
 =?utf-8?B?b3RSMmJmYlRyckJNUFdqWGRGRVpXSDVXK2wrWStmU2FHc2c0blpvZ3FyNk9F?=
 =?utf-8?B?OWE5cC9NdjZQN3ZIcnRWeE8rL1l0YWdFcDJ2cHBNOG8vbUZ6bml4Wi9ldjRl?=
 =?utf-8?B?dG56WHNqOWRBVUdZQlFFOTNRYnI2OURabVkrbTdxTlk0YUxCMVFZTXZ5YlUx?=
 =?utf-8?B?a1JQRHByZ05BM2pxS1JYZ1lqQUZJcjV2ZHVuRTFMQnlCbXRERVIxT1BpNEF1?=
 =?utf-8?B?UXNCR3hkSk9UYWhkVE9Oc1Z5UGp4Wm1rMFVvSWdLbGo1VEhsYmtTdHhTZFdw?=
 =?utf-8?B?cXltTmdwOWkxVkpWWlBSVkRCbzFjY01IdkhPbDgycnhVelBvZzJOc3VzSTdL?=
 =?utf-8?B?UFBCUHA3ckp5d0Yxa25WMDUyeGVQK3BxQjJUVUNDaDhObVkxZXU5KzAwblQz?=
 =?utf-8?B?eVFkTVBTSGdkQkxzYWpUdCtlUmxEYmpFY2pzVXE1a0RERW52K2xrYUdkVlZK?=
 =?utf-8?B?U2luSDBjRHhzWkFzOWRqRGVIcmVRQXdPa1hzMWlFS1Q5MkYrSElNMERQQkMr?=
 =?utf-8?B?V3drMzR4TllwNWo5NGFDcVdkYjViSGhaZFdmZWl3ZVBjNE82dHZOeHVqKzkr?=
 =?utf-8?B?aXlzSFJ4cVROZmQ1cTF0c0IvMms5UU5rYXA2QThiMFd1cTBsRWtvbVE1Slg2?=
 =?utf-8?B?S0lPUm1xWmxlV0lQQnl3YjBEeW9aSWwrbFkwMWxiMjZtQ0hEdjlId3hxR2hZ?=
 =?utf-8?B?Q2RBVGY0ZmVVMUhVak9HYlk1NFhQTUovK2kvN1ZCY3pXdWFPcDNIdjFzQjlE?=
 =?utf-8?B?bVdWSGNmUy9RWFp0ajRwRW1RN1hFS2c5SWNwZzVWZ0s1UHlNWDRDVlR6RW1L?=
 =?utf-8?B?SWZnaG1EUDFHazhRM3M4R2I3UkJJaEdKaUpHSUtTN3V1M1c5QW45cUd4ZVBi?=
 =?utf-8?B?c2FoZlUxMmJOUk1GQ2ZaWURoQWpCTGc4cy8yM0Z6VG92RlFhcnFYVWdIUjZW?=
 =?utf-8?B?ODl5VlFyRjY1MVZTZGJvWDhQYnd6V0tXaUtXRVBDQ09iU3NxbU1GSE9lcG9i?=
 =?utf-8?B?MVduZzJKVzZoOGdnTnE2MkZreHFpcERHcDBwMHdCZlJSZ0ZTZ1VqRGJ2SzRq?=
 =?utf-8?B?TWtDdWZCc2NGaVN2RFBXY1hDa1pCWjZWZTF4L0IwNkxnQ1V0a0U2TXY5N0xl?=
 =?utf-8?B?c2QvVDZHMEU5bEQwV041L3pZc3dTQVhOcnFINUpwREdidTJZNW4zU0F0ZFJB?=
 =?utf-8?B?NjYyY3VncGVXL3BXZVNtbEVidHVkVVBhcis0RkpTTWJMcTFjN05WalphRnZV?=
 =?utf-8?B?UXZwMC91RDBLRzhMN2g2dFhianVmYjFzN3FDVUNPNm5VRExHSTBmK3pLd2pL?=
 =?utf-8?B?YnhNNGxDbkx5MXJMeGlVeVlVcldNRDA4UnU0cHl2eXNIMkY1VVZQb3J5eFo4?=
 =?utf-8?B?cnc2UHIvUGZIK0JqdTZNTSs3NGRNSU5xMTZCRkt3Sno3NFpySklFUkRBNWd0?=
 =?utf-8?B?eTIvYnpLNExkZEp2RVJJYWlSUkZ0M3FqRnQ4dENPTHEzbVRNNmFOY2lyNEx6?=
 =?utf-8?B?Z3MwT3dUbGZacGVUbW4zRWo2cUt5dmx0Vk5LUGxFRW5qbWszcEdvcDhZTlBl?=
 =?utf-8?B?ZEh2NHUxcWdtNDc5cnBQYXJIQ3hnUU9CQVFPdHFJY3IyNUtxenp2SDQ0UGdH?=
 =?utf-8?B?b0xCN3k3WVdRWDBtdGNnbVVnQkNEcC9OQjJ5YU85NUxuRXVXYXdMVTVqWkZ3?=
 =?utf-8?B?cFBFTFZhQktnaGdVWTQ4N3JBa0dtMHdoczJLckdnYThDZUdWZU41YUZ5OU9G?=
 =?utf-8?B?NE4yOUg1NC9WUWRHaWRaOHBZemt2b3RXc2o2R3MzMzBlNU9mYk9rWThwVTN0?=
 =?utf-8?B?OWN0SzY5dHphWFBQeWE0cWU2TElRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AA1EFE35E15E5408D584D1C83A8A005@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dc22a4-6c29-43bd-cc84-08dc27e81629
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 14:21:33.7348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BALAA00IIEKE7vfjToImZicr89+PjkmW+GumXs0BDn91qlLkd6YO9nIwRGEJdW95ylpJS4NUOyOBw2qLTLEOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5813

T24gV2VkLCAyMDI0LTAyLTA3IGF0IDA4OjM0IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
SSd2ZSBzdGFydGVkIHdvcmsgb24gYSBwYXRjaHNldCB0byBhZGQgc3VwcG9ydCBmb3IgZGlyZWN0
b3J5DQo+IGRlbGVnYXRpb25zDQo+IHRvIHRoZSBMaW51eCBrZXJuZWwgY2xpZW50IGFuZCBzZXJ2
ZXIuIEl0J3Mgc3RpbGwgdG9vIHJvdWdoIHRvIHBvc3QNCj4gYXQNCj4gdGhpcyBwb2ludCwgYW5k
IGZvciBub3csIEknbSBqdXN0IGNvYmJsaW5nIGluIGEgaW9jdGwgdG8gZHJpdmUgaXQuDQo+IA0K
PiBBcyBJIHN0YXJ0ZWQgd29ya2luZyBvbiBzb21lIG9mIHRoZSBjbGllbnQgYml0cywgaG93ZXZl
ciwgSSByZWFsaXplZA0KPiB0aGF0IEkgZG9uJ3QgcmVhbGx5IGhhdmUgYSBjbGVhciBwaWN0dXJl
IGFzIHRvIHdoZW4gdGhlIGNsaWVudCBzaG91bGQNCj4gcmVxdWVzdCBhIGRlbGVnYXRpb24gb24g
YSBkaXJlY3RvcnkuIEl0IHNlZW1zIGxpa2UgdGhlcmUgYXJlIGEgbG90IG9mDQo+IHRoaW5ncyB3
ZSBjb3VsZCBkbzoNCj4gDQo+IE9uZSBpZGVhOiByZXF1ZXN0IG9uZSBvbiBhbiBpbml0aWFsIGRp
cmVjdG9yeSByZWFkZGlyLiBTbyBtYXliZSB3aGVuDQo+IHRoZQ0KPiBvZmZzZXQgaXMgMCBhbmQg
d2UgZG9uJ3QgaGF2ZSBhIGRpciBkZWxlZ2F0aW9uIGFscmVhZHksIGRvOg0KPiANCj4gCVBVVEZI
OkdFVF9ESVJfREVMRUdBVElPTjpSRUFERElSDQo+IA0KPiBPciwgbWF5YmUganVzdCBkbyBpdCBv
biBhbnkgcmVhZGRpciB3aGVuIHdlIGhhdmVuJ3QgcmVxdWVzdGVkIG9uZSBpbg0KPiBhDQo+IGxp
dHRsZSB3aGlsZT8NCj4gDQo+IFdlIGNvdWxkIGFsc28gZG8gb25lIG9uIGV2ZXJ5IGxvb2t1cCwg
d2hlbiB3ZSBleHBlY3QgdGhhdCB0aGUgcmVzdWx0DQo+IHdpbGwgYmUgYSBkaXJlY3RvcnkuIEkn
bSBub3Qgc3VyZSBpZiBMT09LVVBfRElSRUNUT1JZIHdvdWxkIGJlIGENCj4gc3VmZmljaWVudCBp
bmRpY2F0b3Igb3IgaWYgd2UnZCBuZWVkIHRoZSB2ZnMgdG8gaW5kaWNhdGUgdGhhdCB3aXRoIGEN
Cj4gbmV3DQo+IGZsYWcuDQo+IA0KPiBXb3VsZCB3ZSBhbHNvIHdhbnQgdG8gcmVxdWVzdCBvbmUg
YWZ0ZXIgYSBta2Rpcj8NCj4gDQo+IAlQVVRGSDpDUkVBVEU6R0VUX0RJUl9ERUxFR0FUSU9OOkdF
VEZIOkdFVF9ESVJfREVMRUdBVElPTjouLi4NCj4gDQo+IEFzc3VtaW5nIHdlIGNhbiBnZXQgdGhp
cyBhbGwgd29ya2luZywgd2hhdCBzaG91bGQgZHJpdmUgdGhlIGNsaWVudCB0bw0KPiBpc3N1ZXMg
R0VUX0RJUl9ERUxFR0FUSU9OIG9wcz8NCg0KQXMgZmFyIGFzIEknbSBjb25jZXJuZWQsIHRoZSBt
YWluIGNhc2UgdG8gYmUgbWFkZSBmb3IgZGlyZWN0b3J5DQpkZWxlZ2F0aW9ucyBpbiB0aGUgY2xp
ZW50IGlzIGZvciByZWR1Y2luZyB0aGUgbnVtYmVyIG9mIHJldmFsaWRhdGlvbnMNCm9uIHNhaWQg
ZGlyZWN0b3J5LCBwYXJ0aWN1bGFybHkgZHVyaW5nIHBhdGggbG9va3Vwcy4NCmkuZS4gdGhlIGdv
YWwgaXMgdG8gZWxpbWluYXRlIHRoZSBuZWVkIHRvIGNvbnN0YW50bHkgcG9sbCB0aGUgZGlyZWN0
b3J5DQpjaGFuZ2UgYXR0cmlidXRlLCBhbmQgdG8gZWxpbWluYXRlIHRoZSBuZWVkIHRvIGNvbnN0
YW50bHkgcmV2YWxpZGF0ZQ0KdGhlIGRlbnRyaWVzIChhbmQgbmVnYXRpdmUgZGVudHJpZXMhKSBj
b250YWluZWQgaW4gdGhlIGRpcmVjdG9yeSBhZnRlcg0KYSBjaGFuZ2UuDQoNClBlcmhhcHMgdGhh
dCBtZWFucyB3ZSBzaG91bGQgZm9jdXMgb24gYWRkaW5nIGEgcmVxdWVzdCBmb3IgYSBkaXJlY3Rv
cnkNCmRlbGVnYXRpb24gdG8gdGhlIGZ1bmN0aW9uIG5mc19sb29rdXBfcmV2YWxpZGF0ZSgpIHNp
bmNlIHRoYXQgd291bGQNCnNlZW0gdG8gaW5kaWNhdGUgdGhhdCB3ZSdyZSBnb2luZyB0aHJvdWdo
IHRoZSBzYW1lIGRpcmVjdG9yeSBtdWx0aXBsZQ0KdGltZXM/IFRoZSBvdGhlciBjYWxsIHNpdGUg
dG8gY29uc2lkZXIgd291bGQgYmUgbmZzX2NoZWNrX3ZlcmlmaWVyKCkuDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

