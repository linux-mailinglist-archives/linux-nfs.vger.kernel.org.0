Return-Path: <linux-nfs+bounces-4996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D415937CD3
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 21:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6346AB214CB
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA511482F3;
	Fri, 19 Jul 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HxNNBlFS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hPtWPby7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272E8C06;
	Fri, 19 Jul 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415869; cv=fail; b=VhlR5GHHQVOsgLxr2sgwAxxHzPxENQIs3sUzoqoSd6RwPsT7jU+soRhl/rMoPszTKK/dJc7rcpKodobLt+YSIwP5OsvyYjBw8yqVWQy7klnf8jIkbUS7wNNwhm/ejuqvQ3KS2fbEEljV0ctFbLs3gFs7cBQ/kiHBXfl1yEeLjtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415869; c=relaxed/simple;
	bh=lm++fztdX+wK89p2BgFjAs+qzYPouWmaSAGQblEbM4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g4Jk32nVncMFeqfrUQbYsbUgbrBsQanW2GVmv/OAD3g1honwar0NcOCj1NWWMGXEDDMBmB1gCzC9AAlaKgGrB57fA3h8p56kvhvbH1vAXZXAezxTTletEr60c3alygl6Qtbur1EzxQFf6ZT+dFzvgcmwGGwHarquJGx8zcwp5XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HxNNBlFS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hPtWPby7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JJ0ZpK013196;
	Fri, 19 Jul 2024 19:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=kzp+F0YYhK4lVb+
	KRJNh2VzUEzXvHc0RgxZSOsal8jw=; b=HxNNBlFS4S0not3PafG1WoaHFl4XjXC
	sVwNP8Xlp5DInVC9jpECOySoxGtHs+CdVuHOrYp6WMTiALPyxyDjx4IPSsMs0zWf
	IGYekseQbPawyeHGpGQhBAXbjt8eGyancXoZgrv53H4C+r1A6cva7jshQN8QHsCd
	hDzJhX3FGYgff3YbT9sGGHbOGHjUEYpTddluKo6qoCOXZebuN9+ZlPpfVKLxDKTI
	RDkhgq1bjfW07Z0LIuyoKpA2Zv2wtVGZvjjyg6XQRufTvbyr3bjnTmzPrBDYyIsw
	NLIuGHsLZcnFzMWpUzbIOjPZfhNp1dnk4l1raoEM3v+KWffuk1cqZYw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fwwvr09k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 19:04:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JH07i2021679;
	Fri, 19 Jul 2024 19:04:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwew9d8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 19:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTeDXIt4S6q/FRx2sRerrOEqxQPJFASUMGcfbJRUv1Ds3unOQ3qavxolSkRpdqJ8fZTi1KOs0Tw4jP/Ue/MNdyAAryLg3t6H0RHBelIICZpUPsxAcvEwLIsXsQbqWTxBKeT2xpnGtmx/5KN6uu7Gh1sQOT+w2aC0DRtBqhd3ggXNQlVyEVkbmGiyErurMqOEuuchX7yNgtbi9rQ8t0V+qAPrsT4UGZukZ3JcvyX1tbHszY1chjzD7SO/J5yj0b2NwXzV4ncEA8SaCwfTeX3Vp+rbUr+8nV4dMKVBDJ4S3jHi1aqJQIgPyFW2CxnbF54Sg5IF5arsXefcRVBo+obZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzp+F0YYhK4lVb+KRJNh2VzUEzXvHc0RgxZSOsal8jw=;
 b=YRhBKe6hPG7EuhfYyviHpm14kfLLMyffKO+aNOD0RzfUznFHL4fufTYEBWx8ksRMo2a5UdL6xUxk2V0z21i2EPXXX2fMD3S0GGhgOjfxH0toA26dKcOyWzhqO3UastqvhUfFtFpSZ/8k5XnbuDkzcAXgd5rR4xODZ5giEsY8vv2qTzQiHaYxdS2DCm8bloH+X1UohAM9Ij6jXHrkPROGB+gxpObYV1JohEdQAWBMlGaaMdtx8A/fcs0ILwB5yX5hEGb3mD2Z/CIkTRF3TuJOd2iwfxhwGMWjk0t/b5RXl91zKtOX5GxoF2x89V6K8YH9T3mEu87kaJ/xjWBKWKpl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzp+F0YYhK4lVb+KRJNh2VzUEzXvHc0RgxZSOsal8jw=;
 b=hPtWPby7jnUap3XJcKESYJU36bG+Cl80AJ9Cwv9Gq80wR7thm5+nL/OhfpQyaOSopqQ31GEU204KhJ+mLtboGZwWc/d7UDoFOAeYy7+Y7LqXAI7RYGxyKxqgW6LgmjdQJmfieSjSqsmt6J2TBQ/fbzq58mqPmRst36qDIFfr/xk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8196.namprd10.prod.outlook.com (2603:10b6:610:246::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 19 Jul
 2024 19:03:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 19:03:05 +0000
Date: Fri, 19 Jul 2024 15:03:02 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH] nfsd: don't set SVC_SOCK_ANONYMOUS when creating nfsd
 sockets
Message-ID: <Zpq4Ziq9YVuGqV7b@tissot.1015granger.net>
References: <20240719-nfsd-next-v1-1-b6a9a899a908@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-nfsd-next-v1-1-b6a9a899a908@kernel.org>
X-ClientProxiedBy: CH2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:610:4d::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: e50d54bc-8089-4dae-ac94-08dca8256bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dxMW+N9L9sPO4AroV1hwCzXQboY4ZuBmwROSrzHsU63c1P3vdmxSThfvW84E?=
 =?us-ascii?Q?lmhIYba4gTFpaUuk2DP3x5jZEzJ/5mHkdiGBLgg5fMQ8dMvYCkdVCY/ko+vR?=
 =?us-ascii?Q?/9m2V5QTRwrBT969Fii0cyIoK2j//sz+xjKg0cN07Nj+i/ICbtUGo0c+3PPb?=
 =?us-ascii?Q?M+b552G0FB/rrpBM4ogtl3FO4Du36R5TVB0ywPbWgtm0bZaHAZIgNgrsitX9?=
 =?us-ascii?Q?STTq2kZUqmFq2Jq348eNjW+0DtaInHaaCIKpFbBvuzTh80ECNNvfWwGLZCzp?=
 =?us-ascii?Q?YD1K6SqZdfSw/zn+agL90YL4eh9BXBl9eme/wbajtjvVl5+yt82wydUKAm5j?=
 =?us-ascii?Q?2A6MjrVqiupTwNJqaq9QqTmtgMjrmaYbmVaK77m7SZW3vJxtUErbvBiN12p4?=
 =?us-ascii?Q?5l8MZ6wGiWfqvKIAwUde7XDfWoo5UfKxoOcE7nIrS4Lj4aGi/242Nd3sbSup?=
 =?us-ascii?Q?Benk5zV+SPKAoDC1N8AIVeV+nJ6x0q+AlEznTiEuzXy3S7AosSs+UammTjDw?=
 =?us-ascii?Q?Xph1qPwS0e0BXd4AWYJhsfzgvjri02qz5Skv3CFjvEMXzT+CnHvgCDQzpEce?=
 =?us-ascii?Q?H1TC8dyOCV80H0awpi1M6URE9d9DnSeWcGf3KH1lJhN+j6452C6f3eD+F1R8?=
 =?us-ascii?Q?c1ajRRfsp0VP8EZB3sE9tVh7He1EdltIhPLkl2/aEQPdxyoqaxpEa1NiYnwK?=
 =?us-ascii?Q?02MirhxaIb+flf77r+BgJAd1HbIjVWPUu7PdQh4ebrt0DycMRRYeDdRQ0yku?=
 =?us-ascii?Q?xU2KH1PfE1sVNBZGxdHgVnA+cUdqwrxOtgczFJCJzy8KP5bU78rDNnB8cAw8?=
 =?us-ascii?Q?K92MrdJLyQabrvoB0g5JwoPSx3m6f+3O066JSGuJ9eT3jJNJ1ZyeNQkn1TYI?=
 =?us-ascii?Q?/q9KdruDTT2fgL5wjOtknSFeK74CE50QDwVuAooaP4ZFOD2OXSvhdGIqwgJJ?=
 =?us-ascii?Q?Z/vZaNnpHGR585N+HkI/SfDyH7+NZj4BmQ9hIiNLmiZpuQPUEt6iZsdtXiV1?=
 =?us-ascii?Q?Kb3kFo76t8ypfVoEzkzribD9XoZpz1oCKoKPOKOycPpWasfJFLwR5TIL7mpv?=
 =?us-ascii?Q?eHLyOO2TrewUqHK5qZcw7i/ytzyhCz/eXe5HBG6UqhccR937BMyjRF/kQN9z?=
 =?us-ascii?Q?wrsYiiruHicOhz859CTMxZ3/5+ItjqBZvaUeIP+1CGUpyQRQgvLTBhWVuZvo?=
 =?us-ascii?Q?gquPJ9EoMDaxy/c0W0pT8x1mXVGw3gKQErNvWOeERVjHiTso4eH1CVaXqHxr?=
 =?us-ascii?Q?cYieT12W67L0hFKnXuLu4DIRIxEutrUwtaZlJQpBgBiFvfKOZV8HUhSCPmU2?=
 =?us-ascii?Q?Oj9gX8O0pxtiKBdX5tJ/OOkmUXqyMdMt8aF0y/Fub4o54Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mbZ5epSJqE/P0Bh5Syp++G2KZEv3TRu3sRZxZY9lH5cdED4AOCLBwp/lzrzH?=
 =?us-ascii?Q?YZLbkm5NU6HCeeEr7uPQRPRj8H2XOkfA7XoB3rWsySXpqQEKmx/CPsvhCIJy?=
 =?us-ascii?Q?sdyLbYGnrYhS7uicgjvdAO+Lw5mWCyCmZYlYRtN/MfXTD+/o6VMWjvMcX5Gm?=
 =?us-ascii?Q?svuHeidLbc1j2PTgPFPObowZBBVEWkzqcr7+qDzRtbiCEwPAlrj2rp6aEfm3?=
 =?us-ascii?Q?eWNB6rCSQ47u7Ru9pUF5HDH9w4W5AfMglUIQ3lT+IHenVu0s92naglbOK5D3?=
 =?us-ascii?Q?RAmS8vcWtURGCDf6rkDIc1Gvm4QaGapJLZ8G+ED91l17weaBpBs3d4BGKJVX?=
 =?us-ascii?Q?tJUgpBxgS+qKVcBfllVataHI1pCj9dWt5PRSMMTMbhsNmD1p6p0DjwMBSf/O?=
 =?us-ascii?Q?NNiJSV4GsO0mnDGsXPWtd3R5wZKh2S/X9femF2NhDHwZeVe+L48zg4PrOopx?=
 =?us-ascii?Q?TQPL5hdjMG85Zlqzi2PqYyOA+oJq9VdFy3LpVsl0jzN4kfmtHkq9AX+QCWFF?=
 =?us-ascii?Q?zT5+KjesozkKL4PrXtLbcHqUhvZ88o41N8sVMvagPpE/n0KqwwTS5tgINAkr?=
 =?us-ascii?Q?X/YKwf8jOQZZ2IIILoN9gEwv/yB6Gq2S73f3Jt8ug01NAGTGvcrWJnVFjksq?=
 =?us-ascii?Q?GkS0TYl+K7VH8YN8BUCP17+jTYenra6WVuq2ynN8/c+gE++zJk7SVCTPOonZ?=
 =?us-ascii?Q?JPMiZUf1iNS6YdeQ6/XGtfrppa+dWvzEgZPsBZ4zyfrkMEdlkBiNj1W1j1c0?=
 =?us-ascii?Q?uwd+3CTfPZPJpMenkBlq6nrEIBi3OC0JN4/948ksxB8WEi+FLq68FsmFxot/?=
 =?us-ascii?Q?LS9Q9McKPeaIGFUrkwcRsz1U27SAMAeECopgt2Mrbn6a0u/vFk8VxqA7UdDH?=
 =?us-ascii?Q?6yiH03ws8WJ4iWjjeD5GStZF+1+cWkJ5WuzIkUv/ZaCj+z/V7tV5UtfMTHYl?=
 =?us-ascii?Q?qvnNDcavnj3mofZor0bSTYB3tWzsW12E9YLD8LKrGWZp6LwTXkVBxoYEj6sb?=
 =?us-ascii?Q?nsT+7BFhHF8XvvPI1aui05b7Daz0Hi1UzK4gyg5z1JwRTREc51yNhCdKnzWs?=
 =?us-ascii?Q?v99UX53N9jsXCi8DJJEU8/o00H81gIcdXehZkGlSS27EMOJumKXh9qTMcw4q?=
 =?us-ascii?Q?kBAXOmGS9QfBvUzT5Jg8ngGFqfW9daBt/3sYbJYYnwFn/s2UpnJ3+zq++w27?=
 =?us-ascii?Q?6p68mi6b4YZWZQ+Q76gAXTtDEv69Zv0LDQl42YBwkZ4AWc5ZKRmQPJZdrlsd?=
 =?us-ascii?Q?OM977/axoOXbYxRTzMQ/MeuhYyrN/fik3QWF1lwcQuiWGenOarK+xsi5D5Ew?=
 =?us-ascii?Q?Fb5Oj+p1mq6hmQ5FWxGw6pPWngaDoFJUebXDgkaw0SHa8aSjbvOyY5TZ9nEc?=
 =?us-ascii?Q?3DV6o/WGaStyAHFLt35jwJ4wS7KA84/vXwO+XeB5cF991mskU0DTAvPj1Hzd?=
 =?us-ascii?Q?+KccJe/nd7E2ZGCYE+AMVtctsMZ6IgXibO7yOMtg+uE3BD2JYmIZigVjXoto?=
 =?us-ascii?Q?mfIYMa7X3nJ9vTP3BvZUKU4IlTXpuNZbGcY3zCb70k1xzCZ6MjeaugA1vLRp?=
 =?us-ascii?Q?+IkA3Evx3eTvLxaqqUnowu66dKg+amajVQIdL49Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M+DdyVewed9sYPtSha9MM4xsxgAOzrP8KBGaDOvU4mzl4wgzJ1z3UU68NP3dc6X3vIB+4P3QEyuSm1CL6/fEqjdpmdA0C3bKcEMkFjWQn7MDhOQ7KMkx4aSN6aHQij6egpBLsjEJXXDiYkVuIJml3iXYtkRuWwgKxiBww8YzkxHgBi1gB5YXb8jGSA3dpZomPk0Xv/EaVzzo3OxGsssp91flenIM8C6GarjZgk9aDu/cjliPcer+f2Vy99G+t/4/xYcrT3UyLMNLPsmFTNs6PPa22+9heTXV1eEp63CUmPhXMJnhA7achvTYeIBev2U2ZY+3pX5alkmYhgNPvBNbLJ8vAKcX0niZ0jQqF/Z0Pat1O/PPkyUmeF5Ma+Mt84UK2o54sozuMZR5GuCHYjAJxYHEQe8c/KiOMmJxYciflQR/kclHr2V3TNnse96uiW+TXIRzJS6oucojx+u9aGsyzBHecHOQ6y3Oh3zCMUkppg1SRhB2tqTLet4IDGQuWWTZSf0aCntBXHE2QyKEii6ft0mGbxxC4KP9W9YcBEZw/DOwGUH6SajOp1/s6kA/prMU8enpiOlrZFAzLjsBAiW1ZcV7DPT5EoF3HU8kKKLBGyY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50d54bc-8089-4dae-ac94-08dca8256bdf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 19:03:05.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk5iJBYyrrl4C99nl55KZb753aYYZ8RQoQUFa3Ep6LhfyOMfaQGlY9mMPxrXcRKeVKrjgvkXw8sCIymcTXIr0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190142
X-Proofpoint-GUID: BKBHrJJWkQOgssVmVGJrY0V6RKIa39b_
X-Proofpoint-ORIG-GUID: BKBHrJJWkQOgssVmVGJrY0V6RKIa39b_

On Fri, Jul 19, 2024 at 02:55:53PM -0400, Jeff Layton wrote:
> When creating nfsd sockets via the netlink interface, we do want to
> register with the portmapper. Don't set SVC_SOCK_ANONYMOUS.

NFSD's RDMA transports don't register with rpcbind, for example.


> Fixes: 16a471177496 NFSD: add listener-{set,get} netlink command
> Reported-by: Steve Dickson <steved@redhat.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfsctl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 9e0ea6fc2aa3..34eb2c2cbcde 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2069,8 +2069,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>  			continue;
>  		}
>  
> -		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa,
> -					      SVC_SOCK_ANONYMOUS,
> +		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa, 0,
>  					      get_current_cred());
>  		/* always save the latest error */
>  		if (ret < 0)
> 
> ---
> base-commit: 769d20028f45a4f442cfe558a32faba357a7f5e2
> change-id: 20240719-nfsd-next-d9582a2c50c2
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

