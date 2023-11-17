Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4E7EF4E0
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 16:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjKQPEi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 10:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQPEh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 10:04:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935C21AD
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 07:04:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHEwtHc021357;
        Fri, 17 Nov 2023 15:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=SXmW/1iwiPL/HPkuVwungKakqmLsH8nEd3MkxvLFtC0=;
 b=JB80938hEC0vzH3g6AmOG5bzn55OdGVPUcwtXuEl3rwd/O7StrhILKDPk86LY1klHSrP
 GeKjiruXTyE2yu7QsIZgQlXgXeXmtVuBjyy3wey4c2INtJy4LlK4TJ18banaMFB73+ne
 x/0xxP1xhbbV/chbBhqAMlQNbiP3wqlI6y8hYBtq/Suz3m9euNVfYxtxX5k9sBC0Dn5Z
 2D6Q6CE4zhuwOXdhYuSU+QbLcNuvOrS2IHn7XyWmH+nwPZEvfmzAGGhBN92L8WFdrLqs
 6Mvzzknr1OV2LK9g88l3ASCCXSU7vHg7D3x4PEaRvu+Tb4E2NmrarixgqjPXxyb+hL5S 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjwjvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 15:04:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHDhZXT015624;
        Fri, 17 Nov 2023 15:04:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq2dhpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 15:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeMBRzk+TqJcx/ldnW1WXpNTMnXrxjiv/MzEoHNn2pvlyjjZiVoQAamgxsYj4sBfe9jFprSi9XPL4iSd/YeoJDllPQmiYPDenOViKr1FYjTA/ML69Key8W/D3G8BMK31ixI7qYcGmn0PPM2b0XDfkkvnfEdSCDwiUxDqjQasIRjpmvmVCvDI7p9X1ltiPomUdJRrdWk0/ngJ+JqJBksM1e/EeIHHjvuMzyKvIIaZlQ2OuzIx77/K9VOspIEd1x9lZ3KBwGSIAArvtAE8Wys9nz9ITUVu2BBRRsPUa1anAQQO+qAXMBuXeyy33yEOwbSUv0wQdr0EI4o88DtDWUlYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXmW/1iwiPL/HPkuVwungKakqmLsH8nEd3MkxvLFtC0=;
 b=H8w7D8bIl0BLwhS9ihlYZr7Pv65VGyuWoYPW6wOMG51d5XAkDdn8dqlPe4eCjpQxMEvYIMUdhdFq6j5gjv6St/Kex34i8zER65V/CdmedGnRr0G48+0J+Q4mnLfV+spVw/qsQP96UiAgRRS6ah62EfkgzfbgYTtnEkkm8DUU5vNwCuJKCtFXpRg1aoQcrs3QPF/v6PCXLz6pnHompmRwe9MLI925u5DvBvbMAEJtnc4GulvK/8mN4fe8bCjUtu6GRRdto4SPU+HGb8IaIMpUyteGZv1bRTBJBMfJ8SXJbp6hyiD/O1Hs3NF1En3uTjnUDvBNm1xflNnu1jU1+tNxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXmW/1iwiPL/HPkuVwungKakqmLsH8nEd3MkxvLFtC0=;
 b=aMTiq9TORvesWxeagkidL29P0Zy/lEYsOX6x00M2vCy+LEt8ADX6uxEuAzkr9izePGJe5LLIga+cJIND9XWL0h6fvum6auI9Gc8xqHR9citaSsKB2tQUIEauhDyKz9fTa9bM63toZDTy2RIsXWKQ3PtIM2m8ZbY1RMopz89bjLc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7306.namprd10.prod.outlook.com (2603:10b6:610:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 15:04:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 15:04:22 +0000
Date:   Fri, 17 Nov 2023 10:04:19 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/9] nfsd: hold ->cl_lock for hash_delegation_locked()
Message-ID: <ZVeA82rMFJL27OoN@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>
 <20231117022121.23310-2-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117022121.23310-2-neilb@suse.de>
X-ClientProxiedBy: CH5P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bee882-6df4-4ca3-05b1-08dbe77e7b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyMv3ZXENaoFr9z9xc4qGA26R1DrbVrlYYem73F+DMVEFscj6jxfVzgSb+4e5yrExcfHHPcWP+4HlZ5TXAyvhUleTb73b39Zd8G2PXetHqrQksEAd/en5Hk6bOQnr4RN7sFPgGp03zU5SB1KpEVHIkIf7My1lLpyVMInDux0bt5sCU97sRDOGWJgvI3lsLP+rUe3hpDQrb7hdvksQ5MzHmr0h6Z35N1blyKx41r95nbWPWDMV+20tpxJUcAeeJRm1uQUWKi6aWw1M61yf7ocz4Ti1bFEXjwTcgg+ROvizES/fYCtVot8Dwfhj4gRe3dGc227fu3M0YIkmdQky+ta+8iULP4JmXpbG2qrKsEknnTf10y3FsKB2nF3E9xlmzRTpDaRJiVmVRai3+MbhfBG9cEHlby/Tp0Xi372JEhTK5DiTkfZTPrX845sPnK/N6OPYUP85P6xfyafH9BsWP/3sjOxZkdoI+Iwh84RvkX5fG5PIRNanJ0VZZrVREk0/l2H0tySDGX5GJ9n9pXC+I8Q7bkNULknJvVpG50fsxycpvd3NrlcO9A2RbVQK9hg8ngv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(84040400005)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(5660300002)(44832011)(66476007)(54906003)(4326008)(8676002)(8936002)(316002)(66946007)(6916009)(66556008)(41300700001)(478600001)(6486002)(6666004)(6506007)(6512007)(9686003)(83380400001)(26005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clgUVggnB42GHYzE9/T2BSfYorfU1GXZdkK9C8AcuQCOPVerMcOddW/X3fGO?=
 =?us-ascii?Q?IdItCso9+Su3MyvJFlAlIGX0XGykVanQURQsmrsSHpS8XU5fm+4yU510RPrX?=
 =?us-ascii?Q?fTtHw5Iwah+F8BpWcdkxJojxTAEgMfWwugqrSLGZR4av0KLXVvQ0TX9cy5AU?=
 =?us-ascii?Q?jCcVY0J7M6EEYt4loDcgrgrQ9BDgEi+3aMYzDA4LtYdHxAo7J/Vset70yoOj?=
 =?us-ascii?Q?lQVAAXhHgsMcpUdeQtNG+EFtX2q+7ZPIlZ1xwr7oc2XKqWPajLwK9JM0toJT?=
 =?us-ascii?Q?ALwniXYILN3LEuQoWIEumNvV4kt4KW9IINOluQLdezPqv0I0GHKcUkLqCid4?=
 =?us-ascii?Q?DDL/8DSalpuZcIdyQbxdrLXrTlIDFeZUnRxgrkqGhpUWIjDw1LhsIid4OlHV?=
 =?us-ascii?Q?NJbw+bXetLAPJWY+s3BUoBOKERVJA61/Ptlo2CdSpmAaBgYNNoW7tV6C26BL?=
 =?us-ascii?Q?J3iMojyewhcsp8bJ8ucONldCdTUzdsGzjapPOiBxzlEkOQDZ7hMYsfDucCJm?=
 =?us-ascii?Q?MV1jiPGZagSkFfZj3x++Xfb1IuDmDPzWpScanvtDa+nc4wjBqlPWRDpmrMTo?=
 =?us-ascii?Q?T+ox2NKRz1eXuguGV/O7gOU63d1c9yQMwe3wbcZuZfKd1uk+L43m6oHKUcUN?=
 =?us-ascii?Q?XUVc7tvvHg4pwbjQVgF8lCEiPJnVp6A0gSLbqs8rihARVNxs3TpMMCNtv/Vp?=
 =?us-ascii?Q?pHgZEHlZlT+LQV3PeXwf2JkkqKb2inhczQB+wW8j40eiUraLqKQY0iTTQHtw?=
 =?us-ascii?Q?k8VGnirDCZ4H2chydmXUnHRk8+0Vv+G6VeHm9qKGBQh1wow+ShQvpAciwpNO?=
 =?us-ascii?Q?NNw3QtA6nNBdhkxlt00ORTHnL7Nf7f57FrT8iR/UBkYgFFxMQKdTlhtC5dey?=
 =?us-ascii?Q?x4wQ+7+EwxJ1kMFbadk1Knwjj5MPOxJHJU4jvbo4vjaf3xqYxNelqs6PkoTM?=
 =?us-ascii?Q?TcmUYFzrzznQiAcq8z17ay9nPUm0tmsI/e6D+cFqH+ix/R7r2i9OB2JtS5cK?=
 =?us-ascii?Q?1ktjjv3gsk7bhZfIbLphEPH6DkFHHtzx0cyeI7WAQBZ4eNlW8EC6LAfNZyy+?=
 =?us-ascii?Q?YVZXxu422RIHNmUpc5+p9iaavx7jgEiTg81+JWlEURhvo+xr4dsvOjpC+cNa?=
 =?us-ascii?Q?dCsbyfBx+MFAB+50E4Z1OlHd3eD6cbyPAlnzR6WaD1/fqgJHThTwkjrr6HU2?=
 =?us-ascii?Q?oygf55BX4tnnAB2l1HYgw6QBGYJMlJ9IFcdEVL8IvIvAtHlxFMLthEgnXUZs?=
 =?us-ascii?Q?5K+7GgpBfx5ydrQjXWmbslmAua/0Vs/04vT05Z0Xd5m5vz6hWg379M4XcTmz?=
 =?us-ascii?Q?n6xH7MtDYjE9ldpVqAOZ0jQPBfjSDG2sCVlYMgn0fHDF2GR02n4yJ9NzA6wA?=
 =?us-ascii?Q?aQIi5GQ/mKTtX/BeXOkYipG+k7BT8wYK7g83VMrvQAeJW5vnm/VOmBTXOGFK?=
 =?us-ascii?Q?Ta650/Z9oG7a7fHeGiJUEg7Om0EkBKuhN7UNVWDoOFkqpHUpZaH8ctTC/Yfy?=
 =?us-ascii?Q?27aIbS0MHBH5uUvqLUPRi9R6aNWh7BbkB33c0ASkplNUSb5Bf8r9C6v0D+4I?=
 =?us-ascii?Q?qu3Zdz5qgkqZ0+5qOBJkf/w8ddJ/xx52LJ9FesJn6WUnN1qYvxnGCqBw+CYx?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GD9PNr8DOAQGxFV7GbL7Wzg7cIHz/1RTysZvfuzQrBvflcnGpRCsQD6QNet8zdhk6F96lK1keFJnQxmaiJ+zVmB+PbFagiAm9k9d0v2p2PzoOh68ei7TVpQaqXdPdorRERtnMXicfW3ksGnSuTedJX+wb4Y0sY7pTiO89B2dREAZ38gIplLh944oAm6Tu45CpSd1IttrzXREoF5mhtFrbGxwEwzgF07GDglFV4LE4QZqYNEcWXlbSxJtsSRsUfmdTqeqW8yPSmFNytifTcCi5MVxZ713+eGkx7F9mBERTzI6pwuSVFCGTB2dEiN6C1NAOwsdTU8cRLX/sbz3wQmhTlizM4ESYIVneT/nqY17Ps+oiJBl4wi3TlvHZPzNuxkF4cBOQV+1aDgvJapIbsgxMEaBNDJhnVCUY6+YCgoNLJHmxdOM+iRHlqgJKMr6etQqyyNr13ZAiqdw7b+cH6ba13tPcQZLH0a8uOqTUZDgL0bNaH4jbJiCwmyYE96G1jLmRdtRof4Znv7KiyTqoInbdquHyU1bVGwQlgE8ZHMnjgddlk2hBvA+zW5giK9T8OBMGwJeC3Jl6kthplqYgsGD6fX2uaZa0V+rjbB08gJpO8As+Spm+uvC2ZDgpl5BHAcJ4vB9/EX7Tjwr+AghqjVfWLFJuuznNlpH5Hj5TjViNjqetFyq6nEPd6to7RuJkurp1pZXD6EgXZBoqTtaHNr9sJZ0StxF6IspXVdBNdQrjRTMUg5buxlXTZHQWq/Aj7fNtU7OVBnTfoy5mv/9Y3YkHKhSk/KPPmx7x0uz9Ros6lEmBvLKCmEOvIP02OH0tVzIxbSfKCmh6BPCAY5SBIiMX/XRHLcodvnLyLTCrf9nSfepvnL9kYm5Ol51w2TwNTtD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bee882-6df4-4ca3-05b1-08dbe77e7b2d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 15:04:22.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRE6IxlZYvPm7NdK2iu53xgGEhZW57pfvfL3tAAZ6B3CCparaL2eaB7VKpk57UbzoPEUitlsOCywIQhXzlibEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=930 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170112
X-Proofpoint-GUID: k3GPwu12x4USlM6P60tTB2vmLc6SEYQ4
X-Proofpoint-ORIG-GUID: k3GPwu12x4USlM6P60tTB2vmLc6SEYQ4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 17, 2023 at 01:18:47PM +1100, NeilBrown wrote:
> The protocol for creating a new state in nfsd is to allocated the state
> leaving it largely uninitialised, add that state to the ->cl_stateids
> idr so as to reserve a state id, then complete initialisation of the
> state and only set ->sc_type to non-zero once the state is fully
> initialised.
> 
> If a state is found in the idr with ->sc_type == 0, it is ignored.
> The ->cl_lock list is used to avoid races - it is held while checking

s/->cl_lock list/->cl_lock lock


> sc_type during lookup,

In particular, find_stateid_locked(), but yet, not in nfs4_find_file()

Can you help me understand why it's not needed in the latter case?


> and held when a non-zero value is stored in  ->sc_type.

I see a few additional spots where an sc_type value is set and
cl_lock is not held:

init_open_stateid
nfsd4_process_open2


> ... except... hash_delegation_locked() finalises the initialisation of a
> delegation state, but does NOT hold ->cl_lock.
> 
> So this patch takes ->cl_lock at the appropriate time w.r.t other locks,
> and so ensures there are no races (which are extremely unlikely in any
> case).

I would have expected that cl_lock should be taken first. Can the
patch description provide some rationale for the lock ordering
you chose?

Jeff asks in another email whether this fix should get copied to
stable. Since the race is unlikely, I'm inclined to wait for an
explicit problem report.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 65fd5510323a..6368788a7d4e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1317,6 +1317,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
>  
>  	lockdep_assert_held(&state_lock);
>  	lockdep_assert_held(&fp->fi_lock);
> +	lockdep_assert_held(&clp->cl_lock);
>  
>  	if (nfs4_delegation_exists(clp, fp))
>  		return -EAGAIN;
> @@ -5609,12 +5610,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		goto out_unlock;
>  
>  	spin_lock(&state_lock);
> +	spin_lock(&clp->cl_lock);
>  	spin_lock(&fp->fi_lock);
>  	if (fp->fi_had_conflict)
>  		status = -EAGAIN;
>  	else
>  		status = hash_delegation_locked(dp, fp);
>  	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&clp->cl_lock);
>  	spin_unlock(&state_lock);
>  
>  	if (status)
> -- 
> 2.42.0
> 

-- 
Chuck Lever
