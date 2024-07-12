Return-Path: <linux-nfs+bounces-4862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7E92FB7B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 15:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E232853A8
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD57C16DEC3;
	Fri, 12 Jul 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdPFmBVW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rwyN590N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1C15957E;
	Fri, 12 Jul 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791179; cv=fail; b=pzQTP9+kpR/0JhzOCDYfj+y6TCVR/q1uN1J/BwL/0RIGUlUfOx4KyT9rHvagaD6I73t3j6tCRje/EJcOQ7NtVfpv9sHWsQEzdvdoC1txYfkGdMBi4hoXvGhmlUmO/y5lCvd82kLwJGwIl6qxrYfBQ7GBcfB/c+T9qAU1U6JVajo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791179; c=relaxed/simple;
	bh=GPcvL+P9FZSDcvae5ROpKIKrGJQdnUsr7ewoI1FZMys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YVnzWW9o0sHFJfMArr31b8VYtF/3exm2QeKYvY1cTQZSNR0yuekD78aXuHqG/nt746RYaWVe6Nl5IjB7glV8fJYaiVEutO68n2DPRPx1afp+POr/cYvW8CEx/HxKgF1wkez75L10IVrkpX2wG+Cf1eeY2ZqngEaK5/wFLrdmEZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WdPFmBVW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rwyN590N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIL9c006321;
	Fri, 12 Jul 2024 13:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=oVdf7fMMnMonmQe
	C4nJQw0lnW1HEpvcxy4+4LyEhW+c=; b=WdPFmBVW6aTpZy6dnrtb9GF98fXMMei
	LVUWpP2v+o0bUdVdNthXpf2A2iRIHFv5VLEp1VBTfP0k+NgGgTQv4mLXrkXtNi+O
	6h6L2ZLsRRgtMANpTlEoBRvnfuTFFCk2mhOEmMCMDESbLH5FuqZNot01SuIgQjOj
	uciOsFPn+s5vXt/K3rQmAbdq0Z6oYC3j8YhEbDSPB43OQYC4roYWzmnpIhXzmXDi
	NcYPQYTM6v91OjL09ia8r7xYcZ0TNOIeRkgaWZriXI2IDzmDcYf6Nuf3yJJ4zaT3
	olgBlbYT5ln+neJE7fkKG+W67h32GomR+LDYeAXTsDV/Nnul7pm6rcg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcksy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:32:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CBXf56028815;
	Fri, 12 Jul 2024 13:32:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv6bpya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FftnOwmMxWN+ghA9XixTUsMLG755UQLZE+gNfjt9VsqWg/S3BQ+dD/58dtaYIJnjzHBZcFjRNqFfBSJbqjR2+L0OEzxZantvJWCpr90n9A6K2/+3/a2swbujZLbKmrz3/m1n+rfSuoZAsj5AnAqw/I2MSpti8+qXpss9BMoVb/cvoGu57UrhJBBLjxkzTAW6xesEyYE+IKR459OEAJ0xJQBr3SWl7g9c8lVWKlmj5s5WT0fX7xSdQHBWT8n24OT+z/xf8a5iwuW21rbPJrdj/OmSROrrZxjXN7KPv79xZGwHL66A8tcyNoGj8kId6qyme4FBzGtGtG6aLtoQ3+MC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVdf7fMMnMonmQeC4nJQw0lnW1HEpvcxy4+4LyEhW+c=;
 b=GITia1CVhdHcHltneb1cUSIcdkjkJj54lfQoFeYCnJihN70xfe5TnEfHDYbodOVFmdQfn2wmQogYJd5civFwzL0Iujet+9nDDV0+eCf/PdAFEJdBDZ+Q+KmlC0iM9HwIu7o8EFC47eZVdw05PkXotkBJpDIdSn/xI/cRZQKmDHhn9bzGZUoIjvCjvR2a4GOMB5vqT3507AryIerZIBS891aF/byKFcXwYxp191Eotbhj3fkW7Hj3SSoArWqgn4EGh8HHXg6fZsf5jPuHLjdwNPeFeBSIoHnmbq+D/yn/pQZd0TydEUDdfi1740v9jJZj1hdeIhYdKae5ggU4XCC2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVdf7fMMnMonmQeC4nJQw0lnW1HEpvcxy4+4LyEhW+c=;
 b=rwyN590NNL6Jyo0Dferu9FPYaPgTYwYCF6L/Er/PZXWBUf/7Rg9DuSbAYIJl4BNj4YvvNpk05Sx5P6fyqZvQfROjiCfCsgE6SlufMYvcz6HeZfGJEcWYyxK1F+9pou8XsPN3kOVaQVKUNWXqgdm+NOToPsUAhqKhYPZ1I2pCXa4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4727.namprd10.prod.outlook.com (2603:10b6:510:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 13:32:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.024; Fri, 12 Jul 2024
 13:32:39 +0000
Date: Fri, 12 Jul 2024 09:32:36 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Youzhong Yang <youzhong@gmail.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: remove unneeded EEXIST error check in
 nfsd_do_file_acquire
Message-ID: <ZpEwdJuoPFRE+sJ9@tissot.1015granger.net>
References: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org>
X-ClientProxiedBy: CH3P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f7b9a3-2c23-479f-3a03-08dca277199d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2g+x1it4xm7zqrD8eTokaR1rUsTVU2T/LfP5YGZtogUqpGim4SBzoXNc/j4x?=
 =?us-ascii?Q?mmiVV7/XMTC00tLeFRbTqnhGZGqX9/Bz3p9Uk05IFP7FbK8BuSdgRNvUNYnm?=
 =?us-ascii?Q?rHKd0iSE0gYlANOsAjI2du1naZ5oujql+T8Zj0yrigigylksooab+09wuO4D?=
 =?us-ascii?Q?CDJhzdlZQKDEyPyeMYxNfFZxc9WOwVzQqPFxH4HixBfjR5smGlbW49egKJsa?=
 =?us-ascii?Q?WbjmUk68Y5zV8yN01/AVHjjxpyXo1zBtpm3Zk0k1LpJzHKLnXWiP5hWlQcYV?=
 =?us-ascii?Q?/Ng9wghBCndzbl/aUSZkcPoESPkvSrgVowIRz4R6GKIL3GRG4yxX9L9GQ+2G?=
 =?us-ascii?Q?oBlEqKQtoiiK8o8cHdPGP9a8RNBrO0io1AcKn4b4nI5eE1GQjktudWQyKiz1?=
 =?us-ascii?Q?mMGFshBtR1x0tBDNs8hOPts2io6whbDgfcLLwZiUGnt+P06sPMvAFLZL4BwK?=
 =?us-ascii?Q?y/oBjhvee3iPieNduTKsPC5Ut8rSPUo1hFL1m43Jc2I8mdLRN/95N82F6sfw?=
 =?us-ascii?Q?8GewtcheB8b3akizsJ4+A7t5ctBLCw7MFmr4xQNkre30BLWquwA2B0VWZtyi?=
 =?us-ascii?Q?N0wqUufQSoV9OZK1r8Bw42ozEbKZnHJ8gGPuNHKj1r987GCPcDzbveFAVg52?=
 =?us-ascii?Q?nJqvaCazRdWItaRf6X0eJBPaoLIp+waPmqg+zJFUuRC81fIR2nPBHx4flQvZ?=
 =?us-ascii?Q?WKMOCtxaJtT61gW7f3RcP2miOAMKVx0Me73i8C/NxykVQvibz/C3tBs47g3P?=
 =?us-ascii?Q?NJDZ8d2SL8c1eHhGt0IZv6YZeZSUmqr1gl6eT2UGgB4pW3FoCDPswGWmbfnV?=
 =?us-ascii?Q?HeN4liS59uh540iDbqEKivs+mVozGkSE10iCPczA8eiXrRrMbOo9yWKGxqQW?=
 =?us-ascii?Q?UH9SrIIVulmC+I/p0zcAo2ZCKpENJ5Cc6B8GDqrd3NXpAvn4etFOLHOdKFFN?=
 =?us-ascii?Q?msmH7bYkZVDitMYNQd+r0mEL7pZSrtFpdvzXMwOcN7KcdaetaoQ+TVbXNUlg?=
 =?us-ascii?Q?7Y8hM1vz5fL5ltzypkuwJjxY1B6Foe/TeP0HW1cDZ4vrmGMbzxt8d0BT8dUU?=
 =?us-ascii?Q?d7hxtCaMz7zhY8lNA3PBamQV4NXh4jSJ98v6EmwPvHfHdV/ZFeXvT9YOuvp+?=
 =?us-ascii?Q?gNNLf1/J2KwkjFXyLQnLYQaQ4ACWP9w/dr3R0KoMeACZTwK4aPtCQDapzSzN?=
 =?us-ascii?Q?VrhPFkPmkTAKlwkbd3NeIUYvNDNtlwlnqirQbwqxL9r1W7g5gr2UGPCjR1ww?=
 =?us-ascii?Q?JJvJ2SXXR4mjxFJG5niF6BOLmaSjRi+NsOBW74cwx4q3+fCc5x8/7f9JENBF?=
 =?us-ascii?Q?Ub6/cx9l2bXLM3pFJTh/kj8mjg7jULngCVdEBJ31/D03TQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MZOt1EG3szi07NRFib5BZYxdVVT7fWZznFhq0JGCerF7H3nRv+/iCdh/HyMd?=
 =?us-ascii?Q?qUDPeIosojLcTanzuLU+9cJDNp/Kpqbi+eeLB1KwcsqYOfO1+8bTwmjD/aA0?=
 =?us-ascii?Q?M+ndlE0Cv/RTCG4kiF5/NY8TYCmw0bl1jX0nAzlj/1dMjg2O1BAdm3YGUR6g?=
 =?us-ascii?Q?aB8x4jfp5FNWPLIRyjxUJmEzAbJLsO6pfoLe3Me/DHg1NKfHte7eiz/xbpO4?=
 =?us-ascii?Q?YZWIITYh1VqE9CzFwGFP6RjUFB6ZaBjQhAiX5knahiCKg0CwmZPy1QO24TDd?=
 =?us-ascii?Q?JGUqeNOUytY49MYFqEYQ3sDYD+NF2otBdEvFVw/QfeBrckJOqSFkR0EFJm1l?=
 =?us-ascii?Q?eOI3T3jc1Y+aYakxawnAoYVV7ELDguzLwD3ARTzvHCOdua/Up5VAYmU6QGQB?=
 =?us-ascii?Q?usxOa7jOwDCI+bM1U8X+ZwzXoE/5XCAB8ISh//NYi99Buyl85AGFAJpnj+pM?=
 =?us-ascii?Q?03qBKuU/Z/vGoSmxpmbpCgYZN66rfpB2L7ka79R8u1Tc3qIrS+8Y5LUIBCgw?=
 =?us-ascii?Q?GeEdlj/cVQpxxVm46368KEJVVdXauYRv22Ja1WmXnUeDiqriHMPGhfCjD3r8?=
 =?us-ascii?Q?sUnCYIRL45T/guNS35jPrs5+KAT07k0h/Mnl9Y/gKDas2C9KdDblw1PsByMP?=
 =?us-ascii?Q?8Kr9VgtNZ0P/F9HjtAdRg0DxjBV2sMMNuPWyj0PlZxNmzCV3lB7IP2elkrOU?=
 =?us-ascii?Q?1fouOckdU/WSmCW7ev/Oqop6TvJ0xUuRPjurW5IM128ICv0CuREu+tHLK5jc?=
 =?us-ascii?Q?xxjqXw6DSBDhp6DLQz7HtBIq6GH8dAh1ekFOOt0Dzy8zf3jQNxr1DX+B1heM?=
 =?us-ascii?Q?5QyjTW+5KNdczyK94fkd0GTxdqMGWYnMy6+tsbbUjjCCDyx0qcSNd7Xdwlsz?=
 =?us-ascii?Q?hnrKU3sJc/G0k4znxKAv/KN04ceS71x/X17BY6KYpgOMk3f1R2Gxaa05YL0h?=
 =?us-ascii?Q?GXDjIWKrHNDwgckiEpCrranYQ2ddTPlulpMOm6AC/b6o+9FHsB9CusiS+DCY?=
 =?us-ascii?Q?aQFeuBnU1BUzQim+mTaK+dK7v3vSBPcEtmjoSxU20lF2ZQq1fMD8Rzp1zvlc?=
 =?us-ascii?Q?o/A6zCyjtmSPL1/PWRspnRrlzp4KXWQDh8jOqpUzTZd/B15hoHmVawqQhDBA?=
 =?us-ascii?Q?/dC26G+9yK3k1cpoKljYj4F80jeevx9HLAIIk7bLBLNN3UVvX8jVFsB/5N7J?=
 =?us-ascii?Q?Y+MIdb/1JagsnjSbddHldAS58Fww8Qn5AxzKv4vuqmKykavEms3GjfLHj1Hg?=
 =?us-ascii?Q?qGfJKmkUON/U30TPJJgD1t4nWcq9lk/24wmJdnqrA+P1yg/QpemXc7vIdB2H?=
 =?us-ascii?Q?NUWW5FKdto5F3PZtxXRibala44QKiE6T0AoQsTRaVrdZ6nIPjtAqWug/xiHM?=
 =?us-ascii?Q?DyC1fvV1Suh2aifQbPAzczMcPo4hjUinm7xFGI2oLfAUBnTUslgi6ifMv/cq?=
 =?us-ascii?Q?4DFGtuA2drl74GG1hCyVepbCXVbVal8j9Hu/HJKWfF1GBRvi6GQ1uo5mzQYQ?=
 =?us-ascii?Q?cS6cG/hyVr+ek3D7o8cHgW9WtBz7W/227DXGoHVOjA1oRfu9vNfZfWEKCCKI?=
 =?us-ascii?Q?K0CLhP6smMTW/nWrgtgPHH8a4y+YIdzOKZCUypCcuqa9eNwbE1eKwlZiLr7X?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KqgymxqvwR5mzBot2+nf3ytuS7F97BVTTMU4ZKHO3r0kft7k7C5k4M0T8+O2+8NA4HD+o67Y8nD1HZbViwNSG41kxRv0HikiyPkPq6/XDGIr36YD8LjwOt1Jxiv+MegYZvR8p5Zg2iMjbR+I+uQLn69MLGbtwijQEC/L2mGvT5VzjiD8ianoLsord5VOkcZEozNagjOsW/IAZ7qwqWXFoKqWDgoxvVGxTly5eK8HnFW8hggoUNxETx0PHfsHAJfJ+s5vyJWvvQNF7SkOJfTqBirwGxlqvsNWAy63/hkUO4PSLp2J0QHCgcZ8CNTnQa/6hkT+JDMX0OlJ/AqnvKCB6UBiQxVkh6xC/FK+l/neyPFSAC0cW3fydbH0UFCL8MixZWpz2jyCwpgoaluNb3g3UNy/FT36Bk1MoltK6G+/tOqbi4X7NA0AMvPoDib7C+ODetLBnpdwclYrLA+joPbK8a/nacU05dzZQHcuRK56cbn/wE6a3xi+TilaYhaAkRsjQTK2GUhPleHsDZ517F/l7RpjInAv6Vq6p17e3Q5yVfd9C8suc3yxHBtTTs3iUpxGBbctPLequOlMI5r+bXLHy50+mqwcO7M3CQL8NI4jNwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f7b9a3-2c23-479f-3a03-08dca277199d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 13:32:39.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnKlWjc2OxCu4gRYKCTuofG3K1Sj4eRppaojobQZ/1WiwSuXyhv7S33FkIPPVo2OutAcLMK+4/iuW/7xXDhkAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120091
X-Proofpoint-ORIG-GUID: eMU6mPQ8q-pI6kyymBZ_MfYUbt6REfNN
X-Proofpoint-GUID: eMU6mPQ8q-pI6kyymBZ_MfYUbt6REfNN

On Thu, Jul 11, 2024 at 03:11:13PM -0400, Jeff Layton wrote:
> Given that we do the search and insertion while holding the i_lock, I
> don't think it's possible for us to get EEXIST here. Remove this case.
> 
> Cc: Youzhong Yang <youzhong@gmail.com>
> Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease break error")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This is replacement for PATCH 1/3 in the series I sent yesterday. I
> think it makes sense to just eliminate this case.
> ---
>  fs/nfsd/filecache.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index f84913691b78..b9dc7c22242c 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1038,8 +1038,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	if (likely(ret == 0))
>  		goto open_file;
>  
> -	if (ret == -EEXIST)
> -		goto retry;
>  	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
>  	status = nfserr_jukebox;
>  	goto construction_err;
> 
> ---
> base-commit: ec1772c39fa8dd85340b1a02040806377ffbff27
> change-id: 20240711-nfsd-next-c9d17f66e2bd
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>

Youzhong, can you replace 1/3 in Jeff's file cache series and
test again please?

-- 
Chuck Lever

