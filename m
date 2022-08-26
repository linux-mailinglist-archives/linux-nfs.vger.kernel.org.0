Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7126F5A2889
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiHZN3P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiHZN3O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 09:29:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F1BD99CC;
        Fri, 26 Aug 2022 06:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq1QtaGHoThq9QIqaHDsw7xDVJKFu/OpDI+XAyBrZhv5+NQ1cdWpzaHm41LA+8Tp3Lqs5McrAKpG61uQRicWyw62SRX9Rxf+39L6vfDAvQNMP4FIFTmOcJ1SMscKxoglIEKcslx57ISgdJBCLUkREd+QTIX+N7GEvqQHHayBvCgWoANLXzx1zpPqkl7tS7tdAfMpu2l5vSYvEyadbq4I4mu0nul+SEAMgT5l1yuUCUHwjtt5C0Qzlx+L2g1hRI22rliYZkv5K/gTXLwYdgtX0MdkJlcSdvH/inYasBOOL5BShzrlm3GQTLBKfWrVPNpdxw+XbfZBSRZU2WaHrdHfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoNglzJ/lXMu/WqP+9G+LEm67LLzYTqD+A07LLAgTGw=;
 b=IPsdoWo1V6GYTy5MS9u4wRIDurGNh3Lo+Y5uOYkofhi+9IPux1HZLV/NNGg+JgqCInikrjKpQxrnecaAgOzD48pCI+rErwxZDcuMoH2V2Td8yZ21j3Fivm+hIA04ZROFt8tjktDmF5sodJA6UQCFL2dmGiPCmlU7t+6tmmAopXxDcg4BOboZy3dVOCo3fKSLLBsHGHEffVd9ookBZfa3/TMhPuQr9PXv7dpnDppmBeFWVYBW3uO0l1c27ZfAHQ7hnuM39Zf3aUnAcVN88+SjNT6O8H5YgriewStw2EN0gdIFwJWQXfRv/Tt8qqtuHEBzLm9hydBT16WdMucOrx97qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoNglzJ/lXMu/WqP+9G+LEm67LLzYTqD+A07LLAgTGw=;
 b=EbSpe85s7vl1Odu8aTRdtGVqCb8kv0YYkeu+b+HqnGAnQL9jeovYF5vkCymmdEqYBf09Tp4QAmi33hwQcvLo3EVK9MPQ8gDc3qlIa7eCouBIe3R1onUmDqteryUlS8bcUUompbi+9/ir0pxZgZM14HNfeJU712jCsFBTjFInAEHzpTMsnVWQfSfNho+u2gnoLd20RUmPvBiAK2mYqkcnVvOlPGj18Sl91ufOJW4WDe/1iQwQz7thBFFviXx2oW8HodNuE3W9y0/NXi2/2hN8WhMMM8epvmaIFGO6menI4KXMh6MB1V/+c0Z/NFEe6KLFY8V3tBgnbnC0RF10wMKi4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Fri, 26 Aug
 2022 13:29:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 13:29:11 +0000
Date:   Fri, 26 Aug 2022 10:29:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Message-ID: <YwjKpoVbd1WygWwF@nvidia.com>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
 <YwSLOxyEtV4l2Frc@unreal>
 <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
 <YwXtePKW+sn/89M6@unreal>
 <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
X-ClientProxiedBy: MN2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c05111a1-e9fe-4b69-a898-08da8766f610
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMgjj0RYsCJvqB8nT6nR0WdmIn9aA+lSM00YYGd+dZt7lt2ke+aGc0bY6imfSIyIEVe9ybdslB1YStDqn6sX4lbhiaHntvzxAtXyyZ4oU8E/d7QLu4xB8jDhtVoKYvDVpTgyomd8GpLXCGdDxNwvC4zC5yF7cMX8v5vsE14/W/AXBQYkSWLmh5VUQP7R9PcWqZXP5IIWbC8bDLc/20qrzilep88EHi9G+mqLUZDcb3VHQ/oeakn75Q2OtB4suE1+EbjZxCRPzCl78lExTSW28YgDis/E/rW8SFg7zE5QnLlg+2aft2CKeKqf676OgXF7hDclU4p8RkWzdpW+aZ4VUK33XNpTk94vhcMdLcCKjY7PiicmQKh8rgWesSK9GFXNhOK+dtey8iBbxl7Q+ihHU23eEC8jvXBNj2VH2KhlT8s/LYR8KGTs++JpzCbT22GVr1DSriTO1e5WkiJMDHdlD+DqS5W9x4dpz+9X5ovM0F15nRAD0cx7Izr6rXVNWL7PEEGL0ce2UiX40ZazhYaDYMLUSYV3q2Za4KM+VP9iL/glUrQT0/drx+LFlmJeoipxYefbvyhI6q9m+aD6ikEFp3YZwtKoJ5NWrzCk0M6Ee5L6BwWX1B5mZOoWQjtouzm+7sQ6NUZ9unhqIVr43abtNmecoR9oEWDK1X3L6LmJp22UkcYKcl5MEJJ0ko9LgW4ZjXquh50Rb9FDT9KUHylCew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(4326008)(5660300002)(8676002)(66946007)(316002)(66556008)(66476007)(54906003)(6916009)(8936002)(38100700002)(478600001)(86362001)(2906002)(36756003)(6506007)(53546011)(6486002)(2616005)(186003)(26005)(6512007)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HOG6Bwsaq8WJ3kiqhd3nLo2P4WXbIZwS8Du2ghwdpQfNIuwVzHKIB1GxZ94T?=
 =?us-ascii?Q?5C73dFp0uFb5/FJPCFspjYA0T3KODvdAUyHghW8w+cR9evkYIJqI3R8bZAte?=
 =?us-ascii?Q?S3/m4ZWL/vbCwYhZ8ogHs/yCjZ4mRkYsBj+F0RIN0fcoG6p8lJrm/g54rCCj?=
 =?us-ascii?Q?Q1KIDgG8VvT/HSR0zqoFnwagA1JIByOUvFT+SN9u23OjRH89U4HVRX8dwxGc?=
 =?us-ascii?Q?Bn1OUCX4uBT8fRPuUqs0evub1AEHiS0ZjHlEeQVdrc9/ADQG2DNSPvXVAeuh?=
 =?us-ascii?Q?D+0avQAHTHQJVB7sRJQsOSnKWNMKAJAxQwhVvV5jtuNWMWP1UAQI2dKS+GSo?=
 =?us-ascii?Q?7DwYf1799b/GshAxPQg94nsMD1k8jgXrjMZFQLFc1gKF4Mhx+1nePhTve4A8?=
 =?us-ascii?Q?iHLvJ4ZAn1RkWLOVCFUjuknqDEk4WYwk6PO8aoFGu4H6zJX7Baz+tUspyrYh?=
 =?us-ascii?Q?dRTvU5Lah9uPdRIN9Om97E86ujyzclqydqP1KwkLAMRW57BLIHBwIMArVljY?=
 =?us-ascii?Q?EYYoEfv/DLPrOMzsVuSq8uRlUajOdQ+UHAO59md6Z5848jT8JaAnAEI9aPFC?=
 =?us-ascii?Q?aedHNq042NOemD4gZuQ800uw5WI+KqL0K83FzzKZRK4pYGAbmpOhQqYTkLw3?=
 =?us-ascii?Q?+BYmc9GE90j932crKsiEPUPnuE7levwEeQ+nH3u1Ugb3QZxG335WvbTIFvAq?=
 =?us-ascii?Q?csGU954qVJyl/bIAJmQ3tk/n8bAABPa72B8WVPHhpGaUgaS6x8ZXVUuBKvzM?=
 =?us-ascii?Q?har4Md683dYkrKO92KcN4OJ2TsagLlBxOUyL6huGaoEmrwgzHncV5PXSXeB3?=
 =?us-ascii?Q?FyvM+B6Cxj49wn3hwhZMU1Qxi1+TELzc2IE05qknj90xlXjKzLs9sXxrX5Rq?=
 =?us-ascii?Q?UBL7xNal7N1sORSFI3YnR4TGqg9Rz6d3vtG0FcLheA3c8D7d2aFpQKwTJlg0?=
 =?us-ascii?Q?QUHnpgAn1QKM9O4eorv7m/y10yZw7TL+Q+mTNq78hDoSaornaAkxC/2NvviF?=
 =?us-ascii?Q?1/0x3FgzkkZpQ0jgAkY5cqLQLkkq8e9qli4dcYl/gPI/4VmNK//SvX1PMf/P?=
 =?us-ascii?Q?97qrQwKeB8HSJj/laKbvIJG0NLsjISFb4YGn7bgz3qc+8/DU5lW6Pn9FX5wZ?=
 =?us-ascii?Q?9c4CSnQZ/DAD1M62+RlNzz/KBgUNz8Azqt5YH0L6skHGjkWe0UTZ9n2dcd+/?=
 =?us-ascii?Q?nsLHK3hEQzQ3PsjWQyFOIQy8vADhf3SQojz/95I6S5Di1B16GaWQ5OI2YBrn?=
 =?us-ascii?Q?aLHKHXhv9Sa9iD1lNjNkrQubRwbqBia9BRWQRyJZ6Yp64A3jl4+lG+ofpkuV?=
 =?us-ascii?Q?f1F6aCfPfksT2JF/NC2hk3ZUVGxAJrlvKu2EpBEqR2k3lNAncDi7s1z7EFwU?=
 =?us-ascii?Q?Zkn15FacmkPmLMOuU2nyLlYT2Qm97Q/g9PvP3D0G1fVw1ySZ0G8IPFdt/aQc?=
 =?us-ascii?Q?LV5Ogoxqo5jEpIw+hGpiGsTPDcl5zni4JzF9NSskC4A3EJK4z7QhDZ0Nib6a?=
 =?us-ascii?Q?WNmzBGK+4GyjkxP/THTAojoMAlYLujIGwD0QA3x6a9xBeIAcysbR50D2XTyI?=
 =?us-ascii?Q?fQ7vGaJ78IQBL/Yk00OV1sKEBto0/TzgL/4B3oGh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05111a1-e9fe-4b69-a898-08da8766f610
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 13:29:11.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqgIgo/1LJDXZqUEi9XqnTFFTJBi060AeyYr1dZK06AuWULDPIlWX4RgMRDpgT2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 24, 2022 at 02:09:52PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 24, 2022, at 5:20 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Tue, Aug 23, 2022 at 01:58:44PM +0000, Chuck Lever III wrote:
> >> 
> >> 
> >>> On Aug 23, 2022, at 4:09 AM, Leon Romanovsky <leon@kernel.org> wrote:
> >>> 
> >>> On Mon, Aug 22, 2022 at 11:30:20AM -0400, Chuck Lever wrote:
> > 
> > <...>
> > 
> >>>> The xprtiod work queue is WQ_MEM_RECLAIM, so any work queue that
> >>>> one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
> >>>> prevent a priority inversion.
> >>> 
> >>> But why do you have WQ_MEM_RECLAIM in xprtiod?
> >> 
> >> Because RPC is under a filesystem (NFS). Therefore it has to handle
> >> writeback demanded by direct reclaim. All of the storage ULPs have
> >> this constraint, in fact.
> > 
> > I don't know, this ib_addr workqueue is used when connection is created.
> 
> Reconnection is exactly when we need to ensure that creating
> a new connection won't trigger more memory allocation, because
> that will immediately deadlock.
> 
> Again, all network storage ULPs have this constraint.

IMHO this whole concept is broken.

The RDMA stack does not operate globally under RECLAIM, nor should it.

If you attempt to do a reconnection/etc from within a RECLAIM context
it will deadlock on one of the many allocations that are made to
support opening the connection.

The general idea of reclaim is that the entire task context working
under the reclaim is marked with an override of the gfp flags to make
all allocations under that call chain reclaim safe.

But rdmacm does allocations outside this, eg in the WQs processing the
CM packets. So this doesn't work and we will deadlock.

Fixing it is a big deal and needs more that poking WQ_MEM_RECLAIM here
and there..

For instance, this patch is just incorrect, you can't use
WQ_MEM_RECLAIM on a WQ that is doing allocations and expect anything
useful to happen:

addr_resolve()
 addr_resolve_neigh()
  fetch_ha()
   ib_nl_fetch_ha()
     ib_nl_ip_send_msg()
       	skb = nlmsg_new(len, GFP_KERNEL);

So regardless of the MEM_RECLAIM the *actual work* being canceled can
be stuck on an non-reclaim-safe allocation.

Jason
