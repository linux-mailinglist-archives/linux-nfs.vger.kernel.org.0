Return-Path: <linux-nfs+bounces-19690-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLqgI0EQp2k0cwAAu9opvQ
	(envelope-from <linux-nfs+bounces-19690-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 17:45:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E31811F40BD
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 17:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F37302F267
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2026 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7383370D50;
	Tue,  3 Mar 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8PwL+6K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S+xjX5/1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7A370D4C;
	Tue,  3 Mar 2026 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555956; cv=fail; b=TVsH9Vq5cuL6gVIbnkLhG+vRaucqnZdw296/jC1pde9qs6CL7P6MD6BMoqD3WJbYiL7DkSfHD1NyymqzYF+Yl3dJi9Rg3L1ghjKjIOj2HFyCgwsOngFVggH9rSRhdYOgYt3ZLQ7pQaw3pcL5X52vrShDtKjQghzGuY7rE+u1itE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555956; c=relaxed/simple;
	bh=oAlgP/GOOwuMlSB0ZhLpfqJmu2VYgmkOlTcrdX43Lm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hq1EBQfEtggS0RJ3QW8c+YYLCcmfCQyDea3RM+6hy9f0zoMMYt3qRc5aon6BIo57a7AC1EJHz1Hszf5A1TXVjtr86M8GYS8WdWsJ7UqkiV/aAeC/MxLnW3H5wcIPqRUJSxAXMRtAHcvqbJiZYZ97L65fm8nVD588Uf6VRATGKy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m8PwL+6K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S+xjX5/1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623FrMjs269640;
	Tue, 3 Mar 2026 16:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qquW/VO+Sx4TQltP5JCzWEbC7nnvG4jzuaIhEqbH1Rk=; b=
	m8PwL+6Kw2bZWDD7hcTfgFs2IyZSk+poIgI7jgJuE4ooLt/tmW3p5w7TquwFev2Z
	4R8UuvXjwnWC2HPoSdF4RtbdeRTusmtZfa31vWGy1bmNiTbxs4x8jkLc3kt2TNjg
	3jtFDx9veGpJ0o4gRWgHZ8skr5AJT+se/0ots6GvwZEzVWtoSqcRTYp2BUsUBiC2
	l5LV1PTovDk/p8asAAMNZCNhPg0P1hRbHIh7XowPEpglljcSEnjtkWLZ8xvRHcAD
	tcXQI+zfs74IUT/aYS2FfW8y6l+oVJEV2+Aeyx3vdAiahXQqLySo8HcasKtMhtT7
	+/QRyZln2dky0hG7nOhRtQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp2pc030b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 16:39:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623FTY0B037740;
	Tue, 3 Mar 2026 16:37:46 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteuhme-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 16:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lr35MGR/Z2Fy62k4JOjlOUyVKSTiKTLAeC/FAuHu1KtUL9J4bJvBhRcd41ya9CIaXQsKssqPz6KiVlQLvQ8owH9h4Bu9O0kGLSFNTr2MtfnXrfHcaPmaJu3W/TZFd1H7L5mLvETTWyFoWPN1qO6Oc49MWvmz6yGfi9gQofQpS6lT0hS88WgnUi/hRm7ghIqqUGnkL07yIjWWWomEHXMhvoL9TH9DL/hoFi3mMvXNzCerdl8R5KxcT23fOPSgQbqT295nl6HC+1hugI4gmRRL0MTS7JJRpmY3AdGb4pcBEnNZ2FmMKHxn97GQqV7dwQbyGx3UW9QvqpA0nffYOgC7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qquW/VO+Sx4TQltP5JCzWEbC7nnvG4jzuaIhEqbH1Rk=;
 b=QFmpzgomKoZb5j/tvJp81GQSgFORec3wlo57h8bOcxYUtkrHc4+wCNZq7ZIXCH1FDIbAvDTJ7giYNeMOlRMfkQHCk6AkdMj+vzgkBwSngjDPbuaaS0V1ctlnLhvPlwL+WISjg5B7bo34BGVsdDVBYF+sOIbCGD7hVqlhZG+XAAvQh15icQf88pr40YUHXiy94Av/TlHDa4karH1/EX+mnb44LkRyj5hs113iJM8nh7SMaq4a9mguhXGOhZeLqudCE5ggdFh7SWzNmxPRAn98YZ2S7dxLm0WXwqzCv7WQiG/r/jFELWf5u3HsVBoeDU6rG7GlwOdnJW7UhbDw6VljTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qquW/VO+Sx4TQltP5JCzWEbC7nnvG4jzuaIhEqbH1Rk=;
 b=S+xjX5/18Mf7Y9N/AFpfdOjx0BqTwwipIb0vWmqIRZ4YCk2a0B//j7IPf7VuGDt9lVAddq8LMHNU60UH+9n3BSntgcfL5hP2/U8w7wE6I/4iLFky81pJPdE1OOWMO/V+vjyZjav2S+WGp4ZcvxpjVhKRN6DJdOW7b7qFqmHazAE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7288.namprd10.prod.outlook.com (2603:10b6:208:3fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 16:37:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:37:42 +0000
Message-ID: <ccfa6bf5-6459-4633-bcbe-dfa487c8057b@oracle.com>
Date: Tue, 3 Mar 2026 11:37:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SUNRPC: xdr.h: fix all kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20260228220922.2982492-1-rdunlap@infradead.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260228220922.2982492-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:610:e6::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a4b317-8c37-43ee-9b38-08de794330da
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 2vtnkxO46k8qWHk7wI3qf392iw7NG+mrpBvgKgSa8/qprwGHbHORQ+fWL5FONHLLRcDKMjBxVNqexhArPcZtm+hQNAhWNujLQehdKol15lqfU6ZQtj64cP0wfwYQEI/3m78wYdGj9KtIurImUk1qXqL64Gk002i1GOecdD9g55RBTnxmUhV4wBysGwMfteet2eEjgZPKcg8x0luEm/+wDn9efACZQc2Y+dgYsOTKH19RagGNL8paJFf3yQlh+80tqOK04hS1st1MLelLpWBCDtPW/NRdyzH784IvoutASJqPgD/wPUEfkIC+9QsXRfc6MPzor2c42HXhBR3UrAzsmSd3FTaviYEHG0xY/zl405ALrLLU0wi/ojY6f3+pQ1qtY7HwAC04CWQOu+rqzi7tJsa11gWqiSMPa33DENr67yhChp+MyogtNI0MSx9eu4zN5CzPUPSW33wRPNNm7M3/5yw+uNvFU6DWVh76t3sorlJpmauvwFaDMEOyJLS9qzCJYNAu5oXiFr+yK+h5agHLvlzLTyxYL1HeiXwie28DdPHMTvYbLaaQCVUdz0YGKMXk2rJGhuffVtFE6aevgkOx0Xj6t8C5A+z/FBJ+ncr+eUo3A1yRhiJ+mxjVWkPrHAvuo2B/51wtyZHNlIwH/4wcb5Ge18Zn17me94jhBff/b7QuPtUeBXFgeL7iok5fYJaK9CUpmRB7viSYh72KR+SD8kuKAMdQg6dPQYKDFA9TAQ0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OGw3NmE3K2lXZko1NG1NWWRkNlMwRTdrUm5SVEY5VUlqMXBleVNQMzZVa1o5?=
 =?utf-8?B?MlkxZ0VrSHJLRm1HMnRXclZacDk1UU5Pd040L2tablFGWGhBa2Rpa3kvODAy?=
 =?utf-8?B?ZHhVeGs5ckR0VVJBdC90YlA4UkxhQXExRWRjRUpWSGdxeTJZOGlqNStKUTd5?=
 =?utf-8?B?SFV4M1pmVVJJQUVtcVNsazlncVpqb2ZleXBURnp4NUxsSEtoNVRTUVk0c2wy?=
 =?utf-8?B?bGFBNVJzNnM3eWhPQ3hFOXhiQnAvbjJ5VnZrQ2ZjbkZYT2x6b2VHQzB3NmJt?=
 =?utf-8?B?dUpnNWZ4YWpRVXBybHJPM2ovMHBsN1hiRkFOZjFNb1RTZUIyaC9pUG9sd21m?=
 =?utf-8?B?ZVoyUXhaTkVleHJlWUo5cEFyY1R2QWdyVjNvZjF1U1pjeHVIR2lyTzZpcGZz?=
 =?utf-8?B?SUtFdHJsMG5KNE5SU2drQVBEcS9zTG1IL3NNVGVhMlBFaU4rTEhBbXZ1Zys5?=
 =?utf-8?B?d0lDSnV4Y0xXSERPeDVDK2dlVHZDTEZ1L29OZllwTEFObDFrZ0ZMZnFwc3JM?=
 =?utf-8?B?NDEwbHV3YlVJSm41eTZYUlY0eW5EVHY5ZjhPU3pFWGtoVVliYy9DVU54Y3FS?=
 =?utf-8?B?ait4QTkwdWxyNWVHSWJxYTByYm51alRxNmZMaDlMWnNmMDNVN1V0L0tQcWp6?=
 =?utf-8?B?TTNkc0NEZ0l5bGVRV3dMck81QUVHRlp6Um8xU2tGdytJRzl0MXJ5bkgvazBx?=
 =?utf-8?B?NzhWcXpRU3VGV2hJdzk1dFYzQmV0NEx1WGZnK0MzOE53REZJTWE4MmhndlQv?=
 =?utf-8?B?QmZDdE1ncWVYSkxxNWhxZTM3WHVwVnAyMkVNYldIbmsyWFRMditSbitQNVUy?=
 =?utf-8?B?VEhIcVRBM0t2WE9MYnJJRW1uUG5SbGJsUldMUUNvSjMxVllnamhmTDk3SDJn?=
 =?utf-8?B?MUFSK3hlWHZYdHFPdkR6UTlpd2UvVzFhZEh2RGJWd0lDVVRkNDJCdlpZc1o2?=
 =?utf-8?B?STVMY1ByUXlBbnJ0d0wyQmVqbkl3M3A5Ymh6aWlRa3BYRHd1cDdMUHFacUZY?=
 =?utf-8?B?UUdJVWZQQ1pRcHhKMWp5dzY1Mk85MnVHM25mbUd5M2hqRnhBMVVPWE53OXNh?=
 =?utf-8?B?YWxNdGVJNCtWZWJNaXo5QS9aRGw1R0ZOa0Z1R3FXbXUwSTk2V25tTlBGaW1Q?=
 =?utf-8?B?eTFoS041VXdTaFhQclVacDdIcFkyc0xyWmcveEY5a05McDljK1dpTzkxdXRu?=
 =?utf-8?B?ejUwKzNBbDJHckRXUDRMc0t1cmpnN055c3Bad1IxWFpNTXc4dTk5MXIvb1lq?=
 =?utf-8?B?QklyQ0JIM0FCY3E2UlV0OW5jOVNSRTZqdTk3WU5jNktTendDZjNOOTRXWDlm?=
 =?utf-8?B?OW1Rc1d4R3c4UHNOaU5FWGpJMGs4M2ZkcVlVcG1pdXBWaGpYdnp4UmwxenY2?=
 =?utf-8?B?NElBbmNDK3lNWHQ5bVcrL0JQUWozMEVDaGMvQ3JNeXo4UHRHL0hPYjVmVzI2?=
 =?utf-8?B?SzAxMmIrZ1FjdXhDS2pTL1l5Wm82d3Q4MHNCYm1BbndJNzl2WHg3WGdLMndm?=
 =?utf-8?B?V1hFdXlXUVBlSFZRRzBMMjVHTHhQTVZxR2IyRmNDMEhvcFpLVSswUkVZT3N3?=
 =?utf-8?B?WTJLMzZXREJRb0VtRElkMmQrUFU4bHNqV2R4V2NFK3dXdFV3L3ZkMUpqNFB6?=
 =?utf-8?B?QWQ5L05vSDJjRTdUUTJLaXlvbnVjYjF4cjczdGlFRDdKaVJkK1FpYWRtTGRv?=
 =?utf-8?B?VHlrSk9uaGFBeEx5YmE1cHdqUEcxQTVlMGd5VUZhVDN6YXRDNUFVMXZlWGVv?=
 =?utf-8?B?MWNTUU5YSXRNNzhFQ3ZFT0p4M1pyR0EyS3lMN0MxSEJXTjEzRXY2dFhBVGxP?=
 =?utf-8?B?NlRCQVRCbTVZbHdYZkFnS0ZZNUoyY0lLN01TbzVDSnJxc2JQRWFENS9FOWxE?=
 =?utf-8?B?UmRPMjNQb1ZnRlhLeWZwWFRBK1VVa2ZwWnYva2lIMEsxVytPa0VtdUFzMWRT?=
 =?utf-8?B?cUF2aEJSZU1mVm5CdnJWRElxNGsvZk9TVWVnbVVIeFU5U3RUT05uVWtqSzRE?=
 =?utf-8?B?QnZMK211UlZaZHNtZFRqd2ZabGRVSDc4NDlTcVVGa1VFbGNBL1JZSXVoM2FT?=
 =?utf-8?B?NDdvY0F3dzV6S3QyYzFPUDRVNTVoYVhVMEJldWlwbVRqZ2ZSem9uN01GQVUv?=
 =?utf-8?B?SXZJUmI0bHZhWGdBbTlETjl6YXdLZW9BZXFScWkyaWVhSy8yaHdOUzA4Wldm?=
 =?utf-8?B?Ky9qQnpQL0tBbTkxUE12bmVybTdqUGRvUzhPWFlDaDlnWGNCSnlXSDhMUFlU?=
 =?utf-8?B?TXRKOEFMNGdIZWpCL3hER1hqc2M3QWZoRklNRjZmVmVRT2ZkeWVZaWNzRjFB?=
 =?utf-8?B?RnB6TjZtQ1hycU1nZWU0UWRkYjlaaWNsVHg0L0ZkRmNNbmxnSFF4QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Xyctga43YN5BeiV5S4dLd+OqknMjLVqzyEMyKNOKDMhliXw6YuPEhgkBGskUmBena/enbItNwOes37UNb5p7DLkq5/JmAh5poPp7NuRId2KLueAkUIRpi6a+V+dRKejem63IxAh/Gs29v+pIeQ62PQ6Qrq1R6RyYQX+XY0UlWA86OEv+mzEyXggiJlGvjWyvq44phY8BXon3u5yA5eHPtDxUd0ydWoGKzw2d9eyxMkpBMxOsVfjqDw2rU37Q2ek2CHnHz75eF23ywh48YUHVbPily3skk3xTLQPpk3tn/yd0IIc3H2ivn7nJpdH6ddzSO/Dq9e04rVQudUYG7vaiNKx4EVElBc7vZRXs2RM9n/GJauC6ugALH7rKK3ebvx9Him9ABoXpBqgeC17eZ3tZfmipISnWaU9IqNH9ZNqYerOePMnyiV+GAFs23xIcpKllgg3CRUCv7fRGqu9IJfieRjsCmvoWTQw68lt6mQzPRlqT5RE+zrD6B/KOECb9UBGOGyNejIuagaHZNb0NwQtewssvAek1YwVvT52CkM804epPuH9JOQiigpJilkOXnclrK/QvSV7RJ+3jtJ4ZBfodpJ8Aw3WmFN9+k8dFZqHWyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a4b317-8c37-43ee-9b38-08de794330da
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:37:42.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvEDXAt/sML0r0EMDN3YGmFiogggRFfJGRgDiqlx7MGwTVeKqSkdrE26dUK2LDN4+8TZ74aUSUN/e/P+44SuYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030129
X-Proofpoint-ORIG-GUID: RKPxdWCAE-ucrhNUhKto6CMVlBB9xSh3
X-Proofpoint-GUID: RKPxdWCAE-ucrhNUhKto6CMVlBB9xSh3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDEzMyBTYWx0ZWRfXyIYWvzKwJwMQ
 xJ8b2sOzrlzuIl21i4tpnHUr/fPB3BuPl4ATcFI/hLpbuRQicEnFrN4sa0r1+EJQtJFOt6yAbhQ
 LD6rvifRtgeoTvAtuwXguidFhBYDp9Zvjx08gttRJOBvr1P2GwclmpvvXIWVlVq3G3fQ16v+MQq
 +mwmGhxQEUtyktF8RB8HcWpoBi0lOsVfA7feHmL78y+8/cQVsgXpXbMnC3tk66Q63RYLFpdGEno
 V2OnWBr6fiMHo5DTJfYjENBGW+ewSdyfR0MnitqCDjMlzfZEhRWzQaj4A3dzJmeZojkHfjFGb1q
 tFdCt1sAVA/0PvGJ+JxQYWRmFcwMPu1vzDmkjyV7/edHRroRNg9wNCPLpg+kgymUXhoFrHYe9WY
 nvDP7I3NdGO5EvH0maZAMzjHO1zA0fRbVLTpgCZnSG4tnH6i6/NyoaB92uqHJHwwGwmnrlThOiP
 1x3w2GNpdwQNbdjEK4kRajHtzxdW+OIBO5pR58qI=
X-Authority-Analysis: v=2.4 cv=fIg0HJae c=1 sm=1 tr=0 ts=69a70ea8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=JfrnYn6hAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1ehdgZigd-yG9neSBMwA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13812
X-Rspamd-Queue-Id: E31811F40BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19690-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 2/28/26 5:09 PM, Randy Dunlap wrote:
> Correct a function parameter name (s/page/folio/) and add function
> return value sections for multiple functions to eliminate
> kernel-doc warnings:
> 
> Warning: include/linux/sunrpc/xdr.h:298 function parameter 'folio' not
>  described in 'xdr_set_scratch_folio'
> Warning: include/linux/sunrpc/xdr.h:337 No description found for return
>  value of 'xdr_stream_remaining'
> Warning: include/linux/sunrpc/xdr.h:357 No description found for return
>  value of 'xdr_align_size'
> Warning: include/linux/sunrpc/xdr.h:374 No description found for return
>  value of 'xdr_pad_size'
> Warning: include/linux/sunrpc/xdr.h:387 No description found for return
>  value of 'xdr_stream_encode_item_present'
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> 
>  include/linux/sunrpc/xdr.h |   48 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

Randy, did you want me to take this one, or will you send it on to
Linus?


-- 
Chuck Lever

