Return-Path: <linux-nfs+bounces-1314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E14283B319
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 21:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0730288E9C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 20:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F7134733;
	Wed, 24 Jan 2024 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jzAvWNIM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eu9Mq9Qs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E235132C31
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128340; cv=fail; b=jPmcCSoDdzaHOTzDgCzUqBgCzYl1+cCQsGRfjpEsaP8SAqR+hudpXd6x9c2XOTWyA6eM8Meq2gibOY0ymzA8APNCTkf6PNt+rD7NOu0tl5WSxhKHulRI/g+D2slhT779igdKf5YboDrDjGRQUAMnxE8Tg8ybhv6GG4d60XTp5M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128340; c=relaxed/simple;
	bh=40OWmH8aQ0g0v2FfpthiJv1KaH+SPwRtioccjWNOFWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VA1lab6OB2fMQtbUpPl4m6zusPKxIG6NU1CFni4J+FsrpVuiSNFaRV89YRYfeEB9iykcMVQ03v96+aMm0S42VsN3O6x9I+Z7LkHx27y2yRXGIOQER9c7FFQ7bpbTmfzTwx0yZyH8ad72V99OBEDyPcm2tPAwbqakwdwqA4/4mvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jzAvWNIM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eu9Mq9Qs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OHE4w4029761;
	Wed, 24 Jan 2024 20:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Y1/Q0qxqS7HfiHhZPRGWSp+SQObkDwb8fgFv3DY1aYM=;
 b=jzAvWNIM3omhUAPxMQ06P/qkCxuL3yzRLnBkj2mP+3HGE4WOPyR9Zwl+/CpC6Qen92iK
 RuM8UXQbMGcQxPd5BR3dSV+ewc5KXGdkNiZXD8+cBlfeoXsSwdG3PWz/DnWiK59dTY6D
 KEG7kRAto+RSARwlxHzHLNjyDFzQzTVnkuOmBvlcsxfrg5znyEiFgix58D4g8+4nXNt8
 VFX4rzTGJ9tMPiyGYjZ9DR/yiM1mHr7+L5qDWbYJMfNLTjDE2bOiyBCPOV0th65WUQL6
 Qy5DZ0bL+LnV1Xl7xMsG8prLK5i6lPJOQJLVBKJ1dzyTpjWcYAYuwOB2kMh5do+Otrm0 /A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy4k5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 20:32:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OJxd9F026065;
	Wed, 24 Jan 2024 20:32:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs317seu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 20:32:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEcIdbNgfYeRdPGnnUvk0rximoZCEPrwrvjauev9LZj85oZqNnTUh1t6qGEM1cinVu2NmN1vXEPkHIQu3kbI9iK6FvYgxRG3OK78Kh19n8n48M6oAODjziSRCXBUliLRmfmmwNPMITfSLCfDVOm1D95QJRnJLdksWhq33MKjYXk4U77GmL7t7REaNfYm/VmWuuDi3hWjajUAZ3nU2+ll9bTyDU4Vw4owo5gkIbNndBfYD7DKj7jQpXeE/HQbkgN88MlVEkWaNtzL20ZNzS2BVA8tF2mYbhPG11lOCXXWxzY+8bUxM53+VD9b8b03i13YB6wD7n7Zl47DKDHMqjsI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1/Q0qxqS7HfiHhZPRGWSp+SQObkDwb8fgFv3DY1aYM=;
 b=TgjvE0Dgocj2tm1pk7zvQHXe+5JmpDwQc9n8jg424q+fKaUxScNCRv4wXBT1lb8IcCxmyoEkZRAi+M1PYlSxhVS6gLpJGat44H60eCida9ZoD4J3CLrz3HQ0ABYTUjYjtaWvoGqCoQtztUns7d3x1+yMBZXhRaPPF+/wMLoNQzEjBwWh1HABUyAenLBAd8SJgsFgagAsk2oK8nxZWxajEj04L6s6RVmKBwRNKlyOwtpBAvPdCbQlSw3fYY/o1mI3c14JBPvPpr1i7WYaGEl2eSDTCAeGdUcISZiuYkt/KR73VMtc0YLwAbiTFVlzcXOxM2C5rHfJgKc239PYVsFU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1/Q0qxqS7HfiHhZPRGWSp+SQObkDwb8fgFv3DY1aYM=;
 b=eu9Mq9QsVqid+4kfcVuyRA9UqQ8UhrITBOFJgw5jBeEvVLT6+19jpvGzicn9YS+jhZ3aF6DrbP+/tWC2Bv2b9veCH+KkHJVjVZC5VBOHmy1qCs0x6/O+lN2XaUnRoTzaPVuy85+wBksIozU7IMMnhcryAoYOkD+jYfwNgROt5f8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 20:32:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 20:32:10 +0000
Date: Wed, 24 Jan 2024 15:32:06 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-nfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Message-ID: <ZbFzxmV6zgi/TACb@tissot.1015granger.net>
References: <cover.1706124811.git.josef@toxicpanda.com>
 <71058c29683d44644aba8ab295fa028ee41365a8.1706124811.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71058c29683d44644aba8ab295fa028ee41365a8.1706124811.git.josef@toxicpanda.com>
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d96fbd-0c59-4219-4559-08dc1d1b8a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gAgJgBGOiLhG4UMTjZ5cjdRLDgzISFlJvsNpE9aG2xR+fc/gdR6eKZASJhRq02Dx+t5IY5S32/gVpd/qZFX8mPITQNpOF+aYzzLltl7Aui/32wwpZX3mTR+f2IAq/NcmkmAHqTVVZG7iHqw0ZpvQY9cWiQzavwGcJwSscAG6KZ0ykUzerQL7x+0XN1ZvI9rmK3d82TQNt7PGU06qyqyo4EYIoTpAP09cE6m+axvaUICWOvLgki5VJR+rlOYNJZBMjce6BMfjyNlVyvZjwB0yyak2xCJtbZNMMkcKEpSMTQ58f8gC1qjqq0gfNm5M5f+sMlqvqdaOyPlYe2cIm/EUBCL3A62l1e6xxlm/7BdADGfihYXM3OxOFC6YuKmbyAxC0MMOy+P+r8fex+Zk3OCRKxDjYzrTinSeg9yeg8kPuxD7GG62QN6+GQywnDMH9RTBroXif2XWCYUHFq+I0MSyhTj1jxyxeeWngR7EPelpvnhPFiiReW/vM3ghmdTKpqpfVhlOylx8GAUWos7TiWbF7XNgLL3fbxDaRkxEqiJgg2t3OkTo2ebYLUfqokQZIA3G
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8676002)(26005)(9686003)(6512007)(478600001)(38100700002)(66556008)(6916009)(316002)(66476007)(66946007)(8936002)(83380400001)(44832011)(4326008)(6506007)(6666004)(6486002)(5660300002)(2906002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MBWzm7FNjxluJZJJYENyETe78GTXG483C7t0RYzvYLWA8VpZisae2ruPVQ/q?=
 =?us-ascii?Q?iwDRpDc06CTD5tXlU17KZa/PRknAaV8vLA2Td7pDnrrsK3L9W8MVD+2A3F6/?=
 =?us-ascii?Q?Zh/EkoRAqyo3nn7uGJ3SywL/sCuGlgt2CJB/7ikOMhhPBE40s976L9y2xIKH?=
 =?us-ascii?Q?+wNijW6B8/KT9XwDoiUROgc5GaMT8X8T2ooIS/3yxqgZSqEkdvLlbEvUemCH?=
 =?us-ascii?Q?qdwFdDdLmZE601c5L89dNBCFx6Zgd4QD0Vb97i5Oahv7PxHFDlUNm7Pk/S1U?=
 =?us-ascii?Q?7dNaRSynX5deEnbNMeY9lj3TABBVkyRkE/YsY0dQl/ZbdiT/R9lMV1IrMd20?=
 =?us-ascii?Q?yf/A++fV060wMC4JJDqvS+ckVQV5aoXNCb+bpliY14ne5ohw6+jMPDkNKZqC?=
 =?us-ascii?Q?8EVG3T1STBF+X7LeIEOHbKireoy/OvS03Xafu6sggUjG+gJnCcccte4Kov1n?=
 =?us-ascii?Q?dFKXvrG4MmU9WUYVAz1j0mORJloiIm5VqNxkg1Bs+80bFOVnkxFy14o+NYih?=
 =?us-ascii?Q?E1MQZ9hpFpEVJJNJpR2RYszQ9//S7+vywL6rIrdS+3M7vzLDGyHE92S9gnX0?=
 =?us-ascii?Q?PVXX4eqaPQVWML9d6p64BRcJyBRuWG30uqWMElkPg0c/AdPdYqsYZqg92Z9P?=
 =?us-ascii?Q?6b3h1OYpZ9ZQv3faUwFLvxE0vhogDtzaLEEuYWLtsIsHNM8SIfEQmN85X3G1?=
 =?us-ascii?Q?2yQSGZ02Tq9GUnvZMNwIkcQfCnu6XFZiuxuGTzdSV6xIqeh2y+p69COCRCpJ?=
 =?us-ascii?Q?hzQj5dnrZm/w3rEdMEayay34wED+PYZcpneBXgm4Zlle/r+acb9Hl5V0h7tV?=
 =?us-ascii?Q?6Uw/1OClKqyw0nAY4w5TrKcw7A6CCblw/69FM2Td5H/GHxSM6e4pjITBXTdl?=
 =?us-ascii?Q?cIbtC2aRU1Abdh97gY8AOyaCHY/Q32Jw3x51O3q8k1MW4myWgzzYSIYAqbAP?=
 =?us-ascii?Q?6gZN2NLQIDMtf/nKPW3ahXBiZx1qQGFpIF5uT8fw8WkWTbMhsvXFhoEiBhWM?=
 =?us-ascii?Q?RlTQBHWT5+JuUTrIE5Z374AhYjd6AxCTw/KV298eck6A2Emg4TVE1kMJnX7t?=
 =?us-ascii?Q?7SXzPFCFUL1RFY1WQrdcKdCJy9GF1XXrFI5Irgv2eq8hYPApP9c6QR3baJZe?=
 =?us-ascii?Q?d42xmjMYmO2563Su+O7kBKFKZ7hJZnCdla6Q8ebXDsyQ67OGxh6em5LyLr/p?=
 =?us-ascii?Q?oykzbcwkmEb4xhS6TNMhaZ2pTzGs/YqFuEz89XbogRXRxdb5dS3ufuoRhSS1?=
 =?us-ascii?Q?Y3AON8Yy+JB26QB4494oLQ0cFd0R3F7phLD5chG+onpKlMIPLBOw84umGRib?=
 =?us-ascii?Q?xBmmPj4gEQq53vey0PBDtm9G+rb8KMyFvlcw8QDbh6u2ht5SDGbTu3allDtO?=
 =?us-ascii?Q?BpCNjtPz7noLBoJoXDPzJrDRf5bRYHTGNAyreHpQtotxZ+FBC2ro3NO//OwJ?=
 =?us-ascii?Q?6Y1cbGk0mWGA0QL1mV979D/emPnyk7j520GgFohyYsB3wy0CcmYqxZ/M6Qtc?=
 =?us-ascii?Q?qVgt3du+Gifj05p8SWaiwE4Rd0LhEezOwl6MfHN6RE9qnfKNjnUwfuiPd/vP?=
 =?us-ascii?Q?TiLChTzc22FfMhCM+kB2wVi9zqMGJgSvDLJ0dLXY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	x0vqrFdCHLQnIqTQu9HadVRyaanBWKhSb+j7gxmq8Zx5v1GLJuw4hH9IsJ7K9HfVGbJEEu2oesjmONG8Gb4CPGp7eaDEyf9zTquc/M53de1yZVSDSB3wquKtbrfd6AVSEYWvp/iE0DF9vsZdieKJQ/8PbzahDdkCI9BOtVVKLfqk87ZlW/bBUM5EnJr/2OzyIXIjVhDgQJSNQ4Gf79bsTtovMQ32f8x5IPll7J6XFwC1umQaxEtDW4z6lOS3hzDL3YwyYJbuxdXeOJzLkKP4br9HGE4/uojSInCMoBTw4zsFZvw3xmj3FsrNzL6Xha+pSX6LXLZbBW93/DGfQPc8KVjtCfhnN0N7dRzxlxCJmPu1KG89G0u95OX2RX6G0mpiQPhPUN3W520B34c20Lw4iUQeBmRq5JQEU1PxlmIUl3hGwxNEYSlCrXn8oRWMZNtgDrLUdtzaLO+oYpPPZuqge4tQAeZvCLiOp3SH2LsBCzFpLVvdfzxJYvxBOEIjMTx52TcOOwWPHMVDdafCSWY1SVkgQ/l7XwgDduVfsooHCpcRItA5BnCTdJZdBnWCIFeLPxntBdSmlPcSClm7bAVHM8ML6Z2I6y4NE7sHAvFxqeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d96fbd-0c59-4219-4559-08dc1d1b8a6a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 20:32:10.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qH4GQqXUElnJ8oU0Y5JXXtEPDsuH5KEaYgGHUustTMb8O/H3zklsCOARZoCTdqC8yWIwNOGSIr79jfaPCtu5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_09,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240148
X-Proofpoint-ORIG-GUID: 4WZ9h0ClakJE4hImF71lNCqSNZlO8NnV
X-Proofpoint-GUID: 4WZ9h0ClakJE4hImF71lNCqSNZlO8NnV

On Wed, Jan 24, 2024 at 02:37:00PM -0500, Josef Bacik wrote:
> We are running nfsd servers inside of containers with their own network
> namespace, and we want to monitor these services using the stats found
> in /proc.  However these are not exposed in the proc inside of the
> container, so we have to bind mount the host /proc into our containers
> to get at this information.
> 
> Separate out the stat counters init and the proc registration, and move
> the proc registration into the pernet operations entry and exit points
> so that these stats can be exposed inside of network namespaces.

Maybe I missed something, but this looks like it exposes the global
stat counters to all net namespaces...? Is that an information leak?
As an administrator I might be surprised by that behavior.

Seems like this patch needs to make nfsdstats and nfsd_svcstats into
per-namespace objects as well.


> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/nfsd/nfsctl.c |  8 +++++---
>  fs/nfsd/stats.c  | 21 ++++++---------------
>  fs/nfsd/stats.h  |  6 ++++--
>  3 files changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f206ca32e7f5..b57480b50e35 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1679,6 +1679,7 @@ static __net_init int nfsd_net_init(struct net *net)
>  	nfsd4_init_leases_net(nn);
>  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>  	seqlock_init(&nn->writeverf_lock);
> +	nfsd_proc_stat_init(net);
>  
>  	return 0;
>  
> @@ -1699,6 +1700,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
>  {
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
> +	nfsd_proc_stat_shutdown(net);
>  	nfsd_net_reply_cache_destroy(nn);
>  	nfsd_idmap_shutdown(net);
>  	nfsd_export_shutdown(net);
> @@ -1722,7 +1724,7 @@ static int __init init_nfsd(void)
>  	retval = nfsd4_init_pnfs();
>  	if (retval)
>  		goto out_free_slabs;
> -	retval = nfsd_stat_init();	/* Statistics */
> +	retval = nfsd_stat_counters_init();	/* Statistics */
>  	if (retval)
>  		goto out_free_pnfs;
>  	retval = nfsd_drc_slab_create();
> @@ -1762,7 +1764,7 @@ static int __init init_nfsd(void)
>  	nfsd_lockd_shutdown();
>  	nfsd_drc_slab_free();
>  out_free_stat:
> -	nfsd_stat_shutdown();
> +	nfsd_stat_counters_destroy();
>  out_free_pnfs:
>  	nfsd4_exit_pnfs();
>  out_free_slabs:
> @@ -1780,7 +1782,7 @@ static void __exit exit_nfsd(void)
>  	nfsd_drc_slab_free();
>  	remove_proc_entry("fs/nfs/exports", NULL);
>  	remove_proc_entry("fs/nfs", NULL);
> -	nfsd_stat_shutdown();
> +	nfsd_stat_counters_destroy();
>  	nfsd_lockd_shutdown();
>  	nfsd4_free_slabs();
>  	nfsd4_exit_pnfs();
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index 12d79f5d4eb1..394a65a33942 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -108,31 +108,22 @@ void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
>  		percpu_counter_destroy(&counters[i]);
>  }
>  
> -static int nfsd_stat_counters_init(void)
> +int nfsd_stat_counters_init(void)
>  {
>  	return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
>  }
>  
> -static void nfsd_stat_counters_destroy(void)
> +void nfsd_stat_counters_destroy(void)
>  {
>  	nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
>  }
>  
> -int nfsd_stat_init(void)
> +void nfsd_proc_stat_init(struct net *net)
>  {
> -	int err;
> -
> -	err = nfsd_stat_counters_init();
> -	if (err)
> -		return err;
> -
> -	svc_proc_register(&init_net, &nfsd_svcstats, &nfsd_proc_ops);
> -
> -	return 0;
> +	svc_proc_register(net, &nfsd_svcstats, &nfsd_proc_ops);
>  }
>  
> -void nfsd_stat_shutdown(void)
> +void nfsd_proc_stat_shutdown(struct net *net)
>  {
> -	nfsd_stat_counters_destroy();
> -	svc_proc_unregister(&init_net, "nfsd");
> +	svc_proc_unregister(net, "nfsd");
>  }
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index 14f50c660b61..5cd6517b52a9 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -40,8 +40,10 @@ extern struct svc_stat		nfsd_svcstats;
>  int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
>  void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
>  void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
> -int nfsd_stat_init(void);
> -void nfsd_stat_shutdown(void);
> +int nfsd_stat_counters_init(void);
> +void nfsd_stat_counters_destroy(void);
> +void nfsd_proc_stat_init(struct net *net);
> +void nfsd_proc_stat_shutdown(struct net *net);
>  
>  static inline void nfsd_stats_rc_hits_inc(void)
>  {
> -- 
> 2.43.0
> 
> 

-- 
Chuck Lever

