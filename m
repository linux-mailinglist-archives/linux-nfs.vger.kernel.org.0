Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71F76996A
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjGaOX1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjGaOXR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 10:23:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904301716
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 07:23:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDToOG004888;
        Mon, 31 Jul 2023 14:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ve/xK/HUN7guwAujxP1oSwTRof+juRUxtJYQwFviu2I=;
 b=3PKOXslSVYUVbrNpQqv4m1Hv2UxYqJe5ZwsHL0rDNo+xZDW9QybUK88IUHqYxXnMVRX8
 PwIz9oSRmBtjOh70/nPOKTMjuwaAmYaGgdhtaobg7Y7bRJvZgwWg+SL4wGansyPaK/uQ
 SGs5sqql3/O1m/ZxVs5w8SKq7qo00SoJEiC7XgG8V4wkALuVrW1193uevDrYNKDcnDNQ
 Tt/u8W+iCmJh7j02wwPR6OPU7LPHukf7cFEAZ69sHOvLHkqBJNLLUL/jK+Wr3F2bHUTW
 fcZkxnlLua93IWDOEVq2P+XLsA3OGDB6dcWB7apTyPjhTH/4lc9Y7OsN1ALgoKIcmiKz /A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uautnde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 14:23:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDDmOa000723;
        Mon, 31 Jul 2023 14:23:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74nvju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 14:23:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbKWxP1fBMjDZUzvmkjz9aH9mVvZCEQ8hlLGkiaEakVVUI4greufLqDp+58jiFJ9HbHL6G7GmYIca0dbp4oHvuARiR9bp+U8mQ5GzIHKVY3ySRAzEe/TDpAwBGFU5qJ/JO193UJZtzmkzI92F6u2uZb3tp+jtAn97tUw2h6lCMhQV2xc8KldKAhsbFUiGlDe8dvEAs6lh7PXtPE7UXHeco5TxTx4doZHuc2RChLJl/5hdmQaWYFq724dpnXs6mOpwCYv4h/0cu4sIl1h+OXgSuHFhs5N36me48Z15g47dE3pMEz/errpWYcVefVckgCfjERew6w+fy81HBjuyx14sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve/xK/HUN7guwAujxP1oSwTRof+juRUxtJYQwFviu2I=;
 b=d878bH8r2szNLaiSzNWqoxCG6CD3jDoKDRR9fDlpwvOJNuT6PeXCeBq6da0X1YSR3+SH6f/ja2D0AhBzYrSbVhlMSETwpxgO3b4O6wQ/k50yB7cP0OxgkJtdEUffW17dBxO4Dl0huJnvsGlzEwwjwMdmalmFt8sNkPl6cvzHe1crMoSwz1pmchFc12GLJd3WvwkhThQPYLsnoFBnzCfivZgES8Jv2M7uPP6x/NFuolWh/oOTZiCk1AnShBJcAD1K5NtHTntNpo1BY9EZFcQGJBuC2hdbFVlcTYpTqb2T5cQT/gzGFw8hB1aLs8XRUPilIETL/vWWGLYNkoGQm/QQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve/xK/HUN7guwAujxP1oSwTRof+juRUxtJYQwFviu2I=;
 b=N7TBlXrNWl2f66WaFnCdA5TUXD5+ich/g8oK2vDEx6AdtHq3zCeLlcYQmsGiURX9ykL0Q3g2mHbYONMksOmd+v5VJ8OEF+yVJippTJ+uZeBmEHmP+ByLwjb0YdINZ46zf77OqjrFyo9rJQhlPLVazj2EGHm4mc5XzDCmSgUmp+U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6132.namprd10.prod.outlook.com (2603:10b6:510:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 14:23:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 14:23:03 +0000
Date:   Mon, 31 Jul 2023 10:23:00 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 05/12] nfsd: separate nfsd_last_thread() from nfsd_put()
Message-ID: <ZMfDxLNQc0osbwFW@tissot.1015granger.net>
References: <20230731064839.7729-1-neilb@suse.de>
 <20230731064839.7729-6-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731064839.7729-6-neilb@suse.de>
X-ClientProxiedBy: CH2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:610:4d::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5177227d-76b1-44c8-5955-08db91d1a6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ge9mlkDxuW4kfy3JY1raT5u+FJUd7fILrhNSVI9HhFjzgNzjDrpgvf9MIZm6sY1cNEqPlwrM1qeZCPkjkbrj1z/KXm5EhyyELLpoCOJTSADxM6OBXaaNWMpUnq8upreki3vDF7DbAgmHy4HdAJn6AGtcOj/fDh2MYw8lKmgd0pfUcjlYhitqjfKqfaPD9YKpTwT+20p8XzGsATQXp5rbiCWIPg9ct99PwtcYDiI5oMwDE4H0itQNqrvUrpZIfOUJh6i+TABAdesDAX2LSrVMuHj9XLiXzoHh3OuicVI16y0mUGdnoEYOJi28TbU2PSjmpuDpY6CEOjptPKJg7WD6y+l76AWfBEZRm5/bVjIpIqpCfXYem548DsH3D3d6JELYzQkwtk06lrE+8yJkvmNqiZ5a46OvVNR85Bfue1hnftt5zO4sjqHio13BFnKaEn1QRJsqawklS3IgjgXURTp6+vkocQ9crbAuQB1WrsnQsgtXA6xGTrra9vTHsvX8At1IGKhkSsKjciDA8ZGLjEVvtiHf7eNrzCsnbYmyFG+F+STCES/tsiY57QLInD22hzbX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199021)(38100700002)(86362001)(6512007)(9686003)(478600001)(6486002)(186003)(26005)(8936002)(6506007)(8676002)(44832011)(5660300002)(66556008)(66946007)(66476007)(2906002)(6916009)(4326008)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oo+rHGxG22WYJ+ArIC9AaKPHgIKbQVQgoSr1pjc76CSc1q1Anc6PGZAz43ub?=
 =?us-ascii?Q?y3oAg5/LI7EikZS8Nk6Szhap7VlWPRwEQZ9KFMGf9Ninsd61xyMtlK9RlS0v?=
 =?us-ascii?Q?pI7ejGk55awh8+C01NFhHY9M9TYrihi0LdJ/mOz/0EpkOa2geOj7NnUy19a4?=
 =?us-ascii?Q?ubDIhYS78EUcYjIvxdMRkBQFoW0XcA4ZDTsgPtu1nCVNibLqLhJr+97TTqMc?=
 =?us-ascii?Q?HX8Z0nW6EjHibnZlTk2OeUzAlOED4jTMkwuzq7eYEFDQP8sNAZH5s7KteOo0?=
 =?us-ascii?Q?UmgtknPh4+IQysnb1L6GkXCbK/R034hOnpjHziCuUat7pHvqolHdcFQ4yQm4?=
 =?us-ascii?Q?qm6Y9iMeQsKmHt+sQ64TFLXLCq3E5imPi8bVaUbHcmWLhmhDfaJPCnMKJykB?=
 =?us-ascii?Q?wCRwk8nDU2B/PVEkDbfYQwLpp3r2cUApLDA5cuLRIA+Wes9v0JPrqh7GM+rl?=
 =?us-ascii?Q?pn/phnCEUaleQ1QwOEq4WcB78s2wtH2fb/3nulvIhXeCQ3FzlFJRFdIa/2cq?=
 =?us-ascii?Q?jsnpKDuKQ3fCOJvjs2o1NVTs7tSaWGF3mwe1iILfrIDhJ6lHlZmod6KPXJ3S?=
 =?us-ascii?Q?Ov5Kd123MGcK4gbxZcwB8Yqw4mkwidYCSNyvZjkXgegu+Q/ohthRuN7gObZz?=
 =?us-ascii?Q?gNsPQyFNGfy6+gA+8qlyDoX5qJRd/mhvLDKa5TqEOap/wJoxeEv9PcZSROsm?=
 =?us-ascii?Q?kmYKID075k041jQFkCZPjQzNBsthVT1/IuDcYuI5UmuSs/FntIZVVr7idaoz?=
 =?us-ascii?Q?jnktSi12vHQiYYXzHAAlIUdXLLQ5NgisiEaKWqA0WLxkqH2rl9paGnmLQ6rT?=
 =?us-ascii?Q?a8g7WxYRmuMdq6A1hgQu59xZLEY0huuVRRPLx+ZcQRSOM80z3sLm2/vVWub5?=
 =?us-ascii?Q?OWGcU6JHxkuy0migQjuUh1UGm2W/7mDKkP3rOlgZL3kvU+q50Tzgo8T/QS+D?=
 =?us-ascii?Q?nqoPH+dDecxgzIVmQUnWcJO5pD8dSN2/LdCmcDITjDE04PRUVBAteSAcsKNV?=
 =?us-ascii?Q?2GAhyvvrtRluaYbUM+0yMxyl4Q+apCdM6VLMU1jyj6+UXDjVdz+jpx7q/CQi?=
 =?us-ascii?Q?MCzuUQUt2uAvN5MTNPpNJRejkhXKWKPl9XYvBIFWAQdVWknj+fPtTVrteZTM?=
 =?us-ascii?Q?pxEsM61CzSwPFQ97+oSAssNGHHYrvScgT8q6eD05OlXLPaEIeR0TX/W+tX/i?=
 =?us-ascii?Q?MRtuoMqtF2Sju75WnUX+uWV9gIX6+uIsEdNK+DiOD+FnX04ksuTebeG/mmOs?=
 =?us-ascii?Q?G5T4UU61FQURp6pfGc5hbCxliIKfw8ihix0TwjRA8LS55U32A7Cj23uVCyt+?=
 =?us-ascii?Q?rl02F45oCvzAk66qPS1pVpq0z7Y+0qmrVJ2u5vS50TjEEDt70/9dw8hpeq9P?=
 =?us-ascii?Q?PhrFGCEvBaEtwP0q9Ugju6pK2Vk4jefIxRYzIDwSw9d0Amz714p3O2r10U+Q?=
 =?us-ascii?Q?vGKZZDG60EVVV/rZ4LW1K/q5f7uQ0phC10pLwnaR6qaDtbju0B+zPnbk2fg9?=
 =?us-ascii?Q?ORH1QbfIKU9sgVsBqMLqlPKh4uwTT4ug7j9MttgHlcPpxkTeARvj9mWqHzvH?=
 =?us-ascii?Q?X6y6YBhRc8jMsVrViCzfxHOsjFfo+iJ9F064aADx3IfSgtdXIWp/R6nl75YI?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nPhJ+1fxi4Ax8ZyO1BZptrxUQkMUSDy2lKHneoqDrhyWryBh5Jx2duQRv8Jy2QzTlzOAz1H5fBGpyVblUQKDPJpztyuj4oeKCgEONTtLcQRAab27OeS4A1SjAnAUqkObf/p4bPl5r1j4nbZJDe5bz9uWS1AgQw73GHnVvj2lziQX+fdpObCekgV3Vjlm5ZnuGR/fWLTHqKDn/64HCfQPPIm/uOxV6xfPlt9zCBHbdu9WT1pMUPYP6KJchTRP/9F3FgME8cJAP8IIpW9hD1OSv47QmxASzGOUqaQxD73qspHwX3obzm1v5mUtwqB+43eHv1rgw6Vq+tjkZqM9L8veaLjJXKQy3L/KNs68nShyUiMmKJuiXESMPCTVwd18ZhnZradYb6uwwjyhaCevB7wXSPU+q7lxsYDJqpIx/Uz2eDzt4XwJxECHdAs+znI1CmqNI8hTj7cMNRN/x0prYRINl3fJQ0vrUDro2COppmo282mZLuFe57fyp6uQjG8XSB18JogAGSHEfC+V2GV1Q9rg2ny34BIHoZOR7D14Bx/3hS0nX/KaArHtrC0+Qhq4sLy4RomKBpcXlfjGIfgAIuS0qzHho1xylDiSQU9hLX5Ixyn1uVr8Tdy2hPr8UHlrcq4qJYz6nTAXHxqM0XPrSldW6oldudFZu6ksqMDIylpwl7OrT1D6e2nIQPLp6kU2K9wLipiGs4hZsHDvWDWVwir/2nS1ceS9BSVYIOQN3V+eNiP3s88CXhpeoDtMoqvIYq7MTTsd8dMuDTeloTe6lCE7OfK2sQxinB+hnt80Rii4rpLIw1QeXxmqG0zShaxavSfu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5177227d-76b1-44c8-5955-08db91d1a6d2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 14:23:03.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOUtgVHvFpvU7DYsU4FhKQqL3R9coCQWLBuojaYlm4UXyNpKhXXpFX5mkKj2hCQSn/rkcI3qnGFOR2iosWwJ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_07,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310128
X-Proofpoint-ORIG-GUID: qwljAL3gtEqtN40WBlDm_CsnPsfAhmgk
X-Proofpoint-GUID: qwljAL3gtEqtN40WBlDm_CsnPsfAhmgk
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 31, 2023 at 04:48:32PM +1000, NeilBrown wrote:
> Now that the last nfsd thread is stopped by an explicit act of calling
> svc_set_num_threads() with a count of zero, we only have a limited
> number of places that can happen, and don't need to call
> nfsd_last_thread() in nfsd_put()
> 
> So separate that out and call it at the two places where the number of
> threads is set to zero.
> 
> Move the clearing of ->nfsd_serv and the call to svc_xprt_destroy_all()
> into nfsd_last_thread(), as they are really part of the same action.
> 
> nfsd_put() is now a thin wrapper around svc_put(), so make it a static inline.
> 
> nfsd_put() cannot be called after nfsd_last_thread(), so in a couple of
> places we have to use svc_put() instead.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

I've applied 4/12 and 5/12.

I'll push these out later today.


> ---
>  fs/nfsd/nfsd.h   |  7 ++++++-
>  fs/nfsd/nfssvc.c | 52 ++++++++++++++++++------------------------------
>  2 files changed, 25 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index d88498f8b275..11c14faa6c67 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -96,7 +96,12 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
>  int		nfsd_pool_stats_release(struct inode *, struct file *);
>  void		nfsd_shutdown_threads(struct net *net);
>  
> -void		nfsd_put(struct net *net);
> +static inline void nfsd_put(struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +
> +	svc_put(nn->nfsd_serv);
> +}
>  
>  bool		i_am_nfsd(void);
>  
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 33a80725e14e..1582af33e204 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -542,9 +542,14 @@ static struct notifier_block nfsd_inet6addr_notifier = {
>  /* Only used under nfsd_mutex, so this atomic may be overkill: */
>  static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
>  
> -static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
> +static void nfsd_last_thread(struct net *net)
>  {
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv = nn->nfsd_serv;
> +
> +	spin_lock(&nfsd_notifier_lock);
> +	nn->nfsd_serv = NULL;
> +	spin_unlock(&nfsd_notifier_lock);
>  
>  	/* check if the notifier still has clients */
>  	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
> @@ -554,6 +559,8 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
>  #endif
>  	}
>  
> +	svc_xprt_destroy_all(serv, net);
> +
>  	/*
>  	 * write_ports can create the server without actually starting
>  	 * any threads--if we get shut down before any threads are
> @@ -644,7 +651,8 @@ void nfsd_shutdown_threads(struct net *net)
>  	svc_get(serv);
>  	/* Kill outstanding nfsd threads */
>  	svc_set_num_threads(serv, NULL, 0);
> -	nfsd_put(net);
> +	nfsd_last_thread(net);
> +	svc_put(serv);
>  	mutex_unlock(&nfsd_mutex);
>  }
>  
> @@ -674,9 +682,6 @@ int nfsd_create_serv(struct net *net)
>  	serv->sv_maxconn = nn->max_connections;
>  	error = svc_bind(serv, net);
>  	if (error < 0) {
> -		/* NOT nfsd_put() as notifiers (see below) haven't
> -		 * been set up yet.
> -		 */
>  		svc_put(serv);
>  		return error;
>  	}
> @@ -719,29 +724,6 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
>  	return 0;
>  }
>  
> -/* This is the callback for kref_put() below.
> - * There is no code here as the first thing to be done is
> - * call svc_shutdown_net(), but we cannot get the 'net' from
> - * the kref.  So do all the work when kref_put returns true.
> - */
> -static void nfsd_noop(struct kref *ref)
> -{
> -}
> -
> -void nfsd_put(struct net *net)
> -{
> -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> -
> -	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
> -		svc_xprt_destroy_all(nn->nfsd_serv, net);
> -		nfsd_last_thread(nn->nfsd_serv, net);
> -		svc_destroy(&nn->nfsd_serv->sv_refcnt);
> -		spin_lock(&nfsd_notifier_lock);
> -		nn->nfsd_serv = NULL;
> -		spin_unlock(&nfsd_notifier_lock);
> -	}
> -}
> -
>  int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
>  {
>  	int i = 0;
> @@ -792,7 +774,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
>  		if (err)
>  			break;
>  	}
> -	nfsd_put(net);
> +	svc_put(nn->nfsd_serv);
>  	return err;
>  }
>  
> @@ -807,6 +789,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
>  	int	error;
>  	bool	nfsd_up_before;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv;
>  
>  	mutex_lock(&nfsd_mutex);
>  	dprintk("nfsd: creating service\n");
> @@ -826,22 +809,25 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
>  		goto out;
>  
>  	nfsd_up_before = nn->nfsd_net_up;
> +	serv = nn->nfsd_serv;
>  
>  	error = nfsd_startup_net(net, cred);
>  	if (error)
>  		goto out_put;
> -	error = svc_set_num_threads(nn->nfsd_serv, NULL, nrservs);
> +	error = svc_set_num_threads(serv, NULL, nrservs);
>  	if (error)
>  		goto out_shutdown;
> -	error = nn->nfsd_serv->sv_nrthreads;
> +	error = serv->sv_nrthreads;
> +	if (error == 0)
> +		nfsd_last_thread(net);
>  out_shutdown:
>  	if (error < 0 && !nfsd_up_before)
>  		nfsd_shutdown_net(net);
>  out_put:
>  	/* Threads now hold service active */
>  	if (xchg(&nn->keep_active, 0))
> -		nfsd_put(net);
> -	nfsd_put(net);
> +		svc_put(serv);
> +	svc_put(serv);
>  out:
>  	mutex_unlock(&nfsd_mutex);
>  	return error;
> -- 
> 2.40.1
> 

-- 
Chuck Lever
