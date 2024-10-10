Return-Path: <linux-nfs+bounces-7002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66415998606
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 14:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A637D2838E0
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96DF1C462B;
	Thu, 10 Oct 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G26EzdkL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LP0lPge2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200BF1C1ACF;
	Thu, 10 Oct 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563439; cv=fail; b=PMGG7Llas2z1yjvWEFecKrdk9ugBa2ZaZVe570zrcODEQkeqLK2/oKIjLSnCC1F6jr+RxBeCcWfKRkciRXhCpY53pJkltQQaO5uI92mxjyanzg3D95wjjk93jLFh3/HYo8ig+wnqSgLGPVQinFeH8fR6ZLmSCzHkrIwdVJOK/BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563439; c=relaxed/simple;
	bh=QFxlR9tM4xs5yqqNpfk7Qb0FiaCzxx2f7MR9CwhTOj0=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Y9uNaIdBvxp9It9fZZIG3UGh8as6TtklBfAr9xmTauzsxx35hxmz5VnvbVQeDQW1vpR5wYZoDiNSamjZ0E2X1VWtTyUrwrgFUht65yZcunHjEXqxOpLvuqDVNnF4W9qt7kksLrlvu0O8M9Rt4KjoTIWOY+8u+okCdN3QFDoyKVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G26EzdkL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LP0lPge2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABMgE2022613;
	Thu, 10 Oct 2024 12:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=KR7Qjj8UVMGgmSSS34gStTFJ+xh2SJB+wvjwnvZYG4c=; b=
	G26EzdkLBFFnRxH/v++R0nGQBVWT1sUPtxQ83UcwwHFpN540Kmv/O3C+wa1pERCj
	eDUnAU2vGZOOYLgADvaymXko1GFXGQ9ADbLPVEbEh1BeTHYFjiGgnebWPMUiUmtQ
	br72kgYoTBFmiTt+sI273deH8VmSG3qccNlpYbCd8VTuzIPRkfCa+ZYanGcZtbfo
	Uv9QT0e/NM7g801rsqF8hqLl4bisYu2pEvYzCaLYQlFmiTwCx9uxi9nfmYToLxCQ
	GWVzBkiA91HFb1WSImBJlBAvoYWEbrygqaAmFdnX1No1pPNJZpVSpXtixagm469r
	70qEx78UM1aHidxNkhqUYg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303yjkbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 12:30:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ACHw2U019057;
	Thu, 10 Oct 2024 12:30:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwg8euv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 12:30:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFVgcI7FrpbwlqJqZx5viB1NOfk1lKT1sJ4lCPRItwO3z58vBYs1SnKLBof1ZAesX+Eyxo/bJeb+t/+WslkOf04AoHy0bGLiybsIXlMiApVaJR0wMfUtGgjt0RfWusxR+oy70no76ZUe8mHzFcc+4Gr4vcxig5ZYGXJmF48m0N0IYZViHLaAzUzNlz5Gl3DTwFcr0zj2oSdG+Kc64AGJqQe6QyV/MRxC9qJmZDRqPYoe5t6PK2N636Nd2+9LDPsidmfAxow3FjV5JjUxrKQO/4Wx5gHUqw7ZLxUKO+bprrmt5Axkb7QAyxAIUWbMHwUhy4murpebMRNam7F6NVtn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR7Qjj8UVMGgmSSS34gStTFJ+xh2SJB+wvjwnvZYG4c=;
 b=zNey6wLXfgrVtOqVDiboDoQmeBe710zkODww61x9PoF3to5zwqrqi9CavJnBrLM2EFKjVLB8t8/0zy4sCS7bPFGPGw6JZtfdnkEN7/icpDHvmfeU84IDFeIrKK2P+GOPmX0VZC1Q6SN6KD4L0AyNUiQ/ArdsPHb5OU7wnukuyj8zskR4Yfq2Gkdjrn+9YjBFT6GvGoNVhyBLMWYD4aeU1Beq/BVbSP6wpxRP/uAAaXAeit5xrw2vFV635E81/WH035EAhWBbm4DtY+MJXwl8Knaxv8Nwj7znBhqjsnl2a9oNlyaYwGdQqIIyE1UAXAwNyd2/fcE35nt1o1wQX69b/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR7Qjj8UVMGgmSSS34gStTFJ+xh2SJB+wvjwnvZYG4c=;
 b=LP0lPge2aLAfmxtWjwF0RCWITJErMjAa/TSwMZB4jom+NzCM0jRt79knyO5lzPlnYQwnrrJeRLs9qOn1G9DfQ9qg2mCLdKFcI5AGNzRPPFzHrZbDlOX8pPYlNWUIwsBfNIEu9ZdTXRZuSxxBSIsu5yArf0ccb5VnFIaLVSXzASM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7217.namprd10.prod.outlook.com (2603:10b6:930:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 12:30:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 12:30:24 +0000
Date: Thu, 10 Oct 2024 08:30:21 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] v6.12-rc fixes for NFSD
Message-ID: <ZwfI3eK47tku5mtl@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:59::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 9514c6fc-90dd-490b-88d7-08dce9275056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLP9bNTIbg1lpr8J7QOMEPHpSQFWKtYJ5JXeH9Tj9PXNDDwLXNny77aUEeV/?=
 =?us-ascii?Q?zNVHTWilrh0J3PjJfrJEF/dH/WwcmsreUBTmvtSN44GUbgTWFk0mOnK1dlKO?=
 =?us-ascii?Q?S5RgE5RWtYmdnZ5aEGWF9Y5mHLQZI2z/99Oz0kTXY5tvTxdvkpCf6e5mDg7h?=
 =?us-ascii?Q?20wEckSLLwDlr47zCXz4xEk4uecw0xwb4mORv71keQ/niILqEmbuoNtDN5FZ?=
 =?us-ascii?Q?v4YiKiuyefrCmUjcQX6OJKBRc3KX1Qqh/ZPBz4qtrF1PChafQBjiqpMerqrj?=
 =?us-ascii?Q?JxcKHh0foxgPMRTFTs7W8nPjMN1wztatsx9x9Pse+vmYd5J73+9ZIsEiYwHz?=
 =?us-ascii?Q?DQT9K/JCS7+rYcmUHZsfMeTQkwshwVOhoCqdSYGHOEaMcuYWQlnDb6XY4gD2?=
 =?us-ascii?Q?J/xz2RoVzabHSjp+cmfAIWaIH1LbC1rNXGCRSZld3K6OSiCmqg3GNoKA2y10?=
 =?us-ascii?Q?yqmAe5NmMcHEd+267Hk3sF7jHBqiF8FzOVI0/ob3CwD47K1mqZEsfT7sgXu0?=
 =?us-ascii?Q?HVayjjaN5Iffn4WhL9LreYcbpWR2s7f9fowIw1Pv44+cGtvx0m110MTKpLr9?=
 =?us-ascii?Q?NJTyZ88S8D1xZu5ryFXBchQdXGjh1NHY8hxpaOxfnPyidxdYoArHle5d9dbW?=
 =?us-ascii?Q?YtasqJ2vgzmghpHurdc5jfhI/TlN1MikBUNbrPkxYM0yZQjP6tsDm9neBojx?=
 =?us-ascii?Q?0FaExd8019QV2D/BKY68wIG2OnZJsXbuaAVxwhpZmTunP6iHe1XDX3/tjgPU?=
 =?us-ascii?Q?uxpu2Q9SvG5JgulisEVpjbsoLXdrH/Xkj6quIMi+JmmLLJuhWv4Hi23xw+Qo?=
 =?us-ascii?Q?B37VglybPBok7wZEesa6JLYOARAblNFti4r8O7KMZmcqw2INEt99PYZXGg70?=
 =?us-ascii?Q?DkYkqtSsjB1chruqXL1JDdzprWUlgP68IejC457GV+fKjX4fPwMf2nzy4+gn?=
 =?us-ascii?Q?IzvXOJ/g/80OLaklz5WEQKmJpDB5DDj0wnHCtwBB67C4KNylXtUyW2GGKarN?=
 =?us-ascii?Q?v+TNM4FvqyIYrWkvcsHbD9wwBpnMTPRfftyosEz+6wO9sKUXoNz1WjlCm42C?=
 =?us-ascii?Q?E6JfyKjsA0ZaM5Op8NNkFjjOa62iTT4wmG0YSFOCsnlCBwYe2d+CUXFJ+jaQ?=
 =?us-ascii?Q?8Idr6Cgfs2jF23MtoE46n43zxswc8XH8cHDHL1cDL28GMmXSB4KOdVp0pWnu?=
 =?us-ascii?Q?UG4VgAjNBvCFhM7/H0CJxrNF1HQFbEjHlgKFKUhMCFfIN2sCsReQ4bFlmiIr?=
 =?us-ascii?Q?tS/pTzZLX7pTwiIV6fF42E3vPzt46GZKEa+/Jh8B1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKsd8qke8XfF3VkcRKtFVzJzIenkAGi0Yn2/wq7jn8oMN4pstLcrqpZ/J5dJ?=
 =?us-ascii?Q?Zj1a7/4pHss/A4eO4TS2QNBrScihVxzfMjGYiB4pE0Fsx58EPFfrJoI+kQIe?=
 =?us-ascii?Q?EAyQP74z0khoWaiZSBxK6LEbY0+YYrKB93C0lXy/Fj3FYMsJSjwPqvWsMje0?=
 =?us-ascii?Q?aAs1P/YyPiBudSPgw4IbMPFSwQol4aSJk/SrQOiYx9XBoDPGHozlPbbQjQrl?=
 =?us-ascii?Q?SX2zbkepBjANhfoguEsuGiukV3IrOnEK/dlxeHDSPfiBzHLjgD/+T+eoWk0z?=
 =?us-ascii?Q?XFwK5kU2Y9nveicyNdM5lFNIIUeW2XQrvzKkm6+StQCo4NHwxJAxbKe+QkWi?=
 =?us-ascii?Q?sZZWuls45X51HFqN7AAFNLZA0pVKwnwsDZtBoAC8a1UHfa4w9WjJGFNOmQ2u?=
 =?us-ascii?Q?Gqmq+LldPwv6EgG/wgMsScd+HoYW7SzxVXVc8qsKqU1ycuaTxCgRHZxuerBH?=
 =?us-ascii?Q?rebdYYGqbxjhG/qPCLoDyM3wmE85WtaOMuHnfKf7sshIWQIph84EgItlp0M7?=
 =?us-ascii?Q?uCMjbMSkKc24JEMNwS+SKQCq8KdEs1gyoU0g/29auk0CBsHMwEP7aP11LVxS?=
 =?us-ascii?Q?23XZT1EiKgzRwX+HW2UKo9R+XbfWakmp2bw3t/Vye8VJLx7MPLR/7jhBlKlC?=
 =?us-ascii?Q?vbyv3KRV22rF4cp7Tiu+rvMshTorXY7VIF8Dc/MEr2H0I8OW0fjKYEiqDBqt?=
 =?us-ascii?Q?1FTsjvgtfo2MJ9StMLtR24wQxCbEK2wjHzCjFd6P+XKjI62Gveyc0jgYrYc1?=
 =?us-ascii?Q?IxyRWfNr0E5b/4LI7cUU1E8RdDjxdYvzzWIk5IAOVVRckLxfwr64xct4jHrM?=
 =?us-ascii?Q?wY5foNrXiB32P12T9u2pr1RxoM0SBdTWVShaAg/u5VloZpC1Vun5JZpYova1?=
 =?us-ascii?Q?sm3o/cQAkti1rdvM/fYblqR56uK1J9fnECAT0zPMBfTkPLoxSDqifm9IUQz0?=
 =?us-ascii?Q?+fExIKf9Uj6GyiYZeN7eckCrMjsc9IZSJHOOCSV/YLWk8vvTtuRLFIm7G3kU?=
 =?us-ascii?Q?Sv2I+DOHwc1FIHJi1N00m0WgIYBWwXb2nc0Wssd5HkQDb0//9HvYe5C5wCPO?=
 =?us-ascii?Q?pDcvpR7RdDEDVH4R5VRTcTUmak4A9mMbe4WUGXZlaMlEhGuAZEqqi8JKyLDV?=
 =?us-ascii?Q?FlONoqndReemQGUGvtYlG64o+PtN0MTFeD/ym/T2aSZeDd449YPTm1FaqB3Y?=
 =?us-ascii?Q?b4Wzm8Ltd5edbINeqE2VvFEqvXqSTYdarDMj6JQhVop3KcwBsWAkIzgJ88iL?=
 =?us-ascii?Q?ZIEgCbUg9yyUEtMig0F7D6OIRqFBAieO9XKNcy7d7gRoWgo4wu5muW3aRbD/?=
 =?us-ascii?Q?oMV4XhoYSh1Shb5hqr25PiQPEWLK8OlBEAE/upS4qSrkIl7kHXtYg1eveAdA?=
 =?us-ascii?Q?CVA8zLdOdKfYFAiTC8OQS5tx1gx1LF0yxLnf600ywqojKo/06PSO6+loIAkw?=
 =?us-ascii?Q?k1BGMrCs+MZtHLOl45Rv/0Q+IeNYHcoLQjHipjiGh+/BJqLFYo2oCyoonAHz?=
 =?us-ascii?Q?37SyaKea5s8KgYMA23vlVjn4pcOVRP0BqNSEgP4YVFsdyHXoE0+EtkjgsM5M?=
 =?us-ascii?Q?SKajnZYQ/9i1LOHpaGN9EeyftiJY0dzH+AjwB5EPlwr6sHJpgRoLp4Tl3qKm?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1l46xw66bs63Qllm0GlmJc5eDaSBmlDhqQRVub4wbnYAMGfxNCjf6qEvLW31TW9lm6qxrC/LEyX0WuKZ45CGddLLU0pKs6tnNybtLj7dq8w/NT7EsjoQKpeDkZLfqx+Cl1/ewcoQ9wmhc9t5IIQzN/1tZtMy2PCyGUkoItdWTNMma6mikdxqcw2AurkfRtJguNGYFwW8IsT0/SZ69NfZX4JNMtVrLlxBjEIVlTkZSPObFgyx91nbvW9siC9RYSRsOz0TF4de9bES0jsnie4nBXdAkqN9FpYGIB0y1ohSIwMxYHaGUrC/GAE6U20PqoWnYOnaMJ48ETYc/0HE8xk9NsnI9mxO9DgepGzFqqgPHskcd6mlatSi9nipTk3w+giAacQqpg4zMPm5yH0C/6LCDZvixgwbT3eQc6SO63ZvIoIqnxvphAxdinfVN6dxuT2m1Asr2FokHnChdZva7USFUuAH2ZaRQ0si53YDXePWJ8gU4wZ+Bkbh6FIJMv6eJ41fWGXi+6gajI7sj7qzFrFvL0XbjCYk6/w997n14rBHTmPtyKjyrff2YTPbvi2XXNOOA44LmAPzHJmUaJMwLaVdJN0io4LT0RcKMc2s1ihbWhM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9514c6fc-90dd-490b-88d7-08dce9275056
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:30:24.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvowlfNCDX4hcV5R2AlnnXf9r/62KJ7lHJXmu19vvkeyPhQH8F/1zyGU0sZSdXmGkW+1g5hQkx9M++xlbNkT2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_08,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100083
X-Proofpoint-ORIG-GUID: 4UNMl-pztug9AIR_PpQ76-tyJtPBfS6J
X-Proofpoint-GUID: 4UNMl-pztug9AIR_PpQ76-tyJtPBfS6J

The following changes since commit 509abfc7a0ba66afa648e8216306acdc55ec54ed:

  xdrgen: Prevent reordering of encoder and decoder functions (2024-09-20 19:31:41 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-1

for you to fetch changes up to c88c150a467fcb670a1608e2272beeee3e86df6e:

  nfsd: fix possible badness in FREE_STATEID (2024-10-05 15:44:25 -0400)

----------------------------------------------------------------
nfsd-6.12 fixes:
- Fix NFSD bring-up / shutdown
- Fix a UAF when releasing a stateid

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Mark filecache "down" if init fails

NeilBrown (1):
      nfsd: nfsd_destroy_serv() must call svc_destroy() even if nfsd_startup_net() failed

Olga Kornievskaia (1):
      nfsd: fix possible badness in FREE_STATEID

 fs/nfsd/filecache.c | 4 +++-
 fs/nfsd/nfs4state.c | 1 +
 fs/nfsd/nfssvc.c    | 6 +++---
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
Chuck Lever

