Return-Path: <linux-nfs+bounces-5098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8693E0BE
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 21:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545DE1F217FD
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 19:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9227462;
	Sat, 27 Jul 2024 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ifwIb2N6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="geCevvIs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D1187848
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110040; cv=fail; b=k8qssP4QZIgE47qroLALh0tXKjc2O1xkD1+0McV9g5QUkoT5Dn35ajhthf5MnunpFQ+aulPT8385Rcf/3VyU48gocsLgcycd6WE2ZsuP4syJx3h1ypgadthdmx1yEO4n1b+QtCV12fTaD8RABlYunGGmww+lOBxl6hqtrmBJCtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110040; c=relaxed/simple;
	bh=H/oU6o17WQtoLGGj8yoCLYnXekrmybOb60jBuFNfvN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CsH1LjuvvTX75mjGlVa+PL/t+zXNqbA70UhrfIsLQVn2d3Ob1+7vhc3mG9Sum/qhYP+mCyx+NKWSojEYNzoMeJ8c1d/nIJGSzCOEnlTZWJLPSpVeKf1Z0O9bLDp35q6Vh+ZBmbNDJOOm9c7LdNvUJK34uTkPeH6dfqTA1ka1nXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ifwIb2N6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=geCevvIs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46RJobEK018942;
	Sat, 27 Jul 2024 19:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=HUz4EuBNGWUR0L0
	OboXfXmqXWg660Yv4QTtgugvWJ48=; b=ifwIb2N6gaLc+UzLakaGWqFL1HksNUD
	RectQBhVKZVy2SmsbkVffW8LMNullNg5Cu2weK4b/+0HwUmbfwZskRzMeInBFeO2
	HJh5Uy2lRKrTyIzzgp+xMMPHCS3OrTMmtmFD5W4e1Ebi/jEe32Ut1PB43bVg5mqe
	d8Jo4nGaMBBtIRfv/dkIwQDv0yDT1NgDcgD7rNrQbkyTAt1oCT6O28NOcI/bO+XQ
	hpx1YD/poFSGXlZRtAK/+p9Q9n1nYR4nucgtLqTWV3ef/9PmIxQUmnzKYwNRD7a6
	Dmw90RwYuGXb3lz0cZL16nZyUbW7jH9AzMtVPCfTSb/gGDrhCgBGZsA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgs0j1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 19:53:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RH23Va008994;
	Sat, 27 Jul 2024 19:53:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb5pvdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 19:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaMVZJqHfN40HQb3GJrsV8JAG23/1xLuLqUegpeG1hJNkqgqtZnUyl4byuol/1d53Ik0/1Z7he+VR9WuQFClbqQ+FkjL1CnqaHIJELy8PW7m+x+DefI4iAP/KIzApo1Yr/DDTXYF3TGi/STo+XlAWqPqeho79BSpj7g9hC8X1+oE1tRScLCvt82u1L6gG+NChfm7huCFeM9N1SdtwvSQU606d5fEKCt3MaK59xo3u7dF21eVuUYagReipsxC7vtTRw4iKJ43z0D5Moi3wICKwQFDj58Z7oKU1KF89fxqn6cS3Nk3bt8D02s4IGEzrp5MXzIDo0yoqxqRNCP3ZrmqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUz4EuBNGWUR0L0OboXfXmqXWg660Yv4QTtgugvWJ48=;
 b=BaM5eOTgZWHKiJdGMlkaFGxZ4Qex1JHjpL98RXmNQG5RzxH+jiyzwbtPi/R5zCyYyOb6l4BpMCYOzgdmKc4SS7l90G+eElq4jt6xpE5WFyYj98j9yLPoyDd2Aw12wGGpXPQ4/buQs4OZf9Q1BbM+vfVFZBGvX/XrChB9U4Zx547uHUBkAN+WC+UuqHDHwR9jE0isXZbVsGvhhCP092FXK3UADljpFVdALmU8N1EH1aNznQUEZP5CYBP/aBGf7f8wjDzGXxF0+Cy2rCIqEZv0vQBJbHJsztgsuroO6pw6zc7PIIk/YuOO6xpWg9ZdnaTMNr9VFqRkOIBMZvhC7utprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUz4EuBNGWUR0L0OboXfXmqXWg660Yv4QTtgugvWJ48=;
 b=geCevvIsVpjdAXq91rulS1013r49kZcDqxOihtDzMB2Dtsi/OqQV2Xz5u0nJ9D+c5syJ0RXeq7Iy+LeVuWWmGwx1JxbIZWUOW1G83FNkKFIEHQ3FWCeEVyjD4kwFDTLiWsbYK34zYb/pF4T932+PW5T8AJQUXyIsZKilM/H/F+w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4577.namprd10.prod.outlook.com (2603:10b6:303:97::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Sat, 27 Jul
 2024 19:53:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.025; Sat, 27 Jul 2024
 19:53:44 +0000
Date: Sat, 27 Jul 2024 15:53:41 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
Message-ID: <ZqVQRVgblq4TfF9a@tissot.1015granger.net>
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <ZqOtYYV2rQ7ROqXs@tissot.1015granger.net>
 <a9705537-e9ec-47e6-8a96-b783868d96e9@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9705537-e9ec-47e6-8a96-b783868d96e9@grimberg.me>
X-ClientProxiedBy: CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: c919a40c-b065-4a8c-d247-08dcae75d23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqFCOiXA9GXzFsVMV5gYQD+CXvrOiGjdUQiHL0ehORyv7fzXBT44sjW/v8DM?=
 =?us-ascii?Q?upRLSohJRLe9wrSLohhLUcIr+Tp3ucyKjqM5t0lsSijJFTuNlsMheGbmrQGK?=
 =?us-ascii?Q?FuZ6kauvRgsYKYjxo/+GEhiOMWjLTgl22awnLh7tAF4a85wP/CN/PsXRe/hA?=
 =?us-ascii?Q?9i7AxNkgFOYkkZ+DbHw0qBAfAUDqwz2/vuf0ZkVGQY6y2ZgQPHxYUT5k2FdB?=
 =?us-ascii?Q?i0I1KWzN80Gn8LKmXhHl3xNVBMVduwMzDaInwYrwi0wHBGxlFInoRGaw9U04?=
 =?us-ascii?Q?YRezTYj9IwfoSXdSOKtWNGm14zD1WQgYsA84rXl+uuwQvU17FvWZIrFJiwEd?=
 =?us-ascii?Q?SKoGr7fmL0uBJyqaGwF1kvVEqi8nD7qH+2lPz0ijR0hT3cGdwUEEfbQqByQP?=
 =?us-ascii?Q?EjFwDrL3xXzp0XgSM4ZDWq+wkQvx3oyIylKJ2gZSeh80b4nmxqsVzuVCa9vo?=
 =?us-ascii?Q?Tgye9beiL2KFmAhsv5UfqQg51tGvUjcsuddjabcqQ8GFXvG41vczPJQpy3K+?=
 =?us-ascii?Q?ECY4CxXjP5hiNM8a/2YmP7n6rOOL4vXTfk6I8t3bNB55JGP0776FgDz+xnjg?=
 =?us-ascii?Q?r5/Mhj5mu/C1ErQ+glI1agaLeXfeyOUumX3kt+7q2IzoDYUGhi3a1tAnrRgC?=
 =?us-ascii?Q?9ZDjFOUstTlT+zYXU1Qgg2FIjs1Ll8uVN0gBAcMZoKyF9QOjY0BfJOhzXKNm?=
 =?us-ascii?Q?DtNPhzy391qrh4DlAnpWVsBZmEnVdymP/bWNs1aZjTPFu1ASqSlPg9Jfns++?=
 =?us-ascii?Q?jhdKLNgc5Iq/yhrAQ8Rli4E/VYBLbwg4TnbWP4vhUmlpKUzJRGF+QzHRYaNq?=
 =?us-ascii?Q?Ceq3ucYOLx1Vf34T5AkY3+0+PzX+cIB1s0QhAe+VoD/QEUJOHWENkyjYxm/6?=
 =?us-ascii?Q?PDQQmziX2HMma++2gU7CxJiXuSgZB+Tu3RcDvd4sgmKn6/tHul2cfzdYSiPV?=
 =?us-ascii?Q?lNPah84zlIsuhnlqjaW9RXoqeXwIw6gTbQ4ANdrYdx1rTrtSFo90caK5+wAA?=
 =?us-ascii?Q?6nd/xX/1/pkckBzt8j9trBq4KmG5qzyCGQcHDv4wnEC6EBbONm0HQ99HvQe1?=
 =?us-ascii?Q?EXlPFhVqPUAXlC3Q+wWW1FxXu946M2MHG5U5l5ZFeO8JQ/dZRbWJbcPoe9Io?=
 =?us-ascii?Q?pb+F5xgaEyORNIksxl/li1syUaA6jozwo1aASjI5SK4MMgfymXNmU9MIss1q?=
 =?us-ascii?Q?581G0AJQ1p8z2XLRc/NM3/6IbjMgm1+hgw03AVUXfxiFPqhA7AZGHI0vsl1X?=
 =?us-ascii?Q?cvNz2RfWbpeCdGnqKS0BRvo1LXhpxIn6rN4YuhHrXFipFjuTNVnX/AEu7tCD?=
 =?us-ascii?Q?ZmznBrYE8u6+kVFrdg9Wmpt63DbEPpTQ1m8DcS7IhYrHzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/KJTBYvp7saVzOveQo9EF7SBOEK5vzohlEPFclw8JjqXFkPz7ZToPpvRRgz?=
 =?us-ascii?Q?h7lUkzqnnA5uEDqY49gwnxwnR3CaYU3SDTGO4KN9AANfMGmfUbdb3E0Qg1TJ?=
 =?us-ascii?Q?xlolscBERZwhushkv1iy/MzW9ULAkb7dy4HaZfuOaRO3ZXVLZojIA4v42fc6?=
 =?us-ascii?Q?eCeji5E2tekiuQI2rRqvLbU+x7cemoG1do92UJ14Uq1u9mtQ8C8k3UB2biWG?=
 =?us-ascii?Q?OT8UKoBc6pLJTw3dY0E326GadNO062F6wKotXW74E5GyR8bt0JUqte2FJiSL?=
 =?us-ascii?Q?qHhWUJ1wMemV4mCcpTdwpnb5JY+c6/kUZfS/6wcXR8kOnOP/UARusvkZGsKX?=
 =?us-ascii?Q?dZoXT0LvUSbtrN/7N72EqBGEeN47nd2GnGFnu98moGf8A/6cCgSylimEqv4/?=
 =?us-ascii?Q?pxssZQJ149VG0wdmvhlCwu4pAXHd5UaANcngJLZM7l0cJMl+adkDGT9jirVE?=
 =?us-ascii?Q?ss52FW9rE+K0PPgbeJ7Cv8rEjdhwZVICPJR377+1/tCpbDe6CHJ9EFL/1b4+?=
 =?us-ascii?Q?35bNKROapyLUeqtqljdM2Wqcwlooq6oZODCMz8PwDYt+7M74ArJOO8txAmY8?=
 =?us-ascii?Q?Ie6nXhWKBN2UtqpHwGTcqsAo/IXoilOuq6v0D4FTwWWbbiO8uEAqgbvthiRu?=
 =?us-ascii?Q?0lXyP23KPClaSfB6ikm4oY+usnys3pOfF5DqXSRZYdXZzYLtGgE3vnrfvBpG?=
 =?us-ascii?Q?oWs2OjEKEnlV5/f5m9Pkmlly+Xzj1/FlC1F35KLEnGt8wIWpZ/oMiyBdnyIq?=
 =?us-ascii?Q?gVOYsRU8NI1muQgev2BurBvCTqURbMcjEEA7iE8+Kujeim7QxdI3x/Df2AZr?=
 =?us-ascii?Q?+7P21hhndr4ebpsmMkc55AdR6fpMosl4Es2inALQch5Xf0FYM3u5A+aGL0en?=
 =?us-ascii?Q?tlk9Cc/J7xWhNngZJQkJkVNyW0Oo31or5TP15EiBJ60qZ3UYKeQguoJ/KB+K?=
 =?us-ascii?Q?idVIWY4UWgSaIewODBnMHr6dP2T6hQAOFxYRFQBJCtk8CdIxdDgoIXaU+nda?=
 =?us-ascii?Q?XsmNBwNw37eLaDU4U13n1QpPbUER4nu1UO9keyrhOoF6UAQaoZYGY7mRskxD?=
 =?us-ascii?Q?2QntedF+HOCI1lrrMx5g5D0a6jto8X66++M90TiZ4fVJgftO6UQe8w52nBXZ?=
 =?us-ascii?Q?27aenkJvCmFn7n58pPwGZpTy8XwPe3b7N/C+axXo8QbOZJ0l46Hqtu5PT9Nv?=
 =?us-ascii?Q?/d0co3s2DNYavetFzn3qwoa+Uiuki24CSsub27iTwU0slQ3aK8Vf9ngKgdqX?=
 =?us-ascii?Q?D2BcAlzwc7ccHLPaRAffGAhB+JdZC3jGWDt6uhdvA13eBSLCWDlh0W/C1Mtc?=
 =?us-ascii?Q?FaNZ9Oi6EQ2my5nqzqPCDqz9qUukZBX5g+tgLVWPFtvajhZAp+TBpRLh9t7b?=
 =?us-ascii?Q?p8FevgGldodjDZN0lWnndNxfMr4UPR1YN28Fq8VCMBlOaCcpRDnL1nCESRMk?=
 =?us-ascii?Q?0Xa/3mU2Q/cynnIAEKCudnDEc/7nOZ7sNtH3+XKOMmeOuQbo8PL6JxvEf5Z5?=
 =?us-ascii?Q?JEQWMKvUZsZ3IyGewFkmkepmXMiiV5b9HMhee+npxWjuvHv1R0MZ0D7CG0CH?=
 =?us-ascii?Q?8QGHcKKHBQjfweMu4fPCj0tuHFIGDvFwGeYSbTME?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ndFQ7GImyx0rUE4QjXkdLe09IFrKbQuYNvHUyJsL8kaW2/fBNGPpBBlGj6ZI2Qf17vx2GOxyBSUqtutyuvF6isMukuGpArTXN2UrkPRagfjzPlMrvnRwqF4aVHyweOlihP2cGXy8EM4zNh9/NfD9oOWtVNKPuL35F3IBUu+nrUMvIfi5THXrMH3QmReGqes19Z7KhjUW8DxAsY3O9O4EiAV0w0Ust7QRfMpCWgWLrbPR3GSYRTzAVK8axYKK6I/HzJz+pFGUfNCUkEcHfdB/fHmHFpdQh9hP9LlrDz4g2TspMcMUT0z8oCMUBn9+mLbslTPqB22LGQur7Wk+ZRqrVbBp4cWwTZBBA+vCe+nVQC/5cpPkX7St+w2JDJxBn8ZBd0n6Azh7ViDeq02nWp/ZP48rEuPl5dhS4TrIeX4u6eN/+ZhIsJSsojEamNA6Y/i2mdv0WZur1xJWZXGYpLtoLgKKDn6PnelQtbQ1ekoeu9AlSbOmq+Im468SEIiRb7doHx17Poj5+TFyt0yDX77DBXR16fumhApEadr7ReX6UaeiPyKKMpE7wax5OUDhgxcA13pSxBS7if3W6xTYraK/9qsHerGWd+M1voojAYQpmIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c919a40c-b065-4a8c-d247-08dcae75d23b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 19:53:44.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nF/lpVDWtgJxS8tGeSBQby7cSw9JfERyG9G6Wigz1/44UqPEF4xVnFpR413674ZsDcELdR8PIfN5ikRRAw5JMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_13,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270137
X-Proofpoint-GUID: Hnz0OcTfyHsXXkmmdiYD9WKnNYFmI1nl
X-Proofpoint-ORIG-GUID: Hnz0OcTfyHsXXkmmdiYD9WKnNYFmI1nl

On Sat, Jul 27, 2024 at 10:26:24PM +0300, Sagi Grimberg wrote:
> 
> 
> 
> On 26/07/2024 17:06, Chuck Lever wrote:
> > On Wed, Jul 24, 2024 at 10:01:38AM -0700, Sagi Grimberg wrote:
> > > Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
> > > stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
> > > Stateid and Locking.
> > > 
> > > In addition, for anonymous stateids, check for pending delegations by
> > > the filehandle and client_id, and if a conflict found, recall the delegation
> > > before allowing the read to take place.
> > > 
> > > Suggested-by: Dai Ngo <dai.ngo@oracle.com>
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > ---
> > >   fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
> > >   fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
> > >   fs/nfsd/nfs4xdr.c   |  9 +++++++++
> > >   fs/nfsd/state.h     |  2 ++
> > >   fs/nfsd/xdr4.h      |  2 ++
> > >   5 files changed, 80 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 7b70309ad8fb..324984ec70c6 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >   	/* check stateid */
> > >   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
> > >   					&read->rd_stateid, RD_STATE,
> > > -					&read->rd_nf, NULL);
> > > -
> > > +					&read->rd_nf, &read->rd_wd_stid);
> > > +	/*
> > > +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> > > +	 * delegation stateid used for read. Its refcount is decremented
> > > +	 * by nfsd4_read_release when read is done.
> > > +	 */
> > > +	if (!status) {
> > > +		if (!read->rd_wd_stid) {
> > > +			/* special stateid? */
> > > +			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
> > > +				&cstate->current_fh);
> > > +		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
> > > +			   delegstateid(read->rd_wd_stid)->dl_type !=
> > > +						NFS4_OPEN_DELEGATE_WRITE) {
> > > +			nfs4_put_stid(read->rd_wd_stid);
> > > +			read->rd_wd_stid = NULL;
> > > +		}
> > > +	}
> > >   	read->rd_rqstp = rqstp;
> > >   	read->rd_fhp = &cstate->current_fh;
> > >   	return status;
> > > @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >   static void
> > >   nfsd4_read_release(union nfsd4_op_u *u)
> > >   {
> > > +	if (u->read.rd_wd_stid)
> > > +		nfs4_put_stid(u->read.rd_wd_stid);
> > >   	if (u->read.rd_nf)
> > >   		nfsd_file_put(u->read.rd_nf);
> > >   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index dc61a8adfcd4..7e6b9fb31a4c 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> > >   	get_stateid(cstate, &u->write.wr_stateid);
> > >   }
> > > +/**
> > > + * nfsd4_deleg_read_conflict - Recall if read causes conflict
> > > + * @rqstp: RPC transaction context
> > > + * @clp: nfs client
> > > + * @fhp: nfs file handle
> > > + * @inode: file to be checked for a conflict
> > > + * @modified: return true if file was modified
> > > + * @size: new size of file if modified is true
> > > + *
> > > + * This function is called when there is a conflict between a write
> > > + * delegation and a read that is using a special stateid where the
> > > + * we cannot derive the client stateid exsistence. The server
> > > + * must recall a conflicting delegation before allowing the read
> > > + * to continue.
> > > + *
> > > + * Returns 0 if there is no conflict; otherwise an nfs_stat
> > > + * code is returned.
> > > + */
> > > +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> > > +		struct nfs4_client *clp, struct svc_fh *fhp)
> > > +{
> > > +	struct nfs4_file *fp;
> > > +	__be32 status = 0;
> > > +
> > > +	fp = nfsd4_file_hash_lookup(fhp);
> > > +	if (!fp)
> > > +		return nfs_ok;
> > > +
> > > +	spin_lock(&state_lock);
> > > +	spin_lock(&fp->fi_lock);
> > > +	if (!list_empty(&fp->fi_delegations) &&
> > > +	    !nfs4_delegation_exists(clp, fp)) {
> > > +		/* conflict, recall deleg */
> > > +		status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
> > > +					NFSD_MAY_READ));
> > > +		if (status)
> > > +			goto out;
> > > +		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
> > > +			status = nfserr_jukebox;
> > > +	}
> > > +out:
> > > +	spin_unlock(&fp->fi_lock);
> > > +	spin_unlock(&state_lock);
> > > +	return status;
> > > +}
> > > +
> > > +
> > >   /**
> > >    * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
> > >    * @rqstp: RPC transaction context
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index c7bfd2180e3f..f0fe526fac3c 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >   	unsigned long maxcount;
> > >   	struct file *file;
> > >   	__be32 *p;
> > > +	fmode_t o_fmode = 0;
> > >   	if (nfserr)
> > >   		return nfserr;
> > > @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >   	maxcount = min_t(unsigned long, read->rd_length,
> > >   			 (xdr->buf->buflen - xdr->buf->len));
> > > +	if (read->rd_wd_stid) {
> > > +		/* allow READ using write delegation stateid */
> > > +		o_fmode = file->f_mode;
> > > +		file->f_mode |= FMODE_READ;
> > > +	}
> > nfsd4_encode_read_plus() needs to handle write delegation stateids
> > as well.
> 
> Yes, missed that one.
> 
> > 
> > I'm not too sure about modifying the f_mode on an nfsd_file you
> > just got from a cache of shared nfsd_files.
> 
> If that is a problem, nfsd can open the file with rw access to begin with
> if a write deleg was given?

IMO, it's not a question of whether there is a write delegation, but
rather what intent the client told the server during the OPEN. The
server would need to open the local file for R/W when it gets a
O_WRONLY open. Not saying this is the right thing to do, just
thinking out loud...


> > I think I'd prefer if preprocess_stateid returned an nfsd_file that
> > was already open for read. IIUC that would mean that no changes
> > would be needed here or in nfsd4_encode_read_plus().
> > 
> > Would that be difficult?
> 
> preprocess_stateif to return a nfsd_file? not sure. But Nai correctly
> pointed out
> that the file may have not been opened for read.

My impression is that nfsd_file_acquire(), which underpins
preprocess_stateid, can open a file itself. I believe that is what
happens in the NFSv3 case, for instance.

So if the caller requests an nfsd_file that is open for read and
there isn't already one on hand, wouldn't preprocess_stateid (and
nfsd_file_acquire) just open the file on demand using the given
mode and credentials, and return the new nfsd_file?

For NFSv4, that would mean the subsequent nfsd_file_put() would
close that file immediately rather than cache it. So maybe not
as efficient as we could be.


-- 
Chuck Lever

