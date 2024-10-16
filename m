Return-Path: <linux-nfs+bounces-7204-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF69A0D30
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9397CB267C8
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0893D20C012;
	Wed, 16 Oct 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WAsEh0e+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PO2/ne1/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8414A4E2;
	Wed, 16 Oct 2024 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090104; cv=fail; b=aYL7MQm+59hOW87tkk1X/2LOD02Bl1x6OSyDoeG+4OHiFwrZa1wmFtHDTZELtxUG7xyFZ3MlLpS1HLrUXQY2kAnNKqc6Hn1bJhpr0YL3ZNhW0fFXEBY/BAx6tQy7sJAIo0Z7MeYcc5vbUiFypiX7vCmHgFsBx54KlJYUp2zMoKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090104; c=relaxed/simple;
	bh=P1e76Wi9one/zPoAxtBL6TUkcbHKtqasiTdBluGGl3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XHT4vYcCl31GFCGU8AX40bz11w7MzFIREM2vYQPsZe2skkQpwILZwAB+8I0Zda0gKhGVMimcEOmIs/l9dMfOOxZLbTMvh5aMKScIfcLFtU+R6YvPPWMz3284FSJRhOLUQn01Tl4z90L07KY+Fe1NzDZkLAPAwcXu1deE4D9LDKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WAsEh0e+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PO2/ne1/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GEBpAw000776;
	Wed, 16 Oct 2024 14:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=K0p0Z1vhufl5tUq68M
	69nHzrk/+XGjua6BhWQyvDtFo=; b=WAsEh0e+3xXjx/eQTcvi37NGFZJt1sJb9Z
	+PbWwpqBxbv1ylFO80SMAiyd/D7x5/NP61TKqUeH2QfxzLNyk7/XSbi4DBtSNL3L
	Ez9ezR99hK8jHyvnhVvca9xTHtM0MzFd9FPKh6rLk+gSJy+ZpCLen/KaZgMx3W2J
	PStq5vH8snsAmalaEgcuYTLeh06P6yR8iz7Q2UL9+4WsTuvh5se402yLcuSqwe+Y
	mxnzn+Lh44vAsvC2NxZkGaQyhdgKCyPfkv8d2TfOCQVx67Vluebj1QH6dICelHCQ
	gs00MJ502Wnrp1W6bXuhNANhJcjc9XI3AX8//jVwxU/FdVTXELqw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09kewc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 14:47:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GDgRRF027120;
	Wed, 16 Oct 2024 14:47:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjfg6yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 14:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaJDfHhovObCVzKhBopvbFhRbVyfiXwTYNYdtSbMy4lVv7WmQPkrg3RioBKJK3j/D5N5gh30DVM8Gi4ko0jDU4zbDE3v6bIYC5islwSwL43DiViyGNI5Ctquhq76L5l0QBWRYKvntiVwDbtxxJg7bN3ukOSAiFIy4QkuAOMdlNEt30XWZKeqP9mDDrzLnrnITCKDhmh7FaU/pcgvov6ppHelOFA7sZQM0+1GRm7E83WUYn3899L9OyoEYMAkjyeL8L/b4JNXukxFyt4DE1PQ/sSXx+2XyQsciVUTFRY1y1BMgo84rRVQ7sfvKSqe7Q3IiV+duRb33AWErfKklFKPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0p0Z1vhufl5tUq68M69nHzrk/+XGjua6BhWQyvDtFo=;
 b=eCrbhrV6heY4N3/ESbB0MMWk9hUz3PRE7Gbpmmk4/eIgFtdezUirRLgTDyaP1JP1RafBowrTgmwDJM4twB+aFETKOcaa00Bgho874NT6QKA/Q8q71N+QFc8MN9hKMXPtners8ds/F7MRtM+v6GLNYDdQuOVUMkWkKhTs0ckukPTUM9gwyDr4MxUDjBM54YHMqIY8HJp0EDCOzYX7UcCpBckFt3OdZ3g2MaQWgGZCuN8QPDiP+GJNErATU5ko8T4UjWgOGC0jouhzDFCx1Wqz7t0GtVcvOHS3VQkQOviktx74Z6DSJtuN+AfuFe3+b01dNbQ2hmcDviojrBrKOxyH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0p0Z1vhufl5tUq68M69nHzrk/+XGjua6BhWQyvDtFo=;
 b=PO2/ne1/coVM5xTr/kmOpzAqQCUGmuhnnTqCWuX0x3+mbyYpdbQVIQxaywnk/tPEEen19Yf4grp+GKBJapJ5kuLU0bFENXQ+xMjlWnLLQ/9iC+aZtBSB4cFJZ487dzf1o45sX1GBh1wEuvCUiYbQV27iDuVYTqJCqOMn/BY3Hho=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 14:47:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 14:47:51 +0000
Date: Wed, 16 Oct 2024 10:47:47 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Marsden <greg.marsden@oracle.com>,
        Ivan Ivanov <ivan.ivanov@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Trond Myklebust <trondmy@kernel.org>, Will Deacon <will@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v1 21/57] sunrpc: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <Zw/SE9+AMYmzBprS@tissot.1015granger.net>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-21-ryan.roberts@arm.com>
 <bee3f66f-cc22-4b3e-be07-23ce4c90df20@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee3f66f-cc22-4b3e-be07-23ce4c90df20@arm.com>
X-ClientProxiedBy: CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 09494a3a-1e64-49f1-34dd-08dcedf18297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ha71DR5uLQ3xqwvwql76J2zHqa0ghYzXKJZf87v6bqz5rBOq9xqm1awJgpeU?=
 =?us-ascii?Q?SYZlT/6Gyf6swFvW8fS3+bwU2/r5n15IUAWul+0hazztAgaWanAMDAtxYd1d?=
 =?us-ascii?Q?W6OyNOuW5i+NOOiCUpF0ki6Zw7GFk1/71DipgWUbB99cI0e5V9TWT8vRFZli?=
 =?us-ascii?Q?YMxijDToFYOuJEL8KGbjCjOO1oB1MPtygvSBslwrgkk+O5T+t+P0V3W+MRlX?=
 =?us-ascii?Q?IpeJMqjvGe8MUkxKFuXeQ3uZgTnUMmrgwJ7rXy3/gQQbg/hXEcgkgdB1EltO?=
 =?us-ascii?Q?q6w4a6DpnNYX0O/qDjX6XUG/ycowdxgAEhurrIBPzdLC7sQOnJd1RvnAFXbc?=
 =?us-ascii?Q?qWP28awRGEekKioG1OLAAkaIKICHix2/wJ2heEl7yC42EVG9UOEkNrfQAXOX?=
 =?us-ascii?Q?5ed+dIjw+5GZ4m5Yuz2/tJMpnglU+vIBEteW3StrWcEQYwVTTN/73pEsY8P7?=
 =?us-ascii?Q?bPgeWtmPDOy+nKG6QVMnqYyB7IbrwNOOST1m9OYbm4W4jm/xuIH23P4vXPjc?=
 =?us-ascii?Q?StOLrn5Llnu8/H8lVZIr2MR+GOhnz8aBAl9200Wqrv/N1SPY2r7TeIsyLHBy?=
 =?us-ascii?Q?p+81wIqcMm+889G9+irvrwyHcC8cQeBKTlS6exBfNTiXCzkz9DVdmHairuCV?=
 =?us-ascii?Q?eGudMrmNw7JodLaIivqdPxYlaQd1pLABvuBK+XTqEMJnK506YJwbPIBCaIdj?=
 =?us-ascii?Q?BpD6oDrh1ErOUEWThfe7WvCIoiR/KwEKSIr5X7UJ0vl64f4K+3xeWvFwgcZo?=
 =?us-ascii?Q?tanpumIyxNcsWDD4/hhNEH57BTeZJzmYLWkpiw+MBkdIxjQRjN9SdEGE4D3z?=
 =?us-ascii?Q?lnP1nKruLLT4IUe4XQ5n+Pgp+reflAmT+C9mey1LGanLWCoX/VkpRLZ7REWU?=
 =?us-ascii?Q?kpJnpT04PTcyvaQrMmdA5PYG3E0CbW5VxIssEuxPTYOn1oDKkU1IPXFjhybK?=
 =?us-ascii?Q?PaxIj4I7PSJ9Smy/hJicFBvPOzjp3mOnPk0P9D9ElGytRmkrBJMz/MTRhvDF?=
 =?us-ascii?Q?hdnxxy/LfsV7cibxLuacyh6A68bgQHl2a+YcoVl0E7JlbcIfMmMz9VOEyJ4H?=
 =?us-ascii?Q?JSwLD3LZNna/d+9H1DbhRPO/yc6a3KpniQoBHxA58Bga6VcTYk7MAGIyxRQO?=
 =?us-ascii?Q?d+JJn3AjuLSlqNz4urboQcxnBXIm1H25LkQeAkAt+PHhA4EB4oOWDPKyGyem?=
 =?us-ascii?Q?YI5LW5yfnwD67MwIBjLB6Az9OgS5rcp2OiTcjZcDi/pNVHkDk0jfpHnXXECX?=
 =?us-ascii?Q?Z7Vo5gR77CQMCwNck5fUen+UPfzMZRJOwJefIItV9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35VSDwoTvjrqjO8l3TwlVlO6WYIJAIjt8j4rL5ho5WO1LHWE7UudhtXD5LeX?=
 =?us-ascii?Q?frtY159tsZzOqVtn79Zdzr6SJRYoCukvXWQHQVnDY7RuVBYeLwipuNhGLvRG?=
 =?us-ascii?Q?yQMa6KqighdJZ5O5NpikS3A8HSbidMtdhDbrlbRvMVuTHP5N7Maqzki0ED7H?=
 =?us-ascii?Q?RPxQ2WwBgIHnKN+zfwlOrahE4bC8tlxTi5QhDBlP95+qd8sFwBsLfk6QBF9k?=
 =?us-ascii?Q?4VRsZ2Z6HlcmR+g8iCe4tQe8odD/3zTxpzwMVmRAdwpm+cKatiToQjkzLIiD?=
 =?us-ascii?Q?uucuft1A3Fe4SCm04bB4PrNLPKkycg3ABQSYybDQsVdYKbK6rr1K/fz/LlHn?=
 =?us-ascii?Q?aQcYD6YuJ/hui5gOO8O34BYudGVKR/KR4pBnppUG85gLC/v+FoTVr+9IDiRC?=
 =?us-ascii?Q?6GG5x/CM96BVNMnRPEkCWETCXJud2qqSUO1PuPoXJ/ZWV+C0I1bnASz3weNi?=
 =?us-ascii?Q?dOOjibLqdoDM78FczEdrNm0xrH24aZkj7j35iOrQgZOmjlKeQSOvL7IMV/0q?=
 =?us-ascii?Q?JEhqwlxE7GFL9X2eI9mwd6yfAAfHm/MIPYeK0GebiQIKGos0+dtwJuoIE/9t?=
 =?us-ascii?Q?meF6F4x0QfpW3I8e17VZppSmphj20w3YaJHY6O8KlP2G/uduPmZsFjDX/xUY?=
 =?us-ascii?Q?FSttexPgceO+ah4ginbs4402KVo5G6FGy+y6zaBC99il7jsPlvBoiod8xtA7?=
 =?us-ascii?Q?TpUXq8w/QAz0RMVx/erm6CRYjh9ZhCDZL2RekuROCrvMsA1qMkH5Ymm1w8sa?=
 =?us-ascii?Q?Fa44gl4W7o9K7SXaUVhnIbF4l6Efd4NMmXTaxvCiBJhzzui8MPU1hiZqgVTN?=
 =?us-ascii?Q?kD6uctTKu1L66w+s6Pj/24qJ1BNktR6MkqAeZOl68ecIoMxGyiqGZ98o8xed?=
 =?us-ascii?Q?IQ0MPNRmCEyQSQdYZR+MdmrNqqGRde7HoG59jhGAEzK+HKLw40NIguSHLXQE?=
 =?us-ascii?Q?rQ8QsOO9jkQqMzSvs7yJ2mhgM1aeR7VQIuApM7zbAeXGf9e/9hW1tKLLN+KT?=
 =?us-ascii?Q?g5C4P6XsyEk0Tzy/DiZe8LX62I38LFxCt2KiRjfkJjlO4FEWYj1ni5wxQiPl?=
 =?us-ascii?Q?o4wOZjC4Rstry/1GfshfUmXn3zz0GJFlir74Toz51vN1sFcRFFkzWb8W6OGf?=
 =?us-ascii?Q?/XD358TH8r0exJrLDuhe/VgaHX8hRtYh7fXqisx9fF0Dp1Tb/Xg9CS9/Jgzb?=
 =?us-ascii?Q?FjrXNT5X+SR7M4wnI2OeoTnM0boYtKgYyUIc4JqVvJ6PY24IQpli6leh9ZNl?=
 =?us-ascii?Q?inkD3uARqTFA+wWJZTDoXsl3zvh8KHmKT2I1hTYnkhXSKOcKwBpS2suZ5sqO?=
 =?us-ascii?Q?3FUlPUa4NSjV2tmrGoHrRqfzPCIhn49Swk4/xwyN1caHaLgQzWVt5d0aQgGq?=
 =?us-ascii?Q?GsYGCDhFhsqNG4RVAY7EV+mQJHcxPkb8EtTRPEvIGZz9b03fxUL7VKCKSDbs?=
 =?us-ascii?Q?NWtSBQmOs/vJZJd9yXMUhugB/J4S6RIqhdgKQ5rKdFZZ2ccCr5sqM8sa0D/i?=
 =?us-ascii?Q?Oa7jE7A0wX3mHGpGK2UWinoCGXOe7n07F8Y5/qH/W9Xhj72WNeRdGK1Dehoj?=
 =?us-ascii?Q?0xpejD7xTiMXHNeiidMeUyam1km51VtGrhC//DDwWvWiWINADk+dj8M6fiGh?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JjddYzN4DVktDA/22O4X0fkt6qGn2y92aK/FfLxiVamZUGILb69H/usxkv1E045xg1WtAFY/cVGN9yG9FTnImbj0MlgswJI6y0VljoXWe1yk+oHn6n14KcFGFfwf+D7OdatNWtN+YvhlslicXZak2pj5XtXJU6pfBs170R/lEAwbe7Vj7/CauMYLNewrSNnM0+ITBf0pCBxkHYjritXgyhDn8gSqaniX27Ok8ccc1cROc4JI0S9o8BwGqIQx/7hOidjBY6eorEYypNFTEBbJBPpsynzPGIkdspPca2dtn8aaEjRVi5wM/nopqGjctasCAgQfn6xqAw2tUt+aXZYMXYCpnwfL1enufALuSyoXzVHYfW0cD+wRMOnKgbBRu83SgAuUD3q25bQNXQf8FGVE7Wo4QdHk1cYMnQfB4vmDGqxHjckK1sRrS91JY6A6xe53QzLMF8M2Plw8Gp7RD0N2vZNrurbGdvwGUS6rwEtdawIhjIOhL7A6zpK31AkUlqY6zut1KV/XzQt4a/mX/gAU/XlfJCe6OwFq34pyBvCqA++YDCV/TagILgJi81kCQl/+TwsQbYX9mXmu1JNR83MsNl2ktUxU8PaxQkOch6wqB/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09494a3a-1e64-49f1-34dd-08dcedf18297
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:47:51.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C6C1J6GZXdOzGmMWaEwMdOkNXtUbeFZeNAzyFAUi5FoWGNh84B+XpD2wHEX+e+LdFb1H/CgFanVOgisQNM8lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_12,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160092
X-Proofpoint-GUID: N5ggS-yQp56Z8jMksHOlAw_1eAoBGMSu
X-Proofpoint-ORIG-GUID: N5ggS-yQp56Z8jMksHOlAw_1eAoBGMSu

On Wed, Oct 16, 2024 at 03:42:12PM +0100, Ryan Roberts wrote:
> + Chuck Lever, Jeff Layton
> 
> This was a rather tricky series to get the recipients correct for and my script
> did not realize that "supporter" was a pseudonym for "maintainer" so you were
> missed off the original post. Appologies!
> 
> More context in cover letter:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
> 
> On 14/10/2024 11:58, Ryan Roberts wrote:
> > To prepare for supporting boot-time page size selection, refactor code
> > to remove assumptions about PAGE_SIZE being compile-time constant. Code
> > intended to be equivalent when compile-time page size is active.
> > 
> > Updated array sizes in various structs to contain enough entries for the
> > smallest supported page size.
> > 
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> > 
> > ***NOTE***
> > Any confused maintainers may want to read the cover note here for context:
> > https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> > 
> >  include/linux/sunrpc/svc.h      | 8 +++++---
> >  include/linux/sunrpc/svc_rdma.h | 4 ++--
> >  include/linux/sunrpc/svcsock.h  | 2 +-
> >  3 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index a7d0406b9ef59..dda44018b8f36 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -160,6 +160,8 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
> >   */
> >  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
> >  				+ 2 + 1)
> > +#define RPCSVC_MAXPAGES_MAX	((RPCSVC_MAXPAYLOAD+PAGE_SIZE_MIN-1)/PAGE_SIZE_MIN \
> > +				+ 2 + 1)

There is already a "MAX" in the name, so adding this new macro seems
superfluous to me. Can we get away with simply updating the
"RPCSVC_MAXPAGES" macro, instead of adding this new one?


> >  /*
> >   * The context of a single thread, including the request currently being
> > @@ -190,14 +192,14 @@ struct svc_rqst {
> >  	struct xdr_stream	rq_res_stream;
> >  	struct page		*rq_scratch_page;
> >  	struct xdr_buf		rq_res;
> > -	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
> > +	struct page		*rq_pages[RPCSVC_MAXPAGES_MAX + 1];
> >  	struct page *		*rq_respages;	/* points into rq_pages */
> >  	struct page *		*rq_next_page; /* next reply page to use */
> >  	struct page *		*rq_page_end;  /* one past the last page */
> >  
> >  	struct folio_batch	rq_fbatch;
> > -	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
> > -	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
> > +	struct kvec		rq_vec[RPCSVC_MAXPAGES_MAX]; /* generally useful.. */
> > +	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES_MAX];
> >  
> >  	__be32			rq_xid;		/* transmission id */
> >  	u32			rq_prog;	/* program number */
> > diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
> > index d33bab33099ab..7c6441e8d6f7a 100644
> > --- a/include/linux/sunrpc/svc_rdma.h
> > +++ b/include/linux/sunrpc/svc_rdma.h
> > @@ -200,7 +200,7 @@ struct svc_rdma_recv_ctxt {
> >  	struct svc_rdma_pcl	rc_reply_pcl;
> >  
> >  	unsigned int		rc_page_count;
> > -	struct page		*rc_pages[RPCSVC_MAXPAGES];
> > +	struct page		*rc_pages[RPCSVC_MAXPAGES_MAX];
> >  };
> >  
> >  /*
> > @@ -242,7 +242,7 @@ struct svc_rdma_send_ctxt {
> >  	void			*sc_xprt_buf;
> >  	int			sc_page_count;
> >  	int			sc_cur_sge_no;
> > -	struct page		*sc_pages[RPCSVC_MAXPAGES];
> > +	struct page		*sc_pages[RPCSVC_MAXPAGES_MAX];
> >  	struct ib_sge		sc_sges[];
> >  };
> >  
> > diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
> > index 7c78ec6356b92..6c6bcc82685a3 100644
> > --- a/include/linux/sunrpc/svcsock.h
> > +++ b/include/linux/sunrpc/svcsock.h
> > @@ -40,7 +40,7 @@ struct svc_sock {
> >  
> >  	struct completion	sk_handshake_done;
> >  
> > -	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
> > +	struct page *		sk_pages[RPCSVC_MAXPAGES_MAX];	/* received data */
> >  };
> >  
> >  static inline u32 svc_sock_reclen(struct svc_sock *svsk)
> 

-- 
Chuck Lever

