Return-Path: <linux-nfs+bounces-7325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F89A6B96
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 16:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93471C21B4D
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25211946B;
	Mon, 21 Oct 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cJMmKo54";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RDAuHa7L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC01E526
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519677; cv=fail; b=L+ygj2jfHw9WZWeLZTwWa2tdapJ+usVzt77BIdfGaBlIu5IQxfbHvZ+P/C4C7d5QDgVdcF2XIVUJCN4sVGcDVShyhFblie/597hdVOE3utmcM5H8Ysi6547bZ2604A1px6/FWYKlj3p1i9rkqMPWehyy7aXZpzlKT4jXoSvTFxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519677; c=relaxed/simple;
	bh=QUlpOvnWZ1+h6CAy2w5Ppziz8g9Y9FcMsU/ZCNyk7X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KangwuEKy3lBFCEYUgcpBXxYuUqBMrblHveYPRUxlQ7vPmMxCN3zEDAqOrKddT3lJ3GMuUpIqYad6RS1OEZug0piBM1Z8fJW2EOG2BPCAXixJnG8uJxhEAPz+abrHhM0O/PuqY9+XtWpi0E0cmZEH1ToSlpuyiLoElArA4sHEL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cJMmKo54; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RDAuHa7L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96aqk015864;
	Mon, 21 Oct 2024 14:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jr+UOBhBT/SgT8AXDw
	85tHPy7THR/KYsL5f67Qctne8=; b=cJMmKo54+iUyj0FM6Gx9t15ewrlU9OxXVK
	E+s0vApbcKDSNvFkkVydI5E++b/0UTz7igP4NDPilGRz8xB4zFSDoGZ1YSUMUq8s
	Pqs8N+Bf0YMQxMZkI2sIXYaVt2/FQDd8gxwQmi23HyNNdo5EQaW8CPywDTQ1vSHC
	Gy1uUfX/SguT+NiOeZGnHcT6hmHdgQT5333YEv5rdnTJU6EmQWV4tvK+mUX/1lpI
	3WW0HSJ+nu0eX5Mr1MS+tp5UPy/raGVkSnkbI9KpZlgQAGld94hhTdyg7mCmNCdd
	cQ/zvD6FPuY7cHrc2P/MHHH1sIjh6RyxTu2Q2Q61C52wtGBkzMlg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asb5ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:00:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LDmH8f022694;
	Mon, 21 Oct 2024 14:00:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8eu6xe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucvJDTjpni6Sc8UgzWful2UZg495fbohWeEtVO9GP//+gzAIQsXYdEbdMGhT6130q9mkhy64f/3aybv5reClNzHkDno6Se7YxUuUYt4gAC6TYhdY2+ru9xWy78hlSCJvoR4owbJ/LVKrMniMZi0uCS/mTsEQ3zhWMJYb9qozxNgCGI1Wk8XqFti1WEHywPiMDdxlmVqCuwd5iYnISHrQ4dGaT2bdOS0Xprmh0+g64ZsEuWAwnjZGtRgQuHkIpb1GnwK7AA0xPWlVWX3wuXna49V3B3gNq+CJBN8ible/zNS07917yTi3h5ZyEJj+jmroqyz7GDgBNuKsM2AfochYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr+UOBhBT/SgT8AXDw85tHPy7THR/KYsL5f67Qctne8=;
 b=UX2BCftYpmyWPj3Bx8L5ls4E4tLlJJ87PIKZQ0y5VYK3+wINBHvtjmYbLd59MDoIHQ7WIDuuGxvMuC2bZlLULb5Uh+VOjgsXRERJq5e18IelxlwNBibMu+5XtmDhGYj4XSAyAS/2X/YmypZprJsY9kq0mLdLGU7Kw8c+gmdScS5quue+IPoH7M2tZTOlZAjiQqirGXtZQK67w1G/eUvstS301TrbQpzCJNshL+Q3KOiRK+l7o2TDoWq+HSGy5/tQcTAkazD3i2zXIajmTHtbAiSRifUo5HsRWPqP43N3978oGHolQSSY8Gtsuud6Li3FzYd5oqATpxmzAQ+ytwSkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr+UOBhBT/SgT8AXDw85tHPy7THR/KYsL5f67Qctne8=;
 b=RDAuHa7LH0eSIPWYrYuyFTlkkaZRMXrDMSyqzygyXtcQ/qxwBPj2i2xm/YpFvmG3n1qdaw09V73roSuVhJLJ76kpT9Vsyhd+28DlPMKIa7meFuV5qRzCnrQi4j0/73Wlde8QozhKTGzliS5d1NT1EVAzVuDGqs9outvL/gf1lMM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5925.namprd10.prod.outlook.com (2603:10b6:8:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:00:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:00:11 +0000
Date: Mon, 21 Oct 2024 10:00:04 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org, yangerkun@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] nfsd: cancel nfsd_shrinker_work using sync mode in
 nfs4_state_shutdown_net
Message-ID: <ZxZeZB51iwVgVZt6@tissot.1015granger.net>
References: <20241021082540.2885014-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021082540.2885014-1-yangerkun@huaweicloud.com>
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 164dff65-4e1f-400f-bfdb-08dcf1d8adb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D3r8tuCK0V0WdmYFUjk9Lpl5DRFjCdyb/MTCP44TuhIDZ7k7KMWmyJqygkk5?=
 =?us-ascii?Q?3KMLR9+2f3daL/2HuYUGVmXCnzYbqkqcRsow7/ztEPybQUAC3zqDqK7wkCbH?=
 =?us-ascii?Q?fcfTnQkvK8L87N/RrWp5wiVQk0FqpRgnwKLtFwpmKfDQBVZQErYaQaR3DMhK?=
 =?us-ascii?Q?5b3audU9Xt11GB5PppOplkyiEYch4JGdrCQunW9itT4y6bjAiKkQhh/JM/NR?=
 =?us-ascii?Q?J8mdyfSYTMemn2JzrxmX98HnJg/4r63ViypQ1xQOo8Xa0l6WhgCV9ZU5kAMt?=
 =?us-ascii?Q?iqepQ9Lcp+UVEe4aSDMZ4tUqwZ4pvgRmcAR/dpCsipi9J1Oiqd3p8WRYmC59?=
 =?us-ascii?Q?yt80ALIk4SrZy9MzarJSRbH1t8jYa1khLUmnQYtieo8RNxGj+p69e8kpF+vK?=
 =?us-ascii?Q?6IfYqxNpHWOlvilXx0lhovMxKCaX+OR1VCLu3CAAletX0VPqh2mBGyHyy4Ly?=
 =?us-ascii?Q?E+P6YJRXs2gxzlvVN9pcYMV3abxQG3VGQqjhNN48YmCJlLc7cbYjTEx2yg1F?=
 =?us-ascii?Q?CKtaOcGe2pXwP0QXNb2OLatsRCjUgDauAKQMdfKzqDaO/6BgzykBpEYFm7uJ?=
 =?us-ascii?Q?MQKHsmUTSYIRdDioYgxeuQppR4mItEmeEOZn3rdTEWIDMMwv4h4+cQDTww2a?=
 =?us-ascii?Q?gywK6go7NrQ/jG1cYC8JWF+/FBi42wD+mrsgPhcWcPCt0AioWzx6OOMFZkF5?=
 =?us-ascii?Q?saqOHIvRTAP7/9jgUQKwnhar3W9gNJqgYKsCwW51Ip4sBpD/jdXNTynH86vU?=
 =?us-ascii?Q?JqVWQCt/37ulO72AojZP5ZQsUxWX41KTwIEIzcy/FDprODsQWxaOyRSzE1hR?=
 =?us-ascii?Q?hQFaoqRkvsyX1gOAhSx7hrfUWfF9rBrkakYALWHZ4OOcSP/4Gi8sW8jOeR4w?=
 =?us-ascii?Q?YUXNLmA/0zfhrol5jgBK/+gvjtjtVNO7lcquFFDQ9+E+U6DQrXYhCTarIW+e?=
 =?us-ascii?Q?aSJVjvvgyaXELYb7DHlY7Bv1oWrKXB+K2Vh16FhwcDq4ZeBZrUbyT2hHiHKw?=
 =?us-ascii?Q?IfBfGrtQ7dxTg/FXobxrbQ4m2iAiPQ4FANKJ5XNsgL8E5zoqz/pBl7dBycb1?=
 =?us-ascii?Q?LJ1Y3DTEXAflRmatQvG48ARZPPmyurkaiJkUzBXCXmnCv9jtkEbA0SrckIU5?=
 =?us-ascii?Q?2uu5Skqcjnhj/Q2xxLeVqkrhaoN9qd+XecdiLowdeGf0SRx0e+TnBWJZvk4U?=
 =?us-ascii?Q?SKK+ZL1T5nUghIf49eiv/Fp0ZErUNOWvaQo7pb0PGEK2Gi0intY7UcKilqph?=
 =?us-ascii?Q?YnGevE+BG+mFKf1gERE1UlJbHbumkyOf9edAToTkstG71A00KyUzDYPMiMPE?=
 =?us-ascii?Q?NpnlWYvQWZKdc5gUMPTMeeSQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/DweGW4tvcQaNIFUTH9EuHOMLnjKpN/lgYyNibe8cb+xke6nJlD2zRywL7kC?=
 =?us-ascii?Q?E7R0Aq5aw3iyHtz6ifKSY0z2sC886n95B9dbRLnqVXc3xVH5kWHF3YLyTpII?=
 =?us-ascii?Q?jqgr40QNH2gw2O3EMBX1RmQK7K8vYDMXhtFYRHYDiabsmAzalNIfTmpgmL/F?=
 =?us-ascii?Q?qS7t2SR3fvkjOMlaXOm+tqzwDfvOi/ZJ8y3HD/iD1U/7vmun6aGmAKyis1TM?=
 =?us-ascii?Q?3dndbDjfBhyJHHBdrW53YXunbCgccBJqcNt9eC7KjKuTvpXLMRvMusd4+mmq?=
 =?us-ascii?Q?azx59x/Df1RL1GK9UnzvPUKqHmhCe8VuTeYjzAksAFMrKXJKlLsfmLPptUYT?=
 =?us-ascii?Q?qR3A0q6q2ZSbuZHNg+Mlx36rBh7HW9JdCPq4gLzDKLZjSCBxBDp/wHhQzwwU?=
 =?us-ascii?Q?MB6JEe6eFvWBhAXWAJnTM0NThcL9rBvnWEcTcScIrMTLHholPEGxe/7Gg+xE?=
 =?us-ascii?Q?DlmOHhxJzCBMm+2VDTTYqH49AlhZb7KqlT5eDkSz2blGR9qB2ZvJwTTGCB4X?=
 =?us-ascii?Q?MIbBvBmIz1JRw3jU0PqWv9u3Wxr6AUBpNOSp/Vgp0Cy99O+Dgsf1nhtNgYAu?=
 =?us-ascii?Q?30OAZZCIc6wReIgEKP6zthm21TMRb8ryc/z/XuGgJILz6eiPr/XxCGUnlatN?=
 =?us-ascii?Q?7Id2Jc/QdXwivd7us0qKQ1scMj5GSLraCw7LZ/KgWMX9e+X8Xik04rCJAWoT?=
 =?us-ascii?Q?OorJRmsMB17eO6fFR1QLrrD3Bs5GcLf4Y+X6PaW0+ay+pfFGr0XgC+ufqb3u?=
 =?us-ascii?Q?e4wUDfOiC/TD/FNt1xn0Qs8qyZpzx19XOQ7y/TRUukW3uLLfxePFiq167fWU?=
 =?us-ascii?Q?VHuoIwDEGxP8DY+yNVocFCPGVHHnKu6NbS2ame3+QJgAZOci5cMDiX2uGwcX?=
 =?us-ascii?Q?d1W/Yq0dULJgtS701xoy5YZXIdXiDvXGpPmnEa11ECOBHnXj68PgjQ+tJ6c3?=
 =?us-ascii?Q?ksp7RJZLaZHuksAlIK+n681SLvEOdr1RNbH7YL8KF/lV+zgKXebJlLUZPImy?=
 =?us-ascii?Q?vc/K1frnVxgXerOU4PqSVxJ7TOIiWDBC3Olzg9sB9lve9fhO5BzzT/RJ2FvV?=
 =?us-ascii?Q?IbWrOvQxBCo06CwJI4Pbi9dyUDiuvOhKcULa0IKWEuMCY3qJjN1asTxcfGbz?=
 =?us-ascii?Q?WzHS9qxh4Ad9wabI5bUUm4DpDEfyrmcdZy9k2P1mNBBKQ4TiLRjJgWI2uCxR?=
 =?us-ascii?Q?wPTjNWpDbW1ZMI73wasLWEBcc1chnLXsRQS7FNNaptU539lKc09+KVZ+9Nrp?=
 =?us-ascii?Q?RTW4qKlvKWekWv3yoEXx040mpBSBYiVRxJzYDj6SJ1EMQVvltRMq/7tndiB9?=
 =?us-ascii?Q?NqYPGFrLMGcOSAR+20/qnkmOvJeoQPAn2APNvNRaz/8aG1sWugesRLr7DB/D?=
 =?us-ascii?Q?5FFfHUEaMOxBG4lJJXWH34eROmVBoAidnj7Utt2Nis0dHTCHxm3FMcA5dKlx?=
 =?us-ascii?Q?g/Ya88yees5G5qJleipS8wEdARN1zIK16QKAh5MIyadfb2yDAcpPLZl9LWop?=
 =?us-ascii?Q?tCsz9fz9OIe9fwscA59Dflx7PuuN9YJHIrsk5fHlcDMXEw7hbighIedMtXb6?=
 =?us-ascii?Q?wEtsTCFwtI56K4DR4tka9vQRKPq7T62gWeT4/ss2TbCeqqNQdMR0DvQclVEz?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hTP6Lwd/ynsxuJ9U/ePJsPjTctSLeR32HCHVsGBkiydDupYP+tcb7P4KjsE6OeK015S7695OrNhqHmjuXJ7NztXyZa3BP23DIDwoFbVtJchEffnJ/bXWs61GffbPfhDERGcSfSbBnHZqniT5X9DtJ7yQa9veBoIOh9Xe882L4loo9b2c59Uxmfm/v6SvqHUXt7C5UQnkCh4Do9Ll2Q9XGBkzb13yz71GEn9IQILWedxM8v+25RGsi0tld4m6Wox4ylXRN5i1gWyM7Fu63yGbyuqH7y1HJwqty27JVCjUBeZ3m4zpvS65d3884rmEVcOW4V7U4zTQmtk6lRjq/rtU1woGAJJRis+YlXvMARSUKhnEKEm3tkqtBm4EY1wN91cMU4O66lyJXCJRd5ydJOzGVYh9fJetg+n7R8JWmBo24fLNJWVYv/KgsLpydiAn6xS6lxlL3PbbbV931YoU1RABmZkw+ldbG/CdqGmY68nMUGoH+JbU91QaDx4TBxpKYiWKUozrkcQi78LegcBXFRg+ili6cKUGk+8+Bl20rOlqWAMyf9vwjwZ4IcSG80xGUDOYP0QoGuiys0/QyRciaAHjJMwyeHrEvMO8F2+FgqYwH8Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164dff65-4e1f-400f-bfdb-08dcf1d8adb6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:00:11.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcYl1x9l5z2TMblfHlC8xpl4tK9W0/9UUkGG7deyF+O4ELRYGI/5f/K8NSIK7jY2BIgmgZnmQglgBW/z7SMMlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_11,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210100
X-Proofpoint-GUID: a6IDbk6wi4pfbU0gYIaBhwz-Q1Po2d_i
X-Proofpoint-ORIG-GUID: a6IDbk6wi4pfbU0gYIaBhwz-Q1Po2d_i

On Mon, Oct 21, 2024 at 04:25:40PM +0800, Yang Erkun wrote:
> In the normal case, when we excute `echo 0 > /proc/fs/nfsd/threads`, the
> function `nfs4_state_destroy_net` in `nfs4_state_shutdown_net` will
> release all resources related to the hashed `nfs4_client`. If the
> `nfsd_client_shrinker` is running concurrently, the `expire_client`
> function will first unhash this client and then destroy it. This can
> lead to the following warning. Additionally, numerous use-after-free
> errors may occur as well.
> 
> nfsd_client_shrinker         echo 0 > /proc/fs/nfsd/threads
> 
> expire_client                nfsd_shutdown_net
>   unhash_client                ...
>                                nfs4_state_shutdown_net
>                                  /* won't wait shrinker exit */
>   /*                             cancel_work(&nn->nfsd_shrinker_work)
>    * nfsd_file for this          /* won't destroy unhashed client1 */
>    * client1 still alive         nfs4_state_destroy_net
>    */
> 
>                                nfsd_file_cache_shutdown
>                                  /* trigger warning */
>                                  kmem_cache_destroy(nfsd_file_slab)
>                                  kmem_cache_destroy(nfsd_file_mark_slab)
>   /* release nfsd_file and mark */
>   __destroy_client
> 
> ====================================================================
> BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
> __kmem_cache_shutdown()
> --------------------------------------------------------------------
> CPU: 4 UID: 0 PID: 764 Comm: sh Not tainted 6.12.0-rc3+ #1
> 
>  dump_stack_lvl+0x53/0x70
>  slab_err+0xb0/0xf0
>  __kmem_cache_shutdown+0x15c/0x310
>  kmem_cache_destroy+0x66/0x160
>  nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
>  nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>  nfsd_svc+0x125/0x1e0 [nfsd]
>  write_threads+0x16a/0x2a0 [nfsd]
>  nfsctl_transaction_write+0x74/0xa0 [nfsd]
>  vfs_write+0x1a5/0x6d0
>  ksys_write+0xc1/0x160
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> ====================================================================
> BUG nfsd_file_mark (Tainted: G    B   W         ): Objects remaining
> nfsd_file_mark on __kmem_cache_shutdown()
> --------------------------------------------------------------------
> 
>  dump_stack_lvl+0x53/0x70
>  slab_err+0xb0/0xf0
>  __kmem_cache_shutdown+0x15c/0x310
>  kmem_cache_destroy+0x66/0x160
>  nfsd_file_cache_shutdown+0xc8/0x210 [nfsd]
>  nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>  nfsd_svc+0x125/0x1e0 [nfsd]
>  write_threads+0x16a/0x2a0 [nfsd]
>  nfsctl_transaction_write+0x74/0xa0 [nfsd]
>  vfs_write+0x1a5/0x6d0
>  ksys_write+0xc1/0x160
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> To resolve this issue, cancel `nfsd_shrinker_work` using synchronous
> mode in nfs4_state_shutdown_net.
> 
> Fixes: 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low memory condition")

I think like:

Fixes: 7c24fa225081 ("NFSD: replace delayed_work with work_struct for nfsd_client_shrinker")

a little better.

I'm very curious how you stumbled across this one!


> Signed-off-by: Yang Erkun <yangerkun@huaweicloud.com>
> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 56b261608af4..158d67186777 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8684,7 +8684,7 @@ nfs4_state_shutdown_net(struct net *net)
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
>  	shrinker_free(nn->nfsd_client_shrinker);
> -	cancel_work(&nn->nfsd_shrinker_work);
> +	cancel_work_sync(&nn->nfsd_shrinker_work);
>  	cancel_delayed_work_sync(&nn->laundromat_work);
>  	locks_end_grace(&nn->nfsd4_manager);
>  
> -- 
> 2.39.2
> 

-- 
Chuck Lever

