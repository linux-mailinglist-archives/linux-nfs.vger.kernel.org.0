Return-Path: <linux-nfs+bounces-1991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243C857DC6
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 14:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE50FB2122F
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F378694;
	Fri, 16 Feb 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b5+PObOT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YfTr735b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B237129A89
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090615; cv=fail; b=lwCHzPO9/q/PKCxRDzRg1bfFJhlNJIYrHeEy3SL3bFWFl5vcHLNa0sI4FSszqAgMEdCP4+6I0Q2D5TcC2FB5vXYCvn4COTkiMaC0tccCrRQgeS2zuGlnb9YhJw9VG0JNwqsOhZMneAsfoyapFsM3dbhGJttKKHdRktJ/JE8keuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090615; c=relaxed/simple;
	bh=cD0iDdLFKf6dUug2W2iNabSbTiQk1PGQrMR7lnATAJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pfJjzwq6fUXmPeVJ6FqxngPuw8PhnmGxcI0hO9gkXsoLfO60l7YbkvDq/zvYynxnAD+y6NE3aDhrqqMSbhTvdaAvQYZt/369AFyMbtzmMukmCpkCWeKp/faqZAI2q/7OFDuq3mtBieDkGLjxzhs8uLVJsSH4rYuGj8Yi+KPedjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b5+PObOT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YfTr735b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCrqiU015652;
	Fri, 16 Feb 2024 13:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=xiFIqjRHXGFl8OnWjnuUhFGNuKLkEnjHLU/RbWIr4LI=;
 b=b5+PObOTV1t6MzO9Spl2GacUO2FvgYBcCZkHy/sBqOgJHwuYWvFLqKbQICddCkn5vTk2
 TWuv3OI9meVRhxNqbjeULfBaZDPrJMv2fDfxn2VJuJaZ/GgCoMK7p2kU1+gOUg6UoRuX
 QpEQj2lTPVoIV98hj8MV/9E72ecaSUTvGFWX+ftLC3JQnr/fjgzYJRDDlQu2CC8IF+AP
 tU8NvpcJlaTT5+0kH3xocyXjiktbfDnRSgG5XxNrdJVqh+A+hv62CmqjyYNVqtpPlM5+
 rBMKB9ITvOoPLsupIuVHAqv/X+jmFXkBMdC4XkW8hUtDVbeWMc1idLzooQm8LXIuprwY hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db53su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 13:36:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCkw5H031497;
	Fri, 16 Feb 2024 13:36:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykc4ssa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 13:36:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buWmJo/+BqAsZCigmIKANQ0Rij4VSaPAy0sDG+Go8I/S3MJD6FUIXp70RbnRPFHH3aVIxfsoSjdrPuQutzI9Tbvdapj1xmZAZP7k8F0YpLD5KO0AMaNATQF+CWovGRSZUVx7rF3j6kvBl95PdvsBLypXQGoOHchHNHQFNqMKGzlkHlhH1uZ7pgUvxvklqFW3nbHQcHiMYHnZNLPNvd3cZr1oqASnChKBDe23viBAuvSht+js+xtT++BMB6o2DTCpAzXcAK+LgzyacTexyodBuqC16ai8SwQ8H1KiqzJbFZxQuE78YyeMNC5LiZeZxU+Q4ftU5APDF0HnANw05aiy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiFIqjRHXGFl8OnWjnuUhFGNuKLkEnjHLU/RbWIr4LI=;
 b=H/Tgmj/Mb9XFxtik6VkwFyVZvZdjiLN6TNxepZZtI2EdJ1/goxkjAZXk4Zde2aTK2gyarW/4c19KZESY+OFd6RR0hYKOMZXSDLicNdJFHHWRDQrlIMGZDKXTewp9MMUzq2jDPX1wrANCRiXARCeVCWoLvN5NZY9+HX19dlqltTLowc+n0SEI2+geG60dA2KPZyrfENNsL7+4aBflLlQkrv+w7Rqrkl424+56+wAmqdpS12HyNPiuxpZpLikiBok0XJ/R437P9I9sh1oYm2YqduDoe8eIxgkVWzaDW94Kol3naLcrgwbm6nOe0T8026WPQpU48iA5RBKohVbUQrtQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiFIqjRHXGFl8OnWjnuUhFGNuKLkEnjHLU/RbWIr4LI=;
 b=YfTr735b6gfhrZYifdL+QL4Zpa0jdHbXOWxKeCgNvt2n2ItbGzs8Wzn8WLvHQ5WfEvKnEOjsIRFJhl2W+WFzOCSTscd7vcEkMSjWgfN6TfQaflCYnrCgTMmFrwjWBpSQRPIktx/kozKuAnCcuOFIsvOAZoTgAVKUsgfnIx/OGwU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 13:36:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 13:36:46 +0000
Date: Fri, 16 Feb 2024 08:36:43 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: PATCH [v3 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict
 with write delegation
Message-ID: <Zc9k61io6bzOxPqQ@tissot.1015granger.net>
References: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:610:4f::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc92aaa-32ba-405d-dbbd-08dc2ef45216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Tm+uLaJNBbQ/fAQhurtn7z/ieP3X3oiZ3QR6NGppjF3Qh2xtkS0qrzXU8a/Aq0RR82TcS5BoMFGnDwyI9Yqg3fTOL665Gg6J4exWNwD/+s3H80FzZVeMyuRRNxH4i3esZ2DSdUaUNxZe2k4SpU/vgFDs4LBfNfb+gbqJbSPoHR8hJCH+f/xo1nZIXnNLQpaZtS0lMwmp2icfY02Md5etft1fH+kHn6F2svAE+cPcduh2EiqeDoNQSSYTnPgEjq9A3sKLoNKLZV2hX6YNqjY2XyS2cC+rjwYbH3mIBkZwmQw/uNNenx4cTZd/xPNNA5Mz03uzD8L62ryoqSDrUWWs/ZI9Fc4Yje0+VsFBifMKb8ekoggGJr+H5dSDLLTi9IqjUoF/KRkeLAPn5zsmoao+gLQ4e82fhdUrYT35sLp/a4LVp451ZX56EIbuEMHilKLSw3oA6GmVvwBMj7GL86YuOtefQZCSwWzeyC9i5NOx2UXBA0UeXbEnBRyMMD6YFwoiPtmx8S5Rra2c3Jvwz/iFO9I0vegc5zgvNdLmW49A+t5Nu/62alKH5MjrC8nGSOJV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(83380400001)(41300700001)(478600001)(9686003)(6486002)(6506007)(6666004)(316002)(6636002)(6512007)(5660300002)(44832011)(2906002)(66556008)(66476007)(66946007)(8676002)(6862004)(8936002)(4326008)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pIwQO22SLGjxSsx+SfwZXifFSoOBH/URGYXFeAW9xQQlXU6AbDlLvYbX89Ox?=
 =?us-ascii?Q?Hm3TQCh8xdxe8dDuYfRUkMmOsk6nDxY1s5vcl2jKoSxXkmbtG8BHPKFpUmpL?=
 =?us-ascii?Q?WNiM+tOiJXVdI+jN2CzocRDooFwkfJhkutt1G8kjtV5BGTDDy4qMkdVZlyou?=
 =?us-ascii?Q?1VRJg5+TfISfZmaSbl6yShYPRv1ypHIrrJLabS0PP5QdyrUAp1l3BMzjjBCa?=
 =?us-ascii?Q?AzY2rViRUqXcz5sRhMaUU6eaGp5epv9mLtGG6GK/PPQMSbPNCPqs8iNJWyA1?=
 =?us-ascii?Q?5f/6Bu5WOOQfLzfSTFpRGVpi2T0eiyG7CUuqCXOGVRsiUniCZkJUOPClvPAh?=
 =?us-ascii?Q?iBI+TeB0IIYgHbn4JPU74puIc3I64PloGXgKcRjdKlvFiEncD8XUvMHoMHd8?=
 =?us-ascii?Q?Vios1eKbDI8YRSGTlZ44zhIXN6vPreyhVchmuIQALgiUxi3DA9+32qF2mrR2?=
 =?us-ascii?Q?UZbBdGByiuBs7qqQLsMVQ8aaoqMP2Jw2krt3LRP3ijvbVPp726Z5JH8r/A4I?=
 =?us-ascii?Q?ufzdHQVX85QxPgPjjJ68eLUqI+mui4trpLcGj0Hd3pvz2002WRBAVHw/QXXJ?=
 =?us-ascii?Q?UGr/CnL6fjYSIA9ItQ/sHlA0SzIeYIKWujC+tZuv4iEofMz/fmm0WzJV7Na2?=
 =?us-ascii?Q?iQDeRHOdoWcJ4+NwqS+lRd3S6b6HfuGk6DLlIuP8kEScuSqu8qPCesgvlWL7?=
 =?us-ascii?Q?cly8IhiWtQkXQuU8cJnR3tnXrfN/R8za+9JoTjhP22Sm9Mb7g9WTOveSfvPY?=
 =?us-ascii?Q?U5wJC5RNsAXXK1t/2bv5DqItW/mDWSV/LSV5q0TfdTIKKLreSclDt7ElZi4R?=
 =?us-ascii?Q?6uRtmWfCjEpwuDFirNqwKpOav5KIGeK1nY5nEo+D/+Updqc5HFejdtijkokC?=
 =?us-ascii?Q?dwau1PpATxC73NIGyMmZy91fBIYUy/9ORgjIO6o0fgKdgdw5WwNPNMKHlFQo?=
 =?us-ascii?Q?QnebMqbnLvFcTaeYDZ1/X30kJYKChI5jOqCRI0fcfxiBtbKUMqZX3S/m2u4O?=
 =?us-ascii?Q?QFL78mAKgt7G8UTlcaHY29UWjoURCNSC7VL2beYS3PkKTvAydNQ99Sxi8ts9?=
 =?us-ascii?Q?SUOCdkOtur0OHJrciAjylF0RtsN3sHPt62yG6Xxslw3t5RW2YRacszkPgSEi?=
 =?us-ascii?Q?Rj4xDVrGanzt/KRpwj/B3Uh8KJqLa8zsw9OyykikEh5RTJyGX8qCOdlW9xhw?=
 =?us-ascii?Q?GH6mNAOH4D8vz70R+VHldDqW6N8ncOjQralcc4TjSBggKYo6r2SYljgLIib9?=
 =?us-ascii?Q?BXx5oRjx9qs6HsbFCn3A7LFKnpxe3HI+FdeGtkWZ00/XvIhLwuY2+sf0Yhd7?=
 =?us-ascii?Q?dBlI4dZ8Q3jIBqd9UX633G24p9rg2MVnnhDbjtMxKqjwEsq1kkVrFMMb3f2N?=
 =?us-ascii?Q?+s/pwoFKt9DudyxDVtURLoHYc3EHgDOVpl62CNr2dpgw+LRCGDY6VCVw+0CT?=
 =?us-ascii?Q?q/Qbn9iMAqKEd3x1LEXsoiBqAPHKOLL9u+hj7zkTBXoqs143wKeNwq0kVv/m?=
 =?us-ascii?Q?vZRwPPMtmM0HLOU3azK8FdSPCMtbcwlXjeXlMakqry/32uriD3q7KLzsX0zC?=
 =?us-ascii?Q?kQXX59EyerESLHCzdsfrZ96S96xdbdJtmjDRbxnb1148+c7+6YOypMzZKf6C?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0YvffH9ahkPIgqULBIg/lDC1GxBWSTXbA4yala7esQAzfM9Ibkn3OkmeygAlkY/zpoq7pgKk2YX4ULT/Uu+dURWEHiAaxM6mRsptWXREwWXN8/8sst2iPWas1p228zVmI5dGC5ar7SH4JzThIFKOy+3nTuQLDese5nSlvdHd2zMHhQvCOllYoYmUNkmkDHonSdOHVrN8Kx8mG/7QkqbghjjiI0tLvr5OXeXF1s1xWSuPxtKRFRBBJOUssbPPUn9QUIozkqU1sjJ02PF0RQGk+YlEp7GZJ6oZ44vlGZ6sBqAvu9jg5JpyIx5Njx7mCZw5OZlUpwO+TyrPEFMEgio8jcQIyCf3Ng8wIByC5nefpaRnP5onuiyVC+QNlJMcjfcavL4jsCtVG47AudnzbYXnL8hNGQyarNjuqyaF4UZwO1x5ok5lLucyBWIwHYwkIkE9V58SmW61ehOvRckUHsd/x7RmrNQgeEqUW1aq9L7MFk3APjcW63FwPQNMnTLwRH1PQlU8cq11/7/RhLeAClbNd0gosYsB4OQ5bIJSQ2xt5PbKIcvzqg6txg8kQCqYv5jyL5DUWNckVexatchfZfVvhDFfTsAsGXLxX9UI/2PJjdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc92aaa-32ba-405d-dbbd-08dc2ef45216
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 13:36:46.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8b3kw7pkWF5LuWXInpbbIa+7+0WnM4qJSqiDvb2ve8yldfgSxe56hp2P+aEKrd9OHGn4qfua56dhpydMdorSDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_11,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=992 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160109
X-Proofpoint-GUID: Gry6V851AnLlOj2NQViyVCR5DMDA8CjM
X-Proofpoint-ORIG-GUID: Gry6V851AnLlOj2NQViyVCR5DMDA8CjM

On Thu, Feb 15, 2024 at 02:05:20PM -0800, Dai Ngo wrote:
> Currently GETATTR conflict with a write delegation is handled by
> recalling the delegation before replying to the GETATTR.
> 
> This patch series add supports for CB_GETATTR callback to get the latest
> change_info and size information of the file from the client that holds
> the delegation to reply to the GETATTR from the second client.
> 
> NOTE: this patch series is mostly the same as the previous patches which
> were backed out when un unrelated problem of NFSD server hang on reboot
> was reported.
> 
> The only difference is the wait_on_bit() in nfsd4_deleg_getattr_conflict was
> replaced with wait_on_bit_timeout() with 30ms timeout to avoid a potential
> DOS attack by exhausting NFSD kernel threads with GETATTR conflicts.
> 
> v2:
>   . update comments in nfsd4_deleg_getattr_conflict
> 
> v3:
>   . rebase with nfsd-next
> 
>  fs/nfsd/nfs4callback.c |  97 ++++++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfs4state.c    | 115 ++++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4xdr.c      |  10 +++-
>  fs/nfsd/nfsd.h         |   1 +
>  fs/nfsd/state.h        |  24 ++++++++-
>  fs/nfsd/xdr4cb.h       |  18 +++++++
>  6 files changed, 251 insertions(+), 14 deletions(-)
> 

Applied to nfsd-next. Thanks for your efforts!

-- 
Chuck Lever

