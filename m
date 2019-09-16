Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD187B4135
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 21:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfIPTh7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 15:37:59 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37106 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTh7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 15:37:59 -0400
Received: by mail-vk1-f194.google.com with SMTP id v78so207117vke.4
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQY5DuhZCx0TpkptBCZ+Ky14hADgXgeD6CGa6QU6kQc=;
        b=SgcCBDsgMmKgnJuTuBTtCZyu2qF75NSqBuh+plkwNS0QPi/Q4ut1m3e4n1DxBHwZCn
         LKfNT225DxXTSxkQ7jTGA1HQ2MVKxp2O1YBVslPjKU2GB3/rmFF0rhi0zzviHI9ZovOZ
         qTodwW7FLax2pdvCxsgd+8JpdmpR/VlT+zlTSWXty1Jw7LTZ4yltIIrTd6O31QhJYnIV
         hmzikyBIY+FJVAPMSOIGNv39RlS96HLEQapTTGl35rKoBhHCRn5K6i6U4OwU0A9xdrQK
         DTwEQ23g6rgirplZpFnzcElcRniRkiCcD6gMmCPjtpHtvdkLwO7sYmBdoDLyW7i7C4YF
         mMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQY5DuhZCx0TpkptBCZ+Ky14hADgXgeD6CGa6QU6kQc=;
        b=scCOIq+YaZh7Y+R5bePEEoHl9C4issEQSQzmT9mAC7ltygAYbh86Lh1MJlRzsC/5R5
         7C7kplpNgqU1sK+smjDhucEO9cdjNv91FTTVhg3RiZSafcjRrOl3iOl2Nj6gyv54hbsm
         q+u6DA/qygqzZoz0SV7BvqcYO1kKzcyYELNOEwbdHeaf6ajrZvz6jcBOWw9YWpJ6vH7i
         XB9pKCG1EmwGwF3mB0j4MuTTbDMVZBNcZAW4PNi55YAh6SOxq8r1XUho4tra+hlllr5f
         qaVjyLECTv/J4Nkl+y4UzJwaMkEJEsLfDOV1cMnynQ6b4WtuZkwmQD4nBz+PN1KUmh7G
         +Zgg==
X-Gm-Message-State: APjAAAU7UX+puF+R1vIFgh06uDo8iu+Nj/pdnU38yrimvz4MFvqtBOsH
        WheKk+5qiBMUIQ94t1+9EvhmlvE1ARzz5c/q4HQ=
X-Google-Smtp-Source: APXvYqzguemS51zRHkcq4j9nJIcCak3FjoxaE8iNnovKaYNuHQtnIwtE/H/zINKbQqVGlrxv3NeYktV7LnlS1xDAABw=
X-Received: by 2002:a1f:a4b:: with SMTP id 72mr7963vkk.83.1568662678489; Mon,
 16 Sep 2019 12:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com> <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com> <20190909140104.78818-5-trond.myklebust@hammerspace.com>
 <20190909140104.78818-6-trond.myklebust@hammerspace.com> <20190909140104.78818-7-trond.myklebust@hammerspace.com>
 <20190909140104.78818-8-trond.myklebust@hammerspace.com> <20190909140104.78818-9-trond.myklebust@hammerspace.com>
In-Reply-To: <20190909140104.78818-9-trond.myklebust@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 16 Sep 2019 15:37:47 -0400
Message-ID: <CAN-5tyGe3V-dAsrNwAVcqKA6dE747ry7C3bb72hGaFgUAGuCzQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I have a problem with this patch.

It sends an unlock with stateid of all zeros (gets a BAD_STATEID) and
then sends an unlock with a normal stateid. This can be seen running
nfstest_locking --nfsversion 4.1.

On Tue, Sep 10, 2019 at 4:09 AM Trond Myklebust <trondmy@gmail.com> wrote:
>
> If a LOCKU request receives a NFS4ERR_OLD_STATEID, then bump the
> seqid before resending. Ensure we only bump the seqid by 1.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4proc.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 49f301198008..ecfaf4b1ba5d 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -6377,6 +6377,42 @@ static int nfs4_proc_getlk(struct nfs4_state *state, int cmd, struct file_lock *
>         return err;
>  }
>
> +/*
> + * Update the seqid of a lock stateid after receiving
> + * NFS4ERR_OLD_STATEID
> + */
> +static bool nfs4_refresh_lock_old_stateid(nfs4_stateid *dst,
> +               struct nfs4_lock_state *lsp)
> +{
> +       struct nfs4_state *state = lsp->ls_state;
> +       bool ret = false;
> +
> +       spin_lock(&state->state_lock);
> +       if (!nfs4_stateid_match_other(dst, &lsp->ls_stateid))
> +               goto out;
> +       if (!nfs4_stateid_is_newer(&lsp->ls_stateid, dst))
> +               nfs4_stateid_seqid_inc(dst);
> +       else
> +               dst->seqid = lsp->ls_stateid.seqid;
> +       ret = true;
> +out:
> +       spin_unlock(&state->state_lock);
> +       return ret;
> +}
> +
> +static bool nfs4_sync_lock_stateid(nfs4_stateid *dst,
> +               struct nfs4_lock_state *lsp)
> +{
> +       struct nfs4_state *state = lsp->ls_state;
> +       bool ret;
> +
> +       spin_lock(&state->state_lock);
> +       ret = !nfs4_stateid_match_other(dst, &lsp->ls_stateid);
> +       nfs4_stateid_copy(dst, &lsp->ls_stateid);
> +       spin_unlock(&state->state_lock);
> +       return ret;
> +}
> +
>  struct nfs4_unlockdata {
>         struct nfs_locku_args arg;
>         struct nfs_locku_res res;
> @@ -6448,10 +6484,14 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
>                                         task->tk_msg.rpc_cred);
>                         /* Fall through */
>                 case -NFS4ERR_BAD_STATEID:
> -               case -NFS4ERR_OLD_STATEID:
>                 case -NFS4ERR_STALE_STATEID:
> -                       if (!nfs4_stateid_match(&calldata->arg.stateid,
> -                                               &calldata->lsp->ls_stateid))
> +                       if (nfs4_sync_lock_stateid(&calldata->arg.stateid,
> +                                               calldata->lsp))
> +                               rpc_restart_call_prepare(task);
> +                       break;
> +               case -NFS4ERR_OLD_STATEID:
> +                       if (nfs4_refresh_lock_old_stateid(&calldata->arg.stateid,
> +                                               calldata->lsp))
>                                 rpc_restart_call_prepare(task);
>                         break;
>                 default:
> @@ -6474,7 +6514,6 @@ static void nfs4_locku_prepare(struct rpc_task *task, void *data)
>
>         if (nfs_wait_on_sequence(calldata->arg.seqid, task) != 0)
>                 goto out_wait;
> -       nfs4_stateid_copy(&calldata->arg.stateid, &calldata->lsp->ls_stateid);
>         if (test_bit(NFS_LOCK_INITIALIZED, &calldata->lsp->ls_flags) == 0) {
>                 /* Note: exit _without_ running nfs4_locku_done */
>                 goto out_no_action;
> --
> 2.21.0
>
