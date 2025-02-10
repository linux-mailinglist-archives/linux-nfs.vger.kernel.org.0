Return-Path: <linux-nfs+bounces-10011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4656CA2EFBB
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D743A3B34
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066C2528E1;
	Mon, 10 Feb 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OxeoZKwG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RPqnnv5b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB825252904
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197601; cv=fail; b=AqK+tPfnd83S+UwQ30tcT/lpV3omRvkjhbUYnlUMgomCmkd/E4LQHKPGAAQo5TEl1j4gaFlDyc023GD6lWt6Y8Oiud4c6IfrZX8gaAzTBmE4fibojgqZjKaTu3gFRvycv24Y3iBlFq8M2v8FmGMs58kjjsNQh1NMbgJ3i1N4TQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197601; c=relaxed/simple;
	bh=vEH5HeXyf9DngYiVmU1giJbYS62ZcLRtljYUs/Km0F8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P6NbieHg+f4HB88pGU/WeORS16n5mktZoH4z+iba74XdWyNUo2EfE/P9Cnl6NrDGS+ikzq8XCbrMBEztnUpPghOD2CE1BxhWiMB5VY/1BAX64o9sCx9rSQmk/+0YZHn0/ymV7wyHBGIPfey0trgA7SyiPo89VEsDHmH7VqYJ+VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OxeoZKwG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RPqnnv5b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A7tj6w001762;
	Mon, 10 Feb 2025 14:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CG+FcRmUfIuiLxO+fV44u0T+kc845sUxbMPLNKVp57c=; b=
	OxeoZKwG9cyXgs+xOpvvwEyH5Wsk1DvTOstlkUn/o5+c4JWFghx/zsf3/QDGSWn8
	NfOApDpIYtD2WKFOe0EX3h1ohgbbyEiHR2k42nCANlyCSyvm4JVRo2tPmu2D2gW8
	R9B2fxvlMfylCAsCZuLgutLil6l5Y2rhI5YFpT+HQWwwk497EEF948V+RncgliSH
	FMSP0MGcm0RAZkhDcBKlU+37ACdPBY0+z/97qPRC9UIEgDYKbuvf78l6/RYOd5Nk
	dDqTVxZt43GHSqD4L1fEza5RVSwy4Tgcn9wv0o/2o+rYWe3ONh/uT/mprYiMR94v
	Vlgtecx5Wy8AbQGyg+f+aA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn31e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:26:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AE4pxE012700;
	Mon, 10 Feb 2025 14:26:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq7esww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkYLaUuE04Pi3CUwkfqG2XYPRdNXwyobLcloS8KwPu8ic5VJHcKVqXLvvcr15Nl+Jte0CyCrtozsdO01ZM8/wL77RdgDrAWKcmqByJzL7lsKrLYc09znUoDNoe2gRhLZTT1AQrZNo/RzgV+Wwh/2Bysg1IfvFBAaPJI0F2tCZIDlItPjHURGiAJK09AVhZPZM6CqAAFH2e8HYIjfg0BgG2t8C8t1p40KSOQGVXJPJ16TIZcPB8l6mSATfkkGKWQaG7eUN4d1g0ASYUNBH3N/HNcjvJcFQGWs4RCdWXAGBfgsSkvceOx2cclHrQUGimmAsezePiri3lUSv/dniFVJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG+FcRmUfIuiLxO+fV44u0T+kc845sUxbMPLNKVp57c=;
 b=LosHfkztUbv4KrZM2f8byeBb+h6WzhNs/fTLNXULrukTVV5kTENcaqf5APFre1uxTRmwMdVJ+4xdkrfgjb82qcD6qYart+bVpQiJaoz+Or6l7DUDSsQSU8dVJkfxxBQYuc2xTz6d2FiF9cvVb0JTh1xOqAV/wfhxSvd9yHJyqJcb6bLEggkmcZAfxprqQZ6BFxmgfgySwSZy6N3UM18aCNg92t5dvLsXhTNjHFABAUsA+aOe/+cAkXeSYTaO9e8V6f2op9YhWXjSzoeW5gQ3LaXHFXBDF9NUdqVgwCjU72ILEL43IYKZOq/yZf6Jsk5dykkHBl1x/fSBbHNBqVXFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG+FcRmUfIuiLxO+fV44u0T+kc845sUxbMPLNKVp57c=;
 b=RPqnnv5blc16GL63ioWgnzLYzB2dEpNlh5IMAPA2loV+Ws234srnVIJBwxQyZRSl4Gpybs2Xqcsa2IYuKcQ5RlR2AX60IF1YZi4TLzxnDs7qWBcQMpTXdtT+dUblNT4Cnb76yGG6EJpwujb5MUE7sXuOPQw9hYX8knr4BUcGGoo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8163.namprd10.prod.outlook.com (2603:10b6:208:515::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:26:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:26:21 +0000
Message-ID: <9571d19f-ed73-43ae-a3f6-e1b75f2ea5a5@oracle.com>
Date: Mon, 10 Feb 2025 09:26:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Dave Chinner <david@fromorbit.com>
References: <> <0efc7c87-25ad-4859-99db-0a33037e5bfd@oracle.com>
 <173915469913.22054.2038589010660243237@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173915469913.22054.2038589010660243237@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:33::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ebb8f5-bf60-4fc1-407b-08dd49dee3cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHJ0aHJRRTJvS2YybW11emt6TW5XVml6dndTSWxYRSs0VTY3UVFud3BReDg3?=
 =?utf-8?B?MGFGUFFpUFROdWxXU3UvMTNlTVBmTlBONTNIMlYxNldBTHhweWxTbXpKZ1h3?=
 =?utf-8?B?cEpTWmJaalMyaGdxMGhFaGtzM0hBNmQzMnRWQzJCeFFtU2E5SG1oeUJJTlVE?=
 =?utf-8?B?OTF1eXAxbnlWem0wZlNtQlBKSDZpcG5iSkRNMlA2aHluNVpqZWJQVDQrTG1k?=
 =?utf-8?B?YTZIRTZqRmdnSVUyZlc1OXpubWtrSjAxNkJ0WkFxTzhOTnlpWXJOeENqZVVk?=
 =?utf-8?B?SDJoQ1hYcVBNVnZhbk5QT2czcXRlUVNvWUtQWGxaR3NLMGl1MVQ0SHFRQWcz?=
 =?utf-8?B?TjE2bnM2RWgvS0pyVFdhOFRaYm1KcGJnMklKNzRFTi9HV2I1b04yVnlhWVBF?=
 =?utf-8?B?VlpRV0R4UEhRL01lSHNWcE1WTkp1bjVDejhTRFBYUjNYZkwrdzc0RkNXaHdB?=
 =?utf-8?B?dFdJeW5kOGh6TGhyK0NWUW5IeFExbHV4Znl3UUcwRVh5eWE5aXA3RFRmRmZs?=
 =?utf-8?B?bFAwL3ZQT25BOU5ZZDhSU01HRWl1WkhESFRFSFRVencyRXh3aWhFbzVsR1hP?=
 =?utf-8?B?b05vMVY2M1R2ajZTanhVSFhnYVAzSVA4VXFvcVU3OVJqSFl1L05Ld3VuRXZH?=
 =?utf-8?B?YWx4Ni9RZnNnQXFXeGo1SWZOOGRZN0VIcGQ3UVJpbGo0VUZ3RVBtVjJjTWV4?=
 =?utf-8?B?eGVPR0lKL1FNYVdabmNGR3Y5aTYybG5Xd2grUklBTW1WZ2xYblVwL1JpVThv?=
 =?utf-8?B?T2dxazlFeUNBcjZsbS9BK2hmenRCQlY0elBSZXVLZlE4ZGRoWmxFb0dxU05q?=
 =?utf-8?B?RWlnV2h4TlBmQS90UFdhcm8yRzNLb2pncWRKUTY2RXZoMGtUaWtTeWZmZVZI?=
 =?utf-8?B?ajhFWHViSDFXVzAzSEpkV0g4VW9FSzJESEN6M1VKQmVFWGdMVERsWVgvY0Mx?=
 =?utf-8?B?SVVlSVhVZG1mK09IbUdsREpacUJMSno4U3lOdGVIM2VEQXliNGJXTlVZdXVM?=
 =?utf-8?B?eGppdFI2MGlLalRVb09JcWlHN2tiUldVZjFVYVU4NkFxbTVmMVdiY054bFhW?=
 =?utf-8?B?Y05VVkJYelB6UW1QR09XVFk1K2Ewa3hnZmZmOUZHRHBhWHpvenowUGMwY3dC?=
 =?utf-8?B?VGhSYXYyZXh6WHFTODNSY1UzZ2ZkZUxRUEloRml3Sk1sY2o2Z1RLd0N4cUNY?=
 =?utf-8?B?eXdGUC9PN1lGZzN6MDhaVTllekhNRHVNMzRveDB0ODJGV3gxd01TM2t1anhB?=
 =?utf-8?B?Y2FJMzdESFp4VktxbHUvSHNxa1k0M1NJY3BaK2YzQnMrUEEvdUZGa2RTTTkr?=
 =?utf-8?B?YlBrMXVqMW41QnI5cDEzR0xZVzEwQi80L0VUVkQ2Ky96WC9lSFZTS0o0Z0pv?=
 =?utf-8?B?UGlhVENlSkFLNVNVTGNsbzdmcUF5RCtXMUxHSTBvYSthclpwYmlXbjhhUlBN?=
 =?utf-8?B?bU9vb3hYS3JPakpsejRMaTdxdUg5NExZTmd4WlhnRURQK3p4M3puNzZjWVFX?=
 =?utf-8?B?dTEwZTdWSzhQVThQc2FGTFhoZXdQdjNHWHlGdkVSRXJ2OWlhK1JmN3djNVNj?=
 =?utf-8?B?cWJLUG93L0ZIOXpVWU03UXRYL3ZJbUNzOFFid3ZzUjZoQWF0WCsxWWtqeU1C?=
 =?utf-8?B?c1ZtNEJGR1JmZml1Y1BHaUI1Ri9YNUFIV0tFTlEvZkZERXNJU3kzekVtTXdP?=
 =?utf-8?B?b2xDeVo0cTk1RFNwUGFpZm1VbTN3T0pPK0g2eTNJNjcxeWlHMVlpSWp2VEJq?=
 =?utf-8?B?WHQ1R1JyZ2pCNzVKU0c5ZEZDczZnVytpRHpVSjcrdmJ5UUNkb3JuQ0tZT3Q2?=
 =?utf-8?B?aDFic2VUeUFzUkpXWjlCeUh6Qk9LQUp2RkpzanMzSjlsMWwwZGEyL1Z6Q1FB?=
 =?utf-8?Q?ciqof0LOkAi6v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1NMWnNsVStWeENEMlM3eWk0ZnVTeUI1cERhTkovYTIxMUZySXAwTGd6emhU?=
 =?utf-8?B?bUprWEVWRGlNQUdoUEZNRmV2WUw1blhvdE5KQTBMMDlOVUJxb0NnWnN0SWFG?=
 =?utf-8?B?YTA3MTNJOUE1a01adFB1NEVGakV1TlN6YlRWbzVCUGZ3eFU0VE1lSGs2RnY3?=
 =?utf-8?B?ZGtqaCt3WmVtRHlHblJCKzhiaW04b2RxTnlIU2NUWjI0aEZRclJyRmdKY2w2?=
 =?utf-8?B?cGdyaUoxZWJHZjE5SE9UcEh1QUt3VGhYNU11Q0ZUYVdZS1o1Y2JLa3kyN0ZX?=
 =?utf-8?B?VGIxcG1NOE8xSG9SU3pwak9UT1VyZGhQanlFSWZIZk91cTM1b1NJNFF6NDNT?=
 =?utf-8?B?Ky9sMzJJbDl2RnJKQm5WYldLRDI2MWtlMis1YmVzeXZyclVOZnFPZUlHZG51?=
 =?utf-8?B?QXl4QW9YcHNKekRJV3dicURYdjg2TGo2V2xnRExyQXJ3bGhHVXJrNEdwcUR2?=
 =?utf-8?B?V0Rwa01lenhWR1VhRkVrUEs1d3c0N3BGbmNuRGU4b3FTSmgvTDN0YlJTVDEz?=
 =?utf-8?B?dUsxUTJqOXRmRDBaYmhHZkJGRGxpdWtVR0NEYlJTN0JZZDdjNU0yRzZqUWN3?=
 =?utf-8?B?MmErQVQya0cvVnJNdGZoR0ZRNStCZTVvZlB0Ynl3ZGcxUHloelp3THR3TnZ4?=
 =?utf-8?B?RGl6Uk4xL2t0QkpQcmlocktLbCtUY0VRNGh4YmUzV1dUekFDbEV2RnFvSDFM?=
 =?utf-8?B?UEthQzdKTnZzRWU4Y3RNaGRoRU9qU0Z4bHdUMFVNalFxTEVaT29nODc3V1pH?=
 =?utf-8?B?OVQybC92eFR1bkxvNDk5ZGZLV2t4bWxTOTB3U3Y1L3RrYmJUM05Pb2dEOFlq?=
 =?utf-8?B?T0dCTmJSK3JBbUt0ak9GM3ZHQ3RBVDBKTUFhekdVdE5aU0RYYS9UNklYRDZp?=
 =?utf-8?B?cjVzZ1pCUTl4V1M2ZVFtOXFaYk9SSGRyWmtlZXVFQXREd0NOU0J4cmhzVUpi?=
 =?utf-8?B?TDBvR1N5Vnl4eTJkOXcyQ2tObGMyVGkrQU5sQjRFY2VqTWZVYkw3d0MyYUk1?=
 =?utf-8?B?VzA4aDBzM05lOENvNTJhMVVYeGdGT09jeThOVVczUkZIWmVDUEcwYjJZa0I3?=
 =?utf-8?B?VGdiaGpRTHpKWEZPMlV5N2QxSHhla3ZmVHJSTk55UzdCYVg2SGlFSElweTQx?=
 =?utf-8?B?ZE0xc3dINmZ4QnFWTUU4WVE0NzhnVUhDK09nN3Nod0UybUtoRmNONDdFN0x3?=
 =?utf-8?B?MlVqby9nMkFiUFplZFA5MUhXOWg4RTI4dGQvdGw2VGNxYkt6VEFzOWFaUFl2?=
 =?utf-8?B?L0NzOGNlREs4UmJqMGVTTE1KUXB0YmR6SlpZWi9YaXdONEVBRFBqcnVmQXVY?=
 =?utf-8?B?MHdpVzVZZkNZNmJzcy9vWkhsdm1xdVRGMklvU1VsWk9vbVhYa2psZ2tubXFm?=
 =?utf-8?B?TG9qUkJSRm5DWU1lNjJVYkJzaGR2S2dGVGN5S1FsMFN4OFJ3N2ZER2p4dFBL?=
 =?utf-8?B?SXZjREFTMzdmZEJWWGUyamI1elhkendadUZQM25kVG9lRFkvM20wQjlUZ1lx?=
 =?utf-8?B?cXR1UlVYT3VMUUM5Ukkxc1pKaDY1VElhUXNMZkFDQlVibjhlcmRRRm5qSy92?=
 =?utf-8?B?TjIvTEpnbFl3ZzRSYU1KOHJoTG1jdmUwWDBkS29UQzRmWFFrazlyZFlDRG13?=
 =?utf-8?B?dFVmVVBRaEdCZURBMGU0aDNyYUhlR2RIODFnbWY2T3NSYlFEeHJaVGdiQXpN?=
 =?utf-8?B?TmIvMDhZajdQcHdRNnlhSkxuWVQzYTdxelpLUHR4UzVsNklqdUxvcFlQNDBz?=
 =?utf-8?B?bGlhRjZYNGlMZWJQZExmbitUeS90Z3JEOUFXYm9YcG1CdTZxOFAvM2JyNXAr?=
 =?utf-8?B?eW1YcVBSdm1FVjZHZi9SUm5XWXl6MFBYejhvTlc4Y3FONzdhTEk4Wlo4R002?=
 =?utf-8?B?Ujc1cFRsamo0RTM3M21hdFdRQnNuMlJrZ1gwUEdvTUNpVklkc3pLY0xiMnk0?=
 =?utf-8?B?ZGhURjc3M3hmSWJaRm92VitKbUIyVEk4eWdsandKN3BKYWpueEVFNFQ5bVFU?=
 =?utf-8?B?eERyVGZueDIzYTVMUGRvaVNER3FPcHA2K25LQkFaSnUrUWhPV2hwV3dHQnRK?=
 =?utf-8?B?bW56emVaRkllL01xaXA4OFlJWUtoZzJ6dHZmMEY4d2Z5RUFmYXk1OE40NUxp?=
 =?utf-8?Q?sKXx/HSkLBEeyqkmCOBTF0FSm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OrdqNkWGxlNDNjA/2XmQJzu7i73B5rgJNL9QhoWcPs9f1TPWzcKRhkZf9CRW95Bpiw/QiHHuBM7FbgboYYlreXNvm4vb4N/OQ9TbOfqwPg8YssXuGYatOPG8O835Dn1Ohul8nGpf1gsfIIlEON0HkpXXXuU6lYSjbQQN1BGDrp8vh+ltFev4iFQSeWDQxwYKohtlkWqMooFfLEkSYkjz3q8BrPxSZhjFR2otsAvKWSU8GaNhzAT1vfJI9b/tNN6KdJeB/rWl8wzEhJdMvVd5Wy1zdZMbV+87OMiHDfFZMY7KZYGPd3DtQbpT3C8li26rKO4f31bOx0kfZJ91SuYlF5b16VMGYsRPPWTu6J6mv7wlL715NJXzy77BzPUyEoc4glLVRMupyWLSfNvYG6wouthz0hKKca7wYBz5W1st9DWrB89R81yo3Sn6QckwXzQB+nZ7s8CtgWppkznhsfP6/vWzAtR+r+ok0bE3WJa17I1v9mLc3p+g16zKtiamqkTT9OUqo0HpjfEnU/1A4+8wQLVitZ4lUN/jApTgRQpKglGZAJeJ6H6/kOTYuSp7ZGciJoBHDVQwRFejWPlf0xrAoet+QKRkxgVjRL7K2NYYBpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ebb8f5-bf60-4fc1-407b-08dd49dee3cd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:26:21.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwwP1nB26k9pu2sXauPNTUoxQIpN8PL0IXq2hT00DmLGUvVrG7FMss3sq6VvNwt50rdUc50D9PEcX716heF25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100120
X-Proofpoint-GUID: sUl0BMFs7uxKQgwDz1wYYqxLI-ove2GK
X-Proofpoint-ORIG-GUID: sUl0BMFs7uxKQgwDz1wYYqxLI-ove2GK

On 2/9/25 9:31 PM, NeilBrown wrote:
> On Mon, 10 Feb 2025, Chuck Lever wrote:
>> On 2/9/25 6:23 PM, NeilBrown wrote:
>>> On Sat, 08 Feb 2025, Chuck Lever wrote:
>>>> On 2/7/25 12:15 AM, NeilBrown wrote:
>>>>> The filecache lru is walked in 2 circumstances for 2 different reasons.
>>>>>
>>>>> 1/ When called from the shrinker we want to discard the first few
>>>>>    entries on the list, ignoring any with NFSD_FILE_REFERENCED set
>>>>>    because they should really be at the end of the LRU as they have been
>>>>>    referenced recently.  So those ones are ROTATED.
>>>>>
>>>>> 2/ When called from the nfsd_file_gc() timer function we want to discard
>>>>>    anything that hasn't been used since before the previous call, and
>>>>>    mark everything else as unused at this point in time.
>>>>>
>>>>> Using the same flag for both of these can result in some unexpected
>>>>> outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED then the
>>>>> nfsd_file_gc() will think the file hasn't been used in a while, while
>>>>> really it has.
>>>>>
>>>>> I think it is easier to reason about the behaviour if we instead have
>>>>> two flags.
>>>>>
>>>>>  NFSD_FILE_REFERENCED means "this should be at the end of the LRU, please
>>>>>      put it there when convenient"
>>>>>  NFSD_FILE_RECENT means "this has been used recently - since the last
>>>>>      run of nfsd_file_gc()
>>>>>
>>>>> When either caller finds an NFSD_FILE_REFERENCED entry, that entry
>>>>> should be moved to the end of the LRU and the flag cleared.  This can
>>>>> safely happen at any time.  The actual order on the lru might not be
>>>>> strictly least-recently-used, but that is normal for linux lrus.
>>>>>
>>>>> The shrinker callback can ignore the "recent" flag.  If it ends up
>>>>> freeing something that is "recent" that simply means that memory
>>>>> pressure is sufficient to limit the acceptable cache age to less than
>>>>> the nfsd_file_gc frequency.
>>>>>
>>>>> The gc caller should primarily focus on NFSD_FILE_RECENT.  It should
>>>>> free everything that doesn't have this flag set, and should clear the
>>>>> flag on everything else.  When it clears the flag it is convenient to
>>>>> clear the "REFERENCED" flag and move to the end of the LRU too.
>>>>>
>>>>> With this, calls from the shrinker do not prematurely age files.  It
>>>>> will focus only on freeing those that are least recently used.
>>>>>
>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>>> ---
>>>>>  fs/nfsd/filecache.c | 21 +++++++++++++++++++--
>>>>>  fs/nfsd/filecache.h |  1 +
>>>>>  fs/nfsd/trace.h     |  3 +++
>>>>>  3 files changed, 23 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>> index 04588c03bdfe..9faf469354a5 100644
>>>>> --- a/fs/nfsd/filecache.c
>>>>> +++ b/fs/nfsd/filecache.c
>>>>> @@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>>>>>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>>>>>  }
>>>>>  
>>>>> -
>>>>>  static bool nfsd_file_lru_add(struct nfsd_file *nf)
>>>>>  {
>>>>>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>>>> +	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
>>>>>  	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
>>>>>  		trace_nfsd_file_lru_add(nf);
>>>>>  		return true;
>>>>> @@ -528,6 +528,23 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>>>>>  	return LRU_REMOVED;
>>>>>  }
>>>>>  
>>>>> +static enum lru_status
>>>>> +nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
>>>>> +		 void *arg)
>>>>> +{
>>>>> +	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
>>>>> +
>>>>> +	if (test_and_clear_bit(NFSD_FILE_RECENT, &nf->nf_flags)) {
>>>>> +		/* "REFERENCED" really means "should be at the end of the LRU.
>>>>> +		 * As we are putting it there we can clear the flag
>>>>> +		 */
>>>>> +		clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>>>> +		trace_nfsd_file_gc_aged(nf);
>>>>> +		return LRU_ROTATE;
>>>>> +	}
>>>>> +	return nfsd_file_lru_cb(item, lru, arg);
>>>>> +}
>>>>> +
>>>>>  static void
>>>>>  nfsd_file_gc(void)
>>>>>  {
>>>>> @@ -537,7 +554,7 @@ nfsd_file_gc(void)
>>>>>  
>>>>>  	for_each_node_state(nid, N_NORMAL_MEMORY) {
>>>>>  		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
>>>>> -		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
>>>>> +		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
>>>>>  					  &dispose, &nr);
>>>>>  	}
>>>>>  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>>>>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>>>>> index d5db6b34ba30..de5b8aa7fcb0 100644
>>>>> --- a/fs/nfsd/filecache.h
>>>>> +++ b/fs/nfsd/filecache.h
>>>>> @@ -38,6 +38,7 @@ struct nfsd_file {
>>>>>  #define NFSD_FILE_PENDING	(1)
>>>>>  #define NFSD_FILE_REFERENCED	(2)
>>>>>  #define NFSD_FILE_GC		(3)
>>>>> +#define NFSD_FILE_RECENT	(4)
>>>>>  	unsigned long		nf_flags;
>>>>>  	refcount_t		nf_ref;
>>>>>  	unsigned char		nf_may;
>>>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>>>> index ad2c0c432d08..9af723eeb2b0 100644
>>>>> --- a/fs/nfsd/trace.h
>>>>> +++ b/fs/nfsd/trace.h
>>>>> @@ -1039,6 +1039,7 @@ DEFINE_CLID_EVENT(confirmed_r);
>>>>>  		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>>>>>  		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
>>>>>  		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
>>>>> +		{ 1 << NFSD_FILE_RECENT,	"RECENT" },		\
>>>>>  		{ 1 << NFSD_FILE_GC,		"GC" })
>>>>>  
>>>>>  DECLARE_EVENT_CLASS(nfsd_file_class,
>>>>> @@ -1317,6 +1318,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
>>>>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
>>>>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
>>>>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
>>>>> +DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_aged);
>>>>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
>>>>>  
>>>>>  DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
>>>>> @@ -1346,6 +1348,7 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
>>>>>  	TP_ARGS(removed, remaining))
>>>>>  
>>>>>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
>>>>> +DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
>>>>>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
>>>>>  
>>>>>  TRACE_EVENT(nfsd_file_close,
>>>>
>>>> The other patches in this series look like solid improvements. This one
>>>> could be as well, but it will take me some time to understand it.
>>>>
>>>> I am generally in favor of replacing the logic that removes and adds
>>>> these items with a single atomic bitop, and I'm happy to see NFSD stick
>>>> with the use of an existing LRU facility while documenting its unique
>>>> requirements ("nfsd_file_gc_aged" and so on).
>>>>
>>>> I would still prefer the backport to be lighter -- looks like the key
>>>> changes are 3/6 and 6/6. Is there any chance the series can be
>>>> reorganized to facilitate backporting? I have to ask, and the answer
>>>> might be "no", I realize.
>>>
>>> I'm going with "no".
>>> To be honest, I was hoping that the complexity displayed here needed
>>> to work around the assumptions of list_lru what don't match our needs
>>> would be sufficient to convince you that list_lru isn't worth pursuing. 
>>> I see that didn't work.
>>
>> Fair enough.
>>
>>
>>> So I am no longer invested in this patch set.  You are welcome to use it
>>> if you wish and to make any changes that you think are suitable, but I
>>> don't think it is a good direction to go and will not be offering any
>>> more code changes to support the use of list_lru here.
>>
>> If I may observe, you haven't offered a compelling explanation of why an
>> imperfect fit between list_lru and the filecache adds more technical
>> debt than does the introduction of a bespoke LRU mechanism.
>>
>> I'm open to that argument, but I need stronger rationale (or performance
>> data) to back it up. So far I can agree that the defect rate in this
>> area is somewhat abnormal, but that seems to be because we don't
>> understand how to use the list_lru API to its best advantage.
>>
> 
> I would characterise the cause of the defect rate differently.
> I would say it is because we are treating this as an lru-style problem
> when it isn't an lru-style problem.  list_lru is great for lrus.  That
> isn't what we have.
> 
> What we have is a desire to keep files open between consecutive IO
> requests without any clear indication of when we have seen the last in a
> series of IO requests.  So we make a policy decision "keep files open
> until there have been no IOs for 2 seconds - then close them".
> This is a good and sensible policy that nothing to do with the "LRU"
> concept. 
> 
> We implement this policy by keeping all unused files on a list, set a
> flag every time the file is used, clearing the flag on a timer tick
> (every 2 seconds) and closing anything which still has the flag cleared
> 2 seconds later.
> 
> Still nothing in this description that is at all related to LRU
> concepts.
> 
> Now we decide that it would be good the add a shinker - fair enough as
> we don't *need* these to remain.  How should the shrinker choose files
> to close?  It probably doesn't matter beyond avoiding files that still
> have the not-timed-out flag set.
> 
> But we try to also impose an LRU disciple over the list, and we use
> list_lru.
> The interfaces for list_lru() are well documented but the intent is
> not.  Most users of list_lru (gfs2/quota might be an exception) only
> explicitly delete things from the lru when it is time to discard them
> completely.  They rely on the shrinker to detect things that are in use
> again, and to remove them.  And possibly to detect things that have been
> referenced and to rotate them.  But if the shrinker doesn't run because
> there isn't much memory pressure they are just left alone.
> 
> This is what list_lru is optimised for - for shrinker driven scanning
> which skips or removes or rotates things that can't or shouldn't
> be freed, and frees others.  You would expect to normally only scan a
> small fraction of the list, because realistically you want to keep most
> of them.
> 
> For filecache we don't want to keep them very long.  So I think it
> matters a lot less what we choose for shrinking.  I'm tempted to suggest
> we don't bother with the shrinker.  Old files will be discarded soon
> anyway if they aren't used, and slowness in memory allocation (due to
> any memory pressure) will naturally slow down the addition of new files
> to the cache.  So the cache will shrink naturally.
> 
> I'm not 100% certain of that, but I do think that the needs of the
> shrinker should not dominate the design as they currently do.

I'm willing to consider removing the shrinker, but IMO we can't have it
both ways: if we remove the shrinker because items age out quickly, then
we can't then leave them in the cache indefinitely.

I would need to be convinced that the filecache cannot grow without
bound -- there can't be any pathological cases here, and competing
namespaces can't starve each other.


> Note that maybe we *don't* need to close files so quickly.  Maybe we
> could discard the whole timer thing, and then it would make sense to use
> list_lru().  What is the cost of keeping them open?

The reason to age these items quickly is because we don't want open
NFSv3 files to block conflicting NFSv4 opens. Again, I think that
contraindicates leaving items in the filecache (or, at least, leaving
them open) indefinitely.


> All I can think of is that it affects unlink.  An unlinked file won't be
> removed while there is a reference to the inode.  Maybe we should
> address that by taking a lease on the file while it is in the
> filecache??  When the lease is broken, we discard the file from the
> cache. 
> 
> If that could work (which might involve creating a new internal lease
> type that is only broken on unlink), then we could remove the timeout
> and leave files in the cache indefinitely.  Then it would make perfect
> sense to use list_lru() because the problem would start to look exactly
> like an LRU problem.  But I don't think that is what we have today.

IMO, filecache does utilize the LRU characteristic of list_lru: the
shrinker uses that characteristic to select files that may be closed
early. Early on, ISTR there was a cap on the number of items that could
be cached -- again, that kind of mechanism would make direct use of an
LRU to evict only older items when the cache is full. So there are
technical rationales for the current code structure, but they might have
become historical as the code evolved.

-- 
Chuck Lever

