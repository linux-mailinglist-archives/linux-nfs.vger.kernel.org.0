Return-Path: <linux-nfs+bounces-3065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D88B5EA4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CEC1F22D5A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C8983CB7;
	Mon, 29 Apr 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eif9EaHY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cPj4EZAU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAC14A8D
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407186; cv=fail; b=iXs4UPN58a92RQeCroyKZPeTAy5fStl0twhPSbErW5m3Dvj9lxSYsAbmaiKmrbp4tmeb2N5U35LaXrbSTYhdOTo+1aCfkrfFhDm00D22ofZoNDRr3mj2ebsvmq50Snu15xEZ9rhKv3hkQUMQq1aG3kQM1Fut94mFidL8/EpPSRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407186; c=relaxed/simple;
	bh=GVVlb/5FedQRsrB4l7Bib6GAvZZKHKR5UhUL5LJjHhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jz+cKQBFrAixl5Q3+7sXi8fy512socNHMaQ0tNByojukoepzXEmYiIe5yvM5G69b5p+v6+XE4DFPj9czTbKMDCyLdMPS7xlSt6xX/h2uELnaIEu+yYpIRGHFxF2xJVl9Z4nk1i5V7Wnjfn4gBBIIY/CnQjydcmbnRgrlNNms/oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eif9EaHY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cPj4EZAU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TFmlTI021733;
	Mon, 29 Apr 2024 16:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=SFkNfXyuYYFNIjM3dPve5ZDlN+L2civPjj4xg9HuQgE=;
 b=eif9EaHYxixKuNJ8oaQy3BBTJiGlUXMX4uG5zV7ppS/DBnNxMYbn4x99Z4Yqry/30u85
 siT/pZMh50QXLJQAg6L0lvkQHNBN1HMvMj+3CxYVGAShkR/qoA6LcnMS4XPbe66Y8yXB
 AnQveVLZ9/WY9SBKYWXYyq+A1mcbW8hFarUNRchwqNETfAyX07loPxm5jjMpRLUfStr8
 DhTy8KxsgvcTfiTVWHABDgJ/OluPIQUGNvm2jHQ06d++xf0e9wm+fTWEstBnuBwm9+Ic
 cicn6/Gqtflawyeflhpt7rKRW8ExH6A7J1e0zpLk1U1rbwqhaR+m15gZueKD80/emWeF fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54b0cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 16:12:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TFNjjN033276;
	Mon, 29 Apr 2024 16:12:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6anmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 16:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2QYgrrOrOSju8zvOCKcogupT0KO88dERpleKE5kGs/ErfXRzEVZcGKktCeZxU5956GY6V1MGv1O3V4c31/rkc3+Rwx1mIWaaa8jclXookmfiTATDlzT1L9EWmU9W3l/HGPw1dl0m2Gqd3oMxEKxi+9qQS1sklniEbui+CDOBdQbs3//ZGom7919ytRFnO6v/CdlGxqekdaqntci/dgpt3Sr9EOd92/bQb5jnF5Sb5Ale+I4aRLpdEkTKZVOX7PQXqNQFokOE5I14hox3dHSd+gHG8d3Sx407/jVRy6vwcCcNxajPmD8qN+IfV88txLrxWP5i9aYDkmTWWvMteGCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFkNfXyuYYFNIjM3dPve5ZDlN+L2civPjj4xg9HuQgE=;
 b=kx/YjasQFPFKtKYg0+r4iCXzFJFq9eVn0S0o/FmPXgs2v3PDydrso2K+aVwykeBg9d4Xi5STGv/Cn7zNaOPm48lrCFZHkIyclMXnBt8AHKM4hJvMaSFDo2qe2ZTsmCCVVrdfzeGIYuWeCd9TDZ65vgGm1A/XnVRFlylnMqK4hBYE9McOO41NxZeBUhtWpHxduaLtdjtcUkpmN9smWyqRol5bM8AcXnWn88uAFAzhrJywDIHDlNrtbc0vIkhyCROSEyevedG/gvniT3XrN5OB0BFVp5Nuv3r/x6x/Mb6lURq0D88wOsL9w5PNEEGmlk3WnDCUhN10LAs6bVoQzc6bbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFkNfXyuYYFNIjM3dPve5ZDlN+L2civPjj4xg9HuQgE=;
 b=cPj4EZAUC1TqyINoG5HdRhGJlzBOPx8Z72UuNxPCZhJkVePYeCdIHBbo+vDchd+dseHDU7jhPKNVIIDiSr+Bj6WkPeO5jquUqtRBgkUDdiq2gQKvSyzChB72dRF+GtwdZJm9ByU3VnE8Sb0OwBYRxV5w3f3xPJDj9rF4Pk/CDjk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 16:12:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:12:40 +0000
Date: Mon, 29 Apr 2024 12:12:37 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: cel@kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Message-ID: <Zi/G9dtc9VVCnEZA@tissot.1015granger.net>
References: <20240429151632.212571-6-cel@kernel.org>
 <20240429151632.212571-10-cel@kernel.org>
 <CAN-5tyH2e7uR_GN3vYp201h2U83gra=U8a+57Ughk1BfpRGZaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-5tyH2e7uR_GN3vYp201h2U83gra=U8a+57Ughk1BfpRGZaQ@mail.gmail.com>
X-ClientProxiedBy: CH2PR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:610:56::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 690253b4-5d06-4ef1-1175-08dc686731ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YmdtT2JrS2dMeEJTVE9XRTkwcStzZnJvZ3ZzQU5oSTBkSTFjQmZKY1p6U2R5?=
 =?utf-8?B?VmhDQmpzM2svSml3T2dIeXVBUEhHWm5qcHY5OStZTXRSbml5R0p3R2Nhbmpk?=
 =?utf-8?B?aVBrdE9pVnVvUVo1QVBsRS9CS3Z2S2JpQjlDYm4vNDBtSVc1Y2ptekxVMVlL?=
 =?utf-8?B?Uk54SmJTU1MyN1JiTERuSDUzMm9HcWF5bzFmVDZGenVNQnd0RmNMWnhDVVN1?=
 =?utf-8?B?eHlZRTg1T21zZ3Qvci84cDdMRytBK05mSHU5VXoxR2RUaGVqU3FYdHZQb2dk?=
 =?utf-8?B?RmdJSEgrMXVzQkpqcnRlOC9mZDUxK3l2ZW42YktiUHlkT01jN1dIbzIyYU9L?=
 =?utf-8?B?NjcrMEpyZnV5VUh1YUxLVk9CV2JxZ1V5azBuWlE4SFhsMEgyNkVLR2VTRTFs?=
 =?utf-8?B?ZENPbkRFK3VKbHBrbmozaUw3VytmN2lJenJubkxlRGZodHdwczJNc0pQMTUr?=
 =?utf-8?B?ang4ZmlTMFJRbnJFK2JhTEtPdG56TFAzYjFLckIydGFiMi9xMDd3T2QraWNO?=
 =?utf-8?B?Uk1YTFBNd2xUSis5Q3VNT0VpYXcyK1pRaEdMSFVJdXdXZXRUOGF2cGdVSDFZ?=
 =?utf-8?B?L20wTlVYN2V1cHhCcm9pMjk3TmQyS0hBTHJHQXdDNFlJc25mbFdmMkpzYlpq?=
 =?utf-8?B?Zi9peDNFSkZwVmtlNkNNNVVXVml3T2hQYVV6RldjcWtzZk1NWERqb0FybmNI?=
 =?utf-8?B?MWFvYTZkazkwSTB2OGpVNjFaM3k0Rll0NE9EVmZ1REFQY0UrY2o4QjNROUZL?=
 =?utf-8?B?Z1BOckg5L3VybVZzUkQwTnF5RFNBaVlubllTWmdYVmVZR0NyOUlWalNCYklI?=
 =?utf-8?B?UDh3VUFHUXBKVVUzbDJPR0U4T05QcHRKNnovYmUxWDdiUTR4RUxML3A2Q2Ns?=
 =?utf-8?B?emtySTU1dFFVL25qNnpIYkNscmtucUh4N2YvOXpPbzFzb0pRQStjMjAzZkZY?=
 =?utf-8?B?OGoyVzJTc0QyR0NhTEI4QVk5aXRpeGVKbEtlc1Bhc2tsKzVGRHgvSnFzZnVH?=
 =?utf-8?B?Z2JaNElLZXdYcExseWxwL2Rpd2NoYWRJRG9TaUNVNlJ3b2pMN0dNRE9SL1dU?=
 =?utf-8?B?WG53Z2FNTENMRkxYMHZ2YUo3dG5yQmc2bzFBK1FSRE55VW0vVzJpcVB1YWpL?=
 =?utf-8?B?TGZoeWMzNTc2UjdKVm1xODYreUorenJuWmY3QVZiM3h3SXgwd1VXclFaUktn?=
 =?utf-8?B?V1VwcGlzcGI0eURETk5GczZxdmc0Z013WHFEZHpmZkNpN044TDkycmR1dlBo?=
 =?utf-8?B?Mlg2Z2tnY3ZwY29YTEIzVGV5MDNyNG8waXFpNTJnODEyZmJ0TW4xenJYMENH?=
 =?utf-8?B?b0tGcnhjQnVRWmUzU1J2VG1Da1BXb01UaUZmZFZkNHNDb2NQM2RUazl5VHla?=
 =?utf-8?B?bFBSS1NCZWFyS2tnT2Fac2Nsa25xMEFNV1BnYUdqREs1Sm04NDZsTkduYkNo?=
 =?utf-8?B?a3duWWtxV0VyL2FyNDBHMjQ3bk9NOEovZzNCR3l4MGpMKzlWbWlSYUF1WFRM?=
 =?utf-8?B?Y01mNElTZCt5dUtpMHB5VGJnMU9EZ2kzdkx4bUZmWlhpekc0QkVsOXlxc082?=
 =?utf-8?B?QkRhT01ES0tTY00wVldNZEM1OGl4VExPRTg3U1VQMDFERmNRUnBWb1VCeG1l?=
 =?utf-8?B?NkNxRVFaa1M0TnordzZ3SWdrK2c2V1BsMVRTaGppMGhhclp1Q1l2bFdoWXhi?=
 =?utf-8?B?NzhZUFNWbEkyV2xibVRJU2g3djZXVnoreExzdWJyNUYrSHpJUGFOU2tnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1dCbGNOdTVXSnFONXZtOXZaVTluc1BwUk1iYmZ4d3hOTzNJN1l0QlBIazlJ?=
 =?utf-8?B?cWd0YWh6Q051QUIyY0pFUGZNZmprNGxsNldLVEJZc1dmS2RkVG9NWFdFdjhI?=
 =?utf-8?B?OE5BNVpqdVJlZE9uUytiMEc0VDZDUkVlcm0wZmhrN0FuZ0JDYlpqT1dTcGZJ?=
 =?utf-8?B?cWEwY0JLNlpaUC9haVRwbDVIem41V0VNeE9VcWVwOWc2RTJFbTV2TGhPaEpG?=
 =?utf-8?B?aUJ2TG1xNnlDazFpbjNocTdyb3dOODRBbHpodkpVbVRqWVMzK3k4VHRla0FP?=
 =?utf-8?B?YUJ5eHpNS2hYUlVnbjdpNXVrSzEyd2VWclE2NGlJazV6MGw2S3JhWjgxb0t3?=
 =?utf-8?B?VC9yWWpaK1MrMWlPd2UxNkRIdHNDYW1jd3VCSVBCbUZHc1BtNlFWekhqWEFs?=
 =?utf-8?B?ZktLNVRVWW5HNHZybU5iNXB6Tkk4Y0tqQlBUUUMyY1ZTU2I1N05IYzh0c09R?=
 =?utf-8?B?QnlobHVQU3FHYkxnQ2FzdkR3VTlMdjRPQ0YyWldWdFpkUXAxZU56YTIvejZs?=
 =?utf-8?B?UGhMd1U5c2hUZjBQbWFScU5Gb3hSTTdSQzZqRTNsRnVaWUtndkxMLzdaa1Vz?=
 =?utf-8?B?VStESmdkZXpWaHdUbGxQY0FqRUx5WXg5Z25EdVllSy8wSHZtM1B2Vk5JRlVF?=
 =?utf-8?B?eG1tRHZra216aHBJZFYraXJKQUhZRkxVdE80VFJBQmVyd2ZDMjRsSXZvT3k3?=
 =?utf-8?B?RUQwRm5Fd0NtaVJxcXFKTjFPeUdYdndLNUdYOXF4M0NHc2cwL1NJMTFVTFBm?=
 =?utf-8?B?ZERpclFkSWwvdVpEUWxaODBvbTdXdExYTDRSdGpCL3p4czlKd3RWcVUxSVZF?=
 =?utf-8?B?bEhXOHdxMmx0U2dlUS9PUTgrQlp5VG1ibGo1MG1sWHJhYk0vaG1xZC8xclJW?=
 =?utf-8?B?Q0RCN2lBZ1dwcGd3VXFvZ3FpZHV0aDIvc0o5SkoxMW1GQzJWWlpQM1VmVXpO?=
 =?utf-8?B?blV6OFZBVElmWC96Z2ZISEFpM09VT0FCOTV6Y0JpSXN6ZCtHd1lVaVYrVEJQ?=
 =?utf-8?B?V2lEWUdrSk5OU2NJYmtPenU5UlQwb3QyNHc4amNFOG1nNmRIRDRSV0FISFRC?=
 =?utf-8?B?OHB0MVNxZEtwdTlSM1JmRzBpRms0bWZzZi8yVnFZdHR0NnEyVGljOUltSlBG?=
 =?utf-8?B?SkZKY0FCMkFKSCsyYmMxUlBQNFhPSWN1TUMrcnh4bDhoS1lLWEt6cmIydkJQ?=
 =?utf-8?B?QzUwSCtXV0NsMXFObHlSRUVqek5acjNoZVh1R0h2TWR4OFZQVTJqTm1ZVk9u?=
 =?utf-8?B?RTNHREkzckNMREs5Q1hoa1ZMSmxDNkJNRU12UEJwanU1ZEF5TUlOWGNCazRo?=
 =?utf-8?B?eWNuWk9FVVhKNmVodFQ5SE9oUkU5RHBVSWpqeENpK1o1a3kxN0U3TmwwOFhY?=
 =?utf-8?B?WFhnWW9UQmMzM0JEWVBIY0IvcG5pckRwSlR0WGdxUFJiNTRsQ3NQb01wbXJk?=
 =?utf-8?B?OEpFdzN3a1VINWxTVERCVlp5ZVJIK0xJdEdoMUZLdmxRM3NjdEplTTUwd1NU?=
 =?utf-8?B?em5kUHczbUdLMXFxZm5zV1F3QVhsNHJpWTBMK3gyZEpkOGNKMkF2VWdNZUJq?=
 =?utf-8?B?UUEzYU4yQVFMUzlObit6dmRMODR6aURvL2RpdjEyNEJRQlM0UmVLQ2JFaXlS?=
 =?utf-8?B?SjdSWXd5VXlndkp5Tlh3R2lNMHNNTm44Rk9FeUlEakg5Q29OVjVNaHFDOTlN?=
 =?utf-8?B?MWVlayt2VmpwSkNCRkxuWkFCNkxLWGR5WGFvN1lZbFFTb3B6NzNSOTNDZDNk?=
 =?utf-8?B?eXl2MmZvcHhZakNFczlRUGZvSVdBYVJDemdSRDYvSUxPdDB5bHBqTThvVEZo?=
 =?utf-8?B?Mld2dGRtd3lHTXREQzc1eGhDcFdMN2F2VFlvQ1RoL1N5RGtZODlrU1lzcDlK?=
 =?utf-8?B?Sk1pYmZ4TlB5dEo5aFFyckZmK1h5U05VTG82NEhSaFRhaXBaa1kyVmVtNmFM?=
 =?utf-8?B?aE5CMENkczAxSG5JS0lPZzNGamFwK2crWXhEdkdINThlMTN3WXQvNWE3RHJH?=
 =?utf-8?B?K0Z2ZkZwZzh2SnhLUTBEN0dSYWJmT0JncVNNa284S05RYU5oenAxZ1BoVUhv?=
 =?utf-8?B?OUpkSk82bjk3blgwUXhMN0NMWmRjaTZJZXY0cUkyQkNzVk90WU02MFhXeFpt?=
 =?utf-8?B?cmx1VTFOWEFRQks4WGZiQXIxbUFkdzA1b284K3FidFlHenhxV1hFWEowTmtS?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sypq4vCz3Ssyj3yp4td/mICO71t5IpNyFz2239ykFy/siSRvefMR4cDWmxF5/Tk5BEIciU3UibGsJxwPmiuj8kUD0+QaC0GbMX9DdBvZk1V+ul32jao7hrslYQo12wOzm2lMT7LCAiQABG/Xwmyoi5XwwVGkrna2agHFIEWrGhAdstUKFeSckpvsJrWDgnWUNv1zyZvMGbH1INZW4cmZgsUHWdHcKFLXqHywWUPt+QhWAmFq/0hdxeYL7QlkXFKEayweWDq0OJ/RJf2sMXriSUnmF3qK2unmCF8wAM01PPQ08Jy8skSS3VBhjNMoO5rRRtqXR49f5kTLsNs1QEPulVPWc2/9U/3sNDUjlhdJndcK6w91lpr3iTL4iczUQHe+C0rtTF5y4CIY7p3d417ZvNluL1rXGSl0c0eDjfoGBqzDtne7dc/SWs3I6BCTqB3pAAmQ0OnF6ARrnBiuVpCUGpwsexBRNXxrDbQ4VOKMmnjP01BSn80ZC+qcwqyYHB0k3uweWoKAdOlzi+60WWOwYT9aOu857j9xPz7ruM3aNEz/LVKWeS2g2zRwGJdmKMoxJ9+98lZmEzaQRktMwqHhuEwSE+vAZFoCgkGzlSNBJEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690253b4-5d06-4ef1-1175-08dc686731ba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 16:12:40.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fr5NE31A55KbuYTExpJ/vmmMNLr+6hVdROiqA557PA1pOxBDQ25gu3K7vARVkObMCMnRSowHYgnLtvXjQepXyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290103
X-Proofpoint-ORIG-GUID: QX9b8UNOh0sPVV0QaH1J-PxvWFljYLjF
X-Proofpoint-GUID: QX9b8UNOh0sPVV0QaH1J-PxvWFljYLjF

On Mon, Apr 29, 2024 at 11:35:20AM -0400, Olga Kornievskaia wrote:
> On Mon, Apr 29, 2024 at 11:22 AM <cel@kernel.org> wrote:
> >
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > We've found that there are cases where a transport disconnection
> > results in the loss of callback RPCs. NFS servers typically do not
> > retransmit callback operations after a disconnect.
> >
> > This can be a problem for the Linux NFS client's implementation of
> > asynchronous COPY, which waits indefinitely for a CB_OFFLOAD
> > callback. If a transport disconnect occurs while an async COPY is
> > running, there's a good chance the client will never get the
> > matching CB_OFFLOAD.
> >
> > Fix this by implementing the OFFLOAD_STATUS operation so that the
> > Linux NFS client can probe the NFS server if it doesn't see a
> > CB_OFFLOAD in a reasonable amount of time.
> >
> > This patch implements a simplistic check. As future work, the client
> > might also be able to detect whether there is no forward progress on
> > the request asynchronous COPY operation, and CANCEL it.
> 
> I think this patch series needs a bit more nuances
> (1) if we know that server doesn't support offload_status we might as
> well wait uninterrupted perhaps? but I can see how as you mentioned we
> might want to measure no forward progress and cancel the copy and
> fallback to read/write.

The client doesn't know whether the server supports OFFLOAD_STATUS
until the first OFFLOAD_STATUS is sent. So at least /one/ of those
waits will be of the timeout variety, no matter what.

We can mitigate the cost of waking up periodically by making
NFS42_COPY_TIMEOUT longer than 7 seconds. That's just a number I
pulled out of the air.


> (2) we can't really go back to the "wait" after failing a
> offload_status as the cb_offload callback might have already arrived
> and I think we need to walk the pending_cb_callbacks to make sure we
> haven't received it before waiting again (otherwise, we'd wait
> forever).

IIUC the wait_for_completion() family of APIs does not sleep at all
if the completion has already been marked "done". So in that case
wfc() should just return a positive number and execution drops into
the "copy complete" code.


> (3) then also there is the case where we woke up and sent the
> offload_status and got a 'copy finished' reply but we also got the
> cb_callback reply as well and the copy things need to be cleaned up
> now.

The callback reply should just wake the completion, even though
there might no longer be a waiter, and then free the call data. That
seems OK.

I think what I missed is that the call data needs to be cleaned
up when we are sure the CB_OFFLOAD was lost, otherwise it leaks.
Will need to think about that. How is that done if the client
detects a server restart?

Also nfs42_proc_offload_status() needs to distinguish between "still
running," "all done," "bad stateid," and "no answer".


> > Suggested-by: Olga Kornievskaia <kolga@netapp.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218735
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfs/nfs42proc.c        | 100 +++++++++++++++++++++++++++++++++++---
> >  fs/nfs/nfs4trace.h        |   1 +
> >  include/linux/nfs_fs_sb.h |   1 +
> >  3 files changed, 96 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index 7656d7c103fa..224fb3b8696a 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -21,6 +21,7 @@
> >
> >  #define NFSDBG_FACILITY NFSDBG_PROC
> >  static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
> > +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid);
> >
> >  static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
> >  {
> > @@ -173,6 +174,9 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
> >         return err;
> >  }
> >
> > +/* Wait this long before checking progress on a COPY operation */
> > +#define NFS42_COPY_TIMEOUT     (7 * HZ)
> > +
> >  static int handle_async_copy(struct nfs42_copy_res *res,
> >                              struct nfs_server *dst_server,
> >                              struct nfs_server *src_server,
> > @@ -222,7 +226,9 @@ static int handle_async_copy(struct nfs42_copy_res *res,
> >                 spin_unlock(&src_server->nfs_client->cl_lock);
> >         }
> >
> > -       status = wait_for_completion_interruptible(&copy->completion);
> > +wait:
> > +       status = wait_for_completion_interruptible_timeout(&copy->completion,
> > +                                                          NFS42_COPY_TIMEOUT);
> >         spin_lock(&dst_server->nfs_client->cl_lock);
> >         list_del_init(&copy->copies);
> >         spin_unlock(&dst_server->nfs_client->cl_lock);
> > @@ -231,12 +237,20 @@ static int handle_async_copy(struct nfs42_copy_res *res,
> >                 list_del_init(&copy->src_copies);
> >                 spin_unlock(&src_server->nfs_client->cl_lock);
> >         }
> > -       if (status == -ERESTARTSYS) {
> > -               goto out_cancel;
> > -       } else if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
> > -               status = -EAGAIN;
> > -               *restart = true;
> > +       switch (status) {
> > +       case 0:
> > +               status = nfs42_proc_offload_status(src, src_stateid);
> > +               if (status && status != -EOPNOTSUPP)
> > +                       goto wait;
> > +               break;
> > +       case -ERESTARTSYS:
> >                 goto out_cancel;
> > +       default:
> > +               if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
> > +                       status = -EAGAIN;
> > +                       *restart = true;
> > +                       goto out_cancel;
> > +               }
> >         }
> >  out:
> >         res->write_res.count = copy->count;
> > @@ -582,6 +596,80 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
> >         return status;
> >  }
> >
> > +static void nfs42_offload_status_prepare(struct rpc_task *task, void *calldata)
> > +{
> > +       struct nfs42_offload_data *data = calldata;
> > +
> > +       nfs4_setup_sequence(data->seq_server->nfs_client,
> > +                               &data->args.osa_seq_args,
> > +                               &data->res.osr_seq_res, task);
> > +}
> > +
> > +static void nfs42_offload_status_done(struct rpc_task *task, void *calldata)
> > +{
> > +       struct nfs42_offload_data *data = calldata;
> > +
> > +       trace_nfs4_offload_status(&data->args, task->tk_status);
> > +       nfs41_sequence_done(task, &data->res.osr_seq_res);
> > +       if (task->tk_status &&
> > +               nfs4_async_handle_error(task, data->seq_server, NULL,
> > +                       NULL) == -EAGAIN)
> > +               rpc_restart_call_prepare(task);
> > +}
> > +
> > +static const struct rpc_call_ops nfs42_offload_status_ops = {
> > +       .rpc_call_prepare = nfs42_offload_status_prepare,
> > +       .rpc_call_done = nfs42_offload_status_done,
> > +       .rpc_release = nfs42_free_offload_data,
> > +};
> > +
> > +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid)
> > +{
> > +       struct nfs_open_context *ctx = nfs_file_open_context(file);
> > +       struct nfs_server *server = NFS_SERVER(file_inode(file));
> > +       struct nfs42_offload_data *data = NULL;
> > +       struct rpc_task *task;
> > +       struct rpc_message msg = {
> > +               .rpc_proc       = &nfs4_procedures[NFSPROC4_CLNT_OFFLOAD_STATUS],
> > +               .rpc_cred       = ctx->cred,
> > +       };
> > +       struct rpc_task_setup task_setup_data = {
> > +               .rpc_client     = server->client,
> > +               .rpc_message    = &msg,
> > +               .callback_ops   = &nfs42_offload_status_ops,
> > +               .workqueue      = nfsiod_workqueue,
> > +               .flags          = RPC_TASK_ASYNC | RPC_TASK_SOFTCONN,
> > +       };
> > +       int status;
> > +
> > +       if (!(server->caps & NFS_CAP_OFFLOAD_STATUS))
> > +               return -EOPNOTSUPP;
> > +
> > +       data = kzalloc(sizeof(struct nfs42_offload_data), GFP_KERNEL);
> > +       if (data == NULL)
> > +               return -ENOMEM;
> > +
> > +       data->seq_server = server;
> > +       data->args.osa_src_fh = NFS_FH(file_inode(file));
> > +       memcpy(&data->args.osa_stateid, stateid,
> > +               sizeof(data->args.osa_stateid));
> > +       msg.rpc_argp = &data->args;
> > +       msg.rpc_resp = &data->res;
> > +       task_setup_data.callback_data = data;
> > +       nfs4_init_sequence(&data->args.osa_seq_args, &data->res.osr_seq_res,
> > +                          1, 0);
> > +       task = rpc_run_task(&task_setup_data);
> > +       if (IS_ERR(task)) {
> > +               nfs42_free_offload_data(data);
> > +               return PTR_ERR(task);
> > +       }
> > +       status = rpc_wait_for_completion_task(task);
> > +       if (status == -ENOTSUPP)
> > +               server->caps &= ~NFS_CAP_OFFLOAD_STATUS;
> > +       rpc_put_task(task);
> > +       return status;
> > +}
> > +
> >  static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
> >                                    struct nfs42_copy_notify_args *args,
> >                                    struct nfs42_copy_notify_res *res)
> > diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> > index 8f32dbf9c91d..9bcc525c71d1 100644
> > --- a/fs/nfs/nfs4trace.h
> > +++ b/fs/nfs/nfs4trace.h
> > @@ -2564,6 +2564,7 @@ DECLARE_EVENT_CLASS(nfs4_offload_class,
> >                         ), \
> >                         TP_ARGS(args, error))
> >  DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_cancel);
> > +DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_status);
> >
> >  DECLARE_EVENT_CLASS(nfs4_xattr_event,
> >                 TP_PROTO(
> > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > index 92de074e63b9..0937e73c4767 100644
> > --- a/include/linux/nfs_fs_sb.h
> > +++ b/include/linux/nfs_fs_sb.h
> > @@ -278,6 +278,7 @@ struct nfs_server {
> >  #define NFS_CAP_LGOPEN         (1U << 5)
> >  #define NFS_CAP_CASE_INSENSITIVE       (1U << 6)
> >  #define NFS_CAP_CASE_PRESERVING        (1U << 7)
> > +#define NFS_CAP_OFFLOAD_STATUS (1U << 8)
> >  #define NFS_CAP_POSIX_LOCK     (1U << 14)
> >  #define NFS_CAP_UIDGID_NOMAP   (1U << 15)
> >  #define NFS_CAP_STATEID_NFSV41 (1U << 16)
> > --
> > 2.44.0
> >
> >

-- 
Chuck Lever

