Return-Path: <linux-nfs+bounces-5972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FAE96483E
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 16:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368EC1C22CE4
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CDE1AED57;
	Thu, 29 Aug 2024 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BB0QQKYt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cYFcjUeM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD131AD9E0
	for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941639; cv=fail; b=a7fKefCtV2hYQ7R6pWYHeIcsFDXA8xLfIERHFWHznsvfhiZc6LXbrWa85FRHmwZZ/5GBRiHiytpW3PsKxdHy1CjacmVa71aEwF6pZAC6N9zM4+EWmTqRC5hUjuMLQIHTe9eoUHjNAE8Q8nxFsAmoeiROuMIIlPaMFIwqjS4EZ6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941639; c=relaxed/simple;
	bh=AVhs2jikDrv3HcIY0HsM9lahAiLOY5DS7maslmL/pF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qnMmLeQLaB2sKar5HLnxViXQPGVeslffPJt9oBnUnEmojEDHD3MqLMygu4aNfppdfzLCOuIskLh6f3ssZh5OTO8OiXn9eNZ0ysLsDlZ8tCrpe3Zh+OoUPDZ/0KPRWCws2xeKh6jdt2qe0FNBkogX2o2ukqDP97Bz1PsZVvP9OvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BB0QQKYt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cYFcjUeM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEDMWi019806;
	Thu, 29 Aug 2024 14:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=NhWvZpRCY4aRrpG
	6hdSlBDyiCgCJLmjf5UnjEJXgm/0=; b=BB0QQKYtRzFF0KZ/2UGJ/F+fK0NxVQM
	lpSQiSehZwu0KO2fiRaXv8cgirYZN7djrSWrYc/mXu8mQ02yAXmwo6pUSMidPe+F
	d/XJI0DClTVEUZJrbTHy2di5VGWqR4264C+mNj1jKEB8oCHMfhKHw1QiFH8jDC9i
	ICe38W5MQvp4nI2TfMkrIp2Cn9NEWf+YM+lOn6PqpEgospucoNmiCI20jpOIYS0I
	MeNtFqf4xDBBX15OKcM6vrRcvFZfDci/L2IvDMn7UH53YqN48SS9I1eEWend+Zj+
	P7dh+K6Pdk7yxXBlSYt5F2A2xv9eyZ6QsE76FHL51duE/geGQK0MroA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41athxr1ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:27:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TE7diY009921;
	Thu, 29 Aug 2024 14:27:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894qsycg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:27:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqvvlomTHXDti1cCuOnaLu6TLm1DRemCp2S5Bf8HDx5b/2j5e2fVuWid9hfiZEV2FqPQeJYrpckZAbMAsTWghXAg67H01GvSeR3MMBhHyDcQBq3TaOEioz+baMFmdkkSUeBbAoIJzt0YL7pAIe0vNPYo0UMxBaIssA+9BEkHEK6yl3f5jL0f8tK1ZA1UuLIGvFzNyCUbtskp8TKnd0YbprWxGhtk3u4YNe1nsF9gUW64QPT52ZX7Kce/V/GqOd5vwfGq3C7n2hnz/kbz2sQVQqacsZEA+VQij/P6SHQcDy5Y3YdnWJJRDmADjMbnLoop/oiWPh3n05UDMVMoU0DFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhWvZpRCY4aRrpG6hdSlBDyiCgCJLmjf5UnjEJXgm/0=;
 b=RF/fNwkt6AQ0Dl1il0q+kHcqMyV2uJoFSPtvRVYeIdELPMrqy3kEltgKMPkdrlFXaAPyqSeW+sLJRAnzmJOJLR95K8laPmDgspefLmMZlrvoMx5nORgkQ7GkfGWImD/5rRFRr4bFqMnGfy/Z5awSx9gLrD/7xxQITFfNmiC+zIV41lVBhnh44QFyTd8Ou31z1Od1YvnYXQ12U7w5pHFXMGvSgfx9h5N7emh26sg6piGr7vH/zYTtfY8MyoiVcwIvqOHjOd2M7bIDGffeClNIoas8ry17Cq0+k/m1a1WJ7mVHkSQWzLoZ733Y7attDb0LmF3Cn/15O4s8TcGADYPxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhWvZpRCY4aRrpG6hdSlBDyiCgCJLmjf5UnjEJXgm/0=;
 b=cYFcjUeMHYdw/dRKZZxDgtgsP6Km0g4lyF8wdWkqio4w1FIH6BPFxEc44OVOJ4FTpdqvXaS3spaSvLb196uar0CQG/WbIdlg5LXwSIYt+gSX0jKfsPBaygWnqG/kZJkaXtLMUNoH+k5GybQMuLJ/4FS2F9s6lwDT4hYyo/M0OWs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5787.namprd10.prod.outlook.com (2603:10b6:a03:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 14:27:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 14:27:08 +0000
Date: Thu, 29 Aug 2024 10:27:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH nfsd-fixes] nfsd: fix nfsd4_deleg_getattr_conflict in
 presence of third party lease
Message-ID: <ZtCFOSIjMbqnpodA@tissot.1015granger.net>
References: <172488638886.4433.12153470259536099118@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172488638886.4433.12153470259536099118@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:610:54::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b58008-92cb-4a17-f7e6-08dcc836a9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5zJrO2DrJab9BJn8KIQCLO0U+uvdrtA1tYkn/DJH/Tt+Bkiq9WGQVZc1WtrL?=
 =?us-ascii?Q?1Ib1o4XST6abBzU1WnBVaOBAJw7oJR4BIeAUMWaKdTwXHDtkIkK1isoJO7jh?=
 =?us-ascii?Q?qy8CRqoy0lx3MF/Krlh+OuDGXcjSVqFJQUcg8h0tp7UeEVp0jLUYUjxCehhb?=
 =?us-ascii?Q?pzUce0ToIarv53+gPkGE1uQYXqoDXghULeiCEQuo09BRPfAaZoYy8WG2ORB6?=
 =?us-ascii?Q?5CrTIp/+ZWkiZtC2b61nJAhasLkFRZNDWBPl4fbKZ085/0i0sh4AmG5U6Sv6?=
 =?us-ascii?Q?rZSNxYPG2PNjahoVMQMmESPet7kHODZ8uhRQ5AiaFxeHqMPDoXCRO/cSsrbv?=
 =?us-ascii?Q?b68H5VX0i4+tJN319k31MlYw5ZtpdOqU1hiaEaAfosAK8cTnAi6PksZeXJGe?=
 =?us-ascii?Q?pE+iKSjeJe+C63PlHKQRWOnmDF2UvK/Ez1NvMXV5FIwx4kbnH4ShBFe4JJTb?=
 =?us-ascii?Q?wH5PNk8l4JOalHlDhdHTrLiKrR4/hzn5h32Ve6jccFFCHOch273kd45ixWFc?=
 =?us-ascii?Q?Yaw6w0KyWkt9uH8NWWaE77oGLbutawd/PBg2XBt4qGWXa2kVcCS5HhUgiAfn?=
 =?us-ascii?Q?9RrB3GCDeJAWBgtE2NMerjj/c9MC30vdAgjijOB8+rCIidz0hyWSQgXnZA/E?=
 =?us-ascii?Q?3vtHm1oKYwj/ddvYcPUjSQgVoplo4XhAGWkGms2dC3SsCeZ5rnmrJejtC50F?=
 =?us-ascii?Q?CcpAAzoXaqP/fyI7s1t6kSnKkWkjFrJH3JmCcxUWG+6LjAAAd0td4YIx6hm5?=
 =?us-ascii?Q?79Ggk7Mii9mBsxbXedNyiZ0zEDuuWgihnYCAsnIPP6PfVZ1spMTSxzK+lQs1?=
 =?us-ascii?Q?5Bf3VOssPBkHB+DjFSMw/M/CfFaZGLbRdtXhW0mgcaVlqVjtsgyq8MVOVo3z?=
 =?us-ascii?Q?0G+NV1zkGs8L+Ep+4ntWZm/Fdj24yOIN+uw8SzfYpyC3YnvQf6cGwwhVQNUq?=
 =?us-ascii?Q?7nn8Os7EVbjb2tZ+5aAeW0En52xFcDK8wKIcVAanlorGes1Oyxf9DcdLfAF4?=
 =?us-ascii?Q?6fewvoHk236Zl/6AYgwOf2VOmDc1J3qdznTWvzEmdYb90Xk7SLvnybh0qpBF?=
 =?us-ascii?Q?srj0YOudaQ9L6BnBEr/YWcz21e4lEOAetbUMWVa4npO22irZVBUqr6UvLPkR?=
 =?us-ascii?Q?1WwFD602nqxX/tEHWba3SwOOX5zPOTlvX0ssSABPDJPgrX8KbnawtpBxjD1O?=
 =?us-ascii?Q?CgHzFC666SMdXW+qkhETSTonBsQk+gLRAQ8cWIiVuFVQBYz5bKk8irXmsr1X?=
 =?us-ascii?Q?z6TKrPcDSXl96VjnGclHsyRXUPeKPv6argjBk4p4lUrylIgTf384Q5/faPiG?=
 =?us-ascii?Q?g4s8e9WE7l9GM5X/E2amJAcLF3ijBeU98sIbWuxu7XhBXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlEsmPQ/3yUcyjRcvlpdL+5kz/z0xuGQUX/3FKaZnQxIHoCSn06TwsdZssDO?=
 =?us-ascii?Q?kL9MV4TVc0x1wNLMKx8QiIiP44pi1zY7ZT4qDx7NToTk4Ce98f55V9n32pQ6?=
 =?us-ascii?Q?FSQzCyd8z52IfvdQMd2eduH4zusGuYBYE0QfDltkSsmrk5rkVkPvouh1edfm?=
 =?us-ascii?Q?KLnz0OMgqhwNJGa1twtJEgKH8IiwdORvHpv6w5JvxA6R/COfdEwJ9H5U3PNc?=
 =?us-ascii?Q?5OCWttmRSDBWQ3VI8caG8VkBK+z1RN+cpqBf9b+i1ugPYDz2gXRhkcMwgcKP?=
 =?us-ascii?Q?47qMFGm1ACNHCvIhkU6M6Nj5iluYTnEvZ4HdSWVZbZIwI8XTvqBRRSY4fxWI?=
 =?us-ascii?Q?8SvjcBhcMkGlLt9XhEB8Wu1ySk1doBc3nSGo2vxxD9NALL2aQ6Vk3Bdu02N1?=
 =?us-ascii?Q?trZW2WQPPgKsloNNZUG7zNGuGFYckmHJ3+F+UhMcdMJKVK1mQn9T6ukjcA+4?=
 =?us-ascii?Q?cd1KAPEb87CZALHR+c6dbZ4bx8/TK4Nlib390St5W13oP/bkhZ7LafbRdaQP?=
 =?us-ascii?Q?QvhbOQ5/WMBjlbdqu4vgSJ+t+RsQoGA5DvcRaB3HQvx4F5b82xBN0oQIztS2?=
 =?us-ascii?Q?JWnn8r0G1kdrU5UuCMtJT8XoYThKL7pMvJ5z3wMge11zMCO3pzYh9fxk2x0L?=
 =?us-ascii?Q?Ea/8KTFH1Khyyqa3e0IEkM0fZwu0Pe7YEK0LgzgAI7oiAz8s32+xU+ewSXWG?=
 =?us-ascii?Q?TQRJLvYktmtFVvN1SCYaqppj37CkNyhI85n9a3RJOYdZ0YnckS82Lin7Qum1?=
 =?us-ascii?Q?338gv/cbfaY9uFpZyqbmkiydFVbVjPLPvom4X9jWtP4+h1Iyajd+ISRK19pL?=
 =?us-ascii?Q?+3W2WAnu1bzxJ08jOgHU++J0QEdZSOM31AIR71Ykthvufhx/Ctetjc2fpetn?=
 =?us-ascii?Q?J+0XJS74EVOGB39n504dD/XvQqllVLVelPip84y6/mBkvgGQwNBlmCqL0eYr?=
 =?us-ascii?Q?bOwRvPcd07jze4Q1hBeuTZFhHSDEu3ZPCuQ089OBbzPQNyEdYCEetzS9rnUi?=
 =?us-ascii?Q?ydDAjpFPRJR0JCVDOywp34vi+fh2IGN/FERMp+lrUFOzyxy1nbD6OyuHk9hI?=
 =?us-ascii?Q?CbVLcwisGzQn4nnfdcx3BNm6hkEapmPb9pugVBi3N4PntVJzXa58EpLeT4go?=
 =?us-ascii?Q?MaBlkC4ec1IpFFK65c7VVPjDkSBOhcvRMWvggfXw/0rKhhPKxzpduXNyO3B4?=
 =?us-ascii?Q?mIa8ARVOXyZGGoFP/sTSKEheHIrlktGPUOf0SKs2Q6wyWUIRaHHRkXK+Shdn?=
 =?us-ascii?Q?+nwadfSyvoXAwn4UBXgT2PtR6ynIM/SEwCGtH60XQx/iw/6VAX1fSGDkT5Qy?=
 =?us-ascii?Q?auDu2yRRVITjim0GDyiHVwaGKR0pJkJkkIv92sol0w8ExyTgQ+3GBQrMZfQY?=
 =?us-ascii?Q?kOZnH68mm/LWQA6aS4xXKiTR9+n9Ylq69gw+Qh85gUU1w8r5Sjjr07XFHHIy?=
 =?us-ascii?Q?RaGWtWdhab/Yz+ZkX3rPWH4KhL7eaIXfoLQtCInb9YI0FbEbwA02wzTDFdL6?=
 =?us-ascii?Q?9rRrvu5DGfDDLum0mXUTfiSrfdmBiVAIb5Kpt3fAl4JuT+FPY29vxakcuMIg?=
 =?us-ascii?Q?zSoTxICPfOUQcEnfDnIx7buRG0Q4kJWkeA4Q+Vlgf2jYtXuJP/2brH+PrZma?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w+oHzfh9PTSaBa586jh5iSrQBvvgYK71LK/uvbpOVkHgJMVuFl0ERcg/JOf7hpH9mM4qrnOE0qpOSBYNReq9f/IULwq3kGFPt44tH1omjWbk1imM7MxCEPXL+3Hk+0IXSBuAfHUS94LLA/Kh7pKZJPIIyOAwjWGjgQuQOVIqZKwLIW5xdIqYWxuQ38daXQ4iMF+++fBcOCDcpB1EjQgvcn5nKluJ2Evnx0K0WIUPTYeeCgqbjtQ+DeBNs2H00B+KPo4B3NfWPF/jOJeqfBM9sD9UYppjFEIDKdAom/mbzgRTuZPSBvGAUwAB/J9mQ7u/mVwBKbcbaTytd3QijW7rSbsREMt3i1xE8JkQ+t0EmG/8TqubhE22QVPTLlAwv1m4OyjiZYayVyKAp2ZxjRE3SFgqdGOD2+XvLPa4CkXiplBwiK1nAVf3V0+CqzNgLkoNiEKpwkoKNIDAMJWDYvfFWfiqHE6C9693hPXlZkja1Sk4anmnNRs1MQdv+ugwQeMRjCuAaYBx61RVnw8+WuXDDXEFDD2MEXExSak/XpW+eFu2+5/PlGGvX6Nc0zWLeFwpmOlGBUqnei1OludtRduemqK7dAD3N38VGh3f730oHv4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b58008-92cb-4a17-f7e6-08dcc836a9e1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:27:08.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdxj/7mCTFOOCgR06W03xOw9eKvRxz3Xd6Zm9DT8oNec490ad/A1EUa0tDOZGObXfoLnk4WWmrdQfRwJBgspvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=704 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290100
X-Proofpoint-GUID: Zhmbu9VT2yxXP3ghKEfOWTCQO980MG4G
X-Proofpoint-ORIG-GUID: Zhmbu9VT2yxXP3ghKEfOWTCQO980MG4G

On Thu, 29 Aug 2024 09:06:28 +1000, NeilBrown wrote:
> It is not safe to dereference fl->c.flc_owner without first confirming
> fl->fl_lmops is the expected manager.  nfsd4_deleg_getattr_conflict()
> tests fl_lmops but largely ignores the result and assumes that flc_owner
> is an nfs4_delegation anyway.  This is wrong.
> 
> With this patch we restore the "!= &nfsd_lease_mng_ops" case to behave
> as it did before the changed mentioned below.  This the same as the
> current code, but without any reference to a possible delegation.
> 
> [...]

Applied to nfsd-fixes for v6.11-rc, thanks!

[1/1] nfsd: fix nfsd4_deleg_getattr_conflict in presence of third party lease
      commit: 1271e30308ff96cc702bc7ef764fa6546c0541fb

-- 
Chuck Lever

