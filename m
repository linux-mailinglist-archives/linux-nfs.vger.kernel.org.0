Return-Path: <linux-nfs+bounces-20287-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L5hCixPvGkXwwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20287-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 20:31:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F40C2D1ADD
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02A4A3066BDF
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E918D3191CF;
	Thu, 19 Mar 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mJWAqtjQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="icI5Pp56"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16D1B7F4;
	Thu, 19 Mar 2026 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948712; cv=fail; b=GBFHJykWwXcsp95N+LvQYXYT+UyXCzeHT4gAQip4WvRVTJUrNBS+Jq1fhSLgw4Xl9rtwSYLbz2iGUmZOWLHtMQLKGPUBsoutRXEsfqRJ3rK41a6+SfR6gzipRVcuRr+oljakCn+3X6QpJKvMfx2cojt+Dj6GyZjQ/PD77uiXAIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948712; c=relaxed/simple;
	bh=GlDM/WzZNpxZawOVbE4i5gcbNCqlVhZq8fuAlLjbs1Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dnmM8vfmAFYJU5cXgGBEd53lFArIaGJUxNE123hVeovA8CSCcTX4rNIKORxUL4xeS7imqxbvg07K6YOXqnB2Wkoil1eERynYjogvBHmMgHuD1tF9jX1Bc3s00JzeuF7KLr+VXu3ysgX3+AthqZmGESgEjKXPNNjJdEVutmPQbx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mJWAqtjQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=icI5Pp56; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFxWCd1070934;
	Thu, 19 Mar 2026 19:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=q6xlrZkDKOytw0lkVnegtlTuhmiZAS47M6N65Lw4CrA=; b=
	mJWAqtjQPYTZXTQT263QgcutVi6EQgUaeG+Uabj69P3ciT7DN9tg2XAftmTvEvEb
	WGB3Yfzoq4iOj6pffgUGVioKFr9J4kpcII/DHNqsGlSLm+O3cBg6CKxN4PDlV6LJ
	VQ++1g4uN3KsdzmDgAdPSEJfhPjDw2ymEOUbwo9pgAjy7QvdJ+c1pVqWb4ef1mt0
	2pBF30u45xoN7Nz/cOpPBIY99IeefJsoFUTCdZRAHffPNlqUIJ7S2+CDnw1Hlhhc
	a0ObQQ2rU8ecHMT+BGdcx0VnMBLsQgcPfy5IJb+i9WL1tbSbzsW4QrQaMjTe0m8V
	y9fpc35oT3hGpvAs4DdKjg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x8nm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 19:31:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JI01Y6014031;
	Thu, 19 Mar 2026 19:31:41 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4dau2h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 19:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reXNcEqsQ25CXcggvMXj8eNh+73tbbbh7bMD/9BVbhYFiAtpr+4s1z67Wyq/MT0a9+Cl8IKb8hsiAsbho2av3Vk9ylHlnEmo3kB1cOunEcYBdDzw8xjNgiFljjG1xV4yRGm1FoaY8dXp2Q+PbmK7oCDUUOyzsypvwWlVajirGgPFked2zDHKM6gdd90xGa2RH1nykcU9LypmPCO9HkjSWi603jOLjrtWx7WvrsKIdJ/WCrBo9LNu4pLVHlXRE0kk4F+m9ayZSk+5Q+ve4ABNTbW7oF4BvIjxDw98a9VHtqdUKz0YzG5G4gtnLE8ZAvRbayXQOZclSiNM2/WOjiGtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6xlrZkDKOytw0lkVnegtlTuhmiZAS47M6N65Lw4CrA=;
 b=AkD+E2arFTp0KgcvVy/hRb9PwieznzaQuTkcBpkB/7Ksb6UgLMC5rM2Osx+TMf2PlYN+ZfAh3fKDKBeyEtuGjYJGDY5LIs04mBb8n4SHo/x9T5qz5oeM0OZh9SSpH1cPaXPc/gBeghr3yaPlTgXYzGbWOZT8bet6DBsZEYhbf0rCAKdcENSYkrC2LqTSYPYt1/YTDM48UgkGGHkLccn20SM+vP3+UM7C+zN1VurKA0nBfafXnuy3zozPR3hr1Yw/qzM6QaCLJbDJcbiCFBTv0bYfjmsFoW/9E2akbKUtqGlxyYrvevtBv9DIbENFkRocwCd98mWXm5BNaKVAehBxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6xlrZkDKOytw0lkVnegtlTuhmiZAS47M6N65Lw4CrA=;
 b=icI5Pp56BlWRpRwi2sMAzsCjoKchd+bsQKx0POuT23h/QKXXV5k1yny7vQh8J6KZVqDQvdoKB+rHQeesNrzZWbtIoIoqE/EvMlLTMMZayTGzq+LaVinVruKOvUMNk+UOdbXvwCmXTT8qyZ9hVavYakkFZ8fYhSvF18LB/h2lTtA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DSWPR10MB997803.namprd10.prod.outlook.com (2603:10b6:8:36d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 19:31:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 19:31:37 +0000
Message-ID: <42fa1201-eb78-41c2-b059-d34df26483ff@oracle.com>
Date: Thu, 19 Mar 2026 15:31:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] sunrpc: add a generic netlink family for cache
 upcalls
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-7-6125dc62b955@kernel.org>
 <0fb26335-058a-464f-ab9f-c109658d4358@oracle.com>
 <c314bb03ebcde4ed58c856a91d895570bd37f05e.camel@kernel.org>
 <d1cc129a-fb8a-469e-a7c0-16209df0ebde@oracle.com>
Content-Language: en-US
In-Reply-To: <d1cc129a-fb8a-469e-a7c0-16209df0ebde@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:610:118::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DSWPR10MB997803:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfb0cdb-40d5-4485-2775-08de85ee2365
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 BdbkB7miAeQzWO5bzFHfGzUcgChXkS2x8cLtzsNhnEmIy94GW1II/vwFU2JGIpK6VXqPbNRl3WWIhkHE3fRMRGvH6DQcXv8/Bz2KAyR/21Ajkl/RWmCXdpmtdUJ9ahRM9egj4HFqKziNnaDlxDatXBCT5aQcvZvXNvJfXarxF7zN1Fbd+UtEXmRd/opbEwVNGjtlQAd86cd7IUCg69jEkRVnBR57ZJjBg8xktC2Rk3hA214K5T88Q4tMxUU6PZlZeHThsK5TgjFeMmtVd3k+WbyK5eMUHp6jxekyaWZMC+Ny7fk1AZ0JtXk+S4xAKtVW/YonZKS8xY7HtsgQ2zgFfwpjhSDYkiy1CC/bqn0dV1+U2OReakUkLGRkJdOhaSP8iPt29c9a9v9fYDvF7+sA7/ciTa6jHGsIgg9gXMc2WXuvls/SJKuPMwq2XLtUiy/QOKYtmh54Y1EN/wUFmzhIrxUZTmb0beSxO5K26ITtb70UcNLtkGYkA3w8dVTiBQJ7LGUgIzu0AQ3ff8dEcnY4yjCCiFNC624dpBkZJTfBz8fhXu23AcqNACCVRh4utDsB1P3OWlT7bK6fShTbAWo/a+BYv0LDn1m5kAsJKbz+QcPmOjGc5MFN4cVaHbHCuyZIw4CI1LlEB8X2JqjKn5Q5udfVUZRyPrj0FllNXf8FLll2URPx6UVzz6Z2sYRawzNmLTZGYCVp6Cqbf58MeVtmDE3VXQjK5zWyj8tamzu9o2s=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y2RPQ2hZZytDbzg0K2tJWGMyOXBMYXRWVU9UOHBUUHlsanRxRzEyRno4M1Ro?=
 =?utf-8?B?dDRBb0ZlRmFWMlozU0ZmWDRKM25WbkxKMGFVZ2o0T2p1T0VYUm5wUU5LOThx?=
 =?utf-8?B?aVNGS2xrckM3K2s0WnYwc2V5YjlvNHladGRxcmQ1YVZvb3VSYlJrRUVGYjJt?=
 =?utf-8?B?emsremNCMnN2dzkzZG1QRVdHRjJlNC9KMmFIVEk4MC9hVHlSL1YxQmZCNnJQ?=
 =?utf-8?B?RXBTNjl2Unh3V3A1WjgwUnJhbURtcCt4dWJlWURUcWhzNEV6ZkY0VjdCNXZD?=
 =?utf-8?B?ZWxPWE5jcEpLYy9yczZSSzljZ2pjTDhUU0t4dkQ3T3hQYnBnSUJBclVuSzVh?=
 =?utf-8?B?L1BYVER4UGhLM0NvdWlxcXdsUzRSWTZscmtHRC93QUV2QUZ0QjJDa0hxeFp0?=
 =?utf-8?B?bXBhV1I4WmZ1My9xLzdkZDM5SjJsd0FZOWdlMm1YcmRLNTdWdzNKUVhDQm1O?=
 =?utf-8?B?djVodm11Y2l2bnc2eFVnNlRXR09vMW1Nem9ncjRnYVY5UkdDVHEyQnV4OVZw?=
 =?utf-8?B?eFN3ZjJUdjAvdXBXUHBQQlp5REpMR25TN2VQTEEyYy9NeUg5c0NXL0Y1VVBI?=
 =?utf-8?B?MkJIME1hUmphWHlYdVE5MUtDbkNZSThZYUFPUC8vSHNDN2JOOW9RMWtJSFR1?=
 =?utf-8?B?TUExK0xJRUdYSmpjVU1xdzEwYitoTVpaR1kxbUpJTXFONmdseGVsVW0xbGRS?=
 =?utf-8?B?OUt1c0RhWkE4V1BtaUw4NEZnanU3ZEpQUVViOHQ1SlhSd0F1S3VpdllraVgz?=
 =?utf-8?B?L24rUFpNdHdxRDdNUmdTWFcrM2VnVVZNV0JHK1drL0xOdjBvbTRrVkFiVktE?=
 =?utf-8?B?RXRuUlYrTHJ0Tkh0OWRqYkZxbGwwRWhidjMvUHgrc3JNdm5zU2JCTUJ0MGJL?=
 =?utf-8?B?V3N0NEgwUDZLZzdnMVMzOFpyNVhVNVc2KzlTeEhha3J3N1dXVk5OMEtsZGZh?=
 =?utf-8?B?YkYydlFyUndkNG16TXI4VFRpQ2ZkaUZwZWlwQ3lBUGpqenoyU3UrRDhJM2ZY?=
 =?utf-8?B?Njl5RW0xTi9FSElGUEZhS1htSFBlK0dXOTFwNzBDZmJzR2M5RVltY21ERlhk?=
 =?utf-8?B?STZ2YVNOL2ZjNVRLbHdpRTBiV1BrZDBvSjhFS1BKdlZPeTZ4YXN2VU9NY2lz?=
 =?utf-8?B?RDAxYThrU3ZJMHZPR1pna09WVE9RMXFUNkJnRjdTTWd2c3RSOVl2bjlqMTV6?=
 =?utf-8?B?R015Wmt3UUxmWCtOMlR6UldlOWlTcnpmRnBCMWt2Y3UxMFIxakx6bWpjL25z?=
 =?utf-8?B?cWlOc2lqNjVmODAwYlJ5STdDaWlveEtNNU1DZnluOFkwK3d4ekl0T2NBc0hm?=
 =?utf-8?B?M0N4UU1yMzBVVHkvc3ZlQ0c2L08wYWxRMTZQOWNrYVQyN2JyVDMrVzErODhH?=
 =?utf-8?B?UGFHbGVEWmFvVVJBbElPcUpwOGRHejg1VlZIZnJKWkV6TmxLaWtWblh2T3Zw?=
 =?utf-8?B?aFQxSzhOUFI0bVVxSHNPV3pzcXBaYzU2bDhFLzRIZFVaN0phV21RWG1td09j?=
 =?utf-8?B?V1ozRy9xYUN6WHFDUEQ5TlpyZXowdlBmbVlBT3hDbGRZTjk1Zk1SK2VMc2or?=
 =?utf-8?B?V0pnNGJua3FFYmsrY1F4R2d0ZUtZcjlIME5TZkU3V3NWRkVSWHBqVEVmS0pN?=
 =?utf-8?B?TXA2Q0R4WFlFNU9SZERRWVZaRTdmUXVWSW5QakRNOUNIVCtjeWNXTVhnTWNw?=
 =?utf-8?B?L1pIZkhnWFpCMVdFLzhDR3NqS1htRmNuZ3UraFNjU25JbVl4U09qR1orTTd5?=
 =?utf-8?B?ODU1TGE1em1SYmEvMnZQVGtYZ3g3K2l2VTV3WC9ZWFROdVJhZXo0cU5lQnhB?=
 =?utf-8?B?N2FBV0YzMzBpUkdnUWNHSk5Ud0Y3SEpFZldNTmJ3cHpvVUpDd3RaUk5Xa2Fu?=
 =?utf-8?B?N1RvcWdvdGhSdHp5UXJoSTFVNGRUSmdFbUJ3SjNEZDJQTEovQ2lEWFhWR2lT?=
 =?utf-8?B?M2tqTTN3ZzBBY1hDdE04clFYSkVwd2ZDZWpPd1JON3N2dmVPWHpxNjNCV0dv?=
 =?utf-8?B?Mm9BOXAyYUY1SlhqOXRCY0EvT2prZExTWjlJYU5RMkpyZUZ2QmozQlE1bGV4?=
 =?utf-8?B?eU5JVmRrZWczODF4NC85YkNNbnFmQUF4N1NIb2ZPeWtoemdmbUE0NUdrYW12?=
 =?utf-8?B?L0YyOVZrNlhCOW5RdXRuMVlDWERYS3lnbjlXRkRUVDJJazhtWG9aQW52NWl5?=
 =?utf-8?B?TWd2cEVpN2p5amIzTWs0cXpVSFV0aTdBUEhDOG5TdHJJQnQxT0lESHhDcVYw?=
 =?utf-8?B?d0RIUURCWlB5QTFYL2JOWGFybmJYTzNBS1pRZWQxay9QYUxaWlhKUXo0aE9x?=
 =?utf-8?B?MXNlUGhCR2dHSCtRTElCdVNCckcydW1QUjdFRHlqenRxYnliZXRBQT09?=
X-Exchange-RoutingPolicyChecked:
	rNhj+d8kp/F9+WIwb9Ujg7TMLgSHMGjKA2aD8UdRe4hPQ1zoTq/q45ljJ/x2ZKMZZqPamgnl9rokYxe3LBToJjToWhcrhyyHftphqlDAX+U14OwKi92RK4lYwrrLpadixHduPzY6LD+9imyHJKrf5v468+xwXHstESvXW732doEGJXskcrjl9UbSAgK+XADL47YuH7XtUUYokpmnUIoRS17zIK7I9ZcAyBTn/2LpqTu+1uKLFBNHTNRPSNJAixyYmlmLpfdajyI+rrQQ4AdyqomTaNgsMwd+ZhKQ0AXsPPPmnvHxux3mGQkFPbPuM/grP9x6RRHCG8FIgKWJMySOsQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U6fg98WMvfKdexHHPuGVo6LHwsWY8EGcoaozXJFK8oXIkZ2Cl39KPedPcWw/MgSPWvdiqap44U1de+ullNrpJZwdaEhSleLP68dOtsKAO6WasRUQtAO+dcg6cOqghtoH6kqvCb2NJuPq8hIp33uJIo4v5M/ACXENgeH1Fp9u0YHScwKgfjImCvq/7mIAw9UDKYKwXHjFkjlNjvFko8lGZqqJ/cQSoWvWPui+tONW6ixUI8i5B+i5yrx8Y/R40Y2vssItIPhCQ5uVLodZuuP8ia9YvP386ib9UDEhRLFbjxA5SmjznpuK3ZUycp1fzH82E7XFciz2bdOb+AnogNOp/ohUGV3CUolN26Qd0ddXi3AwECjJ2sOWoZdpHacXIt3iv1E9CBtvZK40ti90GteAUSF3NpqASWqu2P2b+DkUtYEVCc3L3fFvapWKtIUDhq8rq2QiEp6JOTZKk0dhh0OJ4sMAP+xIbU0TNEtrP5APIFx8sjZ04yMfLnnZsAcUXIygcyTp4Ff3SgeWxXQRI+IMBIwpdMAUyJ/0aKCt0xFG4h/IT3A/L2/Okh+NqLtOn1GKIP0roAXUad+NuIIesjAiA1Yl5kEI4G/diHxfbPTxDv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfb0cdb-40d5-4485-2775-08de85ee2365
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:31:37.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX/N+LxTZ0u9afV13EoQoslZTyV8TnZ2F1MOT6AglEl7UXG67a8j9KPhSgIJ3/Vz4cYDdKKBVtiIYGQgGJqclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603190156
X-Proofpoint-GUID: KT_XWN97f2j_gYDfloVBI6-2uSgfCecZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1NiBTYWx0ZWRfX6qyUPSPLs6Fw
 bzvExXvqeMJaMS/60VEmHBPk9g2TisijxhBlRCShHfZzXjQXSfZk+DycKSzf/ZHrn0gzBErrTN/
 EE7gZ5uQeHx3T/Z5Q0voP9YlBbGmD6j23p6bvFnHvmwUr8pPoGGUkJqzvBXCfSQLvi1fCKWoEsr
 kXez7LM9YQCuG0vlUgqCDcGiLc88xOSK5gRJxKy0K9jBawcP5HgJLZctgTRweKrHSNoOnGj2dHD
 hmPlwz22m33dLUjUhEgYTtmU6tE5Pm/knSdTj1QBbYE2KrNl8tcAK5YzPQr+/JCa7uFHXJm+ol7
 aJc1oVLy/FGzmxdqUfwdZBrGiC8VWjYuflX/ieEsKKj4YfnDI0M+E84RriKQBGyfz6gIY/72Gvs
 NWMYCzrquxLGQAww+wJeozaC9ovVj5Q8//HaFDvJ5zHV5A4lo21tDesidVDmklXNoTS/OUiZnKT
 iRoub0cXQhjI2PYF6NA==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69bc4f1e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=IFH4CkcThOHfYDDguEYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KT_XWN97f2j_gYDfloVBI6-2uSgfCecZ
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20287-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7F40C2D1ADD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 3:20 PM, Chuck Lever wrote:
> On 3/19/26 3:19 PM, Jeff Layton wrote:
>> On Thu, 2026-03-19 at 15:14 -0400, Chuck Lever wrote:
>>> On 3/16/26 11:14 AM, Jeff Layton wrote:
>>>
>>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>>> index 4e08c1a6b3943cda5b44c2b64bcf3a00173a08db..81c943345d13db849483bf0d6773458115ff0134 100644
>>>> --- a/fs/nfsd/netlink.c
>>>> +++ b/fs/nfsd/netlink.c
>>>> @@ -59,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>>>>  		.cmd		= NFSD_CMD_THREADS_SET,
>>>>  		.doit		= nfsd_nl_threads_set_doit,
>>>>  		.policy		= nfsd_threads_set_nl_policy,
>>>> -		.maxattr	= NFSD_A_SERVER_MAX,
>>>> +		.maxattr	= NFSD_A_SERVER_FH_KEY,
>>>>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>  	},
>>>>  	{
>>>
>>> This hunk is clearly not related to adding "a generic netlink family for
>>> cache upcalls". Should I apply it instead to the appropriate FH-signing
>>> patch, which is still in my nfsd-testing branch?
>>>
>>
>> I noticed that too. I think this is due to a change in the ynl tool.
>> The new way seems more correct since the "*_MAX" value is fluid.
>>
>> If you wanted, we could just regenerate the files with the new tool and
>> commit those changes first and then layer the new stuff on top.
> 
> I checked the tool, it hasn't changed.
I think "NFSD: Add a key for signing filehandles" introduced this
anomaly, so I've gone back to that patch and re-ran the tool. This was
the only change that was generated, so I applied it and pushed it to
nfsd-testing.


-- 
Chuck Lever

