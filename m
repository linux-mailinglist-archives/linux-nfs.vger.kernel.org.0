Return-Path: <linux-nfs+bounces-13217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABF0B0FA6B
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 20:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A50160B07
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B721F418F;
	Wed, 23 Jul 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b9b334Aw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yN4f0CS1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018571D6DB6
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296190; cv=fail; b=ky7HNO6gXrjnC0jUezSdFe22rClwGnMVtCUPONmDxX1y4SJQIV9sj5xebINEuloN9sM/Sxjprf6pRNwuDhAhUkpF5kYa8L1WeEdawoerPiS/N25BK1orzgO5epaoTkb8xqEgkYaoDtxrAU8uAr/i+wyQz/a2YCSyCfk++dALSUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296190; c=relaxed/simple;
	bh=4+sE439+iHTHEV7e+H/mbXFZrbj/KpV9AE+szt5Nvn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oaj8bOCtu4cUwXJc9DFzEIYQzxaW30oklTWfhKDEvOPUFz66CnlYkfy3vrwlDLi+8cjcFVpr2ZKJ2/VdXJOInLevVWaE5HdSlqyuibU+OH0zcgWpU6+Ap5Jffa97BABIV8TvhEmJethExmv8ijH7QWIeJ0v02/avdEaNyRTdk4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b9b334Aw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yN4f0CS1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHtwXH013308;
	Wed, 23 Jul 2025 18:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jsPQEkB35DMWTSLdu/OZebataraZNqM3u9V86m68Y3E=; b=
	b9b334Aw1WMznNeeot0w0r/0hmu25tpM6Re4nZsfJwRVpna1NNC9r6q00HPBJq0W
	uC4lykn7C62+VpX6iByG7j82UyIzIz3xnlZx4ZKdCtyU/EfZ5QLhNZB6SRts130s
	0w9LZbnpyzRra+VAn092hiWx+kt0XsrKAzWW8ymNaao67fyAUegOydLmRp6MbFKb
	Is6U2rhfNaMQP/pYoo33/Ywsmk+qlopV0ah6Y9k/LX3dsKHKsT5xf58iDWsQw6BR
	Y8mXW6TyGbNvT2+HK2OTj/pk9i0L67KLmSb6P+eT8YOYByATjJfgGc/Al3IAW31c
	qkIN2awE62qZjuYx08pfdQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056eg567-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 18:43:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NIH03j038445;
	Wed, 23 Jul 2025 18:43:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tayr95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 18:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5JO+15FNf3hKfQ84qWFtXv4YlWT3b8Bp5OxX6nXqoxRfpX00w7/95grphC/efUR7cd7e0auS9vo9mrNkziokuqhIf8uHscVlWUE5mygXr0LNHm/lDMfqnz2YB6qSKrY98tbRv6bCK9XacEKWZyKVAEmfbL9ZuHNbpvYlf8uzr0gosD8MA9326/fzqkISNzN7/J0k3Qf+kfDd1pg2C0+0zj/mTZcsKqBjbzn+eOVGyvRhBbNhoUAGS0Bey5Eys3NLgfM/rLgNcsidZQa6s2mqE2p+wBze4vCwtMhxqshrw4NrM0hP6AAvQ4dnymqSdU7Ny5rq/FuDBbjltXJOMYmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsPQEkB35DMWTSLdu/OZebataraZNqM3u9V86m68Y3E=;
 b=Y04I8F4fLIddujHHAcK5IIacwQboctyGssMehM/wTxwTu5liXZhv4lVr7iwapc2DF7HkmxscTYfUD3t09CrOndaPaCskeQvS2KalQU6t5vyCZytKbFc55XMJ4IHGDBt/kOiW3YhaakoGimPDdS0Um41/ThJGxGR9feEX6CglWe/QHv7uYvE0gezH17rwB0qC3hVCkpofv/mInbwA9gE+LpupMxTF9sBKSSQhqrLDCNQN0Fx3nLiGiAfpojF5BVuip2qXzn/7w/C+3tZaQVktOTk7ZeUJIpQG89u6AXPWt9PBSaStCSfulOOawn5Cex8XNJkdsmKoNNGhjNzG9sAHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsPQEkB35DMWTSLdu/OZebataraZNqM3u9V86m68Y3E=;
 b=yN4f0CS1BdOcdEcWt8dXYkrk6/sZHAOWZifWGs4q7MqcynQPszdS7baYY3/ThEIzPK6g9o19gNNwnrEsNAeSzh0C+lkyA0hu9pIWY9/dyoAJ3EXIdTYap0vlbVVd/xq5FBUtteKFp85MFP9Tl1oiN3XzHqHuAsc/mXj7tJ1zYmw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5142.namprd10.prod.outlook.com (2603:10b6:408:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 18:42:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 18:42:58 +0000
Message-ID: <db121b40-f3da-4ecc-9e07-e3c3c8979b91@oracle.com>
Date: Wed, 23 Jul 2025 14:42:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] NFS DIRECT: handle misaligned READ and WRITE for
 LOCALIO
To: Mike Snitzer <snitzer@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250722024924.49877-1-snitzer@kernel.org>
 <aIEskxZEnEq1qK80@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aIEskxZEnEq1qK80@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd70789-b2ae-4066-4ba2-08ddca18be83
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V0toMzFBREYwM0t1Q0tSNWdPZVZFdGlNeTlHQmZER0tnQTdOMW9vMllGNVZi?=
 =?utf-8?B?TkY3cDE3MkV3WXFaQlZXeVI5ckVwcHZKVnhKZUtIclY3TTRrdVcrRWNmbys3?=
 =?utf-8?B?YlVGM3I4dmtoaWUwTUxlQnArZWlkaUR1NzhGQTJocVZtRzFLMnFHWFNBOGtM?=
 =?utf-8?B?NW4rWHZ5NDlPTmxaUG1hdTdVTWw0R2hUUDhYQ0RITk0wNjI5c25qQmRaK1Jj?=
 =?utf-8?B?eGVPampES3NEMFF1eTJrWklVZTVxTkFnZ0RmRXkzdVJUVVQ2Y3lJelNJbjZ3?=
 =?utf-8?B?Y2FKMk5LT1VMOFNtaEYrTHZMRGVvSVhTbis2OGtxL3V0OU5YVHBWV3psR1dG?=
 =?utf-8?B?SnI0WjZCWmhOeGRpUndjNWVmY3VYS1d0VWNLRXBvZ1puN1QvWFBhL1dEUFN0?=
 =?utf-8?B?aVVCQXdNTXVQeVh4K1RhR2lqV3hHdCsxa3cvMnhDNzBCS1JxTFlicDlhNmFR?=
 =?utf-8?B?RTFOeVl5Y0tGZEJUdUVJaTNLSXZVd0hVM2lPK3NtZXlHWlAveVZJd1J5ZDFR?=
 =?utf-8?B?K3h6NEcxQmxZT1ZRV3pBTnZxRlJScmNCVEIxS2pnOWVpa1hBRkwzTjF1WWR0?=
 =?utf-8?B?UHpRRmQwbGp1cEVEeERxODF6R29PL1ZQOGJpNzI3RU12WUN4YlFxN3oyZE8r?=
 =?utf-8?B?eFJCb0d0L1VuYnF1UHV6K3ZGVGJMeDZPRlRDZ2w3bldyUm1OYnBLeE1ZL3c0?=
 =?utf-8?B?aWNVWW4xeW9wVjZjdUpITjQyOXVPdENJK1Q0VFRQQnZPTzIvdVNhT2xUQnFm?=
 =?utf-8?B?NmNiRHVpb0d4Wnk1b0VLbWJ3NTJxWUFhT01lSUVVNXpPRU4zY3FaNVlpMzJY?=
 =?utf-8?B?QXQzZFhiZm40UGg4WEtBNGRnMnJDd1VYZUFkMDROc2UxaDYwdUFSajJabEJR?=
 =?utf-8?B?eGJtb0Y0UTRlaHdIZy8xY3Z3cGhlR2xUSGlHYmVaUFBiNkU1Tm5GdUYxd1ZU?=
 =?utf-8?B?cEJNS0V6UVJjaWMwYkQyOGcvUHlvODRydklURnpBWGZHTlZvaFNkcmx5dUkx?=
 =?utf-8?B?TGZQTVRhT3QvVzBWcTFNZWphcTdQYjZIaG1RV1MxQm5LR1k2VmkvM1pLazho?=
 =?utf-8?B?UWIwUjRWWGNCNVhRSjBIckNMdzlPYkkyR0c1Wm9qczBDOXVOenBHTDBuZG1Q?=
 =?utf-8?B?U0ZjMGFqbVI4bGsrN1M3ZWdvK1NHSGRiMVovVExWbkQrOGlINnJFL04vMVVP?=
 =?utf-8?B?R0RMRGx1RWdGSll0V01DVWlYdE9qVFVnSjRyM0NHSnEveGNTZFl3OVpHeG1l?=
 =?utf-8?B?OHh3aHk3YmhKb0pzeWdmVi9ESU1UUHVlcjYxMlZQTnoxQkhkVTNkVTUyU2xI?=
 =?utf-8?B?ZXl1SGIwVnpRcU9XMHQvOUNSMWp0c0w4S1BJMkNzK1lKVFFSRnpLTmtZeG9x?=
 =?utf-8?B?TzlmbHNKeU5RZEhRN3laY2RYdDlMUjRaKzZuTnBmQVltM2hxWXV3Mi9kcDhN?=
 =?utf-8?B?bnlyT09PVUw1enpreFRNV1R0RlorU28xN0xYL3puYnlFQ0kydHFOSHhoUEdK?=
 =?utf-8?B?L1MzNUZpbjZWTDY2NERUaTVwdkg4U3VVUkZXY0JITGZNZmNwbmdiVHExZ2cv?=
 =?utf-8?B?TDZjS2hpUWJOdE0yOHhaSzhYdTRuVGVmamEvRGVVTGw4V2doRngwelpvSy9n?=
 =?utf-8?B?TmR0T0NDK1hweWMrczJNMEhWY3VzUDlUa0lJRUw3MjR6azE4UW1FbDduYkpY?=
 =?utf-8?B?RUVhZmk3V2RYdWd4R0RjSkZEYUkwY0lJQUluQTZOWVlzLzV0cXZ5VUxVL2hD?=
 =?utf-8?B?SWpEMkRsalQ1MkhNakVJelNVNzdNU0VUZ0diYzBXMWplYVUzNTFkTlRjeDB3?=
 =?utf-8?B?S2FSaURwaGlPZERiQitMeUNFenE2UU9TdnJ4d1hBb0ZQRHVkQjE5UHVBbWhQ?=
 =?utf-8?B?UE1iUTA5N3ZzT3FnN3dWZU5WUEh4RzhlNVFkYU14VDBod1hqUmNybUR2dFpV?=
 =?utf-8?Q?09JMJL7fIMM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M0dTM1J4alJORmd4Q2paTmJkRGFXUUlFSXJQQm1YZHk0MnZhK3pMM3B1NmxO?=
 =?utf-8?B?azlaQy83dTFkYmQ5YzREMW9iR05UeWpXM1k2YUhxZW9LS0pGc2NUSExEUDQ2?=
 =?utf-8?B?SXU4ellMZGFsNkhhRjc3TUJoZFlBTHRCNzJoRTdlYTVoRmtmSmpYdGNIWERL?=
 =?utf-8?B?cmN1L1RvOGM0TTN4TVVVOVRZYzFwM1dzdEVVWHZ2Q3dmT0czazBpQ0lOTldI?=
 =?utf-8?B?am9uc0ZaVndCWmIxRmMyTjRVdThDNWpGUXFTWEFkYm9qSG11K2xHdUkwZ2pR?=
 =?utf-8?B?bWJlUzJ6VmhTazl1OGVZSGVCSWtxT0ZGTzN5bGpXNHc2MlQ2aVBTbWkzMnFr?=
 =?utf-8?B?c201OFZ4YWYvZHV0NTN5eG50SkxCQ0hJVXlIYmlQUHFGQmNQWkQxd1Q0SE9t?=
 =?utf-8?B?M1Bya2dVRVZiYXBaVnFmRm1jdXVCWFZnRHozdWdyS3B6anBRNzN6c1dIWWNY?=
 =?utf-8?B?d3JVbGRxaWMyWG5NQ2gzUXJXVmM1K2R5SEg0M3hqYVJ0ZXlNaGJHMWcyRW0z?=
 =?utf-8?B?ZEI5NzRlTS9ja2hHakZvNmVFMFNoUDdyZmljUURQZ3dRSUVCNGFhNG5BMnZQ?=
 =?utf-8?B?RjFKd0g2MDh1MkhNTVV6UHFHV2dNY1hYQXBxOElvVlNOc2wvWkZVWWlWM0pT?=
 =?utf-8?B?MDQ0VEhhc2JUOWVVTENLaUttWUZzbGRZSjFCVDBHSDU2VjVoZ2taSnFseXI1?=
 =?utf-8?B?V0ZhNTA4V1QxdE0zVXFnZ3dwOE1LbXVObTRMbWtLSGlqT1VqZUNnM0xERlZz?=
 =?utf-8?B?VklOYmk1VUUrRU9ZTGFXR3RFVjlyVlhlQjBJdEtLbnN1dTc5L0NKRkJ6K0Ft?=
 =?utf-8?B?eXhocXl5Vkl2d2N0WHpET2xLRTg0YzUvWjhCQSsrMHlUSVdrUnF0NC9FN3ox?=
 =?utf-8?B?REEwemhZQVFac1lLQzFnS3dJenFxVE02ckkvdGlpajNOYVNnRnVtdDdObDdX?=
 =?utf-8?B?NC9CeFlrcC9YOUNZS1FpSWRVcjM2RVRMUi9BdHNuM3pmNFBMQ1h1UXV0VEFk?=
 =?utf-8?B?NHEwTFh0ZEI4SDZDNmZtNjRIZlo2WVNPaW9EOGFyR1QvQ2k5ZUQ3c2VTcTY5?=
 =?utf-8?B?bWhML04vQTVNY3hTRktOTlNaei9qT0t5WjVya0l0a3JHYklvWE56WmJDVFgv?=
 =?utf-8?B?NkwxelBZTUd4MUdZblhDTDZyUWRCNFZ5c0o2VkJBS2JiVnpSOXZ4UUNaTGVo?=
 =?utf-8?B?eFVRVWQ1RGhrTksyT09DMSt2ZXB5Vm9iRVlwR3l0N1lJZ1lEWUR3WHdSOW5Z?=
 =?utf-8?B?cjhtTnJXb0dCOWN2dUFNYjA4TytQRmFiZnEra2liNUd0cmdkNVpsQ0dtVlNM?=
 =?utf-8?B?ZW9qQjlwU1kvQkoreHpoY3cwSnU3TlRoeUo1a0Q5YVVzQ3IzUEl6SExTZyt1?=
 =?utf-8?B?WTg0NTFXczQrM0xhM05XL2J3TEpDTmxaMTJPVDcxbW14N1h4WG9HcklOTUVl?=
 =?utf-8?B?NjBZWGp5SXB1eUdJdStHKytBVUF6MWxZTklwaGpyQ0tJRjJMVVBLUVI2NGlE?=
 =?utf-8?B?aEhFcmxiNW1PTDl0R2RBOEl5SXNxNEtjZC9ZYnZCNExMMDhUa0lTTUphL0Rl?=
 =?utf-8?B?aGtnZzR2c1dIRTFwRzJ4NGN2N3M0dFZ1Q0JYZGIzMGFTT2RoK2RpUUdqU1Ar?=
 =?utf-8?B?NmRaK05lYUszN0lXeis0OHV3RmZZWFEwNXpiK0FPS3dlWXplU045SmtINEhW?=
 =?utf-8?B?LzE0aUJqY0oxTzNuNHZpVTNvWllRdHBjVDEzLzM1Ulh0VE5rd1NVNkhSSytj?=
 =?utf-8?B?cDlvNmFHakExazRzSnNtKzVvY0N5MDVoMnQvYlAwb21uOEFPcVYxL0VLamY2?=
 =?utf-8?B?RkNXU25VN1RYd1ZoR1FBd2llUzZyUXZORUl0V1NYamdxdHdOeTJsNExWZ1pC?=
 =?utf-8?B?QytTOFV1ejNOM1JUZ1M3aUt2b3V6OHVxOWlsWmE1UDhYNGU3R0ZHeUhNeFJi?=
 =?utf-8?B?QTBCSDlzU3pva3F4YVMyYllEd2RaMGd4T3gvNWtNZCsxaUpUZ3YwRkQ3WXR3?=
 =?utf-8?B?cXNVMExUVnBjdmZySjcyWnJRV0piYk85TmhvTEkwam9zcWdoUVZka2twY3VG?=
 =?utf-8?B?N2o3NjFtanM1d0tKTkRQRkZHVCtIcVBLN2dhbThUbko0VzYrQ20wZkg1c05D?=
 =?utf-8?B?d01RdnFlaXBWY3U1OGRTZkdENlpKZnVJeDd3NnE0d2lxdksrNmJ5SVkvMHJJ?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QZTfQic+sEf0f9tSNnTVV7o+Yw5njP1pdFfPIfpasvPhQJIqX4ssHXY/bDfEedb5v/HhLN0ejuVzk2V5VD3Pr6XvKduSakCUkZMlQwA5qdTqVs0tB+fyRs4/0jyV4bBIg0A+cwbI2QzavQfgsj8/SbJ87WtDmdcoGnRu5VLL6duNcJQS7yZSrHP4cMsDZcOeLNXcBl2QAO3DyVCz9xEYLNRC/g6yH0ZkYFdNlcCfy5dhxJI1WEGvVBgdkSKRNXbR6lcjd7e6wJUejzwbT+TfGnnVoV75adGd64/DFiCDVC6RiLVJ8Rnya4SMzLDA2EWvsCST7aDSJQUJMxjQCpVrSvYW4KklXa8E3iqA5+gtLy0JiRRe2e6Vm6ui+PJPqpXLgIpdkCa1dqi01l6HM5LsBpb3UNTo3DB+5IQiHhSRLrx44H1A4uqYmQGggG4HfPcY6LNkYnKL8UE33sHeKnjH9T70anfeScznXCNm8nZBGotDHHiMWr7egjOwNptGj3LB9/w/ehMhV5jwQruJpQWV2ZpBwMz04KNcr7dqRsKGQJ9zcAoeLauUdTCwfZoSAiHmy5wt0a6gQMc0bzUMyHHZ/DaR1Uty3FnLsmBwpy4a1Wk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd70789-b2ae-4066-4ba2-08ddca18be83
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:42:58.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/vUfjiZQrYtM2SrbvCz4gylow4/Tl/iY6pHEL4AKUPgNjaFqVlI0NgkHT6rVjuZs6RCUFRJtZegCAorMJGa6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=986
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230159
X-Proofpoint-ORIG-GUID: asPjLRdex5-rVkhuT1PKCm1_f_VV2Xlj
X-Proofpoint-GUID: asPjLRdex5-rVkhuT1PKCm1_f_VV2Xlj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MCBTYWx0ZWRfX6rdObr5uFhBX
 kmAeKZtTwvKhDKqWmjHB7EmZ9fTu5lSbtTrwXgaltfuC4I0IiyFzegPzFqaMinHTCYs4oINEToY
 BtnsKONpaqhYK8dWGqbZisSGQQMJ+lKwsqxybn9mMDQnn9OWs59pVR3HHCnhOmkvoniwDUsdV97
 V1P0BAjAjLUssb7SXfVkc81piHXPgmiCgB00DV6Gm4ksz2pc5rcSvFbJYqsb05Qe7Q692jSWJUH
 LHwPu5R4xvtkvmODvg+wGLlCbVZtaoSYOh9Xqs5M79cZV7DgH4Xi8TaKzYtG7yjRD3ZhPPzR+E6
 3wWRrE0oNTzku+2coWF29MZVbF+GEoXMuUgxGpDIFUUJh7cXQepXl+jk+vBD29J6S8rVg3oo2gG
 +1nE/oJzMI4B4y2X9n4xlsC6QMPg42RpYamNg7wxGS8K/c4jSH84EQiFBZ/je7PYQShdar/4
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=68812d36 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=b03WI77dsz_ZCbwO_KMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12062

On 7/23/25 2:40 PM, Mike Snitzer wrote:
> On Mon, Jul 21, 2025 at 10:49:17PM -0400, Mike Snitzer wrote:
>> Hi,
>>
>> This "NFS DIRECT" series depends on the "NFSD DIRECT" series here:
>> https://lore.kernel.org/linux-nfs/20250714224216.14329-1-snitzer@kernel.org/
>> (for the benefit of nfsd_file_dio_alignment patch in this series)
>>
>> The first patch was posted as part of a LOCALIO revert series I posted
>> a week or so ago, thankfully that series isn't needed thanks to Trond
>> and Neil's efforts.  BUT the first patch is needed, has Reviewed-by
>> from Jeff and Neil and is marked for stable@.
>>
>> The biggest change in v2 is the introduction of O_DIRECT misaligned
>> READ and WRITE handling for the benefit of LOCALIO. Please see patches
>> 6 and 7 for more details.
> 
> Turns out that these NFS client (fs/nfs/direct.c) changes that focused
> on benefiting LOCALIO actually also benefit NFSD if/when it is
> configured to use O_DIRECT [0].
> 
> Such that the NFS client's O_DIRECT code will split any misaligned
> WRITE IO and NFSD will then happily issue the DIO-aligned "middle" of
> a given misaligned WRITE IO down to the underlying filesystem.
> 
> Same goes for READ, NFS client will expand the front of any misaligned
> READ such that the bulk of the IO becomes DIO-aligned (only the final
> partial tail page is misaligned).
> 
> So with the NFS client changes in this series we actually don't _need_
> NFSD to have the same type of misaligned IO analysis and handling to
> expand READs or split WRITEs to be DIO-aligned.  Which reduces work
> that NFSD needs to do by leaning on the NFS client having the
> capability.

I'm not quite following. Does that apply to non-Linux NFS clients too?


> Which means that we _could_ drop the more complicated NFSD misaligned
> READ change (last patch [1]) from the v4 NFSD DIRECT patchset I just
> posted [2].  And just do the basic NFSD enablement for DIRECT and
> DONTCACHE (so we'd still need the v4 NFSD patchest's patches 1-4).
> 
> Thanks,
> Mike
> 
> [0]: https://lore.kernel.org/linux-nfs/20250723154351.59042-1-snitzer@kernel.org/
> [1]: https://lore.kernel.org/linux-nfs/20250723154351.59042-6-snitzer@kernel.org/
> [2]: https://lore.kernel.org/linux-nfs/20250723154351.59042-1-snitzer@kernel.org/
> 
>>
>> Changes since v1:
>> - renamed nfs modparam from localio_O_DIRECT_align_misaligned_READ to
>>   localio_O_DIRECT_align_misaligned_IO (is used for misaligned READ
>>   and WRITE support in fs/nfs/direct.c)
>> - added misaligned O_DIRECT handling for both READ and WRITE to
>>   fs/nfs/direct.c which in practice obviates LOCALIO's need to
>>   fallback to sending misaligned READs to NFSD.
>> - But the 5th patch that adds LOCALIO support to fallback to NFSD is a
>>   useful backup mechanism (that will hopefully never be needed unless
>>   some fs/nfs/direct.c bug gets introduced in the future). Patch 5
>>   also provides refactoring that is useful.
>>
>> Thanks,
>> Mike
>>
>> Mike Snitzer (7):
>>   nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
>>   nfs/localio: make trace_nfs_local_open_fh more useful
>>   nfs/localio: add nfsd_file_dio_alignment
>>   nfs/localio: refactor iocb initialization
>>   nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
>>   nfs/direct: add misaligned READ handling
>>   nfs/direct: add misaligned WRITE handling
>>
>>  fs/nfs/direct.c                        | 262 +++++++++++++++++++++++--
>>  fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
>>  fs/nfs/internal.h                      |  17 +-
>>  fs/nfs/localio.c                       | 231 ++++++++++++++--------
>>  fs/nfs/nfstrace.h                      |  47 ++++-
>>  fs/nfs/pagelist.c                      |  22 ++-
>>  fs/nfsd/localio.c                      |  11 ++
>>  include/linux/nfs_page.h               |   1 +
>>  include/linux/nfslocalio.h             |   2 +
>>  9 files changed, 485 insertions(+), 109 deletions(-)
>>
>> -- 
>> 2.44.0
>>
>>


-- 
Chuck Lever

