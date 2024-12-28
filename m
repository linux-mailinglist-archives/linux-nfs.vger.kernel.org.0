Return-Path: <linux-nfs+bounces-8833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170E9FDBBF
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 18:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925563A1396
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5C42AE84;
	Sat, 28 Dec 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZyVXMI6S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EpoyS3NH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAD18FDDE
	for <linux-nfs@vger.kernel.org>; Sat, 28 Dec 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735406074; cv=fail; b=CqR0fpOys/94/lqZNk6EvlRhDDGrpRTDHOw4IyJHBuTg0L5S38W2OMJV2YTw7w3rBlB0rzEA0WwnX9g0fymGEuNgCk+aywes3/qD8RocbJBFVTxy4zLibZhqZl8IFG6oL/+X3V5Ql6OUTeDx5w3Geuo2m7mgpni4CasnXMkRqWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735406074; c=relaxed/simple;
	bh=FYOtrT4KqeMcArwvVGzEfiflizxJPa2uTC65Q9H2hnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p9cy8hZO0WI5R+5iSA2ludUpOyL7t8se437dEVJ4h7vX+dIRzuuJKTXp1T5nBh+IzMwcVLYThjIPr5jX7Ap6K92LfBxwrtzroJIK+ORf+EWUonD5G420qCM3BbE/J5csb9EZ7zDt0wKTUlycT38r2drjsvF9nRXl/CukT/tUvwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZyVXMI6S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EpoyS3NH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BSGSjAG016685;
	Sat, 28 Dec 2024 17:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gzxgagKc0YwZcL12h4uTLhX+szuRqPD2jOGptMR9xCk=; b=
	ZyVXMI6Srj3TVFAkPF50e/sOn12yKdjNrgTaJKtOiiyAonPR4k/nXqkcX3OcSFmc
	laaBzYl5X4v9osnHBXP4KNl+KgOS+x7o2aNrhqbNieyuSTlA7kXKBrJONuIcQ1gg
	tjxARLS1S14a8zcPiBU1ab3/hYT5PqkbYiTM3TMlwc3rC2QrxAoGyefdR6uO1Wxt
	fq32wr4yh+UGlb3c1xg1HxwBJyfpKkBE/YMkM/ExSQrnoP7fjqyGZh8RU1JXtdgX
	Jmct0jtDphjT1FI3BF+bFE4GdtR3utppKUMb/bhWfUiZAtGkGnwpLz7Xjk8Li4BW
	sBdmPywuMAI/mtgFlshExw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t841re49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Dec 2024 17:14:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BSE0BMI034084;
	Sat, 28 Dec 2024 17:14:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s52pk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Dec 2024 17:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HodRlZh8v86e7B/E5eqpqU/KYnXSYgoqkSJzUdpAE0oXhuhAc9XUPAxUazBd1PPHVTFjLx4BHvE2BHmPW2/ZrTbHgXQeLo9F+HzfMNgzoha4kOz4XiTn1OcH+nqDMMPusxNqeVcQT5yr2YgN2VTvyOmXNLFEY4qPKHOt/lTNu1OZRXPrKqGftNlui4bznjQbpKGcYIWNFYHTyis6UUehAxu1wO9KzLTQhUXTaFZP6cCl1dkMbMvfxzGrT2/p99HO/aNUzpN1PP7+zB37l400fcU8zZu9P6dpYXnlXznmDYriKLp7L/vvDrvxCZcEqiBwNwUdhv7A9Hg/SQUyXdwJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzxgagKc0YwZcL12h4uTLhX+szuRqPD2jOGptMR9xCk=;
 b=IS3DvR1VWeGCGlsJwTN0q0LYLW4z0UlkjWHl4y3J78o7o6lpoWQQbE09YkjQb5snvjhfgka823XyPTACPAdO7M99HQt9uxj060IUrTrEGYWoSw98HA5WnYRtNkngOxwSPBIE6L5CGJOfzcwGruiuqbRRjP7nb0gkcSLqjo9zYtzgKe0B9lS8+rf7WnhlLbRaMKFaL1/q8fOfDopPFiYmG5RF0fFPOjLL7pymXlGt8uAp1thaMtAXhVPEbs4xP78CuF4hdWRmN/lh8JcLoEZuiQjxtz0Ybzm5NgdaWYLYAIIjYT+bX8iothdEdt6punSkE/e0kjapw9CIktQsdgihjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzxgagKc0YwZcL12h4uTLhX+szuRqPD2jOGptMR9xCk=;
 b=EpoyS3NHQcW5Mg1flqWMYAZqB87bDofW1rG6529JvetwXoL6IiL+nSYBaopP47KOb64HO55iMwEbUNQfJqwMfzbCf62ILgOJN/LV0Q2iGqgAd4c5yT32HEZ2CaZihuxEtJwh3SwFI7PvRapGTRqABcjTOspS8TACC4747St2I9I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6489.namprd10.prod.outlook.com (2603:10b6:930:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 17:14:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 17:13:59 +0000
Message-ID: <ae592779-4eb5-410e-b9bc-49165fbb643d@oracle.com>
Date: Sat, 28 Dec 2024 12:13:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode:
 0000
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Scott Mayhew <smayhew@redhat.com>,
        Jur van der Burg via Bugspray Bot <bugbot@kernel.org>, anna@kernel.org,
        trondmy@kernel.org, jlayton@kernel.org, linux-nfs@vger.kernel.org,
        cel@kernel.org, 1091439@bugs.debian.org,
        1091439-submitter@bugs.debian.org, 1087900@bugs.debian.org,
        1087900-submitter@bugs.debian.org
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
 <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>
 <Z22DIiV98XBSfPVr@eldamar.lan>
 <7c76ca67-8552-4cfa-b579-75a33caa3ed2@oracle.com>
 <Z22r2RBlGT8PUHHb@eldamar.lan> <Z25LCAz9-qDVAop9@eldamar.lan>
 <9e988cfa-5a27-4139-b922-b5c416ae0c72@oracle.com>
 <Z2-V_reIDIgJ1AH7@eldamar.lan>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z2-V_reIDIgJ1AH7@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0026.namprd15.prod.outlook.com
 (2603:10b6:610:51::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ae0713-0075-4410-01e2-08dd276304e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L08wandrTUs4MXp2NVZ5SG80REJ6cmVEZ21qRUpUc2xkQlhDYTVQUGtoOHRY?=
 =?utf-8?B?RTVnaFdqRi9EWHczamZMOStBQ3VDZzZVdS9xb3lidGVrcHk3L2RGeEpjMTFQ?=
 =?utf-8?B?M3JTaWdDdk9KMUFteWttT2k2SFovUGFHMGlYOFRHWU1UZk12TmFJbnBDL1hz?=
 =?utf-8?B?R2hnaFFmZUovMlMva2dxTWg5dTZXMzNDUE5aQ0JXZkFrSG9XQjZZYU1kazFY?=
 =?utf-8?B?VFkwbEJjWnRxd3F3M1hwK0ZsWnF1WkRCcFhPbEVrdlZDazJYMm95b28rc2sy?=
 =?utf-8?B?cDdoU09malhROGlhZ2FxUEZUNVhkOXN4SVY1QU1LajBxbkJJdG1sME1sUUhq?=
 =?utf-8?B?cXQ5UW5uUHozOW04bmZRWWxla0lnTG5qdEFWRU02Rm5WNy9hdFMvZDRaQnBE?=
 =?utf-8?B?N01RMW9xTVcvS3FjNWg1N1RZVy9HMk5EM3EwallhVUV1eUlkYndwaUhGYXNR?=
 =?utf-8?B?ZnkrYUYzaFZaSmNOaTJQSjRITUZzUmNYTlIvWGZKVFFGMTRhNDJLSElyZzQ1?=
 =?utf-8?B?eS9CbnNXZjlLNXB3dzRSdnVzRGZRa1h0SHFXMWZwTFo2MUoxeXVJb2tZRDlY?=
 =?utf-8?B?a3VNa1NXQ0JIQTVnN3dBdlgzR1Joby9ZK2wwV2U5c0JTQ3R2N1IyWVErKzNN?=
 =?utf-8?B?QUNTUlZ1eG9Eb0ZxOTZrZUVtQUtUaWFRS0owbTJoNThpQit4VUVJbVlFVGto?=
 =?utf-8?B?aXZyRlNqZVpZSDlpWjV5VCtHQnhBV0xYam9kMy9WVHlpMGtWVjFIeVNGYUF6?=
 =?utf-8?B?dFpwODBsMXFPUEVGbjljSnJZT3RscU50OUt1a01zYTdReHVSOG5qanRJQ0Vj?=
 =?utf-8?B?aFJpcEFiUDMyczJxRnN0VFZ4S3pxd2pEYWppck5hUnJaakswaE94akwxS1Ru?=
 =?utf-8?B?Y0VDMitsSmlicGl6azd2NTNkYm92bnlTMHNGUTVXRVF3UzZZWHZMTzVoYjR1?=
 =?utf-8?B?elFETnVqUlREa21ET0tDL2M1cTB0bjlTaHViV1JWMldPYXdKNGtuNUI2RXpI?=
 =?utf-8?B?djhSUW10Ykl0bUFCOHNSN0VaT1hxellaeDRMTDNlZFYvYllmUkVqSjJKRWZJ?=
 =?utf-8?B?Q2RlK0gyYmhkUUNJQnlWZWthbkxWbG1EVFpwTjBOVGhuenJHZE9DcEZic1p3?=
 =?utf-8?B?OHlwZ0hUM3VxOTRrNGo1aU12MXZqZG4wVDhHUGYvMnRNeDY2RDFQMTFKY200?=
 =?utf-8?B?OGtzYVZjYTJLSjR1aXNQWENuY3psbDdIZUFZRzV0bGVFU1dJWVhyWXV3ZDdl?=
 =?utf-8?B?QmFxbks4a0xDT2luYm9sa0txUXd4Q0E3SlBBUEJJdm0wZGFoSGNUcTJBbHB6?=
 =?utf-8?B?YVNDbFNIaEsvdjZYZ295ZmsvK3VuR0lGVURnRVZZVXIxV0J4K3d6YWlEUUU1?=
 =?utf-8?B?eTROSWpjZHIyWGQzblp5YlVIVGM1SjNNdjZPSkVXQTBoOHNmY3l2b2N1b0Ns?=
 =?utf-8?B?aXFuaitoYzZrcVhLUGdiNlluTEtRb0o1K1h5TVA1TFpZT2lQY2xCbkRYTVUz?=
 =?utf-8?B?QU5YNVRQUDloeW5qZElna09rWmc1ZXZLc3B4bjk1VExmUmFyMXpJaFZLWEMx?=
 =?utf-8?B?eGtkZWZMbmJmSVR1REJNRnIxbFhONWJ6WVcweWQyQnJ4ODJId25hWkxERzBP?=
 =?utf-8?B?c2FkUHdaeGRYM1lWOGZhazJDTDYza3AxT2NWTnRGMDRWdTIwUG1qYW5IOXF4?=
 =?utf-8?B?WnB3Y29YblJWemdQYi9HM2tFZkRwTzBRMHdIZ3VsUUVuNnFMSVUzb2Z5TGdY?=
 =?utf-8?B?cEoyRms1clNySXJjczI2RUo3UHc1aURPbHlyS0Q5cTZ4UFdtOU9NN3hRa1J3?=
 =?utf-8?B?Y05rZFZOTDA4UUNaN3FsQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmpwWWpPQUNFTzhYRVR2MlRUb0wvYWlNVXAzbDVYc1NnRUN5ZDBzM3Q2RUZ4?=
 =?utf-8?B?ckdhQXNQei8zNDJjUGd3QUc2eVBJYjFoeUZLeWhjb0ZyeHhrd01RMkkzbU9U?=
 =?utf-8?B?Q0xPOGduZWtmQjhQQWRydGIzQm9YVERHaFRCYkQza29OcTlvZTVUaldwMkp4?=
 =?utf-8?B?NGlFdGZKR2pSU05kaTNUZk1nNE5HL2UzcnJGT0ZOWlF0SzN4ZG1MV2Q1dXA2?=
 =?utf-8?B?cnduZEU1SUh0S0dRZitCUUpCakJ1L29hYlN4TTFSUWh6dmgvczIvczhDWkk3?=
 =?utf-8?B?QklYNUlQZ2c0dndkYlN0RXRVL2RXRmFTSStNOGZSMFIwYUNWMi9vZlNDeVdD?=
 =?utf-8?B?WlQ4VHMzVktnaTBMUzdSSGlWaU9UV0lhMG5BeWUyRHBkNWd1UEJvc3N4UHN3?=
 =?utf-8?B?ZVpzb2RFcEF1dk4xdzZCcGV5bkNQVjliZ20zYzJxV25wVmpQYldVVGZ2OTV5?=
 =?utf-8?B?V0R5NXlUSVlvUHVtYkRNTnhBT2FDZE5PTlkyTFMwQWNVRzhmeEYxQmM3MnFt?=
 =?utf-8?B?LzNTZ2JQTDB1aXVXR3NSdjVhRDl2akk4TTVQMm5JSTRDR3BuMmxKWVpUZjdw?=
 =?utf-8?B?bUptaEhrdEJ6OGNELzBaUUdjZ3B4K1VyblF6d2wvWmoyeHFhcVN0NFpieXZv?=
 =?utf-8?B?OFdjdzgwVmhGMi9HNzN1ZjA5emwvb2FDSlNicTJ0bHQxdmdFSytFL3Q4SzVq?=
 =?utf-8?B?d2VDT1pTTzNjRE80am9VQ2Q1REd4Q1JSS1cwOU1DSFNRL2cxNG1qV2Q2ZEY5?=
 =?utf-8?B?OXpneFViS2tieDVpL2lMcTEvTkxhWVF6UWFmd0F3QlZDRDEzbXI1OGdJbUNT?=
 =?utf-8?B?RE5zdTIwbGY0VjZHdnZuL2lobWFZZVpFRHBGM1RTbGF1cVladGJlRkNISkdx?=
 =?utf-8?B?NDRxZHNGOGYwQ0lLZDVsMjB1SGxqc0xSM2x4R1NoRVBhSUNJTmpPS2hsbEhG?=
 =?utf-8?B?Z1RYZTlUcXJ3ZnRRUjBDbTFiV0JIdWJyK0o5U2J5TFNNbUt1QW5TRVpPd2xF?=
 =?utf-8?B?Vlh3a1kwdzNPcUZlaGZ1LzdhNzdVc2xEc1N4ckhDUjFQekk1eHhxbmpEemlM?=
 =?utf-8?B?c25XUzI5UTdjRjlFd09ZV3pxVlBXL2Z0SDZTRDk3aUphd3p6NVhhUWRIWlkz?=
 =?utf-8?B?d0hSemtNN2ZOWVhLRjdkTTN6emFOaDVaOVM3dGkvQjJEWW5HQSttUU81dmg3?=
 =?utf-8?B?TW5hNW5WbUtlWlQ1WWVteTFjZGF2dnpnRFR3eVl2ekxJbGlLdVAzRVVWVi9t?=
 =?utf-8?B?dGRIOFRqR3A0UHpteHMrSUJNc0kvWTlPNW84QzB0SlQ0KzJoSnZxWmMxMWpo?=
 =?utf-8?B?Q1RNTkNlRUx2ZjVBdm1vcUtwRG05VUg5VDkwMjJVQjB2M2V2VnpaU3cwK2c5?=
 =?utf-8?B?bXIyZDZ5NVB4Vmd0N2pYNDQ4OEp5Y1pTam0zQlBubERobDhMS2VTYTl6NGYy?=
 =?utf-8?B?eGE2OUZmWTQvM0M4MHlnbXc3RjR4a2d0M3dDaEN2ZDFDV0dmTmd2UzdTNDk0?=
 =?utf-8?B?enBMRTdsQWhaamJyKzU2bjNFTzdUMjZQdWVkUVNmWTJ2Y0R4K0MzWm16TU8r?=
 =?utf-8?B?OXByQnlwcnc2d0NzaS94ZVpObTJvQnhFOUZ6aVRSVUc5ME8wM3ZmSG5kVG45?=
 =?utf-8?B?Wk15c3JoVjNQbXpKTyttTzNzdjNZZzN1SWlaVmdrUzVtY2ZTcG1kRW43Qmhz?=
 =?utf-8?B?cm9ZMTNDbmswVWhOa0h3NmFoL0YyWkZINDVKbHRjQ1FRVlpLTmlYWTVIMVNx?=
 =?utf-8?B?MG9SYStOc3N0b0QzaS93Z0tiT1BJZ0p4RHgvNThlNlNObUI0dFdTMFVXeDd2?=
 =?utf-8?B?MmJRdHl2dTlHZTZ5UDJBOUZRampFcWc0aGRNMHJwaTM2NlhVUnJUUk9Xek1v?=
 =?utf-8?B?RjZRanl0VWFJNk5kWGR6emJwd25GelBTWVR3T0NON2k4VzIvWjZ5UElYZktr?=
 =?utf-8?B?S05VSTFIcHRWQi9jNG1YSlRoM05OR0pCbVJzbWZDYkUweldCRXRlRERVS1lG?=
 =?utf-8?B?MktGZE5LUThReWMwSncrMGc4em9DK2pYdWZjcmZMVnQvSG4wY0JQK2x5aVdw?=
 =?utf-8?B?M2ZRTTQ2MkdWbHN0RE9DcTQxVVZsYzJ1NXJ6dmtqTUYvRFc2RVVwMmVBbFlS?=
 =?utf-8?Q?c+Ho6mUdZ1IWuxM282quVqx6d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HeiPeVn6GT6GYqqDhr9R25JfUhfzamOt3l9Vhi6XSvQInXvRO0U5fxG4j8Hl4AK7Zkxrda0mLvI3+YUur3Kn3ZAlEVMeUREIQHWwBGBW6acgr0Cv1U11e6lJ0MsBSTWRTyisC8NxSi7o2g4O6LHC06vNPJEA1e/q3S+swf++rvfKY+gYAnyOww64fByb6cbYzQ8tbvkOeWfoLRgAYXMB8I4xQq5BQdMDqO3N8i1GIwqq7HmGAh6GY/XSXCcKKIohE7yvTUkrTJ/kaHuOOS9pi4+GWkuOpUpP7TwcdRrhuv1I+4RXL4ZNrdSqkeEbzWgjG230vcW5Q4i6AyViis4/LvezAk/tG+zs/rDrUPgqpvJwCIgRpY2pXRKJwpsi7dpbjGZjJxle33nAiI8x3uB8yPVGfySVgs+AEU8CVNVQBXPMF8+nHWMJGRgxdakI+/jX+Im1ZjXEyHouCcKTiw9UX9AW8c7Ayi52kWka07g7SfzQ3fzzXKi6zjP4+q8vQgjqNnlbYciLPVe+mCzkbmRdubao1Se9AImbui2MQZdIoufYsMGKI+QCdGggD1X67C/1rL7erlTakx49H53ddjO5vW1fb7rSJ2bg1SHsiVXarnw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ae0713-0075-4410-01e2-08dd276304e8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 17:13:59.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTxiMUCR6lPQvGfPQ6Hc2zcHIGddJOYGpHhurFKf+CRffPO+eo4rxdORBRgKASxhFAEIWReUuGxbp6q/+Uhwhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-28_04,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412280147
X-Proofpoint-ORIG-GUID: C3jelWsk1-bWYIOXeymcW2kioEeirG_x
X-Proofpoint-GUID: C3jelWsk1-bWYIOXeymcW2kioEeirG_x

On 12/28/24 1:09 AM, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Fri, Dec 27, 2024 at 04:31:44PM -0500, Chuck Lever wrote:
>> On 12/27/24 1:36 AM, Salvatore Bonaccorso wrote:
>>> Hi,
>>>
>>> On Thu, Dec 26, 2024 at 08:17:45PM +0100, Salvatore Bonaccorso wrote:
>>>> Hi Chuck, hi all,
>>>>
>>>> On Thu, Dec 26, 2024 at 11:33:01AM -0500, Chuck Lever wrote:
>>>>> On 12/26/24 11:24 AM, Salvatore Bonaccorso wrote:
>>>>>> Hi Jur,
>>>>>>
>>>>>> On Mon, Dec 09, 2024 at 04:50:05PM +0000, Jur van der Burg via Bugspray Bot wrote:
>>>>>>> Jur van der Burg writes via Kernel.org Bugzilla:
>>>>>>>
>>>>>>> I tried kernel 6.10.1 and that one is ok. In the mean time I
>>>>>>> upgraded nfs-utils from 2.5.1 to 2.8.1 which seems to fix the issue.
>>>>>>> Sorry for the noise, case closed.
>>>>>>>
>>>>>>> View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c2
>>>>>>> You can reply to this message to join the discussion.
>>>>>>
>>>>>> Are you sure this is solved? I got hit by this today after trying to
>>>>>> check the report from another Debian user:
>>>>>>
>>>>>> https://bugs.debian.org/1091439
>>>>>> the earlier report was
>>>>>> https://bugs.debian.org/1087900
>>>>>>
>>>>>> Surprisingly I managed to hit this, after:
>>>>>>
>>>>>> Doing a fresh Debian installation with Debian unstable, rebooting
>>>>>> after installation. The running kernel is 6.12.6-1 (but now believe it
>>>>>> might be hit in any sufficient earlier version):
>>>>>>
>>>>>> Notably, in kernel-log I see as well
>>>>>>
>>>>>> [   50.295209] RPC: Registered tcp NFSv4.1 backchannel transport module.
>>>>>> [   52.158301] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
>>>>>> [   52.158333] NFSD: Using legacy client tracking operations.
>>>>>
>>>>> Hi Salvatore,
>>>>>
>>>>> If you no longer provision nfsdcltrack in user space, then you want to
>>>>> set CONFIG_NFSD_LEGACY_CLIENT_TRACKING to 'N' in your kernel config.
>>>>
>>>> Right, while this might not be possible right now in the distribution,
>>>> to confirm, setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING would resolve
>>>> the problem. In the distribution I think we would not yet be able to
>>>> do a hard cut for planned next stable release.
>>>>
>>>> Remember, that in Debian we only with the current stable release got
>>>> again somehow on "track" with nfs-utils code.
>>>>
>>>>> Otherwise, Scott Mayhew is the area expert (cc'd).
>>>>
>>>> Thanks!
>>>>
>>>> I will try to get more narrow down to the versions to see where the
>>>> problem might be introduced, but if you already have a clue, and know
>>>> what we might try (e.g. commit revert on top, or patch) I'm happy to
>>>> test this as well (since now reliably able to trigger it).
>>>
>>> Okay so this was maybe obvious for you already but bisecting leads to
>>> the first bad commit beeing:
>>>
>>> 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
>>>
>>> The Problem is not present in v6.7 and it is triggerable with
>>> 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
>>>
>>> Most importantly as the switch to defaulting to y was only in later
>>> versions, explicitly setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING=y.
>>
>> Hi Salvatore -
>>
>> I see that Scott recently sent a fix for a similar crash to linux-nfs@ :
>>
>> https://lore.kernel.org/linux-nfs/032ff3ad487ce63656f95c6cdf3db8543fb0d061.camel@kernel.org/T/#t
> 
> Oh right, this described escactly the problem.
> 
> Do you think that can be made reaching 6.13 as well (and then
> cherry-picked to the affected stable series 6.12.y) or do we have to
> wait for landing in 6.14 first?

In nfsd-next, this fix is tagged:

Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")

So it will be backported to all appropriate earlier kernels as soon as
it goes into Linus's master via the v6.14 merge window (in a couple of
weeks).


-- 
Chuck Lever

