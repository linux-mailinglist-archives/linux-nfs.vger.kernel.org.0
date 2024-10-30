Return-Path: <linux-nfs+bounces-7588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE3D9B6D58
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 21:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D271F21B69
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 20:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E81D1732;
	Wed, 30 Oct 2024 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SQ+WUms/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="avZFtX06"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8771D1308
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319129; cv=fail; b=rZUgjCmio6kC8RDDOJyuoRCObbi7URxo/rcNKnoZI2wzIhFUCW3/asxDIIhDHcUpxP2hd0mnU1uZtxQspAG0XMrJ9yndDp55qjDolhuueW4nCVqfm0AUddTORApvnBeS7hzyGONsPnLflhC7PxWN6eC/uOM/f0xzCjlJY04yWYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319129; c=relaxed/simple;
	bh=FR/HL0QC9SuLJiCZ+tcCwJZG/ocuhZkHC0Q7M2O1QTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rkriB6LSmhfTC3XxEwZwp/gc1eTJWvnQcOG1/p3VQpmHQs8wDUfQlzlPJkK5aZuxw/6uNhMOvEjnl4Z75AuJmJX7xjrr/aIHNtLxCx36l22EVR6EuTT7+dj4HJFELP6TYej2x2T3sccx8GwbJ6nChM598GHlbbeL3gPR0mvZwlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SQ+WUms/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=avZFtX06; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UJBhRh026911;
	Wed, 30 Oct 2024 20:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9xI5zdEvSuNvFFqXVmlyqRVQAgSUzV1e+v1LFKr+Mpg=; b=
	SQ+WUms/+sccYt1j76TBjOlNs73sgofiXSgBlSal5qhP24aKgvJHFNWw3GJ72tar
	364AuZHZ6qVJE+9+a8PlTsNzjkg13rtiatPFKBgTnAJZLdNfDFv04F5QWuUsIhq8
	oNxk9NLYPhrFD0mGiGHZhmDy0/HPRVFcyS1ps0KfHECEnIdslmdmp1sIqA9xBdFr
	SjYpG1j3jDSkSsSUzQhk51RaUw3cvndic7EFUmp3HumsHe56vlHiIq6wbAcAVnp/
	saTQLHlTagfFwkqHsl/MyrMV91svo6no6r+aEI3ocSclBh8e4P7INjtJgapbR3X4
	2RN/nOEe7wIBSYiKejRxGw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc90yms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 20:12:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UJUmEC004797;
	Wed, 30 Oct 2024 20:12:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2w6rwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 20:12:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFpV5IZxUpvD+Und7wJdiR7JAWHIMIA2//qH7ZpPHiuf9Jq5ttF+DXfAfNuhzXo4fcv8CloEbSIMrME2aYBKGMKzGgO/CfUdAzLLcuVfbNqYsioezpWf+jwBfkRXOQ3mBH/8eGDotOmX8UAmxlL0dtE5B2baGy3Qt9+0kW6RmmhrMQeYpn/R22FfyDJC69OhCO64fTSm0C5JM24s5FMmejEpPlpxV2IPQUquTGJx+BYhWSmnh6aoKaoxmoI01m3Atey3qh66W0GSkpivvUNC4JRi+O2wB/3LGdWx2y+y7BieSeGkqvTZ+BNJOPtqsU9b3M0G8t1ogI82tC3/iN55kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xI5zdEvSuNvFFqXVmlyqRVQAgSUzV1e+v1LFKr+Mpg=;
 b=uVdkHElfPXSfTQ8T5+KAieCe4RNNKzXyHo8fX/4CZH7Zu7as3GFuAuf1yPfsC9kVdlW5e6NJnrKVnkH0HLzXsu8d9nN9XKjyf4su4GFssKHXlsQ1L6GocLgveUhB4tcAKBty6dfnM1kBJHOcW10tYjhuudrRdjRY0XksxJGS0NPA8EZuTVuP0dNAp7uC9Q7sADRig+Kr3fcPduQBtORmetMuB9xI+AhCuqY6Nsgqfv8QhwqwXpRsBZVu1f+LPgLNY82OqAz5mZATUpjPHpINURGn+byovSJ4h950yYbBaFlcl0zHm45rRoiH42Z1S6T5+AordcKY65Wqopfy0qr0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xI5zdEvSuNvFFqXVmlyqRVQAgSUzV1e+v1LFKr+Mpg=;
 b=avZFtX06OP2tHzIlx8Je6YIc/hMJ/ll5kIt1dB/lNKwPcr9PdKT3kOB+iydUG6tFo9XhRYHGouHPWxB8//koNJWiD9A626uDN2a9jdrFsWMDZzxy83FpLu61AaxvTp/BFpTlqxx/VAL0mkWrqnajASEyBuiz3qA7S5W3QOMgy1g=
Received: from DM6PR10MB4300.namprd10.prod.outlook.com (2603:10b6:5:221::8) by
 DS0PR10MB8197.namprd10.prod.outlook.com (2603:10b6:8:1f8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 20:11:58 +0000
Received: from DM6PR10MB4300.namprd10.prod.outlook.com
 ([fe80::2b16:46d:bc55:874]) by DM6PR10MB4300.namprd10.prod.outlook.com
 ([fe80::2b16:46d:bc55:874%7]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 20:11:58 +0000
Message-ID: <ade18ca6-d0f2-4647-abfd-4d575ac1e8ce@oracle.com>
Date: Wed, 30 Oct 2024 16:11:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: nfs: avoid i_lock contention in nfs_clear_invalid_mapping
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
References: <20241018170335.41427-1-snitzer@kernel.org>
 <e25a451540d8eb63f35b82652e197b6e207d4317.camel@kernel.org>
 <ZxK73l2yAOcLe_jl@kernel.org> <ZxLVDC_C2CrWvXT7@kernel.org>
 <bedccb42-4e8a-4b9c-a0d4-982abb7a318e@oracle.com>
 <ZyKRDKeAd0m19pt_@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZyKRDKeAd0m19pt_@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:610:33::9) To DM6PR10MB4300.namprd10.prod.outlook.com
 (2603:10b6:5:221::8)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4300:EE_|DS0PR10MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdee528-5d58-4d30-2969-08dcf91f1be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emRsckcxLzl1ZWgydmJ0YUdEM3l6K2NGMWYySS8xS0dJMTcrZmh0TE5xMkZa?=
 =?utf-8?B?ZXM1Sjh2SjlMdU5DYkZoTGh1VXZqeEJHOXF2allsdXR1emZwdDZXYjBJOHdM?=
 =?utf-8?B?K1BwTGF6UjdBSXBLNkVMZ2p4bVJTdW0rVHR1WnhldzdvM2lNaTBDbURSRi9y?=
 =?utf-8?B?U00wMllMK256ZUh4OHVaaXZGYVYyRlJwOE1oRG9QSjdaa3g5Qnd2Y1NwRnpo?=
 =?utf-8?B?OGtDWGdDY2ZXM1NKd1NxU2ZGTmlhVHdBekx1VjNRY0Z4azlpa1VnNUhZdDJH?=
 =?utf-8?B?UncvbGNnU0RxN3pwYitBZTlZVk1hU3EyWGVVTEM5NHdLUFgzMHVXQU1IcjJh?=
 =?utf-8?B?bGsxbkVxRkFIUG5iUm9iSU55aThnMWlPZzBPV0ZyT1U4VmxSK0JGVmMxWFhI?=
 =?utf-8?B?NXo0Zm5ORzJpVUppeWd2T3N2UythMXF4ZjYwZlgrV2lBUW5UWDhZbm5YRUtL?=
 =?utf-8?B?OFBMM2o2V0dCRFB4RHJWZjR4dk1DQkMyTUZLWXd5N25Td004bmVaeVA4cDhX?=
 =?utf-8?B?MHcweC9RaVlhaFpyenhxTmdEd2d6UUdSQVZxMzJMUnA4dCtIeTlTK09XZ2tp?=
 =?utf-8?B?aVRFVW5EUzREeG1LbDlBbUwvN2hPbnY3T1JsUDFSbGJuaUFVZjFSM0x4SFla?=
 =?utf-8?B?VE9xZVNUNm0vWFd6ZjBIMmFMdkRzTkdwa295R0NoZUpoUWxZYjBCWHIrQSs1?=
 =?utf-8?B?dGpIc3JDaFNNOWs2Vy9Fd1hSTktncVpIWnlXeXhkUGt5T0JhSTBkN29lZDI0?=
 =?utf-8?B?UzN1bU82dU5YSVZ0ZExJUitZNjBFRG15Rk9peW5RaFdEbmxIMjlWTksvNVFI?=
 =?utf-8?B?TE1HRXdhUTFmZGh5TnhmWmpieXJiVEswejRVQldzVysxT2FLdDFwVkViSStQ?=
 =?utf-8?B?U0FtUXhCWU8rMmtOREFRK01lRkNaN24vdDRuTmJHSEFvN0UxQzRvbkVqaWlo?=
 =?utf-8?B?NVlvQ3ROSmc1T2ExKytHTXJmekkwVCtvUmg3MDRFN012YVFCV0lsekpGRVM5?=
 =?utf-8?B?b2ZBK2JoMzJSVkU2c3NSajV2UnUyL2RtODh1T0xPeFVVUmRMQzM5cVl5cmVr?=
 =?utf-8?B?VjNySEloR25TMnQ2SkM5MHl5dHJNQm42cE9VVW13aStYTEJUOEw0NjNpeDFG?=
 =?utf-8?B?N29mVjlrb0Y4ZWZHTC95bTZVRlpvd2FOT3I0TmhJSis3dTYwRUZnSjZvWWI1?=
 =?utf-8?B?aTFtQU82Rzc5cGtFdWtaSHBCd29VZEFqNGs4VlJja2dvNVExTEdiVWFFeEdu?=
 =?utf-8?B?RENZSkxOZjh4VXpvRWJ5VGE5NzQvV1paeU5tTDV0dFR1Y1FNcmJXRlh1d04r?=
 =?utf-8?B?Nkh0VEFERUZGSUNWT3JCc3hncWxxQmR0OUhIUEpxOWFRcUZyejU0bEJkaHB2?=
 =?utf-8?B?NFl2WkdkUTJscGRSejc5cjZVNW5mRWJTeXo4c0lQazNVY2xqdTlLM0VaWURK?=
 =?utf-8?B?N2RhTjBwNGh4b0NlTFo1OWxLVFJTeEVJYUZrNjZBaW83UXBFM2hhbDM2bDBB?=
 =?utf-8?B?TjhsK1dqMlZEaEMwUVlFVDNFLzZ0NGxBem5SQlZzOUtTRmRuNEtqbHpTemtr?=
 =?utf-8?B?TDVDRGdLUERSMC9qcmV0RXFyTzNiQmM1NmtqNFI4NHlROHFabnRnMmtkRlIz?=
 =?utf-8?B?T2hGYWRsMEkvOG8xVWJJYU9jRDVZVWw5cWRpaHg4ckZsMU51WDM5M3pMa2k0?=
 =?utf-8?B?R2d4S0NBZTdydjZYc3RuZXRnZ3hnVnpXRkc2a2xITVBtc0s3THEyakdYTTdS?=
 =?utf-8?Q?OVxXD3ZLoWhgxsivvFDMkqr81GgQVmVUUnTEqoR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4300.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVdwdUFwMnpyQ1NUNmgxemw5V0gxS0V0dTIrMmErKzBFWndEZGNBVjVwTHgw?=
 =?utf-8?B?cm01UDBYZEJFaitDN3g5SFhYaVVOR2krSkJXMFJtbE9DanlPMWFsMWdMclU1?=
 =?utf-8?B?akVhTmVHMjFzUU1GdjByR080cVc2Wkg4QWlXMU4yV2ZzbTJucFZaaW9NcDE5?=
 =?utf-8?B?Q1QwK1MxTzk0WlRCeXkvL2xnQXd1U05FWXJsb3BIejlsREJLUm93UUt6VWl2?=
 =?utf-8?B?anZPUzFUSjI5VWFwQ0VDRy8wMHl0OWJIbmZEaWtDK3FMRWhTN2YzemR6bWg2?=
 =?utf-8?B?Q0tLOVJBdUJBY2hLQTdxNDY0Y2xvV0djWXRxcVF5bFJLb1JpQVJoOHE4enF2?=
 =?utf-8?B?ajRTYWFrcGVPZVpLMklXRUpBclRiU25wS25pdlFGc05hUGM0Z2Y4cmU2dGdu?=
 =?utf-8?B?SnZ2NGZuWWwwMG9BaWZmZGpIQmtWMGtwZHRLdHNuZHVSWlA0VUp4aENkc3k2?=
 =?utf-8?B?UDRSdEV5NE5tOWY3QlBndUtEQ2xGRkRCN0dkS0JuOFBGU2N0MUpTYnNQNDg4?=
 =?utf-8?B?c0xaOW10MlByc1BhM2FRV0F2UjBiQnB4Z3RuSWExeDMvT0g2UTBpckU0eTRG?=
 =?utf-8?B?Q1FXOTZqTERrVzEvZ0syVjg2VFM4ZW1LUEZzRkJxZlFKM0V6NjVGNnFPYld0?=
 =?utf-8?B?eXJ5WURiUDY4Y3EyTjd6TWtBYlhvNEZtYmVaQUVDckN2NS9GdmJyMUJvei85?=
 =?utf-8?B?QlRDeWp4NngyNlEzSlBFOUtVOElSUzdiSnhWTmcxRE1HY0NDL3RDcWQrbURO?=
 =?utf-8?B?d3BlNkNwLzJVNUo4aFNmK3JseitKaFVlRGxoVk1xSWgrRDJ6eHRyU3phV3N1?=
 =?utf-8?B?dHdrMldCV2lUSDl0YXhVSTA2ZDU3WDc3aEk5cDZ1aDYrNllJM0ZSdVE1dHAy?=
 =?utf-8?B?TnV5Y05OZnZYQVBhdFJOVnJYaXJFQnNxM3A5V1JLaFMvbTNkOFdzUEszQ0Fa?=
 =?utf-8?B?MjNWQ041S0pLK0dLQ0llODJNaGFsUWZ5SCtGQ3Y3eUNiamFWNUtTdS80VmdJ?=
 =?utf-8?B?bWdTdXhYVWNuTGlZTVFxYmtQWEtwSTdLem0vKzBzcktXYThhMjMwM3hlS3ls?=
 =?utf-8?B?RkRhSlhyMlVTL3RtdXI1bnQxb2hHRldwajQxdUMrSVp4cjR1ZzQvcFZ5aXFu?=
 =?utf-8?B?UUNyakVwRThmbzBKbnVFcXdoTGJGMThtWVhFcHdZUElyMWRFU2owTm9FRXFi?=
 =?utf-8?B?ZDlMajRNa2E3TXFCV0E4aHZNQTVPQXJmK2hTVE1Cc21Qa0c2Nld6YTI1dXNX?=
 =?utf-8?B?ZU1WRCtvcUh6czdGZWNUR293eUd2M1lSQnM5WnUwV08ra0VmQWJjR2VaV3Q4?=
 =?utf-8?B?Wk80WS9jbU5wZk43Y1RidnhjMVpJa3NEN3p0bWZORXVZQlp1WjhjQS9SYlFJ?=
 =?utf-8?B?YU9ibitFay9FYUtGY3k4cGhNc29GRXBTVldJZlVFRDZibnZxVDlYb1JYRnJV?=
 =?utf-8?B?WkloTDM5dExocUQ0T2ZBeDAzblNmQTNqUGdYSTBjQThaS0lBVkJmQytkY1c2?=
 =?utf-8?B?aEZBUm9Jb3VkMzRpdFg5SUlWUDZEU04yN3JmbnhhL2cwNk8yRjhRZFVhVEpX?=
 =?utf-8?B?V2tyVGNNTk1EbThZQXBmZlJQU2xRSisvQngzWkRHaWVuNzY5TzgrWDZMVlJw?=
 =?utf-8?B?R3dlQi9LNWFmTGJlS3l4c0w0NnF1clZINmdRMnRpRmRQbEhBdWd4d1k4bG81?=
 =?utf-8?B?ay83azZVVUNsQklPYUMrZy9pNkhwWjMxc2pUQ0hhdUNQOHNXaGRYM2NMUlFU?=
 =?utf-8?B?RG4zSlNBSHFqRkVWcEtqczlZL3ZkWGlUS1lKMExzOTFGN1BsWm8wcHFXNmZj?=
 =?utf-8?B?OWZQSEZ6eVRGaXBXaG5SUWF3ejFNZHFOVThmb2VIRm5XVXMydUFvbnVxYkhv?=
 =?utf-8?B?TExhYkUrWW9ZYzBXQWV2aDIvQlJ3L29lcjhHZERNOU00dzMyU3h5a1R3aldw?=
 =?utf-8?B?SHRPc3ZwV0pWdVlVckhJTnJQUzUyS0hqQ0pBVTF0bG84TUIzcXM5RHZLazd1?=
 =?utf-8?B?YURHQ0FlTGdxWXZmNHlPbVhZcy9tL1RDTTgrTndBbThEdU9HQk1VamFZZ2dH?=
 =?utf-8?B?WXpOdWNTQXcwMDBFcFN5enNpVkdJcVJFTVhXbHplWHB3Q2ltejRGWlBiUU1G?=
 =?utf-8?B?ektOTjNqUWdZWnh6aWc4SHRpSXZ3NkhNYk13L1ZMQnMzTEJCWmxUUTc0WW05?=
 =?utf-8?B?ZW1JcFBvVjMwV08rRERjTVdJUnpZa09DMXZpNDBXZG9zb2Nqc2Z1OU9HaTBu?=
 =?utf-8?B?UXV4RTYzS0VEd2h0UmNlYUxkekJ3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VQYWhd2AFmMgOypxapyCFVoWkU/dqfC7k+MXtBgoNHnBpksLfiPjywQMIUL82zkFqWCPKfVHMJayxC5Zkl042GxN7n9DcADNwhcYpQ62cFVw8cAxh03/wHrYnlLXSRtaq4zv0gHtdUodMZRVpb0D9WeDCNHG6V9bVQnlrYAScTv0ogBV0Qbh4uCmJ/4UWIsIeDPmFTBMen5UnMzNOZNGBcjPj6gGqWCNSjYlcv2JiI+9jIWygxCul+YUWqpvcFF+42nxqaHgify60OIMw4qv+BZa/Mp7kaYZMVZd3cixdDmZTM+nfBFggMgzfsTndjya9nUWZuZTUJH564AOz/jzzi/ASxDVBDh1pavx4nlCX0fD0dQyqSAIiGtP0KPEEyd4yE1nLU/wDadHe4dPQsARGVHvm7o23iKiS3j034+G/xh5oRM3qp4OoSFJ+F/NPofR8Z0YehM8g3TOJ1S6dAlkzBhQN8vsFCBdcQouTUFoMKZil0DnTInU0y89INyJh/YPC+QjanGrgt7jY7EpwJE4SIytPFjsN7jegBeLiXXS53dkOZU3x2RBoLRNbQjQAIEqgZz8qhZlJzBE6q2sTN+VcD0Vq0CLa7DuEH+BWFLgoSs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdee528-5d58-4d30-2969-08dcf91f1be8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4300.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 20:11:58.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6NZ6KeFwbVj4yEhS/vj8DDsqCac8xg7cVmM45xST+QU8dVGIn91t5dF5lDTdlKh9chDWWRtWZMxZwnfu3F+TfYihI+5XFse2/FGNvymqpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_14,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300159
X-Proofpoint-GUID: N52dEG60mcqQ5bBM8c9jz4ekClXjUbyD
X-Proofpoint-ORIG-GUID: N52dEG60mcqQ5bBM8c9jz4ekClXjUbyD



On 10/30/24 4:03 PM, Mike Snitzer wrote:
> On Wed, Oct 30, 2024 at 03:51:44PM -0400, Anna Schumaker wrote:
>> Hi Mike,
>>
>> On 10/18/24 5:37 PM, Mike Snitzer wrote:
>>> On Fri, Oct 18, 2024 at 03:49:50PM -0400, Mike Snitzer wrote:
>>>> On Fri, Oct 18, 2024 at 03:39:13PM -0400, Jeff Layton wrote:
>>>>> On Fri, 2024-10-18 at 13:03 -0400, Mike Snitzer wrote:
>>>>>> Multi-threaded buffered reads to the same file exposed significant
>>>>>> inode spinlock contention in nfs_clear_invalid_mapping().
>>>>>>
>>>>>> Eliminate this spinlock contention by checking flags without locking,
>>>>>> instead using smp_rmb and smp_load_acquire accordingly, but then take
>>>>>> spinlock and double-check these inode flags.
>>>>>>
>>>>>> Also refactor nfs_set_cache_invalid() slightly to use
>>>>>> smp_store_release() to pair with nfs_clear_invalid_mapping()'s
>>>>>> smp_load_acquire().
>>>>>>
>>>>>> While this fix is beneficial for all multi-threaded buffered reads
>>>>>> issued by an NFS client, this issue was identified in the context of
>>>>>> surprisingly low LOCALIO performance with 4K multi-threaded buffered
>>>>>> read IO.  This fix dramatically speeds up LOCALIO performance:
>>>>>>
>>>>>> before: read: IOPS=1583k, BW=6182MiB/s (6482MB/s)(121GiB/20002msec)
>>>>>> after:  read: IOPS=3046k, BW=11.6GiB/s (12.5GB/s)(232GiB/20001msec)
>>>>>>
>>>>>> Fixes: 17dfeb911339 ("NFS: Fix races in nfs_revalidate_mapping")
>>>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>>>> ---
>>>>>>  fs/nfs/inode.c | 19 ++++++++++++++-----
>>>>>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>>>>>> index 542c7d97b235..130d7226b12a 100644
>>>>>> --- a/fs/nfs/inode.c
>>>>>> +++ b/fs/nfs/inode.c
>>>>>> @@ -205,12 +205,14 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
>>>>>>  		nfs_fscache_invalidate(inode, 0);
>>>>>>  	flags &= ~NFS_INO_REVAL_FORCED;
>>>>>>  
>>>>>> -	nfsi->cache_validity |= flags;
>>>>>> +	if (inode->i_mapping->nrpages == 0)
>>>>>> +		flags &= ~NFS_INO_INVALID_DATA;
>>>>>>  
>>>>>> -	if (inode->i_mapping->nrpages == 0) {
>>>>>> -		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
>>>>>> -		nfs_ooo_clear(nfsi);
>>>>>> -	} else if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
>>>>>> +	/* pairs with nfs_clear_invalid_mapping()'s smp_load_acquire() */
>>>>>> +	smp_store_release(&nfsi->cache_validity, flags);
>>>>>> +
>>>>>
>>
>> I'm having some issues with non-localio NFS after applying this patch:
>>
>> - cthon basic tests fail with NFS v3
>> - cthon general tests fail with NFS v4.1 and v4.2
>> - xfstests generic/080, generic/472, generic/615, and generic/633 fail with NFS v4.1 and v4.2
>> - xfstests generic/683, and generic/684 fail with NFS v4.2
>>
>> I think the problem is the call to smp_store_release(). It's overwriting nfsi->cache_validity
>> with the value of 'flags', losing anything set there but not in 'flags'. Could we instead do
>> something like:
>>    smp_store_release(&nfsi->cache_validity, nfsi->cache_validity | flags)
>> ?
>>
>> Anna
> 
> Hi,
> 
> v2 addressed this issue like Jeff suggested with:
> 
>>>>>
>>>>>     flags |= nfsi->cache_validity;
>>>>>     smp_store_release(&nfsi->cache_validity, flags);
>>>>
>>>> Ah good catch, sorry about that, will fix.
> 
> I think you must not be using v2?

Oops! It looks like `b4` grabbed v1 of the patch from the mailing list instead of v2.

> 
> https://lore.kernel.org/all/20241018211541.42705-1-snitzer@kernel.org/
> 
> Jeff also provided his Reviewed-by for v2.
> 
> If you are using v2 that'll be weird (because I'm not seeing any
> issues with xfstests, etc).

v2 does fix the issues I was seeing. Sorry about the noise!

Anna

> 
> Thanks,
> Mike


