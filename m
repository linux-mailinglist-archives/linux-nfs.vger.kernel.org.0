Return-Path: <linux-nfs+bounces-8128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C99D2ED6
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 20:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20631B2565C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6744915443F;
	Tue, 19 Nov 2024 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jB1uIHvk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IEGGq53B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40A148FE8
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044548; cv=fail; b=mwnY0wNoCeu3mZsE9J7JvIda/NZodmxnGHLZcMgSov+C39yPBhBDYQNeknuNEDlscjfiTiStdXwJU40XAel4f5w/9lYqCvNsVzYVxHBEOUJdfW+tXU/zkdZLCpckyldme2LFzavqC5JGbX3xdg5xaryRZcrwaxhwqo7s1jlUHPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044548; c=relaxed/simple;
	bh=qZWqLLpK5wsWVhYQI8EK3Gchkct318BYwX/Z2vdCauQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvCaZ2nmtTycOSKiEGhNJSvpTcLYGIeeKqE2Xfd34ttpWXaOi7QjW9IzhnlqQR0clDWhrSTfG1a0B+rf0CMasel0YDFA3LnsDrWgdA/HT9ygC0G/NS+gshxQCAu6KV6XLUKXS2MtaG6xEv2DAl9nu/y3AcTzEguAo/ZXSqtZqKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jB1uIHvk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IEGGq53B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIMYH7027718;
	Tue, 19 Nov 2024 19:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=iVrqkj2rgkOcwM9U5i
	hWxiyfhKEUwyaGO74cXl01OwU=; b=jB1uIHvkUPR8UaKPWyyAwt0k/k3VaTu70D
	YwFB5aYqzyf1OSq7P8YwIVcCTu+V/SUWeyr+FCNZP/Vhvb+4hCo9UB74lmHFNKFL
	5OsBnsBPPEvFCubKUXrQod6sSV0JrJXEdC7po0KZT8ZTJYOXeh2AeZqQLNyrEQu/
	lZakT9y0zH1da4jUaDJwpEOBAwvuXRG0p9AcZmt98WwjfLagNG/ujH2MgrAZ1o85
	5jdCl4dwWxkoxXmOox4AY5nZkSrdDi2m4MnsGjSS3W6ffKwPfyBAG8XNY5Uv8uPZ
	cqUpP2ujyS/RdN9eWkiioefmCywQbAZzYDojxjVNFLNkduisAcMA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebwve0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:28:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJJDJBx037210;
	Tue, 19 Nov 2024 19:28:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu972ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKnU9qkLh3schL4doeRIez088R7PO09nkC0OQgcGVtHs1rz6WFaCLQEzVaX1rCXP2g+XuEt6pTGOK5+7UhLOjOgCIm/nSNlN3Ig7FzzEKwby4ZwuF+Swt+i22JFRW4Wi/2ERtaILOuQyDg8YQogUXH+W+abqswjjmlYTetiR5JmlgHidHKFYBkX9FfLcizW63PJ8RCoPTygC/O8fTNLILh/6qyUr5SxSn37VgYfW++qYBWAj3vGpGeGIubFnRc0Aag3a5rieew84s7mjsJ77hr9aipKJAiDsTaeEjPleDX/YWigVztdGCYTAMeOSxhomMLCityzgj8PPdqo0yVXvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVrqkj2rgkOcwM9U5ihWxiyfhKEUwyaGO74cXl01OwU=;
 b=eDpLDUdaJI7saC7OHpPoy3KLZZ9YxkCVTWs6PKmlUrl8SSP4EvO9qFbsWhZiQoWakCjx2t9bKdF7Fty1nikLwYfQbvkbrIdMHHG2y53V7izF69T07oONQtGXoV9Miup33rgzNx5n0fYL9xFPDKDSBungeO0fy+mdSREB/0OqIvWR5kdfNhlnlc4ijSFxDpiAXnLT7rMvqHNX5ci1BR+celHRuAmDj7EeP+Oh9R3wGz+CdQwqvUaMNhhhEABZdEMBcn54zZyucuGDTH450WKqZwH+jL509JAImqjL8lGfTAW38PDFCfDbx56V/hRK0zUxYYKIp2rfPjgMVC1D+sc3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVrqkj2rgkOcwM9U5ihWxiyfhKEUwyaGO74cXl01OwU=;
 b=IEGGq53BauAuagpJRVYN/65ToVy9dwaI52tznmXxkweO2BhOmNIP3hiceoJ6aA8zzs56Wy2DTv/EJ4CaeH0mRpg8Qy7LRCKeucLcAvXA4d8sCqifHjLtrDeAN7t8lwyNPP9G5KSEgHOgQ8RFQ6BC/D6rdcHTOB5PNKYAw/IZBI0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7583.namprd10.prod.outlook.com (2603:10b6:a03:537::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 19:28:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:28:54 +0000
Date: Tue, 19 Nov 2024 14:28:51 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 6/6] nfsd: add shrinker to reduce number of slots
 allocated per session
Message-ID: <Zzzm89G4XI2CdRfe@tissot.1015granger.net>
References: <20241119004928.3245873-1-neilb@suse.de>
 <20241119004928.3245873-7-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119004928.3245873-7-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0422.namprd03.prod.outlook.com
 (2603:10b6:610:10e::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 1feb86b7-28b6-4408-d669-08dd08d067cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6mFhBFCCiGQEp6ywh/6yB2MJ7ByGe4xWzNfl3+rDDk+Hj6TjQovTaYGp+JDk?=
 =?us-ascii?Q?qIiWqX8A54hmKCp5YZst8IwaLeVHRAyheVvgQ/HlizYuOP5KkkkFwNtdvKOH?=
 =?us-ascii?Q?MryXPg4yZU7QKYhOeVrJQnvqh55RzbaQcoVEDWui8x4reYOLm5+qExex+ybQ?=
 =?us-ascii?Q?Lq+5Msc91dGjtlHTSRqXf/shTSr4HTQ3QNasQ/JdFUzIrsm18OyPDeE3s6iA?=
 =?us-ascii?Q?o40NSDion1dTyr8p2G1OUOl0yCOjjJceuaphz2iPQM2TIofngeLuZbJKJ55J?=
 =?us-ascii?Q?dzsJ8/mr1mjnQKi6LPyrnXdqAKQdy/rvgOkueoJhSVEA+Ze+ULtB7iT6MZaJ?=
 =?us-ascii?Q?HoGJsL5XBlhvRfJOzGw25/2yCNrOQUSkGXDpoqPcKlyc3nM/DnHYmcc1I5Y5?=
 =?us-ascii?Q?9wMso+rAOtvtPDYIYMaHcirhdJ1G/DvMcQeazjUuNEvEOn0FSilk0fZSQ61N?=
 =?us-ascii?Q?7oMKdutHjPRUVivUNczQ0Y4Xead8Z39+sP5bhG7MSIXQQpSfhwJUxWt88b3V?=
 =?us-ascii?Q?F4w6MaIsRaRbKt5BTN+CE5QHVsts7d/fjLf+3SlDNzgdjXahbPiUBSv/w5wS?=
 =?us-ascii?Q?dj69vKsQDVBy4IAdYkAkB8QkhdLj7fF8Q7QV3rUKVE2RKmH4zjlXhZe9WeTo?=
 =?us-ascii?Q?KnpoWrJ32mMH1FCUKXrL0GI+OkH48J//kcL1R4zbK43Fycfs8sJ5axmwX7AM?=
 =?us-ascii?Q?I9gZIblt8/9SZ/HLnlqtQ7KQ5HA0qt7hp3kJAS30HG61quo5YlqTdPD+uilY?=
 =?us-ascii?Q?G5aSA/wpjuTXTJ/LWoAP/MrTC7sf0xH/0Cwz+XR1A2Yx7pLOVCb6r8K5D3WI?=
 =?us-ascii?Q?OE9N6+k0z59GLQ/267iJwfKqQLkx0UNLhx1W/z/30FC4s6JaKkLeNepYcWo2?=
 =?us-ascii?Q?h0DU2phpj2Qq85tgDvfGLJJyOh/dEeQXHm6YvyVlNo224wHaD1zy1FMvNegW?=
 =?us-ascii?Q?qIL+WvLMFCGErWbWBtkAtceHPwg7Jd4BW4ia/KnAwj2xhxOmMM3O5gKH1pys?=
 =?us-ascii?Q?gYhetbbC4H0vg9wduXt58poEenyiyYqRIxcgC3QIkBiVyY2HSdHt5ErWGu21?=
 =?us-ascii?Q?kaKi5MHKzggGShGPrMTlfSz6GXWj1EDtB0RwuTRXKDvcoMbNys1dQCOZco9P?=
 =?us-ascii?Q?m1Uf5v5A4HgvtWF5djQIEF7mYajxadscPlJdq6FRaXxRbY9EmkkTmusC03o+?=
 =?us-ascii?Q?Xwi3w/HXMqWIkCpFb760ul4HYK7QJLhgYXX/phzgKpbUTiFpqKrzf2kPVgAK?=
 =?us-ascii?Q?JDdnsW//lPyr/IjWagPQxPCGJrb8aT2svtnJCEzKltKABWyioQzl2n0MMBGE?=
 =?us-ascii?Q?f8nIKdHDPor+Oj0s06R+HuX8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2BRFmbd34p16206ipYv3Fs2pH6PYmYGcfWkka6bKeZU8QHmNc1SgeefIKyEE?=
 =?us-ascii?Q?46QynLh2MALx+NKsc2fl1NlTszIZtTWqQluYqyIAaJJuaLsXJTLp58M1RfYj?=
 =?us-ascii?Q?oPSD85rzJJL1R8arHfjclh8TcTvWkJSN1lLha8+ju02mjs/zCr8KPEzL59XA?=
 =?us-ascii?Q?dzy0ckUolQ1lo/JmVPMN/Ks1tqLP1ibQT+w4uCiF/BSUUxd9DtpxWROxvP4I?=
 =?us-ascii?Q?q7a5QOpjB7JJVR5ETbnilKM9ERlFBD1sai3ScKqtPXHkL7rIM2HBTQJPUN/1?=
 =?us-ascii?Q?9oKFtnnGMfdaT6Plfw+McuXDAUKxtg+6XbzN8AXuUgjK3q5w6hPRAEtffrn6?=
 =?us-ascii?Q?rvpcOjA1Exv5coe8kvqRLH2+7xqgrAbLPeG87klAWAOuvGjD4UGTlrBUl/8o?=
 =?us-ascii?Q?0kIHxLpMVdElOi17aLFh+IQoF9uNmm5TTEImwDYLL6pc7wvIz3e3lm9QbAWc?=
 =?us-ascii?Q?uOIYFrACjzUjNDCOJfHnasxd0GUGsL+dUcqDYK6dCE25QyS1VH+PgFlAc5v9?=
 =?us-ascii?Q?SeY6ufZArl/OOFb7SadVHFiiXI5EbFP9pBV3YRGwYelvVAnvbuwXyTq9B2nj?=
 =?us-ascii?Q?YFBVGZZT0wXVpqX+W2NMP9T+NpZkfn7uDkwZJZFv9oW/DTPeTQcgU2qhGYd0?=
 =?us-ascii?Q?Hd2N93G+LfpGdl6XhnAfIfsuQKQiwUwJkF6Ix/7ZYtzchz2QBEpDIVbADq3s?=
 =?us-ascii?Q?ME6DXuc4n2Wgn6cUwj/E/G2MpUS4TYPYF+ts2S4S0r7Q4WeWn72usJtX4/RG?=
 =?us-ascii?Q?dqEwSt0lGiR4Q0a65WRUIkgzxtRz6dikIerZZpRqwIsG7LxeRtw9z/uYQP5v?=
 =?us-ascii?Q?udjOLUWx/pGxIS1vYXmCFuj4zF3f3M1JcEmcj/s+sZV+h3fBo2ljjLQGn2Ad?=
 =?us-ascii?Q?PqLWWool7ztJAAfDZL71rcPLN0qhJFYBUSHGv63oYTt5c6KKVWgrHZg5QTWn?=
 =?us-ascii?Q?6AbhM77x16vUyfRQR/Mo2o/59NUvtaXWGnyvCCCJLgrQZaNvsvbaYenGUHpS?=
 =?us-ascii?Q?Lng9LUq97sktN5ovRdjCs+pTU5xolrEhFjEIzxZg/FECKcngLXFWHfnf3XH/?=
 =?us-ascii?Q?MJ7tv8/4swtfA68DDSClnn+H0cK5V7v1uJWJJHetr1kfaXL/JM50V83eqfWp?=
 =?us-ascii?Q?O8fnyG+n0swO6ZBUCxYkS4Dg4c6rBg20UIvH/svbMFJPKP0vCxLpxCYljafr?=
 =?us-ascii?Q?5hSOWZxebqR6/aa9ClQojgsGeKhkiUmWD3G0KnPnRM7QH4oxwYu7CX2uja+O?=
 =?us-ascii?Q?ThBTgR+Jub6TyvHWKE3eJBVmNZpXEQliACqCIqMYTWlgWX3Rh5d+uROnf+1M?=
 =?us-ascii?Q?pTg22KUqlM9+dR8qmaj6dXJmQLn2ii8rZZXjgB7XcBDYiNTaodVgQ4HvR8mP?=
 =?us-ascii?Q?PAwR7L+UhVYYphGp/w9pY6QhwH2WWDPVN/iFIJ28cQ+0M5ISblZFEnouJ40r?=
 =?us-ascii?Q?t8+RfMCRb8MJZl4NQP6UidiTamUe43i3T4HXx8vxkkEZIsQZgIG+P+ZfWeeo?=
 =?us-ascii?Q?/sEHzfN0cajB5Nmn1rDv7QUBIx6Y6fA07TeYdIQPlLA5eMgV0QSLOjQJ1mmy?=
 =?us-ascii?Q?4ZcR/HnHToZVZifR7z84gstCR8+kAgsR7yNzkQ0QPMhM0pfbderwdP4yTJ30?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fKIVNSyQuzv3kT5IlGgRztJjDsC+eaQHqT/TeAk0zKQkzSSPSc57he8SL7YbimaPKZInXN8veLcZtCGW7tfkO8XC4DHzwbpDHO2nprV0WpnflstxTv3WHByQRt3v1Q8OEUCS9rcnysg4rdZncnHocaNLF11xHdRyGwoAQA7S0gfgpjmDmU/d96Vvx4bPJAGBgLl8gQ/IClBnBVZ2ivZFvbzGddMRB5AdRgGzm4cATje3HKKmWDBtvNLxaJpgjAUkDu6XShm1XBPL2QQv+s//o8k4hDjIuzmqIMB+Z1q7mzHwHRMo+Sd0+HpNiWjvK8+BydXHO5bb0rKujeZ30UKZmZCzgLFzHdMIqu+DRng9oR/o/zbjDs8GWGUvGM3da+7Iujv13R/MoZDIjHJzzjJxZqdZHAt7Z9mHtEpsNB3khvg8MzooGRdvcRPv8zfzeRBE3kN5FOO+O+tB6gT2iIpqnWfflN38mfHqJyLbzkzlRCewZqOKS+yOyFTpcSs61iOLZAniOkIF249rvXQchhfk74Nm2JEHKJPeCJUt9Ii/UztgG0us6GDLCttt/ZpV4gb7pL5EnJ2fThg45pAJWFcLME41jbYFh3WQgWnq4LwYSJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feb86b7-28b6-4408-d669-08dd08d067cb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:28:54.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDhw/5Z3yMdL7F224AkZlBYAjEorMqYmA/x8Y5Z0RQ7wupHVJWWaMiQOWZJsiOiLtBGhd1wdMyQR72SyzE3MqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_11,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190145
X-Proofpoint-GUID: XJK2OvspuLxaytMHFqTrYIraf1HgLXkD
X-Proofpoint-ORIG-GUID: XJK2OvspuLxaytMHFqTrYIraf1HgLXkD

On Tue, Nov 19, 2024 at 11:41:33AM +1100, NeilBrown wrote:
> Add a shrinker which frees unused slots and may ask the clients to use
> fewer slots on each session.
> 
> Each session now tracks se_client_maxreqs which is the most recent
> max-requests-in-use reported by the client, and se_target_maxreqs which
> is a target number of requests which is reduced by the shrinker.
> 
> The shrinker iterates over all sessions on all client in all
> net-namespaces and reduces the target by 1 for each.  The shrinker may
> get called multiple times to reduce by more than 1 each.
> 
> If se_target_maxreqs is above se_client_maxreqs, those slots can be
> freed immediately.  If not the client will be ask to reduce its usage
> and as the usage goes down slots will be freed.
> 
> Once the usage has dropped to match the target, the target can be
> increased if the client uses all available slots and if a GFP_NOWAIT
> allocation succeeds.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 72 ++++++++++++++++++++++++++++++++++++++++++---
>  fs/nfsd/state.h     |  1 +
>  2 files changed, 69 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 0625b0aec6b8..ac49c3bd0dcb 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1909,6 +1909,16 @@ gen_sessionid(struct nfsd4_session *ses)
>   */
>  #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
>  
> +static struct shrinker *nfsd_slot_shrinker;
> +static DEFINE_SPINLOCK(nfsd_session_list_lock);
> +static LIST_HEAD(nfsd_session_list);
> +/* The sum of "target_slots-1" on every session.  The shrinker can push this
> + * down, though it can take a little while for the memory to actually
> + * be freed.  The "-1" is because we can never free slot 0 while the
> + * session is active.
> + */
> +static atomic_t nfsd_total_target_slots = ATOMIC_INIT(0);
> +
>  static void
>  free_session_slots(struct nfsd4_session *ses, int from)
>  {
> @@ -1931,11 +1941,14 @@ free_session_slots(struct nfsd4_session *ses, int from)
>  		kfree(slot);
>  	}
>  	ses->se_fchannel.maxreqs = from;
> -	if (ses->se_target_maxslots > from)
> -		ses->se_target_maxslots = from;
> +	if (ses->se_target_maxslots > from) {
> +		int new_target = from ?: 1;
> +		atomic_sub(ses->se_target_maxslots - new_target, &nfsd_total_target_slots);
> +		ses->se_target_maxslots = new_target;
> +	}
>  }
>  
> -static int __maybe_unused
> +static int
>  reduce_session_slots(struct nfsd4_session *ses, int dec)
>  {
>  	struct nfsd_net *nn = net_generic(ses->se_client->net,
> @@ -1948,6 +1961,7 @@ reduce_session_slots(struct nfsd4_session *ses, int dec)
>  		return ret;
>  	ret = min(dec, ses->se_target_maxslots-1);
>  	ses->se_target_maxslots -= ret;
> +	atomic_sub(ret, &nfsd_total_target_slots);
>  	ses->se_slot_gen += 1;
>  	if (ses->se_slot_gen == 0) {
>  		int i;
> @@ -2006,6 +2020,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>  	fattrs->maxreqs = i;
>  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
>  	new->se_target_maxslots = i;
> +	atomic_add(i - 1, &nfsd_total_target_slots);
>  	new->se_cb_slot_avail = ~0U;
>  	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
>  				      NFSD_BC_SLOT_TABLE_SIZE - 1);
> @@ -2130,6 +2145,36 @@ static void free_session(struct nfsd4_session *ses)
>  	__free_session(ses);
>  }
>  
> +static unsigned long
> +nfsd_slot_count(struct shrinker *s, struct shrink_control *sc)
> +{
> +	unsigned long cnt = atomic_read(&nfsd_total_target_slots);
> +
> +	return cnt ? cnt : SHRINK_EMPTY;
> +}
> +
> +static unsigned long
> +nfsd_slot_scan(struct shrinker *s, struct shrink_control *sc)
> +{
> +	struct nfsd4_session *ses;
> +	unsigned long scanned = 0;
> +	unsigned long freed = 0;
> +
> +	spin_lock(&nfsd_session_list_lock);
> +	list_for_each_entry(ses, &nfsd_session_list, se_all_sessions) {
> +		freed += reduce_session_slots(ses, 1);
> +		scanned += 1;
> +		if (scanned >= sc->nr_to_scan) {
> +			/* Move starting point for next scan */
> +			list_move(&nfsd_session_list, &ses->se_all_sessions);
> +			break;
> +		}
> +	}
> +	spin_unlock(&nfsd_session_list_lock);
> +	sc->nr_scanned = scanned;
> +	return freed;
> +}
> +
>  static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, struct nfs4_client *clp, struct nfsd4_create_session *cses)
>  {
>  	int idx;
> @@ -2154,6 +2199,10 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
>  	list_add(&new->se_perclnt, &clp->cl_sessions);
>  	spin_unlock(&clp->cl_lock);
>  
> +	spin_lock(&nfsd_session_list_lock);
> +	list_add_tail(&new->se_all_sessions, &nfsd_session_list);
> +	spin_unlock(&nfsd_session_list_lock);
> +
>  	{
>  		struct sockaddr *sa = svc_addr(rqstp);
>  		/*
> @@ -2223,6 +2272,9 @@ unhash_session(struct nfsd4_session *ses)
>  	spin_lock(&ses->se_client->cl_lock);
>  	list_del(&ses->se_perclnt);
>  	spin_unlock(&ses->se_client->cl_lock);
> +	spin_lock(&nfsd_session_list_lock);
> +	list_del(&ses->se_all_sessions);
> +	spin_unlock(&nfsd_session_list_lock);
>  }
>  
>  /* SETCLIENTID and SETCLIENTID_CONFIRM Helper functions */
> @@ -4335,6 +4387,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	slot->sl_seqid = seq->seqid;
>  	slot->sl_flags &= ~NFSD4_SLOT_REUSED;
>  	slot->sl_flags |= NFSD4_SLOT_INUSE;
> +	slot->sl_generation = session->se_slot_gen;
>  	if (seq->cachethis)
>  		slot->sl_flags |= NFSD4_SLOT_CACHETHIS;
>  	else
> @@ -4371,6 +4424,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		if (slot && !xa_is_err(xa_store(&session->se_slots, s, slot,
>  						GFP_ATOMIC))) {
>  			session->se_fchannel.maxreqs += 1;
> +			atomic_add(session->se_fchannel.maxreqs - session->se_target_maxslots,
> +				   &nfsd_total_target_slots);
>  			session->se_target_maxslots = session->se_fchannel.maxreqs;
>  		} else {
>  			kfree(slot);
> @@ -8779,7 +8834,6 @@ nfs4_state_start_net(struct net *net)
>  }
>  
>  /* initialization to perform when the nfsd service is started: */
> -
>  int
>  nfs4_state_start(void)
>  {
> @@ -8789,6 +8843,15 @@ nfs4_state_start(void)
>  	if (ret)
>  		return ret;
>  
> +	nfsd_slot_shrinker = shrinker_alloc(0, "nfsd-DRC-slot");
> +	if (!nfsd_slot_shrinker) {
> +		rhltable_destroy(&nfs4_file_rhltable);
> +		return -ENOMEM;
> +	}
> +	nfsd_slot_shrinker->count_objects = nfsd_slot_count;
> +	nfsd_slot_shrinker->scan_objects = nfsd_slot_scan;
> +	shrinker_register(nfsd_slot_shrinker);
> +
>  	set_max_delegations();
>  	return 0;
>  }
> @@ -8830,6 +8893,7 @@ void
>  nfs4_state_shutdown(void)
>  {
>  	rhltable_destroy(&nfs4_file_rhltable);
> +	shrinker_free(nfsd_slot_shrinker);
>  }
>  
>  static void
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index ea6659d52be2..0e320ba097f2 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -345,6 +345,7 @@ struct nfsd4_session {
>  	bool			se_dead;
>  	struct list_head	se_hash;	/* hash by sessionid */
>  	struct list_head	se_perclnt;
> +	struct list_head	se_all_sessions;/* global list of sessions */

I think my only minor issue here is whether we truly want an
"all_sessions" list. Since we don't expect the shrinker to run very
often, isn't there another mechanism that can already iterate all
clients and their sessions?


>  	struct nfs4_client	*se_client;
>  	struct nfs4_sessionid	se_sessionid;
>  	struct nfsd4_channel_attrs se_fchannel;
> -- 
> 2.47.0
> 

-- 
Chuck Lever

