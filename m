Return-Path: <linux-nfs+bounces-1996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796088585DC
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 19:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD761C236B3
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 18:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF191350F4;
	Fri, 16 Feb 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="WQJ69htQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2135.outbound.protection.outlook.com [40.107.237.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0361353E5
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109843; cv=fail; b=GuD+lHpd3yRtGqhc6IkNwXMnlULRRYOzV53xDwX+cPIWIvNaqz/PfBh76RC7MJ9hMKCQMql59/yfiUJGJUi8wBiLbxta+mEi0/ozNp3ntURGfzb7XFbjs8D/8ijJd0WHxp2eLp9tyfyFkm+BfY+OiMb9TJgHAjjwGLSrnR8vJb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109843; c=relaxed/simple;
	bh=jKoX5brbcfqDV11Cr1s5Xz5IynqzgzvCJY/HW4nlBZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LASMVBpCvWvLDf1maJvxvF/caP70NhrX80igOAkdK8XVLJl7pF17qqqUIE6iLGMBrutOhOq25SpecYXIIjDiTR3BMrgVbjoedOvlfoTInijBxAxowH5Xkl4Z8sNQrEOvvwebeRVNGZ+etYvl1PFpu6A3B+j/16t2mc+OlhxZ4Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=WQJ69htQ; arc=fail smtp.client-ip=40.107.237.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kymDeft2T0UdXmG6gPIrlApNw8tuDV9ylqhGCAUAy7K2sb17dFRo9SAH2l/w7UD5LHi7FBdv8inOs+Xc64nyygXnmMLkH8kaHG0Xp4tCbyvXnwsYYYSaKgWf/0eIysfdIfHWNJ6mYCU+RuSCZcmVQbu9iPX6ZuI2iZ7CubC+IdM5JDO+4nBd1R63+IvnDZteq9hGAn5bL/GB0RLGGDrOqXYMBnHT1PWItcGnjvnzaWzDjYf4ndt9J0HnI4cgiXV2g9l00VLkhwB+NnMc/KkpcSAitnpqAhKOUxTNIajDOpiezNDvCiUb48EpBgDNLBnm9Gf//p/LP7fh2TUKtMTtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKoX5brbcfqDV11Cr1s5Xz5IynqzgzvCJY/HW4nlBZI=;
 b=eeofy5g+VR1oA3Lmb3fuueZCaQ8bx7EZVbb+x5/DjOGRJEADtGHnLOnu4CtbVD0hN2nhCZ9fce6RLJG4ESBbFwITjYW2q6Z19YBVXYewagn2q0Kt9quSQ/Mf6utvs0V2QK443WqPYYyxStv3XMohOb7ll+9akLUivso4SlvAB3iP6yE4fu2fmmxKdX/DMPiuOVTgYhq27LfqmbEFc5t4/T525OSoHBeDTn0AdFgsR80Foi5c44u7T/7fdz1Sds56xPKeSLWix2GFjGSR73fQSLhoKoI2Br7kLOeWz1q5ZcMSOsAVuvtyP9c1FCYiEyJ8X3nw8zilho75rQemU96kVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKoX5brbcfqDV11Cr1s5Xz5IynqzgzvCJY/HW4nlBZI=;
 b=WQJ69htQK90e7gsV8EvbV/bio140TPlHfMUe4eONQMM1tmsmtlK+TO4DXZ6U+dEiNEMNah58Wv55DGXCm+mcLtwQSgSMoVSZt/CqcoOO4Ghgcw53QpaYoabVAYxzyUH+CF0xE6gIpb4r2XKJdR4D/XtbmEQc36FE+3vjfwgZMNs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY1PR13MB6715.namprd13.prod.outlook.com (2603:10b6:a03:4aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 18:57:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 18:57:17 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Topic: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Index: AQHaYHfUW0xTMio2ik6dSCtFnyTgcbEM+KOAgABPaQCAAABugIAAAamAgAAI1oA=
Date: Fri, 16 Feb 2024 18:57:16 +0000
Message-ID: <5c35277cd061e16a914b94e070ea6d95a75c1342.camel@hammerspace.com>
References: <20240216012451.22725-1-trondmy@kernel.org>
	 <20240216012451.22725-2-trondmy@kernel.org>
	 <Zc9kQ1Autf6xdcii@tissot.1015granger.net>
	 <ac1166ca466c343f18df45094c0130947bd21f5c.camel@hammerspace.com>
	 <CFBE3BDF-E347-4273-8C7F-A57E0D353457@oracle.com>
	 <756FABF8-FA78-4D16-A4B8-B47C4745868E@oracle.com>
In-Reply-To: <756FABF8-FA78-4D16-A4B8-B47C4745868E@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY1PR13MB6715:EE_
x-ms-office365-filtering-correlation-id: fbc32b48-96b5-4c70-7328-08dc2f211877
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vID83q/G6Q+l3MKUTnhyPTR+BnfsIt7qJ1aZwUBFMrs3l2xg+z+JJ+83QklG+2HA/zJ743h0twDVP6cZ0Qdcfk9Gr4PYm3xRLikz7+IOoS3XAZepYf//W/D7w3Uz15B1BlC7cbIhCByG54iMHnvA3sKg0IodScHRoaiJ/ry2vzqwFKeWuhgAiacr6tcqnexmQ15QY8M9/gw82jbLKOZhtY8AsUeWt/ivg8piP5hlD2fQNKzDdJkE5EknFtZ5+lwNzAMjYByPeSWnhetU7sM/REPS/eTHXT9HBb4lqzKKYgBglHcDRAUEYjzh/MRQEaHmBnVpLqoTSyEIsijgbUSY3CkpWruW5tz0nVKaBqISiZVsMrG+JVHGCcxwY1C+fAW5QPkQZCCcJPCkdvYz9neX2lx6g+FVzImSX/HPtbbmL0QI4BkO8EafrWjJOWtDYf+5tDLlLLWoe4PTfKieHPJLWTQ9bzOtbTfSruQjsulIPrfLkFywJXHRWk0dRiH2XvPKPQnP9p6K34h0cS27P70nRwmI83pjIliFnovsYM4V0rP7oX5zv8qYVl5eVAcYT03GCLzyIq3r1qF4+mzlVXquldVWGjixMzWk5AxyiAqJukgYABNHErbs3eTqT/fo9AqC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6916009)(38070700009)(4326008)(83380400001)(26005)(66946007)(8676002)(316002)(64756008)(76116006)(66446008)(8936002)(41300700001)(478600001)(66556008)(66476007)(6506007)(38100700002)(53546011)(6486002)(6512007)(36756003)(122000001)(86362001)(2616005)(71200400001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU80akZCU0ZPcHNNK29LK0tXTGduRnJuRmFOQUVZWE80V2RnY3B0ZmN2MUI0?=
 =?utf-8?B?U3lVQ0N3U0oyb2VDelNrVjQwZUVDZit1WFV4Uit5cG8xc1JlM0kvUGlQdHBm?=
 =?utf-8?B?Q1VGaUgyMStPZjkvZTRiZ3Q3TkdzM0IrQlBGU0RwdnlOMFFlbWNHQXljQTFX?=
 =?utf-8?B?QkFHcUNxL1NXRktGd0tJY091OTNVTkJTUmlGOVhZeVk3NUNlUkNlUkFJNmhM?=
 =?utf-8?B?MXk0dm1jVkJ3a3ZzbWNZREh6MitoekxmaXRsR2NjcFVmZGc5blFzSDUwcDRH?=
 =?utf-8?B?ZkVPNTgvVTdmdks1V2VxaFM2WGE4b3pyWk5OaGhya0hvM3JVenprMFFQZVdM?=
 =?utf-8?B?YktQTEdleDlDVGpCak5uSjV6cUJUNEVUQ00zaEZ3QnRFYWl6V2NvQ0xvQWw5?=
 =?utf-8?B?eUVFeGtwd1lETE5qRUlBQWhPYkdLSkd6dGlUTzg3NFAyMzB6SzQ2aXc5OWph?=
 =?utf-8?B?TDJqTWZOZDZBcXV3OVVqR0pnWkpyZEtLYTJMeHRZdHNrUE1CRVZRV0VwR3dY?=
 =?utf-8?B?T2plWExpaUl0dGU1a0pEK1cwMG1SZTh3UlVocTk2WG9yanQxNmhaTDBRSzJJ?=
 =?utf-8?B?VEFYQXhOU2VyWVJzYVZxb3B1SWp2My9RQ1hPUFlOV1g5b0dKclRzSVlzMlU4?=
 =?utf-8?B?TUFTanRieHE2Rk5DZHArb0o3TS9WWnVDKzhkNmhrdmZsYmFTNG9LRXppdjhk?=
 =?utf-8?B?aFlHQlkzc09UeS9tSFN3bXVqbE53eHpLdm1xZDcxMllUbXE4aEhiWWVYRWFO?=
 =?utf-8?B?UTUvbERzdCtHcStkSkVlY29vckNyQmIxeFJhQ1plRnlEU3phWVZLWGVQQU9T?=
 =?utf-8?B?eTNueDJvUWN0elJJUnkydCtyOXFJbHQ5SXZremp2cTF1UXBQbjdEcGVIZExV?=
 =?utf-8?B?aFovNk5XVmwvZXZQSi8xb0dwZUZvK3F0ZWUvbGdacjJLU3hhWHoxbHBFWURW?=
 =?utf-8?B?RGhUSXdpNS9CRHBOZzhNbHRFTU9yaWNnOUxtY3B2T2dsV01BSnQxQ2J6aEEz?=
 =?utf-8?B?NCtjZzltdzM5VVdidWVhbHp6U3hMbDFWWC9yQTRNUzhQUEFnSW4vTHZzTGZw?=
 =?utf-8?B?azBEYy9nc0txN3QyMUhFeUFPMDVGOHkxcytrUStERE04bnUrRk5lM1owM0Mr?=
 =?utf-8?B?Yzd6dFVPN0NIblViaFdMdGdoSk1HVmdna3lsaDJKT1RiaW1NSjZRSzhPYy93?=
 =?utf-8?B?ZHpOWWdnTzFHK25udW03R2xWMzVRc3d6bmhFK3k1MEVUelRraG5KcUpwTXNj?=
 =?utf-8?B?dTkrV3B2YjFiVDBhM3lYS3lhUFJxTzc2SGpwcG12RTZ5RW1YcHFLc2lmdk9R?=
 =?utf-8?B?Q213aWRiOUJOSXBlMDE0R1lpVWE0MS9STm5jRVZodUM0cTBGNDloZE43Q0VU?=
 =?utf-8?B?U2FHUk1BUHFFRDFaeXpTTmJwT0tJd0FtbmxqNWxtME5MZG1DVFh6RWE4d1ht?=
 =?utf-8?B?SXZzU3J0NG1YUk9UamVCUkZUVDBkOXZ6eVJ6akxKNUhJUG9td2M0SGlYVC9O?=
 =?utf-8?B?MWNWYzh2bGxxSkl0RTdqYkZ3SFhNb0ZhQmhTb3EySHp6M2JVRTNlVTFLSk45?=
 =?utf-8?B?QVNpeWN6dTFCd044YzZobklpWnQ2dk1oNEZ2NHZQQ1o2RkVxdGtWaU1LRjFQ?=
 =?utf-8?B?dHlTaW4wUHpnWHVxRzNnNnFSZXFtUXNoSjdmOW8wVjhNaVpBRlN3dEhHWSt3?=
 =?utf-8?B?ckw5dVN1U1lRaUM5KzM0aGdkVHBCWUFPTHZveW1HRG9ObWNyVGNsOEtFakxi?=
 =?utf-8?B?b3pjM1VFNk5XeUV3MFlMK0J5ejNPUHBIN3BiZmdCdEJJQ3hCakVWbkZHeWVE?=
 =?utf-8?B?Zy9VQVgxRjBwMXFPODFaNThkTVVPOG01Y0V6d2JWdEUxYWFPajBNS2pIUFNP?=
 =?utf-8?B?SFM2Sm5oMGN4a1JWVldtbzZGZldlMldDRFRqc2xKVEllMkVJaXdhNHZBUktz?=
 =?utf-8?B?dGZldXZGenBpVDErL1BDbnZuUnZXbm00Und1V1JhREtiQmxHakNoTkpRUmZh?=
 =?utf-8?B?YmJxZlZienV5NnZDNmZwSVROY2tacVEwMDRIS1Y5VGx2bVArdTlRbEhoamZn?=
 =?utf-8?B?VjlBdmRZd1gvbWEvU29TTElzV3VPN29RL1JDdk40RVJQbGFUQ0ZlUXRUeVgv?=
 =?utf-8?B?dTd5K3Z5ampQSFA0QlQ2L3JnMldQU092RGx1TjFQODZ2cG9KMGVqUEpJUW52?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4F57E9AF1C6F84EBF174E145DC28827@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc32b48-96b5-4c70-7328-08dc2f211877
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 18:57:17.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHp8n3K24XRhFqsH/QZ7dWNE00A4xYHgcYYj2r2P5SgPwIQeH9WRXqjYOZQo/Ocw/yVpynJUbSVJr8JnzOhctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6715

T24gRnJpLCAyMDI0LTAyLTE2IGF0IDE4OjI1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBGZWIgMTYsIDIwMjQsIGF0IDE6MTnigK9QTSwgQ2h1Y2sgTGV2ZXIg
SUlJDQo+ID4gPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+
IA0KPiA+ID4gT24gRmViIDE2LCAyMDI0LCBhdCAxOjE44oCvUE0sIFRyb25kIE15a2xlYnVzdA0K
PiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24g
RnJpLCAyMDI0LTAyLTE2IGF0IDA4OjMzIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+
ID4gT24gVGh1LCBGZWIgMTUsIDIwMjQgYXQgMDg6MjQ6NTBQTSAtMDUwMCwNCj4gPiA+ID4gdHJv
bmRteUBrZXJuZWwub3JnwqB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3Qg
PHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
Q29tbWl0IGJiNGQ1M2Q2NmU0YiBicm9rZSB0aGUgTkZTdjMgcHJlL3Bvc3Qgb3AgYXR0cmlidXRl
cw0KPiA+ID4gPiA+IGJlaGF2aW91cg0KPiA+ID4gPiA+IHdoZW4gZG9pbmcgYSBTRVRBVFRSIHJw
YyBjYWxsIGJ5IHN0cmlwcGluZyBvdXQgdGhlIGNhbGxzIHRvDQo+ID4gPiA+ID4gZmhfZmlsbF9w
cmVfYXR0cnMoKSBhbmQgZmhfZmlsbF9wb3N0X2F0dHJzKCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBD
YW4geW91IGdpdmUgbW9yZSBkZXRhaWwgYWJvdXQgd2hhdCBicm9rZT8NCj4gPiA+IA0KPiA+ID4g
V2l0aG91dCB0aGUgY2FsbHMgdG8gZmhfZmlsbF9wcmVfYXR0cnMoKSBhbmQNCj4gPiA+IGZoX2Zp
bGxfcG9zdF9hdHRycygpLCB3ZQ0KPiA+ID4gZG9uJ3Qgc3RvcmUgYW55IHByZS9wb3N0IG9wIGF0
dHJpYnV0ZXMgYW5kIHdlIGNhbid0IHJldHVybiBhbnkNCj4gPiA+IHN1Y2gNCj4gPiA+IGF0dHJp
YnV0ZXMgdG8gdGhlIE5GU3YzIGNsaWVudC4NCj4gPiANCj4gPiBJIGdldCB0aGF0LiBXaHkgZG9l
cyB0aGF0IG1hdHRlcj8NCj4gDQo+IE9yLCB0byBiZSBhIGxpdHRsZSBsZXNzIHRlcnNlLi4uIGNs
aWVudHMgcmVseSBvbiB0aGUgcHJlL3Bvc3QNCj4gb3AgYXR0cmlidXRlcyBhcm91bmQgYSBTRVRB
VFRSLCBJIGd1ZXNzLCBidXQgSSBkb24ndCBzZWUgd2h5Lg0KPiBJJ20gbWlzc2luZyBzb21lIGNv
bnRleHQuDQoNCiAgIDEuIFNFVEFUVFIgaXMgbm90IGF0b21pYywgYW5kIGlzIG5vdCBpbXBsZW1l
bnRlZCBhcyBiZWluZyBhdG9taWMgaW4NCiAgICAgIExpbnV4LiBJdCBpcyBwZXJmZWN0bHkgcG9z
c2libGUgZm9yLCBzYXksIHRoZSBmaWxlIHRvIGdldA0KICAgICAgdHJ1bmNhdGVkLCBidXQgZm9y
IHRoZSBvdGhlciBhdHRyaWJ1dGUgY2hhbmdlcyB0byBnZXQgZHJvcHBlZCBvbg0KICAgICAgdGhl
IGZsb29yLiBORlN2NCBjb21tdW5pY2F0ZXMgdGhhdCBpbmZvcm1hdGlvbiB2aWEgdGhlIGJpdG1h
cC4NCiAgICAgIE5GU3YzIGRvZXMgaXQgdXNpbmcgdGhlIHByZS9wb3N0IGF0dHJpYnV0ZXMuDQog
ICAyLiBXaGVuIGRvaW5nIGEgZ3VhcmRlZCBTRVRBVFRSLCBpZiB0aGUgc2VydmVyIHJldHVybnMN
CiAgICAgIE5GUzNFUlJfTk9UX1NZTkMsIHRoZSBjbGllbnQgbWF5IHdhbnQgdG8gdXBkYXRlIGl0
cyBjYWNoZWQgY3RpbWUNCiAgICAgIGFuZCByZXNlbmQuDQoNCg0KPiANCj4gDQo+ID4gPiA+ID4g
Rml4ZXM6IGJiNGQ1M2Q2NmU0YiAoIk5GU0Q6IHVzZSAodW4pbG9ja19pbm9kZSBpbnN0ZWFkIG9m
DQo+ID4gPiA+ID4gZmhfKHVuKWxvY2sgZm9yIGZpbGUgb3BlcmF0aW9ucyIpDQo+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA+ID4gPHRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gZnMvbmZzZC9uZnM0
cHJvYy5jIHwgNCArKysrDQo+ID4gPiA+ID4gZnMvbmZzZC92ZnMuY8KgwqDCoMKgwqAgfCA5ICsr
KysrKystLQ0KPiA+ID4gPiA+IDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9u
ZnM0cHJvYy5jIGIvZnMvbmZzZC9uZnM0cHJvYy5jDQo+ID4gPiA+ID4gaW5kZXggMTQ3MTJmYTA4
Zjc2Li5lNmQ4NjI0ZWZjODMgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZnMvbmZzZC9uZnM0cHJv
Yy5jDQo+ID4gPiA+ID4gKysrIGIvZnMvbmZzZC9uZnM0cHJvYy5jDQo+ID4gPiA+ID4gQEAgLTEx
NDMsNiArMTE0Myw3IEBAIG5mc2Q0X3NldGF0dHIoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwNCj4g
PiA+ID4gPiBzdHJ1Y3QNCj4gPiA+ID4gPiBuZnNkNF9jb21wb3VuZF9zdGF0ZSAqY3N0YXRlLA0K
PiA+ID4gPiA+IMKgfTsNCj4gPiA+ID4gPiDCoHN0cnVjdCBpbm9kZSAqaW5vZGU7DQo+ID4gPiA+
ID4gwqBfX2JlMzIgc3RhdHVzID0gbmZzX29rOw0KPiA+ID4gPiA+ICsgYm9vbCBzYXZlX25vX3dj
YzsNCj4gPiA+ID4gPiDCoGludCBlcnI7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gwqBpZiAoc2V0
YXR0ci0+c2FfaWF0dHIuaWFfdmFsaWQgJiBBVFRSX1NJWkUpIHsNCj4gPiA+ID4gPiBAQCAtMTE2
OCw4ICsxMTY5LDExIEBAIG5mc2Q0X3NldGF0dHIoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwNCj4g
PiA+ID4gPiBzdHJ1Y3QNCj4gPiA+ID4gPiBuZnNkNF9jb21wb3VuZF9zdGF0ZSAqY3N0YXRlLA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgaWYgKHN0YXR1cykNCj4gPiA+ID4gPiDCoGdvdG8gb3V0
Ow0KPiA+ID4gPiA+ICsgc2F2ZV9ub193Y2MgPSBjc3RhdGUtPmN1cnJlbnRfZmguZmhfbm9fd2Nj
Ow0KPiA+ID4gPiA+ICsgY3N0YXRlLT5jdXJyZW50X2ZoLmZoX25vX3djYyA9IHRydWU7DQo+ID4g
PiA+ID4gwqBzdGF0dXMgPSBuZnNkX3NldGF0dHIocnFzdHAsICZjc3RhdGUtPmN1cnJlbnRfZmgs
ICZhdHRycywNCj4gPiA+ID4gPiDCoDAsICh0aW1lNjRfdCkwKTsNCj4gPiA+ID4gPiArIGNzdGF0
ZS0+Y3VycmVudF9maC5maF9ub193Y2MgPSBzYXZlX25vX3djYzsNCj4gPiA+ID4gPiDCoGlmICgh
c3RhdHVzKQ0KPiA+ID4gPiA+IMKgc3RhdHVzID0gbmZzZXJybm8oYXR0cnMubmFfbGFiZWxlcnIp
Ow0KPiA+ID4gPiA+IMKgaWYgKCFzdGF0dXMpDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25m
c2QvdmZzLmMgYi9mcy9uZnNkL3Zmcy5jDQo+ID4gPiA+ID4gaW5kZXggNmU3ZTM3MTkyNDYxLi41
OGZhYjQ2MWJjMDAgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZnMvbmZzZC92ZnMuYw0KPiA+ID4g
PiA+ICsrKyBiL2ZzL25mc2QvdmZzLmMNCj4gPiA+ID4gPiBAQCAtNDk3LDcgKzQ5Nyw3IEBAIG5m
c2Rfc2V0YXR0cihzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLA0KPiA+ID4gPiA+IHN0cnVjdA0KPiA+
ID4gPiA+IHN2Y19maCAqZmhwLA0KPiA+ID4gPiA+IMKgaW50IGFjY21vZGUgPSBORlNEX01BWV9T
QVRUUjsNCj4gPiA+ID4gPiDCoHVtb2RlX3QgZnR5cGUgPSAwOw0KPiA+ID4gPiA+IMKgX19iZTMy
IGVycjsNCj4gPiA+ID4gPiAtIGludCBob3N0X2VycjsNCj4gPiA+ID4gPiArIGludCBob3N0X2Vy
ciA9IDA7DQo+ID4gPiA+ID4gwqBib29sIGdldF93cml0ZV9jb3VudDsNCj4gPiA+ID4gPiDCoGJv
b2wgc2l6ZV9jaGFuZ2UgPSAoaWFwLT5pYV92YWxpZCAmIEFUVFJfU0laRSk7DQo+ID4gPiA+ID4g
wqBpbnQgcmV0cmllczsNCj4gPiA+ID4gPiBAQCAtNTU1LDYgKzU1NSw5IEBAIG5mc2Rfc2V0YXR0
cihzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLA0KPiA+ID4gPiA+IHN0cnVjdA0KPiA+ID4gPiA+IHN2
Y19maCAqZmhwLA0KPiA+ID4gPiA+IMKgfQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgaW5vZGVf
bG9jayhpbm9kZSk7DQo+ID4gPiA+ID4gKyBlcnIgPSBmaF9maWxsX3ByZV9hdHRycyhmaHApOw0K
PiA+ID4gPiA+ICsgaWYgKGVycikNCj4gPiA+ID4gPiArIGdvdG8gb3V0X3VubG9jazsNCj4gPiA+
ID4gPiDCoGZvciAocmV0cmllcyA9IDE7Oykgew0KPiA+ID4gPiA+IMKgc3RydWN0IGlhdHRyIGF0
dHJzOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEBAIC01ODIsMTMgKzU4NSwxNSBAQCBuZnNkX3Nl
dGF0dHIoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwNCj4gPiA+ID4gPiBzdHJ1Y3QNCj4gPiA+ID4g
PiBzdmNfZmggKmZocCwNCj4gPiA+ID4gPiDCoGF0dHItPm5hX2FjbGVyciA9IHNldF9wb3NpeF9h
Y2woJm5vcF9tbnRfaWRtYXAsDQo+ID4gPiA+ID4gwqBkZW50cnksDQo+ID4gPiA+ID4gQUNMX1RZ
UEVfREVGQVVMVCwNCj4gPiA+ID4gPiDCoGF0dHItPm5hX2RwYWNsKTsNCj4gPiA+ID4gPiArIGZo
X2ZpbGxfcG9zdF9hdHRycyhmaHApOw0KPiA+ID4gPiA+ICtvdXRfdW5sb2NrOg0KPiA+ID4gPiA+
IMKgaW5vZGVfdW5sb2NrKGlub2RlKTsNCj4gPiA+ID4gPiDCoGlmIChzaXplX2NoYW5nZSkNCj4g
PiA+ID4gPiDCoHB1dF93cml0ZV9hY2Nlc3MoaW5vZGUpOw0KPiA+ID4gPiA+IG91dDoNCj4gPiA+
ID4gPiDCoGlmICghaG9zdF9lcnIpDQo+ID4gPiA+ID4gwqBob3N0X2VyciA9IGNvbW1pdF9tZXRh
ZGF0YShmaHApOw0KPiA+ID4gPiA+IC0gcmV0dXJuIG5mc2Vycm5vKGhvc3RfZXJyKTsNCj4gPiA+
ID4gPiArIHJldHVybiBlcnIgIT0gMCA/IGVyciA6IG5mc2Vycm5vKGhvc3RfZXJyKTsNCj4gPiA+
ID4gPiB9DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gI2lmIGRlZmluZWQoQ09ORklHX05GU0RfVjQp
DQo+ID4gPiA+ID4gLS0gDQo+ID4gPiA+ID4gMi40My4xDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
DQo+ID4gPiA+IA0KDQotLSANClRyb25kIE15a2xlYnVzdCBMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo=

