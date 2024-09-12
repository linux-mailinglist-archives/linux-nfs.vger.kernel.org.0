Return-Path: <linux-nfs+bounces-6437-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E89775A9
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 01:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51ECA1F21955
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD46B1C231C;
	Thu, 12 Sep 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G0KyAs7l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nUCp5Oov"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5E6F2FD;
	Thu, 12 Sep 2024 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726184061; cv=fail; b=I25HQZL1SGjRan9renIsPqcQ60+k6PK/NhYG4DzJUKpc4iD9hYmKLYUPJ+0PCJk/Lvo4bRaUCdwVQ5DFDKu8g1c+hf8vj5oGVPODUZsiwATJEQA9mBsfXSrXiSeFuBJ61KGKLS11CDTzZQE4+TFhwmx54tkP2TRYyCT92c3bbb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726184061; c=relaxed/simple;
	bh=h9Y5hDwZFLEvp8BrI/WOc15CtLVzKKKBHLqXD7Fb/ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tV+k0FhRUQT+jhOwDEbHyJVQRAg5H+B5D7GGHWvsfBt7b7GXM2xdc5GQgpWy4rWGwiLXoNoIVeny3R9zk7++h897z3HEl5gft3Ur+4g+RPoUtniaQlvXBDrtVVwfVcMU50NPwIyqEWfDbMoJ3AeHFAplVcs0jACEitFgQoeouI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G0KyAs7l; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nUCp5Oov reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMBYdN023293;
	Thu, 12 Sep 2024 23:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=jwZpZWGJaDE0mKrBHvLFokgyxkvrpXcDJ72wc/B7pq4=; b=
	G0KyAs7l43ppjZk0B7N7Bno++/mebEFpj3L+a7T1U4cqqLaiPTlr11To3Kb/YvMg
	L/rsPE1MIEgtuKI/60BasuvHWwgl4IySM7SG7uXQrvGbFpEleOSq29kYqUHRd5M6
	KihRTzu0RQN61kdMkKeqi2+5HEbK9456VLpTAHPLN9YsvzlEoXVb/Hhl+JbebzqK
	lHGcMG+DMIeLjbiWHcWrOuMf8GDQ6YYcXlUl38BPvW3+NO50fJlsD7vweQYxYrvv
	DlDSgJaATmoTxiQmkw0KcSvh7+i0ffbePFPAZ/hI/V0rP82Nv+xnpeD69PijRT8v
	U9V2OQVW8tz+Rz9eIV/zng==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8d40ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 23:34:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CNFEXY005749;
	Thu, 12 Sep 2024 23:34:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9byx25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 23:34:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6atsG2HfQDwXEwfq+55ilruP6OCXOTqTUj6yqTcD4UR3ARkbwfUZvfhidt2L1dxgkPS7XAwYL8orZT5AbPiYdBxgrzmhLL4qJ1OzQKL1L1MjOjCaf1EzpiBu1Qj9sUOM/BoD6MQjBa+ETuVd7auRZehZjQva0wVLYYZnd5UTc4CTUYt0CkpNJxOeQNPfZJGCHq6P1KSDaci5/yv2SxOFppG+q7WmPDcEuXRl/r83oq6Lm4CKwD+/vD4U7GIei58VECgtipxfZxyMOsOH1nH1orjXDsQ3z77EKr5xvGZyv6s3IajC0vuZGik3f+os0wWGyrGRdpIZ1wjEt9U6eyrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+pfmqEpFe7a7eMmITaga1V4e4QotHaoyhCHE/HiXDM=;
 b=u77BE22/j9ZPCgdmQjEHIVeTNvM5O/cKGY6mR5M86ym/vynf+Vfs5zlmTRL2KVipjsEXYMRbAphy0pYfE+XXgPxMnsGTP9xv4n8x4+swqFseySQEDEcMkDmsEGHmYBPyTFAMxeW4vCTWL5gWbKzBh4hYkUpsqEMphfUEFwrS4mceqtzStYgQMLBaTfKioWWcYRVyoQw+DGh3wwTsSGIzWaXqLmgNLiGA6H992Tm2D/s549FfdFlhKCrFla+E44CYo3uyQpN5O/WK+toHHUqqt68RU8sNVpYM+L/8vYbMSMRWzs0lzZsM7IBvPT6WJcHrlqOQmT/gPTJ0xpb6JaLXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+pfmqEpFe7a7eMmITaga1V4e4QotHaoyhCHE/HiXDM=;
 b=nUCp5Oov/vG7DOJrX6f9gxIOyMU1H05kpuGwG8ccEyAy90SHeiwo1VtNExMuG7baJ0khMrf+8IpMzYEwv1FqSNoS09omdl4RViGKteQpTzbmBOukmztmNiF4NBmSuWauMvFgKxPmp1QDoZ4Mo7aGGBrbnGCHIuf38WsGEHrIxJc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Thu, 12 Sep
 2024 23:34:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.003; Thu, 12 Sep 2024
 23:34:05 +0000
Date: Thu, 12 Sep 2024 19:34:02 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
Message-ID: <ZuN6ah3nI0giafGl@tissot.1015granger.net>
References: <20240912225320.24178-1-pali@kernel.org>
 <172618264559.17050.3120241812160491786@noble.neil.brown.name>
 <20240912232207.p3gzw744bwtdmghp@pali>
 <20240912232820.245scfexopvxylee@pali>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912232820.245scfexopvxylee@pali>
X-ClientProxiedBy: CH0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:610:11a::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f8d959-6114-4198-0402-08dcd3836450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?d1H5x88rSy1WKDACbSoTGHG7NTzjW1s771QVg0kPjRbYkks7ShDJofg/oB?=
 =?iso-8859-1?Q?rPOpqW0QQ5Kv9uBb/HwI5cfqGsiXrZlegkbUHqJVzPSuzBh22xuhQANulG?=
 =?iso-8859-1?Q?PkUVmgOVqx2HParbcneCVC2rrvhsRRFdrcos+SYiVVwxTuFjOaqq6U3fwh?=
 =?iso-8859-1?Q?5sO3unfElH3qTztMNIk/fkoaLmu0B7v2UvTLxWVrcOHhwY/1x55Fnw3vlQ?=
 =?iso-8859-1?Q?yTSL+wyI0whUvYK7jHyWOySR9Rtc5+ozylz7EnHpGm9hXsGTvCZsIUFQdw?=
 =?iso-8859-1?Q?wTamX0RYvt0rfDG+cxvZmxPqdm5eYNzlW86J04mStAH2bqF9ly4NtsoQfT?=
 =?iso-8859-1?Q?6zPAziK774ug5Brt+bZ6jP1cY5A/X1MdicXi4+KoX0l3vMStM9LnP1eKAr?=
 =?iso-8859-1?Q?jnDjZcs6tUteMFAhpDR9qbzPZyCsx8En5A18eSju1DkVVTtPSZL3cH8+5D?=
 =?iso-8859-1?Q?/bSexEVRKXUXJKQf4KEkpRY9cn7x3sg57MU6aZ/Kf+lZMWfs5jj9xrXL/7?=
 =?iso-8859-1?Q?YHM0WI7t3xiZxEcYuogMGpOedPG06u0n8lSqp6EBBAKoYlaJ2rj6RGBsH6?=
 =?iso-8859-1?Q?Rymp/MqCxmljSQ82TRKTnR5LJwpy0v0LWxy98PCgCp2qhDHEUk1A3ksJYp?=
 =?iso-8859-1?Q?WlULt/JYb46iOT4DS/IR73yd+jnbAWabjGdTiBD0+HyznosG47mGIOxFqJ?=
 =?iso-8859-1?Q?Prt4RfJhmXd+GZ4bCHpxzAVECdK+7q/iOXAeLiQlfLf3WmHs6F4YMp1pNr?=
 =?iso-8859-1?Q?47hrxFFr+mT2vWwoO55tfjCX+W5w2FPXeCPVviLNnLpYOPPm7gVqimoWrO?=
 =?iso-8859-1?Q?FiKMpQ9B1YykT36B5ipBCwES0rkEZY9pxd/Nv77cFDYQh91j7dSN4oVP/C?=
 =?iso-8859-1?Q?4vrqmhLCUeT2qa8ZTxcqEpy5mGOXzotyGk/6wGdpxQZ0c3EqekxJsvdhil?=
 =?iso-8859-1?Q?M5GP/oK129SytztsoeM8s5Wlan4XDMSJaddvaGKTAyA/NF4XvXD4dczwvm?=
 =?iso-8859-1?Q?gnEzoj8BlU/egjq2KyjY8aSRHBWJcdpkiVZNnwkDcz83AUOuo26/cEtBFT?=
 =?iso-8859-1?Q?3EZQqsOxcWubw9TOkv+nAD6dRRWDwCw28p379uQmZkuUs9M5u/hTK+InRj?=
 =?iso-8859-1?Q?H8i1obcP6g6XbTg/cWJ3y+uAECzDl2zwX4PzG9GL0T/y2fZpDPY8uqe7cE?=
 =?iso-8859-1?Q?v4PAybfHCskPeA5tW5mQy9tyC121DjYumii2bsJD6jYOoJkgJB1AoMeCwh?=
 =?iso-8859-1?Q?YY0stsakhN2x339pDw+FQtYBEfpIsv5w8Fv/VwZhtQCGJY8f0EQv9zhNud?=
 =?iso-8859-1?Q?+E85bYJbQEMZ/x88foeID8A7jE2lZTbyshATcLHHfhhzqwg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?HGfxYIQ0oFWBIxLhIPbZkIRFKq1d90pWFQ8oYaOuYsOZq425/gfesDOhmd?=
 =?iso-8859-1?Q?gyIJs5BkpxzA1mBjKxKj8vy5UbSpn5KOauw60L9FLElvtxYPsxjcs90FBS?=
 =?iso-8859-1?Q?YeAx8v2E/04Kd/5HqUOub2ihQbBeG8nvyWvL3NnApMqPerF/jE05T6M5v5?=
 =?iso-8859-1?Q?Sx6Azw/ZDzslu/hdUTKULYapp44h8S+pmexjtvV8JRNl6GlwW85Q+3V66i?=
 =?iso-8859-1?Q?MMSl3XoXrhTD0m6FjUnnUuyd65nROm9xWbL8WpQx1EP/nW0iREgycF99oV?=
 =?iso-8859-1?Q?fS5LRBQiqlZyir8gynKfSz5RyGM9+lrkw48BgC2hWWzQ4DlPeNkiwarVnb?=
 =?iso-8859-1?Q?oPGYwORTrK8RvL2XjUAheDmmPiZufmkaRzKgBLEQRvuHCTDUFZ7EBf5BA8?=
 =?iso-8859-1?Q?zp8HS/nD+Dg+VeK09hn4ygh/hJXb5jpkIj0cMFVtcF+A4X8J7FzEzMG501?=
 =?iso-8859-1?Q?VMKXFgRb5OcpP/Y+8q49rOVqi1R6r4JfapZ9/XRwZ9fTbd9eY6xa3+luHU?=
 =?iso-8859-1?Q?8zlT6RkJO+Fawh7NcK1wbGX4zQt/Hb+V4NLKDPxCyv3CPdhQ2VVc4JWTVp?=
 =?iso-8859-1?Q?DzahDU6OMePHc15LTc77NGVmVWQzyeJarVzmQC4ubYqEYg/DFMHDBRQ6LO?=
 =?iso-8859-1?Q?JO6rPywZl7wsFim/SBCkoNNVKy9OD/hRnZRBXunCmxhMbSULdlLBpGzdmp?=
 =?iso-8859-1?Q?gGUr4d+OrwhGISVFD4H8WFvs8uwY/fanzNRxAsyj/6hyzr5cd5TAVmI9Ye?=
 =?iso-8859-1?Q?g0ezlcx0dBcSPSy8D9tu64DbV6RzZNFgdmdt/k/EPxzi0b0j/BvfGbnQZq?=
 =?iso-8859-1?Q?ZpULENmnqE0auIEzMaXop+dRJ84pPy0rV7MfEvoxEOKttwARTrxylMxwny?=
 =?iso-8859-1?Q?MhU+Qwmq86WPVwOEwu8K72fPr5czV1oR/KHPwh8LTShrEwXCD8Twi+6ehk?=
 =?iso-8859-1?Q?+roPpXEcVLebqzrmk2toFs1WT5sCH1V1TqO1S7HNbYSuyLJvkbm+Kgx21f?=
 =?iso-8859-1?Q?+GwgDT0N1RnVtPYccLieMpRzCiOLlEE++65XY+hi0R/X2xhMTmmYL1Uu+C?=
 =?iso-8859-1?Q?9OoPpr3SLh0+rb109BGEq9ojuoW/5MO/CNL5j/0cpwZwkF4mcTwe6IIlr+?=
 =?iso-8859-1?Q?fvXPjzzJTA34YtEwKynXKbkqEGR8NDtqA/gBgp6EhuytKdL4Ux7rW5ScHQ?=
 =?iso-8859-1?Q?+RPceEheIdzOx3f7Dw3YHnZk5dxSI+EuAlQA0gsM2ZgDv+pkHefPiaR4lG?=
 =?iso-8859-1?Q?fNDvaDO7xMuRoOcHfV4Sh4Lj8DZwZtqdwp1qS46TtlmkmE73Sj3LsNk0vb?=
 =?iso-8859-1?Q?bmjtpj71CGDFUrLwcZ6k2ZuelasmldiXp+MpSl9g798K9+uKupRo1DtY62?=
 =?iso-8859-1?Q?2OR+V0uR7vRlAB0mM/TbGn57xEzLRlm4R62bFA0VSkAfR46CJ2egDhLbut?=
 =?iso-8859-1?Q?ohUqqn/sxpoz95ujKi1sqFqQAHl2+yw2noY480pf9d2lAnVENPcRt016RR?=
 =?iso-8859-1?Q?FHbz9Tv9PWL+yVTpuc+TODpeChCHeSZGq8kyV5upP6MFVciUTRjoNAkBol?=
 =?iso-8859-1?Q?fVIkQHU7tDPxz14PmUr3Lwg9Uw4vvz/wgyOhRrc5y7xPI4dIcfYaBWoEkA?=
 =?iso-8859-1?Q?JPqXPOzWoYE2AM1M+Hjcfj9WURx5dxwFvo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DSdsDNcH9huLi6vUOxo1UzDBKmDlgJITHkmqJZ7PV9nKX6KEUk+/eNG0bfomWwil9Z8fve0oXpW1RPHiLLTOtLFH4bPiX0sNN0E/sDBi9TiYaF6sl2kY4aiwOqNsmzzoVoG9DDUO7hvwYITwu/yucVw8J0+1ue0W1YcU6NlJjd/pK0k+S5T8Lm6pX/VhVhZ/TrvAv/aNRZuu8pv4uD+15at1/v41tRih/16e168ziJ4Z6b16uF+EuPKUBB0GFaPCdRgQPSNe9VUbvCTP4ZvhJVqjf5ZmgDEvIVoItA6a3v1phtm8iZ2W18gyfgPvrDuJ4fsrdz69jFaioGulSYNyni/3AWku7wjrdjG3b2btUpRrt7eXLpPLfhsvFT8gOW/q6yf+UML22ntVlMhczw0N6yargqgxd2CfOWT4QPVO2f9pdbocP261f+cELa8mtZmUBZsw7CZj/8rlDpxK5dSGuNOiv0ULtVgU764tO228YWBGpmTcmUXwyNuPtRiMSM2xWak15ml1yEcmucL72zkm1p50GikhahHi7wqZ3Nwn7yxskiKsBEkrEzdJM4R/iJ0+kNNERj7EFNBHj/NDWefpS6qEwtQCdM7nvKH6owzhSnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f8d959-6114-4198-0402-08dcd3836450
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 23:34:05.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuhhlS23nqW5YCoM6miUJwqyxh35PAJL7DfsMzd/8GH04Q5i9NdQeTaBiyIQUHRbZvyKtd9fT5KfldNlCYlZwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_09,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=781 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409120170
X-Proofpoint-ORIG-GUID: 5hL0bd4we0WEfVSxbgy7clGEZa1caBIU
X-Proofpoint-GUID: 5hL0bd4we0WEfVSxbgy7clGEZa1caBIU

On Fri, Sep 13, 2024 at 01:28:20AM +0200, Pali Rohár wrote:
> On Friday 13 September 2024 01:22:07 Pali Rohár wrote:
> > On Friday 13 September 2024 09:10:45 NeilBrown wrote:
> > > On Fri, 13 Sep 2024, Pali Rohár wrote:
> > > > NLMv2 is completely different protocol than NLMv1 and NLMv3, and in
> > > > original Sun implementation is used for RPC loopback callbacks from statd
> > > > to lockd services. Linux does not use nor does not implement NLMv2.
> > > > 
> > > > Hence, NLMv3 is not backward compatible with NLMv2. But NLMv3 is backward
> > > > compatible with NLMv1. Fix comment.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  fs/lockd/clntxdr.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
> > > > index a3e97278b997..81ffa521f945 100644
> > > > --- a/fs/lockd/clntxdr.c
> > > > +++ b/fs/lockd/clntxdr.c
> > > > @@ -3,7 +3,9 @@
> > > >   * linux/fs/lockd/clntxdr.c
> > > >   *
> > > >   * XDR functions to encode/decode NLM version 3 RPC arguments and results.
> > > > - * NLM version 3 is backwards compatible with NLM versions 1 and 2.
> > > > + * NLM version 3 is backwards compatible with NLM version 1.
> > > > + * NLM version 2 is different protocol used only for RPC loopback callbacks
> > > > + * from statd to lockd and is not implemented on Linux.
> > > >   *
> > > >   * NLM client-side only.
> > > >   *
> > > 
> > > Reviewed-by: NeilBrown <neilb@suse.de>
> > > 
> > > Do you have a reference for that info about v2?  I hadn't heard of it
> > > before.
> > > 
> > > NeilBrown
> > 
> > I have just this information in my notes. I guess it should be possible
> > to gather more information about v2 from released Sun/Solaris source
> > code via OpenSolaris / Illumos projects.
> 
> Just very quickly I found this Illumos XDR file for NLM:
> https://github.com/illumos/illumos-gate/blob/master/usr/src/uts/common/rpcsvc/nlm_prot.x
> 
> And it defines NLMv2 with two procedures numbered 17 and 18, plus there
> is a comment in file header about v2.
> 
> So probably the best reference would be the Illumos source code.

What you see in the Illumos code is not something that is part
of the standard NLM protocol, but rather a private upcall protocol
between the kernel and user space that is special sauce added
by each implementation of NLM/NSM.

Also note the way NLMv3 is defined in this file: it defines only
a handful of new operations. The other operations are inherited
from NLMv1.

IMO the comment is accurate and does not warrant a change.

-- 
Chuck Lever

