Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF1B11BF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 17:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbfILPE1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 11:04:27 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39102 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732592AbfILPE1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Sep 2019 11:04:27 -0400
Received: by mail-vs1-f67.google.com with SMTP id y62so16398803vsb.6
        for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2019 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0wU3L4BRgc295JrNWuz0eQvJGYDEdmc42fTLzxjcCY=;
        b=jPlrU1PhItn8ZROI3Cx6/dQgs35JkS/PSdtNT0tlZWKNeGStFin8VXOL2jClIEBtOh
         1phl4X9sJX4bWZzkPzzOtPvZQ/ihr8u9VkvCU0stvxPybrpr/ynEtmEiINvjaqfP7HON
         Dkle0n7pDTcv4yZQrjLtlOKkIQcAZH1ICnVoEgPTJujg3crEohbJd5wNIJTil0EWr2nb
         AoLnBCzhUMx0zzlpXZRJPgBqKH4rMtPgI1MP/eK9r2z2hJU2bvz19oeXcGuOTjS1VRl5
         2JfzZAt4C+p/MeBG6n6By0jPGIb+Xz13cJSU9Nq49tEw707QDArtOrhXyoAwG1y5fHuY
         FmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0wU3L4BRgc295JrNWuz0eQvJGYDEdmc42fTLzxjcCY=;
        b=VTsdmY6svunvmdWxeGf2lTkdXkck5SI1Z8VX/JZtQfKA9/AA811YgIw9++44F67TPt
         T30Vs6NJWEN/ttGzIczXVSpKi/JTY1qD00kZ9LQOo9llP9GBpNFfcidL3S4ovhUnmOBP
         6xtLfjH73r5d9gBkzzd7efMWDMFTpOyVI8ZApTW0xVRWz4I3IwjwJUixbRUjRtVwKSZt
         dBAfr2KfApA4WMiPXhdBaYB+gF7Hd2/LJaW3vWTeaepjkqmVI56F2c3AYD8KOmj+4Asm
         Wo5f113lXa5kQR1700UAIqvergAzJ2BOyRWrCb2Yey8lSMl+EyeRA1P8LPTMBsqkt48n
         Q43Q==
X-Gm-Message-State: APjAAAXQfU+kVaM6+/cTmK9C/ZzU0BhjQFm1HnfYvDXLEg+ExyfdyvXM
        dXegUwXuZFp+WJfY1vNbl0v/6LhE4ysy6Zf6dSU=
X-Google-Smtp-Source: APXvYqylEWB7BGzlYH4P6CYoCvO6iRsJw7SWK1/KENlXMIq0YN9KIQscglfKIqiZv2+8wQkSdckDqa5em9jKkFQZT4o=
X-Received: by 2002:a67:f418:: with SMTP id p24mr22838112vsn.215.1568300665764;
 Thu, 12 Sep 2019 08:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com> <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com> <20190909140104.78818-5-trond.myklebust@hammerspace.com>
 <20190909140104.78818-6-trond.myklebust@hammerspace.com> <20190909140104.78818-7-trond.myklebust@hammerspace.com>
 <20190909140104.78818-8-trond.myklebust@hammerspace.com> <CAN-5tyFLWbWR4_2bw_6WKiT71=WPCRZF=gk-vAQ+-tHDtFwrPg@mail.gmail.com>
 <d4224806db02d9e0597177c467a7ea942c99dba7.camel@hammerspace.com> <CAN-5tyEHirLkH=snFQGLkOTWtpCNYowS9Zpf_nejoS8+dt+wwg@mail.gmail.com>
In-Reply-To: <CAN-5tyEHirLkH=snFQGLkOTWtpCNYowS9Zpf_nejoS8+dt+wwg@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 12 Sep 2019 11:04:14 -0400
Message-ID: <CAN-5tyH_NayArVHcyhr4A994kagxftd8SQXdBbP32e_7W-kE7A@mail.gmail.com>
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

Is the same fix needed for the unlock case? I don't have a good test
case for the unlock.

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
