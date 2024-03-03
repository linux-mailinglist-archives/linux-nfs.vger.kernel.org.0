Return-Path: <linux-nfs+bounces-2147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BD586F690
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 19:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEE31C20979
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026B1E885;
	Sun,  3 Mar 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RYXB/xac";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SSEmCveT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BB1DFC6
	for <linux-nfs@vger.kernel.org>; Sun,  3 Mar 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709490937; cv=fail; b=G/Bdc1yKRPZShk33niK7kbC/Si9Lra2rczIZ+N8RYuUl4oOl5o9F4IcfclqcSRs0rilrgHZdGctwS2jiOWmMOIUEC6ejKpCKSOUSr3Wz5eQDRbbpbmt/IHNKk6jsTEla2iR0MkSZGB/GIjwYugXnkrnJtcee/0pmz/bYgUjI0es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709490937; c=relaxed/simple;
	bh=K+/3I4DmnLiQVSIbPIiohatdzF6Q2/QSa1RVPBFPSw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rdbdpZaIBvG31jcIBobERngT1LehmeNjofqxEUGzppgqEqhorSESe/tJU2nhWtg/J5Y331BaiJEVp/bPIgzckiWFMfLWw0kUS0QqomZX5X1G88CGMiNHa6rOcMy6HbCVZWqzgwEuTkIjenteMQgHpOZPScC2bxn/BL2nRQ9lZoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RYXB/xac; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SSEmCveT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 423HnKlI004391;
	Sun, 3 Mar 2024 18:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=VAjKDhWAVb427d7KRoENRPPJB0JylISa51KczKVxHCg=;
 b=RYXB/xacnbwFAgbEHnJ41iELdnskOghxoMFvajPRSTr5lUTybVOFRcHgcKTZv9g4f+BM
 Ot3w/lX3VsQdUrnICdAgNUqFnEr2Kv0HliIi5bLAHX6S2HZpEyi/BGLdDpQlT7ftbqhC
 9TI/HKicCqVaz39hbj0h40O4GPAkjKF8hY0I6CXIXBewG/n8hzcrE2XJH2cexo+lsyg2
 KQ9rQdyLI7GQBND3YxasejmQ5hh46d7INJEJ3B1DB7aDTcdFm/c/4uHol7xSIyaJxzrC
 r2fKxhEz9knE2XJhtgRyeY1EoRMeeRZ029Fx5otXh9Z4hJDsW46iuaIUrxs20o4w6FLQ mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthea4y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Mar 2024 18:35:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 423Go5HP019100;
	Sun, 3 Mar 2024 18:35:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj4ucsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Mar 2024 18:35:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3sZKHnkhO1JCn/Dw1vsd2J9hEzey//9enM/+MjmOOvPJv92FuGAKosAxTgF9vp1nHeYOf5wto6l/l7QB9ubwdctpDoDdKcQCzZ5GYqjhMaI/mZepU9dtkgHg9TYAzZwO/5rGHRwbpoPoYV0g6YV9ji2v8Is7r4XgeMnjM02Zm2o+Jl4ekKPUGftOvYAIs6Ce/YOumy3yhWT0dF0KfCMNY2lyy+DCjkRIDjmW5gE3xzqbYFglsPgjnXV5RowRlj1LIRnHDXN25M4iKfEX+0tvfcrcREWcApZswIE7IQZ7rkgZe4jbxdC1iCp8GT6IHgOoyuA1j8osfFGiJ37do3sUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAjKDhWAVb427d7KRoENRPPJB0JylISa51KczKVxHCg=;
 b=BXLjZw+TiGmLh+KMLeGtaIXnc2OER1LlzH0r0RoCDhKaN2wh0cd2apfx1+pgOqhn9EXBp2HlRZe7wWktA6/6qbjiy+k14Rez+05Sv9ZLb//Uaeg5dmNTLePHeD1fraCvdusOG0z1xgZVWhMgAy5ScpXXKsoE5r5mlw0cJdz9W7Kyw1SlAlztqWDrvDXs1NwLaZmHPcexS0sqW2M35vPa6jz0med14TSUIDr/QyPyf+jdWXixnp2PGgG3YkOMB8w6fD5D9JJni0ykr0kcLN9w4koeyfLjSKSb0fD8TkLDL2XBOuQrUzphpuryh9qoYqjJcED7YVvaS3NTW7VHPY6dPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAjKDhWAVb427d7KRoENRPPJB0JylISa51KczKVxHCg=;
 b=SSEmCveTehT5cKWZQhbmxxwfylL3yydGyUUJ+fBrOal3tp3p3aW2zWl8JSlbgbozEure4QZO+5qjjWHpZhrDX4pppil4niLx2TTOXl4a6v/dt6sMoJBE0HoUvPgJZwYpLaKqCiixRijlWuaAkrPtaa621VWy2vHkX3Z1juOFZOI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6667.namprd10.prod.outlook.com (2603:10b6:806:299::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Sun, 3 Mar
 2024 18:35:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.035; Sun, 3 Mar 2024
 18:35:14 +0000
Date: Sun, 3 Mar 2024 13:35:06 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: enable nconnect for RDMA
Message-ID: <ZeTC2h59TXUTuCh_@manet.1015granger.net>
References: <20240228213523.35819-1-trondmy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228213523.35819-1-trondmy@kernel.org>
X-ClientProxiedBy: CH0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:610:e4::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: a65b3906-7998-45ee-732c-08dc3bb0aa6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DzjLwWLVnPmV0pS+e5mcncIVI5KTIakCzefcXMyrFtIoKKweMeVxkEssOvezAtvBl5DNyYeWlThzniVNu0N7iXBpda0LuTBaklcOXV9R5PJzjarwbbw5F+yRGJeYh3TSHFZUFbjQmta+b6Z15THCkhaPCy5eTE2KRsWQVzn0lB8n5Emgknf5tzhmWJ7EPPj4nXSSiJqZqRpmN5HLkPHcsyg4l60jiTd/NEUrPCDfO2xglOE6WRg6X2S+G8nUfZ9yOafWxRa4yAe5WdNbC0sjDbJ6giWpRNAIYrIZCz9OCGPIqV2c8UOr6LuZwZ72UrAN0XVwTIr6sg/q7xQbdGT/BzFanwV6UQs3BfB9tpW2JvKNLnH33CAt4qNnJ2GCK4Xv+gL5JGiI3PZt3t6O7eL1gMZ2+jEkexuFYFOvhMcPNoMGQS7UwdlLmUW9Z96z24QeshHzBVcGRh8dfPbIJVshi48WhTrE7qrPQNvjOijX6CfUGlULQUltmSOpziG7CqQZOgfeIFscO8u5lRegN/Xg+aqFAINW968ZlkMQIQhGHY2Pb5batlnlZ2HVMPwdkB6C0f1sKpaQJ/QjXVrDk/vVkERs6W2J3RnKO7lmyCx4/ufNv8AOkz1L/7ms88ynBBJisgVee0YqCPnzRpiACHOiy42mVBkODOapsTIAQoAXJ08=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7WICtEQ7CLhAWTCTWnSCd0o04eS0o56hoYVbztM9ltPhmoeTnH4w5r6p0XZr?=
 =?us-ascii?Q?2UCzNmHsuQ+0z4zSjtTCMTjg3XqpUpKOYmH9ATfKGH6qDcTA4JUWSgdPRSmd?=
 =?us-ascii?Q?j0HqOW3FueDWDOztIewANhkqfRTidDnvMR9CUtKFadcAATFQx4+zSUeNv7Ew?=
 =?us-ascii?Q?OZAvV434cJRAFKd1bNl+1jbO1AEsMTNPqYuFpf4teVfyU4WadJWLtRzyYb4f?=
 =?us-ascii?Q?SmpUr1kVlsS5pS21FTUCiDYQTRyJYTBWQRgYhKOd5//tJRdlkByQktha9Eoa?=
 =?us-ascii?Q?6TXGEF//Di4619wnRxVZzAwRTBBI6vlUT8nfki7hBjUuk/wvLDV5mM6A+2EY?=
 =?us-ascii?Q?Pfu+O8A3ax++V9FdiJVHVclQiIaZE+FIiDwundRs7qMExLlimfoBifCBdgVw?=
 =?us-ascii?Q?l4zz6E5AIqVknSGOErCwFHh9dU2nYt8SWvBr1tJbKp7BTiWBG6208xQPhMeY?=
 =?us-ascii?Q?MOLJxCiY8JhFN3ZkLtVyGCcsB9RuUWVg3pbew+DvIqwFe08AsxL3FBmpvpTB?=
 =?us-ascii?Q?lrS8hZR2XO1UccOLhLjbzA4CAVnw6VK1ONgIIbXWhrKP3EyfpN67JO4meSYs?=
 =?us-ascii?Q?YK3lBRCcVkoyOP1rMsNhN6ZlJBsL7FY6TSWxST8KvD5nT7pL9IlSQyUNKLWN?=
 =?us-ascii?Q?V+dCwZSA8syv4zNpgM/PemqmRNVJSgOxJeNbc0IzY1xCKhgGYqylnx22td+D?=
 =?us-ascii?Q?DsOxo7bTCslu+hlS7Hwi7H5PzxpynB+PhY4sAepmeN3Q5aaJfouPkzRKjGFu?=
 =?us-ascii?Q?ZIcVIxl0M+LAutqBKJz8oPQx0PNmfoOCS+1mMYnrqXdbowA83kd/6ItAxXNO?=
 =?us-ascii?Q?6qaBsO/w3SpBgOtHcBzWTM+cN8N10eAINqyw+vTsmiMx4K2gwKbtFUMIqod/?=
 =?us-ascii?Q?kp1q/DfmOmNqPNwlqYoi2u8qg1h36KXFCz5sufqzfu0y/SaymoR/fWcc2Ida?=
 =?us-ascii?Q?BD5BlDeu5K0XHbgiJ6heE66Pr+AjB9QYRWqpazVMer+T0brz6Ko7gTILwoGF?=
 =?us-ascii?Q?Slj1E9ezCrRb98OHNY+qJXDJenmHS3tK65FqwcM2Ghemn0Pvb2HOzqGTtUFd?=
 =?us-ascii?Q?UiLeGV95kLWsuCUFK393XpulwaIkDRrsPZjzO/kde4wyTSw9ulvpI5r1hJGU?=
 =?us-ascii?Q?MzDEfirg7AG+JusX/XrEcs6zIZALBjhyHEe5L3+h50f5x6rhbH/4ljgkzUWy?=
 =?us-ascii?Q?t7IRUVOc7F6haaDf7cNAvi+nb4/63il20kJIEQ6YgGM7mETNpfz8bNLqGcXS?=
 =?us-ascii?Q?2zLDbkiALQQ76IGUYkxNNfBUlRvwxFPyPqgvVJj9Zjx/XRP2ZIm1ViEcFNs5?=
 =?us-ascii?Q?ZD9ww9zeBoYiobmIspBxm5dPau2xIcqw56N0QhY9oqI9VO+agAf6/LsvyJHi?=
 =?us-ascii?Q?hXBp7JgF7JmOEMitW3u76GCTNntaX0jMTKG/u6Afgz8Pqsc4R9P7gmE33upj?=
 =?us-ascii?Q?G/Se76alupEDmTSk9pJy9j1AkvrN6+dTw4cm7ChFowPR7rwQRugsQUTMusY9?=
 =?us-ascii?Q?acImknqQe+7He8koekLtUIUwO7i83zolxH4N+BiHnYgms0UmDhCOg6CkPgn7?=
 =?us-ascii?Q?m3gG6DEoIX8aosZiqyo9yxhwYZTSJyOH7BYF528YDd3GfpRB4ZeZRXjERtWw?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wqX1paPsHmRbl4hXJ3vPXV7Cej767s9fVACF5PfgUjhDmPRBgo3dShbi6Y+igE6mW0/oRrBULDWkLDEp+W4Qsvj+zMx4zSj8RDS2HbGLOU0ykx/4xMOAtPiCz2ew1YctNzbaGUq1OkgREkY5WF0TApOJDnD88r7+ygmTRDwlMMiTjRI4DXtGqjj/62nLuZkiO1ihz3pwnTqZNfTboGiWHBx8EbO6awYVcPmYvLrUaUQA/gZsPfbEujfFl/ouQ4J9q8eiYch2fzcZOodgBSc6P+jyqRLMVTsWy91pktFiJ9Pmb58ohmm00MgY8ly33dPdSap63LjL5gHOdncdKGNBlZfmGRJpOEB2pxJk3ISTi08P9l6gtjdIcT5GD2/9JHKIxcmuycOHsioLAzxWUa/yNLgBxHKHcvQc/HUnhlRSUuNXcKanKiWvy6RNbt7j/bexrXq0NCZEdC9F6eFMeq62bIM4Spnq+YPiKvao9TL4188Z6mzUrZJyX678y9Ib6CO4u/O+dxsqdsC5ifuLnO8dAJH3gNsPliFboijh5pquC61lK2Guy324XCQz0ttosoBic0RkV1OKvzNLjH0+cBijHsa7OcFYQlU9yyhuv06cAXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65b3906-7998-45ee-732c-08dc3bb0aa6b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2024 18:35:13.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSyRU5zFG3amxxufQnWDgO/BtihY75ytQKR7o22yD9kQGgwIAM8HJaYiyR0xbqLbLzvumVJ7UoPKCmg01gFvxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_08,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403030156
X-Proofpoint-ORIG-GUID: C1luGpSc1s0e6xqh_BOKyWmRdJ21yD0F
X-Proofpoint-GUID: C1luGpSc1s0e6xqh_BOKyWmRdJ21yD0F

On Wed, Feb 28, 2024 at 04:35:23PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> It appears that in certain cases, RDMA capable transports can benefit
> from the ability to establish multiple connections to increase their
> throughput. This patch therefore enables the use of the "nconnect" mount
> option for those use cases.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

No objection to this patch.

You don't mention here if you have root-caused the throughput issue.
One thing I've noticed is that contention for the transport's
queue_lock is holding back the RPC/RDMA Receive completion handler,
which is single-threaded per transport.

A way to mitigate this would be to replace the recv_queue
R-B tree with a data structure that can perform a lookup while
holding only the RCU read lock. I have experimented with using an
xarray for the recv_queue, and saw improvement.

The workload on that data structure is different for TCP versus
RDMA, though: on RDMA, the number of RPCs in flight is significantly
smaller. For tens of thousands of RPCs in flight, an xarray might
not scale well. The newer Maple tree or rose bush hash, or maybe a
more classic data structure like rhashtable, might handle this
workload better.

It's also worth considering deleting each RPC from the recv_queue
in a less performance-sensitive context, for example, xprt_release,
rather than in xprt_complete_rqst.


> ---
>  fs/nfs/nfs3client.c | 1 +
>  fs/nfs/nfs4client.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
> index 674c012868b1..b0c8a39c2bbd 100644
> --- a/fs/nfs/nfs3client.c
> +++ b/fs/nfs/nfs3client.c
> @@ -111,6 +111,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
>  	cl_init.hostname = buf;
>  
>  	switch (ds_proto) {
> +	case XPRT_TRANSPORT_RDMA:
>  	case XPRT_TRANSPORT_TCP:
>  	case XPRT_TRANSPORT_TCP_TLS:
>  		if (mds_clp->cl_nconnect > 1)
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 11e3a285594c..84573df5cf5a 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -924,6 +924,7 @@ static int nfs4_set_client(struct nfs_server *server,
>  	else
>  		cl_init.max_connect = max_connect;
>  	switch (proto) {
> +	case XPRT_TRANSPORT_RDMA:
>  	case XPRT_TRANSPORT_TCP:
>  	case XPRT_TRANSPORT_TCP_TLS:
>  		cl_init.nconnect = nconnect;
> @@ -1000,6 +1001,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
>  	cl_init.hostname = buf;
>  
>  	switch (ds_proto) {
> +	case XPRT_TRANSPORT_RDMA:
>  	case XPRT_TRANSPORT_TCP:
>  	case XPRT_TRANSPORT_TCP_TLS:
>  		if (mds_clp->cl_nconnect > 1) {
> -- 
> 2.44.0
> 
> 

-- 
Chuck Lever

