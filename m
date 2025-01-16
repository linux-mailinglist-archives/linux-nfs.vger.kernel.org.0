Return-Path: <linux-nfs+bounces-9302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E0DA13C37
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756F07A2519
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A1522AE75;
	Thu, 16 Jan 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jnreZv/D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qO8FUIKX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069D22A809
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037626; cv=fail; b=g1mM0iuy1Wx5xXJYgTL5+EcKnYJE/2LA+MRCBYWp0BJHle/eBA54P9l1HQ89C1m9jAbk2cRAz6LNzvkVziIzF58kEdWeUIIQIwa7YW2cjI07lBz3QRmJNyUXsFofC7f2HJlR/DicsdAhzphJIPn8oG02aF5Z25Zq2YHgEgDCCUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037626; c=relaxed/simple;
	bh=UCid5oy1deJnDFKT/wkHhT4dq/syBjo7WQklqjLwv1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ro3ypCWvYNmkUI1eIQ5ZJmTxwuNJ2g/2hTb3omQuz3ZUw2+ecsvN3AaJ5dR9vBxCiSTRnTdNvL4XiFCAlBCOazrAldAbnYpxDxuO5qTZS8RI+cwxHYP90BeKAC33BSCgBdIeeVhQFuBJwfxHVn80M38YVgnzal2Jeo90x5e61rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jnreZv/D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qO8FUIKX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBMvl8027488;
	Thu, 16 Jan 2025 14:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ltkJv31aKJEmLhhy1bh31IdOYzrdd7AcUEDLtSkio2Y=; b=
	jnreZv/DHeQBI9UTaM07Qv6DxxI9D7cvRem1inQmIbiB7rvXFTcLk1MFUW6ND/we
	RjmYiz0cHGVAr3qZ/QKKXywGHhL7UqKRTQaXwsJmb0nKuleVa9amT12g4WZUx7rb
	K/2qW120ZFzgM7P9JaHM+vqWSvPLHygp7kWU9vU83OydnzK8p2zCM9PqNpECREtU
	A7/6Nj2rAh7D0C/cXPfOSXajYAyTMVHjjN9bK1jeVtUVpeRLBCyT6Wrs4cY8sko9
	WQxhq4ZfAd7JIwU5lDrJmMsRM8HovAmsHUkkCy8lPaiUZE5W2Ec7IgW6XHwlve+Z
	90qAECtp9tXKx0bmbm4IKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446wtp8nge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:27:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDb4Sl039281;
	Thu, 16 Jan 2025 14:26:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3auh6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:26:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3ws3LNApNtbf19XziSIvBTK2uJtITGVyMlN2gAChXVg3rcXo92z3+5mO4b9IEAuFlxJSmV6AMy3fWzUoG0oGDnwYPrs9NWGB6g2DldnJjNT/M4IbPjjWlHn1uCNuY4eFUnYELmC++LBCkNcGANOsZZaItxRxYMNLJAPZdDVXPfDcF4zUJDKmpqKeaGhd9HBrKVAM/0N4AxqaaWlZeQyqRzV/PfKRTLB2A5M+sKeH+IKRqfBbN+OjfEFJ38e4/hmN3bpJpwk9/5a4++slN4lJHlKgcygeMlOeXYrM29/0pSsdOFRouiM3xSDOvMtWvjPEUOMxWyhcsh57YcfBcR0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltkJv31aKJEmLhhy1bh31IdOYzrdd7AcUEDLtSkio2Y=;
 b=PXk2W5czjniJOpWmgHene/ckheiF5RdfAUijNNLR+XncKjCyspR0PUjN7gD8GI5WttMuARYs5Q/CFaYEEhADF+L9zK1ez++bsA9+hZaOnzp6b+UByfuzYSi0bk7CGuKdetkzU+qfmvMZthNvrZQRtkAMiRaRtVbnryiQHG4PY9G3dujKaNJstrzK2Uf4BoLI9v4K3PA+GIg+Msji+7IcDdkiGRLs4rTmEvhsm9aG3fiK5xMSiwdRnmJPeDhhAu3JbjstRDZGmC5YehmImN6IxuDMKWDTEDgby+Knt4NXhyr8mRtjAolmDB/14kPHc13+G2RqZkIIr6nTKhwpsV0oTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltkJv31aKJEmLhhy1bh31IdOYzrdd7AcUEDLtSkio2Y=;
 b=qO8FUIKX/tmsJBZ5qg3DvkIuJe84Tq+8nYWIBwUBC9tzYRhgeI1mn2euOw8Agg7eaq877DVNhGPfINmQUflbVLhUfnqQcj1DYTDmkcXJa+i38sJcChmJ/UB92ShXXo56PLEIPc3miJP7WMxzao9UN7+TD+tep49cLv9Lcp+FZnU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6186.namprd10.prod.outlook.com (2603:10b6:208:3bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 14:26:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:26:57 +0000
Message-ID: <b469204c-adb7-4cc6-a8e9-dfd19ee331df@oracle.com>
Date: Thu, 16 Jan 2025 09:26:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry from
 the list
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20250115232406.44815-1-okorniev@redhat.com>
 <20250115232406.44815-2-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250115232406.44815-2-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:610:119::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL3PR10MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 86503ce9-ac8f-4d67-328e-08dd3639d510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2d0SEkwYU9ENXpYUlhtNXV1ZWdHbTZqb0JoeVQ3N2w0ZnJwRkI3cW1OZlRG?=
 =?utf-8?B?Q01TL09BaVdMU1dRMGppSFNJYWoxcUliMzhEcnlrL09XYTU5N1pNekFrcllC?=
 =?utf-8?B?OEw3dlFUR2FiK2t1VVpSNVE5djlMaDBjVlhocjZ6Z0V0VUFKS3ZPUnNVVGt0?=
 =?utf-8?B?VWMyMFJyK3FSSVp4eWl4dXNwUlBxVEJaeU42UVhKVTErR0YvT2dUTFR6WlBY?=
 =?utf-8?B?S1NLcnhmUHB6em15SFFiYnhqVTM4VlVFaEFiOE9RUk9CZStqZ3VLQi9kbGg5?=
 =?utf-8?B?RnNUem1Xek9DbnAwUlRDemdJVlZ5Y2hHMUUyeUMrVzllQWphT1czMzJPOWlo?=
 =?utf-8?B?aDZQSzFjRXBxY0p5YmVoUmgzeUJ0NUU2SENQQTF0b0d6RlRwSHYwQ3ZTRG5s?=
 =?utf-8?B?elFHMlF6azZnK1NNS0FPUUZCVWJKekMvUlNNT3lGVkxOZ3hnRDBKeW01ZWpq?=
 =?utf-8?B?RlBkRytVK2x2SWtWUitJOWh3aExKL25iVi93T1F1cWozZWZBRFAwcUhLbm9y?=
 =?utf-8?B?aFYwVVZXVTZGdlBuVEhRbytXRXVZRU81L29NajFMKzA3VEROL2g5d3h0K0ZR?=
 =?utf-8?B?V2xmMkNxbDJaYkV5YmxDbit3bGJNNHh2dFQxWFF3SkxDbXlPbHhRWkVvczlq?=
 =?utf-8?B?Rmw5QUFNZE9QUWh4MFQwMjFGVlN6ZDJqMXlFNURiaFh6ZGdacDh1d0FwRWNP?=
 =?utf-8?B?bExIQWRLdlVEV05wVWJ1bmlHN2ZqVk9uanhZYVBQL1luV1dEa001NUI3VjRq?=
 =?utf-8?B?d1ZBS0NpdVdjUGY0aURTdXl3Z1NKRUJ4SXRKekF2UEsyODlyaUtIbFlZUWRn?=
 =?utf-8?B?Nm5oRmgzb3BQY3ZRSzFLa0NidFYwOVMwL2dvUjVIc0p2RjZmYndIaWZmTjdh?=
 =?utf-8?B?WGRnbU1oR0Z5YTVONURFYXVrUWNjZFFlWDRpOWo2UlRlTkJ4RjRCMjllT2g3?=
 =?utf-8?B?N1dRZ054VXVNZTcwUlN3TU84OE5tQy9RbDhZdzFLTUNmREpqR25lblIxRllG?=
 =?utf-8?B?OTI1S2tBNVdwZTJOcGJWNk8rVFM3aU1pSXljRGRXYUNMOHJHcE44UTd6bWt1?=
 =?utf-8?B?cHRJOTAvZWs4d2t3cHNQQTlmRXhZb1BKQVFNK1IzMHRqL3UvMVFWeE92c0Z0?=
 =?utf-8?B?RXBUbzR0Z3ZUanBkVlRZVGZGaFhaa21vYktpcjR5dDhHUDZ3TEQvZUcrU1Yx?=
 =?utf-8?B?dXp1ZzQ5RGNieDBGa0VUR29lT2VCbE5BYTBOVXBUN2EwaW1WcWJtNjFHMjZy?=
 =?utf-8?B?Zy9YM3UwZyt2ZkR2eUxTajE0ZUdDZWNlb1F2anlIaGNQSWRyWHloclYweFhE?=
 =?utf-8?B?UWxUc1hVSm1ROVNpY2JRU3RCcUt2RXVraWUyK2NoVHVJc3V2bHFDMngwKzBK?=
 =?utf-8?B?Z3htdW9vQVh0M3lwcWg1YlpSUkxoTXJEaXBPQmh1WGRYQ3F5WVk2YTVjN3NN?=
 =?utf-8?B?Y3h1TDg4Q3hxZFdtYzBLQWNGWWx5WHJudEZXS0gxdjFjQUw2WFZvWmNyOHlV?=
 =?utf-8?B?SDBRU2dBNGJ6Uk9yejdYdDhDRkN0N2RYUTA5Qk5GazRrN2ZoMFlWTFFQRXFP?=
 =?utf-8?B?TVplQkZOTmFrNGthRG9STW9zM3NUT3Z2aUlueDFkN0RtNE1hSHVNOURBMmhE?=
 =?utf-8?B?ZHBsWDRnSHN1QXFEbGp1OXArTWVBaS96MDFMNGJzMUZtRmRBV1FvVmVxbGF6?=
 =?utf-8?B?bm93RjJSK1VNbThES3hFdXJ2ZDgrUEhTeWpyL05BVmc0MWgrazJ3NmxNbEdh?=
 =?utf-8?B?cXJkWHA3Rm1ITkFJc0FtaHkrMjdLQlI0YVZWek1PU2lJb3haWTljZ1N0Y1hi?=
 =?utf-8?B?WmwrbHArRDBrNzh1dUZVcEFhWEFyb2dnTmwwWkxEWkE3dHptTkJVdnJrQWhQ?=
 =?utf-8?Q?/Px+AR1VTqJk/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG05NDJMZEJLQ25zMWZEUnZhb0Y2MzV5WTVwMkc4eWtESXJobVpiNlZTZDFG?=
 =?utf-8?B?bFZVNmNSbkswcHRmK0laOHZpTUduL1BQcVlvaVoyM0hpWkxlVjhGcmxuWXg5?=
 =?utf-8?B?TG5OQnppOXFMY2dSWkVHQ0tsVTBzSVFTdlZabjBnbDB6L0J2alYxdUVhSXk2?=
 =?utf-8?B?VE9VcmNXUmRDTXpLQWpLenpGUHR5TnRIRWQ3V2w2NFlkaXp3RHJ5Y1hpNFBW?=
 =?utf-8?B?K3YyaDB2aUNuUThRZUZCQlFHOXBLTm5QeHpXMW9pZStEYzFvUDJZSno5b0ls?=
 =?utf-8?B?Vkl1dG5nZDhEbWY4V1hRY3F4YnRTM1ZyZDJXZE5ySlVOc0ZOMG4rb1VYWHI5?=
 =?utf-8?B?MFF1M2Z5eTdiRnBPeU51K3plMG5RSERzNG82cndobmV3UjIrMVN5T1lVeGpV?=
 =?utf-8?B?bCs4NmVWNFpSWUMyeVFVVGNWaTBtcU5ObDlqR1JGeDMwWFFxNDVIbXJJSk1U?=
 =?utf-8?B?eHcvVHBEdjRoOXpTY0wrYldDcXRkNDY1ZjVtR1lReUpFVTRoZEdIaG5JUEds?=
 =?utf-8?B?bmZ3REllODJlaGxNejg1QmQ5N0RwaXk0aTJhZi81djdUa25RdWFZQkhJN2Q5?=
 =?utf-8?B?czRYeCtUbTVxUEpFUFJ5MFlpSTVaRGxUNHcxRnN1b2lNVmEzWWRuN0NNL3Zo?=
 =?utf-8?B?KzJKWms0anhiZjRWOEh0N0N1QW12WHNIeHJ6K2xCT1NVUDdNNWI3eS9BSUd5?=
 =?utf-8?B?NW90RjlNNDJOK3U5UDdiOXMyWkdwSHRsdUhFcGhPWmdCQTJOc2VpaldWOTEw?=
 =?utf-8?B?RGVKYi9vS3MzVis0dWNTSWNKdjhxTzJ1c2ZZVlJORGJEV3h4UVNFU1NaWTRI?=
 =?utf-8?B?MlQvaWRybUdLdlYySmlVeStSTFgwM08wRFBmNlpISGk3TWNYVkE3QitFMzJ2?=
 =?utf-8?B?M3JiczJxUVQzU3VLNVFqamU5Nm41aGtuQXpSdldaY3hqYUZhN3FkaXJ5eGpv?=
 =?utf-8?B?Ny9PVjBONWRuSGh6Sy9OUzZVU2g3anRuL0loMXNPcFhqRDhTaHBwZnB1K1Zq?=
 =?utf-8?B?YVR0MWt0REJFVzBEOE9DUkFDWUtVUE1WcFVuYWUvUE0zQkYvazczaEMxMHNq?=
 =?utf-8?B?SjNvcm05TnVWcEFSMG9NeHB5R3B6RmtCMnlqeEY2WUtwUCsrSGthcngwVGs1?=
 =?utf-8?B?bVpaejdDNGwvOVNQS2l5K3VwaHFVOVczTGhOTGV0dGI2ZFlkSjU4TGVQYmVv?=
 =?utf-8?B?SG5XaXdWZU1xbDNRNUR5Q0VWZzRLOHpvbEhYajliVWtIa09yN0FrdzVuZmRR?=
 =?utf-8?B?ODRUbVIxWEc4Wng2UWd4czV2aWlVL3E3OU9WUjgxMmNWRnJDblR0Y1l3NmhH?=
 =?utf-8?B?L3Bqd2tOenNiMkxuSnlCZkQ4WnJjTUxFeGdUTUFucHV3WUp3MzNkaENIRjBU?=
 =?utf-8?B?NWtibkNWNzFvSFlZcHJSSUptTThLaVNpZ0swUXpzbCtqRUx6ZmpGbkN2dWEw?=
 =?utf-8?B?bEpUMHplTWNtYzBZdXlQaTFnR1NyaGFBRnk0dEpVLzRPYzNtMXdsbVVQSHB6?=
 =?utf-8?B?V1NlUFdsaERSUEpNVy84V2NYc09vdlE2SWpHTytEbGpuY2wwRnE4RHZlRCtr?=
 =?utf-8?B?b2E1cFF4Y1RUeGNDMkFiZkM3OFp4UjlpZHlTVWNlZlJjOEhjeDFzVUJrWWtM?=
 =?utf-8?B?TndLZkdzSGRYT1dSUGMzcnBBTXY2dG5mcjFqM1Yxc1VwR2RrL2RCSUswM1lk?=
 =?utf-8?B?Sno1eDdoZHJqZWpKZkdJdU1WUWNqUEpNM0tUY01RUitPUDByQm50NThHOXY4?=
 =?utf-8?B?MGtJUHp1YTVJZWVNZFdOSndqeDhlVGRoZFd5aDBGcHg2Ti92TTkyZVBhUjlG?=
 =?utf-8?B?QVNKVkhLSmpxdjNpQW11bVhDNTdTTXVBWk9jZUkwbFdiRzZQdXdwU0lyOHNm?=
 =?utf-8?B?MkVvSVQ5NWVnViszK3lBK2JFc0g0T2o0R2RIOWloZWFrQmpUUXhOV2l3dzRE?=
 =?utf-8?B?OFpaR1dhUzhNZ2YzMTJnSlcvRU1CSWFLMmRtRHB3U2lyaEJoMzhJSTFPMHVM?=
 =?utf-8?B?YzNRbTFCVTcvNytuMEFRbk5tUTMzT2JVaXg1RDRqeUZvZXcwVk4yRVB6SDRF?=
 =?utf-8?B?YXlGMjYyTjN0ZVdBSHhyY0c5UkM5UFl4a3luN3B3ZE1aY0RaTzJPSGlGQWc1?=
 =?utf-8?B?cjEvZUZTaXhvbmhUaWdUcTlvQWJaSlhvL1NPWXBNY1g0RWt0WnY4OEJhdWdC?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZjWhmxaDasy2Z1qyQxMI9GrrFxPabmrON5d6f7UTT9LgR/Mwt16UV+V8Y3+bZY58DL1lJU0YySd0pPHcu75gu/ykAmC8wPQA1yMqv/pvt6U2u9r5opzG1VKgQy7k4DSVT94Ig1OaR4Wr5zQc3xe6RiqNaJSxguY/xRdC/+B4JD8Sdkmyp/zyJppv+8Dv9dSSnSN/k+P1ZMv3yb6IOcvdNzl/kO4Qm4tYCPfaEanco6MZINkwfnnaUMfcCuTgubjLuph6bva3beCwecysgZ29PoY7psG8klhUm6++87508kwa1V1iXENbGjeBUE2WK6lTR2JJYsSGsM2F6dHWXITSzEJszaCQxXk/kGjsMOhdiMTmRR/X3RwL0gxwR8mVHGTp9kxczYtM0+Le88IVuDRbeIUOZNHlAMEGRppG5U7uy0tBjr6uVJhj2zNIF2XBNwwddYJUwNN3rKQmlxASoAJJXgUEmueWCC0vtemOoTUdLaj35TLebmKom3RMLBoQIMSXOY/+j97cW/2V/rSgxL20kH3zLWN9oRxIBWDcOl2Mbk33u5Emq3yxnC+t0XVqogff78gSX8+1u1TDBT8jG242dr/LpJAASV631FSTCogWsE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86503ce9-ac8f-4d67-328e-08dd3639d510
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:26:57.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ah5oY8CTCFn+iO6rRYALuXKI1z7PYhuPk9RlgnpfdpSfWhfVLI1VVPIyKZF0qrtee4zxBUrk43Kr/0pevbvrWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501160109
X-Proofpoint-ORIG-GUID: geby6DEORWaTRgYhR3MPyRKiOU4lY84m
X-Proofpoint-GUID: geby6DEORWaTRgYhR3MPyRKiOU4lY84m

On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
> nfsd stores its network transports in a lwq (which is a lockless list)
> llist has no ability to remove a particular entry which nfsd needs
> to remove a listener thread.

Note that scripts/get_maintainer.pl says that the maintainer of this
file is:

   linux-kernel@vger.kernel.org

so that address should appear on the cc: list of this series. So
should the list of reviewers for NFSD that appear in MAINTAINERS.

ISTR Neil found the same gap in the llist API. I don't think it's
possible to safely remove an item from the middle of an llist. Much
of the complexity of the current svc thread scheduler is due to this
complication.

I think you will need to mark the listener as dead and find some
way of safely dealing with it later.


> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>   include/linux/llist.h | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 2c982ff7475a..fe6be21897d9 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -253,6 +253,42 @@ static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
>   	return __llist_add_batch(new, new, head);
>   }
>   
> +/**
> + * llist_del_entry - remove a particular entry from a lock-less list
> + * @head: head of the list to remove the entry from
> + * @entry: entry to be removed from the list
> + *
> + * Walk the list, find the given entry and remove it from the list.
> + * The caller must ensure that nothing can race in and change the
> + * list while this is running.
> + *
> + * Returns true if the entry was found and removed.
> + */
> +static inline bool llist_del_entry(struct llist_head *head, struct llist_node *entry)
> +{
> +	struct llist_node *pos;
> +
> +	if (!head->first)
> +		return false;
> +
> +	/* Is it the first entry? */
> +	if (head->first == entry) {
> +		head->first = entry->next;
> +		entry->next = entry;
> +		return true;
> +	}
> +
> +	/* Find it in the list */
> +	llist_for_each(head->first, pos) {
> +		if (pos->next == entry) {
> +			pos->next = entry->next;
> +			entry->next = entry;
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
>   /**
>    * llist_del_all - delete all entries from lock-less list
>    * @head:	the head of lock-less list to delete all entries


-- 
Chuck Lever

