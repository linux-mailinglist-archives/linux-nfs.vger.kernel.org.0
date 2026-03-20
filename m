Return-Path: <linux-nfs+bounces-20292-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGEqLONlvWlF9gIAu9opvQ
	(envelope-from <linux-nfs+bounces-20292-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 16:21:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD62DC8D7
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02E473047899
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD563C943C;
	Fri, 20 Mar 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HLV1Dh0P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HiqSKtw8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2263C7E1C;
	Fri, 20 Mar 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019880; cv=fail; b=nUyfcSfHjZDWokInmGDi0FWXBJqRc4OeQYBAorchJzyUjc0Ao1bUraTsIz912dKZDsV9y47lFwrfoj+uLxyce72fxGV0Qr54Oev8ysLFhMf1/w3Wx5bkxKuOkOHHijJRrVb95fVKSEXGnxqkPdiib7XLFu+ZKifddTPft8gmdUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019880; c=relaxed/simple;
	bh=EVYHyE2PqT5m4XVFis7hxCJvc5Nsb05ixfbDcuotucs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EZbNGrSR+VLI2iiIVeG+X+lXqXUP1inVSix1u9Tj6AKgrsaTc78FUIO2QBBlZRlFG68RoY6z/gN3qJsjMgSN5eobmMk+pbixYpSWKqjJz8Tu+klZoOhXOn+bkkpKXcE/2pF0xnLlbz8obMHyZZg90w/zTmQxM8+al6scBhbAnLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HLV1Dh0P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HiqSKtw8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8YDtl3323103;
	Fri, 20 Mar 2026 15:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rmcXj1nGWGplqAv61piicQT7v9REVvK+Kki+T/1VXsI=; b=
	HLV1Dh0PpObOVgjxey4QIhc5EEEGCiRvFe8dsSxx1RRT5J2jmoFMjdpqisTgknzG
	gmmcx2XvJKko/JJNp86ATRIBJcLRt+5sUkiDkAAwk1kLeodkBv+gs0dQsVd2rvsk
	J/EkdwnKfcd6I1q4o7OKLy2SEZ0P1R6T9XlSRazw6h4ofv/l3REX4UJxDV+ZbjGt
	16s6WIt2GTB8yChF7amuykaFMdwLElJRYPyclOlBEMfunTi+lGFam23WlA2JMcnN
	z2Iu6pFZYXijwOrozYKkaqncKZTe53G8Jf6lyNenn8DlPJCIDHAF//5UokFSkwb0
	89i/Vc3aUUbBLYPzDxULtg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8hx6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 15:17:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62KDaU8q014298;
	Fri, 20 Mar 2026 15:17:45 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4eb709-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 15:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxS4vqqJaYVsSibCMju7Nm/IEl2aaJIbzEbvZER13MRJ5iXZu1kVunMSr7BCFFJGTJCE9c3zDlbCpRHTABzBXye/dzTXXyT0aIZFuhQnFhFyHECREUtbGzhy3Y91kudwV1PK+7j3+FFUVzhDk4z6h62YX+okj0Mrw8OmD5/KFA/4GmJ+4f5xLvI8q5U7FtKIa6eMjQIyzIkCFUOTUD9BmjjIphqXY4Wty52HKug7PtoJztCNfsjJIXoXEeBAt6mCSIowOS69fPgNEwUBqVDEA5MQiHt4Ozv0DIid45aYlNEuBoXx+LUrq4YNtWjgacLi8YJD0pxHCmp6B5ZppjGfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmcXj1nGWGplqAv61piicQT7v9REVvK+Kki+T/1VXsI=;
 b=n/r3hRXa47ag0Svqpp9SKzbsMM5LMoBYvFGDRm0Jy0F27TRg3ZKQ/YB2UWKG8vN16DTJfOUHtBL5zbWWyFCCTa/dZYYgVcezJRARKwd7Y56AogYtgYQhD5tdaUScdzV2zso4Z3sLwSEVsnDd/Bnjjy10whUzQmjmFCiy9heOVyJS2/sbiLIGMlv4YHxfNi3I+OCaNGMdMRil4CLjsNfSfhX1hnP24yO0vtOigDK/QNneVyWoowl8IUfYUPLlSng6UWnsx03STKpnPUMIaOuV06vJ68e7+ikB25wV1N4tqVHgyDak0xpa9/h+DZXUNCMhx2wCO6UgESTq0hvRkEoAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmcXj1nGWGplqAv61piicQT7v9REVvK+Kki+T/1VXsI=;
 b=HiqSKtw8ZrTiQpM9QYR20gOUwlux6rlUR9fJvBezzVn6sC/hiHeacAmnAVU3fZF7bYfoE6oJCIpeutwsIvqXtXlXInHBeYCrtvpBDoSOGxjsBaPFUo/nCn+fUxhLtjeaZZJz1C67LG9RTN01zHhffdoGN9WtXU3U0KS4s8Wolcs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Fri, 20 Mar
 2026 15:17:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 15:17:40 +0000
Message-ID: <9f91bda8-b39f-4bc1-a53d-dffb63ca47ed@oracle.com>
Date: Fri, 20 Mar 2026 11:17:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] nfsd: add new netlink spec for svc_export upcall
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-10-6125dc62b955@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260316-exportd-netlink-v1-10-6125dc62b955@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:5a::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: 515719cc-130d-49d1-69c1-08de8693d3a3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
 f3bssAnwB+z5MzxNPrBzRQIdBiUR1TCSbBRAf0U4J07iK+lFt6UyXAtXhLK9e9o+YOgLZ9iJ7hIrDdHz/2rHigCItz1Ku8Taner51gSwhp4SC4OjoodSQ449VCLoTUlNTC4tLVSH64cBatL60DYL+xGZ4IuLi89vJnLENF/Yr4qgbCGEc3+jr4w2JUix3Q917gZLybMqjjaUNyTfV0bynFgwQBnJl6FihQZxNLRJQpbR6NwAWaQmjkA/M9RNxhA0qEn2amOWrlvcsZ/+fprju0fTjhQiNISw9M0bJkcC2+yRcU8At9RZNKFMtwmPQPc5TtoN/X47v9BNyO4vtGSRczr2ATrKfQcELRBbdhHZZGv4v2EU1yAT4afp9OlT91vcdZZMt/efIxSh8g4wJWw+nBJqUNYn71vS2GYhm3vdtyoYc9lgh1BTHrRd4vePB6lPkEjZkszlQozNTL7L+7opku5jeQDfD0Nd2dgDR53d6pOlisGiOWuFoboJ0qghEZZFtRdyh8skUIwJWMb8cxYbIPZzFrX6DKVDufHVN3xp3dI+Ew/0dAjqU9opESQokpd08MPkkxd0jlwFO71+HAOfdD1X6FPonqlJLjFu36BeSh9KmZ3RZM9Oudm3ToiQLlzkFkEHoph4uUD5StIUgkGiBFmTqCF7L9dVMLMSJSG3/zjaqHOycvsgq/4jEAehZtGwalArp+bBGEoMK6AgDc/EFklzjRJboqXW/MH25taIkKE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?djVSVzdPdXFiVmZlaEpKbGd0cGs5NkJBcCtaWk1uR3lwNDNybVRreVNKV2FN?=
 =?utf-8?B?Z0l1aG8wa0w5a2N5bCtsZnUzSTIvSmdCNmp5YXRjSmp0TkhyV1prQkx2d0M4?=
 =?utf-8?B?ZjludmgvalIwcmluck0zdVpMVGhQaVhYMmtoc2xSZkwwMDF2VURQSDNZOWVY?=
 =?utf-8?B?T3V5T09VaHFyZE5taHRkZlJUeHk5bGRhMGFzMnJsQlBBYUdBZzlDVzZRV1NV?=
 =?utf-8?B?NGpzdWZ6SlpEUFFEdXlEbm1abUN5YlkyYWFCL0hyZWh3UVVUcEtmS0ZVSXlX?=
 =?utf-8?B?TlNSc1lSaERWdkQyVXcwWnlXNHBYNENxajdXVEdrN1hYT1RHa1JBZ2J2VlQr?=
 =?utf-8?B?R2NVNWp6bnpNeEZpNmh1T0hpMGNBam43R3NMZmx1N3ZNTm9lckdiNm5WenRj?=
 =?utf-8?B?dDEyOTF4UG85ZGVvYTRPOGl1TnVBREdTNkIwNm90ZFZpZi90WG9hS1dnR0U5?=
 =?utf-8?B?dWs5TkQ4SFY2VVVYc1RRNzl5WEJ5cFFwRXBrTWFrOTR2cENJcDV6bkU4ZGtM?=
 =?utf-8?B?aFlVaE9hVGVsZ2oyTktxY1RsUlFoTGJOaWNEWWsrSEd6TWFuNDJFYWlBNnFq?=
 =?utf-8?B?WG4zZmdUYkFHQzcxdmE5YmJUaXNnQTdxUkNNd2pZUkZrY3ZRaUNvdDRnRVJs?=
 =?utf-8?B?MHFYZHhlV2loWllPWHZFRWxINFpxdkRraHFCTGw0UHI2SG1wd3EwbEVQeURr?=
 =?utf-8?B?bitlQnJRMUhHYXhnQUduVmFqVThQQUg0bThlSVRHZkhPc0RucDRDUXJQSTc3?=
 =?utf-8?B?NVZ3MVRxUk1rdXBoYUJuWnA0YnlwU1BFMTN6V1hzNzQ1NHRpOUNzRkQyRXpE?=
 =?utf-8?B?SDVlVmFyUEgyY00xOHZCMHZFWDVKeGgyclpPdURYRGxjTzNHb0ZkK251ZlFn?=
 =?utf-8?B?d3IySkFkMmpiaGNHc01CdFBwVEpZUGtkVjl4ZmVWMWVIMVZnb3crSy9oelox?=
 =?utf-8?B?QXFNbC9WdzFyUEt5amgzc05TbjQxalRWTzV6a0REWmRxcm1HYVU4dmsvaGpM?=
 =?utf-8?B?TWUvbG5WRjNPYXNOMXdtOVRKNGNHTlFnZmFmajVUOFpPb3N2ZkJhVGFlREhX?=
 =?utf-8?B?NFQ5YXlhc3hocDQzOGJ6NktXcXdKY0Y4YkNPVGhjRnVNWGVhTzRIVEpmckZp?=
 =?utf-8?B?VGFMeElST2lpbERXQVBJVmxmMXJORjluLzR4ZERSSVhqaSs1UzhTdDJFWlls?=
 =?utf-8?B?eWlUclJpZFRRZ1RpcFdLRjBoa28yamlIOVdHaG0wWnJuN2dvSjdEaXRxL0U4?=
 =?utf-8?B?eW9CQVFpeHhHKzZ1cTA2ZnpZbTJITGhXcnM1MUNzQ0c2dXZZY1E0eE9nRDll?=
 =?utf-8?B?SHdhUzVCclR2Wmh5cCtwNE1Qbmd1V1F5WGI5dXVXSi9tK0F2R1RJMncxYWJD?=
 =?utf-8?B?SjJwRGxLL2ZHQUlESEpoMkx1a1poV3ljUUo0WXV4aHhCUTF6MVJicVNnZkpK?=
 =?utf-8?B?ZWFOaWNlRjViaTdMU2Z1bkwvRGYyWUxua0VSZ2o1SkRneVRHVm1BZFBRMGd5?=
 =?utf-8?B?VHlRcHN5MVhTVHQyVjkwOWUzTkdhdk1KMmdSU2VrdHNLOWVtZ3VxZHpBaUFv?=
 =?utf-8?B?YkpYd1lPeVBsQ1hWMkNBektkUC82NG53ZE5ydDhaL2VkNDJEbUJIa1dubTht?=
 =?utf-8?B?QTV4NjJabnNVOGpSSkFyVGZpSXJyQWx0U0tVMjZLQ25ZR1VLbFhJVTBDMFhy?=
 =?utf-8?B?NzIvc2FLTG1NS0hYeVh0Q0I0NW1DL2ZLWE1yNDdmQ3lwNXVWb1ZpdkR1REJl?=
 =?utf-8?B?TVljRmJ0My9zMzlXaHV5L21STk4xYmptam9BdFhsUWNnem9sWnNLd2szYkFp?=
 =?utf-8?B?N2xUTjZvdXViVHhBSFJmcXhKZTlLaWt4RFV2L1Q4OVFncG5GSFpLa3I1MC9p?=
 =?utf-8?B?UWxYY2loclp3OW01ZWttL3FWY3pxR244eUhmaE9wbnZ1Wm5ISkdIL0I1elZD?=
 =?utf-8?B?Y2o5OEJVTUtHa2RicmkwYWYxVStFTXl2WExoamhoNDI0WkVwZXJXVGpxanpG?=
 =?utf-8?B?NFlWR0NJQnlxa0ZLSGRHbXBhZ2dlSjFXaDYwT0pPRFQvZmFqcjBWU2NWemtn?=
 =?utf-8?B?aUJ3MzdEdlYvMHVRUzZRcjZZdFBDclc2L0JqRURtMHZJSFByc01kRmdEZGxV?=
 =?utf-8?B?dDBrUURjdWZ6TEpxUWxlN2dVYTd5S1RRTVloZzdFM0txZHU3N2lxd3B4bXZF?=
 =?utf-8?B?Y0VnWUh6NHZQN09rcU1aOHJKVENxWU9URUVuSEJpanJ5akIwSS95R0oxNWNu?=
 =?utf-8?B?MHQ4THVGWDJRRnJ5WFhLbm9qMWc3ZFdkaVRXRzZBZXpNczBBZ1M0M2g1a2ZE?=
 =?utf-8?B?SnBaS2I4YWt0L0ljNkhUWTh3WHVLQ1htR0Z4Z2lmYWpKazFrcEcyZz09?=
X-Exchange-RoutingPolicyChecked:
	Y56Rweg3Yzm4W+BZ7tXZE2YDU9F+JbgbxKWICUcHFbWtXrKsfOZB6tA4yg55k1sCecIwzb4TiaqmdOP2bTK8GX0POPyTuiVXYmnw8yWeSWnJn21JkdOHqCBT04zA+b92Y1KRAolnGD2zRASiowt3blKBS1uODQ+gEPQpvu5z8HadXR9Lv2CYI7UXnndLGsEgkw3bZpevX89ULSSe+4otPapY4ZXxvyNYmjxDuZs2a+tPq3CZsAZ73L1YgfTXV3BeBpaKJZ3aJRjTzVGizlwWmDGzW2jR9QiCfpdsPNUWDASIV7uaqTADTOifcBjLhzHl3PhcGdlLATXhhXgn/XTaKg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GE8ry3Oc4DYf+GE5LkHCgyNZW9ENG/mcFJB+PGHGR7Zzss2jQZKtc3Xrhgad2fjZUfTGX+Iv5Ihg1LhZ7gW2Po7Pa6QcedPC0cEX4pEzkzFDiSd1R4HAhN61kBI8BevfxEwyJX/LBpWMH2JzUw4M+cEy+ZCLwh4LXcEWgR9GHaZqX8eGIwMMAvMhZSem1pb83/c2UnQ2Prlsr3lwf8YhmbY6I7bABH40uH9WdTpJ8C+d0Cf0a44KOkz15oiEV5JrxytUtzu5uBF33A8bP4l1mKWNF84UZGm0gS2tvmwU2bam2IpFIOa6dPUfdRyKiVHRz8O/TPqG+2mnF3Sr/ugvy1qlSLZOP1UAYdtdRek44zMR8qnfQcxmR2HYYgijq0Z+CjCXX3qqF+21TwSigaPXXq9O6LD5sxymbX69Yjl1iwp+TL+ngZLeEwKY5uHdxXyI/3ndKk2TfE67JNHlODdA7UAp8lLeDgyn9+UzD/LpeDps7bx+fM0Is8O/x1CR1I1tVf/yWmVDh9zD5AqxZ7uYMM9PV5ECYtXU6sVji2nAQliqp9ZeHL2h9g6PPpEUovWVeuc+/5zzAwBDzAOb1kLAnBxc/SVKJ64knMkgnYndXbU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515719cc-130d-49d1-69c1-08de8693d3a3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:17:40.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAoNGbNFBVuvDzdxnentcJNx/F9qTzr2d9CxVNWg6t5X+FRI1BNS7JcbqkGcgxR9phzDLClb5/8E4sbSlERyyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEyMiBTYWx0ZWRfX0xxRHnQ3T/D4
 9nFj0z/ooCP21PQIoNMA/6WH77761FVCCaSocVWgXW5WuXseRnc13jKakMnt1FI16rOXeZUtjVC
 AGnPOg5re2IlQPxq4WOSn/vLaOpGKcO1kZlU2C9FWhfVTBCd4aidxrcFjzUofhDK1HMjYQU/ADY
 xIXtitA7JTRqsaS+BeDLyqrY408tUL8lDf2lyBEpYDX7jvmQIsPqr499CLs4ZusISWqS0Hu9YcQ
 uhY3QbMC4NbLJFzthicmUlMm6UlaKNNnYM1JYhGsKwJw+wBKbwp5Ihr52kciKB09RwjreqLQo93
 NCwWcTZUqr7TTCTDwoMaIK4t82h9AhNih4Yi3PJHvQCpYRnl67UHDHaYlvhPynz1o8Rh+a+hV2D
 2xVOwFa3l8VmODqzFAa3euJGOysmvbh4qPtaPkfYp1/enJ5pnMLs8w2expGw9AiTmFcKtOYkoK8
 8JnMPhBXEE3btBq1ZyA==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bd6519 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=BKHk7ip1d8ZlBMGwGroA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nNLMrhYNPGKHpnk0XPUuqMD3XJYQS_BT
X-Proofpoint-ORIG-GUID: nNLMrhYNPGKHpnk0XPUuqMD3XJYQS_BT
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20292-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 55BD62DC8D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:14 AM, Jeff Layton wrote:
> ...and generate the headers.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml | 172 ++++++++++++++++++++++++++++++++++
>  fs/nfsd/netlink.c                     |  61 ++++++++++++
>  fs/nfsd/netlink.h                     |  13 +++
>  include/uapi/linux/nfsd_netlink.h     | 102 ++++++++++++++++++++
>  net/sunrpc/netlink.c                  |  49 ++--------
>  net/sunrpc/netlink.h                  |   6 +-
>  6 files changed, 357 insertions(+), 46 deletions(-)
> 


This is the last patch in this series that applied cleanly to the
current nfsd-testing branch, so I'm stopping with this one.

I'm going to whine only a little about the commit message being not even
a full sentence. </whine>

review-prompts seems to think that removing sunrpc_cache_notify in this
patch will break the build (temporarily). I mention that only for due
diligence -- my earlier request to move sunrpc_cache_notify out of
tool-generated files will probably make this moot.

The svc-export-req attribute set isn't used in this patch; perhaps
its introduction should be deferred to a patch where it is used.
NFSD_CMD_CACHE_NOTIFY looks like the same: dead code for now.

0x3ffff and 0x7 in the NLA policy masks correspond to NFSEXP_ALLFLAGS
and NFSEXP_XPRTSEC_ALL from include/uapi/linux/nfsd/export.h, but the
policy uses raw hex. Adding a new export flag requires updating three
independent locations with no compile-time check. Using the named
constants directly in the policy would make the link more explicit. I
don't have a good suggestion about the list of flags in the YAML spec.

Several AI reviewers noted that GENLMSG_DEFAULT_SIZE is 8KB, yet the
request and reply attributes for some of the commands added in this
series are no larger than sizeof(u32).

Recommend you add Jakub to the cc: for the series for closer human
inspection of the YAML / netlink protocol aspects.


-- 
Chuck Lever

