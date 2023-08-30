Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40878D830
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjH3S3i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245535AbjH3P3C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 11:29:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B22FB
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 08:28:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9iOmF032349;
        Wed, 30 Aug 2023 15:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=FqMJF2eRzDVmQ7OPxTQrmsEOS9RrpYzW6b7jOSV8eDA=;
 b=k7iHPl8+Uwq7zwmZSGFhoiSu0gdz1qUQeHXG9Vokajr7SWUztfZKI4/IHGWQRdx9U4sv
 Z7jWWUJMuz0nLSO5Q0EuCWJMMSJW4cibrVZSUxgSolDJ+v0WkctNEDaxHg5gfsThdlON
 SFca7V/WJ6cfGzXEPBlf3N6aZYWKNk3inzngZzo96Wpscog5DN58Bv/GoEn+pbcntFKE
 cmQ8X98q8N7Ls8HIjukGbkLwQcocVOEHU+Fr4KXqV53pbwhwiEYKz6++wWK22VMYX4RZ
 96dAb5igLkGsWJYqcvjj0wSAXmIvkZxlauO56DFjBPGWx1SXksaSxHsqUHUYo5RarVDY LA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcqkf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 15:28:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UFHwIE009179;
        Wed, 30 Aug 2023 15:28:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssepy2aye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 15:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq+6US89fkj+nAj5chA4V6zXAy77QAPXHwi7bt24eoBEK2NaAcAd3eoUrb8XUSLVKe8KJjoFT/sp7RGZ5vq360P6x0hBTlzTK9E5w48o65L7WyKSNQlAc1jOrDcbdvGnoo9xxsA5u/naK9hfoIz+tlE10vxnVnCbMsyMsB6uGtYy2ka9DBro6uISG6gbaV/xjPR25MJp1EoL3bABhUvhZbBOxZBwKtVz8d9rlPNnZLx2w701mnZEEPDuAqSW9AJjH3kjIhMXQiXHGwYQUdZsr47olO/zjOk7UF2e0T7tP4luJAYebC9fP2LGu/XKbB0XnJu8T679nwMYHjmAQ1k/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqMJF2eRzDVmQ7OPxTQrmsEOS9RrpYzW6b7jOSV8eDA=;
 b=jRzDLfEc2uIUkdGnMSBS8ydOEMIk51pQZN6m+7/bpmkgPXASd0oFAzhnQfCMj+//8/2OoaA0Zve/WQMkxEEjLMXdYPqHtZNdA8XtGyqeyfRw56MO/zpq4hJr0Wk5OKNBhyIDCmF3cp3XP91F2+KIg2Uh6K5jMMcm4Qq8g4W6JpM0Kb1s8SEkNwW19DFzGaJDLbzIC+TnIxovlQlj+cVUFw1BWtFAR75KqWc8JKomvRaKQ8so4g6eKBYlRD9ZZSjP7P9U0RZw/y7dzMw90vgRvON7QwvC5hTS6w+hWTWCv89JKdhedDrZc13nK2P8hnTqidCopkr+71pAeqB66h0Yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqMJF2eRzDVmQ7OPxTQrmsEOS9RrpYzW6b7jOSV8eDA=;
 b=mFDr6JXLiATULcRmwhVMOjx2GhF3onBWOdSLPyW+VBEpJZq12V05sxx4JsKFUkcJrCRw5q2OCo62lwNhMDsOTG5rwhazrFtdJB0DAGw16DNsWDu1iafVH3+V887a/TzTyT9amGdzfbBJTU/IW8K6J2LsXSwh6L8Nq2BYJP59FMk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5934.namprd10.prod.outlook.com (2603:10b6:208:3ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:28:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 15:28:31 +0000
Date:   Wed, 30 Aug 2023 11:28:28 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/10] SUNRPC: only have one thread waking up at a time
Message-ID: <ZO9gHCfWzH+kegrw@tissot.1015granger.net>
References: <20230830025755.21292-1-neilb@suse.de>
 <20230830025755.21292-7-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830025755.21292-7-neilb@suse.de>
X-ClientProxiedBy: CH0PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:610:32::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a88ab3d-90f0-43a4-0ba4-08dba96dc44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7igmaKoT+OXt7mYb07hg/5Nwfq5QM0D6znXYC0vtO7JQG3L6Uf3lHzlq9VVUVJGRemTGGg0GNawe/oD4R0jrTjR8/PJsgVbiRFCjxlI5rwucT/atTiLAgNpYfLXwR0JqE0Eh053ppebtayz7CMS0UWKcy531Qc9CuVS836TCJN4LW5TEWf0Rt9aDwo+W7ukvPZElXSBuhALkRT3T6dPwftA+1sLn5pi/nAQ2YbN6mB7G9z3Ahq8Jx+IF2nNURFbcGs88/h6oJGj6M6n1lS2j0btiFcXlg/UFTIQUsgZyYlycauW5AZNTkgLEMcU1ygXBeJjeq9T/rUj14WHp+K0lb5UScx4Y7VYKYB3HyLnM0V8YmlRCi0ksvDT1PS5MET03STTlBK80RmqipORw+sYS0mzk3GGJtBQTbJIB7T8XHgJRGG7VSE622AkxyXJRNDHo+Xf/1YAZOWYE7p70fFi5CGdDc24F5765IxgZyVF3FUe+vHgFojwAczr+1bR8qMUlyHW8l053UsOkotxMryq2YGHQ3V2Wz5sIYNsGbgTNczGQceiyfgi5KR7J7YaAJMTXCe9NglFs7LCnuuScJmk/CsPEzAzs3DNFHwKYUQ9u1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(186009)(451199024)(1800799009)(83380400001)(4326008)(44832011)(86362001)(41300700001)(5660300002)(8676002)(8936002)(26005)(6506007)(6666004)(6486002)(6512007)(9686003)(478600001)(38100700002)(2906002)(66946007)(66556008)(66476007)(316002)(6916009)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/1rj91AuCLaOtDPRsDklSgoSj+ais0UGDC+6uP9eHDLX7YuUyUOjq/QHg4TA?=
 =?us-ascii?Q?96qtdjTuGXbLrmKJ2uXZVNz+N4WRFyvEvMcO1i7xybIZ2XsLZIloD7zlx+z+?=
 =?us-ascii?Q?Ypzbt+t00AjKm42bwQX8FmOCqhGDoMnPHLJPccDM8A9BooxAQSJ85WslnaT3?=
 =?us-ascii?Q?FxaL9BZ4E2mlXQj1dQQPCcgXfqhhyFVx5evqrdt68RxPCeTAR5WeC4MifPmr?=
 =?us-ascii?Q?Rb/jIFx6A7s97qQViBz7A7G91vzPnywrvfx/Ve9I0Vspd6OwH0c2osZPh2qk?=
 =?us-ascii?Q?j9xmg5pVZJyr1oE72RTlu7kB6/hdGWQT+6fxW7lYC2QuMvPoyV+NYXoOI6o4?=
 =?us-ascii?Q?p2rmXEZ2ZCJVkjwUPMd8rkBhUAa7pbTSaQjioNejOsVJOaLOITS9Uw0M9HUb?=
 =?us-ascii?Q?Nk8G/qSWWIvRNocvf4R6F2eNXSBHzmFF6WmzRqfVgceFglqqUfYg53cWmsxS?=
 =?us-ascii?Q?usyyEzgZ7A22rHjfS4DmgkhFbIcm4YAdz5qbi+zKkAsUTt+a53fiC8O6sX+0?=
 =?us-ascii?Q?eGNJ4v2OKENrGK1ZZHBaWUK+HBA1QJdS+v5LREQeUjNJLzZ+OJGbWxFVmUl/?=
 =?us-ascii?Q?QGjt+FZJOdzjJvw9CzQ+i38KV94lCOVUdBKZw9TYO5djWu0q1yKJ5I2OGEM2?=
 =?us-ascii?Q?KNJjyioBAUstMovB5VuIWcwJAxzxcv/y+cixAMyM0iq/PQPlcMDiQ1SRr2Aw?=
 =?us-ascii?Q?3kZziK7wBQrfVlJg0DGFLXZ587qn0TVAlHglC70LlVOM+abTgwsIkAdvCgJB?=
 =?us-ascii?Q?7Bjj3a7yCYh1+vrLUSUJEaDMWpz/nKOvr0QnRfpIBBW3mzHZVcwScPr3TbW4?=
 =?us-ascii?Q?fX9s9GCALjYFJ19Zfy6GrMHLySsZroWcTGlyMSWgTxRaFA1e40BBVqt/Odgm?=
 =?us-ascii?Q?TR5LncN8wAAHGyTz6LoBzWLVrHTfsjzmFVFHww+6207lfPYHnhZqJDH3IzJs?=
 =?us-ascii?Q?cfcuV4j7V8wUKHXwTF/IRSR7Ec1jiEjCzchqT2JCGME+JR01pUaEyFffBAO5?=
 =?us-ascii?Q?Df072hL0PeHKMRBVnJFnusIETH02pXRR5/zmmqIWosbqGrgCb2EUZxGi1cOH?=
 =?us-ascii?Q?UzvVpKVQr12EM7iIKIYiyPe3qEv+r737jEuRrUlDqaK+liDwEaYz3pRYTJLU?=
 =?us-ascii?Q?vq3mQ2dr/N+FNo7Y8JF9wojn+D60cMxvlLSHoNu9VG8qL/Oi89TFfVdfUEuk?=
 =?us-ascii?Q?+25lS8/i1jEiz/gsyDjE73yY5xK3KDwoyYsPbfQksL+BDtT9gKW1H/BJlcCU?=
 =?us-ascii?Q?JuYuXpRUbiVuGGv1KGtqRsXD6145z2SRw/Ccv6b5VVSotVtJhegJyXfL35bV?=
 =?us-ascii?Q?74bLiAdl+xxZ7mPEEvGJ0UGNvMZyyBX79HUBIItnPIaRj9dnS3DFATau9XsB?=
 =?us-ascii?Q?KFz0z/ckTzlvF/pA43re0CA6MLIh/rdNdFQ1XNOnB3c/SiccC1rjLJupQfxG?=
 =?us-ascii?Q?iDDnsiZJmOtE41z0W+9bGmmVQupjBq08LdsKSQpSmyaBo668ImxJ9nlCFRYA?=
 =?us-ascii?Q?G8L4PrpU843Wmk79I62ToemwTfWjUXYZFttvCaTkrRPJY+6V1AM2iwfcxhpT?=
 =?us-ascii?Q?Mv268QAU9i7Fi2GOUP0lYg+WUXESk+UUOyTPdVk6X6iOtF0OxaKEKV9ZcbYB?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Oo+FbqY2aOcDULfAJ41Np/3yUOA2SGfEGhzuUu43EsYKR05Xv7/y2QZUYtEANVaFWyLY8dgu7mp64Qv9UJWax09F1iOgJTcSoHs5botTz4eP0rykcPke0NSz0KCgIs6AeHCcFDE7qZ+jM12osotVBFSnSYNlF3bSB20mbvt4abK36DTK++Aw/NsybvjppvU5QX+NNwCxw69Fi53F0AMkxAhfHYMzeQR11r0jY+udV8MjDKX0NWMgsrL3NuYllef0/naFmLct47tQdGgX7bfk6n/FIqKVuAxC5vbGiwzv0rgr1iqyIzS5QY0T0Eu1WR4PGnzAIXpLpjOC2GWGNFCedmclTp5dLltoahp/s7h9L+jgBzHCSBoCEE/85SsdZJfF6DT43JnmrcfrBRjuVzEIWEMfE+7Gx0KUawhWXmT2enFUCA4EuHFK/lo/KoAXTuNPmI03Zxfnl6l4Iq8wq33tX84cb/yXriL2JZqe+Hy+HMZoIT1mpPnF1ol8xTmegVzsJk9sBMscmjzAO39I4ARL2l9m0o2yAQ/4cD3hEJOj9BVC6+cZ6UHntE6p3p++u5NxvNVYQ6CZDw9T9znlNTgYu5TCjliOp1jH4uuCNIO1naXov/yrjtLwk0pBrsRpaFTNcIJ4dgwo9l34gPAegvSiwXbwM205LNQTk6LV89HEWgxpW5HOXVez4j4JOV6Pc616pjQq0SlztGy3eFL7A9pMXPMxpdZ2DUrj+x5yGJStdlHt32qvH4olhLMwBH3NR88IMnqO51xawkGuWGjKv92J1OhnvB+7NBsuHpVa7RSfSRwlry8zsr52xR+3mx+xnq5y
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a88ab3d-90f0-43a4-0ba4-08dba96dc44a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:28:31.7495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhpMpU8wGTC6MuH3HbBnjGtWuxj4LbLwhMENH84g8WKYAVT0rk8nRKddr2RGKaJinsKZ69q++Tfwkh0kJMztoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_12,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=730 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300144
X-Proofpoint-ORIG-GUID: 2T2wQz-WtOKc-dm0cA8djG8TasOW3_Gp
X-Proofpoint-GUID: 2T2wQz-WtOKc-dm0cA8djG8TasOW3_Gp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 30, 2023 at 12:54:49PM +1000, NeilBrown wrote:
> Currently if several items of work become available in quick succession,
> that number of threads (if available) will be woken.  By the time some
> of them wake up another thread that was already cache-warm might have
> come along and completed the work.  Anecdotal evidence suggests as many
> as 15% of wakes find nothing to do once they get to the point of
> looking.
> 
> This patch changes svc_pool_wake_idle_thread() to wake the first thread
> on the queue but NOT remove it.  Subsequent calls will wake the same
> thread.  Once that thread starts it will dequeue itself and after
> dequeueing some work to do, it will wake the next thread if there is more
> work ready.  This results in a more orderly increase in the number of
> busy threads.
> 
> As a bonus, this allows us to reduce locking around the idle queue.
> svc_pool_wake_idle_thread() no longer needs to take a lock (beyond
> rcu_read_lock()) as it doesn't manipulate the queue, it just looks at
> the first item.
> 
> The thread itself can avoid locking by using the new
> llist_del_first_this() interface.  This will safely remove the thread
> itself if it is the head.  If it isn't the head, it will do nothing.
> If multiple threads call this concurrently only one will succeed.  The
> others will do nothing, so no corruption can result.
> 
> If a thread wakes up and finds that it cannot dequeue itself that means
> either
> - that it wasn't woken because it was the head of the queue.  Maybe the
>   freezer woke it.  In that case it can go back to sleep (after trying
>   to freeze of course).
> - some other thread found there was nothing to do very recently, and
>   placed itself on the head of the queue in front of this thread.
>   It must check again after placing itself there, so it can be deemed to
>   be responsible for any pending work, and this thread can go back to
>   sleep until woken.
> 
> No code ever tests for busy threads any more.  Only each thread itself
> cares if it is busy.  So svc_thread_busy() is no longer needed.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sunrpc/svc.h | 11 -----------
>  net/sunrpc/svc.c           | 14 ++++++--------
>  net/sunrpc/svc_xprt.c      | 35 ++++++++++++++++++++++-------------
>  3 files changed, 28 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index ad4572630335..dafa362b4fdd 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -266,17 +266,6 @@ enum {
>  	RQ_DATA,		/* request has data */
>  };
>  
> -/**
> - * svc_thread_busy - check if a thread as busy
> - * @rqstp: the thread which might be busy
> - *
> - * A thread is only busy when it is not an the idle list.
> - */
> -static inline bool svc_thread_busy(const struct svc_rqst *rqstp)
> -{
> -	return !llist_on_list(&rqstp->rq_idle);
> -}
> -
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
>  
>  /*
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 5673f30db295..3267d740235e 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -642,7 +642,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
>  
>  	folio_batch_init(&rqstp->rq_fbatch);
>  
> -	init_llist_node(&rqstp->rq_idle);
>  	rqstp->rq_server = serv;
>  	rqstp->rq_pool = pool;
>  
> @@ -704,17 +703,16 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
>  	struct llist_node *ln;
>  
>  	rcu_read_lock();
> -	spin_lock_bh(&pool->sp_lock);
> -	ln = llist_del_first_init(&pool->sp_idle_threads);
> -	spin_unlock_bh(&pool->sp_lock);
> +	ln = READ_ONCE(pool->sp_idle_threads.first);
>  	if (ln) {
>  		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
> -
>  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> -		wake_up_process(rqstp->rq_task);
> +		if (!task_is_running(rqstp->rq_task)) {
> +			wake_up_process(rqstp->rq_task);
> +			trace_svc_wake_up(rqstp->rq_task->pid);
> +			percpu_counter_inc(&pool->sp_threads_woken);
> +		}
>  		rcu_read_unlock();
> -		percpu_counter_inc(&pool->sp_threads_woken);
> -		trace_svc_wake_up(rqstp->rq_task->pid);
>  		return;
>  	}
>  	rcu_read_unlock();
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 17c43bde35c9..a51570a4cbf2 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -732,20 +732,16 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
>  	if (rqst_should_sleep(rqstp)) {
>  		set_current_state(TASK_IDLE | TASK_FREEZABLE);
>  		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> +		if (likely(rqst_should_sleep(rqstp)))
> +			schedule();
>  
> -		if (unlikely(!rqst_should_sleep(rqstp)))
> -			/* Work just became available.  This thread cannot simply
> -			 * choose not to sleep as it *must* wait until removed.
> -			 * So wake the first waiter - whether it is this
> -			 * thread or some other, it will get the work done.
> +		while (!llist_del_first_this(&pool->sp_idle_threads,
> +					     &rqstp->rq_idle)) {
> +			/* Cannot @rqstp from idle list, so some other thread

I was not aware that "@rqstp" was a verb.  ;-)

Maybe the nice new comment that you are deleting just above here
would be appropriate to move here.


> +			 * must have queued itself after finding
> +			 * no work to do, so they have taken responsibility
> +			 * for any outstanding work.
>  			 */
> -			svc_pool_wake_idle_thread(pool);
> -
> -		/* Since a thread cannot remove itself from an llist,
> -		 * schedule until someone else removes @rqstp from
> -		 * the idle list.
> -		 */
> -		while (!svc_thread_busy(rqstp)) {
>  			schedule();
>  			set_current_state(TASK_IDLE | TASK_FREEZABLE);
>  		}
> @@ -835,6 +831,15 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
>  	svc_xprt_release(rqstp);
>  }
>  
> +static void wake_next(struct svc_rqst *rqstp)

Nit: I would prefer a subsystem-specific name for this little guy.
Makes it a little easier to distinguish from generic scheduler
functions when looking at perf output.

How about "svc_thread_wake_next" ?


> +{
> +	if (!rqst_should_sleep(rqstp))

rqst_should_sleep() should also get a better name IMO, but that
helper was added many patches ago. If you agree to a change, I can
do that surgery.


> +		/* More work pending after I dequeued some,
> +		 * wake another worker
> +		 */
> +		svc_pool_wake_idle_thread(rqstp->rq_pool);
> +}
> +
>  /**
>   * svc_recv - Receive and process the next request on any transport
>   * @rqstp: an idle RPC service thread
> @@ -854,13 +859,16 @@ void svc_recv(struct svc_rqst *rqstp)
>  
>  	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
>  
> -	if (svc_thread_should_stop(rqstp))
> +	if (svc_thread_should_stop(rqstp)) {
> +		wake_next(rqstp);
>  		return;
> +	}
>  
>  	rqstp->rq_xprt = svc_xprt_dequeue(pool);
>  	if (rqstp->rq_xprt) {
>  		struct svc_xprt *xprt = rqstp->rq_xprt;
>  
> +		wake_next(rqstp);
>  		/* Normally we will wait up to 5 seconds for any required
>  		 * cache information to be provided.  When there are no
>  		 * idle threads, we reduce the wait time.
> @@ -885,6 +893,7 @@ void svc_recv(struct svc_rqst *rqstp)
>  		if (req) {
>  			list_del(&req->rq_bc_list);
>  			spin_unlock_bh(&serv->sv_cb_lock);
> +			wake_next(rqstp);
>  
>  			svc_process_bc(req, rqstp);
>  			return;
> -- 
> 2.41.0
> 

-- 
Chuck Lever
