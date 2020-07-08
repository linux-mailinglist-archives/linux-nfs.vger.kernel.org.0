Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5A218C8D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgGHQIl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbgGHQIl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 12:08:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D947C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 09:08:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so41066995edy.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTWzIUIU61kGIXpIwLerSuSKe5bKsEM4SVNDCbhuzHk=;
        b=hEbzJHHFKskgFuiHcwVetV3t/Ye8lgbS+dGQuMHLhtF87Gq/zfmF7ApOgJl3YHVHTY
         Q87vqfdgOmh1kA4cMNYc1qsc/gJ7Ngeg8m1xbdQep5dFBpDY1ygxvLZiPiH5LnbsQOro
         Q5Ljrn8rRRSw7I36t/z7tQfqPSKX5MAF1T+k/p/7sgIWhYw6rx0M41c6IWTVYo7yafSM
         c+QQ5qKtJYG+oGGSJFp+11LMgqGjbU0pRprM3W4gxfKremDivHX3evpojQAiHvmtAR8J
         xNtAV35Il3UWDU6j96NA7NUNCmVHfB8YGKuC1EOwjdYeKKKnzW5kDK8L1a02oIC+u0an
         hkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTWzIUIU61kGIXpIwLerSuSKe5bKsEM4SVNDCbhuzHk=;
        b=DZ7nFd3HsDcMKbX1gGLRCU9PrQ/dJYOnhfIqbOvZrbU2HIQdfIQ30lERFk+gHXtnJy
         vE4sskrwBnwuZz67Lv/IwD5YVgnzGy4gv3IHrmdXvPlJIxGKIaYosbf8oCnWL3CYeiz0
         ync7DsMh5+SMFtmXwO0rcYHyheuT9rDnhZIYS1khuIeTtEBqMbxDYg26keVRRqNft2B5
         V+AzbzB+pCzYc/vaV0brMT1Try7bhdZePb8NlhFn2XsQo74OcgEIaOWioPqctFXstkfT
         +prCjFaJwOSZr+Q9iXd3s0ebhzFPHZsdpiz0PwmzlzhgRogqt5ARRhbA/roNiCQ5p79z
         T9lg==
X-Gm-Message-State: AOAM530pW4JPfRH2Lr5x00ZmwGmTrKH74vrDia+Fu8rPCgr/m9Wjvtkj
        Q/v8piw3PsvACs5+51t3TE14+uJl2yQOaXQ50G8=
X-Google-Smtp-Source: ABdhPJxPUj1PFrUwJvX3ozEE2IXb+rMT/D5O9XHQWyh6ZQ4npteGiQA4oWVRfMQ/WZHR9kRyHUjy2wKpOu7qbTbnhMY=
X-Received: by 2002:a50:b5e3:: with SMTP id a90mr28481269ede.381.1594224519821;
 Wed, 08 Jul 2020 09:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200708155018.110150-1-Anna.Schumaker@Netapp.com>
 <20200708155018.110150-2-Anna.Schumaker@Netapp.com> <25e89e208bd3c6e44f8041d64c96be238b78c3b6.camel@hammerspace.com>
In-Reply-To: <25e89e208bd3c6e44f8041d64c96be238b78c3b6.camel@hammerspace.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 8 Jul 2020 12:08:23 -0400
Message-ID: <CAFX2Jf=p7zgwRUxFjHSB9eAmhvqSMxQUdGa=qLEXqbKieDTcpA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] NFS: Fix interrupted slots by sending a solo
 SEQUENCE operation
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 8, 2020 at 12:00 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2020-07-08 at 11:50 -0400, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > We used to do this before 3453d5708b33, but this was changed to
> > better
> > handle the NFS4ERR_SEQ_MISORDERED error code. This commit fixed the
> > slot
> > re-use case when the server doesn't receive the interrupted
> > operation,
> > but if the server does receive the operation then it could still end
> > up
> > replying to the client with mis-matched operations from the reply
> > cache.
> >
> > We can fix this by sending a SEQUENCE to the server while recovering
> > from
> > a SEQ_MISORDERED error when we detect that we are in an interrupted
> > slot
> > situation.
> >
> > Fixes: 3453d5708b33 (NFSv4.1: Avoid false retries when RPC calls are
> > interrupted)
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index e32717fd1169..5de41a5772f0 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -774,6 +774,14 @@ static void nfs4_slot_sequence_acked(struct
> > nfs4_slot *slot,
> >       slot->seq_nr_last_acked = seqnr;
> >  }
> >
> > +static void nfs4_probe_sequence(struct nfs_client *client, const
> > struct cred *cred,
> > +                             struct nfs4_slot *slot)
> > +{
> > +     struct rpc_task *task = _nfs41_proc_sequence(client, cred,
> > slot, true);
> > +     if (!IS_ERR(task))
> > +             rpc_wait_for_completion_task(task);
>
> Hmm... I am a little concerned about the wait here, since we don't know
> what kind of thread this is.
>
> Any chance we could kick off a _nfs41_proc_sequence asynchronously, and
> then perhaps requeue the original task to wait for the next free slot?
> I suppose one issue there would be if the 'original task is an earlier
> call to _nfs41_proc_sequence, but perhaps that can be worked around?

I'll try it and see what happens. Thanks for the feedback!
Anna

>
> > +}
> > +
> >  static int nfs41_sequence_process(struct rpc_task *task,
> >               struct nfs4_sequence_res *res)
> >  {
> > @@ -790,6 +798,7 @@ static int nfs41_sequence_process(struct rpc_task
> > *task,
> >               goto out;
> >
> >       session = slot->table->session;
> > +     clp = session->clp;
> >
> >       trace_nfs4_sequence_done(session, res);
> >
> > @@ -804,7 +813,6 @@ static int nfs41_sequence_process(struct rpc_task
> > *task,
> >               nfs4_slot_sequence_acked(slot, slot->seq_nr);
> >               /* Update the slot's sequence and clientid lease timer
> > */
> >               slot->seq_done = 1;
> > -             clp = session->clp;
> >               do_renew_lease(clp, res->sr_timestamp);
> >               /* Check sequence flags */
> >               nfs41_handle_sequence_flag_errors(clp, res-
> > >sr_status_flags,
> > @@ -852,10 +860,15 @@ static int nfs41_sequence_process(struct
> > rpc_task *task,
> >               /*
> >                * Were one or more calls using this slot interrupted?
> >                * If the server never received the request, then our
> > -              * transmitted slot sequence number may be too high.
> > +              * transmitted slot sequence number may be too high.
> > However,
> > +              * if the server did receive the request then it might
> > +              * accidentally give us a reply with a mismatched
> > operation.
> > +              * We can sort this out by sending a lone sequence
> > operation
> > +              * to the server on the same slot.
> >                */
> >               if ((s32)(slot->seq_nr - slot->seq_nr_last_acked) > 1)
> > {
> >                       slot->seq_nr--;
> > +                     nfs4_probe_sequence(clp, task->tk_msg.rpc_cred,
> > slot);
> >                       goto retry_nowait;
> >               }
> >               /*
> --
> Trond Myklebust
> CTO, Hammerspace Inc
> 4984 El Camino Real, Suite 208
> Los Altos, CA 94022
> www.hammer.space
>
>
