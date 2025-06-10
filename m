Return-Path: <linux-nfs+bounces-12243-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9625DAD3569
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48414175906
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E922CBF9;
	Tue, 10 Jun 2025 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8gNnCew";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xRzf/LeP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3022CBE2
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556722; cv=fail; b=K0Vgw83YC+usAqt4O0th9+nGVszecQ/d1ZWID1LfeS7+arywyv2DUY18vROtj/AV9z8XAbKeLoqcsfEpw4Mx9IBLkNDWa5dMUSqTnnhA+55m1YeVSE7DOBj797DkYsM7+po3cxQThe+RF/sRfx1VYEGN+pxMHpTMMmfrD8rsJGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556722; c=relaxed/simple;
	bh=P831sf/XQ7d2nFlZzGQywG056xtXeGyOQ/PvBreDOmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TYcutuFudiTk1oRSzyevOXmeBFLGjzLs0coIphuY3e4Jdxr69RiHUP/rC/rkG2nK4Gwk7clxz+dMDfTW3oBWMjz0GlqU+N2VuA5U1UbpmX0G7YitN6qQKdEWX8Hu22owNhwfLncjWDrYJ7OSH7DpmxXc4A9iMIywQ0yVIyjsXtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G8gNnCew; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xRzf/LeP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A2gcZA003326;
	Tue, 10 Jun 2025 11:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=V/Eiz+ToOHZLEr4lEhULrqAP4ZVdPXOogAss7LtRBh0=; b=
	G8gNnCewaEBkJ8Z1DwfkWsMICYLc7zzhpR62xXNEgFfrjU03Zq0pdjKlWi2WLkyy
	B0qSBLlefrFM+FcT4jaEleJ8M9FSuKOufYfns9uAnqwzoa5C9121yFsLJz9cHP1r
	EDAYnkDAgzjNC6NrbZrJbuFsquT93Ey6tRFnZB3aGBKA9mXgU1U2RowJIEspqvRs
	HgmVbj28VKi7+AH39QkfZShQr/zo76s+Mi52MhZ9Rr4rUBExqPGztOKDJXwj8JPg
	tgWUOef74HnU8dOk68hnUMs66WuqqzXRwCjFUoD8qgM2ZXt3IepNCaqRBpsjtobN
	MPJc1Mk836bDKU7MOHCAvA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v43jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 11:58:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ABAJJs020989;
	Tue, 10 Jun 2025 11:58:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvevnry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 11:58:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5+M7MV0GLDYITZwP/f4mWMfIMQCEAH84Awry7X/n1had3JGPTtCCtzKmxq9M4dG86eTXbrfZUMRJc8BYcQmSjWcCzkvbUCzIq7zq7iln5Fz61x9Q7oM2nQnGmhxDHwlvYdLCMIy6kWQdRcZpHiSn5bG/B+AYZivI9Oaef9M5WVuWWYYfzRgAgoH5Rol5mLwZ9HMMx+hQ1Ed1rnwjm0WmQhSzF7ZQz4a/GG6c6kLLDuKxXlmRLbinKk+GHUFC8wtTjfFEOIq2/TxckgjtN9DXtPsE1ZMpv7UgI5xt/F7cBCkKMPAANu5HVUJe4oYbz7LutWhvC5DDT50xA3c5T8mFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/Eiz+ToOHZLEr4lEhULrqAP4ZVdPXOogAss7LtRBh0=;
 b=nzDESJRmXym4d8WnZGfPRm6e9fJAr7bJBvEQIxmjkhv0bvL7v41i2OyrOnGuCNsYNuC2OCF/+N6Tnal6b8zXwCIwN+/Hur/0/CGOqfKoAHLfEc9gRd8wwi6E6lMwAO2ZosUwNDzrw/ru6WaErN1+ErzbIOdgHl76vL9BZRMZhgliDiYWd94uwLb9Wadu1tUjt2YuDCzM6ORFem76rmLGg58dbFangsS8Msl/fH+egt8Ct5ctQKi+z+5Br4eMJnrlcqiNBEg+uDKMyvwtazc6ClisRtyIjldaGhXCtx/MaGwRn1ZDuS6czMhv1565TM3x7K3lWaZw6uQeJ+fyZgbNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/Eiz+ToOHZLEr4lEhULrqAP4ZVdPXOogAss7LtRBh0=;
 b=xRzf/LePWv65dHtTJGKsjkN/iUFhYF+eDDdgS+Ii1RbKfFxV5jhTKvN597Mv/vlKRAdvKkmBoWu3WSLiN/XDpX89PO1r1p059znjZIPfrntKgQ6v0lxd/RLWCUdPk415vG64yDPtlQ3PYeHbDnBJUryRBO2Fz2MaH71Ij5+cZSk=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB8030.namprd10.prod.outlook.com (2603:10b6:8:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 11:58:35 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 11:58:35 +0000
Message-ID: <3c60168c-630e-4253-a9c2-e88a3ed21696@oracle.com>
Date: Tue, 10 Jun 2025 04:58:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: Rick Macklem <rick.macklem@gmail.com>
Cc: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com>
 <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:408:e2::34) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: e7aebb6b-3777-4fc9-dec0-08dda81620e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmNxT24xWmI3YmZjQVJQZG5Ra0NGZmRrVi9wQ0kreGdrak5JcjgzanBSeW14?=
 =?utf-8?B?dDFNcXZKdlQ5U2R5ci9ESXlXUjdOSHA5ZS83OEFhSzQxWlNQVitHYXQyNEhi?=
 =?utf-8?B?ZE4rUWl6WEpZY2dmSzNOSU1FZFoxejQzamc2eHd4c1M0bVZ4dTFpUnJmTm0z?=
 =?utf-8?B?ZUJCOTkxb3gzVUtQWkFIeDJjU2t0SXhrdXhtWGxjTlN5bXlPT1oxMkROR3ds?=
 =?utf-8?B?bGYyUmdtZmFsYXhXNTZVUGVYUTJjSUtLeldWYW9qdWZIVnhldXBlRkF1dTRr?=
 =?utf-8?B?cjZvYlVKcTlmU3VlSlRNM21nZnRNQVJWMFRzODcvSy9OWkcxMzVTQkVNMWxS?=
 =?utf-8?B?QnZCK0x5M0toKzFhSzUzVHQyYytTV2dVQXRyaHJzWFowZ2FCN0dvOERTbFlp?=
 =?utf-8?B?cnRqRkJyUGFQZ3gyeEVaVEhLRTM4ZEw5Y3pGcmJGcW1TblREYzRmanZiZC9U?=
 =?utf-8?B?bm1BQ09wRjBCeVorVFdmNzVHc01XWWxvUjJsZFZaazEyVnRoY0RPZ2dpUTBN?=
 =?utf-8?B?MHVlVWpwSEo3ZW1VNzBCOHlXc0ZJd0dyWWFwK0F1YTc2ZXFtL3pEMmZNTGVW?=
 =?utf-8?B?N2Y5RlJ5d1hUcFcycGV2V0lxNUpjd1Y1YktOd2o4QW1lRTlMMU5BMWxxY2RG?=
 =?utf-8?B?R3J5WWNiU2ZaQmh2NWVQajJIbnZ5RVdJQjN3M3QzTXl1WDVLUktmQmp0WVJq?=
 =?utf-8?B?ZW1OWXZEOTFRVWw4dUhMQ0FTdUdQdjc1Mm9KQUgvN25BUDJRekNlZ0xmOHpF?=
 =?utf-8?B?ZkRHVDVGV0NucjFic1cwMVNQaHpQVGhDWnQ3QklzK0p2L1lpSFJYYlFsYjRW?=
 =?utf-8?B?VmNRMnR2VXVmZjBMdWQ4c1hKa0hWdWNqakg0UTF4dnM3eTRqZk5KbElMcVpo?=
 =?utf-8?B?UDZheXRmRFBidUN0RmZyOERHcmZwMlNobFVkSlRpVCsvanNma3JZdDV4U2RV?=
 =?utf-8?B?cnRVVHB6c3dzWGF2UHY4ZUtqbnZKUjVrVTZBOXZVelNSWEJhc01FMHI4WXhr?=
 =?utf-8?B?S01neVJYd0ZraExNWXJETFdUOXJad1FMbFFheDNJWkNERk81bUVUM2w0NUVm?=
 =?utf-8?B?VEo0OG9RRlFscDVaOXF0NnVJMGF1anVzNkg1NWZESVl3VEFTNllhOTBORHlT?=
 =?utf-8?B?c0s3ajAxNm9aSHpvNXY5KzB2d3kwY0UvdzRwaEQ0Yjd4WHI2T3ppSVREdFVp?=
 =?utf-8?B?L3ZTWVlWRnpLSUd0S1IybVVQV0JUTm56Q3o0eXdITXVFVno4Q0pmM2lsYTBG?=
 =?utf-8?B?cGxyMXdUcHA0VGIyNnE2dmoyWkZTUnYrT2FRVnJVTS9wbUc1NHJjQ2JkZ3Y0?=
 =?utf-8?B?dHFvU0drQU5uZzRMbUcrVThPTzBWNnlkcGRmei8weThBTUdHaGNjQ0cyRDIr?=
 =?utf-8?B?QWJwYUVsYmRNNnpzeW5mcGxTRnQ5Ui9ZdFprV3ErSm4xVGcwUGVXNFI4U0tq?=
 =?utf-8?B?USt4WFRjWU5HV0dza0RaVXpTVUpGcnRicmhMbTliUEhPeGhqVDVBZGZiSmNu?=
 =?utf-8?B?aWdOVGtySkh0dlZZTm1BWm9Ud2V2a2NCbER0dWZ6T3ZRTGZnbVV3RzlZZHhX?=
 =?utf-8?B?d1VWU3NReGNjem43eW90VmF3VTVWenM3aXBhMVRDQTdKakh0b3JpK2VZL3RD?=
 =?utf-8?B?TWdiY2xOWHhIRC8xMzRBQ3UvUzZrLzJ2VGEwaC9IODI1NHplSEtGT3ZNaXdw?=
 =?utf-8?B?cUY1MlFkMjdVWWdMeFdaNFpMa3d3OGlWbHJrcitnNU82OVVhTTNQSkUrcUVD?=
 =?utf-8?B?UzRjd1g1MU9Qck5VMzdJVEQ3YVRwcjBHbTk3UktDS1Mva3NXOUZITWszNTZW?=
 =?utf-8?Q?Bn1jJALbtWWIc60IAEj2dfr/anFRvZrW0cYqA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emJPQkxyNmtkWUk1RWloUndrZnlwOVAzNThaRWZITnYrbEJVN1VxYytnQTZW?=
 =?utf-8?B?ZEtwa045Yk1VaFhPZDFUVG5jV2UwSHJINGlydzBmakhuYjRHaGdFQS9vT2ly?=
 =?utf-8?B?bGErY0gzSi9JVzY0ZXMyQnpQRDNQNytzVERWd1lXcFN2aGg5RXlwN0Z6UGQ2?=
 =?utf-8?B?aHhsVGU4N0hPTUNpOEVHa1lvVnpteFllWHBIM3g2a2kvdnZYQkZjWVlHT0Z3?=
 =?utf-8?B?ZlBZbW1rOGZGVVZwYUNDdjB4aVUrZnYxdEFuYnhUQWFMY2lSUnpXSkZBTWgz?=
 =?utf-8?B?YlpjMFErOEJ0Z0hlaG1Qd1EvVlRQWVNHVFJoTDBkVUYvL0M1K1NJekloMDF6?=
 =?utf-8?B?K2NNS2lNODJCRmlPTTBPa3RwTVIrdVh3UkdtYmx4UEdGSUxoOVprTHhNbU55?=
 =?utf-8?B?OXVCdENJUDcvb3pabFVyMnR6Q0FJWU5LZ1ZpRjUyd0ZZTUZOUVlDUTN0aW95?=
 =?utf-8?B?RDB1b3pRL1ZBN0JvZlJINk1Ya0d6MUx6eDc2WWh5T3Q0VHpOUzc3eGdZTUc3?=
 =?utf-8?B?end4dWFGd2E5YlpmSmw5ZzFxMG8xb05maDh5MVdBTkZrMWVtUUxKOHZ5QTlS?=
 =?utf-8?B?a0cvY0k3bmhCSjJacnBHTFA2TkdnajJtVWtueGJwVDFaOHdiSjNtQnZwQzRv?=
 =?utf-8?B?UndaVFlsb1dkOGRUMG0wZFY0bS9yWHRUZkFNMmVkQXIxczNNU2tKZDBvblVi?=
 =?utf-8?B?KzNyR0FheGFtZ04xbTBwcFFjamp4SUxvc1pXRUROelFsS1E3MUpkYkpiRnZC?=
 =?utf-8?B?cytQL1dRMWdVQndVcjFSSXk0cGY2NnZQajNCTFhrNzErNmlWZ1hwRWh6ZG0r?=
 =?utf-8?B?SmpIVXhsb2FXSFdIMVdIUmFVVU5BbHlrcXozM0phUFErVDRyZ0txUmhTVE1X?=
 =?utf-8?B?Y2VPRFZqMkhpSTdhQ0RDOE9hbFVSek8zdllha3pDdFRIRmNXdWlUMjFpRlhN?=
 =?utf-8?B?dlh5MUx0bUY0U054SEFYb21UMnZsbVdXQXlDcGZ4eXp1VUpjcGlVbDU0aUdr?=
 =?utf-8?B?OFplUGx6REtBbVJUSHlCWG9JNGszWTlxOGpZOXBSVHBEMkpGdll1YlVsM0Q4?=
 =?utf-8?B?MTBzaTA5bkxQMVFpL3pRdjhuOSsyb2hGSDJ0d1d2VXZxUDh6TnBLTmdKMjhl?=
 =?utf-8?B?SW82cFVOZWNkVGxNVitVN1JxZHJ3WEhqemIxTTcremhrbEJEbGRQemk3Sytm?=
 =?utf-8?B?dUFlSy9MeEtMdFBLZFBuMDhJSU93ZHhsQ3JRaXVkOUtaTDVqQ3RRampQMmFM?=
 =?utf-8?B?S0FLbG5KSFNZSENFUll5K3FoMmhoWXE4a0dnMFlGdEFkQ1UxblBzNEM2Mkxt?=
 =?utf-8?B?MUZpeXpwcWQwRUM0ZFNRT0UvZ3RCZWh2TDZJeE5Sa3ljVWF0QzZVbnhMZXkv?=
 =?utf-8?B?TFF5by9NenNmejJtcHRUeDdsQUZPdENkb0dTWFVWQjg3bmw2MEp1SjNLK0Zi?=
 =?utf-8?B?Yzg4WERrMHlJMHhEdk9HdVQ3ZFpqU0ovd21VRFlFWkRIOXl1WHdabXZmRFVr?=
 =?utf-8?B?UFBYTXZ6VzNrdEdMTHJCNHpNRDI0ZlI2dmE0VG95ZFNYWWJwdjhDeVFpTG9V?=
 =?utf-8?B?SThJcGxBcHZIOUhSVmoxV0l5WGRrRG4zdkRIS0RtTGRCalluS09TVmtCNnNu?=
 =?utf-8?B?dk5BbnNZTVVKZnZCRjJ5R0xyZndaeDc5Ty9ieURFRXVaWkY5OStvQTNqT2sx?=
 =?utf-8?B?VEw4ZEZSZHNxcU9iai8rYjl2ZWQxTTg2RkFtRTRpZDBHWnZnOWw2SSttN1hj?=
 =?utf-8?B?eWFuUnhERnpkV2lMcHpOenpGNHN6Vy9WWVBXN2wxYzhQQ1hTU0RVQ2FDQjJw?=
 =?utf-8?B?YytaN1BOb0FKekZOcDlXc3BZMzZLcDdhYlpDNU1rY0xYcVdMaXk3Q0hOSW5Y?=
 =?utf-8?B?WFhDZDdHL05Rczl0YVJ4K2lrSFhMWmJObWhmVnJrSFpGNUJKQmNyTUZiV1Bl?=
 =?utf-8?B?ekx5UWpUVTBiMXFFYjRVb2JVL1RJSGRRQWpqbzdwK3FIVVRaUmtpYnFhMnVh?=
 =?utf-8?B?SW1KS2Z6NkhCbWhEVWgyWi9MWGtNUGthK1M4TlRkdEFIZGxYRTlZMURDdUEr?=
 =?utf-8?B?eGxzYk92cEJlWXE0bGhadEZsS2xZQmg2ZnpLa2t2R3J3UnN6aTRlK3FFeTBy?=
 =?utf-8?Q?81vuLLH1UKZ98aenhx1Ear+wO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BB0VfDwbegyLUdU7064ch+Rf4x0d+jDVbUtqgcOK76NqNIb7Nhz9yC9kMaSeyzhJlGpmBnGvpWCZFFGWaJn8yWVtAt7W82Eza4JVxA6pf0oAV5ulOteL7ErkOz09mm3LZcdHAAYvxUQBAbJShifUfG78GsL/er3X8pdXyvfO8IMIxkW/kH9Uq2Mkjv+V+ROIHUQvzWbvH5ekWD/IFZYjDLMLeikUSd8SyPuVLmci7oFlLz9shK/SJaA7/3octHAQ34n20q6pwP2GO+ajSag5wf3IbdhmNA3sL5ifyI9+zb2yCDXm2AcqLrcPf5raWFXYN8U/0bBXKbhCqdDs10XLZW4b7kVTRdjWMw3jzjPBUCeFVwWIgTYstBv2RJ1ozaVCaNaJC4xtnEbxiMNr6kR3R9ODZ9lHOA6M4xxnMsFgg9i2PMNHFH+Pd9p6D+HZ8U/2KbfczmcJOe7DwZpHX9qWHZwYjhtfmjfElROeb9Jg0c+FL2kE+fmhx0ZUpEWLbgLCtpHl1EEqS//rY8QLvlt6rp3i9+K3BGAlaN59GNzKHUmT/whNxoGEaPj1W8xvgWoXVsPq6l29+GjXcy3++PdSDSbjUaHeHl7MCTN4DdTD0MU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7aebb6b-3777-4fc9-dec0-08dda81620e6
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 11:58:35.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7/p+ZB4tKks2r4FzFAQMeuRVC/Ql+j686ei553SQxfXsdD//f4TsfeAyUrDxhhGnntr3Jw31KMlELFtpERm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100093
X-Proofpoint-GUID: IzKTSU7L-q-8e4zNSum7tbS7nEqtBPIK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5MyBTYWx0ZWRfX3VtZm3c1kH7/ NNmCk0DToG7RpZn1eYAV20edc/Oi5cPJD48ytAeHQB3pQduefMiq8URAvsCZXXlcKyE77TvIbeX YBfX36l1BEyK/s8oIix1C41N43G0PwRU0/Ek/92O4WP7pGySKIRCj5suZW3J9f46ufaC+4svP5E
 uKGTJyO5HMy+0p2tCtIyirkdDuCd1fBAb0R8OWyNA5+ROEJ0q5Bxio9FoH69ZbaTSfgtsRqMKkJ YgaHYWzp+H14kEIJGTI2MnmPCGDzcC+dnSYXOCrgcuAvrjERjz791lrrNYmu8UV1EQDKH3QdAi1 ZRAUaYp8uDlrhI4+QHqZZCLNiByqi/nCQnUQto+Bwg+xSrSSVqk4N3/7S3+HOO9TQUweN+ltVmN
 OLQ/Pc3AgQ4KlZQoNIG45q6AlkOQDAFfU8rttKlDhTL4G6VaK6W0wwA7hNjl3p77hRgOBsOe
X-Proofpoint-ORIG-GUID: IzKTSU7L-q-8e4zNSum7tbS7nEqtBPIK
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=68481ded b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=6I5d2MoRAAAA:8 a=yPCof4ZbAAAA:8 a=-yzxwr9G_8d0-6rz7AgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207


On 6/9/25 6:06 PM, Rick Macklem wrote:
> On Mon, Jun 9, 2025 at 5:17 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>> On 6/9/25 4:35 PM, Rick Macklem wrote:
>>> Hi,
>>>
>>> I hope you don't mind a cross-post, but I thought both groups
>>> might find this interesting...
>>>
>>> I have been creating a compound RPC that does REMOVE and
>>> then tries to determine if the file object has been removed and
>>> I was surprised to see quite different results from the Linux knfsd
>>> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
>>> provide FH4_PERSISTENT file handles, although I suppose I
>>> should check that?
>>>
>>> First, the test OPEN/CREATEs a regular file called "foo" (only one
>>> hard link) and acquires a write delegation for it.
>>> Then a compound does the following:
>>> ...
>>> REMOVE foo
>>> PUTFH fh for foo
>>> GETATTR
>>>
>>> For the Solaris 11.4 server, the server CB_RECALLs the
>>> delegation and then replies NFS4ERR_STALE for the PUTFH above.
>>> (The FreeBSD server currently does the same.)
>>>
>>> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
>>> with nlinks == 0 in the GETATTR reply.
>>>
>>> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
>>> probably missed something) and I cannot find anything that states
>>> either of the above behaviours is incorrect.
>>> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
>>> description of PUTFH only says that it sets the CFH to the fh arg.
>>> It does not say anything w.r.t. the fh arg. needing to be for a file
>>> that still exists.) Neither of these servers sets
>>> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
>>>
>>> So, it looks like "file object no longer exists" is indicated either
>>> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
>>> OR
>>> by a successful reply, but with nlinks == 0 for the GETATTR reply.
>>>
>>> To be honest, I kinda like the Linux knfsd version, but I am wondering
>>> if others think that both of these replies is correct?
>>>
>>> Also, is the CB_RECALL needed when the delegation is held by
>>> the same client as the one doing the REMOVE?
>> The Linux NFSD detects the delegation belongs to the same client that
>> causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
>> an optimization based on the assumption that the client would handle
>> the conflict locally.
> And then what does the server do with the delegation?
> - Does it just discard it, since the file object has been deleted?
> OR
> - Does it guarantee that a DELEGRETURN done after the REMOVE will
>    still work (which seems to be the case for the 6.12 server I am using for
>    testing).

The delegation remains valid but the file was removed from the namespace.
This is why the PUTFH and GETATTR in your test did not fail. However, any
lookup of the file will fail.

>
>> If the REMOVE was done by another client, the REMOVE will not complete
>> until the delegation is returned. If the PUTFH comes after the REMOVE
>> was completed, it'll  fail with NFS4ERR_STALE since the file, specified
>> by the file handle, no longer exists.
> Assuming the statement w.r.t. "fail with NFS4ERR_STALE" only applies to
> "REMOVE done by another client" then that sounds fine.

Correction: even if the REMOVE was done by the another client and the
delegation was recalled from the 1st client, the open stateid of the file
remains valid until the client sends the CLOSE. So the PUTFH won't fail
regardless which client sends the REMOVE.

> However if the "fail with NFS4ERR_STALE is supposed for happen after
> REMOVE for same client" then that is not what I am seeing.
> If you are curious, the packet trace is here. (Look at packet#58).
> https://urldefense.com/v3/__https://people.freebsd.org/*rmacklem/linux-remove.pcap__;fg!!ACWV5N9M2RV99hQ!IEcffaAAeLhuzaJUO5rQOv0jUUk4ltuMpfqT83lLFkRL9cqOZEvZ-8GGjvoqlVAQKi_FAAhsKEl5NjvS0OLJ$
>
> Btw, in case you are curious why I am doing this testing, I am trying
> to figure out a good way for the FreeBSD client to handle temporary
> files. Typically on POSIX they are done via the syscalls:
>
> fd = open("foo", O_CREATE ...);
> unlink("foo");
> write(fd,..), write(fd,..)...
> read(fd,...), read(fd,...)...
> close(fd);
>
> If this happens quickly and is not too much writing, the writes
> copy data into buffers/pages, the reads read the data out of
> the pages and then it all gets deleted.
>
> Unfortunately, the CB_RECALL forces the NFSv4.n client
> to do WRITE, WRITE,..COMMIT and then DELEGRETURN.
> Then the REMOVE throws all the data away on the NFSv4.n
> server.
> --> As such, I really like not doing the CB_RECALL for "same client".
> My concern is "what happens to the delegation after the file object ("foo")
> gets deleted?
> It either needs to be thrown away by the NFSv4.n server or the
> PUTFH, DELEGRETURN needs to work after the REMOVE.

The PUTFH and DELEGRETURN continue to work after the REMOVE. The open
stateid and delegation stateid on the server are destroyed only after
the client sends the DELEGRETURN and CLOSE.

> Otherwise, the NFSv4.n server may get constipated by the delegations,
> which might be called stale, since the file object has been deleted.
>
> --> I can do PUTFH, GETATTR after REMOVE in the same compound,
>       to find out if the file object has been deleted. But then, if a
>       PUTFH, DELEGRETURN fails with NFS4ERR_STALE, can I get
>       away with saying "the server should just discard the delegation as
>       the client already has done so??.

You can try your test but I believe the PUTFH and GETATTR won't fail
after the REMOVE.

-Dai

>
> Thanks for your comments, rick
>
>> -Dai
>>
>>> (I don't think it is, but there is a discussion in 18.25.4 which says
>>> "When the determination above cannot be made definitively because
>>> delegations are being held, they MUST be recalled.." but everything
>>> above that is a may/MAY, so it is not obvious to me if a server really
>>> needs to case?)
>>>
>>> Any comments? Thanks, rick
>>> ps: I am amazed when I learn these things about NFSv4.n after all
>>>         these years.
>>>

