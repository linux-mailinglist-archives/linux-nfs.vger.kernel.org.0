Return-Path: <linux-nfs+bounces-7629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B009BA211
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Nov 2024 19:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5752BB2117D
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Nov 2024 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13E01A7060;
	Sat,  2 Nov 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nMR6b4KL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wxciMJHg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28B191;
	Sat,  2 Nov 2024 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730572480; cv=fail; b=iQdb+YTJWIGkwWQSHzhBrBBrTm38pE9yv495Dr7mm17kDSRtK2Fj1qhL53NMebxeIfTUr0NIzhBp8vlV0LBjI1nOs+E5MmLz90Eokzyob7+YCJ0DXnMwFutUEbwwS7qrsB9KPc7HWNjoWJ105lfkl/PncfKnIXwlEnn2y4vs8ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730572480; c=relaxed/simple;
	bh=bJipT9UluujDX0lL/dJ24tL/6otBTeN9Wj6Gzfx9/+4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HdrENsXV6kSWer4uEyahunU70Q60yURLgOg8rjOIPxE/O71A/LMmVjYwNefR9EDgnOtH3Rk3vHDIggF0+8Yj9fLCjW5O+JbkYk8UWCpiiorDzsTg6fdhX8xKbPoRgJi2ttK9TR/cnMj8eGqkEsxE1i1PUePxuIofkIxuRjmBH+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nMR6b4KL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wxciMJHg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A2ITZDX013893;
	Sat, 2 Nov 2024 18:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=V8QpjE1nM3Zjc2skVckbfDkbjliyBJ9/v3PZ4Nxxx9U=; b=
	nMR6b4KLhLt9XYiIgOGS+Sip4YVBgLlbJ4pByE3gG/NTePe0iDy4izF9C1eVZY9S
	escAoDPr9FAjVCIe6H11AbvQaVwVdTafI1xIt2RF744ksj5rxfmdtDkQ4EUowUFc
	xyGxDxABDKCgQxQUeXE5uDSkDODqJQf0Z08vZEOD5UwiXl2fr4QVwElSBc0hij1t
	z0LGkYKutN1ypKXYyoI0h+sJotbhIVfBfMq3rwoUEy1kmSMWjRkDqdTsqVemLMe8
	g7b9F0koYJvD13cS6WN8R/IBDGrusP9iYGJNh/wK3m8yUAYeJw9UlKp6KlvI6dBH
	kEWJt8yH6n8EtL0WZJeNbg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt0gjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 Nov 2024 18:34:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A2D1D1Z032669;
	Sat, 2 Nov 2024 18:34:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah5d91k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 Nov 2024 18:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGjuT/x9GSkSss4AdqdTPxoiG/JtXXUPgu5JRWBJbltOyj10cS2IRk4LsYt9G/Vp1emfWtnPvfI6Nly1NV/DPlQPejulFhbz+cTqNl162kSynpBP8RVlBUR5VoKhN+XSTqQ3bgPIsmZUUn+RWjGS2p1pCVMCy/njxkTqWOClHpbXQqWXX32an+P+0da0oAxpHhCDZ3qfwLnW5wPMwjYPo+2QWPiFhZ72ot1fGhfmU5sXUr1aB6Uq/sQ/6UJII2QN82XLLH9/p1u2kNCjQzGZjtWk4K5SCEb+fY5UsyNNE4yffukIJKAwyfHZ8uHKZGdRXfceVokNuwvjrLjFIpwMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8QpjE1nM3Zjc2skVckbfDkbjliyBJ9/v3PZ4Nxxx9U=;
 b=gWs2y1kTlxsEbzqQT9ChYxuai1XsALwdrShIjEY541Qic3raFaPycm686ECCe0XgMiADJ1B7+2MgvisNIg148de9miM0yu6wQVtlwDj414XBO2GtvkXruTPqF3tzin6HGuMb/RitqYF11UMZX06QU4rMRzRSF5DqvlmOgycP9HH/JFdyXn0eDQx4yjOOOkyRBXOkhPJ+Oi0wUKw9SjaLSR4YXsyij9VDp2G0JJi8Uw3AAeO4RICuJDUvGOvQl8lkVgKm/2VE3L+0WjzJ1jAW9aZem7eTJKPRm54onlsj76L5ayoYhnnYLv8Qu1RCDOdguu2GY+s6LFPSw1Til4spkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8QpjE1nM3Zjc2skVckbfDkbjliyBJ9/v3PZ4Nxxx9U=;
 b=wxciMJHggchFynUpsJntlHKifs17slR31MeQw2SyjcIwlaJasLlPYZasn+4Icsi0Agi7fNsV7V230Bc77xLSsmUpVdh1VEbl9Zh9em8QERH4ea/eCelpwXXjQ13nXV6EMiqkFBThMmmmC9k2apIS4Sccytrj300p2oMhVQkXxxU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6686.namprd10.prod.outlook.com (2603:10b6:208:41a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sat, 2 Nov
 2024 18:34:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 18:34:26 +0000
Date: Sat, 2 Nov 2024 14:34:23 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] more NFSD fixes for v6.12-rc
Message-ID: <ZyZwr9KvqOFkwE0N@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610::36)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b30a84-55d6-43d0-9caa-08dcfb6cfab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OG+c2pzyJ+EF6L9uplF3wP37XCeObsUWVOj0kQaoTuoM2U2JfOMRLVJGE2Vp?=
 =?us-ascii?Q?B0PX1+3F/p+c/R2ZgBuw21xyxvpKyd1FE4yfL5bSFsv4hAYKPaxuFlWvksZO?=
 =?us-ascii?Q?uHtiVKKq/n7XJvtxgO6aUaLeALGpjwJtNCghmJbUZU5I6uIg8riqA4X8LVAH?=
 =?us-ascii?Q?Uu+/fCU0CnOOGozQposcDrUUezh3yuWCjvF3cD335NKEiJ7MYzwvkO4t+7Ea?=
 =?us-ascii?Q?3BFNNKHLslIARTk55Q2bzSqvDYm0PJ0gnKHEi3AfJYgCNm+34FwAAJ03OLaC?=
 =?us-ascii?Q?CxBGlHmaqbPeeybx7IchFXK8SkxaS2Zhnjz3fNVbdZxvw/tDgVebC/yAVpAl?=
 =?us-ascii?Q?1CUu0xGUW+U1uhGs9DB6OaGa1GDcB95Oi2sQhNoOLtxwOZx9HSkyOsyorKfF?=
 =?us-ascii?Q?JOM5hBB6SXuY4hq2yY/dVcKFiUBa/Db9T9dDdpFJMoMqGG1c+VdKT+NrgmPP?=
 =?us-ascii?Q?rjgDOpKyHUv+k92DyN6eW2JzNl3Y+toWsd2x7sJ+k9+fWs/wmEN7DBumU0ry?=
 =?us-ascii?Q?8rYkuFMGDW2HycUUJayMklRmTMj4ytikNAL5Emct6GNgood8LQAcfmOL1srK?=
 =?us-ascii?Q?/T2LauR4mLlNKwbTOGP+YCphKO0LMXzt8bB72pOnxJZ0hOwEqupukfQqPzat?=
 =?us-ascii?Q?zF8OdNqZun/OQnPGDwDZqD9tqWwcLL2/LhUzqB9xr9Wxxwo92wP8S4pIDsHd?=
 =?us-ascii?Q?0UhMw0Hdfk1q6V4/GO7LpGWQGmpx03acmkfmT0LwcoznuPKd7ErvcvBYxVeZ?=
 =?us-ascii?Q?YzgIdGkHfxwRCCZOSkrLqm7+Y8u3uyG05vQvMJ3TDJyDjeY/609N9zGhkakF?=
 =?us-ascii?Q?biFf2kpEGR/bQzVJeeF+DnCoSn524yL+XsQ4bjhsIU0wwdvTk7QAS/3Dnsz2?=
 =?us-ascii?Q?WRa+tqMjf2Q0cmUBNG39oZcbKpyGWfdj6xZo5WxTRCfwDk6/TdWKsIJJmA7z?=
 =?us-ascii?Q?SOJYsWQswlr6ygj4RCVR9RZcozvxTFCL0ApQJDHxBvo78VZNsFnJypL2XFLS?=
 =?us-ascii?Q?oqxjQozyjUz55tz2CEYp7lr+rPtJbzSJkyVtAxQVRCCKx/+U0y40MwTu/DZx?=
 =?us-ascii?Q?UlnebeV4TkS20oBmB+hPURadNHV11o5jsjBbyGusMYiIgjkI95+UcRocbwMf?=
 =?us-ascii?Q?ig4LQ4w9uSoIOwXTK/QA2hUq0V39MLUQ8VdIfzbldADQApcb9H9b0nvPN+Vm?=
 =?us-ascii?Q?p8U7TB+jckY8+kJdGOABu0H/oaJ8WVphh8OzZhaCZJMFCx0yzkponkMFDEC0?=
 =?us-ascii?Q?Txczvx6Q29MfJn+Wfke0XqMHuj0BY0FVMtM1zphzVTByhC8NLt/xMM2vX+dN?=
 =?us-ascii?Q?9W6fJwAe1YRzUD92MMWjp6qj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRAnXVoHiIOy+aw/d5DC6RRzBM2rlZc19jqFCTBdYsR6uD25I5tvE/CMVx/d?=
 =?us-ascii?Q?La1jQxlpy5ucCXKRsi9YtLK3bnYEVpjOhbRKs4ZpNML4F7tPoOTxdDUpA2WT?=
 =?us-ascii?Q?IUQnPLHbrIaWK3gi1xTFrdi3MvTvFn6RsDDH2wdIBtBqkaU6iJRFR18gb04W?=
 =?us-ascii?Q?25aRQdWrdYwkKyhxXM9UsYSiTtzjDVezH8V7GIEs4H3dOrs6n9JnKcbY/PyM?=
 =?us-ascii?Q?PobSP2wwy+FJJIqH91FvzWm70DD2zeMOZSKZ7OoNyPHyBT4Z7RlRi0fghZOx?=
 =?us-ascii?Q?WAh1yLHcJOFbczwCAVB2GThpwygulCOZnspwQwY+mKfwwoxnCTwOn7HVIpZD?=
 =?us-ascii?Q?dFPo6YZ2VMxp1qISo8Nq7w10Vi+JvyTzMmMmyG0jfUoA3klPCHCE2X5evKDZ?=
 =?us-ascii?Q?eJOXXFKFV9r0eqoFHtlUjuKn9KgFEoAZVbf2s5EhH2BIvl6otcscexs6E15I?=
 =?us-ascii?Q?k8sbJbm5DvGPrEthQr8yp/sClDfMYUza24l6yBKrSFWgY+vt/W9RV0EwD8yx?=
 =?us-ascii?Q?0OiX5brGTXgy5emmoIS06b+96/KiJwAGUm9aZ7Ofgfkdup4c7sgc2WZXKENU?=
 =?us-ascii?Q?PE15qZ0/0mPIxziSoQzae3DFeG6H44bdBUUkgOh16cr10LIo47diJGM6PGT9?=
 =?us-ascii?Q?YBAYAvrp2I/7JFjq3TcIKXJLqkVkZumXoPOdsAFZ6xI5GaV5eV7Vi5Qw39fi?=
 =?us-ascii?Q?P0otIfG/GTFVqlQzTkFJ+OGcGEl7IU+17rsFFYS0tLdtQyj558NAlilbt5+Y?=
 =?us-ascii?Q?2+DhlOn4FU0hFpj8Q3toCum2+thsSKbvP6ePH4kEObfgxdxtRx3TCn8arks1?=
 =?us-ascii?Q?KQlmqXTWGcA8cZftb4jhOw5RwPghrpXldRfss3uhj1CedqZbT0JguL3r85jJ?=
 =?us-ascii?Q?EHHIVaV1E6q8iYztRLhSqMzddPftI92TAQiBLhmnKK1wMZpy2j1wqLxd0Rrx?=
 =?us-ascii?Q?n3IKAWoIor1Udu3shFM6ZyScvlh955Z7xhjlZcnju9D6dSR6TS7jECui1I1M?=
 =?us-ascii?Q?9VJNWHP/obrJ6arNZQ0RvwA7Wy6Mk5b18DNWhtxGbgAS2i3Y8JHsHswoMd48?=
 =?us-ascii?Q?JUvfH9JpNDxIBG5o4U2ps26fQ/mpTlPgng44ih9KnI4Jgv3BVOaA+M4T/65p?=
 =?us-ascii?Q?Rr9SNhLm8h9An5dOvpVlib8y3vmqS2yCUzgMEPQ36ICJVRUaCaDPRfZ2Hnw/?=
 =?us-ascii?Q?nLKVPB8r6aFNvHNJHLEO+kCETkBF9wLRvwZaX1lTS/t8o1i++mjEJzSck909?=
 =?us-ascii?Q?nZLqQZXNG0qbCjHBI+S/aoRr+qkyt67Ak0naIz/o1lVSzVuSm2fsMZRMq48l?=
 =?us-ascii?Q?56IHY14yKXDTyb8CdHAUWGCf0e+oq43JWvf2FZ/dGZPZ7O/3OP3gWJj8CzAy?=
 =?us-ascii?Q?jMnuEq2CZ4TOjGr/NKyo6McjFN4Xg0HlHK3/vBnnFTBFLmutbuafs4pg3inU?=
 =?us-ascii?Q?MI7cQtmjy89cb43hVgN4+ZVfz+qxw3+nbwvlZpQinLf1giOnL60NYc4IWfx6?=
 =?us-ascii?Q?u+BfJDTyBroSrVqcsIQvoldjDk8Q/uzLnqE5vGqryHIN8nGG9WZNgBZglKlR?=
 =?us-ascii?Q?7o0nmnDhL90wKhe0tPIp2XbcQ1AZBvd4JbDSyTHM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DEvJd4MTvMo0sHOkcE51Xp5bdsKlyztPRo6Y28CXXiYO00fPFzxz2yOmSYjMsfCADxuzWXx/7Y5FtNOuTtu94RUfllujN4sSFBy9L9Fhkjk3U/RxXcj1GmxebDZgd32dHM+1oJemvmRaRh323jC6wCPt4GRo0IN8A0T9pj9SULDYD4swJcBt4C0HMHaVftT1OWy2ACQuaB9zVX66cN3kQc5Meuujm2qYpOlJZ+SzagWiBZSo1vmzzzsD8oanp5uGUDGkhQcMs5DaxIWLTpNNLszDj6xmmWiXTWmJlx7VKjhyZ1VEhVvHWY2GfuKtAGiersbxk/eha7ChNfBncMjziz8CC2E3KOakVYugI/dwcVbYYnJnL82euPqtvpvagAGB0oUKFmV0Pt/s91okNiiHzHoOON2Qxd00CblvJg3gATVgHMz/7WDIhj9FrZi0JXEy6fPm9xckKLVU4NnUtwEznhUpFIa0qbFWwPJIdITtj9hGnw+doHUDnSmJ3xBsZ2jDX/wPGRFygRLLcq3lxIgZjWCCOO1E1NMa7hyn8BLUICzbZo+vUBw3ObhvzdvPSFOJrlm3fFVDbMs0d7QVIGodFYBqv1rOLexIS90tzOsS3rg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b30a84-55d6-43d0-9caa-08dcfb6cfab9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 18:34:26.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WF9KXIb+OIow6hBdFF3wKZjy3pE5RcC3L5tl4wlD6FH8ssIc+uW9BzVaslH1H3WN2intKlXaA5zAY+vkRweYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_16,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxlogscore=829 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411020165
X-Proofpoint-GUID: 0KvLt1AOzzAtKfzNEPSKvrx-llcKnqFZ
X-Proofpoint-ORIG-GUID: 0KvLt1AOzzAtKfzNEPSKvrx-llcKnqFZ

The following changes since commit d5ff2fb2e7167e9483846e34148e60c0c016a1f6:

  nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net (2024-10-21 10:27:36 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-3

for you to fetch changes up to 63a81588cd2025e75fbaf30b65930b76825c456f:

  rpcrdma: Always release the rpcrdma_device's xa_array (2024-10-30 16:14:00 -0400)

----------------------------------------------------------------
nfsd-6.12 fixes:

- Fix two async COPY bugs found during NFS bake-a-thon
- Fix an svcrdma memory leak

----------------------------------------------------------------
Chuck Lever (3):
      NFSD: Initialize struct nfsd4_copy earlier
      NFSD: Never decrement pending_async_copies on error
      rpcrdma: Always release the rpcrdma_device's xa_array

 fs/nfsd/nfs4proc.c              | 10 ++++------
 net/sunrpc/xprtrdma/ib_client.c |  1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
Chuck Lever

