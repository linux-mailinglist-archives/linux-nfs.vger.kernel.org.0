Return-Path: <linux-nfs+bounces-8557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB1A9F1823
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 22:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93B71886FA7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 21:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45A191484;
	Fri, 13 Dec 2024 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="APuOzaSe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="arO46Snd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2884039
	for <linux-nfs@vger.kernel.org>; Fri, 13 Dec 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126592; cv=fail; b=CW9D1AOuwQDxaBvLL6iksrXTipLGDt15lzsysr2S88N3zERW6Pdjv/mBJB6h2Y7JOg5UiJkgwetCrQtz7Hufs98XM7UGQXMI7L5FNAA5GkQlAaSbWHzsINXEXkweqKbtfN8TvCc5JZi5AEdifxRsufTqjoAMDagXfnmMhLmOM5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126592; c=relaxed/simple;
	bh=yDi2DNH7ppbXVHWkBg0zE2NoGp9Fq5uIcIJFaxS5Gx4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U5CbI8pZcEwSkFHfS7DdU2p6vntHFNF+NML/Y3DpIYtq6Rewpr33qIuCmdLbNAMiuSp0rA4dwrTsqHOsN065NV4BeS7J+JGv3Xja18KIv10E5dBrEVlsj4aU3heuoUE4X9gDnlk87nGbIawjxCH7gTGjoZPdeXxEazqyRvKO5CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=APuOzaSe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=arO46Snd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDKBoZU027175;
	Fri, 13 Dec 2024 21:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mJtvVJKQpXPofJYDhLZcfzNdCZljbekuCtofAO5PZKA=; b=
	APuOzaSe1Tr5C6ObZoZ5rF3AC5yPJwCDfnjM/wjOViNAM+9QSokrs4aFp9jFV1tp
	xhoHnv92BqkxOX8TMaNwTxB4pgTiknhueXKK6P/D5Pi+/9vYokm7hKf0m5gXUe0J
	dNYl05olJJ6ayEySXNxrNiaxscCGNWIjp9xmlPVCjJAo0zfjNF6Wd7HB1NO8Hz3+
	zNPscekN3XKCQnuMud9uqlG632gWJoaCY3tPYpsAkp+4BM06eOSGWPkY3Siyci+P
	QCTBhfJOoM9QDDm/UUGU7VFrqcxYn4ADL7zIcsgbstKvLfLT7Sxf7rd3Yep0IQFa
	5IQT/tkCgxjoSADJ3NUV2Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr6ce8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 21:49:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDKv29Q009411;
	Fri, 13 Dec 2024 21:49:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcyw25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 21:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOmf/Ryt63QESNNGPA4qjoIlT7KuPkQZfZbSRjFWBOybOb617Z6b9p8mHbZX+S+TLbXih1+56+2X37kC/8F0sNlvfLhUrmkO/Ax8RttPjvFNkMDLTixkl8pHCKxLXnlOe1lt4WXjxol++HGzV/krjx2lSIdXd4qujNGMHapKLWLL5jSCRKEa7S7N4gIbN3HO0LVKE/2cPpgudM7240eWHhWh/vIuYo6RI9P4Bjks0t7JKWrAF9Ssnwuhv/y8TzxtVOpDCLbVBhudFkpfRSHmMpTXc3fAWVXYabRydS+4J55DP1J2nn9dswTS63qCFn4rkQ3N35otCejWH9WqnqeD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJtvVJKQpXPofJYDhLZcfzNdCZljbekuCtofAO5PZKA=;
 b=xTxslUz12KF0GwB8vw4r9xY4pM2rKfdqc/vwu3oLah2DtHJYYP6babgnFq/cf1heeVlnCb8+AnfEHxLIXc7355mEmCzlpkvBzjqyRPW1CUs2AOxnMJ93qRiBX+aep/SvBdhTEb0EeWnvqHrJsnucC86AaxqtWiJIkhiJRjaKKobyaN32ThHzS9BTWzP1oqqInNE8OPgUoRe53VXoq+2J+KM+t8F/BYxfMA4lkaNypYkNmthEgyzVw0pZTItCJRZRIqJFY3ajwBu6U5OnhsJp+EeDShv50EUeHrr7WgFd7yhjAjvtxcwLFayWjuZQg3mB3iEOdslrBQjGZ1IfSpwZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJtvVJKQpXPofJYDhLZcfzNdCZljbekuCtofAO5PZKA=;
 b=arO46SndMgEEYYjzqubrJ9uaER6U+IPv/Wr6/v8CLN7uJUI6OKUpo1JK47YlLVQdt53wEbduKGiU5JLu1xX8e1yPAKDqH4GjZQbXRRZsT6CXe9y2/0Hb7pLV6NiMQp1Wqk7PrDbeSixt3KMRN4uM6o2qppo8QfLTJb2TGybbIuE=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DM3PR10MB7911.namprd10.prod.outlook.com (2603:10b6:0:1e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 21:49:45 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 21:49:44 +0000
Message-ID: <3da64b87-1a22-468d-aa6c-ab28b0ea5e10@oracle.com>
Date: Fri, 13 Dec 2024 21:49:41 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] pynfs: rpc.py: use OSError.errno to fix a not
 subscriptable exception
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
References: <20241128123642.1636-1-chenhx.fnst@fujitsu.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20241128123642.1636-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0361.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::6) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DM3PR10MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4cd771-b51f-4152-cef9-08dd1bc00e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzJMd2MwblBHRTcyenllYlNrQlRFQ0ViK3lZa3JOTSsxWjlZVEoweVE2Njhq?=
 =?utf-8?B?UFQ5TDNTTWNGTDJxSVNuQ3ZYNkdTakg2ZWZTbXgvME5wLzRQWUVkR2I4MTg1?=
 =?utf-8?B?RXdCRUY5ZVpjQzdaVGNqenpEeWIxMWI3eUZ1K3p6ZENwU2Q1VWhyWE5id3V0?=
 =?utf-8?B?VWx6aHVtaWFORTM2MDd6b1JMVSszandjZVBYWVVhc3krMW5wRzZwSkZKOEdJ?=
 =?utf-8?B?SnVSSTgzemZhUiszR2ZubnA4emhlYXVhb2srNC9UdGN6aDMxTDJKZGVzU2Js?=
 =?utf-8?B?Z1JRd1d0ZnhLRDVCU2E5WjZJSFlGSDZqODVFWlNxODdRUlIyTnh6dkM4TStD?=
 =?utf-8?B?MmtTTzdUdVhNRHo5QlZlZ1l2Q0REWVZwYlVqTnBXT1lQd1FSTDFYKzN0bVpi?=
 =?utf-8?B?aVVmWFdZbkpKaDJla2ZUelRGOTZCaXFsNVFxZkRzZkZ1c1Y5R3FaUjhtdHU1?=
 =?utf-8?B?UTJsYlZwWGNOcHUxemRGM0laaWh5djM2dnBGeElBQzBGUDhZeWxCQ0RGSVhv?=
 =?utf-8?B?T2pBZGtHT085cWRUQ045ZDlVRzI3dkVEdG43d1dWc1dYYmRuUTdxVjQyNzRT?=
 =?utf-8?B?K2NtY3hQRGJqL0JCRnlTK0Q5YkRPZTBleEZMMTVtc0lWK3ZhTUU0cElHa3Jr?=
 =?utf-8?B?RkxRbXVISGpSdjFpSFJuZlRJOVRoeHArMnVEQTRFRlk3RXFLR2Yybm5HMEJ6?=
 =?utf-8?B?d05Ub3RkNnFHRUlCSWd1Yksxa2dxRXJMandnYlF3d2tyV0xGWkZmTzJXQllp?=
 =?utf-8?B?ait2MGFNRTI5dFB6N0NzdmRxSG5pSTZ0V0VCZ2FyZTFwTFJTblltL2FyWkph?=
 =?utf-8?B?dTZYU0ZwNDJlWVVxNGp6M29qa3BBRFJKR2MyN3pKSzRMdUhEK1lyL084Zkkw?=
 =?utf-8?B?dnpmMHB3S2pDRWFVSXVLczdSYlhaOEIzOEtJNnhRb0pxQnptT0Q3L09FaUEr?=
 =?utf-8?B?ZjRQbHZMRitWcExoS2FRZ2MyQThFbUJxcFI5K3BPdS9GcG1HazhSMXI5Wjhx?=
 =?utf-8?B?TWFRMUw2Tllpemk0cURJVjA5QzVnYmdNMjExeGVpanhUdnYvR0RFVUxTc093?=
 =?utf-8?B?UWcwQUF3WTBjZU5FY3NtVjBoMGQxRHE4MkM2YnJoUzM3YVh2ODRvQW4ra2lY?=
 =?utf-8?B?cXJzR1JnMVl1eWYvMTdNVDZEeXdnSmg4YnR0b3VUU29JWklhamErejJFb0VK?=
 =?utf-8?B?cW9qY0xyVzZ1RVNaT1hkbXBPd0JYbENvQklOM0M2SDNHOWVqUEpJKzhlaDdF?=
 =?utf-8?B?emFSZFFJM2hqYjB2MWRXSEEvTy9OWkZQeDY0eVI4VUtqbVVEU3NaOU45cTd2?=
 =?utf-8?B?MnRqQ3FTUklXdGxLWGVOZ1p6WE5pZkdHODFRTmc3Sy9rK3l4czJTcHFmYWI3?=
 =?utf-8?B?Y0JqMitjT0hWOWlDNUVEMTN0YTJ6ZnR5Y1htN3F5OW9VdmM2cUNUZVYrcElj?=
 =?utf-8?B?S1MvVHYxNEtxMmdPTGpSMzNPR1kyek5IRzFaMFFqS0NDMndYNm10b1JwL2lK?=
 =?utf-8?B?NFV0T0ZLTmtvRW9TcmJVUWZGVGZGUk9uQ2lDTlNBRHR4Mjh6dG5PRmxEako2?=
 =?utf-8?B?VC9VYXNONnFoS0ZpTSsxcnpGTDlJWXdIcVVDOXhiZlVjL013UDlnTWN1Rlhs?=
 =?utf-8?B?UlA0WUNuZTd4T1lSNGllSzc4Vm9QNmdTQ0x4a25KbEpEdklhMmkxcmxBb2xI?=
 =?utf-8?B?cWcwWjhRanAvSUpHOTk3VUhsVEpUM2ZiQ0IySHF2cWUzL1g3WGxNWUY1bUdF?=
 =?utf-8?Q?qsaPNYIj5PPSodPd4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRIVEtkekY5dUZHeVA2ZHIxbElnbVd2c0lLYjZNZCtMazUyWXM0cDJJWStt?=
 =?utf-8?B?T1k2bmdESCt0Z2JLcVBGcU9JUXRaSEFYeEVkR3NvYXVpTjJFNkQzcHRpMjlH?=
 =?utf-8?B?cUR3RnNnVVc0VXh1elY1M1hRazNTMkl1RlBFVTdjam9hWng3ZTNsd3B5cWo5?=
 =?utf-8?B?enNPajRFaVhKMUVudVAvRjYzTWJoMXdib09BVGt6RHBkTkphQ09LcHVsY21a?=
 =?utf-8?B?MCtERHQyZ0o0NmF3b1JLV0ovQ3M5ZG1VTEc4a0crM01IL2ZyODFQZk1jbVgr?=
 =?utf-8?B?STh6b2M1ajRpSUxCcy8rMlhqTTNCRkdoMExOOEdaejBCQ0VZcjFZeHhzeTZq?=
 =?utf-8?B?aFJTcVAxVkRWS050VTJTZmNucFZ1MjFDa2JEeEdFV1N3Q3prZjU4c0RLVmg5?=
 =?utf-8?B?Z1hEUVJ5VEF0ODVMcitoSUZIbFk3Y3ovNXZUT3pWS0lDTWVqWkptZ0xVT01M?=
 =?utf-8?B?bzFaUjZIMFFzTFM1QzdoS21xN0s1SC92WUFqK3B4WFpwaitxZUVaRXJzNU1m?=
 =?utf-8?B?UTN1RFFDaXp3K004L2RKRE1zSmJCNUlUY2N4V1BtYnhvcGs4eTdZWEhISWsv?=
 =?utf-8?B?SWVub04yM2FjVGxKNEk1MmgvWlJIaGMzNTE1UE5TaUtBVXJ2Zkh6TUpBUU1s?=
 =?utf-8?B?eWR1SWJ6SjMrV0lzd0ltSlIydHFzdGVHTTVCVzltWFhaN3BYRnpncDRTcm02?=
 =?utf-8?B?WTYvWHV0d1p3cGpraVQvNHNrL3lwZDNOS1VmeGw1dzk2dFJKT09JeGxadzlv?=
 =?utf-8?B?SEVqa2J1UVhkZWpRNWZVTyt5VFZQdnJYdUlFUklFZXAvVk83a1J2WFRveWVI?=
 =?utf-8?B?SzNqenV5a1p0cm92b01qcWFBc1c0OXErTkQwUHZWL3A0WkpOcE0yeThzdGpx?=
 =?utf-8?B?ZHFlUk9iaFJyYVYyZWJ1RjF0QkdGK3RZbmhnSUxCNE9VTzQ2RFMvWC8vbkFi?=
 =?utf-8?B?amk5VTNBYzJ5TGRacUZwcGpHZDJxSVF2dVJwQkZpeGNWWGkydGZHTnNjcXMr?=
 =?utf-8?B?Q2FzdUZhbyt6amU2NWFSNFZmMVZKN29yTzF6MmxId3Vpamd1REdCRVlONUE4?=
 =?utf-8?B?NjRBdGdIQ0U0ME5aLzFPZnFDcUx4SktyayttZEh3VUpXNlpFN0hKS3prT1Zy?=
 =?utf-8?B?cW1XQXZ0UjF3dmp0eEd0RlhQSVhMWGFqVFJQSUdiNFhnc0xBUWlmazlmTmtm?=
 =?utf-8?B?c1NRNVF5OGlyYXdEd3owSmxRNkx1TUZYMHR5YXc1SUx1RkYxSTdOQ2ttTEtR?=
 =?utf-8?B?SUtzSGo2N2lhMXEzck1lRklsOE44RGZDQThYaEJIWXJEUDdQam9oaFlrYnRY?=
 =?utf-8?B?UnFDWnRKbFc1VTRkZTgzRGkxU0V3RGhTcTBNR0FlTlVQOWkxRjJvRkQ3VVNM?=
 =?utf-8?B?QUdxdmZCRGZydzNtdjNYNzNiOTl1elRoclVBL1BFUW5jeWtReGxSdEN0SDVl?=
 =?utf-8?B?TXY5VnFqWndFYjdUL3U3QlZWaVp3a1lHQXZ5K1dkR0dlTTIzQmxKYm5Ra2dp?=
 =?utf-8?B?ZkZhaWd3ZWdMeFJENmg0Qm5MeWRUcnJhQ1Vhc2sxamUzUjlaOFlCaEpIQXlz?=
 =?utf-8?B?M3RzdUlKSWhVZGxYcXFiQWthUEJFUzY5RUdaNlZLUnBVaC94eC9qVjhwV0pz?=
 =?utf-8?B?c3VZT25yMC90VzlDWFNYMVE5TFBzSGJweUUwTkdRZ1RBdDlraTV5aFdSQ1FL?=
 =?utf-8?B?RWc3Q1lSellvN1JUSktZVVI5SFlSNGNYc1lOZjBLVGtEdVVVRUFsK0krTFla?=
 =?utf-8?B?a1VEY2U0aDhRYWVOOFM0UVNaTnl3cDRyaG0rZldwN3hWWXREM0s4SEtaV1JT?=
 =?utf-8?B?MzFiYURyUlFqSWNuMVBVYzNBRUJZaXM4V2lPZHp1cUw4RkRTTWV5aitwNElX?=
 =?utf-8?B?U2lZVFJjc1Z1OENBTUJsbW4wUmZCdW9kdGQ4eWtIQWd1NnZMRS8wK2xrWUNw?=
 =?utf-8?B?Uld3aWo2TEFlWEZIV0ZBSG83aWlaSjJVMUo0bEZ0UWFuV0toR0hIL1E2SlVD?=
 =?utf-8?B?U1BtUmJsMVVPTkVnYmx1cE1uZnE0V2JlYzFiM3B0ZlhLT210Zk1pZDFCUnFD?=
 =?utf-8?B?L01IS1NZTHhhVlhjY2ZmY2htRjJzRHdNalRnVmlxTUVDMDd0WHFOTkIvWnVH?=
 =?utf-8?B?TEtwR05vTUFSeU5MM0laVWNyNWpDM1JVb20xS1pKUDA4dzF5UDFFRGd4cU8x?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x+/qqU1PgSlT+DQKBO0li9LN2b6/UsMwO6QchvqBK++LIPUwQUBFraswpeYh+4DBUwPzLpdsL6LTxnFePYaS2n6O9kWcuf/3pBryKvKdsRGpS0FxGVgH9w2vBQX/wghHraFoq4gR7iAm4faH+6P0zSeWWPjb/67PG02PQhSOeN+ZEsc4XtAoUv5zz5n6u4Dv8LAg+Ha3J57O7gWPHbpZ0s2usKalHj2nFMHpD4Ll30VwSYxpLFxaRhbZ3zUSY8PMCQpHXXrjErwL5yWABhQIPHqozjv4OoQkOUwhKKK2oKr5W8CnUTgkMcGFJhSYn+2luNC4KWfKvLrJB8mTBw4EAPDa2/t8BzmTM5wxmDcYE+1KJ9jFCdoiQA1KvyUD1zm+ERsRE7cy9bRUPWhT90553Kelq0JxcyA6/oQ0B+4t4wcUdYkm9xg6+nAssRb+AGoN59tJyBqpMZZ26LPOlINP4YtmEwVmF1aKzKY5CzkPMbceWs176WqwY4j0eO6iqP7x3iEQn+JNOZI61nc1mBcBiL7MRf3AIisXR7kciyDCa7l/ZROFZl1yGlIQIr//A/mEYH69eeuMKpqY1na4i1PPHxZlWmV/hrqbRSJS7JJ+iko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4cd771-b51f-4152-cef9-08dd1bc00e51
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 21:49:44.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWdFLrn/r1NvFZv8OjT2/vcnLy2/2+MZ4gT7YKcDZZgMqqxAFWBArPhA5o6Y+8Ff8ysnMMSnjxvrVazw92A/vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130154
X-Proofpoint-GUID: vtnxPAX-U-hTq2FJMUyUNvrROovdBvoa
X-Proofpoint-ORIG-GUID: vtnxPAX-U-hTq2FJMUyUNvrROovdBvoa

On 28/11/2024 12:36 pm, Chen Hanxiao wrote:
> In python3, socket.error is a deprecated alias of OSError
> https://docs.python.org/3/library/socket.html#socket.error
> 
> Also, use socket.error[0] will raise:
> TypeError: 'OSError' object is not subscriptable
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>

Applied.

Thank you very much.

best wishes,
calum.


> ---
>   nfs4.0/lib/rpc/rpc.py | 4 ++--
>   rpc/rpc.py            | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
> index 24a7fc7..243ef9e 100644
> --- a/nfs4.0/lib/rpc/rpc.py
> +++ b/nfs4.0/lib/rpc/rpc.py
> @@ -226,8 +226,8 @@ class RPCClient(object):
>               try:
>                   sock.bind(('', port))
>                   return
> -            except socket.error as why:
> -                if why[0] == errno.EADDRINUSE:
> +            except OSError as why:
> +                if why.errno == errno.EADDRINUSE:
>                       port += 1
>                   else:
>                       print("Could not use low port")
> diff --git a/rpc/rpc.py b/rpc/rpc.py
> index 1fe285a..124e97a 100644
> --- a/rpc/rpc.py
> +++ b/rpc/rpc.py
> @@ -845,8 +845,8 @@ class ConnectionHandler(object):
>               try:
>                   s.bind(('', using))
>                   return
> -            except socket.error as why:
> -                if why[0] == errno.EADDRINUSE:
> +            except OSError as why:
> +                if why.errno == errno.EADDRINUSE:
>                       using += 1
>                       if port < 1024 <= using:
>                           # If we ask for a secure port, make sure we don't



