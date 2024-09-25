Return-Path: <linux-nfs+bounces-6645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4059986429
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 17:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C03B24FE6
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 14:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8A19AA73;
	Wed, 25 Sep 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YO/+vIRS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qUUB0IY5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4141D5AD1
	for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274103; cv=fail; b=G8yUlYIPJP9LI+01waaePTmA5pD56xs5iumau9evx6DZusH3Fqsj8H0sVjQV4MAx/+WofqEiHPe5D5TLO/LBfTCf78fdKPNc/XVawxy7fccJoPHo8wDMcC3MjUX0dSBjJ2lGyYrJW8eSjg+qPhYv5F2imFaTY90Pbxd8Pv/pnnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274103; c=relaxed/simple;
	bh=7FEjZRjhsvxcP4aj9a4HmJ6QomJzDnHmUxCoVF9B9uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=chYVNiH2YOa067IOOk2rCtitHDF2IoV9lJs0oC0ACx13Nv10AZYJURxzNDmjVz86eeWrDsHuurX0Ozva9b5SHsX1A3mAen8iXOQI64Db4simoj306IEWGx4kF5tW5AjHB8VyWP0wEvNotCU6+yeDVTrRm5ARu5SEH0sqDJ8UaWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YO/+vIRS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qUUB0IY5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PE0Zlt008535;
	Wed, 25 Sep 2024 14:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=EWURY6DXmSNClP8
	ZE7sWIOMOZNvKktdfgvrJAX2mX9k=; b=YO/+vIRS/TvGD2gMZie9ILn+L+uruPp
	eDETKjvAYYhNHfahkNJ35FYLomjAF02PNaEz47SpJIuhWBM3QbJQuKAXAt5XoI1s
	uS7A8ELlMieaA90yo1oDTkwGKV4hoHyiT7PUa5Sno82ud/fZLsAaMdN/8dkcg9LK
	CQVlh0E6CRig0Nx3bRYew+E2tT8Y7wmU2ax2/RS2c61kmI6R+3GDt2rr8Xy/RNTd
	tkWmVbff1pJN5tBLE2KLXrpcRu26qO6l3PR/zyAlI/prbXkQeTXzoncrrPam3M3y
	x9OUgZiROSKEE8qP13phfL5RsMD5WK0wMh9YJgzuKVrKl3qvPBD8n8w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppuaf68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 14:21:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48PDuTJu025309;
	Wed, 25 Sep 2024 14:21:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkas36w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 14:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3w6931B7AOV3JnpnX6oZqKyG6ANMBWY/8MTFt7s2z3DYLsoXDtPx3csGfOxh6H8jniv+zkTHKdvUSXjXevnHskmg5WHdFcHQtbQYISNsGZZEH1vqPS1TdSVRlXuRqtYXd1im+p5fXOyldV0iynWmwVnlQTVogECJ1NgH2FeuZRlY/K25PXOYWu0E0Bx+8g5adM3FMHNP7KdunXyqIx9GSRU4SaBVW09DooRCaur6+1two0hqttlF0ITEbtQkAdgVgDvgwWIyDIrxqzP8EGRO/uYLVwDL/R+ahQW53nGuY7JCnEYrSQBZaEzWdkaCqId9QzHv5Eum0cVu76j0YFCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWURY6DXmSNClP8ZE7sWIOMOZNvKktdfgvrJAX2mX9k=;
 b=JxPUKFyRSqLaShA+PTNc46UM/7JA+Ec+YaOgkUYvvnj5qTCiVuQnAMNwENVxUmNET8x6TzyiH3IeLS4+Zj1ca8RF8KTJ5hOnc16O+d6AXXj7LNx4xYGWZDBSXh7v07QnZqDqAjhILov29fylP11GQcdPOl8Wfh12ZBsw0641zUoQHisuoDw8mAssGXyhH3Smn0aCNLNM98pyP1VGyk4/4aNbCiXLejj2z6/LIv2e3vRiw2Mg3N7Z4R4ZQSFppeXxxREoGSfzSVTnuLbpLTY3vPocftIw9MKcbr7fhtNeTMmC4KCdYz0O/DkyyMc7S2Nt+jMhFuFF2DXZvfBwARYpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWURY6DXmSNClP8ZE7sWIOMOZNvKktdfgvrJAX2mX9k=;
 b=qUUB0IY5XCl4DH32LAZaaY4o+xUidJwn73VAXJ3E2HatT24JA7gNWCTJaVsoXs539aydbM7cdhF/WG8zR3zPbK9d1to/OQTJ87ltsqJDlUarzHHliSOcrDPG4Sh8cXQ6h8JYFmbfyPW5T8smdBYIfR6OUKyxAbj+ojpp1MP8eL0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4872.namprd10.prod.outlook.com (2603:10b6:408:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 14:21:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 14:21:29 +0000
Date: Wed, 25 Sep 2024 10:21:26 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>, Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs@vger.kernel.org, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>
Subject: Re: [PATCH] sunrpc: fix prog selection loop in svc_process_common
Message-ID: <ZvQcZge2KfnfvQwC@tissot.1015granger.net>
References: <172724928945.17050.3126216882032780036@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172724928945.17050.3126216882032780036@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:610:4e::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: d1eed563-ed4f-4ad5-dc13-08dcdd6d58b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZSZIecLT0MdiQsL5vqjrFv4XvtXQzIk4gcS8yL+rF3KV+9RkagA82ooyMFHl?=
 =?us-ascii?Q?T5Np7Te1eziAF+pJdPL7ZdR4aKHzrOuxYg3o3b/3j0Ui5D0yCOVwn+wCyTcF?=
 =?us-ascii?Q?yvmqbCQ4PrvgIF02BQX9C5hwt/RGYRRMY46yqFabOs7fp4MzU9Lbx+56Ebkv?=
 =?us-ascii?Q?cQp0FwdwvoRPC5hijOdiE3kxd9OSWS+idCDl+wWMxJ7IKwlRv41l7drGy1wq?=
 =?us-ascii?Q?GYy0lav7+9EjZ44IPKbc3D/f8yYXGIQUAUq+kncYO13gxIRa1fOfwtROxAwg?=
 =?us-ascii?Q?iB39sjQ7OGBFkrQY1fHeNLKvdez1gjTUOkhXv8K7XaYXeHPVUYVP1cBD/JZP?=
 =?us-ascii?Q?8ddRa73lW3Djxm1eSlQ2j7BCzfUGsskAcLcdWlmMB48SNm8e64EbsevPUQ+z?=
 =?us-ascii?Q?JvUiQq7OqRljTaWbqkTtfa0k2uQEOjH6lUw65QZ5a1A8GVyeyn8PRapUrcr2?=
 =?us-ascii?Q?WMAy35vQLjdMI524dPTkMluWNeL+IPxX4WHgO7iJFdIKltdtx8V6onyb2uXE?=
 =?us-ascii?Q?1Covkjm/xwRAaDKRiWCpipMiG7vI+5JhXTpZ+w13dYppW/eT5N8Xr3K1nvUR?=
 =?us-ascii?Q?0uvooYf9k00MlWWgvI5wFNIBMY/wm1AvSTY0AgzInHosAxq5pDXUJofnbBoK?=
 =?us-ascii?Q?GNkK+rXEH1m7yp+lxm5BTFc7zzetu+8swC5F8QBQkZHtLkCniBF7uYaz6OSW?=
 =?us-ascii?Q?thRNFf5GIr9uNEN+49YQE1jdlH1BP969jIXdBs18RxugEaAT0hpNMR91vU65?=
 =?us-ascii?Q?3r3kLkzcJ8irEX9fdCUXB03iikdcOKcfcRkS5br21lLL7fabTZHbaQYcx55E?=
 =?us-ascii?Q?8d0oSrPaBi6Pmm5nzORYmIDiHXJX/D9bFsCcbAZrH+JAgjK5s73MTV54jUDK?=
 =?us-ascii?Q?4NQEvtdKdd9+f42vdAtwLnSINgsO3lZCMZuwVYiL2dJMSm3mOEtYhqezEY0C?=
 =?us-ascii?Q?34tcC8kVENgJybYt5/wM6DDv/+ldghg+TI68s+Ks/0Qd0OsTy+WfAIYjHNk1?=
 =?us-ascii?Q?HS3jw2nKWCf+6OD4HcGgE3Is5nJNYlSbdDR+wcCR1Ki/r1gndRQ9zMr9KIcv?=
 =?us-ascii?Q?8RJFZiiMBbsXKyWs1OvNkuneVipsusyIrjMH279QGZkr9w6IWT+1idbESBNe?=
 =?us-ascii?Q?7dbi6M3IK1iHeCUeYIb2+IbKUuY7tX770/1AOseW59DX57JAuoKgzsn2wayB?=
 =?us-ascii?Q?QM+ExFVxGpSrAKZ+4rH/uuRM62TJ8ln549NjEEo536GZX448gAkWFs0VlIdm?=
 =?us-ascii?Q?b+1i7tYx8XdZDcNV96y8XnaZm/6FpbADs3CghrHyRGyxyq+ZkMfNDY2zMWYg?=
 =?us-ascii?Q?jg9DC7qqLZTiOyKZ2idEwXutHPkEESgkJtQbWyUZgYRF7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pcaptdnKwW/lzXEc/FoDn4HDUx2OTWAiE3t0gyfmniZvyCpz3imp2Fn3Ng4s?=
 =?us-ascii?Q?Yg6MsQ2ediBkjzsc9IcTnwncuSf/tfFsMsIa7TC+IizJvpTDhM10HJN6aNXW?=
 =?us-ascii?Q?O3WAEys9wosthziAgQctkUPeyH722GDadD5Mk+RpBGSNnfV2iUTTAMMP6GUx?=
 =?us-ascii?Q?wfNoJmh4HWjd5szj4qSrAKXrmnMTEq45DwXmqzfmbUM/UWPYQOnw5h6qj/Y2?=
 =?us-ascii?Q?bPeUotLY8cu0bJXufvpcYy51ouhZ7psdCC/BEXRHvPkRU5L/NT+bCU3ukRcb?=
 =?us-ascii?Q?IBPXPM+I8ej4czK0HmToypjUMV7zO21Ckvom/nqGIvDYheF9eQynYFWV0+Lv?=
 =?us-ascii?Q?rPCIxdYyPr3FkWq74WmPuLO7Bv0sRVQj6fduIvBTJqsxm8LIsJY+90iDD9Pa?=
 =?us-ascii?Q?0AlStQYLh9Fq/Y8X03LgUxUiS2V/8whfN8cV3IXgRGTHUTKDr+Kzh8IwfiNj?=
 =?us-ascii?Q?Y5LQbXCJd2uauOIis+SfwQiwdzj+1Q7dF4I1vu/AdD/VmI3uUyt84bfSUUDP?=
 =?us-ascii?Q?FqzeEHI00bLLYPZa75MQuhXEV5BgtOTs+vjn+KtVkrjAU6JNg40RaO4ehjvL?=
 =?us-ascii?Q?nKCrEzBpJDDCckO7kBDKYRIby94qoaGdRe/7BjVJHSSuyiFY0voutl7ZD3vE?=
 =?us-ascii?Q?tNN4IYFYuL8kd/w3A7GyImxb+ht6lGUK9a1GpBkrFwHwzv8uypWwJDmttfcq?=
 =?us-ascii?Q?Vc3nwgvklVaAIIOtAswrq1aKS5TP93acSxhXspa2CMs5ZugNavO5Xy++PaAx?=
 =?us-ascii?Q?xaYv5IrF17QD5n/bbCGvjtBtJOCvwGP7QlNsciZxQCkW9vU4RLaBJJatk1vM?=
 =?us-ascii?Q?BkQWGk+oAl4rP09KnuQ8GHvTlF4xeYEdK72F3uzMoraaSPwfHk+InhwSrF15?=
 =?us-ascii?Q?jLTRbRNmg+P5RoPi2g2a5m/VoMbABgkX3uYow72gs0Rq5xa6reXaLnl2sCJ7?=
 =?us-ascii?Q?1VSK5cW0Ke9X8d+9WXh+rNPwzHj5gtg8+NiqIuUv4aL48aW0m0nDr9V2zrU/?=
 =?us-ascii?Q?88tWE9kKl0uHe0w486mIA7wNYCmazpImphavSV2Q7B8DqhimPO2O4kAkFVYD?=
 =?us-ascii?Q?MHqcXzqTpk1qW53a2w+1EjFyZJVg7EmBvR04pedqpBS7/Q/IKMljeVejUmFg?=
 =?us-ascii?Q?WzB66moJ2xtBobLg7Tc35xlFu8aQ1WaALtHKH2iKdhvUliESnT3EWx9Ty8pI?=
 =?us-ascii?Q?iTD46XXQv9YSpdsLLdh8TyAGjkzhGrIydum0ksuWoIyl0Whp4KfzwkDJ8b1O?=
 =?us-ascii?Q?MG23bHxtaAq/NptZlS5g71qdenxYpXrvEFUG7F1c7iOrsetp6UrcTZHvW0W6?=
 =?us-ascii?Q?jsbGNEEcKAf67dDGxgXDsG2u8JBPu2RulrN6pclX1YbPwOg4Zg9QoDB2X4Os?=
 =?us-ascii?Q?fTtDjFfOqAY+CfmeYOIKAAYB1asQaJCdbwLHMB6j1F+5uf53ovAaKoQY3Th+?=
 =?us-ascii?Q?wVkoC1bS9x1JzN8qi5NW4Jj8+590haF7eo5A4u69fybixWfWZU+cX2p9vVm3?=
 =?us-ascii?Q?KYb+LJGeD34MP6CQQok8tmpViMFQEjxklvIv/grEp0pr1vk/a7bd3KVQ/KD9?=
 =?us-ascii?Q?e++1RCwX00TyzTKoCyLclbQ82mfzLuwbT587yPnW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1BP84cmZho0kq4+TEcDTMsHCim5qtZMP8uFz4cm5S9RGXdDoOHtpvOt0Hn7eHIR8fNfvfGigiV8uLZWyDfqcz3VfzG+zk1DYvvD6UylQBtRQPKFk7gaVBdl7w9iQC0W1qVHyN1S84Vgf7u4AWd6LWrKj4lPtRtyiLU11E3i37/ytJ4biyK/AhP3HJ60Cw1njfs/87MjNOMDBo7UYFA/BSHeXm61G1zskmYAxaIvaHeQ14YkvLGrunmcpnHmjPRYK5P2PfS5EZanDIr5j23hO7yDBnkihPPE+tS5Opk68Witu7wiFFh3gwQ5Rr0XllLWJwjuHm3JBAscFN6zxfh+jN89f5+R+zpaCQXt+IvDmFSjE9C3X6L0UAwPqOFMyCfU8kOhXgGhOB7rs475vEB4pkWfNJeuumRDrBBayJd+9yLdaq4WnlnPrnsNznfHEMcVcOO/JaJwZGxFQydcR/dX2BT+oK1Dt4AOTIrB3kLeP8TfjefN+1Qn1Hp6fSg0zkLkfryQnm60NCQT1GH9+YP8kduDOrzVfu3NW5nKBJ+uS2ovNJUgIxwKdgMOnY1dCTgeTsRKtxUxCWaC9DQ1QWPHc5x+vxBb4tqlRor/KSGNGD+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1eed563-ed4f-4ad5-dc13-08dcdd6d58b3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 14:21:29.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkMpevBl9+hHcb7x937OOz0DJeatocNtnX15dsht/BH0rkMtml714XP7LCH/7daATNtpHyj6oJsdMqKVFv5ZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_04,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250101
X-Proofpoint-GUID: VQRPWJFppcCamkYYzWNksyStAeoZ6C5n
X-Proofpoint-ORIG-GUID: VQRPWJFppcCamkYYzWNksyStAeoZ6C5n

Hi Neil -

On Wed, Sep 25, 2024 at 05:28:09PM +1000, NeilBrown wrote:
> 
> If the rq_prog is not in the list of programs, then we use the last
> program in the list and subsequent tests on 'progp' being NULL are
> useless.

That's the logic error, but what is the observed unexpected
behavior?


> We should only assign progp when we find the right program, and we
> should initialize it to NULL
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 86ab08beb3f0 ("SUNRPC: replace program list with program array")
> Signed-off-by: NeilBrown <neilb@suse.de>

IIRC commit 86ab08beb3f0 went through Anna's tree during this merge
window. It would be easier (for me) if Anna took this one.

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  net/sunrpc/svc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 7e7f4e0390c7..79879b7d39cb 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1321,7 +1321,7 @@ static int
>  svc_process_common(struct svc_rqst *rqstp)
>  {
>  	struct xdr_stream	*xdr = &rqstp->rq_res_stream;
> -	struct svc_program	*progp;
> +	struct svc_program	*progp = NULL;
>  	const struct svc_procedure *procp = NULL;
>  	struct svc_serv		*serv = rqstp->rq_server;
>  	struct svc_process_info process;
> @@ -1351,12 +1351,9 @@ svc_process_common(struct svc_rqst *rqstp)
>  	rqstp->rq_vers = be32_to_cpup(p++);
>  	rqstp->rq_proc = be32_to_cpup(p);
>  
> -	for (pr = 0; pr < serv->sv_nprogs; pr++) {
> -		progp = &serv->sv_programs[pr];
> -
> -		if (rqstp->rq_prog == progp->pg_prog)
> -			break;
> -	}
> +	for (pr = 0; pr < serv->sv_nprogs; pr++)
> +		if (rqstp->rq_prog == serv->sv_programs[pr].pg_prog)
> +			progp = &serv->sv_programs[pr];
>  
>  	/*
>  	 * Decode auth data, and add verifier to reply buffer.
> -- 
> 2.46.0
> 

-- 
Chuck Lever

