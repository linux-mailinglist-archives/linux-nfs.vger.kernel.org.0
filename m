Return-Path: <linux-nfs+bounces-4775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF8E92D456
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEACC28136D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AC318EFDC;
	Wed, 10 Jul 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mx5z+Ofe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oPq7oGvY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151319346A;
	Wed, 10 Jul 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622175; cv=fail; b=WVWQMjW034qYEhsh/NrAIsP6gXINmjo/LGqb6hu/ZOJ3AI7JSJU/YY15WHxCnPNzrwKMXQ5n8Iq3dhvh0sb1NQ7wNsM607sTaZcJGxfp1511gUirs+T5IoWuKIY3c75Akxit8YMrSnjxpoF4NihuZASjYOwQjqS20F9XHdPx2eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622175; c=relaxed/simple;
	bh=nuPso1CZdH1wWVf+qP1V4vjc5RRYMDSLdUGlZVAu/VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qU9UOfXGBFiF+K11UCCRhdcabIKHFHr4brDI6rd0P+74HY8BnsZEoTV6iWy/9s0LvBvYfV3ICdJ++IQh+YhhenIc9SvvXQait6+6IvgzjyrnA2oj9nYkSXM6z6yBkRV/yYPK7EmkRecXJVZDuWrMi3pbrCkfms7QJhpT8iy2W1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mx5z+Ofe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oPq7oGvY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7faP1013754;
	Wed, 10 Jul 2024 14:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=DRdU0KulBrx/vbC
	wJR5C5NjRBzKwFQL8aD87jJfMy1A=; b=Mx5z+OfeUPsKitX5ldUY95wxH3HMcSF
	QyLcFMKnaR7OdoEiBqhoT9lcVT/9KZuDBq+veHuQ7vu4y8we7AXApEygYIfNohPx
	nGJqxiX5w0DtYLWsSP9xZZ7aTnybun528rZlTcHAH1yNJviHt0oQRb5zPcomYVjF
	pOmfX1kkFI8k8QY6bX5y/bDzHzTRG+o8TEan5sf4iPJC2QJoo8v7x1qMkgoB5tVT
	AiF6uP0G2G+iJ/dKb1XFDNHsSeVxO38xP1N9OjbN0m10XqgbeUeGwyfM2Ce7z3P2
	y6uUVkuWjbRvA9++tdOHe25Kci3U1cF1gZsq4bQ2e4f9hIgaUwqds6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8fb75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 14:35:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46ADbbeD036503;
	Wed, 10 Jul 2024 14:35:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv31puh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 14:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngDZYnYvo+LPlcCXI0dABGPRBzIS2oAiqAsK0VcqkVQsVyP36l8na1ft30Zf5oWPkR8DqiRiVN3KYR4IRI76ihmmZgftHVgOBFpbqj2PgqI9jV/RDqmDJrBtw3HeP2r8cvx2LIypnYAMJTrOFiXHSGASxfChiL9jV4jd+IyuCRjn9GPbmO6K+g7jh3mb+effzw+/KIQCE3Ja9ppNHTWLwp+Exxcv51tM7HiNogg5wZ7wwZyZiyluBKNpBMqigIQt9YQ7AxEitYPtOTQumgDOHyJH1gCOV9OV/FPw9aJqWGak30qr175jo8jSqTwV3CO2JW0GoEsvYN696x+mKLugFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRdU0KulBrx/vbCwJR5C5NjRBzKwFQL8aD87jJfMy1A=;
 b=Si7ytB15KQtHwf4SdtZ5C1WGjkpmld3xJS9fikepRZKW0mbD9+fmRfcX9VWzCTeiLjBmBQl/xgeBAbewPsXpU2wYYAh7O3g60ybGQeKN1MDQrlFfhxqCcCicsuqmD8mNHKuCCY28h65Tr4VyjjIu2U30/Dc8SsrDMBBNcwTr2FXOGXQ3/dBSq/QVZcCxWYaVZXwKbYOFLP9GCX3TVPoZwEjqFA51/AaXeYGViQiBbjinK3r1MeMdQACvLAiW6otzMyeH12oPNrbWHzExIGwA6MejRyy7Z+nHwrxuwsuWIQZabtj0I+1lF1eotsF6Kw7qNmbijQphCrgzZRQeAy+k+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRdU0KulBrx/vbCwJR5C5NjRBzKwFQL8aD87jJfMy1A=;
 b=oPq7oGvY1/bR3uT5WIgVdS35tSxYF0Vt7Zw1GS9WAE1+I98tE8WCHC/Y4AKC3FbeB5li1/sVSqIfW/BP6MqovXr00Q530Qg8e0eOcDLvSibra+Zwx/sFQMQW4p0b/LeHZmpUxLero80irX4ixLBCV+yR6qzI8H3J1ZbifKacy78=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7523.namprd10.prod.outlook.com (2603:10b6:8:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 14:35:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 14:35:51 +0000
Date: Wed, 10 Jul 2024 10:35:47 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Youzhong Yang <youzhong@gmail.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] nfsd: plug some filecache refcount leaks
Message-ID: <Zo6cQ874llzn/Flw@tissot.1015granger.net>
References: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
X-ClientProxiedBy: CH0P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: ae19e58c-10aa-4d12-55d1-08dca0ed98a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PHgh7dNFiSe/Cl7GyaOERBRifXkYMP0mQ0jrf8IqkcQxqaVscdqIgwPn4qTT?=
 =?us-ascii?Q?2ajUQBuggl956amtNvoc9JBE2yT+06EXW6w6De2L4vNlGPSgxvFVl66Sy0xM?=
 =?us-ascii?Q?MuNZwbdDTZxiwHEkpp8tWFoHN+fCeAj1rNaUxYLosgkHunLCTQXSDGSqN4eG?=
 =?us-ascii?Q?ASz7CiEFy4EZq+0CF/9UCoLBJik3YqT7CzD3iHDkfcV0Q8mjnlEYcK0pq6oH?=
 =?us-ascii?Q?p1BUmSmk2PYp7lV8rqQHkHG6KFHpVE8dA6nhGpzL5OJResLslypwFX8FEs/P?=
 =?us-ascii?Q?+9jYVa9NR+B6mzTIlxBEzWo177edhqEo8qMJG2fCWZUtunWUVX6voh+6a5k1?=
 =?us-ascii?Q?EBBx/0BRxiLv+IenLRIjAPnZl6UpIEIb7RaJ8xTOVCoTDIuiVlH1RQTqUnMT?=
 =?us-ascii?Q?qv2Og62ldAp2mL45RmyV4za2M3Pce1bT62KPaqHXZm7k67GM4Jja7y+pZcGz?=
 =?us-ascii?Q?6M3ZvmUUsAoACRtFf+/3e/GYyxytc+vBG3BHkwhYKOz6a3/XDJePG0wNcobv?=
 =?us-ascii?Q?PO8/+tVl++EfNu8dTy6CKZspoBUkG+lbdXWGku87r+geQKZ2mWPuBXHMsnre?=
 =?us-ascii?Q?eaChC7M/JTyZo+GSJ52vDrX0KJltMtza4I/kVxpv+jdbTJOlAfCuSPjyZ4/m?=
 =?us-ascii?Q?FVbcKOC93JowODJSFizL5awkGtxEFRmNC+QJUr8uVhrs1pzBjmXm+2FEHhcs?=
 =?us-ascii?Q?JVDVhb69MCD3TCnuCvqJCmbV3lY5eUDyGOEdpEQ5cU4qpTeCofWhIzug2466?=
 =?us-ascii?Q?5PFbNLb43/NS/BqidaAKf5V4yKRQ1R4SOfMg/aPoHCZkxHSzVjTOlyfL+NFp?=
 =?us-ascii?Q?ycb/MgjyUxg6l2JAlzQPxv5il8gQyxl1jk0NTTH79pwLzuXnb6f3c4ni6Luv?=
 =?us-ascii?Q?K1LVNR7rPhTH/48ENIZ3tCGELgCop20tXSGUqS0soEtwYdZuS2z2Ee10grSZ?=
 =?us-ascii?Q?2T9HTs6a40hbNSfrld04KnnLuWiq82k8lpHS92Uc0KoZCqByj1ndhpayIfC8?=
 =?us-ascii?Q?mhrRoOHi0J0DmJJYmj0Bq9UBNhS4DQn9SdVJ+zx4MrGz8VW4QgsxQy26mi7Y?=
 =?us-ascii?Q?duZ9Q+dbIsVZUHlaW9a/7NXwRhXKa8hH2EaQMAepZ65ztcQPaWt1ApDuNDRi?=
 =?us-ascii?Q?oCsJ9pj7dRa/SjDqF/AEZSCzGnnZAqbc89NVnU64THrlwrCXD4Yu8FYh9d6l?=
 =?us-ascii?Q?qwtf/w482bNVVopOMagoSashsmcrCYrVg7Jtq4HcXC/g2sGOU0bC1YMeAKsH?=
 =?us-ascii?Q?lDDzhpA1ruVuYp4dRZkLsjFvj/Z2cH94j8jCjkNrP4Z/kkJfE9vUYnze6oWX?=
 =?us-ascii?Q?D7sjJHnG9K9gGGmEbq6A/5rLEGi1+zU2pFDVDlhOhN9j3w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+6oQzY53m7NV4RRbRpT9gtTpzL8F7/Q69hSahz5QPwptc0CCMpYzzmme7FAL?=
 =?us-ascii?Q?nCot78gkiEHDbc7KrlfjbYIBvsompkvyzIPBZoMtmA3BNMo7Qfsnu/l2Xs0w?=
 =?us-ascii?Q?cDnkCVyKGS95/sN4Bk8TVJlcFGCFEtcicqdky2J0fQVZzb0d2r3+roSiMVoF?=
 =?us-ascii?Q?kmG2i+FpX7iijPoZF/jg2N2kp+BOtebg0ARmx2/VchrQURmXgckx0ujLAH0S?=
 =?us-ascii?Q?2lkYVuZSkV0gy4ZQQxjtBN/uYroXE3MRWIMGCUnNhx6KY48tQhUVbKRKKEGx?=
 =?us-ascii?Q?Qg8ioI0d42PmTgBxvMVtEiBMbUeQw9e2KZFoTQMJSgNXYNkvZmTC3arJiKDL?=
 =?us-ascii?Q?UCRXVBk9Kl01xUXIYnDor/X1egw3wo/b3xsfk0yqHnhYGpUTvw23SzKVkN4N?=
 =?us-ascii?Q?NUPB5sLis6IP2AW4UaBpfsyPmW8tV3cLHolqz/ab3xgEu39w8+9wqwu5nkDg?=
 =?us-ascii?Q?lLnE1GFUEtXjbGJ7OJ/0IdhEJwQNFXxhryA6mMgRrWC+EPY7wFaaBA5fT6bC?=
 =?us-ascii?Q?8rm8CO0KiE6p/E+hx+5c1gXJuQ6CJRQp2McLMUscdzf0geuOpT/CohHIMigC?=
 =?us-ascii?Q?NSqFHy+FQbVHv4bTIIkf++Noa2hd+csQST7neZ/tNGs9fOdBaYAN+4cHGfh2?=
 =?us-ascii?Q?WiDEBp+hw8HpGUrqfTNA1LC+ZtivgtlQLYWd6CjJ21IFdwSfvtu30TBkn72K?=
 =?us-ascii?Q?jkUXXAr/3Sr4s9sjvBE4USZe+Cmj6J9mSqba6XDI7sRyOt4rf7R9Zg1oCk/c?=
 =?us-ascii?Q?jquj3HVG5rtLascGt9u8F2WgzYgA56Pbg/7qCj9XAFS8gSC6Wu1dUNL+NMEc?=
 =?us-ascii?Q?TFl0BGtP7FKBDVoPvoy1y3W9Q22nRuVc5PmZvho8h7ZyKlKN5Gx6B3AjBdo9?=
 =?us-ascii?Q?y62xqBP9NMJ/+Yl+9+b1VfRrUhhEYWM9bIxCuvPpX9eKdTvSO9I/UKL2cVpp?=
 =?us-ascii?Q?5w2v6IrvOwo6C4X/k2dZC7eHSU2tj0uLXb+qVAOQ95woAEpXfUtgwZDAS5RG?=
 =?us-ascii?Q?kAws9u01yciCmo2l8z0ihCaayJFcASq4K7LECnfKcgihqvueyvEHF6sl2eGS?=
 =?us-ascii?Q?7GigsBCD8E7mVPZSigT7+hlqYSJn2HxZmT++rZEfCzjmkPFqUGBG7pZb4XVf?=
 =?us-ascii?Q?1uLyAcDInud10s/PyL65nR6S6nvD0vWYJlOUQKCbf9rVSjcyqnxv1vg7Be5S?=
 =?us-ascii?Q?lq4nGl5xJMtbbL3Dn+4WWJTqpASsB1g7bdrltX7KHGWFReEJkHE/sNuT2L2k?=
 =?us-ascii?Q?/A6mrPkHJzNa1nV6tiNznIddKNr4iCWzWQE8Zok0TUeqFDgAOUW7nMxVRjms?=
 =?us-ascii?Q?4du9YVu6P/Mimdu883ID2lsKlczwISAqeYN4ONc/gDm4WLwmX/a++K/JwjGr?=
 =?us-ascii?Q?TxR4MwubbOhf+7T6cYHbgTc2br5KMy/2QAQMVu8IIYqU44dIr7XgHdA/M0JK?=
 =?us-ascii?Q?EC6hjNoQbsZ574KVxVWESBLNBfQn6GANHAeSTx0Rg7XUc7sxW6vV68vWuNdi?=
 =?us-ascii?Q?/ZgHLuN3rRGLCH1OvkE7dwUsznR28Kp9zbYhRVGSo8BqNven6LA71Gn1Gl0D?=
 =?us-ascii?Q?qbT88t0vaTHLqQGqhFEK7uPVGFp/vfL4/7EqaWpA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GPdKur/ZPnFVXJv9ukSRdu+qXcO4gNZ48QPsLeWhLalccdcLd7Gc/BA53pX68JQcsJt3UbjVwCe6kVD2cm3gEtozlwQLYsNr6LJsN/UW5MYbEpLoZ0lELAKLGH3ifI1ztper4wRci0kKQkoaLTIaVTOSgNZ/uFayQRKB4YY2mevt8Jl/SIxDcGg3ui1NBK8mUBD4LzuPjwP7EaNTCw5F6ttFKFb7HTsG3TdTZ06hHIkEvvEDLsyazr+gwzitXPmJE3YKIhypWYddCo0Xfo+aUKB418Og1Hf6y67MN5+IltkucF8zOP+DdVHSs2IWEdhELJBmfo277yC2iaI0wIvzAlMB7w/vtWBKyr7xHC5ZObal65hj9jllDUNh3KH/kHcn8ddDk2H3XsFVXl0NyQNdU88jVLht5/3EgwFGTQGXTaSE7UYlje2pH/vidV94mSh3+vR2AP65SGo1AlO6NBr4wqAjF175fu2b3l94hSsNc5w6BeIuxr+vcylI867kmvDvGcqEj+T9a4tltBhlK8PzsCYyauh7UHQ7CmQoE7UEuJfISbeUTpA0bjuxxjMRYoBuZmTs1vtO23QL0Wq/Gy+y5k5OmrUONjKBCxLt2/E1KyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae19e58c-10aa-4d12-55d1-08dca0ed98a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:35:51.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNj4mgd3+VHkOH4KZBIYzfb4vsupyirAd2NAhKzQcw+kOdT2mhEM0MkxVzX3npMg+gpE1uOtoF+LoYonUMK1sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_10,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=969 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100102
X-Proofpoint-GUID: t4phB9dzjDL9p5BKAkT83_cdQ64Fyvkf
X-Proofpoint-ORIG-GUID: t4phB9dzjDL9p5BKAkT83_cdQ64Fyvkf

On Wed, Jul 10, 2024 at 09:05:30AM -0400, Jeff Layton wrote:
> Youzhong Yang sent an email to the list (along with some draft patches)
> that indicated some nfsd_file refcount leaks. I went crawling over the
> filecache code (again) and found a couple of places where we didn't put
> references when we should. I'm not sure if it'll fix the problem they
> reported, but they are bugs.
> 
> Plus, let's start counting nfsd_file allocations. The last patch adds
> support for this.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (3):
>       nfsd: fix refcount leak when failing to hash nfsd_file
>       nfsd: fix refcount leak when file is unhashed after being found
>       nfsd: count nfsd_file allocations
> 
>  fs/nfsd/filecache.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> ---
> base-commit: 24decb225ed20a5ba46a79f4609e109cb0e4a359
> change-id: 20240710-nfsd-next-01e2afdebb31
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

I've browsed these, they seem straightforward.

Since this is the week before a merge window, I would like to save
these and Youzhong's patch for v6.12. The Fixes: tags will get them
pulled back into the stable kernels once they are merged.

'Salright?

-- 
Chuck Lever

