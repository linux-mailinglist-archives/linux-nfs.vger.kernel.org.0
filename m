Return-Path: <linux-nfs+bounces-1790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399E849DFF
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 16:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6081F263A6
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1164F39ADE;
	Mon,  5 Feb 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RMYFgDGV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I0y9nRfI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6736B0E
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146695; cv=fail; b=YyVp32pYOD5CnbSPV45VS8aiQTGDN1MliSe36pl9zq1LjnXtDDlO1hLCuY2MvJCjMkpKit89D5i60eWmygf2UHR4uwq5uBHHPfTL98E2jlNNoCuMY1rgebSw30V0KNoNvHSnVgg0wYQujwiZjiv9THLpy84aEWAPhi6LNmboWOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146695; c=relaxed/simple;
	bh=CD0DAeOYuRxqyw3Mtu+FZFlmpccKzfIrwofptO3cX2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JDdmG8TghrlQFIiC1jalMluHTsJaY4uaylarOASwZPk3Eo/37HiItcBJdXRGv+5vGPyvpzi1SaapvNESfdi+jolXARdrCDrOlBZ/dzMMh3BKz4kh+Bnkkfhqo25xmjNI2cc7IxsgSXcrV7Sqpc7WddLKYfn1zK0W9fNT9D+y6kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RMYFgDGV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I0y9nRfI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415DWFH9001416;
	Mon, 5 Feb 2024 15:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=5NbMV2pbXO1Z9c7q7ZUYxrEH5FMeoeQG35rEpdVhQUo=;
 b=RMYFgDGVJ1oCUtN7Qi14p+FPKpqIuTYyphsTjLIT1V5LCc5dZ3cyMLYVNqmyjxABvPTR
 FkEAD6zbP0eViy9etKkF/zFlLo5hOzbvuVtir3H2oG62+L5eRtroIixdyzs8yt/rH1Yd
 q7pxQvjq9ttj6cDjhzMBttU6hfvupJaC0tqMHKDfey68SI/iftCjM7I5UeKY1y92/EOr
 A8ScdDbV1bP3ERQZQEDG8re++Fj8jlLceMhi21SlNGgJnFNk5sjakFWiJkxs3mVqoOPG
 l2mDR+ANwiyPVEsH8ucm51Bjv1lyaxfWgPwLKzpeqQA1IxQJrezSyV1fl/oyJz2Tgzb/ uQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c93v9xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 15:24:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415ET0mh038386;
	Mon, 5 Feb 2024 15:24:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5mb6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 15:24:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npXsEkAGrCMhBe3sLSmIvFRmQh90EPscYOsNPUjm35HpzKyihXB8XQhx8qYXSnprs4XRxZZsQOIflO6HC3tCG63yoRGC/diEslhktqlbTFtlfYlAffiQu+ACZXHKxlladkPMnHGuEHrxTKdkck/5XxczrHaFXJUtdEYxfzfgx7MixsH5K2/rxJcIhRDkAASHGrZqs/uVNEGC+0TySKM6iKoChHxvPPGinf1cwK1joz/694KbHeAuqFrmRGQm7oKkofHwv6U12zQBWiKxAUV69bRRgW0Fs5NAEBV3/vMmOcn7LR2ao5MfA5OxiepGNEbi0+UEA8E2XcPtuzyg/MfbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NbMV2pbXO1Z9c7q7ZUYxrEH5FMeoeQG35rEpdVhQUo=;
 b=m+ZeqXycB2zaMGPbt7SD/C8ut+VmeFnRfcoZFMP6Dd9L1BhkBB2PMkQFaCjcMJMSDp0EbKJt0S19Esw3RQmvONNF10OHbcDUIThQd7uDQDnsC3Wc4oR2OFrpZXZyYvGer4ISMn2kjMpM9dlo0/UqRByLGf4AWxCuWe0i7nn7/jYZdcF6RMYJCIqiyElM4e+FNRGAV92Axxsu6hYgyMw/iXb5yPEQOlmm+p44NF2CrHZjuqpxdSpnsD8zln+3sShxXsZDFdrSydPaGpRgqBeB9OZrF1b1jWWKNFQnelcDEGxVibOtm1Ad2dwV0+TQg1kgQQlQ0tWmyJnxrKIqQGQ7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NbMV2pbXO1Z9c7q7ZUYxrEH5FMeoeQG35rEpdVhQUo=;
 b=I0y9nRfIv2AFetpF9QOuhFyhl83dT4tDOD4xhkj/d6tIOls4bjmFsg/VSkiqsHtOM2/w/cPzMABXSpvsq/MVWVl9Q2UfNZqbBNn3RjcfOl6JXOnPACDdkveMKw43A4XIMB59vNgHfBjQqH0lds6MBWHkW3tlqfmB31/LQ2CoZa4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7715.namprd10.prod.outlook.com (2603:10b6:610:1bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 15:24:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 15:24:41 +0000
Date: Mon, 5 Feb 2024 10:24:38 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't take fi_lock in nfsd_break_deleg_cb()
Message-ID: <ZcD9tiK5FDcOH0P+@tissot.1015granger.net>
References: <170709975922.13976.3341850918979137018@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170709975922.13976.3341850918979137018@noble.neil.brown.name>
X-ClientProxiedBy: CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d6b9c5-ba29-4b17-3a9f-08dc265e9301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/joV+INxm9vMJElbDJc4IAY0Fc25++KxKnkb0mLvUTIDUnLvJWVH4//e7TyXEWn/jtyGk3NbnXjTY7Zuzf8WHDFBu67GoZOZc9cM0qcAIws7SxT2Do6krzTKgrYfLFkjQLNNktxsGBunwFfVPbHKbjn+O59+s4btVIAAq8AI6izRwDJnm+tG484BluU8rL3E0a8VnL4+Zq11dNiLKQtdd5RMaY90ZTz9UhgKapFeSJyOOF0VKyhORKYXKV59Wws3L6vexWXYiHC55RbTupT7XlxcssPW1I7+JUhhAGKnQeT+cNwlB/N2fPtXIlzHcaAeHPCRbiIBEIWpIGfjN4lpV6ajv+TWwhnSC9bReR+qqrERRa2Cq4cXeY80F2lmTIvR4rJKnODTNw/X+2tAbqW/vJsc0f+yA0ghP0+/Qb5Bf/RKX2eRj7U3czmMQfaiFYrnpHH263iAJM3b+Lx77MxIt1jsJwzSD9zn3NcKsJ/vs4LSSsgAtYjUk1Ggq9U7THDE5lIi5z6BrmRTnUtq6Bp1OAYdbfvdDZ786tFvEz8f4uVg8RqUAawfuweO1Ye2uuOt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(6506007)(6666004)(83380400001)(26005)(86362001)(41300700001)(4326008)(8676002)(8936002)(6512007)(9686003)(2906002)(6486002)(478600001)(5660300002)(54906003)(66476007)(316002)(66946007)(66556008)(6916009)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?67NXWZ3eerBg0oBnLsq1pUyGza3WSvGN/YS/PBP2Za5SevHFroSNSDA1e/zj?=
 =?us-ascii?Q?sfCEUkNjnr7ZUaDvH129KWpo5qyhEvI0SImmMTds76yGwmhzPXgioWae3Hb0?=
 =?us-ascii?Q?OLJt3gGkgDiUiZ4RIeL02/yfLgXAAxW3O/MxVd8iWayRxRBbCbJCHgQ197zR?=
 =?us-ascii?Q?KfTVyQkzA/fYb7P8gmgsg7QAAAAxSqI9qPLkdBUV21SbpdO7Q4o2bzXT1CJO?=
 =?us-ascii?Q?EY7GRKUzLMCeS7ZlCHmf+IoL6AZPfrS7its6yZzuvnWOb/zgsv2hxgwUzVMU?=
 =?us-ascii?Q?xXdqxAFQtvRtuX5l0oeVV0t6gryloMf9RbsB4gtX+9H7U2nTG5efG/Tw4p07?=
 =?us-ascii?Q?BxAMIzcblo1gTw1OyLtr8jmVwDE7XDxoMHIIuA+5zHA9qXTDeuHRWJ6s42BR?=
 =?us-ascii?Q?dIPKoYiIG3vO5J8R6kEfgVKKeHuNON9zeMGQKOPlQpkFwJuT/gAXAGIlvo3x?=
 =?us-ascii?Q?ryVVey6RENbq9UEM0qsUPaLLNecEF4+rMCJxsSt067sg7//kvg94NqazhqL+?=
 =?us-ascii?Q?Q/Is6SYAIMPNorsl7W/Zr9nYjU/TdkaflLHwL8U7otNtmaqd1aZ3Fyjs/m6s?=
 =?us-ascii?Q?T65GfGjZTmTu3v6jmPidTdKYM+cyCK5jF0Uy/2AHs6/yQs4ZT7vajc6+JxAG?=
 =?us-ascii?Q?HnLaFxvxQbxS16hCON7v+XDmS24xefDMRXGlUvAkjCvF077sRh+BilgrU2gL?=
 =?us-ascii?Q?1g5plTFW7Yqf/qLHxEJHvkxRPrvvPvFNYXJMxbO7RUuReXkaeaykyw6X4sz8?=
 =?us-ascii?Q?442vuTI7uzlAuxtXs1jHFOdPXNbTRF7FG/9K8K+gvPb5LIqBblO6l5zxrNVU?=
 =?us-ascii?Q?+kvU+NeM1dVKugZYqAEzt7V2s2ztRAp//kWPX7JnW3InvdWSY06RtuQ31/Se?=
 =?us-ascii?Q?XMRbCwYeOtrjMiXUa37fVf+g/CDg+YWEeSP9vdTEbqzy2W5AM4fH/eAySF5q?=
 =?us-ascii?Q?20Xs56NzeWD8X7LZ/QRP7XJNrJjAwAv8o7cGBiT5v6Yg6qL+XYjeALut6mKg?=
 =?us-ascii?Q?ZuWk2AxViV3JbDvvBPSKxX4/LbrTmCe2j9kVzip44Ry2yyhKZL55xpNgCoyk?=
 =?us-ascii?Q?sdFxq9zR8w8KHjIIGk7Qjntl8ExYz8zhw1c0TA+inpLqbRCvBHah58IPgYlh?=
 =?us-ascii?Q?NXSnOLcMLr1Bpcp+lPYmf3m61Mvwirt4hwHwdY43iCvvkvnKUkmyOrkcwUIH?=
 =?us-ascii?Q?gnAZn5N/kuqVowbJOHPagQxfetL0Gjw9vBR0o6U+jCjJugs2SkAPWZkwVCKT?=
 =?us-ascii?Q?nC5ZlH2uWQbNwf4ptikgXrNghwW/VPzogLYUcl556pjEg8FcVkzLFdbuR85S?=
 =?us-ascii?Q?WOQLzsmHjWHwe2k0hmqfBcSiFpyEPSmvzjN+HLs96HgTWneVQa164ZIuYPsb?=
 =?us-ascii?Q?6zB2Z+CaIFDzovVUcIh2+L71ioEN3EvXTNH0mK8C6rMzxSLPU7jpYr4/ZL/C?=
 =?us-ascii?Q?ALEXVYf0OmmO3tTwJoXwLfg+BmsT5fhQdUbBQrrmep79k4NZbksdtr8WFT8R?=
 =?us-ascii?Q?dsZg0RqldH4b+jEUik4y9j+tTycDK+I8OvbNrnPc/DtYwprPbvVOPyXQt3dY?=
 =?us-ascii?Q?IYWG2uB6NJORuRShBN28kqmBI3kymVIpP6yBFpIHbK70tHRagNhhAObnXXPE?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	820g6u/lVAUGLGSGJ9H99LBvJRkH5HAMrkyFg+YyVO109j1991sWv5eNNTYGMUXW89dICdYsF0RthL7SJpJKWx43x01oP2HhCcA5EwPOolKluqhMmjqzkc5q5SiKpOgU8uHlFId9Sowt177YUchcH/r1mLqABL3jlvnmxpC9gnhv62S6gFjeDMUcvdeMxZyDjgfIut6oVqO1aX21jMvHMZcSAxhrLCaSNoHBBaVldbpYA4rDgMUMomkrBDV3sTFb1H9Oevw9IpGgXRxSmcf2KD+HJyeZ956Otiy5YE7WQKZiQ9xX6XO4FFjYd9rWpibbumLJGzpwtiOV253xHmW376CH+sqQl+Jz3cMeqMUHYlOV8bm8InyjjyjGz+Gz4OTDsM5qdTncN3rQdY2zcHnoTv23dhCUCWGALrh59aD9M/AH8eXXNJqW2kQ2Coj2RUtBg311naIKuT1kbV3SG0vSwe1k4SgVsToJDs3nqIiY2/U7erKtj/yhWm/43N48phyaJiD4xDga7K4rGMZED8/97cgMxKFR9oLfSGNVx5sQL5V1mu/66Kvjk/JuWrctFQaxYRO20kyjaYvmacexAxj2NblcNwuSC3u1ZsCZxOWLva8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d6b9c5-ba29-4b17-3a9f-08dc265e9301
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 15:24:41.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RohWwLqLNZZ57ciDWJPnr/0Sl2fOEqxPvv45ePkXOeN/QVae7OISXjyg255Xiz8Mja8AMi1XuXQpC3FHyanVDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050116
X-Proofpoint-ORIG-GUID: ggA3HxZpZZjotql6WfYa-p4PtjEtymTu
X-Proofpoint-GUID: ggA3HxZpZZjotql6WfYa-p4PtjEtymTu

On Mon, Feb 05, 2024 at 01:22:39PM +1100, NeilBrown wrote:
> 
> A recent change to check_for_locks() changed it to take ->flc_lock while
> holding ->fi_lock.  This creates a lock inversion (reported by lockdep)
> because there is a case where ->fi_lock is taken while holding
> ->flc_lock.
> 
> ->flc_lock is held across ->fl_lmops callbacks, and
> nfsd_break_deleg_cb() is one of those and does take ->fi_lock.  However
> it doesn't need to.
> 
> Prior to v4.17-rc1~110^2~22 ("nfsd: create a separate lease for each
> delegation") nfsd_break_deleg_cb() would walk the ->fi_delegations list
> and so needed the lock.  Since then it doesn't walk the list and doesn't
> need the lock.
> 
> Two actions are performed under the lock.  One is to call
> nfsd_break_one_deleg which calls nfsd4_run_cb().  These doesn't act on
> the nfs4_file at all, so don't need the lock.
> 
> The other is to set ->fi_had_conflict which is in the nfs4_file.
> This field is only ever set here (except when initialised to false)
> so there is no possible problem will multiple threads racing when
> setting it.
> 
> The field is tested twice in nfs4_set_delegation().  The first test does
> not hold a lock and is documented as an opportunistic optimisation, so
> it doesn't impose any need to hold ->fi_lock while setting
> ->fi_had_conflict.
> 
> The second test in nfs4_set_delegation() *is* make under ->fi_lock, so
> removing the locking when ->fi_had_conflict is set could make a change.
> The change could only be interesting if ->fi_had_conflict tested as
> false even though nfsd_break_one_deleg() ran before ->fi_lock was
> unlocked.  i.e. while hash_delegation_locked() was running.
> As hash_delegation_lock() doesn't interact in any way with nfs4_run_cb()
> there can be no importance to this interaction.
> 
> So this patch removes the locking from nfsd_break_one_deleg() and moves
> the final test on ->fi_had_conflict out of the locked region to make it
> clear that locking isn't important to the test.  It is still tested
> *after* vfs_setlease() has succeeded.  This might be significant and as
> vfs_setlease() takes ->flc_lock, and nfsd_break_one_deleg() is called
> under ->flc_lock this "after" is a true ordering provided by a spinlock.
> 
> Fixes: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 12534e12dbb3..8b112673d389 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5154,10 +5154,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>  	 */
>  	fl->fl_break_time = 0;
>  
> -	spin_lock(&fp->fi_lock);
>  	fp->fi_had_conflict = true;
>  	nfsd_break_one_deleg(dp);
> -	spin_unlock(&fp->fi_lock);
>  	return false;
>  }
>  
> @@ -5771,13 +5769,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	if (status)
>  		goto out_unlock;
>  
> +	status = -EAGAIN;
> +	if (fp->fi_had_conflict)
> +		goto out_unlock;
> +
>  	spin_lock(&state_lock);
>  	spin_lock(&clp->cl_lock);
>  	spin_lock(&fp->fi_lock);
> -	if (fp->fi_had_conflict)
> -		status = -EAGAIN;
> -	else
> -		status = hash_delegation_locked(dp, fp);
> +	status = hash_delegation_locked(dp, fp);
>  	spin_unlock(&fp->fi_lock);
>  	spin_unlock(&clp->cl_lock);
>  	spin_unlock(&state_lock);
> -- 
> 2.43.0

Thanks for jumping on this issue.

This version of the fix does not apply to nfsd-fixes since the
ADMIN_REVOKED changes in nfsd-next also touch this part of
nfs4_set_delegation().

Because edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER") is now applied
in v6.8-rc3, v6.7.y, v6.6.y, and probably v6.1.y, I've reworked this
fix slightly to apply on nfsd-fixes and have started a round of
testing there.


-- 
Chuck Lever

