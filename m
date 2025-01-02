Return-Path: <linux-nfs+bounces-8882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BDA9FFFFC
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 21:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79033A3008
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 20:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9DA1B3937;
	Thu,  2 Jan 2025 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GmLmj80i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fl7xX6WK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A533D96A
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849699; cv=fail; b=uxG4JkEoQXBobWiDf/WIdOy9KN7u7GyXnosIyCB97uyfUV9VAuRRPoA0UCLUmHh7hfyhIJRWlc5Xf8gc+dsW2UMOQSwNOxpSOuF/kVNv9TIWJmQ8dDbGY25Ss0wKVK/VHd9TjvdZvwR5Xw2gJCgyidDLVGbsr9/GuVSA9Z2v0aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849699; c=relaxed/simple;
	bh=D7A8kbuarcCBtIekeDt+CaKUaHE9gRErdj+9GbzWDYo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h0t+ZatoMW7TBQxidw3lrM+BzdVrCoIZ0TlD+NJ7P+9X4P/XrcdhL3u8czm0QCMTQAQ2XTRVTL9Y+kPA1nkJJplJFs0I3pK5dAfaPlJkApBHwVhJxHRl89DKs47t/5qjda/oXegQ9RStMQ8oMgsEewhTrWhOtjvMTA9yAS8TxQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GmLmj80i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fl7xX6WK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502JXiZW014002;
	Thu, 2 Jan 2025 20:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XWeShYInx6xr+AUaQG7uDJs/R5wNjud51b+pky1dcFM=; b=
	GmLmj80izZ07kusw+bRGbi3yqoBKVN8XY5xBlj+XivuTlw7zqMU8zurU/ax7k5B+
	GGxMU3ALpojH6T5Mi/hm9AGOCqLFHfq/GnsC0fAbno8ByMbePeriYtMd2eC5Wfar
	uotcEeuhPyFtVymieiRQ/bi7FqK2wJ2VCr3QM+gksiiHXCxlVcnbdaZ4NmQUZz8K
	yyRM3xiuEyaHEiuWAIa+D8jE2xoHxw41oeXSK6F107giV2puDG/7EOPe/tsZYUnU
	7fdAs2NPHXx1hKkITADh8FJciEMCarU+m0behbWmdcfrTjR5qz99nRwdYMlsu3HI
	WyjQYJMI5ZD6tqQIkyhCow==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t8xs74vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 20:28:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502JL1SR008495;
	Thu, 2 Jan 2025 20:28:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s98qfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 20:28:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxGOVuFAvMtCkN3MeH/39VBcUTMcPyVdppE9QIFLd2cJrOWIe00w7/LXPgR2dJ90wOPTxQ1BRVxXvkc1whc9LfHL2JGxrRwbiIdUB3nS7zu/GkXmXWgpz+cbvVmfXQeajtQBlQlV1Kt08/TfXK/FOQr1GUGiglLaiybNZPpYBuivfZsTIpDiasoX0LjEoScRjT/gC800ABYuTv8tQz3VnFAElWtO5VjrEUOQkmvtVcQ5VYvuYNcndhsF2YtR0sYSbi53zk/QnjXc7MThlHRfSWVurWrkLWuvUHgwRYr5/pv3FvtCP+0w6KXGfBovgRaCSsh0FmF6oQg42OMKwOmReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWeShYInx6xr+AUaQG7uDJs/R5wNjud51b+pky1dcFM=;
 b=Agisuy8WAuxCRY2TcgVarAGXOm5cuXAIlTt2UsUVOj5CUbbgDn5RfavxEuIq3wyCqt5/oIOAIcP4YP3tLh8an7dCckP83M5gVpSHUwhwrydqNL0tVyarsajfH7QCxQaTZEJyq2Uj0nKjA+gxllauQNE4zEiGY4XQzkeJ86cTtqsMfG1BcnXBG2K7WJtXhT4uyQGwIlh7kBxq73bW9ga/R16xasy0ZvxCVIk7Vve2HB1hQRxOGR8KhmN0ylDI3zxu85EX+O6Gm7lUks5z8RbVZ3gajIjmTZ2GL716QfTD+063ySGB7oTeY4ooflae+7npziTKSjiQL2Iz9TiUAasK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWeShYInx6xr+AUaQG7uDJs/R5wNjud51b+pky1dcFM=;
 b=fl7xX6WKWpo1pX4pjIW3lkqLtrCi4b7IOpoygeRqB/1ghXQOBVmKxsrWUMAk4z596IuA7Sf/wscka41BraS54AhKNW3/sMvdWk2CDR4aDe7ekSn22Est8Zf+UFnbAlWnIdqL4zWJHTYyRA5B0n45K+HQoJk/uYmIGUiQfMoNRk4=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 20:27:43 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%7]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 20:27:43 +0000
Message-ID: <f005d232-6855-4264-b053-785dd69f6542@oracle.com>
Date: Thu, 2 Jan 2025 20:27:40 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs] CSESS22: increase the limit above latest knfsd
 limit
To: Jeff Layton <jlayton@kernel.org>
References: <20241220-master-v1-1-4627ad33175b@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20241220-master-v1-1-4627ad33175b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::15) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CO6PR10MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: 603a6f4c-218b-4c15-d171-08dd2b6be95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0ErRU9IMmY2bG91anRmR1JIQUZmVUFvSEh0NC90RWNkOXlSV3hURmVSQ200?=
 =?utf-8?B?ckxSVjhlUitjejhsOWFWbjgzQWppVkpKNW5ab0RhUHkwQnU3STh0eFpJWFVy?=
 =?utf-8?B?RVVJMjRtVWp3RzErWjBUK2NwbjdqOUp2N0I5am84WHppeUFFYkxCS1hxS1VR?=
 =?utf-8?B?eDFuMEtYQWRGdmlrWFVSa1F0SVpVS3JESHlZc0JyZnFIWWc1ckJOay9CMk9T?=
 =?utf-8?B?RDEvVWxNUmJhbXdmY3NlS1Rvc2dFUnA0ZnV3d21vM0J2UjQ3R0JHd3lpVXo2?=
 =?utf-8?B?eDRQQjE2b1BVbWIvUGtxeStxSmNFcEtIUmFFek9qMmliYmM4YzhhWWMwQ2d5?=
 =?utf-8?B?QkVrZVlEQVcrTk85cUw1M3ROVDBySzdBSWVPTkpST09pem91ZTBrRUNZSC9O?=
 =?utf-8?B?bXQ1ZkRvalZIK2JDK2FrZkM2NGZWQmZuV3lKdG12R3NUZFN3bFdjckNZbTNt?=
 =?utf-8?B?ZXZTVFZDaVdMcTJ1Tmh4czJOekRZZ0JIYzZwa3BNZm91R2ZWWENQcmR4cGJV?=
 =?utf-8?B?KzRBYnhaWmlzRE01OUFPb2MvUlBOYkJnZ1Q4Nkg4Y3FhdHd2SzhlZjVmZklH?=
 =?utf-8?B?WDZtdE1STUxSOGo2RjFnV1lESmJJcElTUFl4MlVpMWNia0hha2lhV1djMEFw?=
 =?utf-8?B?ZXF6dFNvWWZIRlBvZUhlOENsaDlPOUo0V0VxdjNHbERVRG5QeVJkcDdKVWpm?=
 =?utf-8?B?azRkVGJrZ28zdVRmVVZkdFErckFqeGt0cGFvdHR2aFpwYlVZUUZkUjNBWkJh?=
 =?utf-8?B?b1JNOE1UU1lja3BrT1BLdnprYW1Kb05XNjRGbmFvSExaZkhiRUx5d3orYi9Y?=
 =?utf-8?B?ZnZ1NVZ2ckNWRjIyenNVc0paczdSYTg3R2V1YTJvU3hoZCtxcjIvQVZiT2Mz?=
 =?utf-8?B?M3JvblhxVEF6UEQ2d3IwcHNpUmZ5NUVlUnlmbWM4dGRNeFlSaEhOaDRyUTkx?=
 =?utf-8?B?dWcxeFg2TFhQL0VVanpydU96Q2EwdlBwRGdadnQ0Q044WUNYV0oyS1RVYzMy?=
 =?utf-8?B?U091UTRYU0V4YWpTbUJqRzR4dnIrTmxyZFUxWUtkY3E4akFXSitEcW5OTzc0?=
 =?utf-8?B?ajJNa21JY2VwbjBIWmNuRVVQd3YydTkwTjRTNHAzSnc3enhRcEtPZnBLa1dm?=
 =?utf-8?B?SmlYanplWklEcVlPM0FwRFh2YXpGZHcvN1p3MU9vRVJPUHNLUmhNNEVwSC9Q?=
 =?utf-8?B?MElEMlVXWVhSMlVrTXVzeVJkVDg2NGtsZ0Uwa2pZM21QNjMyMGRIdHo4aWM2?=
 =?utf-8?B?bEVHZ25kSDZLeUNWdS81aEFNQ0RUcURVUys3LzFpSlpQMllFL2JEMk9BZ25z?=
 =?utf-8?B?bVNmUmthMklQclZ2NWg0L3htWHRTdDB3YVhaNThpUDR3bW92eUMwVWx3WWVk?=
 =?utf-8?B?b2lMZjhBc0dwUCsvMjVxQ3VzTytsOGM0bmhJdU9vYWhoWEkvZnErTWVXZ0U1?=
 =?utf-8?B?Ty9WdXpnT1Q0UVFPbXZSSmZFTVU5NTlVWERQZEtYaEt4SndmSHlGalN1amYv?=
 =?utf-8?B?NFpjSEFNUXJHc2lSakVPU3JFM2ZvRmdxZlU3V0hVSmpTcE4zUklta1A0cXhD?=
 =?utf-8?B?YW0zTWNIeGVBQTM1Q2k0K2xtNTVIeTh4VXFGczd2bkNuOWpnMitCVmcvUXJl?=
 =?utf-8?B?UHpSck1kTzNFMWN1amdjejdtZzh5Rm8ybWpOb3JlOWlDMW5ta3FVRVF5T2xq?=
 =?utf-8?B?elhveUM5RVAxTzhmS2lGbnU3cEFSTFNqQXdHcDhxeHVqWVk0cFUwaXEvV0R1?=
 =?utf-8?B?c2J5UWdDbnVjbWdScFRxTmltT2lsMktqR3JHOEdLbXh2NlZITTQ0M3NXQjdz?=
 =?utf-8?B?Y1huR1ZtRTZCK1k4OWlCVEd6ZUNGbkZEN25NNnVQd1hIY0EwSDZSQU84bnFM?=
 =?utf-8?Q?N7pdzA66pF29A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDhuMVZENVlEbm9RellDdldlckp6TUVBbVpiN0R1d3dDbXQ4YWNlZ1Y1VDVT?=
 =?utf-8?B?TVdTcnc3Z1RBWE9mSUFnL0JjeERrSGcxTXVTZkFmY3hJSTIvQUs2aXZlc2dC?=
 =?utf-8?B?akNmYlowU3VZbnBFY3gwYzF1cmMxVHhMWXNiOGVTZTNxaUl3VWV5dkZiU0or?=
 =?utf-8?B?WUFMaHdRUmh3dEs5VXdjMVExamJWSkl6K01aQ083MEZ6NzdIMUVhUFBvK3lx?=
 =?utf-8?B?QTlPN0hCUCtVb3REVSt6U1ppYmw3czNOVGVteUNqR2VNVmJTejFOOStSc1Zy?=
 =?utf-8?B?NUFYWkxXV01KNFlOMFF3VU9EaXU1cHh6RGpzMmpvS3BMUU1CT3M4Y1BubHVK?=
 =?utf-8?B?RnR1UTgzcUVFdFY2WU1CQTVuWGtjdjZGTWkzUjJDMG00dnhpdDR3eXBnZnBW?=
 =?utf-8?B?dWNxMlhWOS8wdTFLcXRHcUdpeGlGRE01czZXdjlSclNGRTdUS3hYbEFvMzhz?=
 =?utf-8?B?R2ErTDh0cEM4RHM1MGJkU3dKOThzZGJUSmxGamVjTHZnNURjYWt0VURwY3Yz?=
 =?utf-8?B?RmsvSGNXS3BRUzk0WEtmM1ZPbkJpeit1aG54U21rcE9KbWc4NUk5WlE3c1dJ?=
 =?utf-8?B?dlVNbWZHS3NUbFJKbDQ1NFlsak1Td2FUNWdmM1pLYzE2QnFZcENoRXRyZG9X?=
 =?utf-8?B?RVJCRE1yZ1J5ZURhVWZIa0pZQVI1YzQ1K1RKd0IzVytEMVhNZmVNeWpJbHJx?=
 =?utf-8?B?cEp6SkRCSThFYUtlZHpnS0hnTFFOaG8veUdsaVZFKy8zMUMyU0RkV2J2N2FJ?=
 =?utf-8?B?U0htSms0dE9UVVJVZ1JBM2tXTXJyTCtOUXR3aDlrVHU5REYwQTk1ZmhDSGsy?=
 =?utf-8?B?M0pleStrR0JiN3lxMFpLaTUyZGYyK042Y2hSUmhGMmZDcTdmRHgyZG03Vlhi?=
 =?utf-8?B?OXhpRlV0MzJqbWxkYUUzNUZ4NXNnOWtQRWd6b09kV1FkNnY1MUlrWXQ3MGhB?=
 =?utf-8?B?VWNySmRPSitTOHJ4RmUvTW1yZW9rSlpFZ3hoSTBaWDY1YmlBYXdYTTNjV3hp?=
 =?utf-8?B?TkE4RjVmekpPb1VXSXArNG94eUtxYUJuK1FRNmNCT05WaTIvY2xJbjJNbVZi?=
 =?utf-8?B?MnlRQTdqWFgvRTd1c3lNT3dzUkw5NnJiSElnSzJDVHRqSDUxRlhaWkNqNlZX?=
 =?utf-8?B?VXkrZzVScFJqN01mN0Z5c2hxaFFmUTBJMncwMy9EYlcvaWdYcVlYY0toT1d3?=
 =?utf-8?B?S3hXNkJpbnJYc3dXcExTelpkNkFuKzBXb3d2VDhjakhHT214bEpqOFZ1MmY1?=
 =?utf-8?B?cmNyNkJBRDdpb2I4OFhQZk14b25nM2trcElJdU4ra1RjekxubEN6NzVDSURX?=
 =?utf-8?B?bGFUWWZ6dXFSTlBraUMzUXpuZVkybFhrQlljSGdMU1hJZmJ0aENXZWk2Y2tD?=
 =?utf-8?B?NlYraXRlVFFaVnNNNkozenA2cWdKZi82NEFkK1BzNlZWV1gvVnV5WnkzWjRY?=
 =?utf-8?B?V3hCU284SVdQQTlrVGhvdXBrSDI2R2s5UHlMQTNBUitQbXpaTkUwQkgvcVBS?=
 =?utf-8?B?RjdJV0JoOXhhcnpzYnFsVnJtNytQSVRlZUdkN1NMd0QvbmpVRUlHQmpnSFlp?=
 =?utf-8?B?Z25mL2JoRmtvdlpKYWk3VzdWMlV5aDZWNVNWMy8rcDUrNEI2ZC9UTXJBbWww?=
 =?utf-8?B?U2pSWjJrS0lPQTU5TmUwQmYydTloZEgrSG03LzY3T25VNU8zaks2a1R6c05Q?=
 =?utf-8?B?NUNvN29VK0QveDRNRVBvbzRxTXgzLzNpdWNaT3BVOFRNYUt4V01meG9KQXJy?=
 =?utf-8?B?QlozODU1WGJETkJSbkVrMW1qelB5UlN0dXVoS24rRit3Rkp3M1N4b01ZT2dV?=
 =?utf-8?B?NnlJVVY2cEt5SXlBajkxQkREdHpGNGtrMEFnMElwdjk4bUNmSnhIa0tYWmJ6?=
 =?utf-8?B?SDFuMjZhKzQzcU16V0cyNjQ5Y0RhU1VBOGpMRFYxMDlGVkh4czI0blpTTnBs?=
 =?utf-8?B?UC9Bc1g1bnMvTWNCWUozeit3eWNQRWtiOXVQQjd3SWZ5cVNKQng5MzRrUVFm?=
 =?utf-8?B?ZEw5alZuMFIyeTRmYnE3TGhRUVhnWmJCSjJock5XNERvNm5WZng5YVh1MGJR?=
 =?utf-8?B?Q2VmNVgyZksrajJ3YzdyR0J0aDlhbUhTcFc5YTMrL2JlLzV3R1ZGL09FQzVW?=
 =?utf-8?B?a25Sa0tCYUliTUVlMDFtZlJ3eUZORkJid1dnbmIyYS9WdWo4YkVwN2pBc0ZX?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rs7dukNj2NPlbGZCddcD1KfeHI9znwWKSC6S3SF6zCBFU7QenIfaWejpkxoLKEKuOVoPC1jCuwXZACZOycXR00K4qmsED110UABH040S6mvFCJqj7q6H7qXz4xtVpbgnKgpf7KGLNBvGjJOBq2ixyfwsXvJwnMxlrRga9PvR4lDfS6E/xrR2Ax3WQycDXdRd2X8ka6lHcpVacrpYLQxRARh5SjCBYwrFaFhu3HQpBxiAM8wMjPPY/E7kK1lY/Fmgk0+4C8EUfMzUGsETUFdqDZjfrcTdqCD0Kqmey4t+sUmPgPYtr+Klx7YnFWQy0byNAxRpARWNuuPRcWlpjiKxEzAq1EMp9pEJ3z7QtNiZ1qbV9j63Ns9siG0TZukTzU+oQDb7boB6bDT7e9EUgG3G1ZlkLMhQimQKRMqFBMt0So832M0ABrzENoX6a6YyqjtP9Oa16vUl1dt/Cnre6eK/BtOUjR65S5cPwhi8FzFn052oKSUUSSTQFQoMBeet19HMIKcVAoKnBzykHF6cTl4gvmmTEi40PQ1fIhp06LKpxO8VhXXR3ii/BNZHKiYE9eHnhvUf6MNej4IpZjOBClvbXHfwOP21as34YzvRoebaEHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603a6f4c-218b-4c15-d171-08dd2b6be95c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 20:27:43.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tb2VuG0sy/g+8SHaFvpnkeVZm7m/LD0CB4OMCHwAGCwroQ9WydEKofZ+iIz1d3YzYbkX37zc2uq/ylHUodG2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=770 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020178
X-Proofpoint-GUID: L9tXHJ2QyGKWNGTIujA9Cz0FvKpdtq6G
X-Proofpoint-ORIG-GUID: L9tXHJ2QyGKWNGTIujA9Cz0FvKpdtq6G

On 20/12/2024 5:23 pm, Jeff Layton wrote:
> With the latest code in Chuck's nfsd-testing branch, the limit on the
> number of fore-channel session slots has been increased to 2048.
> Increase the TOO_MANY_SLOTS variable to 2049.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Maybe we should increase this to a much higher number instead?  I half
> wonder if we ought to just eliminate this test altogether. It seems sort
> of arbitrary.
> ---

I've applied this as is, thanks Jeff; will have a further think about 
whether the test is still useful.

cheers,
c.


>   nfs4.1/server41tests/st_create_session.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nfs4.1/server41tests/st_create_session.py b/nfs4.1/server41tests/st_create_session.py
> index 43166443ef6f86a6b44de70f3793bd93a330bc9d..740f8bf274c4eeb3ff9da20c0de241a31f80ac26 100644
> --- a/nfs4.1/server41tests/st_create_session.py
> +++ b/nfs4.1/server41tests/st_create_session.py
> @@ -395,7 +395,7 @@ def testMaxreqs(t, env):
>       """
>       # Assuming this is too large for any server; increase if necessary:
>       # but too huge will eat many memory for replay_cache, be careful!
> -    TOO_MANY_SLOTS = 500
> +    TOO_MANY_SLOTS = 2049
>   
>       c = env.c1.new_client(env.testname(t))
>       # CREATE_SESSION with fore_channel = TOO_MANY_SLOTS
> 
> ---
> base-commit: fa786a7217128e6e5c9ef20da9dd6069f5f593e7
> change-id: 20241220-master-2b43693225b0
> 
> Best regards,



