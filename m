Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75627C9A6A
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Oct 2023 19:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJORrQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Oct 2023 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJORrP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 15 Oct 2023 13:47:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB536B7
        for <linux-nfs@vger.kernel.org>; Sun, 15 Oct 2023 10:47:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39FFsA6E020040;
        Sun, 15 Oct 2023 17:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=fhvFsRieD3LQH09X44HHRwaX2lKpOKVTrr8KRh+ZcDE=;
 b=Lqw/1Btx9uFT21rcXmx03NJe9OB2SiLMPIAYihyB+GIu+9T9zijxND0+cgr7BZRu7G2F
 +DvQ+tT7dQFj1JsLCN7DrlBUEG/WuYxttl0E/NbNBix0Xw3vpEg3zgE1cSejosoBAZQd
 t5+onlEaIuF1ZPwk9hjg3f5zaYZEjy2EvOgjklWUANeBlBI0fNsj1+quk1TbvACDGfiq
 znXIsSvNgU8VN4Or9yoYIrOzykVxaL8hHfiWrvqDvzkYMlAE63JK5jxHGuRx1IBhpDAw
 GdJJVhJGndyL0nP3x1eRpodY9aMps42J7l79ikiN97O39uDOEB/ooAxXgvCZ9eckSSk5 Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjyn9c9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Oct 2023 17:47:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39FHkdlL009572;
        Sun, 15 Oct 2023 17:47:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0je64y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Oct 2023 17:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WysoPwKtqMbovtPo0dmig/ykZZ5gAXVXBdlQaexR88lvz8RcJgNIxn8AL0fSYc03SSvC0H8RW0qHbWQukSPLMXSbFqCEw092lObrgUL+IcTN63sxPZMbnDbW+bBYK95GLyYk+tuJRH9FXW2goPbE8WUQUyrzZCCpdg6cQY56ZR9CcMXn/BaloUokJB6JSulv7WFYwuYkKzPiSoZNUpH7Zc12myPfbT3pAy8RY7FW9b5N+yXDSBpYIoGxe5gZ1Th0/aX3YbzD/kx1fp/T1UG2rkeQkG8EGAAVSqiTGPKuc4irWv/5YECvlbTYQDRq3o6NLBHpOWcaa6DtXN2YsacCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhvFsRieD3LQH09X44HHRwaX2lKpOKVTrr8KRh+ZcDE=;
 b=icZW6UqgJljqmAaLf1yRLVi16jggCLoSS3ivPDYGVAlAZqONrdeD2ie+UlsKB5HtQeoAUgogU8e9aQLWnGJDVB28eGmzxWjSwH7iUXs0gBn9B/ADZeRwgcXIuGPBQtallEBDYkH+oWcmGtzvEwpatyCWVPADp/0wtZlMjXh1d4VL2kqXU24djsJAYtaQ28KI6jVaNDugzKLyQOV6ZSFjPgyfwJRtRT1bBrC0+jPqLYJSBSk10/KnrEMxjMzOju2frUcF0UUY4rAcqvFUpIrQkbwqAt39q9HSq3k/7NARfl2v/cFA5KFifmzZmqRkY2qSucf1dJD0DzoNVpemrW5o2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhvFsRieD3LQH09X44HHRwaX2lKpOKVTrr8KRh+ZcDE=;
 b=Rx9m2Mbd+q0DfR14tsp/x8NJtMeb0P4QOlruYwy6EQPhkw3HdAO+MrT5CTcw43W+wzpKa0KymOUIH7H1o8ALEc36z3shIARW/8aH42amFRgWjH9CKP6TWeY+U30GP1mycEJH2Qq1Lim+i9x8Dm46PVWihL9ua+gmpcRLTXUa/nI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5027.namprd10.prod.outlook.com (2603:10b6:208:333::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:47:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641%4]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 17:47:09 +0000
Date:   Sun, 15 Oct 2023 13:47:06 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: lock_rename() needs both directories to live on
 the same fs
Message-ID: <ZSwlmqabc2URieJ4@tissot.1015granger.net>
References: <20231015172927.GE800259@ZenIV>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015172927.GE800259@ZenIV>
X-ClientProxiedBy: CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: bd30c345-3058-4d89-b125-08dbcda6c129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjpth75Vv3SX2wzxshZckTwR/KPedKaNk3t6xbcjGOJLecqmpBzaLOuHAjdxG4Y+AJxgmBnjbYwbm7oiBQqN/8y+jIv0j3bDniEqiZKh9H+q046qVXaLfWH9Q+Q+zwczcLGsh+mIK40Un00aaP3FjmonCUg7EhYpFe6yuwLsL3Ouebg7/7CsV9Z1L7UgQvKGNNdIRFTa1LyKakNoM8CnhJw9rj4YxuimMLm7nKRf/FZrQsq/h5yNas40jf5CmGOraWkWVnu8tChW+XLN/NXjy3ISefGmUjrSFFFK4WfcqiDauD5B1Jb3U68XCT3lsDY/LSSiX2EeZoHxhwDbDjUNnFdalNn9TnkdaYTlShl9IUbnUbOwB7SuXgy5odxfEeSGT+D+4kerN0lEwg1QQfN/BWrQaZgHEWBq8462jFh7/QnQI8FhOLFRw2v8YE8G34VLbQCqJXyeDAXoa36ButLuYpfN4+vojKGSKF/0X6LaPR6+nazhzlDjL2IgHyouDHMySiJ+jHVy/4CeVjeZmON3BPiojD0sLwGPkvaZAcVhZlal8liM0t08HmjYNDvMJ1pB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(478600001)(6486002)(66946007)(66556008)(66476007)(316002)(6916009)(6666004)(83380400001)(86362001)(38100700002)(9686003)(6512007)(26005)(6506007)(44832011)(41300700001)(5660300002)(8936002)(8676002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kFjWCdFgOYslRHvCLBBD8rlsX8hPOnLUxhZFpZps/8VkOFzC3Dg4PTBSAbn?=
 =?us-ascii?Q?w/o7cRSLKpy44S4BX3/dNfkPcnqH7uc00vWbiWHtqkiydPYg5XiimWqYPOnb?=
 =?us-ascii?Q?nHvSZQGSmjRQhlSBzbJOn8EtW/of7Sg5SIt6bYL+7d8/g9YAS/L8L2oX/2Z7?=
 =?us-ascii?Q?DY/m4W2Z2qkEH8ZTafuf77DR60zeDVJh9pCHfvyIWMn/5eJk3T6GJOB0ghIT?=
 =?us-ascii?Q?9OYTZUhn0rELu6TzLwfV3wfsbrNu5ioz5WtuHG510TceMHJ4UroaobMrvfrS?=
 =?us-ascii?Q?mWrv4rDjW4co08VC/I8X9nrFXVLLPXOuryt+3WSP7653ysdAfm8ASD/Xw6yF?=
 =?us-ascii?Q?h13+CzMghafcHalBqAWkDtzxBggy8pTfU9BS/oje4LwhnZII0GzTWX6jy+tu?=
 =?us-ascii?Q?xVt7hclqg31MboKOTnYie28VsI1NuUkMtlwXHoX6CR8KZFNMuimGdB4jBlp6?=
 =?us-ascii?Q?lFEMwS+jeu7V3pWwBP8vOUa09Py2Zqo0mYYm2tPzqyClGMtLhluLv0BzjkZA?=
 =?us-ascii?Q?mJ1jF60+2g/9Fz5vj7gqDN2BmVzGrlYhbVzrtnecHKDp6lCPKC/E0ZnCuhlI?=
 =?us-ascii?Q?lGZKuedQkIMbnDotnp9tpaGAZZwKvPp7chYFWVE1pFFd60RUZszzDEf3op1V?=
 =?us-ascii?Q?OT1ZSz7aztK2/Fi0TsEDnvRItfegVtye1Veakyy/BYACHBZub2mOR1irwjkE?=
 =?us-ascii?Q?gHl7+V2bI5xmL+LyMEOPxBvMwg4YJcuX/Yk+4pnRdjcG6UfMQXWxJh5Ch2ae?=
 =?us-ascii?Q?1oE/ya1K/26TSQic0jf8h9GkCsaRP3bcGlnWw9YQV0AJurRnJS3kHrqZ3olF?=
 =?us-ascii?Q?rB1yaEZ2L4LS8geIZ+IoonGmQ+4dNaTEmgM4YeO27g9GLibbY+9HlM6KKVXy?=
 =?us-ascii?Q?PKNrgf1590EB1pGI/aV2mOzjr5RsTFtL8WvfQ9kVsHXJ7NNUeiOn3B6TeUW7?=
 =?us-ascii?Q?oWeBDXPzMR6bmXhs5dLuFH8Z6dXQGhqkTEncy/izNZ/z2/QW6ZYAR1dnqHWu?=
 =?us-ascii?Q?f/JS5tXp61S8q4o3eZciY3of4GNeU+I2Qzt8/g6jcQyN7gn3MuJ7QdWgr9xR?=
 =?us-ascii?Q?+K7Rw2cV5A9G1y/3qkHGIXVTVnWSEuQAaU2jYnDnJg7cUOiAPpANJ9Tn4R0F?=
 =?us-ascii?Q?8WjzXQ159n3jr5GzrhhCTXd//wLrhL2hxPKrXN0polhIdUlR6573CjozqyBg?=
 =?us-ascii?Q?RkBcjD5N7bbNORvcHJTQX+HIDRY1P4xkuuH9ohVP5vM09tfHWiRP5OodHhIx?=
 =?us-ascii?Q?wfbHRJYc4mARUpPutU7rvMwmLsnYbJYFA+BR8H+Y2y7BVbK5lkqUOCTXt6Qg?=
 =?us-ascii?Q?/GAuMww4p2sLyRNH+w4XP8Hncvj4F4wiwSH9XaSwB7yd6qGIDevjdZdF5+o6?=
 =?us-ascii?Q?vc/gfsxnbSH5kEbTDYbCJhW9z4BIbpG54f2GEBOjocyuWHzfz+wkAMU5PC14?=
 =?us-ascii?Q?umS3w/F5NVQ59rHtcUthwAL20MH9kYLcqFnfadU28iPTSvvki80RKVMgiso2?=
 =?us-ascii?Q?q3G+zYP8T2cd9AdgXusukjMHcxcEOp6duP58BIHHhmiSPJR3MHnmbgVP3GOo?=
 =?us-ascii?Q?ZCziZmH35KD6XdJ8QP2pnnvU9ZmhOAKHS5Wg3X0MkqUT/C9ADdmR4ZKevWEG?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JNJAAu5uGHSqDQymvT/Rrbs4U5M8DOooHdl7Px/iUHMaPVeFyIxqHL2HEEWkhV/dCVJB9kdhGcpgW+/Yc8N8dCdMI0ODSMAhzFGsqZttLUaS4CkhygHCsGfudjEOIoDGD2oFe/TgoZu4ZQXVBSB55yh8BClh3bq6YUInpEITNyi0fv0B4DtSCFB6wH3+XGi346PYq9D7ntbFRKkHE+EbwiQjZX/0hQNvMullwrM+MplwDwmxGJBRdr1xEl+vCWTCyybVu2Sm1WwdhKnZ31b1PxT3OqgUl3HvFCxSTe11dy/bq5JvT5QPjWZY6JestqWV7WP9Z9mkFqG0FGvRP5D/A0sowvkXCJvrBH8RIsF8acXJ4YskQGWlyjVb1B5uOVuihsEV60SReqd90tMF7q3bYOLV4NtknV9mCykEd7EKo7/EsoOIs7ZB1VfPjEjyCnlPRZe4BDi3/7uWtBTegD3pLlq92Ic8oA1+ZhypJzFRFYek7kTOHU0fXzgXv9kPdVk3lOskHuFParQxAeWzGDMeCKwAULBrVxKaEe1P5vcWJEY4RnnaJzcCOo17rW1/bSPE/IEKS+5uuHcKW4FRyyYXaim/qbEJx+D17Z2ddq0tUOkpUB06PcdQ6GAKmB65yAwFcFqpulFdF0mxGzEKgqA306Aj1d7j/5N3qaSIamBn6J7bHAjFgEuPHf+hjzXUHZfPXtAV+cXfSPCouoWFSZg3CWKY0gK+KXcYYLtr3jDdCJw9z+XzWKDwDcVVDW7paSVN6xJxhxoLr51s8YtkiXR1LElYSdEbJags2eQYSc00vRdyRD9+YrJY1OoKAi98m7AD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd30c345-3058-4d89-b125-08dbcda6c129
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:47:09.3111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEhfiB1qpjKmg6ld1tNpudg2kxOTESSl7o9drXvxQ8l2H+k9I/9NUtqOIqR3/bmYeBF+v5iv0jfxHdHQsFzP8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-15_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310150161
X-Proofpoint-GUID: rJbnGApAeO41slXlId1cqP-o-juINRfz
X-Proofpoint-ORIG-GUID: rJbnGApAeO41slXlId1cqP-o-juINRfz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Oct 15, 2023 at 06:29:27PM +0100, Al Viro wrote:
> ... checking that after lock_rename() is too late.  Incidentally,
> NFSv2 had no nfserr_xdev...
> 
> Fixes: aa387d6ce153 "nfsd: fix EXDEV checking in rename"
> Cc: stable@vger.kernel.org # v3.9+
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> 
> [in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #nfsd-fix;
> it's an immutable branch, please either pull from it or put that thing
> into an immutable branch in your tree - there's a lock_rename-related
> series in the making and I'd rather avoid mixing unrelated nfsd stuff
> into it ;-/]

I'll assume you will be sending this on to Linus, then:

Acked-by: Chuck Lever <chuck.lever@oracle.com>

Jeff or I will get back to you in a day or two on the results of
regression testing, but I don't expect a problem.


> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 48260cf68fde..02f5fcaad03f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1788,6 +1788,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
>  		goto out;
>  
> +	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
> +	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
> +		goto out;
> +	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
> +		goto out;
> +
>  retry:
>  	host_err = fh_want_write(ffhp);
>  	if (host_err) {
> @@ -1823,12 +1829,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	if (ndentry == trap)
>  		goto out_dput_new;
>  
> -	host_err = -EXDEV;
> -	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
> -		goto out_dput_new;
> -	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
> -		goto out_dput_new;
> -
>  	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
>  	    nfsd_has_cached_files(ndentry)) {
>  		close_cached = true;

-- 
Chuck Lever
