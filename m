Return-Path: <linux-nfs+bounces-4034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F8790DF51
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 00:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A121F2385C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164E18F2FD;
	Tue, 18 Jun 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bzsp/mA4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2135.outbound.protection.outlook.com [40.107.244.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48A18EFC8
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750746; cv=fail; b=toalcpjnYPrnW6B+tEyqyFV2LQ/SCGgvOZDcl9BAEVFkubKcEU3sP+sPErLSWkKAbHWjge2xYr5nzeEpV5c7HOAuVh7Z21JGHZoGj1ogo/l4j3Zs3W8kDTu6P8NBOLwspgLyPtQkOkFzaBCGNMTyg2rirV5U6Y+z4FaKavH9bGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750746; c=relaxed/simple;
	bh=RyOHAD8Svnh+urJozUzmeSYeM0t46eQC3jC09YYfXBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlBOIzBlwuwWTuytv03Xd8A3ZZFasW4s5DlZ5GYG3VUiOCCNjj39EXm7ctiOrgOlTlFGsJSC9r9LZNyhVFKUGWxNCufw0II1t8TKOcKFJivXCZZV8qQ6b7XsuEBSFi3aKRhV0ed3BWMfvHCKF4hKSSs3Ftl6dM39qYvpRqY9xLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bzsp/mA4; arc=fail smtp.client-ip=40.107.244.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRGl7ozL90IU6++OkYQ3Uui2mV5zY4BymtRqQajV9foHMCAs9WhEjLK+OkOqQFI38zGDM66nm1ahBZtWiwDW/0ppoeAJx6vg6JUvlP0IqzginSEy9pEhrsGFScka1gkuhdfKaVMh53m8SX/xb1rmWyfej6Qn8Wnv4jUrgyen7uDkjOKEBB3inbDLrC1K52/4Qv9590eXimHeqSnFg6IbsYYXEciRJTD9mB3TUJdNYKwc7XYPFce/xRA9xQran73jps7OR9LDjho4tp2iS6MQ6Zc0/RIMDD17OIbGJ7mHAs2ZW5trqwP8yWE7ji0/gR13gmHCZ7pIM5qpLB5HfO+98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyOHAD8Svnh+urJozUzmeSYeM0t46eQC3jC09YYfXBk=;
 b=TVlp6clxmAMowGeMOClhLTma19Yje6+kkx3O2Qb9oT2WCX186Mu0BwVqpMQfMdQXtd386bbDp5GCjYsKJ/aSGjN8bRG5GPBraxN3F9gXjCKs8jIkjnJbs8kQASim5imohPK9VyEYR5PG3+0B+X49mAdtRCxIDTZM0eM/YxM9iG9oW4IY1fn1GNXn7lwJsimf5wPlaHxMyQD/9z1Mlr6x1R3VNrzl5Gi1/tIrLWmiwfxZ3R7xFDCXShRSqlx2ow5h4Tq1Rn4rjQKFaeGXX9lCaY+WKOkz0LzHzs+GldXcJxxCsf/c9GiBZWxTV7QqmreHco//6EjOXH2IjzFUFQUv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyOHAD8Svnh+urJozUzmeSYeM0t46eQC3jC09YYfXBk=;
 b=bzsp/mA4uNujptte3/SylrNNgosglQNhnSkIW2aH91VnwPXINFuuFlTwq1u9XDPFVQP4dzaBs/+0OU0FW7zBUMn8UdHyck54csInRMgHcBRFA8zJSyxAVOgwp+6UYZGlJ/5iL0q22VdbaoiWEMLGZ9D8J4nB2KrvLl5qOWpYY50=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4613.namprd13.prod.outlook.com (2603:10b6:408:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 22:45:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 22:45:41 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH] SUNRPC: Fix backchannel reply, again
Thread-Topic: [PATCH] SUNRPC: Fix backchannel reply, again
Thread-Index: AQHavmXkO5URUV1Zt0G8pjbIluq3+7HOADIAgAAlfYA=
Date: Tue, 18 Jun 2024 22:45:41 +0000
Message-ID: <f4b5bb6c7c4322d87b09bb101b402e45d717fe57.camel@hammerspace.com>
References: <20240614141851.97723-2-cel@kernel.org>
	 <ZnHuoD3JrXk0ho8O@tissot.1015granger.net>
In-Reply-To: <ZnHuoD3JrXk0ho8O@tissot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB4613:EE_
x-ms-office365-filtering-correlation-id: 18176f31-8961-49a3-57d6-08dc8fe86184
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXBMSUtXSStWVWZEcXFLQ3pYTWtjc2JsL25JSVI5UzZLb05nQVVSZ2QrZHpl?=
 =?utf-8?B?cjh4bDBVNzFLMXpZbUVmemxqRVVGalowVENpdDZiMnEwbmpZNi8wOVNwakJV?=
 =?utf-8?B?Sm1qeUxPTU8rdmFDYTJhVG9zYThEdjl6SWhnY2Rmb3lHT2R6UXZKbkYwLy92?=
 =?utf-8?B?V0dVS3k5dWZVVERrY3d5bm1ZeW0xRTdVMnZPOGo5OUZFMUE2NTgvZkNWQzhW?=
 =?utf-8?B?YlB5cEcwZHJKWFpDZTR4b25USW51Z1BacC9Ca1o0QWUrY3c5N3p2VVJTbWpP?=
 =?utf-8?B?dm1DMmxBb01TUjhMVEEwc1FMVHQ4a3V1MEdZL05wS2NUNkpUbmFod2dPV1M3?=
 =?utf-8?B?TGpFV3R5NCtBT0xvMVlGeXRlbkUyUHRrZ0FIYVlPdFQyR2N0VXozK0hRSXR6?=
 =?utf-8?B?d1ZlVnFHa09jdjhhWXRJWjVpVzN1ZEpMbDl6eU82Y1BPemFxbWRsdmNmanJ6?=
 =?utf-8?B?VTczYTd5TVV3Ukh3UXFsa3o4UW5IalFheEZhZ2hYeStQWFJhejJKMmV6cGVJ?=
 =?utf-8?B?M3hDQ1BVQWMvSmwyK1MxTVE1SEljSUMxajl4SjNUZzZ3bStKNmFMOXdvbjg4?=
 =?utf-8?B?cTVxTEZkd1hSeno4NU9nKzBkWE52WlZjT3FOa1BlUGhiWEE5bU9jT2Z4d3dV?=
 =?utf-8?B?aG5zdkNTanQzRFpZMFJhaTJONENnbG4rbUdOUHJzd3E5NW1hTVNKaEVFTGdk?=
 =?utf-8?B?VDlweEI5U2tyRW1RYUgrQ2JydzFTcHYzUE1iRk9RbGVoQkhiMXhjcEtZMU5k?=
 =?utf-8?B?RCt6ZmtZbXJsamlISkV3QjFUWUNiLzRHSkd0NGJQNzJiMU1sZHNZYUdZNTV6?=
 =?utf-8?B?U0dDWitIZW5rUzkybEpucm1NL3JFS3dhZEtPUGMwSGdYcUlqR3NzVE1XNUt2?=
 =?utf-8?B?R2ZZcmhkV3NQUWlQZlJjVXNoNmQxZTZsc3dOYXk4MW04dGVRMXRQQ2lyeE9F?=
 =?utf-8?B?MjBWNDg5UFAvM3VMWXFVMkhEZ2lnajV5clFxZE82MnEyS1hsNU8xWURiT0Vp?=
 =?utf-8?B?M2pjVzhKc2RKWmg2Y0NDb2wvSC92Ync3TUg1Tm1lRlEyWlIwWDhhckxvTzFQ?=
 =?utf-8?B?TkRkV2ZrejBQQncxZXBUb3lWeGIyTUVxcVZNM1ovMWp6elYrcTAySmJPMkpo?=
 =?utf-8?B?RFRDamkvcjMwOU5ZRkhCcjYybmgwSi83WDU3cWtPbkpXRlBNMmdyY3dCdDY0?=
 =?utf-8?B?Y0d5MHMvMncwMlhkQytCbDdjb2h4QmI0YUJpOVppckRITDZpRUdwSW5OQStN?=
 =?utf-8?B?MGk2R3d0S1FqY3p5QWJ2V1FXbUU5SGRTR3NRV1Fob3VZTG5BZ3Bmb1E1czFp?=
 =?utf-8?B?Q0lqNWFQNXlyZmlWK1ltLzZaWU8yQXFFcWpxMGxKdVZ0ZDJhWS9CUFNEV0ln?=
 =?utf-8?B?Mjl6dXUvNHhyRVNvQWhpbkl2MGVlcEdoYmRRdStiZlZVUnBuOGYwQzJQTzRC?=
 =?utf-8?B?WUp4alo2Q3VLYTFEN0xTZnQ1cjgxTGRnR2ZDM1JlU0kwTmMyNXFRMEp3Y0FM?=
 =?utf-8?B?T2JmVmM2RkU3U0VuSHhYcWhXMC83eGU3b21QZHlGRkNDaUtKTVgvWSsxSzFl?=
 =?utf-8?B?RkpYWjdTTE0zVFlQTmd2Y0c4WGUzRkI3eXVlQ0lQSUpsWDYrYnVZc3JwaTlG?=
 =?utf-8?B?VC84WGs3bm45ZnRqa2VZSHhMVlhBQUIxWHM5dzI5TVBkSi9yTkJGa3prMkdX?=
 =?utf-8?B?N1pmSkdZajhKWWF0eEE1MWtHNURxUXgrTkR3dnZQOXRMSExzU3ZlVFZsZ2xS?=
 =?utf-8?B?L0pLT2wwUEQyZ0kvV0k4N3lnSnduNkJGVjVWQkFkTERMMXc3MGVtZlJBU0lj?=
 =?utf-8?Q?KJHiazQycLMav5Rvq3SprcalIxBBKz5MmYvio=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlJIeEhmZllybi9mckl3YjdDSHhuV2pJZE9oWHFNL2VUQUdhVHQxVm9RVDJp?=
 =?utf-8?B?WTJ5YytjOXpIZ0NFSUF0aXp0OC8wN3dFd0RTdC9IR05qbzEyQW1sL1VXdWRq?=
 =?utf-8?B?ckJoc3FYVEE2MU4rY1FuNmdlV1RURWlZcmNUL0Q3ZXRBTFhuU2RxY0lOZHIw?=
 =?utf-8?B?d0ZQZWN6L1oyclQ5cnR3RzV0eFdJc3RrdmJpTWpRY2ZDbjJUSWs2NVd1WTZ1?=
 =?utf-8?B?MlVOdWlNN1V6Mk5rdkhwdC9oYnFDbmhqdlVXRjBUWHI0VVpBdFZ6MVU0VjFi?=
 =?utf-8?B?VEliSkxYUllFalJ5T3FrMnVkWWp3bzRJRS8zMlRoZk9jZXkvMHYzZDlDeEV3?=
 =?utf-8?B?UTdscGxZK3VQUkh3TnEzWlRuNFlYZ1NUVlZOQk5pR2MwK3ViU3dIa2E5bU1Q?=
 =?utf-8?B?QUdkTWg5VDZzcmIyRVZCMzhDaU1DeEJBb0VEclpkcEg0NjE4ZWlETExzbUJQ?=
 =?utf-8?B?L3c2UUxPNTJmT3JxTUpsTk5OVnZtcjgySjREdnJqTjFDUjBNd3R2bEp0S1VE?=
 =?utf-8?B?WkZXZmRLa0hRTFBtV2svQXk4a01lWWNVWEdOK3NPWWVUK2t0SERsOFNYRWJY?=
 =?utf-8?B?ZXFRMURBVXU1QTQyVjRqMFBFeFhrSnhtMWhuMnB3REdSWEgrRHREc1BhTGly?=
 =?utf-8?B?a3F4T1BKWDVYZ1ZwSHVUa3NBWVJlMElBYko5cDBSZkZPUmRvMnZYS3E4K25V?=
 =?utf-8?B?eVlIaHA3bmtiZlpISG9CVTBzQW5mR1U2MHB0YjR6R1VjazZFZHJsRTVRejdK?=
 =?utf-8?B?RkM5N2hFY0JLZDZiUE5nNysvdW1sekdzZ0FIOGdNME1iVlNpejNFK2V1ZkVK?=
 =?utf-8?B?S1F6Tno1TFhIWlNkY1Jkbk5PSWltZjJzek1QaDBVRlNiK1hMdm9lNyt0L1pp?=
 =?utf-8?B?MHJQamlHdjBDMFlMRXBuN2xYSm1PQkhmcjVaZU95ZnJwMVZGNHh4NTlmWENX?=
 =?utf-8?B?UmhnMHZQSFdhV2orNXg1YVJaaVlESEU5N200OEdKR3NHMngyNVQ4d0U5NDgr?=
 =?utf-8?B?dWlrcXMzeVZXbTJkT0l1dkc1WWIvT09MSWFIVzFrQXpWRmFqY0RvSHdHVUFM?=
 =?utf-8?B?WE56cUd6NXhaN25URWxOOENSSm9QeG92MXJ6b01qWVBnREFvc004NkhUdWt0?=
 =?utf-8?B?VzIzUXJXejR4YnUwTW1XVnhTSEdIVE5aUFNVb3FMRzZrTTFKUTUwU2RTaGZ1?=
 =?utf-8?B?U3YwL1dsemRKVXYxekJQSGdaYjFJcHMxM3BSK3RMRjY2ZXlQUW1XQWtIU1Mx?=
 =?utf-8?B?MUxXRHhiUnFpVXN5eWYyNXRWV2IxUVZFUHNnSDBMUnI2MFFaYXEweGtFUjFR?=
 =?utf-8?B?U1VnazVkYVkzT1cxUXd3emFoeUM4ZVJrbnZQUHpxRS9LZnkzbWJZVVNEZy9O?=
 =?utf-8?B?a0xjYkRPY0l2Sm95RDRVSU1ZdmRlVWV1b3Q0VjhlT1RjSWZIWjNyQVpPQnY5?=
 =?utf-8?B?TWE4aXFDMGNaZlpJTWN6Ky9Lc1BCLzFjSGJpVmRPNGI4anRuUklaanRnM1Vs?=
 =?utf-8?B?RHB4K1Q1S0ovTEMzeXpyNFZjU3ZKVVF5alFJOFcwWXVNWXNxUVdMV1dLVjMv?=
 =?utf-8?B?ODBSdngyZ2prdmtPQ0s3VW9PSmJPM2ZzcFR3RW5OZzBXN3U3Q2dKN0VCNGRm?=
 =?utf-8?B?aUZmNUJ2Ui9DN1FIY01MQzhrWTdPbFB5MXdYTEdHeEs1NFlZbTN5S0hmMGVl?=
 =?utf-8?B?TzRaUmpMRnZSZjFLZjE4czR1MmpQZmJIUXJzQTR3SEFSYUJUaUlzakRzVURU?=
 =?utf-8?B?eUxlYmNkWFptTzI4M1JMbnI0M29MS04rcGFLcEVmSmEvOUtvU0VzdkkwL0ti?=
 =?utf-8?B?OWx1VU95OWdLZmVIUlp3ZWFsOXJ6NFRqV1ZqZ2ZqOGdGNUMrZVd0L0FBNENv?=
 =?utf-8?B?QWRlaXpCME9ZNVNKVDJ2K0dWQnZSMUJ3TUJKT3FHcFNQL2FXWGIzR3R5RWxh?=
 =?utf-8?B?RzZiQVBQdEFqUlNtZDZ1SkpxSDhqRTZNaGdIRTJUR3BFdFV4Y2hjaGRCV2dD?=
 =?utf-8?B?YkJGMnloL2htWjlGRTRkcklZTTdtZ1pKNHAraEhBbnc5MHQyT1I5VWZnWDVU?=
 =?utf-8?B?TXRhSDV2L0FRUzJMRlFFVExXTHgvM2dkQ0dUdG40ZDJ0TEpXV1o3TGw0VFBQ?=
 =?utf-8?B?Z1ZIaTA0cE1uaVltUHloYjVBQzdrUDhCU20zcndJZWxsbW5GR0hNMnBLY0o0?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1729D07D522064285F1F7C4715FA729@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18176f31-8961-49a3-57d6-08dc8fe86184
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 22:45:41.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kz3d1Jld4iDumjk7IAXb9rnFABisTyj1sR1idulRX9PvyhnkxEeD5DLxjFZGN+XNJ1JJIICtXjqCZWhOunezqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4613

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDE2OjMxIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gRnJpLCBKdW4gMTQsIDIwMjQgYXQgMTA6MTg6NTJBTSAtMDQwMCwgY2VsQGtlcm5lbC5vcmfC
oHdyb3RlOg0KPiA+IEZyb206IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0K
PiA+IA0KPiA+IEkgc3RpbGwgc2VlICJSUEM6IENvdWxkIG5vdCBzZW5kIGJhY2tjaGFubmVsIHJl
cGx5IGVycm9yOiAtMTEwIg0KPiA+IHF1aXRlIG9mdGVuLCBhbG9uZyB3aXRoIHNsb3ctcnVubmlu
ZyB0ZXN0cy4gRGVidWdnaW5nIHNob3dzIHRoYXQNCj4gPiB0aGUNCj4gPiBiYWNrY2hhbm5lbCBp
cyBzdGlsbCBzdHVtYmxpbmcgd2hlbiBpdCBoYXMgdG8gcXVldWUgYSBjYWxsYmFjaw0KPiA+IHJl
cGx5DQo+ID4gb24gYSBidXN5IHRyYW5zcG9ydC4NCj4gPiANCj4gPiBOb3RlIHRoYXQgZXZlcnkg
b25lIG9mIHRoZXNlIHRpbWVvdXRzIGNhdXNlcyBhIGNvbm5lY3Rpb24gbG9zcyBieQ0KPiA+IHZp
cnR1ZSBvZiB0aGUgeHBydF9jb25kaXRpb25hbF9kaXNjb25uZWN0KCkgY2FsbCBpbiB0aGF0IGFy
bSBvZg0KPiA+IGNhbGxfY2JfdHJhbnNtaXRfc3RhdHVzKCkuDQo+ID4gDQo+ID4gSSBmb3VuZCB0
aGF0IHNldHRpbmcgdG9fbWF4dmFsIGlzIG5lY2Vzc2FyeSB0byBnZXQgdGhlIFJQQyB0aW1lb3V0
DQo+ID4gbG9naWMgdG8gYmVoYXZlIHdoZW5ldmVyIHRvX2V4cG9uZW50aWFsIGlzIG5vdCBzZXQu
DQo+ID4gDQo+ID4gRml4ZXM6IDU3MzMxYTU5YWMwZCAoIk5GU3Y0LjE6IFVzZSB0aGUgbmZzX2Ns
aWVudCdzIHJwYyB0aW1lb3V0cw0KPiA+IGZvciBiYWNrY2hhbm5lbCIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4gLS0tDQo+ID4g
wqBuZXQvc3VucnBjL3N2Yy5jIHwgMSArDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9zdmMuYyBiL25ldC9zdW5y
cGMvc3ZjLmMNCj4gPiBpbmRleCA5NjVhMjc4MDZiZmQuLmY0ZGRiMjk2MTA0MiAxMDA2NDQNCj4g
PiAtLS0gYS9uZXQvc3VucnBjL3N2Yy5jDQo+ID4gKysrIGIvbmV0L3N1bnJwYy9zdmMuYw0KPiA+
IEBAIC0xNjQzLDYgKzE2NDMsNyBAQCB2b2lkIHN2Y19wcm9jZXNzX2JjKHN0cnVjdCBycGNfcnFz
dCAqcmVxLA0KPiA+IHN0cnVjdCBzdmNfcnFzdCAqcnFzdHApDQo+ID4gwqAJCXRpbWVvdXQudG9f
aW5pdHZhbCA9IHJlcS0+cnFfeHBydC0+dGltZW91dC0NCj4gPiA+dG9faW5pdHZhbDsNCj4gPiDC
oAkJdGltZW91dC50b19yZXRyaWVzID0gcmVxLT5ycV94cHJ0LT50aW1lb3V0LQ0KPiA+ID50b19y
ZXRyaWVzOw0KPiA+IMKgCX0NCj4gPiArCXRpbWVvdXQudG9fbWF4dmFsID0gdGltZW91dC50b19p
bml0dmFsOw0KPiA+IMKgCW1lbWNweSgmcmVxLT5ycV9zbmRfYnVmLCAmcnFzdHAtPnJxX3Jlcywg
c2l6ZW9mKHJlcS0NCj4gPiA+cnFfc25kX2J1ZikpOw0KPiA+IMKgCXRhc2sgPSBycGNfcnVuX2Jj
X3Rhc2socmVxLCAmdGltZW91dCk7DQo+ID4gwqANCj4gPiAtLSANCj4gPiAyLjQ1LjENCj4gPiAN
Cj4gDQo+IEhpIC0gd291bGQgbG92ZSB0byBzZWUgdGhpcyBpbiA2LjEwLXJjLiBJcyB0aGVyZSBh
IGNoYW5jZSB0aGF0DQo+IGNvdWxkIGhhcHBlbj8NCg0KSG1tLi4uIENhbiB3ZSBwbGVhc2UgYWxz
byBzZXQgdGhlIHJlbWFpbmluZyBmaWVsZHMgaW4gdGltZW91dCB0byAwPw0KT3RoZXJ3aXNlLCB3
ZSdyZSBzdGlsbCBwbGF5aW5nIHJvdWxldHRlIHdpdGggd2hhdCBhY3R1YWxseSBlbmRzIHVwDQpo
YXBwZW5pbmcgaW4geHBydF9jYWxjX21ham9ydGltZW8oKS4gSWYgdG9faW5jcmVtZW50IGhhcHBl
bnMgdG8gYmUNCmxhcmdlIGVub3VnaCwgd2UgY291bGQgb3ZlcmZsb3cgYW5kIGVuZCB1cCB3aXRo
IGEgc2lsbHkgc21hbGwgdGltZW91dA0KdmFsdWUgb24gYSByZXRyeS4NCg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

