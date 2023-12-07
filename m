Return-Path: <linux-nfs+bounces-384-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD56F808B09
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 15:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F4A1F21377
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868BE3D0BC;
	Thu,  7 Dec 2023 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ShORdwyu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HE4EBNjD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565C719A
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 06:50:55 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7DxFpU015584;
	Thu, 7 Dec 2023 14:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=bXEYiFcpARNdYijL44XI89SLwC2rmyze5lR8LyML8W0=;
 b=ShORdwyuuBuh7XdLac26NT2pzlK/CP1HBLcwVZdNDwdz/NeeMDXiiVxDBkjn2ciDifqQ
 fW0w4HuZZoSUc5HFwIMcG/TfG9Ou7phzYYhx5iwBtZmsd7Hr1W8yn9QHGG0VrZfhKZwB
 m39GA4haF/Tcod36jE+Ovm3p0VeNmD+/2D3x74XquAU7xEU+tvAeLn5t/ln8LiThRRuP
 hhyoNyGZ+1LAKQUojwVotZBsy1Rz74wQJuubJPsROsy+VJEHjXlSa06INZAbrhx3eg+D
 amqSRyWjPs349eLKEmPGtZbyxYo04w+rA6gMC7yzD/GGVmVIKHeejB0L579h5AmAVfZq og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvkybk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:50:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7EoK0h036659;
	Thu, 7 Dec 2023 14:50:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanbhs01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JamDC2eOMMgr8/kQH2a8i4ZAb4hiH1W7naMetN1XHpFskLhWub7+UGQ71nvQo5nQmPQiUSH8Dc4EtIaWLMgdJOJPoOuAIwXlOuYoT4s0ZYkXzvk2gdPFYK5bhnw2AqHJAKIOnIxO47weT1gRUqqumP+to2MBPZ4aA8r5SPacE6l5q38F2hmfWs2RWD2KQEhFZEWOzAEyFGNl107x2ZjlC0cEPZJwT3HFzTRgoWecxObCeKtYp4psCaA6yqWbKIeRox4BCG1a7H8DH+Pmwx2jIQc+GTa0niJ2kj/WtArJOzmHKPK/gry7bZOxpP2b0TRtrlXLcJGdIu2ssJiO/0TuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXEYiFcpARNdYijL44XI89SLwC2rmyze5lR8LyML8W0=;
 b=AOxboFJDESqZrFdrNY2EZJ9OnuQynNT85jcKb7DS5bxE+ZeeD3tNfz2+fJnPKLGrkq06MdE1UwSzNTDxUrPvjnydL/l3OQzcc7zhrK/EIOP94KIoXbMDh7CQtg/EfSRcntdwDW0Hpx49DF5vCAarY/euVS0Pc65Gi+MkKNo22lDDAMZxLiN6M36e3F6vxXvZhnRfuh40j6JekdeG76Pe2hWMYVZtkucwXMoNvPzmf/NKWc/BLfTPu+4I5eDRhKjZRYW1uxYmAHprsmic47wnLWRMYDfOWrHF6n3sz3vbvQ9BQ894R7zXShtE4hp0cGWE1HV+5WtV4J+wwiLehYCqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXEYiFcpARNdYijL44XI89SLwC2rmyze5lR8LyML8W0=;
 b=HE4EBNjDq/jgq/cYfQVoVOOCc0VmQ7Ea+On6t88EitACv4uv3gE9jZARjKQSA3GCe87Gu/68GaD2Mdf5OAbdTXZ2YWQapRai9cI1nGwLvsroXgfLTxwddD9ieLrrrMi5rfSlp1ze5HbeC2VZFoZirD+sdVDbAQgnmXBGHn1yyJM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6758.namprd10.prod.outlook.com (2603:10b6:208:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 14:50:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 14:50:49 +0000
Date: Thu, 7 Dec 2023 09:50:47 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/6] nfs-utils: handle BAD_INTEGRITY ERROR
Message-ID: <ZXHbx1/j8VMfxVTa@tissot.1015granger.net>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
X-ClientProxiedBy: CH0PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:610:b2::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: f192b67a-0c6a-431c-32ac-08dbf733e705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kMLpChHM+TZ6ViHuHtzT0xe9iITEQHplx2gKXSPzaL/y4lyt1mOO6evBPM7chR+8Er5PHjuD/3wQq1Al/9D/WEbSGLX1hBb5Cj606zEoYXcqzt2P3P+dJeY3wTSbFXWOd2xUBDlYBeoWJSLcMUQuILcPwWved/ZqllJcECXRZw4j9oVki6RoJ8B0I9S9Zm24GyPTJMkInaDoqpF0agRZa2HmGyA1Sk2qAUAJ/nCg/4iG+hMxjPKrSxsFNshKtzZL/8/rMv8CpkkCC+3Kioj51mFyaOuLqebLSKpZUKqWba4SG5vasetltaGFY1zUIUymhhXWCAN21QGPzr5Gj0QfrlS/Aua//cb+AaJAaBVd/1bGKZJ8MDvjPdGk1//SW2cQiT3a6s2wtg1IN7s6JHJKao2DJszcHWyu0c5NbY7PPbBgaxq7WPbgfk1JZN8C3RikePKxfRWOeEsFBERimyJ42qZJ+auBY9OFlmtGmhdw0q9K2GiDwuAnOLNg38I2e6EDjTiWQuf+tB3rns7pgJC3VTCwGAJqAz8upOsZ348oBoI55bANQbKg1jZPnxZ0IOE0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(41300700001)(5660300002)(2906002)(8676002)(316002)(4326008)(6916009)(478600001)(9686003)(6512007)(6506007)(86362001)(66476007)(66556008)(26005)(66946007)(8936002)(44832011)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+SyqmTBspBQGbplwGTuwnip25W6PUuuf11IBSxDRrETn9Gk+l/Q4BAxBbu9i?=
 =?us-ascii?Q?eSTAcCEZDd4Bx9Rt8gkBDru8CRKAelx9N9uJrHBGr4//E7iL81wAK127yjXB?=
 =?us-ascii?Q?iOpJs7PQvbSvj6iHs/Y40WdpmMZavBJ5Bo6/JOps8Exjf6XNWsA3q4/dq6LM?=
 =?us-ascii?Q?MzPChjbpFJ4vLEDaTO74uo+sVSfqhvVrXK6Am5pT/toEaZeH03pG461vh9OY?=
 =?us-ascii?Q?f+tBKB3Y/E44h83fFeYO6mVVQyCGUo75F13iWyjbeDN3rsPy/sYIQYz6GKFH?=
 =?us-ascii?Q?9/n04jeXMMy3GUcRCVXAAm4soBh1lFPsAx6Oz/XgbiqB6vD/hYh6cvAQaEva?=
 =?us-ascii?Q?1TkGhfAK/zurRWowrSoD0imuh6UN6is5UFkT5JJy9rG3tjg13huqalLovWQk?=
 =?us-ascii?Q?mlxida0aolkEeWV9TgqozKZ44AT+ILfL/+WQ+hO0ILr1g7B7kbJbcZ9aqrn8?=
 =?us-ascii?Q?uK99VTJb00r7yzsRD2DytQTaPrGWLg1ojsaT65BnVkW77qa9miHC27hhe0Nu?=
 =?us-ascii?Q?JdQfihoemwBwORpvC0HIDtA879v+9v/6rXpAO5hezJCzK5J8oWGlloVeJ/oI?=
 =?us-ascii?Q?VS2yJ52ULTepiKbN0OmJjkOyam0bmvvECRnZca4VZJzVwmqArCeD8yUAwCN6?=
 =?us-ascii?Q?L+QykfzPLsVfyghxSl8QvnkjtCKs/1x9opYATp8NWluCSWc0iZKm4jfh2lqi?=
 =?us-ascii?Q?MYpQ0MVEzXNVm/uVPBufeD3I3qRjtSzYJzAnova/3Umxunu3iBg4iYsti3aW?=
 =?us-ascii?Q?hRlyKUfQgSwyjYzQ+v5DEqwCsTjd0YzgnG746S91x8J9+djKsJl+kQzzWPmB?=
 =?us-ascii?Q?NaywWJTDNWB5HFeUQ4f62ImxgJu+Bwrw9o3nX+3REbyM1oee+tntqlt+bITf?=
 =?us-ascii?Q?QNYtMpPTbCPlFc4Yi/dNJKmk+oa/0hoZW2jpyqx69Ii0Mflr5x0ogv1P3WQn?=
 =?us-ascii?Q?bYN26rLGUVam+8CvO/YKT7EX8OS4jTZm5cm0ITnPN+IN0j7/FZZ4UwQuiS3x?=
 =?us-ascii?Q?CP+DMO3gJsOAEYAkH0fHNxV4BAx74c3XUNeooIvtEYUF62KIUvqwYIZTSxcK?=
 =?us-ascii?Q?EbTiDTdMULpUsVNnp1t9p+CM3lXTJaCSgvvP77YjYyX/KDgmfYH/2ui9j6/b?=
 =?us-ascii?Q?bCucR8hKNAfus5QUJn51/9ImsSXfn+bdnYoCuOcxa4CoPRFl7J9n/9USSqiy?=
 =?us-ascii?Q?pWBgzzLSy10JS79N8NTT44M1Vq51bn5YJm62VO4HIAn+WGXyc7B8D1EU+aQc?=
 =?us-ascii?Q?uXfNuQDNmg5jYmbTiQb8xcM+Cy13MUL4DiW69WhKefxTvdBbYPQ2/Y+evTUd?=
 =?us-ascii?Q?cNsCLbiW6CJTX/DNUw1rlSGt0h4tf8lrAE2Qnw/+td0c1SANTHnfuKl5akif?=
 =?us-ascii?Q?vK2ahcp1n9RRWl7DSSXDzRYBS+ZmpOWdHuEsFHPFRT8T0t2xELlFWmdzSTSA?=
 =?us-ascii?Q?ZvAMc1dRbfIx6ObkGp7YcaQxpkszN0m2CM8/yBptV2plpFv/qt6zfa4sPTuX?=
 =?us-ascii?Q?tjglhmsKrcjVtRVXWE0ygp+Nmh4e9Wj8em88qdN9MrCHB2JkPZ3UOR50mFBv?=
 =?us-ascii?Q?oLqRiZApjMFpmBhXTAKRLnAPDyFWES/IuRDPhZC1PyWFBsqC/uO11Uvv+HST?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PRWBctKNCxFg50IfB5DvUdS3fAVpxpeseB1L7B3F+UsJnMGFAy13nay8oNQC7MI4oeR2IEFlxtnIQ288jqx4XxPEpyuKHbSZdW+L6Mxp+V7vLFMUCVxhATTsPGuFJFRwGwluyduKhvAlMBW86sV49k3cBfk5yB5fZhDbVLDwyB8ulYEEr5gd7lS2FvoHsD9tC7mfBrK16jxhlTWuS4+ysDb01bTL06FVyQKHhydEnIecy2M7QyAFvcFqFTh3DzL8q2qA9G33rfmrPbCQvzofNgi4WmcpgxA+IsZ4ssYeSaBGWgXcYQlqGZgHdduzQRILo1+n1whNifOkttjzdvw/afalMXUyQLgqUA7b/4gwoL99mMJQocbW+ES9jI9U8mqsk16BMcNlI893lekDgpE+AIyIEAfurulJhCTkD2Z9vrCaWMT9MvXRSjlVYZ87zW+SFzZ3KHP0B8SbsGPCIojVQ7rUFPj43BCL9JoUeC7zz+7XZv5cnMu7S/gSC0ECvPlhQZT2NDfOe8I7TqICcYMBo45wEE4PUn6jjNhiEM+0FwWLaA/C5x3i/vqm2alAzaNxJSP1pPR/HyPwl28KJrMDIQI7XuJI1ouEV8PsV8NJQo97PX0tihElgwsvECOInIJsupyl9wcDlnLRlCxPdx77RpRa15WyfkQzjeq0D/0zriH60jfX8LqSpobz4ur/0oa5uG/LmTzls4m9qqM9SsVkVYIyfyroO9fmM6fmBb8bII88E6UvZvokiFFn+XgtRo5KJObCvek/KD4XWELyM4wRKu7BTtN/53jwIncTawZKDzD7QqGCw+D8YfyQ91RuWUxV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f192b67a-0c6a-431c-32ac-08dbf733e705
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:50:49.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1GnY24KnxzI749ucM03KMLySKaCDGyJttuhcIYlaCfqRcdcrrQ8eLxYh6aDrOJRPK7qkQPBftkHbiZcGjb4oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070122
X-Proofpoint-GUID: Qs4HolqCel4gKp5Id_C-1ZmsZslm88xU
X-Proofpoint-ORIG-GUID: Qs4HolqCel4gKp5Id_C-1ZmsZslm88xU

On Wed, Dec 06, 2023 at 04:33:26PM -0500, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> This patch series is re-work of the previous patch series that handles
> gss error for bad integrity. In this version, gssd is changed to use
> rpc_gss_seccreate() function in tirpc which exposes the gss errors to
> the caller. This functionality is further checked with configure for the
> presence of this function in the tirpc library.
> 
> Note that the current libtirpc (1.3.4 version) needs a fix to
> rpc_gss_seccreate() to work correctly for the gssd that passes in
> credentials to be used for the gss context establishement.
> 
> Olga Kornievskaia (6):
>   gssd: revert commit a5f3b7ccb01c
>   gssd: revert commit 513630d720bd
>   gssd: switch to using rpc_gss_seccreate()
>   gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
>   gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
>   configure: check for rpc_gss_seccreate
> 
>  aclocal/libtirpc.m4    |  5 +++++
>  utils/gssd/gssd_proc.c | 26 +++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)

The added error reporting is very nice. I'm glad we could make it
work.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

