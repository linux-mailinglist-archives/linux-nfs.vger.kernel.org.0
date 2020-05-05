Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28C41C6307
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2020 23:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEEVZ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 May 2020 17:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727785AbgEEVZ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 May 2020 17:25:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4064C061A0F
        for <linux-nfs@vger.kernel.org>; Tue,  5 May 2020 14:25:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0A4B7BDB; Tue,  5 May 2020 17:25:27 -0400 (EDT)
Date:   Tue, 5 May 2020 17:25:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200505212527.GA1265@fieldses.org>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200505021514.GA43625@pick.fieldses.org>
 <20200505210118.GC27966@fieldses.org>
 <20200505210956.GA3350@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505210956.GA3350@mtj.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 05, 2020 at 05:09:56PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Tue, May 05, 2020 at 05:01:18PM -0400, J. Bruce Fields wrote:
> > On Mon, May 04, 2020 at 10:15:14PM -0400, J. Bruce Fields wrote:
> > > Though now I'm feeling greedy: it would be nice to have both some kind
> > > of global flag, *and* keep kthread->data pointing to svc_rqst (as that
> > > would give me a simpler and quicker way to figure out which client is
> > > conflicting).  Could I take a flag bit in kthread->flags, maybe?
> > 
> > Would something like this be too hacky?:
> 
> It's not the end of the world but a bit hacky. I wonder whether something
> like the following would work better for identifying worker type so that you
> can do sth like
> 
>  if (kthread_fn(current) == nfsd)
>         return kthread_data(current);
>  else
>         return NULL;     

Yes, definitely more generic, looks good to me.

--b.

> 
> Thanks.
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index bfbfa481be3a..4f3ab9f2c994 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -46,6 +46,7 @@ struct kthread_create_info
>  struct kthread {
>  	unsigned long flags;
>  	unsigned int cpu;
> +	int (*threadfn)(void *);
>  	void *data;
>  	struct completion parked;
>  	struct completion exited;
> @@ -152,6 +153,13 @@ bool kthread_freezable_should_stop(bool *was_frozen)
>  }
>  EXPORT_SYMBOL_GPL(kthread_freezable_should_stop);
>  
> +void *kthread_fn(struct task_struct *task)
> +{
> +	if (task->flags & PF_KTHREAD)
> +		return to_kthread(task)->threadfn;
> +	return NULL;
> +}
> +
>  /**
>   * kthread_data - return data value specified on kthread creation
>   * @task: kthread task in question
> @@ -244,6 +252,7 @@ static int kthread(void *_create)
>  		do_exit(-ENOMEM);
>  	}
>  
> +	self->threadfn = threadfn;
>  	self->data = data;
>  	init_completion(&self->exited);
>  	init_completion(&self->parked);
> 
> -- 
> tejun
