Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3AB76763C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jul 2023 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjG1TWg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 15:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG1TWf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 15:22:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6F19BA
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 12:22:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SIENQk029550;
        Fri, 28 Jul 2023 19:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=4RzaAdaSe47Ox61g+k5uiZMeMJ7DP5WCveUcKajmG8c=;
 b=gCr7B6e31/5W9brPshM12ATXmZqHtixjNx1tYhX/s4ruhPNqDdeGHYQhztIQkOO6JY/m
 ZtmLqNeMctey7o3bQbbU3fhnL5IcdBpagD4W9+i9tQzU3Tl7g33ecgu8MavRCE9cjyAl
 rBhZfXqaJ8CshOvGjDXPMaXBe+i4Y1K1mFyvPRODwLH7X1Y3l4MVBkxFieneQIcDSfIS
 W+UqMWULtGbABoaY0MPNRF6oFnN8h+8OCISsY818XcMfT6f42XyOafgpWv5GmwrYz+pE
 NfwlX4K/5gbqC2Bz4+XshTngRW1olN7Me2ZBo8/VKifSk1xERt9kjcjWTzjwtY/d6fwk 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuvjvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 19:22:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SIG5hm011938;
        Fri, 28 Jul 2023 19:22:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9rkk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 19:22:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1Zy4RbKYzXdr6uqFvGyyEUC5WStLVGBEbhECsThQpkdzjca9QvhoH1WD9QbfMU8NkosC04EF3PFT4awNtZQJhCERefchZK2DLiAVNc1inVdPoBkgJ4i4rF6NSgK353G4Z2FKt9xBEgMVmr2ocW1jPsoLo7iDicCyUUVsfcsiGPQ9rhfBjp48i02nOlWPubWM4X5gewccIQDOm0WA8AOnB5uGLUcH7n9evuld68bxgijF3K8Cheid87QCYpO5c3xGPhGKSTxgG1VxeGLiV9mPMVgsUNmLzu+VL5c2CioO4vTy4RWGJG3nb+Ufm2RFAVMY8lM44aVXSq7dirjV5PSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RzaAdaSe47Ox61g+k5uiZMeMJ7DP5WCveUcKajmG8c=;
 b=jVdH4pn+ayuocthg+S+p4S1LxWNVV9Jl3BofJBQia3ExdhI83KSAVAH5JO6hxdi4gPD0lWEL6XVZh6fK/yu90n1X2aQFU2xAeYelqTxCImo/dPgAMueGZOUM3vgkuqLgzLI0II0V29luRS6js09oy3xOy/3aDk/oU9/zHynyQFANqEu+Jb8kaQl9y31XHNPcCcSDCS2BfBP6O0SI9RwSfE9mIpHz37NZjZlSDA58kIhebeCd/aNqYlO9mCFsRYxqc6EcAwai24gnyU0cqw9+qDCL01yvdYvyeh6k/FgvZYeOuN2NULXiO7jKG2hx+yksEMu5PfLpjDEnsLMS/J6huA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RzaAdaSe47Ox61g+k5uiZMeMJ7DP5WCveUcKajmG8c=;
 b=BkFrPEbgu3cAGJEmpnchOpndtYpIqmdysLvwcCuAFWwHVmslumeO9WDwPMr0uk+eOT5q/VZEtmUinrnTq2JsibH0QHh3cvy1wm+2AzFV2GAP/GCUq9OZDnEUN0QOP4Rn0kOUrnod6e5ROf9OaJUMrOvLXR8xjA/5ysCJSKVW57Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6979.namprd10.prod.outlook.com (2603:10b6:806:328::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:22:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 19:22:21 +0000
Date:   Fri, 28 Jul 2023 15:22:07 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de
Subject: Re: [PATCH v4 2/2] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZMQVX5RlQaWt5wkn@tissot.1015granger.net>
References: <cover.1690569488.git.lorenzo@kernel.org>
 <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:610:38::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: e1172664-28f4-454a-da88-08db8f9ff73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfDvePEFqE0HktT77Xy1FXtYvQNBdgEBd/J4lA5qwGZX8kxhS2xBaGnGo5a+elem+hbr8wXUXgEsl6PSUXISfOrvkuw7ALJgvBw9FBj57EXQDKN7UdAmIDhm4n2/VR8MK9EeWDRyFquuV0PidE7pcST+E3DTo64DuDHwR2DwZu2kf0WPyEthUhlaFvsWpM7qZVQLv8nZLmh409ZlTeqmLxb7QOc8h5TjXSSRa55LRoo3UHQ/Ce5FXt/pcOMKKijtZFsB5Rvu/7dTaTspFQvxghaB0R5okY682BHkGKuVr3pq+vpx3qWrC/+m/Q1vgJ3D64g7j3s+Wevkho88zfK+lBKZQj+90wp7ptCxJri9GYdgkkAo19ZYxl7FZzXzvByYGcsPMLkLsdWbZLgNsT06MShxI2rzgElqa56ZdN7NhRbzrgiF7eQhOASz3u6qz+CR2UuZ2LqHr/hSa6Il80RZlPDw6F8WmDsh/HH7hRjKuYhWEVmc10SyOgsMkfsheDE3ur3kC7+HC0faZKcLW8WL8h0b/gwyUVMxmEbg0XGKHl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(66476007)(6916009)(66946007)(66556008)(26005)(4326008)(41300700001)(6666004)(6486002)(8936002)(6506007)(8676002)(5660300002)(44832011)(186003)(316002)(9686003)(6512007)(966005)(478600001)(2906002)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6gPlSDGv9/EEgX1LkO6syfeF2tMd8xK6atl914IgT4PdM1c9TF8OrSewo31l?=
 =?us-ascii?Q?lH698jdQumSt3zX/lmb5v5JnLYJHzxuvBRLTwxeb3QzPcDEnxgHenLJfuaGJ?=
 =?us-ascii?Q?ICVTV4FH/Rvg1eQJ0PQHV27g/ur8nLTHct+GhpGqbpq6G6lbTmsKBfLHUzr9?=
 =?us-ascii?Q?1KMFlW+fVWc7itX1ZS41mfvnJvBRbMvbg+nGusaN4mzZ6qUPOz5NwKYDBSkC?=
 =?us-ascii?Q?WP1UkacPCQQalR0Peh4xYIyJW3YfvRWPCVqC0QsNGFsQn+iTdQEQ0wxBLmhi?=
 =?us-ascii?Q?wPR1I2UqBJwYCQFWiuBnsChCdcYZET1UEEVQg1clha9XN7tvdgrTp6SbmhGM?=
 =?us-ascii?Q?cXbgY7MuY1d6Dnp+DUX2ohuzFc88l8w4JgIMf9BKG/WuFcgM6EmLbLXSiIiO?=
 =?us-ascii?Q?2/rY6XW84UdDAIChUIXAnPOJnF068tnisMmHAKx613khG2ag/R12giKho7uG?=
 =?us-ascii?Q?BZQY4+QSML7xhY2/QsTf4Ww3KAx2Idsc68uV9ZTOnZ52yFiXRnG34C/OAjSG?=
 =?us-ascii?Q?jXXoSsOagB30XTpDS2F5bZ0uru4hGNHMHQ9Iwu2ToXUA/u6KC4IK5T7TV4pu?=
 =?us-ascii?Q?MdPmHY1ILxZ7J0MrnEgCePtfEe9bEcLiBh7wtbNvntfKzsB6rsck5br6elwF?=
 =?us-ascii?Q?WsBwIolskyY+28qg9SyG00ICr0Tc7D2xi9nJO3dVg0gjJqGpzG+r99NK1YTd?=
 =?us-ascii?Q?DEQF34RM3ntiCiUdSNrygXOIUZG/peQyfdX0sAtazepRPEWX5NeAcEj18La/?=
 =?us-ascii?Q?y7p4n/xLADmicv3peMtLWUCZoaF8C+J8XQq9ubxip3uj/Uvs4AHS5AUzmXmj?=
 =?us-ascii?Q?OrOfFC4rk2lEOnAoB+kpUenWNaMxh6nYoVClR5b41wXy4+JiTTbDjERIsMY6?=
 =?us-ascii?Q?5sXqRkYSClj+4wIBeF3pTShrQcfLWpVI41k+t5yrhpPf+OGDhUSmn0O94EJ/?=
 =?us-ascii?Q?WGlEC6cFHl3I+7QKdFnR9k089o+UGt8wWtvwhFk0mdYtLJLrWD6bXnq204tK?=
 =?us-ascii?Q?kD9miuRl/PXi0FmVywVrMn5v/rkooo1zmgRhUCG+lSRV4N2/zouWJc/tE0GS?=
 =?us-ascii?Q?+U3pRIfqCKPYsPFdqgR8ndwTv+aBSZGAR1C1bU8LcT3Vl+VrRnaZ2EdkNk26?=
 =?us-ascii?Q?rND2ZmntMgzrfaffDXiN8ZEIKiEYr9oNp2DmiUpXkqC8/GLphgTNJMauzgPY?=
 =?us-ascii?Q?3jBlVFflbE18yTfTUL/01lCgP8rbKIYpHiZ3TuyRG/eKsLG97Pg5WRqF7Vxu?=
 =?us-ascii?Q?Y6SwJThOXI8fh8A7YTJoVjQUEzxYVW3tx4Pu7afW+baFdxz09QlKaGxCkfN4?=
 =?us-ascii?Q?COjXRr6NJHIMSKK9U8J7nI4TKzgU8d3k0tqx0tm6z8Px9RBQSJZ+cfLwmq8q?=
 =?us-ascii?Q?5rY8MvuxgasN71E/bqAo1ZAY8ePFyukRY6YSyG0j8WFlB97ykozZj/U/wZW/?=
 =?us-ascii?Q?rUFXl3+FDcNCSZZHDwFjN3rwuviIGLh7tCfRJEgxJVh0Z8yrFgKMhQxYVOXr?=
 =?us-ascii?Q?pk4b5RLBtdwngGfJBlYKgquKenZhwtOY/JCtdSTBZmjKfhJO5SvkmoZZSOr1?=
 =?us-ascii?Q?y6OkZUWOuGYX4ljmQamSo8TC8+KteXSRX4EwRiO+aFQYlNvsEeNVqHy3dJmX?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kKASxc0z9muc10ZzIYjoZtvet8H93YUXUDL/D9sS6tprGV2zDBxQeevj6kqYTIjnjTQ72MEfRYBZrpJn4jP00bzxIE7VqX2YSCSuQ4C6i6dgVc1FkkjkPwjzIXLOmp3rARG8ghQ9mXjryHVjCt5U2+xCDeFiqrr/Z7Kok2Pj3F0hyWiDgYHF5Uvm/WfFFIccyUE5UO8p4xzX5mCMaABivjrSh/drJOTIcrZiAp72i7oUIcrSP48NqDoc/V+ViysHFK1qcqlW9rQmyxu9AqfwOn3PVbwAFD9Tknfoxao9VhYn5BuzeqmfFfVusA0IQssXDOy6u9SwP10PsDXP+FqeycMTf4E+aBDubljcKHJndYO8GlvsZo8gFvP3tEFGaHwT4gAqYv99CWTHnXfDzkqrh/gfRAqF10NEj2fDdkjoWpmJNye54ef3/sFnxfqQjkTzwEhxZyD6TnYwSVD8nTdZ8N14JPcu9wRnT8A5+OP0zmWHgpV8nD5oDT2XjyK3W/ymS6OXGgh+qPYI3CT+dM+ZGvE39QegNKF1Z3qH1wcNv1Uuss+FbEEjnvBaq2Aldl6iDINvKlhwSSxNE8YpWtjIUSYbB+THWNLKW8nWuVWas+c4gsFRAnoqz7FecSHnPDSn3iTJ9rRKTp/lKec316Fesx2Jdw6glFyPZJnDop7PW+wd7K4vjycrHYKHTP2mFeB+strxb6Oa6bty/dtAXn7YawllzBCDeFwgbQirV4tg3t5gI2zkdHXg+6Dy9FUAdHWdHBFs4jbWLLvIxaqmVfOtb7VZ362IOPl99UrGx0+SiO0EDvxWy++BViuwjkXnGFJIWDz3IE5btbRJhyWH2R/vHQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1172664-28f4-454a-da88-08db8f9ff73b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:22:21.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypzoKaS59X1+7FQlvhVEaAFR2ug978mrT6SfFnDR+0drXzPqF4GBgV65fERdTmlNNF6EzvS0lUO9IKJtmiP97w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280176
X-Proofpoint-ORIG-GUID: DL_WU4ccKemPsrMk1ZF2MAWz5PACH4k1
X-Proofpoint-GUID: DL_WU4ccKemPsrMk1ZF2MAWz5PACH4k1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 28, 2023 at 08:44:04PM +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> pending RPC requests debugging information.
> 
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=366
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c         |   4 +-
>  fs/nfsd/nfsctl.c           |  10 +++
>  fs/nfsd/nfsd.h             |   2 +
>  fs/nfsd/nfssvc.c           | 122 +++++++++++++++++++++++++++++++++++++
>  include/linux/sunrpc/svc.h |   1 +
>  net/sunrpc/svc.c           |   2 +-
>  6 files changed, 137 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f0f318e78630..b7ad3081bc36 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2497,8 +2497,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
>  
>  static const struct nfsd4_operation nfsd4_ops[];
>  
> -static const char *nfsd4_op_name(unsigned opnum);
> -
>  /*
>   * Enforce NFSv4.1 COMPOUND ordering rules:
>   *
> @@ -3628,7 +3626,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
>  	}
>  }
>  
> -static const char *nfsd4_op_name(unsigned opnum)
> +const char *nfsd4_op_name(unsigned opnum)
>  {
>  	if (opnum < ARRAY_SIZE(nfsd4_ops))
>  		return nfsd4_ops[opnum].op_name;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 35d2e2cde1eb..f2e4f4b1e4d1 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -57,6 +57,8 @@ enum {
>  	NFSD_RecoveryDir,
>  	NFSD_V4EndGrace,
>  #endif
> +	NFSD_Rpc_Status,
> +
>  	NFSD_MaxReserved
>  };
>  
> @@ -195,6 +197,13 @@ static inline struct net *netns(struct file *file)
>  	return file_inode(file)->i_sb->s_fs_info;
>  }
>  
> +static const struct file_operations nfsd_rpc_status_operations = {
> +	.open		= nfsd_rpc_status_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= nfsd_pool_stats_release,
> +};
> +
>  /*
>   * write_unlock_ip - Release all locks used by a client
>   *
> @@ -1400,6 +1409,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
>  		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
>  		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
>  #endif
> +		[NFSD_Rpc_Status] = {"rpc_status", &nfsd_rpc_status_operations, S_IRUGO},
>  		/* last one */ {""}
>  	};
>  
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index d88498f8b275..75a3e1d55bc8 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
>  int		nfsd_set_nrthreads(int n, int *, struct net *);
>  int		nfsd_pool_stats_open(struct inode *, struct file *);
>  int		nfsd_pool_stats_release(struct inode *, struct file *);
> +int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
>  void		nfsd_shutdown_threads(struct net *net);
>  
>  void		nfsd_put(struct net *net);
> @@ -506,6 +507,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>  
>  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>  
> +const char *nfsd4_op_name(unsigned opnum);
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 97830e28c140..e9e954b5ae47 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1057,6 +1057,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
>  		goto out_decode_err;
>  
> +	atomic_inc(&rqstp->rq_status_counter);
> +

Does this really have to be an atomic_t ? Seems like nfsd_dispatch
is the only function updating it. You might need release semantics
here and acquire semantics in nfsd_rpc_status_show(). I'd rather
avoid a full-on atomic op in nfsd_dispatch() unless it's absolutely
needed.

Also, do you need to bump the rq_status_counter in the other RPC
dispatch routines (lockd and nfs callback) too?


>  	rp = NULL;
>  	switch (nfsd_cache_lookup(rqstp, &rp)) {
>  	case RC_DOIT:
> @@ -1074,6 +1076,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>  		goto out_encode_err;
>  
> +	atomic_inc(&rqstp->rq_status_counter);
> +
>  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
>  out_cached_reply:
>  	return 1;
> @@ -1149,3 +1153,121 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }
> +
> +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> +{
> +	struct inode *inode = file_inode(m->file);
> +	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> +	int i;
> +
> +	rcu_read_lock();
> +
> +	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +		struct svc_rqst *rqstp;
> +
> +		list_for_each_entry_rcu(rqstp,
> +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> +				rq_all) {
> +			struct nfsd_rpc_status_info {
> +				struct sockaddr daddr;
> +				struct sockaddr saddr;
> +				unsigned long rq_flags;
> +				__be32 rq_xid;
> +				u32 rq_prog;
> +				u32 rq_vers;
> +				const char *pc_name;
> +				ktime_t rq_stime;
> +				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND]; /* NFSv4 compund */
> +			} rqstp_info;
> +			unsigned int status_counter;
> +			char buf[RPC_MAX_ADDRBUFLEN];
> +			int j, opcnt = 0;
> +
> +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> +				continue;
> +
> +			status_counter = atomic_read(&rqstp->rq_status_counter);

Neil said:

> I suggest you add add a counter to the rqstp which is incremented from
> even to odd after parsing a request - including he v4 parsing needed to
> have a sable ->opcnt - and then incremented from odd to even when the
> request is complete.
> Then this code samples the counter, skips the rqst if the counter is
> even, and resamples the counter after collecting the data.  If it has
> changed, the drop the record.

I don't see a check if the status counter is even.

Also, as above, I'm not sure atomic_read() is necessary here. Maybe
just READ_ONCE() ? Neil, any thoughts?


> +
> +			rqstp_info.rq_xid = rqstp->rq_xid;
> +			rqstp_info.rq_flags = rqstp->rq_flags;
> +			rqstp_info.rq_prog = rqstp->rq_prog;
> +			rqstp_info.rq_vers = rqstp->rq_vers;
> +			rqstp_info.pc_name = svc_proc_name(rqstp);
> +			rqstp_info.rq_stime = rqstp->rq_stime;
> +			memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
> +			       sizeof(struct sockaddr));
> +			memcpy(&rqstp_info.saddr, svc_addr(rqstp),
> +			       sizeof(struct sockaddr));
> +
> +#ifdef CONFIG_NFSD_V4
> +			if (rqstp->rq_vers == NFS4_VERSION &&
> +			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
> +				/* NFSv4 compund */
> +				struct nfsd4_compoundargs *args = rqstp->rq_argp;
> +
> +				opcnt = args->opcnt;
> +				for (j = 0; j < opcnt; j++) {
> +					struct nfsd4_op *op = &args->ops[j];
> +
> +					rqstp_info.opnum[j] = op->opnum;
> +				}
> +			}
> +#endif /* CONFIG_NFSD_V4 */
> +
> +			/* In order to detect if the RPC request is pending and
> +			 * RPC info are stable we check if rq_status_counter
> +			 * has been incremented during the handler processing.
> +			 */
> +			if (status_counter != atomic_read(&rqstp->rq_status_counter))
> +				continue;
> +
> +			seq_printf(m,
> +				   "0x%08x, 0x%08lx, 0x%08x, NFSv%d, %s, %016lld,",
> +				   be32_to_cpu(rqstp_info.rq_xid),
> +				   rqstp_info.rq_flags,
> +				   rqstp_info.rq_prog,
> +				   rqstp_info.rq_vers,
> +				   rqstp_info.pc_name,
> +				   ktime_to_us(rqstp_info.rq_stime));
> +
> +			seq_printf(m, " %s,",
> +				   __svc_print_addr(&rqstp_info.saddr, buf,
> +						    sizeof(buf), false));
> +			seq_printf(m, " %s,",
> +				   __svc_print_addr(&rqstp_info.daddr, buf,
> +						    sizeof(buf), false));
> +			for (j = 0; j < opcnt; j++)
> +				seq_printf(m, " %s%s",
> +					   nfsd4_op_name(rqstp_info.opnum[j]),
> +					   j == opcnt - 1 ? "," : "");
> +			seq_puts(m, "\n");
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_rpc_status_open - Atomically copy a write verifier

The kdoc comment maybe was copied, pasted, and then not updated?

> + * @inode: entry inode pointer.
> + * @file: entry file pointer.
> + *
> + * This routine dumps pending RPC requests info queued into nfs server.
> + */
> +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> +{
> +	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> +
> +	mutex_lock(&nfsd_mutex);
> +	if (!nn->nfsd_serv) {
> +		mutex_unlock(&nfsd_mutex);
> +		return -ENODEV;
> +	}
> +
> +	svc_get(nn->nfsd_serv);
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> +}
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index fe1394cc1371..cb516da9e270 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -270,6 +270,7 @@ struct svc_rqst {
>  						 * net namespace
>  						 */
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	atomic_t		rq_status_counter; /* RPC processing counter */
>  };
>  
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 587811a002c9..44eac83b35a1 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1629,7 +1629,7 @@ const char *svc_proc_name(const struct svc_rqst *rqstp)
>  		return rqstp->rq_procinfo->pc_name;
>  	return "unknown";
>  }
> -
> +EXPORT_SYMBOL_GPL(svc_proc_name);
>  
>  /**
>   * svc_encode_result_payload - mark a range of bytes as a result payload
> -- 
> 2.41.0
> 

-- 
Chuck Lever
