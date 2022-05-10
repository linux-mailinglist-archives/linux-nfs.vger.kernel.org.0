Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3C55214C2
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiEJMGd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 08:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiEJMGO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 08:06:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B063A71A
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 05:02:16 -0700 (PDT)
Date:   Tue, 10 May 2022 14:02:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652184135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hlu/ZMUz4PvVFSyvyBdFTyo4a0HWjABxOl9e1UfcfUQ=;
        b=Lw/q8QLeGz72ZZaYMWUuS3ZX+8Z2Esd2s4HGh4xHCbYRolvmLbmtzw72C0cHj78PDjphfv
        7CXr/BCWnjgDATRJmFoqkmoDMA0IY0Qeve0b61CYCmF92g+l+r3ZxaPaNzNZUcaZdDKp+7
        kxVVh8YRxRrC3DUYUCnqwE7fGq9LtFgkThNqPZueAikHSnGjYTD/siPG/cg8FabdGXsmMd
        YTSVax+FfSXNBjaVY1v8gegHJM51ZcDqGGcQQW5MBlfB76GHJGJAcGQkPhUkC6Q95q+/aF
        X+u8rgIUq8xk468XStGXtsblu+5fRMV40fAeqJ4yOEl5ZXRC3ikdQaO/L7BWoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652184135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hlu/ZMUz4PvVFSyvyBdFTyo4a0HWjABxOl9e1UfcfUQ=;
        b=8qncRzGh8W8pmq1QliJ1hTKiGkICmpnwkjtDxzkpixVxJToiCUC0B7UEOTMnfYGFa2WuEd
        q5hqOI3qiKb0OUCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Message-ID: <YnpURpp14qNi7TnI@linutronix.de>
References: <YnK2ujabd2+oCrT/@linutronix.de>
 <11F8D1AE-EB3D-48F0-A586-563165640AB8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11F8D1AE-EB3D-48F0-A586-563165640AB8@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2022-05-09 16:56:47 [+0000], Chuck Lever III wrote:
> Hi Sebastian-
Hi Chuck,

> > On May 4, 2022, at 1:24 PM, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > svc_xprt_enqueue() disables preemption via get_cpu() and then asks for a
> > pool of a specific CPU (current) via svc_pool_for_cpu().
> > With disabled preemption it acquires svc_pool::sp_lock, a spinlock_t,
> > which is a sleeping lock on PREEMPT_RT and can't be acquired with
> > disabled preemption.
> 
> I found this paragraph a little unclear. If you repost, I'd suggest:
> 
>     svc_xprt_enqueue() disables preemption via get_cpu() and then asks
>     for a pool of a specific CPU (current) via svc_pool_for_cpu().
>     While preemption is disabled, svc_xprt_enqueue() acquires
>     svc_pool::sp_lock with bottom-halfs disabled, which can sleep on
>     PREEMPT_RT.

Sure.

> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 5b59e2103526e..79965deec5b12 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -461,8 +460,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
> > 	if (test_and_set_bit(XPT_BUSY, &xprt->xpt_flags))
> > 		return;
> > 
> > -	cpu = get_cpu();
> > -	pool = svc_pool_for_cpu(xprt->xpt_server, cpu);
> > +	pool = svc_pool_for_cpu(xprt->xpt_server, raw_smp_processor_id());
> 
> The pre-2014 code here was this:
> 
> 	cpu = get_cpu();
> 	pool = svc_pool_for_cpu(xprt->xpt_server, cpu);
> 	put_cpu();
> 
> Your explanation covers the rationale for leaving pre-emption
> enabled in the body of svc_xprt_enqueue(), but it's not clear
> to me that rationale also applies to svc_pool_for_cpu().

I don't see why svc_pool_for_cpu() should be protected by disabling
preemption. It returns a "struct svc_pool" depending on the CPU number.
In the SVC_POOL_PERNODE case it will return the same pointer/ struct for
two different CPUs which belong to the same node.

> Protecting the svc_pool data structures with RCU might be
> better, but would amount to a more extensive change. To address
> the pre-emption issue quickly, you could simply revert this
> call site back to its pre-2014 form and postpone deeper changes.

You mean before commit
   983c684466e02 ("SUNRPC: get rid of the request wait queue")

I'm not sure how RCU would help here. It would ensure that the pool does
not vanish within the RCU section. The pool remains around until
svc_destroy() and I assume that everything pool related (like
svc_pool::sp_sockets) is gone by then.

> I have an NFS server in my lab on NUMA hardware and can run
> some tests this week with this patch.

I'm a little confused now. I could repost the patch with an updated
description as you suggested _or_ limit the get_cpu()/preempt-disabled
section to be only around svc_pool_for_cpu(). I don't see the reason for
it but will do as requested (if you want me to) since it doesn't cause
any problems.

Sebastian
