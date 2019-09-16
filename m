Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 149A2B413A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 21:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfIPTjq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 15:39:46 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44121 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfIPTjp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 15:39:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id w195so428135vsw.11
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyOUSCufwTaspB1PmfJW3BDR0/aVsk0DFAQytNn4zOI=;
        b=SR/wzFLldAUS6QSpvhZqsDvtKvOCnZzfhWvUKL5oeOjLoMTJ4H9DeghdWVPrUQZalk
         U2cbBiW+UEqK3Mhq0gm6gIXnfGLuSwB1bnl24Qw601WW2FZZ4bcbo7nL8dUvptMYrW6l
         xt4Q0KCIwT36XJHeaHCfw/Zcz2Z2q6c1dmziUFIlIQ4DfD5mgO3edaPvQttGYAGeLB+m
         LtFmiCPczlSMl74i/r1aaUUef+BEbpTCQs0UkRaaJEBcqM7H6u8u9S+xSxZ0MGJ0gIpI
         S04juNhg/7BDWwMQFmO0JWesc2kZEgi5KjN8eP56yqHFol/stCYi5Euozxnd73GN+het
         JcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyOUSCufwTaspB1PmfJW3BDR0/aVsk0DFAQytNn4zOI=;
        b=FpBvmCb3JvTHgmab/4AplsdQZCG5ozf9IZblhfwS2/tiIpAMJJhykRf/nihhvqnnX3
         j5KCMaAwFoKh4LruuJ42qWTDz3+V3K2UQ6l/h0LGDQo5VtcFHYU8TdH72d8kHsOUCtw+
         ehsdTfgMg29vLqGVECvVCL0LQfqzNGX9cYPzoVt5Iz5ibPOwAAYdFzo7Tglbs17Qcvod
         t0CUq7qxU8jzCdrv5jxplZKCQiAt23zjuZDQ10jZkp/YAjYmYhvYrb7G4L1cUyU0c7E2
         CX9MEM9krU915YXHGztbHYvXx+1Bpyp7xbO5DMvCwLKBvq5cWmWYYxkOvGRC8AludP2y
         q5ag==
X-Gm-Message-State: APjAAAWGDOcE7kf4r0iEDtcJigqrEBxU44qiV6slcdD8F9NML/YdMVFb
        46vlh29DJIeR2ZxnS2a8DAm1feQhmsgELX54Tmk=
X-Google-Smtp-Source: APXvYqz4IV9LAadUD5BXArf9yzgCynYNqewPOoV+6OekzP46prQqsVFQ+KRV1BhrL9jFzNB69e2N0rpRF3A5FbAwJIU=
X-Received: by 2002:a67:db09:: with SMTP id z9mr914184vsj.134.1568662784407;
 Mon, 16 Sep 2019 12:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com> <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com> <20190909140104.78818-5-trond.myklebust@hammerspace.com>
 <20190909140104.78818-6-trond.myklebust@hammerspace.com> <20190909140104.78818-7-trond.myklebust@hammerspace.com>
 <20190909140104.78818-8-trond.myklebust@hammerspace.com> <CAN-5tyFLWbWR4_2bw_6WKiT71=WPCRZF=gk-vAQ+-tHDtFwrPg@mail.gmail.com>
 <d4224806db02d9e0597177c467a7ea942c99dba7.camel@hammerspace.com> <CAN-5tyEHirLkH=snFQGLkOTWtpCNYowS9Zpf_nejoS8+dt+wwg@mail.gmail.com>
In-Reply-To: <CAN-5tyEHirLkH=snFQGLkOTWtpCNYowS9Zpf_nejoS8+dt+wwg@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 16 Sep 2019 15:39:33 -0400
Message-ID: <CAN-5tyGXHXU_XvRYuOHKzgbnL6t8Js_wAJ-K_KRzDip7n8jXNQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 12, 2019 at 11:01 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Wed, Sep 11, 2019 at 4:56 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > Hi Olga
> >
> > On Wed, 2019-09-11 at 16:13 -0400, Olga Kornievskaia wrote:
> > > Hi Trond,
> > >
> > > This patch is causing me "problem" (can be seen using generic/323).
> > > This test creates 100 processes that each want to open the same file,
> > > then close it. Each open gets a stateid with an increasing seqid (the
> > > last received by the client is stateid seqid=100). With the patch,
> > > upon close I see 1st CLOSE use stateid seqid=1 which ends up failing
> > > with ERR_OLD_STATEID and retried until stateid seqid=100 (which was
> > > the current id). Reverting the patch give back sending the CLOSE with
> > > seqid=100. While nothing failing, I don't think the client's behavior
> > > is correct.
> >
> > Does the following work for you?
>
> Yes that fixes the stateid usage.

Hi Trond,

Will you be posting the v2 of the patches?

I'm slowly going thru the tests. I have questioned the LAYOUTGET patch
but I haven't figured out a test for it yet. In general, is it
possible to wait on this patch series as I already found 2 issues with
it and need a bit more testing to complete my testing. I don't feel
like patches are ready the way they are.

Thanks.


>
> >
> > Cheers
> >   Trond
> >
> > 8<---------------------------------------------
> > From 859f6c0f468785770c6e87ae4f62294415018e89 Mon Sep 17 00:00:00 2001
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Date: Tue, 3 Sep 2019 17:37:19 -0400
> > Subject: [PATCH v2] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
> >
> > If a CLOSE or OPEN_DOWNGRADE operation receives a NFS4ERR_OLD_STATEID
> > then bump the seqid before resending. Ensure we only bump the seqid
> > by 1.
> >
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  fs/nfs/nfs4_fs.h   |  2 --
> >  fs/nfs/nfs4proc.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/nfs/nfs4state.c | 16 ----------
> >  3 files changed, 72 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> > index e8f74ed98e42..16b2e5cc3e94 100644
> > --- a/fs/nfs/nfs4_fs.h
> > +++ b/fs/nfs/nfs4_fs.h
> > @@ -491,8 +491,6 @@ extern int nfs4_set_lock_state(struct nfs4_state *state, struct file_lock *fl);
> >  extern int nfs4_select_rw_stateid(struct nfs4_state *, fmode_t,
> >                 const struct nfs_lock_context *, nfs4_stateid *,
> >                 const struct cred **);
> > -extern bool nfs4_refresh_open_stateid(nfs4_stateid *dst,
> > -               struct nfs4_state *state);
> >  extern bool nfs4_copy_open_stateid(nfs4_stateid *dst,
> >                 struct nfs4_state *state);
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 025dd5efbf34..c14af2c1c6b6 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3308,6 +3308,75 @@ nfs4_wait_on_layoutreturn(struct inode *inode, struct rpc_task *task)
> >         return pnfs_wait_on_layoutreturn(inode, task);
> >  }
> >
> > +/*
> > + * Update the seqid of an open stateid
> > + */
> > +static void nfs4_sync_open_stateid(nfs4_stateid *dst,
> > +               struct nfs4_state *state)
> > +{
> > +       __be32 seqid_open;
> > +       u32 dst_seqid;
> > +       int seq;
> > +
> > +       for (;;) {
> > +               if (!nfs4_valid_open_stateid(state))
> > +                       break;
> > +               seq = read_seqbegin(&state->seqlock);
> > +               if (!nfs4_state_match_open_stateid_other(state, dst)) {
> > +                       nfs4_stateid_copy(dst, &state->open_stateid);
> > +                       if (read_seqretry(&state->seqlock, seq))
> > +                               continue;
> > +                       break;
> > +               }
> > +               seqid_open = state->open_stateid.seqid;
> > +               if (read_seqretry(&state->seqlock, seq))
> > +                       continue;
> > +
> > +               dst_seqid = be32_to_cpu(dst->seqid);
> > +               if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) < 0)
> > +                       dst->seqid = seqid_open;
> > +               break;
> > +       }
> > +}
> > +
> > +/*
> > + * Update the seqid of an open stateid after receiving
> > + * NFS4ERR_OLD_STATEID
> > + */
> > +static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
> > +               struct nfs4_state *state)
> > +{
> > +       __be32 seqid_open;
> > +       u32 dst_seqid;
> > +       bool ret;
> > +       int seq;
> > +
> > +       for (;;) {
> > +               ret = false;
> > +               if (!nfs4_valid_open_stateid(state))
> > +                       break;
> > +               seq = read_seqbegin(&state->seqlock);
> > +               if (!nfs4_state_match_open_stateid_other(state, dst)) {
> > +                       if (read_seqretry(&state->seqlock, seq))
> > +                               continue;
> > +                       break;
> > +               }
> > +               seqid_open = state->open_stateid.seqid;
> > +               if (read_seqretry(&state->seqlock, seq))
> > +                       continue;
> > +
> > +               dst_seqid = be32_to_cpu(dst->seqid);
> > +               if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
> > +                       dst->seqid = cpu_to_be32(dst_seqid + 1);
> > +               else
> > +                       dst->seqid = seqid_open;
> > +               ret = true;
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  struct nfs4_closedata {
> >         struct inode *inode;
> >         struct nfs4_state *state;
> > @@ -3382,7 +3451,7 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
> >                         break;
> >                 case -NFS4ERR_OLD_STATEID:
> >                         /* Did we race with OPEN? */
> > -                       if (nfs4_refresh_open_stateid(&calldata->arg.stateid,
> > +                       if (nfs4_refresh_open_old_stateid(&calldata->arg.stateid,
> >                                                 state))
> >                                 goto out_restart;
> >                         goto out_release;
> > @@ -3451,8 +3520,8 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
> >         } else if (is_rdwr)
> >                 calldata->arg.fmode |= FMODE_READ|FMODE_WRITE;
> >
> > -       if (!nfs4_valid_open_stateid(state) ||
> > -           !nfs4_refresh_open_stateid(&calldata->arg.stateid, state))
> > +       nfs4_sync_open_stateid(&calldata->arg.stateid, state);
> > +       if (!nfs4_valid_open_stateid(state))
> >                 call_close = 0;
> >         spin_unlock(&state->owner->so_lock);
> >
> > diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> > index cad4e064b328..e23945174da4 100644
> > --- a/fs/nfs/nfs4state.c
> > +++ b/fs/nfs/nfs4state.c
> > @@ -1015,22 +1015,6 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
> >         return ret;
> >  }
> >
> > -bool nfs4_refresh_open_stateid(nfs4_stateid *dst, struct nfs4_state *state)
> > -{
> > -       bool ret;
> > -       int seq;
> > -
> > -       do {
> > -               ret = false;
> > -               seq = read_seqbegin(&state->seqlock);
> > -               if (nfs4_state_match_open_stateid_other(state, dst)) {
> > -                       dst->seqid = state->open_stateid.seqid;
> > -                       ret = true;
> > -               }
> > -       } while (read_seqretry(&state->seqlock, seq));
> > -       return ret;
> > -}
> > -
> >  bool nfs4_copy_open_stateid(nfs4_stateid *dst, struct nfs4_state *state)
> >  {
> >         bool ret;
> > --
> > 2.21.0
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
