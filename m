Return-Path: <linux-nfs+bounces-10696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9258AA6988E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 20:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9411D7AA319
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7DD1DEFE3;
	Wed, 19 Mar 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JsRxNvcz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iPL8o8Fr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95449212B2D
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410862; cv=fail; b=aIHb+RKNYeFKzd+dnOUZa0DvHh1agmklm0Nfc9j+dDnhC5rRVM7PQFHFAPGkOibrGhOzyYVoZm7DpMEuHtVkD6go845VyF8guDLDJ0yJ5cptYZI09Llo6nGtCLz8htPHNPiXg11vSF8a7otXEERNl6OsMj5hdRIthPdam9QIvJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410862; c=relaxed/simple;
	bh=fpPwRFguBxvc5T+LMXMTCQFCEs/5XUa7ol8hbdVNr+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WdEI/MySt2CtEbHR+iJL527Gz0AD6KJaF9sjUjKFXP+ApRJSj9Gd8I0b+5kvJLPtKFYRXTjFVP7vaN66uO4UQeCEElyf5Z0aAp5HPfEVmgRovt6MpSutXTI88yWUGbZsumzFZk96cbqMYkrOHOHaBCGIRnHG7+XW71fHQemue70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JsRxNvcz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iPL8o8Fr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JItiN5004350;
	Wed, 19 Mar 2025 19:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fpPwRFguBxvc5T+LMXMTCQFCEs/5XUa7ol8hbdVNr+w=; b=
	JsRxNvczATxYFbbT/JBMnxouC+NvYTPhCR6E+e59oRRsScz6KY95cHEFLJShG/fe
	WUcK0GfC9ebRBIkcVH2BBIypA4GMrFtjk3AP80/3oJaemtwfyeB/oecAmXcnKx7H
	1iGgVVJM+8QLhc3TemWE2rA6j83TPwLv36+iOFJNh75f+0jtHzpp9M8geTkG48J0
	jIAZGMbkEB5iY6A6SB0Gr3DzatMILhiw0VLU98DR3BTxfYYXXYQZnNZyppydkJyt
	75tuVhs02/jBXwIGlXr4R2Vawc7ENBrzsXgp89Api1QRDM6oe2plHCBQQPI0a7B8
	UB+F2UJ2zK6Yg3Lc8MXexQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbc483-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 19:00:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JHcs9l024957;
	Wed, 19 Mar 2025 19:00:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbkbmry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 19:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD7WWMCG37FA2iAgWb6UPMoJeStTwelpVPvljtFZpXtqNuc5eiVMP1qS74RqAPl0j5BMFmQ0jcX1w4TphqznKjWFP3XCnJ0suTuglGWNqh5d35Iu0Kofu/iCfUXJRdSnKhG2gX/6r5lx3E50+rPO/zPug3zm/l5Cq0m8oHH9R0Ghf1AjXr7MN+nMVq89u2pqq3GJ2w6lK/LqIWfVFvGgPS+eQ5377QAhcF8FaVfCQmTOL+joJ45qoVYfoLoyFfThn52iWUaptL5NnfHVFai6nO0wQpk9vckGxmKKptp8/OBx9IGVier0ukzcLtQ+QUr76sZRJCj0oXuIobIwe1WoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpPwRFguBxvc5T+LMXMTCQFCEs/5XUa7ol8hbdVNr+w=;
 b=CeKnlwc/uafxUjXOwPUmkjXGhzOfntlBsAcoxFMGTKH8tE/QgjGGXSsRJEerrz5CcCDEaVLAhpiORR+xGsnitct0pU01QMWfhwgsYv1Qm/r2Qadfu4EQC0dHhhzE4Qj509eMM7+RQ4qSCrpfkCydBUP12FFcQsbR3w8TZ3OG1LO+09CxAmEKlNgwD9/v6mnRa/u1VCTrNALKmK8EdRGSmC/PodLPfy0zKrMTtQAlfIhJgyB3Ko2tPxOhQETFjLPAvlFRR6N3PiwXVOiZbwPQKEOPclUXWgFTBev5P4+5fYhbnKYJI+eKLpjLEDMk+LZcRbpAUXrJ0uIdHlkAPLBJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpPwRFguBxvc5T+LMXMTCQFCEs/5XUa7ol8hbdVNr+w=;
 b=iPL8o8FrlYJvk1nOhECdLhEi7GadujUwoXTE9Ib18yotqkfQZ0QJQ3ElA6GB3zvx3IrZSUUA/yf8ODmdsbNXEoKgb4GqDEo4y2u94jnAb1PDZCT/u9jEnEjmIYPpzOptU+tW/ztCF5iZlSSs4OiMlS0NvKBVZuQeZ8Y1BsMvbfE=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:00:45 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 19:00:44 +0000
Message-ID: <ba129a50-a4cc-4294-94bb-c75b13454e47@oracle.com>
Date: Wed, 19 Mar 2025 12:00:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <37313734-890a-4ab6-a2f8-0ee5668c1298@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <37313734-890a-4ab6-a2f8-0ee5668c1298@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:408:ea::30) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|BN0PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed333f6-c475-439e-d9ad-08dd671859d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG11MTJtNUxHdVJGYVpqSW5FZTRuRU5uSTNIT05iSDlaKzFYb0NOZkIrRzNH?=
 =?utf-8?B?ZG4rM1NwZkwvbDBtWTRBck9ZaEtyMnUvZnptUThQZGlnemdUWElCWUNUcXVV?=
 =?utf-8?B?QzhOQWJ0Um0zdEc0YXpzdHkwZzdxdFd6MVhEUkl3K3d3TzM3WTdCcWtJcXhF?=
 =?utf-8?B?M2kycXRaeGlKbHZsZ2JuazFBd1owWVYvbDBpcGZuSUhyUytJRW1QSS9rRmYz?=
 =?utf-8?B?Tm5kdkVTK2NFeXo0L0hZZkVyYmdRd1hJYlZqVjQwR1dXYXR4OUFMVE43dWdj?=
 =?utf-8?B?cGtvY2NpVEF3YmF5VVQ3SUNobFdzQXBDdmdxMm9zSFM0bnMrN0tNMjdROGlT?=
 =?utf-8?B?c0E2TVZKbUtmL3NPREpBMjZVMzB0SFh1VjMwOUorUXNxRW1rM293K1g5RVFH?=
 =?utf-8?B?R2p4TkNWWEhvNkIwQ3NRZTZzYktMcTFMMklsWTFHeVdpTkJ2M1hDMmg1dGRP?=
 =?utf-8?B?b0IwWGc0Nm1kWkJVT1V0bGNTeFVsRkVDd0Z3TThSRHMvaU9RdGV4UUxwd1NF?=
 =?utf-8?B?aGFiaWV3OG90djAwcEI0ajlva2JQZkovc1VkUE12cWlETUNRVjlCYVdjcjQr?=
 =?utf-8?B?eWFjNlR5Q0Z2MzlDdlJsOEIxVVR1VmhhSUhlUHpsOEJFTlk4dS9aQmpHOHY5?=
 =?utf-8?B?dWluMFpZYjFOMVhLY2hMaGJpVUFnR3d5QThjUk1hMDEvVE8vQ3BQQmkyb1pN?=
 =?utf-8?B?Z2RSemxXcHJrSWJpUDA4WVpWVS9qV1hNVHBiZ2RtaWJwblcyRVk5dFFlYkxi?=
 =?utf-8?B?Y3ZoOCt5OTJjdzN0UUd4VTJaU1grYmp3MWl0RjRIeUVUMm4xZnBFUEdEY1VL?=
 =?utf-8?B?bFBWM1hpOVZJR3d6U0xld1NBS3diTFk2NjFtTTgzWlh1K0NoS01JZVFqZ0da?=
 =?utf-8?B?SlVnWVB0T1lHcVIyb25McUYraEpQay9QMjdJRG54b3lxYXQrQjNqNStPMlcx?=
 =?utf-8?B?SEc5Q05nL1dqcmpDQlhJSXlIOC9MR01Ec1RPbm1aNnB2aGNOdDk1QTczVXJQ?=
 =?utf-8?B?aHZjSTkra09kNG04R08vOGswcDVHeGZ2RFZNeDlFQmFJbndvTEJmeXNma1JX?=
 =?utf-8?B?Y2dOUTRoaEZ6czJ2TU1obTcyK1EzZ3poRktkZkZsVmQ3UDMzUkp2NGUrc1BB?=
 =?utf-8?B?THVOVmU1T2J4MUFzWUlsU3VydEhqQk5wYzVJMGZ2LzlmVjgzS3gvU2N0K1pm?=
 =?utf-8?B?NHBWRWJJOFZEdkZ1ei9EbCtmeGFDRVlhaUNqd2pxYjg1aDBlVlpWaExTVUJp?=
 =?utf-8?B?ZlE3RElweFZBQXVIaWdmR3JMSm0zbytKaGRWNEJwK2p2eGNNWHdoZTJCNkFj?=
 =?utf-8?B?cnhSK3IvWUNSS2pBNGk1ZWJzTmhndFZOMlliRzUzMUdxcjJWYm5wZFpFZTV4?=
 =?utf-8?B?VUhKY1VWUVc3bGVSdjl3QWp2VXQ0T2hnZzdWSnl6ai84UWRUbUx0elFOWGlp?=
 =?utf-8?B?NElRU0lQOXllNjUwRnZOeGorU0toT1pNUVg0V3J2ZGc2VmdVWjQ3bWxzaHJY?=
 =?utf-8?B?SDdEZVk4SW5ZaVVUOVVsbHRQSllOTm5xV2Z6SWFlMFlIMEoySVdaeS9ORVBx?=
 =?utf-8?B?KzdicjQrQmVhRStDVU9NUitreUVSR0VPWFl3RWhEOU9OSCtGeDRNYjNmZ2ZO?=
 =?utf-8?B?L3c1UWMzOG9zMmtKRVVBR25WTWxuRjB1T0dDdHFDa0NHeFkyMkFhZkdKZWNk?=
 =?utf-8?B?NFNQdVZibzVWemdta2pZcTFpbFBCbW94RTBQNmhzZzA1cHBIRW1mSjNYWjJh?=
 =?utf-8?B?UVNKZXorcGM2TWZQd0Nkd2hxbytnY0YzUTA4QzVVUm1LN2hWaVNBZ3BrbXlm?=
 =?utf-8?B?NzdoZWQyM2dnQXdBYXpyMFdvVjlOdXBYd08zQjJqdDNmc2ZYYkM2WnJvd000?=
 =?utf-8?Q?5nkuBS1U4yQxJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFVtaUMrTEU5YlVSMHlwb3hoc2RicGcyRjIwYVhacHN4SmtiVkkxLzdueEFj?=
 =?utf-8?B?M2ZIeGFNUVBIbzlPcE5idHExNjR5MlVDbk4vbGNRWUc1OXhiYU5nQTR6QUFz?=
 =?utf-8?B?czlXNnBZdUIrdjM2THJiaS92bTBleFFDR3lSZUhaTnBTcFpRSE10eWRGZ2c5?=
 =?utf-8?B?TEhiSzFkeHU0MzNMcjZCWjFWbnkvOGFiVkFFaXhIZTBMT1VDYk1kVmhCekdt?=
 =?utf-8?B?VmJuVmEyeGpxalVsbEh5MU45d0ZESFhrNXBoazZVaUpvcnQ0dTRKbjF5Vy9k?=
 =?utf-8?B?WXg0ZFVQVlZwQlVpYUl4YkV3Q3pucy9yWVBxMmp6Vm0yMEdpMkxyQ0VsdmlO?=
 =?utf-8?B?c1o0anpqQjRob0dDb3ZhRXZQV3k2bzBJbldBVGJYZldDVmhBZ2JoVVhHWlVh?=
 =?utf-8?B?V3FqNnF5Q3lrUFlKbml2bVRqeWRNK3lTOFJQNXZzY1p0SWxyeG1RQVk2MTRY?=
 =?utf-8?B?WFVKSDByNHoxeFRPNndkdS9PTEw0YkxweCtRaGZIVzFhaitlR252R2xaYUJy?=
 =?utf-8?B?SzdmeHNnRldvZnRvcmtMazNEdndFOFR2QnJmMEVHREtQQ3RsdWE0RzRvS3lZ?=
 =?utf-8?B?cXpkV0o0d0QyMS9EeHN1ZEViL0pCWStPczQ1V0RKOUhrR0JuYjBGTkhvMk40?=
 =?utf-8?B?cHpPMWoxWk9kOTlYeEs4bWEwNlFPTDJETUpFYnFMTExTQWtDV3B4NGVRRCtt?=
 =?utf-8?B?OWZNVEdwNm1NaDgyYU83UC92QkxuZ2Z4SERtM2VTakhCVVdvOWZnellvMXlu?=
 =?utf-8?B?cXhlWUdlRWUxcUJhL1MrTjZsMTl5UUNJbTF1dkkrZFVURk4rb3pmTi96dEpw?=
 =?utf-8?B?Z3RTTWNNSlJjVzhzMitXelpMR3dEMVhDUFBQbkxyMkFpUFdwckRpdGlXengv?=
 =?utf-8?B?VHlUVTUrQk5OSDROL3g0WEJSRWdHeXlHa3ZvMlRwaVpCRWFrSUMwNGQzQWFU?=
 =?utf-8?B?MUlqeHk5ckFaK29YWDR3Z1VhVGZKTFFhY09ZYXJUYVN2TElSb0NUbUdMT0Jr?=
 =?utf-8?B?anQ4Zi9HMjF3V3hISnBCeHp3UU14RW42NkczU24rbGUxT2t6T1J2UENkakFN?=
 =?utf-8?B?bWhLUVhSV1l0VTNBbGJWMmlIWFRaNjM4SWJzSTdpM2NTRkVtU0p6WjBwQlVn?=
 =?utf-8?B?emxwZWJmV0xFZWJpTHF2bnBQTVkyTW1nNndId0RXMmJIR0s5cGJvYWNWdGxt?=
 =?utf-8?B?dDM2TE9sb0cyNkN1bFV4TXNRTFVhVEJMQkduNXJPWVBablhCejh1UnBzYkoz?=
 =?utf-8?B?czJpZXBhS25qbHJBd0wvNUtPZjcxYS9xdC9LQ0FZdENjTkZ2RjB0UnhaYmRj?=
 =?utf-8?B?YlFuN2ZJTEpnZXVUaStmSGtUMnNxVW9zUlFTajBROUV2eG5TSFhBSDFxSUZr?=
 =?utf-8?B?aTFhc3BTVnlUaEpnS2NobXpQeE43ZXBBV3lGSURNYUtzaVQ3R1lJSzJBYkVu?=
 =?utf-8?B?dCtKVWZZbC9iZ3JqYXl6RUo3bWtGOERDT25aTG1jRkltQ2l6S1lpQWs0Z3J5?=
 =?utf-8?B?dlhTM0lRNmxjTGM4TWVvZm9SaDUzOHJWVE5kSXgxT1BHZG8zN1VnR1pyZWpl?=
 =?utf-8?B?R2ZFN1VsMHZKUVh4dm1CSExXdkNYM2dxM2pxN3c4ek5saTZoU0I5bXJyOFBT?=
 =?utf-8?B?MFgzdDhZY1M5V2NTSVUxU2Y5ekhRUVhJc2lEZk9mVTNzSUNEVXE2MTlXa1ll?=
 =?utf-8?B?aXZ6dWxOb0xwaGY0bE5VTGI3K3JibnNvUisxZjUvK21LWU43MG9rNWFVNWFU?=
 =?utf-8?B?bStFN2x2VkNMTkF4NVZ2U1pJT2hiTEt1R1liZC9GT2ttVWFkWFhqWG5Yakxw?=
 =?utf-8?B?eHdLUGtMb0tLOXZxaytpeFRoT3pnY0wzclFhZXJscld6Z3dkY0lrZ3RGMVBP?=
 =?utf-8?B?VUhoYnplMjg5bW1CYUJMc094SDRCK3FxNjJ1cVE3ZWtWUjYzb0tDVlQwQ01Z?=
 =?utf-8?B?QURFbWE2WWRpZ2NKQmE3elIyUTJvZEtBOEw4SmVwWEFYQys3RGp2WkN6WlFH?=
 =?utf-8?B?SUM5anRodzZXYlRUQkVFWlZtc25MNkFNK1NsUTZKVFhTZlBmOXcyVGhUbU1k?=
 =?utf-8?B?QlYwSnIxZ2MyZWJRZkVBeVdHSlZiWjE5OUxSV3kreG1LS3hnYVdYQmFZM3c4?=
 =?utf-8?Q?h0o0E95Z9v8pq8rS1ww+edfF9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kpaSjq6z0vovyHKopz+/dXi014Qbux069GLFv68SvGzJFyMhTR0Ynej7zEHCnFBqYU10ynw5yLFGAIpDea49SzjdcXAu8ZPSTOWTO7/XPgtcN0PSOl2RaXgLgLQkrLGKBpencAgKTLg6mj1dHXrK5x0+mvvn/RhlNI9sXVKHDlTFPnNT+jZ72tGVp3mpKdwTgj+SFt7p/h/ZUfv6PYkt2v+A8hiwNMyHuhTFkmZUzCv+/kpulzViubIeSfpaCTeIrwqnBUzuhmrZofWBegdoYmBGDvLSh0KHxPqsLIXe0yb+4TfVdjpVE82AGgtI1QgSrsRaIWxLuRtDRPZFP4EJcs0Ro46sbbbZiC08oU0QYlHEn5vlWzcd+jdsmXlsJYZfgIMmROD8z/1ybf9EpbACBckGalANzlJ6G+t/dUzI8SbbOYpacdXTr4VeQDH4HtuFscT2cWsh8+2EQ5dFMzdnUqnnNVAGe8AmO2cUj2FalPI/Si/aMNNJkziPnUz+tdkW2SR85NDCVBWVUlY/E5EMnFii0lp+N1DgQv9AjprQ44VqEXTcHd6fhwGux0IxAWqO6L6yNCZ6sJib0HLXUWmWXMq7fgNFIENPEtZBZwN2YmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed333f6-c475-439e-d9ad-08dd671859d9
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:00:44.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCBxzDRyAj9UHZbnGTaWjdv8RRihCFYXD1idMmUrdfaDlhdg7i8mmn8X6b0SjSiTb1wYtufnCWySLiSd1jsfJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=982 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190127
X-Proofpoint-GUID: WBA9rQfLjGxd-nPKoyYGsib57-o8XfzL
X-Proofpoint-ORIG-GUID: WBA9rQfLjGxd-nPKoyYGsib57-o8XfzL


On 3/19/25 11:28 AM, Chuck Lever wrote:
> Hi Dai, thanks for starting this conversation.
>
> [ adding Mike -- IIRC localio is facing a similar issue ]
>
> On 3/19/25 2:22 PM, Dai Ngo wrote:
>> Hi,
>>
>> Currently when the local file system needs to be unmounted for maintenance
>> the admin needs to make sure all the NFS clients have stopped using any
>> files
>> on the NFS shares before the umount(8) can succeed.
>>
>> In an environment where there are thousands of clients this manual process
>> seems almost impossible or impractical. The only option available now is to
>> restart the NFS server which would works since the NFS client can
>> recover its
>> state but it seems like this is a big hammer approach.
> Well we could do this instead by having the server pretend to reboot for
> only clients that have mounted the export that is going away. That way
> any clients that don't have an interest in the unexported/unmounted file
> system don't have to deal with state recovery.

Is there a way to restart the NFS server for just the export that's going
away? How do we specify an export when doing 'systemctl restart nfs-server'.

>
>
>> Ideally, when the umount command is run there is a callback from the VFS
>> layer
>> to notify the upper protocols; NFS and SMB, to release its states on
>> this file
>> system for the umount to complete.
>>
>> Is there any existing mechanism to allow NFSD to release its states
>> automatically on unmount?
> Can you explain why you don't believe unexport is the right place to
> trigger remote file closure?

Yes, unexport is another place that can be enhanced to trigger the releasing
of all states of the export that going away. For this to work, the downcall
mechanism between exportfs and the kernel needs to be enhanced to specify
the export that is going away. This approach would eliminate the need for
VFS involvement.

Currently when 'exportfs -u' is called, exportfs makes a downcall to the
kernel to clear the cache of ALL exports and not just the one that going
away.

>
>
>> Unmount is not a frequent operation. Is it justifiable to add a bunch of
>> complex
>> code for something is not frequently needed?
> I agree that I/O is significantly more frequent than unexport/unmount.
> It suggests we want a solution that does not make a heavy impact on the
> I/O code paths.

Thanks,
-Dai

>
>

