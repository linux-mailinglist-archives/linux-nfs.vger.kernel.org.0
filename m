Return-Path: <linux-nfs+bounces-10716-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D04A6A7EF
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 15:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976831B64645
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF80221F21;
	Thu, 20 Mar 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LMJXwOl3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tE58jxZB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0281EA7EC
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478977; cv=fail; b=FTeZcpdOfVXDBkCWurnLvwQgyTsFCuOIOcr+qs+ixnHswfoAx/ykR8/M7iy0pbWTzdx3xMQGuVynKjX5V4GNueJJfc/158S8ZtuPVCnKr0BkkLZo2/QNej7GAi5ulL9oN0ZLbts429xqr6pSCqwyJ2B/2jQbnaC1MxXKztZ9oj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478977; c=relaxed/simple;
	bh=LvRWqIUYE5HVi7DpTNUUT5U07ZBKb03D8D235rPp1Sg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AAmRbb6X1AJ20cKbB52zpKySiv36GfXeQ00+90zcQSAUc36VgHalNkw4w4pH4Sbd8ReWsmVon5csj9JqGylIRdk/RzHKUxYEpuh1ak63hivf2SRcJ1iUDfajQ61BFDorNNIjuDD80tDkhftOHzbgmTTfgXxKORkg6OljKh590aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LMJXwOl3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tE58jxZB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDMk4Y010401;
	Thu, 20 Mar 2025 13:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n4uXXwvT/r+7VB6CU2Lo3O7Bwn7T/LLQU28oQY8X0yE=; b=
	LMJXwOl3a6uSDmF+UyQTbgQH6yEQyzaK94/A6cRe9S1lLpxnJZUTJA5Eq7HExb7F
	Z5SGjcYeD/i6imhZwwyNbgJrMr0JqoaVw6ADDXWDygenlxoa0GCUbDBPnOG5tgE1
	BcRNiIM3uwiXcfPPJ5EhEkTwC/iS00mrOIcQuTDQnSXUwgKmXrvYxNrYt/L7YPAf
	PayxFUCroABZgJwx/OGFd1HVwTPztR0n78Xaqk10VRtoggmpJ3J43aviK1bjyUcQ
	t5rAV4FX0gNG/O3+liFMvjiiLH9NyzA6bikLtmT/8DhfH8Oo94BnqpZv43ShlpOM
	wF1aUKcytIIs+eU/3PrLag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m16a3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:56:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCVKAV018667;
	Thu, 20 Mar 2025 13:56:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdp3vks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwZlQ9fScmF0wDtX8rkX/yXEz6n+Ok8lwMzGT56gJGarrrDJU23QkuUCI6LAxjtc8wGPv7tqIzFzzEPIyk9bSfoTqAXrONDfynOl23mcdww1LM24u93L6Yj3WHms6YXeMbdhnYS8vRTaSJ1CSjDGVUXg1PROV+ev3sd6hJMM4XfRTJwj2ScYgXlKH1N2lp6yjsjZ3AWhRyYDAwdbo3ZxTG4HnpN3b0RgMogeYwZdy3FP8zG6FB8xbzBQ6f6NBDYSLfAMYo5+/YP1vJ/bFBNVYuQjt5Mr6Td9BwtD2FkbvaLxiuDfoTNlLKZuSPMAOJ/YyjnSyf0JbS1J658F1zLWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4uXXwvT/r+7VB6CU2Lo3O7Bwn7T/LLQU28oQY8X0yE=;
 b=lPjtD9LUhSJCgUG9XdK6OJUZHDAJJ3lXGAzTyw9ElGl65JyiBqgtjEdQIUPzMrHpRFQHoEzGl9Ij70v+DtEEhevUW3UHUitWAFhfkUCQgQuLYK7X9h/ZhPhCVDZeZG3raeZJXT2tXHetLWJD47It87mGcF0qaGAGaXhEtkWqKyUByEwQ3GZLg7dlSHng5RtGWgMzB7H8PEONQkIVF1rHUPoBihor5RlsSjzCBKk7CLx7J2651LU9SR9PPzcZLrM/1MvVhq11fqd0wpWKdjUeLM4iBaMRUp0MRGRfO8XQA2N/mX9n+WjHU8dttShHmePE9XBmfaQQ5xeUl0ymMjkUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4uXXwvT/r+7VB6CU2Lo3O7Bwn7T/LLQU28oQY8X0yE=;
 b=tE58jxZBjICQRGORW1v/hMu7m4NZZLbJAhjSmtaHzrHL5D72H4BGmAV5i2wThPzYVNWAVyl9EUQmgZy+lf3kTeLV6o5gzpSKEl/YQPydKYIktXpUZ5N0gXvREMLvTsKH64a3Kg/1Y5wUY0jATZLkCz60FjJ8FRRVYLEZckMEkQg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5692.namprd10.prod.outlook.com (2603:10b6:303:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 13:55:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 13:55:58 +0000
Message-ID: <c8262248-2dcc-463e-b76c-7beee2786171@oracle.com>
Date: Thu, 20 Mar 2025 09:55:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: fix NLM access checking
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org, neilb@suse.de, Dai.Ngo@oracle.com,
        tom@talpey.com, jlayton@kernel.org
References: <20250319214641.27699-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250319214641.27699-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5692:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b737265-926b-453a-ecdc-08dd67b6f0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2N1Z0w2TStvM21TcStHY3Rub3B3eTVmVC9UTENST1ZpeVlwRmhIQ0Z5NGZP?=
 =?utf-8?B?b2NJaTlWTlora3g1WWd6RTlZcTgrMzd3b2hNMnA5V0VTQVlCMHVJUDFQRWpK?=
 =?utf-8?B?KzE4RzZCcERMdkdwSFhuWlBWcWNYRkw0T2tyRXZnSHJWOFZPTGlVNk0xT0o3?=
 =?utf-8?B?bU02TTZDUVBoTzJheUZTZy9VU2pOKzFRcC95LzA4WG1RTE5ZYjhRVmdSUEJZ?=
 =?utf-8?B?bDNPTUZvdHNMeUFoK1Y5K29vS0lXTHhKc05EU0UrUWdURHFMbE12eDhyMjRk?=
 =?utf-8?B?RWl2MDMrQTlGTE5sejZWckJFZythL3Vrb3FJckl3dmM0QlZkNDFmYm82MDc5?=
 =?utf-8?B?b1lQeklITlIzUWpXVlJDcUFjOVZlUlBxSm1DbzUyWnJoMTl0NmxibWZGVW1v?=
 =?utf-8?B?cDd4YjhuYmM1L1VraE0rbXdEMThxeVFUVzg3a09pcGhRRzd1cFQ2MXlFUXdP?=
 =?utf-8?B?N04zdXBVSjFpYVdwNjA1OUpuNHR3RDErVmxlODhhdE9RS25saFh4Q0dxM0ov?=
 =?utf-8?B?eVprc1E2M3IwczEzVXF5SGdKNnZUSHVpc09VdG1EOXRwcXh2VTB1cDM1S0tD?=
 =?utf-8?B?eGIxTXJyaWFJMDAybDZySXNQc2I5TU5QWmFvN050MWR2V3JndVFiRW52YjJS?=
 =?utf-8?B?bm1ubGpHM0FKSUNhY2I4U3RlUGVGTnJ5T3lFcXdHSDRQdndBeXFLQ0xxSDlZ?=
 =?utf-8?B?QURNMFpKNVdlOGRGQ08xS2EvUGtGK1MydVpza3gzUzg0ZTl1MlZScVVMMjVH?=
 =?utf-8?B?d2xEYjMwN20vaTkzdVQvY1JsVjRBenFnSXJ0Y2wrRktYMGFhaG9NaHlucjZr?=
 =?utf-8?B?Y3NuQk9PcUdaelpPK3lZUjNlM3g3eldlaHBybXdXU3p1TE9tQzAvNnhVQ3Ev?=
 =?utf-8?B?aFE4bm5UbFNXeXBuWWhHcWZUS2xYRTN3cXJBRXNzOWQ1TStCV3Q2bThQeFJF?=
 =?utf-8?B?UnVqYnhFRTdxZDdXdGNPVjlNdjV6QjM4Mi9va2Y1ZkhuQisvYkplbXh4a2Jt?=
 =?utf-8?B?dEhyU0JBR0RIYlBJMEpTNGtEa2NUSUdyTFJ1VGoreDhwN0hUK1JaVGZUakRo?=
 =?utf-8?B?RXdrRWJGYlNOQ3FVTzcxVnlMbmtmUVovT3VDMlZRTHNlb1BpV0tvbXQyY1Ju?=
 =?utf-8?B?NjdHMHYrUlFaSysxcUpMQUQ2N3RCSzJkSXN5VlpyWkRBNm5qRjg3SEoxcllB?=
 =?utf-8?B?eEgrZHNxWkxSUDRFR0FSa0dva3ZpMVQzV3NON1M2aHhUSEtId3RLUGFqL0F4?=
 =?utf-8?B?cVZWbEN0Z2l5UTllaXQvVGJSdHY2ejZ5MldhRHhxdDZiMW1HNWtpbmdPN1E5?=
 =?utf-8?B?blpIWk01ZEl6d205bStzcWRVRG4xRnFNTWprQ1B0d2FVYVBRNHJocmtwWHJT?=
 =?utf-8?B?STNSbkwweEtiMll5ZTZmYUpOUWdydmxDbzNFOHpoRmJkYWtYbG42eXJudlJz?=
 =?utf-8?B?VnBCUjNmbXlDT2R6ZDdnTDVBVE1iRXIvZmRCQkxNOXVnaTY1SHR0aUk1emdm?=
 =?utf-8?B?RU5FSEFGS2JBUFdWRTJpYXAzQ0grUDRzamNDbXhNUzErU2p4VVAzSUNWbGpu?=
 =?utf-8?B?cmF5dzFjSEdHZmZ6WGJhWENRRHdXSTd3d20vYkVDTXI0bXhFMTZVVDFGU0RP?=
 =?utf-8?B?Vm1WNW8wUFJkSFpFYnBHV2NTOVBNelI1R21udzV5NUdLUkVpMDFxa3FaOU1F?=
 =?utf-8?B?SVVCd0hPMzNjS2FkUFNUd0hYTUpQQXE0Zk1oVDJMNzBKcGkyNW1scU0vN0kx?=
 =?utf-8?B?L25jczJqVWs5UnRGMHh6TlV0Y205SWE1R0Q4ZStTcFMrcUZ1RDN0Y0JvYXFt?=
 =?utf-8?B?SjRzV04rTlQxZDI2UWdsTjFNUFYwM1c0OWVGRnExY1dCY0EzWGNQK09tKzZU?=
 =?utf-8?Q?TI6yGopRoKmVF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejVsMklRQ1RlM01XeUVla3NzQlpoTXRvemR6T0ZDWmNSWnA2SjZWSWpnTGhS?=
 =?utf-8?B?d21GY2dRU01KWS9LeW10RzBmYXdqTjRqNDFTdFZRMzYyWllGZ2N1empId284?=
 =?utf-8?B?QjhkZUJNd1RLYmNyRjdkSUJzY2NjdUhEMXR6RTJWZ3RKNFV5aWtVa0V2a0tD?=
 =?utf-8?B?RHJHd3RuRG5GL0ppbjh5TGJ2bEMxKzlmMTUrMW5saEkvNW50MDNWMTV4cC82?=
 =?utf-8?B?dWcvbEVsNmIrdjhWRmFlQVE5L08zOFFVR2ZyYU9sb1dQYmkwM1NpYzlmZ1Fu?=
 =?utf-8?B?VmkxN2syeUtSUkNZaUV4bjBlamk0d01ZTnNEUVJJR3pSMlhxeFBjL0t2cms4?=
 =?utf-8?B?c1kwbnJmYmJsMVE4Y0tZN3kzclYvcUQ3WUlDWFBUblNOVFp2dDI2N2lkV0dk?=
 =?utf-8?B?TERGcTVnSXRGNEdpWUZCN01iUVdoblFyeDlZZkdWQURlbjZ4NUdFUHYvd0x0?=
 =?utf-8?B?RDFFMTJQTU04YjZwbElKYk1BU2VjZlIwVUJZd05waU9zbnpZRXdhNFVYM29D?=
 =?utf-8?B?cVdDTEFyWVl1a0VUMDBRRkxWTEVsdGRUbXY5Y3FjdStXTENLN3N4QXQ5aTRl?=
 =?utf-8?B?d1pORzRzeERZRFgzMXpJU3F6aWdCazlCRVRCNzJMS1A1ejF2NVlULzJneDY3?=
 =?utf-8?B?TmNrQ1p0d3ExQUpMcGVleTA4Y202UEUzMWQzSjVOVktxYW8vWFVOeTNBUnhX?=
 =?utf-8?B?OFpSbFRVYmxPcFJxdGNJQmF2bTFkWHBkYjJYYzZrQVp5amcveWVPUmkrS0NM?=
 =?utf-8?B?RktuNjB4N2ZVV3pJdDFhL0haM0lNMjVaK3VLTkI0dTRMVGhPZHN4RDRhVXcw?=
 =?utf-8?B?c1FoZ0JOcmJqRUx3bTk1Q1NzWmpFS3NxeHhKbWtRNzFPaE1LanVXa0syUmZa?=
 =?utf-8?B?UlVSUVYxZytvcVBIQ1NWcE1MM21DYSsxMG4yblU1SWhHMmJmU0pBcXV2emFW?=
 =?utf-8?B?K0NPajc2NVlmTyt4ek9xSVIyd2lNQmJWYUtxMGIrUGc2T2M4dUZzYXdCVzFk?=
 =?utf-8?B?YWlOUzhIdWptaDNrMVBEdmp0YysrOGF6QlQ0RmJBdmxuUHNDM0REeU9FTDVU?=
 =?utf-8?B?MzhmVFAwcytlNUlMdjlEd1M0VVpWOW5PWWFnUGh5ODNDZmtweVhvaXNTZ2ls?=
 =?utf-8?B?blFUWDNNdHJyMmRwakFFcHlsamRKR2RjQ0dIOFp1a2ZXeWlpdjVHRm55bWZk?=
 =?utf-8?B?eCsvNjN2MDMzN0JOcUsvcXpXbE9ncmtSb2lSeTI3aHpnZERGZkZacy9EaUIz?=
 =?utf-8?B?M0FrL1F0RW9JOHYrdHhnMkM1K2dvM0pqR3ZEYTdrMjlUWmxaa0VDaXA5NmMw?=
 =?utf-8?B?MHRQdVkrWVFLTjBERUNqeFdaYUYxR2NkMG51dmlKUWh3RCt4YjFXSHlDdVFG?=
 =?utf-8?B?NWg4WVQ1cTZaRGNMNFVkOEJIOHNHeW01YnY3dFNUS0QzM1h2eWJHN0NkQXJa?=
 =?utf-8?B?Ui9IV25oYXBRQjZkdkh2MGpUMThhU2FnUUpzWUQ2V2Npc3dvK0N5WmNCcllM?=
 =?utf-8?B?bFNmb2FVVUtEbVN1bVE5NStRVXoycy93MTF1TWhoSFcrUUs1SkVwNDArMld1?=
 =?utf-8?B?R1EycXVSbURobCs4bEU5eHUrSnFmUjRsMEdPL2dkK1RDZTZXZDZ3bVZHaEdG?=
 =?utf-8?B?TDN6Z3RoUEI1azJlNmEwNDdYeElLWi9qT29JWFlRTXJ6UzVFQWdxV2JMdlZU?=
 =?utf-8?B?U1pndmdtaWZwVVdLL2xlRmw1YWd6b0pET1FqSmdaNnVwSkwvSytTVk44b2tX?=
 =?utf-8?B?VGtHK2M4Nkp3MzVXOGtnOCtTN3g0bzFjczZnc0ttbUhtWE1HSzFlUzVNTmJM?=
 =?utf-8?B?OG56eTJ2clROSGRzd0tXSzRrSGtJcjV3UEk5M0t1R3Uxa3FEWUdiU2xXeXYy?=
 =?utf-8?B?bFAzVGl6SnhmTXREbExvb0xFMlJzZEVCVVBoRmdZUGFRcUdVWHRQQ1pDZjVK?=
 =?utf-8?B?bk9OZUpiWWJBL2VFTTR2eUNJSThoSmNLNytZVDMzclVFVzJONzB1ZzNKR0Nr?=
 =?utf-8?B?enNkV1dKdkFONVZ2UVh1YTRyRmdiM01SRnNEOXE1RkFZZE8rR1EvdkE3cEhS?=
 =?utf-8?B?dVhEMHVEeEd2NWpBeHB0a20xWDNhcFZzSnR5V0FPck5wY3lDamVaQmZuRUky?=
 =?utf-8?Q?NzZqw2n4918R6BO9D51t5pwAx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0mt2jETm2YR1OqUHFsNVPyxgqo6Dh5ryKwrpxghLiBxyzs/j1WatdYH3T+5UnCOr/SilSRtSuKkyyYjg9jDBR2LRo9uE/XSdi8YUQ8xmQbOSTFQvOj6o0u5ocSYw+Gvgr9CYInOTkOKOYA7v1G9mIAzkILB9LfpIm/+HVdMOo5hn6PoFUhSYFNmdGptkFKuLQMbICsLySoAqU8mXI9XylQSzJEB2mBf8OoIVev8pQPTWSngBCQei5GhiWEUec9P0BGFb1MSDJjE+xv/97bl/cLCWwTl4Rd/m9jZg2GK5twsn92jCVYvTdoYnbtQdIiEvFDHepNGALbmLpfWVEdn9uhIv7D/8IyHT1U8cUk2MbyiUQA7u26bKmYCw5vguC9P4mG7BonVPAZu0NJbjW3EqY65XnkNB5FW5OYf9+yFJQvNht31LSAWcGa3aza+vye24AydblPKODphh9BP0HuL+dqQ32OFLqHzvBE0epylfE8hBZxL+I9E+h11xIH7xhtPWJLTTtulLvJ5Yu2vjvsYD25XJXMMyXJ7ejGPQ6W6KnTbkHhtt+d2RdxWlSKOSmbRoxOHknC81QrYAN2HgvfDhcF4nY3hXu5QH4BX+fZLLAAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b737265-926b-453a-ecdc-08dd67b6f0da
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 13:55:58.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+wkxar4TGS+Y6bg+PWFknCfnzskTTRhQgL2ZwfebBAE13D+RxrwjU2wvD2Wd8VjEh5/Xv7iz3194PK3QOFhqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200086
X-Proofpoint-GUID: gyugRxJwXFiZNZD8duga83VipK8SOWOP
X-Proofpoint-ORIG-GUID: gyugRxJwXFiZNZD8duga83VipK8SOWOP

Hi Olga -

Thanks for taking a stab at this. Comments below.


On 3/19/25 5:46 PM, Olga Kornievskaia wrote:
> Since commit 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
> for export policies with "sec=krb5:..." or "xprtsec=tls:.." NLM
> locking calls on v3 mounts fail. And for "sec=krb5" NLM calls it
> also leads to out-of-bounds reference while in check_nfsd_access().
> 
> This patch does 3 fixes.

That suggests to me this should ideally be three patches. That's a nit,
really, but 3 patches might be better for subsequent bisection.


> 2 problems are related to sec=krb5.
> First is fixing what "access" content is being passed into
> the inode_permission(). Prior to 4cc9b9f2bf4df, the code would
> explicitly set access to be read/ownership. And after is passes
> access that's set in nlm_fopen but it's lacking read access.
> Second is because previously for NLM check_nfsd_access() was
> never called and thus nfsd4_spo_must_allow() function wasn't
> called. After the patch, this lead to NLM call which has no
> compound state structure created trying to dereference it.
> This patch instead moves the call to after may_bypass_gss
> check which implies NLM and would return there and would
> never get to calling nfsd4_spo_must_allow().
> 
> The last problem is related to TLS export policy. NLM dont
> come over TLS and thus dont pass the TLS checks in
> check_nfsd_access() leading to access being denied. Instead
> rely on may_bypass_gss to indicate NLM and allow access
> checking to continue.

NFSD doesn't check that NLM is TLS protected because:

a. the current Linux NFS client doesn't use TLS, and
b. NFSD doesn't support NLM over krb5, IIRC.

But that doesn't mean NLM will /never/ be protected by TLS.

I'm thinking aloud about whether the reorganization here might make
adding TLS for NLM easier or more difficult. No conclusions yet.


> Fixes: 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> 
> ---
>  fs/nfsd/export.c | 23 +++++++++++++----------
>  fs/nfsd/vfs.c    |  4 ++++
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 0363720280d4..4cbf617efa7c 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1124,7 +1124,8 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
>  			goto ok;
>  	}
> -	goto denied;
> +	if (!may_bypass_gss)
> +		goto denied;
>  
>  ok:
>  	/* legacy gss-only clients are always OK: */
> @@ -1142,15 +1143,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  			return nfs_ok;
>  	}
>  
> -	/* If the compound op contains a spo_must_allowed op,
> -	 * it will be sent with integrity/protection which
> -	 * will have to be expressly allowed on mounts that
> -	 * don't support it
> -	 */
> -
> -	if (nfsd4_spo_must_allow(rqstp))
> -		return nfs_ok;
> -
>  	/* Some calls may be processed without authentication
>  	 * on GSS exports. For example NFS2/3 calls on root
>  	 * directory, see section 2.3.2 of rfc 2623.
> @@ -1168,6 +1160,17 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  		}
>  	}
>  
> +	/* If the compound op contains a spo_must_allowed op,
> +	 * it will be sent with integrity/protection which
> +	 * will have to be expressly allowed on mounts that
> +	 * don't support it
> +	 */
> +	/* This call must be done after the may_bypass_gss check.
> +	 * may_bypass_gss implies NLM(/MOUNT) and not 4.1
> +	 */
> +	if (nfsd4_spo_must_allow(rqstp))
> +		return nfs_ok;
> +

Comment about future work: This is technical debt (that's the 21st
century term for spaghetti), logic that has accrued over time and is
now therefore difficult to reason about. Would be nice to break
check_nfsd_access() apart into "for NLM", "for NFS-legacy", and "for NFS
with COMPOUND". For another day, perhaps.


>  denied:
>  	return nfserr_wrongsec;
>  }
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 4021b047eb18..95d973136079 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2600,6 +2600,10 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,

More context shows there is an NFSD_MAY_OWNER_OVERRIDE check just
before the new logic added by this patch:

        if ((acc & NFSD_MAY_OWNER_OVERRIDE) &&

>  	    uid_eq(inode->i_uid, current_fsuid()))
>  		return 0;
>  
> +	/* If this is NLM, require read or ownership permissions */
> +	if (acc & NFSD_MAY_NLM)
> +		acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> +

So I'm wondering if this new test needs to come /before/ the existing
MAY_OWNER_OVERRIDE check here? If not, the comment you add here might
explain why it is correct to place the new logic afterwards.


>  	/* This assumes  NFSD_MAY_{READ,WRITE,EXEC} == MAY_{READ,WRITE,EXEC} */
>  	err = inode_permission(&nop_mnt_idmap, inode,
>  			       acc & (MAY_READ | MAY_WRITE | MAY_EXEC));


-- 
Chuck Lever

