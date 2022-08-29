Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406F45A53F1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiH2S04 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiH2S0z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 14:26:55 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781A74DC6;
        Mon, 29 Aug 2022 11:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntI+8yeDiar0jo/f2bCgTZurNuFkYQX8/SPa/rXKj9KbfZ1zzhmclS9D5ix3ozuXcNRSx6z3cWOSEoaUl7/W4UP86/Jz/ka5tnRhiB5WNYAk15h35caern/WRKUEmPOLSO+pbe5hby5aGho7WxPCNP/T8U9Wi3Qc+RZqwLLr+y74eGio7tV4dKFq1ofqV1Y6EZb+Ev5u7z0EzP7tuQqCDG1naKtCaX1UerRc2FOKS31vflKAau83uoA95lKWOfZWmwXf0JhPQLp8uNyAy7Q109ATXqarhRHEO0Yk8CoN96tmHgp9DY0EGBdlzFM4+pKB1/ud0Sai2NVbWowT7g9CHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2F3fBLCC9bolyKgDpJX+Zh9QPQI8Isxo9TT0S3Vk9c=;
 b=MDrGigVIQ52FVeNJiROnQ6I/2qvhnVlJGNHGAI8oB54tEJ4nBZ3yMHxGl04yQg+Ae2N0/PiIB7zGDrlJAv7KJMIfzH0dlMJ+ayxAH35d/AAOhGcrkExW19i/aRv01EbZ6tmb2P/K59a+ZakR/FewMPhGSZIJC5zjEcv/9RmFaZsflgI6LaaCqEq/N2zDUI/cTmSLKDv+pguAlqjlBTa+b6lw7U3hYOeF0WIhc7TEp8Co9aLwxEC+Da4gLVR3ZOQ4C3S26J2Hilfm4s9TPu6x/dJatfX0uK+o+VMD5bw96mFMXsSQJkHEqOZ5RNuEUFV+Ut5MRTVUpu4T09axbh3N0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2F3fBLCC9bolyKgDpJX+Zh9QPQI8Isxo9TT0S3Vk9c=;
 b=GakUYDYUHXBiwsuCFvw7+iBvgHXCH6KhowE1818YlLLgmdt82yrikHuNdkAfzsnaXuFEo4yORrn8RkU2Ww7hpUjarlHFW2WF79mWYF6iEO59P8YmlYipSK6TKG4K6fOCb4ODLEqAwZcyE7RqpqT00BZ+NmxejWAA9fcwmuu+fkU+MKcClXz69jFMDAwuzOmsP+Hc5UoSHJZNQkKLjvk963YfOGNskzd8hm2eCFo1U9M/EAo/c0L9nERi5MF5O9Ol5z+GhX+h8utQjZNIYPgQ/k3A7L7SAHR/yV+n7nB8MO2HGyKp0Qck4Zl/sEebBqYOn/AWg9D6U5v6nkyeOc2U1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 18:26:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 18:26:52 +0000
Date:   Mon, 29 Aug 2022 15:26:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Message-ID: <Yw0E68fl/FcvUSnO@nvidia.com>
References: <YwXtePKW+sn/89M6@unreal>
 <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
 <YwjKpoVbd1WygWwF@nvidia.com>
 <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
 <YwjT9yz8reC1HDR/@nvidia.com>
 <FF62F78D-95EE-4BA1-9FC6-4C6B1F355520@oracle.com>
 <YwztJVdYq6f5M9yZ@nvidia.com>
 <90CD6895-348C-4B75-BAC5-2F7A0414494B@oracle.com>
 <Ywz15s75El7iwRYf@nvidia.com>
 <904E5390-9D6B-4772-AAE6-DBF33F31698C@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <904E5390-9D6B-4772-AAE6-DBF33F31698C@oracle.com>
X-ClientProxiedBy: BL1PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d705ad-64f3-45a6-0299-08da89ec0b2b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuA3DKqHiqypisYllZBnsdce5dlIp7pW/NzSAE8twF9SgSXD+tPa0YU7FCjhD2dsfrMnPS19xLD/QyslG87QCwYSSu3hzwpt64PKsZe0Kbz3Aq9J5LEQ8XxvTS8h4P1L9LhZRamxl1aS38MkFuGvOWCt7c8X6Y2+0v4F3+zm1UgBqSPqxgRdRk/bCSLr0+l7c9dvUZBnO0t3y8CXAWIVzAPD3V2uKX+/sTAYv4Zo1TyK19K83kBuapsVRO3JT8EOxUx6PyrzX4dF/yvOgYYuN2TaGiohXSmC10HTmoY8aVmqXD9K0vna3AsfPyZJvWQOtNpFk4rzxCPNOTG8E1+9jUqpNO2MTuoJS4UcszAyMZBtH5h+zuwsNcJJlyF90zaezEdCql2dLsRYCE99gHJ/eYrrgj5grs7EDQu9ypA/46qPkLxgyBJH39q64Y+twmnZGLcl2NmOza03BjFkig46MmX1eqLene/kwung6vkkkWzIPjNgWyMFrk32ushKM9wxykEWQIEgQOzvzvLvZpX24D1JpMHH0pmp45TBrdANLaGAlPZtwij5cM1lqGzZ6FdSm/LMjc/DrAyRvfEHmlIpe/dfEBGnTP9tfyOI2xyQifMTDj6rsf777zWYj9zoxzXm/0qR5fIO/DZMsWPxOvfg8bAH0fIMnRo+HHYQ48bPa8GASFe6zF+6P5khsriKkBTAop4JNiL9GVs/cckFk+FxyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(66946007)(54906003)(5660300002)(8936002)(8676002)(66556008)(4326008)(2616005)(66476007)(316002)(2906002)(6916009)(36756003)(6486002)(478600001)(41300700001)(6506007)(86362001)(53546011)(6512007)(26005)(83380400001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZPqPED1UzJHjzcum/NZxz2F/St2RcvB0CHaiS/K4OIzJjw1gdAWpFVJs3MU?=
 =?us-ascii?Q?/R/86LjJLirX5Z2o0ed63AVuqB3NVVZQB0gCQeg2SmOlQxvG69xyHcAdA4if?=
 =?us-ascii?Q?9cpReXOUmrYN+wxacB+IT9ySHLtoZrWe2PWDaJNUJCbFTu8nFu4ejNOygkax?=
 =?us-ascii?Q?PjIk1u7IA3ySyKOEcY5U0+LezL2BjFOOcStEb5wAT7wUhWIgzZbHqNMaBrlV?=
 =?us-ascii?Q?hsXUjwNmFLTLoVjoaWSdVkf6UaiCz2hznY1ttBxq6gaLdIUK9b1Q1INCmeRw?=
 =?us-ascii?Q?Gp6/NZAPConzo+vnjVZmnh05BA1obOKGcZZEKAHcjEW7MfuNfq+Ndr5DdKPk?=
 =?us-ascii?Q?oPrCYCCGOsZ9AF8LlBqBtSS/wui3u8uI//ETT5nmyaATEtISRD23deEQLMGG?=
 =?us-ascii?Q?DhH31GHd4W30jbghqBI8qK6lqtU3q9Dtj7u0od2blpv7+fERSj46Dk+M+kaO?=
 =?us-ascii?Q?QLzXqur0W3PutrgkVMUOEtbrIMd1rifmYTbcNlpKVv526yUJXjFKiEiEXRhS?=
 =?us-ascii?Q?97iqhNwXLSgi38Q1rMTtZOsiycHjSttdKL9oWCE79FgZQPn0yTMg4zA1KkpO?=
 =?us-ascii?Q?rZ7TtHMvNBwBkr8Qxz8emUQL9JOllgRZbZAxI+pgNQAJpSfbrXiZ5PfPhrog?=
 =?us-ascii?Q?Z1OgeXPm3ZiHNhynmnHxGSE1VZhKVKPUzczNd8b6k+yTbwGf2ScTmb19hLw+?=
 =?us-ascii?Q?3MztJpNuaxnn0dmoX6c3QxA0ZTUF8CMeKYYfvaEagwxdhiIiWyyTHezj7OXe?=
 =?us-ascii?Q?3t/pVzhISSOsaSpSvNBc2BBONZnY5O7Nd7PLNc0fQHlYaVcXQzIrY7ubn0vD?=
 =?us-ascii?Q?CgyacHcPm//TrVEg+SW4nlXhzckAP+C955XdNouhlVwnTG1m4VP18R0KZePk?=
 =?us-ascii?Q?MiCUAPIZEDcWg43SS3guyhpA19hG+VZhgHDxynvjhbkwZSZ5qs/HKINyYztf?=
 =?us-ascii?Q?Z6lX1kLdeZ5kKyUi8Z5djVo2S7zfnKxxjQPJQ4QhLRq1RrOhMtP1/EGS2cXK?=
 =?us-ascii?Q?kfr2dw1LBOJuD1LXmgX/M4HHtPH8WttoGVAqOwAmE7KG/H26apLMGVastkY6?=
 =?us-ascii?Q?CozLQw14WCQoG3I2itfGIrLS9utOxBwBdQHy5ooK7v7apaA4/GpV35cI/MBT?=
 =?us-ascii?Q?xGG/RUR/rrjJwnS5W7MSxbn8aCkc/mVqzxdl09R12LBcFbQA1hV9rL2YIcxE?=
 =?us-ascii?Q?OqlTh8cWwS8oMJvoiOAu0NhNZkhFnd1+6lT3GT4PwnvbVyU/k64fnieJ/7Nj?=
 =?us-ascii?Q?+MJ9WvdBrORESohqk6kRr72KCpABQOYbJi7Le/SCFnPvSnco0BcLwkTWwivk?=
 =?us-ascii?Q?pP4PS8V4CI2roU4em7XNiZMu7bq0D7PkHj06zG7GBD6TUQK1dPbz5UwPDvo/?=
 =?us-ascii?Q?Q4fIY/nu4Me7McODrUIQgfv02MRQXugQ+UCT/+ZnDTygl8ZyFDrmPChZP0ol?=
 =?us-ascii?Q?Y+cnoSOrA0DbhoIJEg7+kYIhA4dy4dfN5bz7tFPWQGsITg9GQ3OhqdvmEtyy?=
 =?us-ascii?Q?GV1csixDJ5aa5Qrl0q/T0yShKaYQ+LIWU6CMXBvB866WbdB5MEfcSZvf+iEN?=
 =?us-ascii?Q?6TbApkNZAH9ILenffge1Fjekclvod8pBlReU+Vte?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d705ad-64f3-45a6-0299-08da89ec0b2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 18:26:52.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6t2xQd2JbqgoUQ/Ih2WEMjRrmqwu/WNbsLTBKkq5BpGxHDGbajBAVzAqjRc1kh8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 29, 2022 at 06:15:28PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 29, 2022, at 1:22 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Mon, Aug 29, 2022 at 05:14:56PM +0000, Chuck Lever III wrote:
> >> 
> >> 
> >>> On Aug 29, 2022, at 12:45 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>> 
> >>> On Fri, Aug 26, 2022 at 07:57:04PM +0000, Chuck Lever III wrote:
> >>>> The connect APIs would be a place to start. In the meantime, though...
> >>>> 
> >>>> Two or three years ago I spent some effort to ensure that closing
> >>>> an RDMA connection leaves a client-side RPC/RDMA transport with no
> >>>> RDMA resources associated with it. It releases the CQs, QP, and all
> >>>> the MRs. That makes initial connect and reconnect both behave exactly
> >>>> the same, and guarantees that a reconnect does not get stuck with
> >>>> an old CQ that is no longer working or a QP that is in TIMEWAIT.
> >>>> 
> >>>> However that does mean that substantial resource allocation is
> >>>> done on every reconnect.
> >>> 
> >>> And if the resource allocations fail then what happens? The storage
> >>> ULP retries forever and is effectively deadlocked?
> >> 
> >> The reconnection attempt fails, and any resources allocated during
> >> that attempt are released. The ULP waits a bit then tries again
> >> until it works or is interrupted.
> >> 
> >> A deadlock might occur if one of those allocations triggers
> >> additional reclaim activity.
> > 
> > No, you are deadlocked now.
> 
> GFP_KERNEL can and will give up eventually, in which case
> the connection attempt fails and any previously allocated
> memory is released. Something else can then make progress.

Something else, maybe for a time, but likely the storage stack is
forever stuck.

> Single page allocation nearly always succeeds. It's the
> larger-order allocations that can block for long periods,
> and that's not necessarily because memory is low -- it can
> happen when one NUMA node's memory is heavily fragmented.

We've done a lot of work in the rdma stack and drivers to avoid
multi-page allocations. But we might need a lot of them, and I'm
skeptical about this claim they always succeed.

> This issue seems to be addressed in the socket stack, so I
> don't believe there's _no_ solution for RDMA. Usually the
> trick is to communicate the memalloc_noio settings somehow
> to other allocating threads.

And how do you do that when the other threads may have already started
their work before a reclaim writeback is triggered? We may already be
blocked inside GFP_KERNEL - heck we may already be inside reclaim from
within one of our own threads!

> If nothing else we can talk with the MM folks about planning
> improvements. We've just gone through this with NFS on the
> socket stack.

I'm not aware of any work in this area.. 
 
> > Even a simple case like mlx5 may cause the NIC to trigger a host
> > memory allocation, which is done in another thread and done as a
> > normal GFP_KERNEL. This memory allocation must progress before a
> > CQ/QP/MR/etc can be created. So now we are deadlocked again.
> 
> That sounds to me like a bug in mlx5. The driver is supposed
> to respect the caller's GFP settings. Again, if the request
> is small, it's likely to succeed anyway, but larger requests
> are not reliable and need to fail quickly so the system can
> move onto other fishing spots.

It is a design artifact, the FW is the one requesting the memory and
it has no idea about kernel GFP flags. As above a FW thread could have
already started requesting memory for some other purpose and we may
already be inside the mlx5 FW page request thread under a GFP_KERNEL
allocation doing reclaim. How can this ever be fixed?

> I would like to at least get rid of the check_flush_dependency
> splat, which will fire a lot more often than we will get stuck
> in a reclaim allocation corner. I'm testing a patch that
> converts rpcrdma not to use MEM_RECLAIM work queues and notes
> how extensive the problem actually is.

Ok

Jason
