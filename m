Return-Path: <linux-nfs+bounces-9536-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC696A1A5C4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A808A3AA3CB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ADB22EE4;
	Thu, 23 Jan 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fwgqJgyd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vh5HS5Jy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0C1CA8D
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642657; cv=fail; b=hpGWP5agFzFOpaOC9HM/b2q3XiW2Y/A/JIGSjtzwRbFx6lc2yrvz2yfP3AowglnOc3O/3cFDZbU7B+/bJjL8K/SyDYIICf9A8gFOIpOAqFYzcEaXglyfWVHUpKrAv7p+6JqbltwYhd00aB9h0NKQzFgFlAp/OuWECcFdJdMQSb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642657; c=relaxed/simple;
	bh=GaAol5CvxDIn/NCeGgMcDWhu3/BtY9gV+uuus2f3YE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IwS/IH/ASr58KcOYIpMjRRHPgsmKrYUnKqsGKP3hmTeYLHVw89jCfwHfLh2lieGEqKVIszf9pZ04ir89Hnu+4qryMER71XOixfFX0EbLZ2oPYX9WdG7ZWZ/ZfGbSuQfz3gpbZUf/dEYOhc3bOKOiFkpTQBb1rqz1+nQeAFshdiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fwgqJgyd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vh5HS5Jy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaOLW006796;
	Thu, 23 Jan 2025 14:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=l8a2GpQkIGqFSlTBXueQMAdeSQg99XsM2/OeCT+YRjI=; b=
	fwgqJgyd3uyhDjJZiCOtRPPmZkvA8EXsbJwwJMCfcX9Uj3gbkNro/3Qm8s1Yaf82
	McgGvTeOrh8db0l1dOisZEcmh/qUQVp+0ixd1Ibd2OtxMBNRsJBP1t0mOneyYt4P
	RoZT74fdSzWUhffvCG/YEgJyRJ0FzIM5HyLNK66Dnx8WoAAvKMLQa7CbJrrt0Ss+
	XLED8sjW++MWAJVf5VnjSQzG4X7IhsC3oWyGLJO3iTrgsQ2Ynwdmfp4fq1wV8QSl
	bBCQtwegJIAcjH/7b3wf19IYAvIAni2A0/Haj16WO016hYjnQTjUviT/D1sC/ZF+
	eCawRGeRDo2XoKkDtK/ugw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh2q0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:30:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NClfN1036432;
	Thu, 23 Jan 2025 14:30:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917s7058-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7km2V+BWEPVDDninIS2XJ1khY0Jme6US4LuoO7niQF4SViS2+RkUKt6ApDpV4nnY+8cu7m25acJRye3Gi7Ozdxh3n0JppS2Pax7TFmsCh/XBCMVDOsQ0XFIsOEfMplqMvzUN0e30zqMWkgFqM6F1GEwVpnOrYDXm1754JFwTr60iMtEBST5mS0yKFntXHQnVgTKbfV0cZq2IgHjR09MgQfETOJkTdwV/mOWmndkFFe9eyECabRUt2NXmDt42HqoOsskDfEWn/YdEuT0JadCw0k1YEr9HpPJvvS754V0Aj8mSWRZZFRaJ4BgfFQrInbI4nB8SoV2KSXErdPCvKmhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8a2GpQkIGqFSlTBXueQMAdeSQg99XsM2/OeCT+YRjI=;
 b=tg01588HTE9MA3UxoYgqkPqEgX6wU0wLRFHOvPgN8j0giT/tKrFRTvvS9ZS5qfgFFBzdCuVdWl6w9GvhRw3c+Q0yLIL2vlcD+Pr2Qa/hQbWT6UMH8F0UgZvYrd/xifSxxOG34Drz9uPAlrxuBKWXh28uckapQIGyHYEVOBCHWbwGu8+1okgqiPQ84BPRlnieaRieG81VH5ByDVGRQ1Xp+YIIaAEFh9e99gHZhji6W+cMi6/FYuEsbueAvGEJc0ygVYhIB4iwX2vw+ezzHAycOWdHTN6yvNbbDyKHmR4ZoMmLTS9eIUi0wYuSBUEiaU03lLvaTflcoqmt5gx9QmLZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8a2GpQkIGqFSlTBXueQMAdeSQg99XsM2/OeCT+YRjI=;
 b=vh5HS5JyPKDij118K3G5GFA/sa/kZy9eIG1Syp3S+FvgZevn+ShDpuKJS4X+T8kIRlmZCz2Aza7KnQQKxSDTJX7XC2A3EPzmVlSAROF+PFALWeaUArM0lguMCB3wkidAB9MADuFbLfZiik1iLFhSR/QOmBS7oYUrK9430rib3tU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 14:30:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 14:30:40 +0000
Message-ID: <c9adeaa6-0d6d-4b20-ad70-61d7a4cf344b@oracle.com>
Date: Thu, 23 Jan 2025 09:30:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
 nfsd_file_shrinker to be per-net
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <> <e24e9a9d-1416-460b-ad22-b15f9e9e5e6d@oracle.com>
 <173758380546.22054.5803528057434555102@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173758380546.22054.5803528057434555102@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:610:54::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f13556a-75fa-4209-90bf-08dd3bba829f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG9oRHRZUitwcFU1bUE2VDdhQTlwTDZVU2xmMDhxbE1vTnJSeVFqZDdueE1n?=
 =?utf-8?B?ejlURmRmMURxQlc4cVNlUGhYQ2twd0JlNkFsQllWQVNtdDRxRG9WTFkwc2Rx?=
 =?utf-8?B?NE9qOXFNN0lTL0gxM21mOWR3cTdHWExESFcvd2dZRS9FN1hKVkEva1NPYWw1?=
 =?utf-8?B?RGdCS3F4UFhtaWMwSi84NDIwa1hoYkptSVMyWlZ2WHpSZEVWdXhYeWVKTENp?=
 =?utf-8?B?NUFjZGI0UytyVnRlS2t3QnZnOGJGdk9MaFNldGtzTTRnbCtDVzdqaDN2c0dM?=
 =?utf-8?B?ejljb2lIUjNVcldMK0JnQjhWMDcyNEFIR0RIQU56SFZQZ0d4VW5EcUljYlY3?=
 =?utf-8?B?cDZCanhNTE9WUDdxdkd4QSsvdmJxWVM4Q0dqcDVDK2hEcURiaGxHaWMrYmds?=
 =?utf-8?B?ZkVyQ2NxMUVKQ3lWTWlQdGtlTzZLS0JwSXUrSUQwWmZSN3VFdStIWkhacUNT?=
 =?utf-8?B?TGtHUU5CS2owL0dzSitnaWZqWU80Rm0zWjFuMVdFR2VkYU1QU0cySUl1ajRL?=
 =?utf-8?B?T2VjU0JYcHh2V3c3UnRrRVRadGRnajRuMS9jVkVpbWltUFNGT2QwbUtlaWlB?=
 =?utf-8?B?Qk1tTStCakJYczlkOVVEd2NJRXptZ0ZDQ0wwaTVWMFB5Z1ZzTUhtZVZLS05P?=
 =?utf-8?B?MkVlL1BvYkkzMTh5ZTMzVk9jdWErM0VjY2xTTWR4enpBRWJYR2RmU1QxSk1R?=
 =?utf-8?B?TEp3eitEdW0rTVZoVXVFTGgvNERMVnM3WWxPK1QyRmJjazV4M2pKS05NMzZT?=
 =?utf-8?B?RGZNeDBLZlV5SmIwNnpxVE9neWVLdFpkbUQwaSs2ZURzWUZrdlUyOUtocUJy?=
 =?utf-8?B?eU1mdWZvWTNoczNDSmFiQkxyb2hvWG1BUThwT1lMdnhJOXlIdko2RVg5VVhH?=
 =?utf-8?B?MzlhM0NKalpUdnNjdUxjbnlJa3liQmtuYnRJWVo3Z29uMG1uVDdKSU9uK3l0?=
 =?utf-8?B?bEFBWC9Wbzc3VzdZbytSbHl2WkpjdXJ6eWxwNU9pdnhoV1BjQTJLSVBMVXls?=
 =?utf-8?B?bTlWUlVoR1Z4S2hEMGRyYVlwaFgycmZMZ2tieWVUUmF5c0hlaWUwM1cxbC82?=
 =?utf-8?B?V3pGU2VZc0pSN2dhYUFoeUtlSGlSRHRSU0s0ZGxTYThtMSs2L3J3OGlHc0R4?=
 =?utf-8?B?VDB1S0Q1WHU4SE50YXNOOHRDb09RNTlUQjgxcHpiQjdnRE9zSUc4QmRGREJH?=
 =?utf-8?B?OXVrZTUzYmJZOWt4a0FCS2NEVW5SQkFzLzRHSmZhT1F5RyswTTNtbXNYQm9y?=
 =?utf-8?B?THAvYVA4aDg4MyszSGdJclExRUpscm1mY1E0ZWwyVHpiendIOWdBTDVwdHVI?=
 =?utf-8?B?RUtELzh5eUlLWHMvQVAzSGIvK3d1SWVXUTNZUVpPUkx1RzMvV3VTTDY0R3Fw?=
 =?utf-8?B?dUE4N2kzZVRnKzB4cmJPMmdNU01DRzNFVnNBVWgxb1Y1eVpnUmlsT2RPTjgr?=
 =?utf-8?B?dkRVMTNlT2tROGtXM0ZsU3AvY1oxTmdtQXI0bHI2dmFpR3B6L0F5am9GUDVO?=
 =?utf-8?B?dmFsdnlUVHFZRm5VQm5sejZ6VzFXcFJNY2VrYjBQZTVvVnZuOTA0cHVIbGhC?=
 =?utf-8?B?SkIzM3BjaHVUNlA5dkN5WEtSYTk4UXU2YXRJdVBnN1pPNHJiRks0alA0RHF5?=
 =?utf-8?B?S25BSTFuZTlER3YybEcxaW5MRTJLYTM4SGsxdFhrMUtnZ1pFNGxyZFZndzBM?=
 =?utf-8?B?WFFFRmkyVEh3R3VzUlFRQnFwRVFja3JaMUxjRW1jUS9vSHl4b1I3Zmx1b2g2?=
 =?utf-8?B?bXp6aW1sSGdBUDYvdU9scDFiemhLaHBNVUpJUFZqQ1Y4RXUwOEFidHNiT1VK?=
 =?utf-8?B?WEJjbUhIWEJUV1JoN3FuRjBEc2l1T1Rvazk2aDRmc1NGd0ZCZHd3UXVaUHhx?=
 =?utf-8?Q?YbpnAROQd1q7g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1Q2aTBwamlUWUpBQnVCdVlweWVSMDM2RXhlYXFhSDR2cWR1cVhsY0NCb2RZ?=
 =?utf-8?B?QUJIaUs3ZWpLUHNGWU4wcjNSUXdmMmpIN1lWbGtOU21EbmhaZm52TkxHN0VL?=
 =?utf-8?B?dEZEbjg1czU1RlpDbFpZWGg3RkNFSzdOdEZCZ2NZb1JDeHprMFNrNDM0YWxw?=
 =?utf-8?B?M1dmcUxMS0tacC9vSFExMzhBdGJNazhqMTNjcEswL2paZGhBamJBUUdJRXgx?=
 =?utf-8?B?alJtaTJMUEp3N3k0NWluS1FjaWhyQTV2cHVCNFprUC9laVdYbnlCeDc5Y2Y3?=
 =?utf-8?B?UUx1T1JhVWVCVVkzQjRyRm5kTGdKWXBuWklJelpNMHk0VnZvc3pXZmxGeFRz?=
 =?utf-8?B?T2tYYUVpOCtFTElEbWY3OU5tUnBLVzlCQkhLMldYRVdpYmhHSWVmMUZQWFR0?=
 =?utf-8?B?NlRFUFBsZkN0ZDJxc2pLbFpoSTVtaER1SmZYanJaNXNzR0E3bW43aVlEVEJa?=
 =?utf-8?B?dW1GcGFOQTNxTUVnclNPeDc0aXErOXRZRDJnZlpEa2EwWndsZG1FdFdOZWNu?=
 =?utf-8?B?NGJMUS9ESUVTMmhneWNxUXlyRGRtU3pzTVErVUc0MGkvNjVBRzExOGw3cFJC?=
 =?utf-8?B?OGQvZVNINUNQams0UUxuaDFEV2d3ZGJmWXBCWDMvNVVVZmZyTXBVOVpvT1pD?=
 =?utf-8?B?RnhqRlhJWTNPT1VRLy9GWURNU0NGUy9wVCtOYlVUQ0h0cndmMXlWS1FXOTR3?=
 =?utf-8?B?N3MzWG9CMmJHdGhibldtdHVaODdEOWVLWnp3MTBBR3cyWUxWOGtKdUVjdjRI?=
 =?utf-8?B?RFFRaVVMUGNBWGR0RkFzS3VzZURucFFEa1U4Wkt3clZXZ0lvN1RWdmg2OVVF?=
 =?utf-8?B?eHA0ME1KM3ZPdG8yK2lpUDhXdjcwUkxoRnY5ZVRKT0x1bEFzczVUYUZRZDNY?=
 =?utf-8?B?VEJHMHh2Vzd0SzVvOTNaR3M3cmlUd2dEMG9HSUs4OXpxRExYcDhiU0dTTzBI?=
 =?utf-8?B?K0F2d1NXYklZczM5MXlselZHUzE2NWJMaFdQRlI1Y1EyQkVON0hWQ05TSmZy?=
 =?utf-8?B?bmZseGdpZzVxa1ZpSFlDd1pmbmt2TU9qVGNYbkhxY0V4ZlVJODVLaitYQzNJ?=
 =?utf-8?B?U3k4RjczR0FZbnJYajNhZ09ndDc3ZFdjM2VyU2ZudlQ3dkxYVEZjR043K1pC?=
 =?utf-8?B?bklVSW9SNFZUR09QbiswZjdFTnFMaDg5V3Q5RXFlOHRBclJhK1FrOExheHZw?=
 =?utf-8?B?WlJHblRvd0I1ZTkzWXJ4R2tocElGRUFNek1DSVFVbFlieUJPVU5jSEVBbk81?=
 =?utf-8?B?ZkxoNGdvU0Q4czllUGxaUXdoYk5TT3FNenNwUjZ1eXh5dG9pN3Bqcit3M2ZO?=
 =?utf-8?B?SE94UXB4N2ZVVldlSzZtSWRkWkdLeXJORjRFbVAzdjUzR2VDVjF5ci83cUtY?=
 =?utf-8?B?aEhpZmM1bHB1dTRxSW1DaWF2eFBOOElRUFU1elJ0TXRzbi94azlkTk5DOTI5?=
 =?utf-8?B?WHdVZ1VFNnBoUVJRQnZHN2JzL1puSE5Rb3YwaExEb1hyU0RPa0cwUmFJelFR?=
 =?utf-8?B?dVVLMUY4NHdSZ3NJT1haZTZBTE9QRGRaWDlOU2diZXNodDNvaFVTeStJNmNV?=
 =?utf-8?B?SnZtV2VUMnVDYTJiMGpCZ1JVMmdqNkYzbUE4WEkyK01mVjNEUW1Bbmxlc3k2?=
 =?utf-8?B?MFVKUjZYVjhpYTFlWmNCdnR3WCthRUVVOTYzNkpUZkRtSmVUZm9zWWZBOUpR?=
 =?utf-8?B?Z2FuUS9MYVQ0WUtWVE92RlZvWUh5Y2ZuTVd3K3RxY1JCYVo3VzhEenhpRDhS?=
 =?utf-8?B?b3YzOXIySEJrR2kyNmdWL0JTNHFYS1lkU0YrbEVad20zRWE0eDU3TDJ0cVd4?=
 =?utf-8?B?VTlJQmkrQ2R5NXNyOGRJMzhMYTAyZWp5MXpWMlVxMEw0QmJsWG9YWjk2Qkky?=
 =?utf-8?B?WXJsb3pSK2Eyb1IrdWl4VzNNb0xYcHhGNmVGUTNjaXRlN242anBXMzRtNzRn?=
 =?utf-8?B?MHM0T3BVSmtTRzlqMWFwR0htdGFrZkdBYldlMTNuMm1ZcmVkdHZKNWREWmNE?=
 =?utf-8?B?T3JvWXJlY3kwYTQyL2I3dXpnR2RKRUErNVFMa1ljbG1INjFCb291NFdZWGUr?=
 =?utf-8?B?ZGM1cXhRQ09sVGNSckZtdjZLdnRXemorbUUrVWJ6MjExaDR4bzBGZExOOCs0?=
 =?utf-8?B?UUk1VlJFek44cFRwWEhrdXlMWC9MbkZtOTlBWUVNeHphSFFySWdKWlBXV045?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	trp3GcWnFfbR+HBdAGF7ZHeYOeIV1pAM6x7j8ccpdXtvcA/TndSDr4Z4Km+CxaEiqwjxT06XLJb58VyZdZdE4ylp+MyM/z2kf4HmUzeNH7fBFVE80bjxei9XIge3M/3Uz41nubYvr/qz/WIHv3q0LCjqME9qOVlQdr1EEYztWyy3ARwVGhEjDKqJki0uEHQHq7O01lO1UVLFWpOyxhG2GLkmFY3H99QfXpRzzStoQPJu9k3TZi8b0OOXv5X5HtA0u2mtBJUi77nVXo6Vl0K2UxgXnNcZQE5P6bsCSSE2VJtLf7kInXbHz9a09lkl9Yl3Z/jSQ/L1g3nsWngaJLrgNOOJy+uuZeQkHdwCA9lgkUrDrlk5vkcrPqqlft7xF1JAKxZLKFgYh4a2tuFanl/Lup0QMtM0hcAPNwOeuqeBDjYr2vDOa0iu98C+0daHMJrpBTBQbq2yUUpYn3zYPgYwmpWFb6bMXDbPFMW/eOsWQwllh8wNh2ivPvkmB4kL+ZzvvL2oV1CofOsh6uk6KUYAqEuIleKyWF9PRdDAdT7lr1BHYIq3EQos1KPs6J2if6FnclHEaiWUFyM6kP/F+bEnc0DvJDmymkN3ExYh+k4nt1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f13556a-75fa-4209-90bf-08dd3bba829f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 14:30:39.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLf/n/hNhe74BNhOjo4bJ22F0CpS8+/JlrchZwEN7E6oiZDiHOUMcjTGixSQpwIHazAQxzCbA52fGaHluPbtpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501230108
X-Proofpoint-ORIG-GUID: 47oHNTZYoqEvKZTxcHnVIGqNXJ9YzFSp
X-Proofpoint-GUID: 47oHNTZYoqEvKZTxcHnVIGqNXJ9YzFSp

On 1/22/25 5:10 PM, NeilBrown wrote:
> On Thu, 23 Jan 2025, Chuck Lever wrote:
>> On 1/21/25 10:54 PM, NeilBrown wrote:
>>> The final freeing of nfsd files is done by per-net nfsd threads (which
>>> call nfsd_file_net_dispose()) so it makes some sense to make more of the
>>> freeing infrastructure to be per-net - in struct nfsd_fcache_disposal.
>>>
>>> This is a step towards replacing the list_lru with simple lists which
>>> each share the per-net lock in nfsd_fcache_disposal and will require
>>> less list walking.
>>>
>>> As the net is always shutdown before there is any chance that the rest
>>> of the filecache is shut down we can removed the tests on
>>> NFSD_FILE_CACHE_UP.
>>>
>>> For the filecache stats file, which assumes a global lru, we keep a
>>> separate counter which includes all files in all netns lrus.
>>
>> Hey Neil -
>>
>> One of the issues with the current code is that the contention for
>> the LRU lock has been effectively buried. It would be nice to have a
>> way to expose that contention in the new code.
>>
>> Can this patch or this series add some lock class infrastructure to
>> help account for the time spent contending for these dynamically
>> allocated spin locks?
> 
> Unfortunately I don't know anything about accounting for lock contention
> time.
> 
> I know about lock classes for the purpose of lockdep checking but not
> how they relate to contention tracking.
> Could you give me some pointers?

Sticking these locks into a class is all you need to do. When lockstat
is enabled, it automatically accumulates the statistics for all locks
in a class, and treats that as a single lock in /proc/lock_stat.


> Thanks,
> NeilBrown
> 
> 
>>
>>
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>>    fs/nfsd/filecache.c | 125 ++++++++++++++++++++++++--------------------
>>>    1 file changed, 68 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index d8f98e847dc0..4f39f6632b35 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -63,17 +63,19 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
>>>    
>>>    struct nfsd_fcache_disposal {
>>>    	spinlock_t lock;
>>> +	struct list_lru file_lru;
>>>    	struct list_head freeme;
>>> +	struct delayed_work filecache_laundrette;
>>> +	struct shrinker *file_shrinker;
>>>    };
>>>    
>>>    static struct kmem_cache		*nfsd_file_slab;
>>>    static struct kmem_cache		*nfsd_file_mark_slab;
>>> -static struct list_lru			nfsd_file_lru;
>>>    static unsigned long			nfsd_file_flags;
>>>    static struct fsnotify_group		*nfsd_file_fsnotify_group;
>>> -static struct delayed_work		nfsd_filecache_laundrette;
>>>    static struct rhltable			nfsd_file_rhltable
>>>    						____cacheline_aligned_in_smp;
>>> +static atomic_long_t			nfsd_lru_total = ATOMIC_LONG_INIT(0);
>>>    
>>>    static bool
>>>    nfsd_match_cred(const struct cred *c1, const struct cred *c2)
>>> @@ -109,11 +111,18 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
>>>    };
>>>    
>>>    static void
>>> -nfsd_file_schedule_laundrette(void)
>>> +nfsd_file_schedule_laundrette(struct nfsd_fcache_disposal *l)
>>>    {
>>> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
>>> -		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
>>> -				   NFSD_LAUNDRETTE_DELAY);
>>> +	queue_delayed_work(system_unbound_wq, &l->filecache_laundrette,
>>> +			   NFSD_LAUNDRETTE_DELAY);
>>> +}
>>> +
>>> +static void
>>> +nfsd_file_schedule_laundrette_net(struct net *net)
>>> +{
>>> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>> +
>>> +	nfsd_file_schedule_laundrette(nn->fcache_disposal);
>>>    }
>>>    
>>>    static void
>>> @@ -318,11 +327,14 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>>>    		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>>>    }
>>>    
>>> -
>>>    static bool nfsd_file_lru_add(struct nfsd_file *nf)
>>>    {
>>> +	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
>>> +	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
>>> +
>>>    	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>> -	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
>>> +	if (list_lru_add_obj(&l->file_lru, &nf->nf_lru)) {
>>> +		atomic_long_inc(&nfsd_lru_total);
>>>    		trace_nfsd_file_lru_add(nf);
>>>    		return true;
>>>    	}
>>> @@ -331,7 +343,11 @@ static bool nfsd_file_lru_add(struct nfsd_file *nf)
>>>    
>>>    static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>>>    {
>>> -	if (list_lru_del_obj(&nfsd_file_lru, &nf->nf_lru)) {
>>> +	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
>>> +	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
>>> +
>>> +	if (list_lru_del_obj(&l->file_lru, &nf->nf_lru)) {
>>> +		atomic_long_dec(&nfsd_lru_total);
>>>    		trace_nfsd_file_lru_del(nf);
>>>    		return true;
>>>    	}
>>> @@ -373,7 +389,7 @@ nfsd_file_put(struct nfsd_file *nf)
>>>    		if (nfsd_file_lru_add(nf)) {
>>>    			/* If it's still hashed, we're done */
>>>    			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> -				nfsd_file_schedule_laundrette();
>>> +				nfsd_file_schedule_laundrette_net(nf->nf_net);
>>>    				return;
>>>    			}
>>>    
>>> @@ -539,18 +555,18 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>>>    }
>>>    
>>>    static void
>>> -nfsd_file_gc(void)
>>> +nfsd_file_gc(struct nfsd_fcache_disposal *l)
>>>    {
>>> -	unsigned long remaining = list_lru_count(&nfsd_file_lru);
>>> +	unsigned long remaining = list_lru_count(&l->file_lru);
>>>    	LIST_HEAD(dispose);
>>>    	unsigned long ret;
>>>    
>>>    	while (remaining > 0) {
>>>    		unsigned long num_to_scan = min(remaining, NFSD_FILE_GC_BATCH);
>>>    
>>> -		ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>>> +		ret = list_lru_walk(&l->file_lru, nfsd_file_lru_cb,
>>>    				    &dispose, num_to_scan);
>>> -		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>>> +		trace_nfsd_file_gc_removed(ret, list_lru_count(&l->file_lru));
>>>    		nfsd_file_dispose_list_delayed(&dispose);
>>>    		remaining -= num_to_scan;
>>>    	}
>>> @@ -559,32 +575,36 @@ nfsd_file_gc(void)
>>>    static void
>>>    nfsd_file_gc_worker(struct work_struct *work)
>>>    {
>>> -	nfsd_file_gc();
>>> -	if (list_lru_count(&nfsd_file_lru))
>>> -		nfsd_file_schedule_laundrette();
>>> +	struct nfsd_fcache_disposal *l = container_of(
>>> +		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
>>> +	nfsd_file_gc(l);
>>> +	if (list_lru_count(&l->file_lru))
>>> +		nfsd_file_schedule_laundrette(l);
>>>    }
>>>    
>>>    static unsigned long
>>>    nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
>>>    {
>>> -	return list_lru_count(&nfsd_file_lru);
>>> +	struct nfsd_fcache_disposal *l = s->private_data;
>>> +
>>> +	return list_lru_count(&l->file_lru);
>>>    }
>>>    
>>>    static unsigned long
>>>    nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
>>>    {
>>> +	struct nfsd_fcache_disposal *l = s->private_data;
>>> +
>>>    	LIST_HEAD(dispose);
>>>    	unsigned long ret;
>>>    
>>> -	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
>>> +	ret = list_lru_shrink_walk(&l->file_lru, sc,
>>>    				   nfsd_file_lru_cb, &dispose);
>>> -	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
>>> +	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&l->file_lru));
>>>    	nfsd_file_dispose_list_delayed(&dispose);
>>>    	return ret;
>>>    }
>>>    
>>> -static struct shrinker *nfsd_file_shrinker;
>>> -
>>>    /**
>>>     * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
>>>     * @nf: nfsd_file to attempt to queue
>>> @@ -764,29 +784,10 @@ nfsd_file_cache_init(void)
>>>    		goto out_err;
>>>    	}
>>>    
>>> -	ret = list_lru_init(&nfsd_file_lru);
>>> -	if (ret) {
>>> -		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
>>> -		goto out_err;
>>> -	}
>>> -
>>> -	nfsd_file_shrinker = shrinker_alloc(0, "nfsd-filecache");
>>> -	if (!nfsd_file_shrinker) {
>>> -		ret = -ENOMEM;
>>> -		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
>>> -		goto out_lru;
>>> -	}
>>> -
>>> -	nfsd_file_shrinker->count_objects = nfsd_file_lru_count;
>>> -	nfsd_file_shrinker->scan_objects = nfsd_file_lru_scan;
>>> -	nfsd_file_shrinker->seeks = 1;
>>> -
>>> -	shrinker_register(nfsd_file_shrinker);
>>> -
>>>    	ret = lease_register_notifier(&nfsd_file_lease_notifier);
>>>    	if (ret) {
>>>    		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
>>> -		goto out_shrinker;
>>> +		goto out_err;
>>>    	}
>>>    
>>>    	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
>>> @@ -799,17 +800,12 @@ nfsd_file_cache_init(void)
>>>    		goto out_notifier;
>>>    	}
>>>    
>>> -	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
>>>    out:
>>>    	if (ret)
>>>    		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
>>>    	return ret;
>>>    out_notifier:
>>>    	lease_unregister_notifier(&nfsd_file_lease_notifier);
>>> -out_shrinker:
>>> -	shrinker_free(nfsd_file_shrinker);
>>> -out_lru:
>>> -	list_lru_destroy(&nfsd_file_lru);
>>>    out_err:
>>>    	kmem_cache_destroy(nfsd_file_slab);
>>>    	nfsd_file_slab = NULL;
>>> @@ -861,13 +857,36 @@ nfsd_alloc_fcache_disposal(void)
>>>    	if (!l)
>>>    		return NULL;
>>>    	spin_lock_init(&l->lock);
>>> +	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
>>>    	INIT_LIST_HEAD(&l->freeme);
>>> +	l->file_shrinker = shrinker_alloc(0, "nfsd-filecache");
>>> +	if (!l->file_shrinker) {
>>> +		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
>>> +		kfree(l);
>>> +		return NULL;
>>> +	}
>>> +	l->file_shrinker->count_objects = nfsd_file_lru_count;
>>> +	l->file_shrinker->scan_objects = nfsd_file_lru_scan;
>>> +	l->file_shrinker->seeks = 1;
>>> +	l->file_shrinker->private_data = l;
>>> +
>>> +	if (list_lru_init(&l->file_lru)) {
>>> +		pr_err("nfsd: failed to init nfsd_file_lru\n");
>>> +		shrinker_free(l->file_shrinker);
>>> +		kfree(l);
>>> +		return NULL;
>>> +	}
>>> +
>>> +	shrinker_register(l->file_shrinker);
>>>    	return l;
>>>    }
>>>    
>>>    static void
>>>    nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
>>>    {
>>> +	cancel_delayed_work_sync(&l->filecache_laundrette);
>>> +	shrinker_free(l->file_shrinker);
>>> +	list_lru_destroy(&l->file_lru);
>>>    	nfsd_file_dispose_list(&l->freeme);
>>>    	kfree(l);
>>>    }
>>> @@ -899,8 +918,7 @@ void
>>>    nfsd_file_cache_purge(struct net *net)
>>>    {
>>>    	lockdep_assert_held(&nfsd_mutex);
>>> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
>>> -		__nfsd_file_cache_purge(net);
>>> +	__nfsd_file_cache_purge(net);
>>>    }
>>>    
>>>    void
>>> @@ -920,14 +938,7 @@ nfsd_file_cache_shutdown(void)
>>>    		return;
>>>    
>>>    	lease_unregister_notifier(&nfsd_file_lease_notifier);
>>> -	shrinker_free(nfsd_file_shrinker);
>>> -	/*
>>> -	 * make sure all callers of nfsd_file_lru_cb are done before
>>> -	 * calling nfsd_file_cache_purge
>>> -	 */
>>> -	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
>>>    	__nfsd_file_cache_purge(NULL);
>>> -	list_lru_destroy(&nfsd_file_lru);
>>>    	rcu_barrier();
>>>    	fsnotify_put_group(nfsd_file_fsnotify_group);
>>>    	nfsd_file_fsnotify_group = NULL;
>>> @@ -1298,7 +1309,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
>>>    		struct bucket_table *tbl;
>>>    		struct rhashtable *ht;
>>>    
>>> -		lru = list_lru_count(&nfsd_file_lru);
>>> +		lru = atomic_long_read(&nfsd_lru_total);
>>>    
>>>    		rcu_read_lock();
>>>    		ht = &nfsd_file_rhltable.ht;
>>
>>
>> -- 
>> Chuck Lever
>>
> 


-- 
Chuck Lever

