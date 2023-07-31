Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8825376A4A3
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 01:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjGaXQY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 19:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGaXQX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 19:16:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FC090
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 16:16:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKNmWq024754;
        Mon, 31 Jul 2023 23:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Hi0U9XwWnF9qp7BTBnxBrawmN1H9XVaDFf4gRTdnxIU=;
 b=jaOEUCUOi2/wnFQH90LfMGAMBLtLq47gcYjwTtJgUIGxIBWBqDensEuhY2B5ICzeaD5H
 d+iF4CbUx/N8fFbHeNkya8gJu9sPCsKyYiZE2/ifgJ2aM7cv3B+L4o9BCvX8Atc8TWgy
 aH45gYXl1tWrabSny4j8TyXVsx9AYtgLuOahQ0cflsNc2vC1RuUu2vMsaOUWXWxAYede
 inoU/sX3qwv4e38MogDjZBgsBqerAdmAGWto4pRNm1y2TQ8byVl1+JqaSeG/yWRX7G6P
 H3WoNBAEFicoiuEYhMNHj+9PO4bFikCo6OgnRnzSnwB15AYzD+0GUb47NQD2V2rDjluy 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tnbbqv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 23:16:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VNBLXp008597;
        Mon, 31 Jul 2023 23:16:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bv8qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 23:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8MF+6ybtGBdp+3T3pQHV75AQSEzTbzt7LB30vz3ogNx5YG1XeuFIR98yyH0Nq4RGCKBzfKeqMyIgjMfZoi8GFfRZVVNxpkMs73/dOABcphjqiaf6ziglU43QpidihXzPKiUFCsS9olmMCMwMYJRViQraE0jHQ7UM77Dl7h18wMebDxb0MtEOscUNqVmnTXUNOG4bC2YrYRkw2X3lFBXrHAbmObpiumZfCf7znfTtaJLei/d3LpVfsqXHkdkUd+AfyZ4V3e3C5m992k2JidS6Q6b5NKIbf3SNGFuUyHNJOVfgNTC2gb+aWyrwBzJvlezE5F+RJXSyC0j7FUZ7PdUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hi0U9XwWnF9qp7BTBnxBrawmN1H9XVaDFf4gRTdnxIU=;
 b=PEMMaSKzLP+2ZuhAn8RvKmPssMGeugE7sbvmMxDXcV0831hGisZVwjnabXSDIgU12eeKnSE8L4effdPq27MmzbCCKPVAQM0oWBnxA2EX5gPLrEy90btv+36AjAenHbhQlyLhXBvbsGuP83Z/HFVT6cxYPKObjARO1hfR5RN9lW+2v10XS87DENQVwNo6JeEltOUuOaSzaZ57ye9DmR1BklMT+vLeUwltAwUHJ4/7RuPmQ6GPJCFxRNXFWmoBrtaOyIaaiFyglY6muidyMifhcDfidByuGlvKgloWCOpZM/OjYrUaXohltlJVFFc7AgDMd/4GO2djs++mSbQO5WPkGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi0U9XwWnF9qp7BTBnxBrawmN1H9XVaDFf4gRTdnxIU=;
 b=Mz+Xn17FVGBkO11TK1aM0ZZcGu3sVZfUZZVp3ihS1/hhRXwKE/uPsCIGoZV1vKtpCEnUmIXyhq/YRvBZvbTIR+sSA86D0r2+Ge2VXIQopUmrBiyKUWqDkpDJhPQS6qcG9m9Zi4SNGj00UqrbKW6iOI4r5ws0V23TgAg643gLcmQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5691.namprd10.prod.outlook.com (2603:10b6:303:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 23:16:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:16:09 +0000
Date:   Mon, 31 Jul 2023 19:16:01 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/12] SUNRPC: rename and refactor svc_get_next_xprt().
Message-ID: <ZMhAsTSHy4lcEdnE@tissot.1015granger.net>
References: <20230731064839.7729-1-neilb@suse.de>
 <20230731064839.7729-7-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731064839.7729-7-neilb@suse.de>
X-ClientProxiedBy: CH2PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:610:52::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9af30c-1fcf-4487-68c1-08db921c1fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZQLe+6K2KcnXdVfS9oo2A7v5pv11zvEVXvaaBz2Ngbhegb42y57DRAZU587I4GPxOg298glDptPihY1rGF27rg1i+3YijTL4GLnCgqTh1345gQWdysJzcnkvAn+zzultvHMl2qyoW5jwF5eMbxbu618QbNEMuVnWBSW8iIDeYi1eokocdGBsosrRBgjRivUCGSDZCzDrfMIV7JSz218ehGquQKsyOGWkh1nyOdd/VAcwyxGUwPKeqNTVCyGV9KqcgfSOwo7gufJuE7dmW8BqoZU9rWf9YujosKpxCDeCs42iMoCXbvtYtpq8PZ+of0AgB6B1kqprHEu+PXxSdUs/iu5IE7ca37+kzyycV/0v0w7f730v29/S4OrdiKTYY2ykfD6dX3L2mi4sFpPGMpWX0mUf/Oj56MUCjATGJla8sCWukGyRw3+FHssFgiAzD4Qra0kxUZaROtadBTG6eX9rtCVucYi8v/Mqh+znTMwE85Dr5X3euTUmc9axFQwiULTNxKQ3KYr1r0/AaYayxCQowwFGAbMPcnq4e8bAQsgWPaOu9qrHyQq3fovJCGTt5/s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(6916009)(66476007)(66946007)(66556008)(2906002)(4326008)(44832011)(5660300002)(41300700001)(316002)(6666004)(6486002)(8936002)(6506007)(8676002)(26005)(186003)(83380400001)(478600001)(38100700002)(9686003)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jcPTxPhOSlSbVoA6qvewrPQH6wxwMZ/ZFl7UqLhjz7aQ8YFoKat/Irf8tytq?=
 =?us-ascii?Q?MFi1cVW+Ami5sZ51xA6EG4JIYzlzUbCxN7OZ/pJB7CMm8+mmbjL+ulNqPXD6?=
 =?us-ascii?Q?WSx/BPbLrU3LGgZhS9CxsasNpzfB3k0zhAd33GqGj3L32SEUVOdI/0W7cnW3?=
 =?us-ascii?Q?KllRhx2/Io9nAA7tNAh+0A7mzKI/mmN+ZaXXKOo3keTjjNa3Jd9asqPOqn2S?=
 =?us-ascii?Q?5p1jUA4oLU4vGtGHCTsv1JHwH+EI0UACs8kn3fEpwedSBH8opa414PQsZbi0?=
 =?us-ascii?Q?6rg0p1mpjNih1yYnqC/5t1PNUmUOpVdWKL8hLUjdlOvBZwzRB9Ut3NxudExO?=
 =?us-ascii?Q?Ng0cWSa0vftUFEwwerBiWMWuGtQ34A/DUUj5SnhlIiS9oVNQQuyuC1/jQRkz?=
 =?us-ascii?Q?sf3hBo3AFAvTZ7coEfVrAqTqhekG3K5LerRddNmmkx2Qmsy/sy8wsJnvg60Y?=
 =?us-ascii?Q?Xwul+ytgqMjboqBG1tlByTNCWM9pVG/homn7Huw1LOhO281eeK8Q3rLXege2?=
 =?us-ascii?Q?q6SDs5LQAdWWEUPMSu0/3nlyG+iCymofn8sNlvWVUJygynnSxGDdFV7uV09j?=
 =?us-ascii?Q?+acgEtJjWp7Hshrcxqp0T+QwY/QpiuRNQ1LMbMwLYScLU9uSfAKt3Zjr6r0d?=
 =?us-ascii?Q?hx4VPzj7AbEMbnqY3tu5+CONbiyMdVqvZ0Y5kKQDONA756t/8mQ/Fv6/vvFF?=
 =?us-ascii?Q?CTwcYJjD0Q3rALvEbrRm40RrIiDKRF5la03ClPX487CY8wZ6p/1w9qtLjZ3Q?=
 =?us-ascii?Q?cD6SmdQ9MNq+9QxQChDzqQC3xmePUQ1ufFQ653jx+nGNCd0+7K4g1m/FK9cF?=
 =?us-ascii?Q?T/X4PHR3F/kAfLLf8pupZaQNknEL/HIVzUnmtYUoO2YGFuLJG+810JqG4Q5p?=
 =?us-ascii?Q?UVz67tM/UaLxUBEXzE6X+c0WqWxRU8nT753lyiz6Dge1oqP/CGPc1CWqvdNM?=
 =?us-ascii?Q?BNYsJtg8uwuDbySIpsOeh+WYADlRkuDmWooA0zEhZO2IfSg/g/4Rn6lR/OYD?=
 =?us-ascii?Q?VWSF/Zb2D9k2W5wpWyVotujUTVXm6ySfJzp2PTkGdVH1aZg5GTvi1313uQoj?=
 =?us-ascii?Q?w4fyAk5O4mJIe8iwRWTKKR2UNNClv0jfowS4oH1Il846lpCg3YqFF6+KRJRQ?=
 =?us-ascii?Q?M04prNFcbHpdCazlaAW8oa8bxtXefeySWKIumKoC452760LeUD0Qhyh5SSn0?=
 =?us-ascii?Q?3zCk33cqnxEEFHlGjpU2X5vgd0lYUVpLxx0ZbSVpWN8c0tw8/KPBEjZf/ET4?=
 =?us-ascii?Q?8OOch2WdpE3bEXJXAMxZFaNrs1p+IIEQktdqyRybvplrFswhDqjKRu14QcEs?=
 =?us-ascii?Q?TJWpSculhlLTEUliULLSYr8jk+Qm51QGN/wsnS6WcVzxrauAzdi3N0n5UTc0?=
 =?us-ascii?Q?swkFbYpLXEvB9v0vYxdqmGTA+cxD43M8SA+Wo+V17/++cfhHILV22I57aXkH?=
 =?us-ascii?Q?xG+4v34rNYY1jtmUz9ZvXEkxXTNO7nwVs3qxKUrKI1wl26Uhotfzi+gt54WV?=
 =?us-ascii?Q?8Y1/xY5uWletPQttvoVg4BckWUnVv3QzTHw826/bD4wV7WcGIOmNwUFHzSZY?=
 =?us-ascii?Q?Jk7427C8rMYEYcBikPWaAM/BxMFNdQQKlgK7e0WC1sSpRNOKqyhZmcSM0fPT?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +8genjl6e0s/2McjRozmG/8N7ohdUShBOHPsb+UHVrBXvXs5PIbQ35d6X+eOoD9FW2ZiHntq756oH1vn9ZiGUU8nR9ZyZOvE5XdTqzuhLl8i1XHkWI2MVR154sguZ0xHBXpQeOU0ZBwdkn7j+iXELxnqfk/nk8yUWHDXNvHQ6mlRPLkElQbDZ4BjIZs/FdPL1KwKKK+9NxvT3t6ccTKeEBdp3uavMeHYJvZzzBpH4HJM/r91SgipSBpFarkMX1I4RxxUZeQ3q3WCvs6TPbODF5tGixvYnOYJSioiSTzrFoZ0zK2rUiDEi59+HHu0WE/mda69fBqCCYZyCWehqtgg6LKlvrPHpim/TbkYm5dwncpiNsMaqBvm/xxjzJtilRyI2YJ1h/NqdG6kOf01xP1xIawTyGZN/KVSXYwfCLClPT/BL+FjZr4IQcUOE5nG7WRMn3ePtlZ74yT3T2SL1bpjvEM+u4UeTteeTa0H2gKFOjpIaCy+Z6XOxV28Za5pe+hrzg99v1uy2GkCVubJ+dMCOQ79ceDNdoJQXbUHj17QqnKVgHFZTi4eK4p069jo06e0u3IqvI91tn6RyZ2MeZgISfUTUzYgr3NwwYYYwYqFg4/9fzBNjV5E/GzKwgitHf/PXDyQPdE2qfhstEc1aJZuY2x6bO5unAm9/tIDxyltPVPt1bfyUo0G4AoS0Hnw/gm/vXdEPP0gasbEqT4g6IsMHbMesnZkV3XKO2VZkXWExpPdhBJdVe6w/KN2nm/4yJJUQZQmy+T08X6LW1VGixdxKRaCPVqDcQpKnz8Vkeycf1CESyIBMCsCaJAt+uQB1Acf
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9af30c-1fcf-4487-68c1-08db921c1fe0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:16:09.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bayf+pz64HsT/7GBf98Oj83gIQ4t15z5M8ICERWdH7VkWZA+dVdbS7gmvKAPjhvi6DRmho9kTBjzW6mt6gdWXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310211
X-Proofpoint-ORIG-GUID: SeNClzlXTYh31ZLxovAZcLMyLEmyJmyq
X-Proofpoint-GUID: SeNClzlXTYh31ZLxovAZcLMyLEmyJmyq
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 31, 2023 at 04:48:33PM +1000, NeilBrown wrote:
> svc_get_next_xprt() does a lot more than just get an xprt.  It also
> decides if it needs to sleep, depending not only on the availability of
> xprts, but also on the need to exit or handle external work
> (SP_TASK_PENDING).
> 
> So rename it to svc_rqst_wait_and_dequeue_work(), don't return the xprt
> (which can easily be found in rqstp->rq_xprt), and restructure to make a
> clear separation between waiting and dequeueing.

For me, the most valuable part of this patch is the last part here:
refactoring the dequeue and the wait, and deduplicating the dequeue.


> All the scheduling-related code like try_to_freeze() and
> kthread_should_stop() is moved into svc_rqst_wait_and_dequeue_work().
> 
> Rather than calling svc_xprt_dequeue() twice (before and after deciding
> to wait), it now calls rqst_should_sleep() twice.  If the first fails,
> we skip all the waiting code completely.  In the waiting code we call
> again after setting the task state in case we missed a wake-up.
> 
> We now only have one call to try_to_freeze() and one call to
> svc_xprt_dequeue().  We still have two calls to kthread_should_stop() -
> one in rqst_should_sleep() to avoid sleeping, and one afterwards to
> avoid dequeueing any work (it previously came after dequeueing which
> doesn't seem right).
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  net/sunrpc/svc_xprt.c | 62 +++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 380fb3caea4c..67f2b34cb8e4 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -722,47 +722,51 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	return true;
>  }
>  
> -static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
> +static void svc_rqst_wait_and_dequeue_work(struct svc_rqst *rqstp)

It would be simpler to follow if you renamed this function once
(here), and changed directly from returning struct svc_xprt to
returning bool.


>  {
>  	struct svc_pool		*pool = rqstp->rq_pool;
> +	bool slept = false;
>  
>  	/* rq_xprt should be clear on entry */
>  	WARN_ON_ONCE(rqstp->rq_xprt);
>  
> -	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> -	if (rqstp->rq_xprt) {
> -		trace_svc_pool_polled(rqstp);
> -		goto out_found;
> +	if (rqst_should_sleep(rqstp)) {
> +		set_current_state(TASK_IDLE);
> +		smp_mb__before_atomic();
> +		clear_bit(SP_CONGESTED, &pool->sp_flags);
> +		clear_bit(RQ_BUSY, &rqstp->rq_flags);
> +		smp_mb__after_atomic();
> +
> +		/* Need to test again after setting task state */

This comment isn't illuminating. It needs to explain the "need to
test again".


> +		if (likely(rqst_should_sleep(rqstp))) {

Is likely() still needed here?


> +			schedule();
> +			slept = true;
> +		} else {
> +			__set_current_state(TASK_RUNNING);
> +			cond_resched();

This makes me happy. Only call cond_resched() if we didn't sleep.


> +		}
> +		set_bit(RQ_BUSY, &rqstp->rq_flags);
> +		smp_mb__after_atomic();
>  	}
> -
> -	set_current_state(TASK_IDLE);
> -	smp_mb__before_atomic();
> -	clear_bit(SP_CONGESTED, &pool->sp_flags);
> -	clear_bit(RQ_BUSY, &rqstp->rq_flags);
> -	smp_mb__after_atomic();
> -
> -	if (likely(rqst_should_sleep(rqstp)))
> -		schedule();
> -	else
> -		__set_current_state(TASK_RUNNING);
> -
>  	try_to_freeze();
>  
> -	set_bit(RQ_BUSY, &rqstp->rq_flags);
> -	smp_mb__after_atomic();
> +	if (kthread_should_stop())
> +		return;
> +
>  	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
>  	rqstp->rq_xprt = svc_xprt_dequeue(pool);
>  	if (rqstp->rq_xprt) {
> -		trace_svc_pool_awoken(rqstp);
> +		if (slept)
> +			trace_svc_pool_awoken(rqstp);
> +		else
> +			trace_svc_pool_polled(rqstp);

Again, it would perhaps be better if we rearranged this code first,
and then added tracepoints. This is ... well, ugly.


>  		goto out_found;
>  	}
>  
> -	if (kthread_should_stop())
> -		return NULL;
> -	percpu_counter_inc(&pool->sp_threads_no_work);
> -	return NULL;
> +	if (slept)
> +		percpu_counter_inc(&pool->sp_threads_no_work);
> +	return;
>  out_found:
> -	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
>  	/* Normally we will wait up to 5 seconds for any required
>  	 * cache information to be provided.
>  	 */
> @@ -770,7 +774,6 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
>  		rqstp->rq_chandle.thread_wait = 5*HZ;
>  	else
>  		rqstp->rq_chandle.thread_wait = 1*HZ;
> -	return rqstp->rq_xprt;
>  }
>  
>  static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
> @@ -854,12 +857,9 @@ void svc_recv(struct svc_rqst *rqstp)
>  	if (!svc_alloc_arg(rqstp))
>  		goto out;
>  
> -	try_to_freeze();
> -	cond_resched();
> -	if (kthread_should_stop())
> -		goto out;
> +	svc_rqst_wait_and_dequeue_work(rqstp);
>  
> -	xprt = svc_get_next_xprt(rqstp);
> +	xprt = rqstp->rq_xprt;
>  	if (!xprt)
>  		goto out;
>  
> -- 
> 2.40.1
> 

-- 
Chuck Lever
