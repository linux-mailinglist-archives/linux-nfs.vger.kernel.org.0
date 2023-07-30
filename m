Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F7768652
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jul 2023 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjG3QB3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjG3QB2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 12:01:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82B9E5F;
        Sun, 30 Jul 2023 09:01:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UDeJ3O011919;
        Sun, 30 Jul 2023 16:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=lH4B0nTJ4QxJhgUBUtpPjljYTfGAjL+OrRpN1t2vVv4=;
 b=0shdiuksBPkJyhn/56UWoHz63SCo22sjhfdacEdNnNfzry+LDrFapK+R9yKx/J9g3vxV
 jUX9tLkT7nq/Y6gKrB3Wl3u1hoMz51XXslMgAP2ul55T0TqCNAe9p3xGhP/WHWN0vIvb
 gLWIcCYeBXumTZmN5FAPkAfEDZmWhjHH+vfqMTGKAhCOUgQfdMydLG43VD1DdGx+ptz5
 OWho2BwICjjIhLzn4IJ3Z0C910rG6XJixedLdHwvR24Jdgqu7AW4adM7Pq5CCA4PzvuO
 rjDtnzWZxbR6tFlqX5XDdnz4mkxoI4GbHjdznXr8UTSSg78h7hg3ra1KMXKbQCaVxzMu LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e19xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 16:01:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36UFkRx3000774;
        Sun, 30 Jul 2023 16:01:10 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s79bbq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 16:01:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi7tMVx5pqyZL4lzbpdNsDw5RkbSYUsRM1kNDcHDUoEp7t6KIYP3NH5JddWiRJboBaCzBWD8PnBhOrbWPHaw7bRvktJVjHXrEGddwgX5AQXzXdrbDjX2H+3jn9P8UGLU8/tPXjorjAVAiCJJuvRA4wHR9bCmYoKZOtG4lU6pfJcD4yMo493mJzu8Pg3g5+r+JiTmfHlvsBZKh5tOQ497hXK+DrGK0Jkv9ov8DdyXH+i+APc0pbnFTYB58KslpiseD+3a9WhAyuEJx3F7e+wuE12RpiKtehzlOa6FFhqnp9r4qfO+s62Wulf7Y1BaHd0l1CF47W3wcZdFWmZgSRRjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH4B0nTJ4QxJhgUBUtpPjljYTfGAjL+OrRpN1t2vVv4=;
 b=ZV1xo05G4/aeV2IpIANWnSc411gcwddchNYtZ91puZAt2Cul57cGhuAxYduR7rq3jRUDuDifXbOloL2LtNOVpF3UpvD/lw2NcnHHnu5yXxxFa2Y1RkWv1e+p4bM8H+UPduTzVhfalqCst9csMr4MtS6rirdyZ8uIM3DpTOnkqsm6Grk3TccCSkHsBuwpALXpg+yCr2P8bXZzWpxWDjs9WmNs1x45WCLoGZZ2RtRozmXilJBwgZT6GPL3ZkxTkuwNJgyA6fZxqZ1KmTq76j+b0y1ActKoNRwPivVS4OkhA3vvSDMwqqBLM0TsbQ7FfpZBXQIHOj3E4vrxVnfUqAFKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH4B0nTJ4QxJhgUBUtpPjljYTfGAjL+OrRpN1t2vVv4=;
 b=rb8zx4fRFQ+gkdNWpd5zb08cNPptp9nYPkd+tssa+3ggjEZgiS0BSGN86bFr9/Gp/WNh88U4ZyDUUo/oJUAvKk2vBIDvAcvJtaPS2TgtDLS/W4/7ks5SU56SRgZPfiXYD/WP8XIR6UEr7WrPGOAoIKcbjsMVBADtMNqif1QpZF4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6147.namprd10.prod.outlook.com (2603:10b6:208:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 16:01:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 16:01:07 +0000
Date:   Sun, 30 Jul 2023 12:01:04 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna@kernel.org
Cc:     jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] xprtrdma: Remove unused function declaration
 rpcrdma_bc_post_recv()
Message-ID: <ZMaJQMWO9HF32D84@tissot.1015granger.net>
References: <20230729123152.35132-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729123152.35132-1-yuehaibing@huawei.com>
X-ClientProxiedBy: CH0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:33::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 0802dfba-8998-4b3c-75a7-08db91162fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iX/1lQZPwLrrNW3SooF9tj+hf87e68HTrfVUGbKIr+AlomnRUbtQwmmCxd33n+kRjYYkTjewumu6d6cAt2wDqzjXSFqctZmeNzqX2aa42yuooUwrGTJIbY76m/rNy6PlSRkVVFKXD1FslYovqLaHu4LmVeOvxtET/ue98uCUAbLTAhgtjAymNEvBXOV9YpOGR3uX1DkahG1LOhxDroXvfr9r/hP1ly5yLgIEiexLz+7nThUv7cC/f7MiDm5p+95GJCuVziO7MbwHtbIU8TmCVnDr6/9+FDDot+fZFyI2YUAfPBzKaQEuHC38zYrUrQacscUO7E4H+Wvw2ZvBhbp1Qlk8Uf5v+Q5lRU6cF2RKdlFfKE/n6KjCH8YFYuUZa2A1ThtoVi9kn/mTyZM+E9O8e8f8W7fD9dOryOC0BSkEsF8iWChodwzyx4yVcJN75mJCXwxQ56aO4ItsTLmm2z14gHV+zb3UApbHkdT2LusSKv3dOgseUhkxJ8ploWCgJUQZcKcma8Auv178al7ZW8NpRNdO4e4HG0kvD/+GZnauj8qN0tMPiKx6vvwx5PWRi2W9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(38100700002)(86362001)(6512007)(9686003)(478600001)(6666004)(6486002)(186003)(6506007)(26005)(8676002)(8936002)(44832011)(7416002)(5660300002)(4326008)(6916009)(66946007)(66556008)(66476007)(2906002)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0ZvUZi79lppPC4qy8DO0x+jNbxTQ4DdBqInSdMfIS7o5aYg0cOT6A7IV9bT?=
 =?us-ascii?Q?ZvkoX7UFcQn/N5u9RuuSh1ekXvYSHHMDxT/t3T1S0jpfITsoJhBmBddJSfX6?=
 =?us-ascii?Q?DhKqpoRQRlXRytKbYSs2WVAOG6HNbC4abjSx/+6bfJzLsQ2wIVLuNL+vVtvY?=
 =?us-ascii?Q?eaOuen8Tjs5m1Aqsw2EaPRfYE931MK1CKsNeNqwt+xt1L9KJymlCuphUZQru?=
 =?us-ascii?Q?sfflrWMQioEBKvCpPrOpJ1QVmgMmL9lEuMwsKOeQ2G+UvG2z3VPjBaV1uM4e?=
 =?us-ascii?Q?0wf5WEX4E+Z3Edmp8a8c+wRboVBcSumeEHSQXFFim0eE4jgrvpgj6xGKzrc4?=
 =?us-ascii?Q?nDlLez9ch68NnATdWCp1dTKk8j9vd+yFji4rf0oRLOez7z13LCF21a1du0hk?=
 =?us-ascii?Q?uveX255EV0M4KkEjYY6hkMe+9kshZtAdkTlenlcE340rLzH7W+BtpES9PJlf?=
 =?us-ascii?Q?YFUs8v2M3GkPtgW/3go5KMEihrsYVPl/ZolOgaMmHymr9sRtdn0ZS80n7Kr1?=
 =?us-ascii?Q?o1cI1bpWvflFhWOasx1GBDGEASqzTflim5W0kl7UfiOPV2i0tkzLNQW4lOce?=
 =?us-ascii?Q?J3qADnGSqLczEfhbweWIPcIAQMzQMnwBG+bLGmKM+GU6Tc8EboFOPRRoS/4J?=
 =?us-ascii?Q?9eNL80BZVcSKYDw4PWTuUadXOeHSm5RmriNoXGVeBWqKvmM4Ypqu5C8HO18Q?=
 =?us-ascii?Q?oKFUDsDYxLJJ7h3UDuxqdKZGApb5rdZt9DmgAlBc44Tr7vWmgveaU4S6P9JQ?=
 =?us-ascii?Q?YGi6KMgY8LoK8uawoJ7Ht4uBiEfrfTvJIXgx5dXEwR8ihAIGOTURh4x+1EV6?=
 =?us-ascii?Q?h+pTu+fNpB32sGEpNTtZTqnVxZvQKuNKh6CbiPAjTrgccAhIsMJ4KdUUFFHc?=
 =?us-ascii?Q?6cBpguHX4v8Hcha9qcNm3s70mLlMkG5APNlbAZqSMQayUtgXGXBhWb2JPW+5?=
 =?us-ascii?Q?iX+dOYYq0F/hES3QazVkLAXupxymMeysYC70DVlQbIfJzVXeFs4bxeCIuVnR?=
 =?us-ascii?Q?LAPEbZpCyKqzpyyvZYoIPDIHWBMlvhhBcA53F/5qg3iKZJhTiNz10J32HoVm?=
 =?us-ascii?Q?gqiHhaeqh9iNmX761/SFFcrUKM9Nmup15kPCusYfq6AJ5MjMbtcRnLpxGhNs?=
 =?us-ascii?Q?XlrSmksxuYMstInCjpga6JrrcYOV1qthFvkcBoOsg5HVKEBaIPyBw5/iWYsq?=
 =?us-ascii?Q?7eUWpXGmJ7OTByYw33M3IbmWARssIpLogrTURQR5FtbSuzciSCjVqwXnkxzi?=
 =?us-ascii?Q?PGwBclsEwXiVa2PrUinSokFvf5xnJsxxbba+JI5PO1OiFJJ1f7ksmFJ0TXu9?=
 =?us-ascii?Q?M1DdIPBh2uFGoeIaeNgZOmopvwFf0Pa8Yl9UDusFOPSrPW2ZRIP3OYr0ueMS?=
 =?us-ascii?Q?nXFBtK07O+Vs39WZpD4SDp7Qg82SKWDquZkCbzo6zoO7P+mjN+ucqKyzgIas?=
 =?us-ascii?Q?PNDj/f5yrWs2ilbl0oMJSy3/Kgvx5BmP95N0PtCSwwTK7REVceQfvTH4KSdL?=
 =?us-ascii?Q?XFTb9XbZm4qVfVZOyNU2uhaFd9FMSdwkN0OzAsO5O5ngbyi2MMvTNKvn8kGx?=
 =?us-ascii?Q?V1I/H9Yk3h3PSyVexgzU3UWHqxNF3P9E7ogorUyNPlTo7SGfjwr7ehKCf96U?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pVd+ItKPkA1Vp5PfqaJIydgY3UxtbL/p8Qc6s2FH6glMWWRpxf8Ykv0AHPD+?=
 =?us-ascii?Q?LUqYDVCu0gS8lXMUCOJe3/3WV1+thafhE9yBFwPbkHRJQyx/DzbnGo/Qd62G?=
 =?us-ascii?Q?vngDMaefZgyIyGD6Uy2h0QhDRuNMq7PmV1xxRuVBc1kaHXgyydqBALQegLCw?=
 =?us-ascii?Q?DbBm2frpEXrasL8AtLS4UWiZWeUmPbOMkcUOtiPHmos9avvSgXhbCqt9AiiQ?=
 =?us-ascii?Q?GNWQr+hFcrY6AvzXis5f6bSLT82ZTcf9GGcJoFcu6H8Ntj/+8cKfs1asil20?=
 =?us-ascii?Q?mUdWKk2/Sf2iNHy6LrPvjbaKYu2VqhN/4WpZ/fFoz2q+5zgGqwponi4CoF3a?=
 =?us-ascii?Q?30ei1vPOPHBmp9ksPA33k1DjtwLZHz6ve/8Khk88JIvNAJijlueb/bjsmi5i?=
 =?us-ascii?Q?/UPCWxb87SAvrEjjpEJmIX3u8pJkBOz5CREUZQ8r47TgKR+BfppF6++p/3V+?=
 =?us-ascii?Q?E0caeKSz/CTVVWeOIoxRBxPSDdjI2DiOSb0WJpilrpcLl67Yyv8+wtl4KHUX?=
 =?us-ascii?Q?i+DfJSj4EPTaWRKtMDapSD9p15zGW+zinYNNw3c+M7oSlQbDg9LlMSxDRfpJ?=
 =?us-ascii?Q?2Yr7iLxcTABhbPhBhg9lHBzBFL+M13IcYFKKkzwYpW/imbCWiLnilvrVCJtk?=
 =?us-ascii?Q?z8q3pdvi8lWex2Khj9dn0S7cySyyy9q3hPmP3Mskjxiq+dIbwETEePWtL/gl?=
 =?us-ascii?Q?MR0TuLadkmwTIu7XnFt/mTWzxPTdtbi/dVob1HwcK8gPlVVCEZccVY3g37LD?=
 =?us-ascii?Q?JOvi1Pkrq5yOYTlSp9V28W5knXilzNEaKxvYrx00adzQ07fVAoa18HrSD/gh?=
 =?us-ascii?Q?nOuRwJ0Pcw7kLEbpSGOOQrOElZyxfzVKdJwEb5+fkDqqhCJJe/Ke2KCPDaXF?=
 =?us-ascii?Q?RHfxGPPkVi1qoD2qvehq6ExxrQnz2yB6HccfwUm+4qCPoFXk/4xRdKLsb95G?=
 =?us-ascii?Q?+fa9q/cnTiHFr6G8pMduKEXRGbuMxmMbG0YLfr1znJ8VCK0tX3s9YwmOH1uz?=
 =?us-ascii?Q?ayY9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0802dfba-8998-4b3c-75a7-08db91162fa6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 16:01:07.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xS04bzqVnXEFMmPGQjwhyEcnH71hHUQOEdkoUaDH47QqOZy+UaKal3AYSSSbcbV4wFgP0pMceWHDs88fD4Q7JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=911 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307300148
X-Proofpoint-GUID: usL8P-6R9-olkaYxtNgV1Xhe2am2asxD
X-Proofpoint-ORIG-GUID: usL8P-6R9-olkaYxtNgV1Xhe2am2asxD
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jul 29, 2023 at 08:31:52PM +0800, Yue Haibing wrote:
> rpcrdma_bc_post_recv() is never implemented since introduction in
> commit f531a5dbc451 ("xprtrdma: Pre-allocate backward rpc_rqst and send/receive buffers").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

Anna, can you take this one?


> ---
>  net/sunrpc/xprtrdma/xprt_rdma.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 5e5ff6784ef5..da409450dfc0 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -593,7 +593,6 @@ void xprt_rdma_cleanup(void);
>  int xprt_rdma_bc_setup(struct rpc_xprt *, unsigned int);
>  size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *);
>  unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *);
> -int rpcrdma_bc_post_recv(struct rpcrdma_xprt *, unsigned int);
>  void rpcrdma_bc_receive_call(struct rpcrdma_xprt *, struct rpcrdma_rep *);
>  int xprt_rdma_bc_send_reply(struct rpc_rqst *rqst);
>  void xprt_rdma_bc_free_rqst(struct rpc_rqst *);
> -- 
> 2.34.1
> 

-- 
Chuck Lever
