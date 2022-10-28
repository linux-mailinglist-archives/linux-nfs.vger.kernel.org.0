Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A87611A72
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 20:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ1St4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJ1Sty (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 14:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FEE1274E;
        Fri, 28 Oct 2022 11:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56DCF6281C;
        Fri, 28 Oct 2022 18:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AC0C433C1;
        Fri, 28 Oct 2022 18:49:49 +0000 (UTC)
Date:   Fri, 28 Oct 2022 14:50:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <20221028145005.28bc324d@gandalf.local.home>
In-Reply-To: <20221027150525.753064657@goodmis.org>
References: <20221027150525.753064657@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond,

I'm looking at a commit from 2005:

0f9dc2b16884b ("RPC: Clean up socket autodisconnect")

     Cancel autodisconnect requests inside xprt_transmit() in order to avoid
     races.
     Use more efficient del_singleshot_timer_sync()


I'm working on adding a "shutdown" state to timers, making it required for
freeing the timer. This is to address the numerous bugs we hit where timers
get rearmed just before freeing and then cause a crash in the timer code,
without knowing what timer it was that caused it.

Having a specific shutdown state for timers will remove this problem
because if something tries to rearm a shutdown timer, it will fail and a
WARN_ON_ONCE() is triggered. See below in the "reply" part for a
description of this effort.

The reason for this email, is because that WARN_ON_ONCE() triggered on the
mod_timer() from:

static void
xprt_schedule_autodisconnect(struct rpc_xprt *xprt)
	__must_hold(&xprt->transport_lock)
{
	xprt->last_used = jiffies;
	if (RB_EMPTY_ROOT(&xprt->recv_queue) && xprt_has_timer(xprt))
		mod_timer(&xprt->timer, xprt->last_used + xprt->idle_timeout);
}

That's because xptr->timer was shutdown due to:

int
xprt_request_enqueue_receive(struct rpc_task *task)
{
	[..]
	/* Turn off autodisconnect */
	del_singleshot_timer_sync(&xprt->timer);
	return 0;
}

Now singleshot means just that. It's a single shot and calling
del_singleshot_timer_sync() will shut it down so that it can be freed. That
also means that it can no longer be re-armed.

I'm not sure what you meant by "Use more efficient del_singleshot_timer_sync()"
but I'm guessing since that was written in 2005, it is no longer relevant,
and del_timer_sync() should now be used.

After replacing that with del_timer_sync(), the warning goes away.

I just want to confirm that's OK with you.

Thanks,

-- Steve


On Thu, 27 Oct 2022 11:05:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Back in April, I posted an RFC patch set to help mitigate a common issue
> where a timer gets armed just before it is freed, and when the timer
> goes off, it crashes in the timer code without any evidence of who the
> culprit was. I got side tracked and never finished up on that patch set.
> Since this type of crash is still our #1 crash we are seeing in the field,
> it has become a priority again to finish it.
> 
> This is v2 of that patch set. Thomas Gleixner posted an untested version
> that makes timer->function NULL as the flag that it is shutdown. I took that
> code, tested it (fixed it up), added more comments, and changed the
> name to del_timer_shutdown() as Linus had asked. I also converted it to use
> WARN_ON_ONCE() instead of just WARN_ON() as Linus asked for that too.
> 
> (Thomas, you never added a SoB, so I only added a link to your email
>  in that commit. But as this will likely go through your tree anyway,
>  I'm sure you'll have your SoB on all these).
> 
> I then created a trivial coccinelle script to find where del_timer*()
> is called before being freed, and converted them all to del_timer_shutdown()
> (There was a couple that still used del_timer() instead of del_timer_sync()).
> 
> I also updated DEBUG_OBJECTS_TIMERS to check from where the timer is ever
> armed, to calling of del_timer_shutdown(), and it will trigger if a timer
> is freed in between. The current way is to only check if the timer is armed,
> but that means it only triggers if the race condition is hit, and with
> experience, it's not run on enough machines to catch all of them. By triggering
> it from the time the timer is armed to the time it is shutdown, it catches
> all potential cases even if the race condition is not hit.
> 
> I went though the result of the cocinelle script, and updated the locations.
> Some locations were caught by DEBUG_OBJECTS_TIMERS as the coccinelle script
> only checked for timers being freed in the same function as the del_timer*().
> 
> V1 is found here: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> 
> Here's the original text of that version:
> 
>    [
>      This is an RFC patch. As we hit a few bugs were del_timer() is called
>      instead of del_timer_sync() before the timer is freed, and there could
>      be bugs where even del_timer_sync() is used, but the timer gets rearmed,
>      I decided to introduce a "del_timer_free()" function that can be used
>      instead. This will at least educate developers on what to call before they
>      free a structure that holds a timer.
> 
>      In this RFC, I modified hci_qca.c as a use case, even though that change
>      needs some work, because the workqueue could still rearm it (I'm looking
>      to see if I can trigger the warning).
> 
>      If this approach is acceptable, then I will remove the hci_qca.c portion
>      from this patch, and create a series of patches to use the
>      del_timer_free() in all the locations in the kernel that remove the timer
>      before freeing.
>    ]
> 
>    We are hitting a common bug were a timer is being triggered after it is
>    freed. This causes a corruption in the timer link list and crashes the
>    kernel. Unfortunately it is not easy to know what timer it was that was
>    freed. Looking at the code, it appears that there are several cases that
>    del_timer() is used when del_timer_sync() should have been.
> 
>    Add a del_timer_free() that not only does a del_timer_sync() but will mark
>    the timer as freed in case it gets rearmed, it will trigger a WARN_ON. The
>    del_timer_free() is more likely to be used by developers that are about to
>    free a timer, then using del_timer_sync() as the latter is not as obvious
>    to being needed for freeing. Having the word "free" in the name of the
>    function will hopefully help developers know that that function needs to
>    be called before freeing.
> 
>    The added bonus is the marking of the timer as being freed such that it
>    will trigger a warning if it gets rearmed. At least that way if the system
>    crashes on a freed timer, at least we may see which timer it was that was
>    freed.
> 
