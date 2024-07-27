Return-Path: <linux-nfs+bounces-5090-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5093E037
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 18:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9019D281917
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 16:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2B538A;
	Sat, 27 Jul 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="deZw4/z4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oZp6nNet"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8E1DA23
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722098810; cv=fail; b=Xe0CXSLZItpZN2RsM5PEdZToHNRCGmTyBns3fh0z69H7AQNbIPW+aD/hb5Qei+PcVhZIGNotmznu55mqG0C6ZzHTa+2RK4S1N13Cby8ymiknyKJkefhAmyN0vfSm3gE4QrKDqp9CPcq4k3nJUU/xPlB85YYe4BHfF68qn/GUipA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722098810; c=relaxed/simple;
	bh=O2IcqyCCbj5Wn5f3kzA9j8XQvLRTTF4kc9zhXQB7FuI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IoIyrq1mum9fHvAsCW9hEocuCYCVt8ukKR8Aq8O12Gdp5CMHcNHoKv4TM9MFD2846CELmY05R32mYzKXHFZZn4GPa1JxS+lkvXXavCIqe8VZboNtKh0xHi5l928zHNp5NdoM842kwDX0MFpz/w1hw3Qu+cugCE4jGHPemJanxH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=deZw4/z4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oZp6nNet; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46R6xQ0E030602;
	Sat, 27 Jul 2024 16:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=6LrQX0cC2DFfI9WjKaZef03lRGxsaO40mgGIOv245i8=; b=
	deZw4/z4tHffNszQAgfNt/1m6++W/+fsmnDVNITPh+Lgxiy4cSEtWaGb7ovjgYld
	pdlXUyjTb3MNTOTeTFFsCMl7UT90SAUEctlC1Uz6fUNQwif7jfS6cQeCwyVpiWBw
	reRCOBlwVGkqwh3oZ9C7X3KMxaJLzjXNDquxnGsF42aZjM6a2QQCixe17gfskFcZ
	LvOn/pEfqdGK19RvYOFAB3A9eYOjJxxoTqE/Xgej7gi0YeBtqGJ/zicOMTMU5klR
	OXc0V6oSkV0CwdJdywMp7VWpBuOP9Oauzd39GlJgiUOniXSStvJxUXnFPlzzHFYL
	OAKsl3nEQbuX/JDe+mappg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtagf8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:46:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RGg2dM031028;
	Sat, 27 Jul 2024 16:46:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb5cpjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzdYGrsjnHN/B0+jQkxUX4xD5V3/t1El4dRjbOdqpj6nb079I2v9Ex/z5NkJfAvs9dpiRkh23suYIQxH7QhK1q1WKM0qFSW3GVdvqLrhqezjQSBXqwmJxZ8hhXEFxlVbLaDK/YOi6mwFeOe9qAbRjIiRWpzrygfgbK9ImJG9D3/KgGVEF20HOI10GfUT8Vi3FnawdcuxR2e5pBL0EXBFC05ASoTOT/EMpUnT9EvX+O8yYESsIjjndA9eXh52WPRdGYhQTFlVgjZTpqXDRg6PgYPuJcFRphXLRznFtu08Keh+YhxUaeU8pF1W+dilRkKsbqtDiIDObqYaUHq0AWpt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LrQX0cC2DFfI9WjKaZef03lRGxsaO40mgGIOv245i8=;
 b=Spp1x/1JDnURf9EnEriZIqSirTgf/HAgAUgW+1OQsPNflvKWve/but7QdSmQkRDJ2Gal5xIN5egkyKe9WtNWTuMAwlXJ1rikvMSdLLg4jaF2sP4ufGEyCupM8F+WOJuKua8geLPU8TkBAbTw7hiyrmi+TjTLUGktT1xsvQ7ifB/xMZ6XohnxxwgUzn+FRz9/cFhWScPpkQqdaJcs7sF/eexH4wHWEMwL6PjFGNXYp3azDTU9kSYLkpb6xtYQW1ISiROvYjJ6IN7YyjX5JxZ7Nz+iND7NoGlGG1o5HhnfNGFLGlX7IwAcV71b3BR2MBO3j42RaHHbc5Rvp0k3MDh7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LrQX0cC2DFfI9WjKaZef03lRGxsaO40mgGIOv245i8=;
 b=oZp6nNetR6y46c8veam5YNhvesoZDOPVReMkvlDbu3VR16KHtoxpYkk3NGlmtcHn/O96Y10XoFBblZ3LPlEvdfBXfgepKsSidgUy4bC4XMyzFWqRBtCOo6QC1bhyzDFcS+dad2AX06l249C0iM7Adg391UXfWOTRcJIP+g36mrE=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS7PR10MB5005.namprd10.prod.outlook.com (2603:10b6:5:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.25; Sat, 27 Jul
 2024 16:46:37 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.7784.029; Sat, 27 Jul 2024
 16:46:37 +0000
Message-ID: <df15b4f4-e325-4ed0-bc94-957113a64915@oracle.com>
Date: Sat, 27 Jul 2024 09:46:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20240724170138.1942307-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::31) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS7PR10MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 105c79a3-9dbe-433c-bdb3-08dcae5bae50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDVMeHVBMk1rTEppYVowNHh0aGlLem5XeFhLUjEvb3k1K3lzKy9XUFRiS0o2?=
 =?utf-8?B?ZWt1OW92a3I3SEpTN3BRYVpYalNMMkJQTHJDVVgrK0p6c1VhSXJjYlBScTNM?=
 =?utf-8?B?SUZYdkl2R2l4NnJYMlJuTE1nRjZGSUI0Z0ZtNXViRGNVUWMrYnhlMXd6Vm80?=
 =?utf-8?B?NndLbW1LZEMwT3FQTWxyV0wxZ3pnbDFGOUdnbUZLM3VEa3ZOR2NUQzRYR25q?=
 =?utf-8?B?aUNWUDNXK2tKNmlkWHJWZU5NeEtSSnk0TUJWZ2k1YVlhOTIzTFJwMXVNK2J3?=
 =?utf-8?B?Vkg5UStleTRXRzl2ZldOSk9vT0R4WW9rNHUxbFVlQTlTMEt0YVdQdTRTbkh4?=
 =?utf-8?B?VXdyUnF1aHk1MzVpQ1NPOUZ0YmJVY1dNN3R3Qkswa2w4WVBFQWRJMDVqcWI2?=
 =?utf-8?B?WFg2a2xjWExjemZkcGZjNDNySUpLaXdjcWMvbGVGaFM2T0t6Zm41WU54VlY2?=
 =?utf-8?B?NGN6OVJIZVd6M2pVclhTT3NOUytNZDl6aWVGb0JsNDVvS3dtblNJVHl3YkxQ?=
 =?utf-8?B?SXN3MWgxbXVEZVVIS3hnY2I1VFlVREJzZVV5a0w3OVJqb0pHOHR2N2tYWUd5?=
 =?utf-8?B?N1ZDckY3VU1JSXhUMldXM2FicHJLVlFJdUZqaGlFWXg3N3lLbDhZeDZnUUtV?=
 =?utf-8?B?RmhyUG9KV3hSTkhEVno1N203R2NNQmxna3MwYytBWG51UWhqVDJkTVFIUVhr?=
 =?utf-8?B?WWFxalN3dStHNkhrZElqcXFZTE9zOCtTSHVuQVJvdHhBbnhPL0xhc2l1UEJa?=
 =?utf-8?B?K0VVUWhLcUZiRzBZTklER2gvZHU0ZmtoVnRuTnZUWExTM2hqbXFrNXAwUnM1?=
 =?utf-8?B?a2RQR2hHWUh5a2kzWHExY1poaUFZL2dWR3BIQzFQaDhQd3pnQ1d2ejRKNnVF?=
 =?utf-8?B?VUNSYThqMm5hakg4ZHRFMi9SUzNEaXlpWkN0bWRKcUM1MDdmVTFrNlBZbmJO?=
 =?utf-8?B?ZnY5QzFnUHo3N2NTYTQ5U0dyaTVCVzdtalA3N0lhV1ZyVGF1TDV1TUJhWnQz?=
 =?utf-8?B?aVRYRVBIRjZQelkzRVRnb0tRVm5xZkJ6QVdocTUrbUtORitNamdJb2o5TmZU?=
 =?utf-8?B?YkdPcTB3NlY5K3lJVEN6QkdXTExQNU5SV0JVUDVYWGR1K1R0djNXOGFwOHpG?=
 =?utf-8?B?SFh5VktYdjE5eVo3Q0NaaFlFNC9teWVqRnE3dk1RU1l5ZU03RGw2YVNjQk1u?=
 =?utf-8?B?amlyUHU1UkxwNU1kd0VCdzcvbW8rZWNUWld5bTM1QWVYK0pkVzA0b3dIUXNh?=
 =?utf-8?B?S0xJemU3a2I0Snl6YU9KRGhwOHI0b3BrNS9IakNSQjRCQ2VGZW5HczVvczkx?=
 =?utf-8?B?RFdpK2VYeFB3Nk54QjFTVFNBb0hmSWdVTk9pQW1lVTFyeCs1TWgzcm02TUdi?=
 =?utf-8?B?MWUzRmN5V3l3Zk9NSFBONFZKbHp4bHlIR1RuVjlxZW5PNWg3eFJhTUphOEUw?=
 =?utf-8?B?KzBsd0VWc1Q1RmZDRm9XcStDODY1MHpaWTEwaTFqVDYyVkl6YzcveWJzMGJ0?=
 =?utf-8?B?Umt1bG9LYmc5QWhocXg2VlNKeDRsVXc0Q1A0ZlpTQkRiNTdiM2Q0NTBodVNy?=
 =?utf-8?B?dFA2UUdSclIzVXNmcUJWRHZvdE8vb3hxbFp2a25qM2YzZFIxMzY2ZEptbGpG?=
 =?utf-8?B?dWdUQmlmWkJmdTFnOWhkc21lTXVDNGpDK2wwb2poMVpCYWxyaFZyUlpTaGtI?=
 =?utf-8?B?bUxCcWpNSnpMSHpJTlk3SlRIOVR6TTJOT3VnZ3VUYlNXM2VWRDIzZFppYTM1?=
 =?utf-8?B?ajRwRFdpN29RQlBFTXJQYkVHM25vYlpxTy9XTUFtY1VWL3piV3I5WHkvcTZs?=
 =?utf-8?B?WTdLMXRmVWdMSXZINzVBQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzFzYmd3N29uRmxMaHhsckk2bkxSNnNnaWllbVBKMHFiRFNkbmlkZnVFTmFU?=
 =?utf-8?B?aElLTnIxRWpiTHdkOGdzVDh2c2FrZm1NMnZmUExzeitNSzhCMUtwK1dVZ3BV?=
 =?utf-8?B?dlN2QkM2cEVHeHdYNEFTSFZuR25kdU8xbXdwUTdkUGJiOTNicEtRVVN2T0Vi?=
 =?utf-8?B?SmgxZVQ0NmZoSjlJdk56K0lRTDRsRjZiY3VSb0JaVStzQy9pK2hyNWdHUEpJ?=
 =?utf-8?B?TWNWd3QvQmNnbjlFemVUTDkrd2J6V0Z6WEovczlhc2kxbnVUbWpIYXlZVHNq?=
 =?utf-8?B?aERXdzZsQ25wWWtFZEhLTk5RS0tsZ2VJZVNldk8vQk5rWHRlMGpNMnZGcWRi?=
 =?utf-8?B?TEZ0bjJHNktZcEQ1TTU2ZGhrN3RSb2JLZlcxOC9KY2hrYkNjcXJSL1k4QUYv?=
 =?utf-8?B?OXdMcEt1Wnkxc0NsTkhjZGN1QklvVUZ1ZGk5MGNSbDhCWDF3cGxYbDVSL1ZV?=
 =?utf-8?B?czNDNGR1eUhwTHJxanlqOWxhVXRQQldSbUJSclZyVnRmeVo1RzJBQ0djbDBj?=
 =?utf-8?B?SW5JM1cxSFVWSzJ2S211UmN4aGluS1V1WlNjelk4QUJsMXdkcUw5citoQ0Nm?=
 =?utf-8?B?Q1ZjSEJLSHpwbjlBSzkyMysvNWhHdGhSQ0ZjVjFvQkpHdzNZZWpXRU1ESlNk?=
 =?utf-8?B?UTBya1RySGljWmJKNFhKMFNUc0N0MDFqUkhnUmlWUWVaYkpmdHBKVjBKcEpa?=
 =?utf-8?B?YSs2V2lxNGRGMnhXR0w0aDZYSU8wVzZ0VFlhVmxBK0Z3WVptNHM4dnh4UTI4?=
 =?utf-8?B?Uk1ZVWRjUlVUb0RnWFZDRGRaZXJEb1hYbWpmQVZUdVdna1E4SGo1UGVCS2x5?=
 =?utf-8?B?dEtwY0xDVTE0UVNDanNVdlQxQWYyWG85WGJtVjdtTk9VY1pSUmpCWURRb2ZY?=
 =?utf-8?B?L3h6U3NNMi9RdEpDb3lqSGlJb1NQa0J3UXlZR0dzMjRabDVQMjNIU0lGaVdP?=
 =?utf-8?B?WXlFd0dZYjlLeUVBTldUV3JiWTVTdW4xYjN3Q1hLOVpsTGFpVW01U1B2UzUy?=
 =?utf-8?B?UHd4dysxSURtenJ6RG95MGhhenljUjVHVW1oMWR2RlFtRVB6WXFjS2ladTIz?=
 =?utf-8?B?czBzRFRBTDgyUmVwSnJKUXR4VFk4R1kyTkVFbmJqQnZya1hhMTlKcS83VCtU?=
 =?utf-8?B?MUFIdHNBRCt0V0dZc2hXcndnczFmYUIwamdQV0dUQWZPWFc1d0JVL0VWMktn?=
 =?utf-8?B?WHVKQmxPck00TllJSDJvMDEwWnlyZUFhcW5EYXlTRnVxS0hBMkd0RGZrRkI0?=
 =?utf-8?B?RXIydWxibVJ6YUxIbWZQVXhEc3FmK0xNS2tqTTU4Si9lRkxiUDlRUjl0T1A0?=
 =?utf-8?B?TERSM3VRS0FvM0kzaW1VNEsxT0FiQUIxenZHaU5JRmVSS0ZJTVlFQS93VTV2?=
 =?utf-8?B?ZHBZV281TVE5NmI2OHdHT3AyclVCNCtZeTRRMmhhblB2NmNYRGdJblNuNDJ2?=
 =?utf-8?B?UGRpK1hZK0VWZ1lRL1h4UEgvNE5GNE1tczVsN1ZhdVVIMHRFWGt1UHV6WWRG?=
 =?utf-8?B?K2psWjI2VDBCeXIxNUwxTVVSbXR5R2VrdDQ3eStYWDJTL0paL1cyMmtyZE5p?=
 =?utf-8?B?aVpxWTJzTDFQSU8zbm12TE1GMVF2eXVLMWRYcEh3MHVXNm81bTl6NzJqclpZ?=
 =?utf-8?B?Zy9wOEFYb1BNTERJdW1TQmdkWU12eGI2dHpLdEZxS2hhc2VobmQ5RWYvZll4?=
 =?utf-8?B?dGk0NzIwbFdaZGs1WDdERjF6aERCNkxoQmowQUZHRXR5OFZFOFdybFQwL25s?=
 =?utf-8?B?TEdkbDd0aVdSVlpPWGMwUS9CMmdJeVVoZm1RVWZsdjl5S0FtNFJubE52RzRR?=
 =?utf-8?B?bDdBRzRCWSt4WmJuaGNzZW9SWmVKRG15QlZhVXlpczZyWjVEN2ZVQWN4a3N1?=
 =?utf-8?B?UlFKL2JrMnN4My9rQVh6V055ZFByZCtNNE5JU0dxZmdyNEhrN20yK1JmQW5t?=
 =?utf-8?B?SjI1Q1UvTFYwTjRmaHFUeDZsTytqSEVKWGV4bXhnQWJjL1pBcWtVbDIrVkl6?=
 =?utf-8?B?Y3BvS1BkZFREb1Q0S2w2eU9xeEQybWk3MHJPUTAyeDVSaUZ0dGdTYlQ0ZXNE?=
 =?utf-8?B?WTR6TXRSaVk0YXpPWEYwVUQ1MnJubVVGOWxJTmV1OGZRWXJYWkYwY0x0eXBq?=
 =?utf-8?B?UXhUUEFHbVUvdXNZY2l5TkNiakpqdnQ3eTl6aUNFcklJTERRQlF4OUtsSVVw?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i6ayi0W4FAaVaZOSmpDk1PiVYIBUlzpC5fPDHDhuhTfynXEYScwJRgVFgRhuu/rpmmwcsDlh38mo81mvFDjmE6ya0m7fDxG7cK4XzVwq5V5pI4lXnwNO/c9dyvmbfEO3RrPUCAkRSQxTXc75Jm9OpjqRsXLdmh//48+CKA6Ga5Ra3MF/b5ABnkL3aVDaaYvwn8bsgxVklsHXR3momBoGQfhmEcbKVyj/vffsucZhiMsJfm91wHTc/jBrhnmSXRpZelOlhZaGsIHDTksdTrEQMCxDlM/xdGRksBhUXPFB24vH3y+MRxBH9KxBnh3kMpLk+10cilpvo9hhdRfh1wj2mFKMp1/ofJjfSesaT27tSbnjMm+AblJK3a74xMVg+afbsGbYc+yscfEc1Sd67suvECm+lqDKYlwtQ0RqM9IiAMKUpA6h3fHVisiX3wtif6NP0IKc1RysAGauXfQfLvMXi/Yn28FSQ/icItas4VK9oS3xIsF5ks8sCjErZf87xywyXpX00fmF5Svf/qICDii8tp/9SD7Yu9zyqAVfQxAy8EgGBNfKYT3ekbd8osDNSRZ+8nag0hOC69k9g7sasHRGiNgQmePo1E45ZE8YjT23uGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105c79a3-9dbe-433c-bdb3-08dcae5bae50
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 16:46:37.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKqlc9yoPLtjAZ2Yyur+hwGRWVrWrQ/kZXlOy/rMTmqzavRkiWrf5ZXnxVyUQFrzbPpBpUGtezLjMYNa/aNLoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407270114
X-Proofpoint-GUID: Xk6wtEbR4dZHWC5o4dvZ0Maoo2TadHpM
X-Proofpoint-ORIG-GUID: Xk6wtEbR4dZHWC5o4dvZ0Maoo2TadHpM


On 7/24/24 10:01 AM, Sagi Grimberg wrote:
> Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
> stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
> Stateid and Locking.
>
> In addition, for anonymous stateids, check for pending delegations by
> the filehandle and client_id, and if a conflict found, recall the delegation
> before allowing the read to take place.
>
> Suggested-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
>   fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/nfsd/nfs4xdr.c   |  9 +++++++++
>   fs/nfsd/state.h     |  2 ++
>   fs/nfsd/xdr4.h      |  2 ++
>   5 files changed, 80 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7b70309ad8fb..324984ec70c6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	/* check stateid */
>   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>   					&read->rd_stateid, RD_STATE,
> -					&read->rd_nf, NULL);
> -
> +					&read->rd_nf, &read->rd_wd_stid);
> +	/*
> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> +	 * delegation stateid used for read. Its refcount is decremented
> +	 * by nfsd4_read_release when read is done.
> +	 */
> +	if (!status) {
> +		if (!read->rd_wd_stid) {
> +			/* special stateid? */
> +			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
> +				&cstate->current_fh);
> +		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
> +			   delegstateid(read->rd_wd_stid)->dl_type !=
> +						NFS4_OPEN_DELEGATE_WRITE) {
> +			nfs4_put_stid(read->rd_wd_stid);
> +			read->rd_wd_stid = NULL;
> +		}
> +	}
>   	read->rd_rqstp = rqstp;
>   	read->rd_fhp = &cstate->current_fh;
>   	return status;
> @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   static void
>   nfsd4_read_release(union nfsd4_op_u *u)
>   {
> +	if (u->read.rd_wd_stid)
> +		nfs4_put_stid(u->read.rd_wd_stid);
>   	if (u->read.rd_nf)
>   		nfsd_file_put(u->read.rd_nf);
>   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index dc61a8adfcd4..7e6b9fb31a4c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>   	get_stateid(cstate, &u->write.wr_stateid);
>   }
>   
> +/**
> + * nfsd4_deleg_read_conflict - Recall if read causes conflict
> + * @rqstp: RPC transaction context
> + * @clp: nfs client
> + * @fhp: nfs file handle
> + * @inode: file to be checked for a conflict
> + * @modified: return true if file was modified
> + * @size: new size of file if modified is true
> + *
> + * This function is called when there is a conflict between a write
> + * delegation and a read that is using a special stateid where the
> + * we cannot derive the client stateid exsistence. The server
> + * must recall a conflicting delegation before allowing the read
> + * to continue.
> + *
> + * Returns 0 if there is no conflict; otherwise an nfs_stat
> + * code is returned.
> + */
> +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> +		struct nfs4_client *clp, struct svc_fh *fhp)
> +{
> +	struct nfs4_file *fp;
> +	__be32 status = 0;
> +
> +	fp = nfsd4_file_hash_lookup(fhp);
> +	if (!fp)
> +		return nfs_ok;
> +
> +	spin_lock(&state_lock);
> +	spin_lock(&fp->fi_lock);
> +	if (!list_empty(&fp->fi_delegations) &&
> +	    !nfs4_delegation_exists(clp, fp)) {
> +		/* conflict, recall deleg */

I don't see how we can have a delegation conflict here. If a client
has a write delegation then there should not be any delegations from
other clients.

-Dai

> +		status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
> +					NFSD_MAY_READ));
> +		if (status)
> +			goto out;
> +		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
> +			status = nfserr_jukebox;
> +	}
> +out:
> +	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&state_lock);
> +	return status;
> +}
> +
> +
>   /**
>    * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>    * @rqstp: RPC transaction context
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c7bfd2180e3f..f0fe526fac3c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>   	unsigned long maxcount;
>   	struct file *file;
>   	__be32 *p;
> +	fmode_t o_fmode = 0;
>   
>   	if (nfserr)
>   		return nfserr;
> @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>   	maxcount = min_t(unsigned long, read->rd_length,
>   			 (xdr->buf->buflen - xdr->buf->len));
>   
> +	if (read->rd_wd_stid) {
> +		/* allow READ using write delegation stateid */
> +		o_fmode = file->f_mode;
> +		file->f_mode |= FMODE_READ;
> +	}
>   	if (file->f_op->splice_read && splice_ok)
>   		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>   	else
>   		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
> +	if (o_fmode)
> +		file->f_mode = o_fmode;
> +
>   	if (nfserr) {
>   		xdr_truncate_encode(xdr, starting_len);
>   		return nfserr;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index ffc217099d19..c1f13b5877c6 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -780,6 +780,8 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>   	return clp->cl_state == NFSD4_EXPIRABLE;
>   }
>   
> +extern __be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> +		struct nfs4_client *clp, struct svc_fh *fhp);
>   extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>   		struct inode *inode, bool *file_modified, u64 *size);
>   #endif   /* NFSD4_STATE_H */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index fbdd42cde1fa..434973a6a8b1 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -426,6 +426,8 @@ struct nfsd4_read {
>   	struct svc_rqst		*rd_rqstp;          /* response */
>   	struct svc_fh		*rd_fhp;            /* response */
>   	u32			rd_eof;             /* response */
> +
> +	struct nfs4_stid	*rd_wd_stid;		/* internal */
>   };
>   
>   struct nfsd4_readdir {

