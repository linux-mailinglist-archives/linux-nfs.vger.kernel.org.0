Return-Path: <linux-nfs+bounces-7859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555DC9C419F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 16:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95A71F232FF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B1C18A6C0;
	Mon, 11 Nov 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oi4nol1N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QmOaHxqb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002D25777;
	Mon, 11 Nov 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337915; cv=fail; b=bUZEP64p34tEFBHpyr1eT2kSeXILwkg91iaQuEQ4cschYCZaaaS0woGp6da8CCLq1+oUGuRflisbFd+hHeA5SyhCMlkbc89YPA5pvn0ekaDIJSbM3Wsql/N7IdixBU6PFycwBZ6TAMmziXxsUSGxwv5K8yz+pNbyKxmm5j2PhdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337915; c=relaxed/simple;
	bh=sNnvuxaoQMDpFR+5CgcLezs6rszEkeNXw8KhFUOsCu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qMA7ddWheQcUpsCGvcpMj6z2mSyp+RwkquMMd0VreYuE+c9lOyRCUvnWKmZdncs25KTGV/qJ0f7rSjJUKK9wmVuDTuLsC9DtyUBm1hChipdn5dZQPkuUs2vIWSfM6LhYh/UiPzHRoGVx0HLusYlypkF8Qrsp0PZ5GQtiGPXm+CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oi4nol1N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QmOaHxqb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9so3d026324;
	Mon, 11 Nov 2024 15:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=80Le69yj3A5Jr4zX06
	GByOq7j31jE6Ow9OAgJUKCwck=; b=oi4nol1N9AooG1J5KOm8CbuyPlodsBrbVq
	G7F1tiDyZTyDk9NAPDiKsawPafsPA1nyebVKtNd5KNL0+0WRz/JKmdJW2PWmUtb9
	rxez3sTVccLURy9LI5i5G5laIQp3FmJdByNpblaVurm8w0VbceCci09ORf6vdpme
	3t/oTWNDvjJ810xvdKqyOSNP/jW1bgfx1tyA+IfjMmfgqabKMqVa0/NpxYyJ1cND
	ZajjeFFHBSUbnQdbeErRVTuv0Sc+Z7H1pxQ19zO6gf/EUEHXEZ2xFjGYqIxDaWuz
	PQBkK/L8SfFiKHydQuWLUolNJ2EhTQTRpJuNQ85AHfIg0a+kT6oQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5aj79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 15:11:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABDU8QF021541;
	Mon, 11 Nov 2024 15:11:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx66w62x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 15:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeDBDlVGwdxruYamnwMOU+ANjYE+G+/XNOIZ/o46YVePSA9AUknm1W6azEEnglUkmUhZUnAfatUeOUesm7UO1rZzyKDdwU66ZkIJ9ohq/N8h4dpfGLVGjABJOfA/8TA4Ce+Yl3vnzUYUf7A2eCJIn5PTYFFPqU5lypo9zyCKgeljWxuiKQo3V3GQokgDpnlQ+ZfUsJNMNuNj0aitCXehBGjQ/WeOQgFD3KYbHe0bRGrhCKGLS3CIRMGuP6AkkrvgC/J+TpHAsR8GofGf1u0xUHWd5c1Gih4px8wTMZ2RuYBmSP5p6e+1Tkr7IzdEY4QpzIUsxzmJzry/i08YJiqVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80Le69yj3A5Jr4zX06GByOq7j31jE6Ow9OAgJUKCwck=;
 b=izMoBcge6H4NWsa+Qm2cr3+t2EL42zaabzBAlWZI9oBnVC+y6SwMn/Te0OQVJvlyVzhN3qeYh2hLfMiWFl0aE8qGeSd0Yf/Uv8KSQEsY0yrjFOilhl+nI5SZDYKs1s5R/p+xRTJ8pUYidT7XAS++i+mtM1wSAX9b2jPDYVmv7AN4LT3JXlAPt++9ZNcFY7ophVM9ixz0dR97w30RE8CVgFC1RC7uTpmyAlx2PAfYRYfFC+hbDMT1e5hFtUTUvN4tNnbaqsyVKluR8KrYplw+BArHTOodOtIK6aSmxiZmXyfHD66D8FIasBGW0YMo2mD1HxEIrkTAZpb8+/LEp9lr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80Le69yj3A5Jr4zX06GByOq7j31jE6Ow9OAgJUKCwck=;
 b=QmOaHxqbwhvXbS51i5Khr+XyDZAukKfT3RwGRMXBXhOTU5t6FO/q2Ctdq6l/DT0Kw1iWvz52+d7LFjYvKisE27CLFoGZiXC++IIjbFQmvM9Ad21Jdrdg+OTL8ryzpa7Z75FWi7Di2+3udkCl11qeo5IwvDj1mRNBljoA/4WV440=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 15:11:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 15:11:11 +0000
Date: Mon, 11 Nov 2024 10:11:08 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Liu Jian <liujian56@huawei.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, ebiederm@xmission.com,
        kuniyu@amazon.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] sunrpc: fix one UAF issue caused by sunrpc kernel
 tcp socket
Message-ID: <ZzIejAHeZYTqOqeH@tissot.1015granger.net>
References: <20241111081736.526093-1-liujian56@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111081736.526093-1-liujian56@huawei.com>
X-ClientProxiedBy: CH3P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 75065bbf-9690-4412-3969-08dd026313e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mpCFDz6EgSwHHIm94Nf5mA8QajQXfn33dIzuyWBl9bOIMamQ9URAFrZg9hOE?=
 =?us-ascii?Q?6/MwF8wy7brJIA1vk3CKQQgyOUUrN4A2gwirxjWFVAGO2Rbf0BIjk3GrwX9U?=
 =?us-ascii?Q?R5oIACCGIR+c48b7VhK5+jSy2W0HyDgLxfUqJdhN188e+DAoSecXyIAEjLLP?=
 =?us-ascii?Q?6RJWHMhQ2u+fltcRpt0T1Vcshi89TW5FpI10tk4o2l2vikXp4iFh+ORaz/kd?=
 =?us-ascii?Q?vOjY3QRrrJMjj0Fcb/MA6siLwdcuWYSNu1XlgM4Oao80yIooPefHCFyC4Y+D?=
 =?us-ascii?Q?w5cNh75i5n8JVDv1iWJ5FmIsdHd3YULwyBaGwvEoo4HlX8kUf3VsLGUZHQQo?=
 =?us-ascii?Q?OzXhZZ8B0f/H2ecVtl6uNsWuW8TKtq5nLS4gYe37mB3Qcks8IKeC/ToO5N4B?=
 =?us-ascii?Q?1pnhcoT2jryIZkwXMWtga24tvojfdD4eVgwdPhrlaF/RP4Ib52hwQbMSpnRW?=
 =?us-ascii?Q?Q/jeh3YcwY3cxOo0Rb0gEzGqOgxBGS4lNWCbhonpSW5yn4lcrS6cmp9uq4DR?=
 =?us-ascii?Q?UYb2XdoCch+FlJnLYPzIjkhZwgc12nCQOP51m2nAcDaJSPPYjlXOCI4hZgtw?=
 =?us-ascii?Q?Cy3PfGNbov0o9fNhTdpOAbNfd7RtOlE4pZkORiCSc/KoIvi3cUmTy5QQW5Y/?=
 =?us-ascii?Q?3gZq8h7btKlx3sswJxL3oL7SxFMhY9ooanNPpxmaXfNT/PdJ8KlobdfBsoBZ?=
 =?us-ascii?Q?lSfU8U2tprLKF/T4imUyDkv9HCS4ZJrFCsXearIBpwCHKlFDk4rFboFNllmc?=
 =?us-ascii?Q?mIY+9AJcTV2sjiUq899UlS3PXuvrwJNXqr+QxenTFbpOqqiU7IlhLLN2tZIu?=
 =?us-ascii?Q?Lhq8hrwYFqdjzRqec4lzXUd/mrpYN0IM6yzADDjyE8ebSsSWfkdbfRqmmci8?=
 =?us-ascii?Q?UDc42fvw3JP/nC8V8YxcbRKtBNeXnxKOT8x7wghwIFGDnsPPkA00i3QK8sGT?=
 =?us-ascii?Q?tdOVm9hIT+ibhxEwf6NIqxcUQROXHG+W2leJMEURjF4e65mniw6H6sfagVIJ?=
 =?us-ascii?Q?/rwThpAEyYuy9ChIl69RqWn2Hr/vCPKaaQs4/EcdsK847a98FMyp8OGyGd6b?=
 =?us-ascii?Q?mCIePK1Oa3jAVIadh5SLhVk6n3kW/Q+kjAKHPrsqXWGNy0anPnjw6CbC2lTg?=
 =?us-ascii?Q?ahGhIdDym8z2ZYaeatQA3lIpRM0gw/a77xJ2Z5v5hw1cR/18seeVo3NNINgC?=
 =?us-ascii?Q?uG7zhin7ZOD+OAomeL5agsfv/H3Zx5U4rSbznX8vtG6QLRpIGPP29YW9iqYH?=
 =?us-ascii?Q?RbQnJ3PyohjJXjfirCKbmhl0/5yAhExYOifDFoWg0nOktpNatneA8XZCkAxV?=
 =?us-ascii?Q?2MV2s77CFllKA6GGvyx2p17d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?emR8eQ/UKdYtBRet6JG2dfs1VypKldpES6GRQDzY2dMy0qKPSKua4/OdwrER?=
 =?us-ascii?Q?cSzUFr9x7xCYzS418t3GfEoEWcLQQ5BjWuDTk0e3Yi67OWu1LFEF+yPa5WzX?=
 =?us-ascii?Q?+iG4Yln7lLueWWxAUOA67QWGtsIBbsiFLpSLmuChHkh6XxfPVdYI68mq4bWs?=
 =?us-ascii?Q?6LJF8c+N3WPkOscL+zhpy4qfChQqN3hEn5yR1HEhuDQKD1LwabdufNNDnaGl?=
 =?us-ascii?Q?ho6G0LWxG1nhCCpecG44TwjkfIstpEqs3tY3iPZSbzA2KBny022IfwJdB61V?=
 =?us-ascii?Q?fVS/neSObV+L9Sh2ddc/JC08OcI89lEKNhaMb3gwSA1LLD9bEBhSwzGEYIvC?=
 =?us-ascii?Q?t4ilMNUT6TCX9x9ado0u+NlMf4jEj/xMlcEHPeFqOaEoShT/kB1LMKa5CVNx?=
 =?us-ascii?Q?amzSzE63mJ/6BkQuNI0Cz322fXSVEQwtbMwxctfJwkqhDy/0Z7lUcA6opKHo?=
 =?us-ascii?Q?x4bvo0anDzyTxwvjdlDQWzmC/QDyVdnXb/pA+3zYsV3CePg3NsFqZuOQJGuC?=
 =?us-ascii?Q?h2FNNdDKI2X37oPwnV5jD3wJ/XW8XlGBEu8CoLOd3rpNVPh3j9j7EBAwotUU?=
 =?us-ascii?Q?YscFD1vmBWt3x//Zvlary4U+2/oNJ14F092DYxT2+bfItUvfYdngPWKCvduK?=
 =?us-ascii?Q?HTcLvHHqqoLVHg/xpPRsMzS9bJcDGADMMoT+EaDcIBKQP9d7PVuvjiH0M4Uy?=
 =?us-ascii?Q?vlZcYfHKDNz7F52laGEPX6tnlIFOAbQvg0OQllZqqXx8Pm9a277LSG+HATgD?=
 =?us-ascii?Q?zULlGmIAf7q88ZqyCga1JUHnTFHm0dspNL92FXy/6L9vCX48lgrogJmX6JuE?=
 =?us-ascii?Q?4MlmVhfaemBV7F1CKDu5rOzbNVC6loX+AfQMfVTXXBkIu8Xg7T8cmjuVDZLL?=
 =?us-ascii?Q?RwUBh3uEL3hH4TRxZvtCzZQCyuj0o1vzE9GHNusr2R5cA01zyLwXH25DOr7m?=
 =?us-ascii?Q?Fm7JEOpMey+U0+hu5lLt3XoqrxtsZLAkZ/Hc7HK3H7UDoJI6kzX6frlD+yW6?=
 =?us-ascii?Q?47mDc6GAeDYHKSZXzqYtJPwF9InMqLE0aFrVm64UHZmUdNsJBSj5FPihFYV8?=
 =?us-ascii?Q?jELmwKY+K9R/1Xz1wju+CpaOMIisIbwVFLygYn72AidY1KMDUFTtZ0HCtr0B?=
 =?us-ascii?Q?Zj4R5WMZNn1n7OLNAE/LG50YqKDv8ybNAnX7a+/3caOz0n9Ze7BfBpLO5/rA?=
 =?us-ascii?Q?H0x6fji4k3ymBxUWsirxu6ue2D1qL3WxHnMhdBqnCLFjxd5BQJIYQKQq7RrN?=
 =?us-ascii?Q?WWaOW8cydqOChgsV5cIaiR638yeEBJrl6RBXvK52eeHmaGhdSo8MtpSZLv/W?=
 =?us-ascii?Q?PKSkdmaJoIS5EDzF+LXzXy18p09vqO7/yTbMwPKLQtomY+fnTAgNNlK5jlZf?=
 =?us-ascii?Q?PYBCPfCIvFf5W0dEkMitFlcN4I0dVgFKJAiscn2vMl3y+QQkGU9yQlPUKX7R?=
 =?us-ascii?Q?y0pmyMz/P6w54qcL+Cx8Gm6uUgXp6aj0QAgjeCe7+Zkab9Pn126RPEUAbj4O?=
 =?us-ascii?Q?rO/iErrjbKW1OWyYVhEz3I4OPjKQDH92P/7dLLVCEGkG5gk6fXOJ0ePwIGan?=
 =?us-ascii?Q?pCccmwIYqlW06JYuzCCTDapombtQxNGY5xj2G9Qe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IkkGXD6Uo2E8i+D8tb4UbiqNNomcUqO7TiXcH7DVQxgpY8VNXJpTVFRKEI7/ooXalcrk/7juqWs9PVryTcxZNg/h+7cGQ6ci3TqFBUFSHowVv5CioaXVUEWW9JxHjnLwUo11kfAKZ4EEliBHVziSrF/soPLuDDYULErnagF3Ru8c7hAR87aHgZtbr0GoesaVC6eUD1ZYDDfec0Um3jSD/Tx3dUXMtNcTyP87IYdbW4Gu46DsjBM5MFjxzOdXGX6kWVpuLfjU4zKJwNPwiCyaZTXYYbVYuE+og6o4PYFOn6rF1kAI7gjnFK6Ec6Mp51D2dn9Z6LMwcEKmJxq7gVovsimdnCJH2tdcP8pYcVLigK7pVMpbi6WtJCj2njxbliQKIWYPVe81efJph9+vizk2ShaWCC+lAu1qNtfc/EYG6FJSrRoF7cs+Dae20nNRl2/FVy3WOn+cXX19G0iYOsjLqBGJi2lLKHGCIcYspIZ1qjzrE+K6a3kHgZQW4Ag2DFZL7DjAkihLnqHiK86TQb9uDGBETYBgc5uB2hl4btrbSxF//p+dGwX7g2AyUOIcvOG++Ieljt98D/6Go5H+F8reKA04177XTSIZMoX2sWd6mnc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75065bbf-9690-4412-3969-08dd026313e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 15:11:11.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Obw/pd0PoiApnmVW2ozFyV8XFWICLf77C84aYwXHt5UZbP5Ox0HE88Qieq8NQzrqv0j2Nuf/cMJwRCUWGuVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110125
X-Proofpoint-ORIG-GUID: w3s2oE0Ugmca0wxMW4JCAXxpmdckhNHB
X-Proofpoint-GUID: w3s2oE0Ugmca0wxMW4JCAXxpmdckhNHB

On Mon, Nov 11, 2024 at 04:17:36PM +0800, Liu Jian wrote:
> BUG: KASAN: slab-use-after-free in tcp_write_timer_handler+0x156/0x3e0
> Read of size 1 at addr ffff888111f322cd by task swapper/0/0
> 
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc4-dirty #7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x68/0xa0
>  print_address_description.constprop.0+0x2c/0x3d0
>  print_report+0xb4/0x270
>  kasan_report+0xbd/0xf0
>  tcp_write_timer_handler+0x156/0x3e0
>  tcp_write_timer+0x66/0x170
>  call_timer_fn+0xfb/0x1d0
>  __run_timers+0x3f8/0x480
>  run_timer_softirq+0x9b/0x100
>  handle_softirqs+0x153/0x390
>  __irq_exit_rcu+0x103/0x120
>  irq_exit_rcu+0xe/0x20
>  sysvec_apic_timer_interrupt+0x76/0x90
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> RIP: 0010:default_idle+0xf/0x20
> Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90
>  90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 f8 25 00 fb f4 <fa> c3 cc cc cc
>  cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> RSP: 0018:ffffffffa2007e28 EFLAGS: 00000242
> RAX: 00000000000f3b31 RBX: 1ffffffff4400fc7 RCX: ffffffffa09c3196
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9f00590f
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102360835d
> R10: ffff88811b041aeb R11: 0000000000000001 R12: 0000000000000000
> R13: ffffffffa202d7c0 R14: 0000000000000000 R15: 00000000000147d0
>  default_idle_call+0x6b/0xa0
>  cpuidle_idle_call+0x1af/0x1f0
>  do_idle+0xbc/0x130
>  cpu_startup_entry+0x33/0x40
>  rest_init+0x11f/0x210
>  start_kernel+0x39a/0x420
>  x86_64_start_reservations+0x18/0x30
>  x86_64_start_kernel+0x97/0xa0
>  common_startup_64+0x13e/0x141
>  </TASK>
> 
> Allocated by task 595:
>  kasan_save_stack+0x24/0x50
>  kasan_save_track+0x14/0x30
>  __kasan_slab_alloc+0x87/0x90
>  kmem_cache_alloc_noprof+0x12b/0x3f0
>  copy_net_ns+0x94/0x380
>  create_new_namespaces+0x24c/0x500
>  unshare_nsproxy_namespaces+0x75/0xf0
>  ksys_unshare+0x24e/0x4f0
>  __x64_sys_unshare+0x1f/0x30
>  do_syscall_64+0x70/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Freed by task 100:
>  kasan_save_stack+0x24/0x50
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x54/0x70
>  kmem_cache_free+0x156/0x5d0
>  cleanup_net+0x5d3/0x670
>  process_one_work+0x776/0xa90
>  worker_thread+0x2e2/0x560
>  kthread+0x1a8/0x1f0
>  ret_from_fork+0x34/0x60
>  ret_from_fork_asm+0x1a/0x30
> 
> Reproduction script:
> 
> mkdir -p /mnt/nfsshare
> mkdir -p /mnt/nfs/netns_1
> mkfs.ext4 /dev/sdb
> mount /dev/sdb /mnt/nfsshare
> systemctl restart nfs-server
> chmod 777 /mnt/nfsshare
> exportfs -i -o rw,no_root_squash *:/mnt/nfsshare
> 
> ip netns add netns_1
> ip link add name veth_1_peer type veth peer veth_1
> ifconfig veth_1_peer 11.11.0.254 up
> ip link set veth_1 netns netns_1
> ip netns exec netns_1 ifconfig veth_1 11.11.0.1
> 
> ip netns exec netns_1 /root/iptables -A OUTPUT -d 11.11.0.254 -p tcp \
> 	--tcp-flags FIN FIN  -j DROP
> 
> (note: In my environment, a DESTROY_CLIENTID operation is always sent
>  immediately, breaking the nfs tcp connection.)
> ip netns exec netns_1 timeout -s 9 300 mount -t nfs -o proto=tcp,vers=4.1 \
> 	11.11.0.254:/mnt/nfsshare /mnt/nfs/netns_1
> 
> ip netns del netns_1
> 
> The reason here is that the tcp socket in netns_1 (nfs side) has been
> shutdown and closed (done in xs_destroy), but the FIN message (with ack)
> is discarded, and the nfsd side keeps sending retransmission messages.
> As a result, when the tcp sock in netns_1 processes the received message,
> it sends the message (FIN message) in the sending queue, and the tcp timer
> is re-established. When the network namespace is deleted, the net structure
> accessed by tcp's timer handler function causes problems.
> 
> To fix this problem, let's hold netns refcnt for the tcp kernel socket as
>  done in other modules.
> 
> Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  net/sunrpc/svcsock.c  | 4 ++++
>  net/sunrpc/xprtsock.c | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 6f272013fd9b..d4330aaadc23 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1551,6 +1551,10 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
>  	newlen = error;
>  
>  	if (protocol == IPPROTO_TCP) {
> +		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
> +		sock->sk->sk_net_refcnt = 1;
> +		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> +		sock_inuse_add(net, 1);

I'm not as familiar with net tracking as perhaps I should be. Can
you tell me where this reference count is released, or does it not
need to be?

Does the net reference count get carried over to sockets created
by accept() ?


>  		if ((error = kernel_listen(sock, 64)) < 0)
>  			goto bummer;
>  	}
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index d2f31b59457b..0f0b9f9283d9 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1942,6 +1942,12 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
>  		goto out;
>  	}
>  
> +	if (protocol == IPPROTO_TCP) {
> +		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
> +		sock->sk->sk_net_refcnt = 1;
> +		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
> +		sock_inuse_add(xprt->xprt_net, 1);
> +	}
>  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
>  	if (IS_ERR(filp))
>  		return ERR_CAST(filp);
> -- 
> 2.34.1
> 
> 

-- 
Chuck Lever

