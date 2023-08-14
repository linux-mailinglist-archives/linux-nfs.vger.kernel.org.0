Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C712577BEFA
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Aug 2023 19:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjHNR33 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjHNR26 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 13:28:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806EC10DB
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 10:28:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EGU1JW026760;
        Mon, 14 Aug 2023 17:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=pNBFXNdlhHC45ysVrtfpc1JlnRjRLtKWFxHtjSUClrg=;
 b=RU1n3ZKEaP9vhXCby7jI4ltmpQ6S+oI2KC4J2tp7L81TyRkETEGI8qjflefCOfzjlY4b
 TNUHyxZ712nioC4iIduW0F+cVcKxipK9oyvKMsc7drqt5ShDB8DHNrkfpBZj9KfHzMTc
 HHk7G0QrwIZwFy6JngGWgQSrvVECbOL68lmTNEYXbZoPQEK0gHanZzzyoirSj/lfwN5T
 ZXoUt7cl9pYzofY3PwBaBnrroocfyd4cF0pz3/BJrSpx8QFyfZGViR3ZT5a0ozZ+VPpJ
 D3D9+qvzvy/Or/3gjna6FFnSfYAC+qmqVg79IMahEtaZqLCtCgaT73qpq+yS74EbmZJ7 PA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5u4ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 17:28:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EGOb0H003677;
        Mon, 14 Aug 2023 17:28:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexygxjgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 17:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIXGJsCMNmFDvYDr5LV4XzYSuRWmatVIkriDJg0YZxTDqTODSQHg+Qum346Lxx+mC99Bln+eITrkjpWMgxV/L8y524X0lpyCebiK0oAYj1cc2QDuD5b/FBSngEvC1DFhaTFEkqrD4UeXOOV9XWTnCfhTreQwA2IGLhxo2suAtajmiSpbrDqE7Jrcll4oP+sCplmZFm4gDEJqN9IiRBGMkNA7pQ+zhVP78o6tq4NXTVD3LPnKL0v95GC3RaCISbqb94yX3InSsTPqhXFRGiGdB3p3Tnx4tbgYGiImXQuDs/NaJWooevCcJumkMiAJpluThh5/uVOtQxcdix3Bk6TZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNBFXNdlhHC45ysVrtfpc1JlnRjRLtKWFxHtjSUClrg=;
 b=S3L8eMs1EgOnhCK7GruLdV1uQx7L70Z0yL/2iaSguKrJ4ILomMTC7JA73giWMAzleGSX+oX6pL5+tR/jJCUQtwtJK/D9u9H5oNm0ZwRIb3Mw6hRE/rNZ1TF4tOxPpSiCzqHlqfMEaohBhS/X4F/6sC1Z7V92SC07EDFRxYmWUXvZC/psZYDmiwFMR1o1f/vs27GW95O4yvkgg7A8woRbkfHKgAqcqhNfyLskZ1j9hE6icVXcc/dsilTEu2KUh5IwtVdjurs5NSLMCJXOnN384cpd1d3D4Kys2K/1/TL13o84wyFXZjOpms2WY1hTtRyt48ZVipOFzfqtEwND0De/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNBFXNdlhHC45ysVrtfpc1JlnRjRLtKWFxHtjSUClrg=;
 b=vCsLPiWaFausPDeABqnlJ6jzmLW6DP90fy59ceJ8sfi18GVWnefGJWwIlgAtjWljWQ4he2Q0gAgLXKZpFw7GIJtuoyqJQri0UJLg086PpxuSTsJLXl77imrYeNKd67dMmsiOl2atUR5BAkAr5b0hKXCrlESwU8MMbUe8HwZwxqI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4470.namprd10.prod.outlook.com (2603:10b6:510:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 17:28:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 17:28:23 +0000
Date:   Mon, 14 Aug 2023 13:28:20 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/6] SUNRPC: add list of idle threads
Message-ID: <ZNpkNIlTHjEABvxY@tissot.1015granger.net>
References: <20230802073443.17965-1-neilb@suse.de>
 <20230802073443.17965-6-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802073443.17965-6-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:610:b0::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 93535ccc-d66a-4909-0375-08db9cebdc55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kideXhQbn73DMk73JJZCYrRhSnxjKAp5sPI5X87a6Meg4Fhd4DEFhY9Thxj/DNyS9rrOpk1eDB7l7/7bBatXDMTcTaH/eIzY7MIp3XFTtthY7UstGRdyr8TjRcbEX+UyDCILxB1boIgHMldgremzWwmrfSBu+EBVlSVnLOdQl6Vs0S5LOnAQHgCrXY6XQmGO8Xt3/EeflJoQX+ycH/j5gxmoG545r4DaFPMoHI694Ps+9eem4H3hRjYTcy/afgDfI48T+ynO44hUMHp1GEAzqd5Qsck8eFPucfjVEJGdou5r7opr0/i/Bi3oYmCMpWseuVknaPNXZ9wPfablWqDLpRulk/OB+xBy4Ngedk09flXnNSYMh8kr9dibey04YIHdg0tmbPrahwTBLJATNxhB6zWGd82fpbPWfElASGPSSbB3JElSWguzEAWP+D+rYykrAwJaLJuzFZRZVGkyxldYWLmnwdTu8megxYhhvQ/iNfPe2paUb6TvkGlteuxz4MwOiN9jkaznhvdSLPcYfE+qlXa69LHtDg3ag5tWz/bmw/7qcSbz+6+sV30xk1EsNe5N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(1800799006)(186006)(38100700002)(66899021)(6486002)(478600001)(2906002)(5660300002)(86362001)(44832011)(6916009)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXFI7STFXoAc2ynoAWTM/NS74y1tnRlDjdA1iIm1BDA+zE8hLkqiW+MsZz1b?=
 =?us-ascii?Q?onEOIupvg1F8ltcu7NIypMBiwnPcWJe2lYlTkRjHTb/6q34oflqGvI9WN2KA?=
 =?us-ascii?Q?s/gU9aUoprlWQ4NhmScKDll2cjinna7m4cewoDxI5/BzKsyKRnEmxf/0vRbg?=
 =?us-ascii?Q?NBvfubwvnVtE9Sc/Akdwel+pT+1G11XrQNHC6Bbc9H7G4z13Na1GfTnCoVQQ?=
 =?us-ascii?Q?UJQwCQ5Ifr/DPgRU0df1WjsDBROpLK98QoV7SxwX2ZQPapXmsjyXM1XCZ0/c?=
 =?us-ascii?Q?EZ0bGtyGX2QlSWywyQkJBTFPT7hSRTmAq6cJ0jS+0a/JunKA4hpIz6KHPrcm?=
 =?us-ascii?Q?23YRo31aj1n/j/8MfDQd/eg3iavi2dX2nszY4i/EWSgeMSBIjdoekhbACn0K?=
 =?us-ascii?Q?xCHnukXwAhHe1LecULRkfY1346SdJRcUKfdWXu5C/Jgv16IFScGe353Pj36v?=
 =?us-ascii?Q?wNkYuYFty3UFRYBa01VvrduyBUb0iHm+MwoaFhjDAQKdj6USEaIY8Td367qu?=
 =?us-ascii?Q?NY0frXOz5fkTxZJ57xwpVlQ5tGfrarhLhfl2+JAKTEcHuT/i9NoU78iBlP2R?=
 =?us-ascii?Q?XG09ul+2u9zG8Ix234OqYpP2oqDFPoKdhLohHUWreXi5io7N8mZefQI+MVIB?=
 =?us-ascii?Q?Q/CiuLwyaxk4/Uap+/C7t9ju2LVcOuwL1qDHDB2ObbDbXMpCyjsleayv2c2j?=
 =?us-ascii?Q?FiVS3c8rOm2114ODEPUE5nuHH8LoUlhyUyO+asdQP0/6KJ9yWb9xLmE0Ipd2?=
 =?us-ascii?Q?YTQKCI52h8AHsMwJF3H9j08hsLJMn9FmUlmsI3Iv8dC2Aruuq/0JkdHDv/ud?=
 =?us-ascii?Q?OQGvA9P/DZ772qMKASYI2I5/GfBdh2WT0t0+f3bk8X1onNU3JpNppHAdLgdV?=
 =?us-ascii?Q?J7EOy/iWKPS9KASJ2K6gvIIgBjcXlB+jhNN7C5N0gIDsOSoS7Ykg6jfx3U4R?=
 =?us-ascii?Q?gWrhNIySW7v0LRGGKlp3f1mItHAD1ftXr4giUEhPkxABzbkQfl0Ye4MPTWZX?=
 =?us-ascii?Q?K0+JiaOsCUxBoADxDrWujnzLHYIz3H5nboOpoSGf06M/prWqKuEpdr9+fQpS?=
 =?us-ascii?Q?BST40+jcZamS6RQxsz9ySEcoqI3HUIk644zzBniOEa3015s6JAceXA+E3Hdr?=
 =?us-ascii?Q?TgjMuxpYPDok/2DxdkADB1jtE/NT9CDH1qyCDgocO29yu0AgL6jOz0YEWz6C?=
 =?us-ascii?Q?g8ka/+OdyGbgoO3wwIHdVoud7RiCtDItZgtMRuHGondskaeb1/gB7oY/Z15I?=
 =?us-ascii?Q?JsWhYnHxvPgoytjw7ph0q2gmC/bEFOYsGX7ZiZmBhWZKtRL/NCgi7WZs4vXc?=
 =?us-ascii?Q?bdwuvIjt3FBWOGjY82PLHmdeQYutKNRUucs0h46eG3w4DuXxXhJngAvlug6y?=
 =?us-ascii?Q?5FW2TIJ5knCU/JgkuEpj4Dk7hNJTqQ/DottU974ZVL7/B4ilgYfeKlSvHdc2?=
 =?us-ascii?Q?JYWbpYXmLKyEg5b/UxqbZfJtV0jAVfkq9uEl9OnPktIbCtiRcTkpbXjZi77h?=
 =?us-ascii?Q?XGsD/MllLkKFjcJyVGYxljknyFfLs2wlruvGMK1WswHl4L4WsCk0UYf5xIER?=
 =?us-ascii?Q?5OgSY1jy2d/9YH3HQyyqiuhH0q4d3AgLZh4MmqnpcDHWku64GGkLFrGkgA1E?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jeoboDjRer6/AHuc8BzyPqtqxbdNL3OoZvODd1PYdh9GE/tw3KHVyztqkOTUpTQPNHI3N8ZtaNJvNy3TupWw4apH1dtXhnvufvr8rkn4LQZpyaV/PwGXlFzvD2XDeLsk2iWK49JZBJb2zVGI2HBnNGC/vGxos+BFzDQ/2YTZohyvZi70Q4rTag8MhuG0qvWky8byIROFfhNPR9ApoS343u34tC187dNCKNOVRgSX9bbK9TjtkJhkqnD9BpEJmhmc8GleC9idpd1AjHeTKExwSbYkPPtqNM9OrmTYb2r1n3xXSb34DAHTUxwN0Mq+tu65UpeJ9bIEuE0uf/bwNMfuU/UdeSANewEivV3A2tqC8vYl/M6GSsg//LrHVkpsSjejET6yOW4HLQELrd5wiUevXMXNj/nb/ajpRAAT1Pv0DCbMudxTgOPnHwxRM472vPslbdYCSJ8F3SDP2I95VD+/cJ3RsWlMIETStcyncM27Mq3AO0Ubz3Fy+T2hp4sspXvZGXtDRCjYWcU7GXvW8l6ZUPu/cCqVXTbinrZ+Px6zN1rUIKTMDkIgLoJNoyXWY9HU9rWEl91usIz3KBkPiJUu8KEki8/hHR/8xQn0nUbVnyQqtp2Kaj1EUtJrqD6h0nkrhYDnCDPZv7c4jB7J7UtDIuzfiFH1LKCIeQXPKfP6xt0f1t2JEakMW4hhAoIpBAJuA/Rre8f+X2Ly4zEbHdDQ7pGYTGs00VCIEcWX9RIKp6GKSW4mduiwRa0jM/lAs8ZhjOKLGZLJDm9fZeENrXVnEFCvgbkGqwEuH7y4odcNscl5bvf72T/d3bTBvRXAgUvW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93535ccc-d66a-4909-0375-08db9cebdc55
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:28:23.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0EhGF35GDLMkX8NkkFQ7Qo/texpUupGsKipCwHhJIPIiZD5a+7Qrx44oIt/BxlnYp85gAuDFDJDZ0sJgnY2/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4470
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=970 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140162
X-Proofpoint-ORIG-GUID: bcdDKOmyVZzIl2d4wgzmvGc-8oJ436Et
X-Proofpoint-GUID: bcdDKOmyVZzIl2d4wgzmvGc-8oJ436Et
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 02, 2023 at 05:34:42PM +1000, NeilBrown wrote:
> Rather than searching a list of threads to find an idle one, having a
> list of idle threads allows an idle thread to be found immediately.
> 
> This adds some spin_lock calls which is not ideal, but as the hold-time
> is tiny it is still faster than searching a list.

Keep in mind that b1691bc03d4e ("sunrpc: convert to lockless lookup
of queued server threads") did the opposite because that very
spin_lock was highly contended. I am skeptical of the above claim
without lock_stat data... but that's sort of moot as this is a
temporary situation, as you point out next.


> A future patch will
> remove them using llist.h.  This involves some subtlety and so is left
> to a separate patch.

Since I haven't seen that patch yet, I'm reserving judgement about
whether and how these two changes might be merged.


> This removes the need for the RQ_BUSY flag.  The rqst is "busy"
> precisely when it is not on the "idle" list.

I've been having some trouble with this one. The server system
deadlocks hard as soon as the NFS server starts. I tracked it down
this morning: this patch never initialized the sp_idle_threads
list_head.

I will apply this patch (with one-line fix) and the patch that
removes SP_CONGESTED once I hear from the client folks on the
"integrate backchannel" patch.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sunrpc/svc.h    | 25 ++++++++++++++++++++++++-
>  include/trace/events/sunrpc.h |  1 -
>  net/sunrpc/svc.c              | 13 ++++++++-----
>  net/sunrpc/svc_xprt.c         | 15 +++++++++++----
>  4 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 1ac6f74781aa..8b93af92dd53 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -37,6 +37,7 @@ struct svc_pool {
>  	struct list_head	sp_sockets;	/* pending sockets */
>  	unsigned int		sp_nrthreads;	/* # of threads in pool */
>  	struct list_head	sp_all_threads;	/* all server threads */
> +	struct list_head	sp_idle_threads; /* idle server threads */
>  
>  	/* statistics on pool operation */
>  	struct percpu_counter	sp_messages_arrived;
> @@ -186,6 +187,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>   */
>  struct svc_rqst {
>  	struct list_head	rq_all;		/* all threads list */
> +	struct list_head	rq_idle;	/* On the idle list */
>  	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
>  	struct svc_xprt *	rq_xprt;	/* transport ptr */
>  
> @@ -262,10 +264,31 @@ enum {
>  	RQ_SPLICE_OK,		/* turned off in gss privacy to prevent
>  				 * encrypting page cache pages */
>  	RQ_VICTIM,		/* Have agreed to shut down */
> -	RQ_BUSY,		/* request is busy */
>  	RQ_DATA,		/* request has data */
>  };
>  
> +/**
> + * svc_thread_set_busy - mark a thread as busy
> + * @rqstp: the thread which is now busy
> + *
> + * If rq_idle is "empty", the thread must be busy.
> + */
> +static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
> +{
> +	INIT_LIST_HEAD(&rqstp->rq_idle);
> +}
> +
> +/**
> + * svc_thread_busy - check if a thread as busy
> + * @rqstp: the thread which might be busy
> + *
> + * If rq_idle is "empty", the thread must be busy.
> + */
> +static inline bool svc_thread_busy(struct svc_rqst *rqstp)
> +{
> +	return list_empty(&rqstp->rq_idle);
> +}
> +
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
>  
>  /*
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index 6beb38c1dcb5..337c90787fb1 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -1677,7 +1677,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
>  	svc_rqst_flag(DROPME)						\
>  	svc_rqst_flag(SPLICE_OK)					\
>  	svc_rqst_flag(VICTIM)						\
> -	svc_rqst_flag(BUSY)						\
>  	svc_rqst_flag_end(DATA)
>  
>  #undef svc_rqst_flag
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 1233d72714b9..dce433dea1bd 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -641,7 +641,7 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
>  
>  	folio_batch_init(&rqstp->rq_fbatch);
>  
> -	__set_bit(RQ_BUSY, &rqstp->rq_flags);
> +	svc_thread_set_busy(rqstp);
>  	rqstp->rq_server = serv;
>  	rqstp->rq_pool = pool;
>  
> @@ -702,10 +702,13 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
>  	struct svc_rqst	*rqstp;
>  
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
> -		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
> -			continue;
> -
> +	spin_lock_bh(&pool->sp_lock);
> +	rqstp = list_first_entry_or_null(&pool->sp_idle_threads,
> +					 struct svc_rqst, rq_idle);
> +	if (rqstp)
> +		list_del_init(&rqstp->rq_idle);
> +	spin_unlock_bh(&pool->sp_lock);
> +	if (rqstp) {
>  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
>  		wake_up_process(rqstp->rq_task);
>  		rcu_read_unlock();
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 0a300ae6a7ed..e44efcc21b63 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -737,8 +737,9 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
>  		set_current_state(TASK_IDLE);
>  		smp_mb__before_atomic();
>  		clear_bit(SP_CONGESTED, &pool->sp_flags);
> -		clear_bit(RQ_BUSY, &rqstp->rq_flags);
> -		smp_mb__after_atomic();
> +		spin_lock_bh(&pool->sp_lock);
> +		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> +		spin_unlock_bh(&pool->sp_lock);
>  
>  		/* Need to check should_sleep() again after
>  		 * setting task state in case a wakeup happened
> @@ -751,8 +752,14 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
>  			cond_resched();
>  		}
>  
> -		set_bit(RQ_BUSY, &rqstp->rq_flags);
> -		smp_mb__after_atomic();
> +		/* We *must* be removed from the list before we can continue.
> +		 * If we were woken, this is already done
> +		 */
> +		if (!svc_thread_busy(rqstp)) {
> +			spin_lock_bh(&pool->sp_lock);
> +			list_del_init(&rqstp->rq_idle);
> +			spin_unlock_bh(&pool->sp_lock);
> +		}
>  	} else
>  		cond_resched();
>  	try_to_freeze();
> -- 
> 2.40.1
> 

-- 
Chuck Lever
