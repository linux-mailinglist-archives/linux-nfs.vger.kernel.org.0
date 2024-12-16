Return-Path: <linux-nfs+bounces-8582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573C79F33DA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AC618820AD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D995A7B8;
	Mon, 16 Dec 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IdHGzf6G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mUdH46O5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3732288DB;
	Mon, 16 Dec 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361085; cv=fail; b=VLLr/UGNPg1Fc1VZpzalMwFkDsL/IBPlkZFH3T2EETaVRSd5kqIzg53BSvu6qVMeXF4n4OfmGkX2k/MOjCInQ2sj5tVsLYkfmsBHdWTnsAnZo51BsO385akSPB7FcVsGaQHmOB+OBHPXKMNtaO9o2V3X4fHXDmfuH5Kna4SRJps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361085; c=relaxed/simple;
	bh=6UFuxBMUZ0QqUgMB45FjlaLKLoUgObb/lFVP2tNTWgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=auw8nmBbVPPkaw1B1qp+lsxqfolOTFlcf3dnSK3GlXnUb+nAGF0Hiygumoy6NX5P8/I9yKYxtA7rduRUeqJoGrN7aCLWgNuw3g9j7xkHn2BXiWIVI7lq/t4/lqqMGAzrHGWdGrrlipJDpy5g8fPO74erivLBuUY2k5oNFyU9Bjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IdHGzf6G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mUdH46O5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEnvAX001824;
	Mon, 16 Dec 2024 14:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2SAhhyQxRUTpz6SoxPUaKyF9bLj+JXGojvaADn97u80=; b=
	IdHGzf6G9H2rlqzD87aZH92xyqfFJ8wIKzXt5ILgwsBocS5EMLhmKYEZn3tfDLEb
	AbhNrvqzzM4+Itqhvv/tsXtpZMwy1X/xTOnm1NxlzDPfUC0DnXk1bJzTtmzfqN54
	vf9rGFTwFoh3uV1dMKXKMtVPG2XJMXy5fXdCqXnHPx8aNVs9kNbRbO9J3tjpivGf
	vynHn1sKByJh3KLOEGAK5fCFDminL4QYe+hU/jskH4u9EWmSpDx8+cOcuu+eYJ9d
	dQFxSQeoz2+tWqHmSfz2Sdah9m54hosMZZBV6cEqsE+Q8gNLhndqPKHjYnefojBs
	HynwY8V23cuI2IEjEcLOVQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt3c0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 14:52:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGDZ4rB000614;
	Mon, 16 Dec 2024 14:52:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7c179-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 14:52:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ia26W2kGRAKhfaFgTpCzqmUj4dgeEo4n4+3yRkvNFhnmj5zdC18cuMqwXa+NfEFcEkP5ZKh711sFroDDaoZO31nXw7hoJT+I1060t5gKX5J7yeZo3p8J54WEkhC2J5InnOsWD24mDhZ2qmLC7P62ufGharFEpOYhC1Tfn8WtvgEsa8Na/j3AVyQbY/vnmyyXIsromV7gUJE+1ayB7gYXcKaRH3oFH9LrhuHZNhwGS8oQsKjBSf5yZD8PF/v33SW1p7MWeVQIJe9Xmir3rc7EmmGJ1NqTUxRqjBow1Xw5I1UzGL4UFUK/L224hQ1AV2k8ZEjJ9k0e9VbVxHkaYy+4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SAhhyQxRUTpz6SoxPUaKyF9bLj+JXGojvaADn97u80=;
 b=V/CP4c33YlXMYSnOVCE+BXtaBQ88gX2VA4eOZ4GwZxwppyINESZYRSz5dzZEewSYruy6pKfi6SxB9KiTqf9Y0vnY91iScelW+IXtC+9Mqenhvza2kJci2By9ycRv0qipfuIpWK3YpKNtPhJBkOiekuHN0NFiFyNdkPXFefkUUJUvxuWYqCCCt+1oji6yW4nhUpcX8AbmKZapA1yrBwVJrRqc9C9Q7/ZOf6DxN01FIz+PbKqgUda+rV/Whc8jW3MbBuxvv1F+hx8YtGCu85HLTq8gDjmeqEAaljguKwJpaurbfsY55zI/lV+oyZvKwFrpAI4Pe0OrrjsSrNunxcojoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SAhhyQxRUTpz6SoxPUaKyF9bLj+JXGojvaADn97u80=;
 b=mUdH46O5yAIEMZ5NaI3DWI8kzt0kjRCl6wB/G+JgmdVaWxAaH7lOPAkt/iOZhLCw/nQiDFi8dZQZyrDdlCfuR1+JQOgcW02v+hdiJdJjBhdvHb/RLAevWuktBUT765JIAhHn84Af+pdaeenFQDIZbnUR/VNWLmaruNBQfoi+K+E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7925.namprd10.prod.outlook.com (2603:10b6:0:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 14:52:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:52:35 +0000
Message-ID: <4cfae0e3-c5dc-4726-bbc8-dc0b5395d8cd@oracle.com>
Date: Mon, 16 Dec 2024 09:52:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] nfsd: Revert "nfsd: release svc_expkey/svc_export
 with rcu_work"
To: Yang Erkun <yangerkun@huaweicloud.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Cc: yangerkun@huawei.com, yi.zhang@huawei.com
References: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
 <20241216142156.4133267-2-yangerkun@huaweicloud.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241216142156.4133267-2-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ec59bf-5224-4171-9ff0-08dd1de14705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzQzcmRKMUNScE9hQmxjUlJPdHVNNUsrQ1AvYUdUWXJyK2tSSFZVY0Z5cytP?=
 =?utf-8?B?ZUxGd0FQRU4yMEh0OXpveXdnUlhSN0htVFVuNHFEdnhkYUIxRmFINUUxelNI?=
 =?utf-8?B?Zy93TkY5cG4yYzZVQWxiVGhPLzNyaTJiZ3NCYldnKzlwVTgwY2ladEF6bVYv?=
 =?utf-8?B?eXNMbDNnb25DdDdTZ3hiMFlac0dzblNYZEwrZmV1Qno2OHltYnQyQmh1WkVa?=
 =?utf-8?B?OWExN3R4WGpzVk85bnU2R3ZEaHhGR1BTZmVVUnBnNC9yeVdzbEZyTTBGRnFM?=
 =?utf-8?B?SnpIK2ZaWGRtYzVUVHc2SWJsajlhTXJTR3Z5TmZwYThGeUhOd2pXTHBvaGMv?=
 =?utf-8?B?cmVvTkppZUtTbDBVWEV4NjYrdjFLRjkrMjdPZUdIeEdCYXNOWFdvVXB6eE5k?=
 =?utf-8?B?U2hEYk1HMmFVQUUzL25DYU5TNk9LUnVKa2I4Si90Sll1OHBxejdJNzhlenNX?=
 =?utf-8?B?WTZkY2R3Qy9iL1FlOVhWRHh5d01nVTZndHpMYzlGeHlNMHdUM0grMkljWkc1?=
 =?utf-8?B?OWk2dFFsRUpJaHZqZDV2OTZNdENZZjN4VFJNY0duR2x5V2hOVU53OE9pTFFM?=
 =?utf-8?B?OTZodm16K1NHcXhIYVZ1UEQwZVplNU4zSjNVdzJ0ZlZnZlBELyt5d2phQXdh?=
 =?utf-8?B?eGtZWTN4SVJ3WXo4WW9UU3VsZ0JYOWdaUmtpc2VkQXpSZ2hZSEszWmRJM3p4?=
 =?utf-8?B?djQ1eWoyWWx1eXV3OFpyOHBzZmRxRjZRNlh6eG1seGd0cVAzUXhLS2wxeTM4?=
 =?utf-8?B?blNad0ZGUkRFTk9rQURIQ21wVE51QmNtMGtUdTdVRmFKbjkzY3MvQ1ZOc3pH?=
 =?utf-8?B?aWpFellIL3lIbm5GWmxBWmFHbXNuYUY3NmJWMnNxQ0lKOW5aM3MvbFJqT0N5?=
 =?utf-8?B?RTVBRFd2S2ZoeVRvazk1eXdpUU1QYXN0dTRJNStsMWhHOVNRSE1zUnZVRGM4?=
 =?utf-8?B?MGNkTzBuUXgvYjZSRGlRVUl5dVVzM2xibEdOYmxKMWRoeUNkZmQyTmIxSUgx?=
 =?utf-8?B?aXczdVhYTzU0RTZLeDBDSlBEZm5SeUxONW9ZSUI4NUZGbUpDMDhyQnI4cWpF?=
 =?utf-8?B?VmIwVWhLeUU2cDUrdDRrRERFNkpDNUNBd01HQW5ZZDNTZ0pRZTVuelFXOGtU?=
 =?utf-8?B?UEttUEhPVkE3Wkp1N1EwbFh4TU5mZk1EQTVUY0tMRU9kNVdBbnQ3UERuNnAw?=
 =?utf-8?B?TStvTDgvaUxkQjFzcUNhengzOXdPRmxmeFplamFxeENBdGk4Wm1NeXlZd1Fh?=
 =?utf-8?B?WTdlMHMycEsrWlMwc0N1d2VMN1NXM3I5dyt5ZklaL0pNREtDWVdYMmZLcTla?=
 =?utf-8?B?UFUvM0hiU0d6a0c2TXlFbkRId2Fadzd6Um5iYWt4cklCdFFMN2RrZVprSFB5?=
 =?utf-8?B?Zy90MGRrUVMrckhxRVFhRW9vYWo3ZVZwNnNlTWVxNHBsK3FQb2RMbTFxaXlI?=
 =?utf-8?B?TytpWlVpaXJ5UEFNWmRXUXRHK0tydlBGL0t5K0wvWmllR2F5dHlYRWNUeTls?=
 =?utf-8?B?S1RXYkNOWDR3cGZlUUFMMUxUd010amtnQlptTHhmWStmZENtWTJKT2tvUVhl?=
 =?utf-8?B?Q0xza3lEQzNvNWZDQ1BFUys0ZzhWWU9tOUg3b2xMR2p2cHlNOUhvMkxSM3Z0?=
 =?utf-8?B?bHlKMHh4UmM0ZGdhRzg4b3dzYjVqTHFtVDN0dkpCT0xmZ2c2OHN3NEF2eWp3?=
 =?utf-8?B?S2FGeE05ZCtNMWxuV0lkOE5XSlRVRGthR3RnYndOUDQwWHcvcExSeW1VeTZr?=
 =?utf-8?B?Y25RNkNTS0xqN3hCRlFRYlhqRWJJalQ0OEx6endCb1lxbk9ndSs4MVlRdVBQ?=
 =?utf-8?B?Sm5iYy9iT2xnZVBiRzRIWFNmYSsvTGUvNGVCbVhsRjA1Mzl3bXBwbWxCZHE2?=
 =?utf-8?B?RzlQcEhTaWhMMFpMeTFUdDQzSTFad1hDWWM3MG1QTVVWWkQrbzl2NkNRekNq?=
 =?utf-8?Q?hgm38n2a6sc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czZWSTgrNUU1aGxmNytEL3F6NmhVaS9hdzZ4S2tKNkYvUGZIdXdHSStBYXZP?=
 =?utf-8?B?UmJpd1MxZVZmcnAvZ00vVm53ZUpMaDZ1bHZPb041RjNUWE5YZEZmcnV3SjdY?=
 =?utf-8?B?M3lpbWhlWHhEUDZNV3djYzJvby9oQ3dodTZNM0E3RDJkaDBUZjhmQ0RlZGhx?=
 =?utf-8?B?Q29RTEprSkxoc3lmOE1mUTNQMnl0NW5MbnZUUU1TZmgyWDhuZ2MyMzd2WEw5?=
 =?utf-8?B?YlY0SHA5UmEvblphRGt6SFZyWVFwRTl6L0xFZXV6RXlrRC9CRU1HRDQ1WExr?=
 =?utf-8?B?aGhPOUpxbk1VZmxrakQxL1J3Q29OYmE3Y2I5eUlGSW43T1VCT21xL2NpdWhB?=
 =?utf-8?B?aVc5Y3pQWmU1eHhaT1R4Z0FjOGIwWGtjZStpSWRZQmJwRkd4VkVOV3ZKY283?=
 =?utf-8?B?cUhYQlQ1eW9Mb283eis0YktCakNkUkVaVGhNbXd1UHd3NGZMbWJKNjR6VnUz?=
 =?utf-8?B?Q2h4OFQ3YjZxNmxBYkkybVoyWVVFajdCeFh4YjlCeHlNZmZrMmw0dXp3R1dC?=
 =?utf-8?B?SlBWelR5ejltNXRUNU56Q0hzQXU3MXI2RjJWdWhaWEw0bGJXYW5Da0FVSW11?=
 =?utf-8?B?OWQ5T3FmdklqVXBjaFBwaGJCb0pqeUcrSUdLY1ZWYWVHTlI4RXVuNEpacHBB?=
 =?utf-8?B?RkRQeElpYTBvRzA4N2VHVGZSRXBDVll4VGhVUXE4RG5HV1hRQmVaNk5XcEpV?=
 =?utf-8?B?NmlQV2RXNURxNFJ0R044d2d0aGtLY1A0MWtvQWtLRnRLbk8wQlA5K1dNVXFp?=
 =?utf-8?B?RG5nd3FCcmhZbmdCMWJUQm95eldsM1BTQVN0b1BvdnJOcjMvV3dWT3dDdllP?=
 =?utf-8?B?TGJhbDVTMjM5Zk5WOFREeTc0cWczdGJjcUxxWVYvTTFvZ1k4dHl0RHk5L0t6?=
 =?utf-8?B?RkY0VitzcGMrS3locEIxSVdmNVpRQ1ExbFZmQnE1NW5OaUZvOWFwa2krblJP?=
 =?utf-8?B?RHN6cmVLZ0xBV2U3d3FQTWk3Z2RiQUF3VUNUbmI3bDRMMU5Wc09aK2FVNHNR?=
 =?utf-8?B?VEYwSWZyYjFldytMMUk5MC90dGZxSWs2SVlxQm9jM0ZhWmN3WnJjVVRlTERN?=
 =?utf-8?B?MlZVajlwcWxZcllMZHZKRVFnbHYwMks2ZExpSWp1SUdaRlhuMXdGaXlROEtq?=
 =?utf-8?B?amRJZTlCY3BCVnNYZmxrZmFWUGpORnMrUTRDTGhsRUNOU2hNWkx6RkZQc25r?=
 =?utf-8?B?U2MzMGNHMjhWTW5aNjFrWHRSSzJPbEpKTUg5U25HS3Z0bFF5ajIvc1lWcTEy?=
 =?utf-8?B?eGRacnNFRVl2MEsyMlRUOXkyWTJZOFAzSklac1NCZllINWVQUEN1bUhsbW1G?=
 =?utf-8?B?TnRBMnpuamRRSDlsN0NUMTdmbC9va1ZFUnJHYVhHTUhHeGFnRjQ4S3JLcHZm?=
 =?utf-8?B?ZEtOdFZyQU12aWM5L2ExSWZHNWNscG16bnFydU9iaUFONVFTa3hDQUVOZ2Vm?=
 =?utf-8?B?QWtIY25vMUM4ZUhkN09CZk53NUJFeFhCZm9JSldZWEQ3QmtQNGxEczQ3Z2cx?=
 =?utf-8?B?UVJhSTYvc0lCNDBnSDVieWIxUmJ0TEl1clB2OWw1aTlieTdUdU1INjZaRGNF?=
 =?utf-8?B?VEVYRHg5bmZ4TWNSTk1BNkYzR0E3dVVHKzA2Y2YvdkVveEhkcDZFUmIwWENH?=
 =?utf-8?B?R1pmaVJxOWpQOVBKYjhRVlFZMHZrZ0w1dHlMMUVocFdQRnlXdUpDNUUxRndr?=
 =?utf-8?B?aXJkS1Z4c2crTHFZUzErMGlQVE1lRmRJU0t3dDBxa0RneXVSeW9OZFRJeElE?=
 =?utf-8?B?bkVEWmxCK0EwbXNZTDR4UGVJNm9mSG44Nm5pdy9RZjY0b0dxTHh6YWptYlE0?=
 =?utf-8?B?VlNRM2pkM00rUXNGSFd6REJvY0ZJVnZqRUxqdlRMczJXVHI1SVNjQ0xkTUNh?=
 =?utf-8?B?aGFwMGxCRWlja1VERVNZSDl0YVJUR1VYd2VFVTdNSE14QWZIK2Z6QUxWYVJM?=
 =?utf-8?B?M2NKRmYzYTVsdXdkc1d4dWdmcTNScFFSVFB5Q2p6NXo3TDJGY0lzRTdlS05i?=
 =?utf-8?B?ck9xYzFYLzZ5cVhFUTl6WUdYc1dCRGFFd3ViRUtZNzgrY3lWak4zWGk2dURW?=
 =?utf-8?B?U1J6V3NBaCtjN2dVNVJ5dTVVQXBNMnNIUDRYSUM2MVJ1amxMM2JzRmR4bUVF?=
 =?utf-8?B?aWx3dUxIaEVocUNIYUNtQXlpOVgxOG5aOC81Y2pLM0FJVE1QUFhHN2VVK2xi?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A2pPm/wXJ/JL55SyI0kr5It3NlqGOmyjI2KJ3aBJE+KbDavDZ+zwHXEpGheRW0wBfD48ZxqYDL/Xw6v8daFQHzORPNPCiDbPA24BKWLesFizq4Z51cuXHYHZs4ll4bVzX/gqSUDmyMtdnU5Tgw37zx+5fTrUWMBXVdzQUc7Xu2ZF0/b+sAPuX1JM9HRI2grLDriz5hBpShTJ/nt1pY1Gnx/vQgd4P7ZXy1ghhwt9ZdOmFg76XPqFFwGbRzjxfT7zPtNBJMaPAD41f1eyS01bBaPsMdm+fJpz9op7ly6B5kqSajpli+1mIV1NIRNE156fK4AY16VWOvP7BF/CXbJDmeQsi2TgQiT69YN9FcfhlTrTdTHfNI/iTIZx4A7H+sBp3rBtKo9vLl6MINynRVyouYb/geR5JSfNXNx8ewY9VQdX65tq1EVv7CFbIW60RR3X4QIwcoxsy6LQmmLBc0A3lh/NcVfbCpnt28go2iYq/52Pz+WNixUZeXHQslc9nDwVC7eJy5JsLalw1f4vk0xw4cHhv36wUIOC/1VC1pp0v0FQZhrofIewIlNk9UXVzGIcgdaREXtPnxNX34VhnkpP4b3U2GrR2rGQXH9t8eg6pDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ec59bf-5224-4171-9ff0-08dd1de14705
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:52:35.4650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Js4/mpG90OdT3a7/iwg1X2so2dJvbsJ5JrJjsRlILf6wgamWuAQnLYfo8U8dBQ9m55knit7xEqkiPNAQNZ2tdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_06,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160124
X-Proofpoint-GUID: _LotHqCrmepK4KsfrPR6pzflDKYD4kY9
X-Proofpoint-ORIG-GUID: _LotHqCrmepK4KsfrPR6pzflDKYD4kY9

On 12/16/24 9:21 AM, Yang Erkun wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> This reverts commit f8c989a0c89a75d30f899a7cabdc14d72522bb8d.

The reverted commit is in v6.13-rc1, looks like. Should I apply 1/5 to
v6.13-rc ?

The remaining patches in this series will need review and testing,
so I would like to reserve them for a later merge window, if that
is OK with you.


> Before this commit, svc_export_put or expkey_put will call path_put with
> sync mode. After this commit, path_put will be called with async mode.
> And this can lead the unexpected results show as follow.
> 
> mkfs.xfs -f /dev/sda
> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
> exportfs -ra
> service nfs-server start
> mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
> mount /dev/sda /mnt/sda
> touch /mnt1/sda/file
> exportfs -r
> umount /mnt/sda # failed unexcepted
> 
> The touch will finally call nfsd_cross_mnt, add refcount to mount, and
> then add cache_head. Before this commit, exportfs -r will call
> cache_flush to cleanup all cache_head, and path_put in
> svc_export_put/expkey_put will be finished with sync mode. So, the
> latter umount will always success. However, after this commit, path_put
> will be called with async mode, the latter umount may failed, and if
> we add some delay, umount will success too. Personally I think this bug
> and should be fixed. We first revert before bugfix patch, and then fix
> the original bug with a different way.
> 
> Fixes: f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   fs/nfsd/export.c | 31 ++++++-------------------------
>   fs/nfsd/export.h |  4 ++--
>   2 files changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index eacafe46e3b6..aa4712362b3b 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -40,24 +40,15 @@
>   #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
>   #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
>   
> -static void expkey_put_work(struct work_struct *work)
> +static void expkey_put(struct kref *ref)
>   {
> -	struct svc_expkey *key =
> -		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
> +	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
>   
>   	if (test_bit(CACHE_VALID, &key->h.flags) &&
>   	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
>   		path_put(&key->ek_path);
>   	auth_domain_put(key->ek_client);
> -	kfree(key);
> -}
> -
> -static void expkey_put(struct kref *ref)
> -{
> -	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
> -
> -	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
> -	queue_rcu_work(system_wq, &key->ek_rcu_work);
> +	kfree_rcu(key, ek_rcu);
>   }
>   
>   static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
> @@ -364,26 +355,16 @@ static void export_stats_destroy(struct export_stats *stats)
>   					    EXP_STATS_COUNTERS_NUM);
>   }
>   
> -static void svc_export_put_work(struct work_struct *work)
> +static void svc_export_put(struct kref *ref)
>   {
> -	struct svc_export *exp =
> -		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
> -
> +	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
>   	path_put(&exp->ex_path);
>   	auth_domain_put(exp->ex_client);
>   	nfsd4_fslocs_free(&exp->ex_fslocs);
>   	export_stats_destroy(exp->ex_stats);
>   	kfree(exp->ex_stats);
>   	kfree(exp->ex_uuid);
> -	kfree(exp);
> -}
> -
> -static void svc_export_put(struct kref *ref)
> -{
> -	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
> -
> -	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
> -	queue_rcu_work(system_wq, &exp->ex_rcu_work);
> +	kfree_rcu(exp, ex_rcu);
>   }
>   
>   static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index 6f2fbaae01fa..4d92b99c1ffd 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -75,7 +75,7 @@ struct svc_export {
>   	u32			ex_layout_types;
>   	struct nfsd4_deviceid_map *ex_devid_map;
>   	struct cache_detail	*cd;
> -	struct rcu_work		ex_rcu_work;
> +	struct rcu_head		ex_rcu;
>   	unsigned long		ex_xprtsec_modes;
>   	struct export_stats	*ex_stats;
>   };
> @@ -92,7 +92,7 @@ struct svc_expkey {
>   	u32			ek_fsid[6];
>   
>   	struct path		ek_path;
> -	struct rcu_work		ek_rcu_work;
> +	struct rcu_head		ek_rcu;
>   };
>   
>   #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))


-- 
Chuck Lever

