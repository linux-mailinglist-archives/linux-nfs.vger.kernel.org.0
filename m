Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580EB4854B8
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 15:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbiAEOhK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 09:37:10 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:36289
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240981AbiAEOhI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Jan 2022 09:37:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd9fQYHc+QuvAxW5K4hB76ZNZGOpbxROceXHI41hHNpFJW2hpTgunFleKwjDejHn0aUAsoM9cdYsUiGo0BYRdbv0puzLtu/7Ef9etQdEyidzIbs4ZULnzds+AuDij/IYFddpNIZrzYm9ubwsEz+Xfeosy77hCh8N+EwpFBNmhT0HSCvghPJHA2ucCTjZARkhy1TWhJKc2FxAcUrPbG0hA+SQ2wARmNsPSXLkcioJoKTU1rbmgn362FkwNAt8POqB/Bm+SE3iMOcKcZW/KWe7o/U4TSCM1Z9v4qt+HyJOd0d6zQEzjN/9+mfRZM+wd4ygrPCqhV1bx3GZigNPWzNm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIWmNRZr3y0kM7npY8BKHYHJ2c9kL5cCZL5pgUgqMtQ=;
 b=eGpokinQGGp7HJSzuirsJ84L4HAztYypWktN6MyuST8dUsIB1a5mxSGickgO0qLPnA9PmKPrba8OCdqPJLE4v1poWzdN9PSjpkFtOktUkYLcgE0wZ/TRHd3cb2alxm2aQn0bILvlr3XYT4OTqB0ZczUgqbxxYMbctef9Rbqp0TfEKCvom/0TXrl6eniLaeQWZII4bwh6og3MEbFvoJqpGqrp3x38l4ooeIn+3f10upNGhb07egtD20vyEsgLQqLjBH8Erl3ug9XCROpofcFM/YFTTUcGXJhCslPIF/Bh9+skcJNa4OgZiY28uK8u8FR+Idtakt/Cy3ZHkH6aw3GiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIWmNRZr3y0kM7npY8BKHYHJ2c9kL5cCZL5pgUgqMtQ=;
 b=Lu5YvedipFBkBQHfg8U5zTDry7B+HTFtlk/x/QiJmWUYrw04AORypK5viq6ic/CLTD8aL6TWSQa4vhc1dzmmErK7auF3bwU0Rc3g+uxbv205sMMstD45te+BMrEfOsyDL3dZDIIBu8JD3YuoxxF0IKK8NmXPJBQN6x65zWxQl7IIx/mLGCSnsZQBJkjddB6SAVKq28WqqljwdBNRjc6jLWGnOoTIWKS8eXJzClN5sey/M5g/03RXKyE2j6j1Ti4vmTZ7iF/7V9nyRhDEftkU8NLcM0VsQTL53lRqXe8q6zSaDVttTB3NHxFNQqxuDL62A10vMfEi8QPrlWtuyKIUCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 14:37:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 14:37:06 +0000
Date:   Wed, 5 Jan 2022 10:37:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     trondmy@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] RDMA: null pointer in __ib_umem_release causes kernel
 panic
Message-ID: <20220105143705.GS2328285@nvidia.com>
References: <20220105141841.411197-1-trondmy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105141841.411197-1-trondmy@kernel.org>
X-ClientProxiedBy: CH2PR18CA0058.namprd18.prod.outlook.com
 (2603:10b6:610:55::38) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adeec3b3-addd-4dfe-5d2d-08d9d058d8f4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5110F2D0CF96E28BCF135D41C24B9@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfTUwumaimpzoPdtz/3UwqJ9h36Ag3C0ndCdBIPHIEZs3sTU0EJqLg0Ga6Rgjtq6BhZ5yObTGjdc1UyJ05OrCtAmXua1Brv+qbSapilJGsPvkGraFmFCVHFsGPkgCVTTf/jILnnk8EAjazl2KWJxGKTXpE+giAZ2awdGsNO5KeiUW7BEp0ILzJBx3I3vAjnc7SwDdl9Tss8GUUA8LwWE1ET4jBqzryKqCgYlikdskwydW+IQ0LsFZMIDx/2j/UpUJWjULR8MXZAoyR3uk03x3Zf8cwt73V1L3gocaYQRAYrVatRRecF9hPmlsJ/fUAk/h0KcPc4EBjk8mcZpnhFoW+6H9aS8s05ZT0hF+CREWLdp4P9zyh2Na5iS4w/X7mcKj8iH6W1NVYzECg5ZOHvYRSEwAQLr6DCRwW02pzlJbf3LhdTGNTW+BpSmCQXCmuSYQhjnJ95V/L+gMvDWO3L6EL0/vnzjgw80eQ3pnfh4zoZ+Gov2B0iXUZ5E7i4Yy9GefLxwvZiNlPYl5jGYeMwESbgBNV5eMAX5BPLAMetC+GaiuSS2XXueeMWi7UhCXFA4Yp9xH0OUzFTpdazPEY01N3OOSOOZywzvCpO+EUtHpese1DeNJA3PhVeZtsmBEnMDiyhUDfI9Cy6M6QFCyefHgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(83380400001)(8676002)(5660300002)(4326008)(66556008)(66946007)(66476007)(186003)(6916009)(2616005)(86362001)(36756003)(6512007)(6506007)(1076003)(33656002)(2906002)(26005)(316002)(38100700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yd2uxWD2qvi3jMA0mVlmMT/fOGz2k71dJIn2NaezTuOCfdBsKI9rvRr1OSSa?=
 =?us-ascii?Q?yVgOAMTqZFFO8c+ASMvuNtetOuyEPc2GGzVN3Wm9lIsu1z6GhMjV15nuJKer?=
 =?us-ascii?Q?D6uWYsST9wtMxf/9sTeI7vY8+tdBribDZsAIeF1PebOUZP/b6dEMfWW2mN0G?=
 =?us-ascii?Q?qBit1kmo2G8RJHF7ZHXy5tw2NkVJFdALdWhPOJzAX3jcTQ3qffQMBbrB8GiX?=
 =?us-ascii?Q?BEpnTlUIm6fPDFW+N7jHJdpMRLntuXi7F3rGoF+J+JJzDvW5apgFLdMdxUjp?=
 =?us-ascii?Q?1Er8GvXji2gwSnX6rY7iN34Ps7SH0UpirfjoSgyA9F4BubfbaM6XIB/54qJm?=
 =?us-ascii?Q?RR9N09y1Eo6tYHeSBQwhHcMTcPYmGRnPZoCANLOyqGKZs1wK5BBAz4o9srBl?=
 =?us-ascii?Q?KcKRjZqbhS/A/uhioOUuvJKMDQL5TVy5Rz+GOPFFl+4S27SygA1rW6rwOZV8?=
 =?us-ascii?Q?l3Q52quVrvUwSJKDr6J2UJvup9PZLaTUvPTBSb+JQrPHTznMNmvY23Hvt8ds?=
 =?us-ascii?Q?hSGUO2qy46x1yd2aXW42C3PG4Hp82jIILjOPTtZLOwFnUkWYDgsdkPYL3GkK?=
 =?us-ascii?Q?6njfIrwvb7znCt53rtLCuqsXorAMo8DFJcC9VdL9xiDjM5prEQde3LoEIP5U?=
 =?us-ascii?Q?/fCobL6RNuwiBNt9Tpnf7YKY+776y2FljJ848QbwtJslmwm+CADL1yUaKgSm?=
 =?us-ascii?Q?irWV19A3GRV9t2LpIV9KIC6D4AT/Zq6Re4iyL/DiXz5eMzTcHn8fy4Oo38qB?=
 =?us-ascii?Q?3MG6hHnjAMnJFpM9fw+dzbkzxErv0RYG9g8SHgBjd6gDr1OPLG34NU9zeIRt?=
 =?us-ascii?Q?ZmWpDFGn5UC4oEi20pEnje1Pm2UvXQ8ONhDddHdRfQYpaYm8Fpt7pNIVUrcQ?=
 =?us-ascii?Q?UIMvETTk+ddnIlAwqMvgGRTal0FZm4wMKF0i0ZpESUcbocDII+Gp26bJCKzW?=
 =?us-ascii?Q?739ATm5YmXzISjev1OU+ajo3GSd4p0qOacZBvtR39IF9RNfCWHiG2vZPnCIT?=
 =?us-ascii?Q?sKK+5St+rmJIXaTjTbCWqb3BVdoBcjKG/DJmC252/VYwg0B3an2tAQOnGIrd?=
 =?us-ascii?Q?0HGpwJsbBocbuQetcrs6yG3owd2Ubf4KbRJh7wdo6tdPbj2aePARW9JEWzxe?=
 =?us-ascii?Q?zgUsPzTwxC8LmMGLc7ebOPbz0jMJTfLLJW+ltPo+hj4KHDVrgS29kOh29m+k?=
 =?us-ascii?Q?tWgXVKI+tQvxleUPkULg0rjZhO6pAdDYbEggHOPZBManyeQuGo4xDzeChQ1S?=
 =?us-ascii?Q?j0jJapJNcgArqRNqxK/wdGsG+1syljhlEwZb0PBUpmsO8lPiC+spR3nrKqqM?=
 =?us-ascii?Q?vfC1li8Pm0b3jqkaJCkIqa4mnRlEBHbhwnP6wOKXSRxB9jwMLnOA/GmgrhJE?=
 =?us-ascii?Q?awpveF9sm19POI0F7FsXB4qucAI5FaQ/ef+EGWvTeZIzy3VQoT00zuY6f9/G?=
 =?us-ascii?Q?QjJPXEAQ1zdZseOznqkhRS3ttSJSUetSOH9UzEI0OhvHYj+yawzLYkfNFjNv?=
 =?us-ascii?Q?/gk4HioCT0eJkOJJd/Iz72H8olaKfAia70opRakpYnXlVCAchu4FaVg7yWjo?=
 =?us-ascii?Q?6riRFSvMgQw3yWxop3I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adeec3b3-addd-4dfe-5d2d-08d9d058d8f4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 14:37:06.7103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYzhPtd9pfinxa0DXjpFyixyd14npuB42TPNlDMS2kWWSjVapu26du4WBVtTyxJm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 05, 2022 at 09:18:41AM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> When doing RPC/RDMA, we're seeing a kernel panic when __ib_umem_release()
> iterates over the scatter gather list and hits NULL pages.
> 
> It turns out that commit 79fbd3e1241c ended up changing the iteration
> from being over only the mapped entries to being over the original list
> size.

You mean this?

-       for_each_sg(umem->sg_head.sgl, sg, umem->sg_nents, i)
+       for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i)

I don't see what changed there? The invarient should be that

  umem->sg_nents == sgt->orig_nents

> @@ -55,7 +55,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>  		ib_dma_unmap_sgtable_attrs(dev, &umem->sgt_append.sgt,
>  					   DMA_BIDIRECTIONAL, 0);
>  
> -	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i)
> +	for_each_sgtable_dma_sg(&umem->sgt_append.sgt, sg, i)
>  		unpin_user_page_range_dirty_lock(sg_page(sg),

Calling sg_page() from under a dma_sg iterator is unconditionally
wrong..

More likely your case is something has gone wrong when the sgtable was
created and it has the wrong value in orig_nents..

Jason
