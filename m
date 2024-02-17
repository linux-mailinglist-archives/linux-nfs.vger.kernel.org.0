Return-Path: <linux-nfs+bounces-2009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789288592E0
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 22:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5331C20EFE
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8B7CF20;
	Sat, 17 Feb 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JMQqm4en";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fXNmSjPP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118CA7CF29
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204217; cv=fail; b=MV3o9xCXthECbVGkgqUUlYoGGumf0o2ZZIB6cxHBHoBqaiIsQAQ1EpvHUaZUGH9xdyPTzkvVLmDOV7ceXmXzJXUpSDbbsV5qOJT9InE86WULYqa5CLAIi6dMS1wOQJje2yGxWDKyQpigx3L+JynBOywYqB1GKpGWYevIJLfUNiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204217; c=relaxed/simple;
	bh=WzwgrAnRIZPMVavxkJkcNTqWy00gF1lLeiViShVhDKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jCSWpK0JkHcFHrqVG+lB0nviFfy9qbSS1UXN9APY9Xc2Rnc70vKEFNoTCzcw2D1EF0uSp3sDZojfiX9AqulIADhygz/5yvR9/NbZCvTyjGvAmjJW2oiSmrSeKGXVuIoL++ROhLEPskeABEfm9Htz82jHac7vRggcOCP+xiboV5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JMQqm4en; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fXNmSjPP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41HKQ5CX001529;
	Sat, 17 Feb 2024 21:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=c5D4q6gPjeQRRCL77gfj8dnMuujnmnf/s5GrkenQAs4=;
 b=JMQqm4enkklwveg4DkPbvJBi/cTdTAeI6XEnYSaRhYqeoXod+NhatgUCNGg7AxO8o0VD
 14TwOR6UPwjnzVCFAyJvEyMr0Jy5D7frFTVhIfhl9e+QnqgR4bScrd7UOSC9BJY3ukZ1
 I1t8q4X5R7Qtz5ZvhreK1SXJCaDRF69R5gxTA/kkjbrvR1Df+Q9iT1Tnv6kI5KLtHiNs
 2z8aWfzwyAE2Asagf95ITt0yUWwMwuDa6XL5UleS51xUp3fSxJIfrk3lCfRId3yDB9zN
 vmevix7gofE/EEujp7vA3yeUOInu/6aF1uGGfRZObo9H013tBLibZaBXib1SFGW09bT4 Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wampas4jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 21:10:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41HJ90Zv008468;
	Sat, 17 Feb 2024 21:10:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8480ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 21:10:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gabUmDOACoGmKOhSg6ULMh8+96hPHAtg88V8o6kwU2jzEVX/V0b8ssul+xXaI9BJsJv8bhPTgvXULAdOl9Vu3bc5oeb1M3ADy+FEb3A5wN3ouPlyiIa85Wph4zNw8JKZR8jQj1eqQPzrRQweGEugq0urugVmQHPBjrOaPFEfJ2IugnklhbACmqbYEJUFnpi16pYyNZ+qSHwLXy3Lx5/CUEKvxARBD1Kb9T3MlaCffchhtbEzFRi4srj93RyYT89iBwHYWWtt17Tg42c1lrjOiVBRZQBKq86xufMD2lrqqLfp3w+5BGTwLGzEemqvtX59Nzwa/8GCLvMDULmFfzC7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5D4q6gPjeQRRCL77gfj8dnMuujnmnf/s5GrkenQAs4=;
 b=PnFxzRm3jCOIE6bNTRG7tOagmMQR+HyNBBc7Pj9OHMfg4dxY1Veq0VyZ+Uj0g+sXpI5nU/agRwd1SxfeTf2r65EzOYhiopZac8UbCNgNxy7snftnOhG/InSx8GMrFvzo1r/9WV52fZzC9XP+qM9VZGBu7q0BiaSCjE2El7jSzVUb2YLHtxer30ltT8Splcz+vNZyGOExjEhkOw3hhJg87aB/2OXGfSzB9gOx1tAHC1J85XnyqvRAeSax4jL2OWsVG7SZP3USDCYMTE0wD+4BdjLuAlToU0zE4rI31xIQnNwaPHWhG9WA6nHgpdyjAV5F2QxScjNnAfiQsn1dVbnpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5D4q6gPjeQRRCL77gfj8dnMuujnmnf/s5GrkenQAs4=;
 b=fXNmSjPPjZq8gxtp9sxdQ19qrwLf0CdXIcKlpBDSymyIAHH8L3UmqMm8jtCdy2vUdTJjISOx8luyX0fHGY+su6X63tLm1r2J9AywCpjr4nSF8Ut1gFRu+HKJ6zW0GnHkzey77AI06Q6HkneWPgMjNYnQYFL5mLcRcWe25W8PQjI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5059.namprd10.prod.outlook.com (2603:10b6:208:327::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sat, 17 Feb
 2024 21:10:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 21:10:06 +0000
Date: Sat, 17 Feb 2024 16:09:57 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number
 of delegations reach a threshold
Message-ID: <ZdEgpStNxUc94j01@klimt.1015granger.net>
References: <1708192859-25002-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708192859-25002-1-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH2PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:610:58::37) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 694103fe-26f3-4e93-7b9d-08dc2ffcd0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E52HynECNZklE+MwpmhakKXN172M2bZ1pl4XabM/xMyZ/puh1raHwSEXYEE75vq3d/KeqSSwPeqg3ADKxs2o3IKFLr9Xe2z2Q7DZDqmWEP4Rg0CXzygDbALi39vTlgIt57kIWw7cQX0o3uJfE4WkF6rMAJCV7u1dTnn8sc7dJnpwSwa3xa+JhxiKiisUe0fmeeyvJfCAyZ1JBxjn1g784NHCn2pV+5VTvnhH9RQBEdjaw4Fk6OUhMIVdkz9+U2V3hWrxksTXGuZsU/lgsxS/Y1KBbeHiQB1UntOzE1J7woEjyuuEECxfWN+GvLpKx2hstDrupFTSqpHa+heU2eFGykFplrkAVNsqWHW9bhq194P94Epf3VZ65IrgwaNwOfZJbJLtp+27rnkW08u0o+TfuIk0Av6ceeuPqmtTJfpRT+M/NJMIEXlWz0HCEB+7puxYMHPjyT2LfFnn1pqGV70jv19wN2SVnv52CnwSbWCo2ITwL4RnnuS+Nh7P67ct06ZYGbTGlsROtWdM7SUc5raXOPNdHkNUrOMtEkzqb+jlHEI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(44832011)(45080400002)(26005)(478600001)(6512007)(9686003)(6486002)(966005)(6506007)(38100700002)(83380400001)(86362001)(4326008)(66946007)(66556008)(6862004)(8936002)(66476007)(8676002)(6636002)(41300700001)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?s0oiuWuQIRq9NI3XeqGcH9LkrUWarDpcpzxeDAscHECwNrxiUxFBOFB3tuHL?=
 =?us-ascii?Q?BneO3crr+P93Euz1M0m9jhNjQXlmQsh1OOkd6SIhJ3MjsJd4fFdZjTFAOxL4?=
 =?us-ascii?Q?muziU6PTKollXGqjeHB+g5G5QG9OtGh4N03UlqJMMmg4wdqfqzxfMmHpJJ9j?=
 =?us-ascii?Q?1m/Haa4aMhKHLZ+OJ2SlX8Fth09UjiWSnFA1/XHHRVKiObBUZF7KjIrwSNDo?=
 =?us-ascii?Q?HxL/ewUrm+siCYFNmYlvWn+embFj5iIvoWXzYCoS0t457k37NFO4DhRlL/ZN?=
 =?us-ascii?Q?2kksxRH4pRFbTHzHtuSCriFpmv1fvepcXoAILn4xj9r/zeskx0gEW3mQtQFR?=
 =?us-ascii?Q?n/DRSc5QBtD4tZI1i2x6OO04kEyvYB2wtU8lXfqNg2rIL+jljsOO4dmj6pMH?=
 =?us-ascii?Q?kqB314mky0HXYatC6YxWRs+Zg88dmtAPfH+lG4OcvLbqqZbYbxHesoBt9oVX?=
 =?us-ascii?Q?GxgFkB6Jmu0nYgBXhVHr58rcAuLPaKO5zVMiV/6BEZ1crESWtJt7mLGGb1Zx?=
 =?us-ascii?Q?S8iXaitXsJadgSXmwjzw+IYUXHjwxBgaANFLNfaPE93jaDR+pcutXs/OEwWh?=
 =?us-ascii?Q?1Kg3MNF6zF1DXzpiZME9snhXaXAYuaUCbmKGAZq6ijTvRzy48cJJ5aGZO4iX?=
 =?us-ascii?Q?WBskdM43CfF6D8bHsh928O+Ly7UYowDctlsZWcGVg4lrPs8Pq0Z2b54V6Q0Q?=
 =?us-ascii?Q?OOaD1ALflcuPq0Gq9rJdYwsnOh61gOB0veD+jy6TBUGqpSUIdFYmi9fgV3ts?=
 =?us-ascii?Q?GpxHzD4kwySG2TmfjtfJTVquAYZi0+nf+a5EL33BoX4OxKj5pOqXYgs0jFQa?=
 =?us-ascii?Q?TnzHQwkrXp42kDYxyWd3vg/p1pIvQjC15MQMG4O8+kUy0d2So2eU7Yf2D2gu?=
 =?us-ascii?Q?jradKxtQD1Xa5sQv2BLPB8CcR+3O3pQBrbvguW9aIskTJQHAUo+I1ngcr8QQ?=
 =?us-ascii?Q?5PezDMSPgPN9A0lXkRybJH0jIVZ2h/8OtRzXBEgIMqRtwLFiPqlGZzd7V9GZ?=
 =?us-ascii?Q?M59u8KQjiiXBlrdYgFMzHBK6cS0Jz0RGGAAe6Vi3DiX82lQcP0yXSeZeHhk0?=
 =?us-ascii?Q?0ugBWc30N9pSeisyltAyGHa7Rs6D1am2U1uqE9m6fAA/WyT0zw+w5XLp1GPF?=
 =?us-ascii?Q?SyJEg4KtNbN6DoYs+0+zRAYFtHRkPn7cTOvXCgyqbbtCOX2HrQG2Nm/IjxrQ?=
 =?us-ascii?Q?24972RzaMR9cki37smo7CVu5PTUjq862g4iCt4suDVt/QVnZQV+JlMGVOZ3r?=
 =?us-ascii?Q?AA/CSP2hs9BYGHxjpE8sUSD2BGU2VEomS5SaMxk/2Pz8DTedBfoOE3K9vBzK?=
 =?us-ascii?Q?cIAqL2YWJf/VmC8JIDhSxklf0yWe+5bUQsVv5wBXma1dxTMr1Zi5tFYGwIoj?=
 =?us-ascii?Q?IwnwDhbMB021e0QvM3g5j0dDRMb3upjTsGe0ffnlfkhNMfnWuuE+xqyrYh9A?=
 =?us-ascii?Q?alK/bfyIplBD0q/m1YjiCEF6FOsNdC71piB8YZyxExhAYdG05Yg2cmFCJ/kD?=
 =?us-ascii?Q?fPq++FMvjeMiT7NATJcBf+YTUSc1e4fdHZHrDpvua5jywvHFmsfbwGMCP/h4?=
 =?us-ascii?Q?z295URIB4ODvY+0UcAxtTIDfRZOSL6ppPAoqSPXswjY1sCBE6bNeKy/7TSFF?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EH3VfGLWEuijYTTGOiVjTbtvz9xtGrbABUVcubZl/Olh6EVwTW72gyqmczextXm+Ro5SRWjYrWImoK9/vhTh+NE0gToyCjiL8UXr7a1jqJgM4EzwG7VZZbhskOrb0aHTfrqdGUk5zfRxP1ul9epp0ehEM88o7wr9jXBMx0Dqg1KP3WeNqmyto1wt0bLCGci2HV4L6AGtq8USAt4IvrcDa2WEit6JPH5evMPMnSblghIXV/aKW6Gk55z+Sd+bBSCy37f5pARd+ecyJITa4SPKBeNHHU/s8ZPb35twG+dqJg0PxMfLwP7CNTbVq0/3vpIzElIanl+3LjmZbgYkyIVUDNJ9zEuO0LwYPTwwXxpmelMrlpssI1igykEmgqlFpI6lHuwjRp85piwKBcIs3MwGplA2M2tCoLGgf1/49Wdi0xUmVMG1teCfIYw2eEluGaK1HPlaLb+S8M4jzQIRlh9LMDr/30JCgQCcTq0rTP7iUqZZNREGCLhRjf6SuE0JvNsqwbPFu+PRfqLtJ5hhlrMBO1w5Iw2B8LurIF/uDChK4u45Rwp0uE+tdo6l9+wdUXOzGnnQy9aNPf4F2cLs7h4DpJJ8to7Gfop19358sMK1lpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694103fe-26f3-4e93-7b9d-08dc2ffcd0f9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 21:10:06.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFo7bdfPrPqCeq5Oehoviakf+CAkVm8egmNXUcq9DUFxEmgjBI4r5bNZXA/d4494tbS94o/f8/FazOKJ79urmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170175
X-Proofpoint-GUID: csLInbO7lBN_RWpXaPb_6tdw9-aIH5YW
X-Proofpoint-ORIG-GUID: csLInbO7lBN_RWpXaPb_6tdw9-aIH5YW

On Sat, Feb 17, 2024 at 10:00:59AM -0800, Dai Ngo wrote:
> When the number of granted delegation becomes large, there are some
> undesire effects happen on the NFS server. Besides the consumption
> of system resources, the number of entries on the linked lists of the
> file cache can grow significantly.
> 
> When this condition happens, the NFS performace grounds to a halt as
> reported here [1].

That was a v5.15.131 kernel. The LRU problems were addressed in
v6.2. This doesn't seem like a clean rationale for adding this
reaper behavior in, say, v6.9.


> This patch attempts to alleviate this problem by asking the clients to
> voluntarily return any unused delegations when the number of delegation
> reaches 3/4 of the max_delegations by sending OP_CB_RECALL_ANY to all
> clients that hold delegations.

I don't have a strong sense of how big max_delegations can get. Is
there evidence that CB_RECALL_ANY has enough impact, reliably, to
reduce the size of the filecache?

More below.


> [1] https://lore.kernel.org/all/PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fdc95bfbfbb6..5fb83853533f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -130,6 +130,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>  static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>  
>  static struct workqueue_struct *laundry_wq;
> +static void deleg_reaper(struct nfsd_net *nn);
>  
>  int nfsd4_create_laundry_wq(void)
>  {
> @@ -696,6 +697,9 @@ static struct nfsd_file *find_any_file_locked(struct nfs4_file *f)
>  static atomic_long_t num_delegations;
>  unsigned long max_delegations;
>  
> +/* threshold to trigger deleg_reaper */
> +static unsigned long delegations_soft_limit;
> +
>  /*
>   * Open owner state (share locks)
>   */
> @@ -6466,6 +6470,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	struct nfs4_cpntf_state *cps;
>  	copy_stateid_t *cps_t;
>  	int i;
> +	long n;
>  
>  	if (clients_still_reclaiming(nn)) {
>  		lt.new_timeo = 0;
> @@ -6550,6 +6555,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	/* service the server-to-server copy delayed unmount list */
>  	nfsd4_ssc_expire_umount(nn);
>  #endif
> +	n = atomic_long_inc_return(&num_delegations);

I don't think you want to modify the number of delegations here.
atomic_long_read() instead?


> +	if (n > delegations_soft_limit)

This introduces a mixed-sign comparison: n is a long, but
delegations_soft_limit is an unsigned long. I'm always suspicious
about whether an atomic counter can underflow, and then we have
real problems when there are mixed-sign comparisons.

But I'm also wondering if, instead, this logic should look directly
at the length of the filecache LRU.


> +		deleg_reaper(nn);
>  out:
>  	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>  }
> @@ -8482,6 +8490,7 @@ set_max_delegations(void)
>  	 * giving a worst case usage of about 6% of memory.
>  	 */
>  	max_delegations = nr_free_buffer_pages() >> (20 - 2 - PAGE_SHIFT);
> +	delegations_soft_limit = (max_delegations / 4) * 3;

I don't see a strong reason to keep delegations_soft_limit as a
separate variable.


>  }
>  
>  static int nfs4_state_create_net(struct net *net)
> -- 
> 2.39.3
> 

-- 
Chuck Lever

