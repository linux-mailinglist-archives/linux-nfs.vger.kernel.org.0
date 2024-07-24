Return-Path: <linux-nfs+bounces-5037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C85393B590
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6531F24A5F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1E915EFDF;
	Wed, 24 Jul 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RLaAGMJf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mKFPqBV4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D24157E6C
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840810; cv=fail; b=oyqtMXKBi9llo11rp+DA/IHFZC9OQ7GkDq7pVXcb3kK+V1xjLwbiXqP2wX3dNA8NIppACnwI/bBhOhtgLU1PUIbY7ZnyXXn8C864WBhr+IoUgseKc/KdHU9w85Kcg5Jvg3XbjKmbsBeVdAgdl+v6IlAC5NTw/Kps5c0Y8XlzlZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840810; c=relaxed/simple;
	bh=N0WC61L1+W1zq2Gpy8Gv2lT/y+I/PX/ErgaXSowBr4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CPB5ABOH8Vq5qomKBTM9ugOc+TdyNhVP8vvWQHz29SL+HhoFBHsyiiF1qaCBrx2djG2lohWFdiYpC1Wd/2iThhZSKQfxwPp07CnKXGwAnvoBmjQZ9p+uOeVubSGmCOLQUPj5E43szUrj2gjR7mEfRiBTqODFOizFyQkKWSzSM/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RLaAGMJf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mKFPqBV4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXkRQ030280;
	Wed, 24 Jul 2024 17:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=lhqqjAQy6R5Xh5x
	3gK6XyI5+IcM+1Tn013MTEHrlfwc=; b=RLaAGMJfye68HxVGL22N47K0jL4D9tU
	rdLNnWzzIAxYHxlTXXv+IjbrpUh1Q+TzE3XJysDeLLkqDImT7EXEZGWtGV3AXa4X
	XzwMpCmgnXqX9EIzKLQYQWcHBbxmQnfyQWiJ8+78DDpYTupjnLMJzVvpadP3ys5R
	5+sAtWQejv989rqDNKSu5U8IvahGddoT5jqINOcNmd/6JoX0PAONYOYNqnoS3lzL
	VPgvwXMc4ZlhPMb6XSLuY00o4EbMYtLcLbtFGp5oht/2ijsv9m/YIennsq8ehnwu
	Ew3DGbJD5yPbY0LMVKrAbOS93tgbwBaa+NlKUyYdxERYe8TAbqexGPQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe7hkyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 17:06:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OGeM7d024672;
	Wed, 24 Jul 2024 17:06:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h2a35sx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 17:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYBvyvCE58TI4urL0o2mkMq4wU6QqTL2hlVxSg6L4WsOyoA6TjSBYQ1h7TjuyMX1GTPEgJ74tSFahwMU3FDxmFbrDZgImNwZo6Fu/VgvVuVtc/p1Kn30qfXyFww5IvBjORFdSIPs/iNQeBjUPpDf1B2o2UOPOSL+GGMgPPfSozPSc0TwX/bzaY8ntcsalW5nodbnOKP71gCktC50FlS8Z7eEe2jzFy3NSkvlIk57yhOt7cnx8qZRGWvVkSxRuK7kJqWQ/0Tnj91zecMGhF5L2gqCm3hkjrQpxEaxO640VKIL9nwbCz97pPGlBP5A9BST2sLJZaW9yN+BUr9DjCPCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhqqjAQy6R5Xh5x3gK6XyI5+IcM+1Tn013MTEHrlfwc=;
 b=h+iQ6NTxzCysA3/TEJ9KjvXR/h4zef71IAQYixqCZ3bsaEipD23M+ICIqC0naEX9C4ATQ1/0Yi3BaakCSOC2mHzRmTIHgk3S2eFkDEP9b0L3gO6lGiye/uxofG6PPftWamNiE3xSVtIZ7+JgLa4MYrIc3UBbcoo0leqagMIdhITDDW6Q2O2IfAQAHG4zUf/Wtd0As+sXmXSLWZVQa+1HBU92ecIYv2nKaBOa8KTA6uCX5UkbJfVKZF7g4XusMENQR4b81Ivu70BoJO1fnjm12HRxe4NXCB6539ldZ/8woXRnUJZL8jDhVVvezu64pvr3KmBTZ3gdV3H2dqmbkTpREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhqqjAQy6R5Xh5x3gK6XyI5+IcM+1Tn013MTEHrlfwc=;
 b=mKFPqBV4/iXymqVYMyTEQtnjSZaKk9VP6tPH3PIowGVwk4MIK6ajKPZep9hAN1qTJwJ2plkjW5X6oR76AYIHF1kDe9juRlPKBE5bohtTN55r4qR8uNVFDA5eCusqw9wrUSlrbtqrocxgAlKDyTIb15gyJ3xMuIEOmQl16l6W7IU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7259.namprd10.prod.outlook.com (2603:10b6:610:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 17:06:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 17:06:29 +0000
Date: Wed, 24 Jul 2024 13:06:25 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org, aglo@umich.edu
Subject: Re: [PATCH rfc 1/2] nfsd: don't assume copy notify when
 preprocessing the stateid
Message-ID: <ZqE0kTRdRAibsjm7@tissot.1015granger.net>
References: <20240724170138.1942307-1-sagi@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724170138.1942307-1-sagi@grimberg.me>
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: d72e830c-b7cb-4d45-536b-08dcac02f579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kvRUFkjx0wboPNMiAW5kCFCBJJV+vWkgGcQPTOuFi6EGy5KhwfVkH08/w7L5?=
 =?us-ascii?Q?DxOYLmh3EBED7q8DeZcPEQWBDWE/NfHNeZyUnph4VfCwnc9svSx5hJYZLZBW?=
 =?us-ascii?Q?IhAxNp/16ZTbHqgrUyMYZyL3PFbtDRM02MO8SZ7EL6Zd5dSKXw+CQuSEQze3?=
 =?us-ascii?Q?PcIOEePx4D0jEB8Vabl0yaaERGyX4+0PEH7+iVQasDYB06PQ03q4gLUtXGxw?=
 =?us-ascii?Q?04HV18ZcQ2BGb5KySn+LYa75AbNxBSx8yGBaqrkWWUvjeNa/RCHK5HBIgyKk?=
 =?us-ascii?Q?3PcY/WQzRT0NtcwFZsnNnmA8RfhtxyLje31MRxPeUJJP2R0MaGxAzBoImjnr?=
 =?us-ascii?Q?r6Q66SKVoo8r3xNfXRbB4VGGxgzDM0wi9NXhxezn0exHgHxQPyPBc0S07MJp?=
 =?us-ascii?Q?pEoKCpaYUIr4zOoQRCrRyZ/7Y3fhgRcr2Sgcl91T6VjxMTxwN2VxJLECEear?=
 =?us-ascii?Q?SFfJbDSRtG9b6+bD91pG+rgquvPj6D1p4dErLdOdcrTHe/EpySLjAzZsRyVY?=
 =?us-ascii?Q?QaOVErkVaZRpoA8dZjElBDjleAQRGaM6pHXP+oWe8L0rxzML6gV89TQp5DVV?=
 =?us-ascii?Q?Cohy9/6YFA/YrO67lCet9EQlhwfEKSN16mwCOZseqX7AFPYcY5w4AlC2ULaA?=
 =?us-ascii?Q?E3BE5p6cMnStfAgRGVF9nTngZKhvia4dUoCovkJJg1bf+4YHp6B7PBLHn+zO?=
 =?us-ascii?Q?HtHw7U6GUo2N2veFKyiaLVFaUdkTGTwM+a01+FMP+82J785zzptgqYrGU0/Z?=
 =?us-ascii?Q?JKegy59ohObfKhE6eYtoSvxz5eTTlD2Khgmx0lm+/KuDY4TAeyt6MDVz6f1A?=
 =?us-ascii?Q?87RpZurqJKHViGr1G8bS1PyCh9KCI0nUY8Wyx3GPs/Ak7Z/nkz9wSV62nz85?=
 =?us-ascii?Q?LWGhH463hIvxxCV4q4kFopqiSNR0Bq1gYYJngnfCq5tAh78l/IrzrW9bD3CU?=
 =?us-ascii?Q?BfFP5XjLoQz09guEGZJwA7O9dzkVnYyKL60YH4PToqBSMpJEU0gFXurrFuE8?=
 =?us-ascii?Q?c9jQXA15lbf7sbGpJoiY6c4EEf8MjkekFPPzW9eHX4A0M768FEwP+rrCG5DE?=
 =?us-ascii?Q?Wu4r6Lp/SehgHDGGAH35HJkDInyWCcg9RgKJ5kE2lAd5KGQhZBuyeiOJmmKC?=
 =?us-ascii?Q?XrtJS2seGxAaT4AxCAEYc1YOwIhp/ordFgip+D7CZKRiOr/EFgzFPmhcTBtw?=
 =?us-ascii?Q?Tnz4+2Ygu7f7nXWUf87xy6yg7vj1LRCVwzMo4c9q33+RktF/C1xxM5tH2xKk?=
 =?us-ascii?Q?DY26+nwyPePmE6nsAW0YxSAFOBI/xvCJkNaS+uBcF1Ydit9Q1zHHVUot/7tA?=
 =?us-ascii?Q?XbvSioh1A32/EcS7c9kLpoLLLtjvfKW2DtAcEZmdwXYszw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DbbEX9l8c7hxSLBV2hQK0bV/+4JFnEoBFBwz/M53Gbd7G4e2fqq1Uzx8SwQf?=
 =?us-ascii?Q?EJcwBQ0Wi1V9cFMxWkSWj1oDXs2PGurPlJ1L2UrGr8RHWfMNjz7vsc+nJYXO?=
 =?us-ascii?Q?9efG2tgKmZPK9y55SgBNl5EQ1Mjg7vwlDsEWg00EpVkFu2OL2vIGKlJLWgim?=
 =?us-ascii?Q?WVNgXtrz4rYxljsLMuuyo3fn90iRn3YA8gicXKThD1tkk178mXWDRPd6RNl+?=
 =?us-ascii?Q?pRGgpn3u2M82RsJ5aLEU81NEJ1y80Z84epP0+9jjs0fIG6MBiuP5dNl+L69+?=
 =?us-ascii?Q?0k7GlD216GRrwFzdAjBqimx1oSgYY6H1+kFizFHZIXMBTSmv68T0CYWh9Rer?=
 =?us-ascii?Q?4wuMRBGYogxjTDchENzz/fgn/+T2NF7UobAF9ntPPLGUhmWVV1XAaWNENRaT?=
 =?us-ascii?Q?21BsxWrXcT71ko5xxUsGRTj5oG16ZzkB+wqGdz46Ev5Xdnc9BOy3YNNxJnJE?=
 =?us-ascii?Q?AXCv1C/a6RNDfkG+ep8KilfMzdQ6Raw/FGsif3MOKiJMKOpzLFQ45poKiaAr?=
 =?us-ascii?Q?I5cHxjYr6CIXncFxm5o6U37ZzcMXcdbUoZxdDxxOgXapG7zHmNi8m5IbR82p?=
 =?us-ascii?Q?3s8rjJXZgtQ38tc7YKhK5IYckHtjZd7O5+Mri4W0ffhjV/DtCut3zRGKRhAL?=
 =?us-ascii?Q?kGleEbnlNkbzxbqTuErdoSGsQn6JoULTRMYxgC++2fPeLbZP7c8F7ZaXHbp5?=
 =?us-ascii?Q?E09BwOoEJ5YAtPEoi00d56SiyHqH5BizvKxz8Ldh9t8nysWkzCVwQ8lz4Mid?=
 =?us-ascii?Q?emTjZyVMxgj6ESy0jrhiitVg2hKnaaxNGSgsSQT0vhy0exDo2m1b+7i2e8XQ?=
 =?us-ascii?Q?oT8SqCA0twV4Rjlb+RmxvpBql4T0QHKcVSWJZ+gZBQdpNpF7YRQ71LeNNoOu?=
 =?us-ascii?Q?cbCMxagWhapEBLRufu18zJ/v0+j9NqdKOKWftKir4zZByByiIOe6I1zf46P1?=
 =?us-ascii?Q?kWjSL4PeGhTkmX+UXw031OpZxayL81t0PaUj5DQgGLTNNISG2318czz/OBqZ?=
 =?us-ascii?Q?bvclg6eVcr4jOyJoKZ39dZOrRsvDd81bxn68/DiJsgWy07RfZhUdHDklD3k+?=
 =?us-ascii?Q?lxXvvsZrs8jLCnQo+ylYxafM/qEmdXuaxfBnwXIjPidur3PM5q8h9nyODVxE?=
 =?us-ascii?Q?hdNDRjZodR8IjX2BMvPKIXBx9Kc0VtYlgGKVmRod1LtDngYzg9n+X8yaemKo?=
 =?us-ascii?Q?5O+C8DW9EiuKpbcDiJmVgAS1F7YpBU1uU6N/IeFlNr5S4dJ6blruhofXGZrE?=
 =?us-ascii?Q?MG26Rw/2zaC8qyFoDxlVdfi4wp7wBtvlxD9J8GbaqYrylSZUXcsJLvMYa6rB?=
 =?us-ascii?Q?yLWiel+d87I+R5q5ZM9M/t/S70cxNvFNFW86oniHCOjrgBo060SRI2QeW1vx?=
 =?us-ascii?Q?2R8JVc7sgHE8/9f35qmOLEJUp2aMzsVuANFKQqPbJmVNFuERptWi4mQq4FpG?=
 =?us-ascii?Q?PGUqosQNPQP6V2CHnHjytTnKchglmolGAdZNUVC+7nrilD8hdOdOSo1MUUGA?=
 =?us-ascii?Q?ZLrmXiwn4YAdYaQRZ7pmoZYdblxfIQdjVZV/+o9duTylmlMm692wD0zUWYRX?=
 =?us-ascii?Q?6WRff+DGgB4IemsmymWJ3lcDGugr0aanL9659z1i0/oUnSu4IhcSNzofjXh3?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rsOzQsi9dnuN3ZtE/tSL6vbF2O4LiuJiniYXq6iVXZTbkk3aJE7PxWt+P1XGNPIiQKM9b6+t5HsnX25/X5wBWPzXRxK4UgcxDFMKa2Ez7g2pLHNHVHhVYttslxehwFbLzMlxAJkU+woXnNynDWFrEUndbcZ/IW1kk+bi98MtdCMXbFUkdYgqHmwgQ8pMn8Ffg0swTsfDeIYos9Y602J2EEj0ej+wSlSKIRhCEe9haq7O9ZDxXu+8OhIy/0VchwH5tM609fJBsbsh8iyH3D0hVPOr9odgc61BllDVpS/9DB4r1UvgF/2/M3p0BrXWjWo4HksSMsuIg3loyU3ueISYb02xgh3q8VMCjSHiGyLfJf5Kna8LkXGxrMVIkq09754JkpNo/k4FTsW/QQ7hZqPTqV7b32ORkgOWRzCflu5vn3s12z6d9wK9mB0FxH+qVsl8rTo3xOvqVVS8RoxOHBUjJizcVw9t1h2ZLpLPVR7Ahy5c/mZ5fm9k2swhTjALnp+3LdxVAI5XNUkox2X7hD1CNXn6OrO0khx5E9psAVl+N/GW3wPSQrgzu6UsQappzB7atLk4g0jgz5nhs+zLlP9PsTLMSKxYuSHOlFRxzA9aMRg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72e830c-b7cb-4d45-536b-08dcac02f579
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 17:06:28.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Os6NA0twiF1cHMvgUsvHxw8g+VKu/FXNIvLSRNUeDudsTTBUQuhyRsdb8Ms19Mp3LIR6+Wc8G8fM8KloXm0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_18,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=910 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240123
X-Proofpoint-GUID: nBCcWo3n9GgPvceW1Si1cFVSezir7n90
X-Proofpoint-ORIG-GUID: nBCcWo3n9GgPvceW1Si1cFVSezir7n90

Adding Olga for her review and comments.

On Wed, Jul 24, 2024 at 10:01:37AM -0700, Sagi Grimberg wrote:
> Move the stateid handling to nfsd4_copy_notify, if nfs4_preprocess_stateid_op
> did not produce an output stateid, error out.
> 
> Copy notify specifically does not permit the use of special stateids,
> so enforce that outside generic stateid pre-processing.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  fs/nfsd/nfs4proc.c  | 4 +++-
>  fs/nfsd/nfs4state.c | 6 +-----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 46bd20fe5c0f..7b70309ad8fb 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1942,7 +1942,7 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfsd4_copy_notify *cn = &u->copy_notify;
>  	__be32 status;
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> -	struct nfs4_stid *stid;
> +	struct nfs4_stid *stid = NULL;
>  	struct nfs4_cpntf_state *cps;
>  	struct nfs4_client *clp = cstate->clp;
>  
> @@ -1951,6 +1951,8 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  					&stid);
>  	if (status)
>  		return status;
> +	if (!stid)
> +		return nfserr_bad_stateid;
>  
>  	cn->cpn_lease_time.tv_sec = nn->nfsd4_lease;
>  	cn->cpn_lease_time.tv_nsec = 0;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 69d576b19eb6..dc61a8adfcd4 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7020,11 +7020,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  		*nfp = NULL;
>  
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> -		if (cstid)
> -			status = nfserr_bad_stateid;
> -		else
> -			status = check_special_stateids(net, fhp, stateid,
> -									flags);
> +		status = check_special_stateids(net, fhp, stateid, flags);
>  		goto done;
>  	}
>  
> -- 
> 2.43.0
> 
> 

-- 
Chuck Lever

