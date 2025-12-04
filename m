Return-Path: <linux-nfs+bounces-16902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB3CA3F0F
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Dec 2025 15:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77AF2300EE58
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Dec 2025 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48FA2253AB;
	Thu,  4 Dec 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PqIQNkxN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dxzQndF4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11584414
	for <linux-nfs@vger.kernel.org>; Thu,  4 Dec 2025 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764856874; cv=fail; b=Ch8n+a4veG6vqKLxNfGt16tdPyibXu3pDtn2uw7G6KTBYYUfLeN0akYNc7ScXe2fiNoZWRVNgxMTKx1ggjSpuOCq8oqjj0HqhsxVUh82xLFIUE+sSYdlD1WUSrzlDk26wIq3WaR9yyoUmcD2cBNnpqKX1dvY8sD91k6UyV0g6Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764856874; c=relaxed/simple;
	bh=2MdTvmROjPFovr7NdHDeHkZSRxdOuj4tLu0j8gOeBnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r3kJSAzk7uEqyEcCksY37v7J8EhPY8NPd0GupW8+BdMQQ7FDjivCfVC9lQhJnr9vBASdOP82THcKLKFgD7Xx8eKXFexHmEmdynpJvZAyI4bU92idS4MI3P/qrqrhW6EiibLEzATtv88UH8gpjtzuxutFIrvRKsZhAL49NEqblM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PqIQNkxN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dxzQndF4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4CxRXu958611;
	Thu, 4 Dec 2025 14:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3v3X+vce60rM1JTAOQSGDiTdO5vNGSxdS9rItZeHGaw=; b=
	PqIQNkxN1tIJj0bYUr7Dbb8jMCIeEo0nQgJGfeyYkf7lEE64yVxryzNB1oGRIdS9
	9RCm4jkPjK+Mm03BWRf3ZYcJ9xUbI0LL5lyqkoTA0r7v/ws7wMCPJHnrHbqRrTS3
	T2bkeLQdmTj6mnxXXxEoXBiK7KFK/4zhwAAJfqxDK58oC8z5dMVSsZEL1VdmGoEL
	IDDT4mnt9bvz7c5jvl5HPstIPOQYAiciGfAj/wid++DxMyKTNzF/aTzlFMglljbR
	rwe/cWwKZ8m66b5RxUw4ESWAeFNeFjHdKzF/DZuI2i1UyrfxvOXkKMPO4tx6ubVR
	F6z4k2n1czb4A3esqydA8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7u7yf9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Dec 2025 14:01:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4CQ8Y9004686;
	Thu, 4 Dec 2025 14:01:05 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9c3dab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Dec 2025 14:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/YcSKr5Uz1yl8S92PuE+vuIf6SGj6vRf4/S41QnCAxQ4UkXJf2npev8cUoY7anVHQvLhnlNQyfEYkXluTGhGpBqOW58vELB2HcRQA89e7v+O0LzbqzvtbmjuFGJxOgZqmLz8iLo3OVEmOb2/LWoLcREXeBtXrz0bSZbB+Jw8pcS7exXaF1EPf/0WJWClnMuDraMkbCH0N3gLo2P1K5VYE+7EPHhF6thX9svgN+fh+gvW6IxajX06a5e7p9/jGiMrVWON3fVZFA16fxYoOeDhiuB+icKD+JSnbY29Tad/mkaKOfL+w29qbUHaLIUTrcdubfbtMHKNmOgQ3e9aUi1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v3X+vce60rM1JTAOQSGDiTdO5vNGSxdS9rItZeHGaw=;
 b=C4fyskDU6AePLRrjbRNmfeIdUNjfan+193EUcDU3THlNBfMYD0I7iF/ZFB/iFY7IYYUHQDD6RJXwnMJrjTUAPkEuUg+inaq7h43/rR0uQAIkHkrBO6azTGhnPDxziy6cXnP4Rk3gmCM/RSIlq9iVZNQcoLPwRk7bU40ySJPDqEZbAmhI/woDnkRgD12WGTqORV2kHPS7wNdhODnAUfH+Qytqgc0pOuK8tzJP4oItE/rhTXmgQDL0XLFv+HUyLBd4JMxfIoZAOmbyYzCVpXDQV0N9nxVO1TZ+Q2PpzlfX0l78uCgfr3/wUrgZnZC21o43fd+GKS5QDDfv8Oe+DnFCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v3X+vce60rM1JTAOQSGDiTdO5vNGSxdS9rItZeHGaw=;
 b=dxzQndF4gMm/qGmaiE/gfl7EOqWyy+QFjCjCx+iy6uAYTOZD20wvK9Mbf7qGhxfQmI5z5Tdzhanir4wBvi7lVUHp5fkMUzwOGiPLBu5QsHpY/+h1yS+GmYsA4mFaw8xFxrd2WuArsIlWtc1VZlAYO7XzdtsNqGUzTLmz6x1ii84=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPF73A72B96A.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 14:01:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:01:00 +0000
Message-ID: <0a83022a-cfa5-4b37-97fb-14df5222d59e@oracle.com>
Date: Thu, 4 Dec 2025 09:00:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] SUNRPC: Check if we need to recalculate slack
 estimates
To: Trond Myklebust <trondmy@kernel.org>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org,
        Scott Mayhew <smayhew@redhat.com>
References: <20251120121252.3724988-1-smayhew@redhat.com>
 <305f38b14cec83b79921d5e1552ace515db59f24.camel@kernel.org>
 <aTGSPl66JCYjlt6W@aion>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aTGSPl66JCYjlt6W@aion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:610:118::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPF73A72B96A:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c010de-de7f-4fda-fc28-08de333d8e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2JoZWNad3pGUFdkRmFRYUVNYVJoV0FDZWVRanJ1ejVDTFBuYjEvWi9GVjBB?=
 =?utf-8?B?U0lwYi9rZ2hQbWZpOUY1cWZXQ2pCL2tVOTFnYkVHM1VvQkZIUVZTUGZjbXVD?=
 =?utf-8?B?UEQxMFZpYlhRTTg1UGpZY1RoWG9ncmI2T3BFaUY2ejNaL2RsTkFmeXo5R0R0?=
 =?utf-8?B?OEc4S3NTOHo1TS9TK1p1RW1vbXhrODJvc3lBUE04aWRGWTlFVERIaDlNeHlG?=
 =?utf-8?B?MUVYVFJBTUlIcE1uNWZyYzZ3VG94Q09EQ1JkenpjcUEwVUpCeFAyTVMrUUl6?=
 =?utf-8?B?c3FrbFB0TGpkbzZlVlNja0dSa0FSaUh4SU5mT1NWR3BYUm9GZlJQOHRWOUhp?=
 =?utf-8?B?WHIyQStnQlF6VDUrZlBGT096aGJ6dVdOVU1VRnBuQm40RWxPVzFWSXg3M2FO?=
 =?utf-8?B?cHJsTENKRW5yOEVORyswMk1kcElOb3ZvYUhGWk5jRTNGTFlva1pEV2RsMWk1?=
 =?utf-8?B?ZUdzNEw0MXNaQnM1Mzh2TUNnTy9uc0pEMERyZHgxUUhsc0liSkxJYTdmT2hn?=
 =?utf-8?B?QXZ3TVdwS3R0Q0xHbE5RK1JyOXpNRlpBM0ZqcktMZklJbGZNTDNaa1ZVNkdz?=
 =?utf-8?B?bXJnTG1hUWdTMTU1bWxRLzhvR1RyajhKdExkaXVUMVdYSWh0Q2JvOXhaWS9h?=
 =?utf-8?B?SnEybkVxTVN3akxMSkc4U0NVV1IvZmZIOFdWOCtnL1FkSEg2UllXcjJDQ2FO?=
 =?utf-8?B?N1FhNzZra0UrN1dJbDZiWE9VL1drOVVqZDAzWTN2RTRyeWFjSnhqTjFVeWFN?=
 =?utf-8?B?cC8yU0s0cWhUQ0NabFlLT01zWU5wWW5LMzVHemEyTkN3MVdJdGxMMUZ3N2M0?=
 =?utf-8?B?bmZ2bTlFNWpWZktyd01ZWkxuWnR2RUQ4UUVxY2FQWWxNYllNK2ZQbjB4WS85?=
 =?utf-8?B?Q3dqckJGRTg2RXo3a012eEJoSEk2NmlYZGVlcjFOQlptZnBuajh4bm5xenFp?=
 =?utf-8?B?RTBmTGxQMlJaNldPd1YxSkZEek9vbGcwVXd1aDFqdkZ1aWtPQUtLSFFoSnVQ?=
 =?utf-8?B?T1pVUmlNenhnQWMvRHAwVTBVWFZvdnZ6TmY0SW0ycHlaRC8vaG5QQXZiemMr?=
 =?utf-8?B?SHlIb0ZNK1RHWGtLZHoxNUlPRGc3L054Z0o4N1ZqZ1VReWZlL2ZVSzlhMTE0?=
 =?utf-8?B?d2FBVVFWVEJKYVg1UWV0M0ZRcGZZRFlKTWNtaW9lZU9YaWQ4Q05pWDY0Rnh4?=
 =?utf-8?B?aDhsbFl4UDBNeUFFUy9QTE51NzFvSW9VQkhmTGFCdHMzNnNwb1B1SU5vNFJj?=
 =?utf-8?B?bEZRNndYYUlkTm5CR0VaVmsxMmRuUzlWbFFzM0VBbzZXa1l4K0F4QmVIQzhz?=
 =?utf-8?B?QllRUzJrMm9HaHp2NGpGRklWOFdJRHprc1NzMDhIUWUvSllOWWxjTEdKZ1lO?=
 =?utf-8?B?VUVjRnhXK3lsT0UrUzZ4cmNSZXNSY05vTjM1ZU54R3cyTXE4RlBBWVhkSW1a?=
 =?utf-8?B?R3RUSXUrS0ozMkVOS2NrdENSaEE4YTN0MlI2ZmxLOUR0OTAwVTlqdFQ3bWd1?=
 =?utf-8?B?MGt6UWRhRUFJQ0FkcjQzWHNUWEQzYmRJWUJYNUVRbkx2Y3BGN1o2RWlRcG9q?=
 =?utf-8?B?c21INnRERDFsUTdUYmFOWGFDdjRvTmtxTkxnSE1vL1RVVTNKWXZoN3A4a3Uz?=
 =?utf-8?B?YjRsUWdoVTd1VS9RbnJVRzlCc0dUcUcvYW5xZnY5a2tVVzJnelJzbURoczhF?=
 =?utf-8?B?QkZrZ0xwTEh1MXRLNGJqT2xDWlpCTmQ5M1p6SFZxeUVrNExRbFpMb1BuREty?=
 =?utf-8?B?OWxIS3MvN21UL08xYlBiUXQ1RGFscUpxR01RVm1IOHJiaDgvc09vbTJucldE?=
 =?utf-8?B?VXhaendCZEs2cUE3c01LYzVDOExvVWZ4WE1saitCUm9XQmtWa1JkenlWb3h6?=
 =?utf-8?B?c2R3dnFZZG9NMStBYTNOWk10TGlSVitncnMzMGtmR0VyWk0vY0tPZFloYkF6?=
 =?utf-8?B?N1I0WHJ1M050TDBsYVBHbWF6OUVIbWlLRGQ1MnE5bXJwUWwvY1VnMlN0Q2tq?=
 =?utf-8?B?czNrZDNPdGN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3VtWWJZMEFTUExyUFl5cDBNOC9kTkpUVmUxY2UyZVUrNzRWZ2lRdU56bnd3?=
 =?utf-8?B?ZFlCeFhPN3hlQ2RPWVBYb1lyWXRRcUFuVXlrTTU3MUs1cUMvOXJ4cC9XWVcr?=
 =?utf-8?B?cU9qdzQyTGJEUVVSbzRDRXBBbEZKdTlXSkNVUGE3UEVWOWhRa2hHd1gwaHZD?=
 =?utf-8?B?WTIvWnIyemhqYnhzUyszL1kzR1Y4Sm8ybC95dDNDWnAxY0ZYQWluMTByemho?=
 =?utf-8?B?U0M0bjBOcU1SMkR2YjBMUWVMRi9iL1BNTTByaEV4M3FGWC95aG5veWVITFRK?=
 =?utf-8?B?ZTVMTFpZRmNtNWI3UXNoVkFINm53MGI5bGxGd2ZlYUgzYVkwbGRFWjBEVDl4?=
 =?utf-8?B?clcrNEhwSVFQM0lIcGhIZ05GNnZnTHJxdTdIU2tzcCt2RUlsVUJxVThtdWxH?=
 =?utf-8?B?ZTVWZVZ6by9kcU45WEExZkdoOVdPUS8ycXl1Um53N3Z3dW5nZUtESERPVzJH?=
 =?utf-8?B?L1NsY3FORk04VFovOGhsZWZVN09GbFBHam5VTWthQVk3UUtwSVNRUUZ4aFV0?=
 =?utf-8?B?Z0dyS0cwWGRIZ05hMFJ2NENvRC9hM3A0Yk52T1p0KzdiVDgreXYrQS9mZzBW?=
 =?utf-8?B?YzVxV0V5TGwyZk5vQUJuc1lHSjJobUJqWnB5T2lLVFJDWmwxOGhZWks1NnYy?=
 =?utf-8?B?WjZUcFZTUDdVVE0rREJLb3NOSU43b1B4NXVVODR5SlY4dVdHTnJyczdiSmhJ?=
 =?utf-8?B?OVMwT0RPWmdhM05TZjhXK1JwM3VEbUJIRkRjNGRXMU50Tk9SMDBYbm0zVTJL?=
 =?utf-8?B?SGpCZ0doV2w2Z1FhdlhMU1BtSHpWSVF6enRycGpSakNjcGZ1ZnlMS2NKZUFQ?=
 =?utf-8?B?dENFNjJJNXh5OFVjMVJzYlpLb29ZVFptUHRHVlFJS25TeU5mVTZ0MmNpaUFK?=
 =?utf-8?B?VXNWL3Z0aU84cnowRC9LLzNJUnhuZ0FFcWxRc1RjTnFZMC9PUWNTamJKUllV?=
 =?utf-8?B?TCtWdGRwUHdGc1BaZldkUGZzTXhKSGJMdGRvdURrV3ZESUhTYjF1Q1pDNDlN?=
 =?utf-8?B?YWNBbnkrVnlid0hEeG1WSmhZRDBuZWUxYUIwQVpQa0tzcnROYUY5dnBCV1Jk?=
 =?utf-8?B?RTRZZWlYc3Nnd1lRUlVEbHFuSEpMaVhUbWw1UE9pUkoyZ3RqYlpVckh1WG9E?=
 =?utf-8?B?UnFBemx4eTA2RWRTYnFiajE4cW8zWEdwUEpYTmdTdVZiZ1hRV0xpeDJFS21h?=
 =?utf-8?B?RlRCSUVOdkh2SWIwdllMdXo1RG9TT0o0SWQ3VXluekFNRWtJUTd4ZEFPZTVC?=
 =?utf-8?B?a3lIdG83V1E0aWlWcnY1am1wYld6S2VyV3R0T2d4bG83SERVSkpiZkJIN2lk?=
 =?utf-8?B?VDBsN2h3dXNBMjZqbkdGcGFSNS84RnZGQ2JvQ21hYkhIVHlyeW9tR1h2Z0ZS?=
 =?utf-8?B?T0dIQi85WHFJVzRQZWxjWG9OY3pseHJiTkpOZ1ZldnRBbzUvNGNFaEdJVHQ3?=
 =?utf-8?B?L0tiR1NJWGlLd05KOVhUb0N1T3k1ZFFhK1NqRmJuRjZlbWVtU0JTQmdTOHcw?=
 =?utf-8?B?MXk0OTRKa2x5T24rL1RnVHlqMmFRYWYxU21QbzBVQk1vZnJRRWR2UGp2RkYx?=
 =?utf-8?B?ZXE2c2FJSDBqeFAwWmNUS1JyVi9QMFJDL2M2UTZwYUcwT2tOM2ZtbTVKeTlB?=
 =?utf-8?B?dzdVNVZ5aVgrejF0VW93bFdIYmxpUTdiZXRWME5hbjBlb0d3OWhURlhxNEJK?=
 =?utf-8?B?WEgzTlZlZmZlazZNVkNtelNWN0FUT2hLZEp3YVM1bHVML1dYYThtL010RXQ3?=
 =?utf-8?B?cTlFNkJqSEFncTlacndNT1JwN1ZZS1RMSHF6aHdOenlCYzByRFJqV21sbWJ6?=
 =?utf-8?B?a2pESFhpaklDVlh5QnhLWHhVOXNLdHNwNEx2bGJSYWQ0bHNpTm9BRFNKbVZv?=
 =?utf-8?B?S1RPYktRUE4rOHNjWlFQcDYwb3RrVFlvYnhPc2lmOFd0YURCU1ljQ2pqeWhJ?=
 =?utf-8?B?ZU1jazgwbHVTWkhsQktyTGhGSVF4YXJNQ1p0clJyY1dSMXE5aWIxT0EzVDE2?=
 =?utf-8?B?SjhiTzJmYi9oQTdnWE1ENWkwTjhaZ3JDQlh3c0lPalZIbG8xZTNSeVpFdTBE?=
 =?utf-8?B?N2FNLzhGaUk4K0VYcHJGUkYwM0hHRzBTYXl1cmxlYll4VS9tbFNVd3RVeWtW?=
 =?utf-8?Q?zszvFAzavLyQl9BGdRyAr1nKC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hf13gsdS9zWm09eqxVgZXolv0D3qaxkAPw+wPOPHU58TDPPgVzTdqIOk6WOs3Xfg97+aMMxujkoRe5wS7xOqampX69s3Y5+OuL8Kbk/wsY0eSt09db5D71am3NX5bqhPEKgbhlV0hu0TNjgqsVK+VZcSWwq09ulfmVi4W25WC6qAt4TMOrtYGHLR95voF6PGGoV+lP+IW+rqFJi+n1DbChckknkJN+2ql5UwgTx8KbZuJQ+nvR7VUFGCe+xSqFNvGX8/fm1r3tjPGBtsRbrdG02fo+XorAsEZvD5g7yaHdFYYvdaqW22SjHZDDf/BdmeofKcBqzgmhhbCkjAzJLUAwhvFVgFSiRgy7QX5fgR+SQNDS5iFymA7kMtUN0FEtc85hIEXC1Rt78DqwN3qHUkLI8McFlKF/XRWnfySa2DAwywLt2mSUkreCE1ltLomawdXkdYjxi2Vf13ONITKzjjPfebiEHCRGzUdoiURAk1xV66eRXtd7h+mv8mLyvi763sf5P1+eSBN3JplPutO+35ziHjZXoz1NU3LRvn0M/XTAJSccNkyUNqGo+Es2obYfkTR1ir5wRafEpO6fBsQ44uBjUV4j1ul2gKSnD741YN1bw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c010de-de7f-4fda-fc28-08de333d8e39
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:01:00.6515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/Q0kWvnaMxF5N0sSF2edCxqqPiTrSVS6EuvcfnsVMSTpJDKniSC1JG6VTdH9rJk0wpAAt3vSekL12BQIGGy9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF73A72B96A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512040113
X-Authority-Analysis: v=2.4 cv=Rfqdyltv c=1 sm=1 tr=0 ts=69319422 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=20KFwNOVAAAA:8 a=ahwOmKlcX-kQo2ojjAwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _qfOISzcDvu-uYflxIB1pi_fFgeIdVhB
X-Proofpoint-ORIG-GUID: _qfOISzcDvu-uYflxIB1pi_fFgeIdVhB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDExNCBTYWx0ZWRfX5+ZFsQp0hQKH
 3gOxi4TKsLb97smUnCw4z699GciBzZCp8+T3syCiyhP2mVEOu6KTVa0OX4IwnQzgzBODymdtTzu
 UD965oMUaWYDLB0raQciBNaNHeH7We+EAH55WbS/tdCRvicVoO2gWSQYfW5U6UDBZLvDBcQw0DF
 RVyoNd6ECtZkuC6nboaDau94bk91z5gXwqCQ2lewsG3FpsVbHW8F4WRF8ugWB/m5zHz4DqGlSVq
 RxsThDmcCf81ZPsJA1vgGzP01HAELVXW2BlT0n0jlI4JDX0a0zPkV/b1wgBnXddFQV2NtXWfyka
 9OdfzgS8sFsT7RwjXeEEK1YGFpYS7pVjkk19ZAWVQzV4EoKg399IJdmtwn8hMxF0BhQ+/onD8nk
 3jmAqoyhYXT/JlmjbsoicHROzxJBow==

On 12/4/25 8:53 AM, Scott Mayhew wrote:
> On Wed, 03 Dec 2025, Trond Myklebust wrote:
> 
>> Hi Scott,
>>
>> On Thu, 2025-11-20 at 07:12 -0500, Scott Mayhew wrote:
>>> If the incoming GSS verifier is larger than what we previously
>>> recorded
>>> on the gss_auth, that would indicate the GSS cred/context used for
>>> that
>>> RPC is using a different enctype than the one used by the machine
>>> cred/context, and we should recalculate the slack variables
>>> accordingly.
>>>
>>> Link: https://bugs.debian.org/1120598
>>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>>> ---
>>>  net/sunrpc/auth_gss/auth_gss.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c
>>> b/net/sunrpc/auth_gss/auth_gss.c
>>> index 5c095cb8cb20..bff5f10581a2 100644
>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>> @@ -1721,6 +1721,18 @@ gss_validate(struct rpc_task *task, struct
>>> xdr_stream *xdr)
>>>  	if (maj_stat)
>>>  		goto bad_mic;
>>>  
>>> +	/*
>>> +	 * Normally we only recalculate the slack variables once
>>> after
>>> +	 * creating a new gss_auth, but we should also do it if the
>>> incoming
>>> +	 * verifier has a larger size than what was previously
>>> recorded.
>>> +	 * When the incoming verifier is larger than expected, the
>>> +	 * GSS context is using a different enctype than the one
>>> used
>>> +	 * initially by the machine credential. Force a slack size
>>> update
>>> +	 * to maintain good payload alignment.
>>> +	 */
>>> +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
>>> +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth-
>>>> au_flags);
>>> +
>>>  	/* We leave it to unwrap to calculate au_rslack. For now we
>>> just
>>>  	 * calculate the length of the verifier: */
>>>  	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth-
>>>> au_flags))
>>
>> What's the status here? Are you planning to put out a new version with
>> the non-atomic __set_bit() -> atomic set_bit() change?
> 
> No.  After discussing with Chuck and Jeff I'm not sure this is the
> right approach.

We were discussing the issue of how to protect the update in the slack
value.

Scott observed that, with RPC_AUTH_GSS, multiple enctypes share the same
rpc_auth. Slack values are stored in the rpc_auth. The SHA-1 and SHA-2
based enctypes might have different slack values. For one set of
enctypes sharing that rpc_auth, the slack values will then always be
wrong.

So perhaps a better solution to this specific issue is to move
the slack values for RPC_AUTH_GSS into the gss_cred? </hand_wave>


> I was under the impression that the slack and ralign values were more
> like estimates and we could afford to be conservative, i.e. I was
> thinking that as long as we were accommodating the enctype with the
> largest space requirements then we'd be okay.  But if that's not the
> case, then  updating the values when a user cred is using a SHA2
> enctype would mean the values are incorrect if the machine cred is using
> a SHA1 enctype.
> 
> Maybe we should instead just emit some sort of a warning when we
> encounter a verifier with a different size that what we previously
> recorded on the auth handle?

-- 
Chuck Lever

