Return-Path: <linux-nfs+bounces-13664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA3B280BE
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A41C1C27BEF
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3A3019D8;
	Fri, 15 Aug 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FBfsENR4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OajOFYlk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2218301015;
	Fri, 15 Aug 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265256; cv=fail; b=Q2uKb67M+7Gdh7sBoC2TyDyuadaCNJeFT8AHuJBMPgCCnT0PRM0CF8eC/1cEO+sUf4O0f/njgiIxOLyEM73+1QWbGMDRVUNE0R65OUDy+fCusxYF+FCbo3lP5T4Pv6QMYG7uHQubncmqu1MTamLAbUCLi3kf9ztbZupcqZg1ZoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265256; c=relaxed/simple;
	bh=2oi/j3+d8rfGdMyaU8jKy7wXCRDlOafosCp6StDVBQA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DKTB9zxHMhCZTBFwYPTNVNPX29Dsepl3tRbKwjagXNA+sQ7bDYehAMWjtuxiVtBoYmXjMoVH1eeqP2uSXQ2zfllwnVXvHPYBjxC9j6QGAoTvm93waSBr2I17k1kCqA7UUEO1Mpbn8LSj39JfPtSUX8w0RoJesb8Swdi6YMh9Mog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FBfsENR4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OajOFYlk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDN629015852;
	Fri, 15 Aug 2025 13:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UPMHAJ3sDO9OoybsMDX3CdgEnXU4wgML9VH8ubpOYa0=; b=
	FBfsENR4N4p6Zvw5REwkx0uXXC8CQ12EfLE7Tsgo6dTzul4hS8qeQsgfXU9KvFle
	jlMLW2YCRUupUmhmIxUKnuPLvXqSjHPvimICCGQsg1yTFLvm0z/5CnunQa168LQR
	4//LQAP5Ra4d0dEEhjmQPLd8LStYJPybh5RMoiNLJSoQ3qVH9bfLbg+Cb32qzQmx
	jXY4SpFNsiH01CL3nVNi5fKdptl9t/atcWJFcPaWRPLj7orc5F6JW7R1gPNcUDhM
	BmVf+tFSBNITe/uWj1tynfZTJor47d5pJ95LRyupk7qT+CNEU/LmNQtEE7xnGcdl
	akKrlSVc6cHbV5x2lFPHug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dusht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 13:40:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FBs4w0038569;
	Fri, 15 Aug 2025 13:40:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsmj2r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 13:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZUm7bOEK944DOACPqrzmmd99r1mgS8Pnn5awnmItZa4wo1GXe626eZTuVM08+v/7qoHX50CdLHtkuWiWMyNFixCZE/1yG+rqOXpGrJp25mGBmrEAnqt5BYAf+oB9Apzv0AjohIvCZBOHFu/hqX1hj/F4qSbYfe1yBUR9Y87qMF4FcKO7TSU+c2Ee+jT+5CKQts3kDIR7VNmWChdNZrmGBPAtnLNx6gQpI1G5/orSXYnK9gqGeoivdPry44sxZLvQElMdUEsRgoO+YjoQkUTM8UFwANd74eA9Ur78GipX9igZb/twmgH9rc0nJTAL+5f8353cUR/G8VPbvvp7QssIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPMHAJ3sDO9OoybsMDX3CdgEnXU4wgML9VH8ubpOYa0=;
 b=wP6gk7flld18QlpkyK0Pti9cFoJx4tlZBogyjmlSKEXGscDS0ObYv+W9dLkqhkllVaB05tQp/+Pas1LnArcC2aJzJIvxw3OI9UXl6ltwCF55YUTr57g6P0Lu4GK/dr5b8erHu7xRdEeE7d5bizgf0wSCe/wXKv0InhIQalWlRU7jOE+GGUfqo9RcmnalfKmfp+2BxcAILFN2DqJVST8V+AwqBQpIRR4GkqRSJaFK2X3ki+QafKaxDesZziV26ZHsuposxRtfLmADN11oP6P1uE5hBmQ8FEVuNOpKf+baN9eilhzP8g7Vk9iHFktWrwuYOyKdtskeulGXUTsXUAJq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPMHAJ3sDO9OoybsMDX3CdgEnXU4wgML9VH8ubpOYa0=;
 b=OajOFYlk3LghmcCqj6og7KqUkZligbXs+99b2ronQFlf3vtMqlILpiTl4wXOVISgjI1xtBuT9h+Ra+qrAWn14k5Ar9fIakWeNqrojFZba2KrelVijDo7yAAj8eMiivRxpoRZW4QJCKpTEDIqG3p6wZdl55CHnNoLwVI0ybHFL6c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 13:40:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 13:40:27 +0000
Message-ID: <7df4e02b-18d0-41b7-9561-e6b76c13c995@oracle.com>
Date: Fri, 15 Aug 2025 09:40:25 -0400
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/8] net/handshake: Store the key serial number on
 completion
To: alistair23@gmail.com, hare@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
 <20250815050210.1518439-2-alistair.francis@wdc.com>
Content-Language: en-US
In-Reply-To: <20250815050210.1518439-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:610:118::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aaae3ee-322a-4486-5b0d-08dddc014b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzdlcGpDNC9IRW94THNEd21kWGJPd2Y1Y3d0TXEvdzJuNytsU055V0pRVndh?=
 =?utf-8?B?U3VVNlYzdmpVNVdZY2VyWVhMS3d6eUNlUG53WkZlbmQ3QjFhTlpmWTBFcVo0?=
 =?utf-8?B?aVIvSkV4blBMUVlJcm9pd2hFK1NmSlNXZXZOM0VCaVNyZDFhN2FROVMxb0J4?=
 =?utf-8?B?U2xYa2JoenBNc012TGVGcHZsSnd4bEQzM3dVZFA0WnZDOC9RdWlBTWZiR0la?=
 =?utf-8?B?dU5kSmtUejlpNHR0V0xROVF6dVFvTDZ4bE40Nm1yNm05Mlo3VnJQdnRPaitt?=
 =?utf-8?B?ZTEwdGNSaFRVb21JRE4yTVBpUGFOMFM4V0ZqY0F4eFplTE1oYkJKU3Z0Yndw?=
 =?utf-8?B?eFErNjExekN1Ui9jSms2S3F1L3NZTExpM2RJTG0wVTcyQnFhYkQzK25SOXJT?=
 =?utf-8?B?ck5Ed0U4MW1Yb0o2K0JtSGRuRTdyTlI4K2YzeEN3T29sUHVjQnhicTVVVUdS?=
 =?utf-8?B?MmxkV3Y2ZHJaeDBacW1mYTQ1WFhvTUliV3JGODRGYk5mNWk0eGVLV0xZdzhz?=
 =?utf-8?B?ZitVVjFiSDdOME92U1F3RTJUTVRGUmNoVFZXK0hkKzVLY3J2VGo1RXhwdjFT?=
 =?utf-8?B?WjhSMW93c1RyR3FyVldNVWZOdFpJK1pnUFRaVnZtZWw1SjlvNlBUcFJMZVdH?=
 =?utf-8?B?czNBUWhHV3VKZDkreU9EZjVhV3g3bXdqWHo1ZEZNcHBWK2xGQzYraFV0bldk?=
 =?utf-8?B?QjNlQm1TMm8vUW9HQytyUk5OMnpqUGFwZlBJYW1TSi9YMmdtOG9vTE1HSnI1?=
 =?utf-8?B?V01wdktZQ01LTk9yN0l2aWhSTEl2OCs3aDd0Mk1na3R1M2txbG1yY0ZDTFQ0?=
 =?utf-8?B?KzlIbm1nOW5YWEsrMmI4MDRyOXQ0NXRSNW01VnN3TGRHNG0wcWRWMTcwQ1V6?=
 =?utf-8?B?cHJCanpQUEJQYmhZTDFmdk9UcE53ZEpVN0gvV1Z3Uy80SFZRSkdjR05vdndK?=
 =?utf-8?B?dWw2NTdYb2xPTkhseElEc1JBaXBmQVU3VDhZaVlBcERyMS9XZmNBWjhDTTh0?=
 =?utf-8?B?RHNyQnFOWGZ2RnlWZGFHbFYvbU9PYnRzM1QvTTZSZ3JjTVF0dUpUY3pMMFpF?=
 =?utf-8?B?cGhtL3pnVVpwY21MOGFleURXT3JSaU1jTjlaTDF0bkU5NXhvVzYvRlpwcVBy?=
 =?utf-8?B?bnNXZnNmRkVkR0l5Rm9WVW1NNW9hSi9CNWNJUThWdHVFNGtKVlJXYm02cnpr?=
 =?utf-8?B?ZXJBalN6OG5KVE93VUhtTFlhQVYvTHc2RmgxWkpMakhUWGpTOXYxM3hLbVlz?=
 =?utf-8?B?ZU85dGtqUlZFa0ZPaUtNVGxsRGYvL0dzOUFDRDE1SDdyU29ZM1hyOWw3VHFv?=
 =?utf-8?B?VHRCS0tTS2c1WldZdCtFOXJCdGNpSEJlLy9kNHIvNENWY2E4a1M5V0RlLzZ4?=
 =?utf-8?B?T2hjUEpVMVlnQnpSUGVUV1dQNHg2TEUydEJxM2drQXBhVzVDWTNXTDlyaXJi?=
 =?utf-8?B?UTJUZkx5c2VzOUR3Wk5lL1BRdG5JMUhVMWR1Uy9LVXJCZHkwSnZneHpFOFZC?=
 =?utf-8?B?VFBrYUZKdmx5ekRJbWs1Z3JYQU90V3FsenhiMzZWYVNzR1AwS01nRUx3eFVo?=
 =?utf-8?B?MTJyKzZ0aXpFd0EyZjVCNVZ4c3h5Y3lDZFU0YXVWdzZrdlpFMU16L1RNSzNi?=
 =?utf-8?B?V1IxM2pkc1JLS2NxNlNGMDRNanJtNWRFZ2RibmtVNUFuQ1hzM2RVRGtza3F3?=
 =?utf-8?B?VzRybURiSmRlUC91Q3pwVGlUZXkyeXBreU94cGlyTVJyQzBLSWFSeERnMDNn?=
 =?utf-8?B?bHV6RzhPcWFMUTFZMGt1enFscjE3cTNQaG5nNUtXVkZCTTZ0TnFrWUo3Z0VF?=
 =?utf-8?B?U2pkVHExbGhwL3lzZmpZOEt5Tmc1ZXlFK0FtSVZ6R3Nvb2h1ay8xVHJ4Y3ZE?=
 =?utf-8?B?SG1FTjdwUW5xa3FiWHdvaDlReE5oSzcraEhCc2ZaaHZ6SytONnVXZEtDRlJX?=
 =?utf-8?Q?hFI9UOyqsRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHptRWNIcDVhVDFFcE1UTmN1Z21zYmxrOG96bFRqK1VKZ3NHblRjZ0pqTk9K?=
 =?utf-8?B?ZWpLZDdPamtBZVVxY2RXcGsxVkZmaFltZXFzUXBoanlTQUV0MFFySTVROWxq?=
 =?utf-8?B?YU5WWDA5ZXJlNkJ4bDJXUWFqdTYrWHpuZ1lIZ0NMeWluY2pLc0IvSlNiN3BM?=
 =?utf-8?B?Z0VnK3l2RDgwd0tQdENhUU92RE5LcGg4dXN5UEJqeFFhOFhJVHphTDMwc0Zu?=
 =?utf-8?B?TklmeGlSWUFxYmYyUHFFd3R4Zm1XaXNBVndtNkhWbFc3QXc5cXBhVncwQWw1?=
 =?utf-8?B?VGlvMURvalZHY2NsUDJ2WStTa1BRL1dSSWJoWjgwRG1rVENxdVBMSzMzMXdN?=
 =?utf-8?B?Zy85cjM1RVQrY3Y2STdDOWxRbVpZb0QxMzd3c2IxSUlZZ201b2xabHYyL1h1?=
 =?utf-8?B?TnhiOGpDS2xLdTJXOTlVSE9FVVNYaVdlcVR0dGc1OWxRMzQ5ZEpUemhNaUR0?=
 =?utf-8?B?ZHlmNEVyODdsMFJYSWJqL1VJWHpvU0JtZERTejY4a0FqYVlaTjBzQmFaYXd6?=
 =?utf-8?B?YWxxeEpoa2JreFdoSVhZcEZKcnJxMXQrNmJJUllnaE92V094VlFuVzhFY1NY?=
 =?utf-8?B?ZWJycEc0aEh2NU13R3pMMGJHVlJmQTF5U2d4UlduZWdwWTgwRUJmR2U2NXFL?=
 =?utf-8?B?MC9FVEFuN1lPZDV3Y2EyaWVVMytleWkyR01IbUJibm94NHhHbVE1dUNMNXgy?=
 =?utf-8?B?YURaeFpyRysxbG5maGFWL2RERGkranZOM1lieElaZGREZlRnekxtODY0YjF6?=
 =?utf-8?B?VnpNVjkvTVBDODZwMlk4Vlp1RzdFYTBQQWRMZGh2YzlrS2E1a2x5Zmp2eGlt?=
 =?utf-8?B?NVZveFBHaU1GOXIxaUplbmZRdi9nQjdrYnBmOW9tZ1Q0eC9pc3B0L2JEcTJp?=
 =?utf-8?B?bVBsSTkybnRoejhycEFoU1hlbVNEOCtJSFEwb0w1bzhBUEJvVFVlR0tVL1cx?=
 =?utf-8?B?ZUMrd3ppT0RhU2o0cFNBNnk1TisyUFY1ZklEcG1tQmNXeExlL0l2WFVUL1pU?=
 =?utf-8?B?c0ZWUHF2SG1idE5jKzRKdWdHQXRwaWhNd2U1V1ROWmRKVFlteWlXeXc1dHE0?=
 =?utf-8?B?S3g1TGlsQmlNaVJEbjRHNkRrcUw1clpCS0tucDZmVTZ2TUhLUUV1REZvWDZV?=
 =?utf-8?B?b1pzK0tjK1dUK1VYRnRMY1VjWS9wc2FDelNTZkdUczhFYjllK0VleWFGcFB2?=
 =?utf-8?B?RUJYOXIzcWVrRXBFem9OakhnQTBxVVlwRUx2cHZiMlNHTXp4MGx2NElVZXU3?=
 =?utf-8?B?Ly93UUo1NXNHMjY3ckpMUTFhZTVCWG0wejdKck43amdkMVpsOVRKa1pDVGRU?=
 =?utf-8?B?aXBvVUlVQll1RXVZTnlJbGg4MDlxMUtMNTRXY3kzcDZJTk9hMGhlUUZ0WXpZ?=
 =?utf-8?B?WnZHSWZEV2R4QUlaQkNaQ20xb1NDYVNxcGcreFBhUENnTjVuQWF4ZUNuRmlV?=
 =?utf-8?B?dExlcU0rVEtGOXZXcFVPb3JpVjE0dnFEOVQ5YW9xQWFQVDgzcEJlMGZjTjh5?=
 =?utf-8?B?WjRncVBWS2ZQZE4yRWdBTlQ4T3g0WGNWdVRGYjJSeGVJYXRYNDcyOXFVelJ1?=
 =?utf-8?B?ZVJoM09kMXU1MHc1R1hNNzVuZ1lLTWRvREJLSFl5UHZaY3ZwZWF2Nnl0UmJC?=
 =?utf-8?B?UmJjaEZVOFJib2phTE8xTDZPbGYvVTUxM0wxNW5MS3IvRS9zclVTMXRnaVNk?=
 =?utf-8?B?OGl4VWQxK0g1MExLWU52b2dVeVN2SmxyaU1NTjlZZUk5d29rLzlkRGljMmRw?=
 =?utf-8?B?OGpRTG9ocDhrT0tLN291VU9RTGxrUlZoQXJmM2N5M2xHU3hBQUFZMTRkY2JB?=
 =?utf-8?B?T20xSkdLa2wreTlkcTlkZG52YVg1enVJeGQraWtadmMxWDhudlM0QjRsMjhM?=
 =?utf-8?B?em85U2tRUHpKdnByN2t4U3FpS3BWdFVTVWpqZzh4b0FzVjlpMTRzZmp5anBY?=
 =?utf-8?B?OW8wMWVGakhNb0UyenVzRnBqYVl2NmMzbGMzakJSaURpVzhBa0U1ZjlNaGFP?=
 =?utf-8?B?Q05JVTdXL1NETFIrdDdEdmlDa2dLdCtuTks0UDQ3RXE4S2x2TmhLaWJSeVUy?=
 =?utf-8?B?SVMvbHZ6eTJ1dmtWdElraHNpMFVvejlqYmNUbldOZGIyZ0kvRlRlTm40c1dy?=
 =?utf-8?B?RDQ1ZVN6dDU0VGpYeTFZeHkrNHQ1djdNcVZGZ2RKbm8zUmFKMk0rcTdYVUJ6?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cITsqnixwpQNd8VN9XRC7AXRage18Gzhv4JOIu63vuhjQoTfi6X0kZuqjJfk/++TjDHIfiNOxGjD+H02l7B8hJRzaiiiqD/vhlAFQ+JgpFdjs59BrvNjGmyKleP8mBhSWdy5TqzHzdMS8MjXeODKDOMBHj+nbZhHWrznUXhz4JypGSKOtSMjp74GmxNWmHSFy97KTkozqPenZBDw+tUAR4ej5Fou5qQgqjh3ZFSBU5V+xyTZ0UoGOdni2r4+7SnwsjwPw89dh10/HXsI63JjDrGqwY53lFNvnMxW5mSaUM7Ve36ZkykEUYCjzNTcpZAkcBSGZRZ/muk/wVRYh2XixnaMOWcv4985dDYJz2JMnHHS0wmJ0Bk7lU/sh7k/L85D2+qsgHlvKPeqEaHZa9nZeHvLofD2qvAUvEyjWjmaA3NJerPoke8HhdRVQaj6YqQeBqpxJTWgSwz37zHtsHdQPAAtfFPdhxPomSrcslMROIPGoT/2z0BJxvccsboYWPilJbhjGPRdtbV7qK+xF6/+hDTsWQmwwikcmB3wiQjE/TiKQWLqpM89VuKvB86ZBUTvTiIlQHl1QxYW0Vewzop4qbBVe8z2PobBQxda9SbJNIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaae3ee-322a-4486-5b0d-08dddc014b2f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 13:40:27.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9Y0+LWIgGgtiztx58t1oMUHIIXny9gqq8o+08cAjEXorwfhiPwyUSIAp27yJRwrijlPnKH1bdCHIx7mGxMkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508150112
X-Proofpoint-ORIG-GUID: UEG8UNF_vmHQjSBHV9DZw1lkUZbBtLkV
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689f38d1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8
 a=Y3f5RSv2U2QpQ9XQWvwA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: UEG8UNF_vmHQjSBHV9DZw1lkUZbBtLkV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDExMiBTYWx0ZWRfX16hbRggZGPSE
 TMrtz5AQvVsSw4+rFIKN2KGLFs0kAQyS2tVwRZdMj0gA1P230z34Rd4iB4AXNg9OK7ul4ozYNNB
 NfDnxT1eoPGpuMUJTA8EaJJANP/2LzDu2U4G13yVrRV9sVfzYkvUZEB911bK7E7FuChflAfdM5j
 wyFAhTdaoh/vsYlkWTrs3/BNnTJUVf2sBJKzt3/X3Q0mEzleF2NDaDHQ7tFzFKLTO19aWIkz+uW
 +f8IVEC9K6krgjXnj6QmLT9zxAUWo3Cokdlm7QEOMI7KWgnLgosJ6gQShWxqCfL3FoYDSwfvpGv
 WjiZZnZ5RJ/doTLFR7kVlVfAVi+EJnueBEgHiwYheS1xtjZSLba7+rhJ6yvLGDsCeY/uNNBBiaH
 BbUQK2OQNBnFqtau1z0GUXZgn7F1TD6AnwViOMgLBBjLcqSIC/ENm2gJGDzPcuLQMQrVsMaq

On 8/15/25 1:02 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to include a key serial number when completing a
> handshake with the HANDSHAKE_CMD_DONE command.
> 
> We then store this serial number and will provide it back to userspace
> in the future. This allows userspace to save data to the keyring and
> then restore that data later.
> 
> This will be used to support the TLS KeyUpdate operation, as now
> userspace can resume information about a established session.

Hi Alistair, thanks for continuing to pursue this functionality.

I'll need some time to go over this series more carefully, but a few
mechanical issues stand out immediately. See below.


> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  Documentation/netlink/specs/handshake.yaml |  4 ++++
>  drivers/nvme/host/tcp.c                    |  3 ++-
>  drivers/nvme/target/tcp.c                  |  3 ++-
>  include/net/handshake.h                    |  3 ++-
>  include/uapi/linux/handshake.h             |  1 +
>  net/handshake/genl.c                       |  5 +++--
>  net/handshake/tlshd.c                      | 15 +++++++++++++--
>  net/sunrpc/svcsock.c                       |  3 ++-
>  net/sunrpc/xprtsock.c                      |  3 ++-
>  9 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index 95c3fade7a8d..e76b10ef62f2 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -87,6 +87,9 @@ attribute-sets:
>          name: remote-auth
>          type: u32
>          multi-attr: true
> +      -
> +        name: key-serial
> +        type: u32

Let's choose a less generic name for this type. All of the peer IDs are
"key serial numbers", I think? What do you think of "session-id" or
"session-ctx" ?


>  operations:
>    list:
> @@ -123,6 +126,7 @@ operations:
>              - status
>              - sockfd
>              - remote-auth
> +            - key-serial
>  
>  mcast-groups:
>    list:
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index c0fe8cfb7229..bb7317a3f1a9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1673,7 +1673,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>  		qid, queue->io_cpu);
>  }
>  
> -static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
> +static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
> +	key_serial_t user_key_serial)

I have a patch series that adds a parameter to ->done as well. I think
it's time to consider defining a struct that carries all of this info
instead of adding more new parameters to ->done. That can be done as a
separate patch, perhaps.


>  {
>  	struct nvme_tcp_queue *queue = data;
>  	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 470bf37e5a63..93fce316267d 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1780,7 +1780,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
>  }
>  
>  static void nvmet_tcp_tls_handshake_done(void *data, int status,
> -					 key_serial_t peerid)
> +					 key_serial_t peerid,
> +					 key_serial_t user_key_serial)
>  {
>  	struct nvmet_tcp_queue *queue = data;
>  
> diff --git a/include/net/handshake.h b/include/net/handshake.h
> index 8ebd4f9ed26e..449bed8c2557 100644
> --- a/include/net/handshake.h
> +++ b/include/net/handshake.h
> @@ -18,7 +18,8 @@ enum {
>  };
>  
>  typedef void	(*tls_done_func_t)(void *data, int status,
> -				   key_serial_t peerid);
> +				   key_serial_t peerid,
> +				   key_serial_t user_key_serial);
>  
>  struct tls_handshake_args {
>  	struct socket		*ta_sock;
> diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
> index 662e7de46c54..46753116ba43 100644
> --- a/include/uapi/linux/handshake.h
> +++ b/include/uapi/linux/handshake.h
> @@ -55,6 +55,7 @@ enum {
>  	HANDSHAKE_A_DONE_STATUS = 1,
>  	HANDSHAKE_A_DONE_SOCKFD,
>  	HANDSHAKE_A_DONE_REMOTE_AUTH,
> +	HANDSHAKE_A_DONE_KEY_SERIAL,

As above, KEY_SERIAL is too generic IMO.

I suppose Hannes' "A_KEYRING" is a similar vague, generic sounding
argument name... Though I'm not sure it has as specific a function as
key-serial will have.


>  	__HANDSHAKE_A_DONE_MAX,
>  	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
> diff --git a/net/handshake/genl.c b/net/handshake/genl.c
> index f55d14d7b726..bf64323bb5e1 100644
> --- a/net/handshake/genl.c
> +++ b/net/handshake/genl.c
> @@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
>  };
>  
>  /* HANDSHAKE_CMD_DONE - do */
> -static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
> +static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_KEY_SERIAL + 1] = {
>  	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
>  	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
>  	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
> +	[HANDSHAKE_A_DONE_KEY_SERIAL] = { .type = NLA_U32, },
>  };
>  
>  /* Ops table for handshake */
> @@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
>  		.cmd		= HANDSHAKE_CMD_DONE,
>  		.doit		= handshake_nl_done_doit,
>  		.policy		= handshake_done_nl_policy,
> -		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
> +		.maxattr	= HANDSHAKE_A_DONE_KEY_SERIAL,
>  		.flags		= GENL_CMD_CAP_DO,
>  	},
>  };
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index 081093dfd553..cb1ee8ebf2ea 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -26,7 +26,8 @@
>  
>  struct tls_handshake_req {
>  	void			(*th_consumer_done)(void *data, int status,
> -						    key_serial_t peerid);
> +						    key_serial_t peerid,
> +						    key_serial_t user_key_serial);
>  	void			*th_consumer_data;
>  
>  	int			th_type;
> @@ -39,6 +40,8 @@ struct tls_handshake_req {
>  
>  	unsigned int		th_num_peerids;
>  	key_serial_t		th_peerid[5];
> +
> +	key_serial_t		user_key_serial;
>  };
>  
>  static struct tls_handshake_req *
> @@ -55,6 +58,7 @@ tls_handshake_req_init(struct handshake_req *req,
>  	treq->th_num_peerids = 0;
>  	treq->th_certificate = TLS_NO_CERT;
>  	treq->th_privkey = TLS_NO_PRIVKEY;
> +	treq->user_key_serial = TLS_NO_PRIVKEY;
>  	return treq;
>  }
>  
> @@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
>  		if (i >= treq->th_num_peerids)
>  			break;
>  	}
> +
> +	nla_for_each_attr(nla, head, len, rem) {
> +		if (nla_type(nla) == HANDSHAKE_A_DONE_KEY_SERIAL) {
> +			treq->user_key_serial = nla_get_u32(nla);
> +			break;
> +		}
> +	}
>  }
>  
>  /**
> @@ -105,7 +116,7 @@ static void tls_handshake_done(struct handshake_req *req,
>  		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
>  
>  	treq->th_consumer_done(treq->th_consumer_data, -status,
> -			       treq->th_peerid[0]);
> +			       treq->th_peerid[0], treq->user_key_serial);
>  }
>  
>  #if IS_ENABLED(CONFIG_KEYS)
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 46c156b121db..3a325d7f2049 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -423,7 +423,8 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
>   * is present" flag on the xprt and let an upper layer enforce local
>   * security policy.
>   */
> -static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
> +static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
> +				   key_serial_t user_key_serial)
>  {
>  	struct svc_xprt *xprt = data;
>  	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index c5f7bbf5775f..8edd095b3a40 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2591,7 +2591,8 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
>   * @peerid: serial number of key containing the remote's identity
>   *
>   */
> -static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
> +static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
> +				  key_serial_t user_key_serial)
>  {
>  	struct rpc_xprt *lower_xprt = data;
>  	struct sock_xprt *lower_transport =


-- 
Chuck Lever

