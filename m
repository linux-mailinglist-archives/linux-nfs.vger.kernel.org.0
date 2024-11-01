Return-Path: <linux-nfs+bounces-7619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC759B917E
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 14:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050812819BD
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985314A60C;
	Fri,  1 Nov 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sg/5HzGe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nQFN688O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4C487A7
	for <linux-nfs@vger.kernel.org>; Fri,  1 Nov 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466392; cv=fail; b=d+YSk2OjcEa/BW4rXZAlwvuhPQnn2gnis+u2JFLL/lsjLnYu9L/GR3QuYiWDMHrMewosI0l525RVTwBE8Er3Sou44xw+WuIMLP24cU5TocH4nKL4WRyF5tHPov9HiQDHAR/XN17hF2XUXUxXmYLbdwtjIhov+e9gwQbjC8IxaYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466392; c=relaxed/simple;
	bh=p8X5Ove6Hd5Bmh0PjzY5CdkI1u8SmlTO+jMky33gJNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gkBWjEFO5btY1a/QwWtm4uOXIIN4E1mHa9hI70mGDL/mg4I9PxI7aksjMJh1SZMG6M2gr8tmsX8bVBvi9g7/hs1gZ/op2psZwP03W4jQbHYXhTTvOaCpqyegAxE6pBTaIT5Cisi5+RoEks9bkLmiYR/QBHql+z46me+KRGg7prA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sg/5HzGe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nQFN688O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1C31Eg029397;
	Fri, 1 Nov 2024 13:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OaCPuNKXDaRBMbTBKn
	1a043JjEP7nvpSO/SwuwZEo0Y=; b=Sg/5HzGe4iSF+kTWlQnKR181TzandxKQpr
	xYgw6qLiX7/GZmgBMuiBXkEef6xT+mG7UjFYjOPsa3k89kkO2wTXWSPkP8N79eqZ
	apcf1O9+uiDpPyknnilJ37seTMzCQIzfr+8c1ClnYQh0DXemBPw9KRTD+38LYOqu
	DxoftJzE05LoUGKgumbzxkkeZ+gES0MEFkAHA5xJwK3jJqBY/1V6DQb5Mk1+OKCE
	VMpZJ2M5EQu1ylr8oJmQMSVCqgMTCDgMq6JYUL7jPA04utuo5egho7Mzj5wN6P5d
	VEbxvoL5Ol0t1b+dNt61ldSxY2I/YiBI4HgYsLtQsM8rM59Sg6AQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgmmbyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 13:06:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1C3RBp010191;
	Fri, 1 Nov 2024 13:06:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn91nnkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 13:06:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUmGpBmQHKTv4NNWO7vMGzazFngDbk9j29JF7MwpxDCFcQUySYSCxYHJovcJkG7g6MQ+zalJ6L/kL4rmzTnZaaoGAnh/7a3nktB6DTBwCCZQpCzwSZbH3Dw1UZcdYtWGhqf/+plcN4UjAg4ZVRzVDOeuvZRRJIPvVGToyULjn4LFftf7NAhYD2BStauA0x6v5lJ73n+l3S0vPYGKc7qBeWfnurUb+NVczFNh2pkrbCD6c6IRnKOapyA5r5iI8mKjnsF58urhCg55+HOCz5QAnHYPi/7CIZwmWiSN+CrplWjhJOag/FE0tQP3dSdcGe0vGuWNy8dFcBfs1XVnXcEEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaCPuNKXDaRBMbTBKn1a043JjEP7nvpSO/SwuwZEo0Y=;
 b=lSI9XfH3txO5n3cRN1CRn25yUVPGAtcESqLQiYevSR1tQDo/ivvujq+f4/prTkXTaKuOdwy2vRgQpZo87HSoGWZU+6YHcLZxJ2gJcSeaTNxqLxBm4wCOQp0QIU2hLP7XupLNLIz4Xq5ZAN5KTSCuLF3M1PlZKmJB+mAcCqPsHo3U0/gsx62z7Sj8U/P8yRqGsHVqxup679UxrMzbiF9L23F4a7c3liz0F535t06GulrGaSPmFjwsRypFoVToeUDZckg9EaDBs3MDnZb+ggaVLSmNpCPJJzcP9w11XMl7AjjIYYPnOypArkqsBVcFa2v+8ZQBGHaawBDjFgIPmAvTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaCPuNKXDaRBMbTBKn1a043JjEP7nvpSO/SwuwZEo0Y=;
 b=nQFN688OggJMXX6v8rI5LAWXsSuOVraEyFbf/mj8911200cSswn91lHj21mIRLlejl1W/IJzJ0AWuTwn2f8idlF4HOWbdxjFzB+3MODg59Utrfr1Yek/kDhFf2rNv4OspaCE5CnqxMULN8oiQtEKBnvVgWYRfEu368wX01kC6Wc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7184.namprd10.prod.outlook.com (2603:10b6:208:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 13:04:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 13:04:25 +0000
Date: Fri, 1 Nov 2024 09:04:23 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 2/8] NFSD: Fix nfsd4_shutdown_copy()
Message-ID: <ZyTR1/KM5oz3jATU@tissot.1015granger.net>
References: <20241031134000.53396-10-cel@kernel.org>
 <20241031134000.53396-12-cel@kernel.org>
 <f22222244fef5f0b110f6a229aad15e51a6155c5.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22222244fef5f0b110f6a229aad15e51a6155c5.camel@kernel.org>
X-ClientProxiedBy: CH2PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:610:54::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b3e5af-3d78-436e-65b7-08dcfa75b661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IA8W3BHL/IqoMVvutOjRYN7YPMZ13mF3m7SA49MarRwlwEkKP5oSo8vO/tjL?=
 =?us-ascii?Q?6/Kk8nQoJGa/pCFa5e/RnXzqIxLPMuRUbB+jZIANJakVVqNkluJtX6fhQoZi?=
 =?us-ascii?Q?YF5N2KhILsxj7EWg9diI9Jmo8B6zrEvT5nHhCKKAmx9Vj4Ztcqw8BpM3XJ6W?=
 =?us-ascii?Q?TrTQrGRlKXo2V02D1HZ9O1NOHeQIzubRjEgCwUujHkeWQTBYe6T+QP5O5Rly?=
 =?us-ascii?Q?mLvLgFL+x7KRBYuaPt/0LdKDLWyKHLWnXb3S7Cg/uVvadwiTV4lPPsAFD7Wx?=
 =?us-ascii?Q?LZpZXHkertz6nUrqC1oXKb28kQpaYMQcvApgPnNNl+0KOUj2kkv5lvROovVH?=
 =?us-ascii?Q?cr7T9yDhBuhUo012tBEZuDoXD+StCuG3zXV76DDK5tPK1D6uSLdwX28pZqOT?=
 =?us-ascii?Q?hRexkrYWOKpNHTwoT+QG4s1QI8eqdjCjockMwEV+nQ1JdGkBogLu0x2Ayr2r?=
 =?us-ascii?Q?8IajJSz7cGrT/mWDa2shNV31PnmIGp+i/YHrvH05zycnh3ATr+H5VEmQIG3q?=
 =?us-ascii?Q?jKftkUcRqlh767Pg/uuaoe0gmH1dpT/MKtsLPviBipbyMkHNGXaRB61HrHcG?=
 =?us-ascii?Q?DB1AzWhWftddpy9omftrDCewoQiqXSkEv0R1fyD1PzF0Vx2WVSASuYP432eD?=
 =?us-ascii?Q?MP+3IBnx/eiwAZKQ4PaoNVALN4WUhhgcrYpDF/pq6b1SUx2wl9hWjLxxDlaP?=
 =?us-ascii?Q?CPAgfWaosvZarf+Gp3i8EmKx/sbld05/a6q1P57oXyRWmJK30X54Q8YTIosh?=
 =?us-ascii?Q?iVNLQWxMMed5v9/v4lu5W8Jcl1lhkrdtNHeg/Njn4m4U6Nt6y8XmSb3Tf2Ik?=
 =?us-ascii?Q?lVyqnF6ncsID+KX1/Q5VJmkgiM3yGaZQ7Bn32htqd5xZcKq/l+CtXjKHnITv?=
 =?us-ascii?Q?pHcKdbWIKwrrPzotZI4TN9mmTs4RZeZAof6lco+r3CIohKyJ985IKGT76yOg?=
 =?us-ascii?Q?v48pLZdNbRLCQdgt+bo9v9Xaxnq6Qz2Dgy5/mjgJPGx9qWS4Qh0XD3MvUKfn?=
 =?us-ascii?Q?+yI9YogEuNG3yQjn3EkrNCqJeioupstIP7pX8rBMQC0qMuMjzXNh7o0na9EK?=
 =?us-ascii?Q?be8LVF4UH8GEyah2KTBZD32FinrgBekgK9CD2oqPWZQfr11LZDfmW5q+1KYr?=
 =?us-ascii?Q?sQwdmyPho2XhveOyXUVAN1GHoJpKvBHHj/upLCytZXigF6n13uTJS2I1xfdU?=
 =?us-ascii?Q?EpPLlBYnP0ug+t82KvrRMUE1hmGguFngse1mI566X2S9NgTylgVv8E8gpcIM?=
 =?us-ascii?Q?RZOugGagQmOns+xvCDZeXr/65urH7F+a10MqkNL7V2fZplQrLpwgnROPjITJ?=
 =?us-ascii?Q?8AYvykEp7cSFicT2gDVnhKVe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lSJLeGZPSyvyRcEdhD6mVMNmM0RvW/SAug46gb030he+iAJSpXieYwcF5dyp?=
 =?us-ascii?Q?PLzWypgRvHnLKBBT9+98ypG5qYkuEidIbtit+0BzmqPHzjrtSkJr2ZWXz17P?=
 =?us-ascii?Q?Zlj/8wqNKtWFf3paG3qI2wNjOMoESev2YL7YX24UF/b73zWuiU7WdL2NmARE?=
 =?us-ascii?Q?YVK/TmuriV1w2SA6AxZYxoSFsFxH8eDf+0+XFERdcFjFMdl68gOJv/pbAF3u?=
 =?us-ascii?Q?GKMEP0XTg1FS54GARFlVfc/DvdlHYEGA0RzrU2nKtD+Mu2bjxKOgX2o7cXMw?=
 =?us-ascii?Q?L3MbfVZU3MstxsSfOcHISAKZ/mJpNRmGUkNJAO2qEly/jSkFpwL5iJnBzJ3f?=
 =?us-ascii?Q?UkwX0Dc8dwO42Yd6vNPvC7x4vh1JUX6oCIPuJru3r5nM9n2C3vYv5A3S0AGb?=
 =?us-ascii?Q?3OULqlu5s3Dg2BFCQsptHvi8R5Y90Kinvoht/6P3T+y7ycncrrZwXF6UzSiJ?=
 =?us-ascii?Q?EyQYVnnKPCnY6MM+YKWZ4bE0vMR1sHrLcDx7ZT7mqWEw1d8QPLwhPZ2LLExU?=
 =?us-ascii?Q?G2xMZsSplFisKZsSOA4DzJl2hVDjFhs7Zf0Bl6iCj165HzgFv7pduj5O3w00?=
 =?us-ascii?Q?wZSs/keuaP+PGoZZeZ30526wN120OUZa+QC3h2yBv3Fe4GW4KP57mE0RbTHR?=
 =?us-ascii?Q?cn2uQbQOqagNA97l4CP/Ldwh6RKrzD4qciEbApuJXqgRfjoh2e5996D9xYu/?=
 =?us-ascii?Q?p/1/UEzGvMGO3ll3W6ZLUho+JknSZ3OltoqAMXSyWyQ/wnhnR7+QX8/v+H+j?=
 =?us-ascii?Q?dLnMiPYeE82RpDZg2wDSRySeG4Qhx5LwZS/xndDTX1lasiOe5tuxxLbDyUDi?=
 =?us-ascii?Q?kptIEr9WDhObrRTQxV3o1LHHxwGpQ/AzCB5uEAo5zX3oPgzNMfMePtksAp+c?=
 =?us-ascii?Q?UP7QV7tRq6rGxILm889FUk37OViMjkKQbJp6hr7LPvUpXLeeUnmyPrRh23sk?=
 =?us-ascii?Q?aNXRSmt7fjGYc7SWEhIQoxqQprueYZ8yUJxq01C4d3ms/4mwrtPP4+NeFvq8?=
 =?us-ascii?Q?IOjzR4Q0NCGFFW+1cGVqIgtY6mmkzv6kWgdFFclzml4X2mTj08Zv2l82j8Lq?=
 =?us-ascii?Q?D+NRkLdxhfacdW9+AOOGe0ZL4+sURxaMNwp7Sci2YAufC20hLDqJy+IUJBLc?=
 =?us-ascii?Q?kPrayR9ttzMgYYiUj3YlVIBC0r+OFWTCHG6cQJqi14K1latNKoRDB90DUMzI?=
 =?us-ascii?Q?/4NhjkjDhOjhQGUXXfS8eOA9u1Es5wkCs3zjlHmqmA/Ab8VBrZZdxoFQ4NTa?=
 =?us-ascii?Q?ZhtoIODQ07zDnv2CanJOLv/wUilnrDKY0n5AhKBzPz3GtF1Msw/qF2K95Qr5?=
 =?us-ascii?Q?n0I4HcivzSGH9IgYbMdBKE84tvoKJDBAvJTByrhQROv3WvI+0osV932qxBYY?=
 =?us-ascii?Q?oqTU/LeDpcGGqjVaw/CcwhlnJapw6XcawvT858dgQeJOC5GxuDhLT0CXi7vv?=
 =?us-ascii?Q?ZYgu7DCizYk6jjkpzlKR2c6WnPZLX6lEbAMY2EfzFxjrbFlmzEM38jUUoB96?=
 =?us-ascii?Q?55MA0gDoOb9XY/aFaBGBs3cQg/oCP+dLp7tNz6m9X2oeiVAjJb+GGUTZ5LJs?=
 =?us-ascii?Q?4EbUGvp7Wz4ILlMuWCbR/11MSLwrVIVbB3GMdfEM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZfG+T0vJ0bOgw36FPYHeMwYH8nJKINlNIFAzUIa1qAH0PpsMyJfZayxxytr6WueUOzqIxV8JpWrA7FahlUhwSGCPKmuZn9GA/lD/deOlMvYhs/utvEvWJdeMFgJJG6lplMnROnbk1DqW8FQhVa6+oZkXgt1VYwK0UvUPmS7L6opjXqpJ3hs50YGikhV/ngwZu/9CzEVdGiljFufJshjJe0zVj9V68ubXW3j7tmGNeQhUOMi5alG7E/0qBTOfCwcouy4CCfq3UxOorUYC+YLE7FHdMRkWuVx5+isyTDhJZlDrNZDbmRChoSkFot/y/WJdlbzhiTYmOsJ7ZufIAuVGA7zb7BOult2a/JbFmwPXm6qxGzP6in5B0cslFZk+DHtJejpKHcf6fmktyMU9Nfxitir+pti+slWVAPyeOO99lOFMOSljNqrL53rrYDaQ6SfOOa5XlrHnfR8P65yQ0uvg39hUUDsGKAhGOoaMTjbaeegLxz/HoVpfdnK2OJSCzhfNaLmJ8YiFb0C0ySmgse59v33kqdMZpsngTpL0S0TREHDnF9XbZGbNbxCvJ8h+8PrOQCXm4o1ZMfAQIWq219iYGmnaRab4GkTYQv6kUX183Lo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b3e5af-3d78-436e-65b7-08dcfa75b661
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:04:25.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4jiLLx8xVzB7SuVaGPxqTCEPjptH5j7iKqCER80/TVeC/Mtq6oITGVLpfD+WLSMpLpebBtuOTGvlpqi+GOOuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010094
X-Proofpoint-GUID: fcxFz0ndJwyvSFQZyHFya8Arel2FCtVC
X-Proofpoint-ORIG-GUID: fcxFz0ndJwyvSFQZyHFya8Arel2FCtVC

On Fri, Nov 01, 2024 at 08:28:42AM -0400, Jeff Layton wrote:
> On Thu, 2024-10-31 at 09:40 -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > nfsd4_shutdown_copy() is just this:
> > 
> > 	while ((copy = nfsd4_get_copy(clp)) != NULL)
> > 		nfsd4_stop_copy(copy);
> > 
> > nfsd4_get_copy() bumps @copy's reference count, preventing
> > nfsd4_stop_copy() from releasing @copy.
> > 
> > A while loop like this usually works by removing the first element
> > of the list, but neither nfsd4_get_copy() nor nfsd4_stop_copy()
> > alters the async_copies list.
> > 
> > Best I can tell, then, is that nfsd4_shutdown_copy() continues to
> > loop until other threads manage to remove all the items from this
> > list. The spinning loop blocks shutdown until these items are gone.
> > 
> > Possibly the reason we haven't seen this issue in the field is
> > because client_has_state() prevents __destroy_client() from calling
> > nfsd4_shutdown_copy() if there are any items on this list. In a
> > subsequent patch I plan to remove that restriction.
> > 
> > Fixes: e0639dc5805a ("NFSD introduce async copy feature")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 9f6617fa5412..8229bbfdd735 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1302,6 +1302,9 @@ static struct nfsd4_copy *nfsd4_get_copy(struct nfs4_client *clp)
> >  		copy = list_first_entry(&clp->async_copies, struct nfsd4_copy,
> >  					copies);
> >  		refcount_inc(&copy->refcount);
> > +		copy->cp_clp = NULL;
> > +		if (!list_empty(&copy->copies))
> > +			list_del_init(&copy->copies);
> >  	}
> >  	spin_unlock(&clp->async_lock);
> >  	return copy;
> 
> My initial thought was:
> 
> The problem sounds real, but is nfsd4_get_copy() the place for the
> above logic?
> 
> But then I noticed that nfsd4_get_copy() is only called from
> nfsd4_shutdown_copy(). Maybe we should be rename nfsd4_get_copy() to
> nfsd4_find_and_unhash_copy() ?

nfsd4_get_copy() book-ends nfsd4_put_copy(). But nfsd4_unhash_copy()
would work too, I think.

-- 
Chuck Lever

