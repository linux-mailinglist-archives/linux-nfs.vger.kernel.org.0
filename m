Return-Path: <linux-nfs+bounces-7740-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5609C08F6
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2024 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F49B1F24310
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2024 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4A21265B;
	Thu,  7 Nov 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kB1lgsu4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F102L+0z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6639C20FAB0
	for <linux-nfs@vger.kernel.org>; Thu,  7 Nov 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989985; cv=fail; b=JAd6S3N7K+dp5HYaby+Hrf9B9PCtT1yxNTGTpqCqfr4OKt7kjXaqnb0Pqlk2amPsLt2jS/NhsyzBImndAO4qeYcvzoiFk+pOeDFaJiQ4rRWnLuSknruzTnNDHx9wqJ+cJbeaekNVSKPiOSS0+43Hbcl/P9lA0fwLvUYLbY7d6CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989985; c=relaxed/simple;
	bh=Ay30VHOVKzCBKd2P31Oi6wDNe6mIdMc+iS3rQeN1/6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hfZU2+xnloFSrd0ymzOzMWwzAKcMCCKkkqQv2Bxd0c90D7ZyW6jb+mhFtvWCXB1Zad2qCpluK243GHLNTcK3sm/KQePlleki/1BQ9ZN5Y3gMB6dWxcnPR1HaJEHdLRCcJ/byQ6YSWfuFMOs/XOe4F+5089EeD9c4S7fJDfvZg1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kB1lgsu4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F102L+0z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7D0wTX022083;
	Thu, 7 Nov 2024 14:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vejgLXMxc80uvrf8oU87jHBuhzjQG+W2rHuNzyzvDJ0=; b=
	kB1lgsu4QZO5RKl0DdZ7Eu9G34Gs3LIsfWYy8V+QtmUEZifTK3cGpNm4W30yyIM7
	qSuuqPc6LfQ5U1Dr/BXmITl2+82lxzNOI0kjSjzdN9SwRVK4qWydbsRy3u19caHP
	1108/MXtcpUvBzBoBHA3/NSZ+VEK2AvrsEFfpWqjjI2qMDno7QNld72Ce1QPpBtE
	Z6APKs9Rn0d0Fdmwp0JmdTwHh10yx3vUYV5Jg23U7bwHMVZF0c3wMHU6jovD9Rgm
	plBoblJDSnSsUGCqNb1FE9BIdeSZJ3AXwbeVDNcJDatEMXzbKYWJkSxoH4Q00Tzx
	ykihYyoPuJbHtIWapuF6rQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpstm18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 14:32:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7E8GmC036767;
	Thu, 7 Nov 2024 14:32:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42naha6juv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 14:32:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaRymyMGjACuJyKBrtqCcJr68VbNvivCTouAvThvAnZtENqbcOeHQzQR2Btf1ULow/1ovjqU2QjU/piLhOt4b63MDTFC9vlSwifTc2kCT4FY+l0nbyOYpBnequlKxynYVJ3FlWUV2+zyHwHtelHS2T71q2bqavF7b16iG6hBSNFDyt5uit6Y5cxwVnZ4mycvb8lnQM0Y3SctNSSjA9O7DQdgQrCcDUaVqMJcbLd8wd7e50VNcQYxxPD/by+Jn0lMxk1iGZ/qscfNI70kSxGISqlTlyQo1KW7zvUXRRtErRtO+Iw55LH1WaqS0vGuBbUlntVioVbTtfky7GLw4gZhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vejgLXMxc80uvrf8oU87jHBuhzjQG+W2rHuNzyzvDJ0=;
 b=xN91c8vKmg78LG+3GjwAZvKMvyQuf3aG6UqPH42W2z6I6ApjA6RXG44u7rdYw2bT5wcQa4HxK29Y5u3HbVl61hxmq1LSJqgZJHkY/CAEz3+UAITxVSVjgvAz/+fsgaXi9U6zV3zkHpYt3EDemn36hpSsKiFU6gompGTIjAfRUE9bg8qx1n/tyNBgQ+r35jcfcWREoUEFY/Eq1WOWdS3LgE1syBQi26Cy1Uv6uAJ/nacCd7kMxNFkzs1DkQYPToA8/pbY7U3hSeMMa5pG8LbCdbaPSRhGYpV/vImgWQO92vpu8qiPeTZdkx+j0/7VMCHBlqcldbKPn0aPdRW5lApytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vejgLXMxc80uvrf8oU87jHBuhzjQG+W2rHuNzyzvDJ0=;
 b=F102L+0zByzbwuUjtyiF5LYdEPu9gr9dpLGgTWeOzZR/hD5MWD6aswJu+qW5ZjhcrNLP0AnWtZyDDaf3k6QUXb/PbGvp7MFLRz9LsdxTmy0wfycCVde5Nf3n6UC3yfXrkc0jCOHkASkwv7ALxTYehlP91rHQ7/Zjd2NcW6L5LcM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6238.namprd10.prod.outlook.com (2603:10b6:930:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 14:32:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 14:32:25 +0000
Date: Thu, 7 Nov 2024 09:32:22 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trondmy@kernel.org, linux-nfs@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3] nfsd: fix nfs4_openowner leak when concurrent
 nfsd4_open occur
Message-ID: <ZyzPdsmYTMx+iT48@tissot.1015granger.net>
References: <20241105110314.2122967-1-yangerkun@huaweicloud.com>
 <Zytwhv08T2lKhGwv@tissot.1015granger.net>
 <101f5657-99d7-1813-05d4-7829c48f9865@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <101f5657-99d7-1813-05d4-7829c48f9865@huaweicloud.com>
X-ClientProxiedBy: CH0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ff17b8-8187-4760-24b8-08dcff38ffe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0tlMk9nZXppZDlneTU1RS96WXlIVnZZWjYzT0VqYnl4TFF4cjQ4QnZjMElM?=
 =?utf-8?B?SEZlUlZQR09sdWpNU2FuNTcvQmJKcGIzaVl4anovYmcrVld4T1phb1FScXZJ?=
 =?utf-8?B?cER6WlVKUkQxTmJnOXJpbUVCaEswckIvakZQU3F4Y0VOTzJ6Mk5aWE9IcS9h?=
 =?utf-8?B?T08ycldDWjVuR2xybHNNTHc1T1cySUpqNU81bERRaGNWdXVYaVU4K1l3OHVw?=
 =?utf-8?B?c1l5MVllNE03MzVhdmNLem5teFR3MzZ5NGFVMGFucnI1YWhDdENkQ0UvbFRn?=
 =?utf-8?B?MXJwaGVad1BFY2Q3NkMxWlczcWNIZE40ZldTcDBvck5OclI5eUlFS3czNy9O?=
 =?utf-8?B?NUMycU16bUZqQTNidnBvWkVxVUxRdW55c0NFcm93b0NhY01kZmZOM0t0QVl5?=
 =?utf-8?B?UXI5dk1oY09wSGdoSitZN2s3OTU1WE4vU2VaK3c0SkErNkdpYmxKQmhWaDNP?=
 =?utf-8?B?NW1YNi9lUWNZKzZINHVkN0FLWS96NHBOczl0YUl4VjJFQ21ySW16WDdreUFk?=
 =?utf-8?B?YjlWWVdXekhDTGJZSDZnemtjOG1kNURITm5BVzVneGRHUWtCblFVY0hsWTdx?=
 =?utf-8?B?Q2tEVUI4VkhWS25ZVVdjSDVIS3YrNGFOMURvcjRwN3R5SXRkOHZVTkRwMStq?=
 =?utf-8?B?ZjNQRWc1Ui8vZlQyczlOTllxelJyMlRrZ3JKRjZtZHVjT3RRbk4xMVJaN25i?=
 =?utf-8?B?aSt4c0RjSGcrSzkxcklqZXExaU82d3puSDdRRUgxQnplZFM0RklFYXVQSUJx?=
 =?utf-8?B?Qkk1cU1rVW83eW1PRkwwMjhYcjdmR282TktCZVplYjdFdEh5TEFFVWtVOEFI?=
 =?utf-8?B?QWw1dG1LSEoyNzJHUWFKZC9Pb1VIWmk3REFHMU1yLzI1MmIvdlJDTFRtMlBs?=
 =?utf-8?B?M2RsT2RHUVRsQmFhUVRMR3c5U2JZdlhFdFFPQzBtRGU4U09jTElZMnp0UUlu?=
 =?utf-8?B?a2FjNnc1bUlySFd3QTdjQ3g3TStKYVJWaytEWjVmTzNOdzBwMTJBWDhxVHZx?=
 =?utf-8?B?eXdiRG9BN0VMYmh4VDJaUzhaQkpLdzJpRHA5dUx4RUFUQ09OY04yR2x4ckVy?=
 =?utf-8?B?SWhkOThkY24rcy8vcjAvcjN0Z2JsdVdWRi9oaXJHaE5ERUFmeUI3NGhIN1Vw?=
 =?utf-8?B?NEV0ejFpOUErUStUZVl2YWpzTmRnNE92WVhEOUQ1bm1ZbC9UMEhlUWMrb1Zj?=
 =?utf-8?B?d3YxcTNnVjFJRFo5T2QvaGNIT2ZlWFBKNVVXYTZiTjRTRVk5QmM2ZG5qRU1a?=
 =?utf-8?B?SWM2TmhxWU9PMUNwalRLQ0o3eVN6MUkzQTJoRkhrL1dEU09IZFNnQnRldjVM?=
 =?utf-8?B?LzBsUFM2dnRIVklCV2t5MXJiK2FJTE40MFRsa3cxbVBoM0ZERWtmeEROcTdJ?=
 =?utf-8?B?NkN1NnN6ZnA1Wlo2YVNuYzcwdmp2NXpSUnlONHQzc3VGY3htbHdkazFuTFN0?=
 =?utf-8?B?VytSVmhkTTVjMy9hU0g2b1JQTHU2bHRucmwxWHJBckRDaG10VG1mSHBvZ3FZ?=
 =?utf-8?B?dndXb2dWRmtzUTRCVjY0WHRLaUVQT2FxSG1aZEpHSkcySDBQS1R5ZHc0ZWFI?=
 =?utf-8?B?QmR2ZVNtQUtJa1E4ajZ5WUVVcU0wM1RYdEdVc1drT2VIcjVSV0kwMzE4eFVw?=
 =?utf-8?B?eGR2WDhubENDcFFLakM4MW5yYkVhVlROUGlNajJ3eTNTV1dKUjVhU1J6aGYv?=
 =?utf-8?B?NC96cDYzTCtLVk1GZlFpOXpKV3kvUTNpaU92RFpYbDJrYm40OUgyRWRBeU9T?=
 =?utf-8?Q?MRFMj4t4aDWkZ8wYHbK6Tb/WZDuvCiWmFcmjeXE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkJ2ZmhQb1FYanlNNkduS0N3ZEFTcEdKNmgwNXBmUGZNREk3S2Nkbzljb0da?=
 =?utf-8?B?ZnJpMVpwT1dPQ1BwVjZ2R1h0MFBFOWFabTdrT2d3dnNycW11V01XdHNINTFJ?=
 =?utf-8?B?bWlKN3AydlFwK2FNK0sybFY1TFpBeDRpbml1SDl5R1VYdjZIYkk2eHdSUDh1?=
 =?utf-8?B?eTBWODh5ZHQ4b29IcGlGQzdVKzJWS3o1V3lCbzM1Qk9BbzZqYmVqRVppYThM?=
 =?utf-8?B?MDUveEdFbUt1RUZUV0ZEZWk2ZVAwSi9DRjBuWXJpZU1vRmlmbWZNMEVGVDhj?=
 =?utf-8?B?TGw1QWVWekNLc09wUFhrenVoUnBWblpROEpjRFI4OGtUeisyUmxpTkJ1UHNM?=
 =?utf-8?B?eTVLc2IybU56R3FjbE5kYUhZUDFpaC9Tb1h3QjNidlVEakdGS0kzd3E2K1hh?=
 =?utf-8?B?ZjdVd0xxbktMZ0RBT2dUdThLYUErVTJvaFBlbkxSZTJ3VEMrNnRSWkJSaTNY?=
 =?utf-8?B?N1FlNG1RVXpqQk5lWE1rT3VhT1JCQnc1Y0ZFUW1zQmxJQ0dHd0VVWUlhbm81?=
 =?utf-8?B?di9MamZlY0tFUVU0S3p3MkFCTEtOemZMSHpPdWhEQzExM2tCbXJUNWtlZlUv?=
 =?utf-8?B?cHBqcjMxQ2xNY096d0c0c2hEbm52bi9sSzd3MXU1UTZRMENQNVpFS1Q1Ryt0?=
 =?utf-8?B?d2lSV3o3Z0VXSDROUEtQbm8rTUFPcHlaM0grcERxWjN5OGwxb0p5SVEvNCt6?=
 =?utf-8?B?R09ZNEUyTk5WQW12NWZMN3JaellMcmVSR3JDb2NVM3U1RUxpdlZwNytKeERY?=
 =?utf-8?B?dkx0NFJ3bXozeXBONGN5NURDRTVGMTdSd1Z1d2NhQmpHVUNiOVcybGlKR3pO?=
 =?utf-8?B?UEhhYUo2Z1RYU2N3TUtnR2JNZVNwSko1bUhiRFJkRHFKd0tLOENxQ0wyUFI1?=
 =?utf-8?B?cUNRd0VOYWRHTTlSazhmVDNUNFFDNWRJcEoyUG5iVTVkUUVlR1A1U2hVR0F1?=
 =?utf-8?B?TE5NZFRIZitJQm9oYzUrcW5GN2V2L1AvZi95bHdLRTBtNmNDbEh6WHJOcURi?=
 =?utf-8?B?VSswL25KY0pSR3B5UVBHd0F2Y25lenFtWmxtMWJhaWZ6U3dIOWpOZis2Q2ts?=
 =?utf-8?B?dUpHYTJOUjdXcVRQUnZNZ0lCdFczaTk4WmV6aWN2Q3kwdFN5SDFRSkxzVE1P?=
 =?utf-8?B?MnpueUhYeUZWK29QTnpyMWFiV2VrbUJlMVBVREJyMENQVVVvUTBTUEg4amM3?=
 =?utf-8?B?bjRFMExWZnRYUjR3M21jeEFRcDV4RzBvQXJ6aHZkbFpFWUU2MHhPMFYrYStp?=
 =?utf-8?B?dzAxS1dhaFRDN3owM29BRlAvTCtPVlFqZWo5ODZIYURPbDkrY0E2SzBiUTQ3?=
 =?utf-8?B?Y29ueEpDSWFJMXNrMzVVakxZeCtIdFhlWm1sdllnM2dFQU9QU2s1cG8xamFT?=
 =?utf-8?B?U1RNWjRsR0QxZHYxSi9ONlUwZjc3UVowV3BPbDBvY2IweUZ2K04ybFFyNUxK?=
 =?utf-8?B?N01pMW1LTlA5M0Z4aUFWck0wZDFFMjMxWEpFZnpIMURmc2FRNG1qZzNsYWE0?=
 =?utf-8?B?bjJQM3c1WDc4NzV3VjNCT2ZBWlYxNk9hSStWYitiditQZTBKa0RSbGNjSktU?=
 =?utf-8?B?dHBWU21xNFhQYVBmTDhCUGtSNUJOVzJKWm5sVGpsY3hKS1Bvb200NGlvOHpp?=
 =?utf-8?B?eVpMM3h0cUZpcldpZ0dkcDQyNXVqS1J4NUE3NnllNDhxeG5qaUZLR0QzdXdX?=
 =?utf-8?B?enR0b3p0alZObXhaOGFUcGNXenNtNHdDaEtiRnJCWE5qU2ZXRFlFSEZEcmFv?=
 =?utf-8?B?SEFvUC9hanlIUnpqUmxKQ0pkZ0hQd0VUdlFLOVkxd0hscW1WSzZCTXo1cFo0?=
 =?utf-8?B?K3ZROW9veHhpRFFQVTIxTldIMm1QK2xZWGpZMndxcnlPOVZuOFdrY0xYeXFQ?=
 =?utf-8?B?UUpWV2g1QjdoSjVzN21KUHpPbjhUbkFta2RkeHFkSHl2M1lUalNkaUFxaUE0?=
 =?utf-8?B?b2RvQXhkMTBKRVNNMlBlcGZZYVZCZTBicVBkcHd0dUJ5a2NEdkJvT1ByR3hs?=
 =?utf-8?B?bFFCY1pjTVJmVnBtQWp6NjFzcVUvQkpiUDNxVFp3dzlCSjJ4M1JZUzI2elRs?=
 =?utf-8?B?V051V0JxTU9hWldaSmEzcGV2UTZQN3RnSnVnL0JqZEdnampCR3FMeUZYOUxH?=
 =?utf-8?Q?v1xrfYKWrLWV5lflo+Hlcyiaj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Dw/9kV2usFN/2evljhyslhwNMDxdMfPzmi1nhXzM3U/Zmyesno+dEHyA7sLF2gbf4Gn1RqSoZJsNW5xWR/pXuSaXQ5qSoz1VcOuvGI6dYq9bvZ3EHV6Plz228Ls2hb87bpixglozTLe1Npp8Rfz2BaApKSq63bq5pQ6NxyIM+dJ45gV/vYUCTx7ntlBtzpVbAYdVVhqw9SmQBhytjjl3smrHzjRSL8+egQBIJn7I7bq6GccPlqLpeq/9rUO8iDOXxVTyeiFJuoNPvOXHnGg/0B2DEj0nDw1WZ3Qalx7oyTPqXXDNwxDRG5u68EDSfRyxYdDRi4uOVeLIBvgEDxyqiFsl6SzJ1fwPyM3nz/vdpvCuduYwHYyGoGItVoVJStWPe2BjUXkuWDWE5aECQxAZCPyEfP+uYLj+oIPuXlrD8267ggSMWe10eTFeW14To9PqDIVcq6ff46ioTeq6ivHMxNNAIdwdfH7i8iDTiOG29DGxlm7bSBEa7a3e1Gxk/yh4rQZSXIbGebR36Ioi09AjM14motTDXpjbH+zFbqjPwjwpUg1pOmVL+HrLyxrNe/h3uhBCVgDEowW7xPHI1BUiiI4EgnnwD8UGtEwoUqSZHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ff17b8-8187-4760-24b8-08dcff38ffe6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:32:25.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl6JkNW7skNMx5ZmAMeCPS3fAy+/6CPGw2mrWgjAUiPTX4zR+gsf6Gq2PcjZ8gDCOCFGebX2SBlu6oH3luwLmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_05,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=977
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070113
X-Proofpoint-ORIG-GUID: LjB5GRIStnZJq-jvSHFlTCN3LFXUoHOa
X-Proofpoint-GUID: LjB5GRIStnZJq-jvSHFlTCN3LFXUoHOa

On Thu, Nov 07, 2024 at 09:22:39AM +0800, yangerkun wrote:
> 
> 
> 在 2024/11/6 21:35, Chuck Lever 写道:
> > On Tue, Nov 05, 2024 at 07:03:14PM +0800, Yang Erkun wrote:
> > > From: Yang Erkun <yangerkun@huawei.com>

> > > Add nfs4_openowner_unhashed to help found unhashed nfs4_openowner, and
> > > break nfsd4_open process to fix this problem.
> > > 
> > > Cc: stable@vger.kernel.org # 2.6
> > 
> > Hi -
> > 
> > Questions about the "stable@" tag:
> > 
> >   - You refer above to a leak of nfsd_file objects, but the nfsd_file
> >     cache was added in v5.4. Any thoughts about what might be leaked,
> >     if anything, in kernels earlier than v5.4?
> 
> From the above analysis, actually openowner is leaked, and all object
> associated with it has been leaked too, include nfsd_file, and openowner
> seems already been there since 2.6....

Before v5.4, openowners are leaked. After, openowners and nfsd_file
objects are leaked. Got it.


> >   - Have you tried applying this patch to LTS kernels?
> 
> I have not try to apply this to LTS, what I think is all kernel after 2.6
> has this bug...

Understood.

Is "2.6" a guess, or do you know of a specific kernel version where
this problem started to appear? Generally if a problem goes back far
enough or there isn't sufficient evidence about where the problem
started, we don't want a "# xx.yy" annotation.

I expect the stable folks will pull this fix into LTS kernels
automatically, and I have nightly CI running on all of those. That
can catch problems with applying recent fixes to old code bases, but
it ain't perfect.


-- 
Chuck Lever

