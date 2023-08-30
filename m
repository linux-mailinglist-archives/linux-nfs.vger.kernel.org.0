Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5FC78D821
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjH3S3b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbjH3Pfd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 11:35:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD25113
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 08:35:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9iR3h019477;
        Wed, 30 Aug 2023 15:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=8zt+cU525kghoT1pCRIGZlHkjecL3FCFyZsWKrY+yJw=;
 b=gkJQxP5skGePyFYGa0N2quDWH1W6StHTWtyS/gaUcsqWeR08uN+7XY0ue3JO723f0O1j
 DdGQ4KpEwdy+HBPaFwfzIMvV52R+jJBoao210/VgYi2QgKjYxXAKsQ7XMx4FDU9t+Cz1
 QiwRtASIpTEVjl4RqbDnwVxxiz4bmhSLCmSFwGNfA9kiw8OWi0+vua8/DZn1sSP9CM77
 lqvxGnASbgrkT827cLH/AcRZDzV5VE7CaV/BqYKm4qfJIklRJ+bPImarR909OSUUlGq4
 MjGgAsfI2ykrIARoDWlca0pUuddN1gWe/LOdLmF6tB0haloHk3vcaQ9Xd3mWtRDtQYbC Ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4frrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 15:35:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UF2bMk000443;
        Wed, 30 Aug 2023 15:35:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gcqvqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 15:35:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVqVxfsaMNG4zv7YViPJlCnX9slOZvP3z8u8uWrWqCbL8xNlL+M3oDc5cHlDQOf6TbMjBpjpmUyEGSWTsZlli5UDJJaWr7+piyAraVB1ud+g15Kx1K5WlOMVvxQi+l0l+HL7dOYrjHAyOTR86AYo0vOKDSvl+PE7tWPkJJoVobsQzqzGC22wxlLoe2o+6grDkkTbtc52l/8SQ98QMrns4YNuysu2U+fB+9OEHblcfxOes33nq5BbOMMnYMDWqs9EGw5SD1XTZukpiVY4bwDfBovPDCyDDHCyYDdEZgqh6SdEcy4ixMkmvoMX51mrXtcGaBtBs5x5x3jkQ28N3hz0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zt+cU525kghoT1pCRIGZlHkjecL3FCFyZsWKrY+yJw=;
 b=ml3ix29uVveuqmNk2T67tEOtVo2WybJ/KxPqLZuvkR6+JcJzhmpSPhqpFJ+qQX+lQKv6VYx+JDzgNCBcOEkQdSR9FDQxAijibfOrXQHgDK42cFF7EhzoaPfeLrWk7july+E4HD4kX7wDWMnh4pwFzgh5eyaf5w39f5Pb7e9jeUtfIRyTmDoR8GCdf+9CdjmLKbXq8qL1Urjz/t6Xwmi5gN8WFzgYJIhTwTHevuM5WYoC1pPsBx0q9P6BFT+VTtr9m4FZDbFOVhhVnxCJ5VKozNYRdLc9YempXFBnLeNetoTMREc2HJbZAqDSYJvZAJCHi/Un/KJL7g5UW/iJIc2Jwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zt+cU525kghoT1pCRIGZlHkjecL3FCFyZsWKrY+yJw=;
 b=bDl7G3gvRDGCl0bUrml3Lh2G+IYeItJL0ryq5HetHpfXoewMmv3HPxPFmWIpgFYHZrrcePLlm5fUSuG/118PbSi4TXkKmfoCeFAkB3bRzn+tuNb8hv8AuiyvKAYdDNbdtG1M50otng0U0GsJsE8spWS5DE2Jq//l31tnTTx7apc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5140.namprd10.prod.outlook.com (2603:10b6:208:320::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Wed, 30 Aug
 2023 15:35:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 15:35:21 +0000
Date:   Wed, 30 Aug 2023 11:35:18 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 05/10] lib: add light-weight queuing mechanism.
Message-ID: <ZO9htrRySAB+phNL@tissot.1015granger.net>
References: <20230830025755.21292-1-neilb@suse.de>
 <20230830025755.21292-6-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830025755.21292-6-neilb@suse.de>
X-ClientProxiedBy: CH2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:610:5a::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: cacb98d4-e2ac-4535-1c75-08dba96eb87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WH6Hnco6BD6AzuDaA4HyNNaIqkTVwgRG01+UhwppksJJFqHB99JmrIzy0YtPGWz9zyNlnawMaYWPi7QKNpTdVAwPnGmJU4aKbzywG+RyBryiBaaQgF2xnVgdgqx2Llbfs3AVGfIN71WB2GeyDeWLRcFO1JC9nuHmI9Ykw6Wy5+k2hfyls+XcQyU75EYB4NCHQtts531lqZwX8glbYdxWoOftkQfJFLsCoA/8qoEGLSm8vgpWOYB15ASRoiv+vxP0OReYEGM5ceaRJz9dVcNyPvs1Lvd3StraomHlIQq9T4sE62WEP4wShExzXyOVYpxD0Nt9YCtknK2rsZu44dqdtZF8h9ps0W+Ug1xmaZoV82YR03WBiHmAz+pmDeyO5gntO/yQdsPwmuus6kRnEE76wZPHIu00DCMsX0UAFnF89P1Z/5opRhaSMunJIgUYfFJaPizGlFf14/SIs/dAmyuCR2zwjNMqm7RxsKC3OrZEeGwmCAyD6Kr6nyy2YS531uXBbL+IUJ9F+SfxeZpNATz52pJuZ3WYW3hPrzJyJVES94LyBh2o8/baAP6JsAmoO+ECy1pzNIg7IDi0poN517xqBjHUiPK0fo4XzsCLzB7CRGTNiYJ1nwM2fk9/TcXGPZVTXkC098BCVKTUW085p76Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(186009)(451199024)(66476007)(66946007)(66556008)(6916009)(316002)(38100700002)(478600001)(2906002)(86362001)(8936002)(8676002)(41300700001)(5660300002)(44832011)(4326008)(83380400001)(9686003)(6512007)(6666004)(6486002)(6506007)(26005)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GEDcukQOfuTu4vVWhOYZm/n/Q+Le5LDuiSRzc7EQRfuqKSPonMJ/iaYka+pp?=
 =?us-ascii?Q?45u2MGioopq3uozjo3tT4tKQUjepqnngYtW5nTFvI8rPuhPQGQL+UmDCB/vd?=
 =?us-ascii?Q?B2HG2NS0mLG46y0A/d14zeghQvXXc9au5nb0+lXraknSTIGg6RizJmwr7Yhd?=
 =?us-ascii?Q?NxbwSSY25Mr6D9L+7FwkQDAEYbPZaTnrgGK8xakS63G9JyU464ImfWPCLj7y?=
 =?us-ascii?Q?xJ5V859/uK7KsJeS3SxQhKfgr6QfZZ/v5er62uh2tES9elUOjyHKAO+u9gw8?=
 =?us-ascii?Q?eau6JJOMIo2Iz6E8kmZqrsMI1f6x3WZro28+Xl/eQmMYGFHvdHT3xRqcU4ma?=
 =?us-ascii?Q?qoaR0t4N4CZITR/3ECnVdzU/bWjr+JFTqQ+LqfbTG+ENZB8P1itn5wdD8VAW?=
 =?us-ascii?Q?bI26/31sR1qlOVw1ZnQcgv0nP+ZMsG62EU8s7uhj4IPKavNXK/QSMubxBt1J?=
 =?us-ascii?Q?Pj2MwD+PrE3Go8Uptiy6uXTGTvjTUrhS1FPR5OdxupB9bvDLZH40lHSPLFnR?=
 =?us-ascii?Q?jWUY/4WluSNNhc8YRllS1Q22kddLiyGjBxAbs1yUIoZQSz2oJL5C/GZYjiLA?=
 =?us-ascii?Q?wA4Cn2Hcb0vmtYPa2RFVciZh1BhDpvvN6xFzutRO8mxBN5bYpVIf2hAtR7Sh?=
 =?us-ascii?Q?s4B9PQvaPVt26G5DVy7wxCjpxY+fWOa3cccPrYJYpQCLoaRsgJ7yxkXfPRfp?=
 =?us-ascii?Q?LUY35we0OsaIlkdcQ3mTWz4nGtK5azNOfrOiO+Ysj4B+XA4nbgjMZLrX0nBJ?=
 =?us-ascii?Q?H9NmuZ/Hu9sJzuAOfK9vTQFCQ3KE2UrvZNM5fmh1aOpbakGcPtHu8PJDqNxD?=
 =?us-ascii?Q?ik1OdMWOIT1BwhCw5X+dnm2k9rbTy1i9/wBUd3lyQDXojnz8rZn7H8Rk8jPU?=
 =?us-ascii?Q?JmIwm+l4AO+sYFbmgv9AAeaUR4lD919/PHQdg7sK1xnEMmzD/6go0LMleBm1?=
 =?us-ascii?Q?z2ABzYK4rDcLQ0C6lQCLETaU42OJ7ZfVNaL2wOUotSUVduKdvpukX7ZomiS7?=
 =?us-ascii?Q?WATMML+GyHCOY60LM0/hHU/hJWBktvlLreTi25cdoIoTac+YSUIVLea5JrW1?=
 =?us-ascii?Q?UpJ0v2+3sC4pgybrrnlZz7IdQOZ/UrCYES+xNAllMOxBxaF8wgyAuPIhcMBH?=
 =?us-ascii?Q?9vtywrOLGybzgomYT7tyG/uzI/imPgZ/h+ybB73yRSiR7vf0qPJF01m+PryR?=
 =?us-ascii?Q?w2TIwlfTjo4GOB2kr1AlkpujHGLQg1i8bKH0iGf8ph0vfZtRr3syH/UjYiMC?=
 =?us-ascii?Q?57w8AJFf2oH2maeUnopp+yTOSRJu117t0oNPfAUVm1rTsb2Ka9nwlpmVlz87?=
 =?us-ascii?Q?l/dl/NvH87eNauXBUtEbGJyx4+yAumhuOL3I4H57IyKh5R1/9L1ooslC2YlS?=
 =?us-ascii?Q?4MB8OaEr1BQNR6HvdfEs1v9uI1PoUcK6raZ1MytR3ftPeRvzijfDizhhU4Ul?=
 =?us-ascii?Q?+VLJ7594fXVmZFQbHhf/a52BSE+jMxek9QWdwwNlV9qouK/kytbuPXAGvkA5?=
 =?us-ascii?Q?36oi/SRScwvRgNebnhemsy8r6epCppy5oAx3GZA9lSpJU2Nj0jfWa6W191ui?=
 =?us-ascii?Q?/4WWmWlwmGX1AQtn6+A6r6idm/Mev+LmhFn2FPZtY97Oa7BBaMWewiYUlgT8?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0Kr3RJj4DF3t8L6Dw5Jn+Cm5MxxEe0uEux21BACDmNsKEaL61JNGqgE7Gio34t5fsCfxMNcx1ww4ErDu0Qp0yb1BR23h+k8jVguRgXyl9ahm7tQ2GWhvf9Y1fwKyRoOE06O9fMqYdU5nVWic6C4Na8y2OUSSHDNRCQPsMwfdxH90CIG62Uju513yTqFtxFV1KcwSh9woMj/xOj5SgfoYPlJ2IR5boXf/xLEtHjgwJtSYdWCILuSIE3sPaSPeZiHnRyRC3OijGhLN6DNz7YVXV05tAvdbXDskb77uixNqqGefucSFuUPhfiB2K6D28f5q/PbOqSeIDMq8UhKW8MJWPowdFc0nwvF+qaf1Cr58j3/uOuxk37ejUyaOrnyaYiKL/B5ez2ZLehMIFw/yvbkVjPDPuo4wF+nPI3I2gG0C4ah82qRNosCYOjknH45BPioMiGJkke/Zfvu7OGW5IknslKHr8rl5OLnHZk+Cx8uppqtXWri2aGGqDl2oI79LhoT/w2q8/EKcv26PyQHHS/fCEGJS7907niTnNFdA5naRLhWgGW3ncCdkNwVamQaWtcWaPNIyMfFN5mex9BH+qOS6u2LK34qFXlAqYJBTKkWA+FOn5eWqtV85yUuNr4E6HixQohqvSMBjGzK+41gV70ICvoGsezs+5VM0YpIvCA+3WQgMzIVHbBzD6VLrW27PL+0EOfQS4z3xQZK1a6mwl+YUphVMolEfAo2bmMFFjRX13sqCbCjhToNV/GpcaVLjxy1l0yhUj824DnH5BDmhrQly1qC/ylxsdN89wbRSBCS459Rx1ZwxLvNW1lwNSB7gdVus
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacb98d4-e2ac-4535-1c75-08dba96eb87d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:35:21.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acNwWv1dVpErdsSHbLibNA3a9MtAPhwJY6k8l5u0din1NeTAzh8uj54Mln+WkkakyL2EiIWT50w8cgyXJ+GIKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_12,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=892
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300145
X-Proofpoint-GUID: l0ZtNfZ1n-9Ga2DySiBLmPOp321CNp6D
X-Proofpoint-ORIG-GUID: l0ZtNfZ1n-9Ga2DySiBLmPOp321CNp6D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 30, 2023 at 12:54:48PM +1000, NeilBrown wrote:
> lwq is a FIFO single-linked queue that only requires a spinlock
> for dequeueing, which happens in process context.  Enqueueing is atomic
> with no spinlock and can happen in any context.
> 
> Include a unit test for basic functionality - runs at boot time.  Does
> not use kunit framework.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/lwq.h | 120 +++++++++++++++++++++++++++++++++++
>  lib/Kconfig         |   5 ++
>  lib/Makefile        |   2 +-
>  lib/lwq.c           | 149 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 275 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/lwq.h
>  create mode 100644 lib/lwq.c
> 
> diff --git a/include/linux/lwq.h b/include/linux/lwq.h
> new file mode 100644
> index 000000000000..52b9c81b493a
> --- /dev/null
> +++ b/include/linux/lwq.h
> @@ -0,0 +1,120 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef LWQ_H
> +#define LWQ_H
> +/*
> + * light-weight single-linked queue built from llist
> + *
> + * Entries can be enqueued from any context with no locking.
> + * Entries can be dequeued from process context with integrated locking.
> + */
> +#include <linux/container_of.h>
> +#include <linux/spinlock.h>
> +#include <linux/llist.h>
> +
> +struct lwq_node {
> +	struct llist_node node;
> +};
> +
> +struct lwq {
> +	spinlock_t		lock;
> +	struct llist_node	*ready;		/* entries to be dequeued */
> +	struct llist_head	new;		/* entries being enqueued */
> +};
> +
> +/**
> + * lwq_init - initialise a lwq
> + * @q:	the lwq object
> + */
> +static inline void lwq_init(struct lwq *q)
> +{
> +	spin_lock_init(&q->lock);
> +	q->ready = NULL;
> +	init_llist_head(&q->new);
> +}
> +
> +/**
> + * lwq_empty - test if lwq contains any entry
> + * @q:	the lwq object
> + *
> + * This empty test contains an acquire barrier so that if a wakeup
> + * is sent when lwq_dequeue returns true, it is safe to go to sleep after
> + * a test on lwq_empty().
> + */
> +static inline bool lwq_empty(struct lwq *q)
> +{
> +	/* acquire ensures ordering wrt lwq_enqueue() */
> +	return smp_load_acquire(&q->ready) == NULL && llist_empty(&q->new);
> +}
> +
> +struct llist_node *__lwq_dequeue(struct lwq *q);
> +/**
> + * lwq_dequeue - dequeue first (oldest) entry from lwq
> + * @q:		the queue to dequeue from
> + * @type:	the type of object to return
> + * @member:	them member in returned object which is an lwq_node.
> + *
> + * Remove a single object from the lwq and return it.  This will take
> + * a spinlock and so must always be called in the same context, typcially
> + * process contet.
> + */
> +#define lwq_dequeue(q, type, member)					\
> +	({ struct llist_node *_n = __lwq_dequeue(q);			\
> +	  _n ? container_of(_n, type, member.node) : NULL; })
> +
> +struct llist_node *lwq_dequeue_all(struct lwq *q);
> +
> +/**
> + * lwq_for_each_safe - iterate over detached queue allowing deletion
> + * @_n:		iterator variable
> + * @_t1:	temporary struct llist_node **
> + * @_t2:	temporary struct llist_node *
> + * @_l:		address of llist_node pointer from lwq_dequeue_all()
> + * @_member:	member in _n where lwq_node is found.
> + *
> + * Iterate over members in a dequeued list.  If the iterator variable
> + * is set to NULL, the iterator removes that entry from the queue.
> + */
> +#define lwq_for_each_safe(_n, _t1, _t2, _l, _member)			\
> +	for (_t1 = (_l);						\
> +	     *(_t1) ? (_n = container_of(*(_t1), typeof(*(_n)), _member.node),\
> +		       _t2 = ((*_t1)->next),				\
> +		       true)						\
> +	     : false;							\
> +	     (_n) ? (_t1 = &(_n)->_member.node.next, 0)			\
> +	     : ((*(_t1) = (_t2)),  0))
> +
> +/**
> + * lwq_enqueue - add a new item to the end of the queue
> + * @n	- the lwq_node embedded in the item to be added
> + * @q	- the lwq to append to.
> + *
> + * No locking is needed to append to the queue so this can
> + * be called from any context.
> + * Return %true is the list may have previously been empty.
> + */
> +static inline bool lwq_enqueue(struct lwq_node *n, struct lwq *q)
> +{
> +	/* acquire enqures ordering wrt lwq_dequeue */
> +	return llist_add(&n->node, &q->new) &&
> +		smp_load_acquire(&q->ready) == NULL;
> +}
> +
> +/**
> + * lwq_enqueue_batch - add a list of new items to the end of the queue
> + * @n	- the lwq_node embedded in the first item to be added
> + * @q	- the lwq to append to.
> + *
> + * No locking is needed to append to the queue so this can
> + * be called from any context.
> + * Return %true is the list may have previously been empty.
> + */
> +static inline bool lwq_enqueue_batch(struct llist_node *n, struct lwq *q)
> +{
> +	struct llist_node *e = n;
> +
> +	/* acquire enqures ordering wrt lwq_dequeue */
> +	return llist_add_batch(llist_reverse_order(n), e, &q->new) &&
> +		smp_load_acquire(&q->ready) == NULL;
> +}
> +#endif /* LWQ_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 5c2da561c516..6620bdba4f94 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -763,3 +763,8 @@ config ASN1_ENCODER
>  
>  config POLYNOMIAL
>         tristate
> +
> +config LWQ_TEST
> +	bool "RPC: enable boot-time test for lwq queuing"

Since LWQ is no longer RPC specific, you can drop the "RPC: " from
the option's short description.


> +	help
> +          Enable boot-time test of lwq functionality.
> diff --git a/lib/Makefile b/lib/Makefile
> index 1ffae65bb7ee..4b67c2d6af62 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -45,7 +45,7 @@ obj-y	+= lockref.o
>  obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
>  	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
>  	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
> -	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
> +	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
>  	 percpu-refcount.o rhashtable.o base64.o \
>  	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
>  	 generic-radix-tree.o
> diff --git a/lib/lwq.c b/lib/lwq.c
> new file mode 100644
> index 000000000000..d6be6dda3867
> --- /dev/null
> +++ b/lib/lwq.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Light weight single-linked queue.
> + *
> + * Entries are enqueued to the head of an llist, with no blocking.
> + * This can happen in any context.
> + *
> + * Entries are dequeued using a spinlock to protect against
> + * multiple access.  The llist is staged in reverse order, and refreshed
> + * from the llist when it exhausts.
> + */
> +#include <linux/rcupdate.h>
> +#include <linux/lwq.h>
> +
> +struct llist_node *__lwq_dequeue(struct lwq *q)
> +{
> +	struct llist_node *this;
> +
> +	if (lwq_empty(q))
> +		return NULL;
> +	spin_lock(&q->lock);
> +	this = q->ready;
> +	if (!this && !llist_empty(&q->new)) {
> +		/* ensure queue doesn't appear transiently lwq_empty */
> +		smp_store_release(&q->ready, (void *)1);
> +		this = llist_reverse_order(llist_del_all(&q->new));
> +		if (!this)
> +			q->ready = NULL;
> +	}
> +	if (this)
> +		q->ready = llist_next(this);
> +	spin_unlock(&q->lock);
> +	return this;
> +}
> +
> +/**
> + * lwq_dequeue_all - dequeue all currently enqueued objects
> + * @q:	the queue to dequeue from
> + *
> + * Remove and return a linked list of llist_nodes of all the objects that were
> + * in the queue. The first on the list will be the object that was least
> + * recently enqueued.
> + */
> +struct llist_node *lwq_dequeue_all(struct lwq *q)
> +{
> +	struct llist_node *r, *t, **ep;
> +
> +	if (lwq_empty(q))
> +		return NULL;
> +
> +	spin_lock(&q->lock);
> +	r = q->ready;
> +	q->ready = NULL;
> +	t = llist_del_all(&q->new);
> +	spin_unlock(&q->lock);
> +	ep = &r;
> +	while (*ep)
> +		ep = &(*ep)->next;
> +	*ep = llist_reverse_order(t);
> +	return r;
> +}
> +
> +#if IS_ENABLED(CONFIG_LWQ_TEST)
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/wait_bit.h>
> +#include <linux/kthread.h>
> +#include <linux/delay.h>
> +struct tnode {
> +	struct lwq_node n;
> +	int i;
> +	int c;
> +};
> +
> +static int lwq_exercise(void *qv)
> +{
> +	struct lwq *q = qv;
> +	int cnt;
> +	struct tnode *t;
> +
> +	for (cnt = 0; cnt < 10000; cnt++) {
> +		wait_var_event(q, (t = lwq_dequeue(q, struct tnode, n)) != NULL);
> +		t->c++;
> +		if (lwq_enqueue(&t->n, q))
> +			wake_up_var(q);
> +	}
> +	while (!kthread_should_stop())
> +		schedule_timeout_idle(1);
> +	return 0;
> +}
> +
> +static int lwq_test(void)
> +{
> +	int i;
> +	struct lwq q;
> +	struct llist_node *l, **t1, *t2;
> +	struct tnode *t;
> +	struct task_struct *threads[8];
> +
> +	printk(KERN_INFO "testing lwq....\n");
> +	lwq_init(&q);
> +	printk(KERN_INFO " lwq: run some threads\n");
> +	for (i = 0; i < ARRAY_SIZE(threads); i++)
> +		threads[i] = kthread_run(lwq_exercise, &q, "lwq-test-%d", i);
> +	for (i = 0; i < 100; i++) {
> +		t = kmalloc(sizeof(*t), GFP_KERNEL);
> +		t->i = i;
> +		t->c = 0;
> +		if (lwq_enqueue(&t->n, &q))
> +			wake_up_var(&q);
> +	};
> +	/* wait for threads to exit */
> +	for (i = 0; i < ARRAY_SIZE(threads); i++)
> +		if (!IS_ERR_OR_NULL(threads[i]))
> +			kthread_stop(threads[i]);
> +	printk(KERN_INFO " lwq: dequeue first 50:");
> +	for (i = 0; i < 50 ; i++) {
> +		if (i && (i % 10) == 0) {
> +			printk(KERN_CONT "\n");
> +			printk(KERN_INFO " lwq: ... ");
> +		}
> +		t = lwq_dequeue(&q, struct tnode, n);
> +		printk(KERN_CONT " %d(%d)", t->i, t->c);
> +		kfree(t);
> +	}
> +	printk(KERN_CONT "\n");
> +	l = lwq_dequeue_all(&q);
> +	printk(KERN_INFO " lwq: delete the multiples of 3 (test lwq_for_each_safe())\n");
> +	lwq_for_each_safe(t, t1, t2, &l, n) {
> +		if ((t->i % 3) == 0) {
> +			t->i = -1;
> +			kfree(t);
> +			t = NULL;
> +		}
> +	}
> +	if (l)
> +		lwq_enqueue_batch(l, &q);
> +	printk(KERN_INFO " lwq: dequeue remaining:");
> +	while ((t = lwq_dequeue(&q, struct tnode, n)) != NULL) {
> +		printk(KERN_CONT " %d", t->i);
> +		kfree(t);
> +	}
> +	printk(KERN_CONT "\n");
> +	return 0;
> +}
> +
> +module_init(lwq_test);
> +#endif /* CONFIG_LWQ_TEST*/
> -- 
> 2.41.0
> 

-- 
Chuck Lever
