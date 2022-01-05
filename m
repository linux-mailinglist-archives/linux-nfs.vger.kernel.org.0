Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF25485677
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 17:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbiAEQJX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 11:09:23 -0500
Received: from mail-mw2nam08on2064.outbound.protection.outlook.com ([40.107.101.64]:32993
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241832AbiAEQJX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Jan 2022 11:09:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtRPAcqbQ/pE5kDuG/NyWnK9ZfmlxgzxiPmkz16PQ5t2CroQtNwroQOaA/p+gY1rMA56Hnd/mGXt5NB1sdAwYSDJ+P7J2Nt54FTvppsgRuNggZnaq39mX0PeqRZJLuLCF81QG/jdv/ka6+wJl+F6cOS2WDZBKZuv9HZ9NgxgF7mHEgy2kpnlnsKQ80EFJPOemIQjOIX6sGo0mggrGhrwxDT/g50HXd9YcoOOfNfNb2wxhD6t2WthBeNuXWxtTCjCNz2TUlicfgFolTzkT6D4Vr+35RYz3/GyCJwdeGv99J3nP/t4knbhMoQV5Ioclg+1I2wXEzizkaCqdr6elItjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3fcbi236YMLJj7IUcQ9q1Uyq/YUI/4iwmXcKjb8aoo=;
 b=HrLyE5vz9pvMpoh9BYnOCCy241j3h4YJppHDPjFp6mbqHLhz7oNd/UBM9rdcW7Kq5DCfq7XRbx/umbbxLV6m4WgYy4q+pcY7cK0Bo+Qm6CWZbG44BYjpaqGoWE05dv2+1oHVu5j3v4/0NRUqEEit8yVWYA8g3xM2jW0Sj47mxSrISoNhOeg53bqK9SVSl1/SgHslKWPl26+6Bi6b9wUIuFEvd8CZt2WIT/jZEbyP9drgM1BqFBhDKr6IKZbmCZQ88ZoT7ueCZmboZN7EKwfiZXrfrrEGbq1Bvyk7qthRm2H0KXuTyBe/oL3keF4FnczAFVrfZMVSiIY2Ww5S8MsDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3fcbi236YMLJj7IUcQ9q1Uyq/YUI/4iwmXcKjb8aoo=;
 b=hrC5IwLnn95GUiMQ0EHnS7gEz/oxzCxI9YCLiLZ7nKea0brqFvIA6ZP0fDKW67zojRz9vEGyqSFYXgv5/kLhNXykdbpTT4NG6Ab/uR8rCfEwk9r48nSAGjhvBMZoxRG2EdIaAxk/VNfBHt2m5Hus8HSh/KN0K0V9ZTdIvlCA7Lr48lQy8lH0PvjbkmH1AWtpsQ0jg/q4DqsOSk26aWazoiP0VcL2fS6fhqRx6bgrHcyCKnSWXYf6XxXBqnJuh5ePfLmVvfG+99el6NXAmKwo0hQ/AjCBShYYYAgUOxPOK7G8cVwo1ttIJqfBUfbuhPPyJri/4V6vNAZnyWDtuhzNbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 16:09:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 16:09:19 +0000
Date:   Wed, 5 Jan 2022 12:09:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: null pointer in __ib_umem_release causes kernel
 panic
Message-ID: <20220105160916.GT2328285@nvidia.com>
References: <20220105141841.411197-1-trondmy@kernel.org>
 <20220105143705.GS2328285@nvidia.com>
 <3b74b8f4481ec27debad500e53facc56f9b388cd.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b74b8f4481ec27debad500e53facc56f9b388cd.camel@hammerspace.com>
X-ClientProxiedBy: BYAPR11CA0083.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76dea75d-100c-4a1d-6636-08d9d065ba7d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128F4AACC37F1206E9A459AC24B9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRX/BUUPu3Y3oi5nivnPY3I/M8WLT0NP4+6cyIgnEdWey5q22uHYW/syMnYj8E07JXO+6Zo+yW7nujO0d1a2xtJk5PysweosdNVk9Pax//kz3ZIJhwRbBKlwxfzOov5xWHQPbTInSDfkDZvXkjhvlRCQo2dz7aqAIvoUg7S4TOMOckioJZOvFOJuD9/QTaRFLHXdQmfV1K34z9xiWxUS8iO5jdboCnIVjO2ylTql6FB6/WlM+q/oiUms338fWQ9RWuMpb5TsGVzNuy/aKfoBj2hqj1AK5m5Lh7lDJJLXWQBPeFrR8x/UXib0kj8rw7vb7tYe/2Xe691xZ0NP4qaFFZ3f0sMPvfsx9WUacPyleXWRnWx/ay226lN12XpMWzkn1DhFltGhsLZ9F+3/wUDjmrA3isbL7SgjX38FBz/cILb4okhWstL0tYaZi4dGxBI5ILoGHRx4kjpjwpzbNmNuKWv+sEz7vXUMd19cg90fRQvnUjMH/uDit+u67N/t98vVZeCjeOJDLN+FFOwzgfmcYJjCVSyAjI78w1V2W/D5pC04kgP5aDIG6qj+hXsiCgiFFnfh0NjZYqtYj0ArkqRMPnzJlQMfRt5SX0oinSMw+RwRla/r5qKhBMjQePhxFqFKBAL6/z/SCZRv9xvyH7A0ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(508600001)(2906002)(6916009)(8676002)(6666004)(83380400001)(1076003)(66946007)(2616005)(8936002)(316002)(38100700002)(6512007)(6506007)(4326008)(66556008)(186003)(54906003)(33656002)(5660300002)(6486002)(66476007)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?endTblJRTnlWeFpjVGkyZEpOa29Pc1Y2dStjUXQwUUhvZlVMK2RsS0lJaVMv?=
 =?utf-8?B?elVzSXZyS01ERmxaNHM0YmM0NXdKRkExa3phMmpvRWNiajBLY0FpYnlyVmFJ?=
 =?utf-8?B?ZXNhNUxYdEJwbWtibE9vK2FOSjlMbFBoRDZSTExUeWtSNE85SEdiR1VDWjJR?=
 =?utf-8?B?eWpWSjE4V0pYUGVWamE5Q3dlczhNNjdJU09nSzBSc3dGaTRrWkNMc3R0RkZS?=
 =?utf-8?B?UzU4TDkxbUVaeG1sSzFDekovcmkzamtBWG50ejF6Qmw5N0R3cXVQS3NXVzVN?=
 =?utf-8?B?UTB4ZFFHRWZQdUpxdE5ERDI0NDNCQkJhSkNIOCsxanFGT1I0ZVR3QWoxY1Rl?=
 =?utf-8?B?L0d0b0d1Zm56NnpoZEJPdW9DdHpsYmNXa3lBcUM1OEkwbHpNeFlhOTJGN05M?=
 =?utf-8?B?WUEwNjNFQldnT1FTOVMxaWMwUjlmdVp6R0FqcFBPdGM1UUdNMENxL2R2bEty?=
 =?utf-8?B?cDRLVVM5R2xQZEFJdWs2Y3FsY3l5YWJhU2w0K201ZHVvcWhzdUt0cGdBTndq?=
 =?utf-8?B?SHJZdURhK3FsNEw3amdGRXVNUU84dWpqVDFNT050bEVPZTlJL3pZTktjb1R5?=
 =?utf-8?B?bW1NZ3FHVkpTSHQ3NHBHTWgzK1dTeXFmaFE5eWxrcUJ2Y3JYUjVvaldRdFZZ?=
 =?utf-8?B?SXlDMU5rcTVQeEFYWjk5UVdmQnhvWVpWbUJqMktxcGlqNkNRMnlFZGNKZkFT?=
 =?utf-8?B?WHMxeUdvRktwbDdldEhrRmdqdzFPMElQdFRqR21YZEllL3orVU5QWVBBTTZn?=
 =?utf-8?B?RGg2dEVoUGRZS3ZHakxxOGl4MnlCbVpERjVERFo1cVRXOUNLM0s0WW1wa0pO?=
 =?utf-8?B?bUs3WjMwK1RudEZwMnN0VGRUR0JUcXd0dzRDU0VweUhYWDI2blJTUEtsdktO?=
 =?utf-8?B?b1BSNDZPMFpiaU9DeWx1MmdqZ0V1c1d4ZUV3eHA1MThBRDh3ZytwbU1MQkVV?=
 =?utf-8?B?bFZKSHQ4Q00yczF1VDFCQTh5ZkZUK25SZXNwaUJnNGFORTBXbTluNEJqZ0FB?=
 =?utf-8?B?MGpLanVueEpDcllIWlVZdW1FNjhidVFXQ3JmcXFTQ2hMOUxSVXc1VlIvWVdm?=
 =?utf-8?B?bUtiVnBucUtNaDFjR1VwSVdqY0RwcGl5RDBveVl6UXNsMTlnd0VhUys5M1Mw?=
 =?utf-8?B?bEd6QXZUdWFFcjFKZUQvRmNDc3lEWWpEdmF3Y3NtU3ExVU1RNlZzSVJBRkMx?=
 =?utf-8?B?S25reEwrT0U0MHNVUy9TV0ZSd1kvNitlMUFURWVmM1JCYURqbzUvQkZxbG00?=
 =?utf-8?B?TjZyd2RLQXZ0eEZDZC9sZlREbFA5dXJOSk52WENSWjJOWkJlanNZdlFSTGh6?=
 =?utf-8?B?ZXpIQmp6cGdtK0p3QmVSaCtxbXd0ZmF1T3FXOHpTU2loUTFBL2NUWkFlUFdZ?=
 =?utf-8?B?UkdSbzZJVzNSajN5WUpJQ3lnWWFFV3pSMUx2WmViSHArRDdSaUZYem9vRHBU?=
 =?utf-8?B?MDBZVk5PdFdiNjgxOUxzT0lUZlRiQnRJdGdhdlRzZ0M1SkJSSENaU0ZGSE8r?=
 =?utf-8?B?RXRZcXk4aHhwV25QMEV5ajhPb3dheU8vM2dkSDdOSXJ5OEkzdlNYMjhaQ01X?=
 =?utf-8?B?UkpNaWpka3ptenBtNWVpSkp2LzBkWUVYYkl0eHlyVTcwMzVBQk5nZUZxK1hi?=
 =?utf-8?B?V3dlTTJFT1U2MUQxbm5yZEswREVCd0JkRkorZTFyeXcwOS9pU2s4T2VmMTBN?=
 =?utf-8?B?UWVRQjQ1eS9yeFM4SVR6RFJZSHlFVzFOdFM3WElaaUpBTnFtd05lTW5vbFAz?=
 =?utf-8?B?c0ZHR3UyOEx4VXJNbmJwWlBSc3d1TmZGTkcxVGJSa2FXRnhKT0haNTlkd2lZ?=
 =?utf-8?B?VktDWUlRWGdUMkhHNmlUNjZpQ1ZWR203NlZOTllGTGprN0drL3NqRkd3WTQ1?=
 =?utf-8?B?UHoyRW1tWmcxMGRLZlQxaWRqMGp5b0tTZlZOdXJYY3NKL2I4cHhJY2lwK0c3?=
 =?utf-8?B?cFoxUEV3YWlyWG82ZnlCN0hjQUUybUhSTEMwODFIT1JNOVUyWGxiT3Q2eDJt?=
 =?utf-8?B?RVlXWmg2NTF6dVFPUzIxNlZwc04rZE9aSWdITjU0eVNHcnhyQ1lWWmo1NVY3?=
 =?utf-8?B?ZExQNngvR3I2Z2ZZYUtscHVGaEdMb2kvSG5MNkRKaTVyTDhUZ2c3dDZXYkUw?=
 =?utf-8?Q?qCOM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dea75d-100c-4a1d-6636-08d9d065ba7d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 16:09:19.0408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXQ+yXieCCHkBD6MES15hLgZWIRkMievUWIPHFlggF7dHs9P+rCBj/y3ATsiOuJu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 05, 2022 at 03:02:34PM +0000, Trond Myklebust wrote:
> On Wed, 2022-01-05 at 10:37 -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 05, 2022 at 09:18:41AM -0500, trondmy@kernel.org wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > When doing RPC/RDMA, we're seeing a kernel panic when
> > > __ib_umem_release()
> > > iterates over the scatter gather list and hits NULL pages.
> > > 
> > > It turns out that commit 79fbd3e1241c ended up changing the
> > > iteration
> > > from being over only the mapped entries to being over the original
> > > list
> > > size.
> > 
> > You mean this?
> > 
> > -       for_each_sg(umem->sg_head.sgl, sg, umem->sg_nents, i)
> > +       for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i)
> > 
> > I don't see what changed there? The invarient should be that
> > 
> >   umem->sg_nents == sgt->orig_nents
> > 
> > > @@ -55,7 +55,7 @@ static void __ib_umem_release(struct ib_device
> > > *dev, struct ib_umem *umem, int d
> > >                 ib_dma_unmap_sgtable_attrs(dev, &umem-
> > > >sgt_append.sgt,
> > >                                            DMA_BIDIRECTIONAL, 0);
> > >  
> > > -       for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i)
> > > +       for_each_sgtable_dma_sg(&umem->sgt_append.sgt, sg, i)
> > >                 unpin_user_page_range_dirty_lock(sg_page(sg),
> > 
> > Calling sg_page() from under a dma_sg iterator is unconditionally
> > wrong..
> > 
> > More likely your case is something has gone wrong when the sgtable
> > was
> > created and it has the wrong value in orig_nents..
> 
> Can you define "wrong value" in this case? Chuck's RPC/RDMA code
> appears to call ib_alloc_mr() with an 'expected maximum number of
> entries' (depth) in net/sunrpc/xprtrdma/frwr_ops.c:frwr_mr_init().
> 
> It then fills that table with a set of n <= depth pages in
> net/sunrpc/xprtrdma/frwr_ops.c:frwr_map() and calls ib_dma_map_sg() to
> map them, and then adjusts the sgtable with a call to ib_map_mr_sg().

I'm confused, RPC/RDMA should never touch a umem at all.

Is this really the other bug where user and kernel MR are getting
confused?

Jason
