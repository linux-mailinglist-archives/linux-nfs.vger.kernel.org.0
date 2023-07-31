Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385D8769953
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 16:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGaOVq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGaOVp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 10:21:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D252B3
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 07:21:44 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTJqj029571;
        Mon, 31 Jul 2023 14:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=QwbDW8TA+iYHjVcCQCoXJTR0bOhlwUMRVETTN3hMZE0=;
 b=lGwKLCDNiahjG4dQVZ8ykDc+rnZi3rUHtjiU/QXhD2MdfOXvT3OoE+P2gXY2DxMZE1ad
 QzqdK3nlFISRJNHrpLrZyUEhd99I9liB8s6L59qV/OEkxf4uLGVUb46KRE3OJIT6Qx49
 +uc/mJJHWBqWWI4Wv0Z0cYl22Ff67s5JPIaUPF0VJCVHxUyRhSrPwQEA+XtTdL3D+/55
 rA34+NspqGF+K51y5v1stqOB0ZEyyur0YjIbmScXfbT5mmxdb8sTbKdf7xkduDqyX+kw
 LnErlP2ktVi7S/gBFxraxD2U3C5QaHGVfTC8LYVb+TzU2uqogKMyQ8ABQvQe25ZGtktp 0g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd2q3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 14:21:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDFs1w008730;
        Mon, 31 Jul 2023 14:21:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7b543h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 14:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsFyaeV+MrDZZHSuDfY6jtJBLtHnYYDD6als3XBJCx/zQvakfPnkxQVEh1swpna8sgz/u0eD+WqjEbsrelgpc400hM85HMspB5YPY4PDkATp5RqvvGcz/Va5nLEX+zxUvho6/67lPj9MBlyj+yFtnd6DzTXohOI24ffo+vW80/aR5eeIya1e8rKivGFzV7agjS7yCJHKogdB3gzgxQHmFx0tPaHXutQBnKHkreotVw/eREAXZsU7OAqj1uJH80Qj1kYbYeD6BrIgEXz5xLU2bZJc3EgyjN5bsSmTtOR4uiVKgw9yt3jmCVO3uLRnN7zyiFr+NFsgG0/jPJkpaHBjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwbDW8TA+iYHjVcCQCoXJTR0bOhlwUMRVETTN3hMZE0=;
 b=JY1zKlCPWGxGB14zkfSGzwS8VdFYQyAYk88w52K7e0f/lLKwtDdGR08bW5vTj/6SQeCOlOhigoY/mIB6sLQvPPlIYlL2npWLkS02SY/7nTnioP8fv9PhSznwt+fMviJOe3f5QNlWynetByXgsrLhkvabgYU3nBee4JsA8u/UIJIGNjymJF4G/B5ZijRjwMwjIzCJLurypiz58mtWn8TUa9b3/MPVBGl45sJ9yPViEi5RzmOJ5XLqumUVnB2BpLHKr1joz1GnrdDgEHbtwjGFX8yLXwJQZM5sJVNcuKeDuN8huY4h3DOxwWGEAgNqKusdRxH1SU76ufudCZMktlzO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwbDW8TA+iYHjVcCQCoXJTR0bOhlwUMRVETTN3hMZE0=;
 b=nSiSA2ZV3IMx+uMneVbDak1myfKvX2N8ag449bgn+cMnMzCfWYiLJvSdauZSPK8mGodos42VkCoUHTrh4bKm63EoH66QHly/jZl8Yb/QkLE7Ac9QChoNAp14U6s06C/rXg4IK48TOB4DlTDEQNPcm1d9Bobe1V9nAEV7wNJlSPY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 14:21:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 14:21:34 +0000
Date:   Mon, 31 Jul 2023 10:21:31 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/12] SUNRPC: make rqst_should_sleep() idempotent()
Message-ID: <ZMfDa8YRUH3Lm15p@tissot.1015granger.net>
References: <20230731064839.7729-1-neilb@suse.de>
 <20230731064839.7729-2-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731064839.7729-2-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:610:e5::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b04153a-0021-409c-a81a-08db91d17185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzr7eaWOfZZHVLRgiPcGhSLb/LdlIJ7FrK6Tp21SwXO4luEeTJRVi69ouqA8osroBn5ICT/UwuSE8uIL52YNuQ5OWKWbRH9pmQipL+eSfn/ckRIjeZ1YK360/cXPhNpCOJGh8cryxZXCcQqCVfd37T1Hajfv2XAhIblgBhdh30XaCmbhzkBnUUoDp7HZKrB07twTmXLHk1CdY2AAgriSNmMi9jYu2GZ1t2t/QJAsVwqQjoFo0+aS6+d92+/lkto8jVD6wSdwWHFVe4OtPBL52UINS/wRekaGVIXNPNv/r7MsJ1lcEjBlH0GCG25KX3BnQLc2ruR45hFrbPZZceF4jD4D8asPlqqMzm53J705j1z/033ddcflMOKXKjgU+XfmMB6gXxcB7YdEFG985evvLIVZ17cNjaSpNwPsSMtcJUSB6ERrNg4sri+h8QzoR4P8exDBTsES7SpMrrSSPN487Pf6CitJmvco8098fV6ddySaxxy3KK46ngunkIZERFiQZZ5loAeDtPhNIGmyLoJ79Xjyc3MzfpPRaz5QR2zFzShUQkJ48yCxwxQ/p/qKFrdV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(38100700002)(86362001)(6512007)(9686003)(478600001)(6666004)(6486002)(186003)(26005)(6506007)(8936002)(8676002)(44832011)(5660300002)(4326008)(6916009)(66556008)(66946007)(66476007)(2906002)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2sA/dONPX37bRi5F7DhvFM1cy3g2J0NU/FBXAxj2wtzQwkVp8hIdmu/bxxs?=
 =?us-ascii?Q?fqvMyhWDkD7jIvcJkBRNYPmc0+p68qBLNS9MamkpHB46j00lhXFoawPyGhq3?=
 =?us-ascii?Q?gaRkWk9usFLeoy/tkudHWo8nHlbIj8L7KNe6k8bSFvEfmDwnjviVMm/yChBN?=
 =?us-ascii?Q?DvRKYJXLFJ+KDzoQdr6cWT+FoEbYiouV46Ap5wk2yYz3ECdGHK+uZ88zxTPx?=
 =?us-ascii?Q?ZEooHne85s0aZrPMxobFJQdUJ1y+Lk3T/C8TJCVesOzmUUrm3fi0MeqkJp3i?=
 =?us-ascii?Q?yOVRla1KV5ps0IJDSs/pDxdaNcjFqtzZKAt3sPfn8wXf5d/3HRNkjD/vizOS?=
 =?us-ascii?Q?3dXbHCy2KzCvCojq1SuZS/xb7D6KET+xMjHBcvH3k0yq76vByW7R9aYMvqyn?=
 =?us-ascii?Q?VqoutH1PrJ8F+gc6Ji+WNKtchmkcLc4tb9FjHzduwo62YxZ1EfbGCh1zH/P8?=
 =?us-ascii?Q?JuXAWEwNYHqOCGhRIhnxt2qI1+o4SS7jQLTkH7p96pN6CZo/Wj8k0aJskElj?=
 =?us-ascii?Q?6OOM+1B2din4haP8Ibq9X5PTfCW6fy3vZ7gMiFExVFr5irT3VeZWbnemeCr1?=
 =?us-ascii?Q?wZpEHSLoYx04I7xQ9BJlAaZj4cteLsUUEJUUCJzIcrGDWbeDN4SSYX7mF+Xk?=
 =?us-ascii?Q?e3XJqaDo+tQFuq7KjZtcCwr4cMtYGzmhXFzY/rd+6b8rqjoIkyoNslsvyyOS?=
 =?us-ascii?Q?sUIpTuo/JhTaO+fbHbLx6BaiUEeuya1D24MJ/wC0kUDUS9l10QS8/SSn0h3A?=
 =?us-ascii?Q?g8IxlwEk0G4qb9uEL9PqhBe0h63ZflXvM38LiL5djMwpf3ke2mqoraaPwhUr?=
 =?us-ascii?Q?BjuTiVv7pN5RYKBwa43RK2W6TQPwsZ2QSfKkmOzFvo4AVo+Y18jG9jOKoxOH?=
 =?us-ascii?Q?jEdxyo9Ktxnmme+4nIP+/V1zkS3Aqeiwx0S17xjB1NCUrnd9Sq3omt6/00DI?=
 =?us-ascii?Q?NVXVLeHYRHzywqPM3lFzEBSpPLqjqYPf4rVlyu/Oi4bA/xn1aHpJ1zI40oRw?=
 =?us-ascii?Q?LhH4uqZOheh7WC0VhI2qd6KeTME+nkhftdvvz9FztyxqVZIdM5h07LW9D3+Q?=
 =?us-ascii?Q?gh3XsN0VfeeZaQSFZJV2UOMC5B6max/st5Jc4KZhcUdG23JPF4H3qGpUJT6j?=
 =?us-ascii?Q?vvFw6AsTa0BABmySdYSv9lzF+iibIEhUBTsIWeYKiXjoRvg2bZHZX2Ubsitm?=
 =?us-ascii?Q?8F56OFNGXGSICsOJev5xUjnlXe/CSCyG3fdnJmlkG9/EaDGKAx0GWLa/Z0ab?=
 =?us-ascii?Q?p3vYuYWyywowgij2j+oYwP2DB/nR45RrsJkolbb8WB/HqQ6XprpoPFDPMlo3?=
 =?us-ascii?Q?dUe+yBh3iP+QRsC/L7neXjRQQ1yUWMkFDvFiWF7kW2qacnPFjdkqOgYG3dGM?=
 =?us-ascii?Q?K8kMD1nsFcXrH2jXEPOpTKZ2dH2C+Nt8p6WJKViuxAbtuwOp0ur9DTzsE1SZ?=
 =?us-ascii?Q?Tzh//0Q0kIv9SO/CEYAFcdMHJndmtC+HXUPjavcF2iH09uVDJ59XvfaGIK9o?=
 =?us-ascii?Q?g6dzIvhFMvWPvC/jrz80LJ6T2xdGUZLx+Ap4GY/9nZiDEnj6ADi7YZ64oL6z?=
 =?us-ascii?Q?SEJp0KJXe0SYekkSAoJk23lwWDJFKzMmPOBz66S0PP2v1xnZnF40L17mKVD7?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q68WeviQED3RYe7OofXfz9sL3p0XH2rFs3Wm2gsrDorOw6AnFGBYWJf8DgaMcL8A2IcewJBb/It0R9/hCqUGVW/P/Ul22m8+1G1z2A0YjGwZy6SZmT0fIYluy2RF8YKh8V+7da9HPbU8ojzSgYPCvQkIaeQ0z6cThi8eHEfxucH04BBPwDwwUvaDtxzyz7Sf5Qy+xMKtpcvO+Ak9cpsYknSA+HwVL2wRMhUsdSJl8PTSs8EtRGNS4AJyBAuAxAgzxSnRcyyE8tw9UoSX1awrU9hrHCpwwz8EgusQ+3n/P8y8ajB+Z0mzd1oHb4qCllcf9z4VQEKiCkagd5DbcPvjt2+wdZ+qtsLVsCgmR63GmFFhRperPQSwIlJM9ITlImVF5N7H7FGT0Ry/BC5IJEftf6O4vQyG5c/0MF01UTTsc8Ib9a2761l9jDppWlnBcN9i/WshOJdIaVptGLr9ACUBXwJf12N4Vh408PKVDsyXHZ9+WZ8AziDzRw8gDSd7GD0AAsp59Wr4dfFHZ96nXM/Hi9bIoTgsgYBCccr3p2y73wzIEBvjdA4aPavcqqZXZaKXslhaMzZwk47OJSA1Rq8rqVNipw0PdYjVrYpB/5nTmm/txtRwLIRP0fkNjvoWsdxP1HPx/0/BwRD048GvLs8ml+hWihCI8Tf+OvfVFet2ajyUkLh47h0X6zZi4wreK9MupUjjrVi+BKndjStTUqwF8HmuW2QUGOrl5KH5VuTn8j5eGFnmJhZmp9O94cBdWAcb7qAp8MxT74oh+RwSc5UbJLYiY5WPhbYHMETMxsO4zzCdoYg9BnkQzUvxaTkWNYOc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b04153a-0021-409c-a81a-08db91d17185
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 14:21:34.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTg9MbzmHktRPNw1I7SMN2hHz/idaAW32c7k4LP55WWhhR9N6roMReY/CHxw1NgBwua830leBqjoBaIOyaRHYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_07,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310128
X-Proofpoint-GUID: 51yo1Xo10eoY5xI9g3uKS2389FXf65t1
X-Proofpoint-ORIG-GUID: 51yo1Xo10eoY5xI9g3uKS2389FXf65t1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 31, 2023 at 04:48:28PM +1000, NeilBrown wrote:
> Based on its name you would think that rqst_should_sleep() would be
> read-only, not changing anything.  But it fact it will clear
> SP_TASK_PENDING if that was set.  This is surprising, and it blurs the
> line between "check for work to do" and "dequeue work to do".

I agree that rqst_should_sleep() sounds like it should be a
predicate without side effects.


> So change the "test_and_clear" to simple "test" and clear the bit once
> the thread has decided to wake up and return to the caller.
> 
> With this, it makes sense to *always* set SP_TASK_PENDING when asked,
> rather than only to set it if no thread could be woken up.

I'm lost here. Why does always setting TASK_PENDING now make sense?
If there's no task pending, won't this trigger a wake up when there
is nothing to do?


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  net/sunrpc/svc_xprt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index cd92cb54132d..380fb3caea4c 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -581,8 +581,8 @@ void svc_wake_up(struct svc_serv *serv)
>  {
>  	struct svc_pool *pool = &serv->sv_pools[0];
>  
> -	if (!svc_pool_wake_idle_thread(serv, pool))
> -		set_bit(SP_TASK_PENDING, &pool->sp_flags);
> +	set_bit(SP_TASK_PENDING, &pool->sp_flags);
> +	svc_pool_wake_idle_thread(serv, pool);
>  }
>  EXPORT_SYMBOL_GPL(svc_wake_up);
>  
> @@ -704,7 +704,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	struct svc_pool		*pool = rqstp->rq_pool;
>  
>  	/* did someone call svc_wake_up? */
> -	if (test_and_clear_bit(SP_TASK_PENDING, &pool->sp_flags))
> +	if (test_bit(SP_TASK_PENDING, &pool->sp_flags))
>  		return false;
>  
>  	/* was a socket queued? */
> @@ -750,6 +750,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
>  
>  	set_bit(RQ_BUSY, &rqstp->rq_flags);
>  	smp_mb__after_atomic();
> +	clear_bit(SP_TASK_PENDING, &pool->sp_flags);

Why wouldn't this go before the smp_mb__after_atomic()?


>  	rqstp->rq_xprt = svc_xprt_dequeue(pool);
>  	if (rqstp->rq_xprt) {
>  		trace_svc_pool_awoken(rqstp);
> @@ -761,6 +762,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
>  	percpu_counter_inc(&pool->sp_threads_no_work);
>  	return NULL;
>  out_found:
> +	clear_bit(SP_TASK_PENDING, &pool->sp_flags);

clear_bit_unlock ?

>  	/* Normally we will wait up to 5 seconds for any required
>  	 * cache information to be provided.
>  	 */
> -- 
> 2.40.1
> 

-- 
Chuck Lever
