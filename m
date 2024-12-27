Return-Path: <linux-nfs+bounces-8798-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E5E9FCF54
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 01:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC3018831D0
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 00:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E47184F;
	Fri, 27 Dec 2024 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hhd8lGA5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ba1z66T8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B59D19A
	for <linux-nfs@vger.kernel.org>; Fri, 27 Dec 2024 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735260777; cv=fail; b=h3GCwqrA7cQ2js4K3ZW8Ak2U+41wS6V08udiOAp8fFi2rqzl+1KFa1exYZ5eyLLJGmnql3tSc204NnXiUUvrS4MGDi9vxTfo0UzqbJknNvMZOn+R3veDRe/svsmh91viTmsb/WqTAO6RdOhdyPvLVNm2uBZR70M5SlWfQeFIJFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735260777; c=relaxed/simple;
	bh=trAdULCHUnyPxR4Mt8dhlAR5q6vV9YE2l5VrQhoS3Bw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yd/8wi3Vd+uSS8Ll4F4gB1ZuL4Div0OMjCQRHWqFUMmnb5f1nbSCsnYOdFKqp9at0d/dSeSHETaMIQDUnJp+UM2CPzO24A5PralKNlaVXvIp7jEdofzC/+cPDdfoT5Y/Trg9Gj7kVuJupTKS/dydODxQLasRWpG5PSEW1uJFvh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hhd8lGA5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ba1z66T8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQJkgDB022737;
	Fri, 27 Dec 2024 00:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Gdgsyu5SvVzOHiVgCclooiwmkb5XdstU8lRUJ1VZ4Ys=; b=
	Hhd8lGA5M2W4VDs07N+gm9caZoBfmiqq47EZszd6pCUP4u70jD2ALGLfK4F+6yl1
	V9mc9PW7ynxRQrx9IuxBbb0squh+/PIwGfuiBkjDfqWypYd845Yv749yO/LKJiYr
	rwOf85iNHufLhm4RpvROMKOLX2LWzpIe1/QBezkMkLMka4AcqITwOw2AHgMmY9Xd
	k7acG2u9vsTdYNfCBUYZoIApx+XSWET9xMvCAIGSZSK8Bv7vQVcymAp6u08c4QN1
	bOXRI5CfPGHNQG7YKqkpeEVkb39TfGogYloguV1cjKXT7EkJhLpCKBxWe7KYL3GF
	5UYm0hpBJre/ihHKUDu7DA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7rpspn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 00:52:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQJeGZH029431;
	Fri, 27 Dec 2024 00:52:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4fyerv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 00:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFkExTixsgUNbwi3kJ54SsHCN5hiz/awhhSXT6nujfpNYLKiT7HHVad7GLBOCz7oW9JYmxG6f0+SeGbEiZZ5qZtRI/CCUHlt/14ZsvDtmg1PWUclAMQcOU6IyYTjMtrYCNtviNbQHiAepJASJMJWGC8dH93Ix0YI15CBw+OVtdvAbCRMY6HGTnwREP4UC7eKJtZ1zSIRS6NuowVWEGTKFRcUhsSNPzi9EPr8IpSe8Wb6lGjhKRWFDMiMqLkYZkHGZX1faS/EQuFBF4YoQ91h6EwqyykAdv/rLq4nN2AfgBrdPw71tPDFtma3OIAS2KliZqEjQQ808kFIxuLZPQMjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdgsyu5SvVzOHiVgCclooiwmkb5XdstU8lRUJ1VZ4Ys=;
 b=hbv7TO/nxpMO05sXwh8A72lv1c1Ww9np6aSq2K0EoFFB8sRJaLMv6FbceXcG16bIjvHfZRmthHCct3W+14TDgbDdER5IwaQUu853JBhVCHi4Qv+nvuTdwC1G+cl0BYN6tDror8CzouikziOnA9j9fAlBE004xty4jiGoO5ZOdOl/EG5uvmeTMX9Ve7Y0xrQNvv5lsOwOAyVcZJHMUq4o5YY6rVdVTHZUmJWgRkO8sZuA0IG7BH0HmAnkumS6VqKsqjuCYxk6Us1SjBYa+14rFW8PahcRk4UmM5aDpUymD32Q2D02ouE8hO5Nr0thN5HTjCvDnIUL/Yfc2hCCJQOVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdgsyu5SvVzOHiVgCclooiwmkb5XdstU8lRUJ1VZ4Ys=;
 b=Ba1z66T8/y6qbFjGpsw3GCLNJHpZnvZCX49dQmPcdYiPMBXcc/qNlT7bkw3E7XurzSNxPF2qqorBrc3oqby+sstkfdae78fZuHcCQQDu3dDESqITaZkCI7zSsU+v8D0CnBEScbSl9PNXDn+C+RUPIG/9dfpX20dy9aXAU8nmtBM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7929.namprd10.prod.outlook.com (2603:10b6:610:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Fri, 27 Dec
 2024 00:52:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 00:52:26 +0000
Message-ID: <536c66ee-d26b-4251-a299-685723f572f0@oracle.com>
Date: Thu, 26 Dec 2024 19:52:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] SUNRPC: Document validity guarantees of the
 pointer returned by reserve_space
To: NeilBrown <neilb@suse.de>, cel@kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, Rick Macklem <rick.macklem@gmail.com>,
        j.david.lists@gmail.com
References: <20241226162853.8940-1-cel@kernel.org>
 <20241226162853.8940-7-cel@kernel.org>
 <173525258802.11072.15894870883388643692@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173525258802.11072.15894870883388643692@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0440.namprd03.prod.outlook.com
 (2603:10b6:610:10e::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f72ee14-ff8d-4503-e23a-08dd2610bb83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitNaDM5MUdEOWU2T1BjcEJsN05wMWdnZE5jNW1tVlZZT2pPL1A4MWlqcGgw?=
 =?utf-8?B?UEU0eEtKQytQRWFEWmVYQTZaYUdUUkNBR1hlQWNJNkpMQ0I3RElqSXdyeFJZ?=
 =?utf-8?B?ZjByaWVXeXBrdFEzSHRZVFVNTFRmQzloMXN3WWZ4M0VydS9TSnJLeHJrUWVB?=
 =?utf-8?B?b241ZUJwWm80Y1ozVVEyd1NvcGUyamZWV0xSMFhCdmhCVUVaZ2JUYlIvRHZK?=
 =?utf-8?B?dzNFaFZhbm52cXJ5QzhiRnBmVm1Gdkp0cVdvTGVZU0pMK3g2UHh6ZUhma1kx?=
 =?utf-8?B?QlZSQ2FSemRwVFZFQWFpOG1XbHcyeVUyeDBrQU0wUnpJVVJDdXdzRzdYRVRX?=
 =?utf-8?B?YjEzS1ZRRlhFZUx1Ti9ubjdBdllKTHhnSStwbG5KQ2V0MXFrSG1MWDNLZ0sz?=
 =?utf-8?B?L2NuY2lHZ0ZwS1c5V0ovWkRjc01sOTBHR2YxVEZZVzY3Znk5ZHFPRWY2YlNq?=
 =?utf-8?B?YjBNQTBKSCtwUHFINEtYSEd0enBrVFR4VktFS2dnbGMrYUN4TXZpdC9nV056?=
 =?utf-8?B?K0pwby9wdTBldG9ZbU54U2dEQVBCT3p1YzdNaEk3a1k5VVJzaFlvVnBHQm54?=
 =?utf-8?B?U1RBcU90L2M3YW1KK2xwM1hLRmZQWExmY1pZdHduVU9ORGhVZHp5WnNGMUtl?=
 =?utf-8?B?S1BZbUhoa2phS0YxRHk3b0l5WWlSQ09qZ0JuVkN4UTFRVnVQWENvRTFaWXVh?=
 =?utf-8?B?UXlKdlY3VERQT0ZEWXZDY3c5VWJqZnN4c1UzRmVUd2ZvSVFvOTA3NTcvVWpN?=
 =?utf-8?B?ejRXZzlidUx4VmpVU05sTWJ4RThVSG45Zit1cjdPUVNObmFlT1M1TlZQSU8x?=
 =?utf-8?B?N0xhTlphWUJVTGFqTTJHVU5rdmtQSDhLYkNEZWpCRHY4TlBqSXZlR0FVdnRH?=
 =?utf-8?B?VXdBVFl1S0Qxc1NWWmpoSDU4WFR4b3k0Y1JEbzB1SXBSWXEyUDRiUm9GRnZl?=
 =?utf-8?B?emluaWlSUjNvZnZoTlh1TElXdjdhK1FCNmN5OW1sUXV5dmNnVVNwUDhmOUtD?=
 =?utf-8?B?R081U1FiZS9JSjNEa294ZnRSVVhTUGdWQzl4ZWJJd2NCRTc5UzEweWwrZXRD?=
 =?utf-8?B?bWNNZGtJdlpRNnIvWjhMODVDbXJOSEdQYzRRNEg2bUg0a2QwUndrdW5yNHpW?=
 =?utf-8?B?V0pISW1vVjZyVmdYeGh3V3dYNFVRVEVGQVlrcE1xUXlxaWlGUkVtK1RuM0pr?=
 =?utf-8?B?WnlxKzFxL2pXNzdsZHNYWGZWQlQwNXpLL2dwVTAvdm1OK0Fkakw3T3BSRHVV?=
 =?utf-8?B?THFlNFlYb21aNUczYkFYUGlka1dLWDZCTjdTdVRJT1BpUjBzcVU4Znp3WEd5?=
 =?utf-8?B?NCtsZTBXVEo3UlVpdElEcDlRQzFxZnlTeTJkQUFpVG9LU1E1dlIyVFlna3M3?=
 =?utf-8?B?N3o2LzBLMEdEOHRaTmFvUnRoL1k3T1lqVnZYTGgwOFBXekcvM2VDemEvMDV4?=
 =?utf-8?B?TTBiQklRYkc5cHBMQjBiSkxXc3FtRFJEaDhCOVZjRWwwdHl4bG83RVI0VkFr?=
 =?utf-8?B?a0Z0M1JuWlJLNXloZXBzOVBwL2gzbm1qR2NWeVdWRDJ6TjlwaHBYV3hVSlhD?=
 =?utf-8?B?TGtGRVYwL1dzTjA0VVJMRTRKcmJxUGhYaG9ydURpYVcwUzFwRVNNZlVSc1Uv?=
 =?utf-8?B?c2pNa2hnZ3FBa0krR0ZKTEg2V1Z1Z1BxbHUwZk9PRFdaOUJDSTdTRlhIRjk3?=
 =?utf-8?B?SDJxc2FIZ2kvN09EMkFpK2hkWVNOck9qbEZ3OG4zSnpTc2RaSlVpaUFwMzgy?=
 =?utf-8?B?T3p5cmUra25hTjdYNVBkVTFCV25DTXcvaThqUWJYMEcwdHRUS2EyRWpycjBF?=
 =?utf-8?B?K0JKUU4vUkdvaGFhMU1UdDFGOWdmWTlZWmI5THRManJlTzI2cWhEYXdBL0oy?=
 =?utf-8?Q?1GXDepP1Es7X0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWxRVEFpaTdSNmNnSkIyRi81OTBRMGVNaGwvQVJkN2dNY3hydDFPSG83QU5P?=
 =?utf-8?B?eTJ4OTVwVWFqblRtSGlhVUtERmwwWEJ3MjNvdWk0MDczNVowcURpL1JIT1dv?=
 =?utf-8?B?cUVTZ0YvZ0diSlRlbkUybDk5MWdZaHhjTUxvUTN5Nko5b2xIOUpVYURFNWpZ?=
 =?utf-8?B?Qnh1WEhDdkZ0Z2ZGNDVXVzlUa2xQWkF2cjdrdWxLNlo3YXZUQmdOTWt3RzRU?=
 =?utf-8?B?ZHFudUJlSzBqaGJkcCszN1J0QWo5a2E5bFpGKzJpRXlSV3FORHJaaWZSTTQ0?=
 =?utf-8?B?TG5VVGh4bU9uQVlvNktwcFJqZ3Z2NnVndnBtTmhSN3d6azhzc0VQU2locXpJ?=
 =?utf-8?B?YjVqS2tGZThHdlIrRVBhRjdzZXJ5MlJVT2xLU3NVVU5sQ0Y5VHVHZGQ1NXlx?=
 =?utf-8?B?Q0UrR2taNDZuOW5sWG1XbmNtTVJEc1hEWXA0TGs2TFpoN0J0NlZCM25zMmI3?=
 =?utf-8?B?QVYxWjQzYWNDTmdSRmJLcmxuZXdUN0pSMUNjYmttWlN2RGgwNEs1RDI3a2hk?=
 =?utf-8?B?UlREYndZWThOZzFBUkFRTERoa3Z2M0l5Ni9OdVNnclRlM0pCclpBMkE4d2hi?=
 =?utf-8?B?RytqejRVdXdyZEk2L2hVaCtEN0VVcWY3TlFCMFFoeHZ0SVo5Z1ZtM3ByQWxW?=
 =?utf-8?B?bnZzd05BNSs3VWx1RWhUUlJLektXVnVCMjhmd2p2Zit1L3kyM1k5Y0l5U1FE?=
 =?utf-8?B?cURjZWdwR3A4aGFrMFFIbXdFTHBkcDA1dmhYb1JoeVpqeHJoQlZLdVVJYi9P?=
 =?utf-8?B?N3BoZlpyc0g3ZlowU091RFViMHgrZFRpVm5uYm05ay95OEh2SnhZbWRVUUdS?=
 =?utf-8?B?WFpSSXdpZ2EzVXdOaTM4UitKMkNHdkw2NjF0ZnlUV3NOVW1MMmtYY2xIMGl6?=
 =?utf-8?B?OXl4NGlLOUY0NjNRMXhsaUxwd2R4RHhOOU1rZy9hdytXWjh6Y21uaUh1MzRk?=
 =?utf-8?B?Rjd6MU8rdFgxVTBPTStEYVVDUlcxS0NTK0dQL3BYR1pQRnFEcFZ5aWhUUmNt?=
 =?utf-8?B?T2U0M3N6VUNnc2o5YkU5V1VydklPS2dwM3A0blZBbVMxMmFGNllOVVlNRGw2?=
 =?utf-8?B?TlVWZkZHdGtBczVzcWc1dEduMU9NK0dON29raHowcjlMUUF2azBwR09Dc2VX?=
 =?utf-8?B?ODV1eERNNWpqT1NBRnFPZEpwZmU0bmlabzNRaXNVb1g3N0dBQkNYUEUxNUIr?=
 =?utf-8?B?ekNFWU9pdUJBV1JLWnNSUHhvb21XK2JOWTh5N3BvRlBXZnZ4UThyRkJJTE05?=
 =?utf-8?B?ckFocG1rWkJVUTR4Z3piYzRRVVJXV2lUSStqUGtvZUVFTEN4eEJsRG5Wb25I?=
 =?utf-8?B?bmhOK1N0cU9PWnpCTmhvN2ZQcDIxQjdENmhWN1RhUU9ZNkhtV3JHZHNOMTRS?=
 =?utf-8?B?TVN3dzdsRTQ3ZlBKYWNTb1BtNkwvSHJ4bjIxQ2hkYm5ld2hGbWc2QkFsM2dr?=
 =?utf-8?B?enRGd0RLS01PRExqdER6Ti9iUW9PK3BzK0NLS1ZPZ3FSbzhHTkhibGI2U2lp?=
 =?utf-8?B?bUh6VWFTdnBsMStndmJ5elhwbjhkaE5WMk5wclV4QktXTWkwcmlQREZBUGhY?=
 =?utf-8?B?eXEyTzBpeGUwQjVsM29Bck1TblhrNkxoVFFlRDJhakExTmdORXF2UklKVy9z?=
 =?utf-8?B?VTJMMWJ6Z3M0RmR0RUdqcDYwS3ErY2l0ZlpYN0dBUmxuM0I3L0U5ZG5FWUNZ?=
 =?utf-8?B?NmlRckloTS9DVDZSOUFyamxDdXJUa3FYai9rdTBrUGxoOXlUcVBNSFRpSm1U?=
 =?utf-8?B?MXpMRHUwMTArbWJKTGRMUEd1SFZoMmpuZC9CNXhKYWhXelduU2gzMGVsMGxx?=
 =?utf-8?B?VFlucGpBR2Jlb2F5dnpaRTcxR0VmTHkybVNYdTdsZ0h5SmRsY2xXY2Z6NlUr?=
 =?utf-8?B?UHdtb0h5UWRsYzFuTTBnMTFBS0RSUDJ3TlQ0MGJsL25OdEcvTkJPYWVDdDlX?=
 =?utf-8?B?Q2tnMVI2SXhtVWtKSk9hck5rMlQ4YTNsSkJJb2dBa1N1SFlhem00NUxDR3Fj?=
 =?utf-8?B?bHhHQmtDWDNKeGwwZ2tLWkZta1RyTVI4QXE1bXBncjMwUTNNWm11S3dYSE5h?=
 =?utf-8?B?UDBZb0VHeWRpVERCMVRQYUdkalhiNHZEajJGUWh3ZS8xaHlOZThOS2lXRk1J?=
 =?utf-8?Q?td/3ewxZ0lBP6J2OiIY2uZmK8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yQBa3QvRkbtbH6nBMcUCfKrZaudJOMB8lJzuHnkMLctJ3GPpZco/d6eLtqiFAsxWXXky3nVrmTIf5n1vRmPH3ZTUhPAWMofSK3vwMQ+Aaeq4FNylidiUKnOJ54+TRi74XPiKCZnr2K9wbAApsihnaO9kgI8pir9WQYmo9TvfxRr1JDqlHDFfkOcSbTAcrZPd+dGGaWphYYPL3MqX58Hzcj9sn7B7W0MWeFuw12zIEzu9MoIB9pwbjSNONB/aNaWHQg4XEm4FXMIL+bIWJi5jYYu344g4ukW0UI3SMprGWrBGy4z2ka4N8ke1mpJMZvJVJoeFojNjkhuV3+63Br+AJeD5BYuUHMusWLKZr4bzBzrbpV/1tdhZXrBSOtWyYPK1OoGraQYagw83W5wxtizfV3LwqjVPh56MJq8T1S0DXsF6yc0vy5bDqsEWPz4eT/4unew2llsc6aGS5MTGTjK1A8XU8/+7vI8AnsrT+RyeTYABuV+siQGVFS7U0Gm6+XZJGEyK8WRIahfSS5po1mjWVzBon91ZdC4DqXG3HdBES8t+g5EAGxx+X8zlTrfZfzmwfrRL61s6fjGcfZb4/A29HBR2sRNGguzGcL5MiGTc8zk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f72ee14-ff8d-4503-e23a-08dd2610bb83
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 00:52:26.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBnJ4m9w8NYHZa0jgosPgVgOO8ngug/luuJ0byxi9waHiCWaTkdPRQJalJdxupI5urg/7w7EszMNuUmeOuKubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-26_11,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412270005
X-Proofpoint-GUID: -WH3kGlXjbkNG24Inb6zZZGWySlXsq9h
X-Proofpoint-ORIG-GUID: -WH3kGlXjbkNG24Inb6zZZGWySlXsq9h

On 12/26/24 5:36 PM, NeilBrown wrote:
> On Fri, 27 Dec 2024, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> A subtlety of this API is that if the @nbytes region traverses a
>> page boundary, the next __xdr_commit_encode will shift the data item
>> in the XDR encode buffer. This makes the returned pointer point to
>> something else, leading to unexpected behavior.
>>
>> There are a few cases where the caller saves the returned pointer
>> and then later uses it to insert a computed value into an earlier
>> part of the stream. This can be safe only if either:
>>
>>   - the data item is guaranteed to be in the XDR buffer's head, and
>>     thus is not ever going to be near a page boundary, or
>>   - the data item is no larger than 4 octets, since XDR alignment
>>     rules require all data items to start on 4-octet boundaries
>>
>> But that safety is only an artifact of the current implementation.
>> It would be less brittle if these "safe" uses were eventually
>> replaced.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   net/sunrpc/xdr.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index 62e07c330a66..f198bb043e2f 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -1097,6 +1097,9 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
>>    * Checks that we have enough buffer space to encode 'nbytes' more
>>    * bytes of data. If so, update the total xdr_buf length, and
>>    * adjust the length of the current kvec.
>> + *
>> + * The returned pointer is valid only until the next call to
>> + * xdr_reserve_space() or xdr_commit_encode() on this stream.
> 
> There are still several places where the return value of
> xdr_reserver_space is stored for longer than advised here.
> 
> - there are several in nfs/callback_xdr.c
>    e.g. encode_compound_hdr
> - there is attrlen_p in nfsd4_encode_fattr4
> - maxcount_p in nfsd4_encode_readlink
> - flavors_p in nfsd4_do_encode_secinfo
> - rqstp->rq_accept_statp which is initialied in svcxdr_set_accept_stat
>    and updated in many places.
> - segcount in rpcrdma_encode_write_list
> - segcount in rpcrdma_encode_reply_chunk
> 
> These are all safe because of the "4 octets" rule.  Should we include
> that in the documenting comment, or would you rather all of these
> be change to use an offset rather than a pointer?

That's getting to be a tall list. I will add another sentence to
xdr_reserve_space's kdoc comment for now, something like:

"The current implementation guarantees that space reserved for a
four-byte data item remains valid until the stream is destroyed."

IMO encode_readlink and encode_secinfo need to be updated sooner
rather than later.


-- 
Chuck Lever

