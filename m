Return-Path: <linux-nfs+bounces-4983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FE934F69
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8751C217EA
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D613D62E;
	Thu, 18 Jul 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CDnSsMKT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NQvn25K9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D313D8A3;
	Thu, 18 Jul 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314407; cv=fail; b=uLQ7O75l4DjAoLG7uJROSanMf5ohNA0ujenQf0DveeOSHVWRvuiccusQ407Ub8tP1Tn4veZsFHM9EcL5c82oGtnEGhAqpmUoKs4fpOuRNjD8FxYiNZdxRPz4ri7aPL5FTniaMQmSyHPdqXd5wGCI7y8wngnYjJY8aWDr5MfU54s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314407; c=relaxed/simple;
	bh=CsjxdJ9bjX/5imyN/DfNpD9odDBPXZ+Cm8AuzIQGFjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hNVGmMAIg0+70StzbrJKqOthALPNaGpBJ2tkkedmheaL6Wfxc7MMAYJu+drQox3m+Om965YkhYvglbqjgOM9DFfK6SmELwJxVCKCEtxnm3jkrvpHXnyaTUV/fe5AWgghgTcNdrLzhPEr6Z3vLYFi4s7RPoNCHBu2aCyjenwnr1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CDnSsMKT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NQvn25K9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IEELCI031783;
	Thu, 18 Jul 2024 14:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=TywtsborrdOkwdf
	/zK4d2CpOTKwTS1Vrsn6okOcHLAU=; b=CDnSsMKTjvD9J7SL974tUR2Gm3UCJit
	sD0PCKQhiATxNundKUOqC8g0ZYmxQlEZ0h73KQXHoA+0pzV/moyQd5l/1TyLsG3B
	Y6c3OhY9WMMdrHXDL701lCRvrmC8tWtKqE4Ary+dJUCCeISkR6qUKS4YPvyqgrAm
	5hnMueG1hkV/g28gj8+1MWyYgHijjsiux0PWu3ToxyRdaj/cZlKiV3nuZFKConbs
	25tdjwntYBTWVug6rkh5CMSU4VExTTJ3VeeOmxGAdn31MyAk5XrdUAzNy9YC7ADj
	e8nykp2MOgXdgLOzH+juSzW8xpmaO+Y4YIqbMryr5PzNXQkKaZzhbxg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40f4mvr36y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 14:53:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46IE4oG3003758;
	Thu, 18 Jul 2024 14:53:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf0hfc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 14:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8lM5aEcxpxNW4Wh5vm1/GasRlv0nq8CgVVfdFIMuMNW2BAPlt3FPnq2tGe7DDDEHXlcxshR0cFfPuFboT0RoHJLY44GKHw3Rd9QTdXlHlTfew4vNyGZkt8brxEVMb1PDZeBy5Uvz/l93ML6T6rlydxihjQYkaUKpq3rt11txeVW9xydIJhwdK1zJjS7ypyDw+g48YqFy7TxmiOzzJDZCeF34HsBCPmw5uCxDDIoqW+ROTWW9Yd7OESCowoV1+zoLCF6u78KfdV1BMHo0koEy0yKo6sFYD2E6ujRa07y1nayr5tXu/4fs/hrl44omoR7qs397goPoPneKxKmT1qqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TywtsborrdOkwdf/zK4d2CpOTKwTS1Vrsn6okOcHLAU=;
 b=zNd4v3KNP9c45ibu1Ovi6QN+hYK4cFbx2YK3tN8m6ZuSVVs18d9uQ8OUNnaVig0ZFSfezQ1sA1bFWUD9dLYQnv5QzUkuCc0HFWnjajgmM6gVBMnYdBlFjEMsL52GUj0gVnQ5DqmTLYpELUpC/rPE7ct0KIb9VrNGTd/LKOqwN6bRrI10V6hVz7ay7qLNYvK2/6BD1JFOOW5o0MJjhBQWTDGNUHpZJBcnDq8ATdtrAELGG9/US4FAny9muEgvDwfJsjjyNbAcTpdV7LlfaW528r9DgV32St+3V41RdZfo4SpNwsMPMaswOlftX1ibEuNGgD4typknCD6o8bgNncw18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TywtsborrdOkwdf/zK4d2CpOTKwTS1Vrsn6okOcHLAU=;
 b=NQvn25K9upc53UavjZ2Z4j24qZche5VeKi4UD6RnDwJaNFQv4KeNgmls12ZNMD/6Y2lo7NceYtgzDHTo/BQN1RWUZQtF2H2UWR+ahfoBZwWyjgOAVc9giic3Cj+bURgpNRjT+AJ4pba8c3+tqZOJi3WseCgbhnLH0d7xQ2dDGLY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 18 Jul
 2024 14:53:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 14:53:09 +0000
Date: Thu, 18 Jul 2024 10:53:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        NeilBrown <neilb@suse.de>, Sasha Levin <sashal@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5.10 762/770] nfsd: separate nfsd_last_thread() from
 nfsd_put()
Message-ID: <ZpksUWW9aAccQOcr@tissot.1015granger.net>
References: <20240618123407.280171066@linuxfoundation.org>
 <20240618123436.685336265@linuxfoundation.org>
 <ZnjyrccU0LXAFrZe@codewreck.org>
 <3afa32d75feeae84d894e7e71ce8e24372df78f3.camel@kernel.org>
 <ZpjCU1rS15JBasOV@codewreck.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpjCU1rS15JBasOV@codewreck.org>
X-ClientProxiedBy: CH2PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:610:57::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: a452228b-3a13-4923-fa5f-08dca73956a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QcnmjZ8KBSYL3VRVeiIYDVk6Hdspk+twCUbiFbKlsTnIGCZJSnCc4Zk6KfPS?=
 =?us-ascii?Q?Jq9PAejC80vhSJA+v5C0k3LRTknTXWrPMlKYgIllHDH1JPneZggrz6j0SR0q?=
 =?us-ascii?Q?vA1edusZDePZ4xO2dg4GikpbeFRGgJE5YU1txGVvfWbCMx/PNBgUXyc96qTa?=
 =?us-ascii?Q?Q+byYQkO6LbDrdgNtrVOvQbgC2saBE7PxXIvFlng+Gk/vUfKomdGImPut3mo?=
 =?us-ascii?Q?UYMtRm2EUnUHH+098UrmiF7ExlXCWhHv9K/84/IwmqcNovL+f8H+vyZnStaO?=
 =?us-ascii?Q?r6ChupntoAbBy1vAvKwZr/DyzEuVlU7hV/RoxOOg+DljSPaL+WGkWUZp8mwF?=
 =?us-ascii?Q?iSMz3Lww/Y1YwUlPoiMvXe7ausKJSczYajaevrwOOU/LfHeZELPGPVBeG1w2?=
 =?us-ascii?Q?Cf2JcotrzRqh1yKT+F2UY9D5JszNigNufnN4AwoNplpPmvKQWNW0zF8HLUso?=
 =?us-ascii?Q?L2d3SgyRvSeRGWVZNw9oy3EGUKl316FfLSOWVvZVLw98mAmKYM2BROVqwnkz?=
 =?us-ascii?Q?l8yGPGdz/TOTvKwkIv6JerOmYN9iVH9liXfXtZznIQo83bU0jRWuZmOijOBY?=
 =?us-ascii?Q?NXSf7s+b0Giw2MVFYCT4XbNXFsqjKkBbIKUhFQrzsp58Cdc3r+0UwXnyQpQ5?=
 =?us-ascii?Q?HsJJclb9J6RrFbdZk3xhBOg8Xh5AUXWYsnCXsjkD1J9JAKB/mN4cPboZCO3g?=
 =?us-ascii?Q?dJbfY3EfRORtgAPCpCJt/Uawiy0OLYsrz3hMY/22yY+Sp6gEQjnj2DkQuIQE?=
 =?us-ascii?Q?xcv8V9LT9ZYW0CuhXcSiUCsLMrRP7ogskdhUhsXr1TzAZUzePRpYNx954kdT?=
 =?us-ascii?Q?4TjDIVQfjLuo0gix+uHXiHO5peqB8WZvJ7ygKD7skSFvyLkJoZ1iTYCKuG1I?=
 =?us-ascii?Q?3r2D+vfqKU4IfszNG2icgZIA7TU7xX1JYTdxXSpaxnlQcNu6VktW9m5qkLqV?=
 =?us-ascii?Q?W5zK2BZcdzEnBVHUWnM6Fa/7EMngQzEF/tGEp0a0aruT8vFc+0DZy5yjLa1t?=
 =?us-ascii?Q?wQSkEZxWySVxK8iV0oOAcFrbmSqAJflGDRVxquoJQux0VsOsIE6Y0P/MRUk3?=
 =?us-ascii?Q?sW0mE0qpwkkUPg+LWHu/Z4pA4bda2JL6/t2rSHAkn4UYixVU1G6jYtMsP9Ak?=
 =?us-ascii?Q?vfZcB1zZjlNr2nIjhb7bWvDY7AMkggrK63kyqDkC3x76qUXPE73vaB7dwzPn?=
 =?us-ascii?Q?W6vsV1B7RgUZB+tE2zUj9cU/9TvvqOem24c4GkE5p80Um96YqnioskbxFSTn?=
 =?us-ascii?Q?daqJVqGldMwYeji6I7TBJSH9ZXPs+UBVUbzl5vXXKwUxBuQ37/a2VrbBv3fl?=
 =?us-ascii?Q?JlhBe9oqYvHewxRZb3gVrVdpjiF6thTxE+Up3npUctrYoQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4Q1uCLA0WMCVxszk84luer+q0Sm3T1qZhdrBnCJdxCMYz2mTYO9HzxNja1jG?=
 =?us-ascii?Q?NXOx1oNHMt/TeSBNBLFEfalFWgSGgfcKuOXGHGiomf9sF3d45YHmwgqq7Eor?=
 =?us-ascii?Q?d4GVrd5fC6w6YAtugwQidM6Ef/wEHJOWsEzsXhQCClN8sNVKdSne9vzhEskK?=
 =?us-ascii?Q?xH+mpX6ktB5YQ1eouzHsmPm8iRfcZ9laOIQdf4r2zWNxrX0oWb25qtLh325H?=
 =?us-ascii?Q?YpXI5rTNbbwigMOiU+DJlEmtjxgC6c1RI+bZ1EKwXV7/7/70sd8bMVOScc0b?=
 =?us-ascii?Q?JCe7zazA1Zl7KrL4b47agrSq5QUNell0hOQlr7Qao5sv3qmlG4PtQ5bvP+1n?=
 =?us-ascii?Q?7IT0QeWkK+lTztGt9lMSO5hA+yW/rENze0GhmT23k5hmm7LTJbbjNU0QbcPK?=
 =?us-ascii?Q?HUubzIX33euR9SD5MunXC4ppxqpBk9HYntFbpyOGa3be308rORWuXDlJlxyu?=
 =?us-ascii?Q?5bVWOdBVOZQ+t1hzhPo4XZZ2/OjmbVOUchE/Fnaat4tcFIL8iXxf15jJ4zKl?=
 =?us-ascii?Q?ZUBWut4vfDPEs4eShtp/jhTES6ekfQcXUKqNanseZne8MEr1PXmjnXa3CObj?=
 =?us-ascii?Q?BMKj3lQEoAelWiK3tPgukMJPkdfcZb4Nnmvhm1ZdFh/BNRWovL6W/lowmvYL?=
 =?us-ascii?Q?QqohPuxTdQLjSh/zmbxOj24GGiyxZ2BHN9PtBLg/mGWsLhKeK2GiuOL5KlmQ?=
 =?us-ascii?Q?AXY4WGxPZvDg7d9/4VjlnzhgpVBvDNsvtEbMUTNmSOG9JArwHVCMhHZpUb/7?=
 =?us-ascii?Q?pQ31Fo1wJnLYF0ljgnTZSpFQkYfYXPtg08SLM2zyRg5vm038ikCkt8PXJSKq?=
 =?us-ascii?Q?um1jMYEg4TkxEOl/4fvgmqfTukcGn1AK6RZkf4Q9k1nUmPPQG6KCFmH/R8wZ?=
 =?us-ascii?Q?bbq8FfkutpcllBZBmFynQXb0+vDxFInUJs2wC4im52i0egqW0NlhwVh5WOQu?=
 =?us-ascii?Q?kDD0kaeSUPgv+mLGGmCJzHIoeCM5RTRGTD/eox5Ewvxqs7WuHFuuMGE2WHL+?=
 =?us-ascii?Q?D3R1qxU67k0URaSf+kqFnsEo8tpJw6jazjqPXKVpIDsq/79xFY+HLWT30Icl?=
 =?us-ascii?Q?1/R1ReFBsvu7LE3W48BzggtfLaDKK6C32ByYev3tN0M4NVaer9LkEIAPp777?=
 =?us-ascii?Q?xmNSGK4P0AgoCY+tSXg49DtWOxE76Ddzg2En3HNPugQZ0ZXfWP/bkKRwnQ/4?=
 =?us-ascii?Q?vXXUkpdzez3XbBQ0oQayQ6d1QmAgIxETLzzkjak3ZiK/asVrvxmERF9fG4jC?=
 =?us-ascii?Q?k1aiyp1f3DfKlW/NvFzZ3tnxnEnddeRthC0u/W0onUpApDLbKIMb9aDyr6sf?=
 =?us-ascii?Q?IeYVIhU96WD+39BJlr3hU7ONadbNB72cNLbCrEZDPui24+I8q9aTQDRdZIbj?=
 =?us-ascii?Q?hzHdV0p5hxTeYOnduIAgIYzhXZDoUXBqFphEAFG6HmUmwmjuIS/8NhwKZa/O?=
 =?us-ascii?Q?Zfote7MdZU7fke6Hw0xpk8R1fqMgFdh2UTSaIzyWMBfiiV818911pc6cNCtC?=
 =?us-ascii?Q?pb3SCDLRgVqM+tGFezVv4N981fHyNEXR/d0geCnNau4PrzGPeyUtwoW39u2O?=
 =?us-ascii?Q?5qhijWcPDpi/wh9Ngu/J8MeLK948PrabCQ1WlYVm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/zBUr97ylMbc+UBZ+AWq2Ljqbkb2cyNTLJAmEwvl0u9CWE8PqsdtnvkKlzHuKIP9dG0e0TxHdMXb/cWTqPGtivowUtVnMFiETCoIEGprAGwpcNiU+GvriFwtenzQEEpLrwz9u58h77xWg4IPvU6AbcdtgLDGwQydPxxArTZ39wmsFBZjL3PIhJVwW8rbfrfc/M6fagys8f1+G1mqAVu0ZIRlmZ0vg/3tIeuqj8PG/8o++IUJaSF8CbX5l83YyuGT4b42Q12HOtvUR9L93Q+soYbKyHSFWE3HopqT5qJsjjtY82wA0gdEjo/bqC+igvBKZYhF4kwX4IXBPd3+YiES4x6NrKqEbvMjtWE5TldhE4H2ptXkjfuUzfdnZumIAs1u0f6VKgtXt6mVmF4Ke/AohLUewFzm3uV4548r5I6zhny9U6pmhI/A/xF0FSgHdxNaskk2ZD5TfsLeNTxMAb2NdYZrNQc7EJH9Cfa1ipGCc5CCDzVkLlbEAMmC2BE1mDtMMnEtbmb3NyU3ALqr5UK2oRdXKpai9WtrJvlU0G5FFqPHO9Kur2FD20ePypyjpbjsYBdKiObx/gC1+oy4yrHkykQID6XQ5g4zbDyltAi+KLk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a452228b-3a13-4923-fa5f-08dca73956a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:53:09.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcPeoo8az61VXhAvjLAWFjUdb9k2AEy1hQNBBT0n7Xjn8/b1LvUcSKZlQW5gcI/O8b3wnKeT+olMlSJXmst3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_10,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407180096
X-Proofpoint-GUID: WQbRIn68vio4PJ7nvwbHWfc_ox3EWH5w
X-Proofpoint-ORIG-GUID: WQbRIn68vio4PJ7nvwbHWfc_ox3EWH5w

On Thu, Jul 18, 2024 at 03:20:51AM -0400, Dominique Martinet wrote:
> (Sorry for the slow reply)
> 
> Jeff Layton wrote on Tue, Jun 25, 2024 at 11:45:22AM -0400:
> > > Jeff, you're the one who suggested reverting the two back then, sorry
> > > to
> > > dump it on you but do you remember the kind of problems you ran into?
> > > Is there any chance it would have gone unoticed in the 5.15 tree for
> > > 2.5 months? (5.15.154 was April 2024)
> > 
> > Sorry, I don't think I kept a record of that panic that I hit at the
> > time. I do think that I looked at the original bug report and it looked
> > like it was probably the same problem, but I don't remember the
> > details.
> > 
> > I think I just mentioned reverting them because I didn't see the
> > benefit in taking those into an old kernel. These are privileged
> > anyway, so even if they are bugs I don't seem them as particularly
> > critical.
> 
> Right, normal users can't stop the nfsd so you're correct it probably
> doesn't matter as far as security goes (and this correctly doesn't have
> any of the shiny new CVEs assigned); I'm now curious why it got
> backported to all these trees at all if nothing needs it.

We wanted to backport the NFSD file cache fixes from v5.19 through
v6.3 to LTS v6.1, v5.15, and v5.10. Since it wasn't just a handful
of specific patches that fixed the NFSD file cache, Sasha and Greg
asked me to backport the full range of NFSD commits up until v6.3
to these 3 kernels. The goals were:

1. To fix the file cache
2. To create a platform in the LTS code bases to make it easier to
   backport the more complex upstream NFSD fixes going forward

Thus the backport of course included some commits that would not
normally have been backported to an LTS kernel. That has surprised
a few folks.


> Anyway, I really just started looking at it because it got reverted in
> 6.1 so was wondering why it didn't get reverted in other trees, but if
> it hadn't made it to any tree I wouldn't have cared at all...
> 
> As long as there doesn't seem to be a problem with older trees (and at
> least I'm not getting any weird hang or crash on shutdown on my 5.10)
> let's leave things as they are.

The only bothersome thing seems to be the inconsistency between the
LTS kernels. I haven't heard a report of a problem.


> > > (Bonus question: if that is really all there is, would that make
> > > sense
> > > / should we take the commits back in 6.1 with that extra fix?)
> > 
> > Maybe? The problem is that someone has to do the testing for this.
> > These interfaces aren't currently part of any testsuite, so a lot of
> > that tends to be a manual effort.
> 
> Agreed, let's not add more work there if no-one can quickly test this.
> 
> If it turns out some later commit that actually needs this gets
> backported to 6.1 we can always bring the pair of commits back when
> someone notices.

Sounds like a plan.


-- 
Chuck Lever

