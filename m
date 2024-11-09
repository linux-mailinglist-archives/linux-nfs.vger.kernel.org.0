Return-Path: <linux-nfs+bounces-7821-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A389C2ED1
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6584C1C20AEB
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB50E153BE4;
	Sat,  9 Nov 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c9hT8TNe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UhAVneTz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3792556E;
	Sat,  9 Nov 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731173719; cv=fail; b=SsxWdoXKF0lTB1MIBqjonQao2iKyinTZkzBRWU4cINxxlrAhhXyWTWs9G1iL4b2gsAA69tdtFRgFsGTuxsXT9YnXhUYF0IZ3QwbHvfvHZ3avvoaZc4ftoptzBPIokMpGDIlSLEzwTiNxHuPSauNED/Srmi8zAA9E2Eq8rCpCfLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731173719; c=relaxed/simple;
	bh=mL7H0exwZnz/4PztSLRQIiIJbKNqKIL1o5hRIOEH6CE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EpK4nIHYQKkh6p8RnKKrWHGrHpRFCsKY4nib3qG4gvQ9z0KswUe/X08EX98/Byk9B8ljGT24ClwswlHxM2X4iAyQ2YvDZ36Zuicb5XzH1GbGPZ6pNuuhCZdCHVfVSOh/Zu5SkdZqApqxgzN6o49pXRZMlB3JvyBjB2DLdR+UO9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c9hT8TNe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UhAVneTz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A98bOPk005685;
	Sat, 9 Nov 2024 17:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=fkFjc19nM1KRtwBzsaPn/niHUATA6VzznEv0dM+fqVc=; b=
	c9hT8TNewipPIxugs9j+vuyl007SGaJc47GnLWN3yIz6joTvAw5gDIMMJUgxDF3/
	ONfgwIntRJt0BLEARsR5Uu2nOiVc1DfkqfgQJGpoFYNuvx9LF+bvrgNvaTfsWLrt
	QnPQCXl4f+tWQ5BSirksl3n2V6PwdXVfJoDuspJxb46f1oFD3KGJ6MpguT031LES
	j4CKcajuLykhqT5Lw5ClKNi6KNe2OnY9mGpRoVdM1wpILQfJC2RA2OcmuCAaEupo
	ZYxGo5fRqp+gQsSRKIsrcSeekZScMVmyQ5OIQ8q2+NL0sKArTWR2UFUJE9BuNT6I
	dMwpFceFHabeu+DRoiZZ+g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwgdnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 17:35:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9F9sTr021504;
	Sat, 9 Nov 2024 17:35:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx65dux1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 17:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCsLd+JwwEpdqj1vgMiOoCS+wkJ6liIH7N5jddar7W33y7+3NiiqPXsZXy+U6gJzOU0BpINmZwiRtkH30v4QqNRLZn9Q5vcTgVmeJnAFROgDhGPb/bWyMQmWDEVSS449GAsJV+Yp9qRT4oAGHVA9IQg/gQ10HntcOxYEihzQoc7Fg1Ks+X8LtCmk1OaGsgQlEjkDXc3OfI4kyzcIUkAg2pMA5TjQEGJBn4K9p9ty5o8bokkYnHWEmV0Cdz9wGyZ4nl5DFjWESbff0zcb7UljUXS1gq1BCrVJEIgW//fG/BSwjr4XcEW506OvcVO2SxnyHnSpYG4DzOCxtADsfJWwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkFjc19nM1KRtwBzsaPn/niHUATA6VzznEv0dM+fqVc=;
 b=aujsz8WGEth2Ak5RLL9HeD35HqwUEas3CUjNbAbmSHIPLg5oFhpIJaBw3uD5k1uBfIcCaH4NM3SW33Ka59M4NNdWxUGGIV2NxYYutrtcFc7/+fSEpskH3FY3AiUwIul/7kWaYNoHxQMABgdRvJPuDQ3IGw3p3OWPLrFLwomyELOZ0xJRYOOgDZXYhz8AfQ4eT7Cu3P++z4Cg/kWGl8eEN7nee4wmSURKtV0Jh5zojSLw4Q/eb4VWISaOwls7o3xxquU9Fvr2bwojj3Ya63WEyMdmC6biZB9Ele1RPxgDFDGd+NnjeSMdm8mtocXPw9UHw3OJEpOCTDBw4mUcrq3l5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkFjc19nM1KRtwBzsaPn/niHUATA6VzznEv0dM+fqVc=;
 b=UhAVneTz77MuLIblD4qwTApfFuSCm1bBH4wz04HQT+DfZsfX/0ZiiG/YlQ8kWH76JPNDvDIQLqIYDePRSa8PZhxyk+4M09pzk9OqnyxEd9wZK8o7mTjt8nvmSTNcMgpZBsd1Jog1VGFHsSLSwm8O5kC8xTlztmsgS65mu9AkKJo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5908.namprd10.prod.outlook.com (2603:10b6:a03:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Sat, 9 Nov
 2024 17:35:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.022; Sat, 9 Nov 2024
 17:35:08 +0000
Date: Sat, 9 Nov 2024 12:35:05 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] one more NFSD fix for v6.12-rc
Message-ID: <Zy+dSVteJF/PSpL/@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:610:60::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fc3b87-ca8c-4a72-3b94-08dd00e4db15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2AwDbYaCNr3WxWjCNyIgMYYS5KxZpObosm4kICsXnEJn9sZW7Z3hZdkrTnEp?=
 =?us-ascii?Q?vs9sQDNqcbBM4jPYEKPq9IsmvlISYh5LpBIydV/s+SkgzdYoqnMudwNtMp9D?=
 =?us-ascii?Q?rYlpUXqNdODCrnmtH78m9s6xzvXcU+ZRgjVRzlOf44coZBEBr5yeaVKy67qV?=
 =?us-ascii?Q?bWUPtD8VzV8H+vSA9gJ7TKSz504rZOipUJww3vBa5DzIb815Hf0sEmS8EzHc?=
 =?us-ascii?Q?Tyt1aTvkp+mt1y+uqWfPVTXmbC+gydJCeGY2qSX+YD6iBByn63GcMvI6venV?=
 =?us-ascii?Q?xLLlxuhrQu0cNO2qyBRqJvSp5L0wEYDHHim5XEFDpxwFS2zkSusDWg5Ibpjn?=
 =?us-ascii?Q?JRSezhwDO10wQLurAceDefPuVjEr5wevehpNwt7h+TMD3y0bujJxCTvAtOWj?=
 =?us-ascii?Q?DSYFRV2ZTM6JMri+L5AHVDWg24zw2Bpn+ket88+yZXYG9WoRKc2qbz8F5fHN?=
 =?us-ascii?Q?9gOFWx1BFMafcQzZeZLfW9nWmAwfV4/bM4WDGVwsOX4kE6S2I96SrVTu2EnJ?=
 =?us-ascii?Q?DODTcDw8QG8ROgxkJCBSqw1eTKFa8UNgQ2EguJ/csMETWegx1+IVZFWGLu+n?=
 =?us-ascii?Q?ZTt8KMn2NWyI34qpQwWDe7+Gb47IbOhP4XAYWv1xB/4DzB7fs4RI2YtTJYsA?=
 =?us-ascii?Q?iZxyIBavw9ByhWkT59ZXG9vuhIYFwGURY9NeX1vttuTSikaicPaXgkhDk3QY?=
 =?us-ascii?Q?ALVz36hw+kkEUFsrW8jBFFIBAfOhW7eWkL9+oerbkLvGVgYseqHHqAuFYXHi?=
 =?us-ascii?Q?MNZv/QO1fyBaW5h/gzpuCBVH7KF3vErJlFPhdha+sJxvxi1KwbhoL8uFq4TN?=
 =?us-ascii?Q?IVft08d9/QUK3CCz0A3AxHdHXCgeXmrsEtb9I31sAxjzhmYoFyWTX+j1J84O?=
 =?us-ascii?Q?+wXvwwy06nZGIGfRDD1QkqAgbANtTqVFQxR83EbheqRt85dLogE/cURRxZcm?=
 =?us-ascii?Q?PVILgP0Ve26eOweduSZRyAmSjU315DZ6JmcDyRkLgeFH3k1f8RVGEkNqQoBz?=
 =?us-ascii?Q?y+UrhvyU+KgqpWTLmYg62YXDGuCbAbfYSsZnNi6et+2NY63h5LfJbj4sqUF7?=
 =?us-ascii?Q?UXsmIhThjkgQ11wmqP2mDccfZlgNjw4Bl0CNab3GSfP8/3sbpXhYtTg9fv+U?=
 =?us-ascii?Q?HmP9nHdmspGWL965U/WE3U4BiD7V8OpQPfKiQip81LBic2yF1dkGScr7vz61?=
 =?us-ascii?Q?RNOQ3cTH/8StYoRj3gxJb5YiaQge2DQWS/470gduRGVCGxzZfSVHT/g3D6f/?=
 =?us-ascii?Q?j2U8Z5YpmQ7GAwJebfcp5iszQJ0GSrmB66H/UaJUHvZq+lzCCXSgaTXlweeI?=
 =?us-ascii?Q?s18GvRFOCdZk3RnaaW1oYq6H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hY3NdoprJ2zVP3MgScnAbX1PqGyfVAHjQ9FAO+nlwTqH6ygfk39IvHBEhp5M?=
 =?us-ascii?Q?dVcKwGFInz32D3Gaujod8Zw518iJPk1q33TjscHbJpm5ZC84+m5jnKaEp6HI?=
 =?us-ascii?Q?WJSWUF9t1qcuXXroaUCLiwLiRaJ+D1W3NeHRdfz+jGJrCmQaxIQmXlc6fbFN?=
 =?us-ascii?Q?Bs7HnLT4hd4dn01U7MIm42J5M/L60C28faFQUnWnW1FKwr+7H6gPlST08SQI?=
 =?us-ascii?Q?s1Qcc3V1nQXt1jQTuTrzz/8qQiL035l5LPyrvvWlk7DADgPneEdONHu6LXVE?=
 =?us-ascii?Q?09Vb52ZO77qMogwbEqWs7KRnd4UkECyDJEhQywdeZhfx06abgIVCu9Gj+BSH?=
 =?us-ascii?Q?3gpYytqE84uvZktDr+6AN8DHmYqM/YNiu7eY4+FrYl/D5bHuA2YPP5uABmW8?=
 =?us-ascii?Q?7dhzg0w0WS8P6QWcfEr3zCsLn2HAjkumQmontsXXmmb9e/ogy1QugF9n+fJX?=
 =?us-ascii?Q?0lnXLEpmrWPMwwZ/Kn5qIgbh6UVTcI2JhHI15PAw0HFsBy5+lIlO+Ggawc4Y?=
 =?us-ascii?Q?rvuu8dcIi0+iHyJnSkNVwVMPyWlb2HC1mm5KgtyZbIUSkctRatpumHNsN3m+?=
 =?us-ascii?Q?txTHyXivVp7EscvXLBUwOUT6zHeMYxIp0H6BuQKrf5PxfWo7zQFL9APmDfmA?=
 =?us-ascii?Q?DMNIumONyGf8iJUJGL+b9V49D+gkoH2SIIOicpq7gmrc+6IgNOSpHDSuvIKG?=
 =?us-ascii?Q?Zn8QpJ6NzK6qtWwf2RNX14txHD2BSDm3HNPeuN/bDMRsfIQ82vcA8TkXp1ou?=
 =?us-ascii?Q?lvr+Iuaw0hQeIZHiz4HURSZFMaXFcJkEqPmTLMpkq9mtAvjQCd64F9Mn2mAk?=
 =?us-ascii?Q?ZyWnerDOCnGLYqE17iWsaznIQf/ghw5jKgSSksBIBlKe25JeL6HkgLB4re4Z?=
 =?us-ascii?Q?etxZlfVIP8cug/A6NImQ2kixxoGAXllrLSz7C9+39emSz4/QjRyUCXZ2F+FD?=
 =?us-ascii?Q?J5yifGLPn1Np06C0VSivMxTMZ14DjRggcTH5pNltIetHWMU5UXa3VJssTm7m?=
 =?us-ascii?Q?hzFvAoDhBxaoQCnvCFGxXRUSvFDZ8gmkPJFA1Lb15MwHdeJ/NFKeLosNt/Qg?=
 =?us-ascii?Q?XAZ4D6fI013H18JEsaiEFrYvC6eMACK/cd+h/9PzobYrCsRlgd50IPSWA1Lf?=
 =?us-ascii?Q?itz2QX2KCo33OjCvRuUKglPYlDHpZV+pfF/wlAJSFwPs3XTooC3SO0CNmbNU?=
 =?us-ascii?Q?BQfKwlPvRLxKR8kAus9t/OLDHx+D4NkSUvAK4bMreR8VNBwHwjwctzKFNzCo?=
 =?us-ascii?Q?aBsz9ITMwE+OkTSdmN0dxsJnSSDHadarXiMMMVIm3dU3aROo5kXfh+VgwFtI?=
 =?us-ascii?Q?z13j8w3sVeHgyTsXAFX2ZPPCJBjOMW1Rwh9WmbWRWxRgtGRIiZ0HoF3/RUXa?=
 =?us-ascii?Q?Ro2s8H/CM4hDjxYMzwI71eAPwRFo/P+WtpKU2c7QnL3bU9E+c/hxttbUhwYM?=
 =?us-ascii?Q?etrgoMxY5fAIs3PsQn6/yfPFDhp62DvBOnBELHgkjhdTtR0rdbT5xx8lddlH?=
 =?us-ascii?Q?vQLCjXe7WZKquobVP5N6h3pfnBZACjT8qa5BwT5DzF9sN17YoA2Zyb5qnee1?=
 =?us-ascii?Q?czd3QapftHSszanoUubKDcwRCwMBjIGkTR5ifEPh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mu68Tjsa1JUax3aIFweKYEYaZCJvbhppnJ1uhWIloZmPXuyCi8xiJ0hvAAK4tXNWpNEF5N3LvNr60g5MG2Z0z0T2zI6haLaxXAU1WkTJsRkYBi3qEoA0SLF1xan7NDeuQ5yJ+2YLFHrKlM0tGDc6mKLSyo18StdIxQCowDah/Bp6tTGBtAt6FmSEMV7J5Quh9OE0oFptJ0HY37+dAq07h7GtRRs3zEIsUVXBY/T5Y/LCD+vn0y9YK1zs16c6zgFQgGyrF3mLJVU9c69mJ1F3Qk+41EF4I3OzQ19GBbS9BBTfaEx2y6PuPPovD2xrsO4itqmHPadERZCAQ97h/mFO41cKVp61YXISBKn9WrI1WEJjtcVhF415wtLkY3fAxiAPJir+YNprVkHhJWi0zUL3c5DIH1RWMZI2SQ5vwK4/bJQOe1ONVwXKYLNQVc5WAWgvp2OcWYgGgLfIuneUuKC5TLy0HWod/kpx3R9x+GGQyP+0k4x0nVTY4f7PD0jHvNXyBsPRw9fSM/OVzS5KCPWWMCuGWdh+tsIzUTTgWWbQsg+Y87y8O+7CZQ4iuuTNopxzybhdP+A36rSwPXdzNKgJ8krvgK7t4Em1DPbVneipwQ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fc3b87-ca8c-4a72-3b94-08dd00e4db15
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 17:35:08.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HY9tESJ2pmXwn4/5ZOJHTjtNc4P0oBC6CtaqygF4ewkxZgi0hzh5Vj+bCcVSRbKLORIBeOHVFRM7Rgm9nVjnXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-09_17,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=720 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411090151
X-Proofpoint-GUID: dA5Zl_EodXmIyvMb49PJa2cu561G6YqG
X-Proofpoint-ORIG-GUID: dA5Zl_EodXmIyvMb49PJa2cu561G6YqG

The following changes since commit 63a81588cd2025e75fbaf30b65930b76825c456f:

  rpcrdma: Always release the rpcrdma_device's xa_array (2024-10-30 16:14:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-4

for you to fetch changes up to bb1fb40f8beb45a3733118780a3da24fb071a2e9:

  NFSD: Fix READDIR on NFSv3 mounts of ext4 exports (2024-11-07 09:11:37 -0500)

----------------------------------------------------------------
nfsd-6.12 fixes:

- Fix a v6.12-rc regression when exporting ext4 filesystems with NFSD

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Fix READDIR on NFSv3 mounts of ext4 exports

 fs/nfsd/vfs.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
Chuck Lever

