Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E2721915A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGHUTy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgGHUTx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:19:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A5BC061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:19:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dp18so51845574ejc.8
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2PfEQPxgZY4hwjqV2T4P8YyR49aWSh/8TcC3UdSwTo=;
        b=a6NM/8t/C1nW0y2F+3GU/dJ3Mxc4RHm9xCUN9wLdl5rFCfpsmPTWG3bK5vW/jc/25K
         W19tGKWvwS9WWGX3BUT7geP0IqZzbWDPrYcsUQExQgLGgM1qT+ls+RDTGvMOFrpKubLy
         730/MfPtnBN3BR2galbYIwDWqjuoMcX5g1YUeMY14OyPiJvcW7OMNn21M3eMC4zzUpXo
         NMyYYC9WXSlz9G2nYcC+BcM0GUgEAA4WkOkXd/dxZ5F4NyqcrLl1deMe5m1DooEJPkRo
         9Lx/blJX0QKAzhPGdJccbkFlthgfBKhxByNBJEczHxd+W7MIrUDuNaKhdtViSyAA1Tpc
         eSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2PfEQPxgZY4hwjqV2T4P8YyR49aWSh/8TcC3UdSwTo=;
        b=az6PW4y3bKBhaQC04t8NcKXvxcfu8t6LKMgdvKEoi9HK6vj+bLmMVX7+e27o8pnD5a
         AA/B+XTCHffbpUVejyGzzzKD++TrCEVuukbKBXOjpg953CNFpS7oSLo+Eu9c6qdC7ePl
         lXa+QiIONvLK2v65orxs8okub2jrJeJyF+iOt1ZV1lS48nblFCEazvPcOT20kFzU9ZSm
         ZVoVF2a+0nMlOtIRrSN9fSaJhQrWzlJsrxw3zFdGex8NRqPgScAcPbjDdadJfLdWf0Gn
         xLo0l8LVQt+asXcmukWjNEmvaan7ECGHCAG9tPj+tyuW9XxTeT++FAEwXeMD2905zVio
         DTzg==
X-Gm-Message-State: AOAM531CWs3x4CEE2NU0ZUxwGxGRyclq1YkuoSIkmG+VHEkuICApGx7p
        JfG3sxfrfkUbll6lDWbsDY4hLA19ddd1A6FYoTphJw==
X-Google-Smtp-Source: ABdhPJwnIgFd/P1lxzWtSCuI7e0gmyOpcMSABYpFyvT3vgmi/2O52/QFlh4wbP4YQM0V7ltiavmy5fXd3hSOLTRvhmI=
X-Received: by 2002:a17:906:70d1:: with SMTP id g17mr51951860ejk.436.1594239592232;
 Wed, 08 Jul 2020 13:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200708155018.110150-1-Anna.Schumaker@Netapp.com>
 <20200708155018.110150-2-Anna.Schumaker@Netapp.com> <25e89e208bd3c6e44f8041d64c96be238b78c3b6.camel@hammerspace.com>
 <CAFX2Jf=p7zgwRUxFjHSB9eAmhvqSMxQUdGa=qLEXqbKieDTcpA@mail.gmail.com>
In-Reply-To: <CAFX2Jf=p7zgwRUxFjHSB9eAmhvqSMxQUdGa=qLEXqbKieDTcpA@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 8 Jul 2020 16:19:36 -0400
Message-ID: <CAFX2JfkE+UUVyrd3q=GgC5m-NqcYA9cgMRTOj0AB2f6o1tBY2w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] NFS: Fix interrupted slots by sending a solo
 SEQUENCE operation
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 8, 2020 at 12:08 PM Anna Schumaker <schumaker.anna@gmail.com> wrote:
>
> On Wed, Jul 8, 2020 at 12:00 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Wed, 2020-07-08 at 11:50 -0400, schumaker.anna@gmail.com wrote:
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > We used to do this before 3453d5708b33, but this was changed to
> > > better
> > > handle the NFS4ERR_SEQ_MISORDERED error code. This commit fixed the
> > > slot
> > > re-use case when the server doesn't receive the interrupted
> > > operation,
> > > but if the server does receive the operation then it could still end
> > > up
> > > replying to the client with mis-matched operations from the reply
> > > cache.
> > >
> > > We can fix this by sending a SEQUENCE to the server while recovering
> > > from
> > > a SEQ_MISORDERED error when we detect that we are in an interrupted
> > > slot
> > > situation.
> > >
> > > Fixes: 3453d5708b33 (NFSv4.1: Avoid false retries when RPC calls are
> > > interrupted)
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > ---
> > >  fs/nfs/nfs4proc.c | 17 +++++++++++++++--
> > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index e32717fd1169..5de41a5772f0 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -774,6 +774,14 @@ static void nfs4_slot_sequence_acked(struct
> > > nfs4_slot *slot,
> > >       slot->seq_nr_last_acked = seqnr;
> > >  }
> > >
> > > +static void nfs4_probe_sequence(struct nfs_client *client, const
> > > struct cred *cred,
> > > +                             struct nfs4_slot *slot)
> > > +{
> > > +     struct rpc_task *task = _nfs41_proc_sequence(client, cred,
> > > slot, true);
> > > +     if (!IS_ERR(task))
> > > +             rpc_wait_for_completion_task(task);
> >
> > Hmm... I am a little concerned about the wait here, since we don't know
> > what kind of thread this is.

I've been playing with this all afternoon.
> >
> > Any chance we could kick off a _nfs41_proc_sequence asynchronously, and
> > then perhaps requeue the original task to wait for the next free slot?

I haven't had much luck getting this to work. The asynchronous task is
easy enough, but I haven't been able to get the original onto a new
slot yet. Is there a good way to do this without a new call to
nfs4_setup_sequence()? nfs41_sequence_process() only has the
sequence_res available, and there are enough call sites that adding in
sequence_args creates a lot of churn.

> > I suppose one issue there would be if the 'original task is an earlier
> > call to _nfs41_proc_sequence, but perhaps that can be worked around?

I could use the rpc task to see if it's sending a sequence, and only
do this if it's not. I don't know if there is a cleaner way to do
this.

Do you have any suggestions?
Anna

>
> I'll try it and see what happens. Thanks for the feedback!
> Anna
>
> >
> > > +}
> > > +
> > >  static int nfs41_sequence_process(struct rpc_task *task,
> > >               struct nfs4_sequence_res *res)
> > >  {
> > > @@ -790,6 +798,7 @@ static int nfs41_sequence_process(struct rpc_task
> > > *task,
> > >               goto out;
> > >
> > >       session = slot->table->session;
> > > +     clp = session->clp;
> > >
> > >       trace_nfs4_sequence_done(session, res);
> > >
> > > @@ -804,7 +813,6 @@ static int nfs41_sequence_process(struct rpc_task
> > > *task,
> > >               nfs4_slot_sequence_acked(slot, slot->seq_nr);
> > >               /* Update the slot's sequence and clientid lease timer
> > > */
> > >               slot->seq_done = 1;
> > > -             clp = session->clp;
> > >               do_renew_lease(clp, res->sr_timestamp);
> > >               /* Check sequence flags */
> > >               nfs41_handle_sequence_flag_errors(clp, res-
> > > >sr_status_flags,
> > > @@ -852,10 +860,15 @@ static int nfs41_sequence_process(struct
> > > rpc_task *task,
> > >               /*
> > >                * Were one or more calls using this slot interrupted?
> > >                * If the server never received the request, then our
> > > -              * transmitted slot sequence number may be too high.
> > > +              * transmitted slot sequence number may be too high.
> > > However,
> > > +              * if the server did receive the request then it might
> > > +              * accidentally give us a reply with a mismatched
> > > operation.
> > > +              * We can sort this out by sending a lone sequence
> > > operation
> > > +              * to the server on the same slot.
> > >                */
> > >               if ((s32)(slot->seq_nr - slot->seq_nr_last_acked) > 1)
> > > {
> > >                       slot->seq_nr--;
> > > +                     nfs4_probe_sequence(clp, task->tk_msg.rpc_cred,
> > > slot);
> > >                       goto retry_nowait;
> > >               }
> > >               /*
> > --
> > Trond Myklebust
> > CTO, Hammerspace Inc
> > 4984 El Camino Real, Suite 208
> > Los Altos, CA 94022
> > www.hammer.space
> >
> >
