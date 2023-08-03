Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2326676F321
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 21:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjHCTAz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 15:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjHCTAy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 15:00:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581EB35B5
        for <linux-nfs@vger.kernel.org>; Thu,  3 Aug 2023 12:00:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373IoAGJ016616;
        Thu, 3 Aug 2023 19:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=9S74qYtk4ccsEsF5NrOHw/KumIBmFielZkm6KO/9X3Q=;
 b=sfK0JbXEZXKFv+M1PhiFr4oAp2DBvd/S7nsNnTQ220IWtT4cfUQ9E8dfGHhQI+E+jS9i
 25sjGT3lRZxF+2dNIMk4+MSndbLGfB6rwZHleC1po99Zv4q7BP4Sf2VTNckIs2u9BdET
 tQmo3yXCFsFKuuUX2B53tQAQvfjHtxUGzXABJ8c0+ZGetMcYAV+vwW02CoWV5ANdWCAQ
 lMD53+NdLUcTg7apVn/2+hafbg5fgxqc0CiSdiuUVu5Bu/NNDTjUl3V3lyvQ4oxD41UP
 +88+iyxGZ1cs7+sHBLOZ3bYzco5/LYMXKKVn3v7y/hSxc5YQFb4lt5mjhs/jqdHRnGdR 9w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav2ag1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 19:00:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373IHumK006943;
        Thu, 3 Aug 2023 19:00:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s79wfd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 19:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL40axmZTUd5meNQHT/TX2n46MDrp3HyVuohMxTHEgYV72GEFR29PhlczzDAwl3ltlZlKhemxqi5G6QufeJ+YVZmXYNeTARTEn6w3KJGARiyZ09ssHlAVhMXjBOSwYo2iEhgAMKrzEv8WQLJQnhTDoeCyuA9h/g05Oe1lz5+/Xjei6zUQbsUELulqn0ODLiWnbqJCRumXmQBzfzCub3xP5qdqscUxT1IB0ljiCByozDOnB3sw1ECqa5qR24mvyznQJ7rhkBuV92E1J9AghQhzsvMa92uIOCltrg2Hzdnayi3Hu65Vy8ibo+7SqOcVMktpThQRDxIDvYBeT9mhjNetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S74qYtk4ccsEsF5NrOHw/KumIBmFielZkm6KO/9X3Q=;
 b=I5QS++YZNMNdEmylvwjMjHUrjo3veBX527yjLfxsSuCZU6LjJLehSsXN0gbpkTBlpEF8pr+t2WxGRk4/5GgJE5aWGlZ6Q4eaI/KspDoZ2JZWSik2eCSMtcutHa2JbLN+auHAfIztmyT+NjW2sBAhAeAsL3/i+Vzj3pDOUuHOUQuxZ1LrbileEeo+0CzEpAsxVGSRZiIn7MYYgRLnOhkY1f0Q2Zcisa5ZM0hgahqNLAnU6KIDxn6olBXh7Q8oYXJvdTCchinctkW3ec5Eo0mByxc64zYVqZmeZdb+MZ0iq2I8g3XCv344XHv8l407ibcg7lwS+LeNyacMznFLX1LPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S74qYtk4ccsEsF5NrOHw/KumIBmFielZkm6KO/9X3Q=;
 b=ICXKPrP/uVgazbFyXoabqoLasvxzFwo/lLDKVbRipFFgyONchezytcta1EoUZsQporr0cV5M5k6TnVDNgqNNlmEaRR2RwoyHMA8IssPUlMLP7I9++TxOWJLjkM/hFdKH84Mu7fc12VIFsXt2l8FpmhEljgjl3NKQI/EzEfbhzes=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7085.namprd10.prod.outlook.com (2603:10b6:510:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 19:00:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 19:00:36 +0000
Date:   Thu, 3 Aug 2023 15:00:27 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/6] SUNRPC: rename and refactor svc_get_next_xprt()
Message-ID: <ZMv5S7k4iCQgYXZ4@tissot.1015granger.net>
References: <20230802073443.17965-1-neilb@suse.de>
 <20230802073443.17965-3-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802073443.17965-3-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0439.namprd03.prod.outlook.com
 (2603:10b6:610:10e::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afdef45-259f-4af0-9973-08db9453eba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ktnj/i5PPAEQkYy4Rv6B1zitJA9ni+AN5vHrizsBloJ1PQMV1nyXxAZXkJdjqoDJyYXMizzYH4n6uVZa0ex1eExbGWO/253YuFp6txk7k/6JVKVnGzDhuSUzRdzncjBBlJ1Bwm/jSrw2QbwKRi9YnCHndwE7r10U9lR3yOALmCA7/swVfsXpojTbJzOD5Hx182WYpiogUA3quaY2xDyAnT5GJQs64ltVRyVQzD3xwk8jtuwcFp99vbzTGj5OxLbB8JpRF6Yvzn537mu/5qs8Tt8aBkrUc+CbtYGiHNXRyGo9+1vkFOAPd1BDThJfosptZwqiW4sUufblRRc4qKcoExVyIz/D9ocLxLhqL1ttwf2efWHnQtUon3rqEQN+BvhKXfExKm9xGPMFKMO7A3pVKLSN8Kanw22a5ft5khIcr4s2wkTDDS7OaBFiyS2CaAwwTE5QhKoooCOm0AUZ10Kt/I5WRrX0GvES1t6Mr4yj214WT0HMZ5lgCbNwdrv0E8v4e7zQ48E/nO54SufCfxiT0+ceGo68r8SFFFWHjbzCcSGLV6HO7GeoHUroqoTu8Hr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(86362001)(478600001)(38100700002)(6506007)(186003)(83380400001)(26005)(6666004)(41300700001)(8936002)(8676002)(9686003)(6512007)(6486002)(316002)(6916009)(66476007)(4326008)(44832011)(5660300002)(66946007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewkWpMH0+K3K/K1QhlpJ9TkelLhbAid4p1TPQAnRwHopzQLwcMoOeNt1Sbr4?=
 =?us-ascii?Q?VfP/rYmX42ZbkbjQNRwS/WXCHFjvjv3zJNzGf57mfXbPZGxA5TnOJBSsyoWM?=
 =?us-ascii?Q?qOw6ZkY4fY5dpRZLeFNw01PMNK7uIAX+MJTMBzSp7lWAGqd2FxgRGv0CuYez?=
 =?us-ascii?Q?VVa/0IxV9fT2NqBo7YxH9bOMJ7kWSSpwVmIQSv90xOQiZuHjRQvttuAqw6du?=
 =?us-ascii?Q?/r4xVnw79Gy5I1jhULp8WrdJTQFcMieQWU62SQK1UwA2yUPwOSt1UPdfuVv9?=
 =?us-ascii?Q?FxjI7O6pnxWINRgFKCeShvEF6kHwbXho88XUihl2HbEpW5JtAHNO18Vijum0?=
 =?us-ascii?Q?ld5a3/Kuis5SYnOKOkpF6Dq5whKoAdfFiREkva4k31K9/0+rfQ7J3RqOyBwp?=
 =?us-ascii?Q?9/CbIt3LNeeJAgV6FSwZSteZDAXGmNI+/sBuDT6UPB/6tUoyLZL2TzM/EE82?=
 =?us-ascii?Q?nOkT+QoKJBpBq5McM4SwlpOrtEYVAYpexHHHUHvo04dqODB8R2IjelxOiW29?=
 =?us-ascii?Q?Y6hvmPsrwjdY5aSV++NHkU92IGuwMkFCUmc5dzYKAqTXr441aegRCeEJrn8P?=
 =?us-ascii?Q?NHIzyyvKXGE9P21iazZT9uCYaAl/TiFWb4sdDeGjs6jkGlbFBbbYduDoqK6G?=
 =?us-ascii?Q?s/eDfgc9AxmqRYT4twuup0gVjIrLUjvw3WTYdTGsQ0gbH/vJZvFNtJNUX90q?=
 =?us-ascii?Q?5osvAkxf9FoOV0T5LmzRI5fvfFSJiejQN3bmqgvYahTjN5LDoSkNzGgpIJDU?=
 =?us-ascii?Q?X2gY2RboyZwZmVSg9BnfqF9QJhLfzRnzN//4cwNZGhqIxWfdV4XSCxsdTG7p?=
 =?us-ascii?Q?xZ9MFIUD8e/s1Qeoi0VI3Brv5cNH4IDZCQ/7LMwtqiQwy82sENZiZ3fNHbtj?=
 =?us-ascii?Q?KnQSgmYW0wiBVFR7aWjiug0H2lLfgT8xJ9MiKhWO4lDS+gQ5VAwsnRZ0jsXs?=
 =?us-ascii?Q?dH9lQ0lchkXH1E6KNOD+vfwTpZDfP77lUUJ2u1eHxqSA5kcoRqYUueRgqh+I?=
 =?us-ascii?Q?u3sPt4/slKlJpIlCGPAbacIvnnvPlJP7D6iQ4ctDfHKrGHZPlDpH/I2hsI4g?=
 =?us-ascii?Q?MyzWXFO09i6UH/M4rRa4xZqBv7IyGO0eYZ0ZuieA96GKES1phMQucdnvMr7Y?=
 =?us-ascii?Q?McTTJABf5G0IcJ9dqpUA/V1j50Mtt2vmquzcWKd2HZlvqQTzB5TJYJAgX2op?=
 =?us-ascii?Q?DO8RLxhonJxmcpjNh4/U7QH+f3aQbZX68KJngC/VqJwxDychbdmpGZRmJlv9?=
 =?us-ascii?Q?p08XwtslXr+rDRH/S+GDJnaC2UaurfW/854YnBUFNTmluJCYXHVUzRn545ry?=
 =?us-ascii?Q?y0X6Ig96CorXLvVmSGHF06Fu/jLBBo4sL1yh3KW6pL8rddN+e8MsRootiGLM?=
 =?us-ascii?Q?LMPPgnXOE/Z9+0ApFapHjfZGObkSzurAlTDsvERiprJspqXw4/wOmfyH3m4C?=
 =?us-ascii?Q?hnfGXtDUuBVbVtxWNXX9kBKuz5vHWggODqQGh0ImoWIGtGeg3Yn7Ovcs8efL?=
 =?us-ascii?Q?P6TjPI9qXI7bl5cJ7bEy7H78rpTgzCKm9ueBcjm2cXGszf3C3aExMLWHFkUO?=
 =?us-ascii?Q?pZ4Fr0F/VuChjzFxksBOb9VRMG+EmdnQwwrfaMXoj8vKXpo4y9Mo2HqtP/V0?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gdB1GNgLXolYU7NHkJlagIKsFgF/OagB6FWKZFKk9PRBmFsTsAe7bduaJjOxTyncSIsNMno58NsireHrHbebw1kwmSXbT2gzWR0Ton1OUkMTvgyqmYLvOuCzGBoUQFQb8gLFMjavDhEPeYB/JxTpX1kzKLj8cTm0LpdfolTuesT+64RM0eL5Hl0qyPM+vjrnsrkyy85xl+09POboCCzoZUsMeRYVEkovBjGx6LqxYsRb1AARZpDxEiBCL2KOf9F98df1jf/hxoRCYTFFJAcS60NLLwb0PcbQowwHAjKO+sw/dVU3shaESQjvlN5sySlsjEQjDbdLb7+lVTgK6PcrkjZ565WRQMYYXV3ZpOcUsh/jmqqjFvLU7vwt9bH0Z1A8v6hw6ZpWOkGD2uyraGVSzstW7zXkpHJQNJVBIXnrMZhyl8SOLicaBqdPY7Te1D7bps9F2QF/an7+RxNpVmnjx09ujLvwCDj/VT5S3OpMySK9hOairwsFUvfB4wzGFsnSix5F+AN/d7kR4wRxhXXY3BkVtbCuJ+hVa0Xc5WrC4pS6q0UCzIFZ8qZPPXShh0VciY0qyTPixTjM6ZDSZJUAGn8+n8mVxSuFDDoaEAzg2LD4j37nzxQB4w7xK0Ym8fMv/IwxNiwH3RaDQyX2469E/vMjdiKBWwac96OUJjkJCCRsTskIzRdZD3jf89n/S6kdRTMdrVeACB1MAUIPXlzeTMwCbuHu2N9ij4EoqFUZLRS1jF261j9F/eILGKCcXkkZroVcjBCMd2ubUWfXtvEwurBsrp+6SZTvGb3HA3x7qF7iuTfitpAEMbJafmyE29YP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afdef45-259f-4af0-9973-08db9453eba4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 19:00:36.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsfpCFY1y5YbWR3udHmtXEP+knu9v9G2Pc8SLOBbUOFv3jOMVMEN1hEJp3hh+ejAQImCRZheSGca+MrBAyY8lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_20,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=707 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030171
X-Proofpoint-ORIG-GUID: PN5xsHqvtwbS6hYnOvt2Q7G4XWP_H3wY
X-Proofpoint-GUID: PN5xsHqvtwbS6hYnOvt2Q7G4XWP_H3wY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 02, 2023 at 05:34:39PM +1000, NeilBrown wrote:
> svc_get_next_xprt() does a lot more than just get an xprt.  It also
> decides if it needs to sleep, depending not only on the availability of
> xprts but also on the need to exit or handle external work.
> 
> So rename it to svc_rqst_wait_for_work() and only do the testing and
> waiting.  Move all the waiting-related code out of svc_recv() into the
> new svc_rqst_wait_for_work().
> 
> Move the dequeueing code out of svc_get_next_xprt() into svc_recv().
> 
> Previously svc_xprt_dequeue() would be called twice, once before waiting
> and possibly once after.  Now instead rqst_should_sleep() is called
> twice.  Once to decide if waiting is needed, and once to check against
> after setting the task state do see if we might have missed a wakeup.
> 
> signed-off-by: NeilBrown <neilb@suse.de>

I've tested and applied this one and the previous one to the thread
scheduling branch, with a few minor fix-ups. Apologies for how long
this took, I'm wrestling with a SATA/block bug on the v6.6 test
system that is being very sassy and hard to nail down.

I need to dive into the backchannel patch next. I'm trying to think
of how I want to test that one.


> ---
>  net/sunrpc/svc_xprt.c | 91 ++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 48 deletions(-)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 60759647fee4..f1d64ded89fb 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -722,51 +722,33 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	return true;
>  }
>  
> -static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
> +static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
>  {
> -	struct svc_pool		*pool = rqstp->rq_pool;
> -
> -	/* rq_xprt should be clear on entry */
> -	WARN_ON_ONCE(rqstp->rq_xprt);
> +	struct svc_pool *pool = rqstp->rq_pool;
>  
> -	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> -	if (rqstp->rq_xprt)
> -		goto out_found;
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
> +	if (rqst_should_sleep(rqstp)) {
> +		set_current_state(TASK_IDLE);
> +		smp_mb__before_atomic();
> +		clear_bit(SP_CONGESTED, &pool->sp_flags);
> +		clear_bit(RQ_BUSY, &rqstp->rq_flags);
> +		smp_mb__after_atomic();
> +
> +		/* Need to check should_sleep() again after
> +		 * setting task state in case a wakeup happened
> +		 * between testing and setting.
> +		 */
> +		if (rqst_should_sleep(rqstp)) {
> +			schedule();
> +		} else {
> +			__set_current_state(TASK_RUNNING);
> +			cond_resched();
> +		}
>  
> +		set_bit(RQ_BUSY, &rqstp->rq_flags);
> +		smp_mb__after_atomic();
> +	} else
> +		cond_resched();
>  	try_to_freeze();
> -
> -	set_bit(RQ_BUSY, &rqstp->rq_flags);
> -	smp_mb__after_atomic();
> -	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> -	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> -	if (rqstp->rq_xprt)
> -		goto out_found;
> -
> -	if (kthread_should_stop())
> -		return NULL;
> -	return NULL;
> -out_found:
> -	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> -	/* Normally we will wait up to 5 seconds for any required
> -	 * cache information to be provided.
> -	 */
> -	if (!test_bit(SP_CONGESTED, &pool->sp_flags))
> -		rqstp->rq_chandle.thread_wait = 5*HZ;
> -	else
> -		rqstp->rq_chandle.thread_wait = 1*HZ;
> -	trace_svc_xprt_dequeue(rqstp);
> -	return rqstp->rq_xprt;
>  }
>  
>  static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
> @@ -858,20 +840,33 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
>   */
>  void svc_recv(struct svc_rqst *rqstp)
>  {
> -	struct svc_xprt		*xprt = NULL;
> +	struct svc_pool *pool = rqstp->rq_pool;
>  
>  	if (!svc_alloc_arg(rqstp))
>  		return;
>  
> -	try_to_freeze();
> -	cond_resched();
> +	svc_rqst_wait_for_work(rqstp);
> +
> +	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> +
>  	if (kthread_should_stop())
> -		goto out;
> +		return;
> +
> +	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> +	if (rqstp->rq_xprt) {
> +		struct svc_xprt *xprt = rqstp->rq_xprt;
> +
> +		/* Normally we will wait up to 5 seconds for any required
> +		 * cache information to be provided.
> +		 */
> +		if (test_bit(SP_CONGESTED, &pool->sp_flags))
> +			rqstp->rq_chandle.thread_wait = 5 * HZ;
> +		else
> +			rqstp->rq_chandle.thread_wait = 1 * HZ;
>  
> -	xprt = svc_get_next_xprt(rqstp);
> -	if (xprt)
> +		trace_svc_xprt_dequeue(rqstp);
>  		svc_handle_xprt(rqstp, xprt);
> -out:
> +	}
>  }
>  EXPORT_SYMBOL_GPL(svc_recv);
>  
> -- 
> 2.40.1
> 

-- 
Chuck Lever
