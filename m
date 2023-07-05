Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C485747B97
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jul 2023 04:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGECnv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jul 2023 22:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGECnu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jul 2023 22:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA910F5
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 19:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D29613EA
        for <linux-nfs@vger.kernel.org>; Wed,  5 Jul 2023 02:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6073C433C7;
        Wed,  5 Jul 2023 02:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688525028;
        bh=CJ68G7YuRbha143kXOOjRkrQiLW7e5WGvmWpfc7Wykw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9IhkdLgOg8xKZyu+gnziCQBlvSOz3zHuWEFvFt7pDc82aK2nLELtrEOhKDII2nSj
         1+V1q7Symr6YXXy0J+yMyfEDXqyWeZNlKemGVC9HV2N8B3i7gioxgI+hAdq4YONmpQ
         SPQiDXdero859mWBla7djZvscSYa1fGnXA6fyN8fdzImAx+l1q6QxsKvHZp/oGjdQJ
         DcSBJUgcIJAldf/Is8wINhPM+EEs7gTxOkG//MELnvdOdOws6OvGpV8f2EDH/CFW5G
         x5TmvFi2s8u5TDhOji0I2ZpuiAHZ9/GlAbG4GTbHfRRonftUmdW4mjGxoSnG/Q8TkQ
         UFU/CSyQeo+Uw==
Date:   Tue, 4 Jul 2023 22:43:45 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v2 0/9] SUNRPC service thread scheduler optimizations
Message-ID: <ZKTY4RiB6bC/SL2F@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168851931219.8939.14382911673248383020@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168851931219.8939.14382911673248383020@noble.neil.brown.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 05, 2023 at 11:08:32AM +1000, NeilBrown wrote:
> 
> I've been pondering this scheduling mechanism in sunrpc/svc some more,
> and I wonder if rather than optimising the search, we should eliminate
> it.
> 
> Instead we could have a linked list of idle threads using llist.h
> 
> svc_enqueue_xprt calls llist_del_first() and if the result is not NULL,
> that thread is deemed busy (because it isn't on the list) and is woken.
> 
> choose_victim() could also use llist_del_first().  If nothing is there
> it could set a flag which gets cleared by the next thread to go idle.
> That thread exits ..  or something.  Some interlock would be needed but
> it shouldn't be too hard.
> 
> svc_exit_thread would have difficulty removing itself from the idle
> list, if it wasn't busy..  Possibly we could disallow that case (I think
> sending a signal to a thread can make it exit while idle).
> Alternately we could use llist_del_all() to clear the list, then wake
> them all up so that they go back on the list if there is nothing to do
> and if they aren't trying to exit.  That is fairly heavy handed, but
> isn't a case that we need to optimise.
> 
> If you think that might be worth pursuing, I could have a go at writing
> the patch - probably on top of all the cleanups in your series before
> the xarray is added.

The thread pool is effectively a cached resource, so it is a use case
that fits llist well. svcrdma uses llist in a few spots in that very
capacity.

If you think you can meet all of the criteria in the table at the top of
llist.h so thread scheduling works entirely without a lock, that might
be an interesting point of comparison.

My only concern is that the current set of candidate mechanisms manage
to use mostly the first thread, rather than round-robining through the
thread list. Using mostly one process tends to be more cache-friendly.
An llist-based thread scheduler should try to follow that behavior,
IMO.


> I also wonder if we should avoid waking too many threads up at once.
> If multiple events happen in quick succession, we currently wake up
> multiple threads and if there is any scheduling delay (which is expected
> based on Commit 22700f3c6df5 ("SUNRPC: Improve ordering of transport processing"))
> then by the time the threads wake up, there may no longer be work to do
> as another thread might have gone idle and taken the work.

It might be valuable to add some observability of wake-ups that find
nothing to do. I'll look into that.


> Instead we could have a limit on the number of threads waking up -
> possibly 1 or 3.  If the counter is maxed out, don't do a wake up.
> When a thread wakes up, it decrements the counter, dequeues some work,
> and if there is more to do, then it queues another task.

I consider reducing the wake-up rate as the next step for improving
RPC service thread scalability. Any experimentation in that area is
worth looking into.


> I imagine the same basic protocol would be used for creating new threads
> when load is high - start just one at a time, though maybe a new thread
> would handle a first request before possibly starting another thread.

I envision that dynamically tuning the pool thread count as something
that should be managed in user space, since it's a policy rather than
a mechanism.

That could be a problem, though, if we wanted to shut down a few pool
threads based on shrinker activity.
