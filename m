Return-Path: <linux-nfs+bounces-10100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8CA34DF9
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 19:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F87A2F3F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D094428A2D4;
	Thu, 13 Feb 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fXsbfSdP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pkYHvc45"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC302222D6
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472453; cv=fail; b=FI9scZlfM8q5m8YjKis2zTRmYWLSGrDhIAVazqyGwdJpCxD8wOfbl0voVj1O3MpHmXWYYDk3Aaip7BbjzT5uEqyh82tX6DxsOWMW17gLu7PSq7mAGsOjwSfQ/z7QCs6642Og7jn5ATCWD++eTaE296oQbnnL+ytvoRmF42Wp8y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472453; c=relaxed/simple;
	bh=ajiNe3yPLeaGZRee6CqlxurzVC/26paSKb0pza8tbtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fNVXJyjD9pFLZtCERfIN9LznGa19BCzuoqsY/9NU2FfFc5gNmN6OdJL3Rmo95E4aAEl0Ay6joHdaIXMyf4YQISTR2HeXAbN28hsxizD2RVTWiprzKkfDLws8Ho1jNyYqVF5uxVi+ih1mnWxAYsg964g4+EVH/98LIt+Pqk27luE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fXsbfSdP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pkYHvc45; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfYP8027473;
	Thu, 13 Feb 2025 18:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8v5QFTYa+k1g6hDJN6445JvWpGo4mmgBui2H2jq2r8c=; b=
	fXsbfSdPumV1o0k/eGtkB0uAkS8CLEK1KiXLJIRKdqpC12QNsU1TF5Dzdhjb26RQ
	hC94vt04feGWCt5+FOTFewIHlSdBTts63JUOx83IEVKHjjZ5iT/rJbYEm7582HpA
	mkgdm6tzTynCfvkSzo7DxDtqb/QWjVKXbSMOtkIOrRZnK9uAi2rKpSLrlulvC83F
	Qakkoh6fwAwq2ng5rj6jyEXLiOGAwlDCPf8Et2QN97ztGdjsodq4/T1Brj8rd5dN
	0SG7YBa5ICLhODgFXLcHSYCwzeH6uLaphAKaWm2pnSzUxZ2qis8n0b3LcSbjPIYI
	tdyqQsluatbUzParmpEEug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qaj74t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:47:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIbbOr001156;
	Thu, 13 Feb 2025 18:47:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p632j2g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUO3f7hEGKLCvgVU+/u8smnPLHI60hOFuSPgPOd9jlPXCBC0iipH3nKlV99f06l7oBX1eJ0Xn2NbeNrljDg5SkTswnaAV4kVmHgDhA9R39zxYOEowQZwf8n7kibsarMtRVtEqFD5H8iMl3KxMb2o9mor5CGace3kHUTnI1AgAu16vxGwMDcMtCgAyApbbKfoqXULYlS7bSDf3edDMat8wjD/wx0GV/OCgGW/upO7pNgQ0hIV0wkLimfOwG1wegTLpPtDOf1mg7z4TML6hzeaD0KA6iUL/2nUtDmHRlkFt7X36oMQQLAvaIvfCHaYczhg/4usnmIgte9a6GHuuI8AFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v5QFTYa+k1g6hDJN6445JvWpGo4mmgBui2H2jq2r8c=;
 b=tw1BP+ToxvoZUoBuQimlCi+dj2XkUSbC2qSOtXoX92K/uaXJJnw99HE2XpytHL0uXYDlacm6NZvftDoVKpOFqE122GLu+uFwyumFd/X9DpuudsBV9S+LSVLXwASoZkTjRtHrd9GhPm0wXtChwb0Xsm3IXAzew155UxrotFXAELOw6S3mXKGjL3rYe84NDmyRzh8POKVZoI7u4A32ueIvPZ15aHK52pqHRuNo8XLKZ3RGH46y3N48kCitTgA9KlaJ9cOcVCLGabvmW3m3WpxHivdbJEtT/0zp48FcMbrLH5SSecbhkar/ym2SYRtUjjpZKTlRtlfiaxaJGWfVXr7rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v5QFTYa+k1g6hDJN6445JvWpGo4mmgBui2H2jq2r8c=;
 b=pkYHvc457XYGF2WLDmC1uMeTZ//+yL6paI/2+fq2Eje4P63H4iyvkrdbC4hA9lskhteya46sPqP3l/luYY80wIhHwN6kwcKJG9Q2CbSj4WieYbPaeb7wOgYeNNV1sk3X0BT4jL+B7erFgJBuWvjk7QBFkRBTHZi5UDG33s41UwA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5826.namprd10.prod.outlook.com (2603:10b6:303:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 18:47:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:47:09 +0000
Message-ID: <12784b78-d053-46f6-b0e3-e81ca2e90269@oracle.com>
Date: Thu, 13 Feb 2025 13:47:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
To: Trond Myklebust <trondmy@hammerspace.com>,
        "aglo@umich.edu"
 <aglo@umich.edu>
Cc: "okorniev@redhat.com" <okorniev@redhat.com>,
        "cel@kernel.org" <cel@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
References: <20250213161555.4914-1-cel@kernel.org>
 <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
 <CAN-5tyGt4OhqZbzzADe9OumbaThrefZ1nTw=_wrrxy7FWfWK9A@mail.gmail.com>
 <18421def0a2aa132a6817b56f97eb9d6f3928727.camel@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <18421def0a2aa132a6817b56f97eb9d6f3928727.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:33::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ff703d-3478-4916-1284-08dd4c5ed26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akRRbC9ZZ25PdUNmLy94ZGZvdFdMd1NVaTR2cnA2WnFhREpLdDJ1U3oyQ0FG?=
 =?utf-8?B?T3JQNnl5U3JTOWt0K3N5YTIyVEdhRnVaZXdkeTduZ0ltSzhuMXNBaS90WWpu?=
 =?utf-8?B?VHU0bGl5bFhhRERaZGE2bm42alVpUXp5RTZtVjlqM3RVeUFyRVdWRU50NmRy?=
 =?utf-8?B?Tm5NYXdFUVdRck02cjZpNFBDamNpODlyMGRpL0NDU1VrenNGS0pHVlJpNk4x?=
 =?utf-8?B?QXp2YlU1Tzl2L1lDM0tka3hma0txbFhzVW00dHlQT3Q4RUdwWEw1ekN3dnQz?=
 =?utf-8?B?NVNubXN1VkJZVmtJK2M2RWVyTkc3QWlYdWc1L05HVS9kcmFsSGgwZlBQaGEr?=
 =?utf-8?B?WnNuZlRCcFZBT2hmVzBUV0hjdXdna3FobkJqYTlSRXkrQVlZVFg4Qm5lZEhk?=
 =?utf-8?B?ajNsZmRVZVNhREZaRnJrOU1FN1BKeEt0UytuWSt1OTFob3VZWHdxbnhjZUky?=
 =?utf-8?B?Skk3ME9nVkl2Q0dIMGhXb09NS3hrY3VWT2NSWTFEMERJTktDbEorMStqLy82?=
 =?utf-8?B?ZWVoMGlpWmQxb1hKWWdQUjFHSW11YTgwRHpTYm82eHEzYktWVWpJSWZNK1hh?=
 =?utf-8?B?Q0dmU2RYVlF2cERGd3g2MnRMR2pMMWxRMjk0bDZ6YVVTMFNXQ1Voa25DdlNh?=
 =?utf-8?B?VjBsL0h5N0pQNVZibWNuWS9PYkNNWFlIVXdqMytzK2dadTJMMVlwZEYxSjcr?=
 =?utf-8?B?Rm5NS0dtMnVqTXJyT3ZLdVgrS2V0V2lySGZWc09zMStEWThNUTJwWEFOK2xz?=
 =?utf-8?B?YmxjUkN3TXoyN0dLMFR0N3ZxaTFpM2RmK2JOZGJiZ1dwTDVZdTZ0V1ZpRVJr?=
 =?utf-8?B?cGNXMExuUVNqMU1FejVMZ1J6NlYrK2xoQkdTYjBBRGNNcEdFK3NtUU9rNDlR?=
 =?utf-8?B?QmQ3aE13NjhMMkp1N29ieHh4aDc5UWFEZTRwV2FqRXBHZk1ibktYTHlYcmhM?=
 =?utf-8?B?STdtTGpETVBKRCttb0xvNzhVWFhnOWNwdHo0Y0RxZ0lHSFVHSFo3K0JHZU1a?=
 =?utf-8?B?TDlNcXFaQ3pBaDhEUlBHNlNpNy9SSXNWU2Z5MnJaRTZGVGc4MkY0MzZhSEo0?=
 =?utf-8?B?T3hJOEZOa1IrVlcyY3YySHB2M3dSWXk2Rk9uMEZVOU1JWUZ2OW1sZkNGM1Bi?=
 =?utf-8?B?NXpiNWVWeGlkMFpkeDNyYW5wMlpZNGNhVWZjc2crMU1YWHg1SFdnaFhUQ0Z4?=
 =?utf-8?B?RExsK2diNTdGYjRJVG9sZ0xTTHhDK0JZSUF1d3V2QlJOOStGRHFackFwKzdh?=
 =?utf-8?B?QWF2Nlc4eko2SkxOMS9vQklxVXBuUWdlV3ZlK2xUaXNNUEI0SE9HUEVQM0JV?=
 =?utf-8?B?Z2IzQVIvdE1rNGFKY3dPeG1SM2VTYmRSc3V6bGdRUElPZDRaaWNJc2psNnJi?=
 =?utf-8?B?ZnAvQWxENVBhTHJQYk10T1pBTVB0VlJEajJpT0hnc3gwYXhUL2lKUStwUGR5?=
 =?utf-8?B?TFVKaFFrWTVVWjNGQWt1MHR3QmlqdGd3ZUdYWlhackplT0ZRTEpKVjduakZJ?=
 =?utf-8?B?dVFMUnE5TVZ6bjNXVkpDZUoxY01EZTFzZnpTamNBdGdvWUxDRkNxNksxaDNI?=
 =?utf-8?B?VGZVQzBpMGFlbUpUTTl3T0oxWFc1N1pFYktXcWgvMC9VUy82Wm9CSWx3akQz?=
 =?utf-8?B?RDJLbHhHR0pYa3FQaXRKV1R0T3p0N0FpM0ZRUjYySnYvZmw3dlVBTWlqRzFS?=
 =?utf-8?B?NDJOTU1JTmwyK1VkTFg2YzhiTXJQSXdpSzIxbUY4Mmo5YzBwY2hGTjlHTk9U?=
 =?utf-8?B?akUrTEZqTGpMUlIweXZMZzNKTXllaCs2Zno0dTJkczNTRGJCdzYxcVVhbDVq?=
 =?utf-8?B?eEZxcE1IZlhUQm5WcXVQSnNiZzV2NksydEp5N3hCUnpGV0xRamZ3Vy9vWHVk?=
 =?utf-8?Q?4myMOvG/MXsnq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE9UQ0t1UnFNVCtubWppZnBhbHZiU0ltMUxtSXJLQ09TUzJwdmt1K1EzaTA5?=
 =?utf-8?B?TlBQTnlJdjBNOXNyOFNON0laMFNNUlErRXRZQUNieFpjYVZLMjZrdnd3OVlN?=
 =?utf-8?B?RHIxM1hEcmdFU2RLUmMyZmlOTVJCZEFuVFdoK2tzd0pXYzE0L1FnOVY0Wm5r?=
 =?utf-8?B?SzVLc3k5cmtzS0ttQWFObCtLZ3p2QTNBQVcyZ0g1cnRQZkozbVd3Uis0MGh5?=
 =?utf-8?B?TUNMS25sTGtubFl4dDBPSkhvZXg3VGM5ZEs2c2lBK1ptYUFVSTdOR2ZVbmlM?=
 =?utf-8?B?a1k0VzBmSjdiY2RHdmhtZGsvaUFsTjNUdkVhUnNwMnMzdjN3QWY4eWo2cHBT?=
 =?utf-8?B?VHBPTkVtMGJMcTVkeWVCdDZXREJKUEdFaUw0TVdaMjJoWXA0U04zRzJtQ1NO?=
 =?utf-8?B?VTMzTkkrL09UYWk1NThKK0h2dDUyeTVYanRYdU9ER1lZTUV6RXY1S3VLbEdJ?=
 =?utf-8?B?azJUWEltTHBMTDV0VUpHOW40T0hjVGpxYVhYM2FwM1BlZStzK3ZXYzI2WnpZ?=
 =?utf-8?B?TFA4VWdwLzV2NGhQc0xQa2dzbi9NY0dCR1dGakRsQm0xRmpCZEhkL3pwVU8r?=
 =?utf-8?B?T2xoVXhET3Nvd1lqSjNMckhMTmZweTI3amV1MXEreFRiQVNxSWxBTE0zdEdB?=
 =?utf-8?B?ZVlWMVJKRGJkRVJGNFpJTW1CaHpUMDJCbU5OT2VwMThBY2owaVJlVE02TWJT?=
 =?utf-8?B?SWszSTMyejUvNWVFUmVNSUpncDFIRnA1dzQrSmpmci83cDJVZTdUTm1jRGhM?=
 =?utf-8?B?aVMxVlFRU2t0aUNPUUVqYmdJZWRZM1lJc2xOUSthWE9VdGVlSVJ0UXA5WlJN?=
 =?utf-8?B?bjh4S2Z0NmJTcVNKaFRxVHNPUWJCRXFjMnZmb0I1WTQ4SWhkaUJEVmxjM1RE?=
 =?utf-8?B?dmxpcUhucm1mWStId25Ub1ZzVmdrNEp3MElrYmdhY25xNFNtUktPR0RRbnhj?=
 =?utf-8?B?ODByTityMmNrQ21PcDVGYkR0azIyb0hvOXdEd09PQUovUlRCVUpYa2gxMGNx?=
 =?utf-8?B?YktLQ2graFRaNWdXellsZEpBMmZnbVlWVFk4WHlUcC9XRUN3bzhQcTBNVGpD?=
 =?utf-8?B?T0lSLzFpL0s1b3k3cytJVER3RnlCbHpnaFdRd3Z1elFCSElnM2tLUEZqMVN0?=
 =?utf-8?B?anhNRlFJY1RCc1lzc05BZ0lqOEFJY1NZWkRoMThxS3dBOEJZNG4zSlpXRE5z?=
 =?utf-8?B?V1NoZTZ3ZlRrb3VoRmZTWEFWRXhUSGR4ZjNOTklRemlCRUlzN1pEK1E5azhq?=
 =?utf-8?B?VHdvajl5Wk13NFJDVnJDeHFHZWpUTEdxZjFOREJvVVZEWjczSTYxdnUzNmVO?=
 =?utf-8?B?amxiMmRYV1hwMHVMMHVsWmxuQjQ0dmhkbWNscEE1TVBNcDVvNkZwaldMeWVI?=
 =?utf-8?B?N0RDbDllVDBFVlZ5Qm5mNHVZUEcwb1ZnUjJKSHhlaWZROEJQWk1qcy9SckZp?=
 =?utf-8?B?QUVNb0pKRStWT3RCc1JOeGdqalgrbmZPYmtIL29yQWRORVRpNkhzYlhJWjl3?=
 =?utf-8?B?RFFxbDVYcmlKMUNraDIxQjUvYWhMSlYwYmFkWkl5WEh5SHVKVzNTM0U3YXBl?=
 =?utf-8?B?VUVBcXpJN09ORWhubUR3UzE5RVBjTlM2YXhKaWpLMTE0UXMwa0krR241cWg4?=
 =?utf-8?B?YmE4cTZoZUVJYjViY0NIeklqMUt1c0x6YXJTWEdDeExDR1V6T3p0TXBrc1Ax?=
 =?utf-8?B?MVJ4WFUzYmNBMHB2dW4wQURrL0RLWHFBTTJvcmZsSVlRN3lPN1YyWUhpVkFU?=
 =?utf-8?B?S3VxcjlyQndsSW1xK0dwNmRNWG0yUnZoQmNjVkpCdnNvVVpoWDFDaFdQdkpa?=
 =?utf-8?B?QXJSUnk3Ris0VHhpMWErY3p5Qmg4L0l2RmwwQldHYTlsUTh0UXV6M0svZDVh?=
 =?utf-8?B?NmIzL1NyakNOeEw2S2QzblIwOVBmTXJxdDh5NmJzZ0RuL1BIVVc1cmxndEVX?=
 =?utf-8?B?blpaSFlTcCtVaDQ4ZXBaQ2R5M093MUpvNVE0MVNPSDVIZ0p0QlgzcTcyRUkr?=
 =?utf-8?B?TEh0Wjkrajh2VzFQRjh1S0dJaGFUZUU3Q2R3a2g2WklYbEJxT3NjOUR5TkZY?=
 =?utf-8?B?S2xvZnEwa3M5U2lUeTVDQ3FwcU1NeU02MUN1aElibWlWZTdqeE5pbWZUQVhC?=
 =?utf-8?Q?C1/3dLLdnSjcRD8XHXHhXBkar?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ztl6WwO6vMIr6DwZ4W+CDxGLQOpwFH/l7+U9utnvwEEFnvZXHzXHEcPpQMXgHGLDeZ/FsSEKIqggdKpkW8vlj45XGHZbBzFipDO19DI5MbfKornfg1GGaWORboO+jgAaqTsQOO34mxrM/d6z0tmZUJ5nm4AHchMPaF5V07H9+19gVlrZgB4xY/Ittvw7r+NAH6eNk7FFsgyXUJqOKYyNjeHnM0JAcGsUiHb3K3NXhBaVCAYZNaNwDaGhwgNqbrXzwNMXNg1eVY32IBrPi5H6Fns0JO7vG2MpkWpziqpWgkmaueAheJemdEcpNW/Wa24FS8A73Yq+8KfF2Cqahu49imVqJJd0AfVkpEs9d06OdndWqUASqrLEApxI6hfaHM5RGXo1HOkjU45bBMRmLFcJDD9EiLN7nGeQmgcyXilSFfeurtaAiqdSvNFRMS8rWKGUc0e0stirZGpbd9ean58sLE56iT/yvgWetNdjVwV1eJRLpd9HOgd5OkKrHZujcTdDT51ZjmfGbsWopvCrXE1VoC8qhRKxAi2Yuz/cqoIR17ti/k0ha9fc1SJJKzY264aa9yKLAZ6qsdX6778VrmZT2dw4VwuuvZRGG831M99bnYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ff703d-3478-4916-1284-08dd4c5ed26c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:47:09.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RF4RGvOxafGeTHGGMgJ36Ntwg6SrwEnxXNPNQPRUhHhPz/jm6R0awFA4f3S/Q4TOEmcFeNZC6JjVTKvAtMsBkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130132
X-Proofpoint-GUID: mempCaiieqqoSGL7zAIzqsrz9vVkuS4b
X-Proofpoint-ORIG-GUID: mempCaiieqqoSGL7zAIzqsrz9vVkuS4b

On 2/13/25 1:44 PM, Trond Myklebust wrote:
> On Thu, 2025-02-13 at 12:53 -0500, Olga Kornievskaia wrote:
>> On Thu, Feb 13, 2025 at 11:59 AM Trond Myklebust
>> <trondmy@hammerspace.com> wrote:
>>>
>>> On Thu, 2025-02-13 at 11:15 -0500, cel@kernel.org wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> The NFSv4.2 protocol requires that a client match a CB_OFFLOAD
>>>> callback to a COPY reply containing the same copy state ID.
>>>> However,
>>>> it's possible that the order of the callback and reply processing
>>>> on
>>>> the client can cause the CB_OFFLOAD to be received and processed
>>>> /before/ the client has dealt with the COPY reply.
>>>>
>>>> Currently, in this case, the Linux NFS client will queue a fresh
>>>> struct nfs4_copy_state in the CB_OFFLOAD handler.
>>>> handle_async_copy() then checks for a matching nfs4_copy_state
>>>> before settling down to wait for a CB_OFFLOAD reply.
>>>>
>>>> But it would be simpler for the client's callback service to
>>>> respond
>>>> to such a CB_OFFLOAD with "I'm not ready yet" and have the server
>>>> send the CB_OFFLOAD again later. This avoids the need for the
>>>> client's CB_OFFLOAD processing to allocate an extra struct
>>>> nfs4_copy_state -- in most cases that allocation will be tossed
>>>> immediately, and it's one less memory allocation that we have to
>>>> worry about accidentally leaking or accumulating over time.
>>>
>>> Why can't the server just fill an appropriate entry for
>>> csa_referring_call_lists<> in the CB_SEQUENCE operation for the
>>> CB_OFFLOAD callback? That's the mechanism that is intended to be
>>> used
>>> to avoid the above kind of race.
>>
>> Let's say the linux server does implement the list but what about
>> other implementations that will not. The client still needs an
>> approach to handle CB_OFFLOAD/COPY reply.
>>>
> 
> There are several cases that need to be handled. Off the top of my
> head:
>    1. The reply to COPY hasn't yet been processed.
>    2. The COPY is complete, and the state has been forgotten.
>    3. The stateid presented by CB_OFFLOAD is one that was reused for a
>       second COPY request after a previous one completed.
> 
> The client will want to send different errors for either case
> (NFS4ERR_DELAY in the first and third case, NFS4ERR_BAD_STATEID in the
> second).
> With csa_referring_call_lists<>, the client can easily distinguish
> between the cases and return the right response. Without it, the client
> might end up returning NFS4ERR_BAD_STATEID in case 3, or NFS4ERR_DELAY
> in case 2, etc...
> 
> So in practice, we want all servers to do the right thing if they want
> to avoid confusion over state. The client can't fix these races on its
> own.
> 

We are currently living in a world where all NFSD-based servers do not
return referring calls. I think we need to understand what the client
should do in those cases.

-- 
Chuck Lever

