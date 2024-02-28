Return-Path: <linux-nfs+bounces-2112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841986B98C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0743284C44
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 21:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E588624B;
	Wed, 28 Feb 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XExK8H7O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2117.outbound.protection.outlook.com [40.107.237.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160986244
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154206; cv=fail; b=PElcHD4m+6HtBzE2UDr3+lZoO1D2LrwZR1WTzhW6TDYxfzEHYqgqrZF1Fig70EpXRzOH/8yhduJxH4t8jGQqzgkruQAyDKKeI9pbrJ7IxpXrOA1htiy7PUm0AZ5ZLN+AhSYQGPGkTk+MznR/c+aLNgO/0iBL0sOWpdUp3kBDoi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154206; c=relaxed/simple;
	bh=RN/6JvQurIBvYSCzoqTFI+00kR7iOMjJlbJrjUtRXX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uF5KcPqKITEnYkTqnYwbVQj5HNNKjEBkMAtKUKND35f7qZMVehJN2vakVYWonF2u7EZqzvk80rwUo0BgNRmQviG7jqIOHNqY8dlIKJqVA3RmgY425aYWJMrVAxu1zbhlfvrmRFJN3d619Tglp9ZXV2cLr04igsxyBNpWLuB/afM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XExK8H7O; arc=fail smtp.client-ip=40.107.237.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REQWReG8zlHZ4Sy2v5g3UnbrADxrMDnew5lMpLZCZdNzpaSFRotx/OR7SdFusj/f+4Qsftig4XzDStr95Tt6L+GWiGz5c8S8Lbel1Qfuu4UG6OHjdn8tpT9K8W4WzYmR8qXTOqhtarTPev9vFGYC23QepS2by3qMOhjzxDJS9C+N5RYtcYyyaWpup1Xivf27Rfof0t4wK3hm9OocxUacy1dP0sWWVXZjz06o8ge5Mmt6ZrF19b3FdTxtcAhEBUPKjZR9IDIUCW9iPCbAsH6KLMH1KTXZoY8sVTrAs615CUu3A7RSBgcPdZsr8vBXvyDz77utDDsVPX0ZX4G9MzjRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN/6JvQurIBvYSCzoqTFI+00kR7iOMjJlbJrjUtRXX8=;
 b=L+FMKqdEym5GElGbLwMn37p6HGfz8uRaVC43s+eeoRpd3lv2o8eECGAhka3pV3ob0pKfyEB6ERb4G/p9t2abQXTsl7KWPVUHvMETa+gJV6PaRQmKbysmF9VgnH2WnLO0D3KvjRH8fy1zZHWTkzFdOuYZ3X65yKi1bX6eMAzIBzqur0SOtju/jHOIXaeZqU0G4xY3gwxGgBuY/mFutFOgVBfaupC0aWl2og7KxCEZlDQuZXEsGklTlh0ak7q02iJ8W6ZXo0MalD1B91ilKYPfz/DrLfKZBsxffUhEZPz4ECANb4nfgWdplbhpkNVbMRvsH5Oa6868Z8moB5BHNRc/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN/6JvQurIBvYSCzoqTFI+00kR7iOMjJlbJrjUtRXX8=;
 b=XExK8H7Oo2v7JG0ZcxkZB8HJxjBq19BqQ5rdRwXVCprGnpAmABz5+sos/Bmn9BBsZ7CCUTXLHIKVWbIquidD9sglLK0xniVUFPdBx9MhG9rmjaCpubrNfM1jjlRHhpNmWQoks00eMe8zDm101zrDwd+NTMLIeLZz3D96LfPwqxU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3749.namprd13.prod.outlook.com (2603:10b6:610:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 21:03:20 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 21:03:20 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "chenhx.fnst@fujitsu.com"
	<chenhx.fnst@fujitsu.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] nfs: fix regression in handling of namlen= option in
 NFSv4
Thread-Topic: [PATCH] nfs: fix regression in handling of namlen= option in
 NFSv4
Thread-Index: AQHaZNj8oyB/8DgaKEaGDlPGFyU9xrEgSWiA
Date: Wed, 28 Feb 2024 21:03:19 +0000
Message-ID: <6f42ef00497c15e1ceb2267e69bdeec239910c64.camel@hammerspace.com>
References: <20240221151613.555-1-chenhx.fnst@fujitsu.com>
In-Reply-To: <20240221151613.555-1-chenhx.fnst@fujitsu.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH2PR13MB3749:EE_
x-ms-office365-filtering-correlation-id: 61ee1892-d154-4e15-62e9-08dc38a0b146
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tFDSIb9xOBfvjZ7hLTHoR3Hb4uCiKP7fVkqATXyzitAjUy5Hs2bqWcm2vxLtx5pXrTjNnuRPCaMaCYt8b40+Hlo042qeGPw7fh2VTnIuCAe8ZvvczqTObCW3WgzwqpSmNRQk0URsZ0E7S/dEiv+E0WFSH/reZHcS/RhkApNO5a1BigEKVjWMXX4hyLPmLfsd/A8ATqIrE8NX0ar+bFsy1Rh/obhCUwljG7JGoAOFfDskEOcT9OFK+JcSYjXxlggPywfCvb4FuzD6xiHIBEHBCwzYt1tjyI5hMjSTXEJGGQ9shqcJX92j33W7wAwAyfwUVHBiALVx7N5C4qBL4ccL88zJFnjg302x+QjueHNu4hyeB+/SwSjbV1hcfW0p3Z2HV8/MMRY1Y26wUp2xe/YdPYj7iXTHRUALSUVbrRvMMgizRCGJ8OtBkLSOKNbMXA7E4RJbYvJj4yjALEUUaRlVOgJMBY+tbx4sRlE1IKBjKblKwUOMMinz6UP+jtJLn/os9gyq3AHwaJqp1CyET/XEToOYezNW3dbro+XAa7F44ad43tBQq/643ZOxeqKb08f2b9bRnA/Z+tq1Txxn6WhaoCbw7tr8O7VYZo82tww3nWV/KqP6zBnv4gTzgcwk/a6M4fOllKgF+jcNHYedtjICddk8WTihXYVkVFW28m/O9x2mGyvKcrQQZkYLpXPEr1GOZVIEuvaXeGR6FUUpm2cbRg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEMvRjFsYndxSHMxUlkrcDIyUFZsS1FNbTgrNGdGWVozaFVucUxzQVVoYU5i?=
 =?utf-8?B?Wm03bmpyRW9xRTJyOWI2eUdBZlZjL1U1ZHJsR0d2MWJML3JRUDhKZzVGZ3RM?=
 =?utf-8?B?WGZqb2t5OFRoS05CMzh5Tzg1Yjh5VjFQWjA3d2NkOXdWSVVBeHhJUVR5L3cv?=
 =?utf-8?B?MlcwbTM1bWxrQlNocE4ydXVuSWo2eXZQWlVvZWxZVEYyRkZFME5tdnpyMkpy?=
 =?utf-8?B?Y1UwcjZ0Q3h3RUNxaTZlcG9VdUc4eUpIaXd3QjlFMUpyYlFVa1QrRXpLZDVr?=
 =?utf-8?B?ZFVUb2J4Vy9VaGtJWkQxSWtITkVrWmk0bTJWakJlTi9LQ0N1YmNnRyt3NE12?=
 =?utf-8?B?cDlsWWlMOXEwbGFMTmo1WjltdWJLN045aHpRQ1JmTHZsb2dWZ2NJU0sxRXc3?=
 =?utf-8?B?TnFxRHNLcDNvWm1TOG1mcVZMTU15eWtGeUUrdnVTclRRbU10ZndReHArb2Yx?=
 =?utf-8?B?cUx5TkR0Qi9FR1pPVDJ3alZwUjJJcWgyR1ZvUWV6WTh6WEVuMGsvWHNLU1Vx?=
 =?utf-8?B?ODhURTdiV09MbUpBaWF5cmIyWGErYzByQ2hUQU9wdnU1Z2t6WGx2ZFprc3Bh?=
 =?utf-8?B?SGZWSW9ib1BPK0hXN1FTRzlvTHRIejRWVytiWGZUdmpNaXd5OWVUQm0yQ1Vr?=
 =?utf-8?B?ZlVaMDBVcExFdXB3cDBVd2hkRmxMTVNaU242OWxUYy85T1RLZ2xjdWNEU2dU?=
 =?utf-8?B?dkZjbDc5K1ZKR0c3NGdlcW5ybm1XamdYeUR5R1JSZVIxTjU5NkNqckp0VEdS?=
 =?utf-8?B?Wm4xRS9GaDdDSHZESExqdGx5aFF1am1qYUpEV0c3WW9VU1h1L1NwQVIydnBq?=
 =?utf-8?B?cHIrbG8xcDdpMEZzeGJ5Vlg3dlpoSWtyWExrcWlXRjZJN3dRMjd4K3ZwSExr?=
 =?utf-8?B?TzR3NmdKNlFSUFpCTEZFSStRaVBwbHhMdjJrMC9odGo2bmVweGVsc0lBamlP?=
 =?utf-8?B?YVVxc0ltYWVVb2VXSUlSbGxLZk4zazZVcTlUREFRMEJMNEFURXBjbEN2aGln?=
 =?utf-8?B?K3NBOUk3WUk4L3psOGFGKzZYUWFGcFdrZ1VrNjdrTE9xazA4eU85VTlRVlNi?=
 =?utf-8?B?YnZGalZhQnBVOStOUHVKMkZTdkV3VngzTHRLTkFxeTNuaWhmdGhwUU91Wkww?=
 =?utf-8?B?eTRaOTh4ajY2djNtTFlXYTgyalpEd0hURUJPNDZzNkplRTZhb1RiRU5RVWRn?=
 =?utf-8?B?UHo4cUdabFNLeGhwRTlhdzBUTURZWE5XbGd3dWg3MXpsQW8rQ2Rvc25ZM0xL?=
 =?utf-8?B?cXVGVE5sUnFhZmR0RER1WUE1a1FoMG9JeEZLVnhLRm84elowL1pqSUNoWXR0?=
 =?utf-8?B?MzY5OFErZjVWdmFjV0pUUitQSTZRT3B0V1dRR0J6dVBkaysxVGJmQ3pxVEkr?=
 =?utf-8?B?OTlPNERuRmp1SlVUZ1FDVUE1Wk4zdlN1b0xOVEtiRllzU3ByVHFWNitpWE9o?=
 =?utf-8?B?ZTNnM0NzTVYwWHhlaTZFRDh3TkJwN0hTSmJ2QzhjdGVtNS9TVWVtTjBGYUJo?=
 =?utf-8?B?SEIzS3lhb2RiZjh5Q3ZuTUtuY2dtMXJLTWp5OUVJTnpldWZOWGpNOGtJZkxM?=
 =?utf-8?B?bVNFUGQ3OWNnc0tvWkt5WHBaK0pXSDZiQS9NSmVieXhPakk3UDlxcVdRT0dF?=
 =?utf-8?B?WHp0SHd6c3BXRFlpOGYzQTBwcEFUUXB4ZVdHV2NyWVZjL0FpaERvZzZvZHQ0?=
 =?utf-8?B?U2ZMSFJ3b3h5c2s3akZtQUhzeEVEMUF5RlB0bXEzUHRPakM2QUoxMDJlZjk0?=
 =?utf-8?B?V2paZ1RoSTl1d0pzbGRVTVJlblFselRkNUpVVVROQXNOU0EwUVJZZi8vWWdI?=
 =?utf-8?B?TlZrYWsyZ3RhZ2kzMXpjNlc1R1RRdXJodjFVRVdPNnJCVXk3aEV4emdYRnpo?=
 =?utf-8?B?STNPdjNoenNka2ZHcTdZclNxZi8yLzQ5dkZibVNsMjgwUzZEZlRJN1lpZkQ5?=
 =?utf-8?B?QjZSdUtHRUtydGdaRC9CZDBIVHF5YVRCMXFwY3p4VEY4UERNdEhnYmVIM1c3?=
 =?utf-8?B?L2M4UEpEMmF1d2MvbVVha3BWdUhWdVZnRCttQWRCWnBvbHV5Z01nUWlpU3pR?=
 =?utf-8?B?ZUhGbGl2OEFBMkdvQjlGdUhxNFJuTmlUd0d4N3JFNHZaSkpjRko5NnNYekEv?=
 =?utf-8?B?Zm9KMTFUZnVQa0FvS1dCSTVldzBndDgxVlIrRm1Vb1JxVTVOYjNWamNPL0c3?=
 =?utf-8?B?cHQ0d3JXL0YxdXIwU1BLRkdDWTgwYzAzSUMrOS95bXM2R0h2RVI0dFpkbUht?=
 =?utf-8?B?MDB6Z0ZiY0lMU3JtQlhJRER3OE5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <086D1D8C3D9EE54BBAF0D43E6E7810E4@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ee1892-d154-4e15-62e9-08dc38a0b146
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 21:03:19.9190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+1oQeSIj5v2S7PgVhJ9BpeMETWP9XcZUAqR5vXAGsqd4b+7Ex6HvVa7n5N04kZFFYm6N9tpw6TEfeTkMAkT3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3749

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDIzOjE2ICswODAwLCBDaGVuIEhhbnhpYW8gd3JvdGU6DQo+
IFNldHRpbmcgdGhlIG1heGltdW0gbGVuZ3RoIG9mIGEgcGF0aG5hbWUgY29tcG9uZW50DQo+IHZp
YSB0aGUgbmFtbGVuPSBtb3VudCBvcHRpb24gaXMgY3VycmVudGx5IGJyb2tlbiBpbiBORlN2NC4N
Cj4gDQo+IFRoaXMgcGF0Y2ggd2lsbCBmaXggdGhpcyBpc3N1ZS4NCg0KV2h5IGRvIHdlIG5lZWQg
dGhpcz8gSW4gTkZTdjMgYW5kIE5GU3Y0LCB0aGUgc2VydmVyIHdpbGwgY29tbXVuaWNhdGUNCnRo
ZSBjb3JyZWN0IHZhbHVlIHRocm91Z2ggdGhlIHByb3RvY29sLg0KDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

