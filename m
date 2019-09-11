Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643A4B04CA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2019 22:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfIKUOH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Sep 2019 16:14:07 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45163 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbfIKUOH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Sep 2019 16:14:07 -0400
Received: by mail-ua1-f68.google.com with SMTP id j6so7202783uae.12
        for <linux-nfs@vger.kernel.org>; Wed, 11 Sep 2019 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ik3oEMKN9d/v8YrJfvjpJShszJIcNsnRCl5hSbNkYmE=;
        b=jjwUCs+yPz5jqoDcawKvsGNAn4x3wLt5Qd5Mw5C2Fa68eE07ogCbEnARH1HGdDmI9Q
         YcBOjbamsPBhUC7MBqwXcG81mDdgEgAbFuHFNQ2Yt7YtiWPHBRBRDQE50wUbjY/5Ew5B
         xdeXu6UJTFTIvENmpqjHSiNeZTvR6n+5OSFlC+RVZjXjjnbIoqPlITIXhk7pdbbSTf2G
         vc1jV1BqKxNGZrw6SEOhwNV7KHjx3YZJ3fTOjiM0yHgCmNS3d5kMlhxY8VU78OjGThaQ
         eAlJrdz5Gb3HCtSv/4CrSPi+0z2N6xf6u59c5rrNteiWZmnO3ZREG0VwrxJzZphQutEv
         D7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ik3oEMKN9d/v8YrJfvjpJShszJIcNsnRCl5hSbNkYmE=;
        b=H2Tp1FQGouhIIeQSkkrQEzVXHnGbnJBT0Bdx1F4SBEro4d3vbrwNumd65JPgzUJSbs
         lSTFsu3rC7vQgtO82qPsTxtfCEbjwBriNJhiioORNhdHIioFaNnpFNO2TMCeUN5zKKBj
         ZR9kCyE3RPUyWexAPj8m6QLS7o6ns8HoN+s1Gbv2VDmw3c6YD2DjMgE8bfzAiBEn7zje
         Q9jPmHs8Di5rYAaDvqr0ShCzr6Pn/DzEY3uY7nOZ1BvTHexsFpQimyd9OXulm4oMEUjl
         0deMFKfUvHJY2kdPfdtfj3WpNFlaKoDvP3mJ29IkRHdWu8KmxrBTrX7sMoqGG4YNclxr
         ft1Q==
X-Gm-Message-State: APjAAAVdXygxVzwZ4YZItI9zpMCRyHvoY2HzZsboPaOt2lzu/tznItgS
        GyydSF1lUSc8IB4kcoVWcX6LDrwNiFkSkjnQxeM=
X-Google-Smtp-Source: APXvYqzuSIBOlqKZk1QDFR6TwJX7VcSJKP0k8QKaYt3vPSOpRuj48efK0WVG6u4Igi8oYk2tm5YeGIdhlUzrADTJUq0=
X-Received: by 2002:ab0:70c7:: with SMTP id r7mr2778000ual.40.1568232845869;
 Wed, 11 Sep 2019 13:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com> <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com> <20190909140104.78818-5-trond.myklebust@hammerspace.com>
 <20190909140104.78818-6-trond.myklebust@hammerspace.com> <20190909140104.78818-7-trond.myklebust@hammerspace.com>
 <20190909140104.78818-8-trond.myklebust@hammerspace.com>
In-Reply-To: <20190909140104.78818-8-trond.myklebust@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 11 Sep 2019 16:13:54 -0400
Message-ID: <CAN-5tyFLWbWR4_2bw_6WKiT71=WPCRZF=gk-vAQ+-tHDtFwrPg@mail.gmail.com>
Subject: Re: [PATCH 8/9] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

This patch is causing me "problem" (can be seen using generic/323).
This test creates 100 processes that each want to open the same file,
then close it. Each open gets a stateid with an increasing seqid (the
last received by the client is stateid seqid=100). With the patch,
upon close I see 1st CLOSE use stateid seqid=1 which ends up failing
with ERR_OLD_STATEID and retried until stateid seqid=100 (which was
the current id). Reverting the patch give back sending the CLOSE with
seqid=100. While nothing failing, I don't think the client's behavior
is correct.

On Tue, Sep 10, 2019 at 4:10 AM Trond Myklebust <trondmy@gmail.com> wrote:
>
> If a CLOSE or OPEN_DOWNGRADE operation receives a NFS4ERR_OLD_STATEID
> then bump the seqid before resending. Ensure we only bump the seqid
> by 1.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4_fs.h   |  2 --
>  fs/nfs/nfs4proc.c  | 41 ++++++++++++++++++++++++++++++++++++++---
>  fs/nfs/nfs4state.c | 16 ----------------
>  3 files changed, 38 insertions(+), 21 deletions(-)
>
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index e8f74ed98e42..16b2e5cc3e94 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -491,8 +491,6 @@ extern int nfs4_set_lock_state(struct nfs4_state *state, struct file_lock *fl);
>  extern int nfs4_select_rw_stateid(struct nfs4_state *, fmode_t,
>                 const struct nfs_lock_context *, nfs4_stateid *,
>                 const struct cred **);
> -extern bool nfs4_refresh_open_stateid(nfs4_stateid *dst,
> -               struct nfs4_state *state);
>  extern bool nfs4_copy_open_stateid(nfs4_stateid *dst,
>                 struct nfs4_state *state);
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 025dd5efbf34..49f301198008 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3308,6 +3308,42 @@ nfs4_wait_on_layoutreturn(struct inode *inode, struct rpc_task *task)
>         return pnfs_wait_on_layoutreturn(inode, task);
>  }
>
> +/*
> + * Update the seqid of an open stateid after receiving
> + * NFS4ERR_OLD_STATEID
> + */
> +static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
> +               struct nfs4_state *state)
> +{
> +       __be32 seqid_open;
> +       u32 dst_seqid;
> +       bool ret;
> +       int seq;
> +
> +       for (;;) {
> +               ret = false;
> +               seq = read_seqbegin(&state->seqlock);
> +               if (!nfs4_state_match_open_stateid_other(state, dst)) {
> +                       if (read_seqretry(&state->seqlock, seq))
> +                               continue;
> +                       break;
> +               }
> +               seqid_open = state->open_stateid.seqid;
> +               dst_seqid = be32_to_cpu(dst->seqid);
> +
> +               if (read_seqretry(&state->seqlock, seq))
> +                       continue;
> +               if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
> +                       dst->seqid = cpu_to_be32(dst_seqid + 1);
> +               else
> +                       dst->seqid = seqid_open;
> +               ret = true;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
>  struct nfs4_closedata {
>         struct inode *inode;
>         struct nfs4_state *state;
> @@ -3382,7 +3418,7 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
>                         break;
>                 case -NFS4ERR_OLD_STATEID:
>                         /* Did we race with OPEN? */
> -                       if (nfs4_refresh_open_stateid(&calldata->arg.stateid,
> +                       if (nfs4_refresh_open_old_stateid(&calldata->arg.stateid,
>                                                 state))
>                                 goto out_restart;
>                         goto out_release;
> @@ -3451,8 +3487,7 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
>         } else if (is_rdwr)
>                 calldata->arg.fmode |= FMODE_READ|FMODE_WRITE;
>
> -       if (!nfs4_valid_open_stateid(state) ||
> -           !nfs4_refresh_open_stateid(&calldata->arg.stateid, state))
> +       if (!nfs4_valid_open_stateid(state))
>                 call_close = 0;
>         spin_unlock(&state->owner->so_lock);
>
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index cad4e064b328..e23945174da4 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1015,22 +1015,6 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
>         return ret;
>  }
>
> -bool nfs4_refresh_open_stateid(nfs4_stateid *dst, struct nfs4_state *state)
> -{
> -       bool ret;
> -       int seq;
> -
> -       do {
> -               ret = false;
> -               seq = read_seqbegin(&state->seqlock);
> -               if (nfs4_state_match_open_stateid_other(state, dst)) {
> -                       dst->seqid = state->open_stateid.seqid;
> -                       ret = true;
> -               }
> -       } while (read_seqretry(&state->seqlock, seq));
> -       return ret;
> -}
> -
>  bool nfs4_copy_open_stateid(nfs4_stateid *dst, struct nfs4_state *state)
>  {
>         bool ret;
> --
> 2.21.0
>
