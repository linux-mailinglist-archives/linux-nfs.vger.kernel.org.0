Return-Path: <linux-nfs+bounces-7862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F376D9C4299
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 17:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37CF286EDD
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E90178368;
	Mon, 11 Nov 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I7kv0SEB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I7p97uKk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863754728;
	Mon, 11 Nov 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342392; cv=fail; b=MJZg2mIUUhZ6vfpKxRI95oiFBEpgfVV31krsrtN0xKLQsdFIDfAx3iGPREtS9hP7srDqTE9CVvD/FqTVUzJjx4WKqDBGOOzrh5sVzZSggOQ2PLesmtXz01xfjLHYHrfCmevxhHGx5bxOOhq8RTvHhePm40N6EAE6YPIzcRlXPIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342392; c=relaxed/simple;
	bh=1rDvtS1cMVBWSl4dpHDkO0fzN0Rt4zXarSl3Ne3R0QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u07Dqapcvo3Ge8tc+6l1w+6GPLOJa9/QFv80DKxGYCQJGpk7ZIydcfdrM40H12w7NlgJcvvWhopIRYslyAxq+0cFb9Ok1y2t7rNFXUiXD9ag0c0+V8j54oI9flWCrLtr8S9SgaRtzhmqE9oTfdC23ZmtdKiC4D23+F34TPdLAmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I7kv0SEB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I7p97uKk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABG5u4u030184;
	Mon, 11 Nov 2024 16:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dlxhKhnBEwO6WtztJv
	4uAgHO6iuea+5RkTLoq1HIBVI=; b=I7kv0SEBht1d/Jz2xUvYxGyKmAOUzqLfBv
	GGUiPVgho8qv5mjNU16iBUTqWPBslXzVwFLOleE9gB1rgt1iQnPqKjKboqGQWoYx
	lw2inXiLN/bp47MwQeQxyHlDiyTPOl3IV5+JKUz7m6W03gT23ecI6ry1PRkA5TJG
	MqQqyxfCUK0PmKSiTalsGc4idK+TUTbuND0+r1MgcL6VmDKC4smCcr1pM7/O6tLQ
	zPtMvGMKk8rhXOv/lOWr4dqKoqm6H5AKBiygw/E3zrmLfOivVFuswvEHcxnJKKDH
	2jYLIuSzhtHyD4+dQ0GZOscmLqWaRERcKelN8urPNhEGbDRId0UA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbtwer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 16:26:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABEmdhZ021547;
	Mon, 11 Nov 2024 16:26:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx66yf46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 16:26:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wym0zFrtv+RradKax2FGptVwPFNisDFEvtExWnFPfTYRUbcUnOAZMRSLt0X3KD7dnqEq4UTkKg5lG1yT2oMwgtzRM6/B43SxqSXxbbcJku2h3qk7i6yMuIj21be5SRqfXzRLs+DIuFvrmJNQc7s/wP2+RfuO5GuSQRXMdkwNaEbL/pPZlR12PCO52ihZ2lb/M/dllVRK0yN715mjsQuUudZElM3ZM29vl90ZZ61veBL5ddrkjZ5EJG0U2Xpw8UeOVK9y0eY6Qf1OOuXxQT2JUF1IsZyjj1PZnVC0vnh0XEtMVr9egf5GH6f0xvcU6jE3P3Xc7Y631d+SqcaCPGOG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlxhKhnBEwO6WtztJv4uAgHO6iuea+5RkTLoq1HIBVI=;
 b=ohvebVCMPMA7zu/72NgtR+4rfjxQvDgmwwKNO+r+gKk+22fAqNrOv+HORDLP7GTAHGARTc1IwtuM3h7wkVbY8dXrVPgj5cjCsNDRVjkuXNxUAs3fBP3UICk7Scc/0Yr1uwEtxzTnwlCXwOVa2evBxkO8q1PuKMtyRDKsDOjizSbZTQD4NN3HpS66lr1tMO6B6mlDfuWaM4vBK7RZ5Xj06AR2tXtmIbBZo59s1r4qd+ZTWWD/pWpvBxHeJRcK4rgqkpvoRlD9zrpdJceNDmVtSbwSXAK48UYqArt8cKVQNBSIYCOOSJIybdVyigW1Q1+QbUpQbYLmWqXBmhvfJxKE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlxhKhnBEwO6WtztJv4uAgHO6iuea+5RkTLoq1HIBVI=;
 b=I7p97uKkANM0X+6/DJJZwcU4MJ1hOcvfc18x2gEiYWLGoMssMxr+vPu5X9woIPa5s/mpA1e896PBQ1cPbke7GS5lhDpCdPh32J3PomNd+YI6e7bLHDWy8GpwZ81//TgUf2kgYPSjT7Oj1wSYdCFGmUepmBJ0uy7DCZSVSn7NUF4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4165.namprd10.prod.outlook.com (2603:10b6:610:a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 16:26:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 16:26:16 +0000
Date: Mon, 11 Nov 2024 11:26:13 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: drop inode parameter from
 nfsd4_change_attribute()
Message-ID: <ZzIwJXZvLpwt+ENh@tissot.1015granger.net>
References: <20241111-master-v2-1-e0a52a156a03@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-master-v2-1-e0a52a156a03@kernel.org>
X-ClientProxiedBy: CH0P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: d033873f-2e46-4bb7-042b-08dd026d90b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QNyoyuIcnvBIDrbYm44Waun9UcYVYa0+QLAv82uarGZZmtmD3O3hDjQVgFmh?=
 =?us-ascii?Q?BStGqwS9600GQUTu0d6NkNtnz+BvbR3fbUwyfndtvjLvKfLFWOXEp7xbEfAX?=
 =?us-ascii?Q?r+N4yIaqt0oeQQM9fl7A55jRYGSHnbIO6cm5WYygI0PXbqFBmMHGBL6pKjV1?=
 =?us-ascii?Q?4MjfEnKSfmyOv1ilsxzlgxWnxoOwAo1dhX7cKHnYuSOKa6ifR1OCZoYfwGrj?=
 =?us-ascii?Q?pLcuJYzCYG4Zo2NZvNZt03fMcQMa4gPtBNmdTWO3qIBSzvsouiYuJWq+qLQN?=
 =?us-ascii?Q?3Dkg9Smb6EPllbjh1qUE5QpJh75muC0I64pk2Gdcm9jwh8ptTqiaJxvrZd5S?=
 =?us-ascii?Q?uneFMyloTOSQ3dne5cju/pQt6GC5jbHmRUfhLeqSpXZtr/pAH6by+eCOOKIh?=
 =?us-ascii?Q?elu8BQV1M3+QOg+JB+yLRLHN39AQ+6bCwFUkMwcPE3UahWvhlMYXNwrvUHFh?=
 =?us-ascii?Q?jCeXUVD1lF6JI8djdlKBuqsU8XPIr46Lt44n3OPzONkMqBhCgpXCHip4Lb/7?=
 =?us-ascii?Q?CHQcWyjk/W9xwt0yvF4bno/EVbkF9/05vAuLVHq7WOeW8yk7fTwUPkkGoHm9?=
 =?us-ascii?Q?YbtXgCpbqht4spx6+tkGKqxpN5VIynWEs+e8SJ7PIC+9cqomD9m3bhCNzF4D?=
 =?us-ascii?Q?EBEgTJ+4Mu/fjqiOHahk33DM7yvjqymd8EUzJmvUoP299OK9V0wWLGiMt3ao?=
 =?us-ascii?Q?1B720BJfcFKg6xkSyVaD+wjrflfV1zwIznlJIZZ9ybXAxfqZlYCOdm/o+18f?=
 =?us-ascii?Q?/RSNg8gX50l7F71qUp4imZkBFj2X+VHS/IOgbuHvVwRqom1mOIQruYkMZja5?=
 =?us-ascii?Q?/UmYKEwzIgNsOJ5U2ZM7gmh+6/iVStfqnVSmgo4kDaZNzVosWQG3F95yagAU?=
 =?us-ascii?Q?TDspilwJMStngOkGJO/hkjYEkyqSYAZOWALffP6En++8Ai0YGnjh0xg6bSsj?=
 =?us-ascii?Q?++US0tBsYoP1qK3QLYa5eyRz6Xrp47MFeFC5/EUBIX19Th6SbPSQXfwkBq8+?=
 =?us-ascii?Q?QAUir8peQkEzKW+AMvqvDa8erU4HgezX5K2rAR8rn1ddrfZaUsUQgNr7K7JG?=
 =?us-ascii?Q?HVvgOefjzyJBTiGTQbTfSJ5tCJa09QHzuRMMLbaH/5ELQ6iYdvA28rkfKqET?=
 =?us-ascii?Q?QL4SBo74VRjZZzuxTxWhTIjrNLlUMAEw51tnWJXW7y0+ttQpYO1QhYjcNQYp?=
 =?us-ascii?Q?/lfL0OD5VOOL6rnd2vjAQaNYJskQEyQzuX6oKHMe3pjke6dQzfpI/LqAlv9M?=
 =?us-ascii?Q?ojUd55InHCA0iwDnMPzPoMo/biZ13Zrpo7FIpjIzv89BFmDb6ti2L9d6cVcK?=
 =?us-ascii?Q?q6s3BSR3Pt07MF5ShLRwWnzr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSsuE27Mj7UHjeujOqTnHQmJqz6MWmV73bZn3TOYFh+F1DTs5oWv0S1NJUWG?=
 =?us-ascii?Q?Sccbw/sCsV1ejZ9U44wOD8cwmPcqPiU7I5AJ7aVxIgeFhFw7PBC1+KTa34lx?=
 =?us-ascii?Q?tt3R5rHC4IIm9zEG/fs6WvoJPAKVzIferAMEWJfEIt01OMu+gEgZxLAnaauF?=
 =?us-ascii?Q?x9HmBEY9d+b2UCEZ2ICoivT3WkT0JfRs0hrdKG20jDC3DpeA+W2PE0du7FV/?=
 =?us-ascii?Q?UGHtgiGCtyN/l6RAZdcHa13Lks+bVmyKWjrZ7LQvozw5zZqu7UMfQBnVoZeg?=
 =?us-ascii?Q?8UCGdXAUm7hyYr9zT9nGTJDhWh4+nIZjZNOf5EKEwaEV+9tqsD4FmpDRX46O?=
 =?us-ascii?Q?WPDx7LIqLSzpoVFn9vz7Q2EPrYdqozsQlpYVggOCaZgZ5V/uR/5OlFLvFQ+P?=
 =?us-ascii?Q?i0yL1FPBiQ8L1Z4vygTkWS+DS5fSSBl9uFop4nhCzhvcWyqsotg4eEsyfEtD?=
 =?us-ascii?Q?0CWDVZRgeYYS96zlQijGlDk/ZhrrjHlofDxfODtHr0/YhBCEGzhekpga3jPS?=
 =?us-ascii?Q?R37yLZTH1asW7xxfcisFPQT0Hs0bMIla/Ido/XRP3GVYE8Ev2GM+D0wug33u?=
 =?us-ascii?Q?bPq11Krn9xYwOEAY4wpme5mqGNqP57Al6DOfR/x8Fl3qvE7GpaKcn7FgUvpn?=
 =?us-ascii?Q?6RX7rkV2md5GwFBTXknnQQRTRZnNxQJ5qXo3H1VrGUZVZSfRW2K0kf/spXlH?=
 =?us-ascii?Q?INHEjhGpGFJPFG9lEfkMl/P2KZWM4UtN7zpKRA+Ja1EwooUqcST/HSNro6if?=
 =?us-ascii?Q?aXBJpGTaMF91KqchUz0fxGslQxVn9NGFBNFkYv+mikprdcWrMq1iW2JQRcHD?=
 =?us-ascii?Q?9ygXrnn7Y6DZSyoTzM3BNRop6fdI61dkdjVeoK/Gi3v/DxMi+pn7IREdMW92?=
 =?us-ascii?Q?LIqmIgiPwwCA06OyJ9GtB5BcbqQsEuTyVybcxPSRqYbznoLnz44SQT7gKj1o?=
 =?us-ascii?Q?d3HaGsimmzkySptEqolg3XoEtHUSaS0lnGjEvTcldoZ5MXJUcUtqv+LW0s51?=
 =?us-ascii?Q?rzb0z1urXpW01xbNNAImqtKeLEl6Qx3rouliUo/VPqcAo8i+XP6Am3k21XwI?=
 =?us-ascii?Q?PXLEUv2/tO73st+rcpNCpApKkjFUbMLLKNUhKsOpELvqoJS6iEY+bc3D6KW6?=
 =?us-ascii?Q?g35kCIzTMhyyVRcxId3t6Voog6HaLhXY2DOVr+iWqowIJIDlW8LpIJYbenJm?=
 =?us-ascii?Q?nOmvVcpFa9n0S+M6WNGLPbyaoODcraU/vxwNyuIxsOIzEBPd4yndEh4KCOB0?=
 =?us-ascii?Q?yZxxeB3uJ2j7dfIHwkxGe3LBaMUiMs4Dc2hyb2EzZpO/p8H0ATaOB+IPlFjT?=
 =?us-ascii?Q?HEYtyjG0OWq3vaXqJCMRbPGlCj78SqU6alBg0jQ55WLBVRyJSJrNxyR+izd3?=
 =?us-ascii?Q?hmvKcwRjO8VVNsOZsvL/BM1RmC7/KpylP4J0tyi9NmL2jsyDmlutkcI/uZqE?=
 =?us-ascii?Q?tmYTb/b7S5eBpobAlNxDyXCK/De/0nzfFV4f1GbsTMiXgG62+EhTuVjb2GU0?=
 =?us-ascii?Q?Nhiq9ZiPvN1wYR11qxo1+81rAbFgQqeT7YeON3ZgPpOiLrk2ANQ9qLPH3ykm?=
 =?us-ascii?Q?vKgbfoebmEwhihZN2xx6YA9PH9p10aGxIX+zifXR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qru6Jntk4k9Jy3LbPh41fKKZGQ8iKA9CV9P7ImSqHlfakW8KkrocF7SqzItTm81bkbbkLW4Ao+MZReGZFQS9erpl/XFpvbg12hleHMOtwU0aB0lIhH8iEnwYLSzJkPqkFmBj3A5IVKksp5T/gtzM/fAX0+arWAZyUqIJD3WLFjYNCDEriSRhnWSp8S0Rrm9NM506FcIQ+ykcHlwAjjEU/QYyjTHWkdLEGFDTGYMEQyICHbmQ1y1aT/Pg0J2KROHQqNzPb4n8i+E9EsMxun6ysnax5d6UHNmrFqzA3Cq+QgPQhBIJbLlL62TDL3VbZhYSTfq1fbFqhPxNfwEaK/OzXCznZ2Cvrt01xkrcWiZDRZPugtwLl+2tb1Z/aTBOr71FUUePXZymTWVl8KoWah03IUp2x1OJ9DN7loJ/Nswt017Gup6635KFp9DFq7NvA0LKDcZd+XZfEiCs0fqAgVrtWCUcGGTHLarnKN/Yc3Iuu1Qr3zH90ZopYADoXSBNNuEVL5U7zrm6aVLStcRWGGLsY5/Wr7L8PZc0ooLZKl189e9NakuZ3QB1uZtf7gfxTdQJcX5x43u2VUpGb7zyFbEKddNT50BJuDO4AYQ8GrWqtZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d033873f-2e46-4bb7-042b-08dd026d90b0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 16:26:16.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1y71Uicn72ac2VQCOHBhqgKeMpWn7bd2UpP/S+uJMclREvFxaBzozGruHkLi4shkTkifjsbUEUGdsL43Z4VMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110134
X-Proofpoint-GUID: ekL572GTPx55bjsvgh4BFSwww4_WKwHz
X-Proofpoint-ORIG-GUID: ekL572GTPx55bjsvgh4BFSwww4_WKwHz

On Mon, Nov 11, 2024 at 11:01:13AM -0500, Jeff Layton wrote:
> The inode that nfs4_open_delegation() passes to this function is
> wrong, which throws off the result. The inode will end up getting a
> directory-style change attr instead of a regular-file-style one.
> 
> Fix up nfs4_delegation_stat() to fetch STATX_MODE, and then drop the
> inode parameter from nfsd4_change_attribute(), since it's no longer
> needed.
> 
> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This version should apply cleanly to v6.12-rc7. Some later patches in
> nfsd-next might need to be twiddled as a result, but it should be simple
> to fix. Also, I fixed up the Fixes: to point to the right commit. This
> dates back a bit further than I had originally thought.

Ah. The Fixes: change makes this interesting. If we're not
addressing a fix that is limited to in 12-rc, then I lean more
towards getting this in via a normal merge window.

Also, it's pretty late in the -rc window to take fixes that are more
than a few lines. I would like to see changes like this get some
time in linux-next etc etc (which it has already done for v6.13, but
would be difficult to guarantee for v6.12-rc at this point).

So then that changes my concern about this to only reducing the
number of pre-requisite patches that will need to be backported to
cleanly apply this fix to LTS kernels.

So about this:

 - Apply this version of the patch to nfsd-next, but earlier in the
   series

 - Fix up the later patches, as you mentioned above

 - Then let automation grab it for LTS 6.11 and 6.12

Does that sound over-caffeinated, or would you be OK if I reordered
nfsd-next as described here?


> ---
>  fs/nfsd/nfs4state.c |  5 ++---
>  fs/nfsd/nfs4xdr.c   |  2 +-
>  fs/nfsd/nfsfh.c     | 20 ++++++++++++--------
>  fs/nfsd/nfsfh.h     |  3 +--
>  4 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 551d2958ec2905be51b4a96414a15a5e4f87f9ea..d3cfc6471539932fadc01a95a1fe0948f2935666 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5957,7 +5957,7 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>  	path.dentry = file_dentry(nf->nf_file);
>  
>  	rc = vfs_getattr(&path, stat,
> -			 (STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> +			 (STATX_MODE | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
>  			 AT_STATX_SYNC_AS_STAT);
>  
>  	nfsd_file_put(nf);
> @@ -6041,8 +6041,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		}
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
>  		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> -		dp->dl_cb_fattr.ncf_initial_cinfo =
> -			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
> +		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
>  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>  	} else {
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index f118921250c3163ea45b77a53dc57ef364eec32b..8d25aef51ad150625540e1b8baba8baf9d64b788 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3040,7 +3040,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
>  		return nfs_ok;
>  	}
>  
> -	c = nfsd4_change_attribute(&args->stat, d_inode(args->dentry));
> +	c = nfsd4_change_attribute(&args->stat);
>  	return nfsd4_encode_changeid4(xdr, c);
>  }
>  
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 40ad58a6a0361e48a48262a2c61abbcfd908a3bb..96e19c50a5d7ee8cd610bec4ecaec617286deea3 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -667,20 +667,18 @@ fh_update(struct svc_fh *fhp)
>  __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
>  {
>  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> -	struct inode *inode;
>  	struct kstat stat;
>  	__be32 err;
>  
>  	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
>  		return nfs_ok;
>  
> -	inode = d_inode(fhp->fh_dentry);
>  	err = fh_getattr(fhp, &stat);
>  	if (err)
>  		return err;
>  
>  	if (v4)
> -		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
> +		fhp->fh_pre_change = nfsd4_change_attribute(&stat);
>  
>  	fhp->fh_pre_mtime = stat.mtime;
>  	fhp->fh_pre_ctime = stat.ctime;
> @@ -697,7 +695,6 @@ __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
>  __be32 fh_fill_post_attrs(struct svc_fh *fhp)
>  {
>  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> -	struct inode *inode = d_inode(fhp->fh_dentry);
>  	__be32 err;
>  
>  	if (fhp->fh_no_wcc)
> @@ -713,7 +710,7 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
>  	fhp->fh_post_saved = true;
>  	if (v4)
>  		fhp->fh_post_change =
> -			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> +			nfsd4_change_attribute(&fhp->fh_post_attr);
>  	return nfs_ok;
>  }
>  
> @@ -804,7 +801,14 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
>  	return FSIDSOURCE_DEV;
>  }
>  
> -/*
> +/**
> + * nfsd4_change_attribute - Generate an NFSv4 change_attribute value
> + * @stat: inode attributes
> + *
> + * Caller must fill in @stat before calling, typically by invoking
> + * vfs_getattr() with STATX_MODE, STATX_CTIME, and STATX_CHANGE_COOKIE.
> + * Returns an unsigned 64-bit changeid4 value (RFC 8881 Section 3.2).
> + *
>   * We could use i_version alone as the change attribute.  However, i_version
>   * can go backwards on a regular file after an unclean shutdown.  On its own
>   * that doesn't necessarily cause a problem, but if i_version goes backwards
> @@ -821,13 +825,13 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
>   * assume that the new change attr is always logged to stable storage in some
>   * fashion before the results can be seen.
>   */
> -u64 nfsd4_change_attribute(const struct kstat *stat, const struct inode *inode)
> +u64 nfsd4_change_attribute(const struct kstat *stat)
>  {
>  	u64 chattr;
>  
>  	if (stat->result_mask & STATX_CHANGE_COOKIE) {
>  		chattr = stat->change_cookie;
> -		if (S_ISREG(inode->i_mode) &&
> +		if (S_ISREG(stat->mode) &&
>  		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
>  			chattr += (u64)stat->ctime.tv_sec << 30;
>  			chattr += stat->ctime.tv_nsec;
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 5b7394801dc4270dbd5236f3e2f2237130c73dad..876152a91f122f83fb94ffdfb0eedf8fca56a20c 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -297,8 +297,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
>  	fhp->fh_pre_saved = false;
>  }
>  
> -u64 nfsd4_change_attribute(const struct kstat *stat,
> -			   const struct inode *inode);
> +u64 nfsd4_change_attribute(const struct kstat *stat);
>  __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
>  __be32 fh_fill_post_attrs(struct svc_fh *fhp);
>  __be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);
> 
> ---
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> change-id: 20241111-master-cb9afaab4ca0
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

