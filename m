Return-Path: <linux-nfs+bounces-11144-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0DA9046A
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147DC7A5C6A
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D518C008;
	Wed, 16 Apr 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dVrEDsVM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jxku0E09"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888A1420DD
	for <linux-nfs@vger.kernel.org>; Wed, 16 Apr 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810345; cv=fail; b=WDvfz7zKkUCZY6xhS+FoXYRUzMffTm55STx6/9nznTyAs5P6A3bS1tjA82vuWLXhN4s8CjnXkpA9Cf++IKZftHh+9Ey4pSa1pXlRKF950rC0RNXaFb3Dg3Nxbsawj9NI9+90WVK/cAQ5BxHXSob40jNv52GiCArgkgtt2J2nnXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810345; c=relaxed/simple;
	bh=U+d7LrpJOFZ2rg35KN0WCUhmoqeTMm1Ed4Zgb64Y5SY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bbw3x/wKAPK8PWKoHqx2l9I0sD+4NT1XWb2y/tCPuw2y6Lg56cXvW3fFPKgs1iT0GmAn4BN16tGGUmeefbTvYRRx9Xh6HEKlsAyT9PylyODHdmrXi4WwcWMuCjctdlr8ksf9JMLmazoYLvfeZ936GBwfiiac763CtrQu1lm0YRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dVrEDsVM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jxku0E09; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GDNssY016184;
	Wed, 16 Apr 2025 13:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LoAcNg368/5DenmiOusao1nfov96l/zWlVI/S+wCoZw=; b=
	dVrEDsVMd1WMvUFwE+DrjBmXtFXKTj86cgnh5bqA5zecT2N328yEAvobCL5XnAA0
	Q08M/nnFaB3fKuQjkn+J9vQXwgCHBsmLF/6Sci3y7jDX9OREMdsl1fLNbntJT7nN
	U8DOTMJfAq8TvCokuVVt/CW0/F3ls/5LqJfv1+ZunKc+qicNCvrp3BnbbYvPoL0i
	zotAtSbzOSmtM56cAkGVj2kyuw9ECpAjYTFgC2pPHl6eNq4/1ajB+PfAMKLegxln
	9Tp63eEkojpVQ3FtJw0TGCOXrQv5w4PpTJSTk/pvOrXyBsVZgCC1c6uJ3zlNkSHo
	nuNOhxb7hR9KT0+5kgIEfw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617juc5k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:32:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53GC0xRp038779;
	Wed, 16 Apr 2025 13:32:10 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011029.outbound.protection.outlook.com [40.93.12.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4sw442-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:32:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R82RDsDqIbm/wZwCZXBFzrHNYAB4cOdJ0Vo1cWhJYJp6Gxx+FBb+5TDUnmGDuU+rY9y03XJEDV4Ye2dz1JCF+Aj7yUpo3RzL37yypV5a0+EHKY8BbOCUeHXbBOAhG1l0TQ4cRjL6RNKSTcJWPrhfyH5By55nRvd3xJqGT5ruuwwe+Vuio2wbdAWBNW7kt+vKGWKsVT0odnX9m0mHmVLvbIkFwHNUMOqFdQ0seiLSTnTpU0f/1UjR51ZbdcK6ap19HDplKG19TGVBC7EPwiyqcOfCcrbjfUAa1E/Ai8wV05MF5GB0w9zQtCo85aWoLDoJv5RTtvi2QdatZqnVF+82Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoAcNg368/5DenmiOusao1nfov96l/zWlVI/S+wCoZw=;
 b=hBNSXmD7nM9MljBnhVNIsQFz71bmLoHW+zf/n7xWY9mDQgz3Uoqh3ZFxw2yHjDJ5WZvmfU4zDEUN7OV3y5R0bn1OSELHsZlP3hVDK51JMvXdzFIMTVqEo+cLClZPvsAZ/LdBDgGxnGhXoUgNFy23Q4d3RyBhhQTiGvuzYO9YAsD+Yk4+WAGYlHXzjlXnmp2lDnETnNYTksKnhA0p5TWTrvF90G/XUW6/5Wm21NETd3fr1uqA80Fr/1Q/HjQw+JBH8pTDjrPMSErVf8HaRthDFv+2M/nnqZiCeO7dtjh2kRwRzoNJqpjWaGeU9QZwCUmJ3+C0rB0EFnhfLviRBq5/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoAcNg368/5DenmiOusao1nfov96l/zWlVI/S+wCoZw=;
 b=jxku0E09Tn9JH2OadjF6oInnmvFdMQX/I0KkAJhZxqQqVYYflrk9CdrpqXuz3dLkGSlNdXPUTy98MBxXXOOxbqIcZgjvsskKa2e2fwXHCoIsTEe79dEv76levttLSlZ8qRRM8mIQwtYRjgkhiy1QhSat9h+fN+UxmwPSs4z9wlI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6496.namprd10.prod.outlook.com (2603:10b6:806:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 13:32:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.021; Wed, 16 Apr 2025
 13:32:06 +0000
Message-ID: <425a2e7c-6d42-451b-b8f8-7c923ac0ed03@oracle.com>
Date: Wed, 16 Apr 2025 09:31:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Mike Snitzer <snitzer@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@oracle.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, linux-nfs@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali> <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <3911d932-5ad3-4cc9-98c9-408818cdb4cf@wanadoo.fr>
 <Z_coQbSdvMWD92IA@kernel.org>
 <738e994b-1601-4ae0-a9a2-f74a6b797f23@wanadoo.fr>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <738e994b-1601-4ae0-a9a2-f74a6b797f23@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:610:119::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c985ef-816a-4a8c-e63f-08dd7ceb1476
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OFZUZnpaajV6WTl3NFpBV1NOY2VZK28zK29KWWwzb0xZeUJlQlIvQmNodTJu?=
 =?utf-8?B?MXFZQnk0ZjFxT3ppTnFNS2gvQ0RtcW1iakh0OEp6TFU3Y294bE95ZGxGWEZB?=
 =?utf-8?B?WHFybVNkWnl4ZU9velBOajdVNjByR1hQZm5RMHU0M1M2aTBaWmJBNmJYN3Z2?=
 =?utf-8?B?Q1d0QkxHRGMrSkpId2dtdWt5enFIY2xDdktSb1dROVlQM0p0Z216OEU4WDIx?=
 =?utf-8?B?MnArNzR2N2pNc2draTFIZDFteVJGdG1LSzdCZFpZR2pzeHIydko0R0p6Yk55?=
 =?utf-8?B?aUlpQjJMcE9pdTlCZGxFa25JNXAwVllnRDBOV21RbTludUVCV2JDU1hvWG1O?=
 =?utf-8?B?QnlmeWovczBWSy9PYjIxSDAxaG52RDBvNFBQb2VETkc2L0NEemt6M2tTcVlR?=
 =?utf-8?B?RHFQaWFGVmhZUFpXWjBNTTFCbytaOW5FVkExSHpDa1dhMXM5SjZEd0UyMHF2?=
 =?utf-8?B?aWhORFlBUWZJVmpQVm5pZGlrcXA4dHlFWER4OVlhNzVwTzNYc1BzdkVWaGNN?=
 =?utf-8?B?aDR3Sm9QQWh0TlJLampGRlJaSjRZVklVTUZBV3YvUFh5aUpXZGYzMjg0Tml6?=
 =?utf-8?B?U1ZyOUxJWUR6ZVgzYk9sOWJCRXVGdGlVQld2SWJOK1FqVStESWxqOCsxUEVB?=
 =?utf-8?B?NEM1R3I4eWtDL2lSZlZBN1p3MDlUK3RvME5hcXhpbEQ1dTFHRGhIWUMrSC8y?=
 =?utf-8?B?M3ZoTnRzMDNXZ3BnMjV1SWFvYkRSOEsydnNVWG9QQWJMd1RVQnY0UG5YQUpz?=
 =?utf-8?B?RHMvRGV6cmpYUEVTL0RvSjRBRWtzV3VRVCtWNC91em8zUnFSZzRTSGErVUxJ?=
 =?utf-8?B?YURvZ216QXQ3dHdQU2dlSHl6MmtvZ1g4VW5ENlVjbVBkZW8wWHpxUnI5TU1v?=
 =?utf-8?B?RGEvb2dWTi9nejgzSTdGQnNEajBsMEQrT04xU0V3OFZ0MGNyTnJFamdCVG1Q?=
 =?utf-8?B?dGh1R2lGZVFzM3hCZG8yelZzZmpXRGhWRitrTVEySytxZ1ZUZTNEQThodlB3?=
 =?utf-8?B?MThqOHI3TTY4SzE5QUsyaVRzTEJOZWFZRUEwVHlNNkNoUUw2aFoxWTFETFBS?=
 =?utf-8?B?eUdjMU9HNldwTVYwcUdrVy9Fd1JTT1BMYnRzbmw1anh6aXdnM1oway9vYU0y?=
 =?utf-8?B?RzRlb3NmVDJURzd5L1FjNkV2WUNUaWtXckg1ZU9BcGdNbXlNeTlSWFZHTnNh?=
 =?utf-8?B?MXgzT0M2M3hpUjdFeUQrWHRLSnp1ZllVZ0J5b1ZBR0NhRjJxNHAwMjhibmZQ?=
 =?utf-8?B?OTVCK2s2b3JDQ1hWTExGVHhTMHBwM1VtUlVrRGJYTE0vbDlxU0tHYUFoYzFv?=
 =?utf-8?B?Sm1vYzZ3aGtNNHFCcjJtTXpaRXJzTEQ3ckJva2NxWXFOR01NQmhMNmJqZG1V?=
 =?utf-8?B?M0JkRENtVmNPVG0rMGpsVUU5bU4xWGFYMG5KejNTejZwbnRvSVVSc2VxWHVR?=
 =?utf-8?B?VEFyWGRTbGhQb2FyV0hOdTViUzZUa1lKNmJidGYxclF3QjNFbmpWRmRiL3VC?=
 =?utf-8?B?YjZjakhlN01BM3M4TXBnM3psY0s0RkRabEdIbmw5aHFEQmc3TWhXbGZIeThS?=
 =?utf-8?B?Q3FtN1Z1Q2l6UWNJbW55QUlIV21ITmFrMzI3d3ZaZnZUZ1EzZGI2U21yd25O?=
 =?utf-8?B?cmZ2REoyT3Bjb2dxQTI2ZFc2V0tsQzZPY3ZvN1RJcndZcDVuRjJuTFVBckdu?=
 =?utf-8?B?S1RqWHZPd1BXcjR6WTNJTmNkbFhHUFp5UDJoaVpXbmlzZ1BCUk44WFhydmVZ?=
 =?utf-8?B?cENlV2haTnBuUVlIZ21VZEpCYTlaWkhlWWJGckUvNXJ1ZUVUU0NhYUlVK2g1?=
 =?utf-8?B?dCttakx4WE5EWVE2a2RuYU04RzNKUVFjVHcydmtEbDd3cXFSQVMvay9GNVhk?=
 =?utf-8?B?L2pNY2p1N2sxenBxanlHTFFDOG5TdG4rLzhteEduM3ByeVhtaDh0QU1iT1ZM?=
 =?utf-8?Q?mcorMgbBAg8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U1NYNUpoc2xNcHREVzBHTmxseCtXZ2s2Z1htV3BtczJsaTM3S0R1THNxTFNa?=
 =?utf-8?B?Nyt5b0piQkNlcEZzQUlnTHJsdDdqdFEyWndkSGlkckppbmh5eWIwRTUxRUV3?=
 =?utf-8?B?ZG1LRmhxNTNiaTRSQzVXc2V2NDg1TkJNZERDOWhEaVEwV0RiM0RWVUtSbHZm?=
 =?utf-8?B?WGRQMjM1Rjg5dDRlN0pnSFJYR3JFNlZzRVgvNUt0Rmw0aUErUGgrdVVYVHdz?=
 =?utf-8?B?V3RkOTlXUHJlVEh1OGxhVGF1M2tzNEhjcnJNQkR1dnN1ZVBYVTA1bzhYZmNE?=
 =?utf-8?B?bm5NQndid29kTWtmcGpxRFlxWTdXSjJKTW5EMFQwK0lsb1pwVVlTOVdEMjhY?=
 =?utf-8?B?SzhqZU9zemFmekFUV1E2c2tLWnd3dG9NU3VCeVZ4S2VkTEx4clhWbUhKblc0?=
 =?utf-8?B?STRsRThra1BySmJ4a2tKZmpwSFoxbFJBV2ZFMjFpQnB6NjJLK1NIL1EwOHFC?=
 =?utf-8?B?T3U4RkFzQXlwNEM2eEFjRksrL2F2Ni85ZERLNzEvUDAyN2JpYzNtWUNwQ1dI?=
 =?utf-8?B?b2JlWXhIdHpvZ1FNSjNTYWJDaGUrTVhpdkRoYXg2eXhJb0VFbE1PdGhBd3VB?=
 =?utf-8?B?bzRzcEtrSHp5cEowdDJETmZYRjBpV2xJTGtscWowT2NTNXkvRHVuRGRGZHVY?=
 =?utf-8?B?UC9iK0tYRkFabW5jREJyV3FYNlM4VmFYQUhPZ282bXp6L05tY0FwVXlvb1Y2?=
 =?utf-8?B?bVpVNk1KNVhhRDJvL1FKTmE1aWIvVnVrUGExTGNtYXJ3UEF5dFlYQ1dmSC9u?=
 =?utf-8?B?M0RjRnNMSm16MVlnTjdHZWV3UUxJbU5mOHVGTTE2Z3N3b0E2dE8rY0Z0N3VO?=
 =?utf-8?B?WGJkTnlNWHhKRVMwNm8zYVRDRVpMOXFCU0xGQjVTR1NaS1RXNlh1YVlLOTZE?=
 =?utf-8?B?M1VhK2QwanJqUU9NdTd2TFdad1AwYzY5am1tbHdHNDVudnk4KytETmtxWjFr?=
 =?utf-8?B?anVqTTdPdjAzS1IwbTlKSVkzekFIZUsvbjZmTW1Ic0FnQ1U1UkgzbW5pTm44?=
 =?utf-8?B?cnRvcGFvSEJtTTYrZ3JweFBoQklVTzRVNWtLRDVuYkJCSmNMMnFPc1pZeTdY?=
 =?utf-8?B?cm02ZmNQYk0rRmlBODcxOGtveG1IclBUQmJ5VURxSTdBZmRTb1hiT01OYW82?=
 =?utf-8?B?eUFKc0x5TkdWNWc0eFJzVS9jZllNRDIvTEIyem9rS0tsQzZEUm5Ec2JaMWk2?=
 =?utf-8?B?MXhSdjhoMGMyYjcyRFMxYnNYZmFQVDVPY0JYR2tHTDRINHVNUlRNR1dseHVz?=
 =?utf-8?B?ZEV5NkJYeWo2NDJRY1NKWjZvd3R6S254alArNzZ1UHJ2Z2JHbko5STIyN2da?=
 =?utf-8?B?MFVFNlVxcVJ1TXNvdE1sRTZnM2hVbVpVNFNvY3FmMUJabUJONW5lUHBOQTdj?=
 =?utf-8?B?RFk0TnlDZTAvbVR1ZGNmcUZ1QkptT0FYdm5rQnpGSVVIc2Fwd0U1dnhFdVV0?=
 =?utf-8?B?LzdKamNiTysxSGJqV0pLM21MUGJwQzN1TEVrcGt5WDJYeU5PZzkyWTRLK25x?=
 =?utf-8?B?ZDJtMnNxenJaakdCSituL0hrbWZwODNmR0tIeWpkaWRIV1dzVTE1VGxiK3lE?=
 =?utf-8?B?K3ZqZFYwMUxYakFZQmZDRzRHeHdnOWpBU2wxd1ZQbEJnSlhhbm9lS1oycnAr?=
 =?utf-8?B?cnNrUjF5Slk0RjJSVjU4TjIxV0VnbjQ0Z0JCVkJWSXRXSVc1ZWVXMHgxVDE5?=
 =?utf-8?B?WlVZeU4vTFpyMVJJemhHbEdINjlDc1hjZkZkWG5oSzFabEY4NFEyeXBZcERt?=
 =?utf-8?B?cTYvd0RXUFNsZXdGVWczWFc0UTZyOWxHZXIxSHJaTHZtNHQyVkc5TEUxZjQw?=
 =?utf-8?B?VWtlNnozcFhCWm4rbnpJNWtNUVlzTlRUenVmbmJabWtzTlRBckRaREVteWJj?=
 =?utf-8?B?ZnkyZjd3ZmlFR1JOMVZLZzdsSmVESVZNODlId1pIWVpNUkVNeU9vQi9QeU9i?=
 =?utf-8?B?WTB5OUVEZmpmajlYMVlWRFZCeWUyOHpFWk16U0MraUxnd1JjQnEweXg4djRY?=
 =?utf-8?B?Z2lHVnd5czZLTHYvZEFzWFZrMlBxYjlSODZEcEV0TGwzdGwxcEFKVkhrNXRa?=
 =?utf-8?B?eDJOWmNyaGZUdWV0amk4NnlBbFVIUjcvTml4cmZ2clNiSXNUUnh1c2ZYaVZQ?=
 =?utf-8?B?VW90NjBQMXRKRVBFTEd6SGM4S0laYnNudk1FU0hWNEE2WkxaYzZDcS9lL093?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dsKQEYprsAMXY/uRDBcLT6tZQuY3ID5WJSlDVKst7Zq74niiWizwHwEjtpE4xLU4vaIwDN2o5LDTLY7g7KK/Mnh9yjdrZLR6bavzbPa7ujudKVZzHK/U/QCe9K3FlwRMpq3f1tNbpzv5A9hkVtRyu1WEQXcWuDog1KXTMlArh/C1sXcINFFv/j1yJUUidu6AyANZ/DYZflQA6lwdKPwnolb0p4WhbNVLqich3wkV+U4HkulzLFgMIDU7pS+9YWCY2ehEL7lx+Y4E6fLh/3OnI+ReOG3T5ruIGYAZ5cg1u+pmXX0MFvelq6aTdakERyOf4KRnFAHTF80y1WernJuEfXQWxfe3S2iKWykzVHcFMadEryEqAz2sCPIc0QzTiVlQzpWjyWCNbcqua5udrXlp6HCIQxEUfhwvY2ohWvl3gE7EtlWkhDs5qVD0g4gQoc8RxAarpRZibuExr+KrynWHTG9ZwOVFx4FK1ZdIDnQMME/1ZeHc/e1iIzPOrEbF29GXFZiXCxJqb7p6cljLKMDYpkmpUD0mLKIE06ISmrd0ohwXqHsb/oAmAkNVsg3hRcuw70UfWEdr1GOz9KyHjoGageGYhlOm/ik7t9cjMgb6nl4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c985ef-816a-4a8c-e63f-08dd7ceb1476
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 13:32:06.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4inf7FqUSd0wVkY6PuQTvHQiTYFSl3nzhDyDbMy6ZUK7R/0nUQBiFNyzS9NBaCfAY8oElpsVEXMnXTCpF2n/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=977
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504160111
X-Proofpoint-GUID: GHaMwG5CBHbER4w1K0AWGmGYkYK6IIyz
X-Proofpoint-ORIG-GUID: GHaMwG5CBHbER4w1K0AWGmGYkYK6IIyz

On 4/15/25 10:41 PM, Vincent Mailhol wrote:
> +CC: Neil Brown
> +CC: Olga Kornievskaia
> +CC: Dai Ngo
> +CC: Tom Talpey
> +CC: Trond Myklebust
> +CC: Anna Schumaker
> 
> (just to make sure that anyone listed in
> 
>   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
> 
> get copied).
> 
> Here is the link to the full thread:
> 
>   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
> 
> 
> On 10/04/2025 at 11:09, Mike Snitzer:
>> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
>> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Otherwise
>> RCU code (rcu_dereference and rcu_access_pointer) will dereference
>> what should just be an opaque pointer (by using typeof(*ptr)).
>>
>> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
>> Cc: stable@vger.kernel.org
>> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>> Tested-by: Pali Rohár <pali@kernel.org>
>> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> 
> Hi everyone,
> 
> The build has been broken for several weeks already. Does anyone have
> intention to pick-up this patch?
> 
> (please ignore if someone already picked it up and if it is already on
> its way to Linus's tree).

I assumed that, like all LOCALIO-related changes, this fix would go
in through the NFS client tree. Let me know if it needs to go via NFSD.


-- 
Chuck Lever

