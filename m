Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47415A5307
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiH2RWw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 13:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiH2RWv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 13:22:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1A762A95;
        Mon, 29 Aug 2022 10:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG/iO473eQ2ebHHsMpRfykPKfppWqm7gbE4Zsx0qPCu3NgFd3Poz0rzieH2ms4/oyZfEa1drWMAI8M4sbDrM7p0g+j5X86m5kUvsVofyS0MLzK5FndnMbWo7/aRMtIkmwnVEgtE+w7dXihvghADDSJZCVIuP8onSlOw17CNjymS8UvG0tddh9s0HP6FJaQAKQBr1S+QK5OM8S9CsPFGb3VQ+01A0Ggo80kp/SsahZVXtWJnU6PtmIlbjTTxCOEtARkksZc3JfPe9fxjQuzIpJ+YCHcyrt7V86aGCCiSNZ4MADtISuLQGtTw1cK4C2z1j6pw9AQGaCXh7YJImb6tuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygzdmENQRy7jh4hnPL3XgYElofSgoLCevzMbs2/Ma98=;
 b=XOfSeyOWlWuWy8QN9QtiDvdELGZWvbIgkzZIFzIuIPZXFSyNPn3GeoKK0Ms6s0NAbQSs1KLcrA306uDWhFKvya1t32cUp1+NHzVIvnRsyS/hwEENGsyEphTQz0ryB1YOQIbGlQZGW2W4QyxdMAw3VykGEhjF/8Dd5U5nDs/Bt+XBhcDt6COu6TW4keJohC4kPH5BhN9KIpb+ddBKKK/6qJTmlugTKOieA8uaDTzdvZvl7Y+a9oXSNqZE0MjkCZhzEArLRiCd7eYBGgwkIziA6+2iZSL59ntFlrf6ua7ix9oOV5wxY2LZMpz1y2HlXGOwfHmT6gs6BDjyuhm/f/9mHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygzdmENQRy7jh4hnPL3XgYElofSgoLCevzMbs2/Ma98=;
 b=Px97UEBhuwEB/KWrz6Zh9VAmq2kNRrSHUse9IlhccB2Q7R5iFKc+Dmcx7iD0dupliZ0zyKXeL+C2kgnyrHX+3tlTpO9t35iq8+qwt6bVk1QiMvli3caUqlr4KQreBRqtp8P+Rh9A+HJdWHs4uO/0xgw8XmVwjjIak3hsv5yFr5xo9kdLohvgTB1tsNJ0BCWy2rrFAwcElCbZ9rfac9tGB/KiexaH3HVC5K4AFMieOeNYf+HA1cNzFJYyQFDrkBA6+kWYzpUeA+JgKx3S6OT64eqAO062fbmgJ7RcMLQWLIvdtXFWfJ6lA30bimP8LLPTnrXr1R/8N+aK4nhHEu9jkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB3667.namprd12.prod.outlook.com (2603:10b6:a03:1a2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 17:22:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 17:22:46 +0000
Date:   Mon, 29 Aug 2022 14:22:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Message-ID: <Ywz15s75El7iwRYf@nvidia.com>
References: <YwSLOxyEtV4l2Frc@unreal>
 <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
 <YwXtePKW+sn/89M6@unreal>
 <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
 <YwjKpoVbd1WygWwF@nvidia.com>
 <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
 <YwjT9yz8reC1HDR/@nvidia.com>
 <FF62F78D-95EE-4BA1-9FC6-4C6B1F355520@oracle.com>
 <YwztJVdYq6f5M9yZ@nvidia.com>
 <90CD6895-348C-4B75-BAC5-2F7A0414494B@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90CD6895-348C-4B75-BAC5-2F7A0414494B@oracle.com>
X-ClientProxiedBy: MN2PR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:208:23e::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ba409c5-1743-4f5f-a831-08da89e31740
X-MS-TrafficTypeDiagnostic: BY5PR12MB3667:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtMPYEOC0DW8zSuyiAxYRIT5bXGQFwErHm2vpClJpZr4Yy0zSsKbZinoqjp7vubn83PQxIy1gQgeBZYH1yrgqadgCk2t6QunzonXeZBthUw/WMZhImgP2Hf7KY3gT4ImCC7+d8Ynl9t0wJpuTrre/4rOrnpGJFW5tui9fa4pO5zHg2dkHcPRUwOPQdFBUi6ZGIse7aJjT0bvERMExY1P8OgIxSMmRg7Eb73oNKXB5iei2yxRpE9eUnHY/emSAkM1ElrM+jqcbg4DsYWPTRJZFS00vdN4KG9lgnN9JuwZmMwxnzPkl3K3QmbRwoFr9zBPZj5SNjnZ65HIo+2xsdEIN5pGSj6q6bzM4qmqb0TTn9aZOCdvXMmBhC5z176y1IWaXOY6/chTjDcH+gziYtoyEqN/M6CT00flVea/j4hwdPUByL0pDoS5vvlDJcMCfjJmav/GJYxa1+7EEBx4Ppl5bITM7wSIYdlALvTD7EL8arQQfhQ+t6MLVs/8TbEjEWQlr+C1eldFlk4w9p3SS6hrH5IatJ4vxWqcywWcG1lg6yCZqUYVZPU/3bo45EENK8fbVef4/2yPjPQka3b6PEd0/+YORXEo6V+csFDjALr/wjbgW5vtTLHeAQAluXmixei0lHTa+RsuzeCZlpuoR0TvUCn0R33kq/R58iF4bdfk8eKRu3jOdKXOPA5PjyYzp2JjZawACDRPsSZl+d6n11P6/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(4326008)(8676002)(66476007)(54906003)(6916009)(316002)(5660300002)(8936002)(38100700002)(2906002)(66556008)(66946007)(36756003)(6506007)(86362001)(53546011)(26005)(41300700001)(478600001)(6486002)(6512007)(2616005)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?etwRZI/FKWlebAES8x+H/QpckdhV0xrjwXMFa9p5kM+N3a/x0Cq+JSx0iSS+?=
 =?us-ascii?Q?GOvarf3Jxf0YxQruI4qwnXX//VwnqXftdDAc2weVWzRwQRgNbnZcKzYDPEFD?=
 =?us-ascii?Q?5udUPuox+9V1u0ZFNC75zD9zdqHa2LA26BYPMXxqtvm/JkSoELRVAl3zzFB8?=
 =?us-ascii?Q?W+8/nMK4tosDcoLIleEczbbzNsEmCdml6aeBpONzIdX8SuUaQ62sXMDVNAf4?=
 =?us-ascii?Q?7aG8Gc7IlSqSjYtt62hjyfKXRLcecnKoqbF/uXzZAmQRqFldtU65CQLkiATP?=
 =?us-ascii?Q?toJ0G9Pdxigd/IETbSiXLcsh5H6rsFHcqPuJnW+sXSJVDE1UGWpiriYtD9bS?=
 =?us-ascii?Q?S2uYkmDpwuruDACRh6Nw1EHECsa+PHWWEjb9p0NInsEnn/F9UgS0YMe/B2lb?=
 =?us-ascii?Q?tkRb6m9qaH14FeM58aIoA7inOKyKZVAhCTfwJoRSqQnOD/h0vhFDhze3dPQf?=
 =?us-ascii?Q?ijNTPYP0w+xdL4QTMrZIe6I7lIZYyixUeu7bPmf+ZW5X/sfFwYaSYsMO+4e8?=
 =?us-ascii?Q?WOsMKOj3xy09S9zD78qWjlUFH7JX8r8lk28LmQ/zIz2cld/qebdVM4yK0/s4?=
 =?us-ascii?Q?jVBrbInGvQvEDyMPpIscubl+Nl6UHriKDVBoEA6Yej1ULDLMkbE8s4F4xtwc?=
 =?us-ascii?Q?HxddWAiSe8U+JTiccXFcF5bfQs5ztQnXULoCaNwAYTmp8h6quq0t/r/IGQeM?=
 =?us-ascii?Q?lYKDdWTmZx2dMhKyZ0TeOttp5gvZ46bw2lf6fQ+HDznqykV3iXjnLepfvLud?=
 =?us-ascii?Q?2AN8JqT5hpo35YFFDAvdsv5QCibOFTUoS0LrGGstkbjTge/EG6c3mo+3XaS+?=
 =?us-ascii?Q?8LQnbjVOwPrSqkRh45vHhPE39H6bJifwTOKB7xrgxIHJcuVfEtPbqCU7VwRF?=
 =?us-ascii?Q?Hru+t2CKuSk4u8HDvKun0iJxc5XqNf7bIMpUhwY242wRKJq8qZklHm9cYuoy?=
 =?us-ascii?Q?TJ2nHgnBtMC+BPbuME14oqY/cH5YAHalAdzcRGEnBhePGJzks3aWKoxDA3HX?=
 =?us-ascii?Q?nT0lAkqVmrt2/SYXwFcEQpDRNpUjnGNTcj/YKGCQ8gjy3ZlypEjnr/5Dq6rp?=
 =?us-ascii?Q?vMCisxSFRbc8+V/sNQFR7Vxzo093CYCtXhHnvAghnMYl76fG3HybTmjjdARM?=
 =?us-ascii?Q?5alM48dkFr2Oha6gG5Xp9R47aE+3ynii7zIqS07b50rbRSsF1DXyOlppzvMT?=
 =?us-ascii?Q?FrWx52+rTMPgG49zEpxMrE6ojR9b2qo051CksFDconx/nkTVQqV3VdCbxxEg?=
 =?us-ascii?Q?8jo70Z6wsZWGody4FkrG3re26fbzrMJLmLQTwKf0s/+kV0TVEhIQXCITPL3c?=
 =?us-ascii?Q?lSOlG8e1j8p4DydeHQxb/A619oHR3HE1uRJU9pZDlxYzqjaMwsPMVNulpZZb?=
 =?us-ascii?Q?lyLVmJXZHbm9T+zSPYQ/edMwktPwKL4rA9OCYdxJytdBfN6wQ7BGPbI3h9nr?=
 =?us-ascii?Q?fdzGmOuYxKQvy0Lvqf4TNUhWxY01TxcouJvbit3HvRDA61P8wzygjd7zQtnk?=
 =?us-ascii?Q?gVleJDiK51DnQbzYwRm/iCyP3ydZ3CBgxzpxG3ZvtywT4hjGTWRG9e5Wfbr4?=
 =?us-ascii?Q?PtYd43SdIWA1DEjfIpwfW9kRLTKsYESE5FffUKTT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba409c5-1743-4f5f-a831-08da89e31740
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 17:22:46.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYviyGvJcT6txW/iMZ8POjjGPd2HRSFXLCyZHvuy6OgHr814Pah5bpwUQNOw7RsV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3667
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 29, 2022 at 05:14:56PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 29, 2022, at 12:45 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Fri, Aug 26, 2022 at 07:57:04PM +0000, Chuck Lever III wrote:
> >> The connect APIs would be a place to start. In the meantime, though...
> >> 
> >> Two or three years ago I spent some effort to ensure that closing
> >> an RDMA connection leaves a client-side RPC/RDMA transport with no
> >> RDMA resources associated with it. It releases the CQs, QP, and all
> >> the MRs. That makes initial connect and reconnect both behave exactly
> >> the same, and guarantees that a reconnect does not get stuck with
> >> an old CQ that is no longer working or a QP that is in TIMEWAIT.
> >> 
> >> However that does mean that substantial resource allocation is
> >> done on every reconnect.
> > 
> > And if the resource allocations fail then what happens? The storage
> > ULP retries forever and is effectively deadlocked?
> 
> The reconnection attempt fails, and any resources allocated during
> that attempt are released. The ULP waits a bit then tries again
> until it works or is interrupted.
> 
> A deadlock might occur if one of those allocations triggers
> additional reclaim activity.

No, you are deadlocked now.

If a direct reclaim calls back into NFS we are already at the point
where normal allocations fail, and we are accessing the emergency
reserve.

When reclaim does this it marks the entire task with
memalloc_noio_save() which forces GFP_NOIO on every allocation that
task makes, meaning every allocation comes from the emergency reserve
already.

This is why it (barely) works *at all* with RDMA.

If during the writeback the reserve is exhaused and memory allocation
fails, then the IO stack is in trouble - either it fails the writeback
(then what?) or it deadlocks the kernel because it *cannot* make
forward progress without those memory allocations.

The fact we have cases where the storage thread under the
memalloc_noio_save() becomes contingent on the forward progress of
other contexts that don't have memalloc_noio_save() is a fairly
serious problem I can't see a solution to.

Even a simple case like mlx5 may cause the NIC to trigger a host
memory allocation, which is done in another thread and done as a
normal GFP_KERNEL. This memory allocation must progress before a
CQ/QP/MR/etc can be created. So now we are deadlocked again.

Jason
