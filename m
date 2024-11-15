Return-Path: <linux-nfs+bounces-8008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471A9CF170
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 17:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55A51F225B9
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB381E4A6;
	Fri, 15 Nov 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g9BeiQMd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jVT/CRFU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0D12EBEA;
	Fri, 15 Nov 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687909; cv=fail; b=cNUg0iQdVooX5Qhm67Cb6c5yiCQxaFWC4nuZpaUPWbtXonSYA+NpcUaaK/GPGRV5CxtdJKd4IEkIeQEZnqPcwLdWsLU/jlaE9AjIVBX3Zj4EoqGCW2FxRGJspUfUHgccmMa++m1d0yciXmNgtnPT4oOxuUZwsmmatxVVGtUUb8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687909; c=relaxed/simple;
	bh=dtm9RBm18mZoNAfohjS6SCv/euqsX0+SSyLR6tgBU1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ebNELwtZjs4lILsK/1zuy9p873IwnQJ/wQBtfsh+OXAfSXYXFC1igf+bGW+xlP6+RMNshgPbAUeVH4gm+kBU7hwzH1/4nzASfGfksXrmJ7+gaWqI4/jlIHEAzCbDMYVzxPc26/4Rhcu7vPG5I2yNbKOEOi5/qMVo2qPsUe66mvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g9BeiQMd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jVT/CRFU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGMaPe012245;
	Fri, 15 Nov 2024 16:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qwE43Oj3bJLvqPe+Lm
	x6nCaDGjTnwZDMao3M6uEjoy4=; b=g9BeiQMdY8BRYKODa/JFoM2l1BFk4RqsAb
	cyq9gonSzu1Dh0hICzgMuULIpyUk5q9h7s2ytb8JdhUNTkZXfKksi3P9G9gE6pN9
	4fpsLO4K8V44nAXElQcrsI9Q7WAgXRqxOmeZ8zM1LT6xNRYFw5gTdKrX777waUnF
	6YgR4An92EBW9xUJNg7YTJBQSsYEYlutriHME+BC0u2z3j3FSmUNYX9D3I3lzkWp
	HXJZsQX3SLGAKzyTtQAu5XWIsa5JZzAUr80nYdy/C5M/sxMGmE7ABSycmMeRiNJt
	J2oTraSkceuCuNhd7dFw0IcmW0lvrM18T5X8d8NHB22jzGv1Qtkg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc3u5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 16:25:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEvHI2035927;
	Fri, 15 Nov 2024 16:25:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ccwuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 16:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogP9rlhO6biD7dZkPOWYori0emuTDLdAi5YEDxg9FQdmVNx/AUeoXiYgWp++BE7Qng9JXLzS+8NwNY1XPk9TCcAUm600fIToy/QtsoDl2agMKXTeHgTshWcU+myRjHN0ShfYanJJGIdCbkpLQhpeZut4fIIoWNF55XVu8m5Kkj0QSWpURAjC+rh2OOjHUsz57zX6753/c7QRlQwF/NzF+KFng49Kkmcbr6v9fS8fxThGgq6fjGVSMnhx+zx7Xd66Uh+MtwGyoCZy9Bi7BuZ2YCtiMoVFU1j//Gjy+zzU/TQ/o7K1lpeK305w64+RBklcaRSxosxeE9O58jID/J04Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwE43Oj3bJLvqPe+Lmx6nCaDGjTnwZDMao3M6uEjoy4=;
 b=O5rxk5UiGWqla7nIbOn+qLAcP0lhZCWQyXRG6ImuytbwAA6aRKb4ZxopbfKxAX4vj7TRbH3Y4H+tpf7RBYtihYfMgmJOrXVkgP2Nf+FsB/1Mf462Uwe8ZlBQ+ZnFOSUXW2kePWUUHRVeuWArraL86SIlUer7iE/KCJhefmb3JPhEMo1ZbMvwXg3w8UPh3MitptwdC070i73rmJ+A7ulV1MLegyC2+eFjDq3JkYnLO/U7cwSBUzG1fKAYlEbtA9Fe49B37N08+XynOXaxIQY5GhhqCsMzcyoYT3zvaehlphYGhuhtWk29NtxsIzUqugMEkmf42v66jmkAXzZeJlQ8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwE43Oj3bJLvqPe+Lmx6nCaDGjTnwZDMao3M6uEjoy4=;
 b=jVT/CRFUkQVVDSCkpcsZlYIia60qZ7u2l6zv5+dGPV78+jCns6F23ZnKsWnhYDKTrBSrJPgfRe3iAiF2jPMC5H0PTTDE0L97YjB11912XtKLCegg5x9DWWDglTHyZW2L5VPZGosQKPDR2MkbcRETIR3UyBc/3tRiSA35PqCyRTs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4756.namprd10.prod.outlook.com (2603:10b6:303:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 15 Nov
 2024 16:25:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 16:24:59 +0000
Date: Fri, 15 Nov 2024 11:24:56 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: akpm@linux-foundation.org, aha310510@gmail.com
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-nfs@vger.kernel.org, hughd@google.com, yuzhao@google.com
Subject: Re: tmpfs hang after v6.12-rc6
Message-ID: <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzdxKF39VEmXSSyN@tissot.1015granger.net>
X-ClientProxiedBy: CH0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:610:e6::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: f546e5f1-05a4-4913-8a3f-08dd05920cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YL3lIGERGZ5W4PmGPt+QLNfzrmR14/1b6xwNwj3dM9ulwXdqCvAiUd1xpIti?=
 =?us-ascii?Q?OyzFwUBtw+bmgH5lqQq9VYhyEPeJcih7JubieSrQPExCmf6xwQzzKSoUy6Ek?=
 =?us-ascii?Q?AjHeT9sJX23RqzokoMz3CGvBcxPOmBZW1+FmL8DTWEn8K9SydVeOfmMqtXQK?=
 =?us-ascii?Q?ylp4xjTD+gWI2w0drXrdN7Vu2dDB+0h1m3TgTuOcs3e+WXqTJB11eJFaYLY/?=
 =?us-ascii?Q?oaMMiHdHNE3GqgNuB4w9c5OnVEORyPthZbY5Z0fP6+8hPNmPXLWiLbGr3J9j?=
 =?us-ascii?Q?ByZxPl3fanM6RuxU/7HHu76JNORBQ0RAwReSDBZroXNdYuR4RQr/nJ+RxZMq?=
 =?us-ascii?Q?W3njgj/kmK71ROXZqJIfb08c15nnHWKGePZ02ycm37QCyCLf6pVvL2Fp4WUq?=
 =?us-ascii?Q?3ATDITTZlLhqABvChEcB2e3s4vhj3vP8KwKrrBxGhZGuKzok29i4oWQnqHI/?=
 =?us-ascii?Q?dhaAJV64cjozfI57tIBXGCol9XadtZTYr/3ciT59Zofj2SbbZL/Bf+H9oIf7?=
 =?us-ascii?Q?RF5+LQbrOUwIEkSYM1KdCg+qaJP6ct3WOkxljNDOjpJlVdGGmbigHbfCNemd?=
 =?us-ascii?Q?K6riwEmY4lAYWRoQh5iDNinK0JYBrzundt5ZMK3QWOCgArbL/67Hxi0qhxD3?=
 =?us-ascii?Q?aD4+N6D+TyrHMMtlfKcgL47S/07oxtbh16KbVZ08txTLWKeLFlrMdYoMZXVZ?=
 =?us-ascii?Q?9sD8p7AaZmXffPCrLc/+dy4K2MLYJ7IK53bcsfSGUCgi4K5AozTB4uXK1obC?=
 =?us-ascii?Q?/45Z7wfBkCEgE/jMYxcd7VxnpPNKQK/AA8eAtZx+EnXRIFBAXxEN6TjHTiLx?=
 =?us-ascii?Q?8U0JRNSQPAw7iLG0Lqz9xW1uh0jE7GBn354FW924qQZaU5ItGmJPIHn5sBpr?=
 =?us-ascii?Q?benA8xbHWVlVjqzVxWhMDSf3JiL33RA1CaVv38PS2K3pSwaDqYzWnJ2N2uGY?=
 =?us-ascii?Q?e6o6NbRqYP31Rsdr4XwG4jrkqZ7tRss8xtZXb+g4TlYfhUgrrHUH1Gskt9g4?=
 =?us-ascii?Q?9kJgabx4kj8QUvxBI7IMyXHySuRmXE0WsMhEo0aA+oI7F9Lfzwx2Vlm0UqqL?=
 =?us-ascii?Q?38cXKPGhwCA+Whl1qcDz4HMHMjuAx+Xd2SifBGKNfhQXJX/jfclKXoGmzkio?=
 =?us-ascii?Q?TOmKT+mb0J6P6cIZ5t6QZiNXizwPJUI7++QAD5ZO0+99w3Ke1iqTiMvqHRP1?=
 =?us-ascii?Q?lZoqAnyxuHmuvntqF5VyVX9CKOwB3vLx4ioVKKFhnYNxxiL3Cfio2KdZKN0p?=
 =?us-ascii?Q?uF+FeVHR31XVCHDqc51ob79o01luinK++yptlFzuRHqt/3R7Mook8J95f0aJ?=
 =?us-ascii?Q?0qkELoccXTMLbTKQh/ksurvL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a3HqYHQMfoaDa6yIFiwVXk3AyyxTb6cXZ+IwNJkIpwhBQpWQTrGx5u6Ic2lM?=
 =?us-ascii?Q?yiCsvU4BESfotSzy0GPPuqcM4DCjFgTL1wzBel6l90M8+C5t5iCpuD95GCnr?=
 =?us-ascii?Q?OvHjzb8GhqbdhCvp7Azwa2gsT7HAaK9/akzR+uc3cK/J0y3SFKKkXNVOohkP?=
 =?us-ascii?Q?9c2nipwc9R5tMdURC4+7fVLUV6ogQdZ+lwYgw/Sl8q7VieASs0SnPz39FjIJ?=
 =?us-ascii?Q?msAXxdRWj2HZe/877ycjUC10o/t2vDIUcaM6Ua12nlCqSDVzKUupDrjzr89i?=
 =?us-ascii?Q?rt7mQsWhULinHYb6faK4QoBh1u6zIANSOp4xNRs5ky058zm5QUjUOeq89mB0?=
 =?us-ascii?Q?jvH8/m/eSYd5bmp6m212V6X1iER0EImtJPaMmO74s8HN1PgZkzT2UkIpchWL?=
 =?us-ascii?Q?lDz5K6AmCQU7GauYdkwqgvZaZ2o87ToYZ9/E/gfVExpbuoDgl312h0dbv4hB?=
 =?us-ascii?Q?W5nHwSRjQ+K2sI+4sIB5G++bB8DthjwwU6M09/kW2Kjyh7vXIAhiUwaq9LCq?=
 =?us-ascii?Q?UjRvgorB09H8dzYU7rZ0X8CynlhA0YFW4R7sESPxFASEOJEky/a0kT2LpPox?=
 =?us-ascii?Q?hi8ANWWQKAQiYh/upbXLe5KURnt12Hm4Teu9k/tC+ScfZ8Ep3u0sp/OOGuw6?=
 =?us-ascii?Q?X72c6YUAD8FG6avt8hiE161QN7rUxzFLxA05hHQktAwYBc1ATpQxDVMRbynr?=
 =?us-ascii?Q?S+FytENScxiM50RrACL5xg6rfvh3ZhXnXj7cel9OeFMQr/8f89oeuM4fIzz4?=
 =?us-ascii?Q?MY8HCrzhPoUgsQifDz7nH3itaHTYB9mp/5LghZse3bbNmp7eTCyVe5HyG+go?=
 =?us-ascii?Q?kz8idUMdYaORPVTkm64jv/HEUq6FcRrp53oCtXQ2fQ54bTGRdKLfIhkPoqnw?=
 =?us-ascii?Q?COcmGLqU+t+Lt+Xy3xWSiPDc6n2tBw1yDw30xkj8q5FRepnRrm9S9OQuOn1G?=
 =?us-ascii?Q?pRrc5DlNYYHcycxUADfezSPJemwmRk7jQ/X5ltJ8aa2ogrY5a29swYNMl1jX?=
 =?us-ascii?Q?MA1d3AXNw/bx5BlgsxbdEZyxwmysWQayLPxkNVnFjFU8BAfCeazcZ+joxv5h?=
 =?us-ascii?Q?ZJwabFtFmvCKajVoZuiUkozpdUma0fUKsPvrItq3XnWsleF71w45S0ndB+IJ?=
 =?us-ascii?Q?XPcbBQokHWGrZO9u0A6CLlab/ycBeM9i2fj6RvhKOGJtLsDGGL2mKhaU2689?=
 =?us-ascii?Q?WZ+ZH1A33WruYKuegOG4FJTKinKtJF6j5tUI1AYE3UU5TZbRd92PSkf7MQhc?=
 =?us-ascii?Q?raZsGSK9QfEYZP3Pa3CMP10uFDnF+O1ZVRajnJM0si38VDMyKMz0evFdyw+x?=
 =?us-ascii?Q?Agf1NMZmTgzfarvCxo2Xz5ezBNIDefsFoVz9dzSe75P1MUvBgDuAI5vVu4u9?=
 =?us-ascii?Q?t/Kw0KFsM0G1bkZUUk0nS7TYVKnBRBt7j+/rwVQ7Y0k5ndxYKXcdQE0UTUEz?=
 =?us-ascii?Q?hO1UfiSXVLcR8/SMdq5f6SZlE4yzXzyNUx5eHv97WPBdlaVtY8jqFKJQLBgM?=
 =?us-ascii?Q?bFKVY0hvmiYg4H9ZtZNx9l6MJJiOMlSvhxrLjv78PoVlwk4QAbylmfeRlQ7T?=
 =?us-ascii?Q?MOMPysg7tNGfoVRU+cTjuxebjlHoRkAdAP6Dh+gy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N5trHBJqgdt0JSDuhi1Zj/VSSgPoEA17TX5UoHVwdkeXMYPGpTm4xW1yC6yL0AmzcqV4wGj3kBC2w6b0+RsH0VTmXg9OQDg1xWc+0KrLgMpMFIw4teV5w4/9siDEaSkf5hFjhMOxULrG3ETRjSfRb4pREjyAtCakyFTr72vzGrZHMQhoGj+/OhE2A5UPNOeTkeAwNb/zONmJiWo7/FtmoNp2OiubsbIpSBGxAUxooFCblwxZjCiLBmULOiPmqPP9zOg39fm2PbfcDrFfb8uYD7kkleH97CHbO2R3C80UYhOkKL/Ts2RkNO7Z4DR59SY+P9wsM/EOj7/s6WmC2zrECma+fKN6wmPk7eqZMd+RMzp36keG44HtyHtE5Kx6NwZpu67lUsqdYQYBUTXRXR3fVdqO/D/fnmU1Fvv4pyyWp0rj2wH1A08JdrHVqtsJDvwyJupyctGDtgWrcMTkkyg+AMNy1he+qN7v2LimohvnaXJyzdwmVFKm5jUAKDp+dl2+Ingu9Imf7az8moH7d+2jOoLTwFwhLxPlg8pjnJN5LGi321UNWv2bC4eyRin0PmvFGG0BFS6JgCQoyYpJUuJovP6PdEnGNA8CCIDXSpf7Mtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f546e5f1-05a4-4913-8a3f-08dd05920cdb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 16:24:59.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEhXowysvd/h3EjTSavMHEVOgDvDeIdrOHZdK0OfcjznTU4ZnT8by99OtBpc9Pg6RaDJa61hn9LU/jqHwYMn9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_03,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=977 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150139
X-Proofpoint-GUID: RpLgj4626lqOAnIvV5FEKNlslhLtHCJC
X-Proofpoint-ORIG-GUID: RpLgj4626lqOAnIvV5FEKNlslhLtHCJC

On Fri, Nov 15, 2024 at 11:04:56AM -0500, Chuck Lever wrote:
> I've found that NFS access to an exported tmpfs file system hangs
> indefinitely when the client first performs a GETATTR. The hanging
> nfsd thread is waiting for the inode lock in shmem_getattr():
> 
> task:nfsd            state:D stack:0     pid:1775  tgid:1775  ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  __schedule+0x770/0x7b0
>  schedule+0x33/0x50
>  schedule_preempt_disabled+0x19/0x30
>  rwsem_down_read_slowpath+0x206/0x230
>  down_read+0x3f/0x60
>  shmem_getattr+0x84/0xf0
>  vfs_getattr_nosec+0x9e/0xc0
>  vfs_getattr+0x49/0x50
>  fh_getattr+0x43/0x50 [nfsd]
>  fh_fill_pre_attrs+0x4e/0xd0 [nfsd]
>  nfsd4_open+0x51f/0x910 [nfsd]
>  nfsd4_proc_compound+0x492/0x5d0 [nfsd]
>  nfsd_dispatch+0x117/0x1f0 [nfsd]
>  svc_process_common+0x3b2/0x5e0 [sunrpc]
>  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>  svc_process+0xcf/0x130 [sunrpc]
>  svc_recv+0x64e/0x750 [sunrpc]
>  ? __wake_up_bit+0x4b/0x60
>  ? __pfx_nfsd+0x10/0x10 [nfsd]
>  nfsd+0xc6/0xf0 [nfsd]
>  kthread+0xed/0x100
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2e/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> I bisected the problem to:
> 
> d949d1d14fa281ace388b1de978e8f2cd52875cf is the first bad commit
> commit d949d1d14fa281ace388b1de978e8f2cd52875cf
> Author:     Jeongjun Park <aha310510@gmail.com>
> AuthorDate: Mon Sep 9 21:35:58 2024 +0900
> Commit:     Andrew Morton <akpm@linux-foundation.org>
> CommitDate: Mon Oct 28 21:40:39 2024 -0700
> 
>     mm: shmem: fix data-race in shmem_getattr()
> 
> ...
> 
>     Link: https://lkml.kernel.org/r/20240909123558.70229-1-aha310510@gmail.com
>     Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat")
>     Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>     Reported-by: syzbot <syzkaller@googlegroup.com>
>     Cc: Hugh Dickins <hughd@google.com>
>     Cc: Yu Zhao <yuzhao@google.com>
>     Cc: <stable@vger.kernel.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> which first appeared in v6.12-rc6, and adds the line that is waiting
> on the inode lock when my NFS server hangs.
> 
> I haven't yet found the process that is holding the inode lock for
> this inode.

It is likely that the caller (nfsd4_open()-> fh_fill_pre_attrs()) is
already holding the inode semaphore in this case.


> Because this commit addresses only a KCSAN splat that has been
> present since v4.3, and does not address a reported behavioral
> issue, I respectfully request that this commit be reverted
> immediately so that it does not appear in v6.12 final.
> Troubleshooting and testing should continue until a fix to the KCSAN
> issue can be found that does not deadlock NFS exports of tmpfs.
> 
> 
> -- 
> Chuck Lever
> 

-- 
Chuck Lever

