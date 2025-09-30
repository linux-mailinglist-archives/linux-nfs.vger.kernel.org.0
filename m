Return-Path: <linux-nfs+bounces-14828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7756CBAE939
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 22:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31381920712
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ABD4C81;
	Tue, 30 Sep 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nL0HZT1d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uv5S66dr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D22286D40
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759265792; cv=fail; b=pxeKAT8ed03Hvr99vWiUcX8Fb4R2c5WjJMBjwaLgmV+s9bu7GcIBTB+oK5GJcEB1UqjXy8HFXQvLSNrwrb3RiX5OwpmM/16skR5b0uFtgHBCXr+ivNJN8FI+2nMcW5CF2q5JxrgS2U1xt8TipJIHIwvPiPFb7oNnCqcyGgpzFWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759265792; c=relaxed/simple;
	bh=mtIOVgkb99ffKwQDr+SNaUYxXwYsmsWVFA3qzy1/wkA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jtQZNfb2nmN6S5n88599KgCopKdlq5ciSJQCZ3Z9vlXfzVc+iT8QjMInwKsjyvK9sLsu+HzN/3eyYBBf0QhlZfVf/JMyuFIaOoaKAgd8nnTFXEeaNraIdNxFxFHzRDU60GRZsCiAauApBI+F22QGFOMIUetkXmyhNvEdH7kU8fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nL0HZT1d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uv5S66dr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKNLYc006278;
	Tue, 30 Sep 2025 20:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ISNWMwxMGPyIi9FQ8Xr+aiMcU7q2ZHhOvA88XGB/5Ig=; b=
	nL0HZT1da0RFu74nOhYZzCWLDxUhKRJLN/6+QUqRyQA4Mjh0ycRduEt4UAtzQlyi
	XuMqULLuMlWCHfSVqD2arjSinnZv6hUOxTvxW3cInn83UNLvlWriSM/rrUXdN1ID
	c6BKizhN7au9SuwRVRkp9wOvFRunIe3GRZdXNCslBENXa8xwU/0i5PIo4FgMPoEh
	DaaxABxwiC+23DuVNhG8NqDAQQFJl6nVCNAcZ9jLqEVK8N9ZkqLuAc/4BMlVNiVQ
	zOJhMriWExLlXDZu8N65hI2TpMhEpOM4yyLNUFgewJO+NFB86UjFzxH6Dlwzep1f
	7fBeaxZGpjZf5neax1epOg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bgaxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 20:56:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKF7FB007787;
	Tue, 30 Sep 2025 20:56:21 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c9cpy0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 20:56:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alQ/G+xPzuscE2yOLXpuiKVvbG5niLvIH6gM+f/iN8y7c7/f4Vn3S6iXoehn5vG9uCJmkH0LT6aGXP51ecZzTL2i65bldRa77v/AD9tYXrtK8CFUdxIOSS7PLpybmqTnZUR3UboeTmAIP2wOhokzybbaDpDdv6Nf5gMOiXEtxSlDFWtteSpgt7GKsKZSdHyJZmWvLSP/lGFrDYKeVKqU8QiSUCVkR0Od1xzz6YuIz5F6CfErkKtZLoIK91TivQess3pLp6ccxkKkGmbgw/PFdaE4xBFijwpEG31cz7uwdPHXNQL0dFIkjYjjk6UiwxVTsZyyO7aMiU2+EWe5IHfa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISNWMwxMGPyIi9FQ8Xr+aiMcU7q2ZHhOvA88XGB/5Ig=;
 b=EXAjH3omHw/2oNYTzqiWPR9secj5Tlcb3YRPojFGE0ffq0K5hXI4fMtAFWFQ8UWT1bfeRPGYfmxi9FwLfAVxpjODrvsnknj8N0SLCsNs1HW+WY4JxrMA/maaBwpZJ6VZrSYgd6AH0M5owFlhiNlIIlok2zn6ww99hfJQ9rF7tVUztZf0DdwJhk0HRX1MCOy4FpGBbVc08dqkid5m9Xvi3Dd+PLguUI4y8H44s5Sg8S0at19NlC6E2Y2CqwUIptVnDY5oc/xLwzr0FjmW49X0GaSfRuPWfWl8+akLTiemDPKWtPLbCABeF9z0jdtbPNaSuRnsVMYblRYgVSGoVP936w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISNWMwxMGPyIi9FQ8Xr+aiMcU7q2ZHhOvA88XGB/5Ig=;
 b=Uv5S66dr2IQkYwMzmWqKVdPa9yvyMHL4YrE7gjCW3PFIzbFnh17fl7U5Ll6J8Xfzu7SP5v2d/bpAAhdZ7bsFSR2yVhX83AJiHXO53qvGdse2QJtVaFKN+mIf4uKh3Kx+Vi6hBx6yxFRnUh57Qo252ZpEJiNTovi/f6LgAvKDiSA=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Tue, 30 Sep
 2025 20:56:13 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 20:56:13 +0000
Message-ID: <4a5e2517-89f1-4acd-a724-d8310d7c267c@oracle.com>
Date: Tue, 30 Sep 2025 16:55:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nfsd: Avoid strlen conflict in
 nfsd4_encode_components_esc()
To: Chuck Lever <chuck.lever@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
        patches@lists.linux.dev
References: <20250930-nfsd-fix-trace-printk-strlen-error-v3-1-536cc9822ee6@kernel.org>
 <ced615aa-1aab-40ff-87bf-bdfcb64cd9af@oracle.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ced615aa-1aab-40ff-87bf-bdfcb64cd9af@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:610:b3::8) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SJ0PR10MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e94a02-7c8a-4638-7cc2-08de0063ca97
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RkZUNGpFRlhLMUxYOEZPa2E2Z0RZdys0SGEwR1NqRVI0UXBRUTQ3Qi9jVys2?=
 =?utf-8?B?d2NZNitpZ093aEdSSHVPb2JxWU5TbEFCZzIwZVJlS1o5ZXJtaEZtYUF0Y3FP?=
 =?utf-8?B?V3dBVE8yaG1BYmhteUt0eHEzY096TlVmWks1SEl4YXRBRGpQNSs4OW9Bbks0?=
 =?utf-8?B?MWt0Wm4xRDRqUVorYyt3cWwzTFNVdzJENE90UVdUSGZ5eEI5RHVEUEM3Unlk?=
 =?utf-8?B?b25VcnY2Y3o2VDhtR2JJa1VYRytyWlczakM1Q1luS2hkaWltK3prdFlZRUl3?=
 =?utf-8?B?bzRrZG40bTd3MWJhQmFZdFBTbjBUTE9CbzF4YThzMnpORjF6SmpDRytDSTlt?=
 =?utf-8?B?cDNETEZoZU4vZlYrWk5zb0ZQZVVXQ3VoQjVEN0diVDVuMUsvQ1J1VTl4di8x?=
 =?utf-8?B?OHExWXY3MzlRZW1wNU1Ec0tjVElOVWJxZ1ZuTUhRM05uQW5YNmtQNFA1WVJ6?=
 =?utf-8?B?cUFob2kxaE9sUm9Da0hhcTZJRkZBUUxrcWlXMlF0Mzc5cG02MEVPbklydXBZ?=
 =?utf-8?B?ODh2SXRsMUVJTzRkdXc1a203Z2wweTB2UUhOWk5CQU9rRnVHSUJqTW1TVnFO?=
 =?utf-8?B?UGdNbUprRDQ3d1AvYVlyeS9tQjJBdmJpMzQzcERLajdqTjN1VnBYMVdtSXQx?=
 =?utf-8?B?YjJyTkV0eElYY3VDMVhDQkFtcDAyMlIxVkIvbm95cmlJRFF6TnZJTzdGOU1E?=
 =?utf-8?B?VU94L2ZXVGtoejdVdEJUZUNZajhpVXhsZk8vZEEyQVFaUjNTcFhrVUJRTGZG?=
 =?utf-8?B?ZFdLYlZ1VytBQVRhbEJUNW4vYmdPMjBlVys2V09Ud2tXUTRUVHRETUlhVGly?=
 =?utf-8?B?bWhhK2Z2MC9yWjlXTURBeTZlWnJRUXpvd1l6RXdZRVhmdnpoRm1tdnZxM01x?=
 =?utf-8?B?WWNqTnJqTWJlQk9iMkJRNjJPV2Z0K3Faa0FjWVBKMmFpd1cyVEJPVjNUVThq?=
 =?utf-8?B?SU85NnZpTkt4WU9LQmRrcGdwZnBtUVVpOEhLTVhQNmorU29IaURuVFc2cG9a?=
 =?utf-8?B?Z0ZTcVM4RzlYU2R4eElTdDRwMUpnd1dmYi9Edm9zMUFlMkFBbWo0TjNFVmhI?=
 =?utf-8?B?eEhEck9QTlJCS1M0VmQ2MjBhT2tHNERFRTYxMDd1RFRZbjY2dFl4M2xEVk9n?=
 =?utf-8?B?dkVEUmpUMUVOeHhYTTRhcDc2UVRmVDhZMHg3VWdHOERDbld3alNoU05oQTBJ?=
 =?utf-8?B?STdpRXVWbVZ6UFBwZWU1dCs2MkNQaFZVVS9Rd0ZqL21PK2s0VWpEQzdvUzRq?=
 =?utf-8?B?VFB1dzBEZnUzODJRSzd4cXVtRStzRTE4STFpbTJiYWJQL3QxaU1oL2lkRU5Q?=
 =?utf-8?B?ZlNjdVorMFk0SXpaZXN4MG4yZHI4K3ZvczZockFmTXNSS2I3eDJzL0loWTJo?=
 =?utf-8?B?Q0xFOEo1d2JkMDZGZ3pGUERpMWU1UGFJYkVJL08yT1Y3eE9Bam1KbzB4VkdQ?=
 =?utf-8?B?UkZwRXJ6bmZNSkc5dXRFLzhWODlsTTdWM2NIUkJia3RJOE9qS2VxQitYZG1o?=
 =?utf-8?B?RUw5K0Q3enR5TlhuZDlJYmRiVkFCZ3I2RktWa0tZSU1iMUlua3Z1NFNtRWxi?=
 =?utf-8?B?eTNIeVV3NGUvU1lOYWlBaDk0eVUxaFdUNEFCcjU5aWtNcWVwUzNUcHJ2N05V?=
 =?utf-8?B?dmU0SmhNMTU2Q0hFYkRPTHVSZi9vakR2RmdpY0Z1aDZ4a2Nra1hOY2JLV3pW?=
 =?utf-8?B?dEFQWmt3d1VCY0MvSVNuNkhFKzdhU0ZBS2o0VE1TOXBqSWM1a09EN29VYkxz?=
 =?utf-8?B?ejFpUmx2L3IzTUNwTGdJY1JRczA0RVQwd3pEVVlzTkI0S2Q4L2Mvd1RIeE5n?=
 =?utf-8?B?eVV5b1dXemM0dk56K25CazVKMjBmOHROZXZJdEdwK25jQTB6WTBDVEZDUXQr?=
 =?utf-8?B?RDJKQnI1Q3dKVWIrdnpLV0RXdWw1UFN0Q21vTXhUaFZSODE5aXhpNmhnRjFu?=
 =?utf-8?Q?YL3StKsGXhU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NjM3QlRkMUppYVdUSW4wNFArVWRFMmt3M2pEbnNvMWE5b3FIYllQT0hqcGV2?=
 =?utf-8?B?TExpL3J1ZnlaRk1UZ0kxZFZHaXhicVMzZHV3U0Jkem83WkN2VmhGanE2UFgy?=
 =?utf-8?B?eW5QNUVrTE54dEEyeGxOa3cwWGNTYUlDK09VcE5xelUwS2FOanpyb2s0RXhv?=
 =?utf-8?B?NjVkamMwVFJGOXNLR3pRVERFMjJzNGhkS1UyN05YUHFDMFd4Nld0TVdib28y?=
 =?utf-8?B?Z2hDaXFLWDdwclROQTRMWmpsUSt0Yzdjelh0OW1VdVVOS0tMMDNxa3V4VnVR?=
 =?utf-8?B?VUViSHc3aG1vN1NvcDV5UTdxRE41Y2ViTVFBMFJaVW5WNXZacGpONGVEUmx1?=
 =?utf-8?B?OU1Jc1pNd2VNM25JRDdqR0xSSU90c3VwZ2sxY1J5MWt2NWdTNkc1R0RFY1g5?=
 =?utf-8?B?V1JpdkVFUmVpbEJhWUZHU3Qvc1cxK2lEREFkT0JkYjJPTElHQ2p0NDN5UTQ0?=
 =?utf-8?B?S3FlTTRLOVhyNWdrNGhKVUNpdXdXRE50ck82OXF4TEU0UzNiVTFVeStxc0xt?=
 =?utf-8?B?dlRDUlhHWGVEY3lCV0U0OTFpMXNSVTkvUjBldzY3OE01alRtQWQrbHJUNUp0?=
 =?utf-8?B?NlFUR1dFYi9kMUJDK0tiRzVWYTJNN0gweGtaZEEyRlNSWTJsYmVQMVBXUkln?=
 =?utf-8?B?MGd2bjUvZXV3TTlQNUlxUVltMEZDUmRocGwyRTFUT3BsUTVaMlhvWjBkRTRZ?=
 =?utf-8?B?bGRXOEVKN0gzSEJpM3B5THkyVjVJWG1PZVV0UnpwTHo4Vk13REFvZGRINmRN?=
 =?utf-8?B?VUhjekZmdVltcVplbkliUjJIRjFQbDkrODZ2OFcrdWJ3N0xVWFp3cVRNQ1Ru?=
 =?utf-8?B?Z2pYWXRoL213Y1FSUXFPaVNVYTdadjJkOHhTM2lnbWN6Z2ZoUWhwSnpLa0Rw?=
 =?utf-8?B?QVBUakZVdmdNeVFkaHlQbjFOdmtpZ3ZheFJKTVBnWFVtTGMxQVMyaFRWRENE?=
 =?utf-8?B?eDhnQkhEa1BGb2JCdWp6Wk5RNHNwamFpZ0RpZTdTN1dsRUFFbWppQjJmV1hz?=
 =?utf-8?B?UDB2aXdNd29ycWRYazBlUkZtMmxiZUJueThTSVprbWxna3N1ZVpMTEpqNGpF?=
 =?utf-8?B?Mk1LZGdpMmVHQlppOUp1QmJ6MmtoLzVRWGJhWS9LNFZUMHhmRDlGekVObTly?=
 =?utf-8?B?YW9DQ25qSE42dGM5SlBsNUtjZ0FoUmxidWNRZ3FFby9wQU94Uys2OFI1ZVFE?=
 =?utf-8?B?djBjOGN1Y1c5amY0Q3dESUZXUXJMZy9WNFdJOUxpM2U1am0vYXdqNjhRWUpS?=
 =?utf-8?B?NmtZc203Rkp5TkRYM0gwYjY3SE9oRFo5YkhtZGhCTmlWdzh1Mzd1ZXlTVGlp?=
 =?utf-8?B?eUZ3ODJpWm5FS1lqQ0xUUzNzN0NjMmN4UDYyUEV5MXg2TWVKMHBNNnZGb3NM?=
 =?utf-8?B?WEhnZWhPcEQ2OUxkd25EZHZQRmNtOVprWVhWMS9vTzlxVGpsZklnVmNqd0Q4?=
 =?utf-8?B?c0NnYzBHUkxTbSsyYlRPbnowK3pVamhoQkJ6aStnd1lNVm93L204YnY0RDJt?=
 =?utf-8?B?STNjT0dpWEcrYks5VDlyQ21SMzRybWgrUy95ZlY0OW1qTG16NWljNGhoQVhC?=
 =?utf-8?B?R2VZczNUWkc2bTRkb3NXUEk4RytYOWo0TDdIemE3eGorN1krYTBSd29GbE5o?=
 =?utf-8?B?ZFV6RDlzUGUwZmtnRzQ3bFltSEZaOHRGRnBEUUliQkNzUHRVMmwyMDQ3YW1v?=
 =?utf-8?B?bUFiQkdKNFBLZmlTRlZoZnFFT1ZEclE4RVd6eDV5eUloUTV0UjNkQ2ZobG11?=
 =?utf-8?B?RGFaNzhXT1RVcGpva1phTXhZejNMTzFTODUvU2xtLzl3b2JtOUsvM3Q1c0NQ?=
 =?utf-8?B?QUZPYjMyd2hUUk91YjNlMm5vckx3MXBSSGNmOGhqRU85eW9TeU5GVk9qeFhi?=
 =?utf-8?B?aDJrTk0vZ25UMW5YTUJ4c1lJZnJVekZpYitVTjFMYnlCMWZSRWtleXdKaHFM?=
 =?utf-8?B?cEdrMGdWeXQ4NFNDWnp2aFM1aVc5SGtaRVFMdkZ3ZEthZXBHdVdObTRiU0xL?=
 =?utf-8?B?R0lPa3ZuNVltR0Y3a3NhUHg5S1BGSm40SjFCc2pRUkIwdTZxa1NvNDlmcGwv?=
 =?utf-8?B?cllpWWlUM2lhUE9PWkI2YTB4M0xGbUw5Q2NSRHFQRmxxTmxQVVh3cWQ2TFNN?=
 =?utf-8?B?TGZNVHVBQ0QrY0V6WG5wdzkyZS9maGZZZ2g1WEVYL3BLVWQveHgrZ1Vsd01v?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hRkaVE3KYNI+U90fUE7rZd4Tx9eSl5vaQj6apO/QnRaIrP0/dCi/BaK/hi5uCDjXNu8+5bZdnaTGR2hNLT14pcjgnfr8MDug9sgg0BlI37ePWZt5zMzGo8VDYVek3bgUWm8kTnlbbwjRYLjqFQLgLV5ODwmnzIE32BJ7hxTMkEpJuxzuqrTizzLCvp1xGL+1uF0voKBx3C6/cxbkikPqscogokWj7hS3/c//WeUvrTf0MV9crJ6AK6ZtHP/JA4uUDnC40gBBLmS0ihwWfO/jKKbYxpGrq9T9FslhOAAsc5Li6tL7LMBWaQvNgyIHxIvt/5sky4fsZtB3KJfOpbijNNNqjQVMTiOvJp9k2zzNGuJxXU5DH0B63mcQ2rFiYr7Sse7rczELKJLMPDrbkYMMKb4Jrha09m+/tPCLxL4ot2mhT9sk4b2hvCRGUkMFDOBLgwsr/hJlqaadqEi5AtIPcDHVZxieSufH7vNtPMKxtltdjGuW1qQUk4eh8zAliC+liYscs+egtWNEBpLZaR5rEhw2CPDU3uy4zx4kP9AEWX72ybBloBfMRvbFprM9WwYFkcDuzXaHXYcmPmeGk8ub2zyguN+qmKS6NcS4OG3yQXw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e94a02-7c8a-4638-7cc2-08de0063ca97
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 20:56:13.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyYTE6feh8hH/M35pEUrF1KHO2A/8DuEi7PEhGzw9GGxQ9rTRFDvnn9p6+hzwjiv8nie6hgBti0RZgJlQpj2bkD0wHut5K0KMaKGOjLLF3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300190
X-Proofpoint-GUID: -WAyXl17XzB2WaVl3-s159xHU8PlouuX
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68dc43f6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=tsiXka2cBcb_6nLmPHsA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfX81f1lUNGtT6U
 UD+htWdRzDosGeiSnOUSBstC9D+vc8ssV7xH1b7NqEQ7511mAIhUDxtw2+g/n/9uxqO193k9qAX
 guymqO4MW0YJgvZ4Q7jOpg+RAurDQNGq5t0X+0cikv8XBYX5q92QK/O9fydkSKdUCdPTrFjmPR0
 14AyIsvWku6CtYuzOLRHIv4iapBlisCGy/Fb1E7n4libnQZkAxqeStMoJy6N+f8x1cLspBfti+A
 RvHY5uiQCjfQ6jJIaNHiTc1nHWZGHK9kcLO8kHgYg8yD8UlflZ6Ojrce1EKtSzjIbf/NI5tZLeV
 F9IJcaPMQYJ9M3EoICnqQXMiacSh3FCE8h9lAsL5c9zYfL9cwa5luGWtoSY6E48/zxxy68jNW2v
 7vzlq/jL7nOWr1OSexuo7crXvnGhYg==
X-Proofpoint-ORIG-GUID: -WAyXl17XzB2WaVl3-s159xHU8PlouuX



On 9/30/25 2:52 PM, Chuck Lever wrote:
> On 9/30/25 2:31 PM, Nathan Chancellor wrote:
>> There is an error building nfs4xdr.c with CONFIG_SUNRPC_DEBUG_TRACE=y
>> and CONFIG_FORTIFY_SOURCE=n due to the local variable strlen conflicting
>> with the function strlen():
>>
>>   In file included from include/linux/cpumask.h:11,
>>                    from arch/x86/include/asm/paravirt.h:21,
>>                    from arch/x86/include/asm/irqflags.h:102,
>>                    from include/linux/irqflags.h:18,
>>                    from include/linux/spinlock.h:59,
>>                    from include/linux/mmzone.h:8,
>>                    from include/linux/gfp.h:7,
>>                    from include/linux/slab.h:16,
>>                    from fs/nfsd/nfs4xdr.c:37:
>>   fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
>>   include/linux/kernel.h:321:46: error: called object 'strlen' is not a function or function pointer
>>     321 |                 __trace_puts(_THIS_IP_, str, strlen(str));              \
>>         |                                              ^~~~~~
>>   include/linux/kernel.h:265:17: note: in expansion of macro 'trace_puts'
>>     265 |                 trace_puts(fmt);                        \
>>         |                 ^~~~~~~~~~
>>   include/linux/sunrpc/debug.h:34:41: note: in expansion of macro 'trace_printk'
>>      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
>>         |                                         ^~~~~~~~~~~~
>>   include/linux/sunrpc/debug.h:42:17: note: in expansion of macro '__sunrpc_printk'
>>      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
>>         |                 ^~~~~~~~~~~~~~~
>>   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
>>      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>>         |         ^~~~~~~~
>>   fs/nfsd/nfs4xdr.c:2646:9: note: in expansion of macro 'dprintk'
>>    2646 |         dprintk("nfsd4_encode_components(%s)\n", components);
>>         |         ^~~~~~~
>>   fs/nfsd/nfs4xdr.c:2643:13: note: declared here
>>    2643 |         int strlen, count=0;
>>         |             ^~~~~~
>>
>> This dprintk() instance is not particularly useful, so just remove it
>> altogether to get rid of the immediate strlen() conflict.
>>
>> At the same time, eliminate the local strlen variable to avoid potential
>> conflicts with strlen() in the future.
>>
>> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> ---
>> Changes in v3:
>> - Eliminate local strlen variable altogether (NeilBrown)
>> - Link to v2: https://patch.msgid.link/20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org
>>
>> Changes in v2:
>> - Remove dprintk() to remove usage of strlen()
>> - Rename local strlen variable to avoid potential conflict in the future
>> - Link to v1: https://patch.msgid.link/20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org
>> ---
>>  fs/nfsd/nfs4xdr.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index ea91bad4eee2..07350931488d 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>>  	__be32 *p;
>>  	__be32 pathlen;
>>  	int pathlen_offset;
>> -	int strlen, count=0;
>> +	int count=0;
>>  	char *str, *end, *next;
>>  
>> -	dprintk("nfsd4_encode_components(%s)\n", components);
>> -
>>  	pathlen_offset = xdr->buf->len;
>>  	p = xdr_reserve_space(xdr, 4);
>>  	if (!p)
>> @@ -2670,9 +2668,8 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>>  			for (; *end && (*end != sep); end++)
>>  				/* find sep or end of string */;
>>  
>> -		strlen = end - str;
>> -		if (strlen) {
>> -			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
>> +		if (end > str) {
>> +			if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)
>>  				return nfserr_resource;
>>  			count++;
>>  		} else
>>
>> ---
>> base-commit: 3fadfaec904dffab02ebf63dd9c2ae8fa15c6d32
>> change-id: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186
>>
>> Best regards,
>> --  
>> Nathan Chancellor <nathan@kernel.org>
>>
> 
> There are fewer implicit typecasts now. Very good.
> 
> This one also deserves some testing IMO. But, if Anna still wants to
> take it:
> 
>   Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Given how late it is, I would postpone it until post -rc1 if it were
> solely up to me.

I was already thinking about leaving this for -rc1 since v3 just came in today.
I don't mind taking it, but if you would rather keep it in the nfsd tree that's
fine by me too.

Anna

> 


