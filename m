Return-Path: <linux-nfs+bounces-5091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26F93E03A
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 18:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB471C20F03
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809121DA4C;
	Sat, 27 Jul 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W4pubC+T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E6BAnUnu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F91DA23
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099171; cv=fail; b=E3hII3b313RJaw+C6brMGJj63xEKKfM0hNSFUYlZ4Phx/DFzPwKyqICEexgskabupG9lFVJBDXW3NyFQ+lWWFgSZrH+t69KryYHdwC0WntextSrfRnY2pr1P0as7PZRxogZX2IwOy7eeJe/BXAw6TY/9YUdugme+bSzfxy1Ez2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099171; c=relaxed/simple;
	bh=iy5zabef131nCb08Vue/VnWY1tvKSxhsSNmgUaMJF5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PXLxjw6kvHTk+7L8rkP1xPDzAtIsBHcVV0DmjMTaTgRly132KTaNf2ZtlNrXHdZHFpGOVnM92VzZnReuScn/Sn/heJkGsiS5IBiPZQQbccKOqGBijnNTOe9doF0wC5oOFYw9Esrb3tipBxpDmQKb9kY+wN6zV42MxX6UfglD7fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W4pubC+T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E6BAnUnu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46R70O3g031822;
	Sat, 27 Jul 2024 16:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1jzYDf+bRUOPNQj
	M0sO88+zdKDaNmaADO3DsjC856y8=; b=W4pubC+TykyBVsbFQKtC+r7iw8ywX9B
	7FdO/NDwTQjAupY0armUF5uWpmm85P7q6OsV+r760ZtsRKGh8evgscRgwzgJEzW8
	36S4rCQh0f+rZchxl2oSE29PMbYAr/5GPyvQVg/WJSKUap6Dh4CVX/qdzA7SeZh2
	CFA4HKAzlJI8JlCSvkRsxSJqq4O07gXpC7fxVLEzx9hz0kTwCB6Gb/LSrZd8ZZ2c
	veIUo7wxr7MDw6FCQZfjKwRY0htLApgsdIHL+D1mV66Mp4LvPwN2Y80t3KE9kyfc
	0aYo9QBbKIzCR8rCQuRvE4ql9XHimsggM55rli7zaU22pbW50TbmPuQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfy8fm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:52:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RGFVj7007520;
	Sat, 27 Jul 2024 16:52:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb5mmhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEyYLI/ACdm5f/NB+GPzJZ6R16O5If4t3FsO4NvGQMOu+xk5jA2LfihgGKe4IVYYhntPXAwFM+ZoWv8VeiBdOAWLxQrRh9guCrjVbd0UKUAXkMe/NQx50SkaaQb6js4EeGAJ7LpQYgTs3GknIJTFHo1HhcWVWhWo5FMVXzlP66Zg81ZEHFooXA5pqVB1DEpTA5ydBPSDC0fmF+74+jQxdkZJh1Q69D/GSXBsGrN780vQuzqAoJ+M5dzeGBkGw6GGA3sWRm2gNhSjQFGvxi/yFZoPNQvFWM2xyfZ+y6aaO5N9QJw43vQ657SMrUzI5DZ2OQTZCeDTTTpzDeJnfKaY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jzYDf+bRUOPNQjM0sO88+zdKDaNmaADO3DsjC856y8=;
 b=d8eEE8dWiNYQnzjktvftqTvxGusxLlpDMslWEPkGssXOMeJMTX/ZZjaDa7AdjuDNkAGagTEwEuySFGtV2/Wz8ND9rI05/bJvdIkS06TkAGuE4PB+SQtbMUkZcflq3Egd4laNm2HtYCfql9LILqxKIanCxRCIZ344sNEkb28Lvo85rt6Lh/+wYLrB7R3wMdgb2Tc55fLuuEqYMjeWgO2w5tlqL+wtjmUJ8MCC8E+OYJ/4ekiovC8aheE3jdMhXqIvPy9Ug14Fr/dluBA+QR5coCbvdZJW1EHKl1eOP2sCy1E21yws7CpbZqGAIwF9D5mF6moSutu065G6cnU+LUFuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jzYDf+bRUOPNQjM0sO88+zdKDaNmaADO3DsjC856y8=;
 b=E6BAnUnu+K7sIDLKKDwh6H5LseQyYZ7ich0iSu+A7MJ51G8jx4EcVzr7ZfGsqnPdxi0+wGzb/Xq7hoe77Zoi2QC3TXc8WZUcDqy44d9LwiW8nQ7Edix21T0LgX4lTiKL0lmegKjfNNTQX+nakozcaFszDQiNX99gNWbLSrKlC9Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6585.namprd10.prod.outlook.com (2603:10b6:930:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Sat, 27 Jul
 2024 16:52:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.025; Sat, 27 Jul 2024
 16:52:35 +0000
Date: Sat, 27 Jul 2024 12:52:32 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
Message-ID: <ZqUl0EyyJYJhsItg@tissot.1015granger.net>
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <df15b4f4-e325-4ed0-bc94-957113a64915@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df15b4f4-e325-4ed0-bc94-957113a64915@oracle.com>
X-ClientProxiedBy: CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 20378b6a-e52a-448f-bc55-08dcae5c83dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ROmXl1KeywyvPd+NPvBRxcwIhVDLuisRvaOElpRggM8eGUDjwkqh/UYWEISH?=
 =?us-ascii?Q?/ipVIW06SUoUMpK/nIqEsNcl3HjF55/UbCHtrjLwL6BxyG89dePhSsQU4fdn?=
 =?us-ascii?Q?Km75HsJvpQrwyTWi8qjSX9Fm1fJ45iO1muVtn7RnlmVQfPBlopFLnOilnM3V?=
 =?us-ascii?Q?owHHLIRCdmC8l1fDBU6HFVbDUXWDrjzG2ypIWgMjmMVltaGr7b7FkTwfLBA7?=
 =?us-ascii?Q?UHgF/52oWwScnT09IgtWfc4nOKU0WIbiJcWP5eEZBdGDfPV9zIwHBpnigpV3?=
 =?us-ascii?Q?f4URpN9hx1U4nx6ce3YunupF71mghzSRYUQD2ir9FKkUX/MPB9YiXjv9PVTR?=
 =?us-ascii?Q?3c//q/bLi+N/RktFFAUYjsIT5NiG54NnHEohU2TOpG5cFkPKV9wN3iitrvgC?=
 =?us-ascii?Q?QKptub0iis2C9HbPs8TKdSekcjGVtAjenUOPa8D08tkkhiIELLOrKLxqHsZ3?=
 =?us-ascii?Q?0Povu0S+5WF+59dR8Z9hLWTS0TwjIT5KchU8bSoEjCndm8dxbEMA0XDf0IX5?=
 =?us-ascii?Q?0susLXPCUIymAky5RDzrgDcFOkLmCmLS7yYcMFf36VxSMq/rZTH3gxzBMt1H?=
 =?us-ascii?Q?LYKx+/nFdci0cpSVEhIJ78xQ5wtkkq9qzdQYDBSpnRsBi+OQK+ss7A8yeoAH?=
 =?us-ascii?Q?hjG2jvmh59IOcFemgE+0+TkDRcsQ9YidgO/t9hLtowfEOHAVKAd9t8uBDLt2?=
 =?us-ascii?Q?rAPmpjyI1ubby6GrmLVdetWBNUzHFdcuzgQFN/Xm1I6qt6vknF+UHIhkjboa?=
 =?us-ascii?Q?dQXPcRcJQLA1PusX21aoTW6gIeXGbaw5bfNiIaCpqWxl5hj7ujpiOGDMp/62?=
 =?us-ascii?Q?BJ4sYyEWAl60a8OW5pppuOC/vTgaPi9RxxYzOlUbJXYiQdtFG1j2wXXYBavE?=
 =?us-ascii?Q?JWDAodM7lJ5WGI7sECFeSAk8MyCT/5iLeDl+ws+tAwzMOcg129xk0BOC+x6n?=
 =?us-ascii?Q?sZc3omLUd/P5svq6SzBog8NMxpt/gg35iqpceUPw91PcNNGuP+NsaMFuZlUl?=
 =?us-ascii?Q?+1N0FCOUYEUNkTEF52yLutANPdZQ+rgZLM/uaB7zR3Gz2t7T9ToBM6hMSiCQ?=
 =?us-ascii?Q?/VA0qDgDf9/iyri4BvLQi6gl/IV53dq/PawYSwH7pz5+EVFjPEN9R3a7scTk?=
 =?us-ascii?Q?eVX2o9JmY9Yz8WmF/Y+WJZE2IQ5X6S4UaNTtC1oJn4sm68QN0AuP+pBeWadt?=
 =?us-ascii?Q?sNcKHdUmK12QVUtIAfnfrBWRyJZG/axu9Y5m+lELmj63EwRCqluw68p9CRon?=
 =?us-ascii?Q?pQWictH8dnDGwzkPmqT38RGDNHr4CsB5WYGNXxyDWBAGU18LOnrFPVUe+0Zj?=
 =?us-ascii?Q?5xEVUmG96/HSyBObj3eJktifcpGWxvhP47GA52VYyhE/LA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+7Yf/DS9dzqSr+NAqwIRXRhZy30yPVTSKDSI6c78N3xB45F4NG4rK+lgZAZp?=
 =?us-ascii?Q?en3qeLQBaJBWYoO+WYwJh4q6VXGeJznLlNaowp8lJZ5QNCMmQ0hjPYQkrO23?=
 =?us-ascii?Q?YGcWV3GgJ74IQvEPDH27k6b18TEHgy2euumbCvuXqtFg//tl7WJGk088CvGh?=
 =?us-ascii?Q?TOoH+cP9feyyGi+5L57PCkqW8inp+r4hYm9gf1D+aeP8pg75B43iaascjjbS?=
 =?us-ascii?Q?SbjBm2IMjH6jndyp3ZyVqRZbs28/KtwzJwD4ER4yHdFSho/WwVDY2bpxlALh?=
 =?us-ascii?Q?o8aEwolhieQkjKzCVbpK5HzF9cxFzLAHFbNQyAa+JDmdapz/qn+FLLCCJr1d?=
 =?us-ascii?Q?lrgZirfuUZlEk5vmOSQl/bgRqDvCv4Iyx8gVlaV/9/7KT7J0MeUjvjoQWNrE?=
 =?us-ascii?Q?KfOJP3hN3uPHWdsJbOAfx0Xxi01JW4vkH+zaPxVeJy1dQqypA3xwdY0Dt8hH?=
 =?us-ascii?Q?R10CUVnn3MLPwKKUAmY8aKefFOOe6rW6M3MaHWRbzdCdfO6+5xwd75O4I169?=
 =?us-ascii?Q?n6qyH3RbNtw2KQCBNCbO5AEOnP3PboU7D8LqNDYJhJChL2El4qYM9wIneW+m?=
 =?us-ascii?Q?8Z2qHIWReYxYsA4V63vPOnC9zDl0xALWCJ/9WxldOQTa14dJkYZNn0zjBw2m?=
 =?us-ascii?Q?Ky+Wl5DuVfdhMxLa6zrGSUCB83Xt7gn3pSGI44EOflwPbFFqxKhdE51fv4OD?=
 =?us-ascii?Q?J9kI//LNyoss1ILqZC4ctgyEs/3dIiXbQLJXmRoJwNww4G39ipJG0HeXbPL/?=
 =?us-ascii?Q?0IAxdw4w+ErXXKNJP5F9So1V9MqVQYtSS85xCtb9H3G/3WjQf2DPdzqMyu9e?=
 =?us-ascii?Q?qbyLlPD3GW4ulE+pnhrdRfQgAmcuP01buuZp0oypA1nwFmzj3Lu8PNlVesKF?=
 =?us-ascii?Q?1uyEXc4FC6R9ocR5PPVGvhn2ENVclC2GorcPhFlky6Bv0cOsq1LzEffb1HeO?=
 =?us-ascii?Q?347ExjynIHVP91XjcsrObySYkerBmSJrTVq2P4Sawg7y1zHXHmEVkMEkwpn3?=
 =?us-ascii?Q?OujX99JVFEqrMNW/lGzKdTe9Cs13jaM93oIuKy8lNfth3RRwJkRZuw8vkGhU?=
 =?us-ascii?Q?vSdIqdkui+p6VMmXj17HYCXnzdLGF6O6WtX+JHLO2yyASjcjV0Eadaa+efbM?=
 =?us-ascii?Q?/kNwoSgtODDGT8my3FMZNaisOnOwZUbhkly8SwyzCAwtiA8By3CfRQaNXAyV?=
 =?us-ascii?Q?MsWKq/sdWWGe0VCOMUqlbE0+zh+ssKvxdzrkvUDji2NFgXykTipiKngxDo+j?=
 =?us-ascii?Q?ICpUowJ2pjGRK0k6PzTXGWuvTWyWVHExCGiya1eANd3zCE9ool4fvE4zYgQY?=
 =?us-ascii?Q?1J0nA99B9aJUBUpHy27jL+kh/alS3eieyRmb65EKrASblKfVbyBpBNX3L5s/?=
 =?us-ascii?Q?ltj192bEOIP9tK84Bi0rIS2tx4qlXkbdzPufGF4wnWv7RM9eCkft6OiQIK2d?=
 =?us-ascii?Q?ax9RPtCWR57WaBPpW+Wrcz/BPT4uJ7rBn0OiNUi65DzatIcEPNExfJkGXoqX?=
 =?us-ascii?Q?5wnOx07RoRH8ZrrgK1c9rgxbXYp1CTHFLDMOW+zQK3T5AXgfWd7vjUeh8/k1?=
 =?us-ascii?Q?/XBsxpiW53kzvRIpwZ5zX0GlP7JdHHXXzxol/pO+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	295CJoKQH0a4odHQ3EYrO1Ng7p88WZAfPHhWiQC5elqKmRQ7JcgIdRf9evXnRxNBK2Zt97v62SeAjlcM5k+dyfRy9YL2JEJEVXG/exJK656uc+wRfwIHUGMqH82Rvq8x9IcGxP4py4SieH/4TsVoh0gqSFBeqLlA4P6PjySZbE0PXA5OAKDiIENuqrWiaIHk9m5e/JtTUZ6vRLdN+hN4yWsq7DbINPgVL+DgjXHHfx2ptCaQRxIrjpscZAv8zinGmnqkLArLhQVxzHoo3m4hL61g+So9U01rZtxgKcMWL+8QGkA3qHIdrVBz2ClTlnO47oS235vRgFndC/xBqwIIIJGzSlfDwfkMzna8SruRCV1gI8Z7W8395tLqZrH8ssgnraMZa/CY3Ohb1q3OyrZ3oMpmCQrN0gDtdL0YoAgyK+J5MjoavLG0F/eobtaeZpVcWoXVcPhzQcMEoTa5hyjdcepqVKbMoyeRfzLAlKcntjCsbXKA8WujkH6KLwvZI7wL5MspdB0q21lvKqEuArPv1to3JRL2zvC9xPM4aTuWwdTEoZuppmDqN0x/1VJhzVFfsV7yf/ZLtd+l5ORZHfQy6M9sTGSZE2POEZj6IrWNFVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20378b6a-e52a-448f-bc55-08dcae5c83dd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 16:52:35.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvQ2NAxnetkqf0f2r34Tt5lHrAcYjvzQRk4hwcg4v5U9p48HqMMGNb/2tTRX5nFjGnXuku8ExouHKKw3dFc+dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270114
X-Proofpoint-GUID: MPu9SqNDvJvmeTGcjQx88AJRpwt8YUGk
X-Proofpoint-ORIG-GUID: MPu9SqNDvJvmeTGcjQx88AJRpwt8YUGk

On Sat, Jul 27, 2024 at 09:46:34AM -0700, Dai Ngo wrote:
> 
> On 7/24/24 10:01 AM, Sagi Grimberg wrote:
> > Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
> > stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
> > Stateid and Locking.
> > 
> > In addition, for anonymous stateids, check for pending delegations by
> > the filehandle and client_id, and if a conflict found, recall the delegation
> > before allowing the read to take place.
> > 
> > Suggested-by: Dai Ngo <dai.ngo@oracle.com>
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > ---
> >   fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
> >   fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
> >   fs/nfsd/nfs4xdr.c   |  9 +++++++++
> >   fs/nfsd/state.h     |  2 ++
> >   fs/nfsd/xdr4.h      |  2 ++
> >   5 files changed, 80 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 7b70309ad8fb..324984ec70c6 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >   	/* check stateid */
> >   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
> >   					&read->rd_stateid, RD_STATE,
> > -					&read->rd_nf, NULL);
> > -
> > +					&read->rd_nf, &read->rd_wd_stid);
> > +	/*
> > +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> > +	 * delegation stateid used for read. Its refcount is decremented
> > +	 * by nfsd4_read_release when read is done.
> > +	 */
> > +	if (!status) {
> > +		if (!read->rd_wd_stid) {
> > +			/* special stateid? */
> > +			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
> > +				&cstate->current_fh);
> > +		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
> > +			   delegstateid(read->rd_wd_stid)->dl_type !=
> > +						NFS4_OPEN_DELEGATE_WRITE) {
> > +			nfs4_put_stid(read->rd_wd_stid);
> > +			read->rd_wd_stid = NULL;
> > +		}
> > +	}
> >   	read->rd_rqstp = rqstp;
> >   	read->rd_fhp = &cstate->current_fh;
> >   	return status;
> > @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >   static void
> >   nfsd4_read_release(union nfsd4_op_u *u)
> >   {
> > +	if (u->read.rd_wd_stid)
> > +		nfs4_put_stid(u->read.rd_wd_stid);
> >   	if (u->read.rd_nf)
> >   		nfsd_file_put(u->read.rd_nf);
> >   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index dc61a8adfcd4..7e6b9fb31a4c 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> >   	get_stateid(cstate, &u->write.wr_stateid);
> >   }
> > +/**
> > + * nfsd4_deleg_read_conflict - Recall if read causes conflict
> > + * @rqstp: RPC transaction context
> > + * @clp: nfs client
> > + * @fhp: nfs file handle
> > + * @inode: file to be checked for a conflict
> > + * @modified: return true if file was modified
> > + * @size: new size of file if modified is true
> > + *
> > + * This function is called when there is a conflict between a write
> > + * delegation and a read that is using a special stateid where the
> > + * we cannot derive the client stateid exsistence. The server
> > + * must recall a conflicting delegation before allowing the read
> > + * to continue.
> > + *
> > + * Returns 0 if there is no conflict; otherwise an nfs_stat
> > + * code is returned.
> > + */
> > +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> > +		struct nfs4_client *clp, struct svc_fh *fhp)
> > +{
> > +	struct nfs4_file *fp;
> > +	__be32 status = 0;
> > +
> > +	fp = nfsd4_file_hash_lookup(fhp);
> > +	if (!fp)
> > +		return nfs_ok;
> > +
> > +	spin_lock(&state_lock);
> > +	spin_lock(&fp->fi_lock);
> > +	if (!list_empty(&fp->fi_delegations) &&
> > +	    !nfs4_delegation_exists(clp, fp)) {
> > +		/* conflict, recall deleg */
> 
> I don't see how we can have a delegation conflict here. If a client
> has a write delegation then there should not be any delegations from
> other clients.

A delegation conflict is possible if the client is using an
anonymous stateid to perform the READ.

One thing we could perhaps do is add support for the use of
anonymous stateids as a separate patch. Sagi, how necessary is
support for "READ with anonymous stateid" for supporting WR_ONLY
write delegation?


> > +		status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
> > +					NFSD_MAY_READ));
> > +		if (status)
> > +			goto out;
> > +		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
> > +			status = nfserr_jukebox;
> > +	}
> > +out:
> > +	spin_unlock(&fp->fi_lock);
> > +	spin_unlock(&state_lock);
> > +	return status;
> > +}
> > +
> > +
> >   /**
> >    * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
> >    * @rqstp: RPC transaction context
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index c7bfd2180e3f..f0fe526fac3c 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> >   	unsigned long maxcount;
> >   	struct file *file;
> >   	__be32 *p;
> > +	fmode_t o_fmode = 0;
> >   	if (nfserr)
> >   		return nfserr;
> > @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> >   	maxcount = min_t(unsigned long, read->rd_length,
> >   			 (xdr->buf->buflen - xdr->buf->len));
> > +	if (read->rd_wd_stid) {
> > +		/* allow READ using write delegation stateid */
> > +		o_fmode = file->f_mode;
> > +		file->f_mode |= FMODE_READ;
> > +	}
> >   	if (file->f_op->splice_read && splice_ok)
> >   		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
> >   	else
> >   		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
> > +	if (o_fmode)
> > +		file->f_mode = o_fmode;
> > +
> >   	if (nfserr) {
> >   		xdr_truncate_encode(xdr, starting_len);
> >   		return nfserr;
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index ffc217099d19..c1f13b5877c6 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -780,6 +780,8 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
> >   	return clp->cl_state == NFSD4_EXPIRABLE;
> >   }
> > +extern __be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> > +		struct nfs4_client *clp, struct svc_fh *fhp);
> >   extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> >   		struct inode *inode, bool *file_modified, u64 *size);
> >   #endif   /* NFSD4_STATE_H */
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index fbdd42cde1fa..434973a6a8b1 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -426,6 +426,8 @@ struct nfsd4_read {
> >   	struct svc_rqst		*rd_rqstp;          /* response */
> >   	struct svc_fh		*rd_fhp;            /* response */
> >   	u32			rd_eof;             /* response */
> > +
> > +	struct nfs4_stid	*rd_wd_stid;		/* internal */
> >   };
> >   struct nfsd4_readdir {

-- 
Chuck Lever

