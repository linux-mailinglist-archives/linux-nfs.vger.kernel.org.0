Return-Path: <linux-nfs+bounces-2755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72388A1584
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 15:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2C11C21B5C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7F14D2B2;
	Thu, 11 Apr 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WxI0VglP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oMBh1m2x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2B14D451;
	Thu, 11 Apr 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842097; cv=fail; b=otbLFpEpNMRjMJizov7I86OUVnl4x/R9GRGmjRGaRETNZIRHMckvJI9InGPwmgTsROuacmecFyoINh7HBKGTUCtjnT8EjjAk11pbJtXE0KSe8wuvofXBfJWlEUDGVActaJ5oKWnoKlfp9yTOPa9BXgaTUhg2f/mLzzTFKLSWtZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842097; c=relaxed/simple;
	bh=3U0QTxPEfZ4Xp1IeyE+EF7j2MANQoen+KwPYCNWUGXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ufphC5euvtCSMtL6wZiNKx6cP3y9P/2oT/Pl3Q7OlpjjKLHXtcgII2WebVDu+1eWnyvraJe/nOUFZE22FP3QRMwv/VFNJuyIGUlvzD0WzkhqhmM6aSHjZwtrXdnXUdfxVnaayPvY+I2nM51pOx1eRLm0/i3eDoCPGEWg2mdNj5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WxI0VglP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oMBh1m2x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BCPueM004063;
	Thu, 11 Apr 2024 13:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=eYmIg8MAyNUyyLB/Iql+7Sopbi5A6NVwJ4jyaUBAtn8=;
 b=WxI0VglPxD9TX1hvhHYzneihQiJaC8QpZvGxNykxm2UelSwH/15Oq+Dt30wUa0imBt7S
 bIuCN0MZmH9vDTrLpOlNfBqmbDNBgK9hUw0gEATz3ZjwYhhcoSb7n2UDbqpw991hPZDb
 WT3tsTPy1rMUyfmOGcEaRw05JiEdN5a6l4tZ6io4/bLjZ+mcI4Ww1tT7Q/fk0KwsZY9p
 9Ru6NVj+rYi8imSeZsS9rB2YOtgQ7l1kD4I1GyeTfhqciJ5/lel9Ovw+H9m1qTnZZFmc
 plETA+SXfrOTqWOYY2RDYOtYUki6CQTVNzWr3Agf/wPZwaJIL1EgcdbIC9zHZEoKFn3l Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw029nc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 13:28:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BCYVFW010765;
	Thu, 11 Apr 2024 13:27:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu9gp7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 13:27:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqtq4B9tB2zkcnniTb/51MZvt7owvrZlsyExK1qNxbGStzmOxqdx2Q4fYs2VqCmzG98Xa/a2uQfRq/zmqL04XqZ1TLZPamnZ7uoMM1FdqtjvkCq4VMFukQq6UiVo8lgcpz9+9cxJYvLc3A2M8xYE/uGiaHwVqKwSRwwvXwl5L3xv6fW6m4YTp/VfnG7A6iidB13MWawgWA2RZdI9gsQImkp6Hr4bcH5vOp4slB/+TPjrnDvWpnVUJlWij0KByuWGXsQK5fdh2OKrOnB4462BquEofnS1OJY9vymgqeziyTj+YmNYGHETi/Bg2HnKBpDqtUcFrgxuKWxZrLihOoSPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYmIg8MAyNUyyLB/Iql+7Sopbi5A6NVwJ4jyaUBAtn8=;
 b=d4GdzEICf9rBcldx8Xo4NiHXu25Wts6nK+YoS3P3V/0xWqfEtPOdGpDM8zT6IT7PiPV0/FjRsyunnwo+4FoXRb5VsnCUD6PonPsh0xymL1Si1RBgs4kHTQcm0bs5xZuzUKigSo0Xq1M5dq7v0/Jd9Cf+5OnFDXsiAVOSYkf1j6suGjzREZZnslThgdX7tUznuG2FfH+4yqN0D+HzpDXTKh8Y9xFUxCIq6YcDINNdykWHaUMLJYT+nFpx30dqRkk8oFLGbgTPY0iwTtSx15mru8/hYR2gSeavwL1ZnPMu2KFpsGUmGjHShKghGyt9BCeF+6EhRgHkBdogVkteaKcN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYmIg8MAyNUyyLB/Iql+7Sopbi5A6NVwJ4jyaUBAtn8=;
 b=oMBh1m2xBm9/1zzdeJ1mX4mWLy/HWXgrMkjwZPvKgheHqghzhGTwHjOrmaIVcpFB0q6YSe54W+MFY8PJEAbszHwznmS1rC+iDIQ1vIyEJz8hm5Nm65Fpcn8fgqPUSQ3iDMrTcviQWtoGx4J+NaXb2+kqpTmj8i3in8qeEABU3ZM=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CY8PR10MB7147.namprd10.prod.outlook.com (2603:10b6:930:75::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Thu, 11 Apr
 2024 13:27:56 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::a541:2604:8ad8:bdf8]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::a541:2604:8ad8:bdf8%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 13:27:56 +0000
Date: Thu, 11 Apr 2024 09:27:54 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFSD: fix endianness issue in nfsd4_encode_fattr4
Message-ID: <ZhflWqUg88h1Cuse@tissot.1015granger.net>
References: <patch.git-0ff58649313e.your-ad-here.call-01712828617-ext-4049@work.hours>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch.git-0ff58649313e.your-ad-here.call-01712828617-ext-4049@work.hours>
X-ClientProxiedBy: CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::14) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CY8PR10MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 61cf8de9-3c67-4adb-1304-08dc5a2b330a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dI8s3oQTDxHMwvRRMfvB2P8NZpVP0pfx7iM5HcBGiwE63VRjKao3gYYGEUrcRAaCdT74fZnPS4cXMTri4dHZmgBSFIO40vwK7zq0IEtx8XLeY9kg7H41azLM0Lj+ue+105NWUqnvMY5dIyxhO3/MKS82NGVwmSSkwVrt/re+m4JGaOQt612K2tUTlNo1A/5uSw6TQHwVvfj4J1c72oNS97PjjqC4MHBqWI5JmrauVQzMYei7yUI2IW3AmTkf5Iccvoo1O6GwEbyQUug/l7sAhplDMSJWXJGfqyvIMPVfBhKJpKfVoDirK/0Nbe30za+RpfSlqhRZnWf5aUPV5A5xP8YK/ATCKNlRD6eC6wsVXrpv8Vsr56X1qcKC9xU9wtaq3yIrdWU9b4c+wgHRB7i1e3D7jxaQ8wZjVFbN43xI4bROkJf1qtCAIyLFJudej+JJfv2cSHD3QMgPHNZsM/4hRHoLNh48AXlntfbAYHCv25owCHAHPk1+eERJ5lJMLLooV9ac+AA1xvbAf/g9+qgPtPttd+k+vDkrbxG4P6nmrWkqFW+qvSiLkQ+G6ul54XuewgISLaUcYvs+7HZ73xTX/0MXLaUJpdpgFkz0B6Pw8H3lcoaA66TU9lacJBx8fb7VpJ62mqeGUjFQ+E8U/8JDGFNAFzp8yMbZxXNfLriW5Mw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YE3QiDE9J1J2Kq18JCqJzm1wv6Hy99p/eeN/aSuMfwRdM8u8bJxz9I3GdrQX?=
 =?us-ascii?Q?JG/VuJVDl0R2FQW++PD4szbKqb/8YGy8mSrKDc1ytyp8xzT27LINSUlIR5SM?=
 =?us-ascii?Q?4/ISoSqSt9hVzrsV4ZXa+g0XUI5Py1cMTaf8B25x0sxkLcYC5fBCkLItFTsV?=
 =?us-ascii?Q?Si/MT1AliT2p+DvfEAG0v9YA0H2NhPi/0H+nv1X4LyMbdwdb72ifIXngp52c?=
 =?us-ascii?Q?K5i0ma2Pcozma6/aAJmIvgL9onLc6mgYWFSZKpRUxmpswV5d+aEUjYgU5SHX?=
 =?us-ascii?Q?1Fl1G+L9HHjm/lYM9ZLtkATw7CNI2Q0DM0r1ARTMLk7A8UQYcaLjcuKINlNv?=
 =?us-ascii?Q?Qo1l8keMWcedSRC3O1T+D7GRqNC1WSGbg3hm9/Jsi+Sn6Ks1FLAxoLVIrZ9G?=
 =?us-ascii?Q?UnNWxfj34qcc+DoiqJnCUUDnIBuW41lWgPyGf5zADSPNroC6VPhukbsiObhf?=
 =?us-ascii?Q?M/RaWXzGtO+WgmE3pZx0hyqwFXPB5W5xm10+xSssP2BMwOygSsXov/ySoRKk?=
 =?us-ascii?Q?3mAMaVJKT4DptSAGjtSloyYEwRgnVyjEuD4D5lsFkHvCYZIiygkRAVXULzXW?=
 =?us-ascii?Q?xnc33E0DufgMuAE5l3mu01ix9aR1ZQ/TUwzHpdZGCgd1DeTewwc7aPfgStPQ?=
 =?us-ascii?Q?+AP2tWwB3LKUOAB2ihX0l7WwOZX+OOK0tM+lq3pj1/tkQGH8pM3DLAU4LpQ7?=
 =?us-ascii?Q?gxWEMO65ohGLlQ89OPjskYPcL1HKWtkzkhpsoXOxrqVNSOmo/9S6qLNH6ier?=
 =?us-ascii?Q?4NnHpI/mupzoosPQUNjRU/At3UHbXag6l6kZLQdrXiiCnJ0QLpBgoy08W/Hi?=
 =?us-ascii?Q?8pn7bdiFZZ7IQuvW96wAqvHquxplwXGCHVUvfwuZu38MIzcMJNjTQfJrDHFS?=
 =?us-ascii?Q?8r9YqN6bMeDCG4+g3okJ+ZcqLtbvgVTbFapwsOmCHSvoqwHT8hrF1aqGY35n?=
 =?us-ascii?Q?mmUZZzQi7dARWc/j2UTDoVNa6s8XWpt/2m67yzfvK6dgpa2HyiGcW2A5QfsS?=
 =?us-ascii?Q?4dWa6DiwXAxJGisq/3UbmWILb/n1qIEXs3MnvTxFPej/oANmvYFrqWSzT5x0?=
 =?us-ascii?Q?+vo7zSXmiz8Z5gNQeh1hwEmyx93LLKT0O3yr9t8wLIzsTjnFvhtDIfXAWmbd?=
 =?us-ascii?Q?AUWNSgWPWzDU5RwG7WKcTXp75TPsg+LsaSCisj+iTCPyI3qeUNRhYpHbIHZN?=
 =?us-ascii?Q?oZREYpd+yyoKYZXxJE410x45QS+nddtqbFTNAZ+BDyLzsujuoS2xZN0mTu1r?=
 =?us-ascii?Q?mL56qN6Vzv3SUUElMWmQpXhD4/fmUeugJULQ9JHs5+AczG/V2/3yM14Oxn9O?=
 =?us-ascii?Q?GFPvhUcydUyJkLT6nTbgoNcEJ3T+DshMOlcdBLBON9tae2yIvRSK6N0LJE9l?=
 =?us-ascii?Q?P8R6eWt3z/XQEZaj/yjcLt/pTs2AwTAe9MTG7fNH7V9kCVQ8O2Yv5CNggjPT?=
 =?us-ascii?Q?5DfhrPlU6/e5D0jG/QDHb4S1OYs+rVkFEs+3XAyw3DFkIYPD81YqISxsjZac?=
 =?us-ascii?Q?ibm9NET1e/VaMTgtoL6NoNpH40TEQQat14a5wgWjej8CWmZXWt9jCrcLcAXv?=
 =?us-ascii?Q?mddO7m0ZwMSwaDOjbWocSRirT4k/7/MbOoyjqH3LX1TbJW38jVzR1MvNfc39?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UN0k8iBBQRICAokclO73AOc2ENeuI9/3HiFQn5VLcLMSkmGHWG3pp9QcZiCXw7bH7WQP3xCSNSwPPmUc6S9qsg8uvdXSBvrJ+8Y99udJeSTxxvP1a8E9C0t417ldWh4gjF5F1gRPCLE49fFDHGAX+Mn9JCh7xJOmUtZfUNgygJb6i1+r7avwi2ShzBkzRgv85JVevo2tpTOkZ0QG2vZBG4mrgBZ4S62q9jv8oiEHztk+l7FjjdhKjfGG7C322uQj3ICC4DJ3ciopyS8A1i7LT6OsmH4oiJCfKOjOFH1w+P9n6toPBxDlKfs3J7fldoLIBmN/XkVjTiq7VAAwKnzVEIgY7sNtzvu8GDK7Pdr3iDCfc52gp5cRfWAWHc/Yypabg/QR6OxaW4rl+Yt8LALQ2woKJ+c7ohselIBkwd7RjqBYbyjILSpIG8JsOAzzedFsCL0GOadAXjbIMbc0Y7KHXNzgJKrkXMNa421eUmlxXHOu2/vifIBsSzontmcUaz5rfnyDytNHaDQrnsaxOKFaOf9/jgvmQdSFWgyVAqJuOUHjI8vGaCR9enmoEoXUoizeX8Q1izV7S1/jvxMq/pTi/NngslhCIfm5Meun8ndT5yU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cf8de9-3c67-4adb-1304-08dc5a2b330a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 13:27:56.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iobgurmVywGds2Ug2UKZkEoOFyWrQ7u3VP8bs4K8+mfKHmmCjxcfplgFxSKwn6i3q+XGF61ZJolKgJs+B9+wlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110098
X-Proofpoint-ORIG-GUID: lImtKuxz4WNXEKZr3RJQS8mKDqcXazOJ
X-Proofpoint-GUID: lImtKuxz4WNXEKZr3RJQS8mKDqcXazOJ

On Thu, Apr 11, 2024 at 11:45:57AM +0200, Vasily Gorbik wrote:
> The nfs4 mount fails with EIO on 64-bit big endian architectures since
> v6.7. The issue arises from employing a union in the nfsd4_encode_fattr4()
> function to overlay a 32-bit array with a 64-bit values based bitmap,
> which does not function as intended. Address the endianness issue by
> utilizing bitmap_from_arr32() to copy 32-bit attribute masks into a
> bitmap in an endianness-agnostic manner.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: fce7913b13d0 ("NFSD: Use a bitmask loop to encode FATTR4 results")
> Link: https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2060217
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Thank you for the bug fix! Applied to nfsd-fixes (for v6.9-rc).


> ---
>  fs/nfsd/nfs4xdr.c | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 10439d569d9c..85d43b3249f9 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3519,11 +3519,13 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  		    struct dentry *dentry, const u32 *bmval,
>  		    int ignore_crossmnt)
>  {
> +	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
>  	struct nfsd4_fattr_args args;
>  	struct svc_fh *tempfh = NULL;
>  	int starting_len = xdr->buf->len;
>  	__be32 *attrlen_p, status;
>  	int attrlen_offset;
> +	u32 attrmask[3];
>  	int err;
>  	struct nfsd4_compoundres *resp = rqstp->rq_resp;
>  	u32 minorversion = resp->cstate.minorversion;
> @@ -3531,10 +3533,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  		.mnt	= exp->ex_path.mnt,
>  		.dentry	= dentry,
>  	};
> -	union {
> -		u32		attrmask[3];
> -		unsigned long	mask[2];
> -	} u;
>  	unsigned long bit;
>  	bool file_modified = false;
>  	u64 size = 0;
> @@ -3550,20 +3548,19 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  	/*
>  	 * Make a local copy of the attribute bitmap that can be modified.
>  	 */
> -	memset(&u, 0, sizeof(u));
> -	u.attrmask[0] = bmval[0];
> -	u.attrmask[1] = bmval[1];
> -	u.attrmask[2] = bmval[2];
> +	attrmask[0] = bmval[0];
> +	attrmask[1] = bmval[1];
> +	attrmask[2] = bmval[2];
>  
>  	args.rdattr_err = 0;
>  	if (exp->ex_fslocs.migrated) {
> -		status = fattr_handle_absent_fs(&u.attrmask[0], &u.attrmask[1],
> -						&u.attrmask[2], &args.rdattr_err);
> +		status = fattr_handle_absent_fs(&attrmask[0], &attrmask[1],
> +						&attrmask[2], &args.rdattr_err);
>  		if (status)
>  			goto out;
>  	}
>  	args.size = 0;
> -	if (u.attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> +	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>  		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
>  					&file_modified, &size);
>  		if (status)
> @@ -3582,16 +3579,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  
>  	if (!(args.stat.result_mask & STATX_BTIME))
>  		/* underlying FS does not offer btime so we can't share it */
> -		u.attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
> -	if ((u.attrmask[0] & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
> +		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
> +	if ((attrmask[0] & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
>  			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
> -	    (u.attrmask[1] & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
> +	    (attrmask[1] & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
>  		       FATTR4_WORD1_SPACE_TOTAL))) {
>  		err = vfs_statfs(&path, &args.statfs);
>  		if (err)
>  			goto out_nfserr;
>  	}
> -	if ((u.attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
> +	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
>  	    !fhp) {
>  		tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
>  		status = nfserr_jukebox;
> @@ -3606,10 +3603,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  		args.fhp = fhp;
>  
>  	args.acl = NULL;
> -	if (u.attrmask[0] & FATTR4_WORD0_ACL) {
> +	if (attrmask[0] & FATTR4_WORD0_ACL) {
>  		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
>  		if (err == -EOPNOTSUPP)
> -			u.attrmask[0] &= ~FATTR4_WORD0_ACL;
> +			attrmask[0] &= ~FATTR4_WORD0_ACL;
>  		else if (err == -EINVAL) {
>  			status = nfserr_attrnotsupp;
>  			goto out;
> @@ -3621,17 +3618,17 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  	args.context = NULL;
> -	if ((u.attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
> -	     u.attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
> +	if ((attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
> +	     attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
>  		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
>  			err = security_inode_getsecctx(d_inode(dentry),
>  						&args.context, &args.contextlen);
>  		else
>  			err = -EOPNOTSUPP;
>  		args.contextsupport = (err == 0);
> -		if (u.attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) {
> +		if (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) {
>  			if (err == -EOPNOTSUPP)
> -				u.attrmask[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
> +				attrmask[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
>  			else if (err)
>  				goto out_nfserr;
>  		}
> @@ -3639,8 +3636,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
>  
>  	/* attrmask */
> -	status = nfsd4_encode_bitmap4(xdr, u.attrmask[0],
> -				      u.attrmask[1], u.attrmask[2]);
> +	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1],
> +				      attrmask[2]);
>  	if (status)
>  		goto out;
>  
> @@ -3649,7 +3646,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  	attrlen_p = xdr_reserve_space(xdr, XDR_UNIT);
>  	if (!attrlen_p)
>  		goto out_resource;
> -	for_each_set_bit(bit, (const unsigned long *)&u.mask,
> +	bitmap_from_arr32(attr_bitmap, attrmask,
> +			  ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
> +	for_each_set_bit(bit, attr_bitmap,
>  			 ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
>  		status = nfsd4_enc_fattr4_encode_ops[bit](xdr, &args);
>  		if (status != nfs_ok)
> -- 
> 2.41.0

-- 
Chuck Lever

