Return-Path: <linux-nfs+bounces-12138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9394ACF62E
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 20:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48A9174074
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A8B33062;
	Thu,  5 Jun 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WOJ9UHz0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fQ8ZazrC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA84400
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146906; cv=fail; b=KPoctsV9Nu4IUarpYx1aO+PyZrXC/8tjeci4WDy6BKh158F8P6mzmUNGCXDkq50pTuj/YVDJu6a/F8ET5q8HxOam4sr2AHSBsXbGKwEYkzEaSY8SVAvU3Cdd8mppCoZwhEN26hM6hdC8982RFPPG4HU9045ElOk8p6xGvagGhms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146906; c=relaxed/simple;
	bh=PDROf3uutToKu//C7DJae/UJWwMD0Eky1JmiASSYAv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b90grgoButHeOelNhxLs+u03Yh7XazKpqC31FwvUGK5K5vWmNk8pPlMAGcfeqOP9CUSoVe1FfoRCVNMPSYE26+BlFrlFGhTvK32ex+Wrh4yrybqWhRGiHLmj8DLXD8Hq7mr39QUAM4vz1MbjzOVAAXG78lw2YOyg1496OutfVC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WOJ9UHz0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fQ8ZazrC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555FtVtS022423;
	Thu, 5 Jun 2025 18:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4qAa52crwNStVwXymU7nlcGxGjvUbwCDy5Obmo5tL9o=; b=
	WOJ9UHz0Q78huGoPdm0Z7cWiQX5RSOuFtltxiaTegoOQLkS1PZLozPLFPWqlF7jR
	0JFDW6eyPAYYilRd5GXvn9XBzVNpSfWd/kA6W3mi54jWtj+E954V3Pn/Sk1Ajm5+
	f/aL440TlARdBmUsjuX3awh9iclqwcIQN6r+JbbUEIXOSG4BV2CvFGFq21Ey8YKN
	RM6trG58jMzClQmd5elxOS1ENronaLff5t/4eQQ3+27uhNhPURyfiqQmjh8DXl5c
	W548uG/quqaf9pmSuFMKLwZwTm2ZbNRggzJJZEi39OvtqCuEi/n/zlWeXhmoLpKS
	apmVMxTEbu0fvAcu5AHsZw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gem12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 18:08:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555Gqa8O040198;
	Thu, 5 Jun 2025 18:08:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7cmsmt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 18:08:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwUBBghkxVF9Hxf37oeiP7chs6baixGCpIGnHzKzxEahW3Fgdxilgmc7k/9GQ5pqxB5U2/91yEneCUbdB/Jqdct2co7zZRDZIrSjMZXUSjkmJr84p7bHMSF+GX3CHF5djGehPYS0MoZnfuGKEw1I7lm1tLD/cRkv3zac95c9xKkjCH0RMAPQkCuZ2y+uqvmclGJ1P/DR5aXHrllHOlPjimOPAtE2HwYVZ4EeGwLRr3SM3TDaJRYX/EnQP+Gwu3szSJyrKNciwFRno8OykodRXuWqm03QZF2KpEpwCSEN5SuSKozJdIXtxDcTyXaxOuY0DuRyqNksFrLGNFutd9ZgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qAa52crwNStVwXymU7nlcGxGjvUbwCDy5Obmo5tL9o=;
 b=TVbbWSxTRqvJy2IrZRCa9IFWPCLKcewes06lkJC2dkxl5VD23Mb6aIWujKG1iaVW6evqogFtljvP81bbRnqoBtxTLsgXkm0I0vu/D86e9auDn63UsaJbWCkE+rcjJByokRIgUwNrowB0Fj/CBPLxTPESjKqLW0bJcZfDmGq8CJvmu1kJlf5P2gjNd9Bx/m4dsybBJp9Dk432UmRa2DXlldkqMLuTjlTqWXHjQ8mLN2Lu4u1yR9XJ2h79QFDde9eHjoWQePaj4WEwG8IXhk3OhPnwSn1DJcqDvQ+aIOI1h9r9NAh2rkzumecnu7vP9MJdLJAgOD9XENa3iW2KXWaEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qAa52crwNStVwXymU7nlcGxGjvUbwCDy5Obmo5tL9o=;
 b=fQ8ZazrC+b980mEIYDqC4u4hqFuMhiY3QC0Gv85AX/s+FMRKi/TmkuTEWIJl0qMQ35wcI7dbMdOqC1lqSCgKxGusnwoOJwkEL4EaXCwnHmzPpGxu/UyuP+qICrDpS8H7OcEu5+kSFBcUPqM/Hgt+9u0cwREIXJEvKkdcw7yjrfM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4690.namprd10.prod.outlook.com (2603:10b6:303:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 18:08:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 18:08:15 +0000
Message-ID: <272781a5-bbe8-4181-972f-4b76eb93b1ee@oracle.com>
Date: Thu, 5 Jun 2025 14:08:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SUNRPC: Cleanup/fix initial rq_pages allocation
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
        linux-nfs@vger.kernel.org
References: <458f45b2b7259c17555dd65aa7cdbbf1a459d5e6.1749131924.git.bcodding@redhat.com>
 <cdb4ce81-c05f-4e60-b351-34d713a51e96@oracle.com>
 <80457CF6-99FE-4EB5-BC07-F4A8D9A8D8D1@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <80457CF6-99FE-4EB5-BC07-F4A8D9A8D8D1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:610:52::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a0c7e5-c81e-4750-864b-08dda45bf143
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZCs0UVdzZC9qUVNRRit2OFh4MXRhSXVabW56OTRNZ2U3aG53TWVtZzR1SFd6?=
 =?utf-8?B?RnZhVEN3YTc5TGZmMm9oMi91a0taRTFlbWlTOUY5aWhpRHc0RmV4SnhSb2xo?=
 =?utf-8?B?Vy83VGJtNzRocmJyeDFyVld0NG44K0FxQnU1RjdQWWZFTUdWLzA5ZFdmYVVY?=
 =?utf-8?B?UWgzK0JSa2I3ZkpKaWdJc3lpM09mbW8xTEIybzlqNTIxZ0c2VWx6N0NwcFAv?=
 =?utf-8?B?RjhGRkFSSWlLM1dVWmEzUU9FalJvNG5oSUMzZmE4amlTRkxZWkswa2NYZmdM?=
 =?utf-8?B?WHNKeHU5NHFXMGM5NTNuRVovUXhWUGJSWTl6RW9vUkFEME42WFlKU1FoS3VG?=
 =?utf-8?B?TjI1VlRKT3d0U2ZneGgwSVpRVmhxbkVXWXdoVnBOQ0hHQTY5Tlh2aGtDaHcv?=
 =?utf-8?B?UllmZGtBcTN4WS9jQm9CRE5rS0pFallnNE40aDFBVUJMbTJNQnIwOVc5Skkr?=
 =?utf-8?B?NTZwcy82M1ZqRkpsV2dBMWJSb3BaTUE4ZG1pdUlZN3VPZmZxMjg4R1dOQmlQ?=
 =?utf-8?B?QzRJL1FlUUNES0VsNDQ2K3d5UWloYVFuNmNyWVkzcjJ0UU55MlVUa2NKSjJW?=
 =?utf-8?B?THRvWS9HL2xQYUdoMStMOVlrQnIzd1AyTXFwbXpCL1I1TUJCWTE0TkN2SDEy?=
 =?utf-8?B?em4vM0ZyQStzTWN0a3dyZnl5RlFocmNmamkvdFB5cnFmSU5tR24ydlhycTN4?=
 =?utf-8?B?Q1Z6UTkzcXR2aGU2TU1tQ3ZoaFpkYWZ0dmRtNXpKTzZEbEN6bnZhaTlvRzI5?=
 =?utf-8?B?b1UrOHh6cWhnUFJTMmhFZStRT3B5SzFvTDhIS2VhWUxIN0MzNEFTVEU4RVpm?=
 =?utf-8?B?VXBUZ3U5N0dobnFZUTZ4WUdzRnM0bXUxYXJIYWt4SkxTeENJaWVKZldnUHhV?=
 =?utf-8?B?UXBtNzBSYlBZR0p4QTZnempLZXpuSThhczZRUENHNkZlNUNydEhhQnB2eDND?=
 =?utf-8?B?M2p0dVFGR2ttdlppa21XK3lQck40TktGZzI0THpwcmxYN0dncjdiTENTM0Fk?=
 =?utf-8?B?R3g4NDBneVd0YWViVWFqOXlaemhGc2F4R2diZlhXTjNjdjlzcmk4S2xPMFU2?=
 =?utf-8?B?c3VNd1lHdVF6UGphdDFrYVNidmJRNlBydE9YSEZmdEl2NWxMTEV0ckRFOXlQ?=
 =?utf-8?B?M05oZVpFOVcyVUJWVTFEWDZnZklpV1NKZzluYnlVaVhER0puVDNjU3pMWWlk?=
 =?utf-8?B?SHJ3K2dNKzRqMjhmMTFTOVdQZURLRUlyZGFqcEpTMVNTOWh6bjdxdWdnL3BF?=
 =?utf-8?B?cXRzNi9nV2VBNWhlWk1POHVhK1U1RVp1NERwMGRRcjlmd04vYUV0YUppdXox?=
 =?utf-8?B?R2MvWnhxbnZZSXVHZERHZnVwU05ZaVk2OVJvMnJxZG85QlpIUjJSdm9UNkhr?=
 =?utf-8?B?eFA0RDBIZzlEV2dMOCtIL1d0R2R6Wlk2OFdkSXo1a2RjQ0MybWQycVBBRkV4?=
 =?utf-8?B?bUhKb3dxOW8vWFY0b3NOWTVuanl6T1U3RnVodjdmcGgyV01vZmNpcGdMbEps?=
 =?utf-8?B?b0pCV3A5b3pZcXBRdndJYVcvMHZicmJMSEtUWlA4WEVIaHNtM1dkemV2Y1lW?=
 =?utf-8?B?QzBrcTZ0cjFSQ3B4UkRnZm00Z1p0NWtERVlpZ2dHUXZNOVRhcnRQN20xeVl0?=
 =?utf-8?B?enQvTnB5cTNGdzFnOHZORWxReXlReU1VYzBuM0FiMnVIM2F0VnlMV1dlKy9u?=
 =?utf-8?B?Nmp6NUZJbitTaGdDcDdIcTFJTVhwZFlDU2FBNDZRN2JLVk1OK2JPdnovcEZr?=
 =?utf-8?B?elgvbk9hM0l1WDJhdndjY29zc3d6a21zT0Z2UERPWmdqVHdzdmNlbjZlVkE3?=
 =?utf-8?B?bnE4ekhnaStaL3NBbzlLN2htcXRFM0hsM1k0WW5RazIyVFRDWDJNR3QyQ1ZS?=
 =?utf-8?B?ZjNhYTNmNVlCaHFyY1BnM2VKcXBMYzFxOURmRlRIL3N1UVk0YWlXWWdNMm5E?=
 =?utf-8?Q?eD00kQ05GVM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?LzdaNkFKN3dlajRPbFpmc3BUMlRyS2xrVE1jaEZHNnl4UzBxMXdKUVFKUEZG?=
 =?utf-8?B?YndURE5seDh5T1ZPY1VDZFR3YXozQUE4QWtZeUJYVExuUTZHQU1LSmx5NjFC?=
 =?utf-8?B?b3RKVXJtQmR3MTM2Z2lYSDFzMHJFNHBYWUJueFNDeHQ3Z2ErMUdnRkhtWjNr?=
 =?utf-8?B?aDdPZ2JyYk41MGxDQlBqRUplaGpiWjJaZHg5TVFTQ0swZWRNeXkvamszU0ZQ?=
 =?utf-8?B?My95dVdTSkpqWU9VdGVwWk0veElQVG92TW9ZQ3cyT2Z4cG5ZV0EydlBtYndj?=
 =?utf-8?B?amV5M0tVRTV0eFMvTGR4UjZUUHVNK1lKVm9Fd2xFSUd0ZTBzYzNna1FkMkJM?=
 =?utf-8?B?TlVNUzVUZEhPTExpc0pkdU1aZWU1OGpWMGlsSGdDRU5Kb0NaYXVYRjBKL1BB?=
 =?utf-8?B?UWxpeE9GSkpQTE1OTDQxQVQ0Z2xqYU9SVzlJb25MazFoamIvajZGSU9zaWVX?=
 =?utf-8?B?RWk2a3M2cWVDTWJFVGR6eUZiSEx0b0x0OE1hZ09rTy9NTlpmSlo0SFRMZitN?=
 =?utf-8?B?Smk5RUp3ak5wU2FLM2dXQmRqcHoxTzlBSk5MYkhRb1RWMy9hM1hTVk01c0VS?=
 =?utf-8?B?R3Fzc21qbXRtcnhNMzhOY3lpUFpMQ1FXQ2paMHJZbGlNWGFTcVBzWHg1OVFT?=
 =?utf-8?B?RnZLRWxFSlJsQXVGT2w4UGZaREZkNDRMeEFtUExoQTVSYkNxN09yS1V5NU0x?=
 =?utf-8?B?L2lsS1Y5dVgyd3dQd1Zaam1hVlFKRDZYcDlOUS9SRkRwcXJqeEplWTRybzRS?=
 =?utf-8?B?WHRncTNYdy8zRlJmRkR5V3AwNGEzTkxXQ09qSklKd3pPTWZWZnBpU0hERWFT?=
 =?utf-8?B?ZEhYTjRhQ1k4WVp1Y1c0L2NrNEt6dGFaUElEQ2RhVTRDc2ZxQ3JFMDB0bWgv?=
 =?utf-8?B?OVp4WHpITGRmZGJzSXAxMkhEbEs2VXZ2NGhpSk05TXJ1UStNbVZoSGUxZ3R6?=
 =?utf-8?B?YitmQmsxaFk0VkdPWkJIdTNhU1ltYnpGcjJGREpCVitUY042eWdTOS85MDR0?=
 =?utf-8?B?WGtla0Zod1VPMVo4aTd1bk9kamxKWkovL1Rnd0x5RVBaS1FZWTJ4MFlpUm52?=
 =?utf-8?B?M3VaN2hVU09KRnV5Y0pJQk9rQTF2TUJHd2w4NlZsUjlzNWxwckcxYkgxaTNZ?=
 =?utf-8?B?d2NxOG5MUzRZaStwVnZlM0drbURGUjZYNjJROWdvT2lKaDdXSS9QZHVGN0hp?=
 =?utf-8?B?cW1NZTBjRytsQnV0OHNZWFMyQjVscERmVHd2WUdqMFNwNDFhMXRCQUFrQ3Ur?=
 =?utf-8?B?dlA3dk1kckc2SExPTW5GdkxIWmhkTkcvRFpuUVg1aDNBQVZNMFhRRnhydHkz?=
 =?utf-8?B?N0JhWGhJYk5lS2dKY3VQek1tL1FBOUxQVVgrZDNYc1VyNHNMSzNBemJ3UVhh?=
 =?utf-8?B?dlp2c2lqQjFFU0FIVkY5d0d6SXhhMlE3anRtdmMyT3lRazBHNWRvdEc3VVFB?=
 =?utf-8?B?Nzd5M3F4SGZTcmxkcWpRRWROOFlqUGJPUUVnQ09HTnVMRkpLTUhpS3lXVDd4?=
 =?utf-8?B?ZC9zUEJJYkVJVFcvdlR3TFNXazZGVHl4MmFEL1ZsZmE2WFhVZHg3cldvYzly?=
 =?utf-8?B?VWZ1RlE3RVkzdlVmOXBJOHRxeWtDRm1GYXUyTUVSZnBBamdaL1M1ZENhSFVD?=
 =?utf-8?B?TFoyNzhJWW5EM1lmVm9GUmtEMEJpMGNzZkxwa2RPbHhENTAyVUdncUMwYWl2?=
 =?utf-8?B?RXp6WHZETjdxdDgyR0FZdm1tV2dxSkpveGpyU2kvOEFPOS9xM2NXNE5MWXFS?=
 =?utf-8?B?U1NCY25vcmJwSjdpUnc1QkRWM1V3T1hKL1NjTGhLOW02Y2RhUk11cW1CK0FS?=
 =?utf-8?B?MWV3NmdGTEZHZXRqWHUyRCtsR2UzcXZyUWN2aHNnbDdVQ09iUVhDQVcwbHpM?=
 =?utf-8?B?aG9LK0Z0enRqZWw5eWdVNnhBZVZqY1JJUzhYa2UvU2ZXN2FIZEtWWG9ML1Fz?=
 =?utf-8?B?MGxIVkFyYVJjckNXVWZvVUdhbjE1T3phZS9NVExyQUNvandNemQ3V3NjSndj?=
 =?utf-8?B?N1lqdHJhSWRuQklLUUdpbFM0bERZTG0ycjUxd3NRQkROVUhxUnoxeUxIdEVM?=
 =?utf-8?B?a0FhSXhWU3dOb2xRcEpMTHZwNEFtelphLzRnMFYzUmJBNisvMjZtSnJNYWd4?=
 =?utf-8?Q?SK4W6uZngzd8pVjpuVPWLk4Zj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	df93fSJVc/LJaMsDiDW0AYdshScrihNe5KyDNbBkN09w3aobFqEYd5cBcf1Kyevdnl2FCq2veMjKjV8Q3l2B8vOfcDQlS2CxLBb3Ukb86BlLFP9QmRvkFZbwhp8+fs4cRTcpxS8yRd+s4GC9AsBulKcHLLA3z8TXLwx+BGW28R+f/nLXzbK5CcUXGi3h7wF98AWs0EuKnQ09hPS0tZUoCrsTCQGCCOlNqCxpS/BSeVSlH649HWuHVukMrACnal5Wx5Zw41Z5zvm/oZj9lnTD1GmXNzg2Jov5L0HPgbWthGrfvjFTuN3XhZ06CLTW+HifKUKNHfWXs1qQvCyLuLzdE4j9R1QwH1XvRmy8WbZTLQVd2ivtPeWzO6loXMBYXb+4aahrt5H13SV0PPJzKhnnxgL82gax5pq0PMW1df1NhgQ3uZ7Mc51Nyv9lDvrnEqSak1QGoX4XTBNonP50JeUqgc2HpRjla+CGfze1t7BoIfTnqXD7nJ/I7xxIncxb5F40pQ+mXEzp88DplYE7VN1qaJBSFyQF8BRZ+If7oDhTPxMgGSu/yd0ExWbYlt78oBW3Wsuh2Z2DWTM645LLC9dnTAX+s4LGLhKKTHvAGqTHxj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a0c7e5-c81e-4750-864b-08dda45bf143
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 18:08:15.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NUHo3yGaDYBks9EtCAMfdWVGXM/eUCPzo2+l8NqexiGuqema/fqQAnIqLH3zmI/3rokUWj7RPpfJx6BdyMaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE2MSBTYWx0ZWRfX5XKwalXY5gyC 4FvQBfvIVpgsfbakaGDsH+QIYzJuXlBbZIfF+ez5eQI+W/LfA/XZyFNJ2nq8RSqaVIjTaA9GuSC efLBbYsiphOMHWINmlPG+KRmZpXjNMhQS3mSAtnQ7tEfFfXXHX0MVbrc5uo8A3mk4I0YjHfgYQL
 fOnUNWgqzlonTIyZMFwzZp65xhv1TbQz3HH0hv+B+oZsN5ra1HlF7/FIgFI9/Wd+9x1K8yltk+/ CbRLVoyZslcONsKkn51hCnq9g13PQinQuYD1FQ91NoJjXsubKeLQ27FNNe8mS3w7NbINnnk5F+z HZuKHdomBBUgWVkBZ86bjEF4YgznHhBGDud1XsC3kYNiSvuwxGZ9wuj6BJatFnKjdCfYYznM+fn
 nIsAZkE0adSgAuZK7/laOTd80SIuie2NOgaIfuPBczQMtUhRaKLZe/ksSiEZ6/PycbZ/eASH
X-Proofpoint-GUID: 9TBsEAZ9ANlN1rxejjz3Q8V74DiI3nSY
X-Proofpoint-ORIG-GUID: 9TBsEAZ9ANlN1rxejjz3Q8V74DiI3nSY
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=6841dd12 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=m_XMTXC7oRfzKfuoMskA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206

On 6/5/25 12:54 PM, Benjamin Coddington wrote:
> On 5 Jun 2025, at 10:26, Chuck Lever wrote:
> 
>> This doesn't apply to v6.16-rc1 due to recent changes to use a
>> dynamically-allocated rq_pages array. This array is allocated in
>> svc_init_buffer(); the array allocation has to remain.
> 
> Well, shucks.  I guess I should be paying better attention.
> 
> Can we drop the bulk allocation in svc_init_buffer if we're just going to
> try it more robustly in svc_alloc_arg?

Maybe!

I would like to understand the failure a little better. Why is mount
susceptible to this issue?


-- 
Chuck Lever

