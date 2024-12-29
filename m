Return-Path: <linux-nfs+bounces-8838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343369FDFC6
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Dec 2024 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17EE161D0F
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Dec 2024 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EDD158558;
	Sun, 29 Dec 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TKx5QXj9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LDLUbGbP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CB42AAF;
	Sun, 29 Dec 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735487175; cv=fail; b=RIoJnoJVbJfa+Di8Kxu9R+rp2XjpEPtcFoSEPDI7uw7iif1acpOzbD5ZchYA8g9hI31vGUsU9odZ4jQuvn6zHLUuQF6c+IWgZwSeLQf7ahzfKA4oFUuow2wCQczjrrYl4q08sqEGFSSQLXXlq+gWNaU0olXdn64raQ9GbleG20M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735487175; c=relaxed/simple;
	bh=fMeKUin4ux3xlaM4jCwF8S7u+XZZezcQDmp23QRf9Bg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X8B+BXzqo89Br8xT/87IiSg8bOUBeznouf7fxSZO/rbrtkdLHhTo0OyZgw/gXyhTL8oevhWNDjxRuzQHvkfp0XDLeAtBJwUU+mV9iYos3KP+LgFd3/4QonDvvtzdYHMLVjsR8BbMiN4RzZUmz752ma7lctLYiUr7L0Fjl0vrN40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TKx5QXj9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LDLUbGbP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BTFjVQ9022211;
	Sun, 29 Dec 2024 15:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DeajJmQPO8vzNORGZghsPM7JzZxxkp8gj9IDp9/ACkQ=; b=
	TKx5QXj98tyccOTyoiT3SR0MQVhSFbQY8QHgodbf3Vyf56hw8PPUhZJumcl6nnY0
	KFJtTOg3t83/lYwjdZL/wTBYxBsXjoxmyP1s0henhU/MHaUofH6pJTcAZQVCsdgY
	l5YwM0qCZnM1fervHMuXwNQGJ3zRlxq0mkNOs+1HxerWoxr5NjYqOhz0f5+bGZrC
	+T+6pZ3nmay2vTYDsYW9QjRdL2le2D281uQFKVtwvU6kHLr/BPlLFfcAjqHPB32Q
	ZY+XGxAdVdOvqdsiqCgM19fWCVXb7NVNzhp1f8BP5v1pxJuIEM9i26gYXB0sYj0v
	xzzzdXfOoujNe/U0Ivup1A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t841s9gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Dec 2024 15:45:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BT9wciJ012122;
	Sun, 29 Dec 2024 15:45:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s5umjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Dec 2024 15:45:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I886K5ovd5v4nq0q+gTD0e0p5rVug0Enr6JtH+ebHBKWuhr2O5hu8nBxDoPLgGGVL9Cid0KZ41ztbI1KFPMbenNvM9T2PoyXpdZccJ9LYJJWccg00cixLXuhHWD7SC9bnOceA53LLu0fRJCNlwBCF6xNTapLsT3ghk25FK1MFhR4ovnC6Ba/XzypX1GOPjzZVgdd6DFlJ7IAQwDuSW9wA/K4R1dmWlGK5xrB/1wTZEM2e//N015FCQUZ0EuRVZRjbM3kNxCaH307QxvVt5f6lN9O+gEZfK24GuII/F3o1zMsJAnhfsLOmVRcb/E94qW8n63NvksyvWNCaOnHFejPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeajJmQPO8vzNORGZghsPM7JzZxxkp8gj9IDp9/ACkQ=;
 b=GBzWbkdzrJF9bua4XifYCDz0y63U7sL/2Ov0JJD++kJEgE1ynx5JelKcXVcT6tV/E66bGqE0IE1h5u6EYhOMPQsw58IkE94gIIoD/R6gDO92a4M69Wuy37H4yzoBeo4WUyqdl1xATifGZRVGClusBMcxHDFdLEBwZAvk39s9rC1Le9MrYWRsHOHRrFkyP3GIc/hozC9xZ/1t51mRmwNYMOvWpO3EpIGZo9tAWjk29tE8SYm1hdpagmL8nYn3bMW4fublX00JCyRUnsRUEyAD63fBstT0rgdYEM4e4UbiMBna2cbMWN5Zml+XRUYgj483TmadD1/bj2wmGIO6y7tPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeajJmQPO8vzNORGZghsPM7JzZxxkp8gj9IDp9/ACkQ=;
 b=LDLUbGbPNkhrsBHE1uE/D3JdZfpWoHrnQG4KI514ZZUYSN1EnnnKz4pO5mxLYZpPYlwRxAIKp/gUO9g5JFGiLJpx1VUyU64+PK6GM2Vuz+3wFRXz0pb2aTrzirkqujs28VhQODmGPKf4CMuDgFmX/GBw41Ur242YVAo6ZGaNUBg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Sun, 29 Dec
 2024 15:45:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8293.000; Sun, 29 Dec 2024
 15:45:47 +0000
Message-ID: <c3e323af-fd21-4de3-8c26-5b584e6937ad@oracle.com>
Date: Sun, 29 Dec 2024 10:45:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10/5.15/6.1] nfsd: cancel nfsd_shrinker_work using sync
 mode in nfs4_state_shutdown_net
To: Vasiliy Kovalev <kovalev@altlinux.org>, stable@vger.kernel.org
Cc: "J . Bruce Fields" <bfields@fieldses.org>, Dai Ngo <dai.ngo@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        lvc-project@linuxtesting.org, Yang Erkun <yangerkun@huaweicloud.com>
References: <20241229144557.1203112-1-kovalev@altlinux.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241229144557.1203112-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: b79b2693-da7a-492a-c068-08dd281fdcb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0luZmp3dlpONzExby84RGxjRTdpQkk5RWRubk5ack9rek0xZW4vako5RzBD?=
 =?utf-8?B?eHRIam93Rjd3UDdja09Xa3JOamxxV3F1MEs4L0NCZ1VwNkRVMGl6dHR2Wnlk?=
 =?utf-8?B?WlVTa0lSVWxxRXJVM0V6QnhLL1lwZmExRUZMb2RuNCtvcEZsRkdUZkR1NDVO?=
 =?utf-8?B?blJXQS9KK1cyU2k1anVWNGV0dlhFc3AvUVRBSUw1THVHcnFRcmtWTDhTbDB0?=
 =?utf-8?B?NkFzZlVZQnd3eDRMdkVrcnh6U1hSbmRKd01RQ0Y5NUMrb3B4bURHQm1qUURD?=
 =?utf-8?B?TXBsRzRsWmEzRzROME9pMHMwN0NTcUFrMnhUT0lRZEZMcmRlMlpGRW1mSkNu?=
 =?utf-8?B?MkR3eGozMXBFQW1ZMlVIc3ZZRzZNakNpKzd2R2FRNEtYdTIvakUxajRtYXd5?=
 =?utf-8?B?WWJzZlNSR1cyS24zb3ZkUXNnbXBpc0VPS29qb21mVk5HZHJ5RlVTK3NGWUlW?=
 =?utf-8?B?Q2ZvdTFMWWp3MW5iZ3hPR2ZoZmdwL0c0UEZteHROd2xTOTIydFFJenZtYjg5?=
 =?utf-8?B?WUdEM28vbSswb1luWFpmRkx3eFduenhnTUtEa0NiUWhXRE91b3pwVGs1ZUc5?=
 =?utf-8?B?RUpQVmNRdU5IcklyRTlHamUvcXJKaFdDL28xR0Z4Ym9RVGdzUGZ3cytJRlFX?=
 =?utf-8?B?b2hzMGpOMUUvZHFBQkRhMXN0TjFNcHRTYzIzRlpISTFraXJmTjNQUml1WDZF?=
 =?utf-8?B?WlZBNlJ3RW1CejhEeUJ5M1Z2VE9FdHR1UTBEWWREd0lEYWgvRnZ6MnppQTVv?=
 =?utf-8?B?VHk4YVNQWUhKL0oyaXpXU1ZSN05pRjJBRmVtZTZSeXA1WjJLM2RhcXQ5c3ZY?=
 =?utf-8?B?NEFwRnJqQnYzemhvR2pMdGVqZ01ZaysvUW1QSWtFNnV0eVJJaENhSmtIOE4z?=
 =?utf-8?B?TjBaUTdINUw2Tms1eG9FQXk5YUFmZmxtak5xdFRaUTZyOVUwWURIWmtQOU1s?=
 =?utf-8?B?MjJkNDlQaFBVRjNMb3JicHExeGdJTzd0eWtCRFI4V3I0Q1REVmhtRm5zS01r?=
 =?utf-8?B?Y2k5WVEyWUtYUEIzN053UUMwRlNoLzdmWjhwc3VKWC9wNEdIbVBiT3dRZ0hC?=
 =?utf-8?B?Vll6UmF3cDNBS1hQZkVBZk93cWJRazA2bitXcTJXTnFncmtYa1YxVStqQi96?=
 =?utf-8?B?Mk5SSEM5aC90WUYzMXdTcE0rQ0U2b096a1ptYVZGWFBqQkYxUXYvaWtIMjdC?=
 =?utf-8?B?d3FOZjRxdGR2YngrOGlMcXNBM0VlZ251UHZCcmtzRmFVOTR5SUZiaUU1alhL?=
 =?utf-8?B?RzI5TFJqc0Q1Nm5LS25vUk9JQmw0NXJZa3c0RlFHdDlmOUh2bHBwZllzcFBC?=
 =?utf-8?B?WkZNZVUyMjJ2U3l6MmNYTitNdVBhYzVuNDlGT3NyN3pGQnpNbzBDV3lLS2p5?=
 =?utf-8?B?M3hVazBEWWpDY2JmbUQxcXlxak5uMHdaeWNlejhEbUJyRG05RDRteVVzdDhQ?=
 =?utf-8?B?Q1N6NTJYZUt0ekVnTEhzK2pTdzVndVVXWHFlOUlqMjU3djhDUkczYkMrNVNC?=
 =?utf-8?B?NFljQnpqd2pXKzhzeWdzdzNYY1BRT2lDVWdtNnlwakoycW9JTStpZXU1Z2tu?=
 =?utf-8?B?NWVkeVN3bGo2SHR0NU84S3F4UnFSVGx0SDhtM1dQU3RpaVNUMTJadC9Jb2Yw?=
 =?utf-8?B?aWZSUWJLZ2tKdlpoR3Yyb2FDS3JFa3JidFFmOWFHOTI5cGNWYnRmRkJWVU5p?=
 =?utf-8?B?SWpRQytiNFZSUHZwd3hWTUYzSXBtaHRDU3ErbGREcEcrM0puQmdwdWdPRWRr?=
 =?utf-8?B?ZU43WWxXa29RYXptN1hnaCtSV1FTcXNLdEZ5Y0h0dG8vVVZmdURxUE9TT2Rp?=
 =?utf-8?B?Tjd2aS9yRHlxY2JBbzB2MzdwaGgyNDJpcGVPbHl0N3QyVUJ6RlRqL0dwSzBU?=
 =?utf-8?Q?vwWkCokgpAec3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkpZR2VwUFlHYXBYeUtwWVJRbjRFWFpFS3AwTWxVemdGa1ZLcTREWGRxVDBD?=
 =?utf-8?B?enFpY1FFSFdxRnFwNk9FU0dLNmYrenBQcHRhRzVsNVlYK1pqOXNIbklCRmdr?=
 =?utf-8?B?M1lqdmdOcVVEenhRNmJPcE5FVkFQZWQ3NWlWRVFSOWFPOWw1TDUrUktESWR1?=
 =?utf-8?B?MENtUmpJS1cvUzhHNkF2RHFUYTZNNnVHT3ZXai9iUzRCZ29kU0JyVVRNKzhj?=
 =?utf-8?B?bTdKdFdLRGRlZ2NqOThzZlhseDNNS1FHdXIzVlJMa3MxOXdNbFZETWJNRXhz?=
 =?utf-8?B?cCtBZ2xjS2ZUNWxqNUQ5UGJab2NJT3FyelhVUDE2MzNVU1dtaDhwL1BSd1FU?=
 =?utf-8?B?WWFzM3NFTDM3alRDVDVNcHZ2S1ZEOTF3UllpcXU1NmdYV3NGSjN0a1YzaE01?=
 =?utf-8?B?QUhFU1BxcFlkQy9tV1FBVHgrSjNFWkg2Q0FYeHRtRE9icERDOEJadWlmenU1?=
 =?utf-8?B?eXZ2VzRhYzF4UkMySGtzYU91UDFQc0JrR052K09zUWRIbUJCR0lYaE9RT2NO?=
 =?utf-8?B?NmVrNksvL0IvYWFzUG53RDBwOXFJQWpoSndLL09HaWF1TkR3YUNhMEVZRi9h?=
 =?utf-8?B?VEFlbGFOVU1hQjJGODR6SXJhUjBoZFM4ZWxMbFhGN3NSazZaTU8yN2tPUGwv?=
 =?utf-8?B?V2t4Z3VkNExicGJGcWFBYkwzWHE4dlgrN1U5SHEwWUR2NEdhaDJtbzBWYk41?=
 =?utf-8?B?K1BiK0VjNnREREhPbStkc1lOMS9hWUM2MzBBUkFORDBZUlpmUktuekRZT2JT?=
 =?utf-8?B?azVER3RDVVM4Zm1jaGc0TytOZTVaZHhpN1dpMzRiTXZDTGZSY01PS3EwSkJa?=
 =?utf-8?B?aVVjU1MzWUZZblZPQXVuYUd0aitidnZRTmZ5OE1IMGZCNHBXVW1sbDlhSFhv?=
 =?utf-8?B?UE9YVWc3bkhlVFFKZ2o5SUZSL0lqamlmcFB1Qjd6M2F4YjRWRjBUUFRVOU0r?=
 =?utf-8?B?Z08zTnVLeXZ4NE9Uc1IzamppSlg2OElDbnN0QTUzWnh0ZmZRMUFSQlJieW5j?=
 =?utf-8?B?cVlCblgyZDhMVy8yb3htcWZhUGo2TEtmQktzQW9BVmU4L2ZSTmZ4SW4vVURR?=
 =?utf-8?B?SlRvRm1SWTdqdjY2elJCeGlHWTdZaE82TXZ1YTJIaHhtT3RJM2huLzg5MTRw?=
 =?utf-8?B?aklNOTd5a3UyRmhwTWVha1VBOWlEZzFNWDE1S055dVFza0JuMThzWVRxOW5G?=
 =?utf-8?B?SHErMWpITVhvSjczV3VFWHVhZ0ZKK21yck5WYjNNMThJNTRPYXpCNzNxRm9n?=
 =?utf-8?B?TTVFeUhhbXNDVnZQR3UvUFpzK3hrcEYwVXVKSm5TY0hwZ25WeHI0Q2RDMkZn?=
 =?utf-8?B?aVNONEtjR1BqNitvS3lsK0VYWEVFKytsSUc3cDlRdVBYaG5hVVQrNWZVV1Ba?=
 =?utf-8?B?ZkpYTnViUXR5TjZwWGRZNVowbEw1eTlMVmdZRnFubUQxSnBoelVJQ0dkTWJO?=
 =?utf-8?B?WWIzU08wYU03TUhvZ0t4SGZkK0JranNWRjVVRFpWaERwT0p1OEVuSUh1Wnk4?=
 =?utf-8?B?d1FWdnVqY0ZlemRvUWwrN3UwN2ptdUdOU3FYNDJITm96S1NlNjh4d0k5bUdo?=
 =?utf-8?B?cW91eHVJZmNjd1c0WDgveHJsaHByYTFtcG5xa3Z6dk9rUnNnUGJEdGNNdFgr?=
 =?utf-8?B?Q3BiNkMwR1NyTkJWQ0h6WVNnSkFPbU9VZnBMdnBHSU41YWtiUjdoYWVsallh?=
 =?utf-8?B?N2hSa3d6aWUwUmFoMjZoWjFCenhuZzR1MFhXK1lLQ05SdVpneExiUEp3Sjkz?=
 =?utf-8?B?RWVKVXE0YXhxcXV2ajNENTRiRFJFTFBucENKNWFKNUM1RHhFaGtUK3BYQjJI?=
 =?utf-8?B?UXNkK2RPeW51ZG95V1FFWjBwWTk0Zk1pL3NYQnJMS1FKaVlXTTFSQ0FyeHli?=
 =?utf-8?B?cHNlUU0vV2xROVhvZmhMNWF5UEZKekRKRWxGczN5VmNXOXFFOHJEZmJzZXhP?=
 =?utf-8?B?aXZGYVNPcFRJanhGQ2lWZ2plOFAxbzRHN21vVVcydlFyRkJkVnhzQlhZWENR?=
 =?utf-8?B?YXRhK3gydVdta215ZkU0NER6dThKZ3QzWHROWWFTTEVUVE45eTdHMnliSG1E?=
 =?utf-8?B?ZEwwL0JGekF2dlBTTnFvbTNFajNiZDR1Z1F6WjhDcWJUb0czME9idUdmKzJI?=
 =?utf-8?B?NHlQMVVranpLd2hoT1k0d1lEZFphdzRnbmNoK3lrRVNpQWl6WEFxaUhIRko2?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J/NrKv59wGvs6LbW/NcRQ5LuW1TM54KVoqLB5WzNrB+rrRVMGsxwcN0UKCXteLpBAfqVS/8ZBgLsxKdirFh5/7UDmu0x+9DgCQg71RjVP9IoajURQPf7PEBxAI63PO5It+IM0tPC7jJ0LCQbrIK76cgVhpXtc/aaNKSCk3xysIncRuf0pXLib7231RsAQ1JIrRaCvJu4M93nd25EYPEQATptk4LZBn9Xj/6OHotciptT6gYveA1/vIyYqv0uLRH0CJkCeMNaUd0Nw6V8SNg9WIKbnUHQWWogwYHg9Q5F+UYCM6kNzzYSL3xFLcmKs7g4QbNa5GbNQ0dxVJx3eAlgPVWGtvfcQv7TyGDoaM4gL0cK228RgkgnKD9PFPuAQiP1/AOj/k02wzQJQXq08vmcpyUfp8bq7KL8Nm7Plmj9d6IrsTvKL4gldTBqtaLBkKfVoynBOe/GmmY0T5AzzNS8rwhMXEQVzwrgmz1K2CnIN+E2WUdlojWJgcCtPVvNP18ka3hOKABoxvxCC4LX/NW/HCIuMAzITVgeDA2x8cFHYTe9Hj9Xa4B3WN9PYw/zEgUOY76m11dKwFjK0oKJl6r8ZKhJpSq9CKutVViW4LPSPAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79b2693-da7a-492a-c068-08dd281fdcb8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2024 15:45:47.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWttI7IdXrWYqLy2Q+WQ8JBpFl54VcO6Vy4prlu9HHhAM4PQO91r20W1jlmw3CsZtFRr9HuFAiO0ivZDEsUfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-29_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412290140
X-Proofpoint-ORIG-GUID: D08JIckFcCs5T-g6YHIwz81DfgPYRd4n
X-Proofpoint-GUID: D08JIckFcCs5T-g6YHIwz81DfgPYRd4n

On 12/29/24 9:45 AM, Vasiliy Kovalev wrote:
> From: Yang Erkun <yangerkun@huaweicloud.com>
> 
> [ Upstream commit d5ff2fb2e7167e9483846e34148e60c0c016a1f6 ]
> 
> In the normal case, when we excute `echo 0 > /proc/fs/nfsd/threads`, the
> function `nfs4_state_destroy_net` in `nfs4_state_shutdown_net` will
> release all resources related to the hashed `nfs4_client`. If the
> `nfsd_client_shrinker` is running concurrently, the `expire_client`
> function will first unhash this client and then destroy it. This can
> lead to the following warning. Additionally, numerous use-after-free
> errors may occur as well.
> 
> nfsd_client_shrinker         echo 0 > /proc/fs/nfsd/threads
> 
> expire_client                nfsd_shutdown_net
>    unhash_client                ...
>                                 nfs4_state_shutdown_net
>                                   /* won't wait shrinker exit */
>    /*                             cancel_work(&nn->nfsd_shrinker_work)
>     * nfsd_file for this          /* won't destroy unhashed client1 */
>     * client1 still alive         nfs4_state_destroy_net
>     */
> 
>                                 nfsd_file_cache_shutdown
>                                   /* trigger warning */
>                                   kmem_cache_destroy(nfsd_file_slab)
>                                   kmem_cache_destroy(nfsd_file_mark_slab)
>    /* release nfsd_file and mark */
>    __destroy_client
> 
> ====================================================================
> BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
> __kmem_cache_shutdown()
> --------------------------------------------------------------------
> CPU: 4 UID: 0 PID: 764 Comm: sh Not tainted 6.12.0-rc3+ #1
> 
>   dump_stack_lvl+0x53/0x70
>   slab_err+0xb0/0xf0
>   __kmem_cache_shutdown+0x15c/0x310
>   kmem_cache_destroy+0x66/0x160
>   nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
>   nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>   nfsd_svc+0x125/0x1e0 [nfsd]
>   write_threads+0x16a/0x2a0 [nfsd]
>   nfsctl_transaction_write+0x74/0xa0 [nfsd]
>   vfs_write+0x1a5/0x6d0
>   ksys_write+0xc1/0x160
>   do_syscall_64+0x5f/0x170
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> ====================================================================
> BUG nfsd_file_mark (Tainted: G    B   W         ): Objects remaining
> nfsd_file_mark on __kmem_cache_shutdown()
> --------------------------------------------------------------------
> 
>   dump_stack_lvl+0x53/0x70
>   slab_err+0xb0/0xf0
>   __kmem_cache_shutdown+0x15c/0x310
>   kmem_cache_destroy+0x66/0x160
>   nfsd_file_cache_shutdown+0xc8/0x210 [nfsd]
>   nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>   nfsd_svc+0x125/0x1e0 [nfsd]
>   write_threads+0x16a/0x2a0 [nfsd]
>   nfsctl_transaction_write+0x74/0xa0 [nfsd]
>   vfs_write+0x1a5/0x6d0
>   ksys_write+0xc1/0x160
>   do_syscall_64+0x5f/0x170
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> To resolve this issue, cancel `nfsd_shrinker_work` using synchronous
> mode in nfs4_state_shutdown_net.
> 
> Fixes: 7c24fa225081 ("NFSD: replace delayed_work with work_struct for nfsd_client_shrinker")
> Signed-off-by: Yang Erkun <yangerkun@huaweicloud.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> (cherry picked from commit f965dc0f099a54fca100acf6909abe52d0c85328)
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
> Backport to fix CVE-2024-50121
> Link: https://www.cve.org/CVERecord/?id=CVE-2024-50121
> ---
>   fs/nfsd/nfs4state.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 8bceae771c1c75..f6fa719ee32668 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8208,7 +8208,7 @@ nfs4_state_shutdown_net(struct net *net)
>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>   
>   	unregister_shrinker(&nn->nfsd_client_shrinker);
> -	cancel_work(&nn->nfsd_shrinker_work);
> +	cancel_work_sync(&nn->nfsd_shrinker_work);
>   	cancel_delayed_work_sync(&nn->laundromat_work);
>   	locks_end_grace(&nn->nfsd4_manager);
>   

Backport Acked-by: Chuck Lever <chuck.lever@oracle.com>

Not sure why automation didn't pick this one up.


-- 
Chuck Lever

