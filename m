Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FCA76232B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 22:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGYUTO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 16:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGYUTD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 16:19:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ED830D3;
        Tue, 25 Jul 2023 13:18:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIXkJ020074;
        Tue, 25 Jul 2023 20:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-03-30;
 bh=BEZueGPUh7qfxUGRAJZpV4AWjftaNZmHO6TayE4PNAU=;
 b=ZVO2zcYdPKWGRnR+toc7Jrmmj/DjsYqwve6105Nwm+Yy5dVHwzBKrW1VorI1BUtfCoxa
 GXYrpWPoer43/+cfQdmxoE3YLGw22b7fHv05/eSLcOrUgfaonVi50R8Z0TuWXtlj1PeV
 mzmeOijsm1LydTGrnVw8DBb5fQQjOLszQ3EzYnc8fcfId3lL1JmaMT081ot+Xl3F9p+k
 ahgVABlmHc1YEK7aW5gx4XWyZ0Ktzr75ScIqqw0Suppaflka49vLsYzrP1XJRe2QgeY7
 Sf6CF4x3AWAX6FOvQ+oSyq06PdZOcbzNdgvszql5iFLZmoiedcbzM+NVegdHL/DVdrPo TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05hdx08s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 20:18:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJlYpt030466;
        Tue, 25 Jul 2023 20:18:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jbj9ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 20:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUxbTDeTHdaB1b8lO6h6Qmk5T8NDA3JTVudtCuREyTNeMRL6n6tzz62VxRjLVLwBETLJ3w3KAfoY8Tiqv2rnIutiGjkZBECH8qQpyiaDfy5wBPqKKsd3hyFNVBEntORgHXoyW/H81S8cRbPfcpsbCivtMBSyFKs/mWMiM5D9Kb8w3Lfx0H0F1LydUXct3Jf27mROwEjz843pLS/CiA3IubPV4UXFQppCYnb2Seu66p1EkxYIPj3rJ4K5IRV7XM88MWV3ut45XM8DoR8o3/qYZyERBTIkiIQmypZzH7S2+y1ASg4moAUYZSOcR91WXvm/QIhqIEHVRTNM8Kauo5x6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEZueGPUh7qfxUGRAJZpV4AWjftaNZmHO6TayE4PNAU=;
 b=mMBhOccPPBeac/NitfUmExJId2w4mqfo03KnhGDDKJRO00ladgwSXl9q8IyMoYyR9o9r9Mi8FqyFRKzDqFAvZqDHM1Az1OPrznEhgTj3apelQPYW5UyhdKIKN9giw0i0JgMQ6ozk+w92Nffh5vXLygTYZWf6kWtkBIg3j/rt+uAAsk2TlyuHjyOUDDNXCqlCJC0UCKm21rd9l4e+YP6aAulWeL1C94vssUk0j+FKL2mRN5FOLaHt+SzdUEuAHFz72AuIO91HT3zogAKszDdGkLdxhGYzEdNLmpoLkwlgUSTu/smF756dZOEAhZW6XH7X84L+30Ne7ZY7FGqF5MrHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEZueGPUh7qfxUGRAJZpV4AWjftaNZmHO6TayE4PNAU=;
 b=njYVC/R9V9IWLWULCdxk9OlaSUjHO0OgSurVSX33hdsw1g7ZFSgcUcB+JJkqqPoOXNGOYDWC8YdrBdUSIFotdD9+B4NKyB+8e0j/aCuUNJZWHB2tg0Tn4E/bDiZCTKgKjjoq1Y8rp246zP0inR8Yk4ff0Yu99je6SdepxBMf0gc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 20:18:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 20:18:08 +0000
Date:   Tue, 25 Jul 2023 16:18:01 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] nfsd fixes for 6.5-rc
Message-ID: <ZMAt+QaAHn0XIGDt@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P123CA0626.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: e2556ee6-c6f3-444b-d5db-08db8d4c42c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/O9NLNoTxBgFtZKvvaGmn92+nliJ4EJVeatJYXfUrqjUmt/N51mBlx4lS8HKwiz/M6DTK1I4pn37QDs4wZPcx0XUBA7o8YJveDvBTLr1hhtzNprAcU1KcXgMvEWQpX5iJchBts4uaaxppcdf/d9v+5uzLQJzQFnd8JMQHgG+lvhd1lPlSe5t9Lme5f83i3yG7hjyvITztUvfDgn9dfKVRyJyOKcF9E8wqRZTFz2YBhrQzgVWLRd9TvMgn/GNudwNBKb8074HK8DBDXl1oixrznF0APPt+wTIDfDlE+C8dO/+b+EfvPME0d5gnZHyzlOBQ8I8VEvUuo355mFpnaNBFWisBhXzeP13+0XxZ0spxwWqG5DSLYqqApP7mYFxkeUrJ9WMLy2uEzIDjidtXKlaXr9wvxfYLBwgYJx1KlhbTAvC2JhPAmlAvbnlZgoyGEuE6rQAD5M93BUzujfplC+5ulMmAjwaXY1CmYiB36qgaIT/gG4j5hZKisKHlpclf8X2a7SPq/AbVXCz22wK91fW0z4VM5+WQuVujtYsdS3knmqEVLIuLCexZTVQmYDCGPR7JlNuOVvLQclXEvsGe+5VM05zsHOpgsUYmejo4y1fbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(5660300002)(44832011)(4744005)(8936002)(8676002)(41300700001)(316002)(2906002)(66476007)(66556008)(66946007)(6666004)(6506007)(38100700002)(26005)(83380400001)(9686003)(966005)(86362001)(6512007)(4326008)(6916009)(6486002)(478600001)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NiAfoCqE3J16D2MOGkOxZwPVSZgeonksmBBV58UOdE5jxgU/nvwPcoJgHMXx?=
 =?us-ascii?Q?2bs9eBCRKckIaS0d+Kfuy4XxjwLJY1HqWply5iWjPVackN/4BVM6ANXnTP7k?=
 =?us-ascii?Q?Ooi8w8W0olprriBtSijb1D2iKtV4YU9Rdgh07kNdnjmW/jCpCbQ6wWZnEPSX?=
 =?us-ascii?Q?pQgu5rW+9tE2CrZDgUAsyWYlf05ECh6ltYPQq+FrDiK+H7nshipSyBAREcoN?=
 =?us-ascii?Q?8JOKwea0pgpIrBNRlrvfgBLZmzMVcgycboBWPsioelLFb1rXBGl1uuYEq5t8?=
 =?us-ascii?Q?ytBfURW9ax76mP2eI5fvn92G6v2oySbWNRyp1w8tfCaBbdFcDU8XYjTX2Pc2?=
 =?us-ascii?Q?I1Yk5SJMJiHot0eqa4VfsDlWCdSrVrcG9Ray2Mo7NXZBb99dTgntV/tJoBQc?=
 =?us-ascii?Q?BMvVHhoDJVNPYpR2E6QEVt9EITM6buHxfuA8AS8ZkbkdKs5wVyd1Ba9/BdA+?=
 =?us-ascii?Q?HZm04ojPzRNRm3BlEtXh1iBUxyChc2PUcoqYee67r5K6ej71KEhIejHXkAAk?=
 =?us-ascii?Q?4YXGt4nr5pjNUiMA3y1fxETIEuCWsbP+aVm6ouDS/RkqUw/g1NeFAujoGMWO?=
 =?us-ascii?Q?J62Gj03P0OKmlLWeOVMgl5nxVpmVQfQfB7vM4wSHgJyYBVZemRdSJ2XxZTrJ?=
 =?us-ascii?Q?3tmlZcHQhcXHdZOJoQ09lh4T2U5sLbP1fCAee4bx+edqhPgdTa+WuhVeAFwe?=
 =?us-ascii?Q?JR4D+ry29z1KjCTdsaaqpNQAURGAe1yUZzTEVOQ4g+UmWPGddpFEiYiaOD/V?=
 =?us-ascii?Q?Pdse2m9PMLR4pOu6MQthpUJzLAOU1lw5oNTBAEQ++lRdC6Jz9qCVmrgWBHlh?=
 =?us-ascii?Q?klkrC74KZI8T01xMGYiSQXPoytG+neEAas5mQ9W0dCAIYAeldznqzFqvi04I?=
 =?us-ascii?Q?nUpxJbgqeSTrHzy0lu3ZFwWzGWtZYSB/p58p4IB5p3ozGzpCKFs43E9R6JY+?=
 =?us-ascii?Q?83INLiJhCO+RJazKJr4W/MR2TaKjXeWh93GbQLypMTRUig0+vjexZean/Bjr?=
 =?us-ascii?Q?Hb5IfEtd657CRa6ygYqxkcolFClhrJKI4ntPqgukEc4CEiW5wD9mVbn/hA+3?=
 =?us-ascii?Q?j19TYUV5ihjAIGs8fCYHs1MPe0WRc57m0L/Mkmbj3CaPiK4yQSJ8klqDdr2/?=
 =?us-ascii?Q?Nw3Za8OG0b5jVN5qLYaV7qK5z7c8zzr+7EGcywacPOXVWzaScgw8gRSE+sXN?=
 =?us-ascii?Q?UmQAYBH+1P6gFoZRjiH7X6D/v8GoUeDZ3SNJ8eKZYq6KMcUSspgCiIvXptiX?=
 =?us-ascii?Q?sC7eUsc5lFj32tAFcvEvcpcBmOoXTbhw9nw0LFCcmMKUCZ1R75eKOeLl2ILi?=
 =?us-ascii?Q?4ZHtjF2ahGafLMp43Igur5Fo9KvzUotgL1dvB04WtjSTep/kkphZb9uJUYEk?=
 =?us-ascii?Q?Ah/mRBa/Tm8ikzWeEIpXgqeOlqhCPDQvZN3olp0VehDSyeuyOYxG454NVdqB?=
 =?us-ascii?Q?VKUEhLxHxpCY9hVk/i53M4d8vKwhdXxYjmHXOQYbwC80oLHgeaZxCQUZscgc?=
 =?us-ascii?Q?zzvnYWfchy8hpR+MDcTGQWtoq+0A188iKAiE8/z5P9nHXNwLPRvbkY8YsEVi?=
 =?us-ascii?Q?CHgfTZZAQMlMcT/GbMjzRRPosuo2WMlsVTsr/gxM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X5FI17MyTBfaApAzr8rvHICp/rGoG5DfsoHbaFLYqTA26+8xIJdVuxwBAGW7FHA2zTh+HbCrvW4ap7gMUtJdT5zSETH7xhlWCcfqybgMYXS//8vLNzPlouZwRo2O7hOIQotTwMXQYwGy3tdsfA1M/8Xa1Tl/7OSSDjbMYkztfY/nlIEIgn4cvp9owpuqx1TzDDow9huAxso52AN+xTunHh4wjYKVMMZJfrsjnU6MJIPyr6Ax4S6JbR3oprUlJeD29sJc0AcXo7M1u8O3PvYLOPyJ9sd3zBetVhPS+YPyVqDxmyG/Xn0H8HKzvwuL6m1eSqCTASgZpfWwcJB5QQuM7qbaeSjQQrDV1HHPapiSUsRVJVmv049D9aw9lwRYxOI9LqE9g2wCDPcc5VQMNCjqjZ53zi/Qz/tnOWSRNeASQFad+X7oJ6xt3TlfBZvv9SGlEtmZupStvGQCIeCsrbuqs9kLGXmdGrUaXuK2Dg3vmUgwZuOKI3CU74wS7XuM02PhlqOQkVvEu4cfzFoI3YuwV0NsZBuIaJUjOfXxECg0EJNbNC57NnTT/70uE71ug4xsPen3tTTUqK49piHip1ovRVec/4gmOlqi6BnXWB3/lOuxejQ966nIysOwQIMexdm8AWb6QHpgWQ+7xEOMN5Ys7ALTLWGai6Wb9iEld0iXb35wgInWOZRxOEj/E1yVw6AdQ2negtR6mSG0dTSeOjbDbWik3DuLRMPSR8FgI9clAOnuSl/PE1pWsl4lgt0FWVYIo8C5iruGYRcffJd+ooMsscL6yaVNukr10sEWebQST+D93jtd9y2K4MOfDVQHfzZGIoGZDWfORoFbSD5x9uwbOsnQgpJe1fyrK4jCYA8u0Aw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2556ee6-c6f3-444b-d5db-08db8d4c42c0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 20:18:08.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgkUbUV2GwAbHRZyzXlCPHIxRUUn9L0pfmumbWE3cybXW6kZCa4Bk8OP0tLDPdk/+MnowWzQGYR+McjRjdA7aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_11,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=696 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250173
X-Proofpoint-ORIG-GUID: AV4VkWGhjLE9RgbIUi1yiqC2hyy5soJy
X-Proofpoint-GUID: AV4VkWGhjLE9RgbIUi1yiqC2hyy5soJy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Linus-

The following changes since commit d7dbed457c2ef83709a2a2723a2d58de43623449:

  nfsd: Fix creation time serialization order (2023-06-27 12:10:47 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-2

for you to fetch changes up to f75546f58a70da5cfdcec5a45ffc377885ccbee8:

  nfsd: Remove incorrect check in nfsd4_validate_stateid (2023-07-18 11:34:09 -0400)

----------------------------------------------------------------
nfsd-6.5 fixes:
- Fix TEST_STATEID response

----------------------------------------------------------------
Trond Myklebust (1):
      nfsd: Remove incorrect check in nfsd4_validate_stateid

 fs/nfsd/nfs4state.c | 2 --
 1 file changed, 2 deletions(-)

-- 
Chuck Lever
