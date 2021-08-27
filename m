Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6199F3FA157
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhH0WBs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 18:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0WBr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 18:01:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82253C0613D9
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 15:00:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q21so4787647plq.3
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KU6Oj6ko3t1UlfRRdesW+khRknc2/3XzPemCk9l1U3U=;
        b=bwge3MYChnMBP/3P52PlmHqNa9xrfItvTnzCU0xGx0hyhI+4h7K/09O8iJRhwKN+he
         nXFpMHMA6u96VB9g3IVbLK2Wxt7nI3uOe5kOzjx8aWLW2n3tjkQ9Zlleo9US+3sUc0J0
         UvwSHxIZ0T8WIExMrJUBsQwjO4cys44bJAk5Bt5/Vqk6pmy2S8oph7DVhWyyWdO5mguT
         sDB7TZAiFCefl/t8Q4NVgV+dX8eiKu17MqQiUOG0vadKFXLxH4loMFByKHv0B3cMSr5G
         Y+e23g68Brrbp8wOmYhzhFomuwNnAWcGZ4YzqZW6bN33Cr0mo/pTju4ipkJ7eqcX8eNo
         Q/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KU6Oj6ko3t1UlfRRdesW+khRknc2/3XzPemCk9l1U3U=;
        b=f0Tt+Ar7jmYSi3oCFGg/RbQrAAOdXi3200obegFyHqXc0i5nsSZWvqCS56rHvp9U3s
         y+MuUPTPwKrsT4n8v19LLdZKQd+HQQpKdVFDAqOQ+kOotpWEhy1QFQzM5/oVwr3wNymd
         vB0bm+PegjBofwfb7yhKEfx2+nETg7IHdUTB0H4IBl87xJ2oJTQgelJJn5Jk3sYdanwk
         Qxf+kGPv8WlkrqIcbwop06hzWMr1L0uDGGSkVzZYfkeT8fMPH8v3GyddSEvw2d0qFIzJ
         XgOO183dJaGyWCjF7j0kfaoDkIUOLlk81hRO4jGFiIRI1WojQN/qGPuEfRcX+YIhL85T
         8ojg==
X-Gm-Message-State: AOAM531i4B70omHn7H93CaoFytBR86TyLTjy0IZT/Qzv3Ez6B45Ys5w5
        v1DARzHm1KXBTPsZh6GI4oSSVAAm2VvKGxT2H0E=
X-Google-Smtp-Source: ABdhPJziGECFg+xSBde6fPfQrU25XxWMXgw/58ff9ylUIPnvWiFA20oRf5fnTua7WTomD4Q+b7564JS5D1JdNNTGL/g=
X-Received: by 2002:a17:90a:8809:: with SMTP id s9mr25153495pjn.44.1630101657835;
 Fri, 27 Aug 2021 15:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com> <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>
 <162941948235.9892.6790956894845282568@noble.neil.brown.name>
 <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>
 <162960371884.9892.13803244995043191094@noble.neil.brown.name>
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>
 <162966962721.9892.5962616727949224286@noble.neil.brown.name>
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>
 <163001427749.7591.7281634750945934559@noble.neil.brown.name>
 <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com>
 <163004202961.7591.12633163545286005205@noble.neil.brown.name>
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
 <163004848514.7591.2757618782251492498@noble.neil.brown.name>
 <6CC9C852-CEE3-4657-86AD-9D5759E2BE1C@oracle.com> <CAOv1SKAiPB62sQcnDCKC5vYbbmakfbe80KRu3JEVZVO7Trk8cw@mail.gmail.com>
In-Reply-To: <CAOv1SKAiPB62sQcnDCKC5vYbbmakfbe80KRu3JEVZVO7Trk8cw@mail.gmail.com>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Fri, 27 Aug 2021 15:00:47 -0700
Message-ID: <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Mel Gorman <mgorman@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

OK, an update. Several hours of spaced out testing sessions and the
first patch seems to have resolved the issue. There may be a very tiny
bit of lag that still occurs when opening/processing new files, but so
far on this kernel I have not had any multi-second freezes. I am still
waiting on the kernel with Neil's patch to compile (compiling on this
underpowered server so it's taking several hours), but I think the
testing there will just be to see if I can show it works still, and
then to try and test in a memory constrained VM. To see if I can
recreate Neil's experiment. Likely will have to do this over the
weekend given the kernel compile delay + fiddling with a VM.

Chuck: I don't mean to overstep bounds, but is it possible to get that
patch pulled into 5.13 stable? That may help things for several people
while 5.14 goes through it's shakedown in archlinux prior to release.

- mike

On Fri, Aug 27, 2021 at 10:07 AM Mike Javorski <mike.javorski@gmail.com> wrote:
>
> Chuck:
> I just booted a 5.13.13 kernel with your suggested patch. No freezes
> on the first test, but that sometimes happens so I will let the server
> settle some and try it again later in the day (which also would align
> with Neil's comment on memory fragmentation being a contributor).
>
> Neil:
> I have started a compile with the above kernel + your patch to test
> next unless you or Chuck determine that it isn't needed, or that I
> should test both patches discreetly. As the above is already merged to
> 5.14 it seemed logical to just add your patch on top.
>
> I will also try to set up a vm to test your md5sum scenario with the
> various kernels since it's a much faster thing to test.
>
> - mike
>
> On Fri, Aug 27, 2021 at 7:13 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> >
> > > On Aug 27, 2021, at 3:14 AM, NeilBrown <neilb@suse.de> wrote:
> > >
> > > Subject: [PATCH] SUNRPC: don't pause on incomplete allocation
> > >
> > > alloc_pages_bulk_array() attempts to allocate at least one page based on
> > > the provided pages, and then opportunistically allocates more if that
> > > can be done without dropping the spinlock.
> > >
> > > So if it returns fewer than requested, that could just mean that it
> > > needed to drop the lock.  In that case, try again immediately.
> > >
> > > Only pause for a time if no progress could be made.
> >
> > The case I was worried about was "no pages available on the
> > pcplist", in which case, alloc_pages_bulk_array() resorts
> > to calling __alloc_pages() and returns only one new page.
> >
> > "No progess" would mean even __alloc_pages() failed.
> >
> > So this patch would behave essentially like the
> > pre-alloc_pages_bulk_array() code: call alloc_page() for
> > each empty struct_page in the array without pausing. That
> > seems correct to me.
> >
> >
> > I would add
> >
> > Fixes: f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator")
> >
> >
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > > net/sunrpc/svc_xprt.c | 7 +++++--
> > > 1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > > index d66a8e44a1ae..99268dd95519 100644
> > > --- a/net/sunrpc/svc_xprt.c
> > > +++ b/net/sunrpc/svc_xprt.c
> > > @@ -662,7 +662,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
> > > {
> > >       struct svc_serv *serv = rqstp->rq_server;
> > >       struct xdr_buf *arg = &rqstp->rq_arg;
> > > -     unsigned long pages, filled;
> > > +     unsigned long pages, filled, prev;
> > >
> > >       pages = (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
> > >       if (pages > RPCSVC_MAXPAGES) {
> > > @@ -672,11 +672,14 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
> > >               pages = RPCSVC_MAXPAGES;
> > >       }
> > >
> > > -     for (;;) {
> > > +     for (prev = 0;; prev = filled) {
> > >               filled = alloc_pages_bulk_array(GFP_KERNEL, pages,
> > >                                               rqstp->rq_pages);
> > >               if (filled == pages)
> > >                       break;
> > > +             if (filled > prev)
> > > +                     /* Made progress, don't sleep yet */
> > > +                     continue;
> > >
> > >               set_current_state(TASK_INTERRUPTIBLE);
> > >               if (signalled() || kthread_should_stop()) {
> >
> > --
> > Chuck Lever
> >
> >
> >
