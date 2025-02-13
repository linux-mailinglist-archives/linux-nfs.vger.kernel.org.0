Return-Path: <linux-nfs+bounces-10090-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B04A34555
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 16:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587AC1632A6
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FA26B0B5;
	Thu, 13 Feb 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+BhTEfu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sOthv6/x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94072A1D1
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458968; cv=fail; b=SbkJRmSomyi+/lyOZCeCxtCcVzCcuWV3+Nuo8a+R03aVLojgll1K2q3FS3n7wlXLUMvhgpLj9ufvXMxjPjwofTFtDsVWUTTfB9n3FhlFDbzcNEY6X2DFfn+TkXYpgZTQbTbw16lPe9rXGIFHT4+Oz7+zDsVYC26BmAz3kKRqd2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458968; c=relaxed/simple;
	bh=1gZEQogSkrsE/ZB0I718f0VESyaFprD9JwDjATnX//4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YFc29r8yG01nItOZeYDk1OXjUeMVKbnBroXddozZGJNH7MNAEMpHeKZ23pT2WRnd90riNkl4FICKsVCSai/0hEfuATL4Q8NHHL9Y3Geyh1pumLeNweHUuji4YGLolDvO5e7CFdrzo27ldRhigJ3clWkLh3ciF+jmFNVHHykJWhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+BhTEfu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sOthv6/x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fsFL027036;
	Thu, 13 Feb 2025 15:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DB/LriOSfgQMSMpslCZoraytJ1K/7FbbXLD2mhUF0fQ=; b=
	Z+BhTEfuayVmd2DXFhtCRjDOrdo9HVQJHAFYgAnUD1ysxqYhTYaVVB9yfMMNcCU/
	64U3xbMvDbyQVpCe2au9eO+mNYCcJrZLIxmpCED1GG6bFkQXdTikafoCAcLHCx5A
	4UXDiB6/ydnTmtxe4PAKqLX5SbbOUny2IaG9yUV+y3MBvwLVQYqGlmSlgGvr7yyd
	sCY8t6tR5kQa/01JfQOGL8UmXP88g5O5K42glepK5iVXFYcOlUnF6VgFnLC4/HF8
	mLOkRKpaAerl/U7HJax2MhCv/yTEc3tlLwRbpiF0991m1kto+mQbyBklbvy3ggKI
	SoL3O8gG5X9KFDcLFL+oTQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg9usq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:02:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DEOn0g017578;
	Thu, 13 Feb 2025 15:02:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqj4fkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:02:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBWSl/R2ZOFXyHPIeBgIilBia8og5F6q9egUn5J8tBWfcbEUyDtpt4RDiSzkp+eD8kjSyJjXHg0CQmiFEVfDYeZv2TXkXnnEmjlTxbQ+p3N7iJzZX7o1+eoK5dB12IFslQDt/F+LoObaZqXuLiniJnVMbvZs2I+fEoBuWzHXrEimpeJcawtax3Wi/AwSqas5LWaEbSGiJXTvwysi61P4XThslA4ZQT5BKLplNR/4tET7sr+6HQgJ5/Ti5VNfnEB4HMY2tk1C0EgbLqt+Cb5dfRNH8mPfXMZuiZ8/UT8/Fw7m0QP2isUgnMQbTlXISsGwQMyEQpA4iK5e0XKDW5mdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DB/LriOSfgQMSMpslCZoraytJ1K/7FbbXLD2mhUF0fQ=;
 b=bRlvkLYgzmon7cGgZuA6LZL2/vfmzEJd5mgR73eKHd/Fw1BngvMUTlQLtToCF6LkR7Hc85GVxkIxiGr04bqq1NwcyofdfhraqAwCduC8LUvrxzaZqMh6zZsJjXBy8QEaEQ76ojXG+cMUjUdVAKTXMdbIMS9o3MY7b3HtN6x1mUMOsqs6AbD/nOJ3kXUVc0DOwG8dgLUEVO3g+rl5AHQOsM/rMS0bAtKkvSG2oLCXLjvB1FJJ1+d6gAFn65+ZddNzVg8VsyjLJ5SpCU6v52MD4mRgmW4BUKA8CogA2puXfYUiLsNcKaoJAPcHWNeGm6uxBFmJPO4aF+vs1bnWW6eAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DB/LriOSfgQMSMpslCZoraytJ1K/7FbbXLD2mhUF0fQ=;
 b=sOthv6/xtVOaJCZrUrypugzyruVd5VekW/zCenf3+IWaTODukyoxDOaDHzRBpoyLWvb5n+y2ig2vbDEU5uP8aRG9OTzxe7D2LWVNXJDfqtkUUXOp0AXoFt/k/SShj1G7+1wHRXQS+nGyiFxFcWwqyPiQy7xeBCl0b7HHeu9cpOk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4334.namprd10.prod.outlook.com (2603:10b6:208:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 15:02:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 15:02:32 +0000
Message-ID: <98b335bd-e551-4398-95f5-e3b442dc1825@oracle.com>
Date: Thu, 13 Feb 2025 10:02:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] nfsd: filecache: remove race handling.
To: NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <> <Z6qMrhV11Dtcveja@dread.disaster.area>
 <173939861036.22054.7500741229199220325@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173939861036.22054.7500741229199220325@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 276b4d0e-528f-4d98-8485-08dd4c3f7170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTFlNU5GMVJyMDhuLzYvWjRWbkhLeUJPcjVjYVNuZlJEZHUrT3U3K1VwS081?=
 =?utf-8?B?OVNKWVVJWU5nUENSc2UzSmoyNi9xSk5SUFVIeFVpUUJ5QXN3MWsvQTdYd3FZ?=
 =?utf-8?B?MU1NT29ySmNtb2hUMTVPRS9zaGVvS2VuY09TSk1Sa1R5cWFacHF1WkpzVFZO?=
 =?utf-8?B?WGFEWGtPZkJLckdaajZsaU1HYUlYSGE4Q28rR09najFUQzBuaHFUbVZlSjJI?=
 =?utf-8?B?OFRFQXMrejZ3dnJPRld3bFp6S2NNODBKZG1FSDdYWkJ4Ly9jeGptQkNodndq?=
 =?utf-8?B?N3R3OEluNGc0QU1GNk5sRitlMXg5ZFhlUWxXYWtwZWk2R2xoNDh2VlgyWGNo?=
 =?utf-8?B?Q0JqYW93UFJTai8xVzE3ZldwMEpVUzh0UjdnTVFhaUpFYW54TEF4WUV5b1Uy?=
 =?utf-8?B?c1IvU2ZtUzhQdk5oWGtWK2twSEZlcDN2YTUrS2R3cEVhSnhjMkxmUERlVDQ2?=
 =?utf-8?B?OTlpWHBuL3FNdUdkTnRoKzVqaGtkMm4rY0NzR1pUOWpoMk1XYUVMN1RvU1A1?=
 =?utf-8?B?TzBmQjQxdlJ2ZTJPVlVYLzlpeVJBWWdPUUhrNmNrZ3pyaXpvOFNheGZuS08w?=
 =?utf-8?B?UXVKTjByejQva3JYUFQ4QXI0emxYblZxRGg5WG1oQ0pMdVB0eElkTXJrUkhz?=
 =?utf-8?B?L1RDQnJIMEEwdCthNFoxRzdFeml4RFUxYUVkcXZYRVZpQXJYL2laUlN4bnlk?=
 =?utf-8?B?dk1mdUM4VWNETDZsS3NsWFljeW5RWjZYQW9zQVhQb2s3SUxsNlA4QVZaUXJK?=
 =?utf-8?B?cEREM0h6RnpWVmhXSVhsalJOTThhbVVRbktwamZEbjdkOWEwY0hTZ0pCQlg2?=
 =?utf-8?B?enREU0lPelhadzU3YXBTd1YyOVROenp6RmNHNndiNnBkUlJPblVUWWJSeE4x?=
 =?utf-8?B?ZVJDRGpXMEFkcXVaNWRsL1VQWjdaSnp2TWN5VXNJdDV1d0M3TkZ0U25FcmJP?=
 =?utf-8?B?akt4TGZVT2F2L01zMklTdlcwbzMrY2tMUWl0VGY2eUxlUWkvK0hVQlY5eGMv?=
 =?utf-8?B?c0V2Z2NYaVBXMHBCY0VMT3Q3aDJVYy9JRHhwNTRFbm5FZWE4U1BJU2FPNC8y?=
 =?utf-8?B?a3BKWHBCNmJHTE1VWkZHRVZrZE9ZYzhCZkZPbzBZZ0JWRHhmQWdrSnhyTUQz?=
 =?utf-8?B?eEQ5S0VudGtoVE9oUDJXek9SVCtJREJESkJSZEIzd3VwRVhmUHJrd3dVOGVS?=
 =?utf-8?B?VTBITDMzTXBTN0Fic0xuaC9Ncy9oSjY1UkFTZnRZWU42WnNCbEJMRTRmWStx?=
 =?utf-8?B?UVJDQkYwL253enVvZFZvVmliYWRIdlk4eFlydVp6RkF6azRyRkFZdjNlME1j?=
 =?utf-8?B?ZDg4N1loU3RUV0V4ODh0MVpZbUsxdVpaYlQ5RlNtQVpOb0ZRZDJxVlpjN1Yy?=
 =?utf-8?B?RjEyd0JyZTZqcjExTzJMTzBSZXdOenM0YzRQbW9MajZNZ3c4Q09KMWhObFli?=
 =?utf-8?B?Vjd4dUNZRDBkRGtuZXMyZzRBcVBYd29hN0dNd0M1VU5qUVJyeWVwM2tnVHhx?=
 =?utf-8?B?Um9jTUZYS0p5OEJ1dUJhaE9CZndDUXQyaVRXMmR1UTRZRUpOS0U5M0JVV0J5?=
 =?utf-8?B?VTduQlphT2N1Ymo1N1FRbE85bXZIR3hkQlFzOUMvVG05Mi9zOGdUQmVhVlFW?=
 =?utf-8?B?eWF2aXpxTUlseWxGMEdhVmtaUDhUZ2l4NnVYYVVIN0xGaHBYUXlhWFBGY1JN?=
 =?utf-8?B?WDVSTlVZQmlwN0lBYlNXZCsvS0JxdXVDanlXcVpmeEZzWnZxTDIySFl1Q09z?=
 =?utf-8?B?ZlhJR3luVUxwemdncnlkdlRsaFpDYzV3ZzhNL1JCU2dDSmNMbmJteUJOZW9H?=
 =?utf-8?B?eU9tVHA1Njg1RmdyRmRzSXA0UWVRZGszT3Fud0o0YVI4UTVPM2ZIa01HSXJF?=
 =?utf-8?Q?SaKM2mH3ylMqK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm03d2xWZ2RudzVYOVA4WG5EVktJRGRkcVVsaXphZjVTL1VlbHIvQS83R1Bh?=
 =?utf-8?B?REpsQ0o2b3NXUnlTb0NBaGNlS1JUc3UyYS9wellLbnVBSFRzcGFSNzJudXF6?=
 =?utf-8?B?ektjb2FZa1Y0bkVJUWlhRFQybjVJVWlhRzJRRW0wZDBnSmdvRnZHZEh4ek11?=
 =?utf-8?B?Y1BOUjVZWk9zTEQyK09vMEprTUMzcTFLMnZxV2N4Zm5jTkVQcWw5bkIzZWZq?=
 =?utf-8?B?cHpEL1BXTzd5YVRpd3gwL2lkN09SMW5kbjVrQ0Exbm8wb3hGcW5rQjBDeWli?=
 =?utf-8?B?ZVNsdFd5MjMza0Zlbm5MTEhPTU1CTjBqenFmWW1JYTdTM2U2ZWxHc2JhQUxT?=
 =?utf-8?B?Y2NnbnEzcjIwTFVTc2tBd1k3ZnRZQVl0ZEt3TmQydU94SS9DOWF1OWxlSHpz?=
 =?utf-8?B?aW45SGZnSWNyeWpZTCtnaVB0Nk5uVE5uUDByTzQ5S0dLOVM2c0RiNVFwSjhW?=
 =?utf-8?B?bDF0SGxoYmxoWVM3SzJCOS93RTZTdnZMQ3FTVUFKbGs2cCtlcE5LLzgwOTlW?=
 =?utf-8?B?WTFwbmJhMXcyOWtpQUtyUGxzOUQwdUlBWWRxeGxsS0JlRVYzMUZIb2l0T2h6?=
 =?utf-8?B?NktIYVUxM1JLcWtrTlM4STVsTXhxNkttYkRLZ3lmRUt0ZlBMNzZKV0Y1T1Bp?=
 =?utf-8?B?S3hrVndsTHNGVnpFRys5MU1TazBIcnlNNmwzKzM2eVdpbitEcUZSWTRzWXF3?=
 =?utf-8?B?aVZwcUp1Uy9UZHlkcTNyTi90Vm5TVTcrWi9xeUVqOHRQRHJ2VVlCbjdRdWxN?=
 =?utf-8?B?d2RhcG9DVElWSHEzUi92WXRoTVp3QWRLY2pMU1pCZ0xVTm9TTEJGWFQyb1Ey?=
 =?utf-8?B?NDgzbUJjd0Y5aHRxVW1oVGo2eE5QODMrWUQ3aGNmZWJmczRBMzBqRWZwVFpJ?=
 =?utf-8?B?bmI1VHN2OTFFSlJhVjRzM0VTU1ZSQ3hQcjNRS0tNdGY4NmlvOUZydm5wNFhP?=
 =?utf-8?B?VjAzUnJBOU1OeFppeEJla0p4bnlZblltZ00wQ0Eyc2t2VVI0aEx4aFA3dTJv?=
 =?utf-8?B?MkZUZHFnMit2VC9JckZQTVFXZUhXMlMzNGtDeU9nS3VQS0RKTjVHQlR4L3Ir?=
 =?utf-8?B?bmw4NVo4T2swRmZYSlFXOURvcFNqNWx5NjB3ZUJRcElYNFhPWEVnZHhKSStr?=
 =?utf-8?B?cDBpcGhxZVRNSVcreE5lazFjVW1UN2docFowVXZYeEpTSkxVLzYycnR4L0gw?=
 =?utf-8?B?aDFRNHErTTBIVFN1Mkk1ckRmbkZBVkJ3RzRvT3UzVEhMSU11dDluNFZQYUJH?=
 =?utf-8?B?Z0VvM1NXeit5ckd2SUU3K21WMEk2K3d3Yi9CcTNReUs0d09tZGI2TDQ5M1RR?=
 =?utf-8?B?MDJ2V2tmL0FsNlVEZ1FqTG5uell5eDRiTmpDQWRncjVjRGVuTWxtZ2NVeGx6?=
 =?utf-8?B?ZEtrNkJGM2pCK3hjaGFQcVFKNWhGV1RNa1lVNE1hRG5hVGlJOHBTaUw0UXNE?=
 =?utf-8?B?WHYxTWU2N295TmsxUUpnL0hvUGRhRFR2cklIUkNoeFFOUCt5VHo0ejhOTjR1?=
 =?utf-8?B?eWN4SWdmYnZsQWpRZjNEQ0luQmpEcWxTZldFRGgvU2xCdXlaTHUwcnlnaHBV?=
 =?utf-8?B?RWpEQlNuRlNaMXc1cWEzcHFrcitJRndEdmR1R3RYZitOMDhmYnVRQUUzN2ZL?=
 =?utf-8?B?SG9KVE8yRkJKb1RjNEM4OGxPR0NWS0Rqd0pHdEFJODFWSTBlbkJmbDdqYlRV?=
 =?utf-8?B?ck5zZXdXdnV4dll3VUZWYVhnZ1dWdExaZUFlZitSRmJySE56VUZxc1BnbVNs?=
 =?utf-8?B?NEVMNXk2ZXFSalJkWWlSWDExS3piYmdjQ3RyUFA1eVloNytZWWtZZlFqMjBq?=
 =?utf-8?B?STdWaThxellnRG56Sjl2YngxWjBvK1dVVVNqeWQwaVBBeUFSZTR6dHJJbVE0?=
 =?utf-8?B?VFlMMlhHNURJODc4dUdxSDhYQUpybXhoMUlLa29RRW9DU0tlNzEyQ2RBTlRy?=
 =?utf-8?B?MGQ5WjdlNXBVQVNrUEZaSWlBUHZJcVZzSTNObFl5Sm11dWpWTXV5am1LVCtt?=
 =?utf-8?B?cDJETEdWMFVDZ0VKTmpFZkl3Smg1d3BaVzlIeURUY1NFZE9OMVFyTzNyVjFk?=
 =?utf-8?B?TzZENkdGVGcxUVFTNGhldlJjT2tEZjZVbGtNbkh1TVl3ZzJrN3VhS0UwSWRo?=
 =?utf-8?B?YUpHNUg2TkE5R254T0sxTkJlcXZIMXM0MFJTY3ZLNnpJdHJja0pOQWxzaURm?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3wMww3UnS2FFx2OTudMpbtPFu0jUJ8XNNpdcnikf3K2IBwKTbF2XI83RWswA4j9w9+rfKCjFN1d/5cUnYIlrmaOGNCmpV3UcSYZzDmDgagtQHMv6rYG6Yi+8pfDSP4UzrXj1nFFK+/CZq35PrhOavvO39akDakscYwEhF12gi1Cz4TBhLbUNUnuH7iRUP/R7ZsqNGFTy5cwHXSV4SvKyRC0p58EdXMUc+TvZhhAWE3UPxZZW2eeySDx3Yo6m6bBBR1L7CTXWJWTEAc4DeUUVG+yA2NcjGqANDU6XruneVQOy/zT1irQ9I80XlhwyDuwhtMZwxzwXOcQTHO4SQm+ZiPovNS6H4kj5zuUVrQv9K8lOX8ucWtLoFQkUUcMHc0IHqcTWGkkdC1B9IR0yoUkoWpmry2LNv/iBUgT1EZhgjjMOmbXGBOfkR3gkjCmECK1Rz3I6Pw0tabOoHArbkIEPV6PhkFI2Un8WU0zcdnr5zOwevQzxonDPt+YSGGiekyzgILs+MC0rD1kgTts/oDm9pcJ7gI2t7kIxpjQNnkSXPQ9B8uzCgJmfCI6DcGC1OAIJ9QeHCNhy932+oVjDUu+OcqIIkKGALlyvK65Q3ffkhc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276b4d0e-528f-4d98-8485-08dd4c3f7170
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:02:32.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rGUJPRFNb+1fk0SObYNassZF8+c1Sr8DsOvk3UD4lYfK+JpV8gqKkavt22X+PCqhQ0t8o3iSTfA4Vd76X6M8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130112
X-Proofpoint-GUID: uclV9CMQTqeFtcR3NJIczmIHvDQUn808
X-Proofpoint-ORIG-GUID: uclV9CMQTqeFtcR3NJIczmIHvDQUn808

[ responding to both Neil and Dave ... ]

On 2/12/25 5:16 PM, NeilBrown wrote:
> On Tue, 11 Feb 2025, Dave Chinner wrote:
>> On Fri, Feb 07, 2025 at 04:15:11PM +1100, NeilBrown wrote:
>>> The race that this code tries to protect against is not interesting.
>>> The code is problematic as we access the "nf" after we have given our
>>> reference to the lru system.  While that take 2+ seconds to free things
>>> it is still poor form.
>>>
>>> The only interesting race I can find would be with
>>> nfsd_file_close_inode_sync();
>>> This is the only place that really doesn't want the file to stay on the
>>> LRU when unhashed (which is the direct consequence of the race).
>>>
>>> However for the race to happen, some other thread must own a reference
>>> to a file and be putting in while nfsd_file_close_inode_sync() is trying
>>> to close all files for an inode.  If this is possible, that other thread
>>> could simply call nfsd_file_put() a little bit later and the result
>>> would be the same: not all files are closed when
>>> nfsd_file_close_inode_sync() completes.
>>>
>>> If this was really a problem, we would need to wait in close_inode_sync
>>> for the other references to be dropped.  We probably don't want to do
>>> that.
>>>
>>> So it is best to simply remove this code.
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>>  fs/nfsd/filecache.c | 16 +++-------------
>>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index a1cdba42c4fa..b13255bcbb96 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -371,20 +371,10 @@ nfsd_file_put(struct nfsd_file *nf)
>>>  
>>>  		/* Try to add it to the LRU.  If that fails, decrement. */
>>>  		if (nfsd_file_lru_add(nf)) {
>>> -			/* If it's still hashed, we're done */
>>> -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> -				nfsd_file_schedule_laundrette();
>>> -				return;
>>> -			}
>>> -
>>> -			/*
>>> -			 * We're racing with unhashing, so try to remove it from
>>> -			 * the LRU. If removal fails, then someone else already
>>> -			 * has our reference.
>>> -			 */
>>> -			if (!nfsd_file_lru_remove(nf))
>>> -				return;
>>> +			nfsd_file_schedule_laundrette();
>>> +			return;
>>
>> Why do we need to start the background gc on demand?

This call is an original feature of the filecache -- I'm guessing it
was done to ensure that a final put closes the file quickly. But over
time, the filecache has grown explicit code that handles that, so I
think it is likely this call is no longer needed.


>> When the nfsd
>> subsystem is under load it is going to be calling
>> nfsd_file_schedule_laundrette() all the time. However, gc is almost
>> always going to be queued/running already.
>>
>> i.e. the above code results in adding the overhead of an atomic
>> NFSD_FILE_CACHE_UP bit check and then a call to queue_delayed_work()
>> on an already queued item. This will disables interrupts, make an
>> atomic bit check that sees the work is queued, re-enable interrupts
>> and return.
> 
> I don't think we really need the NFSD_FILE_CACHE_UP test - if we have a
> file to put, then the cache must be up.

I can change 1/6 to remove the call to nfsd_file_schedule_laundrette().
Then these questions become moot.


> And we could use delayed_work_pending() to avoid the irq disable.
> That is still one atomic bit test though.
> 
>>
>> IMO, there is no need to do this unnecessary work on every object
>> that is added to the LRU.  Changing the gc worker to always run
>> every 2s and check if it has work to do like so:
>>
>>  static void
>>  nfsd_file_gc_worker(struct work_struct *work)
>>  {
>> -	nfsd_file_gc();
>> -	if (list_lru_count(&nfsd_file_lru))
>> -		nfsd_file_schedule_laundrette();
>> +	if (list_lru_count(&nfsd_file_lru))
>> +		nfsd_file_gc();
>> +	nfsd_file_schedule_laundrette();
>>  }
>>
>> means that nfsd_file_gc() will be run the same way and have the same
>> behaviour as the current code. When the system it idle, it does a
>> list_lru_count() check every 2 seconds and goes back to sleep.
>> That's going to be pretty much unnoticable on most machines that run
>> NFS servers.

I can add a patch to this series that makes this swap.


> When serving a v4 only load we don't need the timer at all...  Maybe
> that doesn't matter.
> 
> I would rather use a timer instead of a delayed work as the task doesn't
> require sleeping, and we have a pool of nfsd threads to do any work that
> might be needed.  So a timer that checks if work is needed then sets a
> flag and wakes an nfsd would be even lower impact that a delayed work
> which needs to wake a wq thread every time even if there is nothing to
> do.

Moving the laundrette work to nfsd threads seems sensible, but let's
leave that for another patch series.

-- 
Chuck Lever

