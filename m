Return-Path: <linux-nfs+bounces-5362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C27951BEA
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E2A1F2472C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0681B14E9;
	Wed, 14 Aug 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QZwPZd/M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nVoEeSjo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE51AC431
	for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642301; cv=fail; b=h0RZWrN3lusbJASSp4ZID5CvMivcDjnWi6Bap335nb0sBH5jZ7mdHUcBUhSHsIM8r4tdMLdlqEoHM7f7hTEXMdk1jCDuCuqnmViuqyQxR7em+Zbof3V7MsCWdWozm3UXIhk53WMzwvl/N2URTJB0kXCLJuNCnEJwgZlB8Pv23t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642301; c=relaxed/simple;
	bh=k0F8sYbT9UjOIDKWg4So1D/THPs2rBmqg+SAoy0F4vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCHXzg0Nq+giHR/i98p5KpNQWIOvJZGcgAPjKHT9y+yvedWIeF7+iN8n4f7DGsx6aHwkBZsodfasbG2dS3waw7ddoFQzyc35gl7AxzSvDraP7qEZRXtgYue+o6O+hLyD4URj8t4YZYWsWIvRHGqjy5yq5Wyaev4D0CYPFIcMqDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QZwPZd/M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nVoEeSjo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtZFu007009;
	Wed, 14 Aug 2024 13:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8aB16X+ByZ7QhDX
	0LJiHOsP67eSngEmOH2+Xcg5lH7c=; b=QZwPZd/M9A1OcEIuz3P+gGeQbbEwnGB
	wcZsaOTNbPicYb5jvavrmbNf1YIgCoTWnkYycLxMNRjwcwEBhbMG2eJytTVhw7ga
	EczWlvNu0RfRQXAPcDqTaUjTtdtIKpqcl0/4W2FAYjdE+MllJDGapBl7RPks4dQ5
	dSsdnOS/LY5Ul1yQHGbJjHGHUK43neMWPzjQEWgDgSZa/2kdv3gBwYggTCSU8AjS
	mp+BaOQAfEMB0mlJhP1+liotnDVmkVcTGwfIsVVbzXFQ5jPvh5AxX1IM0GFHYlVj
	RnSJ1eKsAYswHkbhbiQZsUODzAK0j1XOUeLC0t8JRZuWYeV6V8qOQHA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x039865a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:31:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47ED9FJw000624;
	Wed, 14 Aug 2024 13:31:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9uwwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s64wmrR/bwW0B7fxiyJraB7om6eNdKsOF3DTNwT++zFGP+tHBv8Dk2Qc9JWrowI4TNVWywTy5+67Va22gGU4nEW8a6uHWUs714ZaBfhWLLgjSXmf1zHLf58HRFhUTA9UihpZzEB6slqCGitMUHrbBaznLAp8+THO11RW0OsOwi+3rcaYC7obfROWEXzfMgQcfTONNse1ePv/mtIYhkTaVTYA94FgSguz/0ilz7z8Tn8GQ1+Qzsx/Jn6WdrQE9YvkAKRmNTbQYjY0KqNirNgSFEktA5UTLaIz/i3Eq5H18h0nXYyLz2mjiUu03DZXhErl/RtB9arhrLfsQqM/GoOCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aB16X+ByZ7QhDX0LJiHOsP67eSngEmOH2+Xcg5lH7c=;
 b=xLTfmSVg/kwJQ7jh3DBupSjnebVuLP/bge/JhKA5ComATNaAVrno37ZL0guc+VuXwNvsNjzaxAFRKFVbt2+zacf4S8B0TdqyWJ0M97E1AKHaZZUBCfLzFqt23VHEHJwmZJqwxLhBQLpyDyMnDcQubVBGdhNaswHp4gCrcxntg9VXz144ZuQCrTZMBMfs5mAT06nggN43MZT1Cd2b1lsgEeUMVfQqDy3eh5bfWBQKo4lPrTTfSdbJlthrrr4hjrEFYzw5pQIT/kickrn3tWs9iOpwJ4vtZ0v7pc2S1u2xpfQzd3jfr/LmcRxJOvFQPHI0cqZnzomMsrlYFJNnPpcJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aB16X+ByZ7QhDX0LJiHOsP67eSngEmOH2+Xcg5lH7c=;
 b=nVoEeSjoOhAYnOJ7a/+Emno2BTsX2wIyes8DGby721S2MKnTyYz3sts5rF4m/7vBJdXVsE2IEBCmv2YQt5VVWOJgz9zw74Tj14yIOaCO3+EesZ4BZgUSlckto/7jPMSmgNEb+15Fyq9pETAMUh3bhS0Gpw8ayRxkAdUkjCZA6HE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Wed, 14 Aug
 2024 13:31:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 13:31:30 +0000
Date: Wed, 14 Aug 2024 09:31:27 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] SQUASH: nfsd: move error choice for incorrect object
 types to version-specific code.
Message-ID: <Zryxr3IJPnvFIrTg@tissot.1015granger.net>
References: <172361193894.6062.4098495640528994632@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172361193894.6062.4098495640528994632@noble.neil.brown.name>
X-ClientProxiedBy: BN0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:408:e7::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f60bca9-092b-4b7a-8c9e-08dcbc6567eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txau0fH2o6ZgLP7rBvUUVd8hlhVvrHo8Q93kUPVxwnQgKam+qvfXv5jTZeAy?=
 =?us-ascii?Q?EruuaqpXcPscc6uU0BjT+zfRZrrFSF5yCvd2o+qhFY0NB+2dmPJyoYV5aazd?=
 =?us-ascii?Q?fz364nVpcwxToiiq3GntFbMyGps56Ib136qgF1F7jAQHy8pGDo5D8CPBO+YD?=
 =?us-ascii?Q?mY8dR+xJv42a4LXgXGIeADFka1Qdt/wDjOeNit1zrO3WMPcWvGv3mV2WSWjY?=
 =?us-ascii?Q?wAXwJGORH2DJVXnl7IsVDHOtxYY8JtAkCYNMQhRXz+u1GjJzz9VGBo7egsG2?=
 =?us-ascii?Q?AgmWyr3B10E7U+7a/HS7ucVWSpgSA/1wV4vVyTSA64JDtIKi8Bzp6BU2pPga?=
 =?us-ascii?Q?/9UmMghh0G4DCgYLNsdYoIJNIz26slQrS0L8wJHPHLNVc+nzSOSdAuwM++8r?=
 =?us-ascii?Q?NgCFvXDRyMMzHsWIu8PkBmD1zraBlNn2y7cDHlwxlneW0ga9lE/MYumTR12g?=
 =?us-ascii?Q?caQX7d8JkHEkIAt2ijUrNO6r7WRfLh08YIiUNJP97BfaN9KLaRpGty3/KZiz?=
 =?us-ascii?Q?GSuOoBttRe1pJF80uTZfcCJSnW9jsqthENTExqrJWL+E4LVmUBEu1sJP5vVT?=
 =?us-ascii?Q?k/mAtS5d+sqjRsWcTxexTZLNFZwGzZkp5Pe1kEWN0UvyNA75AUwQGETSRs54?=
 =?us-ascii?Q?QJBoQeC93nQ7weEvmEIQK8LjYQkNu1l8pqdTe1Kdv7cTRhUlQio9VvtW+1YU?=
 =?us-ascii?Q?iWPmhE9+4kJStabpwsGTAikWeP7Cej91tYgnbUfh653yEPhBaFk4UbJZN1Ym?=
 =?us-ascii?Q?E1jl/S+gJDwaYP52ltupN8fX1sihQdEC0/PMwPw+YlWjQ2z3DBpDMRkApgWb?=
 =?us-ascii?Q?EFOM3dXn/iMBwM6z5M/jLk2K4QjHdvRRJEJrqYy1XPCZtsxpyDtCTdImBxrK?=
 =?us-ascii?Q?uwPo4rMOsg1r7ZweezZ6uEn+3Rb4AHJYKMtXvOrTd9XZri/Kv6tjdOe4XNSk?=
 =?us-ascii?Q?wz4lVVXNBGT3QDwjE5ISETk9EN3dHApYrLUfPTuJ+pkEypmKr0ECOTNZmaU8?=
 =?us-ascii?Q?PsnZg8jlY/0LU71q11WqCLh20PlEE0yy1JuwQOJUM/kiXaXjWPciSuBkChsD?=
 =?us-ascii?Q?6Sn019bHzrqnfTpQDah9LXgsIIm48J2eCD2uwB1qEzJ6PBWTFkehcnXPqAMv?=
 =?us-ascii?Q?h4L1Kcb7ENzWC3KJ40b0rxzZlKq4bQclCDUkNe+prJ9L0Te1YNmVtFH9tJrm?=
 =?us-ascii?Q?HSX5aSWlsP/ZlAKiTyKCrjWrpi35ibUeI9FbHVzUNYUqbUl/qQRJuPhV01nr?=
 =?us-ascii?Q?eP14LG3o/X9rnIyou87XgUH1qECYrtMNM91HmK5QmKU0jk0xZANACj1U7hHg?=
 =?us-ascii?Q?ONwbETyPcuJwDtsP6gPdtrF9Ym76mzMTL00g/9H0/cFzqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B8SpMdkaUsz+DO3RImjmRen25ONx0+O77jYocu88qgtP6JA4xCh7cwlVUgeC?=
 =?us-ascii?Q?vo5bc8WI6AWf7Duxiw40VdXxfSisHKk+7yYdgBdvOsbXEfRMlYziWFvJKX0a?=
 =?us-ascii?Q?6AR3fSEcj+EOoWn6HRuSWUADcSeIV3WJxQvrKn6/btV9hGLiPsXv3wlxKS/J?=
 =?us-ascii?Q?TPJR8o579A6nPRY75hAPtA7mhBQX6i7sMRYwWPXiBWRja0cSL9bFjCWyDMON?=
 =?us-ascii?Q?SRqJk/gVo5ukZ9zAQjsYZsqo633DLyh0BqFzoQ0xy1xTYyTBMMiYVH+x4+gO?=
 =?us-ascii?Q?wQeIHfzENuFINaUusG8SPfQ3i8fWjWjmoynpv5PkBEg7xa03NEPV2CfHSxWb?=
 =?us-ascii?Q?1eU6XG1pjuLKbIs3b1is35kAhyjbqYvQw9WMKAZHGPElLwyyht1vm59lf7Fq?=
 =?us-ascii?Q?oQRvVO+2rrqOl1JgXc6mDVFo7A9Dk96VI22+IXxYuBCetyAwA/8ZeVNxQ2eV?=
 =?us-ascii?Q?mwpjn9/YyUPvpui4Qykls2VXmBUyD4Bh2DJx/72wDNDoyefK1yqdpxbJNNHK?=
 =?us-ascii?Q?bCMCceBWKltfrSG4XG6GvIjVskP+EAgicnC/vMfJ9oszNQ+klOITADI8lpFk?=
 =?us-ascii?Q?IjQ5H/YFGkEeAWEt3fM0wYzUSTaotNLTzWxJLddeYFFisE9mt9VI1McyN32S?=
 =?us-ascii?Q?jRm2paNH/lbXeNGR2MAMENvVSaSMKrlndH19hN4gngi3P7DmgDzbYxeY0iJ/?=
 =?us-ascii?Q?VpeCs1D633334wKg9GFdVwaumx8Aw/18K+GCUS2v7Ebu3ghZFsjbKm6Rznu+?=
 =?us-ascii?Q?0orhChfsV0zBiadvhOzncTTHiLZIihj5L/8FVr+h3k9pkyqLnPbpYk57gbR/?=
 =?us-ascii?Q?8Wem8ksJWp6dKJU5sAQfxhXt00sT5sO5cu4LKolxYYGmNV2IoVYy2Y7z6PSB?=
 =?us-ascii?Q?6hg0gdE1aAIwAcXocV8r9suFP+LMaNGL6ev64h2oxmbliJM8itAz5DeEyX+H?=
 =?us-ascii?Q?Czz/8wJ23fkzHoUgewP0A8UylCYBl43u7fl8c/Xu/kX6wqb+SMyHJTDq1qph?=
 =?us-ascii?Q?KwcsIMOHWXdlGyn/xszLxLGWJhdK4+243RilpBUf2C7A2PZAm97R48q7BgtO?=
 =?us-ascii?Q?IrlZ9ARvh5lWRH9elKaz+cTuUF61Hl1CKuVF6iuMx2b1uZqk6GSWgibkjPZu?=
 =?us-ascii?Q?dQVsfZuXkai/XkB8oOdK7lae9A7g3qQA/wIdEnqD6FTzhYm71B58IvWhkwBM?=
 =?us-ascii?Q?kJvRhQAYn1knkg0L3kX0cmZKMp9Wk4jqSiscSuhFxf3YEDMgb0q8MsgAseQG?=
 =?us-ascii?Q?lwQi6gI0ZuWrPVpCuzr4SjhqjAtGFIZln1ICQBaVKbQU5CSFXdM7pzR9RbL9?=
 =?us-ascii?Q?7LjBxcXlX68EJZ4Um/Ccz2B0xyP6u4VY9FgRp/gIpF+0AUJJ8RsSCIy+3NvK?=
 =?us-ascii?Q?QzaG2JdKLJLk25gSgYRG9UPuIagtI4KBplf9VxxejC3ZsleNjmWZ14ctf+a1?=
 =?us-ascii?Q?8umm1LDYLuuJ2NZgryq9abYLKpLwofk/TPgoqFLRJjHPdKahfP9aQj7fxUS5?=
 =?us-ascii?Q?o0c3osDZlGBUY/FYUhCapTg/sPV3UmQXuFC6Kt+SPAtQFYkCYqB05mICuzyn?=
 =?us-ascii?Q?wTF7xmm+AvmCerZO1HwluIdnC7znSJEuP4E7OCK9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P37zYU6atyw27I9cJKVnyai6rqPpMqYCBU9H2lNdal+CYtkrD0sB1OqbBHuSQZrn+HW37Tc9WE9kZCkzOaeWOdJa68qNbmMP4ljwO/pqUioRYo75uLItsxaWZc9w20FFGqdD31zhvleTSX6CzpUXBAqU3tP0SVJIYBH6wnHdJs9tZq4P1BHc7aWLSXmLwWO7EKPLlTuA60Auq/V1Zucqf/ggS6jA46s9pd/tphIlzTDiiUgxXnbALPx16MHFS/Cr6wCO+Ohs89+e92aH20b/iLVDpaobjLMBzC/GDPD9NONCNL874JTs8mh0ngHD6KFZ82CrpfvhPcyh8bIfte+YTZl+xuomNSburqkRBOxWshWhk8Em+b2XW7KPuBl4CLd6C1cvpUEiuCO3uk3rHL9TwGsAmST8/+dzb4a8upHYGsuK+AzCfG4amSTjMxw9dEDvqYhil9X2pAdyUlI+pu5R8Iaex70i/z7DhMAaIUkdshuPo95/F92MRsbCBOV23eangMF0E6IB9oGL6KqKnFgbEdwGZcmvo2EZ0OqVLRssqDILQfvMCz51Yk1nNfCZ1ud2EsrHWR18qt3+PbQHlyj1AUUjkVyQ504nlLW1X8d7jbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f60bca9-092b-4b7a-8c9e-08dcbc6567eb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 13:31:30.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6O77BA6q1s64nh7RpcH+VyWfbnLD2tq/KcmbK5sTrx0rMBZy342wznQIWp8o41UcnznBuAIqbAg4twEJog36Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408140095
X-Proofpoint-ORIG-GUID: o15xqY1ftHrfPAHN0FtgefRcUc-fBk86
X-Proofpoint-GUID: o15xqY1ftHrfPAHN0FtgefRcUc-fBk86

On Wed, Aug 14, 2024 at 03:05:38PM +1000, NeilBrown wrote:
> 
> [This should be squashed into the existing patch for the same name,
> with this commit message used instead of the current one.  It addresses
> the pynfs failures that Jeff found]
> 
> If an NFS operation expects a particular sort of object (file, dir, link,
> etc) but gets a file handle for a different sort of object, it must
> return an error.  The actual error varies among NFS version in non-trivial
> ways.
> 
> For v2 and v3 there are ISDIR and NOTDIR errors and, for NFSv4 only,
> INVAL is suitable.
> 
> For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYMLINK
> was found when not expected.  This take precedence over NOTDIR.
> 
> For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
> preference to EINVAL when none of the specific error codes apply.
> 
> When nfsd_mode_check() finds a symlink where it expected a directory it
> needs to return an error code that can be converted to NOTDIR for v2 or
> v3 but will be SYMLINK for v4.  It must be different from the error
> code returns when it finds a symlink but expects a regular file - that
> must be converted to EINVAL or SYMLINK.
> 
> So we introduce an internal error code nfserr_symlink_not_dir which each
> version converts as appropriate.
> 
> nfsd_check_obj_isreg() is similar to nfsd_mode_check() except that it is
> only used by NFSv4 and only for OPEN.  NFSERR_INVAL is never a suitable
> error if the object is the wrong time.  For v4.0 we use nfserr_symlink
> for non-dirs even if not a symlink.  For v4.1 we have nfserr_wrong_type.
> We handling this difference in-place in nfsd_check_obj_isreg() as there
> is nothing to be gained by delaying the choice to nfsd4_map_status().
> 
> As a result of these changes, nfsd_mode_check() doesn't need an rqstp
> arg any more.
> 
> Note that NFSv4 operations are actually performed in the xdr code(!!!)
> so to the only place that we can map the status code successfully is in
> nfsd4_encode_operation().
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4proc.c | 31 +++++++++----------------------
>  fs/nfsd/nfs4xdr.c  | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2e355085e443..fc68af757080 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -158,7 +158,7 @@ do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfs
>  	return fh_verify(rqstp, current_fh, S_IFREG, accmode);
>  }
>  
> -static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
> +static __be32 nfsd_check_obj_isreg(struct svc_fh *fh, u32 minor_version)
>  {
>  	umode_t mode = d_inode(fh->fh_dentry)->i_mode;
>  
> @@ -168,7 +168,13 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
>  		return nfserr_isdir;
>  	if (S_ISLNK(mode))
>  		return nfserr_symlink;
> -	return nfserr_wrong_type;
> +
> +	/* RFC 7530 - 16.16.6 */
> +	if (minor_version == 0)
> +		return nfserr_symlink;
> +	else
> +		return nfserr_wrong_type;
> +
>  }
>  
>  static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh *resfh)
> @@ -179,23 +185,6 @@ static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate
>  			&resfh->fh_handle);
>  }
>  
> -static __be32 nfsd4_map_status(__be32 status, u32 minor)
> -{
> -	switch (status) {
> -	case nfs_ok:
> -		break;
> -	case nfserr_wrong_type:
> -		/* RFC 8881 - 15.1.2.9 */
> -		if (minor == 0)
> -			status = nfserr_inval;
> -		break;
> -	case nfserr_symlink_not_dir:
> -		status = nfserr_symlink;
> -		break;
> -	}
> -	return status;
> -}
> -
>  static inline bool nfsd4_create_is_exclusive(int createmode)
>  {
>  	return createmode == NFS4_CREATE_EXCLUSIVE ||
> @@ -478,7 +467,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
>  	}
>  	if (status)
>  		goto out;
> -	status = nfsd_check_obj_isreg(*resfh);
> +	status = nfsd_check_obj_isreg(*resfh, cstate->minorversion);
>  	if (status)
>  		goto out;
>  
> @@ -2815,8 +2804,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  			nfsd4_encode_replay(resp->xdr, op);
>  			status = op->status = op->replay->rp_status;
>  		} else {
> -			op->status = nfsd4_map_status(op->status,
> -						      cstate->minorversion);
>  			nfsd4_encode_operation(resp, op);
>  			status = op->status;
>  		}
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 42b41d55d4ed..1c3067f46be7 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5729,6 +5729,23 @@ __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *resp, u32 respsize)
>  	return nfserr_rep_too_big;
>  }
>  
> +static __be32 nfsd4_map_status(__be32 status, u32 minor)
> +{
> +	switch (status) {
> +	case nfs_ok:
> +		break;
> +	case nfserr_wrong_type:
> +		/* RFC 8881 - 15.1.2.9 */
> +		if (minor == 0)
> +			status = nfserr_inval;
> +		break;
> +	case nfserr_symlink_not_dir:
> +		status = nfserr_symlink;
> +		break;
> +	}
> +	return status;
> +}
> +
>  void
>  nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>  {
> @@ -5796,6 +5813,8 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>  						so->so_replay.rp_buf, len);
>  	}
>  status:
> +	op->status = nfsd4_map_status(op->status,
> +				      resp->cstate.minorversion);
>  	*p = op->status;
>  release:
>  	if (opdesc && opdesc->op_release)
> -- 
> 2.44.0
> 

Applied, squashed, and pushed to nfsd-next for v6.12.

-- 
Chuck Lever

