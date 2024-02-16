Return-Path: <linux-nfs+bounces-1984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB785736C
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 02:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949FF2822A2
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 01:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B584C2ED;
	Fri, 16 Feb 2024 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Lts4/by3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2136.outbound.protection.outlook.com [40.107.92.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B102FB2
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046989; cv=fail; b=XY5BtAuvVdfiDmxhwanUYnsz0w082wcRmHVvpizg0oLk7ho+WzzErSsiFVadZC7dPRDFwe60CdraTT+uI7sB7CXXJI+mS4YFrBa9TeHVJ88kmBaYDlp4SgcPyeuc+3zYJCp3TuNjQdN/QQGsQLJH5kMKW/8e9aKYAGBhfXh3p78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046989; c=relaxed/simple;
	bh=vhJ0RWR9E6YjTvoRgJLQTabaGdlo9RdQWOfl29G+wVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPoEr6C+QM7YB0lj7kEG6UAVC/Fr/eRDqtoVXMh+Td1DnBoKfDdZBcp4p4r+C9j7mjRnVkG7/T6ftTYs1iENPplV0+q5rPuYD/dffMgZjDMbfgx++8tXfR3ZR1r3vsMCcc9L6JfHte8IMmU8ZtMLyVHbbXvRFx5tuWFNsvu0xvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Lts4/by3; arc=fail smtp.client-ip=40.107.92.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc+6WEuqSXNWaOwKzLol0s+R/nz35lYVYTff+8LreWohLt8iVKaoqWF94lBMGgukYDHP/DmqI9iPPSzhdDR2w1QXoI7hsHg9UxfxxE42Z31eWI0Rm6NdxyB1mu8FGxWkUjH7ltC8zRy9BUpvstye20YYr+8uglIj+YiQr2U6vjyRarRLOdi2JXT60xFG7/KSJMtMcZENLw0SDmI3aS+4Rr2LfdIZZ07CunDMEe064qw4J0I1Su1mdiIisDrh0yA/RnFIJywSbhj8KSnMR3bMVZsKqNtwDkuacrYBBBmZ+bXKENyB91ONCMhaPEkDoGBIspZifMwHO+3vaj4j0dYVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhJ0RWR9E6YjTvoRgJLQTabaGdlo9RdQWOfl29G+wVk=;
 b=Pkov0dvqQ4hno7UgTbp8pxewwAoops01OPmDEvujOm8o0ORLxY0ZUBi957ctIhWMB8KNnaBI715dgkjHML9cXn6nUpGOJrsaa1SWZQOzRLRQoJ7+NnwaAf+1Nx2b9iKJdTVobfeCjO7pQROZSFU3o20vXyJPxHWlyeYkJhLadP8P/He9gFYAkkrF1AAD1Kcx05lfg1muO3EpT7rH7piCKDfo/S8vPmvccVXqnDRTSqsgn+P1/fVqQMGAX5u+SCd4jg45RW+ZotYGdrrUocYieyOMapA89yYiO7K39q1N1hcZu9efXQjOO/s52vJ//GCUCM1qUNJKjiN5qrJNvQy6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhJ0RWR9E6YjTvoRgJLQTabaGdlo9RdQWOfl29G+wVk=;
 b=Lts4/by3NYh0oPvx4KtUzstgszxD9jHPL0vbT4TcOZgxDCXi9J69j8RrcS18/HGVM8rQQCukqjmqqz0H+LmB+FoqPPBtfiBeHN2HfOdWoAMVy44fOg55Cr+v+Mc1hLc0k9D54yhGhFAVtowK9n4QpP99unsQpK5YcyFrsrOYqPY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO6PR13MB5324.namprd13.prod.outlook.com (2603:10b6:303:14b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 01:29:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 01:29:41 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
Thread-Topic: [PATCH] nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
Thread-Index: AQHaX5btnlfDKjelY0+nKK8eMc8WYbELkbAAgACeWgA=
Date: Fri, 16 Feb 2024 01:29:41 +0000
Message-ID: <d873ecdc98917e2f37d58627c618060392b2afec.camel@hammerspace.com>
References: <20240214223501.205822-1-trondmy@kernel.org>
	 <Zc41ru02fZ7SSPNU@tissot.1015granger.net>
In-Reply-To: <Zc41ru02fZ7SSPNU@tissot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO6PR13MB5324:EE_
x-ms-office365-filtering-correlation-id: b76edc1f-0913-495f-679f-08dc2e8ebfc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8TUqPyNHSO8mLeAXT/awpCP1iJQzTpvGx9pDugWRhPlreo6M3rhUHcYcWlVNA9cE7jqAeJzHYEWPZSYjIRDJ3p6OgV28Hi55s0rDNUVxabL/NX3uAauX5zNrAYKSrua5FEN57OlARfH6zBuebRX1f6MBzIkg9Q21nqJP5Kc5SrORuxljm4oQC7fbentxljrkwHnOphtSiDoV7MVBVXyUR+PsPmGrh2YnFOLo5XJb80Ml6O8oZ38KUQUOraTBL6OskKFcbeX9Esoxs91Kbuaw8IYGuAqop/a5pFisB6gCCCyJVonS9K+/LBE/Y6xGrshTgsKXpdfT0XqLlpyVOlpK1E2vOmVwEN9ENN8/b5Y1GqZeuGNaS+eEsyw13G0IlredQ6KAnuZAMplPZYKNUB/Tr79BIo7bY79Xo9fVSprC5UFzKzPcLd0hEN8x33JOLo1hn7AqgMKGwv1rtqagPa6xf30YLTANf55GkKRBtkPUtReaLLENG81ZnKUZZhoW4wrs0bCkUqJwTpKJsCuB8Zsho5b5fLF3RkKHWStvXk3+mZXS1P06SkEP83DLXNteESGW+n8t0p8yIm0SZj9Gu64iuyf7D/3MlN1/QSZOqUPIzVZ/YTm9QoE6PL0eyvktnxfq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39840400004)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4744005)(2906002)(76116006)(64756008)(66556008)(66446008)(5660300002)(66476007)(41300700001)(8936002)(8676002)(4326008)(66946007)(122000001)(86362001)(83380400001)(38070700009)(2616005)(6506007)(6916009)(36756003)(6486002)(71200400001)(478600001)(38100700002)(316002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NU5UaXN2U3U0VER5SHlnOXVJaVZ4RUhYRFkrOE4yYmtaKzFDRENUd1hSNHNt?=
 =?utf-8?B?WGFETU9EZkFVYnpaNXFzVTg1ZFpBYi90aHhFY3lLTjdxOW1pMDVTYnNtSEgy?=
 =?utf-8?B?MnpTZ2twcklOQ0Zvdzd6ZXp1U3hleTI3aVRycFRKdVFaL0JNRjIvbmR6Y2tV?=
 =?utf-8?B?SCtkLzdzQWhkUnpETWpualc1bXhGcXRIVXlpczEyb0xoVU5GVXFYQnErVyta?=
 =?utf-8?B?MUtvRkZBZjFLa0lYODN0RTRsbS9UV1BHQUNydTdlNGhjMno1bkh3QldPaU1M?=
 =?utf-8?B?SkFCNEczaGhGZk1NU3ZTWVFXd3VOTEM0dFpFRGpmZGYzWmIzQlpNcTdyVGJ2?=
 =?utf-8?B?MTBvSVRxN0Q2eXA3VnNlS2o1d0ErdHo5d1U0VUNVSm5yQWg2cHVXRm0rTi9K?=
 =?utf-8?B?Q1drRFpGeU1VdTYzcTZHK1BtTGg5cW5IcWsweHZVd2xuQ2hkNDBlRGRvNS9H?=
 =?utf-8?B?NWxEQkNOQlJGd3F0WHh5NlE1RXV1anRPUEdCWDlqSUJXZ2plWldPcDRveTE2?=
 =?utf-8?B?aWRBam1BT2JLdWoxQXV5bnliTFhBcjMyZFg1RTdBS1RTLzBtZ1dMendZQzhi?=
 =?utf-8?B?R0Q0djZlWUx3bW1yRzJuNDV2SXp3bDJqdGNtanh3cUJRbTZPRkxqWkhBNk5y?=
 =?utf-8?B?UkxCNFhMbjNNY0NwaTlaaU5IemJ1M0djTkJoemdOSWtLeGF1aTA2Zk9KTEs4?=
 =?utf-8?B?SnEzblBJVnk2eDdFc3NPUjBnR3FRUTdvYjJpWnk0QVFRb3FTaEh0L05nM0Vn?=
 =?utf-8?B?ODlwVEk5WlR0cWtjbkZNSjlqNTczbFhxM2VudzBFUU1qRzh3RWVyb29uYjZS?=
 =?utf-8?B?c0k3UERINlBvMFlzN0tiVEhoV0EzVnA0VkhPWEg2MWIwK0NnNUtHaFlEM0ZG?=
 =?utf-8?B?ZFFSNHM5TWpHejBjOEpKek5pM0dNUWxVRkMxUUpzZ2x1SXVJMC84bTQ2cDhP?=
 =?utf-8?B?THRkcHpRbElGRVBJNlpnN1lqQlFjME5Jdkd2L1M5dVZ5cTBQa1RjNDFqRWRn?=
 =?utf-8?B?UzN0VHdJcmFLaWhCSm0rN3VCd0xxemorTm9rOFJzeDhTeFFoYzI1ZXFzVmxE?=
 =?utf-8?B?T1FDUDJ2R0h1bWpXUkFSdUtaNmEvWHlYMFQvRDlOUFNxbW4yeGFibEVxNWUv?=
 =?utf-8?B?ZWpmZnM2VTh2THZ2ckR1anZzSUUvYksxSC9HT2RHemJtRW9ud1U3dTZYbHla?=
 =?utf-8?B?U0xpSk16b2tPU2JjSGF3cFZrdFVtUENWSmRhUGtvaG5Pd09tWVF4eGNSUTdC?=
 =?utf-8?B?TnNkZjl0TTZESGU2OWdjSWJxMStJNUJ6SFQ2SldjR2VjWk5Ga1lGY3VpVldO?=
 =?utf-8?B?MWtyRUpBSkVhc0NzM0gwU3MvN1BrRmRVVlJVcmM5dnFYMnMydm5tZFVxU3B0?=
 =?utf-8?B?MHhQSVM3WUJHd1gyVWpQVVFHTEdzc3JIdDN5SlhUL3pYZFRqV2k2V0NKczZ5?=
 =?utf-8?B?TnZIU0tGb2ViU1FEbmhTaUI2VVNUdkt5VW5VcHgzMzVTY1RYQ0ovL1BVcWho?=
 =?utf-8?B?eWxmNWNaQkhGMmRFK3pFaGwxRElYbEI3amprUGlzdVhSMTY3eWdjMHVKWmZV?=
 =?utf-8?B?RXhOOWhRaVFtRXpFZTlUZXJtODM2TnpTRDBpQkk1MFRmS0NqNWROL2ltVFhy?=
 =?utf-8?B?ZU8wQlNxdTRBbFFrMXNrc0MzZzQxZm84S3FFSXdYVWxTQitEUXFrMUZOMjhq?=
 =?utf-8?B?NHhmRHBhNWVsUFFSOFRrMnNxOGlRVnN5N0Ntbi9zRGlPejBlTUorNTIySEEw?=
 =?utf-8?B?YWtKK1dKa21QaTliTkROQXNvdTl0N09ra2NTMUtmWGJEUmNlYjdBOWhPd0pQ?=
 =?utf-8?B?QmdScGZnZzVRc3NTcXZHVzVBSnF1Vlp3dWJZeFhRSTZCWEdNRzhIeWpvczNv?=
 =?utf-8?B?OVIvYUpxVXRac0pkaHkzbWQrY21ZZWZUUm9xejhtWlEvbVorbDBNa2RCdml0?=
 =?utf-8?B?UmhUSk1pR0JBbXVOajU2djQ0c0VoYjhKUTRRMEM3cUVTdWZTOVRrVlM1U1lB?=
 =?utf-8?B?Um4ydUFzd0FpZFM1QjFBTHpqaTNGVmZQM01QaUhiaHlzb0NFeFEyZ1NEVERa?=
 =?utf-8?B?TG94U2JBQm5OdVJvMklyRGYxUXU3dU9FNlliaVdhSFFQbHpjM2lodmVHYXpZ?=
 =?utf-8?B?cmlaK3hKaVJkSHN4V3VsYlgxMnRpTm1wcXRpZGIyaUxIZUR0amd4Vm9vaUJm?=
 =?utf-8?B?ckpocE5lV3hIZzJybklDRnIyT1pZRjV0RlV5WEl5Sy96VjIxL0UzelV2dVcx?=
 =?utf-8?B?N1p1ZWpVQWUzMUYxczZNdWNqWjlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44432DF8E2D8EB4DB5DD6566700FAFE7@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b76edc1f-0913-495f-679f-08dc2e8ebfc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 01:29:41.7179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVPcYparGWQxDWYC4lTNnhd8ifyT+9aB5gYFn36es7BQUOnt1sKD4NRVhNyI0ep+IBdRyN7HALOZmq/lm+s31A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5324

T24gVGh1LCAyMDI0LTAyLTE1IGF0IDExOjAyIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gV2VkLCBGZWIgMTQsIDIwMjQgYXQgMDU6MzU6MDFQTSAtMDUwMCwgdHJvbmRteUBrZXJuZWwu
b3JnwqB3cm90ZToNCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gVGhlIG1haW4gcG9pbnQgb2YgdGhlIGd1YXJkZWQg
U0VUQVRUUiBpcyB0byBwcmV2ZW50IHJhY2VzIHdpdGgNCj4gPiBvdGhlcg0KPiA+IFdSSVRFIGFu
ZCBTRVRBVFRSIGNhbGxzLiBUaGF0IHJlcXVpcmVzIHRoYXQgdGhlIGNoZWNrIG9mIHRoZSBndWFy
ZA0KPiA+IHRpbWUNCj4gPiBhZ2FpbnN0IHRoZSBpbm9kZSBjdGltZSBiZSBkb25lIGFmdGVyIHRh
a2luZyB0aGUgaW5vZGUgbG9jay4NCj4gPiANCj4gPiBGdXJ0aGVybW9yZSwgd2UgbmVlZCB0byB0
YWtlIGludG8gYWNjb3VudCB0aGUgMzItYml0IG5hdHVyZSBvZg0KPiA+IHRpbWVzdGFtcHMgaW4g
TkZTdjMsIGFuZCB0aGUgcG9zc2liaWxpdHkgdGhhdCBmaWxlcyBtYXkgY2hhbmdlIGF0IGENCj4g
PiBmYXN0ZXIgcmF0ZSB0aGFuIG9uY2UgYSBzZWNvbmQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiAN
Cj4gTEdUTSEgQXBwbGllZCB0byBuZnNkLW5leHQuDQoNClNpZ2guLi4gVW5mb3J0dW5hdGVseSB0
aGlzIHBhdGNoIHdhc24ndCBzdWZmaWNpZW50LiBJIGp1c3QgZm91bmQgYQ0KcmF0aGVyIG5hc3R5
IHJlZ3Jlc3Npb24gaW4gdGhlIHNhbWUgYXJlYSBvZiBjb2RlLiB2MiBpcyBvbiBpdHMgd2F5LA0K
d2l0aCB0aGUgZml4IGZvciB0aGUgcmVncmVzc2lvbiBhcyBhIGZpcnN0IHN0YW5kYWxvbmUgcGF0
Y2guDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

