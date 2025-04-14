Return-Path: <linux-nfs+bounces-11133-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F2A88D8D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 23:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AB01898085
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32F1BD9C8;
	Mon, 14 Apr 2025 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3KQPPE+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AvKqBxAZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5F19D06A
	for <linux-nfs@vger.kernel.org>; Mon, 14 Apr 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664845; cv=fail; b=k5yblsMEx71EZTVINoo4Vt727kHmEJEP0u7RHMCSIT7rz5q7pvhF/WmZnmNySZZvuIH/Au3+y5VZQ7JAmA4M/ubm5sF2ezbBVDk++NTWdb1fWLqtQxQYzikfHMfnIbTCVwmsyKBCtzHwNP3eFoSxhUISYMmX/bzLh6CZsnUf2C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664845; c=relaxed/simple;
	bh=Ob9wW6s3QUPWf7Je1+cuBeTwg5/Tl8RNgqOMRImIa6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HDq9R7BG37+5GTVLVlD/znbVvTgHFIvEpxjLtrwpyOANC1iVZZDy0kJmD4USIRFfWKYRbAVM23yNGX74O04u5lJDSjteGl0SyNbIRnOUQEgTZFjC5SnhpDHALXWXFNSn2hA3uoJJt8acNRKMWKu/M7sKoiST9fM7SXG4mjidU3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i3KQPPE+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AvKqBxAZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EKoXpQ026798;
	Mon, 14 Apr 2025 21:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XWvjkwDmK5+XdYhUHzYha0xC0GrVqtRaC254uNBderU=; b=
	i3KQPPE+MOfZE28a5kUPHXdf1DmBKBExckg6jz5r0Rso4FZ4RCcvDzX+AX6nsJs4
	NeJD/ivFSTPEyBkr8/isIkm6fHQBJPWhvkjYh+XMqevy4WNGuA/QA7JTG4S6tnq5
	nVfn/T71oWGwoCIQFUlPItV6f91nE9KJ35liy5e7cLKBKYI76MVcoFP+PvvmI9bu
	mR60dlLBplrfgq3Jx286vei+u3JeQ5qqIJXEkXml1OjbDWc/8y6SHvL1ZzD752cn
	eKui31VtCkyDIoDHCjzl42TLo4QMhXZcvgGbU8o+J9IMEHsk3Mr4pChkiMwAEOE/
	UUXhovs4rXz8DkE+Af8OpQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46187xr6tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 21:07:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53EJS7MS009227;
	Mon, 14 Apr 2025 21:07:14 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011024.outbound.protection.outlook.com [40.93.14.24])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d3h26hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 21:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T25gEmt90H+hdkButcAzKG5W2fvnksTPhq0xcOTqNgA66STp7WJf2pEDczHSF9AONdV9ZqwpZoPJKk/m+gE6++rdn0Ze2oLbmhPm4kPtQoI2yrpC7c736Z45kL4zxr3RAk6u7usWaJfHpAIcagJf/dRjntgBbiCLCY6I5wdvS+gF4Ep6mbCahRDnGta+Dbn46nGRHJzcwaAIR8tkgaffsObByGP24qqQZEv0uNRNtiRfFvE1VrsT7n0WZpG8FzrW/2kdA0G9WmcFhmxXVjkrpB6SO27XFuc+rnqSm1fHrVkE3wpHMPFy7sdttyPSOmL7MIfAT+GxPE6FYJ4AWz/LcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWvjkwDmK5+XdYhUHzYha0xC0GrVqtRaC254uNBderU=;
 b=y+KMywpeKwA1G1oyqB+N5s2bvs3ScxzMAqS7pC1g/8U/M6PrGRzpVWGdyi86rLuAuMdx0SXtvj9rDEsaWOZEMck0huttPcnhv5WaW3dqfngB1+8d0bIFDK8xDsHz5SxExs4VYGU9Ge1DLRkVbuc/yckTwq/xTpY4Zkxv5qPTf1v6WKA7O6x9pg8jL88vFDSD19zoLLCI6T5t7iXjCzQGmP5I6d2rdS9wFvk96HHXHdVjqACRldNI60f3UO8FKUXb1cxm9NKpTqcpvowd7QYGQwuZJYrJSV/T0J5TWBmvOvpLfFyj84IQmHHL2xMQF1URZjiPmVcJCTkzwgRS60q6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWvjkwDmK5+XdYhUHzYha0xC0GrVqtRaC254uNBderU=;
 b=AvKqBxAZApTooWL6SbW2RhHRlbXKJxc2xS2J15X6QywjgpAT+MOp9Yc9M+oXw4vfDpvDRj6hkvrGnDwPC/LFrmGu+EjOBqswL0vuo7NNcyuZCCs7k7cJBzyJpY/kaKJKP0Z+JNYkj1AnkDe9yn7Dzklmud/+lX5/XqTexbfnOF0=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by MN6PR10MB7467.namprd10.prod.outlook.com (2603:10b6:208:47f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 21:07:12 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 21:07:12 +0000
Message-ID: <2ae4daaf-5e6e-41d4-9d22-2fcda3246bd3@oracle.com>
Date: Mon, 14 Apr 2025 17:07:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4: xattr handlers should check for absent nfs
 filehandles
To: Scott Mayhew <smayhew@redhat.com>, trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20250411201612.2993634-1-smayhew@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250411201612.2993634-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::22) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|MN6PR10MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c575cd5-42f0-4ce7-d09a-08dd7b985353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVUyRzhRTFM5MyttTHZkaVp5VzZhOXg0aEd2WE1Kd0tDVzluc0wwVjBzaHVj?=
 =?utf-8?B?T2JVYk9mYzJ5dHcwMkhVTjJEOWUvdjRhajR5VUU4NTZuejA3NHViYUp5Ymx0?=
 =?utf-8?B?cGM4dWJ0RXNybDRkOWlMb3hqcklBMDNkOEhjaXZOcS9QV0xKUkFYV3F5eXA0?=
 =?utf-8?B?cWxEL1ppZVlqbWR1UFlMMHdWOHhRbFR5WUdzMzhRUURibW51Yk13U3BpcEpq?=
 =?utf-8?B?UitJeldsMUJha1RrOWE2NHFiRjdNWEhSZTI3TmpZVHB4NC9YczBCTjAybk5z?=
 =?utf-8?B?Z3ZjWGZDbG1ja0JpUjBJNU5GbEVhMk4yc085ZndsMXNadmZFazM3dDJSQjNK?=
 =?utf-8?B?MFVkdDhiWVVmT1NLOHJzc3dDWTRRb0xLajhVTGsrZ1lBNW9sSlFJbXVBeUEr?=
 =?utf-8?B?V00vZG4rbmt2QU1Db1J4SlVYZmhUMXo3bG4vNWJrSWk1Q3UzRVg2KzIwdXc0?=
 =?utf-8?B?STY2SmE2Zm9XakdZYkh4Q1RQcXNLSGt0WmpNVUNmM2dmYU02VFNyT1A0TVlh?=
 =?utf-8?B?NnFTWG1sc2t5T2tzY0RlQTFCVGszK0RwL3A4WUJDMGNFVmdpV3VQZ1RDMTdR?=
 =?utf-8?B?ak1UcmdjbjNRS05wY2NpTC9Vd3pvRktEWDJwc1Q2bW9RWHZVclJSemRqb0ph?=
 =?utf-8?B?bkkxcXRVa3J0V2w0UVMxbE9aeFBsTU9KYnJ2MWxiZ0gxbE1MMHFxY2FTOW43?=
 =?utf-8?B?UGxGMWRJRHYvYTkvc0NWckxoNWFuK01Ec2lXb1hlT1cxdHRqZUNjYUMzVTBy?=
 =?utf-8?B?cmxiNjdHQ05aUzZxTC9EaVhyRSttemw3Sk95Y1kzQnpyaWZiWktGOUI1VVFn?=
 =?utf-8?B?UW1WZGFibThVTWhvRWpic08wWmNsUDRuOXErR0VqdjM2N3FzRTBqK1hjSXVH?=
 =?utf-8?B?Tmxib21RUEdGQmVuY2YxNHduejIrUDRTR1pYSmltdi95bGQ5dk9mZEZqY2Ry?=
 =?utf-8?B?aHdvWnZIaHRpWUJIWUM4R3c1NEc3ektEUU5PWUJnYWJVbitQMG14bXJzTWx4?=
 =?utf-8?B?V1ZzaHptWURWMVcwSVY2ZEc4Y1Mram5xNFpyMklmZVZYejRZb2RTQTNTNDNR?=
 =?utf-8?B?aTFJVUpkazBTSWNOREdBcWpES3ZWdHo4Y3JMcEs2Sk9hWGhWSDVLbTlGUVdO?=
 =?utf-8?B?aDZRWTNaaWtCTjBZUzdldHVxRHN5VUtaTk0rTi92VmZLaGczM0JoTHNlQlVn?=
 =?utf-8?B?Vm9wb2FNR3RZaGdHdmNUcDhDNEdwTDdaQm0xR3pBTEZFYjFvZDJHZGFsRXpJ?=
 =?utf-8?B?YTFjZXB1ZlBZTENsZ2tnN2dqYmRiTDF1YlBDS0F5dEhjdTBQYlkyRVF1MVhw?=
 =?utf-8?B?eS93eTl0RTZuVW12YUFCejdDQjlULzJGS04yZDVMb2M1emEwYnFZMnI1eXJJ?=
 =?utf-8?B?QUdNZGs0VHdVb2E5ZmZHbmcrNzBpUDJhQUdqeWc0VkxhQkcrbE9WY3UydFU1?=
 =?utf-8?B?aGd6OS9ncStmTFBWNGdCek1FUTdVR1dEVXRzTGRiUWx4OC9lcWtBSlh5cFVv?=
 =?utf-8?B?M1M5ek5YY3g1akJ0aWYraGdQTkdZWmJwVG9qOWZQYnp1ckh3SW5pMDVyVzlK?=
 =?utf-8?B?MlZJcnJ1bTZnQS9Pck5oUFdnU01MNFIrQ2poeHZydUhiVkVJb3N6bFdjbjZo?=
 =?utf-8?B?WWtFUmduRHptNERBWVU1RkxmTTVjbzNwMlp1d3JxZGpyR1dkOXlvbkhuRyt2?=
 =?utf-8?B?amtaYnN5aGY4MWlZZXZTOGVWMlpNbkZ4Q0NwbW1DNGV6MUlKZTR6RUxzakxW?=
 =?utf-8?B?Um1UV3RMMTRTTHRWbmJZZkNCa2phU0gzaFpHOHBlNCtscFIvUllFNWRFUU94?=
 =?utf-8?B?ajR1V2F2TFZtVEt3T2ppY1RKSGVIZUo3THE5ZlB2aXhUNk9XS29GVnlzd2d6?=
 =?utf-8?B?L01CSnp6bGVKNlhmL2RXYUJKdTl0aVFjZ09yWkxETURKb1JKZXFyUFRyVGRH?=
 =?utf-8?Q?FNoLu17POaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHBPV2lLTXhuWWJvQTAwRTRsaUFUL3pPRC9janZldk1rV2dpMzNRYi9FUWg5?=
 =?utf-8?B?cFU4VkxMWmpUTng1YThKeGVkQXRSQjBReTJDYUIrNkJqaXdxeUxOdG02Mjdx?=
 =?utf-8?B?b2txT0xlLzE2dkJGb2JRaWVqZGZkZWlkY01iQ3huN2Q1ZjRvY3FHNnhKMFkx?=
 =?utf-8?B?elBHK2JFdm9la2dNVHptd2tDV2twbU1xN2x0R0pQcTZnT1pCVnN6ZUpTS1JP?=
 =?utf-8?B?S3RPdVp5OVQwV0NtRmtadUp2Y3l0QnFrSURmeDM1ZWg4NGErak9HVy9aM29Q?=
 =?utf-8?B?eWJmOUdGdEViSTZCVUNiOWUwMFcyV0VzYklnOXJteThsOXQ1Um9Jc0lvSnlO?=
 =?utf-8?B?SzVKNWk3ek5HZkFJZnUxczhvYXZBM21iUjhya0tscVpLeDBBUGFpRDgxaS82?=
 =?utf-8?B?WnV3bkFQcDV6OHNXV2lNdnRKMFQwK21pVExQM3FuUmgwM1ZDMGpwM0NCZThz?=
 =?utf-8?B?Nnc3dWZOWmw1SXZ1a0JicGNYN3BhSGlIT1R5QThySzhGSzM5T1F5bXk1MWRL?=
 =?utf-8?B?T3ByNDdtVnBsb200VXRydGg0SEV6ekZDaFU2RVR3dXNpWnhOZ3BITGxpYnJx?=
 =?utf-8?B?N3U0NkJsZFcrcSthM1l3NzFQeCtjNWhST3FGNWxXcDgxSC9BTFBDK3ozNURP?=
 =?utf-8?B?UVVHb2VoeGpKbWE1MWx2UHdYenk5R2VjMERaKzVQTXM1OEJtQVAwenVUV3Qy?=
 =?utf-8?B?djlmVjB6QUtjSGxMMGhnWUpqTm0vWVAxbU1rOFRmSnZUMVNGbG14ZmpYdklv?=
 =?utf-8?B?Mk53UDByak00eEcxdXBUclRwSHpOdXVyWGsxSjlQcEJlRGt4MWRkR1R4aFZ6?=
 =?utf-8?B?NjFFVVY0TjV6SkMxZHlHM056bUx3RE9PVElkc1JXcFlhN3kxcThjVHQwL2V4?=
 =?utf-8?B?dXRQOWxIM0pQK1ljQW4rUUNnL1V6RnF3U3dzajRvUytXeUI3THpCTzJtUDJz?=
 =?utf-8?B?Z0tCM3JQdCs1bDFTNEM4TmIxU2YrbEVoQU5jOFJ4VXk4OVRob05RWndGSUtG?=
 =?utf-8?B?ckVMUndTT3MxVjBmRkVrNUhmK29ScUZidEFsMkYyQmRZbUxQSW1OQjVOSk5B?=
 =?utf-8?B?UmN1VFVTT09HZGdCUGJ5WDFDQnJqSjR5Z1RUVGc3SzNVQ2QrOWd3ZlZ4TVVi?=
 =?utf-8?B?NTYxTmVsMEdnamg1dHZvT3Y5WFhtMnVPVDJlc1Fka0xaVlhIRGcwMkd1SnFS?=
 =?utf-8?B?TjhTMkM3QVluYzVnODZKTDlCcWJPM2t2YlYvYU1peG9BM0FxMmxxdmRZWUxi?=
 =?utf-8?B?NThCU0h2bzRQaWVoZWRjMTJEYkZwTEZ3U05LTEJmNFhrUkVtOWlocnJ3dnBv?=
 =?utf-8?B?eVVCZ0JOQzIwMC90dFRobXRUaU9EODlVN2xReFpUZlI2MjFIMEV3L0J5RS81?=
 =?utf-8?B?Rm90LzhjUHRFelRBVTJ4K05HZTlvZ1NGSHA0OXNZMHkxNGc3cDFvYTZmOUpp?=
 =?utf-8?B?VW9FcHdwNTZGcmFCVlFMTUUvaDhORldrVTJRSjZXOHZuNnA0Q1JGQktwL05i?=
 =?utf-8?B?NmhOOWxkT2tEWlBjMW96TGVsMHh4L1pMbkk0TFh0YXRFL1dKaDV3NUFiSm5x?=
 =?utf-8?B?amJhMlJZVGVXdkhKT1NkRHVRbWxPcTd4cFlkQUFLdy9wWStMQzh2bld6b2pC?=
 =?utf-8?B?QldTV29NN0lDU2M0K0xNa01ZZHdubnAvYXpMYmRhMVIyS05XK1ZORU1IYlAr?=
 =?utf-8?B?K3h0NmY1Wk9CWGZtWGl0U2E3MkRzbTdKQmxBNkI2Q3MwQlVCNEx5SVNxcUZY?=
 =?utf-8?B?dWtXd0FzSmMyRzVDRkRtU1FqMWFBeGFCUjgyV0tyc3ZoWTdFR3FhMXJNZ1pD?=
 =?utf-8?B?Rk9IQTd3UElYVm8zNmNXQUF1eFpUWHY4Sm9KL1lkZUVXT0hRbTRkZWxsTEhI?=
 =?utf-8?B?cVlkRU5FVnFkcnc3eGFLdnI2NGtnM1N2VVFYc2pFaDhGbXRsaXdnTDNKZTlj?=
 =?utf-8?B?aHQ3Z0t5Uk1QMUJVVUJpd0xrNW5tQzF5RGowdlBxOUVocXdScWVYU1hnRGJs?=
 =?utf-8?B?NEtDRC9VcDRDVUxuUjFzKy9NRWtaSTBET3A4bk1WY3J6ekQ2d3p5RDE1aEtN?=
 =?utf-8?B?TUFnZ0Q1STdOWVArVHllMXlnL2NwbFhyOGhyZHFJTGN4aUc0SWlhVUYzQlpr?=
 =?utf-8?B?TWpnNFFMRHZOS092K3VoM3BoWmVMNUxxYXZVdWZhR0xuRHZ2VjhWa0JPdnIy?=
 =?utf-8?B?NWZkTnNCV29VdCtQbUZtMHZ2aDhXTkFoK3NybDNQSG1xZGVDTGtaKzJjZUdO?=
 =?utf-8?B?bFVzVkF1M2FJUUYyOEFWQUg3U1FBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j+ok9n99GX0z+hzLGJ01F9ZFKb3H/v2AA/O0jzYJxvJzqqLxNok8OrWNzGJrH4GH5OjXYouscKP/hWeithm9KdzHdUC615zc+c6MkkjQYRxiGgyMt+7qLehtaChK+8sXnBR7oWVgWy1fBea+fSlyHxyduzWDKBOW8ie+2DZFSSCJEvvr7rY4jl5H/Dssgyth38ICj3a7TCiVAIFROkf9P6UUBOPL0BJvFbEkLrGHWpjfjFPkNp0R6LoP6cCgMmVP7ag3IudvwOioIcnH5Qk5p7P9wCqIyispg5DWY7v1MXERHiSub8hjhGzc2/Kbg3Fi/uEf+n7Rxr6+huY3vUSsOrUwrqR8LDShAU/g93lXJhODElD26rgQ8OGLKya7TAkxqDLHKHtycgWvmt/IUexV0z1uA4B1lY8dYJXtgJ0TP4sZnPjRAqzmcvj3ZN7ID5lkeSoxijMoa0KT1frIBwrrxQSCQm55yD/F8a2ACzI+z1cdlgNMdwhzVWqZSydXcKVs77j3B5uZtecIUfZBQnKFQXL0/2ehFjjtkxiVRXFYkqZsrD+PYjsMu3GPtZecUeRG/KKCxMZIf1VAK1sboNhNeCU55tcGZL4mhOjRA/B6ZFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c575cd5-42f0-4ce7-d09a-08dd7b985353
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:07:12.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3EbQ002Rz3EG4/BgHCp2gC41Lu0GFC/mn5128NHo865yzuIf1WpFahbp6D4UABPJOaFeOXuQShnd3ShhwI7ciwmhw8ESOsx2letkRBTcw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7467
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140153
X-Proofpoint-GUID: xABAsAO4u7FTKhtPxqmmpPzdne5n-RB6
X-Proofpoint-ORIG-GUID: xABAsAO4u7FTKhtPxqmmpPzdne5n-RB6

Hi Scott,

On 4/11/25 4:16 PM, Scott Mayhew wrote:
> The nfs inodes for referral anchors that have not yet been followed have
> their filehandles zeroed out.
> 
> Attempting to call getxattr() on one of these will cause the nfs client
> to send a GETATTR to the nfs server with the preceding PUTFH sans
> filehandle.  The server will reply NFS4ERR_NOFILEHANDLE, leading to -EIO
> being returned to the application.
> 
> For example:
> 
> $ strace -e trace=getxattr getfattr -n system.nfs4_acl /mnt/t/ref
> getxattr("/mnt/t/ref", "system.nfs4_acl", NULL, 0) = -1 EIO (Input/output error)
> /mnt/t/ref: system.nfs4_acl: Input/output error
> +++ exited with 1 +++
> 
> Have the xattr handlers return -ENODATA instead.

This looks like a lot of repeated code. I was wondering if there is a way to
do this with a helper function that returns -ENODATA? Or could it be checked
inside nfs4_proc_set_acl() / nfs4_proc_get_acl() / nfs4_server_supports_acls()
to cut down on duplication?

> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 970f28dbf253..a01592930370 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7933,6 +7933,11 @@ static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
>  				   const char *key, const void *buf,
>  				   size_t buflen, int flags)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_ACL);
>  }
>  
> @@ -7940,11 +7945,21 @@ static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *handler,
>  				   struct dentry *unused, struct inode *inode,
>  				   const char *key, void *buf, size_t buflen)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_ACL);
>  }
>  
>  static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
>  {
> +	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;

Note that the return value of this function is a boolean, and not an integer,
so callers probably won't care about a specific return value.

> +
>  	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_ACL);
>  }
>  
> @@ -7957,6 +7972,11 @@ static int nfs4_xattr_set_nfs4_dacl(const struct xattr_handler *handler,
>  				    const char *key, const void *buf,
>  				    size_t buflen, int flags)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_DACL);
>  }
>  
> @@ -7964,11 +7984,21 @@ static int nfs4_xattr_get_nfs4_dacl(const struct xattr_handler *handler,
>  				    struct dentry *unused, struct inode *inode,
>  				    const char *key, void *buf, size_t buflen)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_DACL);
>  }
>  
>  static bool nfs4_xattr_list_nfs4_dacl(struct dentry *dentry)
>  {
> +	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;

Here's another boolean return type.

> +
>  	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_DACL);
>  }
>  
> @@ -7980,6 +8010,11 @@ static int nfs4_xattr_set_nfs4_sacl(const struct xattr_handler *handler,
>  				    const char *key, const void *buf,
>  				    size_t buflen, int flags)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_SACL);
>  }
>  
> @@ -7987,11 +8022,21 @@ static int nfs4_xattr_get_nfs4_sacl(const struct xattr_handler *handler,
>  				    struct dentry *unused, struct inode *inode,
>  				    const char *key, void *buf, size_t buflen)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_SACL);
>  }
>  
>  static bool nfs4_xattr_list_nfs4_sacl(struct dentry *dentry)
>  {
> +	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;

Boolean return type.

Thanks,
Anna

> +
>  	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_SACL);
>  }
>  
> @@ -8005,6 +8050,11 @@ static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
>  				     const char *key, const void *buf,
>  				     size_t buflen, int flags)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	if (security_ismaclabel(key))
>  		return nfs4_set_security_label(inode, buf, buflen);
>  
> @@ -8015,6 +8065,11 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
>  				     struct dentry *unused, struct inode *inode,
>  				     const char *key, void *buf, size_t buflen)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
> +
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	if (security_ismaclabel(key))
>  		return nfs4_get_security_label(inode, buf, buflen);
>  	return -EOPNOTSUPP;
> @@ -8023,8 +8078,12 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
>  static ssize_t
>  nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
>  	int len = 0;
>  
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
>  		len = security_inode_listsecurity(inode, list, list_len);
>  		if (len >= 0 && list_len && len > list_len)
> @@ -8056,9 +8115,13 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
>  				    const char *key, const void *buf,
>  				    size_t buflen, int flags)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
>  	u32 mask;
>  	int ret;
>  
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
>  		return -EOPNOTSUPP;
>  
> @@ -8093,9 +8156,13 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
>  				    struct dentry *unused, struct inode *inode,
>  				    const char *key, void *buf, size_t buflen)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
>  	u32 mask;
>  	ssize_t ret;
>  
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
>  		return -EOPNOTSUPP;
>  
> @@ -8120,6 +8187,7 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
>  static ssize_t
>  nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
>  {
> +	struct nfs_fh *fh = NFS_FH(inode);
>  	u64 cookie;
>  	bool eof;
>  	ssize_t ret, size;
> @@ -8127,6 +8195,9 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
>  	size_t buflen;
>  	u32 mask;
>  
> +	if (unlikely(fh->size == 0))
> +		return -ENODATA;
> +
>  	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
>  		return 0;
>  

