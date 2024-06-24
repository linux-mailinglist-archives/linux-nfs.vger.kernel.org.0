Return-Path: <linux-nfs+bounces-4281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729FD91569D
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 20:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C59B20A93
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD341F5FD;
	Mon, 24 Jun 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVNDBDXQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cJE0u9P3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00B107A0
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254767; cv=fail; b=dgZ+H+iHRiOP84oZ7oSPhxx6rJ/GIeaEaJXYnCQUIXSVqojMax7Zmn2VSaQO0Rvmvopw1kgrGSUuH6OcFVTKh0goXv769taAClpBMna1nIF5DcosjKxzfmmh8Ch3PhhHDCWdBzqAFlFzeDQ4k+LktnDIfY3WxuoQCeYjj2KEmWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254767; c=relaxed/simple;
	bh=3OEoKCgiSh0WklOn/EdrAllS7Q2IrMCt4h/LSmG26fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n5TxLCk4XDIZW6S5GZ4hWFPkQYxWp4s0DIVYmvt8n1pf8C3HZftsZctF+wVbOABkud8kOFOYOh4iyJEpjnR0qGE7RjgeW6Eio4F9EF/nwhBOYn2rbqET/MeH+7bkoOA8HLG9AolK6UYovKVEtEuRO4K8Qs6J/8uaMX/LOUuAN8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eVNDBDXQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cJE0u9P3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OId1l3011500;
	Mon, 24 Jun 2024 18:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=+o712E19ltgUNPM
	UQtTkT2KcXXqDaSvIgcPg1mElzmg=; b=eVNDBDXQF5jsCwocv0y4HsU6yso87wm
	gRQP0g8UrsrF3nOp/AYa6/SswLVe4uEmDKg0jHKp4BYdpm7wyasyTLaCq3v4cN0s
	z2rgjP7xZrNi9Yh9CXBRRpDbYLaW7zgBeSPqbIHWBYaw3YyhjJXAgTvZ+cEv/Iuk
	Ru1yZj4hM8cCG5rksZlGk5jlrvqNmB51gEbAfMHEJEvY9TgTwJsAcV9JvmWITs80
	LG9Lt+WUEjLvS4IagHeZ4XSDoedlwz2tdUJUyPjs0qc3Sj3tFs98lffGu+hVC/dc
	AC//W07jQ8m2CCegMTmGaVv9UIXdMR5kar5EKk6WCu0/yI0M+ke57Lg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn7052h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 18:45:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OIZUJP001507;
	Mon, 24 Jun 2024 18:45:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn276ygv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 18:45:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWQ+EHJnrr1La3h5PmkoeDFsB7iWXxGsXMaXPRiMCqkV4hA/efwFKKCXCA3FdUCG+opYDjY7CLPpdH+BddmA617A6AdXNoD3JDGLUUgZjKGz01w9gOdAsIStDou/D2cwhEoYebMDlv+LIM4K6PJU8g/mAwu8gadZCBnE1bxgXEj1S030DVicQ9NvLi4ZFnZ8eFYbCJ8LbINb/YDiqhiiGfa0tvGyoG3fXORvcmkq+DLOSIfFL/pSelKCR9hmLCT4UuypT7E7BVdrXB+8z3zLLx+pth6n1VoyIWNLkJoOrD+e6PyBX5vTBaXjShi7t5qjdW24SoLyvinDHfk9GjZQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+o712E19ltgUNPMUQtTkT2KcXXqDaSvIgcPg1mElzmg=;
 b=HmmHUSZUs1kgOUjn5Z+wThP6GBenc+LK3zO75cucRuSrQTQCA2RJd+RktzI5UN2fP1U1gRpA9GaceFZWdyoIPl1/ts5qV0NKgwy2XrrS1zDC1abOjK9XxSNoES+hmVr/o6qb1GIPG0rwvamclt+zv6am6KiTY1TJB+c75Lq4CNJG+XGnIE9NVX9JObezbQ1QwEzgYwSYUoKyp0NpAldza6BDSa5H9VHRvO/FVLpsEAGikQwfZKRUCOuXuc2pQ35SaqRR/LAMWPRZTeXp1tl9U9LJ0xQi4h8TwN4rYVccyQGWHMmE8ikm4yYu5FsNXwcytMEFlNYz3QB+9KyEpahyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+o712E19ltgUNPMUQtTkT2KcXXqDaSvIgcPg1mElzmg=;
 b=cJE0u9P3xY/NyetBJBkbiEcpGOHF9ZG0EF3zMec6TqEUQl8s4o13/KOjUUq6+1ftylXevL9VG6dxhW4/fmQrAn6SXN57aUz/IQBnWdqkyf/n98Br+9crWzFwfxooDgn+hua8ZFlJ0/getYXXgoIApz/ZrIjH1Qaj4RUiK54fFgY=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DM6PR10MB4284.namprd10.prod.outlook.com (2603:10b6:5:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 18:45:51 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 18:45:51 +0000
Date: Mon, 24 Jun 2024 14:45:48 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v7 14/20] nfsd: implement server support for
 NFS_LOCALIO_PROGRAM
Message-ID: <Znm+3Gk3nlT+bS82@tissot.1015granger.net>
References: <20240624162741.68216-1-snitzer@kernel.org>
 <20240624162741.68216-15-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624162741.68216-15-snitzer@kernel.org>
X-ClientProxiedBy: CH0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:610:cc::35) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DM6PR10MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 52bdf331-a597-402b-904c-08dc947ddf26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PrqyvaCoseF1KJavdbM1e7K5c5f74GQnCxQlffFLpbB/rjShDI56tLE6mvzx?=
 =?us-ascii?Q?DbKfGgCI1+jf2ac6d/UXpxp2eLtzO0Y/IoGyqB3SH7QTHGAlL8os9Z0oRWMc?=
 =?us-ascii?Q?3TjJ9Sje80xmxKf5H6AYPCFD22qS/OkQDkq3yWLKQGRJPPdZEhNhLKQqqE4T?=
 =?us-ascii?Q?0o1wyfUGNQtNdIvHqZCD2NLpfbrm2J8rxRblbqrhvDL8wxVPivkLCQCCVGdZ?=
 =?us-ascii?Q?LqrFiZ26eD9O/UqO9JkRqDQ4qBhYY4UOiPLLQ4H/NXtGB5b+uOStubGH4J/r?=
 =?us-ascii?Q?NbQjiuVYUgZw6MmcbVT11q7j7LHBnR+6GVlzrA2DrTOLuWnmWloR+2kV1yoh?=
 =?us-ascii?Q?xgXSJDu0Ge2lxowHMie23IW++9eIqd/SGrHJqYDhKEvDreAI6lM3GVGzfXfL?=
 =?us-ascii?Q?K0sGnGJ+juDTx6zeAJ1WxsEyrd1cCp6XuW4w9BEuUgsT75qRTMhVmz7VNWUq?=
 =?us-ascii?Q?SlKc3nLYd4YJveHo8tzjDXl/wIe1PBHpYOPoYW6eDsXHQYNvpYw63Ifq2bwp?=
 =?us-ascii?Q?z22UEVMFoCP1i0I1RYhCrJUUHaYXUHDwytmuT1Wm0vm9ei7JEfjl5y6KWRyG?=
 =?us-ascii?Q?3UR5KnrperFoBJE+Hr385ImL4cmTdtcXOo62MJWYqjAis6X14ONoGAqQpLi2?=
 =?us-ascii?Q?yZlQBuaq9hu+3ErUNTr6eBdhKul18a3g2Palee8vtyePkRP/Wjquq7DYX0q9?=
 =?us-ascii?Q?/pUGd4qXmUqvTc/B0RNAsW2z/Y4xhkhws6tqw8pIpMNM+X0kzXRl6bakc+TV?=
 =?us-ascii?Q?SIU9oAAgWWDNw4DpgFV8oTVQKDFulxiPuLMoOLAunS+FxYD7Hxe6uhpPTP2f?=
 =?us-ascii?Q?d7zLIhyc5YP+A05GUxZ3o8nLaI6wAmCPbGqBw1Cf0G3thds8BnH4skX/uPqJ?=
 =?us-ascii?Q?S2Kvj53SkPeDSObH6VL0I3xjyAsTUCnesj/JtN6gMVLocxIkkYnfmbdRoTyr?=
 =?us-ascii?Q?RDXfYLRtkKJdNgi/sw+Ece34YqaojE2/AQM9AkL94T4Jw0BCaZeFfZqW/Uhi?=
 =?us-ascii?Q?vsppQn40YtuUVXu33NTO1kGA2XBrZms2nOpNe/twKSRUhDuvM9ZC7hkf4kPs?=
 =?us-ascii?Q?L3TIhTVZkZvNC5bMNeBxBLwFUBtdd1WcmzQAUiF5UaK9foHCK8C31yQ7VxUo?=
 =?us-ascii?Q?ffjcVbTDeRXaS2D3raNS4jwMbu0dlE9GmKROTdF5TkR7Mj3R9kKrQ1/qkDnl?=
 =?us-ascii?Q?+EbhklEeGOqdas/rbxn+cikz9T0YXvyPD5l3bgWgK9RZ3KsT+hGcSTr0jDxa?=
 =?us-ascii?Q?hs+p7xyDlhzxsqEcK5MUITglNAN4z+ssT5rHwqU2tMwZ7oTTJnTE3p65v1QS?=
 =?us-ascii?Q?36V/GAUP4oRh78IxCtW41WxD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?orkeaJOejX6oVK7W7+9CXqd+069TO9ANXEQ8qTKyBHf3Y3kU6kavfLX1MYc/?=
 =?us-ascii?Q?sVhqyjwC/oIDhmjUvIzP26aoiMLScg+7gfD8tRY2ylsZyG+Uoa0FiTe0WU1K?=
 =?us-ascii?Q?HRCOcOS1TkHRSxqqRDRkFIpWT1djwrh4UBaGuoR7j4wRAA7XG9oOaOjVOMpN?=
 =?us-ascii?Q?66JFNUPgG5qnFZuDjVt9PlsY/cQce1h6G1J8GY0a/jqKQFoCWz6BrKEYyH2+?=
 =?us-ascii?Q?yIMNb7KIxApa+KTeMh8o39EwHlnsjB7ZfRgUU5IpGPGEHMNh/gSMjcW5RWwE?=
 =?us-ascii?Q?VjNw7OU11nnQCi8heivfRfkER43on8vzBCYQo2Bwm0owr0V1McLIDONmBJJk?=
 =?us-ascii?Q?Fv6ywIV/Qb3ihcBzCWiPENHslWmoY0SwJJiiInlk0YYgLxKvB+p2ovEBnh82?=
 =?us-ascii?Q?FvqY7FRNxTNCmjgOB6b1N+O99THNW7qGUaaLacfmPTjBWNWMlkiKS38DKLgX?=
 =?us-ascii?Q?3Yq0jMYMeB5Y2GGn/THQxC3CNUZufpiHu8eRUDFDtHXdjJDNcz9cmsiGujf8?=
 =?us-ascii?Q?upFaPWqUANR1Qbls/gtOC48AooL00JhU4tEik3BN0S9fBmisLw2MtSWRzfAk?=
 =?us-ascii?Q?99oeCHQzsTUSSMkqjB3EC1yZ7SkotspoIAaTQ7RoUOWH10/2oPTRn5D7ABNO?=
 =?us-ascii?Q?gjQ69vbZzMA7yvuXTbFbRGsZT3p8eaQ5C7+wtkQ/n0riq1eLxF4+AhGkKAIP?=
 =?us-ascii?Q?IBOUwCvjm970CVaviNtY5GcVoaZMDyn6dao+4LWPGSTEmfwnPv8kp2qsM0vb?=
 =?us-ascii?Q?P897TwAmI4OEBG1fU+N3X4PLrJNigGMlEAg6PHYkIOvC62OCC96oHJlsYPs/?=
 =?us-ascii?Q?c3PkMsT7U/jTjQgb4bRZ0p+X0j9fYqBQA8Aik5d2k5sH2Qd4gUWlW2TlTM+M?=
 =?us-ascii?Q?x1QBeA0f+egg9oj8VTAYIn6jCkIUzwIenTIsrkoPY+ZBSx237lQSlTUJh4vS?=
 =?us-ascii?Q?C+FZs5vBwVeKagEl5xaqzBv/wtJ1ZbJVjZ2XN9SV3KO/nHEmfIrW1Nc9dOjD?=
 =?us-ascii?Q?ARefZglzgg4UuwlngYds+xeM6ii2XLwUIJvTh3K42Tau8e7iMa8eWAvwn7f2?=
 =?us-ascii?Q?IwIsAsGqfzQnmoBHrRo8G3UYyRtSN5kyFKD+9plb9SC5UYv7bxxCYuXNDDIt?=
 =?us-ascii?Q?fyv9MJyUCe4bUPM28g7dOyzJDBltRLMPteLQO6Bjlk2R6zkbwd6xnN4ol6Oq?=
 =?us-ascii?Q?KsgorUvNP5LxnWu3iCX81NprJk1GOrKpwpfqdggW9Bg8YI0k1ApeuDIbfzPw?=
 =?us-ascii?Q?myB3hL+7Z6BqMcTIEg87oukRQqNF2cIjE8f1ZwMA3y5qxE0HAZTzZ/ODDnT6?=
 =?us-ascii?Q?PcWu/RwDBa4gPiVGMdICn4SoX5AIUiu9EBTgCP+tdtbtw/bVi/sqe0OvLKp+?=
 =?us-ascii?Q?jkJ2+KncWE6VsDZx6Qd/0FsFtU0pmObyZTfpAurDlPtVaKLJFcynUdhZp7fq?=
 =?us-ascii?Q?frp5o7X8vG+xzFlIbT8Qine0ZJ4SSXfBX/75SoEmf6Gf4QbVTMGFvMSxvW00?=
 =?us-ascii?Q?nF4UNsx3++EDZjyk1eFzNGe7+1RVSHYjaxZ/3mLMo2HZcf2gSXefY1b8OU/D?=
 =?us-ascii?Q?crrdVI8bmGr9KJrLVB2mDChP23vQ0c0QoIYi4IPA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UHV9Py8jOQlmGPQ7vQNJwxxFE5UEkGUSPSqImePl9xN+UNcA4gtnPHMMKKM2aPqJzMu0U4wO8Zj25bYvGmf/qNBKrwmjOCadlOR8DVkbMffJQ05gLnBiBitV/Ry9Mbt8RFwnIFdK3YF7JPTUQqcMkeH9al14c3HVlKRxMavlkRX7hzZV1gbDlO/xelRA/jvFZhXhGLBmnk70ijAESmZvrSaHlafL/kjqqfnzjIhJ4Gv4elY26djo8scEQ/2uneQMQAekb6HysPitmiSLTYKnSEqlBzau1MhQc9yflGE8TpKrNu5TiTObH27z9W7xUZGuU1wF1ztPh37nQ5wlB2CjRBOuFxy8/tLM/pDIU0Cui5T6nTSIFMGVzDP+FfPXtYOK7Vb8nEXwLmzYoJpMcbjlSpivXr+ZE4ccoaR6zUJ0l2LC+ypC+8fggN+ztwIyhe/qSFwRQ5lb292Jgllpw55L4q5DrijxOZKClYe6dThyAWh+xcr9j8LFQzz4dT3s/zjQqIbwc2maAaqamUtDYSFZtG7PPqlLwr8fri/8Lmg2Ypvp2YIbpxUoIWQM8QHYEFvuqSzoYPiC4hum0BhMVXs64BTNrvFxqQ454XRnLzqNebs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bdf331-a597-402b-904c-08dc947ddf26
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:45:51.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bIdajuv7AtjDVOHOF1SGpPkdXeIdN8qs7H2TZxMgg58eTu8NewpLgJsw7Hn7nZd71DiBlXVaTk7h2C82BCZWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406240149
X-Proofpoint-ORIG-GUID: GteqZbkbh885SXFp-2IPMVdcFGxOCBbn
X-Proofpoint-GUID: GteqZbkbh885SXFp-2IPMVdcFGxOCBbn

On Mon, Jun 24, 2024 at 12:27:35PM -0400, Mike Snitzer wrote:
> LOCALIOPROC_GETUUID encodes the server's uuid_t in terms of the fixed
> UUID_SIZE (16). The fixed size opaque encode and decode XDR methods
> are used instead of the less efficient variable sized methods.
> 
> Aside from a bit of code in nfssvc.c, all the knowledge of the LOCALIO
> RPC protocol is in fs/nfsd/localio.c which implements just a single
> version (1) that is used independently of what NFS version is used.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> [neilb: factored out and simplified single localio protocol]
> Co-developed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/localio.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfssvc.c  | 29 ++++++++++++++++++-
>  2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index f6df66b1d523..aaa5293eb352 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -11,12 +11,15 @@
>  #include <linux/sunrpc/svcauth_gss.h>
>  #include <linux/sunrpc/clnt.h>
>  #include <linux/nfs.h>
> +#include <linux/nfs_fs.h>
> +#include <linux/nfs_xdr.h>
>  #include <linux/string.h>
>  
>  #include "nfsd.h"
>  #include "vfs.h"
>  #include "netns.h"
>  #include "filecache.h"
> +#include "cache.h"
>  
>  #define NFSDDBG_FACILITY		NFSDDBG_FH
>  
> @@ -249,3 +252,74 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
>  
>  /* Compile time type checking, not used by anything */
>  static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
> +
> +/*
> + * GETUUID XDR encode functions
> + */
> +
> +static __be32 nfsd_proc_null(struct svc_rqst *rqstp)
> +{
> +	return rpc_success;
> +}

We already have an nfsd_proc_null() (for NFSv2). Let's use

   localio_proc_null()

instead.


> +struct nfsd_getuuidres {
> +	uuid_t			uuid;
> +};
> +
> +static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)

And here, please use

   localio_proc_getuuid()

instead.


> +{
> +	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfsd_getuuidres *resp = rqstp->rq_resp;
> +
> +	uuid_copy(&resp->uuid, &nn->nfsd_uuid.uuid);
> +
> +	return rpc_success;
> +}
> +
> +static bool nfslocalio_encode_getuuidres(struct svc_rqst *rqstp,
> +					 struct xdr_stream *xdr)

Please use

    localio_encode_getuuidres()

instead.


> +{
> +	struct nfsd_getuuidres *resp = rqstp->rq_resp;
> +	u8 uuid[UUID_SIZE];
> +
> +	export_uuid(uuid, &resp->uuid);
> +	encode_opaque_fixed(xdr, uuid, UUID_SIZE);
> +	dprintk("%s: uuid=%pU\n", __func__, uuid);
> +
> +	return true;
> +}
> +
> +static const struct svc_procedure nfsd_localio_procedures[2] = {

I think I prefer:

   localio_procedures1


> +	[LOCALIOPROC_NULL] = {
> +		.pc_func = nfsd_proc_null,
> +		.pc_decode = nfssvc_decode_voidarg,
> +		.pc_encode = nfssvc_encode_voidres,
> +		.pc_argsize = sizeof(struct nfsd_voidargs),
> +		.pc_ressize = sizeof(struct nfsd_voidres),
> +		.pc_cachetype = RC_NOCACHE,
> +		.pc_xdrressize = 0,
> +		.pc_name = "NULL",
> +	},
> +	[LOCALIOPROC_GETUUID] = {
> +		.pc_func = nfsd_proc_getuuid,
> +		.pc_decode = nfssvc_decode_voidarg,
> +		.pc_encode = nfslocalio_encode_getuuidres,
> +		.pc_argsize = sizeof(struct nfsd_voidargs),
> +		.pc_ressize = sizeof(struct nfsd_getuuidres),
> +		.pc_cachetype = RC_NOCACHE,
> +		.pc_xdrressize = XDR_QUADLEN(UUID_SIZE),
> +		.pc_name = "GETUUID",
> +	},
> +};
> +
> +static DEFINE_PER_CPU_ALIGNED(unsigned long,
> +			      nfsd_localio_count[ARRAY_SIZE(nfsd_localio_procedures)]);
> +const struct svc_version nfsd_localio_version1 = {

I'd prefer:

    localiosvc_version1


> +	.vs_vers	= 1,
> +	.vs_nproc	= 2,
> +	.vs_proc	= nfsd_localio_procedures,
> +	.vs_dispatch	= nfsd_dispatch,
> +	.vs_count	= nfsd_localio_count,
> +	.vs_xdrsize	= XDR_QUADLEN(UUID_SIZE),
> +	.vs_hidden	= true,
> +};
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index a477d2c5088a..bc69a2c90077 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -81,6 +81,26 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
>  unsigned long	nfsd_drc_max_mem;
>  unsigned long	nfsd_drc_mem_used;
>  
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +extern const struct svc_version nfsd_localio_version1;
> +static const struct svc_version *nfsd_localio_version[] = {

Instead:

   localio_versions[]


> +	[1] = &nfsd_localio_version1,
> +};
> +
> +#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(nfsd_localio_version)
> +
> +static struct svc_program	nfsd_localio_program = {
> +	.pg_prog		= NFS_LOCALIO_PROGRAM,
> +	.pg_nvers		= NFSD_LOCALIO_NRVERS,
> +	.pg_vers		= nfsd_localio_version,
> +	.pg_name		= "nfslocalio",
> +	.pg_class		= "nfsd",
> +	.pg_authenticate	= &svc_set_client,
> +	.pg_init_request	= svc_generic_init_request,
> +	.pg_rpcbind_set		= svc_generic_rpcbind_set,
> +};
> +#endif /* CONFIG_NFSD_LOCALIO */
> +
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  static const struct svc_version *nfsd_acl_version[] = {
>  # if defined(CONFIG_NFSD_V2_ACL)
> @@ -95,6 +115,9 @@ static const struct svc_version *nfsd_acl_version[] = {
>  #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
>  
>  static struct svc_program	nfsd_acl_program = {
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	.pg_next		= &nfsd_localio_program,
> +#endif /* CONFIG_NFSD_LOCALIO */
>  	.pg_prog		= NFS_ACL_PROGRAM,
>  	.pg_nvers		= NFSD_ACL_NRVERS,
>  	.pg_vers		= nfsd_acl_version,
> @@ -123,6 +146,10 @@ static const struct svc_version *nfsd_version[] = {
>  struct svc_program		nfsd_program = {
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  	.pg_next		= &nfsd_acl_program,
> +#else
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	.pg_next		= &nfsd_localio_program,
> +#endif /* CONFIG_NFSD_LOCALIO */
>  #endif
>  	.pg_prog		= NFS_PROGRAM,		/* program number */
>  	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
> @@ -975,7 +1002,7 @@ nfsd(void *vrqstp)
>  }
>  
>  /**
> - * nfsd_dispatch - Process an NFS or NFSACL Request
> + * nfsd_dispatch - Process an NFS or NFSACL or NFSLOCALIO Request

Nit: "nfsd_dispatch - Process an NFS, NFSACL, or LOCALIO request"


>   * @rqstp: incoming request
>   *
>   * This RPC dispatcher integrates the NFS server's duplicate reply cache.
> -- 
> 2.44.0
> 

-- 
Chuck Lever

