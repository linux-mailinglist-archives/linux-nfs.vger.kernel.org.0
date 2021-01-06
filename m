Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5F2EC05D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jan 2021 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbhAFP0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jan 2021 10:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFP0A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jan 2021 10:26:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90EC06134C
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jan 2021 07:25:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cm17so4753784edb.4
        for <linux-nfs@vger.kernel.org>; Wed, 06 Jan 2021 07:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WTqEg4GfcICmaTDYTutlZP6vKlRBYFxlVYKdexV8Lk=;
        b=TIESOBI/e5FIUfjmxHTM7kdO6VsRLYgrnosOGqjnvnxRdkZu6ih5woysI0vPACmkay
         ATlo0MzDyjXTELWX2yLhu80Dmo35XTA5VbAdV19xST3R+UWW8SmnWR7ZDyWPgeFYovYy
         Y2Vdqi02XDVMgV50490Y5ymLfyRxHsTLv59zP4/FtU1Gn0sTS3EEI47V2sixElnRH69x
         dIvte8/iqpYPmqk2+CW+kHzfiPD23iShdakOYsmLnNI1QJWFJRNTn5SimHI+NsmxSQ0g
         UuIj3HNPsnhzkprXpUU+5neOYagudC4pDoJokH1VR2/qovpnhgglT37PD5+EWHmKlMLb
         9jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WTqEg4GfcICmaTDYTutlZP6vKlRBYFxlVYKdexV8Lk=;
        b=E4MHMk5Q5jnwHH8Gkjsnv4kfEncJJdWEMGiUpx7BUxdScGMXwEtMsGBa3HzQVrRx9z
         3+n64oWXJ85itXWOQ+xax0dDqmd/jsNguMXur3Y5AqTI1zFZerrCTRjrq6S7jqqgxPyb
         Wbqlo3chi2uYVqGrs/8p//ak/CTZEIUu42zK4hDKjehUgKHmQ67xbzeAKGg9nzkc8X7C
         aYRsqRaB1vH6kDPGxJikWJKdmPwYuXYgzvyz8qMc4/raimIYV+N3R1qf/kLQCpiRyffI
         Myt/vgB7RcPiv/03HlJMhHqeF9VtZwMJKjq0pSWonp+6PGK/Q1d2v6lcBgTOJlGiRjFQ
         ELsA==
X-Gm-Message-State: AOAM5329IWTOFNcGaZ0QaoTNQ9NHIKYh1pp7ZWPUkDK6c0qlHXTxFM1J
        89VOF16MhN/Ix0i5X+7IO+HmrkXjpdvGaEsTGtM=
X-Google-Smtp-Source: ABdhPJyxp9tYnpC1MpOg7ufABQ5SMkK7VKRGaBL5OEcnkBiIPE2m/XW7yh7NJ/AEq/op/Q7n+8vrU4uTV//FeXsY9BM=
X-Received: by 2002:a50:fc13:: with SMTP id i19mr4422326edr.281.1609946718741;
 Wed, 06 Jan 2021 07:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20210105152620.754453-1-trondmy@kernel.org> <20210105152620.754453-2-trondmy@kernel.org>
In-Reply-To: <20210105152620.754453-2-trondmy@kernel.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 6 Jan 2021 10:25:01 -0500
Message-ID: <CAFX2Jfmqs2oEN3KtjfSViyhFqdt=v9ty3oGz4HiqpWw=xNVh9A@mail.gmail.com>
Subject: Re: [PATCH 2/4] pNFS: We want return-on-close to complete when
 evicting the inode
To:     trondmy@kernel.org
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Tue, Jan 5, 2021 at 10:30 AM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If the inode is being evicted, it should be safe to run return-on-close,
> so we should do it to ensure we don't inadvertently leak layout segments.
>
> Fixes: 1c5bd76d17cc ("pNFS: Enable layoutreturn operation for return-on-close")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4proc.c | 26 ++++++++++----------------
>  fs/nfs/pnfs.c     |  8 +++-----
>  fs/nfs/pnfs.h     |  6 ++----
>  3 files changed, 15 insertions(+), 25 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 0ce04e0e5d82..bbca5c46e400 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3536,10 +3536,8 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
>         trace_nfs4_close(state, &calldata->arg, &calldata->res, task->tk_status);
>
>         /* Handle Layoutreturn errors */
> -       if (pnfs_roc_done(task, calldata->inode,
> -                               &calldata->arg.lr_args,
> -                               &calldata->res.lr_res,
> -                               &calldata->res.lr_ret) == -EAGAIN)
> +       if (pnfs_roc_done(task, &calldata->arg.lr_args, &calldata->res.lr_res,
> +                         &calldata->res.lr_ret) == -EAGAIN)
>                 goto out_restart;
>
>         /* hmm. we are done with the inode, and in the process of freeing
> @@ -6384,10 +6382,8 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
>         trace_nfs4_delegreturn_exit(&data->args, &data->res, task->tk_status);
>
>         /* Handle Layoutreturn errors */
> -       if (pnfs_roc_done(task, data->inode,
> -                               &data->args.lr_args,
> -                               &data->res.lr_res,
> -                               &data->res.lr_ret) == -EAGAIN)
> +       if (pnfs_roc_done(task, &data->args.lr_args, &data->res.lr_res,
> +                         &data->res.lr_ret) == -EAGAIN)
>                 goto out_restart;
>
>         switch (task->tk_status) {
> @@ -6441,10 +6437,10 @@ static void nfs4_delegreturn_release(void *calldata)
>         struct nfs4_delegreturndata *data = calldata;
>         struct inode *inode = data->inode;
>
> +       if (data->lr.roc)
> +               pnfs_roc_release(&data->lr.arg, &data->lr.res,
> +                                data->res.lr_ret);
>         if (inode) {
> -               if (data->lr.roc)
> -                       pnfs_roc_release(&data->lr.arg, &data->lr.res,
> -                                       data->res.lr_ret);
>                 nfs_post_op_update_inode_force_wcc(inode, &data->fattr);
>                 nfs_iput_and_deactive(inode);
>         }
> @@ -6520,16 +6516,14 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
>         nfs_fattr_init(data->res.fattr);
>         data->timestamp = jiffies;
>         data->rpc_status = 0;
> -       data->lr.roc = pnfs_roc(inode, &data->lr.arg, &data->lr.res, cred);
>         data->inode = nfs_igrab_and_active(inode);
> -       if (data->inode) {
> +       if (data->inode || issync) {
> +               data->lr.roc = pnfs_roc(inode, &data->lr.arg, &data->lr.res,
> +                                       cred);
>                 if (data->lr.roc) {
>                         data->args.lr_args = &data->lr.arg;
>                         data->res.lr_res = &data->lr.res;
>                 }
> -       } else if (data->lr.roc) {
> -               pnfs_roc_release(&data->lr.arg, &data->lr.res, 0);
> -               data->lr.roc = false;
>         }
>
>         task_setup_data.callback_data = data;
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index ccc89fab1802..a18b1992b2fb 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -1509,10 +1509,8 @@ bool pnfs_roc(struct inode *ino,
>         return false;
>  }
>
> -int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
> -               struct nfs4_layoutreturn_args **argpp,
> -               struct nfs4_layoutreturn_res **respp,
> -               int *ret)
> +int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
> +                 struct nfs4_layoutreturn_res **respp, int *ret)
>  {
>         struct nfs4_layoutreturn_args *arg = *argpp;
>         int retval = -EAGAIN;
> @@ -1545,7 +1543,7 @@ int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
>                 return 0;
>         case -NFS4ERR_OLD_STATEID:
>                 if (!nfs4_layout_refresh_old_stateid(&arg->stateid,
> -                                       &arg->range, inode))
> +                                                    &arg->range, arg->inode))
>                         break;
>                 *ret = -NFS4ERR_NOMATCHING_LAYOUT;
>                 return -EAGAIN;
> diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
> index bbd3de1025f2..4d5ee568411d 100644
> --- a/fs/nfs/pnfs.h
> +++ b/fs/nfs/pnfs.h
> @@ -297,10 +297,8 @@ bool pnfs_roc(struct inode *ino,
>                 struct nfs4_layoutreturn_args *args,
>                 struct nfs4_layoutreturn_res *res,
>                 const struct cred *cred);
> -int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
> -               struct nfs4_layoutreturn_args **argpp,
> -               struct nfs4_layoutreturn_res **respp,
> -               int *ret);
> +int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
> +                 struct nfs4_layoutreturn_res **respp, int *ret);

I think you also need to make this change to the fallback definition
(for CONFIG_NFS_V4=n)

Thanks,
Anna

>  void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
>                 struct nfs4_layoutreturn_res *res,
>                 int ret);
> --
> 2.29.2
>
