Return-Path: <linux-nfs+bounces-2883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00678A88DA
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 18:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31C81C203D6
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFF148836;
	Wed, 17 Apr 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Md57YA7r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="czsw24hF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CDE147C7B;
	Wed, 17 Apr 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371373; cv=fail; b=CZBMBcg7PRVZ+teyMrko6/KsDaMcFglSzrdyqVDhGbAYhlvZIY8ahPBGbxSPsCl3dRZrZdtvTqHUMGyZ73G8/Jc8azuSHErGWVcVqAgVV3z1VUH7hTZU3PxjlPtPjohVrRisQh0JTpuaFL+JQCTXEGgKXZHR8RBXXXPZ4vHhOQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371373; c=relaxed/simple;
	bh=4ayvM8+eNXbODP7SZdb1xU5l1lGrK+iRRysB5V8yR9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OYePqo37PwXo7HvjXuoxcCm5qwJNKxzjDzUw49++OAxaujOyW0EwijCESI/kANFAOKg+3UVo1Cx4jeoK0S+K2v2CJihdIqWHISSrWRuOT3sEMxFEEc391Osz3LuqAL9P18AwG/ym2Hh6zRhqem5hjUOVZ2DTEbZfzqKgZwhSedQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Md57YA7r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=czsw24hF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFO3Wc005253;
	Wed, 17 Apr 2024 16:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Qw9HKtA6lyB5qAynSsxHQMHsPcC6JEl+dRpclskUZtA=;
 b=Md57YA7rDW+KOdKjzXRol42seWzTDkHo1yu/KMXWb3L/2GysPQ+p1OR7azAzV9mloTQh
 8om5bAbuGBY/JDQy3W6epbz4wBtpPidx4VxGJ9JNnEuPSgK5hVANI1trBqXLM9XRmbMl
 zxDJu5pC/3Yz3wu9fB29go/PJoRvN2A85BzBRwGXPPNoNOQl5HEMYO9BD/2VSXglcKKS
 q/ktxJgfLvi8Nq0Ut36Gdrk0Uhm9Vu3IEuKZzzEAiRS5hPkGzXVlxD5NMRti8OHOrNPT
 7mpebfewfdDsYKi1n2/EdPHTGPCOloW469OdHLt0vGbZXclr3gazSzC8IyJ2DRVAlujr Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhnuge1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:29:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFUg0o004428;
	Wed, 17 Apr 2024 16:28:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggfbxg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odFE0UhxV1pXuRrqhEgwJUi4WT/++L9ethNSEvjW3zOd3zYJzg4STf4+p8qXzccis9OKSkpwq8IfkxIAYh2ZRRUbDHVmdf570+HAjXhJj7xfwrfazvvWnxn9BUB60CfRVcCl9LoF4kN2tPNuhpY3nYXjjv6Zl1WLeru8wtMaPxl8Hv4IXn9XoQFAocwNNeVCCZFb3FTiLiq+kzq0JuuD/o30vXV5bivCezphAngIJCVL/+qkv6Vegc/yeq8qyt4Ap3BdC2uPPlaCdix6TeNWmG52XW3hjTrNI6itY0NvDp19V9ZXlttrytxiGbTgyrOzFG3IAPFyHoJBz3Ji4c1dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw9HKtA6lyB5qAynSsxHQMHsPcC6JEl+dRpclskUZtA=;
 b=BS3yVhkOKErEOdmrsSLWk5QK+MmiqtJFWxwfZeva6HvstMpcdJtYtPBAwsl/cWeajA/4tIIISF4HTj+TLftVmbdQ4ugEiCfj/39m1X6og49386jy4fTijehSHGtMtxcxd9T4WBDKocvN683NTuBmSybHK79BB+20TqMRKewl1DvG+QZgwYCKuiz/YgPsPUD9iA7Cn9QSQEM4zKWy4ToI+DRTKV68R1+blEW4PmKFUzdGTrfNOhxmCv1vtUPq8YK9bk/pmbX5znc66tl0hVvnwfxWC0OIiTyYqvCnNz6gejdwhEpqkFzZojkCU2V1wot7K9XOmn737c4D7fcghXPQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw9HKtA6lyB5qAynSsxHQMHsPcC6JEl+dRpclskUZtA=;
 b=czsw24hFrvIF5EDZt2oqOqfi+IDrm+6YlIukaRf48UfghKxazPv9Q1tHnYNskDOitOj1Cq7L6zx/H3X0ouzNn59nzgV8REbIzAkc0z5ac1jGzUrJKFGRPXbB6CuIqH2GrNT7YAYSgmekX672Fi8ZC/xX7OQkX59RwMYGkpPM8Js=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6084.namprd10.prod.outlook.com (2603:10b6:510:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Wed, 17 Apr
 2024 16:28:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:28:57 +0000
Date: Wed, 17 Apr 2024 12:28:54 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Li kunyu <kunyu@nfschina.com>
Cc: jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockd: host: =?utf-8?Q?Remove_?=
 =?utf-8?Q?unnecessary_statements=EF=BC=87host_=3D_NULL=3B=EF=BC=87?=
Message-ID: <Zh/4xozLPreN7ELW@tissot.1015granger.net>
References: <20240417082807.14178-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417082807.14178-1-kunyu@nfschina.com>
X-ClientProxiedBy: CH5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ce4c11-42f2-4c45-5a93-08dc5efb7af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uShayjaRLjnJYQM2nzY4vffnvHKhTzttHft09oyoSNvXkqxsMO/aSE+DPEL4VZ5xDs4xIgbXXzEvxzrkfb9xC4tdnj1OtIz5Iqv7eNFlbHq/aEtGu4zN6rBFdp62eIsuM2/liPNmnweFfu0zUVJJdCQw0aGJCAJUwy2Wf9UGLsqyBMfTxpySEob3pcILvI3OBrCUHT2+vGXJMmNtvwPO4UPT2//h9RF2zQTzA+IOEDn4RdZHhpq9elEkXFh5HegXvqvudlR3Pl1gdOJLHcWsjLLHwDa+zmSJ/tB78DpPxvYd3b1CsehSZAFvVYW4//taxoAC/7LR03OweVYOuH9LHdljY1vHVPIdr5ydRyUxEHb6sMePis3yJyuOBB9nc3c8mbt1AqCPKgp2n/c7fKmdvjFyZ+/0yPVJ1yh0rcbfUBBPis7iR+vqC5dC1yZjvT5MLvwz12nXjYKcxI3RakfU1Qa1bqI5T8s7tVLQrQqOKyyEfgrIFz924n/b3GciZ8cubSxmsRU5Tlru4GrWKrMUp4PAtrP5x7JBcA3UoI2UrY26mbk3NlwF+DTT9RQSN0x5tK0AfP7HxSZdPrCeJWFMUPlaqNUx/mR7+JcE4aNM8twfTdXcAbAZCIFZZFyQ0b0bnDmDQf3R0QYB3ReS8bCB3oi2u34ZUj6TgZ8q4HlZzxY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ih/ftXuc3xHsGrtIKZmvLYglJgTawOBgPaMR7jwgDHRyYOETIm/M1NKBT/mQ?=
 =?us-ascii?Q?C8LCPQmXEZEw4RvZyl8sGrdDI9lVMrPQFHYsUywSUeKo8eiqdxQfbwbcH7yA?=
 =?us-ascii?Q?mk/7Wno7Aq/dEDkKaOO2lM8rkv8jjf1/BybQJY5I8P+ukYad4EPhilVUSreY?=
 =?us-ascii?Q?+fuAFuA4zysecxgHqEWhuUwBJhL0cluNiSjd6hySZOHhFZlgWmC6TasxAWbd?=
 =?us-ascii?Q?/T2YjazapH7PnErpHmhNpAxLdpG3rmeS7pyqlGnzQED5mit0nTA6OMOknQmB?=
 =?us-ascii?Q?6bP9FIgk5qtj2FvvY2sykU5iYPhe55A19vaMABoUCloorucrq2LfV+Vl9Gcb?=
 =?us-ascii?Q?3974URPYrP+jVjEKuzejvp3hD3ZiSXa2PFwjvU1RrZBeBzl6IxtsLbPFuApI?=
 =?us-ascii?Q?bA8DeHK9aopMhNCJaQwe9H1Ljkx31lGkHGYQpewHdHZZjUpFVl1ODisHe8oN?=
 =?us-ascii?Q?tzBHnlf94YtfERVQckyaNP9kL2k8ZBmqNZL00ja206EIJq1DgUeDKdbvbTTu?=
 =?us-ascii?Q?UPFyRF+h8cLRN386aJg1C+hxkOysm6hoHZZbQ0gK9lTmm5PtZN2eDDZyWJls?=
 =?us-ascii?Q?OSSYF9wy7rVkb5XbtFIHHasHKpC68VCOzhqavt5NtfP4MP/5ZMWGWzvDimJF?=
 =?us-ascii?Q?YkrglmpKm+KvtY7P2J013MpQtp0xy+MtqJQIQXGQmwNvP3xjnXrqTO4FOQsj?=
 =?us-ascii?Q?mkeBYHtHbxvpSc6orRo4y/XqG4LEGkeyh+kzepXbF02SpqHNvUGdvqRIWpND?=
 =?us-ascii?Q?aZ/c95y/Tv4te0n+xnfHEAPr1AOYPGEXbjviJEotdkEs6DNmuM66h94LaaA3?=
 =?us-ascii?Q?8s212Czp7slvVI+DWQ84JIHfNO6M+c/3TWHxusS4nsRytkIm++i8J7HgLnKu?=
 =?us-ascii?Q?t4NeLPNbQy3lPtbVpXiv1eeH1iXO+bfQEe3OKXD0aLGHbrbL0qT82TrID5cn?=
 =?us-ascii?Q?d1XJtsV538sO+/J8fP2pSniWfHK4y9nWkymWFS8TWnvwC+AIyfGqkOVdMGWi?=
 =?us-ascii?Q?3HYGzs0aYYFBxaApcLY0Z7u4RU2NJZRUqT4oOMN9tRQjzF5hdFP+YhpZGmr6?=
 =?us-ascii?Q?Bgyvh2aK3gpADQw7S+NXVGNK/i/o/aWAlDQ02l+7uv9JC2eZfn3Zngkw1vhj?=
 =?us-ascii?Q?ANF/oDFSx3htK/Q8Pgo+9lb8S7VOqTdrPkQj877Zt1NVKjgzO94Xciayr4vz?=
 =?us-ascii?Q?sTmzkgkgo4LwD5UVC+n4rkoSA5EPDBlWDaEdDmPDRQ81PBavNSwnGz7X7R4n?=
 =?us-ascii?Q?K1L1Zg6sM2Fgh61J8WgODUS7m+4qnkP17C2SxCa3P4o7GQIoaLmq7QKzK8Pt?=
 =?us-ascii?Q?d6qPByxo6ljDQwGnFtNZqXJA7VTb89GS86Lr07jOO1nEFGLLxwxkTHyxops3?=
 =?us-ascii?Q?kdelfB67Kx+VTvwkEbWnMO+FmXXFalmHNjYy5gbdqYQGz+poQmKUoOCsrAja?=
 =?us-ascii?Q?bLVIjLDeMxrOBiP9L5JXc77g72buSnPvaaauSEOkHY/oGFrYSxMrVvDBZDG9?=
 =?us-ascii?Q?6AKMgZsu2Jd9PYGdKgJG0QPXz9FuymswBEbg8AuGeyT8vwTE1iqCEtnjTUNu?=
 =?us-ascii?Q?dc11Gu6U9sd/shp62wJCyhakl1UFshgYHrEJ1c1J+VjTWv2+hZFguTDCMHQj?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IFM+1YdhgIj62dHGz9RGl5oFsKGI8diJVfyHlCWXwScfLKMR8nvPShpPkayp/kh5obErzYBYFDfey+egtbcVT8Mjevgp1zgs9cDn72SbXjyNAURig5y0GRnJ3UM19QA1ApE8b5/RugInCc97iqd+y+rvh20kZIXr/207wYKxz4mG/awHIYglWx5gv5I6ScLht7Hmn7TW5s1hJiKpCSYiF5xHXXCslyK8IaLBkSrvDHJmj9IUow8r8WZGZiRWQbvjqLVhu7OXhYT2Hrxe4ABpNX/fjnr6IZ9mAogOCKdBHIErwUHZ65hcJpG4hAa33wx1SfhqgMglrI2HimgNoAhDIPhGkFgMDgdMT1POv9Fv0gfbqJtqtixOBU6lIZZxv/jjiL5KbRmf12JtSUtzQIwFyOcoUKG3oARsFJuKJs/qOBLvEP+6ZnagD1ytdzQNeccL7JO5dlHnrKpehHGa17Y9ONNKGj32rTK1wHqyiffNrEgGBz+uNtb4bvAC+i7k6y1ybj/SrarQbAEOcTsUBxguwcBmX6MqBPqyrMNYl87bFCLXR317lSxgkP9w9atyCYRqrqRwFkdAyfS23KzVbOfvrWlOfTr+KGPLFGLy2vmKPIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ce4c11-42f2-4c45-5a93-08dc5efb7af0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 16:28:57.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZEyYzmP7R8/gYtIIzeS9h4QtLfmp0F2DvBT5lGYnSrMsRoCuJ/ma4ZNjQ44jpdwz4EPOQp+eFV4vUz8WxgjcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170115
X-Proofpoint-GUID: beqoRiv5IGDVoAffT8u-_TBspYEbp6P9
X-Proofpoint-ORIG-GUID: beqoRiv5IGDVoAffT8u-_TBspYEbp6P9

On Wed, Apr 17, 2024 at 04:28:07PM +0800, Li kunyu wrote:
> In 'nlm_alloc_host', the host has already been assigned a value of NULL
> when defined, so 'host=NULL;' Can be deleted.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  fs/lockd/host.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/lockd/host.c b/fs/lockd/host.c
> index 127a728fcbc81..c115168017845 100644
> --- a/fs/lockd/host.c
> +++ b/fs/lockd/host.c
> @@ -117,7 +117,6 @@ static struct nlm_host *nlm_alloc_host(struct nlm_lookup_host_info *ni,
>  	if (nsm != NULL)
>  		refcount_inc(&nsm->sm_count);
>  	else {
> -		host = NULL;
>  		nsm = nsm_get_handle(ni->net, ni->sap, ni->salen,
>  					ni->hostname, ni->hostname_len);
>  		if (unlikely(nsm == NULL)) {
> -- 
> 2.18.2
> 

Thanks for the clean up! Applied to nfsd-next (for v6.10).

-- 
Chuck Lever

