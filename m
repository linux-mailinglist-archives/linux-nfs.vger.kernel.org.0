Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E3C3A83A9
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhFOPJY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhFOPJV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 11:09:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC7EC061574
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 08:07:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g20so23236487ejt.0
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hP3Mt/W6d69RoPiFiFWaXKKoIJjdrt6DPB0zus/qvIs=;
        b=Tjw0iebw5RjMonL8/0pLLV/ojQ7bjhfrygQ1Lq/9VvUlYAamiz7WMwfQyattTztvrP
         mUU/fOEi+ieOAOHVA8Aa8qOotMA3yV05qr93KWVUoChAYU5f7LrKlFl+r/JqBnwhCUjm
         ocbyZPgzHo6+gTwErADPl1bjcszD/P8+HosN65YmSD5LDiVNhcaKNLK1BnVCmF0kPwUy
         yJhT3Avp7Fu+5AxUQS/fQrmbM3vAkcyaeW9z/tyWqqe7YZnFHdlolQZ0Fj/0Ds6FXC0y
         vvqR6FE5ni1xDBZf/G+oXlP1Vlh459P+gPCnAwOu0MSDAqCg2/sb1bpoDQ/Q1vhsfxXz
         gceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hP3Mt/W6d69RoPiFiFWaXKKoIJjdrt6DPB0zus/qvIs=;
        b=QdEpEk5+16WidHX8st+G76yyEhTuVQD9GobFG+VXLtWorAZ6AUCjn1h6Dmfp4My/pg
         NZ2PnXl4evieJXny1yO67GcKRTaBHb2IrEpK3BaOG4xY5x8s34GmzUGN9xCZnRIqxKkA
         r1ynQ4kLvJZHICbUrsWfMzYbElxHQtVLaRv65QUSTF8OJsWTbZUKjAtfbQ3p1fFb0yAB
         MT/4n28RXdB7RXEW5KFOdZRKWB2KrTh8C53lYSCjXkMcuAJzCUPdRCEh8Qi8hG60Y4RY
         HiuS5Z5OfSdjt1Cy3QJBfPwqFNJsNqzkV/3+0PEJEawQr4u8m8QQcGnhCMAXAPvB9+kj
         UO3g==
X-Gm-Message-State: AOAM533YQ+djDbrRDmTrw9In+zK2pR7csQ6rTYUDAAd22/UpR4XJB0Sr
        mQbvJvF3Fa3fZjFkIB9DLkm3CJzShjyJZTxF7bbLdbS2gM0=
X-Google-Smtp-Source: ABdhPJwFfJub+X2bYozER9KvbAItQugsxsy7R9PenBXuUVhdA3NxG/C3qQoSqjJ5B7v1c34bR3FhgNXP1gmBwG1/Tpo=
X-Received: by 2002:a17:906:15c2:: with SMTP id l2mr21265442ejd.348.1623769634641;
 Tue, 15 Jun 2021 08:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
 <20210603225907.19981-3-olga.kornievskaia@gmail.com> <8c22421ec7374b3e58b6019933d1c419f7703d28.camel@hammerspace.com>
In-Reply-To: <8c22421ec7374b3e58b6019933d1c419f7703d28.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 15 Jun 2021 11:07:02 -0400
Message-ID: <CAN-5tyGk6OgCg-n2OLWN4_9q+GP6E=TuZr7ZFGRCheWQpR9VLA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] NFSv4.1 identify and mark RPC tasks that can move
 between transports
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jun 13, 2021 at 12:18 PM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Thu, 2021-06-03 at 18:59 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > In preparation for when we can re-try a task on a different
> > transport,
> > identify and mark such RPC tasks as moveable. Only 4.1+ operarations
> > can
> > be re-tried on a different transport.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c            | 38 +++++++++++++++++++++++++++++++---
> > --
> >  fs/nfs/pagelist.c            |  8 ++++++--
> >  fs/nfs/write.c               |  6 +++++-
> >  include/linux/sunrpc/sched.h |  2 ++
> >  4 files changed, 46 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index e25c16257545..40e8d36cbfa8 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -1155,7 +1155,11 @@ static int nfs4_call_sync_sequence(struct
> > rpc_clnt *clnt,
> >                                    struct nfs4_sequence_args *args,
> >                                    struct nfs4_sequence_res *res)
> >  {
> > -       return nfs4_do_call_sync(clnt, server, msg, args, res, 0);
> > +       unsigned short task_flags = 0;
> > +
> > +       if (server->nfs_client->cl_minorversion)
> > +               task_flags = RPC_TASK_MOVEABLE;
> > +       return nfs4_do_call_sync(clnt, server, msg, args, res,
> > task_flags);
> >  }
> >
> >
> > @@ -2569,6 +2573,9 @@ static int nfs4_run_open_task(struct
> > nfs4_opendata *data,
> >         };
> >         int status;
> >
> > +       if (server->nfs_client->cl_minorversion)
> > +               task_setup_data.flags |= RPC_TASK_MOVEABLE;
> > +
> >         kref_get(&data->kref);
> >         data->rpc_done = false;
> >         data->rpc_status = 0;
> > @@ -3749,6 +3756,9 @@ int nfs4_do_close(struct nfs4_state *state,
> > gfp_t gfp_mask, int wait)
> >         };
> >         int status = -ENOMEM;
> >
> > +       if (server->nfs_client->cl_minorversion)
> > +               task_setup_data.flags |= RPC_TASK_MOVEABLE;
> > +
> >         nfs4_state_protect(server->nfs_client,
> > NFS_SP4_MACH_CRED_CLEANUP,
> >                 &task_setup_data.rpc_client, &msg);
> >
> > @@ -4188,6 +4198,9 @@ static int _nfs4_proc_getattr(struct nfs_server
> > *server, struct nfs_fh *fhandle,
> >         };
> >         unsigned short task_flags = 0;
> >
> > +       if (server->nfs_client->cl_minorversion)
> > +               task_flags = RPC_TASK_MOVEABLE;
>
> Hmmm... This property isn't specific to a non-zero minor version. It is
> actually specific to the existence of a session.

Isn't this the same? Would we ever have a 4.1+ client without a session?

> > +
> >         /* Is this is an attribute revalidation, subject to
> > softreval? */
> >         if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
> >                 task_flags |= RPC_TASK_TIMEOUT;
> > @@ -4307,6 +4320,9 @@ static int _nfs4_proc_lookup(struct rpc_clnt
> > *clnt, struct inode *dir,
> >         };
> >         unsigned short task_flags = 0;
> >
> > +       if (server->nfs_client->cl_minorversion)
> > +               task_flags = RPC_TASK_MOVEABLE;
> > +
> >         /* Is this is an attribute revalidation, subject to
> > softreval? */
> >         if (nfs_lookup_is_soft_revalidate(dentry))
> >                 task_flags |= RPC_TASK_TIMEOUT;
> > @@ -6538,7 +6554,7 @@ static int _nfs4_proc_delegreturn(struct inode
> > *inode, const struct cred *cred,
> >                 .rpc_client = server->client,
> >                 .rpc_message = &msg,
> >                 .callback_ops = &nfs4_delegreturn_ops,
> > -               .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
> > +               .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT |
> > RPC_TASK_MOVEABLE,
> >         };
> >         int status = 0;
> >
> > @@ -6856,6 +6872,11 @@ static struct rpc_task *nfs4_do_unlck(struct
> > file_lock *fl,
> >                 .workqueue = nfsiod_workqueue,
> >                 .flags = RPC_TASK_ASYNC,
> >         };
> > +       struct nfs_client *client =
> > +               NFS_SERVER(lsp->ls_state->inode)->nfs_client;
> > +
> > +       if (client->cl_minorversion)
> > +               task_setup_data.flags |= RPC_TASK_MOVEABLE;
> >
> >         nfs4_state_protect(NFS_SERVER(lsp->ls_state->inode)-
> > >nfs_client,
> >                 NFS_SP4_MACH_CRED_CLEANUP,
> > &task_setup_data.rpc_client, &msg);
> > @@ -7130,6 +7151,10 @@ static int _nfs4_do_setlk(struct nfs4_state
> > *state, int cmd, struct file_lock *f
> >                 .flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
> >         };
> >         int ret;
> > +       struct nfs_client *client = NFS_SERVER(state->inode)-
> > >nfs_client;
> > +
> > +       if (client->cl_minorversion)
> > +               task_setup_data.flags |= RPC_TASK_MOVEABLE;
> >
> >         dprintk("%s: begin!\n", __func__);
> >         data = nfs4_alloc_lockdata(fl, nfs_file_open_context(fl-
> > >fl_file),
> > @@ -9186,7 +9211,7 @@ static struct rpc_task
> > *_nfs41_proc_sequence(struct nfs_client *clp,
> >                 .rpc_client = clp->cl_rpcclient,
> >                 .rpc_message = &msg,
> >                 .callback_ops = &nfs41_sequence_ops,
> > -               .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
> > +               .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT |
> > RPC_TASK_MOVEABLE,
> >         };
> >         struct rpc_task *ret;
> >
> > @@ -9509,7 +9534,8 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp,
> > long *timeout)
> >                 .rpc_message = &msg,
> >                 .callback_ops = &nfs4_layoutget_call_ops,
> >                 .callback_data = lgp,
> > -               .flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
> > +               .flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF |
> > +                        RPC_TASK_MOVEABLE,
> >         };
> >         struct pnfs_layout_segment *lseg = NULL;
> >         struct nfs4_exception exception = {
> > @@ -9650,6 +9676,7 @@ int nfs4_proc_layoutreturn(struct
> > nfs4_layoutreturn *lrp, bool sync)
> >                 .rpc_message = &msg,
> >                 .callback_ops = &nfs4_layoutreturn_call_ops,
> >                 .callback_data = lrp,
> > +               .flags = RPC_TASK_MOVEABLE,
> >         };
> >         int status = 0;
> >
> > @@ -9804,6 +9831,7 @@ nfs4_proc_layoutcommit(struct
> > nfs4_layoutcommit_data *data, bool sync)
> >                 .rpc_message = &msg,
> >                 .callback_ops = &nfs4_layoutcommit_ops,
> >                 .callback_data = data,
> > +               .flags = RPC_TASK_MOVEABLE,
> >         };
> >         struct rpc_task *task;
> >         int status = 0;
> > @@ -10131,7 +10159,7 @@ static int nfs41_free_stateid(struct
> > nfs_server *server,
> >                 .rpc_client = server->client,
> >                 .rpc_message = &msg,
> >                 .callback_ops = &nfs41_free_stateid_ops,
> > -               .flags = RPC_TASK_ASYNC,
> > +               .flags = RPC_TASK_ASYNC | RPC_TASK_MOVEABLE,
> >         };
> >         struct nfs_free_stateid_data *data;
> >         struct rpc_task *task;
> > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > index cf9cc62ec48e..cc232d1f16f2 100644
> > --- a/fs/nfs/pagelist.c
> > +++ b/fs/nfs/pagelist.c
> > @@ -954,6 +954,7 @@ static int nfs_generic_pg_pgios(struct
> > nfs_pageio_descriptor *desc)
> >  {
> >         struct nfs_pgio_header *hdr;
> >         int ret;
> > +       unsigned short task_flags = 0;
> >
> >         hdr = nfs_pgio_header_alloc(desc->pg_rw_ops);
> >         if (!hdr) {
> > @@ -962,14 +963,17 @@ static int nfs_generic_pg_pgios(struct
> > nfs_pageio_descriptor *desc)
> >         }
> >         nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
> >         ret = nfs_generic_pgio(desc, hdr);
> > -       if (ret == 0)
> > +       if (ret == 0) {
> > +               if (NFS_SERVER(hdr->inode)->nfs_client-
> > >cl_minorversion)
> > +                       task_flags = RPC_TASK_MOVEABLE;
> >                 ret = nfs_initiate_pgio(NFS_CLIENT(hdr->inode),
> >                                         hdr,
> >                                         hdr->cred,
> >                                         NFS_PROTO(hdr->inode),
> >                                         desc->pg_rpc_callops,
> >                                         desc->pg_ioflags,
> > -                                       RPC_TASK_CRED_NOREF);
> > +                                       RPC_TASK_CRED_NOREF |
> > task_flags);
> > +       }
> >         return ret;
> >  }
> >
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index 3bf82178166a..eae9bf114041 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -1810,6 +1810,7 @@ nfs_commit_list(struct inode *inode, struct
> > list_head *head, int how,
> >                 struct nfs_commit_info *cinfo)
> >  {
> >         struct nfs_commit_data  *data;
> > +       unsigned short task_flags = 0;
> >
> >         /* another commit raced with us */
> >         if (list_empty(head))
> > @@ -1820,8 +1821,11 @@ nfs_commit_list(struct inode *inode, struct
> > list_head *head, int how,
> >         /* Set up the argument struct */
> >         nfs_init_commit(data, head, NULL, cinfo);
> >         atomic_inc(&cinfo->mds->rpcs_out);
> > +       if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
> > +               task_flags = RPC_TASK_MOVEABLE;
> >         return nfs_initiate_commit(NFS_CLIENT(inode), data,
> > NFS_PROTO(inode),
> > -                                  data->mds_ops, how,
> > RPC_TASK_CRED_NOREF);
> > +                                  data->mds_ops, how,
> > +                                  RPC_TASK_CRED_NOREF | task_flags);
> >  }
> >
> >  /*
> > diff --git a/include/linux/sunrpc/sched.h
> > b/include/linux/sunrpc/sched.h
> > index df696efdd675..a237b8dbf608 100644
> > --- a/include/linux/sunrpc/sched.h
> > +++ b/include/linux/sunrpc/sched.h
> > @@ -121,6 +121,7 @@ struct rpc_task_setup {
> >   */
> >  #define RPC_TASK_ASYNC         0x0001          /* is an async task
> > */
> >  #define RPC_TASK_SWAPPER       0x0002          /* is swapping in/out
> > */
> > +#define RPC_TASK_MOVEABLE      0x0004          /* nfs4.1+ rpc tasks
> > */
> >  #define RPC_TASK_NULLCREDS     0x0010          /* Use AUTH_NULL
> > credential */
> >  #define RPC_CALL_MAJORSEEN     0x0020          /* major timeout seen
> > */
> >  #define RPC_TASK_ROOTCREDS     0x0040          /* force root creds
> > */
> > @@ -139,6 +140,7 @@ struct rpc_task_setup {
> >  #define RPC_IS_SOFT(t)         ((t)->tk_flags &
> > (RPC_TASK_SOFT|RPC_TASK_TIMEOUT))
> >  #define RPC_IS_SOFTCONN(t)     ((t)->tk_flags & RPC_TASK_SOFTCONN)
> >  #define RPC_WAS_SENT(t)                ((t)->tk_flags &
> > RPC_TASK_SENT)
> > +#define RPC_IS_MOVEABLE(t)     ((t)->tk_flags & RPC_TASK_MOVEABLE)
> >
> >  #define RPC_TASK_RUNNING       0
> >  #define RPC_TASK_QUEUED                1
> > --
> > 2.27.0
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
