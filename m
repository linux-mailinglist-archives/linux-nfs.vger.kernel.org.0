Return-Path: <linux-nfs+bounces-2094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0098694C8
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 14:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D933F1C27E24
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC291419AA;
	Tue, 27 Feb 2024 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="BXmrXefq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F4413EFE4
	for <linux-nfs@vger.kernel.org>; Tue, 27 Feb 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042168; cv=fail; b=aDCslC+ypvYgBVdj2i57ViTzIZOO5dEAos5tqX2J/f0wJ37uzze0omZcaqLp9JvcoE+RtKNE8/O86kaFGkTgCuGwZh2qwW18pMCUTHO6ZaUB1YaBxjUXIDJ5y8PvzL7AeHhSl8vL3RJT6ta83gXr05Iwe7ws19L1FxMtcFjDcsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042168; c=relaxed/simple;
	bh=Meu0KlydAFHURPXifor4s9Lm6moNifTEx8zhrQN5XyI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IiJE+a72OKlLIfWjFA/MmFAOnqQekvHxF0rh4vOzQqNF/sSB2+Jxy8jRRyvMfvPSuTqxKcV9VGgANfftjVo1dr51arU6H9eg0TX7hvqObKl3IF6V3ZgR6IOl5cBjQ+NvaAsErAsJWhANK0i3Wd6W/BJDvyQbQy9DnGIoBlldroI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=BXmrXefq; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5CEiLensU7EkSoZa2LP6JMp3jzjEJzjTuAe3E3H2QQTvovHSoq0lxhaY2NVJdik8dDid2PZFTivgJsv8N+zI2FNduTMtUzcoTrTtCJ/7gHOYQV9t+8LFITPHvwq0jLSwClyEZ67IRl+H1XM4OvqEFAHgHWQFNRl2yqYXEilad0xBolhpxAwf0wltlvM4XiMRbQLK2H9IdLMchxsDHHAE/u3cL5BkyphoH+w3PabRLHMIwgQ3KHV+xPS9xLyKAzg+XVgXoR/bJ3aX6x+7mq2uTUE8BcDgLZyzfqMc2yEaRxF4GfsGYyHgNz5YxmGV7nI8vl2hidkDwZfxSf7UKtx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Meu0KlydAFHURPXifor4s9Lm6moNifTEx8zhrQN5XyI=;
 b=TAluTZBIk4EAYlA2nF4aNCkRJkmDZVn+bENFXIe+kCPghTLJEvfOfqpyngd8j7P2nosF5WtnAn1hbt1jElwnGHjIcmRKroE1hIMWPGOSARw9hNjCgrUci0FiDzzws7qhZMxd8SFxfcosdjpNHo4+3cwH2x38DjBYFF1dSV14VB+PBqUYxrkH9l40ai9pZkc7mntbE5aT9zk+QWdfjFzpiUSPVr/cDCrtFc/v/IoHyhbnMheP1aaN5sRv6SqZglWx+17Y2BsqYIRMV8akJji5czJvJnKDm4bHBtk+Z9oQswOBHJUMRKd6Wa8BE7GbG1uLFSapczVw1riqoIuN6MtuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Meu0KlydAFHURPXifor4s9Lm6moNifTEx8zhrQN5XyI=;
 b=BXmrXefq/94Pcxcjme/ZNK9xd6hZEiDJgXuuq62awMyjUSKRzMTS5RkTtVqsrLoY6b5kYGXtxYfHnCuYD8VeYCy4x4tYbhYOMH8Fu7+4P1sYAz6Do19wb0dGh4UweUfGvxmH8FTSoyakhgReyr9KIfckhIJgrySlcSeM4w+4PSI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN7PR13MB6201.namprd13.prod.outlook.com (2603:10b6:806:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 13:56:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7316.037; Tue, 27 Feb 2024
 13:56:00 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "samatk@amazon.com" <samatk@amazon.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: Client support for 0-length virtual files
Thread-Topic: Client support for 0-length virtual files
Thread-Index: AQHaaX2Qh6NyIOxh9ka1o/OlALp7TbEeNmeA
Date: Tue, 27 Feb 2024 13:56:00 +0000
Message-ID: <738cec371f888a16d4d077fa41b54b8bd9d3aa1b.camel@hammerspace.com>
References: <A5FAB971-823E-4573-9C4B-C92BD41693E2@amazon.com>
In-Reply-To: <A5FAB971-823E-4573-9C4B-C92BD41693E2@amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN7PR13MB6201:EE_
x-ms-office365-filtering-correlation-id: eb0ccc16-9c69-4b7c-15ad-08dc379bd496
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HbUf6PqK6mCOY6OU5vNeaI4xprvrJn+Hvd3J5LrwFmkBk4AZ8tXYNaaBtqLyyuyUxx73ObfhmxZReCd29Ul/3FgcSQqrzVEDn126d4PHfwxiuCWasDTZMLCGI5bmaYzGEwRVjR0oHco3G6iVJcwKTonL37eQg2O48xN/rSA1StxGRU6q65SSn5CYV1sX7wycCAALqKrWHYoyJc4B947TPUlCh0Z+8nBMI6JBubfAWRD6Cl7ku3MkmmbhfXGn7e5utHZqEFRvH11RexeByLdN2/eyxdtsGzPNFZ/jVulJMr7MIUyqGNI49R4khwK+D+BCIxVKLhKZHrxpqCkR0E9xn9+KnJVZfLP4LgJeR0KhvUzqYCbqYK6Mzjor2rOtDa3dfFO07GOnnlSGDHJzvf4zEInLYUR47NH+3rxy4AU0d8S+ckPsPY84b6TSbU0qY9wSCAwvn+zzF7Xgg9H/dVsgxX/F88gfLB0phYj7Sgvu0Jy/w6wn+F1D5V+2hcUitOuFlNwIgM2imccNqVcqT/jsD0V2GrnSwo0I+FrtvxCNXL23I/eo9s7zhEydwGiVxBjGhpE44q81ULlBicvdDxTsPwUO0zHGjFx0aJNbTyPfQzAWNJwpiXoYFxYWAtQm1jYlqp4nis97ndFWmLTs13/ApELWRiiMGE4hFSq/sRZfr5HOnck+BlJlIQcYiTZx/2M6onhYyqVgR1Lavy+uTosM1Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWZyWXByZkxwNm9TMkFsaFBScHhLamNUdVBVa0VndmRPR1orMFpnV3J0R3FD?=
 =?utf-8?B?cy84Wk5IYzkwOE1zVk1hdEtVQzJYWTcwdUNQcHpJQWIyRlA0Z28wV3d0cnRj?=
 =?utf-8?B?YUFnOHUvSkFKVldkY01oQmY2Rk5YUFJMd2xpUWhuZGhpcDZpbFdCdjdVUlox?=
 =?utf-8?B?M2hmQVlSTGtra0p6OHNUdjRSbkhZVTlIUmxGVnJDa0V1ejZSYkJrN3ZMR2xG?=
 =?utf-8?B?SVo1NHRpZW51SGtzUTJJWjNESDJVN0p6NzRqdFVXRkhsSlB2YlA5K2Irb0kw?=
 =?utf-8?B?NlJZTm45MlNFTHBrSlA4Z0tReWVtNk9mdldKQ0NMZjdPY0RrSk4xVWY1S1lC?=
 =?utf-8?B?K3JNN1ZkQmQ5QWwrZmJwWmFRcXFyYkQxdnEwWEEvWVdoY0JySlF4WkJSMjV3?=
 =?utf-8?B?OGEwcVorenVmL1M1ZzRlb2hCNXhrQlBCeDgvZVdJRUMxbnc2T1d1Z2xiaWox?=
 =?utf-8?B?NHVtdE12ek9mQ3Mzc1RmRVJFWWpPQ1o1RUNRY3lPb2VYMHRHWUNiM3o0UHpP?=
 =?utf-8?B?dWJtTmMyaWFTaS8zK3ZKTWtESzNsdGx1QXZRSUYvUU1CV3V2M1p0S0ZHZmR4?=
 =?utf-8?B?N2kvZ1Q5Q0hOL0M4UndXOE4rK1hRUVFnZDM4cnJBR25Ia1l4UE9hRjRyQ2FB?=
 =?utf-8?B?SU9FemZZSHhBVTF0Rm14S0JicFc0R3V4TU9nQlFBM0tQTThmTDRmcnNMZ0dP?=
 =?utf-8?B?QWNIYlF4Qkx2UjVFckxYT2VKc2I5NWU1bXk5cU5yYVl6S216QVRqYWVzZENJ?=
 =?utf-8?B?OEVGUHcwWGZnQTRDZklSNzVvdmExOXBSbXZPRHJoOCsxbm1PVkRQbGw3bTht?=
 =?utf-8?B?UkZoS1RERk1Hem1pc1oyWVIzajBxUUZjR3BYRWJRZkR1Y3NpeHFXM2c5UUQw?=
 =?utf-8?B?L2pEVjZhWW4xTGlWczVZOXVJeFN3YkpIenFWbkxJVGFyb05VNzBCNTVxbUt6?=
 =?utf-8?B?aDRQYjNMb2JQbnNQdU9sWEMxRmZUQnR0cWQ4blBmWnhqTHlYdFRaeVpCNDJS?=
 =?utf-8?B?cmFOVGdYM2E5cG9lMndYYXdRSjNnZGJwK0pndFRacVh1WmtuVVNPdHdROE90?=
 =?utf-8?B?VnJ2T2k2ZndGdUZYY0dyeEc3WnR6S3VnNHJHN0V0aWt6N2RHMnZ0UDlMaXNx?=
 =?utf-8?B?dTJQKzNWNEJKbTJKK2V4QnVYS3JoZXN5Z0RDZmxCZ281MmNJUlBWUUM0SXc3?=
 =?utf-8?B?RDJFamtMZ0RROGFEQ05QMW8yZEEzZVRqUkFMVTRiM2lVTUJ2d0cyU0NBZTMr?=
 =?utf-8?B?TENPaXB3SGhiaUY1T293dk8rNFY1YUx1dGRBNWdpc0kzZUNTTTZBeTczTzNK?=
 =?utf-8?B?b1c1cjJxelkvUWpyNytJRGI4bkw1blJJRzErMW9qSC9zcTR6WXV6MlhnUHlX?=
 =?utf-8?B?L3VzSm8xb21IYUZXL3U5eUEvbkZJZkpBN3VUaC9wM1I0Nll3aFBPYmg4Y0pw?=
 =?utf-8?B?NVFCbmFab29CVWFrdEFFUEtZOXRKa0RJd3dhRVJwNWwzc0VxSGRVQkpLRnpu?=
 =?utf-8?B?aVZIQW1waTQ5MXpqZFZPaittNTdIZ3JzbG1vR25pUVRmTS9zR2Q1MVBtYy9p?=
 =?utf-8?B?M2FNOExIRlJrME44aERKODJ4WklETWg2QjJ5MFo1ZXdpdUxoYlJrYkRKOUR5?=
 =?utf-8?B?RDlsbU1HN0FaamJQTTkwdjFrRFhkeU9hMHFHNUI5MVJYdHExdnA1VHNIM2E3?=
 =?utf-8?B?TlBsSU9nazVSMTNJclhvazdvL1J2aXc3MVkzc0NxUDQ4b3g4WkNqTTZHU3Ey?=
 =?utf-8?B?eTlBZFU5NGNVd1ZCQnJNVXhhVCtUVW9HQzdIMjRhSUsyNmgzSkFqRVMveENu?=
 =?utf-8?B?T0V1RlRTYlV3K1p1V3lvbGJpSGZ3Zmw3RVVzbXpONXRUamFkdTlpR1d6dUNu?=
 =?utf-8?B?ekxFd2xZTS9xbWp4ZWZ4NUVyZlFvSENSVkZZZ1MvajF5OWd6OGtnMWg4Wm9r?=
 =?utf-8?B?eTN1ZnlCZkRTR2NEODJ6SmR1aVhIZkpRODUxQ3d5OXJNZVNsUFBncEtrVVpS?=
 =?utf-8?B?ZlZyQllvTytkc3F3UWw3ZEZoU3c0OVZSR3dzc0NsUzhBcExmbTJJNldRSTdS?=
 =?utf-8?B?VFdDdG9HY0Z6NkZmU1NUbUprK1h6VU5zQmttZXhTYVRBUFo1blV1MER5TnJH?=
 =?utf-8?B?cmt1SS9BTmZhQlZrMzZFb3JEc2ZYbmplYXR2ampDbVJZUjFoU2dXVDJYbHFj?=
 =?utf-8?B?cStXemJZeXUraTdxZnBFc2JydHNkTkJoRW9NUlZLb1FHR2MxZGhvWGJXcmdy?=
 =?utf-8?B?V0RHcC9iMUxIZWRPQWFNd3dLcUNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D7736C61A2D84CA40364E1A7D8EF79@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0ccc16-9c69-4b7c-15ad-08dc379bd496
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 13:56:00.5790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3J8E1oFB/DjpqGdRstCJ/uwQsWK11iF+rvSp/H34gBgwEXj3bRzulLlp4EX5EuzTji/lWaDtb/68IO4gt6FxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6201

T24gVHVlLCAyMDI0LTAyLTI3IGF0IDEzOjA0ICswMDAwLCBBdGtpbnNvbiwgU2FtIHdyb3RlOg0K
PiBIZWxsbywgSSBhbSBsb29raW5nIGZvciB0aG91Z2h0cy9ndWlkYW5jZSBvbiBleHBvc2luZyAw
LWJ5dGUgdmlydHVhbA0KPiBmaWxlcyAoaW1wbGVtZW50ZWQgd2l0aCBzZXFfZmlsZSkgb3ZlciBO
RlMuIA0KPiANCj4gSSBoYXZlIGhhZCBzdWNjZXNzIGV4cG9zaW5nIHRoZXNlIDAtYnl0ZSBmaWxl
cyB3aXRoIG5mc2QgYW5kIHJlYWRpbmcNCj4gdGhlIGZpbGVzIGZyb20gYSBjbGllbnQgd2l0aCB0
aGlyZC1wYXJ0eSB1c2Vyc3BhY2UgY2xpZW50cw0KPiAoaHR0cHM6Ly9naXRodWIuY29tL0NoYXJt
aW5nWWFuZzAvTmZzQ2xpZW50wqBzcGVjaWZpY2FsbHkpLCBidXQgSSBhbQ0KPiBoaXR0aW5nIGEg
cm9hZGJsb2NrIHdpdGggdGhlIExpbnV4IE5GUyBjbGllbnQuIFdoZW4gdGhlIGZpbGUgc2l6ZSBp
cw0KPiAwLCB0aGUgY2xpZW50IHNlZW1zIHRvIGdpdmUgdXAgYW5kIHJldHVybiBmcm9tIHRoZSBz
eXNjYWxsIGJlZm9yZQ0KPiBtYWtpbmcgYSByZWFkIHJlcXVlc3QgdG8gdGhlIHNlcnZlciwgZXZl
biB3aGVuIGFuIGFwcGxpY2F0aW9uDQo+IGV4cGxpY2l0bHkgaXNzdWVzIGEgc3lzY2FsbCB3aXRo
IGEgbm9uLXplcm8gbGVuZ3RoDQo+IChodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L3RyZQ0KPiBlL2ZzL25mcy9yZWFkLmM/aD12
NS4xMC4yMTAjbjEyNSkuIA0KPiANCj4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhlcmUgaXMgbm90
aGluZyBpbiB0aGUgTkZTIHNwZWMgaW5kaWNhdGluZyB0aGF0DQo+IGNsaWVudHMgc2hvdWxkIGJl
aGF2ZSBpbiB0aGlzIHdheS4gQnV0IEkgcmVhbGl6ZSB0aGF0IG1ha2luZyBhbnkNCj4gY2hhbmdl
IGluIHRoaXMgYmVoYXZpb3IgY291bGQgaW50cm9kdWNlIGFkZGl0aW9uYWwgcm91bmQtdHJpcHMN
Cj4gd2hlbmV2ZXIgdGhlIGNsaWVudCB0aGlua3MgdGhlIGZpbGUgbGVuZ3RoIGlzIHNob3J0ZXIg
dGhhbiB0aGUNCj4gc2VydmVyLiBDb3VsZCBhbnlvbmUgc2hhcmUgY29udGV4dCBvciB0aG91Z2h0
cyBvbiB3aHkgdGhpcyBpcyB0aGUNCj4gYmVoYXZpb3IgaW4gdGhlIExpbnV4IE5GUyBjbGllbnQg
YW5kL29yIHRob3VnaHRzIG9uIHBhdGhzIGZvcndhcmQ/DQo+IFdvdWxkIGZvbGtzIGhlcmUgZW50
ZXJ0YWluIGEgcGF0Y2ggcHJvcG9zYWwgd2hpY2ggcmVtb3ZlcyBzYWlkDQo+IGJlaGF2aW9yLCBt
YXliZSBjb25maWd1cmFibGUgd2l0aCBhIGNsaWVudC1zaWRlIG1vZHVsZSBwYXJhbSBvcg0KPiBj
b250cm9sIGZpbGU/DQo+IA0KDQpJZiB5b3UgY2FuIG1ha2UgaXQgd29yayB3aXRoIE9fRElSRUNU
LCB0aGVuIGhhdmUgYXQgaXQuIEhvd2V2ZXIgSSdtIG5vdA0KcHJlcGFyZWQgdG8gYWNjZXB0IGFu
eSBoYWNrcyB0byB0aGUgc3RhbmRhcmQgY2FjaGVkIGZpbGVzeXN0ZW0gQVBJcyB0bw0KdHJ5IHRv
IHR1bm5lbCB0aHJvdWdoIHVuY2FjaGVhYmxlIEkvTyBmcm9tIHBzZXVkb2ZpbGVzIHRoYXQgYXJl
IGFjdGluZw0KbGlrZSBwaXBlcyBvciBzb2NrZXRzLg0KDQoNClRoZSBleHBlY3RhdGlvbiBmb3Ig
bW9zdCBORlMgY2xpZW50cyBpcyB0aGF0IHRoZXkgc2hvdWxkIGJlIGFibGUgdG8NCmNhY2hlIGF0
dHJpYnV0ZXMgYXMgd2VsbCBhcyBkYXRhLCBzaW5jZSBvdGhlcndpc2UgdGhleSBjYW4gY2FjaGUN
Cm5laXRoZXIgb25lLg0KVXNlcnNwYWNlIGNsaWVudHMgdGhhdCBkb24ndCBvZmZlciBjYWNoaW5n
IGFyZSwgb2YgY291cnNlLCBxdWl0ZSBmcmVlDQp0byBhY3QgZGlmZmVyZW50bHkuIE9fRElSRUNU
IGNhbiBkbyB0aGUgc2FtZSwgd2l0aCBjZXJ0YWluIGxpbWl0YXRpb25zLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

