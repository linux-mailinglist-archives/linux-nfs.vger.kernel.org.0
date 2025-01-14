Return-Path: <linux-nfs+bounces-9203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A69F4A11102
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 20:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862851888104
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68511C2DB2;
	Tue, 14 Jan 2025 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cApw90EY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BNm34vkX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7A1D54E2;
	Tue, 14 Jan 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882282; cv=fail; b=UhfqrM9fykIpHXzn2CM41EFWJYhIQqaUi21tUOjbhOuqOBDPY/KStRoK0SfeZHrDVjIEaphDB6cxi4rSdzILYZWFONOoinO76LdJ8o1NRa4jetUQ3cvVuTuvZ9hfu6ROZxOD52chSacsBW4Lct6zU6Uqeuexu2XrGsIVhaglaqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882282; c=relaxed/simple;
	bh=2pCRfanXlkOgoVcYWzjvX1HM+WN/vpXM9TVRV4VCRRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ECkgbqXk4y5lNpwuOb9IxU+FcX/tFhU2NtVfEtdszlJU/fwIwu0oeZ5EnzjXzodvqkj/rvL4Z10MinustPOGZTSXlQzkXf7iVV/rsczvnmYh0NvD+rEB1YS4123QDIGPXzcjqZZlj+X31lg9xFJ99jjJyWIlluKZEdEPv48MlOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cApw90EY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BNm34vkX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIXo49026869;
	Tue, 14 Jan 2025 19:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZOLT6g03/Rg5eG8sWnqQgCOcE4mAuNEUQMyaP+cjOD4=; b=
	cApw90EYY75NF7LLZIxBGnM0BjgOybye4pQCZjrpbrMXEFgp3J9uPHOqL5m4qiYd
	TXAaDMw9VLesGR10OZ88cPZ738Jw089x4Dw1Ky0NHABrpWLhNs+ShdwFsMdktiDu
	pWiFenxIHQQXkv6fgmKy+mhQ0t11XxTCsLGylRk339rhvCWawXNkJ/FrEQ3c9WS7
	fUdP5jgQvuicCoWTMLXO29pL3WZAJZ034h731v9qLZVVlvjYALuwVnMkE9D6ueSI
	p56MzqC9mjDnecA6iY45+y56NwCNx5T4iaE0Bu6wRgy6z61pLRMw4dKaeOY6zmCV
	IlJQKqxSF7f7eOLAo15bQw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcpk01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 19:17:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIDqH2020444;
	Tue, 14 Jan 2025 19:17:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3eu88q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 19:17:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/juT09ljhIL4QxE4jkAyueXaVHW2WF/eE1mrSGT34XGIPG6nRqNGh+4lN+sR0cQYUlB7ZMJbNH8YGE3xHuRLHCkTVHGxe5ow+5cgb0AltcpIaXunm9aMUy1Dgdg4EOjhXTHpCH03eXsFe0BGaRyfh2oljHAg+yv08BPH0Q21g++tbFmTbAUNe6srddTxh7OuNaZo2ffqB0DSPtX9rghVCMUbOWZwion3QBz7c1gK3B804sHgtISXsvTyT8LXZrIf4CIABUJtCv9eu4P46GtuEwrpnF5q7vu02SKpwXefrSOnBxhELeNuUiRjUGYcnsSJCZqO8cqME7luKNAE0lilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOLT6g03/Rg5eG8sWnqQgCOcE4mAuNEUQMyaP+cjOD4=;
 b=NTiwUGQ7IRbvnmtWFgxomwrWgVkCDw2/WZoNc+bBk2rblQTXuSIJ7349P0hXNslN8DxOtPLi7yMJTYonQKFmsPusQBTjuJvKDSQyIDU/LHaDzJP6GPh++mda9Q5UCTGG5Oxb0xe5Z1eNAbHNEbx2/yAxzUsHbRmXZjfbycHCdHfzXDdqqygqBZyYbBbkKHjJWKnwXC+2aYa53+ZSQgziTjZTG0kJnpVI8xbos18PWej5YuSFszVE59xFfuXrWcC3x0q7lVeKfZXy8uPlbKKmVdVckQhP/AjGOgWSAqd0m+cFF+9LhORDvaDCll4bNeHwmtVcMofNqMU0e3/2aalofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOLT6g03/Rg5eG8sWnqQgCOcE4mAuNEUQMyaP+cjOD4=;
 b=BNm34vkXSIMbqoQW1OWfBRIr4Nml9nRokcA1gRJPEtaK6JjKb/VDlWVzGBPeZ5p2kW533BzWgZx8Goki4qzj0HIJ1/YvImFdufGjvTxYXPXItDXxePEbc3cHzeoZoEfG7guLV9wH5hQGCY9V/p6wnPcqc1nbUmAoQ21MUBh9XeQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6100.namprd10.prod.outlook.com (2603:10b6:208:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 19:17:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 19:17:25 +0000
Message-ID: <9370397b-8a15-4251-acbd-9dcee42c96b6@oracle.com>
Date: Tue, 14 Jan 2025 14:17:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
To: Li Lingfeng <lilingfeng3@huawei.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
References: <20250113025957.1253214-1-lilingfeng3@huawei.com>
 <37d6dab7-5031-4b96-b66e-9ba8f17d1adc@oracle.com>
 <48364ac5-8417-4f3b-8d9f-350d00a24d0b@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <48364ac5-8417-4f3b-8d9f-350d00a24d0b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:610:75::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: d17cbe6a-9bd7-4cbd-6f7d-08dd34d0142e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDNwa24vNnI4dGZBSlV1dlVxbnkvenh5MjJWQUVZbW1DZW1xRTVFT2FxZm1G?=
 =?utf-8?B?dVo4bzBpOStMZjFGUUZXbEoyVk5BbHYxamVuVTJhK3V0dlZFakhLZUJadjhQ?=
 =?utf-8?B?YXZlL3VCL0h3SXZDZHd5Y1Q2R1JXNzBUUC9UZHI5NXdhREFnREV5L1piR21Q?=
 =?utf-8?B?cUJFaGlxT0tsYjdsYnZCc0VwM0lqYWQvelpUNDVrTTdYYVZIQlRiOGxxQURk?=
 =?utf-8?B?aGcxVXZiSkxVSnl1MDZWR1ErTDN0LzRwYnJQQTczek13bGFOeDNGanVyOGNV?=
 =?utf-8?B?ZFVjQ1dFaGlsSlpqNytjd3BraUVpeWh0VmdxQUdKZllzSE50UUVBdWFpNG5K?=
 =?utf-8?B?NEFIamc1cVR1NUdzdUdzTk41dytRUGxXZDZ1NFo5cjJmUUt0ekxjUG1QMitM?=
 =?utf-8?B?bEJjQm1mcGQ5M0craDd1M1N0T1ZHQkpCZU5mb3UxVnN1SVh1SnhTUWZteksv?=
 =?utf-8?B?OTg4ZXdhQXJIeFV2blN3R0ExNmo3aFpVbTFEOWE3RkY5M1hibm9OZW9XcktQ?=
 =?utf-8?B?R29rU3hleDF5REVGS0c5U0VJRUsrRi9HejhFVmNzMUNrMTg3eWxSUFpwaGVx?=
 =?utf-8?B?QzNtMExiSC9xVkJ0NWY1aTk1eXppV1k5Y3dSVXlrKzJ5dGwzcWozdTQrQi9w?=
 =?utf-8?B?WTZvWVVLZnI0T1BVSmgxdEdFUTV3UmUzRWxaT1J1aDFwTWEzLzJTK0wzSmgy?=
 =?utf-8?B?MmVQUk85WkVnNWtzMnlWaXIyNGdxeVF2bWFOYW1sQWpsajVqeTRUWUZ2dTdx?=
 =?utf-8?B?U3Z0KzdQTVRHVmRzblU5eTF3N29wVXJmSEVucVpsMk1XUUMxNUtZVm9hUGw4?=
 =?utf-8?B?cTNjbnRjd0Qra2E2M3pzOG82alBMcFZGdmd1UDArSGtySmhJV2RqNm1NS0hT?=
 =?utf-8?B?VVpaNUZMSzJuVEpjOG1CTXh2RitVemVaTEp6dUN6RGJlcnNJdTlvc2VzNUtj?=
 =?utf-8?B?T0ZjQ3c1MWd4ZU9jRWg2VWgvRlhDRHBiMGRZcU9xSGp3VEo4MmdrNHRQcmVE?=
 =?utf-8?B?VndCbUhDd3Z3d1BTWDZwSmkvb3RaS2xyYVhNTHIvMk1MZEtWUVFqK0lwK3hP?=
 =?utf-8?B?MHN2eUd4cHBXVmttVFRQbXpSOFJBd1paSUlKYmY3aUppZnpseUVuSVdGYTl4?=
 =?utf-8?B?L1pGWDYrMkhTODFYZ0k0Y2FaNTFRT1c5YlVTdlZ5aWdMOEdvTkJQYVNkS0Z6?=
 =?utf-8?B?ZXltSVJRRHI0Z1lMWHExTHg2NnNOS3ZTRGlBUmVZaExPUXgzYk02aXBqYXhH?=
 =?utf-8?B?aXl3czJEUUxLL2U1ZTEvWWpna2ZpSHNhdWlTY25nSUgwUzA3WU80YWJmazdu?=
 =?utf-8?B?ZHg3ZGRuellQTHFpcHF1ak81cUtKYW84WnhTeThGWVRVQk1ER05HUnkrb0pU?=
 =?utf-8?B?Y1h3K1lTejhkdEFEc1NqRW9nNHpjMnVic2lTZWRGNElOWDVwVE82UTNTUHhl?=
 =?utf-8?B?dE5kWE1UZ0Z5RjVzdVBtSllhR2FySURoUHduWUlxZWdJMHY5U1p4cUlVakZt?=
 =?utf-8?B?WWtrdWxUVm4yaXNkUlh1TXlCWmtZMGN0a2dIVkplMkVFZ2NiSXo1M1dIMFRG?=
 =?utf-8?B?QjJNR21oYTdSdzZPUVhOTHZGaHNSUHpnak5Ed1A2VjFHakJmVm5Vc2lrZWxt?=
 =?utf-8?B?LzVON1VMMG0zSkJqTUlrS1BzanhuNHkvT0FGK2V5d21sNGFEa3BQakxiKzkr?=
 =?utf-8?B?Wnd6elhSYzd3Rm41NC9ZeStxUzFDVktkQnV2M01Vcm9ZazFyVi92OWJ4ak1V?=
 =?utf-8?B?OS84cW5TSkNXbjY2b0oxdUwva3BFaFBWalZZalVRdnRWYzJ0bTg4dlJGQXo0?=
 =?utf-8?B?RUN3V2s1UHRNaC85VFpMdDZmc2kxYUVBUzExT2d5YTgyZ2JqS1A0eWFhaG1m?=
 =?utf-8?Q?jvr4iVOhPHqL+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFRrZXlKd3E1cEVMbG5BRGwwb2MyZHo1VkZRSDhmdWV5d2N5YUd2dHp0QUk2?=
 =?utf-8?B?MUkyeGR2UFNncWZnZWFtMklhTU1veFZUTUNoZGJCY28rVi9HU3lZcVQ2a0Uv?=
 =?utf-8?B?WmxIWTdEMThtbW9xcDkyWlZwTm1CeWNpeHZwTTh2UElpSmV6MFl0UUJINURk?=
 =?utf-8?B?aDJMbGQ2bWJ5ZFNVK0c3Z0FJZ1dGL1h3OVh5bWs3MWNnM0FXTjR2RVp3T2xR?=
 =?utf-8?B?QzR1ejQrWUdWK1k4WituQlo0V3ZjQnoycnJ5UElpMG54S0NYUWNHaGxzVGF2?=
 =?utf-8?B?OS9YWmxDRWI1ZTlYaDNnUlVLWCsyRmNsMUU4ZVYrNStFakJzYW05N3BMT0RY?=
 =?utf-8?B?ZkUwY2t2bnloMis1S1ExbkM1NDZhem92QTNsR1pNUnh6Mk0wVkMydVNEOUJW?=
 =?utf-8?B?cjZtZ1VtUTA2VEJPcnBremdQT2JaUjBudFRma3JxQ0hFTzlqVGJhak9Bbmor?=
 =?utf-8?B?OXRxL0pNekZPZ05RZ1RiRVozVTZhdUZLOUZ0U3dMY2FnNmNjaGwvUWRZTG1P?=
 =?utf-8?B?d1QyYzByNWxYeWpMUjdYUjNDU3RBOXZOTVF4R0NJQnVXL1Yxc0ZjSlpnMEZV?=
 =?utf-8?B?SXFKTjhPZWh3QVVUcWpkV2llakJzbGxOQkVLVVpiTUM1Z0xzaWd5bVlqaUVu?=
 =?utf-8?B?U2JYMzhjeEUrcEU2cytkQ0NMZmFuRlRHTXFUZi9IdW9zNmh5cGtlbU94WkR0?=
 =?utf-8?B?eGZoZWFPSkZBTGxoOU9TaHRCR3pyUU9iUGZ2aGVaMnZZb0gyTzJaZW9qOFc5?=
 =?utf-8?B?bllvMzZtcmtVdmpRUzREMC9YWnloeXp2aEdRU0RHeGpqdmhKd1dHbGp6Uk1T?=
 =?utf-8?B?UEZEd2g0c1VHMktaalNSZmJrKzZuM3V3dzFBK2ovdldaVi9yMWptZE1BY1lk?=
 =?utf-8?B?OTBiS05qNjBMN1UzNFJNUDdWYWRHRVZwMEtocDlEbnprZ1ZhUWVIYzlwZVVq?=
 =?utf-8?B?Zmp2SURiSXE1Ti9EalZJQ21qeVVKS0JWSUdiQWtNRUpkYzEzbXJHRTVRU2NK?=
 =?utf-8?B?dW9qcmxzK2E1T1Jnakl0d2YzaHlVVDFmU2p0R2ZIVnQvajhEQjVwOGE1NHBQ?=
 =?utf-8?B?RnBiaXN2d1E4UHVxUkpsOGJPcThxTFg3NS9ORGlBREI2WjMxVE9oWGx3a1ps?=
 =?utf-8?B?SmpTUkprbWJZbmg1bXQ3aEhIdk40anh3ZXZJdFpMMGJFd3p5Z1Q4d1kraGhH?=
 =?utf-8?B?VitOZ2RRZzFzNHh6TXRvT1hvNWxrZTR0Qm9KbzdWd3RUaGJrL1hLcWFkY2dq?=
 =?utf-8?B?NXZYWDJNTTZjODhYUXhlckZVQUU0Tm9YNmhHVjNnZFIySm9OcnhmbE9Zb1NB?=
 =?utf-8?B?QXJqeGpRcEJCMW1hYk5kYVB1LzF5SHNrY3VyOGJFWGhka29mYnBEcHZSdDA0?=
 =?utf-8?B?c3pNcnIxRWFlSExHQ0JxNVNYVHJ0RFJjSWRXNEc4M1l4Z093QTA0T1RGdlNP?=
 =?utf-8?B?QW54N2JEOXB6b3pFS045aGhhM2NxckZ0YTZpOVNCUHNvaFBrZ1o4UFU1d2VL?=
 =?utf-8?B?RTdEWm5Wazk4ekhDWkN2NlVPK3d3UEp1Zkt1Y2ZBSEU4NTNnQS9ZUzNPQjg2?=
 =?utf-8?B?akJBNStqOElXTmFrN2JCWk1TUTJjQ1Vyams4aU9aZTdzUGpqSFIvVmpxd1BH?=
 =?utf-8?B?aS9JZ2Fhdm9kczc5T0QwSUN1UkhJQ0tDRnhYZE5LOWVpbzYwMDYzb29rQUZR?=
 =?utf-8?B?RU9BSjF3WE9vcHV1SDJCdG52WjNZaTdYN0k0ZmNQN3RWSm1lZ0hXRGxVdlVq?=
 =?utf-8?B?NytYRXVjdzR6eDZzTXlJTDVCTHhjeUdWUGlIRzI0a2w1VzhLWEMvY0oxdFF0?=
 =?utf-8?B?emwreFY3K2FKQlM3ZGQ4WUFQekR2T3BldjNtRzZSUjAxbktyM3JjRnYrOFE5?=
 =?utf-8?B?R2lIMUlBN1dHZjBuRG83TVVoSTkycDBFSlNTMWx0bnk0TVNDMldvcXlIWXlH?=
 =?utf-8?B?bk8yeERUSzZaREJtZFlYNVNaVGFzTFRnSTdrNlE0WWJoSjd5cHRYdURRcGd6?=
 =?utf-8?B?cFg4cmRuV2tKSGxhZlBIS1hQUHlMOFF6ekRmMjJUZGpyRzN5cmZqQU9ZWWR1?=
 =?utf-8?B?dE5vTnBZdnJRcDdTSU82MHFLNFNXNldLSFBXZCt4NzRtMk5qM3pjdURKeXZU?=
 =?utf-8?B?cVYrejIyUWJmYUl6Y3IrNUJUNWxQZDNVT3AydWFrNHhEMWJjK1ZJSWo5SUdZ?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vYH0d5ld6Bu727fQByDLHN0GgUxRDhvqrVUvNTAB5O+5mHzK0SsCZf4nxPFPQa6/1otnBFApZd2CFxhfyH//0PcvthGrxWR5wPSKWT03msHBWkO/bgVeVySLY57DS6tFJXLp2EVmMv53ZdTZC2woFfaNCh0J/TE5ORGj/kmPnZb7hTd7sqNo5YTkpYFNyOEozSohM3E6BReTC1kooUOSob4lqMZXaNbTAfupyVEoP5HgGpj8Bewd6U86ONMMoSLJag2RKOSEfcGrfRxPqjFct1qgcHwlM45PdEQ8K9bI7R3QonglUhxSIe6ZS9/H+EQyW131COwrOX2sNlGm58D/ASxY7RYZZbYp5+LbpHzp7JV8hKWNHJI+PI9Plo+1y3stz2XM3Wu5VTcNufQsSnH48BsJ1EAJr3eUpH5PQZHCwrNCEzygPYPCTeXbf7vxpagVb9tPn6LjLMuKecW74/4iuqtdAhzEU1Pn2hM83PSwpWH0WKMcW6YFbT3IaNpK6ILfJ92J2/a1Jagtnf7DJCK/7qLyXZPAVvcd+c52l1Y8ykmAE3t+r+rmbe3AFHHykg4x6NuE8mGIE49uYt6rWrlN/kIwaVBaBA+PfAeVbLf5apc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17cbe6a-9bd7-4cbd-6f7d-08dd34d0142e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:17:25.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ9CKyiTWK2cw5Znmk6nwF7Re2pG+kwz3HzTRcCaQuVA+TKprxva3cPCCTFcYVAk3IOYJeebr5UGwgyVlJ8ddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_06,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140146
X-Proofpoint-GUID: W-j9sG_RPcYVpE1FvvCspGUC3NeLtVee
X-Proofpoint-ORIG-GUID: W-j9sG_RPcYVpE1FvvCspGUC3NeLtVee

On 1/13/25 8:54 PM, Li Lingfeng wrote:
> 
> 在 2025/1/13 22:07, Chuck Lever 写道:
>> Hello!
>>
>> On 1/12/25 9:59 PM, Li Lingfeng wrote:
>>> In nfsd_file_put, after inserting the nfsd_file into the nfsd_file_lru
>>> list, gc may be triggered in another thread and immediately release this
>>> nfsd_file, which will lead to a UAF when accessing this nfsd_file again.
>>
>> Do you happen to have a reproducer that can trigger this issue?
>>
> Hi, thanks for your reply.
> 
> Here is the reproducer:
> 
> Patch:
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> 
> index 585163b4e11c..8a8245b0ce32 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -356,6 +356,7 @@ nfsd_file_get(struct nfsd_file *nf)
>   void
>   nfsd_file_put(struct nfsd_file *nf)
>   {
> + static int count = 0;
>          might_sleep();
>          trace_nfsd_file_put(nf);
> 
> @@ -370,6 +371,11 @@ nfsd_file_put(struct nfsd_file *nf)
> 
>                  /* Try to add it to the LRU. If that fails, decrement. */
>                  if (nfsd_file_lru_add(nf)) {
> + if (count++ % 3 == 0) {
> + printk("%s %d sleep before test...\n", __func__, __LINE__);
> + msleep(5000);

This will certainly misbehave because garbage collection evicts files
after 2 seconds, and here the reproducer waits /5/ seconds.

But I can see how it is unsafe to continue dereferencing @nf after the
reference count is dropped. Jeff, any comments about this failure mode
or the proposed fix?

More below.


> + printk("%s %d sleep done\n", __func__, __LINE__);
> + }
>                          /* If it's still hashed, we're done */
>                          if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>                                  nfsd_file_schedule_laundrette();
> 
> Steps:
> mkfs.ext4 -F /dev/sdb
> mount /dev/sdb /mnt/sdb
> echo "/mnt *(rw,no_root_squash,fsid=0)" > /etc/exports
> echo "/mnt/sdb *(rw,no_root_squash,fsid=1)" >> /etc/exports
> systemctl restart nfs-server
> 
> for i in {1..10}; do filename="file$i.txt"; echo "123" > /mnt/ 
> sdb/"$filename"; done
> mount -t nfs -o rw,relatime,vers=3 127.0.0.1:/mnt/sdb /mnt/sdbb
> sh test.sh
> 
> test.sh:
> for i in {1..10}; do
>      filename="file$i.txt"
>      cat /mnt/sdbb/"$filename" &
> done
> 
> [  205.114996][ T2409] 
> ==================================================================
> 
> [  205.115006][ T2409] BUG: KASAN: slab-use-after-free in 
> nfsd_file_put+0x190/0x3b0
> [  205.115055][ T2409] Read of size 8 at addr ffff88810798f3e8 by task 
> nfsd/2409
> [  205.115062][ T2409]
> [  205.115068][ T2409] CPU: 1 UID: 0 PID: 2409 Comm: nfsd Not tainted 
> 6.13.0-rc6-00038-g09a0fa92e5b4-dirty #83
> [  205.115078][ T2409] Hardware name: QEMU Standard PC (i440FX + PIIX, 
> 1996), BIOS ?-20190727_073836-buildvm- 
> ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> 123[  205.115085][ T2409] Call Trace:
> [  205.115095][ T2409]  <TASK>
> 
> [  205.115101][ T2409]  dump_stack_lvl+0x68/0xa0
> [  205.115117][ T2409] print_address_description.constprop.0+0x2c/0x3d0
> [  205.115132][ T2409]  ? nfsd_file_put+0x190/0x3b0
> [  205.115140][ T2409]  print_report+0xb3/0x270
> 123[  205.115147][ T2409]  ? kasan_addr_to_slab+0xd/0xa0
> [  205.115160][ T2409]  kasan_report+0x93/0xc0
> 
> [  205.115168][ T2409]  ? nfsd_file_put+0x190/0x3b0
> [  205.115196][ T2409]  kasan_check_range+0xf6/0x1b0
> [  205.115207][ T2409]  nfsd_file_put+0x190/0x3b0
> [  205.115217][ T2409]  nfsd_read+0x151/0x3b0
> [  205.115229][ T2409]  ? __pfx_nfsd_read+0x10/0x10
> [  205.115238][ T2409]  ? lock_acquire+0x15c/0x3f0
> [  205.115249][ T2409]  ? nfsd_init_request+0x6b/0x300
> [  205.115259][ T2409]  ? rcu_is_watching+0x20/0x50
> [  205.115272][ T2409]  nfsd3_proc_read+0x1c9/0x280
> [  205.115285][ T2409]  nfsd_dispatch+0x1b7/0x4c0
> [  205.115294][ T2409]  ? __pfx_nfsd_dispatch+0x10/0x10
> [  205.115305][ T2409]  ? __asan_memset+0x24/0x50
> [  205.115315][ T2409]  ? rcu_is_watching+0x20/0x50
> [  205.115325][ T2409]  svc_process_common+0x615/0xd20
> [  205.115346][ T2409]  ? __pfx_svc_process_common+0x10/0x10
> [  205.115359][ T2409]  ? __pfx_nfsd_dispatch+0x10/0x10
> [  205.115374][ T2409]  ? mark_held_locks+0x24/0x90
> [  205.115388][ T2409]  ? xdr_init_decode+0x11d/0x190
> [  205.115410][ T2409]  svc_process+0x2a8/0x430
> [  205.115435][ T2409]  svc_handle_xprt+0x71c/0xb40
> [  205.115458][ T2409]  svc_recv+0x5f1/0x9b0
> [  205.115477][ T2409]  ? svc_recv+0xab/0x9b0
> [  205.115501][ T2409]  nfsd+0x1e7/0x390
> [  205.115522][ T2409]  ? __pfx_nfsd+0x10/0x10
> [  205.115536][ T2409]  kthread+0x1a7/0x1f0
> [  205.115551][ T2409]  ? kthread+0xfb/0x1f0
> [  205.139288][ T2409]  ? __pfx_kthread+0x10/0x10
> [  205.139769][ T2409]  ret_from_fork+0x34/0x60
> [  205.140238][ T2409]  ? __pfx_kthread+0x10/0x10
> [  205.140701][ T2409]  ret_from_fork_asm+0x1a/0x30
> [  205.141226][ T2409]  </TASK>
> [  205.141548][ T2409]
> [  205.141809][ T2409] Allocated by task 2409:
> [  205.142254][ T2409]  kasan_save_stack+0x24/0x50
> [  205.142726][ T2409]  kasan_save_track+0x14/0x30
> [  205.143214][ T2409]  __kasan_slab_alloc+0x87/0x90
> [  205.143694][ T2409]  kmem_cache_alloc_noprof+0x162/0x4a0
> [  205.144268][ T2409]  nfsd_file_do_acquire+0x3a2/0x1420
> [  205.144812][ T2409]  nfsd_file_acquire_gc+0x5a/0x80
> [  205.145338][ T2409]  nfsd_read+0xc6/0x3b0
> [  205.145766][ T2409]  nfsd3_proc_read+0x1c9/0x280
> [  205.146226][ T2409]  nfsd_dispatch+0x1b7/0x4c0
> [  205.146682][ T2409]  svc_process_common+0x615/0xd20
> [  205.147212][ T2409]  svc_process+0x2a8/0x430
> [  205.147652][ T2409]  svc_handle_xprt+0x71c/0xb40
> [  205.148140][ T2409]  svc_recv+0x5f1/0x9b0
> [  205.148569][ T2409]  nfsd+0x1e7/0x390
> [  205.148966][ T2409]  kthread+0x1a7/0x1f0
> [  205.149388][ T2409]  ret_from_fork+0x34/0x60
> [  205.149838][ T2409]  ret_from_fork_asm+0x1a/0x30
> [  205.150330][ T2409]
> [  205.150646][ T2409] Freed by task 0:
> [  205.151120][ T2409]  kasan_save_stack+0x24/0x50
> [  205.151778][ T2409]  kasan_save_track+0x14/0x30
> [  205.152409][ T2409]  kasan_save_free_info+0x3a/0x60
> [  205.153073][ T2409]  __kasan_slab_free+0x54/0x70
> [  205.153677][ T2409]  kmem_cache_free+0x159/0x5f0
> [  205.154169][ T2409]  rcu_do_batch+0x311/0x900
> [  205.154643][ T2409]  rcu_core+0x58c/0x6f0
> [  205.155065][ T2409]  handle_softirqs+0xf8/0x570
> [  205.155526][ T2409]  irq_exit_rcu+0x141/0x160
> [  205.156004][ T2409]  sysvec_apic_timer_interrupt+0x76/0x90
> [  205.156575][ T2409]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  205.157196][ T2409]
> [  205.157416][ T2409] Last potentially related work creation:
> [  205.157986][ T2409]  kasan_save_stack+0x24/0x50
> [  205.158404][ T2409]  __kasan_record_aux_stack+0xa6/0xc0
> [  205.158893][ T2409]  __call_rcu_common.constprop.0+0xa5/0x8f0
> [  205.159515][ T2409]  nfsd_file_dispose_list+0x93/0xc0
> [  205.160067][ T2409]  nfsd_file_net_dispose+0x1ad/0x1f0
> [  205.160613][ T2409]  nfsd+0x1ef/0x390
> [  205.161021][ T2409]  kthread+0x1a7/0x1f0
> [  205.161451][ T2409]  ret_from_fork+0x34/0x60
> [  205.161908][ T2409]  ret_from_fork_asm+0x1a/0x30
> [  205.162407][ T2409]
> [  205.162663][ T2409] The buggy address belongs to the object at 
> ffff88810798f3b8
> [  205.162663][ T2409]  which belongs to the cache nfsd_file of size 128
> [  205.164061][ T2409] The buggy address is located 48 bytes inside of
> [  205.164061][ T2409]  freed 128-byte region [ffff88810798f3b8, 
> ffff88810798f438)
> [  205.165446][ T2409]
> [  205.165678][ T2409] The buggy address belongs to the physical page:
> [  205.166340][ T2409] page: refcount:1 mapcount:0 
> mapping:0000000000000000 index:0xffff88810798f4a8 pfn:0x10798e
> [  205.167356][ T2409] head: order:1 mapcount:0 entire_mapcount:0 
> nr_pages_mapped:0 pincount:0
> [  205.168204][ T2409] flags: 0x17ffffc0000240(workingset|head|node=0| 
> zone=2|lastcpupid=0x1fffff)
> [  205.169071][ T2409] page_type: f5(slab)
> [  205.169483][ T2409] raw: 0017ffffc0000240 ffff888443a06500 
> ffff8881214b4bc8 ffff8881214b4bc8
> [  205.170431][ T2409] raw: ffff88810798f4a8 0000000000220005 
> 00000001f5000000 0000000000000000
> [  205.171554][ T2409] head: 0017ffffc0000240 ffff888443a06500 
> ffff8881214b4bc8 ffff8881214b4bc8
> [  205.172630][ T2409] head: ffff88810798f4a8 0000000000220005 
> 00000001f5000000 0000000000000000
> [  205.173509][ T2409] head: 0017ffffc0000001 ffffea00041e6381 
> ffffffffffffffff 0000000000000000
> [  205.174587][ T2409] head: 0000000000000002 0000000000000000 
> 00000000ffffffff 0000000000000000
> [  205.175538][ T2409] page dumped because: kasan: bad access detected
> [  205.176193][ T2409]
> [  205.176427][ T2409] Memory state around the buggy address:
> [  205.176997][ T2409]  ffff88810798f280: fc fc fc fc fc fc fc fc fc fc 
> fc fc fc fc fc fc
> [  205.177810][ T2409]  ffff88810798f300: fc fc fc fc fc fc fc fc fc fc 
> fc fc fc fc fc fc
> [  205.178601][ T2409] >ffff88810798f380: fc fc fc fc fc fc fc fa fb fb 
> fb fb fb fb fb fb
> [  205.179420] 
> [ T2409]                                                           ^
> [  205.180190][ T2409]  ffff88810798f400: fb fb fb fb fb fb fb fc fc fc 
> fc fc fc fc fc fc
> [  205.181000][ T2409]  ffff88810798f480: fc fc fc fc fc fc fc fc fc fc 
> fc fc fc fc fc fc
> [  205.181844][ T2409] 
> ==================================================================
> [  205.182677][ T2409] Disabling lock debugging due to kernel taint
> 
>>
>>> All the places where unhash is done will also perform lru_remove, so 
>>> there
>>> is no need to do lru_remove separately here. After inserting the 
>>> nfsd_file
>>> into the nfsd_file_lru list, it can be released by relying on gc.
>>>
>>> Fixes: 4a0e73e635e3 ("NFSD: Leave open files out of the filecache LRU")
>>
>> The code that is being replaced below was introduced in ac3a2585f018
>> ("nfsd: rework refcounting in filecache"). This fix won't apply to
>> kernels that have only 4a0e73e635e3 but not ac3a2585f018, for instance.
>>
>> At the very least we need to add "Cc: stable@vger.kernel.org # v6.2" but
>> I'm not convinced "Fixes: 4a0e73e635e3" is correct.
> The replaced code is indeed introduced by ac3a2585f018 ("nfsd: rework
> refcounting in filecache").
> However, commit 4a0e73e635e3 ("NFSD: Leave open files out of the filecache
> LRU") added the nfsd_file_lru_add operation in nfsd_file_put, which
> enables concurrent removal of the current nfsd_file by gc, potentially
> triggering UAF when accessing nfsd_file below.
> Therefore, I use 4a0e73e635e3 as the fix tag.
>>
>>
>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> ---
>>>   fs/nfsd/filecache.c | 12 ++----------
>>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index a1cdba42c4fa..37b65cb1579a 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -372,18 +372,10 @@ nfsd_file_put(struct nfsd_file *nf)
>>>           /* Try to add it to the LRU.  If that fails, decrement. */
>>>           if (nfsd_file_lru_add(nf)) {
>>>               /* If it's still hashed, we're done */
>>> -            if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> +            if (list_lru_count(&nfsd_file_lru))
>>>                   nfsd_file_schedule_laundrette();
>>> -                return;
>>> -            }
>>
>> The above change does not seem to be related to the fix described
>> in the patch description. Can you help me understand why this is
>> needed?
> Firstly, I removed the access operations on nfsd_file, including checking
> nf->nf_flags and nfsd_file_lru_remove, to prevent triggering UAF after
> concurrent release of nfsd_file by gc.

Understood and agreed.


> Secondly, I kept nfsd_file_schedule_laundrette and used list_lru_count to
> determine whether to trigger gc, with the aim of initiating gc and
> reclaiming nfsd_file as soon as possible even if no other process triggers
> gc.

The list_lru_count() remains non-zero for extended periods which might
cause the proposed code to trigger the laundrette more often than is
optimal.


>>> -            /*
>>> -             * We're racing with unhashing, so try to remove it from
>>> -             * the LRU. If removal fails, then someone else already
>>> -             * has our reference.
>>> -             */
>>> -            if (!nfsd_file_lru_remove(nf))
>>> -                return;
>>> +            return;
>>>           }
>>>       }
>>>       if (refcount_dec_and_test(&nf->nf_ref))
>>
>>


-- 
Chuck Lever

