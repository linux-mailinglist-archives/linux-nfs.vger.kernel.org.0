Return-Path: <linux-nfs+bounces-14735-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A0BA3D6C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEAA627798
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBE22FB0BC;
	Fri, 26 Sep 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WFad+IzG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ik8WsacB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7052FB0B5
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892463; cv=fail; b=PhF2ev5BNOlfp0syn699q4QMYndMX4pKwkSfK5vHq0iHX225LXFWFIHeWt4niIN/XOSpr0205VOOPePvNZVdtR0v1TOWRXz09Tbpqk0nByAjhFl84WIokGSXGVNdz0efHyndbnkHFdGfW5NPPpW8hMflZfe5Gf2Xszk5Nhw8nwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892463; c=relaxed/simple;
	bh=bMkzjl6/sZPxvmEjjsdKz2grvUmYFOYPYrzIcj6ZX6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dlpWEaTX5+fNcW5pZEpacK8QlGBmWGWJGHnXq/up+qkk2EDXVoc5zTnE3fi+7LuOklwVTf4IDnrlaYZowJ8dyphiHdjeMqL+9ug+O+Q0mOP2JxpnPtzJWtM4P+LMDBDkLTufBss7eM/nOuQ8iQPkOEhrY2UFi32oUwTGonBLqcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WFad+IzG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ik8WsacB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QD5BZs009802;
	Fri, 26 Sep 2025 13:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cmffXtbsJfBkwLGSnHY2QekhML48foGS8HevBYkvPrM=; b=
	WFad+IzGsaEW28ygCdwuHYwkhio1SvfI97YuSOCavXh/RP3S8QWYlgXDJJ9iIu1C
	9L8Ch4/noG+AiKgIoYbd6qinVQOY2wZpkTfqBjxD4UO/qSjqU803azXASTo5IrOr
	MHcAeiSnKpwj2gMYH/UlFYV7yDrElphgmN4hYkjSLkeJf2pvuu+WZk3sKZzDfJzw
	wznH659nXTaHCPV8zLrKIIt7WubVamT8QZo83kCNXY6DkK0JZacq48xk2Hlwalrl
	TikRlNZ0kbQIt1xz88oaRd/XnpqO/dDhdwyU7d+dyXcWnfnyiE/F2a7mpSE0dDr/
	lQ46WfOHbU7WItAeM5ityw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dud2r0h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 13:14:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58QCDm6g023349;
	Fri, 26 Sep 2025 13:14:05 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49dd8kts3n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 13:14:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/yVOybiomzuIwxSOwreSQ85w7P7vA/4IpbQkCwcC507NuN3tgI+S32XL/zVoUGl42cmaNRpmI5roXNnLFfLnqD3x2ThKrep15yYiSCmwPjW69CBYxphnIKa3Uyf9VozPgtQ6Jk0Qr2NMuIuUMeYJpqBdYgBQYQjsdofDASIhrnmgNw50HFe3xt5NjUJst/fTECXTHqpPFm8WhjwMbNKQ/5LJMNrnbRlIO/SwKniF2Yh+nxnKfAURjxcfbzJrIpV3QbHuwGzCHrRCmSxP3GKRfquOsQylCroYvFoH8PcEW5HMFbXg5z+yzUgmW/2mPZQcipJeMBcsJPuwx4ivXL/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmffXtbsJfBkwLGSnHY2QekhML48foGS8HevBYkvPrM=;
 b=GZ7KL5kLjT/Q5QUiVkpqtA/ZgXaX15Row+ands0WgwWzeA2Kr6keJ64pMzpp1xRa1sF5QlzJnjtEEK9DUU8T5WN4sPpAEl2fuPybFryvtq2zlJ5dILEeM4EHKz1B8v2hwwOCIj4F+I9Rq62WSLN678RXKn8R/nA1t0cIPrMg1JcJBU+BTdsOLMnjzdxQZ+61zPAL5/q9z3UzP8ouK8MitJz36HqTNYDFO9Ax/VljCAdIP3N2xH/UFaw6IEOeeMr6c2KfbW3bmP03QNAEX2CxCrIszzn2TdZ+q/nReJPbE1c18a9Z/pMLZiXqLU3DJw/tt7Vgt26+UWqMbFoRACeMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmffXtbsJfBkwLGSnHY2QekhML48foGS8HevBYkvPrM=;
 b=Ik8WsacBqyBiFzZIEnbRb3cTS/Fv34U0jhLmobUvRRZNeuoi9WvhzSiq+wwqh7Z84Cg2JThAaowlnm0rwPiMGLzldRmzTyWtpPs6piFlQp+pn1RQ4QN6iH2/mOSvN8tahBBgyYuDNuW1c6oIRm81WNIlqeprrW5NQPOsHQf/N/4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8018.namprd10.prod.outlook.com (2603:10b6:208:50b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 13:14:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 13:14:01 +0000
Message-ID: <327de9a1-175f-4a8c-a163-6ea53c64a602@oracle.com>
Date: Fri, 26 Sep 2025 09:13:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Move strlen declaration in
 nfsd4_encode_components_esc()
To: Nathan Chancellor <nathan@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
        patches@lists.linux.dev, Anna Schumaker <anna.schumaker@oracle.com>
References: <20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org>
 <6669bd1e-ba37-433a-8f8c-5cd9787b846f@oracle.com>
 <27d0b9176a444dcf87ecd40c17b6ed1865c1b789.camel@kernel.org>
 <20250925203233.GB491548@ax162>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250925203233.GB491548@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: ee521f1b-4dcf-4d98-5398-08ddfcfe8f53
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TC9KeExGd3EwTTE5VklRbE1DNTFOWXpkaXVPWEY1c21oN3lidGdPYUtKUnhI?=
 =?utf-8?B?MzhGcjNCWFVFQW10UzlLbnk2SnNSTFlMcEtzaFdTYmFBYkFzNVlScEliNWlR?=
 =?utf-8?B?UkV3REM2RE1IN0RheEw1Tm9QOWlvN2hMdXNaZkFGMW5iaXcxL1c3ckVINXhG?=
 =?utf-8?B?dUpDWjNpM0VaVTJIRkZIR0xmTjhLbzB6WDhTSzhDM1ZOZTZMMllqZ3FFNlha?=
 =?utf-8?B?cmZ6eWFId2lDaExuNkMydlJFaTBITi8rTzFlZFFWQWxmWFRVaURQZWxGeUVI?=
 =?utf-8?B?eXFtbFdLbGpualI1aGxNbDlHM3kvdEg2VVlVYnlOT0pBOTE0M1RTdlJDUmdu?=
 =?utf-8?B?VnV1aHdnLzlrbmg1UGZwV3ZBS0lJR0tON21CN2dMMUl3TTdaR2Q3SU9BaWpL?=
 =?utf-8?B?YUxtcjE1YTlrWDBLZ2VWTkVDSlE5YjFTWU9MTzdXKzlKZWZ4OUFhNGxGSHpv?=
 =?utf-8?B?a29zaG8rRGdZeDVXdjFCb0ZGL0E2QkxVbGVPQzVmeTN1aWJwdkpVOFRham5T?=
 =?utf-8?B?L2poYVY3YnF2NVNBaFgxcTdzWDZQQmx4c2tva2FUb21UVVBMb1YwUXFaQXJO?=
 =?utf-8?B?b2RCVUJrR0xhWTMwVE9GdDNxeWFtT2lkdm5pUk8zNDhxU1I0aEZvLzlIRHpt?=
 =?utf-8?B?cS9ib0pBUS9yTmRGVW5iSUhSdFBEeTdNM2kwaEw3eGN4d0FMVERKVHNUU3B0?=
 =?utf-8?B?WTNKV25ybnlYeFJwZ2ZETTg3cHVybWJEWlp3Mktibjd0RVhuN2ZSam5VOEdY?=
 =?utf-8?B?L0grc1V6U0pXeWRsTTR3ZHhGRWgxOVRzRUJPdHZkeW11bFVqT2s1bm5jY3JH?=
 =?utf-8?B?Vk5yemtobzVkTkp2RFB1cXI3Rm1IcXFGODU0dUdORHFBTkFxM0NWSWNRWGV0?=
 =?utf-8?B?RjZDdk1ZYW1zdXdsMkZkYVRvQk12TVZ0R3dLN2pjQ2Q3eGdQVnFmaVUvcnJX?=
 =?utf-8?B?QlVISWU1WENHWU5YVmtwWWRBUVJCQzVYYUJ6QWlqekdZNkFGSzBWekpSQ3VV?=
 =?utf-8?B?eFA0eGRSL1BoSW9WNDJ0QjNnQlJ5SHozQ0w0eEJnZ094WWtBNVk1dHo5TFVt?=
 =?utf-8?B?SDEwdzBlK2x0STNTVWR0RnBVc0w1aHNmNG44d0R6clZwRmZ0QmlTbWxBb21P?=
 =?utf-8?B?RXFyeUlvdWxoYlB6aTdLcFhSa2lIa3dQQmhGS0VRMGZ3QXRMSGFBUFFDOXdv?=
 =?utf-8?B?bmdmSkJabmlMWlZqK3J3UzF3aU5Wd0U3N3hhY3YyOVZYcnl0SWxwWEVCWHhT?=
 =?utf-8?B?dmxNaGd6TGVsSHhuY1NEZHFzei9vQjl0b0laYmkwSStFMENTcEYzRmpwT0JO?=
 =?utf-8?B?RzF5Y3ZmNEk5UzIvbmVLYnI0cXdZMXI1K2t3eG5McmtudjhSL0xJMFE2aGtw?=
 =?utf-8?B?NkVVbTR2cjFrSXRJTThOdjNoYytRZGNIMWVRbHFRb1kxdmV3ZG9uYnMzUHRs?=
 =?utf-8?B?dFNLTTduT3BKcS9SUTFvK0pGSjBtSXhhTytkeU9NeTF6OXIvZi85NHZPSG5B?=
 =?utf-8?B?SjhyNzlCSjR3R1RxSEYyTXdQVkhNQ01xdXVwTTNWemxQUjl0aE0wTnVqWjc1?=
 =?utf-8?B?Q25jQmxRWGdSZHh1VU5ER3VtK0lWdWFqT0VvdWh0K2RmcDVLNWh4MnZBYVVK?=
 =?utf-8?B?ZjFrV0pveUtpdXZiZGRUNW5DSnQzaUpYMFVsVkJtajJmZGVTR3pLQXJSdUdv?=
 =?utf-8?B?eHkwTjFRNTNZR0JGTjJGdEdwVHNLYlZrV3k3dGNpRGxtbzVsbEFYV3Fzci96?=
 =?utf-8?B?bVE0ekpCSnNQWUJ4aW83MWE2S2Jqd2pIaVZ1QVM2SHRLZHgzWUlqcW1NVHNM?=
 =?utf-8?B?NW1rU2FVZG9kS0lHcDRRcGhERTZvZTBVbDNwd0dTWThQNXduTHozMjhBUC9z?=
 =?utf-8?B?M05VbS9UelhCUnFvOTVFQTlzdXpaVHVzOTduZi96dEFzR0E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a0ZQUlpIdUR3MVdiOFUyTFFodmVaNjlyQisyY2kxWisyMDhBSVZNQmxHMnJY?=
 =?utf-8?B?LzlnY3A5bTYrcnY2Rk5lM0MwQjFUSSswY0J3T1JXTGxCcHg2T1hUT3haYitG?=
 =?utf-8?B?dlM0VUF6SnpIb1VCcWc1Uk40MEN3by9Lc2RJeG8xcm1PelBBcENWREhqcVBv?=
 =?utf-8?B?Um1pMUUydWt3ODVpaTlXV1dSMTVUbnhBZGVhb0JuWitjQStaRUREN0VqeU1H?=
 =?utf-8?B?dkFoTWF3c2xtQVZ1cTNaRXVMTEU4NmlmYmV6ZTZMOHIrcmx5MnpBM3RDNzYw?=
 =?utf-8?B?aENSMEgzMzlveWNsQ0JtYytXdkpiVVgxbTdncG5taXc0MnFLTE8wT3NZNUhS?=
 =?utf-8?B?N1hDdjI4Qnk2ZHRmQUhydmlGTVRrQW1va3REQ2Yvd1JJOUZtL0Znc3dtMFFE?=
 =?utf-8?B?MDQ1dEZxVXVaN2xGRUlaTHVsVXQxa21PVnBIUzBsT043VU9Jc25xdWVNcjJY?=
 =?utf-8?B?ZDhpN3FaVlltRUUrdFBWM2ZUU0ZDazk4UEhyck1nbEpUYmJKSTg1R1lScEs1?=
 =?utf-8?B?aEtQODQ1NUFFNjdLWUNMQjRrNEViTXEzL282K2pMUXZJY2tvZnV5czR3TmMx?=
 =?utf-8?B?NWtEcFVRbys3bkIwT0h4RjM0QkVoUTRINzM2U09BNG9pdTJ6aGhrN1ZQazNM?=
 =?utf-8?B?aEtHUUJwUWkxZElJcGVmbVVxeGNFZ1UwYU5BNmRwV0RtMWFpck5CekUrRGMz?=
 =?utf-8?B?aFYrcFk2RjJRQy8wUmM3Y3Z0NWM5SXI0eXhKblhGRGdnYzhDMDluSDBvUWRK?=
 =?utf-8?B?ajdObkhEOUtxM3dQMjI2Zy84UC9HblJZanV6N3hqMFVMN3BORWNDbGN0ZVBD?=
 =?utf-8?B?TnlDV2JTMFB1VTVqVVVnbkR1SFhzL3pnSk55V0FLNzlvQlpjdUdpYnBaUmh6?=
 =?utf-8?B?RGxzcnphNG5KYjVxMmNlaTBYU3dYVzY2VjN6N21GY1Q1cnd3KzlGOThrYVdZ?=
 =?utf-8?B?Z0JZSDdSeUZvTmtldHZuL3p5Z0gzZld6ZlZyUjJHQzNnRHROd2gxa0NqcnIr?=
 =?utf-8?B?b1Z6S1A1RXk3Q2FoZDdhSGUzNkRnbHhOYThvU3U1MnJlb3lrU0xxcFg0dVl3?=
 =?utf-8?B?b2NnNHRIVlIwcDlQSGVZd1FzWFoxaUs3UDVQZEN4WmljSllLeG9JL2hCbjkz?=
 =?utf-8?B?TGZYdmdUUVRaWTl3L0h3UWxrTGVLMEIwc3JFRHYwaUlPWmhrcGFUazg4b1Vk?=
 =?utf-8?B?MGNFdDdTcm95dVlLWDY3RUd5QUJlS3g3TUZqQUdhWWswcHNVeThDL0ZwTVdm?=
 =?utf-8?B?b21XcmhvNllFNW54Q1hLKy9zL2Eyc3RGckltVms2NnJDOUJyQ3dqZW8vUmpv?=
 =?utf-8?B?bmN0NC9uNitjcS9adUhnUGIvdXNrUnJrVE96UU52U0s2ZUJEeEJBMzEzVzNj?=
 =?utf-8?B?RW93c2UxajlaODFzalBTdUhJbVJyYnpxMzhqakljTkpnNjhKUGNna1I4K1I0?=
 =?utf-8?B?SHZHcVRDWU1ZR0dtdXdsRzBNRGZDZnN5WDhLYktJeFljU0x4QXZlMGVnVTJh?=
 =?utf-8?B?Rnhkc3pubTZBMFJnVUIrMy9MNXg0bnRBd0RhRTJXcjhGNjI3cDkyL2lJVmNt?=
 =?utf-8?B?SXNoNjhGOXJNZGRkREJBM0ZEc2g2Mjk5TmZTWkNGT0ZNUzJ6ZElIdmk4M2hk?=
 =?utf-8?B?Vk9yVng2YmxtWjJJYldoSmhlTGlYQ3JkZktweDF5UG5vczFacWNsRnBTcFdF?=
 =?utf-8?B?Rjd2T2R4WG4yT2NITXozVWh6dkVHdFhxUnNueG5WQkhFWkhLVWpxNXcrTG5a?=
 =?utf-8?B?Tmo2Q2tIZjVoTHhSM1o1MmRpVUFKeFZab0pEaDcxSTdhMmhwUXNLajlzQXMv?=
 =?utf-8?B?RHMrRjFZcks5OW9ZS2l2RG8wNUttWTBPbE9PVVJ0M0wrQmFpbXliNy9WMVp0?=
 =?utf-8?B?WUxKdENQK241WlZsd2tjekdBbnBYWTNIQlVoL1NEWEFtaXIwRmRlUktkTGYr?=
 =?utf-8?B?OGxabTVqU0d3WSswZENsVTJHWG9uQzkyazN6eVRoajlaNGpYaFRVbDlUZysw?=
 =?utf-8?B?T0xXbkV5ZmxmVjM4K2VNMEs1WkFKVGlZd3BtU2pMOUZyUUtSSksrVnVYd3hu?=
 =?utf-8?B?VFhwR2tLcmJoMnBJYnNMOE8xZzJGdXI2ay9GTU5hSkF0VzUzcWJkN1Flc2hK?=
 =?utf-8?Q?qyIz/yOARhRuNwrXE5sAYT+mO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5v+F+wZjLguVZL3pJcX5xml9w+AhnEIoC/NicYyvIeqpbgBcoWbcO4O159rYUh6CHdikfAEcN/E+7fK+K4dMTuMDtkA9yG4ofnJjnA+1ktbf22YFf65WgUJ4EJRgCE03dcj4Fj2mhbcMNtiRCZtHVw8bQq5GFi+OlB0d/vk6nQGWBB81xNeQUF0iNcHuH/lwzXNiWQx0nSZ+ANBct64iPQyfT1Ox9omelqPXEiA8U4/8RccZ2ZslzX4QNeytYwTDEF2QehLpjQaT/cLnbVUVj9OW7r86/+2CX/SxoAbT8XO573jPrFkrKLohTxemeNlVpjcaOagM5tLRelAvsu+7O9d1g9IEFz3L+ChYfBheQu2i0Xt8lhQ+gM49D4eRQVNUWnCrtPvnq0HTfuE14hO5NmQ3BFpn2JvxvCTmNvLdA2Eh7mmmRzIBFrcndCLLrVZsL+GnczzREq9OzvfPzML/N+0Cyuoyne7FyVEqXys6H7Zq+2hnG0GrEvMt+/uE3FMUVS9rGlK+l5KvqAr5VWuETNB9IAdcTZcZMnKsv7BjrKXEN3ks9rYqoUax8OxLGK7iESKov3zuTSMYIHQ9iJ05B+7YmVZX1ev+y0Lz/JY5chY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee521f1b-4dcf-4d98-5398-08ddfcfe8f53
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:14:01.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpyCa+y02/3BhIBfOXRkCWRZ+VMoqF9pWONWSDh7i4vA5h1Bk+T8b0joU0OBzvnZrNLY4KDdsSyOnG5GIIVPaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=740 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2509260122
X-Authority-Analysis: v=2.4 cv=M+9A6iws c=1 sm=1 tr=0 ts=68d6919d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=blekLcpHyEOfQilNOmgA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: iTrqA2V1xXVoIAk08fLWRFR4Ik-T3jtb
X-Proofpoint-ORIG-GUID: iTrqA2V1xXVoIAk08fLWRFR4Ik-T3jtb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEyMCBTYWx0ZWRfX6O2sIbMAajjB
 o+5p2yAhzoaIP2y+CQ28OaJl2o4sGXugMuP9FjHt1DhCR1eYPxnwtJUTy1iSxJ0q+6FquO+v2wT
 sfqfJtUWIZRwBBChTsW6vh2SyssAZLQFHhs4+gG1QiKPbAze5h8yQ+yrSXIoFx0vlL+KDw70DPn
 8i4PjXdgzfJbFZv/Lmigyp8SRet4gZMJl8Lg87om4JvVqChiCMm6KCS0jtW5hNhdAvvNWuPZnSF
 FK96fOxBB8/A8ZWWmFltBm8p1nuTx6H52MCiLrBweMzbj1xbpfX5vmIQRQUifVRYoj8hKuMjHgu
 9LlUInExmS7xvgzc2O4XoWI3yOzti/zON75KvHyBeDvvkJ29vGtC7C9RUo7zMe4n46gPMxkWkFQ
 SfflA81TJ0AYoZyXv1UrKZJwjGIKPw==

On 9/25/25 1:32 PM, Nathan Chancellor wrote:
> On Thu, Sep 25, 2025 at 12:52:10PM -0400, Jeff Layton wrote:
>> On Thu, 2025-09-25 at 09:43 -0400, Chuck Lever wrote:
>>> Would anyone be heartbroken if this patch removed the dprintk call site?
> 
> Yeah, I had figured this print may be low value and worth removing as a
> fix.
> 
>>> I think renaming the strlen variable to a name with a lower collision
>>> risk would be sensible as well.
>>>
>>
>> Fine with me on both counts. No point in overloading a well known
>> function name here.
> 
> Agreed. Should I send a patch or does someone else want to?

I was hoping that the modifications I requested would be
straightforward enough that it would take you only a few minutes
to resend. If it's going to be more difficult than that, I can take
it from here.


-- 
Chuck Lever

