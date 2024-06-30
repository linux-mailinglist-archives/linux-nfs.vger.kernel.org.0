Return-Path: <linux-nfs+bounces-4414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66AA91D22C
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7850C1F21349
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8A13DDAF;
	Sun, 30 Jun 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mwtjf7o7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D5uu2UC2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6B12FB34
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719759010; cv=fail; b=eIgt+Z5sTtdGaNtKkL8y6W/AE8/1+gTzLF9lbI+jAsZK6Aq/uNdHysKYWH4y+ty0uouQrqnKnKb63gBTvLKo2f5qyIq49rybMm+UBLQmf1JnGVXKE2IgEySYbOKQl8CQxqfFIicbtHnhHkpu/h5Wx0vSraccTof1Wtu/C1TqRrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719759010; c=relaxed/simple;
	bh=co1TNscjp4/i1CYhuUb5jzkKF54wDA2NvyguxcSTs2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/OTx26pW/f+7HLoBJHv6prTjR4mvDi1t3lA158Ej47pzgtiXRRwl0/yaTF4XklbOm4mBkP5E3Bbtk/+hu2eqbkCvaobzy1yr/AJ6d7VIQiASRSbGNGHqToL3MSq6qg9bwvVxZU7/y8s2CGtKdAs/U4BF0avlizVVT1d6lzedDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mwtjf7o7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D5uu2UC2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UEYof4026829;
	Sun, 30 Jun 2024 14:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7eY+jcTgwbxluyH
	SKMDLK6XZqqoGFYfs0c+BfEeZ6ao=; b=Mwtjf7o74sAI+bfhVf/ft0vJnARFwPI
	4rFX2kC71ahg6cEgFB/c3iJ1JuUGEmQCYNfM9zitFlJqM/NgEVu3Z0ei3krEZDTW
	MYMtGe30jslkcch4+XA54ZbUlySypu7auFHSxgElzDSzlKlm9GxKRajouI2wK+zp
	YYjAqP/RE7ph74UZOFLtK8myxXd88QCOYTwXydVlB4nqpVKhV4zZ/eTd3kX95WZT
	8OZ2cgqxgEo41GsYUTDTN4LNVOMc8lMFwZB/tgsBe2HUEbIMNbd1kglX808ptLah
	PHAauRkEr+KMXJ8ZKuPNjVRZkKv3pczYTpoqzfKLtECzO/YEgmVSL9w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028pchbm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 14:50:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45UA5cSk026255;
	Sun, 30 Jun 2024 14:50:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbmvnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 14:50:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRvt+fcEJciyRBtvy0dZPT6kMHdmDRARiTwC3zlF51BxAsQ1IFWQ6ugGBpZNZb4ULJLvgHSM/8/KV6CYbha03a+Jg6BxCix3S2iFUzN+Ahj5E1abSZoiFiRimAmiJwbUX3DC3WvOAV3QvyVe40qZaQfiSCmnzpkmMmMRVGsgUJoN0krl+4wZxDHrh7/bhg+HHnkfJ9OwaqzewQJUY8qQ3C/dZzHdEUDKsVDsbwLjY1AsOpKFgVZlmop8dL1hK+NvEFUpzLdaY4YdVrlKwmIpuj1jjk0GcHR6cfzrlc42htpB+Lnh1NcRq0IWdTinSs76vTg+coXBxYUXAmQqwVybUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eY+jcTgwbxluyHSKMDLK6XZqqoGFYfs0c+BfEeZ6ao=;
 b=IZ2lyau7wugsq9CAQm/fmLxTRmC7CcvNPLQ4weIQczA8Ym39jZfvGF6iq7vxBNhF+wUjvPH09uoWJjgidrHLTFmoeP28JpqzAdLzduTj8M/GO0QrBNYN49FnY2wBJdutop12+H0FzRi01Fo7CE9nz6jQv34ZQX+zhHRHZ3SttAnLX/Degz+i1z2/yOW7xrVBcJc1IJyg0pY6KohLnvzeW/rjh4DxGpl5g/6m0cf/5FnjJu3YXeY2ACFR8iV0L3kpA/qxWvMhuP1NUiyehwi5KECDEBUQvqk9qaNXWndRhOXZ5RcG5f+J42QCdlcJJcASJ5NVgQ538Q5lmKfy9F7bAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eY+jcTgwbxluyHSKMDLK6XZqqoGFYfs0c+BfEeZ6ao=;
 b=D5uu2UC2skfbUqaY6j64+QcH+TyQRDPyjgxmPjD+kjgkQMBuel+nbSxpMD1ZOk4OLM+jPldR/fuinNbYStRZJq+46Y4TusShasyggTECYGMvta/cRbtRU4besm34A6WqnGbEctAuaNm2TM82CtOJLkB829yphBt3+7b2vDLUqGc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:49:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 14:49:54 +0000
Date: Sun, 30 Jun 2024 10:49:51 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
Message-ID: <ZoFwj0gkBf3Pr1RI@tissot.1015granger.net>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <20240628211105.54736-14-snitzer@kernel.org>
 <ZoCIQjxougYwplsp@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoCIQjxougYwplsp@tissot.1015granger.net>
X-ClientProxiedBy: CH2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:5a::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e99ca1-765b-4346-674d-08dc9913e719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?czyfJv1anbb0vH5upRd/3wW3KVMqShqpeBWaQ9iW+bPZWs9s8AU1ZDNQtM2Z?=
 =?us-ascii?Q?wgmhMCXvfF3hy4eupHnxkxNt1omtabZgkypdWz/pFDSZ4Cy94PYJP2alkanC?=
 =?us-ascii?Q?6QmrSZWX0oV7lC3yIBPNJ8+c8PDSw2aCnja4tdzXSrKcSw2XI8uaIo5ocppd?=
 =?us-ascii?Q?EdRqCdVOWDYqALihIKdXsUmxPYqHhZQCuoxxiaUIjihsPffO2Y5GD11OEEKM?=
 =?us-ascii?Q?AB02lQvz4juPuCpwab886+BiXuB7HAy3aU4HEcjNZyjLwBDCvvifpRCV3GQZ?=
 =?us-ascii?Q?p7l1Z6DLmeIPvyJSlxUQ4kUYOp/CEho2Vk5XdPhL/SbMCms1TVEWL9MC0zNu?=
 =?us-ascii?Q?poKvuVjEklaZtW3Fp6V3xsjXeRv8Br75i4Qh+YMeC04x3bLq1w4Mk9VZSQHI?=
 =?us-ascii?Q?tGVbk3qmnFDZ8Y+gilhFkPEa52uo+6GKh4nVXcLnlsB5y/66UjNRi3AZATjB?=
 =?us-ascii?Q?dYZO6ege4xPxJq+D8p4qsSDMBW+dl6JXIBApKsPwwqz22xF9170Y1n3NwQTT?=
 =?us-ascii?Q?VueaHKp0v/fThUZwzUZSaL36G0lnz6EtBfxbmMgZQmPDlcWYBgCGea7/QUke?=
 =?us-ascii?Q?ERqit4C5FAywyevpzpvWWrDTzQ0xOVj9KC3WJKvRVdXGt+zn6E990qI2efRa?=
 =?us-ascii?Q?CXQzViFbP06hEFhZn7b5zziIgKC3Qq1h7FhAw1LHvdb6O+TnzF8dF8XT77Qp?=
 =?us-ascii?Q?9ihb2nXKQQPvsTd9OKiqMurBhX83GDV+Rhm0vOMKbl9hpXyNorMYxLZzGle/?=
 =?us-ascii?Q?BRa0Wv0HoZTBJchGa1LFDOEhBIUGz8pfabIbx3I0WKdm0P/H1vpzOhVlr45e?=
 =?us-ascii?Q?m69c8xqXPfGxRZVt62AsYljRq89a5WfrtZpIQDWRwfMtMEChMnYwOp46Y0GV?=
 =?us-ascii?Q?7iZ179m8NpIlcnNT1rPYfgsa6hS0QfGdN7KgYc0hJP5d1oR4kBISSVWCxbXi?=
 =?us-ascii?Q?yEh1e64KVRKq6bVuwT90ZcZ4GluTsCJyHPIisaldRm6z38YuO3iZnspScb+c?=
 =?us-ascii?Q?mV1AtoWFuDZi676HjQSB9zGPuZsd551VP4AY6iWkCEXGLCuKaFyIGFnY2ggU?=
 =?us-ascii?Q?MYOLOcpi1uvFWg8SS4eICMZDj9u1vqqNRVHrt+nk5tDhlC6Nwjgkj08t7Lv5?=
 =?us-ascii?Q?NOTGRiGTCmRISV6UiqNVMBiz6OhrlnXKdnMvsC99DDkO8WppPgFmkjyprH85?=
 =?us-ascii?Q?IwoGRDm2gZHH/n+XaTOtg+NSrggiXzPUcS717BQ6i2g3eZ4kQz6GAqfLAZZU?=
 =?us-ascii?Q?ycPJFi2XDEnbyfj7QPJc8XrMKvRaSBgz8kMofCeU/HGfmMeKfXI7WATJROKW?=
 =?us-ascii?Q?PZJJT4asXjcrXu7/3t1PxJE1fqG5ME6vwjIcqmC+3uWJtQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ansFcXKRMFYBGTtKz8E27RsT/mP+Qimoex+4e1c/wFYOgBJzYBAc2DCUH1xy?=
 =?us-ascii?Q?kTzR/yhq939QxqEFsFs/81V4TCsX6gqbn2SNXGp3i72S87CwG99rSizpDkwL?=
 =?us-ascii?Q?2kYTNws20c7/fgfTeSUu8Bl9jWmjoQpkWjRNFkOsFkMsE4ao6DW/Y8XocBSC?=
 =?us-ascii?Q?Sa+aXmrXH5qT7WAuz2+F4U3FLrqw5E7ZTTG/mmSod3z5FvANucJVFsnxztLx?=
 =?us-ascii?Q?IXbsrlWT+VFUgWQq7XEoUXNSFHh0AQDlG0XO5m2FM0QHxkr+FWes/I3uxpjt?=
 =?us-ascii?Q?z09gG/scaOTIKfGxYApJxenFWIBKo/Emobq89JS2hijRLomkXnhVpbcRvDx4?=
 =?us-ascii?Q?ZJ/aIiprfYRr7rrFLZb5ZA/jyNrBOsP9XydUixI4BExOxAmIDNNvEUySAqVl?=
 =?us-ascii?Q?snt9eaxN3rsVz58pH1DLrobgYuxiXT6Qk1TIXFmqkzXKsSQChaOi1YSWeFly?=
 =?us-ascii?Q?t3bfxcCKCCjjAn7eIRSnHOstDfHjS6GnpuJCLQ1HvUeu+BpokGHEuw+fmra6?=
 =?us-ascii?Q?qUvwqIWClbHy6u8e3Vlmk0Kv4DSpCU6kCl3HOsjoxEmJfwFGCRrqB14BM6IM?=
 =?us-ascii?Q?FxsdyMNXPFFCFuPiLXUGFHaQr6/cZSC37NSoYg1Dc0+4OE+daLoJ/BDXXI/Q?=
 =?us-ascii?Q?GOY2/BuoGm5jg/eL8UNMal8gSSXg2t+OvK50Q4PwNe7KR3HS2BiMbqrtQznL?=
 =?us-ascii?Q?TQcLBLvtYP0KIapZNxUd0k1bd3q/2CdYbpmD2LKv22cvQfVNg+QJvpQUr/MH?=
 =?us-ascii?Q?d/Pz+6F+XU7YAywNlWG3BaI0jDQK44lB+/5OMquQXfsG3yzg2GsDXVUnqLyO?=
 =?us-ascii?Q?lI/1OT4MR9dS77LqDHCkcU85cjY1dUdIa8iIaUEgsFsdVeCVtFpkUQBRXF1l?=
 =?us-ascii?Q?XopXgvkZAWC2hJF37hY6u4tA+GFZqyO1nKq2jA0R3oQeKASHGUXmYm46Q83s?=
 =?us-ascii?Q?FaWPhbvYpyGf1NVIGaNf/VUzacya4Wwl3UQTX9GSJxZ06K5XRlrQLQoo4G1L?=
 =?us-ascii?Q?KxjeOWKO7puHZE9Zl/Dl1/mCptw0J41W1ehyIhjkIocd5CGT0KCcPinrbzvA?=
 =?us-ascii?Q?R5j63VVLGbYDlPQNh5mSeg5ok2yWdCHSnaogNCG6qwYEPzvGX7TRHTVAFsNg?=
 =?us-ascii?Q?zNdtVTZSqtwbOuvSHHoXZ0lHJ9fUvUQd3CNOfJqS6KCYIAxvKX61z8yG6pqv?=
 =?us-ascii?Q?iwZ/CrNLtwngMCR00HjAIYDtn2ABsqQ15L55M1BaX5ZabZVJnFF7aZ4F5z7J?=
 =?us-ascii?Q?DHzhM9YqWphXgAjFKe42vRlG9rhHZ8QLBXCfRkp6tVoZj1lrj02JWEJwEJrk?=
 =?us-ascii?Q?a6O7QRyFudNQM44KlLVvR5pchkdr4duxyojFa6l023To/9MLUzWG8YUnocEa?=
 =?us-ascii?Q?YGE1yV/NpiLeuw+btdlml9t0INYxOBV1mMQsKcYIX4K1p9SWrFGC6FFB7DQ8?=
 =?us-ascii?Q?X15uWmZYY6xq/qZ558pG4JCooISZtpIfjDsREU1DyXjPwtOhlHGYHjYiUOJj?=
 =?us-ascii?Q?DtBLpcL1KrBGafYvGcXPdxcD22kkX1lSt4SGS6Xg7IXGIJXdG9JUffLVVF7C?=
 =?us-ascii?Q?uyHrllWUZY5yBX8doTp+eUb7Bm89DB0OE8NqIxTd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/EwWWP7mNJsfWtuH5LBo4VMfefwV13MGiQ6AtFglHK84EhpzaXzmP79nrXagZndM1TBWGLRlbohQrqa39nIs5Rnia0OubrHpfTWKGUNMqSeLEaT+zrFFoIuBcHiqCRYnyhkTgfU7LQm7p5ZHgUZunrrEHbD+TnGFl/Ji+MTzO9B8Pf3zLPnCh2cMFDVvtlcjAeeTdQFxE3iZdfiA3TgbiVOzw58eYefpU2eFHZB6i/q0x/T+tuJALEPHHl3WoWrAtIoDDhhtzbWw6d9w9lQjeAylZUFu12uN1PxJnJUSLJRQz60Jz1/qvhVj34FlQDw3UpoWgFHT/8uAcwfdH5zdnbP+qyirJedsfNNN7nxmpXmdTguiLTBKlrvtvHWsJJatc0SfXtr7SxPGQ9PMyMpG8ZwwpsvNW9rtOHM+r7lg9hRhyfsR4T2KSrt5Veqf8Rasf7ecK+HVti3amfreYyQAsBo41OLUiDkyKpHPd+y2quksrgxsGmfwx/DS+07Vplf2DBJ+0qZGVbgTs6xFn+DS8XOe7VIqvSOLt+fXr8kcLjToOQOs2MuxUfwXf+HU3AmhJ6H7+KG/j+9DFY28eRx4riQ/Et1NfW8Q4V/P0pDb1bk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e99ca1-765b-4346-674d-08dc9913e719
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:49:54.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sD3eH4UN5PvJ7mkv4K6i+QacNY0zmsY06GcwJuNNmTUGrGZ45LiPWmWArN5J4uUZNdu8sVKDnLu51Ic6dqirA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406300115
X-Proofpoint-GUID: 25ZosVcRtSlHr9gQCjyvQ8ObvMZyNehI
X-Proofpoint-ORIG-GUID: 25ZosVcRtSlHr9gQCjyvQ8ObvMZyNehI

On Sat, Jun 29, 2024 at 06:18:42PM -0400, Chuck Lever wrote:
> > +
> > +	/* nfs_fh -> svc_fh */
> > +	if (nfs_fh->size > NFS4_FHSIZE) {
> > +		status = -EINVAL;
> > +		goto out;
> > +	}
> > +	fh_init(&fh, NFS4_FHSIZE);
> > +	fh.fh_handle.fh_size = nfs_fh->size;
> > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > +
> > +	if (fmode & FMODE_READ)
> > +		mayflags |= NFSD_MAY_READ;
> > +	if (fmode & FMODE_WRITE)
> > +		mayflags |= NFSD_MAY_WRITE;
> > +
> > +	beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > +	if (beres) {
> > +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> > +		goto out_fh_put;
> > +	}
> 
> So I'm wondering whether just calling fh_verify() and then
> nfsd_open_verified() would be simpler and/or good enough here. Is
> there a strong reason to use the file cache for locally opened
> files? Jeff, any thoughts?

> Will there be writeback ramifications for
> doing this? Maybe we need a comment here explaining how these files
> are garbage collected (just an fput by the local I/O client, I would
> guess).

OK, going back to this: Since right here we immediately call 

	nfsd_file_put(nf);

There are no writeback ramifications nor any need to comment about
garbage collection. But this still seems like a lot of (possibly
unnecessary) overhead for simply obtaining a struct file.


> > +
> > +	*pfilp = get_file(nf->nf_file);
> > +
> > +	nfsd_file_put(nf);
> > +out_fh_put:
> > +	fh_put(&fh);
> > +
> > +out:
> > +	nfsd_local_fakerqst_destroy(rqstp);
> > +out_revertcred:
> > +	revert_creds(save_cred);
> > +	return status;
> > +}
> > +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);

-- 
Chuck Lever

