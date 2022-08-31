Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FC15A75E0
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 07:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiHaFob (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 01:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiHaFoa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 01:44:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA72BA149;
        Tue, 30 Aug 2022 22:44:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V4hQgO012626;
        Wed, 31 Aug 2022 05:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=RO9R1f1+xv4zsSfe8Zqe9tJ6P7eYeaf85V2LDrSW0y8=;
 b=EMcYsHrvz3SA31vMssrR2VPPbPf5rNKikda7zEOFBz8QPYgefATKfab19XHs++Ji4mS3
 hUecv5l9rF6vxS7TqjRdp0mDAYhsIVLlz+7LDJd/8HGCGTIqhLfC+yoQabRNEIATE2L0
 TxTk7RgQF5Qf5efvUWgZcnm9VQFHa3PU6B3XUcZDThCX3puF5ililC59hDCJxRuVJgks
 sxvkSE4i0i1wbwgnKubGpz1+7nLWzL9yYX+THTPUfwzaDF7Fl8gRIDq3yrVkWiNto9UG
 FWd/1qMmVayk53QANjBk9aTP/7vrFldW2UqzlYJWFYB+bWivARc8ed9e4F0BtfZbCIzr Kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pc0225-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 05:44:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27V2TYU6007939;
        Wed, 31 Aug 2022 05:44:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79qb14n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 05:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRXn/MxAQlma7V06gXoG+KXlW6jXKyYO5eUmTwQjF1/+fQQBEEVTilvkZPWQ0HysBy0whh33tKEmfDts/qevXzHtoBQfF2c60t3swNWunRHW/8KrMOPE3n2bx+kwbSorNJ+zW1F9fYA7dHwqTwXI4RcllvvSUjV/wqU+o1YY/OIdvjLffYiaALFxlbd6n+cupVN1WEDiKZgyN1sgImKKiBNAylyHeD7ZyRg1fjcJZCKdJYLhjmtSGScIc4eNw7SSIRqG6cEf1uQZuB7aw78F/xkZ/QnD+xPhuuEpQYz1Lj/ddtzpBylOHFrdDnYHiVRR2yusdFJGJJ1rSvq2EHCqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO9R1f1+xv4zsSfe8Zqe9tJ6P7eYeaf85V2LDrSW0y8=;
 b=G2qkhhHcmxyp0MEslm0/6LAN/7UOvzVhG7cGgeazdTaP5cKndZzXczm8wDX5EEQzqGs81vEeLbJKaVUgiDbsqSR+hgivra37aPPdMA7bvnMLHA42sBXn6Oa3/oW/4EvoVnmJ7l5xENUyu+ZAaHUmEdbjxzeh0yeFK8uLCKDfbA7XUcN9nGRhHDi+5cGNxuKhnRDen/hoZYAtQ0GJzC9bErwSWvAsAghjSVEF+//FgBp/hKKk18ULFV5arXAxFu3ThGCz4nw99Hwn/jbqNM4CKwxGDynpbwot3vEERM2ZsypEPF3f+j2Lna+xhGjWogFnUGHAkJagoeCDNYZ/Hb/YXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO9R1f1+xv4zsSfe8Zqe9tJ6P7eYeaf85V2LDrSW0y8=;
 b=JxYNh1OLcFQE5oEXGRZUA4itjT2AzarZSt4rwHPb6T+I1L4V6C/g5P+MgnDS+UxDNJmYOiB0Y53EGrJh7umej7wxQvoTNcD6N5xWzsxiR9gx6JxQPSYe0LZw6qV4TbbLLEP/ONDoLoUAcon/qBX1W1wjUxvoaNpVFjLTN3T9t5Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB6351.namprd10.prod.outlook.com
 (2603:10b6:a03:479::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 05:44:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 05:44:18 +0000
Date:   Wed, 31 Aug 2022 08:44:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jeff Layton <jlayton@kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Fix a memory leak in an error handling path
Message-ID: <20220831054407.GI2071@kadam>
References: <122a5729fdcd76e23641c7d1853de2a632f6a742.1661509473.git.christophe.jaillet@wanadoo.fr>
 <20220826110808.GE2071@kadam>
 <5AAB19B0-0DAB-4313-AC9A-307E79CE4527@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AAB19B0-0DAB-4313-AC9A-307E79CE4527@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0183.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68a19242-5c7e-4228-c285-08da8b13d871
X-MS-TrafficTypeDiagnostic: SJ0PR10MB6351:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20+ZF+HA+xMMqbBFA168HN6g2uGaFCW2fYI9YTxJFt8Qlwti/waJq59hIe+7G3InU5jVarLfC7YZHPOdK1OtzkOBpVzeKm/WMRDuO1Dhq2ClVwVgQh4ZNEDAdTTjuRiWq8lYBxy/4jEOKkfXj+tVcjRkoPC9n4eDQ8r+OfY/N99UoNQGcOpRD9jwgQVSC1OYGCuF3WDZT+4CsBBULyeBzaf01xV390z+eK88xASAnvyfuMa1xzoD/XBPaaLp038ZezlWEgZ/4Aq3/iMCljRkQzKMVfztCRXpXZehFcOsvaXnsqrPR3K0LGOYP71wgoA/LJYAcqw25RB2cMarPnH28F2DuwWK3R9HCgXddWcuY6tF0etS4t8sRWGpp/kTCpqDEqpRKL+jbRQ7fBXqZG+2M2cdRnmbfKPPvMwFMmJv2tKmlvayWRUZHuUz0JQGn0a6jbSrhATuMe9slxWtgyCfoouxDW29GuZexm3W+BQURb8CJ3KL9rchZzxsBO0AWuinMpGC5O2cXS/6w+sSSrPQX3hI1IQ3T404pouiOjl0dho+0u+G5Wuv1bdzYgVGipkO9M2hYpWx+AuKkd2Sm5OMpc+aaE1tyYX32Hm4UNAMiXkPA7InCaQ+8bXrWD+9LnTYNnQWc7e43j0rzhj21yKsLRH8y1zrki40Tqcwoutx9mO98T7cU7tq2AseD8k+0Qa0P7K04Nwnhn7HhG47ZNQ7TFhQqz8kPtRDisQc+zJ/KIn2HQpuUaR+8ZRjEnO4qxeysItkz77QfFdMOsPHU9dEV3XdA8wL55hyxSUaJrkpWLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(376002)(396003)(136003)(366004)(346002)(6512007)(86362001)(9686003)(53546011)(26005)(6666004)(6486002)(478600001)(33716001)(6506007)(966005)(41300700001)(52116002)(186003)(38100700002)(83380400001)(38350700002)(1076003)(5660300002)(66556008)(6636002)(66476007)(66946007)(8936002)(6862004)(4326008)(8676002)(2906002)(316002)(54906003)(44832011)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpKJpIsnI8qIICpB43Xs7pYYhInoJKaOe1PRD2VGpLCkRFefx7LaEKUveq+Q?=
 =?us-ascii?Q?COhQ0qNkzcOB2zIyjlMR5L3EZh7rA1vxQp3uBmlFtK8BPK838SR9WdJhVwbH?=
 =?us-ascii?Q?GrgcTN5QqRSO18V+vHyyWHqYILn5q941bW+j6MzdFdOcSmSAIP33100+2kMM?=
 =?us-ascii?Q?R4mfy+ljqi/0oBxXox75rOXHFaQQVsA7nVtXN1J5QvJdsPwEQpU+Lyzyc9F5?=
 =?us-ascii?Q?uPIcS9p8MSYeVLlH7KDOZw6HHsVE1yA9cf8bdYpM6QxcyrY6Wf6TjDBCByQu?=
 =?us-ascii?Q?mar/FjE9r8HRQ1TQcdAsGFmeTyEfDWXzC1zj3mPflxzhZnwRDB5z49SdDYUx?=
 =?us-ascii?Q?sNPnqQ+BfywtKWv0ChrHMfvgeRMSbYOxtEEK5VndQexP1rkb00iEJ39GpvGA?=
 =?us-ascii?Q?5JAAXIuCpo8YlkE3rglwmnsByZ1a5mj3C8+K0aI60fjnSL5xqtdde8F2aNoN?=
 =?us-ascii?Q?uaF+Clp+hM8iSKMhoxWC7ELhHD4BWuct1RL58WL7MVsNbqIEclYCK04raCsC?=
 =?us-ascii?Q?8VRyMyPbDyy/3iNf99+ljJvwW6zICD300mRVEJ2wv5aKhJUHD8TmGg/AX0gr?=
 =?us-ascii?Q?L6TwjFkHSKg+3LX9k91ercR8QoGKn1mcuqK9DO/XV1qOEP0yDbTSL0xU8RYW?=
 =?us-ascii?Q?/wzmWxsFwkcQlMTT7vr+WJLex5fxBViq0st5EVlJdE8PIaHHzcmwYKt45tCu?=
 =?us-ascii?Q?zOc9Nw+L/3kuAxHlTqtsgfM7vuqo/F4ikbKPox1cSgbUupqpUwjV1mka3vgT?=
 =?us-ascii?Q?J8Z1AbspvHcnfsFu4fd3SeF/Ufhgo/ZavmIvO8z+M0e4z933hkKypq8RjsUY?=
 =?us-ascii?Q?VHGrNhKxZ96nahRTKitKqRQ6cBe+nhTYK/98l9ceoyR/R1vqflTGdioIrjEV?=
 =?us-ascii?Q?WIR5tPSJhjRqv4jXDg9xrqxbkz7bKAYPrDtJPKxsUdJOBJnc+mmS/dYD56+Y?=
 =?us-ascii?Q?VX+5s3/1hJOh7ni7jnnYiAb7P7n3ojdeus4Nzn3kfp+77bmuMPoIpMVYAQDI?=
 =?us-ascii?Q?fPuDUjdJ7Rtd829jUPtcyMKmnmu4CWQ9lt21Wwg1JCgNpO+D59QfDrpRDhyj?=
 =?us-ascii?Q?55G+L+c/DxBsJZC5CT+7j0viMMtUpWb2oDpc4IiFvhER7lLbCEAutU5ZuhcE?=
 =?us-ascii?Q?0i8dinYm90oYSB0LRw0D6pXPxRpGkTzw3IjYtWFta2X7cbjQJs37RXGNlRtE?=
 =?us-ascii?Q?lLQOVnQqiH82jrqXgiZ9VGxesuooSu0jlYTCmV64L+HDFYDqSXaE/Jo64Oa3?=
 =?us-ascii?Q?+7AClNv8UhIFI3CrplBiPDSOqmMkZEh4eowNKMw3XeFU8i3VAEbRCSUdib3J?=
 =?us-ascii?Q?KMlu9eAIho7gbcPomQW/HGmiQcczj4h3+yn+cHv2oF0pHzmVP1SVeRRoF65D?=
 =?us-ascii?Q?KHlBgY5l5hdaJQwVWAEbhXQuhO9+jdb4RSQ62qEM0EUYvBp75Vt7QPV/52ZS?=
 =?us-ascii?Q?BORq8qTHuK0eXQ1iJZLGB9QIcac7Ckqzkt6krQ0usBh5psOQjJZYscbw7eSZ?=
 =?us-ascii?Q?xSDkZWJBMjUrbrcO6eI1QWgG5LzCt0/MYlPuml8dy8QeJbLUdrWNVXQYU3Kk?=
 =?us-ascii?Q?Pqn88QpHF9KJUefP1uOlYHNmHPFuX/JwU4TuvyzUpzGxfGPgeCfFR7Geb6JD?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a19242-5c7e-4228-c285-08da8b13d871
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 05:44:18.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qN1W1zYPEIHqqnmzuDOf+mIKjSON3y2XMj97rSSZisX+fOAevgNVBWW/++24BrE9np68CHozE929AqpNpmVaH4N3+weLMjimrXKpiTs4ys4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_03,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310027
X-Proofpoint-ORIG-GUID: i8ql36Mh-KCPH4I_fEUaaYz75BHfcDLK
X-Proofpoint-GUID: i8ql36Mh-KCPH4I_fEUaaYz75BHfcDLK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 30, 2022 at 09:11:54PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 26, 2022, at 7:08 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > On Fri, Aug 26, 2022 at 12:24:54PM +0200, Christophe JAILLET wrote:
> >> If this memdup_user() call fails, the memory allocated in a previous call
> >> a few lines above should be freed. Otherwise it leaks.
> >> 
> >> Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >> Speculative, untested.
> >> ---
> >> fs/nfsd/nfs4recover.c | 4 +++-
> >> 1 file changed, 3 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> >> index b29d27eaa8a6..248ff9f4141c 100644
> >> --- a/fs/nfsd/nfs4recover.c
> >> +++ b/fs/nfsd/nfs4recover.c
> >> @@ -815,8 +815,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
> >> 				princhash.data = memdup_user(
> >> 						&ci->cc_princhash.cp_data,
> >> 						princhashlen);
> >> -				if (IS_ERR_OR_NULL(princhash.data))
> >> +				if (IS_ERR_OR_NULL(princhash.data)) {
> >> +					kfree(name.data);
> >> 					return -EFAULT;
> > 
> > This comment is not directed at you and is not related to your patch.
> > But memdup_user() never returns NULL, only error pointers.  I wrote a
> > fifteen page blog entry about NULL vs error pointers the other week.
> > https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
> > This should propagate the error code from memdup_user() instead of
> > -EFAULT.
> 
> I take it then that Christophe should redrive this with your suggested
> corrections? I haven't applied this yet because I was waiting for
> follow-up.

No, that's a different thing.  If anyone wants to clean that up then it
should be part of a different patch.

regards,
dan carpenter

