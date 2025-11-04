Return-Path: <linux-nfs+bounces-15989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C75C2E9CD
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 01:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D713D1885764
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 00:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053FA1367;
	Tue,  4 Nov 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SsUhJOZ1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ji2PbaKM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA7139D
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216353; cv=fail; b=ZOILHY9Id2mQ5orfT5iYiSPzw3s//TW/Cl1CywhM989N2NyzS52ybEeXT5DrLISAN2PaY2ugXRzYlR7fVLjK3tbStq1KUAYcPrihSG8HCq3dXaNA2UrsRooHvZcjlmBQ0EcJFpZ14/L/T/KlfC3r18VTq3B21K4kC0jWhKOkiYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216353; c=relaxed/simple;
	bh=THKndnve0pmdYhrjOEH5C2g+xduZqwtnhp8uXRfSqxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pmAGc1xLWKuqf7jvkCOIlJShcqlNERJMhXDlj2p2oDpkDupZiKUg5+MQFDHedrcjzkRpMwnxd46NBDnKDxTJ1eHPf3MrL3NxQaYWXjpRn3eDZSFTEtYH6PjqQt4iJ5TdUPuUTt4llh4Z1KZR15Tii+JeIUe5NBsGvEMCBvLwO4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SsUhJOZ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ji2PbaKM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A40TBk1030026;
	Tue, 4 Nov 2025 00:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KPAwkUfwDN7ARmW0TRnP5bEe/sqCySBaP2dIVIoTxag=; b=
	SsUhJOZ1WiYfaPZqbYV0uF1oA28uRO2QAYk8Ce71w+0SQp+y9l8LEBKvPUzZCRUA
	0+X3X8wocN1W/GCbfwrXsGYVQdp6l2+xslQDOg1dhWAqHcRAhvGREQj5GWqfXT4h
	fnYdKxp0kQGbQJhp2J+pEM5ihJYNn/NfkTDviXq2STc9DtNTBMIsZ2Th0EqyS/s8
	RmManTVhLthRFLuIE1enZEk3GQq9HUcIgB+B5nq+/kA/q9LSsBHBKvrh8ykxaswN
	yHg3416HjnaylgROaNfoD1XkM1fH3BMn4RO5eWebza6Ym5g+m/7spSAbPHozKE0I
	XQvhM+ZLzkeBnJ+NuR3Jcw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7705803t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 00:32:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A40WHFW017252;
	Tue, 4 Nov 2025 00:32:20 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n8mupa-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 00:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK7Ue2lZDenQ8gnXFFodB7n8QOWWT4aoySae/9qSDkf5cPFc2BOfzrzmYcF7TqdOvXKDhcS/Ju16OUBG5Cmt22JvoejwgpUqBP3IW6p4yLJVhGOWHkJzqhGauJVFWpGPG3sU8X0OQsDjjyJ/1EXxyYowxEwP7p4CKwkqM4OlCLM+TO5NQG3Nq98PekRsdXlZ1dASJ60ZKrfogF3EtqFlMt9Uu3k7QGjZMjSDqNy3waiRiF3A3Ykrzl4bjIAjCSbntRTayy1t0WYvSOcw1ydHEgElONthBhBUSZST9op4rySc9UPOXaP54NrNe9Prm4LonqQdyM9jHeQ2ks+9aoXPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPAwkUfwDN7ARmW0TRnP5bEe/sqCySBaP2dIVIoTxag=;
 b=maw8C3tibaiC77docdannrnrS5V+TVT7fOHzZspkPjAVyPfTjgvnt1Mr+/ygnh6E4+phdXVnRN45zh7xKlXhpEaJofWxAP0dmiS7fOX269mcTSNurcVaqZZCYC7+NRDoMHWVvpPqJDtZPHmlvPaB/2ESOx0xMkhnWIdWy7X65cL1JeeFFZeL5JvEETP6PeDCP4aFUecZUUft0B5E7xGqTX5kuwnYtbBlDjCiM4ELed3VLkuf4KK4ZUpBYVYgZW8CQTwfzW9tz+N97G5iQqC7yuf3kM3rLSuuVeSjncCCkXjPgN3bBl1FBWw3ng8kqQ+W715lzVucah+xJvOqxOm30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPAwkUfwDN7ARmW0TRnP5bEe/sqCySBaP2dIVIoTxag=;
 b=Ji2PbaKMq/AQjsj63XqaseroxD0PEABHkB3LhG1+orW4mBdV/W/AxD9kHHNRSwbzK6yO8P8f4gM0eg5AxCtcY7QP9tVJ0VlNkPL4uuAIg243dMTJeDaFqlr8jz9eBp7zRhvw/M7mJfcB0j88XC91aWWi7e79NoNxXN+2wjGg+wg=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH3PPF2A078470E.namprd10.prod.outlook.com (2603:10b6:518:1::791) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:32:16 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 00:32:16 +0000
Message-ID: <9f5a24bb-0f19-4feb-b687-0a78844c8bb1@oracle.com>
Date: Mon, 3 Nov 2025 16:32:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Add trace point for SCSI fencing operation.
To: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-4-dai.ngo@oracle.com>
 <b8a55017-5bff-49f0-a2bc-6bea6df7d658@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <b8a55017-5bff-49f0-a2bc-6bea6df7d658@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::31) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH3PPF2A078470E:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dec5350-0b4e-4145-0c8a-08de1b399ac8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S2FyVjdzS3JvYWFaTXgxRlk5SnQ2NXVlWDlBZDk0Zzd6WExiTS9rQmtucWdZ?=
 =?utf-8?B?Ym1tRTJKa0EvTXlNM1I4QWtUZnRNeG4yNFhtdmdrY3VqVG10b0V0Skk2RytT?=
 =?utf-8?B?aUliQ3hLWU84cUFmdDJxM1BZR3o5aEF0NC9tLzN2SW5NOEdLbTZZQ213SFRz?=
 =?utf-8?B?SDhYR0lmSHJIblZhL0x2enVnMVBFdVdBL1FuK2ZKVENEYkhWMUhLNkxPcXlp?=
 =?utf-8?B?VWZuNGhHZEN4eitKUnhMMHJDcWV1VnV1a2RmazV1MTZLUVZtYVZLR0h0WVNv?=
 =?utf-8?B?OFlxU0hMSk9RMkpWc3JoVmdGaGxqSkdEQmNaMnl1eFpOQjFLRms3ZkhQZHpZ?=
 =?utf-8?B?TEJDbXNvbXNLMTVTY200OEdyRjhjb1B4ek9WWS91WjAyVTAxV2k3UnA2STBK?=
 =?utf-8?B?ajJZWS9rRkF2YUMzd1Y4ZGliQmU4NU5NMERoNHp5ZVRTZUtFVytSajBQQXg4?=
 =?utf-8?B?YWNWMGhsVlZVaUttOURZYXoweE5oNVNBM0pKN1lKbFdnZWhnWlBVTTQraGp1?=
 =?utf-8?B?bEsrcFZhTFIzekNuUm4vcDh5bG1BQ2hGTG8zbS8vUlpHVDNnWk05dmVtTGNC?=
 =?utf-8?B?OFZXNG1qMXdqREVuc3dma09lNjl4VnY1L1M1QXRxRWhHTmdsT2VuUEwycTNz?=
 =?utf-8?B?TTNyNUNMbENRekVlMWg1eWlWT2gxVndyd2kxMFdneXRkOFpOWU5SRHlVU2xP?=
 =?utf-8?B?WG8vNWUrVlVScEErVURxRWdxTldVMUN0MGUxd0UySjFzVWF0TjhPbU1oNlNX?=
 =?utf-8?B?QUxWRzA5T3dYTmJSZHltRk1NWHRteXJFRVdXMUpGTm5iYjd5eWJnTk1KVHU2?=
 =?utf-8?B?T2xFOGllT3RRc1hjdENIbXl3dXdLSy9TOVlIV3ZjbFkvekZBNzJTdUd1eDk1?=
 =?utf-8?B?dThwZlhsSE8yUU1WTnpYbndrZklSakZsekFaYmZWN3VyNUI3MzdVcTg3dFU5?=
 =?utf-8?B?dHNGY3BOaktqK3g4Q0ZneXlUTy92ZlBTcHZqeFI1Ynpaa29oU2dpeXEzaFow?=
 =?utf-8?B?NG1vdWQxNjdTcTFIM0xYMmhTRjJvUjl5SHdmSTJ6MUtGZFBZV1ZUK0JlVW1z?=
 =?utf-8?B?a2tYcnVBTzg5RHUvdnZ3WWlwWUlnSExnTlczY3VheE42dGIrS09YWHJRVzN3?=
 =?utf-8?B?dkdDRjRNUCtGNnl0RWZpSU9HaVZrczhZL3hDalVISGlGN3FDbE1jRERRRXl6?=
 =?utf-8?B?S0JILzhOQ2JZdXFTRVhscXM3OTlQWkVqa1RWdXg2RzQ2dlBmaFdsdHF2MFlm?=
 =?utf-8?B?UnhpRWE5cWFNcWExOGt4TzZVUE8yM0dFZ3FkU3ZYS1pNNGxMT1h1bkdDRGRZ?=
 =?utf-8?B?d1lpNDk1OHpOSG5sdGpoZTUzNXFkd1BCUWRRT1AyeVlwWGhGM3VKNStqOWp4?=
 =?utf-8?B?YngrL0M0U1JjK3BaRExkbjlrazBTOE5Nck01Vkp3MThRak93NmQ3RnJ1WXpY?=
 =?utf-8?B?Q2cydzNQYkxzOEViOEpEWDdBTmc1NW02ekNHS0tWVlJBUzJaU3I2a1NFOW1q?=
 =?utf-8?B?M3lVTmNxVUc3dHdEeHRIM2dWQTJ2UXQxc3FEN2hJUWtRZHpFVVptMHhqQTdo?=
 =?utf-8?B?VVFSdisrMGtwNGRDUjZtanZnM3R4Z09SbWlHMGZFdDdTVmpuWjcwaXdubnRn?=
 =?utf-8?B?S09GSmFPaEpQOHJDQllRMndMT1luY2tOVWNLa2ZUY25qTWFTdGEyeUd3d1Ru?=
 =?utf-8?B?SFNYUUF0Uld1cUJNaFd2OWFWT0Rtc0pUMzgzeStKZHlKZlZUb3B5KzQwUFpQ?=
 =?utf-8?B?TytLcUtTZElURTZYTjUvbUpJZDZNc3Z0eU9ndnUvT3d2THBRU3pQVjlUZUtp?=
 =?utf-8?B?akRSUDhqODFmTDU1enhFcVFZTjNsVVpDOXhNVFQ2azJtN3d6dWxMaGpjai8w?=
 =?utf-8?B?RDh6TXlYdTFtWUxpVDRFU2k3bXl1WjYwblNnSFhhRHB5TTFwY2Z6S2RUUk53?=
 =?utf-8?Q?936oAkFPkEx7ofi9yjitM+jp63NToe+8?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SkxqU2lZOW1MM0RiaTE3OUp6WDNvZEZuK2dtaXZsMHhvYVVXMW5URU5jNHhs?=
 =?utf-8?B?eDNpajFPODljdmx0ZTVHRDBkdWh4N2M2QUhzU1hPbUw1a3NUcloxMkdlZEdN?=
 =?utf-8?B?VUNRMHltWG5ZdER3TWRwb2g0QmZQSllQVXg5aDdnYWZWa0dNRVZrWW1XMDRV?=
 =?utf-8?B?amU2eXYzcTYvMW1IeWdkUzhIaUM3WEtxdkhYWmI2K0R6MEltZExrK1RBdFQx?=
 =?utf-8?B?SXF1MkNOczdNY2FRbkZiWklHNVNnT3kza1FNcVNDc3FOTk16ZUNtUXgwa1BR?=
 =?utf-8?B?NHNnMzVmYmNtWWRGMW4wdVpkRHlFamx4VjNQcXlFRkNaT1ZsWFFpZWpWbjZm?=
 =?utf-8?B?Y0VTYW0xYWxtOWpVNTNXelh0WVA1UFAva2h0T0ZxZVJqUHBYWEFqOFNnSElX?=
 =?utf-8?B?NHlRTkdrb0hOU2dqWFNPNFlESkhIWnJOaTRYbzQxcTdSZXBGRGJWamI3SGxi?=
 =?utf-8?B?UXd4STBCT0JYYkZhTFd5L215QmN5SXo2VFV4VWl2KzVRTnNVOG5ydHp2RkYw?=
 =?utf-8?B?Sjl0aEw3Z0xFZTU4czUvL3lNWk91WnVUbnF4dTdPQzVQS0Yva1hUekJ1akJL?=
 =?utf-8?B?ZXBnMzBSV0dka2RUR3FrWk4zVXF0MzVSdEpxU1NNb3lyTmdJR01xM09vNDg3?=
 =?utf-8?B?dU1CQy9JdGxxNEQzSHpkdFZZZGRuWHhBL2xreGdYVXNmQ0toY2JwbUVrSUdG?=
 =?utf-8?B?d1pOQmVZWTNKYWpDS3I0Q0lCWkw4UlJCYjZiTCtBSVRxdEhrNFZGUWU4K0pN?=
 =?utf-8?B?c0t4M3kwemY5VlBKL3E0UTYwK01tcnA5dVRhbjJiZElnVjAzdTdVU1IzM1li?=
 =?utf-8?B?bHUxN0JqZ0xkNm9EVk1IOExPUU9uNng0RDJVN0xjbGJBMzI2VWtJUk9UekR3?=
 =?utf-8?B?aVd3c0NYYVV2V1B5MlRxaEV6WUI0MTZrcERadm1aYytYMldPMnFIZ3FHb1hX?=
 =?utf-8?B?dk1ZWXBNSm00U2lUOUxHdGFSejgzNDFYU1g2SjM0a0xRaXE1SlR2aWdENGpB?=
 =?utf-8?B?Tis5TVZWeWNvOGVZb1Q0bWxzbWY2VStXNll6QVZTazQ4Wm9aOURlbGpJbFNp?=
 =?utf-8?B?TjdaNk9WdFpNa25CdWh6UWNIaHFUQUx5bVJ1S1A5THhZZ3pJYU5aR1l5Tnp5?=
 =?utf-8?B?clBhVm5VZ0dPY29wYXdjSnNvcVVsZXdqRDNPNEwvRlhMUzBpdFBzbmJjRXI4?=
 =?utf-8?B?b1hBOUwySjkxYkZETlN4WXVXOEQycjhCL3M3VjgzSHN3K09mSTROYW4rYUNL?=
 =?utf-8?B?YTRjZWNmcDQ5dmNPRXRsWlNKbnNsNGFnNDFpakhXTmRmNzhSUVljdlBnbEJZ?=
 =?utf-8?B?Rnlmdk5XMFdXaFk1b1l0UXdQaFdKeS9aTWMxaUVyNzFCMWVhODA3S25sajdk?=
 =?utf-8?B?N2wrNytYVVRYaVVnNUdVTjlyRUM1TCtUUWxpanZEdzdESTJDd001dUN4Qys3?=
 =?utf-8?B?bElnN1BiMTQzY0pZL1JjbDFrSHZ5WXlYekorU3p5N2ZkS1BnUWdCYWVwSVly?=
 =?utf-8?B?RElmZ3N3K2RFWXUzUy9ObXFRRWhzMkJYVHFBbkdHOWxScENNbVZoZ1ZQL3ZW?=
 =?utf-8?B?bVJGTmwwYW5PdzhPY1U3Zjc0QUNnRWkzZHlQR1FEWmg2V3h4NGc2SHZnaXBx?=
 =?utf-8?B?RGgyY0dJM0tzVkhKd0U1elU1RjAreTNKakxab0ZqRnk0Z3o5Vmt3UkRYRURm?=
 =?utf-8?B?Z0YvdEhXT29Yc0s3Wm0xRTJJbGdibHViZ0JqTVFPOW5DaGlpWXB0Tm1FUmVy?=
 =?utf-8?B?MU1ka0o1dmt6WXZVMEFrTGVqMEhXTFVxdXVKUWhtejM4RDRqMkxOQzUxUHhv?=
 =?utf-8?B?UVpEelZjWXNiMERKRnlOMnlDRWEzUlZBaUtUc1AwOS9FelBjd3UycE9DVmw2?=
 =?utf-8?B?ci9uQ0JiRXNmbDJmVWhLWlM2MGFaaHBSZTBsMTZDVVRScTl2a0VHanFwK0RL?=
 =?utf-8?B?bURyZEpjM3UybFEwWDY0TStXaDliQmhIdnRTa3lNS0dXSTFuTDBMNlF5N0x5?=
 =?utf-8?B?bnlnY1AxM1lrTHo2VktPWUtwbTJ4MzJMSDJwc3R0TlgwNW5QRkFZb0VKU1RG?=
 =?utf-8?B?NWNScnpPSHM1Zng5bGY2dVZxdVNwNURKMFZ2eFF2NEpNaUU0NVdzUmNDWUN3?=
 =?utf-8?Q?ItfwHKTIitGvhk+ORdTksx2ra?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+vinAETgOuqWDL3+spMkXtgzCyOJJTxFOnk+Mx0BOqDw1HsMtoW4kugq30pW72LEfhl9Nsbphql53cBRAmiA0gM1Tx81t11inRCuJLec+T7PdVUblg/Xfqph7/ng7Fe9yGfXWBeTMGmPUHRG3idbSEtw24ZkFP/ooNEW1CwuG7Cu/XFSuQkTEJsPdBfMBV+3JBSHqRKkXcvJsIDtoDvybbawmV5xNFIne25d7q8iK+4ae3ASuukarBdjdupZIg2mj/OEEpijIhyeO6gN8TDGoIywroNUXThCHo9ZMkOyNGs97cEaOzBnWeIXx8WMDq/OFfS6B0nUGLF4YtrMdEIfw3kuAsBoDZDn43RbVAeFJqWEbCXTvuPM8R9YJ3q6mnmvgCjMLj/aZrAAIEJBnF9RIrTRj7zGVVw3n4YI/hvbK+0876RMNU+/yRRaRqeaNACjKgBC0HwRDnx9RsJMhvau0kJYx9Rnw2x7V2Zfh4+ijUqonP0REdKJxY80x3HBaY1Y0jBwPMqwgSw890dKGGulPKqhxy4iucAqyhjNk1V4/URrgxrm6AAs7ighyt+TLDRv9NETFLdS9Gb+V7HasI970e8PUGoB7ZLX/LStvY3sYzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dec5350-0b4e-4145-0c8a-08de1b399ac8
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:32:15.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBGZe+R4CtTaZ0/N36w2Y3ggw+eDisnzKLpWRGJzV/hJ4a0yYhksk3w82OINd/pVAFhTVz5kMvJkz17GPyRSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2A078470E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040002
X-Proofpoint-ORIG-GUID: 0Dcnm3ZR8XOrm6rU2vrpM_F2TGdKQ2A4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAwMiBTYWx0ZWRfXyh5BYM3+69Px
 fnNPECqhD6aUohsQHI3OuebQIaivDinOAhA4ypbGSOmGOpYk6RSkP9qqAp/ag2k0gVQoWqY7vrR
 YIW9kdBMrKQp2apvuNFmE27R1PYGWoLpbMCAAx1GymWDAPmz/CCbNDJ9YMHi8SY9fchdIFMY1rm
 nVbPMRYsMvc3PoZIALJZm0QjDydQBKYCovFZC5YywzoPsDLcmkieNLtZfCADeeyWObR5QMvQQgq
 bLBZJ9ISULZrCzx/XY5UTbpOrODNJpL1haumHptKjWKk8A6hdtl0JiT1qthh74tVYu/Lg569SXA
 vyYtrYJS52s4KPnYc4nMDkR2qPaSAhx2E1qBmfu3qwDvM7+MYVov5kEXXEMnG8mZEaQ81jUb3QV
 VfyxcuWqvqcvJGyuemITO2U9p/TK6A==
X-Authority-Analysis: v=2.4 cv=WsEm8Nfv c=1 sm=1 tr=0 ts=69094995 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sIn5yVyurPdKi46oYccA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 0Dcnm3ZR8XOrm6rU2vrpM_F2TGdKQ2A4


On 11/2/25 7:40 AM, Chuck Lever wrote:
> On 11/1/25 2:51 PM, Dai Ngo wrote:
>> +	TP_STRUCT__entry(
>> +		__string(dev, dev)
>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>> +		__field(u32, error)
>> +	),
>> +	TP_fast_assign(
>> +		memcpy(__entry->addr, &clp->cl_addr,
>> +			sizeof(struct sockaddr_in6));
>> +		__assign_str(dev);
>> +		__entry->error = error;
>> +	),
>> +	TP_printk("client=%pISpc dev=%s error=%d",
>> +		__entry->addr,
>> +		__get_str(dev),
>> +		__entry->error
>> +	)
> Have a look at the nfsd_cs_slot_class event class (fs/nfsd/trace.h) to
> see how to use the trace subsystem's native sockaddr handling.

The native sockaddr handling used by nfsd_cs_slot_class seems
to be broken:

[opc]# trace-cmd record -e nfsd_slot_seqid_conf -e nfsd_slot_seqid_unconf
[opc]# trace-cmd report
CPU 0 is empty
...
CPU 15 is empty
cpus=16
             nfsd-2784  [011]  1205.355839: nfsd_slot_seqid_unconf: [FAILED TO PARSE] seqid=1 slot_seqid=0 cl_boot=1762214337 cl_id=3172331794 addr=
[opc]#

After changing 'nfsd_pnfs_class' to use native sockaddr handling:

[opc]# trace-cmd record -e nfsd_pnfs_fence
kworker/u65:0-7458  [001] 933.253811: nfsd_pnfs_fence: [FAILED TO PARSE] addr=ARRAY[02, 00, 02, f9, 64, 64, fa, 2b, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00] netns_ino=4026531833 dev=sdb error=24
[opc]#

-Dai

>
> Do you want to record anything else here? The cl_boot/cl_id, perhaps? I
> guess there's no XID available... but is there a relevant state ID?
>

