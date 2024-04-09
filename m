Return-Path: <linux-nfs+bounces-2726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F289D03F
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 04:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9631B283C58
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7FB4F883;
	Tue,  9 Apr 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L6mldiZC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uN5SlMy4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097644F881
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628583; cv=fail; b=QqKdm3emYFTbJ6o27a+NcHFTDHv38IVNcJYOF8XLxA2GXg1y4biJlYc1y1KNy94Zt6EOyQP0BMlcYtwpyph+wWKkqUJo1a9r7drscWLC9+be1cg4Vk30c6DnZ9d0oN/sNX4rhiMuSNWAcQg7QLMRVZVArVj4lsB5fZaOEiVJlHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628583; c=relaxed/simple;
	bh=kA5TudEo8Pwmm8oSV+lEwMGTC8+CGvIxmuqyDjxphBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FYC9LJpKJp+Mxen95fLvw5Pi6EcbMdyVJSMnytb/ZxP5sb/GHTPDNMBzKVtR5BnT5KQLbhU7LpPq0/W5WRdK/3yab1XDLrXsUgC53680ygSvx+1/fh8gHLjrdS/XxJU76pjFaD7ooBtDTtqe1yTYD/F8lGUNl758DbIdpvw7Rwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L6mldiZC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uN5SlMy4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LmnFa007758;
	Tue, 9 Apr 2024 02:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=WZ8cFg9D02BiYusXdMlqiOG6KpDuu2RO+Mt64PJSqRM=;
 b=L6mldiZC8lelCAkwJdUuA46TrbAfp5ecgA7MK88p1PhQixBamKf/zr3Wk1t2R6pcUngS
 S9w7fgsMKoDQiRqWA65HOvHS7WcgggGeg9nA0zfgqYjrxkOtZiqEqsV3KAiMgsZiqQpM
 3/OrafcHGY0VdvUvA/NAXIJoriuOqlHb8o/quRuL+YVwUGyoKLvgVacbxKw7LukxBJTi
 5GuInf1QPDWyBCHl3wX5o+Cz8nOJoL1/Fi/Gve7btzu86mSd+4whnotWN0iDzMjfTWAW
 PnRG3R/KosltSiGb5vQ7fGYb8+Zt7GKRtomyQyiXyeGcgvU8bf7il+CksiPMtHP6ebVl AA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0um3b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 02:09:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4390T4fP032537;
	Tue, 9 Apr 2024 02:09:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu6n3gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 02:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alez/fxdTQerW3d18xgdkc7p/j+3H+gCyBHes/Ev7Q3716nMhTj3HI2XlLukU/wrirDbhzK4ZjVYY1nmKy7AsAjTw93SaJ1WwexdibSOooKAZ6mNIM3yLCW2Ld92/cak9+lF991nExy8EdRoITy6o9tvTBAqOlcgwvvdaaqCFkKcqwEJGtiOplnGruGfYAG//XrZiHbQS+ifYNWfMrnano63f2MB95+Btgub373k5Ux81nOSh4RokBcFhj4kQPSDDw9lWEyfsyyjN01NVDbJGVY1cVcSnn0xpHX3kNZw2eUCPwwPUg6prz/61VfE1EV1d+dTD9Tz61GAfRqYGBWk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ8cFg9D02BiYusXdMlqiOG6KpDuu2RO+Mt64PJSqRM=;
 b=E9u4gdVoIIvoYkklSsOgIxlp3EBpxNpdK7hi1pSBHwLvuDt11GXO3Yfoe7rX41NstY/cvAN8ObFIHpl4Hr0jqxLB9O/HzyrkWqftmbNxoQaQzCNGCzsI38nBnbb8R0Ck9EXW2PaTigkK3Fa3QWeDqPtjeJpYkAZReIn6tdqPwy1auWgv0F/IWYQb0Gqj4V1fCoRzxBvLPDEa5guPYVAYy3VsSycqAL4OD1pXIDxvgCJRKC4DsF7rJJQus/3wHliyqgbYU1/z/tl4mT1YMYNN2LX37gd0/rYP1blLfUX1QcAI0kmYs3mSXJT3HedOPBOLjFfPr39hM2uTIUM0VG2vUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ8cFg9D02BiYusXdMlqiOG6KpDuu2RO+Mt64PJSqRM=;
 b=uN5SlMy4D1hokweoFIOYDnRtxBWNw6HoYm2flpzayIqEJuHRPiThyV2/Tp5pg1S/M5adfMcLZAOB3Yy6voemUFk3mz9yXo/KY7qsEEf89ql77+tZOVE6ddS/ngYHit2xh+jCGN2TjB1DM47ela0VcWLf6dn2zjYoUcfnSnm+1Cs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5107.namprd10.prod.outlook.com (2603:10b6:208:324::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 02:09:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 02:09:30 +0000
Date: Mon, 8 Apr 2024 22:09:27 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/4 v4] nfsd: fix deadlock in move_to_close_lru()
Message-ID: <ZhSjVyrdTyqyj1Hy@tissot.1015granger.net>
References: <20240408021156.6104-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408021156.6104-1-neilb@suse.de>
X-ClientProxiedBy: CH2PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:610:38::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5107:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	D//P2SYMxcJ3wH0f2++NPP5xzC6LsQi7R7EvmZLiupPMcR3sNsq42jt4Aa/M72FnahlapDZyKKTLToKPyE754GehVM9peUypUjMNc7wA2To+5N7ezrPiQhhQQ4QJ3IueCv/WWqjycye/FAk4F76mvog8IsNBrQjucIdYyhWl0ZzVxbufNQC5sB/ErmqU6jAtmpfFt+0Tqlury/8a6k4bSnuaOTtsNxilNtGyE8yB4JQEBeq0woHvuRl7IMoHc0ViurYrERG41/qir78mMwJ2SlAel5tewYsluD55muRV/svZbbzxgUUvocjC+EECNBflJAlQbr6fkTldJHXGcHdaVHmBFK5jqyEMmRtGu/v3Ut8An/3YxhAcF/y1fb9FSNpmswgkBCCwZrbLIiBJntpLr/TujjalhAqF/rAquklKCcoviZmY8VLgNQXHzee6pVdrjLab8mvyoVcCU8nUmONRSAKb2lVyid5yndcvOojLHoN5m9JJngvHYC2z3moOL+e9Dnm/s4gjzIW4p0A1EwMcXqw5m6MPAtpArlGuFnDj5wxtYmKcKT/PkHCeMVH2BMfxPj4bCwpUOaTGvvLJvML7+oHSHE8M4WZz3kJDqoMcLjW1HasK8YzVVpmJheNzm205uv9Hj7iz1zDDDCqHyGgasjXgQecp3q4lcYXszv7137c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W/BaQwM9GBclaeGJ+eEzSw0iv9Whjlne8Bi7VAjfJfqyTOudYHxKBP834j4e?=
 =?us-ascii?Q?ex8zrKE8efZBcLo9myRaJIavl6chBfRIcpVVlikLV5YBKszhUj6AA1kBK14x?=
 =?us-ascii?Q?JTze9J0p2bd7Mmfkqc5J24zLqxb21ybtgItz+9Pu+BGYSaLnEbHtlflWqa0V?=
 =?us-ascii?Q?t8kuHxpzInnTocV66l0D/vetfZpMSSuY0YtkHIOWHeoW86/S7AZSLZ8sXs+6?=
 =?us-ascii?Q?9EYefU9dFwOLd/MRf2o/RuB20jaMj5tYWjP2yyn1ST29hTdjpOEk9Yq9Y8sR?=
 =?us-ascii?Q?cVxxVnPzmkRtmgPDPMW+Q+E80HU65RRR2GuI7DvR4BmrhZNKT9CxdQsdp4qO?=
 =?us-ascii?Q?S8hpFXPaDtKN66Kx5s5oAKU/hhu19J0Z7iBCvS1Zp2PAt4E0AFy7wnWJBQUN?=
 =?us-ascii?Q?42htXq/J2ESGeLE2YYOAkK9E4iapp5F2fhz3rdnRqGn+paSYE8NfuNbgN+Oc?=
 =?us-ascii?Q?8gjfYDb1TfD+o7l1uRUlujF0e+rUudml8rp6QLrZi3CQA3/wDvgaYNJO7+AQ?=
 =?us-ascii?Q?3u9UPAJdjltLolq0UqTjiNOxXNG7jMCVdsOKA78Q0YmFD80M9LY2hX+Fo5PP?=
 =?us-ascii?Q?lxdLigEfMn/U7ARL53SMwDx9FRlCoCxfLexeGhxbqjTgTZm4m5v9MpvgZUuU?=
 =?us-ascii?Q?oKQd5l4nPmxyQJVXPjiwwQYwZwKLGHCuNwg4c2P+ACFPztme+oUwfMgfDhgu?=
 =?us-ascii?Q?1ZUuafx20JeS4thtSjbJvJj8FMcspcXvpabzQwriOSs0E9oTC/HtgCkfa3Fy?=
 =?us-ascii?Q?aCZ0hT8wjok4J4hGy2zF/UIHYnjwRIAkvmHyMIByOuOnKWMEpu5upjW8S4EM?=
 =?us-ascii?Q?+jOXK+131/MCKX6lq43ex28KTMsmvpCAASS8xGwOBO1Nac5wHXy3w9QP65BE?=
 =?us-ascii?Q?ThFb+ZEhqQoqzpN41jxbCqsMAoOCO76idHlLHrdWl0u6pi2gk9/ampn9M/jO?=
 =?us-ascii?Q?nwmks3eMNVP+cYNX6hwsAVUzCeaeKe2kG08wZ1wmMJDk7W5PuwWfGWnmeWIf?=
 =?us-ascii?Q?E7ZW7H78uhW31nbb+01DnD6HwKYuPg2XUQGvz/F5jEO8stJwhGC/DP6BFy1d?=
 =?us-ascii?Q?Pqd/+QwEB6YBKPmvP6iDE7Gvh8yNmL09xP7tJ6OM/NrVSC3TCggukz1mOA1a?=
 =?us-ascii?Q?mF+lYlJai6u80ZIKg+sNP0rTO23u+snHsL2bBOcz+JeWqHPI6DqlxIhmKZhY?=
 =?us-ascii?Q?Yf8EL5cZw6ufpD4yr27ZyIugeN9giR0+E2MeAM+i1CuSBPIWP+pYbta7757C?=
 =?us-ascii?Q?nAVX9HOTfoLSVFZoiYuFA/+G12zaVz0g5FmdRJ7t06bQ0Pwx4w8yTQ8rSyG1?=
 =?us-ascii?Q?3Nm+/FZOmkFQV+qrcRVB9k/DOZJ+BEgqYNWioGG0jZgDQPDW2FMiGh+LQ1ij?=
 =?us-ascii?Q?nOQ/FPEo5NfdD/pg4tCxgoH1ISY9+DENYzD1PjMCIbD1vd8fldN/O1g8eQVR?=
 =?us-ascii?Q?xMcL0AwkMAH1Pe3qog6tAXrRirA9aqZCLKdkL63lHOlX7ON4C2LlHYnn/DTa?=
 =?us-ascii?Q?f/iiqkstEa7Fprefq6aKGdSsjTLEUOvErQNFrGTu8SLFOk4c+uLPW2bHlqE1?=
 =?us-ascii?Q?r3sRqiSGyDh1fNr1Znn5D3YniICs6jI+cd1QyFfyaltUeye9HcbpOwgJ6ZYA?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iNy25L4W2roXH4EEsQFxQQ/t425kV3/Bd0q5tep/0MVST1ZFMftha5ez4tPtKUkl+ygh4tg0CcvvF/AGltpKL/EbSdorMP/lanArR41Pv6Y7VF4MVc0q+k5rPxfF8GCPTZMgtfprEeu15OR2SJhxzXM+g2Sn6aD7HYmk2nKBEqRJ1qigWzw5gyNVwkqJTsGrhPiEU316c8YZf5Ud5a1KojEatW40uuvxwlmjIESSARtqlDy2hIr/LJa5qhF7GW/RBW6M1UCWmdU4U7uZEolMPxpHUficG5GPlGxuhsJRMD3ji9SGodWIdzlQaMvU9gKQl8NddEBi8VNjJVhYc64y3OH1DG19poXxdWkAgBD/naAcCnG0aPE5IjRA8DlNieaaomh5kxNm5rUxmgQxm0J3xI8rbToHOOQjtPQkNhnGZD15CZ2Rp/huR9gN8t+Pyhlbh8wyNYZiQvXlOfDznxPYWQ6GC0UjfGslmOzmBsqpOrbDfGKqhHU7ICxFW0kVaNf9bs4us6/OnnatGdz7t9y0ikWXtxV5oEz6erq8ePr+9/Dy8oq6a0sZ9e8qfU9zhOgn3ebLJpvRTtkW50Gou5e9qPbQVfXnIfFnTfk1tgeWBtY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9316a41-c01d-4b63-c8a7-08dc583a173c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 02:09:30.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dI1YIt34p7yv42aMtC+UBl4m5xIJvFzVna8FAcUxJHDAl6u2aktYg2ABqzUT7rBrc6kZ7WR2xJdEOkFC+S0zKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=779 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090011
X-Proofpoint-GUID: GqVcVNlCdPSdKEDZBqmUJbMNLnCM62Pz
X-Proofpoint-ORIG-GUID: GqVcVNlCdPSdKEDZBqmUJbMNLnCM62Pz

On Sun, Apr 07, 2024 at 10:09:14PM -0400, NeilBrown wrote:
> This series replaces 
>    nfsd: drop st_mutex and rp_mutex before calling move_to_close_lru()
> which was recently dropped as a problem was found.
> The first two patches rearrange code without important functional change.
> The last two address the two relaced problems of two different mutexes which are 
> held while waiting and can each trigger a deadlock.
> 
> This is against v6.9-rc2.
> 
> Thanks,
> NeilBrown
> 
>  [PATCH 1/4] nfsd: perform all find_openstateowner_str calls in the
>  [PATCH 2/4] nfsd: move nfsd4_cstate_assign_replay() earlier in open
>  [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in
>  [PATCH 4/4] nfsd: drop st_mutex before calling move_to_close_lru()

Applied to nfsd-next. Thank you, Neil!

-- 
Chuck Lever

