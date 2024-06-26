Return-Path: <linux-nfs+bounces-4318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A159184E7
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B531F22EE3
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44FF1755A;
	Wed, 26 Jun 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dHgt28WO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PHHUbf7n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051A316B38F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413585; cv=fail; b=aJdZsV5h8lWmP/9ugw49XmjVdTgHpKk93c91i7J7oJxOIT4v4iBbGq6YKqvv5Y87/oH3qxZ8jNjhJLJqtl3/ppIx3i//tFL3k2yUwMsP5t1PN1iLK6I1o/CdkcpPyFncIvDbO+KgWPC6E21q+fQ5+E9zK8o1oyzC9TRin287msc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413585; c=relaxed/simple;
	bh=oip5+6MjGjbAzJSQKEP4Ab8ksxdlBgFzrf9dsA8/3hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OMvbWjnizD/eky1MN/hKTbZt5HsEbEcbGWfXergtTbLIuUZdWmxAZTvpGZUrXzYEm+qFfqLT2fbcb4HLBwfJCaQi3pRMi31lzKcWu5ivHM/Qererv9k0mJN5dTscGb/DWJ39k3Wqpn6kuz6a5Zn8tlUwZtBELG5CcNrbHDttsJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dHgt28WO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PHHUbf7n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sIcU002156;
	Wed, 26 Jun 2024 14:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=s3f1S3CqXr6krAw
	kwA0PRqAB3L5EIroRA0rMl40Lfag=; b=dHgt28WOJXV6EpiX+J2lll2jUzJh95s
	pPCEEN9E/QZ+KFYoEG4i7hY6wM/B7syzp0tMHRkUo6ycjMVHTT8e8ppXZP799Qxc
	MAdIC+4Khn/ZfOzOA+vufjQXeDi1r1/Pe5p7b6Oo5bC+T6RgFGaOqDoUPdTpNdaB
	eH3B89GpmXY+Y2fujICy8FtdkTiL8IgQl5JEOUSYNoMrWLfD5t2BnZn8sJN2EAoY
	NIiEsjeMta97+U+aTqOuHcDV01f9OmKgQ5aw73hhPbYa4JMxrA2z2OxvrKSzU6O6
	wLlQ6co2LqaJTfsgMt5GrnhhNCYsTBowG3MXiZSzefJTofBsU/tYCiQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t3k4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 14:52:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QDLisa010762;
	Wed, 26 Jun 2024 14:52:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fnbb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 14:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdVJjUbxCGUrSwL5+S6mBrIhsIioiXqsQdDysQ620eztEtZZLuYvz6oGy7Y7ZKwbjlFMhEZmXvUoIp5s0pGo3ZSTIyAmNRE63AzHz5eDFTQtdljX2fwsRi4khpv6Y9tFAg5jkcfi7eHUBT0sPFDaZIt/kcBePkYm+2jv0t8gMfROZrHqR8dzUw1xc03Sk12H0nuyEcON5dGmZycn1m36qw4c5okHzTmVoGYh1DqQuLuuxLfmOsNxpxcjTGSH5zk9puBlUhqui1MJY7xGMdntIXNV8pjiPfPxQSZ/cA5poi9SBnhWRsOz5ekL84B/RkTXJskI8Nf+7K5zdqLEq676qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3f1S3CqXr6krAwkwA0PRqAB3L5EIroRA0rMl40Lfag=;
 b=i7zKvAQOpAV37oxHQiIVNTsWb7aKsiYHT4Kl7/IGnzgFre1iFLAt4cllJdNudjd8oOz1XP2rZq5KS+G3jT2hRu3KO4hsc6b5iuz82ce4Vicd6q5neJ9Igz6iuBTZDUBHFMUSOn7Vm+FQvRkW91/DLTYEKQg95k7ME62WIr3lrTZbBerlZDJqCNwc9rRl99VwwvZMAZnvbr1Pvj4NtCATQcVBkR3H73LJOR4RPgnPsfai3WbZA7C7OHXGvmjIT26eyeSB75KyDkOQnq7w20h6HiGqhqMFts3/FmkhTsieTPVDrhshBMbnMQeaMJr+jQpYpk1FxxL6ocS8lTUFkv8rzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3f1S3CqXr6krAwkwA0PRqAB3L5EIroRA0rMl40Lfag=;
 b=PHHUbf7nv12aL42NhdbIMJjCyItaFR9ibCzhVVYnu4wPZVREe1jTkYI18e4ofGbURoP+aawV/Eq7NrjGauKRrr+6bATnDvYTd9oY1pKIiC12NT3IptZ2R1QhGXiQ/04j5FE5KSWL7qSgzlGDj+bzT05E7EKDqTL3oqMSwLCNseE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4153.namprd10.prod.outlook.com (2603:10b6:5:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 14:52:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 14:52:47 +0000
Date: Wed, 26 Jun 2024 10:52:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/3] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <ZnwrPGHGZqD6lBtT@tissot.1015granger.net>
References: <20240625200204.276770-5-cel@kernel.org>
 <20240625200204.276770-6-cel@kernel.org>
 <10B16A04-327D-4031-ABA0-72FAE31602EE@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10B16A04-327D-4031-ABA0-72FAE31602EE@redhat.com>
X-ClientProxiedBy: CH2PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:610:4e::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: 1825fc13-b4b7-4d73-900f-08dc95efa47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|1800799022|366014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EehdLxqjjgPlIOiXhOPHFl2x7CT4xdZ+4M76aATQm7qOSF/sqAMvND5y1z9q?=
 =?us-ascii?Q?G4KfDW4DIo4fkAPMXBr/C4s7/ZlSnc9rHmm4t8nI9ZyYgehrShEFviJCbiOs?=
 =?us-ascii?Q?lxuyvnmWuLxlXY/7LI6aZfJiu0IeCh+9IuY2KIgkbglnpboWZsM7Qzr8su2v?=
 =?us-ascii?Q?ZAbOLkJjm04YzLGvP2sYl408Cz9Iz+SOskVjYjTwMaqiUik4a1KvoFAPC/ox?=
 =?us-ascii?Q?8h8IAs8AqUMx1kUecXRzaRdCKFC2NHzGVUK8cuMap+ag8a1hFe4tIacCc4Ah?=
 =?us-ascii?Q?lZpYrasjcIwbDCCqGzR8SduHDZIRqMGrEejEyAw2D9jxn/evEJ6hmIGcAUA2?=
 =?us-ascii?Q?sZxVUOfVyk/4qo4tIM1w3p+Tv5sm00nbnu8atJjNY+57rNn3UV2zzFgCZAY6?=
 =?us-ascii?Q?ZI9OPFQKrOya4jTlXhVBandjAB2KpIjf+YAg380x/y8B4nTL1PZdsA5FuTKZ?=
 =?us-ascii?Q?TCa0afPgn0F6tUbvMwQrz9QnZEkqle63omET1AKF63sUQF8fafobg/Z76HUA?=
 =?us-ascii?Q?In4QZ9Ww4VL4cB+vtYvBF0YLrfbklwN6XHyexTo4Q2D7k10LqJdBEATrXLd/?=
 =?us-ascii?Q?NbgK/V/lx0toRQzlBXB0PiSbyDs1oKOURa6kar2c/6Ev9R1cOxilZKnQl/hD?=
 =?us-ascii?Q?QcUDO012nEo9QppZLUX/yU/YdhtsdLcdxAI0ZTiFoT4ZXGIzvFHoOejhWBIt?=
 =?us-ascii?Q?HvA8kuD51VTihLAqw8BxInTtGi8yGEahJB1mIWdIlJgPDyBY7U4uq6E/IvIO?=
 =?us-ascii?Q?UmZ/wIi0UB4gWPyPvB4+9tXwnuZ2qSOPZQ3MpkjK0MKOGlpN29nLGi1u8z7z?=
 =?us-ascii?Q?/UkbaTq+jc8A0zc1JqmOL5PBAIDvWibZ5orILVWsU25siK7eAWQrNwVw/gE1?=
 =?us-ascii?Q?Bx4pKoEI7WK4yZZ1HHuME12ht9Nn12vgODScfytT8WOe7N2L1I9R6DRGbPcG?=
 =?us-ascii?Q?7YqGGtNvr7OmdMkLPDoz+8f2VNpS4MHO5pnsxPTSIniLSisjJHwiMMW1r3pY?=
 =?us-ascii?Q?hvoJ5VCNOysTSUsufKX6SEfEUySLe+ggTrdKOa0dLigOvA8QBBbIlCvY0wFS?=
 =?us-ascii?Q?NillP42DgVDnvA/RX06oSDNlVHN0EELr9VdOfEB0XWFrN9/8P5W9cEU81nvh?=
 =?us-ascii?Q?1V0OQH8l5OA8uIwnd00FoJhaWfh/0vq5gNIm8p9ogm2WoutyOiI+X5k8zzEs?=
 =?us-ascii?Q?T31LwALVYb9e8mkKY2dTGgoZvT+lvToo94LEla4Rpnu/mNQ57mALEaArwLgt?=
 =?us-ascii?Q?QHd57++IHk9N4nz8dgy+oGK58etkr9bFL1LSejJC2wS0aYZLsEAteEXNZF4v?=
 =?us-ascii?Q?fd0db5Cnjt/WEdkJSbYx8o8FdPJ+I3NWEPG/5WnWYyjPLQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(366014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y+VMoaWJn/lXV7mtzCYM8DtiTJ7aykjUX0xXsaYyQOYPp+lO05QJFtMS7mFt?=
 =?us-ascii?Q?z0E9YcwkU318yxoM6Qunrh7p+ibMaa1BAAK/EobEjym5Q3C0B1e98o+Ow0LO?=
 =?us-ascii?Q?1Cuvbt1a8vEWe6gNJVxJyG9eAeBVCQKkLI3/wI87rCh/d63jJzwz9q2JlpvX?=
 =?us-ascii?Q?FGXE0QxdY5IMvInKLKP103oazEPwVxCW6L8Qu8lqJAg3idygkycsJZOvhjOC?=
 =?us-ascii?Q?1NZsJAEAr/N6/I7VC1Qf4z6ory3qg55fU1/yEY0f9HH+m1SugAIf9sfVEO3r?=
 =?us-ascii?Q?u5qERD+kBR3Emyxm4LxpRs5NX/YRNe1aVOIKuDpUZEXG73buT35l/UD002C/?=
 =?us-ascii?Q?4aP6f63ipM3/HZlrkDtzYgHIEnPyRtAY4ELHvVmJ1LMoNks3e8VVPaYpSZ1T?=
 =?us-ascii?Q?kOilq/0eMdRzp+GbTVp57ifAmPoboIJMaj4qhpr+dEvNG8tHg5ODXuDLJ0q3?=
 =?us-ascii?Q?g0D8E0IRxncqksbS7hiJtmHbMHUbea+YDeMqzHtwhaYUgekBTFTE07rxUpAv?=
 =?us-ascii?Q?aiI+Jw4WAMpJ9x71xNCVnOPMMzPfAXd7PYHdOBR9SF3MFavyYbCMOYAD14KK?=
 =?us-ascii?Q?blNlKyHwwcdj/k8m49BQTBIoaEyp008yCU2Xgx+2/U/3nbw0r1JP/HpNsMnW?=
 =?us-ascii?Q?9fEjdr2F/lGxqhiTsq75xiqvmfqOhQRNB27VTRbVryG7uiJj5Y0QfIAIwJRb?=
 =?us-ascii?Q?wOB0m7b3Brnj/L3ZOiiIzBcWj90GGVXpObQK6KWPkC4QTwRq1tPZi+9odSqI?=
 =?us-ascii?Q?wYNjxvv0BP8lauEY60jmcVpPwHM06vVfmjxA1ILRy2EOBkFfFPyLEtPXXvfY?=
 =?us-ascii?Q?dVEuhQoeSTkqTFiadO8BqjzQqiDTu4WCP7ecB+NS4cas/GGa0BXQ5Xs8iIBX?=
 =?us-ascii?Q?hS2Am6jy63QY48CX+tiqmt8FHzh+8LgHhol4BvK213xmr5dn7pPxHPkVJ30X?=
 =?us-ascii?Q?dQT9GbCJ9u63GmyXUt/dEUazuaOknSRyUKFn/lPkTOPyrceqljb+G12SADJz?=
 =?us-ascii?Q?CnTvV1B9J3WkXuFvo383x0+tzY8T3WMV07Eez45PzQ0ml80gx0rEqPUK8QxF?=
 =?us-ascii?Q?q2c7Cpkc81/IXaVFvzVet08Hkm5dWwFNNkcjk7Fw5f3Dgnbj98Y71o6mLBJR?=
 =?us-ascii?Q?QvQMjmmufNGmjWIUQd7ovdZITEIhlaVDNA/uvAyBKGXCnK5WsL5CqVD8iZJj?=
 =?us-ascii?Q?XujTYrhUKyZSu8qjxMbSJULt3kxC6u5ShN/DAfm+9Wn4h7IORxwP6NGDDg42?=
 =?us-ascii?Q?Galet8QtmFrYzRIZI1/9bDhAx5ASZILhk8IwEsEbQnWYHubpxPTxFyOLX1+s?=
 =?us-ascii?Q?bT7tP60Z6Aci0ZsNw4I+yszP5jjE03yWW1Yr56M7kud9KtjwU2bFfrpcBqo5?=
 =?us-ascii?Q?Lfv+r6DCFizK3BE/fhSK44fLBSceMmRIG2zd2vAzT2+erbppgCbBqf7R7yyf?=
 =?us-ascii?Q?9FOFEfQ9kiXk9PgFVbSsLB/3VlsgWG2K5rLPGvOKMIOuhxUFWk/jScAnEBV1?=
 =?us-ascii?Q?yvomkaJtv+aAnCkIxpaPORuqooB2IBjhKm5eZK6TGA/X5y8GK/k9/8CKNB5N?=
 =?us-ascii?Q?jnP/kI0E1SRsItJPuraG2dWiLmwgcCkT2C1m3NSl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Xk6/jmySat+Uc/P8mvY411eSFbL17Tv0ry8X9y73bwztqoBQIIEBaYLbMYk7FZl6P6l60wIDido0EXyQwnYMYJwvbzQjsmINji7KKSfuUP9HsY6O5QgxdroqHaeeUWQh8u7uk1XvbU8HCpy73uiOuzOmp+wGp0Rsheqa3HT/9S7Or24nfGd6FcKWRkayNLxOiwJESEjOS6RZYgzlqzPiA+oP9EPqd5iheIVErY3WWEManPUDZwKcq1Hqah+6+s+86hXY4I+cQPy8zx1Aukeb0G0Z3qryjVsNLIGSSBferw5/2B+SM2POdl1GQirMrf93kcEtTKydqmK7Ul5WkDHMmbg61/CktDFkb54vHQNStYT8ny1xbEj2F87vxujSjFLXFANLwomY875gP4OnEmSV/P7MBsa/6+wZEbmii65RCsw2LQzS8jG0t2uL59W5buIhQBJ2NnQXqr4ze3bKQzxD+BpU+fwHeXCS5hLy4oYIMxpg28ynGM+eyRIuAMvDUCljKSQ5LXSUaytVygPM5s+7g6yxScOBBodx0E8VzeE2kqAsdwb1MVAEbaYRat2c+AFS4DUqW7SyeqqKFTEF7wBGgNDBtlgFPN9pj9P10mLpYl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1825fc13-b4b7-4d73-900f-08dc95efa47d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 14:52:47.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: id2yySGZyOAmnNHjCS0j106bqv/UzxUqN9guo3Y09zMXvUJE4240EJNLhQ3dl+C9U0RHtQ7u0Pe8c6fvdc00Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406260109
X-Proofpoint-GUID: 3kndLbj2WbhnWqccrsZ9EyDdb5RbMPNw
X-Proofpoint-ORIG-GUID: 3kndLbj2WbhnWqccrsZ9EyDdb5RbMPNw

On Wed, Jun 26, 2024 at 10:49:44AM -0400, Benjamin Coddington wrote:
> On 25 Jun 2024, at 16:02, cel@kernel.org wrote:
> 
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > During generic/069 runs with pNFS SCSI layouts, the NFS client emits
> > the following in the system journal:
> >
> > kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
> > kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
> > kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
> > kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
> > kernel: sd 6:0:0:1: reservation conflict
> > kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> > kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 00 00 08 00
> > kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
> > kernel: sd 6:0:0:1: reservation conflict
> > kernel: sd 6:0:0:1: reservation conflict
> > kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> > kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> > kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 00 00 08 00
> > kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 00 00 08 00
> > kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> > kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> > systemd[1]: fstests-generic-069.scope: Deactivated successfully.
> > systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
> > systemd[1]: media-test.mount: Deactivated successfully.
> > systemd[1]: media-scratch.mount: Deactivated successfully.
> > kernel: sd 6:0:0:1: reservation conflict
> > kernel: failed to unregister PR key.
> >
> > This appears to be due to a race. bl_alloc_lseg() calls this:
> >
> > 561 static struct nfs4_deviceid_node *
> > 562 bl_find_get_deviceid(struct nfs_server *server,
> > 563                 const struct nfs4_deviceid *id, const struct cred *cred,
> > 564                 gfp_t gfp_mask)
> > 565 {
> > 566         struct nfs4_deviceid_node *node;
> > 567         unsigned long start, end;
> > 568
> > 569 retry:
> > 570         node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
> > 571         if (!node)
> > 572                 return ERR_PTR(-ENODEV);
> >
> > nfs4_find_get_deviceid() does a lookup without the spin lock first.
> > If it can't find a matching deviceid, it creates a new device_info
> > (which calls bl_alloc_deviceid_node, and that registers the device's
> > PR key).
> >
> > Then it takes the nfs4_deviceid_lock and looks up the deviceid again.
> > If it finds it this time, bl_find_get_deviceid() frees the spare
> > (new) device_info, which unregisters the PR key for the same device.
> >
> > Any subsequent I/O from this client on that device gets EBADE.
> >
> > The umount later unregisters the device's PR key again.
> >
> > To prevent this problem, register the PR key after the deviceid_node
> > lookup.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfs/blocklayout/blocklayout.c | 25 +++++----
> >  fs/nfs/blocklayout/blocklayout.h |  9 +++-
> >  fs/nfs/blocklayout/dev.c         | 91 ++++++++++++++++++++++++--------
> >  3 files changed, 94 insertions(+), 31 deletions(-)
> >
> > diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> > index 6be13e0ec170..0becdec12970 100644
> > --- a/fs/nfs/blocklayout/blocklayout.c
> > +++ b/fs/nfs/blocklayout/blocklayout.c
> > @@ -564,25 +564,32 @@ bl_find_get_deviceid(struct nfs_server *server,
> >  		gfp_t gfp_mask)
> >  {
> >  	struct nfs4_deviceid_node *node;
> > -	unsigned long start, end;
> > +	int err = -ENODEV;
> 
> Just a nit - this err var seems unnecessary.. especially as still we do..
> 
> >  retry:
> >  	node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
> >  	if (!node)
> >  		return ERR_PTR(-ENODEV);
> 
> .. this, which seems clearer.  Looking at the return at the bottom makes me
> think 'err' could be something else, but it can't.  Looks good to me
> otherwise.

@err used to carry the return from bl_register_dev(); in Christoph's
stand-alone patch, that was an int. I'll get rid of it.


> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Thanks for rechecking our work!


-- 
Chuck Lever

