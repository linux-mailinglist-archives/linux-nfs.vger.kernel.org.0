Return-Path: <linux-nfs+bounces-7222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D073E9A23C1
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9112C288FEB
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B41DDC17;
	Thu, 17 Oct 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XywO/Q6Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ls/hlATK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2101DE2DC;
	Thu, 17 Oct 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171469; cv=fail; b=BSkDu1zxT5owhnaVtWeTPa1z0uGmINtXi7pypsP593Z3L5ln9Z4b2WSHAwh13GEwS0mQS5/tokp9C6TfWdzCA3DxrAunftAMR0iV7HBFvkb6OwIu/J1/CDVmdzokE220HD4vKHmQm6PnssPu0ON0cfNYA7RLePSWsuu5SL4i0vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171469; c=relaxed/simple;
	bh=SBjhcL9zAEqBpbCy1GUMIke5NMa9v7xvIsFfgV6gCwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=twfgn+gDxc7CJ2LUxkVDRJx/o9T/ubojcXk+g1ps/N+DOxVayNkD0lkKK/ovSdOf/THjJ1Y9EJWvUOIaieFKhEeeuI/JfpNizWxMJhGEdKYi+shqgUcvufNU86eUptdqVu6hK/GADAZVhjeFHTE+Ru84e1HQW2G4Uxt5htIqsCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XywO/Q6Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ls/hlATK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9Mded032077;
	Thu, 17 Oct 2024 13:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ATb/piD6YJIs8usH8o
	EC7MHq6BYiLImyEm3nszMzY+E=; b=XywO/Q6YfD5yD/Iu7Xq/BOTJLDWJKKWshB
	tjx+00ZsXpVUcDa4rpL9pNryiy8uiJ/g6OyBdPz+dAnDXKuptnDRqfGz17hjcqXh
	P2sRT6yNkLLlvh2w4INLcMlXfzx6UkWYhv/CMa4gkkX4SycjY/hCgPVu+Y+U8ZS6
	Us9OJNcwNgQ0vQ5I+Ca+joM90hHG7icOHJbJEB6yxgtrflqwfuZXPpbgDnjzGAV4
	GKT40Dp13gqO57qV52TtaExtKCXrb4TJFSbDnGuWNgkUs0xfNHcRiAHpC+4xX5x0
	CMVlYncUZKkt5MqV1+gdFJOUHgJV64bdUhIVVouBL4O2UPd3P6Dw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcnwb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 13:24:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HC242f019863;
	Thu, 17 Oct 2024 13:24:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fja7gy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 13:24:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9J6x1KT6gBkSuSNdd6YYFq+sCDfDNURuLHZ+6rzjvZy+T/PdS408tzC8DaO6GWC7iEJSQuOPUZQQnmLL4YXSP7luHOpUe1ykTSM6jzpjFLWTSCwdyTC9oJuOwY8ugm5arLSvtCHmgG/4Mtp1jGn3BrmkcA4U5m0dsYhGIxYsMskVnOPXm8/4y37vBust0uuVld3k4wAqI1v+AFtycSPbqQ+QesobAA/ujBTjc6AxMynoO5pnSgettUM6/Rz/+Pg1O/jwwPv24QmTXdCqjTDhOWbNkovvTyT6xZPfGagcCma8WJ87sptJrSbSqFRCEWDRgC/UwpZBL68syheuty7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATb/piD6YJIs8usH8oEC7MHq6BYiLImyEm3nszMzY+E=;
 b=rcQOLbgu62Q4PBxhqC2LFoT5Ik8dz37SY4zPB3ohOn5DNK063VxvHNq8E6udOhoEXrp5PY0EaXgcnIMAVWZt3pH5ClHlkv+KfvDh7vxml6neKsyvTMT9EtDJGvj4nOw/9C20BISEZ7bBYzQIZjs5Wd5O1247TKrQs7BzICmX/jhhg4bKydvutuxAnFBXm5Vzg0YIkPPkXEuNxERysL3pot5lYfnV6gR0m+EsCkB+mdLTRklGuBxJQMDWa9IsDDsiCi1hjM6EjebfVc7NmWnWVLOV0GMCiX6aiq5hxafXr+k0TIHmaeBbt4p0oyuwE2WITdKxeMKwdyBQ7MTqs8/i9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATb/piD6YJIs8usH8oEC7MHq6BYiLImyEm3nszMzY+E=;
 b=Ls/hlATKxlGzKK6WvpApfvjb0GtEXW9d2JvESxFCeYWYYjqsmG0uD8PyS8tsb8oaFpj2/R5Wf7Slst+E1Mj9vJAzqx2+IIsy4RZ6R+0lQdUGNwhMmO/YSSyEGrCqCyq4bg1PizqKteuGq2iEChNzKtINxVLPSk3y5Z53CqPhajk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6712.namprd10.prod.outlook.com (2603:10b6:208:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 13:24:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 13:24:18 +0000
Date: Thu, 17 Oct 2024 09:24:15 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Kinglong Mee <kinglongmee@gmail.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] SUNRPC: support resvport and reuseport for
 rpcrdma
Message-ID: <ZxEP/zBCaSgxbJU7@tissot.1015granger.net>
References: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
 <Zw/GUeIymfw+2upD@tissot.1015granger.net>
 <a4dc7417-1d0c-4700-9102-0ecc2c9e81ab@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4dc7417-1d0c-4700-9102-0ecc2c9e81ab@gmail.com>
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e1c5c7-a2ad-497d-a6cb-08dceeaf010f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XjKxRG1ikGHO4TZex7D6NSqfe03/z+6QI/pN3+cXGklDvEUHD7zZhkYlEdMu?=
 =?us-ascii?Q?Gdsh0tBuvCac51x1gDlaXVyTLqpTOxFkvPUpQMqMLAYxSynXGAAFrKBkizrj?=
 =?us-ascii?Q?CUaptHwh7HlzTqaCkEfArFXqRKQmBC5vJD5aGyWY43n6wGGN7rq6Ri/Yy2Jc?=
 =?us-ascii?Q?zAjBOlAEQgtTVa2WguWPw7v439IIOVQXd35QCLjq5afuy0pKzGPNR0czgOcN?=
 =?us-ascii?Q?i4bkPM5WXAGLK3oC93ISZ3G6adKMq7Suz1rtLbshiYnPSdrYZDOzPV3IrQfc?=
 =?us-ascii?Q?sjGiLvxQmLrlrb0enqaw5xQjvFPHc0mOGVLSoC+d/ZTX+W9A17Vk2mwBHnCI?=
 =?us-ascii?Q?xNchg98Skcj4OHtSqaJBt78mboH9eKO3hxUBoTRZjx4n1ODO1ufXBfLMQIvz?=
 =?us-ascii?Q?nf97T0kAdAWzAAEN/j3cer9cRfgX7euOm2raZjJ/UPzcK3htzGQRCxcq8+FC?=
 =?us-ascii?Q?lwG2SXHnhl0F/Hgu0cIfPWHcFN5iQH5jmRqLHX8YNACQoAq5221hG0uF5BOm?=
 =?us-ascii?Q?eI1FLowdz31LGOtGtllNNlm1tE5GLi51tx6RJDL6LmsGzjv/TzO10pgKRR0Q?=
 =?us-ascii?Q?fHwNdPVQjhaccWxkRKptSAwPl3DtTVQCPH2B5qyryZnZZNFdQF40q/OkVbCG?=
 =?us-ascii?Q?I2HMHeqR46ZQ1Vm35DaY59AZNi9qg9Gs3MYfn9LdQ6XMhtDT3i1JiWj02hHy?=
 =?us-ascii?Q?ZluxcQM0Ff7VAAcgjzFg36meG4DlzDr8w3EESjgyohJrt3qnP3kMVnpFgCcm?=
 =?us-ascii?Q?hKR6VW78/DHBXLr/yP04bObZ4NQt5PMiSND/dnVT2+jYWpT1v96xmS0EFdcD?=
 =?us-ascii?Q?LUy/7UDtNU2doDAzGPeG+L6EbBEBBAcjfnISMOnw3iMiONo7PJmV89o1sILs?=
 =?us-ascii?Q?VCY0Lp15fKNYNAK+LyI996qgL75Qv1IC26nQ4TQypLhCXvTG4q3HgzzYv66f?=
 =?us-ascii?Q?Lj8qi6nIW+XYZa4FpXztwfNs4b/MYDjLLrNI7ZTi3sWTDALvPdEzsRVvtewj?=
 =?us-ascii?Q?dKlzXqFmcAnVmjfhpHRYKh8S7pd0Sjsj9KOKHqMX0NvmmWexBlaJkBx+5iCR?=
 =?us-ascii?Q?xloxwP000EButMYTpnmBThxR7CxWGjE24WN865lMs3+3hxc/iO8N+0uZu7kX?=
 =?us-ascii?Q?3T/2p2TyOXAPautjA6IBKGbPRXx0WS3kOlYqcIQy7/xrtS9FAcWi82eTfHM3?=
 =?us-ascii?Q?KN5wmAbhrHMNw/uSTO2IjKFvefK6yYCepCn2WMF3LC8rR34imnfFW/lDXvb5?=
 =?us-ascii?Q?DZ5jRfZoMthnnni9SjN6qHtDhHPsUj1rCbKhIGik0cYT83QmWUh5n78KY9bn?=
 =?us-ascii?Q?qOzRUzX3CqX6TyMx6tAcQ0LV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gA9X3SgMgLN4ewzZhvGvlSN3d24JV72+MMM5I9f/vWRGZ43KxcXHssP5QLrz?=
 =?us-ascii?Q?Qa/YH3MfsA8+lQURVcKZxw25YjFlJI8Wwx3831u2PePsa8iJ6P3fyKGLw1Jt?=
 =?us-ascii?Q?BQjOihD97DmyiXaru1zynKpkzrO17jnwuHGKccrh5KfQx1CS9JqdnRroCRv2?=
 =?us-ascii?Q?Xrf7XP4HhhtZYOX9JWO3A84xMz29Sppe09TbX7Tw3et0/UngwneFooFzDUJt?=
 =?us-ascii?Q?rppvOSkCAkQ9+AQLc0pV5vMow90zuuURwmNdZlbponNSCq2Zcwpv2S6HJNeR?=
 =?us-ascii?Q?8e9/pu8k9IraEp4z/dMOy+1m/z+7qwrV/ZESiuJfVJpo+LVSkmgd+KJs46Q4?=
 =?us-ascii?Q?ks7RfWcYdcxWCOm8RPwS7FmNukWgUxgA1HOGTIdV0hRoIoyuQfnwRjY3E/6a?=
 =?us-ascii?Q?STH1OQzghhXvnveoK7zGfsA5L+cpx3uq7G6jpyMWiA3jTiiZ8hAnvU+5TU6d?=
 =?us-ascii?Q?162BY0RvHFh6K8MP75C8Nhrf0dlU2m+2NMNEeYa3B8lOlky8qTWNRlPRDqFt?=
 =?us-ascii?Q?uAH5Pgaa3jPV0zZ/soPa0ZkQ5SyFbmiexbJCg6UkTYa/lp43ftn9yrFhKxHb?=
 =?us-ascii?Q?X8UkQH4zXywzELY+2OMgZyNXR3ITQr/t98vOB+EiWkno114Cfrc8oF8k/Omf?=
 =?us-ascii?Q?eML+q3gfLFNuKZb7lH7YRYJu0vnpSzawxgPSM5PZ1SMMJhPV83EByU2SIZlM?=
 =?us-ascii?Q?ZwbwqSoyPYZBqswT75+dw23Gqo+UYbs8X6ZW/jufsoghmxD6QykZ9WdPv/qy?=
 =?us-ascii?Q?fIFLhjy9SrVhSD/gqmDABFxNgpheUSOjgXJn5QI4TopXmgndfChMm485cV9B?=
 =?us-ascii?Q?n+suFhBbN/XhN37YhdDXbftwn/C3k3Ki0duk5zoCCl6j22PR0u3zXgwL58o8?=
 =?us-ascii?Q?UdosDgXCzeQ89EYLGsKpvJz8DZ8PTarIxF7aX2iaAFN7OW+OJLy48EejJ5qi?=
 =?us-ascii?Q?PHRcuqw/1gHKP1CVUCVLHzSN04QX0ZfvKGFXbG3Bl/GBkmwn0jXtc+pJ4yYx?=
 =?us-ascii?Q?20lep73XM3P3LSDc6oXCzM7I8ZJpCB6UsKY5yakZjkrVfgvBOpDkbaluMMFf?=
 =?us-ascii?Q?PrJ3FciV0GS4piOWyYtGL76o7KcN7WYNkCFuZEsMc+Dkn4a34NAMWEH4M2Rf?=
 =?us-ascii?Q?6v7c2DHb8s9EMTKrelrxy6+lGc23vcdQ/WblbLjiDG8//bYfdbHPSHiV0Tra?=
 =?us-ascii?Q?87NNq6BNjyZmiXh8PTDS4NdW8JgZLAuoqzs/zsqhhsXIMZAD4sBsuA2b0n3Z?=
 =?us-ascii?Q?31pNEfuAwJ/D5hsdTGhx+WCkbtcnUgFVvJuu2341TU0hY8HafMRX2fqWvk0X?=
 =?us-ascii?Q?A4phHoVfCeCuECyrJpA1KPTT5Z1aBS4/QORaBLh00C9bvBjlI/JQWhr3AI4i?=
 =?us-ascii?Q?cQmRDre+vESD8TopZ0cR6iaZW+8LxlaO9WBtMrilLYbWpi75fq7XLV4uSdkn?=
 =?us-ascii?Q?NRrxTu0sYB01LqnlfbPdWva1b8mHEKdXiUSigPZLiqZlUEDlaKDOJaekYyH7?=
 =?us-ascii?Q?rkntBTISESHB8aIraVT4VV5NaD8wxCrcYju4MWCenjJWoXqRxyHMJZrdGjjq?=
 =?us-ascii?Q?qnnRjmc/kYcxguwunnb2a6lQ4IWZF1vuw2Mrc8u9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5xOTwdb5w8NOsKBljHIxOpaS6pxWD0+IgE3Oth+JjonMkRWUBmPhhsPXlxXLjSg8SWUdktT7JkxEs2v78or3RQgRShyA2/wuwHUgIFyqcxGTTVmW5k84xLmsaj0DxEfgCnDjhqonF1bnIqdH0e5M17qGlKacTmdo8hkMizFGI5wdu409tJKgK2/knPRUhTWQ7q4TToTadh2BFF4CAeZPOKWv6nTw/NUFgz7YD2ihdPQgspK+mnLJIXlGhiFz0rhVWO0bOrNycZ9hQ9YQZZ4T+QfclVul5tGaTh7f0RZb73RNYGIInZITjzfMUGusfvYMdoM9n8uke7vt5EPC1Sc8spBi6VNeBNdiAv+Qq+u8C3AtFNsrj2J1K5wf9j8OavmVvOOAUg5luQIGIIB0XJCdTvnYHXBPdqTnTQ5Pu+lcp+ZpQz/hfGHxxRzmJOxWo43UoqJBFGK4QxxSMDzpJYz+8I4XMXtzcFT8IgBvG7QquscWJVT4wSgdOm/L7IVpO6xLl+/irOFlP6EMAvEsxLvchdqgvArVMWUXqBDzmoFuYDXyXycopN0ZAQ35ZLCxe8ayRxxBfgd4/k1QNGtH2xkbWDNAFtPvF3fe42E1rR/vS28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e1c5c7-a2ad-497d-a6cb-08dceeaf010f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:24:18.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6qbmm2FMyNbR4XKSuwiuRF2rw3Lwgi0ThuLHFJXN8F9lhMpcClfot7PwF8R8fwuwBvIbdzjwuJDykFnjrc4sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170091
X-Proofpoint-GUID: IVt9ySVKXAd6gNctyY4FquoKvysn2aAT
X-Proofpoint-ORIG-GUID: IVt9ySVKXAd6gNctyY4FquoKvysn2aAT

On Thu, Oct 17, 2024 at 10:52:19AM +0800, Kinglong Mee wrote:
> Hi Chuck,
> 
> On 2024/10/16 9:57 PM, Chuck Lever wrote:
> > On Wed, Oct 16, 2024 at 07:48:25PM +0800, Kinglong Mee wrote:
> >> NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
> >> This patch supports resvport and resueport as tcp/udp for rpcrdma.
> > 
> > An RDMA consumer is not in control of the "source port" in an RDMA
> > connection, thus the port number is meaningless. This is why the
> > Linux NFS client does not already support setting the source port on
> > RDMA mounts, and why NFSD sets the source port value to zero on
> > incoming connections; the DRC then always sees a zero port value in
> > its lookup key tuple.
> > 
> > See net/sunrpc/xprtrdma/svc_rdma_transport.c :: handle_connect_req() :
> > 
> > 259         /* The remote port is arbitrary and not under the control of the
> > 260          * client ULP. Set it to a fixed value so that the DRC continues
> > 261          * to be effective after a reconnect.
> > 262          */
> > 263         rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
> > 
> > 
> > As a general comment, your patch descriptions need to explain /why/
> > each change is being made. For example, the initial patches in this
> > series, although they properly split the changes into clean easily
> > digestible hunks, are somewhat baffling until the reader gets to
> > this one. This patch jumps right to announcing a solution.
> 
> Thanks for your comment.
> 
> > 
> > There's no cover letter tying these changes together with a problem
> > statement. What problematic behavior did you see that motivated this
> > approach?
> 
> We have a private nfs server, it's DRC checks the src port, but rpcrdma doesnot
> support resueport now, so we try to add it as tcp/udp.

Thank you for clarifying!

It's common for a DRC to key on the source port. Unfortunately,
IIRC, the Linux RDMA Connection Manager does not provide an API for
an RDMA consumer (such as the Linux NFS client) to set an arbitrary
source port value on the active side. rdma_bind_addr() works on the
listen side only.

But perhaps my recollection is stale.


> Maybe someone needs the src port at rpcrdma connect, I made those patches. 
> 
> For the knfsd and nfs client, I don't meet any problem.
> 
> Thanks,
> Kinglong Mee
> > 
> > 
> >> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> >> ---
> >>  net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
> >>  net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
> >>  net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
> >>  3 files changed, 141 insertions(+)
> >>
> >> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
> >> index 9a8ce5df83ca..fee3b562932b 100644
> >> --- a/net/sunrpc/xprtrdma/transport.c
> >> +++ b/net/sunrpc/xprtrdma/transport.c
> >> @@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
> >>  unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
> >>  int xprt_rdma_pad_optimize;
> >>  static struct xprt_class xprt_rdma;
> >> +static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
> >> +static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
> >> +unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
> >> +unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
> >>  
> >>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> >>  
> >> @@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
> >>  		.mode		= 0644,
> >>  		.proc_handler	= proc_dointvec,
> >>  	},
> >> +	{
> >> +		.procname	= "rdma_min_resvport",
> >> +		.data		= &xprt_rdma_min_resvport,
> >> +		.maxlen		= sizeof(unsigned int),
> >> +		.mode		= 0644,
> >> +		.proc_handler	= proc_dointvec_minmax,
> >> +		.extra1		= &xprt_rdma_min_resvport_limit,
> >> +		.extra2		= &xprt_rdma_max_resvport_limit
> >> +	},
> >> +	{
> >> +		.procname	= "rdma_max_resvport",
> >> +		.data		= &xprt_rdma_max_resvport,
> >> +		.maxlen		= sizeof(unsigned int),
> >> +		.mode		= 0644,
> >> +		.proc_handler	= proc_dointvec_minmax,
> >> +		.extra1		= &xprt_rdma_min_resvport_limit,
> >> +		.extra2		= &xprt_rdma_max_resvport_limit
> >> +	},
> >>  };
> >>  
> >>  #endif
> >> @@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
> >>  	xprt_rdma_format_addresses(xprt, sap);
> >>  
> >>  	new_xprt = rpcx_to_rdmax(xprt);
> >> +
> >> +	if (args->srcaddr)
> >> +		memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
> >> +	else {
> >> +		rc = rpc_init_anyaddr(args->dstaddr->sa_family,
> >> +					(struct sockaddr *)&new_xprt->rx_srcaddr);
> >> +		if (rc != 0) {
> >> +			xprt_rdma_free_addresses(xprt);
> >> +			xprt_free(xprt);
> >> +			module_put(THIS_MODULE);
> >> +			return ERR_PTR(rc);
> >> +		}
> >> +	}
> >> +
> >>  	rc = rpcrdma_buffer_create(new_xprt);
> >>  	if (rc) {
> >>  		xprt_rdma_free_addresses(xprt);
> >> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> >> index 63262ef0c2e3..0ce5123d799b 100644
> >> --- a/net/sunrpc/xprtrdma/verbs.c
> >> +++ b/net/sunrpc/xprtrdma/verbs.c
> >> @@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
> >>  	xprt_force_disconnect(ep->re_xprt);
> >>  }
> >>  
> >> +static int rpcrdma_get_random_port(void)
> >> +{
> >> +	unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
> >> +	unsigned short range;
> >> +	unsigned short rand;
> >> +
> >> +	if (max < min)
> >> +		return -EADDRINUSE;
> >> +	range = max - min + 1;
> >> +	rand = get_random_u32_below(range);
> >> +	return rand + min;
> >> +}
> >> +
> >> +static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
> >> +{
> >> +        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
> >> +
> >> +	if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
> >> +		switch (sap->sa_family) {
> >> +		case AF_INET6:
> >> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
> >> +			break;
> >> +		case AF_INET:
> >> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
> >> +			break;
> >> +		}
> >> +	}
> >> +}
> >> +
> >> +static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
> >> +{
> >> +	int port = r_xprt->rx_srcport;
> >> +
> >> +	if (port == 0 && r_xprt->rx_xprt.resvport)
> >> +		port = rpcrdma_get_random_port();
> >> +	return port;
> >> +}
> >> +
> >> +static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
> >> +{
> >> +	if (r_xprt->rx_srcport != 0)
> >> +		r_xprt->rx_srcport = 0;
> >> +	if (!r_xprt->rx_xprt.resvport)
> >> +		return 0;
> >> +	if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
> >> +		return xprt_rdma_max_resvport;
> >> +	return --port;
> >> +}
> >> +
> >> +static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
> >> +{
> >> +	struct sockaddr_storage myaddr;
> >> +	int err, nloop = 0;
> >> +	int port = rpcrdma_get_srcport(r_xprt);
> >> +	unsigned short last;
> >> +
> >> +	/*
> >> +	 * If we are asking for any ephemeral port (i.e. port == 0 &&
> >> +	 * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
> >> +	 * port selection happen implicitly when the socket is used
> >> +	 * (for example at connect time).
> >> +	 *
> >> +	 * This ensures that we can continue to establish TCP
> >> +	 * connections even when all local ephemeral ports are already
> >> +	 * a part of some TCP connection.  This makes no difference
> >> +	 * for UDP sockets, but also doesn't harm them.
> >> +	 *
> >> +	 * If we're asking for any reserved port (i.e. port == 0 &&
> >> +	 * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
> >> +	 * ensure that port is non-zero and we will bind as needed.
> >> +	 */
> >> +	if (port <= 0)
> >> +		return port;
> >> +
> >> +	memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
> >> +	do {
> >> +		rpc_set_port((struct sockaddr *)&myaddr, port);
> >> +		err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
> >> +		if (err == 0) {
> >> +			if (r_xprt->rx_xprt.reuseport)
> >> +				r_xprt->rx_srcport = port;
> >> +			break;
> >> +		}
> >> +		last = port;
> >> +		port = rpcrdma_next_srcport(r_xprt, port);
> >> +		if (port > last)
> >> +			nloop++;
> >> +	} while (err == -EADDRINUSE && nloop != 2);
> >> +
> >> +	return err;
> >> +}
> >> +
> >>  static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
> >>  					    struct rpcrdma_ep *ep)
> >>  {
> >> @@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
> >>  	if (IS_ERR(id))
> >>  		return id;
> >>  
> >> +	rc = rpcrdma_bind(r_xprt, id);
> >> +	if (rc) {
> >> +		rc = -ENOTCONN;
> >> +		goto out;
> >> +	}
> >> +
> >>  	ep->re_async_rc = -ETIMEDOUT;
> >>  	rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
> >>  			       RDMA_RESOLVE_TIMEOUT);
> >> @@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
> >>  	if (rc)
> >>  		goto out;
> >>  
> >> +	rpcrdma_set_srcport(r_xprt, id);
> >> +
> >>  	return id;
> >>  
> >>  out:
> >> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> >> index 8147d2b41494..9c7bcb541267 100644
> >> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> >> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> >> @@ -433,6 +433,9 @@ struct rpcrdma_xprt {
> >>  	struct delayed_work	rx_connect_worker;
> >>  	struct rpc_timeout	rx_timeout;
> >>  	struct rpcrdma_stats	rx_stats;
> >> +
> >> +	struct sockaddr_storage	rx_srcaddr;
> >> +	unsigned short		rx_srcport;
> >>  };
> >>  
> >>  #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
> >> @@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
> >>   */
> >>  extern unsigned int xprt_rdma_max_inline_read;
> >>  extern unsigned int xprt_rdma_max_inline_write;
> >> +extern unsigned int xprt_rdma_min_resvport;
> >> +extern unsigned int xprt_rdma_max_resvport;
> >>  void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
> >>  void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
> >>  void xprt_rdma_close(struct rpc_xprt *xprt);
> >> -- 
> >> 2.47.0
> >>
> > 
> 

-- 
Chuck Lever

