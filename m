Return-Path: <linux-nfs+bounces-14571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F83CB862D9
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 19:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC981CC11D3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 17:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE4F3191A6;
	Thu, 18 Sep 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D/gjum/2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ef5aTTIM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B98318131
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215729; cv=fail; b=JHqCstApPDqbkkKcfQdD/A3rEShTa0fuyr+JgtwH3U9uxmlAAYsgBOwJQpjt+M7bQSUWoL4hPv6PRHFB+fPLSWMbST0/2T3++5oUO1HD3azHcMQ6uzJ2ZKRQr8LzYV3IpkkCtLdxbEnDrsoyXkM1WtRE+8Q5LEMNRMjL1f4bIS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215729; c=relaxed/simple;
	bh=2t0K9qMElbaSuj96FmLN/VMjEl6NDMczCVRg0Sdscbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ekbjEGdqqviXh9rwxPhPUKeKfcAvZFH6PM5NjS3xxJqtR+AhVu6HK/ZZ06opSvpcL+YtVAakPZMNrtvJ08JGeKZvjjVGrkQzegVETHGzUZ5ka2Ncbi1rWSu4aBkX/QgQ1zx7RTZsA1bOGrXn1wK2Y/POXs+ZoEV78z1Y7ZW+XzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D/gjum/2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ef5aTTIM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGGBBa029823;
	Thu, 18 Sep 2025 17:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=roB1CgXzMGdl9H1t8F/tmNJiZoYfypnwHMZJeecgH3U=; b=
	D/gjum/2U+POy2/IPFueHeenvlNgJibqb+URJnkDO9aZxp0JbPA8OpoovLl7AnF1
	XKIGdJ6kLym1h+poU6a9d5NaEVfcPXHTCsjbR1vR2zylwVQIH7ZGMsJjJQfGmlvu
	/EmYh7LwrUdeOSbGSSnPlzhevTm/r9APH9u6EZX8fUb07UVvE7SPkhEZ+WDX9vQJ
	JNiw9tbV9daggSkJfDjCRCGlOG1/mh2Y0uVH5wpTE8cIbXoYJdozgEwU12XboduA
	8IyOCW6GUy7n75+LHltJkS2fPl6Rm7fpMIismDb+Wm7TSQYd8KA8hlvXFgeaoTfF
	4/r7OX2FEGUQtDmqZemMiQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8ku7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:15:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHCEXx001717;
	Thu, 18 Sep 2025 17:15:19 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fnau5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:15:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW1KknbWPcGg4HijDjubVgB4IQ41kf0CbMNSFgSl5XOOrAKpIYUk5Nj8fi2L/Mhr5u6fVKrTott3gUcorHyVCnKZ9PXLdNrUOv52OBnL1zaPwUr82q7XPv8PiRKE3zgdOd2lSXXboQblHiB8uFiggsYC+nEEWOG1nNCFZ3cxK858lgO0atuRT63ozR23JUrDj+LDIjSqtwJ0lC9lWQuBpYrwUsBLtWHxaNXylPspwvzXwKjkAIBXIH7/YVKj0yUJgolydY581q4c8j6g+79FKGlDYHXX9pgaNwXOfybsBZbPLD+CY5oJ1hxPwpd6y29M5DyrLE2aI0bfrWJ7mnPwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roB1CgXzMGdl9H1t8F/tmNJiZoYfypnwHMZJeecgH3U=;
 b=IT0I6vAq4zyN09NUmSpU+M+Kz48Z2O8GPIX0Mf43mfpGToi0pWlqMU8qH99OarmMsfopb868bZQ84Z6eADGDhX+AYB0P9F5uekPRetLo2B4wiP3f6UYk0ZDl9QawJwZanryfkFhcIXxhsYdgwccGrOHtgb8VlF/7nyuz/L2aOnAWqsvc6jULJ+GMn8rlA6bSWNtj1aaIB6AwGmSzfJVETQusAboUFxjai92GqcG++DWw7Dj0mOoY3eFNVTL9OJVfA/oyhFljWvU9BZe5GNx5VNJiIAwGXQOHFNeaFsBHE0ED52PgT3ogw6cZGl9dCM0QstnHEehsgpHPGoTuB8Dbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roB1CgXzMGdl9H1t8F/tmNJiZoYfypnwHMZJeecgH3U=;
 b=ef5aTTIMaDzrZlHVVjiapjOQa/CF4EJ07eFmJVEhfQjMWNvxs2dWvNADxBoceo33rhpXc05atDdQzDlMavm7A22BA41yNl7NkfHpUnTuHitMUHVTpdjIjCy1u4ICuUvr8CbWwMOxcPS83ZLf+4Ovti7Tm0zyXUKcd8u+j77z5Pc=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SJ2PR10MB7081.namprd10.prod.outlook.com (2603:10b6:a03:4d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 17:15:13 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 17:15:13 +0000
Message-ID: <404a4c49-9e16-46d1-8901-f7a8a6a9701b@oracle.com>
Date: Thu, 18 Sep 2025 13:15:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/7] nfs/localio: avoid issuing misaligned IO using
 O_DIRECT
To: Mike Snitzer <snitzer@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-3-snitzer@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250917181843.33865-3-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::7) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SJ2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: cd364452-743f-4279-393a-08ddf6d6eda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGpnYjYrSnRYczRzUFpvci9KSktoNkNvNm42dmovUmo0eUNMQVk5L2dBT1dp?=
 =?utf-8?B?SmxSaDhMK0cvOG5TR0ZINytkZE1xUnNKTDl4Um4vRXhkNThGSm50RFdQM2FJ?=
 =?utf-8?B?MytoYWhlYXEva3YrQjZDQVZMNkVYR3dLbmdLVExrQUhiMUJoQi9waDBZcVla?=
 =?utf-8?B?UzRlWWdJVkZNY3RKRTU0cHlueTNxNHplTTdLampxZ2YrNVQ4N2NVOUhPazJJ?=
 =?utf-8?B?c1JIanI2NDhqNHRieTdmMTFVQStQUzd4emcwRGVoWEVyZWI3dEdWQVpJUElK?=
 =?utf-8?B?a2xvSDA0a2FFUUl0VU4xNlBIc1Z4QisvRytjUTMxdC9veTdKeER3VE5UVjRo?=
 =?utf-8?B?U0FUZzhHSDB1ZXFCTlBIbjZDeGZKZjVnTm9yL054Z1RXWEFBVyt0RjM0REJY?=
 =?utf-8?B?WjJwV3Y4SW1ydHVPS2k2anZZQWpmWTg1RnYvTXZHeTFvUU02QUl4amVkL255?=
 =?utf-8?B?SXdiWFlqbWIyUTdMaXBTUTN3SUpRc2pUYkw5VVdlNURlcHVSdFhWdE1GN2I0?=
 =?utf-8?B?TDUvMlB3VHVBUDlxV0wvRTRWd1d4eE9Jb2puVnB6L1lzMnlzUUZFZWNpTnBj?=
 =?utf-8?B?UzlTY01iQXpKNkMvQ01yK0x0R3AvTWZMdnhRL0tESmVIcmg4TkNIdjlIbnp5?=
 =?utf-8?B?a2RIanpNUE94WGg4YW9CNCtCdGpITjBOQ0V3TGVHZWNFM0hueE03R3h5T0hI?=
 =?utf-8?B?cXFGenJxZE9JVk9aaHJzWENHTFJ6RTIrdFREVXB1MHExN1J5SmFqSkhMT1BB?=
 =?utf-8?B?ZDdGTFM0dTByaFkxd1BCdEtEZ3IwMGF1YTVLU1VLemNzTnVlUEY2RjlEdWF0?=
 =?utf-8?B?WmpSQStxQlA5SGsxSHRFcHROUTdJNHhTcXNRVWZCY3BnRWF5ZVArK1YzQWpm?=
 =?utf-8?B?am4zN3l6STgrdU9WV2NMRWVOK0FUM0VXZkgrTHp4UmtNQmI0SGE3aCtrWGJw?=
 =?utf-8?B?Njh5d0ZMakxNaTdPUER5cFlucGJzS2h6cFI5U3orVWxLOG8rdWF1eXlEeGdi?=
 =?utf-8?B?RWtkUVlPb1M3SUxJYnVRUjFyZTdBZ3AzUHgzZGZRclhxeXU2MHJTT3dnK29y?=
 =?utf-8?B?Q0U4VFlmQktRZGtySm9lU2JrSE1KMFhBUUhiSkNJeW1tMDE3MlltcjAwdktU?=
 =?utf-8?B?ZFZwRVB3VzhmZStuZGVRLzFyNEZ3UzBKWnQ2Szh6d2JwM1kzNmJmUXcrTm1j?=
 =?utf-8?B?Qmx0YmdLV1hpUU5YamUzakZVTzFvdlB5S0NNOGJUY2x0RFZVNk1JOHpzVEhP?=
 =?utf-8?B?U1ZCQk9FR0Q4V0h3YU9qWmE1SVV1QmZrMkVURURtc09UK2VyWC9JaWFwVkJQ?=
 =?utf-8?B?Tkg5aG1YeWllZXJldEx3bGM3bWVRSFJxNmt4QmRjV0R0cHIvZ3Y2UkdtOGRB?=
 =?utf-8?B?VmFtWU9OS29DS2FwV09tOVhzdjQ4YVM4QVNyN1J0RlUvK2p1WlUydTRWTGpY?=
 =?utf-8?B?UWwwam5pbGFLWXdlN3dieU8vT1BBNjNDRDVhV01SMW12R2JPVVpReWYza3dU?=
 =?utf-8?B?WEpNdUlEY0VmRzhsUGF3Q0dxTzYvMjRkWEFzZWpYdGRhdHhoZWp6K3JWRDJV?=
 =?utf-8?B?L0JKZUUxQnBIbWo3L0VkU3llOE1ITGR6SVU0dUFVN09hNTJCY05KcHRhT3d0?=
 =?utf-8?B?ckUxOUVuUmJWTmhuTGdLZ0xaUnlDbzRZbkxuYkE5TzBPMCtGSUNrVkQxcVJt?=
 =?utf-8?B?UzlPaVR5bmhDT2Z3Zm4zem9YczlpOUk0U29sdDEwQkowdDhXTDJ6MVBwSERw?=
 =?utf-8?B?T0NJTVdpd0ViSFg5b3VoSXdPcFNVRVJBRlFNZjVQZzdvSmp0MFBIa3BXUFZI?=
 =?utf-8?B?TUlXTWJhWE1vV0RqbFN5SnZxdCtSb0xTMFJEOE54SWRxay92a282cDJUeWRR?=
 =?utf-8?B?N3FVZ3orOUNNMFBFd0FrYU14MWZPVWpXakI1ZGpuOEtQZEFMUjBvalVMMjU3?=
 =?utf-8?Q?Ep7Nj3Ku+3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2pidDdHME1kOHZkTkdKeTlPbnNpYWZ4NnVlSDRkV2p5VmVpdk5iRFF3ekJ6?=
 =?utf-8?B?ZXBybU1ZK2ZPemthbjJnd3JRODZHbDVHYUhBUnBGT3JsZHUxM0cvV015WHRB?=
 =?utf-8?B?YjQvT0NOQlA5dEdKYkg2eUovbE9kUDcvRjJlZGIrYnVVRi9URy9uMW5HZW5x?=
 =?utf-8?B?K2hLM0RJQ1NQL2lQNDF4QjJPaDFoN1p1THRCc3E1dGFYT1djWDM0V0NSWEY4?=
 =?utf-8?B?M29LdHNLVlZueXhXY051c3UwWFIyUDUzM2I2aVRVMkVreVZtNTBMK0c1TWp4?=
 =?utf-8?B?N3BDdkloVi9OKzhxZTlTSGt0VnQ0aEE2TmFHTjdFdlJQSmVtMGxycFFrRk1M?=
 =?utf-8?B?MGRMZ2RDMWxDV1hzb2ZOWmZYQ3RpbnZEWlJaL3J0L0ZTK0I2L3ZyWEdsMUIw?=
 =?utf-8?B?N2FPMmxjSnlKRk85VnIySW95QUY1V3Yzd1ZIVlRPUWU2Z1lFdTVSMHhqbnhw?=
 =?utf-8?B?Mkp6MTk2UlgxK0FCR2hZNit3Zmt1WVlRcTY2eVJaN1MzSjVtQjdJNDVLd0tS?=
 =?utf-8?B?SlUrUkNHQTEwRlQ2Nkc2eWU3OHZ2aVA5SGI2N2tSRWRzRkx5dVlYTXdXWnMv?=
 =?utf-8?B?S3ZEREgrYlRaTHB6aDBXZDM3Q0tBQVk5WU8rR1k4OHZEY3IwZ3oyUWVrT0Vk?=
 =?utf-8?B?YWF3SUNoaTE3VUhsRC9haEc2U2poak12NWVYb2hGdGVDc25rNGtNcXR6ZUx6?=
 =?utf-8?B?Y3EwQ0YvTGxUNTdDdThtMm83QnRaZStZOG5SdmN0U0ttSXJQNkpKK1JXRk9q?=
 =?utf-8?B?dWFnZWdWaEg5dFNXRWZKa20yUHRMdElwb1d5bmtkYnUvaDdnWTlSSmtWTENH?=
 =?utf-8?B?bUU1dXVIaEJlSzdUOXZ1ZTcyOCtqOEhLSDQ5TzlwR0ZXdHJCdktmMnVlWFVZ?=
 =?utf-8?B?MTRVYno3RW11OCs4eWppOXhBdDZRRi9HQjE2R0F4SXJvTVNRK2tLT1d0eDY3?=
 =?utf-8?B?N3pabmYrNmdMR0VVNW5EZi9xb0xoTEd3NURyMmFPRm02RE1McDZsc1psbnVp?=
 =?utf-8?B?QzNxMTVsM2JXMnlyQWJsV0pLUDFGc0hnL3loMnlUa2RXY3p5djA3eFZEQk1T?=
 =?utf-8?B?b2R5a0EyREgxbU0xTjlJZkY5RnJmaUh5VWg5WHNBNjhpTEhERmViVXAyZCsx?=
 =?utf-8?B?RTVIYVQrei9MdlJJVGtXazRjYWRkMkdQeTdhSUtDek1YOUlGTzdlM1ZEMlAw?=
 =?utf-8?B?VThoZHh2NERwUG1lek9pNnd6SlZVOHA4aDNGeFJFN2RPMlIrWWxMdzFadnpu?=
 =?utf-8?B?UE1mVlBZSTBsNG9GYlBCQXdiRFdidHhtcGJodnppTGlGUnBRUnF3SnZ6bWNu?=
 =?utf-8?B?M3RiUUduVWJLeU1CUzlRVW5zVG1ScVpxR2M1WTUwdWJXK1lOL3FVSDVGMEx1?=
 =?utf-8?B?ZHA3bnRjL3U1QnR6eDlxN1MrZWl0ZEhHR2l3NVorcnVKUkd4OGh4Qyt4REll?=
 =?utf-8?B?Tk9sSFgrbDVHSDF6WTF6Zmdxdy9OMUtHS2x3TG5TZWNHRHR2bWpvMS9USTBp?=
 =?utf-8?B?THlKTTdSTWk5QUNJeWR0ZFJNWGIvb1R1L0hMTk5teWdnTmFmak9TYmUxNVc0?=
 =?utf-8?B?RFV2OUhycVNIU2pYbUdIY3piSDYzVlIvcUtOSW1FNU9SRytIWmRya3ZEMERu?=
 =?utf-8?B?eGtROWFBL3R4c0s1OHRkY3VKY29qR3ZHZUIyNHp1VnVwY2tqMlZjSjNGOUR4?=
 =?utf-8?B?NlJlMmVHRXVhUC9tMXEyMjl3SWQxS3RrZmFNdVBQRks3aG1LQUZsYVY0N1BI?=
 =?utf-8?B?MlYwdWQ5UlNmeEdoSlNueWhCYjZNSE9SLzE2MEJZZnJOS2RZRW1aRDFraS9m?=
 =?utf-8?B?dUJ3eVRuRFN6S1NrZjdaUXFTS2ZaRlREQmljaTZOUm5KV1Q0NTU1cHcwUS9k?=
 =?utf-8?B?d05HaURnbFdpQ1VMY2ZBcEVTa05NU2UyczVSQlJNVUszdzczWHJjRnZZTURP?=
 =?utf-8?B?THhpNkxLbjVpWXVwU2J5clM1bkljR1BHZ2hDbzBRazIxQXNyekpjVndqdU5V?=
 =?utf-8?B?bDlmb2JpU1Iydm9lRWZkN1loVEFPTXdWNm41RkpMODMzQmQrOVowSHE2RTFz?=
 =?utf-8?B?ZUdkbWRRNkVMamVJYmJoNi84aG9UUGVCSlRFUXEyUXgvYlFHdHZzZ3U3aitQ?=
 =?utf-8?B?dTZuc1lQMEhkSFZKL3FPbFlOTDN3b3FUOFlKSEpqblUxTmtSS3hXVkxSSWs0?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yb6C9EQtdRV3PkmbKakpioZwY6ZXTGr1Q9NQSem0m21O31RC/7ITf6lswOiCzHRr2h5KU42xmo4qPMDY6SAmlOENsgPr4hC523Z6hshb+v6F8fGmMCgASmmYr6DgeKkioSYfueBJ+sSv/Kqj3fEPUMEJIY3La9iWeWpwLwrqoYmSN8uPrGVEcSVwMEcrDQ/Stlsdy09oBH8u7AVzchDQVYpT2YVbcp7xdFtT/sLPhZX/iewlTXmS2ArnPxmc4BsFNdwSc9S/vbF9amGDv2N35Zs9UU/X8qj5IJzF5To/ONTZDdRfssqwN29R6/xWgH7ULSZkgLdHlF0ce8w79q5RU5gZd8+tNNA/5l6a6OrqizhNlsesnMzG/k5SEKuxvrU3dmgfaXqdDnvMQEe7IH0iEh0jDNR770dX7Ho7MFLM4R3YgBgG4RpOM+hbXzaAGgNxrodpCJ3jo0L8bCk9HSSBVw/IwyxIFuV8ptO0DFkNZ5RZGS7u4m1OA/bG1w9X5h9M3b8oZ88kcpyn/34yZTxL4IijMyfpEUhV+koriHPED6uGP1oubgQ6cjLm7olnnGzHiHu521AvKdy8E1ogsXix3vuI9xKw2NyxqY4N3sfo9hI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd364452-743f-4279-393a-08ddf6d6eda7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:15:13.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAd4RKkl0HrsphKlSOTeZaWy6YeqW7Ed/zhfBQXn4s0GjAKvDp3h2l1R9WcvQ5CyFddDp4yalQDrKXqKwNuRJZyxngRC9v9eGazcZ0S8HN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180152
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cc3e29 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=VQHB3f-KAAAA:8
 a=U8di7r_VAqqYve8VNMcA:9 a=QEXdDO2ut3YA:10 a=hl7nQCIM6j68zV6B1S6c:22
X-Proofpoint-ORIG-GUID: s7SRjVzGHoEPhyqsiLaHT3rmllXPp2z7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzFkRAXUPMQ4x
 5qKy/u3d6tlox/Skmffr4V7NnsyS5q2MOfaGA2ht40+cK7CTqGL0Pw8y35zbLT+Rg8bPSD1gNrc
 rl4f4QewXq+G8pYSBwPvQOuex/1orFdFB8Yet0x5h4T/Av9U9hDoFkYHo1ijNmr3e8/kxLmlB7d
 UnddL+UvJWJS0QeyNoM3JBn7WCWRQRDRXfKECSe6k8k+kPPH+Llrb2gx64wVs48OL7Tpd+JsLXl
 hF+OKa50TX4SYrB+UN/VfTgTIsTyqC6McSZdYjK175iEagqWE91iEc0KQGwN+E3nFmi5UxRZkCw
 BVT45AJVpM5bCpAurEp4GIa6z+lby2oJij0Klwjf7F6g4D14vSrnwc+U/edCeXq7cJT5DUM1vkU
 osdeUc9v
X-Proofpoint-GUID: s7SRjVzGHoEPhyqsiLaHT3rmllXPp2z7

Hi Mike,

On 9/17/25 2:18 PM, Mike Snitzer wrote:
> Add nfsd_file_dio_alignment and use it to avoid issuing misaligned IO
> using O_DIRECT. Any misaligned DIO falls back to using buffered IO.
> 
> Because misaligned DIO is now handled safely, remove the nfs modparam
> 'localio_O_DIRECT_semantics' that was added to require users opt-in to
> the requirement that all O_DIRECT be properly DIO-aligned.
> 
> Also, introduce nfs_iov_iter_aligned_bvec() which is a variant of
> iov_iter_aligned_bvec() that also verifies the offset associated with
> an iov_iter is DIO-aligned.  NOTE: in a parallel effort,
> iov_iter_aligned_bvec() is being removed along with
> iov_iter_is_aligned().
> 
> Lastly, add pr_info_ratelimited if underlying filesystem returns
> -EINVAL because it was made to try O_DIRECT for IO that is not
> DIO-aligned (shouldn't happen, so its best to be louder if it does).
> 
> Fixes: 3feec68563d ("nfs/localio: add direct IO enablement with sync and async IO support")
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/localio.c           | 69 ++++++++++++++++++++++++++++++++------
>  fs/nfsd/localio.c          | 11 ++++++
>  include/linux/nfslocalio.h |  2 ++
>  3 files changed, 72 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 42ea50d42c995..380407c41822c 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -49,11 +49,6 @@ struct nfs_local_fsync_ctx {
>  static bool localio_enabled __read_mostly = true;
>  module_param(localio_enabled, bool, 0644);
>  
> -static bool localio_O_DIRECT_semantics __read_mostly = false;
> -module_param(localio_O_DIRECT_semantics, bool, 0644);
> -MODULE_PARM_DESC(localio_O_DIRECT_semantics,
> -		 "LOCALIO will use O_DIRECT semantics to filesystem.");
> -
>  static inline bool nfs_client_is_local(const struct nfs_client *clp)
>  {
>  	return !!rcu_access_pointer(clp->cl_uuid.net);
> @@ -322,12 +317,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  		return NULL;
>  	}
>  
> -	if (localio_O_DIRECT_semantics &&
> -	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
> -		iocb->kiocb.ki_filp = file;
> +	init_sync_kiocb(&iocb->kiocb, file);
> +	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
>  		iocb->kiocb.ki_flags = IOCB_DIRECT;
> -	} else
> -		init_sync_kiocb(&iocb->kiocb, file);
>  
>  	iocb->kiocb.ki_pos = hdr->args.offset;
>  	iocb->hdr = hdr;
> @@ -337,6 +329,30 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  	return iocb;
>  }
>  
> +static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
> +		loff_t offset, unsigned int addr_mask, unsigned int len_mask)
> +{
> +	const struct bio_vec *bvec = i->bvec;
> +	size_t skip = i->iov_offset;
> +	size_t size = i->count;
> +
> +	if ((offset | size) & len_mask)
> +		return false;
> +	do {
> +		size_t len = bvec->bv_len;
> +
> +		if (len > size)
> +			len = size;
> +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> +			return false;
> +		bvec++;
> +		size -= len;
> +		skip = 0;
> +	} while (size);
> +
> +	return true;
> +}
> +
>  static void
>  nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
>  {
> @@ -346,6 +362,25 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
>  		      hdr->args.count + hdr->args.pgbase);
>  	if (hdr->args.pgbase != 0)
>  		iov_iter_advance(i, hdr->args.pgbase);
> +
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
> +		/* Verify the IO is DIO-aligned as required */
> +		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
> +						&nf_dio_offset_align,
> +						&nf_dio_read_offset_align);
> +		if (dir == READ)
> +			nf_dio_offset_align = nf_dio_read_offset_align;
> +
> +		if (nf_dio_mem_align && nf_dio_offset_align &&
> +		    nfs_iov_iter_aligned_bvec(i, hdr->args.offset,
> +					      nf_dio_mem_align - 1,
> +					      nf_dio_offset_align - 1))
> +			return; /* is DIO-aligned */
> +
> +		/* Fallback to using buffered for this misaligned IO */
> +		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
> +	}
>  }
>  
>  static void
> @@ -406,6 +441,13 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
>  	struct nfs_pgio_header *hdr = iocb->hdr;
>  	struct file *filp = iocb->kiocb.ki_filp;
>  
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		if (status == -EINVAL) {
> +			/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
> +			pr_info_ratelimited("nfs: Unexpected direct I/O read alignment failure\n");
> +		}
> +	}
> +
>  	nfs_local_pgio_done(hdr, status);
>  
>  	/*
> @@ -598,6 +640,13 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
>  
>  	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
>  
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		if (status == -EINVAL) {
> +			/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
> +			pr_info_ratelimited("nfs: Unexpected direct I/O write alignment failure\n");
> +		}
> +	}
> +
>  	/* Handle short writes as if they are ENOSPC */
>  	if (status > 0 && status < hdr->args.count) {
>  		hdr->mds_offset += status;
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 269fa9391dc46..be710d809a3ba 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c

I'll need an acked-by from Chuck or Jeff for the NFSD portions of this patch.

Thanks,
Anna

> @@ -117,12 +117,23 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
>  	return localio;
>  }
>  
> +static void nfsd_file_dio_alignment(struct nfsd_file *nf,
> +				    u32 *nf_dio_mem_align,
> +				    u32 *nf_dio_offset_align,
> +				    u32 *nf_dio_read_offset_align)
> +{
> +	*nf_dio_mem_align = nf->nf_dio_mem_align;
> +	*nf_dio_offset_align = nf->nf_dio_offset_align;
> +	*nf_dio_read_offset_align = nf->nf_dio_read_offset_align;
> +}
> +
>  static const struct nfsd_localio_operations nfsd_localio_ops = {
>  	.nfsd_net_try_get  = nfsd_net_try_get,
>  	.nfsd_net_put  = nfsd_net_put,
>  	.nfsd_open_local_fh = nfsd_open_local_fh,
>  	.nfsd_file_put_local = nfsd_file_put_local,
>  	.nfsd_file_file = nfsd_file_file,
> +	.nfsd_file_dio_alignment = nfsd_file_dio_alignment,
>  };
>  
>  void nfsd_localio_ops_init(void)
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 59ea90bd136b6..3d91043254e64 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -64,6 +64,8 @@ struct nfsd_localio_operations {
>  						const fmode_t);
>  	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
>  	struct file *(*nfsd_file_file)(struct nfsd_file *);
> +	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
> +					u32 *, u32 *, u32 *);
>  } ____cacheline_aligned;
>  
>  extern void nfsd_localio_ops_init(void);


