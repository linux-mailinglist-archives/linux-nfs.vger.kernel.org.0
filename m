Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8C376FB
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfFFOlA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 10:41:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36186 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfFFOlA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jun 2019 10:41:00 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so395614ioh.3
        for <linux-nfs@vger.kernel.org>; Thu, 06 Jun 2019 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRHFQx4rk/WQV+W1bUpqDxQ0lUZEI/eFyBpWg1hk11Q=;
        b=sCbqy9Il3Out2uZPEuDkEDVkIvng7aW0ineP0yjFozNXPOloupyWTAbt2WypG90mH2
         RO8VsxvONEY6+lOd57nEUJshWUBcTFa4IkigR9dm1Tf3DkipfnQEDvxo9Opwgz/kXNUS
         DmfwsDfBQINnUWZ0Xoz1mLZvPk4JJIu5YNhrczzgp/VL2bPoWMOSqbNGpzr8ixIvUQ6M
         V9vloCuM2sAIC1VdTIvssvKJA6lBX9B+Tqrhtdc0OZYZB24Z7LzEBoEXD0s6IamPEOWM
         W5OA0EUvwGXsDqIoNEx40vD+nBZGfdTKV5o4U5ZsLduig2WAsLA4QAk+CITyXaYhUObi
         8iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRHFQx4rk/WQV+W1bUpqDxQ0lUZEI/eFyBpWg1hk11Q=;
        b=BpRDaXTYbRGhriFe0YLVrJjCtlfQblHy/1MgL+zxrKEnK6P2fEhnfvmCIyFQDI55DM
         DL0zVJzAB17H2iU/exvrsy6pmqZX5r9Kp1RlWEvPUjROhOrCkSqwny9tba/kQOKrR0e+
         zu2J7G/WtcEj86O6z2aylWMakru2O5uDLO2nBe5WsVKN8PQcs5YyU1pvguUUhZTr8Odf
         ymqBB7oufb6g3V1R9wrHvyidLwFcd55CnXsCgGT1/Z6hAYSwbPd5AB05n+1y42d5ZWj6
         mDc37WOVOiof7UmbkUBKX87GqyZblUXl7trUEZK5uDEHRWKzLIVUjDGTR0+4P8KJupTZ
         BTMQ==
X-Gm-Message-State: APjAAAWSZsJ1QxdtZwJJZ4VzlsAzi+6TABhdSSahQJhO8gIxZPTFaVox
        yxh+xfP/LEIMk37eX5/MB+mgyO5hPWJxqkdDGQq6zA==
X-Google-Smtp-Source: APXvYqzKErRjMjB/Lu1mV96B+n+Cf6+/oCq0PF53kEaSxsxhJvuN0Qd+FEtZW9TaI4V1DZGCc+oSBw0knpFzAe36NbU=
X-Received: by 2002:a6b:e711:: with SMTP id b17mr28649615ioh.3.1559832059117;
 Thu, 06 Jun 2019 07:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005a4b99058a97f42e@google.com> <b67a0f5d-c508-48a7-7643-b4251c749985@virtuozzo.com>
 <20190606131334.GA24822@fieldses.org> <275f77ad-1962-6a60-e60b-6b8845f12c34@virtuozzo.com>
In-Reply-To: <275f77ad-1962-6a60-e60b-6b8845f12c34@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Jun 2019 16:40:46 +0200
Message-ID: <CACT4Y+aJQ6J5WdviD+cOmDoHt2Dj=Q4uZ4vHbCfHe+_TCEY6-Q@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in unregister_shrinker
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        syzbot <syzbot+83a43746cebef3508b49@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, bfields@redhat.com,
        chris@chrisdown.name, Daniel Jordan <daniel.m.jordan@oracle.com>,
        guro@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Jeff Layton <jlayton@kernel.org>, laoar.shao@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-nfs@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 6, 2019 at 3:43 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.06.2019 16:13, J. Bruce Fields wrote:
> > On Thu, Jun 06, 2019 at 10:47:43AM +0300, Kirill Tkhai wrote:
> >> This may be connected with that shrinker unregistering is forgotten on error path.
> >
> > I was wondering about that too.  Seems like it would be hard to hit
> > reproduceably though: one of the later allocations would have to fail,
> > then later you'd have to create another namespace and this time have a
> > later module's init fail.
>
> Yes, it's had to bump into this in real life.
>
> AFAIU, syzbot triggers such the problem by using fault-injections
> on allocation places should_failslab()->should_fail(). It's possible
> to configure a specific slab, so the allocations will fail with
> requested probability.

No fault injection was involved in triggering of this bug.
Fault injection is clearly visible in console log as "INJECTING
FAILURE at this stack track" splats and also for bugs with repros it
would be noted in the syzkaller repro as "fault_call": N. So somehow
this bug was triggered as is.

But overall syzkaller can do better then the old probabilistic
injection. The probabilistic injection tend to both under-test what we
want to test and also crash some system services. syzkaller uses the
new "systematic fault injection" that allows to test specifically each
failure site separately in each syscall separately.
All kernel testing systems should use it. Also in couple with KASAN,
KMEMLEAK, LOCKDEP. It's indispensable in finding kernel bugs.



> > This is the patch I have, which also fixes a (probably less important)
> > failure to free the slab cache.
> >
> > --b.
> >
> > commit 17c869b35dc9
> > Author: J. Bruce Fields <bfields@redhat.com>
> > Date:   Wed Jun 5 18:03:52 2019 -0400
> >
> >     nfsd: fix cleanup of nfsd_reply_cache_init on failure
> >
> >     Make sure everything is cleaned up on failure.
> >
> >     Especially important for the shrinker, which will otherwise eventually
> >     be freed while still referred to by global data structures.
> >
> >     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> >
> > diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> > index ea39497205f0..3dcac164e010 100644
> > --- a/fs/nfsd/nfscache.c
> > +++ b/fs/nfsd/nfscache.c
> > @@ -157,12 +157,12 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
> >       nn->nfsd_reply_cache_shrinker.seeks = 1;
> >       status = register_shrinker(&nn->nfsd_reply_cache_shrinker);
> >       if (status)
> > -             return status;
> > +             goto out_nomem;
> >
> >       nn->drc_slab = kmem_cache_create("nfsd_drc",
> >                               sizeof(struct svc_cacherep), 0, 0, NULL);
> >       if (!nn->drc_slab)
> > -             goto out_nomem;
> > +             goto out_shrinker;
> >
> >       nn->drc_hashtbl = kcalloc(hashsize,
> >                               sizeof(*nn->drc_hashtbl), GFP_KERNEL);
> > @@ -170,7 +170,7 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
> >               nn->drc_hashtbl = vzalloc(array_size(hashsize,
> >                                                sizeof(*nn->drc_hashtbl)));
> >               if (!nn->drc_hashtbl)
> > -                     goto out_nomem;
> > +                     goto out_slab;
> >       }
> >
> >       for (i = 0; i < hashsize; i++) {
> > @@ -180,6 +180,10 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
> >       nn->drc_hashsize = hashsize;
> >
> >       return 0;
> > +out_slab:
> > +     kmem_cache_destroy(nn->drc_slab);
> > +out_shrinker:
> > +     unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
> >  out_nomem:
> >       printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
> >       return -ENOMEM;
>
> Looks OK for me. Feel free to add my reviewed-by if you want.
>
> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/275f77ad-1962-6a60-e60b-6b8845f12c34%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.
