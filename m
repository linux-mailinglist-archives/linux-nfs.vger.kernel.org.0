Return-Path: <linux-nfs+bounces-11922-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75535AC5192
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 17:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81E27AC18E
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9B8126C02;
	Tue, 27 May 2025 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ESSfwOZ/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PxkoF3l/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A792CCC0
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358352; cv=fail; b=K1IsQjbgkQrgSV9ltvLEFlf6ikhbIL5zbeqXnWl5uPmTQ2vmPGWttEbfLPo9QcUH4+1jKKwivYYj4tXAZGX7029NC3J7x4mRiDcKNgLeAa+rxObiJOkQgnkOAGWxHtR1eX9yKyFXGXx10R/k7t6hB74g8rFHAhzP8Knlcw/8RdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358352; c=relaxed/simple;
	bh=5Qb7SV/smvFKlAsYCwUJlvcPHStk6zoWzH0tR6GKsqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eJt1YMEU71c8Knv7UXdQWk1kGmVi/kDE31crTz/YlqJGP/y8rVW1olt0L4+839imwvTQyLBj35uJuBIDODV3thRuXrylIIqxrQ7SeyQVlSFBK19TcCwqPxb/qOK+MYe2jas3tmlhyvdcDR/PPzBFfbegyIIudI10B6GjXAe607k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ESSfwOZ/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PxkoF3l/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCjeOl011700;
	Tue, 27 May 2025 15:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ys9Ekj70lWs/0EZHNWIoL8eFwRoz3ccsxlDECSQ71yY=; b=
	ESSfwOZ/kil7pHGlFPYjEcegAT+x7nUuFm1AFttf5OeCoax9LNhsLgbLO6lfd5Qt
	fVZomfoG9TO5s+Agkph4LbTokbuGodI9+8WMX984EK6J/ZEmdLAy3o9AibpCPVNO
	zlLHljOiDFFUsuBzQLT0+jRDVovKn9WgujO5VhSLn+VLfLHAMvawroH+3kbzKEAR
	+8hBw/jM1ahsV4TiUfEnjCYHdW870dNUvXL8z/xYK/4LSOP0fZ9NCVRNR7VGRBNj
	PvPKAKL9sEyjhTFlcD452gOGwvljWiwy+1aDvLFCHHe6DWoy/yeUo3hXN9YU1O5d
	UL5MRCtyTJ1NF6O00TjsEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2peubhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 15:05:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54REkK32027893;
	Tue, 27 May 2025 15:05:39 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j91022-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 15:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRb8NK3dJtMivsF/qwPf81NNMmb9DVQ8i8r7a6wBaOGksDUjePAAABoDoK9bzv5Xl0S/1m/8jVAJZ5u8xQYcxF9z1GXGiXK6uTU2k4xzaA19bQIBXkI2W2tJ1TAiVQa6dsnSXhhLd8eEj8y7S2wzAQ55lN7K+Co80cLW+KqdjJsF9qdhWDiayE2uMscP0/uTpybAWkzFi/MKbCT7gHNGlQKGSUIqPNMOwDuCVzCYErSEKUe1zHbkXABu3jJrRZBTRXWOZkZDXhy7xyYBOyD9PIWAMObqw6DivgoAKkrKU6YFgfWNhcqwF4xFJIHnGJvfGoGOMgd9hX8MKwUeoo0Tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys9Ekj70lWs/0EZHNWIoL8eFwRoz3ccsxlDECSQ71yY=;
 b=V79zhru52q06fqE5SR6x8GWMUEozP9+fobnqRoO4LX2/iWgXfjEV2Q2LW7elIbk+TmubqT0q+X7Tiyk0IXUaVBwphmeKyPmXrdAr+8xayfJbWTGntXvuYuXqs4vM4bI+fZB0Vw2uJZpsPQd74BLGiNztxt8nraXX9i/wop8W/vglHUnALCFu1T9kYlKSGgQRw6lW9aZaiEVkJ2eHMunyvb4Qf69lAkIRf+9gRS5iz/T9KJBeyVYx3suZ2OUfUjeeLtpaiKXWxh6qKu57suAS4U33H9Fb8RBFWna9SL4V7DMk8jIo1x1kwLiVA0PIPhSQOnnpY702/GGUe/p+7h5tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys9Ekj70lWs/0EZHNWIoL8eFwRoz3ccsxlDECSQ71yY=;
 b=PxkoF3l/4nYogzKLobjGgJkxxLYIa8sDZgCAcQTMHboimr3iM37nnl6eYEPmceishwJrwPAGqWb2ahS7ktlMU/Mf9r87rhFGTm+QUM1LFfDITDctZzMmvdkz3iEV+NuStwZUxxU6iJ2eb4AwKF6cingbZnOsow1W8IwRJL0v8nc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7644.namprd10.prod.outlook.com (2603:10b6:208:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 27 May
 2025 15:05:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 15:05:36 +0000
Message-ID: <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com>
Date: Tue, 27 May 2025 11:05:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: NeilBrown <neil@brown.name>
Cc: Rick Macklem <rick.macklem@gmail.com>, Jeff Layton <jlayton@kernel.org>,
        Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org
References: <> <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174821817646.608730.16435329287198176319@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: a3934801-eec9-46a1-0fbc-08dd9d2fef93
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K1ZRdTAyakJDMkpCRTJzM3NGVUpmSDFWODM5TTJWMXEvcFBhbEFXbVFQMkZ0?=
 =?utf-8?B?b0YvNzVnTGFpc0hwb3JSLzlKa3RMZ0twaU8vTlh6TUkwREFEM2VNZmFQOTJq?=
 =?utf-8?B?R2hVKzdMelNFNHRSOXU3OGpFZjZLVnN3dFdkWUJTc0N3VUdheHBIK3krbEJj?=
 =?utf-8?B?ekFqMTNzd3o3RnBkU3dHWElZYVkxWHFEVjgrUzRUc1FKTThRbHg3YUhQQnZ5?=
 =?utf-8?B?MnE1Vi9rbjJpVGRpSU1sSnoxMURBWjRLbEFVV1I3SDg4QjdDaWNmajBKU3hN?=
 =?utf-8?B?ck1yYmFLbE9YMFRtVnBJT3ZuSk43SXNwR2p0VWJFSVErZVVxcnlKdkphT29G?=
 =?utf-8?B?Zk4xWlBaMG9qQ1VtTFl0WTJUOXFaNHl2U3ZCbFN3U2lnRDZxNVNOcEhZTFhK?=
 =?utf-8?B?ZE5Pc2pPMUUyd3pJOVFqbkh6bnpvN05kZ3BwRzkvdTVBemtxYjNFbU54ZE9V?=
 =?utf-8?B?cGRpR3lTaXZ6T2NHN3cvV2lwNjRqUnA1T3N1c05jYmFIcGJHSFkxaFpuM1B6?=
 =?utf-8?B?SHpSeHRKTzZEMmR2OWthZFZBWW9CMUVabS9KakJrenpMRVpSVVRFNVdjUXpW?=
 =?utf-8?B?Ynd3QnZKWVVSdWE3U1A0VlBIbUVuMEx6QlZSS0E3dGw2d2JacklyQWt3Yy9I?=
 =?utf-8?B?Q1Njcm9NNVNQdHFZT1VwSkQzc2ZEVVR0SjhsYjdWbUlJUzNldWVkYmpZYnNT?=
 =?utf-8?B?cnBQYWpHMDNZcHlzb3RlZXJMZ2VSVXgxaldtazNYWFlOTXdXSFpXdWZvUlhs?=
 =?utf-8?B?TVpNQ0VpSkROUXQwRFMwTjZkanRXb1F0L01zck1Keld5TG9DZ1lIZ0dUYUdH?=
 =?utf-8?B?S0NFNVdXSktIMVFWVTd0di8rVXNSb21udU04YU8zaTNBc1Aybk8xSEQyN2Rl?=
 =?utf-8?B?QWVGYzU3a3VBdUxNMy9qL0R5aEh3WXFXZWpQaDNRQ1hTZGZxTElBY1VsMHFu?=
 =?utf-8?B?Z2l1a1B2TUtpeVlFeER5cGpZdzYwRzYwUWtwdUJSVmE5Y3ByK1VzaDdtSDlK?=
 =?utf-8?B?cXFRWFVjQWRmd2dDVXN2OXdCdERXZVFuK0FydmNUd3BtckhpRFlWSTNFQVMz?=
 =?utf-8?B?SVRwMnJkS1pxbDBDZDNobkFIbUxtNnFldXlNeDRoUUY1bFZVZlBYQ3lIQ1Iv?=
 =?utf-8?B?cHlMSGhwNjRPckl1QjVHV1BRcFBBV2h6cllGcFVvNklrQlFYaVkwdzZvaUVJ?=
 =?utf-8?B?TkU1dE53WVM4TExYcUxzckRCQXNxRnIwSG82MllWK2NWaERtMGJnWFhZbFA2?=
 =?utf-8?B?aU8rODFDMisrV2ExSlVFa0k3MkFXT0pTclJLRzdTMWdIMnVmZitDMTE2Y0JE?=
 =?utf-8?B?c2hpMWRxSzFGcUdpQlR0NlVtRlhEbEZZcCtkcjZxcUYzY05VM0NvOTZ2Y05H?=
 =?utf-8?B?RjFGc1d4STY2RFgwUmMwdk9xYnFqWGZpU3Rzem5LeEhleXMreTVWTU9Db3JJ?=
 =?utf-8?B?RUxnQ1hGV1BDejNqaVJibFRMRlR0QzlyODk0ZDBGRi91OFB6cnpDczI1OWhl?=
 =?utf-8?B?cnlycmZ0d2I5TWJUd1dsNXVHMlkvN09iTDJQVHNXRGFuRU44dHY3bWdzNW9s?=
 =?utf-8?B?OGw2a0xlK0tOYlpyR09oaGpoQzg2eUl3aGVFblNkN09tTXZZNG9IS0kvSndM?=
 =?utf-8?B?aWxFRVZBcTBBako2QmhsVHIveWtBZkJvMjlUaWtnTHlsMU1mdUdxeHpBSm1H?=
 =?utf-8?B?d3d6WFRJSGNmOVErc0t6WE5DMnhGZksrVXN4R3FySnd3REJBQ3lIcCtTMWlj?=
 =?utf-8?B?OHY1aHNrSGhDTzVvcklDbml6YVdCUW1JOVZqc3lUcWxvOU1uaWRlRkhxUjRU?=
 =?utf-8?B?S3FmM2d0M1J1d0VqRjB0S2QybnRpMVJ5dEpNWENiWndkR2MvdElQK1loT3Vk?=
 =?utf-8?B?N3pWbnRGeEVHdGRsTUlTNVhjR2R2Qm85UzE5UVp6NXRYUHJFVC9oRlZ2dnAx?=
 =?utf-8?Q?6DFyG41CtD8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eXMyWkpKdWFheXVtdEJ1aXhiNXFYOHdadm1SbERIUXV3dkVXaDZ0TWMvVUIy?=
 =?utf-8?B?bExaMEtjWEEzWERCVFJYNmU3YmVNVlU1Z1hkSWZPN3Z0SG9TeWY0aE52QzAv?=
 =?utf-8?B?S1B3ZlNtdUp2UmowSVd2SzRxejBHVFFTS3hTVEppeFNISTY1YnhySTRURFUy?=
 =?utf-8?B?WVh3cXNlcnkxcjZoUk1hZVJLQ2RhYkplNGgySGRtRDZLMUEvaGlmcmFObW45?=
 =?utf-8?B?R2NSeUpBaGF4cnJ1eWhWTzQycXdUK0plOUJKa0JKMWc0V3p2V0E4VUNiVUJQ?=
 =?utf-8?B?c2VsRXY5U3I4ak8zcDdIUVpoNHBVVkowd2s2QUtPczNSMURNTXhGRHRVMmxD?=
 =?utf-8?B?eUd4YTNrWFNnSGlNZFpiNC9kZmpkeXBPeUNxR2d1NUlkSUliNEdvNnRBVlRp?=
 =?utf-8?B?b0t2YUJoYW9sSWxVbUdBd1lOZGEzdkFlTVNWQWpWVEFhd3E1RkJmSDRPUnNs?=
 =?utf-8?B?a3R5bHFCZzJkNFdPaG9BTDMzNmZmWk9DMjg0dUF6Q0d0Q0x0aDBrZm1QSEE3?=
 =?utf-8?B?bjJvUzI4bkpzdXMxdFl4cDVWcVpEVEpJWkVKaXZTK3dEQ3RlWHVuait1ODB6?=
 =?utf-8?B?N210djhMUi9oNm1OMlJGNjdTUzFWUlU3SGJzeTBBNWpiaytGS0VETHowaldH?=
 =?utf-8?B?WFZRUFBtdWJJbno1blBSQVZtaTRnRCt6QURJSENaeXZPa1pKd0tsSGUwNDAx?=
 =?utf-8?B?QTE5aWR3Z1FCZ1BHUnVOQnpiT1JnSXJreTFXRG5UNHdoc0xwUjEydFllc3hL?=
 =?utf-8?B?ZWdhVmdlNFZHS1VsckVhZU5OS1QzQmFlK0NPaGdObWRmN3JiRnJLNkNYTzFq?=
 =?utf-8?B?NHg5ZXBlOG5weVd1S2dYN3BzUGExajNLRkRER3RQdHFzOGhvNHpWYU8rM0JE?=
 =?utf-8?B?NitscDdJWFRvclFSSDBhQmppdHlEWTQzeVlGY0piQWhRbVF5YVJrMEZ5TFRx?=
 =?utf-8?B?anRmWVd0bFl1bnRaYk96ZXRXZHJsMmJaMEQ5bTE3TUZqdHZoN21BYlp1Rmp5?=
 =?utf-8?B?bXFFNVpoSEk2V3hPRGpwdHJYcThZcWl6MGVVSHpIaGFuaHRJbzJIOUhySThQ?=
 =?utf-8?B?eVpoMXJtZzZta2h0NWlwMk1CaFA1TGQ0ZnVtdXpNUGY4Y2JxZTZCNHR6N3pK?=
 =?utf-8?B?UDBUZm9lbkx2K0NHTG5GdGg4Ym9mR2VIVjlLNjVBc3A1bnVYbzU3elZGaVBS?=
 =?utf-8?B?L09rVG5mMEdiWHRKUzZMMEZ6b29WMUJ5dHFyNUNoL0NWWmw1RU1PNGRZTDdS?=
 =?utf-8?B?aEFYTU9rOTZNOTM4MkMyNjZJTnc0WVViTi83VHQ0cjRaSzNQTWxTRmp0OW1w?=
 =?utf-8?B?TUhsbm5lMGgrOFU3ZUtjOFY4Zi90d1lLV241cXlqU1hUaEswNGNBekhEMjA3?=
 =?utf-8?B?Qm0vMURFOTArVzZ6WUhlak9xd1lJSG1xalE2UU05dXhwTVRlQmJIdmNTNi9q?=
 =?utf-8?B?OVUyc1U0ZHNDVmpPWEk0UUE3V2cwa1lQaUFtUVR3V3Z4RitTYU5WU2FqcTA0?=
 =?utf-8?B?MFhITmo5ckhHRkJFdzN3anNEcml3a281dnNoczF6UVFzMGpmUDg0bEpZTktW?=
 =?utf-8?B?MTVmaHRIOFRLRHEyYXlyZ3NDS2Ryc3Z5a2tlT1NjVHdvUG0rbm5nQXQrTTN2?=
 =?utf-8?B?bFNOdDQrcUtUQXBBUWg3RjFEMnJSWHhJT3MwWDRvQjRkME5uaUpjeFFXRmRC?=
 =?utf-8?B?SStNcHVJNlFVaHFNZ2FXOG9TRm44S0NsbDhjZDBzNUZHODYvWVNwbU10M2RD?=
 =?utf-8?B?TitGTngzV21WZ0ZNSTU3Z00wTjlvaWlCSEZmcm1RNGdwM1E5ZFlnV3lGcU1U?=
 =?utf-8?B?Y2wxTkdBT0pyWTQ4WDJRdXBQb201QlZ0WVhVSStyWC9oL3Y4OVNHTDhlaXdI?=
 =?utf-8?B?ZTJNdFE5QUFmTldhMVc2NjErSlYwTUJEeEJpMlpaK3lWTVNTMFE5KzhSSlJa?=
 =?utf-8?B?WkhPZExGajR4U2c0enBILzBuMi9xOGlZRDl0NFRkODRlQXZ5TU5yN0RONXFX?=
 =?utf-8?B?QkxTa01RVUkwMTVQbi9ON2Q0N1dyYURBNmZaSU4zYmRhNDJ1bTFQVlVFa2l3?=
 =?utf-8?B?OGFUL0FNRFdORG1jYjdlcXcvREM3M1FJdVhIREFsTUhLdGdVVEdkZEhFb0V4?=
 =?utf-8?Q?AE0bzdVUb00DQuSv1mca2x1Jb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YCeBnGzrewhoJMSX5GEq0AEL+EvO4AI2bQeKdw0yMbx9XcKPNdKVrU8Z2YGn/GxP1dRUw7thB58+i61LZIFNimwOX0eJfEN4oKpdM0I8bzMQ47QrKLS2m761Q12o22Tg2mgsmMjGcYhbKs6Ve4OULy/9Vc04ApImxK9UGdW5BFyfSK/gSzGx8vPThfEEjyQNbxd2oX7ReBpMrG80iLcP9Dl75v99crhAADIEMO86tLhyftteqdnHjxQoAPMg0YefMkcsSiEJVeQ5pntCv/D+MEknl9KsiT6qFSrANeHqBwFTZPprIy1OhOnteBo4vDPt9uXWZk0pIHGnx/JFi3FJ1cyemyz6BQszw60sQHXPpewBNyVnC3HF+ts2WPAK6D4lkg62I6zBIgTmWcCtzW+0APjp8eE3lEGd18HBwknwaod1dnroFj6WE+jb/gpiCkId5KuQAmjerIzi+Kcs7kjUYMkUSmJVvbUMUrbT1n0Tq9zV+cz+I+n1e9IU3COOEtP6Ir8HHM/u3jwpWZlfxNt7Nr8mXCdPmZwORAWe03Cdvn2hGK7ktFC0K1wk5JWlx/Qr0eSpjr0imqD85XLcpHdbbqNwKSl1XHVYRQG9wUFEYGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3934801-eec9-46a1-0fbc-08dd9d2fef93
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 15:05:36.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z66zi51xm/VqpQ9ZfzGZ4idIGFl2pzucq/YxYbmQz6zJtZHjSSzSSBZffi8TNOaw6JzaRMkGIYH+U5cK1OdfSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270124
X-Proofpoint-ORIG-GUID: j4iX-2h8VicHnVm5iVBy0c17Cq0estBi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEyNCBTYWx0ZWRfXwaqKasefqyD5 Of3MqaNBN+G5S7ym/xgrYQEIqVJIgIT+9/u3G9VdbcWK0S8CXKKIavaDZWqUuMsjwl4HoIOZsbb B8i23ch7t+4lfF96OhR71NrrUtjlf4VhZ++ZAfJb6HlOYHFYGJPhW+WtIgGATKkof5CnMoFet/o
 Egpje1Z+A3VZpEuxEY4jm9bNRtsr1Jh+80PTpTWaSOftdlU/JZE+knB2MVnHRLPQiK+i9Gl1+Mm 94VG2yR7YcOihJZxAPVOHeoQ48jBgA8DUsAl/TyZ0b0SZKeU0YtUkKsoJ+WPuc3TjCRcxHGEsWH Eetusmll/8UbMNiSMJo+bDMnqrR95zQxarZ33n8HsEEtafot6IX+51th+mTKIdn+rk1V403Dqbz
 FqNWBpzCLauPhqaGOvNDFb1Xm4eKHrN6LWV15/JUYBqCqS4JN+Q6SBmJYofKWubF8VfXALOb
X-Proofpoint-GUID: j4iX-2h8VicHnVm5iVBy0c17Cq0estBi
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=6835d4c4 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=A1X0JdhQAAAA:8 a=XO1RX-ICvVMdU8ZT2ZMA:9 a=QEXdDO2ut3YA:10

On 5/25/25 8:09 PM, NeilBrown wrote:
> On Mon, 26 May 2025, Chuck Lever wrote:
>> On 5/20/25 9:20 AM, Chuck Lever wrote:
>>> Hiya Rick -
>>>
>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
>>>
>>>> Do you also have some configurable settings for if/how the DNS
>>>> field in the client's X.509 cert is checked?
>>>> The range is, imho:
>>>> - Don't check it at all, so the client can have any IP/DNS name (a mobile
>>>>   device). The least secure, but still pretty good, since the ert. verified.
>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
>>>>    the client's IP host address.
>>>> - DNS matches exactly what reverse DNS gets for the client's IP host address.
>>>
>>> I've been told repeatedly that certificate verification must not depend
>>> on DNS because DNS can be easily spoofed. To date, the Linux
>>> implementation of RPC-with-TLS depends on having the peer's IP address
>>> in the certificate's SAN.
>>>
>>> I recognize that tlshd will need to bend a little for clients that use
>>> a dynamically allocated IP address, but I haven't looked into it yet.
>>> Perhaps client certificates do not need to contain their peer IP
>>> address, but server certificates do, in order to enable mounting by IP
>>> instead of by hostname.
>>>
>>>
>>>> Wildcards are discouraged by some RFC, but are still supported by OpenSSL.
>>>
>>> I would prefer that we follow the guidance of RFCs where possible,
>>> rather than a particular implementation that might have historical
>>> reasons to permit a lack of security.
>>
>> Let me follow up on this.
>>
>> We have an open issue against tlshd that has suggested that, rather
>> than looking at DNS query results, the NFS server should authorize
>> access by looking at the client certificate's CN. The server's
>> administrator should be able to specify a list of one or more CN
>> wildcards that can be used to authorize access, much in the same way
>> that NFSD currently uses netgroups and hostnames per export.
>>
>> So, after validating the client's CA trust chain, an NFS server can
>> match the client certificate's CN against its list of authorized CNs,
>> and if the client's CN fails to match, fail the handshake (or whatever
>> we need to do).
>>
>> I favor this approach over using DNS labels, which are often
>> untrustworthy, and IP addresses, which can be dynamically reassigned.
>>
>> What do you think?
> 
> I completely agree with this.  IP address and DNS identity of the client
> is irrelevant when mTLS is used.  What matters is whether the client has
> authority to act as one of the the names given when the filesystem was
> exported (e.g. in /etc/exports).  His is exacly what you said.
> 
> Ideally it would be more than just the CN.  We want to know both the
> domain in which the peer has authority (e.g.  example.com) and the type
> of authority (e.g.  serve-web-pages or proxy-file-access or
> act-as-neilb).
> I don't know internal details of certificates so I don't know if there
> is some other field that can say "This peer is authorised to proxy file
> access requests for all users in the given domain" or if we need a hack
> like exporting to nfs-client.example.com.
> 
> But if the admin has full control of what names to export to, it is
> possible that the distinction doesn't matter.  I wouldn't want the
> certificate used to authenticate my web server to have authority to
> access all files on my NFS server just because the same domain name
> applies to both.

My thought is that, for each handshake, there would be two stages:

1. Does the NFS server trust the certificate? This is purely a chain-of-
   trust issue, so validating the certificate presented by the client is
   the order of the day.

2. Does the NFS server authorize this client to access the export? This
   is a check very similar to the hostname/netgroup/IP address check
   that is done today, but it could be done just once at handshake time.
   Match the certificate's fields against a per-export filter.

I would take tlshd out of the picture for stage 2, and let NFSD make its
own authorization decisions. Because an NFS client might be authorized
to access some exports but not others.

So:

How does the server indicate to clients that yes, your cert is trusted,
but no, you are not authorized to access this file system? I guess that
is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.

What certificate fields should we implement matches for? CN is obvious.
But what about SAN? Any others? I say start with only CN, but I'd like
to think about ways to make it possible to match against other fields in
the future.

What would the administrative interface look like? Could be the machine
name in /etc/exports, for instance:

*,OU="NFS Bake-a-thon",*   rw,sec=sys,xprtsec=mtls,fsid=42

But I worry that will not be flexible enough. A more general filter
mechanism might need something like the ini file format used to create
CSRs.


What about pre-shared keys? No certificate fields there.


-- 
Chuck Lever

