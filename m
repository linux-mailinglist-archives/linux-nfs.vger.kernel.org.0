Return-Path: <linux-nfs+bounces-7187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A599F604
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 20:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F76A1F25BEA
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25573203709;
	Tue, 15 Oct 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AWWIZVqD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JGjOWKGv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2A2036F1;
	Tue, 15 Oct 2024 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018222; cv=fail; b=RpkWK78Sto8tw6e2NMhhA2TVOvJ68///+gT5h4fu6WBAgDqFnRvJYPymwhE/xLn58LncVFOxxG0nZ/oO4Va8I1BdqLVOgLlEFuAfLUf+96fA1QC8j24+zUvdccA1hqh50BxuhuCRRv35oz9pHnpuKyf5mz6/KEGvy0ttF2xZryE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018222; c=relaxed/simple;
	bh=eAv2Mzx4SLKM3NXSB7fXqe0sRj/j27lzePDHMiQH2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tzvr8e7KSMbBVESfHfLG9t33B04BP5t5TVJYzodDC/ikwFIji12ufr6ciPr/7ocNF/ZdHNtSawIUdTH4jkCHCjNWTORAQyaK5lFE4FgKkxXOGRCJGsxkz8pqg5GtO9lxKiYrL+uUzcVGoCDm3QxJjPyEsBa9B05+wvyaHBj0ww0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AWWIZVqD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JGjOWKGv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtinY001644;
	Tue, 15 Oct 2024 18:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=33rTQ1+6PqcyJ1HyLE
	J8uyvDMYPxVD0aKqeZcBGk5DA=; b=AWWIZVqDmylAuaJwcKOqySw/92hkwod4Wl
	Ll5Sc3YBWX6dUvnM/FQRsZKoh4ZYVJfVU43tANL5NUu2u24mirtdZ/Gh9HB436zQ
	D2vUxJzjwfTtCc38TohkZGZDgj35ajso3eCHjIXMpUAkQKsPbvlzcekceyAl6XjF
	6K8OKgSsm2YiAfrkRNcrNTknPrpMN7GoCfMrTnGgeW63u3pevzveLDIMlwv1Abz4
	wGQlGuv8/1ZzRXiybJXQrCTqIqZT4F7hDd5tiq2eHjH479JiLB6Ke8wHL54GDyxB
	0ZvIDYx9Q/WiKQKJ7OwGky1cUGkKFmqhEAZSqNdjXJeG6uVW18gQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ahsff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:50:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHDSja011010;
	Tue, 15 Oct 2024 18:50:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fje5ma5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:50:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKyOHQdoly1hzeL5CfeeGRiSK9k0NxvESlx/YHkSZ8tD8qr8k72IR/bOwYEjDf08OIoPPQq6mVelf18TkEtSqi73UXvmKuxg0WGrBzvK0UYyHnQy7Hool7CK2O02TAeU3A+RvRjbQIhJ9RkSW+kuUrml4KWjuFn2MhuvJeShR5wgnYaQ4IvvuKHZGfobKoJ+FPuuMAWBEf6CgfNDJS1vfaao7AeFotHe7j1gB4zs+QengO+Vg4cWlDeOR9tyIRuDHkwtyLtAYv+LT+21m5rgeEVf5O3keqE86hN5qqnRz6Ivamh31vmbxfcy80d/pJTBDi+OijGXuZleX/q05AmaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33rTQ1+6PqcyJ1HyLEJ8uyvDMYPxVD0aKqeZcBGk5DA=;
 b=PF9Cnl8iGeEOAuf61CY2lKrhu7IWkJV4zhw89x1Dt3Qk9SLLARuLJZ3MrcX9ai3zKU4HDdiU6f9p0jYnDcrh/phs2gwotaxzmc71oWCyuxWq0AcuT5ObE8HPVayzF2F/BcHeHhAWtxU2aMGzsF9w0agvGZoa8tR1TCRZl+05q9u+KYllTVnWQLsaQ7B2DjOAS1Pr8rwVCsnQKkVxa0DliY45z9bOnxUEofi/+TL9j/OZH0/r/L2qQ+s93ARtehQg6uLeL335CiSsqoCCKYr1Y9Jr/tRomcQtEUNP1+i0uU+NRUD3UvvZRGyMtnCMqP5iDUJQhE/ZtUXpupyNJRvQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33rTQ1+6PqcyJ1HyLEJ8uyvDMYPxVD0aKqeZcBGk5DA=;
 b=JGjOWKGvMhZIgGCZ3TtD8tAyKPlDty+3IZzL1dEv1X5NZbIBbBQuCJkXFinkA48+vaNCY5AAT7BRVhrpq6NBf1bhReq7HxGvTkWorQtaIq3ILHko2vMUbe8wBJ744X8Gao4Qz/xHxMnDdevi4LUbpiFfXowxYcmo0cz16R+VQ9c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL4PR10MB8230.namprd10.prod.outlook.com (2603:10b6:208:4e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 18:50:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 18:50:04 +0000
Date: Tue, 15 Oct 2024 14:50:01 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Thomas Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] nfsd: drop inode parameter from
 nfsd4_change_attribute()
Message-ID: <Zw65WTsgBnhId8mC@tissot.1015granger.net>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
 <20241014-delstid-v1-1-7ce8a2f4dd24@kernel.org>
 <Zw60mgZaLZtGWWil@tissot.1015granger.net>
 <a70e34202c13ef2ac69f04a153268950b485781a.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70e34202c13ef2ac69f04a153268950b485781a.camel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:610:11a::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL4PR10MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 42480fd5-2736-4c39-c6b2-08dced4a2e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y4e0hyNliPE+gAb06psMLa7MODGhaPA/xcAdahrL8UdRfMRpt9EY7iY3396p?=
 =?us-ascii?Q?9TDOiU8BCVW3EGErMNEcKSpSK65LZ5LIqGyIPZhdvw/ap3UPFb5prN6HpJuD?=
 =?us-ascii?Q?lmR/9aOZtI9FocmlhluYGrcuBXMAEKrtlr9EvKXVsfd9EujP0xBAdUrQ+nuc?=
 =?us-ascii?Q?cHx67P6cYCwm9LSyW4ELiSDyloQa/I2Qx8sk1p73fR38oLQPlq2w7dCfVug3?=
 =?us-ascii?Q?2WHON1H2Bc65ihSnzgEsLbI8XyBdRFFWqYXwjObZEOLrER+yBFd39rMrVbDR?=
 =?us-ascii?Q?/2LE8QAJq5DlvdNIGIvm74r6eZ3kiJPuT0ib3ls6mPZ/mvyyw1gh1BMPgq92?=
 =?us-ascii?Q?77QudisTfjhkq7GUtpT56ZaEkbu6kFj/MT9KyMjd+o2rFVGOoikya+vHtV2N?=
 =?us-ascii?Q?UZT4zIiNunsv3NBEw6/hCMifepjofu6yXlZMF8i8pt9TY19TiqNJdksl8PEd?=
 =?us-ascii?Q?2CJLNdexYAViaL9QrhVwafSj9yeN4+EVN0U+yT3uTBd2eBD+EHJwA9Ts3x07?=
 =?us-ascii?Q?BUd95N/uWUWFc2DcWlWViJjEgzOSN+A2oUg6+7dLL85f63zi795fYlcob6Pt?=
 =?us-ascii?Q?CfPagdx2VGwX+P4z0RB6mFkwg1EffsE4g2KiUUCSUrI6v7UyAbC1ddlxnUYi?=
 =?us-ascii?Q?+I+NHnOZqrEGVBWgY37lV1cs2CF4lHluRAmqCpNt4XL8e/ZjFVxGHY6tqT7/?=
 =?us-ascii?Q?rAgj45dDV/2cLjIcz0wt8oUNnEZhhKJb4f86J680J+F0hqP7vlMwwTGbqM4t?=
 =?us-ascii?Q?mP7MKaBXShZFWVEHeS+SwWMtMbqe7iH2DwP/cJ0qBaMxT/9JZitt3+b8FaqK?=
 =?us-ascii?Q?f3usIZGTXiZU8VsTzr8vw5U6UZEo0PX5a+MLpXc5Bas7YMwYPR1S2Ezzpal+?=
 =?us-ascii?Q?lgDz36SHLSAQellrxK25kE3fOQG7u/GiWTSQO3jXM4VhczgC2uc8q7trdWQu?=
 =?us-ascii?Q?dkltz7QWWy593ZIclkRdRYDeewi8FonUmzw646EMRXCqlSke0KTemOgI52qI?=
 =?us-ascii?Q?KDmFWgkrcGZQZoHgZ389Ehz8Sye4evJYSS9fh89ElyQ/r+nDnvXSJbntKT2f?=
 =?us-ascii?Q?9uXlDMp+kvTJ3pyAaoYmKwDEwdzkLJJLV6M7Qp24D+Rvkd9JwgFJZX6ouYxn?=
 =?us-ascii?Q?9tGjPijwBpg4CvllbVQasa2K+J0CtyKVs9ujThFb727C/GtMNeFjqtzIOjbA?=
 =?us-ascii?Q?xMzcHEoiOys7BelUv7m8Y3nMbZUANP+zilwGXyK6ljQa4HpxZCIxopPNpBCB?=
 =?us-ascii?Q?dQqJYfytz0XwVlhvlAMji+JO+Kl13ltqbO0u/YmS1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wnW4d4WjbpRKDJ+4+n0aToF/LN8lDKzMmkjm50EFOYScb0bslurSxcz3YOb9?=
 =?us-ascii?Q?n1ETys19osrDm7b55Jyc4/al+badI9M8ZlPsiTYEDdGVJj3b/BgNTHBOQt5Q?=
 =?us-ascii?Q?+CJfoo/Kr/ZCEXCV9PHxJ8yMTfSOudxbKu/oDolRjZIySsz6wzrsinAALMIs?=
 =?us-ascii?Q?HokfCi4oZtQOv0n7YeHBv2uP6gAhSk/sSJA6NVRBo7csfblSWZO0caIsAW/y?=
 =?us-ascii?Q?tmbaHOrrkvNOfl98Rl9H4zoseo5ingk9OgfQfV1NVpVqQ+cu8uVNqtyYfCXT?=
 =?us-ascii?Q?iIsE7dsjCSeJMYe5+Y1b5gyAKV4m29X/xYPjvMKjFTASnvJulzLPZ6LRon9i?=
 =?us-ascii?Q?0X00mW+mkq/XkG7Tji1gCnT64P0LCJnATBcD4bVXy/ynirATcSkShDBeokno?=
 =?us-ascii?Q?lvCyytlxaH/wLjH76adlpCh3+Tc3pByYzIwCEhbfdOsq0Eu+JKg9tHgO7qbn?=
 =?us-ascii?Q?LCneFUVYbyWEpnOh7w0fy9hpoS8UHnr2onN2x1FM3/fgPFNP7GbkcTBJK1qM?=
 =?us-ascii?Q?R/VNjLffm2SDP143QHQ0HF6C9UwuD9ygCKvjG/mIJG1Z5dWSF0kCkraGPFCO?=
 =?us-ascii?Q?ihb8MdrAXVPlI1TioVqP1mv5g3YPl9rWjhRAoBSvCbCCaz6cZ+M6AnEok0nX?=
 =?us-ascii?Q?q8UX8mjhV5t36UrpMG2giNUEdcQhK1aPmg2gdc+O6iBlifbiUWqsIAiDSZO9?=
 =?us-ascii?Q?swpVisoBY4KCJtxbbubXX1uYniM6nDxHhVyrBMA1BDFMOpW0i7Txj4MUKCEW?=
 =?us-ascii?Q?3gAjCB7Bu8cmnpzdkHTMmIdqFhDxZ1InYHNrvmcaWE3pKtCxEYIljD2RoHoz?=
 =?us-ascii?Q?z9JoGGQES/0dD3qv/cbXZME+kuh280xE9Cm5CjzUli9CmqJPBjBKe9fW2M1D?=
 =?us-ascii?Q?Bzsmop8QbsBbonq2RcNKUOiCLWrPeR/nLF6uaOLWEmzTasLiC1Gp/JDunHmP?=
 =?us-ascii?Q?z4Fx0kz6TzgHNGlbjxCu1PZq/MUkooitfzCxxKpsvPke458Y21aa03vnATZY?=
 =?us-ascii?Q?vhu5ea8SYUDGNyJx3LWk3h3PT5NTbDQ5kvhsuRC9emrvzYssOxC2xJz1eVxv?=
 =?us-ascii?Q?kh1y7fjYscQMrg+/JNcbOgcB/ILvJaaGqdUCPdLOd1M1DJl5jna0KR9NUIFR?=
 =?us-ascii?Q?EuA8pozg/V2Z7gzGnQbjH05A+n7B0M5hjyJLJfQuP0rcq09dSFvhQ7v1Y0VQ?=
 =?us-ascii?Q?lbxKJIxx3K+wtth9VFpBbbTV34k5IgAdjRNfD2hX7vOhFxcvyUG2EmSzdV3e?=
 =?us-ascii?Q?mpudRraoOR2fsHndulJwZCKs9u6uavt8pIyng9gntX0Wwx45vdh8TUJBSQEM?=
 =?us-ascii?Q?Ay5a17GD6c6hgiKTF2ODhaoWglWS47d3fZjBqOaUvwH9QXoPJEmQSzHKX70z?=
 =?us-ascii?Q?YEAqpjBGfdwqXTg2N4BdtQexty20su7zCyPQuwGo4tUqx6mLfcKGWYJ2jpfZ?=
 =?us-ascii?Q?HAPybbTNSajFPtrzfmajlOOHhlCVCfLKpCNxjINXkFidgNfsBD30VBP5/hsv?=
 =?us-ascii?Q?jsOdLjwRhwxblDWaqQAPnNoFTSbTmTDX0SN77DvehCS+YrDCQXlGXWtUSG6+?=
 =?us-ascii?Q?R6VYRcEO4WwZPssRNRWxtrKa7a3CB9bASAIKFl4/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zqDNXZhD0S947/Tawt10qbF73wx98OsKcdE/Vud8WGAl6BPb8zR7fZS4gdCxChOhEFKqhAC6KsDLAxe7/cyz9AC/gAdY+1KAseQ7k0O6cZOLSyKW4v+xLWJ2/8b55Vb47sWuLXEDZUxrTrYEf/tHc7rmjQW7/yjf81Na9ltwgKA9QK0RiFtm6XQSiOmlXVrU5QfGAWabV+FybPPjg5PYKueOJgrgXmRv6qFSbJXipAer4yhD2rUB4RwHZVXNxkHzl+eKDcv4gh7/pTnQ4UegLNRYQ9LWw+128sZYiPQD6bUro0vgVmB5y2T/ma+1Knw0DQNFzo34BoAUjySw2XFsLHdED7zatw5QeZE9hxSkcgIPKQd56JAGnwv1PhbxJviT2hCqMgwfbS3d6AQsI+ZHd+drs4sk3P4vHFE+qz7fhmSBpRFwL7qISXt7PspIfIkeMRIv/fXk2W6yTaLWF1V+ULUiy99K5tusnlk3zpvqtmE3TM8xdvOcpA3D+k842UMTWklYsM7ODqsOEnO2jU7EwV+fqLH9n8e7Ctgj54SxWWNLtXypuKttGg/4oClmJBWc3UPm+awbkyWL9TXt6XvGztqN+KzPq5ohdI55xsYOJ40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42480fd5-2736-4c39-c6b2-08dced4a2e82
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:50:04.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ajc8gBtAlKHlES+AVLwo06XZ1dGQPm4lxcVNIpp3lk+LcywFSOHwFd3WBbZNZFqoQvRRSCP8niBp0Uqojs8ynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR10MB8230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_14,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150127
X-Proofpoint-GUID: 1LnQIaMXioq_S0XJaVQvK9qAMJxPzZvJ
X-Proofpoint-ORIG-GUID: 1LnQIaMXioq_S0XJaVQvK9qAMJxPzZvJ

On Tue, Oct 15, 2024 at 02:42:10PM -0400, Jeff Layton wrote:
> On Tue, 2024-10-15 at 14:29 -0400, Chuck Lever wrote:
> > Hey Jeff -
> > 
> > On Mon, Oct 14, 2024 at 03:26:49PM -0400, Jeff Layton wrote:
> > > Fix up nfs4_delegation_stat() to fetch STATX_MODE,
> > 
> > The patch description isn't clear about why this change is needed.
> > After reading through the other patches, I'm not sure I'm any more
> > enlightened about it ;-)
> > 
> 
> My original thinking was that this patch was just a cleanup and
> simplification, but now that I look, I think the inode we were passing
> to this function in nfs4_open_delegation was wrong and that could throw
> off the result in some cases.
> 
> Maybe we should add a Fixes: tag for this:
> 
>     bf92e5008b17 nfsd: fix initial getattr on write delegation
> 
> ...since that should have fixed this call as well.
> 
> > 
> > > and then drop the
> > > inode parameter from nfsd4_change_attribute(), since it's no longer
> > > needed.
> > 
> > Since nfsd4_change_attribute() expects @stat to be filled in by the
> > caller, it needs a kdoc-style comment that documents that part of
> > the API contract.
> > 
> 
> Agreed. It needs STATX_MODE and STATX_CTIME. It can also make use of
> STATX_CHANGE_COOKIE if present.
> 
> > I can add one when applying this patch, unless you would like to
> > resend this one or send me something to squash into this change.
> > 
> 
> That sounds great. A kdoc comment over that is a good idea.

I'll make adjustments before applying.


> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs4state.c |  5 ++---
> > >  fs/nfsd/nfs4xdr.c   |  2 +-
> > >  fs/nfsd/nfsfh.c     | 11 ++++-------
> > >  fs/nfsd/nfsfh.h     |  3 +--
> > >  4 files changed, 8 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index d753926db09eedf629fc3e0938f10b1a6fdb0245..2961a277a79c1f4cdb8c29a7c19abcb3305b61a1 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -5953,7 +5953,7 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
> > >  	path.dentry = file_dentry(nf->nf_file);
> > >  
> > >  	rc = vfs_getattr(&path, stat,
> > > -			 (STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> > > +			 (STATX_MODE | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> > >  			 AT_STATX_SYNC_AS_STAT);
> > >  
> > >  	nfsd_file_put(nf);
> > > @@ -6037,8 +6037,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> > >  		}
> > >  		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
> > >  		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> > > -		dp->dl_cb_fattr.ncf_initial_cinfo =
> > > -			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
> > > +		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
> > >  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> > >  	} else {
> > >  		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index 6286ad2afa069f5274ffa352209b7d3c8c577dac..da7ec663da7326ad5c68a9c738b12d09cfcdc65a 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -3621,7 +3621,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
> > >  		args.change_attr = ncf->ncf_initial_cinfo;
> > >  		nfs4_put_stid(&dp->dl_stid);
> > >  	} else {
> > > -		args.change_attr = nfsd4_change_attribute(&args.stat, d_inode(dentry));
> > > +		args.change_attr = nfsd4_change_attribute(&args.stat);
> > >  	}
> > >  
> > >  	if (err)
> > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > index 4c5deea0e9535f2b197aa6ca1786d61730d53c44..453b7b52317d538971ce41f7e0492e5ab28b236d 100644
> > > --- a/fs/nfsd/nfsfh.c
> > > +++ b/fs/nfsd/nfsfh.c
> > > @@ -670,20 +670,18 @@ fh_update(struct svc_fh *fhp)
> > >  __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
> > >  {
> > >  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> > > -	struct inode *inode;
> > >  	struct kstat stat;
> > >  	__be32 err;
> > >  
> > >  	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
> > >  		return nfs_ok;
> > >  
> > > -	inode = d_inode(fhp->fh_dentry);
> > >  	err = fh_getattr(fhp, &stat);
> > >  	if (err)
> > >  		return err;
> > >  
> > >  	if (v4)
> > > -		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
> > > +		fhp->fh_pre_change = nfsd4_change_attribute(&stat);
> > >  
> > >  	fhp->fh_pre_mtime = stat.mtime;
> > >  	fhp->fh_pre_ctime = stat.ctime;
> > > @@ -700,7 +698,6 @@ __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
> > >  __be32 fh_fill_post_attrs(struct svc_fh *fhp)
> > >  {
> > >  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> > > -	struct inode *inode = d_inode(fhp->fh_dentry);
> > >  	__be32 err;
> > >  
> > >  	if (fhp->fh_no_wcc)
> > > @@ -716,7 +713,7 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
> > >  	fhp->fh_post_saved = true;
> > >  	if (v4)
> > >  		fhp->fh_post_change =
> > > -			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> > > +			nfsd4_change_attribute(&fhp->fh_post_attr);
> > >  	return nfs_ok;
> > >  }
> > >  
> > > @@ -824,13 +821,13 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
> > >   * assume that the new change attr is always logged to stable storage in some
> > >   * fashion before the results can be seen.
> > >   */
> > > -u64 nfsd4_change_attribute(const struct kstat *stat, const struct inode *inode)
> > > +u64 nfsd4_change_attribute(const struct kstat *stat)
> > >  {
> > >  	u64 chattr;
> > >  
> > >  	if (stat->result_mask & STATX_CHANGE_COOKIE) {
> > >  		chattr = stat->change_cookie;
> > > -		if (S_ISREG(inode->i_mode) &&
> > > +		if (S_ISREG(stat->mode) &&
> > >  		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
> > >  			chattr += (u64)stat->ctime.tv_sec << 30;
> > >  			chattr += stat->ctime.tv_nsec;
> > > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > > index 5b7394801dc4270dbd5236f3e2f2237130c73dad..876152a91f122f83fb94ffdfb0eedf8fca56a20c 100644
> > > --- a/fs/nfsd/nfsfh.h
> > > +++ b/fs/nfsd/nfsfh.h
> > > @@ -297,8 +297,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
> > >  	fhp->fh_pre_saved = false;
> > >  }
> > >  
> > > -u64 nfsd4_change_attribute(const struct kstat *stat,
> > > -			   const struct inode *inode);
> > > +u64 nfsd4_change_attribute(const struct kstat *stat);
> > >  __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
> > >  __be32 fh_fill_post_attrs(struct svc_fh *fhp);
> > >  __be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);
> > > 
> > > -- 
> > > 2.47.0
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

