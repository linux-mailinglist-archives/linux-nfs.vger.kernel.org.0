Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4C59D3FD
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Aug 2022 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbiHWIQl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Aug 2022 04:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbiHWIOJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Aug 2022 04:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D2AE27;
        Tue, 23 Aug 2022 01:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 289656123D;
        Tue, 23 Aug 2022 08:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDB7C433D7;
        Tue, 23 Aug 2022 08:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661242175;
        bh=UlRRdgcm4BgCazHwvO3AAA7RV8/Vm4nE+hFYjMWe0k0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVEXfy/FdUDWU5wWnXAKBwtE04ZW8Nn1lqIDr7vVLtNWONCwfGPmZi6JvyH6mx47G
         g4zi2N5MOxisT2CeoFnexNHDqg/44FjlbK8lA348vjtWQhtCSMpMV7kvtFH7+Bsllh
         ytY9WtJdoG0fmrlmLS4s26Ahecnvx/xjva+nfsvbAloBryVclmg0tCTWtj1QsRAY+h
         z5VsWIU6rkWGjx5NRiUr++z2+SS2T79fLUX2N2lUFCfB6KdqcT+9S1qs2/rxBKaXaV
         b5CXdl3Acpny9n2c8jt8uc7Iwpc+3TazAA1DpoG0V+9C4mb8DPA66JezN0gfnuvP0q
         Jl9QyrAvbAhaA==
Date:   Tue, 23 Aug 2022 11:09:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Message-ID: <YwSLOxyEtV4l2Frc@unreal>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 22, 2022 at 11:30:20AM -0400, Chuck Lever wrote:
> While setting up a new lab, I accidentally misconfigured the
> Ethernet port for a system that tried an NFS mount using RoCE.
> This made the NFS server unreachable. The following WARNING
> popped on the NFS client while waiting for the mount attempt to
> time out:
> 
> Aug 20 17:12:05 bazille kernel: workqueue: WQ_MEM_RECLAIM xprtiod:xprt_rdma_connect_worker [rpcrdma] is flushing !WQ_MEM_RECLAI>
> Aug 20 17:12:05 bazille kernel: WARNING: CPU: 0 PID: 100 at kernel/workqueue.c:2628 check_flush_dependency+0xbf/0xca
> Aug 20 17:12:05 bazille kernel: Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs 8021q garp stp mrp llc rfkill rpcrdma>
> Aug 20 17:12:05 bazille kernel: CPU: 0 PID: 100 Comm: kworker/u8:8 Not tainted 6.0.0-rc1-00002-g6229f8c054e5 #13
> Aug 20 17:12:05 bazille kernel: Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b 06/12/2017
> Aug 20 17:12:05 bazille kernel: Workqueue: xprtiod xprt_rdma_connect_worker [rpcrdma]
> Aug 20 17:12:05 bazille kernel: RIP: 0010:check_flush_dependency+0xbf/0xca
> Aug 20 17:12:05 bazille kernel: Code: 75 2a 48 8b 55 18 48 8d 8b b0 00 00 00 4d 89 e0 48 81 c6 b0 00 00 00 48 c7 c7 65 33 2e be>
> Aug 20 17:12:05 bazille kernel: RSP: 0018:ffffb562806cfcf8 EFLAGS: 00010092
> Aug 20 17:12:05 bazille kernel: RAX: 0000000000000082 RBX: ffff97894f8c3c00 RCX: 0000000000000027
> Aug 20 17:12:05 bazille kernel: RDX: 0000000000000002 RSI: ffffffffbe3447d1 RDI: 00000000ffffffff
> Aug 20 17:12:05 bazille kernel: RBP: ffff978941315840 R08: 0000000000000000 R09: 0000000000000000
> Aug 20 17:12:05 bazille kernel: R10: 00000000000008b0 R11: 0000000000000001 R12: ffffffffc0ce3731
> Aug 20 17:12:05 bazille kernel: R13: ffff978950c00500 R14: ffff97894341f0c0 R15: ffff978951112eb0
> Aug 20 17:12:05 bazille kernel: FS:  0000000000000000(0000) GS:ffff97987fc00000(0000) knlGS:0000000000000000
> Aug 20 17:12:05 bazille kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Aug 20 17:12:05 bazille kernel: CR2: 00007f807535eae8 CR3: 000000010b8e4002 CR4: 00000000003706f0
> Aug 20 17:12:05 bazille kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Aug 20 17:12:05 bazille kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Aug 20 17:12:05 bazille kernel: Call Trace:
> Aug 20 17:12:05 bazille kernel:  <TASK>
> Aug 20 17:12:05 bazille kernel:  __flush_work.isra.0+0xaf/0x188
> Aug 20 17:12:05 bazille kernel:  ? _raw_spin_lock_irqsave+0x2c/0x37
> Aug 20 17:12:05 bazille kernel:  ? lock_timer_base+0x38/0x5f
> Aug 20 17:12:05 bazille kernel:  __cancel_work_timer+0xea/0x13d
> Aug 20 17:12:05 bazille kernel:  ? preempt_latency_start+0x2b/0x46
> Aug 20 17:12:05 bazille kernel:  rdma_addr_cancel+0x70/0x81 [ib_core]
> Aug 20 17:12:05 bazille kernel:  _destroy_id+0x1a/0x246 [rdma_cm]
> Aug 20 17:12:05 bazille kernel:  rpcrdma_xprt_connect+0x115/0x5ae [rpcrdma]
> Aug 20 17:12:05 bazille kernel:  ? _raw_spin_unlock+0x14/0x29
> Aug 20 17:12:05 bazille kernel:  ? raw_spin_rq_unlock_irq+0x5/0x10
> Aug 20 17:12:05 bazille kernel:  ? finish_task_switch.isra.0+0x171/0x249
> Aug 20 17:12:05 bazille kernel:  xprt_rdma_connect_worker+0x3b/0xc7 [rpcrdma]
> Aug 20 17:12:05 bazille kernel:  process_one_work+0x1d8/0x2d4
> Aug 20 17:12:05 bazille kernel:  worker_thread+0x18b/0x24f
> Aug 20 17:12:05 bazille kernel:  ? rescuer_thread+0x280/0x280
> Aug 20 17:12:05 bazille kernel:  kthread+0xf4/0xfc
> Aug 20 17:12:05 bazille kernel:  ? kthread_complete_and_exit+0x1b/0x1b
> Aug 20 17:12:05 bazille kernel:  ret_from_fork+0x22/0x30
> Aug 20 17:12:05 bazille kernel:  </TASK>
> 
> The xprtiod work queue is WQ_MEM_RECLAIM, so any work queue that
> one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
> prevent a priority inversion.

But why do you have WQ_MEM_RECLAIM in xprtiod?

  1270         wq = alloc_workqueue("xprtiod", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);

IMHO, It will be nicer if we remove WQ_MEM_RECLAIM instead of adding it.

Thanks

> 
> Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/infiniband/core/addr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index f253295795f0..5c36d01ebf0b 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -872,7 +872,7 @@ static struct notifier_block nb = {
>  
>  int addr_init(void)
>  {
> -	addr_wq = alloc_ordered_workqueue("ib_addr", 0);
> +	addr_wq = alloc_ordered_workqueue("ib_addr", WQ_MEM_RECLAIM);
>  	if (!addr_wq)
>  		return -ENOMEM;
>  
> 
> 
