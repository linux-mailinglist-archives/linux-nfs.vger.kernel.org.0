Return-Path: <linux-nfs+bounces-8711-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF7E9FA824
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 21:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E461886B62
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 20:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6C194C94;
	Sun, 22 Dec 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j4w7kuXO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uX5+WjVR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5E192B69
	for <linux-nfs@vger.kernel.org>; Sun, 22 Dec 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734898658; cv=fail; b=NHljHCPm6EvXW7MREsXyjP7X40Hgbnww73bJk69Az+ngqEEfiGRyA0U2QO/vdwpm+khs6BaGAgQ82x7SdGC41Hk43R/AJn/vZSS8T/rs2b1N7I/pgDmzaFqOBpkRX/LtKLNvF4TuDs99ymyN5KHFkFk41D8kmi9vnuWlSwkhjns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734898658; c=relaxed/simple;
	bh=0dZTvQOgJ7pj+0VgwNeZKkDmWQfaHipoyvsj1zUEZvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eV7ZFUiJYYHXQzdr2NOW63fjJPe80AmA08U0Ua7a8l8ZCctfTnIrgXjyFo9l6TkJ/YBFBww9SJGEVF7xANTP+8r+SYWwtc9ayHV+4+kl58kI9CfxQoQ+flEO+nTyDKwUYXX+5tuxHBxaeWJTWOWlY+yfPLTwtFoUPabvhFFehmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j4w7kuXO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uX5+WjVR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BMGajBo030949;
	Sun, 22 Dec 2024 20:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h1wVgENp6hRyUgYV11Objs02prvKGWe1VWFXgNeZQNU=; b=
	j4w7kuXOKz+aTmrHq+k3M7tyFgMvCBFunkFP4356EVehaKEtbhBMPRMhTJrFMEb7
	gLyKEUI5ZLe/coo47uBrOnu4b3zH0eJG1KfRTKYHZ12tIbIvpo76ZAWYWylfXbSU
	5FiK1+BamrLIYpkBjwrp25m9gLPe9AsDWpc0ERTPhP5AWl/dShucGvFpWACvLEes
	4NclB48QpOa/ZWKQfAZk2wdH4pM5H5pK6C2UC2eqYxwptaIzmlp+IS6RbU+fM+iQ
	7RUM4HCsDdU+GAPgYT3ugH+3+zaB/Rg7d2PGrBlm85Tf+FIGWtBKgllmr99WpG1Q
	bZhQvqe+u234JOiprRQA9Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7rh84q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Dec 2024 20:17:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BMGJM3q039142;
	Sun, 22 Dec 2024 20:17:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43pp6hty25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Dec 2024 20:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQWWYmkDnR4GGGHVuh/YWmdEkZaycTfb6kjb3WxBsKRj+BRW5um8p0tk7ZN3LEXnPqHO0F2pGNq2tUhqEbQTxo2rc7CuBsIBTCsTW5DHBa9Uty0Z3cLQ5g4BsRbA20UAPWlg5wk5D0jAQpnDHK6/2SAf5DUJp85cHMaRfaITnfg1k2ad3PDAdMP/Gu6RTdI+M/tQmlayx0rcz4nB3AX2SrnddVKBEM7zecfky4/R7XdkxfZUtVmE7aRobD15dmDe5GCLxL048Wa8HGvOG8KiHKYxLJ82APwH/xqE3pd/F7Swrl44J8CGKDX8IqQxIKWfg+ST83up6Gh1litK+LcenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1wVgENp6hRyUgYV11Objs02prvKGWe1VWFXgNeZQNU=;
 b=d+m9P4pDySnRpk/tOy8NJv2IXIJ2NdXazsJXtQsDbb7higLeI3hO/4PoXrfrL12Dk1q2+9ip+W9yy0vAPVTV8qPrTU7rAuQ4CvVHdXZudcrAKiRjuj5sHzkOG7rMhvHE8LeAIs6bjOmFZ5xs+RzxlSAjXaJxDUFN/wEV5dHJru7Dnr8qe9MGbpomCsfmhcNaALPUOaiFAN70S0vcu0+81qInG5XVKGc73TsRtmbivlqSULztVSg6mOFVyF4V2K8ug4arQmWt+qJmoNl39U/xh0kKBo7wbQFsxiTp15IHa1BzsfjA9pOgDsbMlKgAXvUaQoX49rRPlQIoUtT63MrPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1wVgENp6hRyUgYV11Objs02prvKGWe1VWFXgNeZQNU=;
 b=uX5+WjVRYUmLFAY3A8uGxrSNZuKK7dg5xBfmC9h8Iv57/QXYXEWFn3cRyAaP5H+gQBm27cR8RHSmldohhYINjuCHPbS4pI7mXfyj/FTa3XJdGPIkaFUPpm+hu2kHszZ9rGI4SWV2gzzqqQ8PwLRkcrY7KW1g3RndIKz1LQWZIHM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Sun, 22 Dec
 2024 20:17:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Sun, 22 Dec 2024
 20:17:20 +0000
Message-ID: <3998d739-c042-46b4-8166-dbd6c5f0e804@oracle.com>
Date: Sun, 22 Dec 2024 15:17:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Rick Macklem <rick.macklem@gmail.com>, J David <j.david.lists@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com>
 <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
 <e4853faf-0836-4595-952b-69f71150bede@oracle.com>
 <CAM5tNy6tR96WrCeoLEfoA5cGs0AP=mR3q1nmYrqbFTTQB=G=Yw@mail.gmail.com>
 <CAM5tNy6dFBgAhkX_mBzXyRyb+WfukZT0egpt75XRgCYKHPsP3Q@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy6dFBgAhkX_mBzXyRyb+WfukZT0egpt75XRgCYKHPsP3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:33::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: d13e3524-1c02-434d-89fe-08dd22c5a33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGF4aEJYSmdFUGQ4VFdIUmFncUZaMVJzY0xwMThXaUhvNWRkM1d4SmZPSjk4?=
 =?utf-8?B?TmRFTGlEK3N5Q083dU5LRmpVdVBqTXFUbmlUR3dmNHRBaER0U0dOVnRTVTZj?=
 =?utf-8?B?WFFCUkswZGpndlQzS21jd1FuU2RTdUtPUDBWaTZ5Q1JFbGtBN3lIbW83aTUr?=
 =?utf-8?B?d1hNTkNjVTdOSlBycTRBVU1UMW11dGJiNVR4M0RleGZJWjFMRG9IeGlac3hP?=
 =?utf-8?B?ZzhzTncvTTlndFpHQmM0anZaU1pBUHJTOGZ3Z2dCTnZQZEJRdU5XK3l2WmxR?=
 =?utf-8?B?dFN1cGxySzJnVU1iVElzamQ2aFBJaGxEYlRmOGZLelQrLzJQbzJQVHBWZ1dH?=
 =?utf-8?B?VVNFN0tma3dXUEFIaGZKWkwzeEVvWjJBTTJ3SXdrMEpGc0RWazZIdzZneEdu?=
 =?utf-8?B?ODNGNnh1bTVLYm1jUkgzemxwZmRCc0hLdzZESkJLaHVKSXpmOGIvbFJWTHZB?=
 =?utf-8?B?K3VrNU92cjRsWWpwWHpaN0lEaGFTN3VHZmJNckIwcjBMUGorMUVsZUhHWW9Q?=
 =?utf-8?B?a2tnVlZkVGMvaEhSdzZxbURGYlZ2L1pFbkZoUmxmL09mdGtCMWtWQ1lMUWNn?=
 =?utf-8?B?MXB5UnNjendKWlJZbVJrT2pEYnhsUC9EdnhMRzdhbk5rOHMvWWtseVM3azd2?=
 =?utf-8?B?RDZLdWlNVHFxWVplZUplUVZHUU9BcVc1U25WMW1STGIrR2RneHRiUzNSMTgr?=
 =?utf-8?B?TEgyRFRobXg0eUExUjUzMmFmWmRmcTgwU0hZdFZIRDVwcnYvMGlFamN5c0tI?=
 =?utf-8?B?ZWpYczMxYWxIVnBjUUh4SFZWUHpLVjhMSXBKVElqSjlVZklJL2UrbXNWMkFs?=
 =?utf-8?B?WVJ6ZUI2Q3Z1Nnl5UnpzcjRTRzloZjVsWWlxSHh4TmNVd0JMTXA0OWpLUndB?=
 =?utf-8?B?MlVjZHdsa3N5b0t0NlNvU3hnRG0xdnpOTVZnTlYwWmdYOWt3ZWZBckQwTHlC?=
 =?utf-8?B?TmVlNkVQeUxnRW5oQWk0QXpnNmlBZWZYcUNXc2h2OXpqeDZWa2h5bDV4S2lp?=
 =?utf-8?B?SGJuUVgrQlRxbk91VFlsaCtEbE9xdHBFRE9YTUxCUkQ1cU1WZHNnZ0hkU3du?=
 =?utf-8?B?NFM5MmFMRnFEVnVXNW4vSUxyZ1FPa3ZUUFY4SXdKOXNaQkpBTDhTR09UcnIy?=
 =?utf-8?B?SlpFS3oyTi9IMjVVYlhlb3hNZ1dSZXpSMkYraGZXcXFkTW4wUUtFckk2Mkg3?=
 =?utf-8?B?dEhyYmpCTStLQVB1MmZvckNuZ2I4QmRubXRLTHR1TnFvU2NEc1ZZMEhLVnNa?=
 =?utf-8?B?MzY4ajNVMHErOThrQzBjbXNPc1F4WE9tTkQ2UCs3MGpYYldyV3RmUDFFMUxU?=
 =?utf-8?B?WHNMNjhkTWZxTExTeHF4cEdLUXN3VDU4RDlpQi92ZjhjeXBVaS9HSERlamFy?=
 =?utf-8?B?ZW9kZTJXQmtSQ2tpMjZRbXBFSExoWjRHMmR4Y2F2V3FRczZFdTIwMENpem5o?=
 =?utf-8?B?OWxvTFB0MC9hSDl1ZlJHa1JaMEdPMVlrTlhqNE1KTDl4ZEJyYmt2TDg0OHlF?=
 =?utf-8?B?cnhZajM3clUrUnErQjM1Ym5kUlhjcUhFT2Y0ajJwd3g2cjZYTUVqdnlyejgz?=
 =?utf-8?B?S0JIMUoyQVJ4OEpxRk01VGxobFF3Z1ZibkVxckFadSt5b1N3c1Q5WXFvMy9X?=
 =?utf-8?B?aHljNEZFMGdRSnQ2OHBBM2FXWEQvTWMxRWFsZWdTa0c0TXdLR1hKOGlkZkNW?=
 =?utf-8?B?QjBEUzU0OG1JNzJyYVNjTnB5WXphQnhqNGp5dmRNTDVFRXFxSzh1eEV4OEFq?=
 =?utf-8?B?eWtmMzRndWZjcTJ0N1R2TGcvVDJ2eXB6QlNVVGZia0crVVR0SmpuNzJsbVIz?=
 =?utf-8?B?YVBtYjV0QVAvaDlpQUlRUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTVCNmNJaytROFNFalZFMDlrd1pIbGwvRm9RUEpLR05FclE3Q2dZcGZKV2lF?=
 =?utf-8?B?R29qRXQreFI4d0xXNDh4eHNvMktvaXlJaVdkV1pjVDVqTU9VWjdKSGtVZ2kw?=
 =?utf-8?B?TElUeURDaFdlRXJ4Z2phT254WWdZS1IrMkxDd2x5aXFlOXRLQ3kzajNrTWcr?=
 =?utf-8?B?RUk4UTZWMFlLSXZPNkhtT2dXVDJQZzk0d2l3VmpPT0E2UVVwMzY4ZTNyNk51?=
 =?utf-8?B?a3gxMDBzRDUwY3lubnpQUVFNVTNzREM0S2xldUhmNDd3UlYraVNFOGlsSlV5?=
 =?utf-8?B?ZnRNdnlNTENuN1VEd0duTDgrS1MvYVZyQmM3WDhueHNzSzFXTDJZQ2FhR1FE?=
 =?utf-8?B?RU9Ed3JTUXFIQmlVeVVLVXE3QnFyWjlHQ1BOR2pGUWM2UGlvUWl0WjlvREtT?=
 =?utf-8?B?LzJack5LaUduUmJzNnNveFVtWXc4RW5wU2Y2RkNlSE8vK0V0empnaU1mT2Fv?=
 =?utf-8?B?MkR5VFhQZkd2NTdqNW04bFk0VVh0VnltekE1eHpWZy9HdEZ4VUVnYnljNDlL?=
 =?utf-8?B?ejBBVFlQeXJjbngrdysyNU4xeVpBa3g4amRjSDJ2dVp1R2RKL1htWCtRbTJ0?=
 =?utf-8?B?Z3JmRnpueWJvTHo1QXZTOERHckxZc2xjc25iWTBuMVdnT0lVUGFsY0V2UC95?=
 =?utf-8?B?YjdjbitDdlRjeVJWL1U0Q0wxNzV2b1hUQjlDTWdSQTNLV0dDbHNSNXNLQS9O?=
 =?utf-8?B?M2RhSGNWSTlwZEp0RXM3UEp0SHdOVDQvZnR6cFQvWDhvSXZpV0FtSTl1WGZP?=
 =?utf-8?B?VVpHNWNmNUQwMEsrUWM4VGljSzVMT0NlcXJDalRtSVZNcU85NENPOFN1eEpz?=
 =?utf-8?B?eG1OYjQrQXZQdldoUE93SXpGUlM5QW94MStkWjBNR2xUMFh1Q3RPOFZNdWJ4?=
 =?utf-8?B?eDFWVUNoMFNKTjJvN01VT3Z4U0xNbzB6bGtjaEhxdzhvNWxJZ3BCWm04dkYy?=
 =?utf-8?B?b2ZkaTc2Q3dsYWNhM014bHcvcnk4SWV6bjNpOE9CTmZPQS9BejFYSG1ESi9B?=
 =?utf-8?B?ZkxkaVE3Mm14MDUyWE5RNVJaOFhPL1ZtQmEyV0c4dStiZDlRaURKVlFqSENs?=
 =?utf-8?B?aWlZeUt6RHdERGI5NGpuVFpWOGEzYWpRcm1DVjFoV3QrYUtqSUVaTTUxSEZD?=
 =?utf-8?B?bHRYbU51MW9zNXl4SmNHSGRGQ2FydEN6YjFocFBzc21OdnhGTGEyZU1Fb1N2?=
 =?utf-8?B?R0JBMTJkSnlXVjl4aU42elROK3JaV25wODVaNWdwbCttaVA0ZnIxRXN6RE8v?=
 =?utf-8?B?N2dCQUNjWnE0dXA4QjlYZ055b0pSdlpES1lvN1ZtcUdQaHRodTZNdXhLTVBZ?=
 =?utf-8?B?cTZ3VEtyR3ZUbzZVY00wRVdrb1VDNG1PYTIvZGFTUUdEaXVidmdEYUlYYXpC?=
 =?utf-8?B?WWE5KzJFK0I0SFBPcHFkMmo2NTdCZzZLY3Z1OENXWDd1NFA3S1gxUGcxbUc5?=
 =?utf-8?B?NlMrL2M3V3NyVEgwMVgvQm1BeHllRWxiM3B3Nlo5bm1MSXRUVFB5TWNwSXRW?=
 =?utf-8?B?TUdtR01VK0RRMjNWSFE3WGgxSFlsUm9BYk9aZDZRWEgzdWFhVHlwRlVNaU81?=
 =?utf-8?B?bWdyZkN4REdXUkNBdWxhSWtOU1hRR2ZZL0NPNFROaThvMXEzODFDTlEzUy96?=
 =?utf-8?B?SXpQcHk5M050NElEYmFhNzNySXVxSnN2amNpS25JWkJRRWJZU2tJSUxpRlJu?=
 =?utf-8?B?TllHYU4ydFdpczY3WlVQcElBb1hReERNbWUxMm55OHU3a1ZwdTArc1pmNzlG?=
 =?utf-8?B?YlBFNFJOc1Y2OFovVFBxYi94MituVExmbFhVWWkwY0lBMDJZY0lnUjBpOURx?=
 =?utf-8?B?UGU0SkJyZmN4UURhTW5FN0M2UmhLZUVCaGEyeWxGQjBFL2ZSem9UZVhoZmVO?=
 =?utf-8?B?dm55MlRwWitPTlh1RS9xUDY1R2dsaldzMHU4MFZjMTFSdCtUV3hYNnNyRElF?=
 =?utf-8?B?U2hUTzM1azh1b2N6bE9uTEdNK2kzWFd1NWRqTTN6cTdCWnAyUkF6NU5Jd3M0?=
 =?utf-8?B?WmJIMVE1SjBuUng3ZHY2d0EvTUNaRmpvenc2OGtOMkVBdFg0UkgwY0VVcVJJ?=
 =?utf-8?B?d1JhM3VEcGpMVHQ1VW0xWDg1WWtNaFB2ZDBIZVNsRUY4SytHcEpadEtkTDZv?=
 =?utf-8?Q?CCFm29iamFW6sAC5K8fc5FM+j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D/H2SI9qR58LoxyhrP0plUOzTKlQDZP/p/mMFpPYiz9D6dg3zENqlxdiI5LWGyZBelJftGPFrkS7a1DJBykXvdFzoT+oEROQfuvQNApQbUrH3h81PBIeceeIxwTmxrc6GV2xNKhREwMwCda0lY/RZJqrXr4FKT9J4GijNe6fk1rF/S8sqZLIJm3LxSuyTMtyIfRKteRpLnrWkwUAbeGztjX/Ng4ORDh0ZGUwYgZfwcTZxQwhMnm8yMXcKERcZe4AEXbDhq+6VHt5wZVzSh4doBnxjQBC+OOJV7ZrB8Y2ko1uuJLF2zi6r0y/W1f7mxIsYADtZA7Uf5IbG0lC4x7c6SnNVhd5gLY6sZL0NVXIdYbQhuaXnZVKu1YZRJmCxo+f6D9Oge53hSytiDuu4yRlMlWcO+kvJFGsxrJb+3ihi7FSMl9OiGsqz0U+vuEoi72s24S0qVmvsUqWLAsMLfaFqGcwfuNzQIyn0l3GOCUJwK8/z5Zgxw1hBv6p+gkh9+mbmR/B0uejmFZwU2uJtk/uEwOoHeinIRgaiZ6+A2Za4eGDUNNyK4tU5jn+ScdisdGBZynhrKwI1qcjeujlULu7f6FUdC3SiUn43Oa9GVhjOqo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13e3524-1c02-434d-89fe-08dd22c5a33d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2024 20:17:20.0188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85jFj4WM5IOkrWNBJkWiI7GSLcqzgCCIBFzR/ipOEGIbR4uKyTPuDG3wbHyyQmqi4LX/2Sa2ZexGNGVEccaRjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-22_09,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412220186
X-Proofpoint-GUID: 6fxZ8H6sjDGNAEuCk9-zkwjwnLbHrQb1
X-Proofpoint-ORIG-GUID: 6fxZ8H6sjDGNAEuCk9-zkwjwnLbHrQb1

On 12/21/24 6:53 PM, Rick Macklem wrote:
> On Sat, Dec 21, 2024 at 3:27 PM Rick Macklem <rick.macklem@gmail.com> wrote:
>>
>> On Sat, Dec 21, 2024 at 9:34 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>
>>> On 12/20/24 9:16 PM, J David wrote:
>>>> Hello,
>>>>
>>>> On Tue, Dec 17, 2024 at 8:51 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>> If they can reproduce
>>>>> this issue with an "in tree" file system contained in a recent upstream
>>>>> Linux kernel, then we can take a look. (Or you and J. David can give it
>>>>> a try).
>>>>
>>>> Yes, I reproduced this behavior on ext4 with 6.11.5+bpo-amd64 from
>>>> Debian backports on completely different hardware.
>>>>
>>>> Then I set up another NFS server on Arch (running kernel 6.12.4), and
>>>> reproduced the issue there as well.
>>>>
>>>> Then, just to be sure, I went and found the instructions for building
>>>> the Linux kernel from source, built and tested both 6.12.6 and
>>>> 6.13-rc3 as downloaded directly from www.kernel.org, and the issue
>>>> occurs with those as well.
>>>
>>> Reproducing on v6.13-rc with ext4 is all that was necessary, thank you!
>>>
>>>
>>>> Additionally, I have tested every combination of FreeBSD, Linux and
>>>> OpenIndiana as client and server to confirm that FreeBSD client with
>>>> Linux server is the only case where this problem occurs.
>>>
>>> Interesting.
>>>
>>>
>>>> Does this count as reproducing the issue with an "in tree" file system
>>>> contained in a recent upstream Linux kernel? I'm asking sincerely; I'm
>>>> so far out of my depth that I'm pretty sure there are sea monsters
>>>> swimming around down there. So I can't rule out the possibility that
>>>> I've done something wrong either in setup or testing.
>>>>
>>>> During the course of this, I've gotten the reproduction down to
>>>> extracting a 2k tar file and then running "du" on the resulting
>>>> directory from the client. Doesn't matter if the file is untarred on
>>>> the FreeBSD client, the server, or another client. The tar file
>>>> contains a directory with a handful of random Javascript files from
>>>> Drupal. As far as I can tell, it has something to do with the number,
>>>> size, or names of the files. The Drupal project has three separate
>>>> directories all structured like this with the same filenames, but the
>>>> file contents vary. The issue occurs with all of them.
>>>>
>>>> The Linux /etc/exports file is just:
>>>>
>>>> /data 192.168.201.0/24(rw,sync)
>>>>
>>>> (The production case also uses crossmnt and no_subtree_check, anonuid,
>>>> and anongid, but I eliminated those one by one to make sure they
>>>> weren't responsible.)
>>>>
>>>> The corresponding fstab entry on the FreeBSD 14.2-RELEASE client is:
>>>>
>>>> 192.168.201.200:/data /data nfs rw,tcp,nfsv4,minorversion=2 0 0
>>>
>>> Out of curiosity, do you see the problem recur with nfsv3 or the other
>>> NFSv4 minor versions?
>>>
>>>
>>>> One additional thing I noticed that really blew my mind is that I can
>>>> shutdown both the client and the server, wait, power them back on, and
>>>> the issue is still there. So it's not something in RAM.  That prompted
>>>> me to try "touch x" in the directory to create a new 0-length file.
>>>> The issue then goes away. Then I can "rm x" and the issue comes back.
>>>> By contrast, I can write megabytes from /dev/random into one of the
>>>> files without affecting anything; the issue stays the same.
>>>>
>>>> I then tried it with all empty files using the same filenames. The
>>>> issue still occurred. Add or remove one file and the issue goes away.
>>>> I then renamed one of the files to zz.js. Issue still occurs. Renamed
>>>> it to zzz.js. Problem still occurs. Kept going until I got to
>>>> zzzzzz.js and it worked.
>>>>
>>>> Finally, I got it to the point where running this in an empty mounted
>>>> directory will create the issue:
>>>>
>>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
>>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
>>>> done; touch y0-xxxxxx.xx
>>>>
>>>> and this will not:
>>>>
>>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
>>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
>>>> done; touch y0-xxxxxxx.xx
>>>>
>>>> (The difference being one extra x in the last filename.)
>>>>
>>>> It works in the other direction as well. This causes the issue:
>>>>
>>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
>>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
>>>> done; touch y0-xxx.xx
>>>>
>>>> This does not:
>>>>
>>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
>>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
>>>> done; touch y0-xx.xx
>>>>
>>>> There's a four-character window involving the length of the filenames
>>>> where 62 files in a directory causes this issue. There's a little more
>>>> to it than that; it doesn't look like you can just create 61
>>>> two-letter filenames and then one really long one and get the issue.
>>>>
>>>> So I haven't found the specifics yet, but perhaps due to pure chance
>>>> this directory structure is exactly right to provoke an incredibly
>>>> obscure edge case?
>>>
>>> Well it's likely that this is a problem with READDIR, so file content
>>> is not going to be an issue. The file name lengths are the problem.
>>>
>>> Also, I'm wondering what the FreeBSD client's directory readdir
>>> arguments are (how much does it request, what are the maximum limits it
>>> negotiates, and so on). Rick?
>> As you'll see in the packet trace:
>> Sequence: cache this: No
>> Putfh: directory fh
>> Readdir:
>>      cookie: 0
>>      cookie_verf: 0
>>      dircount: 8706
>>      maxcount: 8706
>>      attr: type, RDattr_error, fileid, mounted_on_fleid
>> Getattr: same attributes as requested for a previous GETATTR, mainly
>>                to keep the directory's attribute cache up to date.
>>
>> The session negotiates a max request/reply size of just over 1Mbyte and a
>> maximum of something like 20 ops. (Can't recall, but definitely more than 4.)
>>
>> If you are wondering where the 8706 comes from, it was an estimate of how
>> much would be needed to fill an 8K buffer with the XDR translated to UFS dirents
>> by adding 512 to 8K.
>>
>> I have not yet had a chance to see if I can reproduce the problem with
>> J. David's
>> reproducer. I will try that soon, and if I can reproduce it, I will
>> poke at it to try and
>> figure out what is going on.
> Just fyi, I have reproduced it. Once you use J. David's little shell script to
> create the files in the directory, the Readdir RPC gets the junk reply
> to GETATTR
> (the count of words for the attribute bitmap in the reply is 0 instead of 2).
> You can unmount/remount it and still get the failure, assuming you do not
> mess with the directory contents.
> 
> Good work finding the reproducer, J. David!
> 
> I will start to poke around to see if I can figure out what the knfsd server is
> doing.
> 
> Chuck, I suspect any fairly recent FreeBSD client will be sufficient to
> reproduce this, just in case you are inspired to cross over to the dark
> side and install FreeBSD somewhere.

I see the same malformed GETATTR result in the attachments.

Linux doesn't trip on this issue because it's NFS client doesn't ever
append a GETATTR operation after a READDIR.

So I've installed a small FreeBSD 14.2 guest, and copied the reproducer
script over to it. I see the extra GETATTR now, and I'm trying to
figure out what is causing the corrupted reply. At first glance, I
can see the problem involves a particularly placed page boundary in
the XDR encoding buffer, but it isn't a problem with GETATTR encoding
per se.


> I'll post when I have more info, rick
> 
>>
>> rick
>>
>>>
>>> Since this isn't reproducible (yet) with a Linux client, let's try
>>> another set of network captures, and you can send these to me
>>> privately.
>>>
>>> Start the capture
>>> Mount
>>> Run one of the reproducers above
>>> Unmount
>>> Stop the capture
>>>
>>> I'd like to see one with v6.13-rc3 and ext4 that works as expected, and
>>> one with the same configuration that fails.
>>>
>>> --
>>> Chuck Lever


-- 
Chuck Lever

