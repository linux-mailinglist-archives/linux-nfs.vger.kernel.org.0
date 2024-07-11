Return-Path: <linux-nfs+bounces-4821-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5542D92EBB7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BD51C23303
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED09157A74;
	Thu, 11 Jul 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="liFtmS7D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="duQUrDv5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8812FB1B
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711722; cv=fail; b=HSPX5zkSnNjP7Y8TNiOSGGd9jTdhPm29WDyQXzGTuVrdCIzUZUMdfP3dsJlpYDoBeSFPkW8N6byTNigJ64sLFw0Pe0l58Rjjs01yenxlxbKPaT4ujOex8tKxOn3+ZJMoPvEB+9vH4uM9EVcjQryQJnXv3cV5LI5z8Uc2RTP522k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711722; c=relaxed/simple;
	bh=Mmf/kPZQPwRLESgK30h8uJ1Tp093niRAKpXsbqZZUH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ApAtGjq+EOC1dQj65JLT/68x1nkR3ZPITCk4IMWHZwm8lwM36jW0luXLNpUSwfjxdlR7bpiySdUQZ1bFADeaDU6wxU9LLALE21qn2j6YgOKLDLQ7lzEiS9NzJ8Hf7cP8bRjJNQgBbV+TDFMTVd7bh6Pgk7W9emmpyL7ymjgzr4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=liFtmS7D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=duQUrDv5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBXcr010306;
	Thu, 11 Jul 2024 15:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1HOfaGpWKMNC1mv
	oEy9DgQJosfGm/1NcHtsxBIoRZkE=; b=liFtmS7DJlM/pugtwQN9WmDqwRbTRNO
	2SGeF7aq1nvYCkxaU/2HezVfdbLviEUnhrWbPypO/q1DxfexCm+d2xYS9hmaeI20
	EunealAJstpP9sTAdk6MqHMWAOsmpaYQUP4U6vH7DDwiv5eG+mPASyO0Ob/1vTcx
	O0Tuv1C3oR0SXHFDDywzyk7YSqlwXaaTknplBjSwJ1pHNCC1JFSru7429nfXBmF6
	6SE7l3h1L8Kz6Jv7E0wJVP+fbAuR/8ZNutnqk+vXi7Uq9f4rl/DubCny7PpLaZcO
	2s/asbnZkQ7/wEHWWTBWXT96VJaPdXbNq+fQuLjarlzpy42w9Isj0rw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8htw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:28:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BE9gRT030233;
	Thu, 11 Jul 2024 15:28:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvbe1js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:28:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmC8pA8CNDxqCeh7/x39mOtxat0WHdLci972Ay2BIJeuncJpWg/9SIAhM/cc6AFq8ZyrdFipXpSfHOaCsry8UMC1yU42oa2+wC6XoXTpQkn3OTrEFLBwfTAP/09dR7j46fO7pu/CGc0rhXD+WPPHq1u6DsQvQbfTWhwMkpF+ZpfiNteCGh2jC5PxJ9D0NssqSw8pBPnDdQ7RYzi7Vfya9SL99eshdEZhA9uoIUeqoAVwFMlhJAzveCmUcBrRUQMS+bKJXjG4DmQBtDEiXqyU4YNm2vQd6WdQ0Br25g60YxkwdP3lT3uyodOykllqcwwF1JHNNGw4odyiG6yKJNGdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HOfaGpWKMNC1mvoEy9DgQJosfGm/1NcHtsxBIoRZkE=;
 b=oOrQngQUqt0tLZF7u4e95z5B3Au1ItkS7Z5o1nUr7SchIcDL1Ta49/G28tycqqYwemUyulJudRPuMMb6QL4LfuyrJZuEeifyWUdU5USfK82Z3lWaVwufnEpI0awak8AVdDxgbOnCka8LiIkEDgufGfeR2olRD/inknCgCW9gcPWsK4LaYMyzRDu3SlsPTdfHhfKt8IA/gD3HuR8+sjXXlKZOaDNdn6a2v8UjyuPz+GJILwlElbRF7+by07NGGAr4WtY4MioR19Me65w6H4SfeTYQ7K2I1++HHsRwi6m1bT+ggOsub0Cj1xYG9EKsWes9NG88p/FSEnXIC1iF/UOdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HOfaGpWKMNC1mvoEy9DgQJosfGm/1NcHtsxBIoRZkE=;
 b=duQUrDv5fqZ4iimpWvvCW87rduswD3Ec1PitBrtiM6e5GjIVpKkAZPXLRA9rrdWARkfvIhgwpmyTYlPtSj7qDtCvZDXbSGRkIrRmxhuxA3ASCqlMqsXW6XJAFbw8ny+Sy+BB65jY9pe8TIpyRPZ7OzS+j0Yz/2Tys82o5AlA7Ho=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7185.namprd10.prod.outlook.com (2603:10b6:610:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 15:28:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 15:28:31 +0000
Date: Thu, 11 Jul 2024 11:28:27 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Message-ID: <Zo/6G7ANcWEWkd0l@tissot.1015granger.net>
References: <27526e921037d6217bdfc6a078c53d37ae9effab.1720711381.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27526e921037d6217bdfc6a078c53d37ae9effab.1720711381.git.bcodding@redhat.com>
X-ClientProxiedBy: MN2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc1d85c-79fc-4ef8-a196-08dca1be1ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+COw8vxhV6qRF0nE1wZfNcdWbCmQJQGsk4j+D96kzgE7ZEvix2Uyoft3x9SL?=
 =?us-ascii?Q?drh7ETaVWKMd9FwJjFx9TVRGK5eI8hmjSqsCwtuKaYWihdSM0v2ImDNsl3i2?=
 =?us-ascii?Q?xnbU/RxjpjJD0kf778qj6AYGASgif+N84t5qn0+lrqElBI8bJG7T0+pnxGeG?=
 =?us-ascii?Q?xjEU0mhz6YEQz+yYgzo2+rMhbpGxg5iDgGD75xqYCIUifL/QOO16N3DwPTxg?=
 =?us-ascii?Q?J6jLGPjjnbKKKQNtwMIdGOWHC/WXLfF77Qs0aupjDZxB8+E43/mvczKiNn6s?=
 =?us-ascii?Q?5EtIhBqytEpQpwwBTrmUaI5bNlta/bMzcf4I1mxuufArQMxhx8nGh304eEov?=
 =?us-ascii?Q?jM0PRgBB+YzHDmrpQPJyhk8cZ9GmH6qmod1RHtA6XNceLfdzNorQNQIlKn6g?=
 =?us-ascii?Q?diJK7pVw8nZN8bjtDBnR2alwVVgikSoIfVZl2hGr9K0KvgKZHdYcKusVUL/2?=
 =?us-ascii?Q?hssvkoYv3A5DiEWIlAz1X+WMX4kqVuIdE1lNc5BvI0w5uZ3MiFYMN/oRI5Fp?=
 =?us-ascii?Q?CnF5jUbwB56+yIze2DB2umFORctkweT802keKpMM846PWIXuV5iFa8Z0hBbP?=
 =?us-ascii?Q?Eoq215dGOHoWsIAON+BcN9S2L4pqZJLTCcLi6oK0bcwpkR1Wqff7CMmtZPqn?=
 =?us-ascii?Q?+jMRYul8Lymadlz0wKwXySFwjzWcxGQ3WwnFUwb7l6X0XWUQQDCxVRQ6N7OT?=
 =?us-ascii?Q?FkSUSyWaww9fCFBsGL8QY7lyG1FMcwmUej4lT97AwNZwAYzmkBC+wTRWHMwH?=
 =?us-ascii?Q?QJohukDS9WJ7FsRsahVuTvKhNbmZMmPsdMCk2QzQdl89LVDm2hCERjhtcBVW?=
 =?us-ascii?Q?5ZJ8xi8IOjMpXgTv3VdzUwmWwwQqqU3aHzAmXKgAbXl+KDvrhIH+auU0J35d?=
 =?us-ascii?Q?/U71OBCJ1Pud2kKSdWVzOHYINAXs8GQPS3GNBhDkXImnJbnFaW4rN8jv5LJJ?=
 =?us-ascii?Q?SXstTZ67E1i83tUA6vjGgHrlWqbPTxlYPatbsNj40yGLzu/Da0nTe+S8geWf?=
 =?us-ascii?Q?X6SjaywOyEm2ITxWqmO/SXlF+aBIKR8BruGveA8UJZSwf7JcLcTV9ZA5bOFK?=
 =?us-ascii?Q?3SS3ufJuqxmzhhOmn0uVVEP+kaxVcMnsPZvCSXILxcqYD6h0AuhugJKZw10o?=
 =?us-ascii?Q?7gAo91zf2J+FTalmMhlD+mr4VN8mHiF+6Rwcf0JeEW9Rn2BmcE4j/E9QmG+j?=
 =?us-ascii?Q?hL39So62FHmyOgpK2xOYaxnulieYEMJNmJX6A0430h3lReI0m1BlPVB640RW?=
 =?us-ascii?Q?KOsUw9f3BzmoFqwXXTtRl57z56iRZQD6Pr3PhPgBarE4K5ADj+a3uHjBE1sE?=
 =?us-ascii?Q?p7zYabugW6HSZGGsbXJKiWhy7VLYIQQw71MokwDTM0a3jQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eKUvdemM6tu8tbA2maSr5Dwt7l7HtRhGW9fA1SIfeSmmuLC5XOt9n4akVKp1?=
 =?us-ascii?Q?pNLf9MHiqIsbpcw7rg/hcIRr9KRPT+qCUnggH4AI7MTBMZjI66p1DBnrCRcm?=
 =?us-ascii?Q?0XLZlXDrPbgqxhRA8+Rwse9Nanhb3vFAG2owVgw6AAGTfoEAAZikiaoOstKe?=
 =?us-ascii?Q?RauEoHLC9coLK+MafJw9a31JdwUJkG6bKJ15eo0Hx3PiPXf3eWMudGGdwYnF?=
 =?us-ascii?Q?4vg4UqNyJbnQH5jjS1/sc6RYQAuEuHLWGKHaCKIzHrWCQuyyIiMfJUW7zJGq?=
 =?us-ascii?Q?D7WWRnkKUmnZBvtyFX6N4Fz6qoCiXTIgq0xlh6oapzrWCdYjD0HAKbRAztCP?=
 =?us-ascii?Q?et45HbO27mlM/6wWS0z9d3xPfiVArjh+jqpgj9YJygUyqAIA9/8Nts0VWdb+?=
 =?us-ascii?Q?uMcPK4ew8xOISNBg+luLpPFfCQANcoYjRF/BHAWJIBiWtMT1LPkPGu/RqZ9m?=
 =?us-ascii?Q?6WuR3txnFWvXfZNLBAl+3/Ud5xB0F23PJJwIUvPWQvJr5ECxMShhkG1Wvh+e?=
 =?us-ascii?Q?/uM8pNvEAl85kS7l4LTvkO3iTadA5I/FKtY3ssX9JGTZIibtjZjLbtnYpyV7?=
 =?us-ascii?Q?4cAkw2Pgss+FoTnBSMWJnHrAEcAXlPkL+VT7mxT05K+fWBEuvGU8o46vKXZA?=
 =?us-ascii?Q?PdCO1C+yCcQpM8mj28xCetFE6pCwZ4ZKqQ/n0OGU8Z1nu5ieAJ0JG/08DQS8?=
 =?us-ascii?Q?oaG0xmo2ltwmc2Boafh+NEQ6pJf/dfwF9VbEYXwELojtZz+AoXHHqMqC96bG?=
 =?us-ascii?Q?b0ULmU5j6+4kIlrCy6lVdNzGOTR/AbcYl/tXRAhwMpGJiuRbdZcbYdiQRI0Y?=
 =?us-ascii?Q?97rP4j+GjjRK5Fvyd3VgSs9CBZJELZxYWFBUNXGEz3EcM9r6dLugfx7LAIeo?=
 =?us-ascii?Q?XOQxnbrcejj1T+CfULcK28blS/XVc4Rb83P9IXKOrtXNC4Eo20DJz3FPi6L6?=
 =?us-ascii?Q?/QrO9wPziZhYf6FsPTWXrOHSL7Ik2AuzGkaes2yahgzoV7PkKlO5DS7Mvf4i?=
 =?us-ascii?Q?YDnvKE9X4yTyrYogSMm9NDpYY54qn+dEHnWzPANkQa+X3t95KRI5JPE9g8CO?=
 =?us-ascii?Q?6AwBTTcjmvCKs/qfiTcC2GEzFDy7+9ljGsIBBfZtjpVyE6YTtZFHDitjvVy1?=
 =?us-ascii?Q?l+xXxOEXKN3U1NgpZDdnXsL7yDJk+Iu74OjGzB6Jhs7mnTk1kyIQXdU4k/mO?=
 =?us-ascii?Q?92mXPBVrrpyOxOUIpqb+e5H7o2RuGve+jcLbObHdO8QCUvTyvNwcHC/OVcRN?=
 =?us-ascii?Q?FzvHsfugVPHq/v9BPusOlwZtnGatmWBz2cxLros8MbV87RSsZneg9p/eBrQo?=
 =?us-ascii?Q?cwQyFOJ0K0K457XU+6E4HEjSFiEMhnaQNTCD08wneStXdt5g5PtYS/U05Zof?=
 =?us-ascii?Q?IkSm79+QsllCzaS7AgUJWLzf3roO0dAHrWhvrXbXvRHdF85zxCAKoqo3EC1l?=
 =?us-ascii?Q?abC7ALoDL/chlv5Ium4L3q2nqcdurEJKQA187PPPeavWCEnmJtm9HNzdd4vV?=
 =?us-ascii?Q?isZZ1IPJcMDA3bYDfWuBBGC20MDxLzX45enKF0MeUFWd7B5QKqzoPlCllElC?=
 =?us-ascii?Q?OEQ5OTIAUaOQtyb8G91iVozkwaQnwtAbVX257RWM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Oikj21Yi8hDZGWCtbpwbvkkADzQAcEB2Zi/Ul1UJ12HgREuVdxuQ028ocSgM57LKaTC8L4llW5B6vTZcNBY5mSt+Y3EWib6Bx1V6f7Sq/4wWRyMH4+r6sB8AF7pkMQgXXyGoRqxFeRGqQBMhaGdjR+iJIVrHMLL2U97d9FBKjgz1D22ahPnAoUIm4azlLtj/UNkRoPsH8Jj2AJYDvLEDTVHng1SxFF/WZV/o9EN/5MRY3JAgfggCdLuOZNzzRV900VY/5AgX2qeUpqqxKZPjIUa6X4qrN1iolgTr74i3Ma0DJ+OI8omcwV0LqvlbCsOMwYW9Z66r3Ymh/2MbXuHSmG3CEiw2i7/emNDlVCdTymaBEt4f2lGRdGfm9vuTkWWdvD6Rwp7TViHvQW6m+2y2COuh9IWUcXo12P1R2cKBLilMsKIfrvjz8CeZjfr1a3ntR+50h8r2Cws5uXXjdVo8MlKIz7itafzBfBjJmYUE30AGPnCShAkicrGxwwcTnpsA3apXnfHgMcZYaNj+W9NR/HfWAgV/AtIGp/cpP+8Aa4tDAVi5ukRMPwJ7qK23nZyJoYb52v+BLGYV2v15VkUpNb8HSPraeIkMELtyDjM0qFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc1d85c-79fc-4ef8-a196-08dca1be1ea0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 15:28:31.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bD5XhYnuTC72s/UBX+KTjohPqMYuwFL5Sacl1cFyXnN1U3eR9IADRu22B2d31O8I2gZLt+yEv8KqpT/HLrBvGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=880 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110110
X-Proofpoint-GUID: BfLpY_Rzm6l9KQcKIAgtBXPSFZzrBCkO
X-Proofpoint-ORIG-GUID: BfLpY_Rzm6l9KQcKIAgtBXPSFZzrBCkO

On Thu, Jul 11, 2024 at 11:24:01AM -0400, Benjamin Coddington wrote:
> The GSS routine errors are values, not flags.

My reading of kernel and user space GSS code is that these are
indeed flags and can be combined. The definitions are found in
include/linux/sunrpc/gss_err.h:

To wit:

116 /*                                                                              
117  * Routine errors:                                                              
118  */                                                                             
119 #define GSS_S_BAD_MECH (((OM_uint32) 1ul) << GSS_C_ROUTINE_ERROR_OFFSET)        
120 #define GSS_S_BAD_NAME (((OM_uint32) 2ul) << GSS_C_ROUTINE_ERROR_OFFSET)  

 ....


> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  include/trace/events/rpcgss.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
> index 7f0c1ceae726..b0b6300a0cab 100644
> --- a/include/trace/events/rpcgss.h
> +++ b/include/trace/events/rpcgss.h
> @@ -54,7 +54,7 @@ TRACE_DEFINE_ENUM(GSS_S_UNSEQ_TOKEN);
>  TRACE_DEFINE_ENUM(GSS_S_GAP_TOKEN);
>  
>  #define show_gss_status(x)						\
> -	__print_flags(x, "|",						\
> +	__print_symbolic(x, 						\
>  		{ GSS_S_BAD_MECH, "GSS_S_BAD_MECH" },			\
>  		{ GSS_S_BAD_NAME, "GSS_S_BAD_NAME" },			\
>  		{ GSS_S_BAD_NAMETYPE, "GSS_S_BAD_NAMETYPE" },		\
> -- 
> 2.44.0
> 
> 

-- 
Chuck Lever

