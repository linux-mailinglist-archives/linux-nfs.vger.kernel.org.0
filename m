Return-Path: <linux-nfs+bounces-7199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08579A0C06
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765082864F3
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF80209F29;
	Wed, 16 Oct 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WEMmJltK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xtN0eWG9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9586207206
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087069; cv=fail; b=TAB6pScmzGgkqBqGczFB4Loox0rBm+Yg2JIx6lf12vFnU9xkCXJJQpg3HKad0P4ZfXscozCBATDbC8U5PeUIVLosvDAuaWYoo2rR3FHfGPC1XPi2HQh/vFLB/PYn2zr0+grn9UDh9hSr/C2j7z5tkCZvM55bG5YqtAMSkhi8U3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087069; c=relaxed/simple;
	bh=9Yc4EtGgcGc4D99hsPp8PmIWHluFOt/eG8buCU/sIqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XT2H0zIHL8d74YoPDtFKp7EzMkL7h/h3OJmNXtLiIfneveKhqNWbVHb2iSSYlYIv4f4475vHHSji6uu5SkyWfi01ZYUI2GegGZxHo0h09aDRIjFhnCtH2Vvtgy7mpy8KrwYv7X0j8sx7IzOSwSPPpXkRL9WCVQyWEBL+AfqFTqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WEMmJltK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xtN0eWG9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GD0dDt009047;
	Wed, 16 Oct 2024 13:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=UYaKB5LNmMLRSTkGUm
	d3Sgtg7EL6inV4nK2VhlsuIt0=; b=WEMmJltKML7zZ4wzDGXZQP9j3N2FViOs0X
	R67c+Hi0j0s9KUtHfKGURpf07oBKXYnVhu7h2c4cFOs0h7AmjWalp8xBuYfErSXj
	50YT8rvwQ7E+ynAi9blHiejKNH3fv6Z4LCqNsxgHEHwjVK/Nsi1pHz8XLMJ9I7FI
	7yNn5egrDM9T/Zs5sgvYv8uzQMaAnA7zPrc0YdnDBgolGlIGf4frzlu/XLk33Nuh
	mbfSsZ59xYfzd0lG/JpCXpfzlaLLR5ppA9sbLFLe5+rLQu2p4fZpyB/kfzQ0xv1l
	EEyD1OW8JLgRCAaSa5hmvMy+tXXEydTDmqekC/UZYGG+4ydGfytA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1akn4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 13:57:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GDlGMZ014020;
	Wed, 16 Oct 2024 13:57:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8uk5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 13:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmZ3x/TLG+vXTu56BVrsPDcV5xoNMRcrsPgzhrTMqlGfMpBKYCFymKUZU1qMt1jWMqBPr6olQ7Yhbi5ZUtFUQzqiZSzmRO+4mTQGVCCJ3XMJ/iX0ifCnfmo+ZdeikK9Qi0FKZvAACijn8imQ4mZXBzJ7drfvSDPF6lwlRJoQxYwKb/TOvu3hXM9hFZqAT1PH2Z/BMDpcPTGIUZxnXZC7W0Bw6EVKbHefe0/+0AXHEzs4439GfVcMaEhyEzqRpJj/MfwaqsTQBb91hp904QM3+bFMJaCtakSLnEbYknDCMxvT+N2uJcOxVx4ZcRXQqaDAUUK1qNVMXNJjPYbvkQC2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYaKB5LNmMLRSTkGUmd3Sgtg7EL6inV4nK2VhlsuIt0=;
 b=YHQxylzT7N14GiZfCM95rTHq5YCzzHBiB7tAMTy4uOVknPdkLQviIODoCV+11B8GdAwwWvOShmuxpkt0GS+fqkudx2Os7mVXzZmevF2i1eLxsGyUBLjUxvcKz6/s6w4oypUZMQkgB/r53W8UcoTQV0ifWoLpXoyM22coLgCk6C/ZRLP/2GIYg0vWItByCWUA/jqS9sgcBtSUqyNcDxDhnAPQT/Nu7xuFOTCZ/90frLFK6VdPU9wlcU1ltdr3+XP66dbAr0vm1uFItjOpjOCNBYaFh8IO+GTsj6avQbOuZHE2dSElnr/4Gh4B9/riFWgG9GV+HybHxGhHxM/tpOoSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYaKB5LNmMLRSTkGUmd3Sgtg7EL6inV4nK2VhlsuIt0=;
 b=xtN0eWG9aF9xBcJDhPsBqasrAX5nANh5/CJ2SDjLJsN+AIFZAnOHeUuurgMwCht1QOQZg1IOH655VDKoh0RPulmR4e5JJ0aSpkVxyWBbrVYvUKXWveJVo0dpM1LviBw42bBkIg+2UDgntlGcwDX+ryoe/s+5+ozfYU3OAAAOq9w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6797.namprd10.prod.outlook.com (2603:10b6:8:13d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 13:57:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 13:57:40 +0000
Date: Wed, 16 Oct 2024 09:57:37 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Kinglong Mee <kinglongmee@gmail.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] SUNRPC: support resvport and reuseport for
 rpcrdma
Message-ID: <Zw/GUeIymfw+2upD@tissot.1015granger.net>
References: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
X-ClientProxiedBy: CH2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:610:58::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 1929f95e-613b-4393-ecfc-08dcedea7f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?watiN24WFrIUPpvvi+fwhECKUlk3IV0LWtgvOCuLZmQnrVhhv7tt4sP95U3u?=
 =?us-ascii?Q?QF/Qh1LuyMvy9umYa1XXzKm4aOSXJRlVdZo7+GlSV8XKEKXPegvmCWpR8W8B?=
 =?us-ascii?Q?0Hl4z6xKCIGTPx6NvEwCxb2T7IZBdIsIrOAoYaoeStMNyjXD+JVPUvLZ0qwo?=
 =?us-ascii?Q?XclJTBND6fA3JYkVSxJuqDIJlZjw+vDCjbKG/WJ4r6mWR7DWmqct540rWIxW?=
 =?us-ascii?Q?AGWL/63mVWy2z0ENbAczL0q2uU2sukXC5BIzhO96e9gvU3rI9fVJbP91Ylby?=
 =?us-ascii?Q?LJydhlfwGxI+07BjtiDO2igni0c4f9dYVYVFMp5RkHZpz/sUlFPzBF0WXZTZ?=
 =?us-ascii?Q?VZU7ea+3ZG3I+X7OmSUw74kCVv7qmdRcH6O4yvLQ79+iMOWU1ODc3oKyeSzu?=
 =?us-ascii?Q?vSxwwaurCMh0pPCFnRlj9jdkOqMB1Qvqb4/nlv8qb2yXCRmA7AG5HC+D3p0a?=
 =?us-ascii?Q?YM8u1PjNlZwRFMhrp6cyF/9TeK6B4Q3kGwK2iwXpof5Dhh4E3BMHlc38PWkf?=
 =?us-ascii?Q?1AI7SavckxBZN4JLDKHi17AKKIwl//DJehrveyv2MtUPbcMTbdWnt5YOga/W?=
 =?us-ascii?Q?ti5ogxvp0D202Hv6ZsUrFjF0t8Nxk5b4WXqztncmhdbwxPXR/qR+f67Cz3Er?=
 =?us-ascii?Q?W2ya32I27dFgMbn6/sAwE6ROx7lLOm7VcOT1d1HX2hp+iWGP54fKKLWPKC/S?=
 =?us-ascii?Q?FsfkKOWexdGUoWjthJVp5bMEB/BZPbC3asGP4ID2+01rcc9RB+i3EqSfNXx+?=
 =?us-ascii?Q?pcA2dm4nj+L2u4qX5dtOwTyjbFOQgi0Uw1ehwKYsIXXCk8Vi6zkhU0Clr8bi?=
 =?us-ascii?Q?CxozOJg3xBk/Exc0bVAxrysbn5eXzUM3Hh08myEUnq6e6xtJoqZHUsQejrcK?=
 =?us-ascii?Q?nC3mYX/Xt+1KrymEy/sMNlkaTwvFsBOrnO41jG+RysrfoZFJSVpDhOOt8tHA?=
 =?us-ascii?Q?+k0aNzAUgaAKznXygU9x5KuziBQ57aSReg3dQkpbrJx8MsLK7OzXF2ZFHG2V?=
 =?us-ascii?Q?+GVBv5JaCVPgextpjnVFCjY6ehSH0XK2kntTLAFyVUO2zKR16aj4DSNQ+jJD?=
 =?us-ascii?Q?kPUGqXkEKmovW93+SlujFIix+AtClDKBzBI6kQ9y9ik7Zv5IEOUPQ/350oDt?=
 =?us-ascii?Q?ebdc3dAD7DaHVYIUZHBQIjFu3yccKgm83O+nAbDUqym9imq0ClFrXjJC9a8/?=
 =?us-ascii?Q?EX1xEzD5W6RigBpcPQK9r7UUHQ4Ufs67Ux0Bu5QlY+utwwPnIPltMLRjydOT?=
 =?us-ascii?Q?O2hqbN/KESIjT3VZK9Y4vMgfQn00ay+RI7GiK6e6iA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EhxblLbSP4ob3EPZD+xLId7HouFBwzVxR91s3wa4JmRJueKaeZgaKgxXhsDC?=
 =?us-ascii?Q?J/u/hSIMHbC2Co6HNKomidbxbMG1mbRau1tUaxI9+v7dxSvGmSb3kNO5L6tx?=
 =?us-ascii?Q?Gs3ONLkIoyY9jvT2s+0pg77lWxenwXm4o7AEmxQgNO5xioLK51CzWEedVPLe?=
 =?us-ascii?Q?sbQuB/V7I4nCdnmz9dNe97irqpWFoop12yyeI/ydVRnsTgK1zM8PazZ6qceE?=
 =?us-ascii?Q?aOrRbZlfr3poR24Zr4wQE7596Ci50PPkkVWwdFsQmSiFeyIUK8NpQgiJ7G9I?=
 =?us-ascii?Q?Bkk8aMHstyD1yWpCHoPCSLymPQ4hBIN7Il36mmPqjPN2QwGbsHUNR+CTLve3?=
 =?us-ascii?Q?u++WIpOn+7ghDceyP7j48Xmhi4z5ellnh0oXJymtrBXUAEkT/o4StsyV7eL2?=
 =?us-ascii?Q?fJxXx5VJ8Yag4P8K6T5FLwjmTHOZknb+qkMugdwjvAJIkkvGvbwmnlUy+uib?=
 =?us-ascii?Q?iNYsI5meTfq5Ir5saIq2OcVVADXkwse3ncC+ieVfkLk+aTF0gGNEDo2dXS4C?=
 =?us-ascii?Q?xwHfVNP9Np1GhSddKqpI308CiDkIs9bX1mq6ca3npc1wuNiGE9/fqsyZ3/22?=
 =?us-ascii?Q?Bejzvoscf++V9F2MePvWzgaVolP1rJcduZTTYXyz8hQ2gFeDlW350wWR5Zu/?=
 =?us-ascii?Q?TT69HlepRPv+inkSATvgbS/b9XHjO7Ex/ALuuBvKH13oyiqjpp+e2GPAPghh?=
 =?us-ascii?Q?35TV2yslo8/+z6mHZ2dx8HwCFyAxScEyVDirch91caP/qfZ9It2cCT2rAr3a?=
 =?us-ascii?Q?ZWcMNd8evE/NankhZYezXtUvcx3QM/TqnFZoMnyM56TqmEJ2TngCRlELo6Rk?=
 =?us-ascii?Q?v0s2BImM8zElYw6aAFeEvZK8qYSyNTN9dkPDiJfJF9Jjy6/e3dvOMo488N7j?=
 =?us-ascii?Q?jzeVZPpZL8zxjNsYFe+7A3LaEQss3I2hWUQAwfPUHYvImoIO839ukTSygjaN?=
 =?us-ascii?Q?WS8KuOj+C/bj8nFi6wO9KpSYnZh7al3xNEehk4ThD7wmpmEQMXaMnn3keLcR?=
 =?us-ascii?Q?YgMf3qWuHBV7VzoFmgztb+lP01lXDOi197ji/wrziz1J3B4NI++vU5WRG+NT?=
 =?us-ascii?Q?QS9epocpZSeKyzAg6KE7Sfk1CsPBzgnO+WgL3foHgm+Fu3FR4NkZ0vmOpSrJ?=
 =?us-ascii?Q?YO0gFZoqxNPGqo1sst3Lx1NjftgON0/S7mXUOE4C5OFAubF4cZL+Ai7u7Mu2?=
 =?us-ascii?Q?Bg0iUS2QE/WyNd3i9T9Mxx29OWYg+QKjGrA4GrdrYB0mQGE0Vyif9/Z/Dx67?=
 =?us-ascii?Q?DJrVJz90NkBMtGVL6bULTbTM4DYFoscbFXCzH9HeDT9mlV8ZX9NGi1RDrjPO?=
 =?us-ascii?Q?9ue3j9akToGnwIqVnwwvRPA6IXkgS7sIA+c2M7FolByExPqNkuMm+1e62Yie?=
 =?us-ascii?Q?+bwwFR3vJBGQEXIugHcZYx8e5Q0b8WPOIbFkJNK2Z5jY+oxOtz0fpLRx5JCA?=
 =?us-ascii?Q?MAwLe+BCdnZSeExGhvxSx3jAYxUqd1jYMg2i9DyRHbdMim+EPR4xw4+3vonv?=
 =?us-ascii?Q?Ba4AukzGEkno4H+6LVXlFRWPzUYZ5/3V9vrEEu3BN3u7+GBkp/ncHCioWZWF?=
 =?us-ascii?Q?wMee+SWpmyPyvCKw6ZlxolC09vIKFnyAYY7BkS/p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VPfa/VNy2IQ6txk63scy3wB0Kjsjd9ObZZdez/WFPomKHT5OlwQMfDHWAMcXhWdja60CARlR8La156RopmdGUXLSfHeWcKZWrLrbJDZmQhXy3XV3b0JgC1f7awvVovrhUfbIw+6jvXq+HiuucwSclenOHArSDAV7646u/+4pwb3deMc5Kcsmh0oS4nwmggaJwwY4sEO5AsD7NNTvPs4RQ995WNQS5MJ0fhh9AVohZIOr8ooVVHIzdl3a1QNz08ceVeSBKh/fV2EbOnTOt5+GtewGlVKtFF0YCT7s0No3iB7N7t27maiVMvWrtUoTtos0GV1nU0ez+nluFQE1knUeoLkAf0DIdXu9DOyDjf13BRypiaO6RVaYAF6yS9zQoonADcN/1bedFHfn1vqfV8FIdKHS1IdoWJhNGl63Csg/BydJXTr86Gh2Q2yJbdtTJlMZpt/57Wh9IS0dm2lFTF8Gafu74oxCmvcRJWImvFiJ17khggT5WxPiM7l8NKr63zAQKdBhcCBJLHdyvmfcWKPYyivWFi488lDX8L1QNCXYdq7dQEq8C8zbF939FyKnBuG0n2UKO83d+ahOwp3q9ehO7zAWcwuxxkt+JK/bDxVv1mk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1929f95e-613b-4393-ecfc-08dcedea7f8e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:57:40.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjwfWB5DSMdZdkEUhsY7u43x8O8fhVwV8EktsPaHO0a4Tr+DjQflrrF9mib8ryWi890ramcXNi087TebBthBDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_11,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160087
X-Proofpoint-GUID: UQfjCRB_DPQUZgzb0beHRGeDXTHTGYu0
X-Proofpoint-ORIG-GUID: UQfjCRB_DPQUZgzb0beHRGeDXTHTGYu0

On Wed, Oct 16, 2024 at 07:48:25PM +0800, Kinglong Mee wrote:
> NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
> This patch supports resvport and resueport as tcp/udp for rpcrdma.

An RDMA consumer is not in control of the "source port" in an RDMA
connection, thus the port number is meaningless. This is why the
Linux NFS client does not already support setting the source port on
RDMA mounts, and why NFSD sets the source port value to zero on
incoming connections; the DRC then always sees a zero port value in
its lookup key tuple.

See net/sunrpc/xprtrdma/svc_rdma_transport.c :: handle_connect_req() :

259         /* The remote port is arbitrary and not under the control of the
260          * client ULP. Set it to a fixed value so that the DRC continues
261          * to be effective after a reconnect.
262          */
263         rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);


As a general comment, your patch descriptions need to explain /why/
each change is being made. For example, the initial patches in this
series, although they properly split the changes into clean easily
digestible hunks, are somewhat baffling until the reader gets to
this one. This patch jumps right to announcing a solution.

There's no cover letter tying these changes together with a problem
statement. What problematic behavior did you see that motivated this
approach?


> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
>  net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
>  net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
>  net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
>  3 files changed, 141 insertions(+)
> 
> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
> index 9a8ce5df83ca..fee3b562932b 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
>  unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
>  int xprt_rdma_pad_optimize;
>  static struct xprt_class xprt_rdma;
> +static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
> +static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
> +unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
> +unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
>  
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  
> @@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> +	{
> +		.procname	= "rdma_min_resvport",
> +		.data		= &xprt_rdma_min_resvport,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &xprt_rdma_min_resvport_limit,
> +		.extra2		= &xprt_rdma_max_resvport_limit
> +	},
> +	{
> +		.procname	= "rdma_max_resvport",
> +		.data		= &xprt_rdma_max_resvport,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &xprt_rdma_min_resvport_limit,
> +		.extra2		= &xprt_rdma_max_resvport_limit
> +	},
>  };
>  
>  #endif
> @@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
>  	xprt_rdma_format_addresses(xprt, sap);
>  
>  	new_xprt = rpcx_to_rdmax(xprt);
> +
> +	if (args->srcaddr)
> +		memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
> +	else {
> +		rc = rpc_init_anyaddr(args->dstaddr->sa_family,
> +					(struct sockaddr *)&new_xprt->rx_srcaddr);
> +		if (rc != 0) {
> +			xprt_rdma_free_addresses(xprt);
> +			xprt_free(xprt);
> +			module_put(THIS_MODULE);
> +			return ERR_PTR(rc);
> +		}
> +	}
> +
>  	rc = rpcrdma_buffer_create(new_xprt);
>  	if (rc) {
>  		xprt_rdma_free_addresses(xprt);
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 63262ef0c2e3..0ce5123d799b 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
>  	xprt_force_disconnect(ep->re_xprt);
>  }
>  
> +static int rpcrdma_get_random_port(void)
> +{
> +	unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
> +	unsigned short range;
> +	unsigned short rand;
> +
> +	if (max < min)
> +		return -EADDRINUSE;
> +	range = max - min + 1;
> +	rand = get_random_u32_below(range);
> +	return rand + min;
> +}
> +
> +static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
> +{
> +        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
> +
> +	if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
> +		switch (sap->sa_family) {
> +		case AF_INET6:
> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
> +			break;
> +		case AF_INET:
> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
> +			break;
> +		}
> +	}
> +}
> +
> +static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
> +{
> +	int port = r_xprt->rx_srcport;
> +
> +	if (port == 0 && r_xprt->rx_xprt.resvport)
> +		port = rpcrdma_get_random_port();
> +	return port;
> +}
> +
> +static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
> +{
> +	if (r_xprt->rx_srcport != 0)
> +		r_xprt->rx_srcport = 0;
> +	if (!r_xprt->rx_xprt.resvport)
> +		return 0;
> +	if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
> +		return xprt_rdma_max_resvport;
> +	return --port;
> +}
> +
> +static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
> +{
> +	struct sockaddr_storage myaddr;
> +	int err, nloop = 0;
> +	int port = rpcrdma_get_srcport(r_xprt);
> +	unsigned short last;
> +
> +	/*
> +	 * If we are asking for any ephemeral port (i.e. port == 0 &&
> +	 * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
> +	 * port selection happen implicitly when the socket is used
> +	 * (for example at connect time).
> +	 *
> +	 * This ensures that we can continue to establish TCP
> +	 * connections even when all local ephemeral ports are already
> +	 * a part of some TCP connection.  This makes no difference
> +	 * for UDP sockets, but also doesn't harm them.
> +	 *
> +	 * If we're asking for any reserved port (i.e. port == 0 &&
> +	 * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
> +	 * ensure that port is non-zero and we will bind as needed.
> +	 */
> +	if (port <= 0)
> +		return port;
> +
> +	memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
> +	do {
> +		rpc_set_port((struct sockaddr *)&myaddr, port);
> +		err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
> +		if (err == 0) {
> +			if (r_xprt->rx_xprt.reuseport)
> +				r_xprt->rx_srcport = port;
> +			break;
> +		}
> +		last = port;
> +		port = rpcrdma_next_srcport(r_xprt, port);
> +		if (port > last)
> +			nloop++;
> +	} while (err == -EADDRINUSE && nloop != 2);
> +
> +	return err;
> +}
> +
>  static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>  					    struct rpcrdma_ep *ep)
>  {
> @@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>  	if (IS_ERR(id))
>  		return id;
>  
> +	rc = rpcrdma_bind(r_xprt, id);
> +	if (rc) {
> +		rc = -ENOTCONN;
> +		goto out;
> +	}
> +
>  	ep->re_async_rc = -ETIMEDOUT;
>  	rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
>  			       RDMA_RESOLVE_TIMEOUT);
> @@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>  	if (rc)
>  		goto out;
>  
> +	rpcrdma_set_srcport(r_xprt, id);
> +
>  	return id;
>  
>  out:
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 8147d2b41494..9c7bcb541267 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -433,6 +433,9 @@ struct rpcrdma_xprt {
>  	struct delayed_work	rx_connect_worker;
>  	struct rpc_timeout	rx_timeout;
>  	struct rpcrdma_stats	rx_stats;
> +
> +	struct sockaddr_storage	rx_srcaddr;
> +	unsigned short		rx_srcport;
>  };
>  
>  #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
> @@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
>   */
>  extern unsigned int xprt_rdma_max_inline_read;
>  extern unsigned int xprt_rdma_max_inline_write;
> +extern unsigned int xprt_rdma_min_resvport;
> +extern unsigned int xprt_rdma_max_resvport;
>  void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
>  void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
>  void xprt_rdma_close(struct rpc_xprt *xprt);
> -- 
> 2.47.0
> 

-- 
Chuck Lever

