Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0DA7CDFA5
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbjJRO1J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 10:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345473AbjJRO1A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 10:27:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365AE385C
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 07:25:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IEHxL6001482;
        Wed, 18 Oct 2023 14:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=GBPiH7Sz/eLXsSHZkj2wFFPcShreOMW9hVL3u5DwiIs=;
 b=p4OGnAKKrJEnxQD9DSkyTFWXWPGJnvy7T2kLjrKuDqVDQkCF1q0s+AMG5Sst3IRu5sd2
 np0XnZE40uSGiyknBiKcHedU10q14tJKUb7y3sro1b07rgdebqsrFObeWFf1zXZyHinp
 Sx9BkwExV4fXl/aB1XlkG6OWShZkPIruRINaPZbYJG/1F5sZguDH/8oxdIJRPd30Xi1R
 UdN2ZTwBJX1+BbY6lhehxVL+G+7NCB15eMrdGeAPTnc/L+UUl0LmKEAf3BQbtyR5jzE8
 +IoKQ9DRBOb+fq9EVENo8GB50fD0RN064r7VXNZB7oNWHvqDF8P4BZSVcGGhtTdaY4vG +g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jqpe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 14:25:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IDe5Wc015401;
        Wed, 18 Oct 2023 14:25:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1gjm39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 14:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZZpVQxIFznSaVpG0ixfHozIOgJy+OeDIE+3E4w7O3ef5ILmHCYfKM0+7W5t3+GeOSzotyDbgp/XEzg938eIcbTbeC/VtfeT/uUnwvNlXrRtAN/m3lMpd6WtAp7s+4eaJBIrxETDrpykOsDNLPhqaeS5TTnl3GdxGVEknhY/hzi+JiYHfzsMbL517LoLMFSpIM3EK6xzgBLm+dqglPIFHh+XKts0+gSfVhF/awH+3h8CNbS4DDVjvIe25Q7UycOBYPyfeZwJ9HHwBQY2EQwv/9CA0JHMancli2ekdPWoV1rsGo6E9+1EgPQNrCaXLLaRlLOl3gCchJK18oZGeuy+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBPiH7Sz/eLXsSHZkj2wFFPcShreOMW9hVL3u5DwiIs=;
 b=jPkMpik0BanjL1bPGtN0DB8/iz5Xo7asXw5kdg6CtoL1f4ig2UXBfgG6nGDmvq8vpy8O2Mx0Rhvu0jaREpNLFjl0EYmf/LhFHpR75Q/TKLCKu80O/UoshszQmu9bIObGcEKuXmvTwSChoLfpjX7cFlpx/+krtsqYTjAZgZMn8KYf51EyrSP5XJy+zOfKET5GH3z3L9MGXO/9vel/Wdxms0V+htZ0mkkMrdvHQ6m0DvT7c3LI8XQKXzk2LO5ujwdeXyQBYhzf3OM933qaXPKXXKvEn/ujxILF6XQDrZZVDy9gotmZgvPYzHsgFKGaQ5gu2QfT8mT9ADPKXyIne2MVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBPiH7Sz/eLXsSHZkj2wFFPcShreOMW9hVL3u5DwiIs=;
 b=fWOG982lA++488WFa50Me5Unu5sxpJrIKQJkoD3VoU5bY35wEKgGd7LcACnmV6DYCKcItjJIiLizJ0L7YiI5rYqeGhkltJm9ZZaYr1fltvjx1wkCqJGG/bJw4wTqziiJQ+ly6X2JllOf10eRoWZRnwjCudjrm+d+VurADs5UM3w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6274.namprd10.prod.outlook.com (2603:10b6:510:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 14:25:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 14:25:08 +0000
Date:   Wed, 18 Oct 2023 10:25:05 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Message-ID: <ZS/qwYzQvrgJNEv6@tissot.1015granger.net>
References: <cover.1697577945.git.bcodding@redhat.com>
 <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
 <ZS/V+4Cuzox7erqz@tissot.1015granger.net>
 <6157b73e380e5b625cd8ed0133ef392d0dd4bd8b.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6157b73e380e5b625cd8ed0133ef392d0dd4bd8b.camel@kernel.org>
X-ClientProxiedBy: CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b45dcdb-b138-4ca5-d35b-08dbcfe607a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKPTqdaeV0VyaJJFpEcM7CypZJcOlrkFbzLBDzh5RxsMQffIW1SL2hGg9MTyCKN2aSEs2tVXuORSEVNA2GFZn5x/yqA4wXbAHsMJh0EM7LSwfDmmcT5vDz7WXV/M6dLqVCO7tUKpACBGjn5eCHf313LulgRCBjpLttLoUK0UydT9v0DcmD2s+m3SXxTlpNWmnY6JAmLmk1mI3up3qp+lRuVvehwSdYEE9QrLNIzIwvr9BZeWog2k4eftQQPb2BvmYdmZqbMQhWcKiyygL9P+pfjcrSeAjosdSaebyR6DjAsCnHarF8SnRXQj6rvneCIdCnvlrMZx5DUMlgoYFVV6bo1p8Yr6PE30DpIxEv1yJdk4v9JOvcDRozNqurbDdrtBTBBoUimUUAoARe24NohWw4KZWP6dK15kCA2UHO9G2J0oDc/Pd5UkRpAHdMlyE0FE53B7rMhnnivjmcE+HpjC4uJPQoOKtHUIn/koqqRdItaYA0yMs5hre4w0m3tLv9PPSqkT4uKjXp4iSwnW08r+h6BZmoBb1YIgHlQRyJ0Lv9AG4GhIZ3t+0KQSVFJdZW2Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(478600001)(41300700001)(9686003)(6506007)(6512007)(26005)(86362001)(5660300002)(6666004)(66476007)(316002)(6916009)(66556008)(66946007)(38100700002)(83380400001)(6486002)(8936002)(8676002)(44832011)(4326008)(2906002)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vpP8hnhrmqHKkXmIpT4dsjbX20NxmGdgXlaW2qXv7SuVlFSwo/S6ytwZnVTv?=
 =?us-ascii?Q?1K9dzBDU3izZ/od9TaDLXirzkohY5I1BbpjSpu5qZjVFdSRrxTVPrarNcYO+?=
 =?us-ascii?Q?F7jiPRJ2iWS6caxHNZit23zzXcExQSd+AlT1DEmSQpjJsBB0mTp7N2SvHWPh?=
 =?us-ascii?Q?CUAOffPCWPTpEQ1ydSjkZmJNfQGxzs471tYo9Qnrh/DnHtEjzlOLl3Nxx3IR?=
 =?us-ascii?Q?zggpy5U+FT9B/ozr0TNcEsrWplTtJwT2xf2haYLhVUpfoZvD02J9jwV6XMH/?=
 =?us-ascii?Q?EX4Z/zjZXoKJm41CLSiQHlc5gYJVl58MrkCMFJ/dbG0EQqeKOsnvdgEk0cRX?=
 =?us-ascii?Q?Gl8BRXEw5gxVyUjB1FeW5+L56IapT6wESCNhvALQdJPKahn1zdLaLhvYPmTV?=
 =?us-ascii?Q?Pc7P6AH4kAS17CQhEX1g+s6LrQsXD0WtwYMZEwCET2UG/gEiDFh8PReo7ftt?=
 =?us-ascii?Q?H/slgCrfNVz9oINLJE2VC5txrRhImcyXahuSYX7ZbYiBMreKDrTWJiwadDzq?=
 =?us-ascii?Q?SuzlU6WkncySsDFTc53yJ8EuGCTl1hN6RllbhCMrnYkWk2frLPI+iRQngmIw?=
 =?us-ascii?Q?PULVH5dktTuafMjjPJjqpL68z0FgN+aTmUB/vcWn6ymcGSebAqIPCR8qgZnT?=
 =?us-ascii?Q?MA1ADVSsdz+GXUbLK6eXKCgMbTOF6RgU3/5tcj5o8PEtCdRrTekHIWHJqj5s?=
 =?us-ascii?Q?lLVsK+v3+7McO6vGpRoCo7Tu4cC3VoZxV7xJJFI2jgSM62yHDk6NpmgptBTl?=
 =?us-ascii?Q?M65w0ieX25RSYuhfdDjBtcIke+BLGy98T8waM0RuUWedS43iME2yjB8GQXox?=
 =?us-ascii?Q?kp9ysWU7hZexQdraLgdONR0um2rbv4YsKanbvDVDjuDrwqYkbmSdTQpIDzD/?=
 =?us-ascii?Q?S0gGhpskX4dawQkHpG7ZumNnLNPPBQlszyum15QmmujAs8gVh2hBFL22xdNN?=
 =?us-ascii?Q?RCWgu1yNO6I6ZHynXbaMpO0d5crsPGL6TvhCIWH4awCIj6UK0UenOiD4vwl/?=
 =?us-ascii?Q?/TCd2kcdSj5LwEIez4HKU0EONul/K0FFv5DjlGl0HZBXkpYiuVHouFv0dSJA?=
 =?us-ascii?Q?ELngHrp51AROpiwXCuKl+yRhZb8c0gA1U1wiAhL2nuc7dE2YaQZG7MaAa1Qz?=
 =?us-ascii?Q?auckFDmMAWePpl2DQQkq5uQFvbF+ql5v/cwugM3+wPR72NIS9i4fmCAWid2J?=
 =?us-ascii?Q?e1hEx4j4+KWt1Nzgv37Z2uMAFkC3wYzuSEsyiS8fzjjziNP9tkdNLZkXFIl/?=
 =?us-ascii?Q?CM6BPW2BiMv8S4vVW7Ak8iJfxmv39AOTWHRXBtHcV/At9HK/d8I/E1BX5yTE?=
 =?us-ascii?Q?R0g7epp8qaoNZT7MUJSeS9kpZfj9AwM9S4dJn9oqA6+dRv9OzJ1Ww5kuvxuG?=
 =?us-ascii?Q?ohy/lK6FpP34a5ZdLeSvyHtF+8DWtkJZd/PwbKFYfHkgQDO9zEOfFUHu6xwb?=
 =?us-ascii?Q?0ZAz3hEDqJnQ8J9+4V67Rp4TFl7LiVAUI/B09XcbYdutKnmFjrXN9CUrAu2J?=
 =?us-ascii?Q?sJRfbU/DGZUf8JJJaaB+5xyod4hJPobsVyR24UU092AWDzYf6mf1QJNoxG4n?=
 =?us-ascii?Q?0Sahgni4bCUMiEb5aimcL5hXxDkWnzQyoWFUeclEpRzmaT2pJzyAZQ5Lz0Ta?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qbVFnTexqIPzvh+D8lOggpXrK4GGWhbD5AW18vdhWDz9zctMexjuy61SpUvWHvPwx8DQriuzKBjVDucy9SawwaeKrUbdep9UID1/cpZoUc0u2ueQKhGbHeL/iH/IHS6XUWsjDbxFrt0Ttj2tREGI6mDDXbn0Wb+4XooJX667mCPhdQUQz4juWWPIKCy3lkb0Dnf1fwzv/xU709/zt/hdaw6KBkpFzsAw/JI4YUl1SDIns3IsB+9p7bca7/KqrW1n/D5ykPdY2tRHyWXxCmLPRMKl0kF/qlPVCBvRLgxG2yN64435Yy7DIWfAF8hmmvdExKMpGtPjhm1GD8r7cUMLWdiJ5M7cvYj81xDpL2bMoteCfxRyxzmX4yNZ78gRfm0R87f241AwKw1w5IygfVuCditz0ENZut1/gm9aNmvQdNKIRA77Apm+BMO51JmqDkWJqcAKC/j/PFdeubl2DATWSaRxxOq16R1darH9kEyahZllqBfSmj4ndvg9v8F9kWl33fq0JTBeENIXL4t8DoQ71XL7O28al38nBojaBMqgljCiqUvM5aUqE3c/FaJccm730tLcndUA4tIrQXPYFdU4X3IdLyhBR4/T4I4ha1ULwWwKIjX8hLG1bibpFeAjmEJXl5+mdFX4fsEYvS29YMXgLc6ZWYioDP6PMWaOD3BGnEaFRXsbZ7CU7gte26oH4zkh3RZ2hUUYiWtBTCoeKOQIQFucG0skFdbA580GbozjhKF3usYd4t+73vNMngNB8xOreVJkJRB22DL6j23raeT3bqhMNOOupbWqm4F4lG/Zk/qU0NXAW+Ji+Sw5njQFBXEWE4n2AEHFEnWxd3ap8YVKBJZm+fbTWKbN4YIPFNIsPIQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b45dcdb-b138-4ca5-d35b-08dbcfe607a6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:25:08.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwRMC64/bpjzIlK9v4q+Zn6mHAl/b9pS3fmtpmAeclT3JDfNfvA0+wo07TP5McIB9wlxHKM8MTg3KeacmAXxvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180118
X-Proofpoint-GUID: cjVdftgyu9--yRY12H0R_WjfWCuiSaPG
X-Proofpoint-ORIG-GUID: cjVdftgyu9--yRY12H0R_WjfWCuiSaPG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 18, 2023 at 09:33:40AM -0400, Jeff Layton wrote:
> On Wed, 2023-10-18 at 08:56 -0400, Chuck Lever wrote:
> > On Tue, Oct 17, 2023 at 05:30:44PM -0400, Benjamin Coddington wrote:
> > > Expose a per-mount knob in sysfs to set the READDIR requested attributes
> > > for a non-plus READDIR request.
> > > 
> > > For example:
> > > 
> > >   echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs
> > > 
> > > .. will revert the client to only request rdattr_error and
> > > mounted_on_fileid for any non "plus" READDIR, as before the patch
> > > preceeding this one in this series.  This provides existing installations
> > > an option to fix a potential performance regression that may occur after
> > > NFS clients update to request additional default READDIR attributes.
> > > 
> > > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > > ---
> > >  fs/nfs/client.c           |  2 +
> > >  fs/nfs/nfs4client.c       |  4 ++
> > >  fs/nfs/nfs4proc.c         |  1 +
> > >  fs/nfs/nfs4xdr.c          |  7 ++--
> > >  fs/nfs/sysfs.c            | 81 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/nfs_fs_sb.h |  1 +
> > >  include/linux/nfs_xdr.h   |  1 +
> > >  7 files changed, 93 insertions(+), 4 deletions(-)
> > 
> > Admittedly, it would be much easier for humans to use if the API was
> > based on the symbolic names of the bits rather than a triplet of raw
> > hexadecimal values.
> > 
> 
> I think there are some significant footguns with this interface. It'd be
> very easy to set this wrong and get weird behavior.  OTOH, we could push
> that complexity into userland and provide some sort of script in nfs-
> utils for tuning this.
> 
> That said...
> 
> When we look at interfaces like this, we have to consider that they may
> be around for a long, long time (decades, even), and people will come to
> rely on them to do strange things that are difficult for us to support.
> If we have someone saying that their READDIR performance slowed down, we
> now have to grab those settings from this sysfs file and validate them
> when trying to help them.
> 
> Personally, I'd prefer a simple binary "make it work the old way"
> switch, if we're concerned about performance regressions here. I think
> that's the sort of thing that is simple to explain to admins that are
> suffering from this problem and (more importantly) the sort of setting
> we can later remove when it's no longer needed.
> 
> Adding this sort of fine-grained knob will create more problems than it
> solves, as people will (inevitably) use it incorrectly.

Totally agree with this assessment. It will get baked into wacky
knowledge base articles for decades. Voice of experience here ;-)

It's not yet clear sysadmins will even need a switch like this, so I
would go further and say you should hold off on merging anything
like it until there is an actual reported need for it.

Now, full control over that bitmap is still very neat thing for
experimentation by NFS developers. Hiding this behind a Kconfig
option would let you merge it but then turn it off in production
kernels.


> > > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > > index 44eca51b2808..e9aa1fd4335f 100644
> > > --- a/fs/nfs/client.c
> > > +++ b/fs/nfs/client.c
> > > @@ -922,6 +922,8 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
> > >  	target->options = source->options;
> > >  	target->auth_info = source->auth_info;
> > >  	target->port = source->port;
> > > +	memcpy(target->readdir_attrs, source->readdir_attrs,
> > > +			sizeof(target->readdir_attrs));
> > >  }
> > >  EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
> > >  
> > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > > index 11e3a285594c..3bbfb4244c14 100644
> > > --- a/fs/nfs/nfs4client.c
> > > +++ b/fs/nfs/nfs4client.c
> > > @@ -1115,6 +1115,10 @@ static int nfs4_server_common_setup(struct nfs_server *server,
> > >  
> > >  	nfs4_server_set_init_caps(server);
> > >  
> > > +	/* Default (non-plus) v4 readdir attributes */
> > > +	server->readdir_attrs[0] = FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR;
> > > +	server->readdir_attrs[1] = FATTR4_WORD1_MOUNTED_ON_FILEID;
> > > +
> > >  	/* Probe the root fh to retrieve its FSID and filehandle */
> > >  	error = nfs4_get_rootfh(server, mntfh, auth_probe);
> > >  	if (error < 0)
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index 7016eaadf555..0f0028de7941 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -5113,6 +5113,7 @@ static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
> > >  		.pgbase = 0,
> > >  		.count = nr_arg->page_len,
> > >  		.plus = nr_arg->plus,
> > > +		.server = server,
> > >  	};
> > >  	struct nfs4_readdir_res res;
> > >  	struct rpc_message msg = {
> > > diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> > > index 7200d6f7cd7b..45a9b40b801e 100644
> > > --- a/fs/nfs/nfs4xdr.c
> > > +++ b/fs/nfs/nfs4xdr.c
> > > @@ -1601,16 +1601,15 @@ static void encode_read(struct xdr_stream *xdr, const struct nfs_pgio_args *args
> > >  
> > >  static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
> > >  {
> > > -	uint32_t attrs[3] = {
> > > -		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
> > > -		FATTR4_WORD1_MOUNTED_ON_FILEID,
> > > -	};
> > > +	uint32_t attrs[3];
> > >  	uint32_t dircount = readdir->count;
> > >  	uint32_t maxcount = readdir->count;
> > >  	__be32 *p, verf[2];
> > >  	uint32_t attrlen = 0;
> > >  	unsigned int i;
> > >  
> > > +	memcpy(attrs, readdir->server->readdir_attrs, sizeof(attrs));
> > > +
> > >  	if (readdir->plus) {
> > >  		attrs[0] |= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
> > >  			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
> > > diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> > > index bf378ecd5d9f..6d4f52bf47b3 100644
> > > --- a/fs/nfs/sysfs.c
> > > +++ b/fs/nfs/sysfs.c
> > > @@ -270,7 +270,82 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
> > >  	return count;
> > >  }
> > >  
> > > +static ssize_t
> > > +v4_readdir_attrs_show(struct kobject *kobj, struct kobj_attribute *attr,
> > > +				char *buf)
> > > +{
> > > +	struct nfs_server *server;
> > > +	server = container_of(kobj, struct nfs_server, kobj);
> > > +
> > > +	return sysfs_emit(buf, "0x%x 0x%x 0x%x\n",
> > > +			server->readdir_attrs[0],
> > > +			server->readdir_attrs[1],
> > > +			server->readdir_attrs[2]);
> > > +}
> > > +
> > > +static ssize_t
> > > +v4_readdir_attrs_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > +				const char *buf, size_t count)
> > > +{
> > > +	struct nfs_server *server;
> > > +	u32 attrs[3];
> > > +	char p[36], *v;
> > > +	size_t token = 0;
> > > +	int i;
> > > +
> > > +	if (count > 36)
> > > +		return -EINVAL;
> > > +
> > > +	v = strncpy(p, buf, count);
> > > +
> > > +	for (i = 0; i < 3; i++) {
> > > +		token += strcspn(v, " ") + 1;
> > > +		if (token > 34)
> > > +			return -EINVAL;
> > > +
> > > +		p[token - 1] = '\0';
> > > +		if (kstrtoint(v, 0, &attrs[i]))
> > > +			return -EINVAL;
> > > +		v = &p[token];
> > > +	}
> > > +
> > > +	/* Allow only what we decode - see decode_getfattr_attrs() */
> > > +	if (attrs[0] & ~(FATTR4_WORD0_TYPE |
> > > +			FATTR4_WORD0_CHANGE |
> > > +			FATTR4_WORD0_SIZE |
> > > +			FATTR4_WORD0_FSID |
> > > +			FATTR4_WORD0_RDATTR_ERROR |
> > > +			FATTR4_WORD0_FILEHANDLE |
> > > +			FATTR4_WORD0_FILEID |
> > > +			FATTR4_WORD0_FS_LOCATIONS) ||
> > > +		attrs[1] & ~(FATTR4_WORD1_MODE |
> > > +			FATTR4_WORD1_NUMLINKS |
> > > +			FATTR4_WORD1_OWNER |
> > > +			FATTR4_WORD1_OWNER_GROUP |
> > > +			FATTR4_WORD1_RAWDEV |
> > > +			FATTR4_WORD1_SPACE_USED |
> > > +			FATTR4_WORD1_TIME_ACCESS |
> > > +			FATTR4_WORD1_TIME_METADATA |
> > > +			FATTR4_WORD1_TIME_MODIFY |
> > > +			FATTR4_WORD1_MOUNTED_ON_FILEID) ||
> > > +		attrs[2] & ~(FATTR4_WORD2_MDSTHRESHOLD |
> > > +			FATTR4_WORD2_SECURITY_LABEL))
> > > +		return -EINVAL;
> > > +
> > > +	server = container_of(kobj, struct nfs_server, kobj);
> > > +
> > > +	if (attrs[0])
> > > +		server->readdir_attrs[0] = attrs[0];
> > > +	if (attrs[1])
> > > +		server->readdir_attrs[1] = attrs[1];
> > > +	if (attrs[2])
> > > +		server->readdir_attrs[2] = attrs[2];
> > > +
> > > +	return count;
> > > +}
> > > +
> > >  static struct kobj_attribute nfs_sysfs_attr_shutdown = __ATTR_RW(shutdown);
> > > +static struct kobj_attribute nfs_sysfs_attr_v4_readdir_attrs = __ATTR_RW(v4_readdir_attrs);
> > >  
> > >  #define RPC_CLIENT_NAME_SIZE 64
> > >  
> > > @@ -325,6 +400,12 @@ void nfs_sysfs_add_server(struct nfs_server *server)
> > >  	if (ret < 0)
> > >  		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> > >  			server->s_sysfs_id, ret);
> > > +
> > > +	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_v4_readdir_attrs.attr,
> > > +				nfs_netns_server_namespace(&server->kobj));
> > > +	if (ret < 0)
> > > +		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> > > +			server->s_sysfs_id, ret);
> > >  }
> > >  EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
> > >  
> > > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > > index cd628c4b011e..db87261b7cd7 100644
> > > --- a/include/linux/nfs_fs_sb.h
> > > +++ b/include/linux/nfs_fs_sb.h
> > > @@ -219,6 +219,7 @@ struct nfs_server {
> > >  						   of change attribute, size, ctime
> > >  						   and mtime attributes supported by
> > >  						   the server */
> > > +	u32			readdir_attrs[3]; /* V4 tuneable default readdir attrs */
> > >  	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
> > >  						   that are supported on this
> > >  						   filesystem */
> > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > > index 12bbb5c63664..e05d861b1788 100644
> > > --- a/include/linux/nfs_xdr.h
> > > +++ b/include/linux/nfs_xdr.h
> > > @@ -1142,6 +1142,7 @@ struct nfs4_readdir_arg {
> > >  	struct page **			pages;	/* zero-copy data */
> > >  	unsigned int			pgbase;	/* zero-copy data */
> > >  	const u32 *			bitmask;
> > > +	const struct nfs_server		*server;
> > >  	bool				plus;
> > >  };
> > >  
> > > -- 
> > > 2.41.0
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever
