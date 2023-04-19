Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A46E73D7
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 09:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDSHSb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 03:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjDSHS3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 03:18:29 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC0593C2
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 00:18:11 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id b10so3230366ybk.9
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 00:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1681888690; x=1684480690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+FaMupUOtZXVRvIYAidVKZ4twQNYjfgdR23Ua0bUiJ0=;
        b=KVfpy2S4mkCqQtMG1jmfBuRBogqjuMtLsB14DifrJrwBzDtRsnbHdatJY107IcP1n7
         Korb0wMeiBpbZfZjeWHzSstBZEOfHkS4Y8ikEjAYDoPhk1Hv3Q2TKpYWpns2+ZabzHnG
         Xe2lwiMO6ej1m18jTOTfGT6Yzq30YMU2LX9bi4I0fj4/3r9Z+ZasuYvT6VgvkA6jjm5t
         +qMsGFrCpmai9sVrvFJWzxXfClPitd5lhbdgGo+olT8B0Bi2tHpLbMK+XtwPK6+WtIJg
         pGRRaoHy7N3XWpyPKSv/61wARHmPGFbSgnIGjxXrXNLpp0CbK4jUu/UzUPk2Kop4rQwJ
         2/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681888690; x=1684480690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FaMupUOtZXVRvIYAidVKZ4twQNYjfgdR23Ua0bUiJ0=;
        b=INhOm54WF4nv2zquoB125LgGDzi+klExrvhA9FDq12WcO1O9RI0TRlGyPo2N+QMmAD
         2e+6QrS0gLCIgLXchcdVw+p3lMr67GL4ZiV6sRXvv/KmzYSdtiJl4erYFxav721GSprx
         tbLcv46gJcjq3hoQRAhCu1UCdlzFzOOJt40ORd0OounpGXKuZDJ43qkItqxPU8WRY9VP
         Gbe0OeO+W6g5+szGmh5AU6Jn01b5OjfJ7JlliZDQPSF3XthMT55ExiW68+fPn96LSvfl
         +tU1t6JD0WqDYFuIwu8RRCFoq5QoXEBV0zocKGi8GLtYX7Vu2/mEPGt4G9G/mx4RznNY
         OYEA==
X-Gm-Message-State: AAQBX9dx5hhlagzgmlWgGqr4hbjc+ip76GmspTa5qEgXAP+nTFSarReh
        y3iD4Ajzb3KaLXwA2rPbvJao8qwtQhzg0G5Y1Bg3Gw==
X-Google-Smtp-Source: AKy350bMJoTdh5eOXV/7UpTp2rMOgWZVxTHtVIrifzZ987IpHuosbz0IMYULRlRuLOTEbKUJleub4fuueAvkL5YpkXA=
X-Received: by 2002:a25:588b:0:b0:b8f:3b82:bf9c with SMTP id
 m133-20020a25588b000000b00b8f3b82bf9cmr20330471ybb.41.1681888689816; Wed, 19
 Apr 2023 00:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230411030248.53356-1-chengen.du@canonical.com>
In-Reply-To: <20230411030248.53356-1-chengen.du@canonical.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Wed, 19 Apr 2023 08:17:32 +0100
Message-ID: <CAPt2mGNqqDeRMeCSVh6oX_=nS0UcGCfhBfVcuaVG9HpdwVSzVg@mail.gmail.com>
Subject: Re: [PATCH] NFS: Add mount option 'nofasc'
To:     Chengen Du <chengen.du@canonical.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just to say, I am personally for this or some other way to opt out of
the increased ACCESS calls on select servers (e.g. ones with high
latency or with lots of multi user logins).

I see it as similar to "actimeo" and "nocto" options in allowing users
to reduce "correctness" at their own risk if it helps with their
workloads and they deem the risk worth it.

I am currently reverting the original patches in our kernel for our
nfs re-exporting workloads.

Daire


On Tue, 11 Apr 2023 at 04:03, Chengen Du <chengen.du@canonical.com> wrote:
>
> This mount option is used to skip clearing the file access cache
> upon login. Some users or applications switch to other privileged
> users via commands such as 'su' to operate on NFS-mounted folders.
> In such cases, the privileged user's login time will be renewed,
> and NFS ACCESS operations will need to be re-sent, potentially
> leading to performance degradation.
> In some production environments where the access cache can be
> trusted due to stable group membership, this option could be
> particularly useful.
>
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  fs/nfs/dir.c              | 21 ++++++++++++---------
>  fs/nfs/fs_context.c       |  8 ++++++++
>  fs/nfs/super.c            |  1 +
>  include/linux/nfs_fs_sb.h |  1 +
>  4 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 6fbcbb8d6587..9a6d86e2044e 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2953,12 +2953,14 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
>         return NULL;
>  }
>
> -static u64 nfs_access_login_time(const struct task_struct *task,
> -                                const struct cred *cred)
> +static inline
> +bool nfs_check_access_stale(const struct task_struct *task,
> +                           const struct cred *cred,
> +                           const struct nfs_access_entry *cache)
>  {
>         const struct task_struct *parent;
>         const struct cred *pcred;
> -       u64 ret;
> +       u64 login_time;
>
>         rcu_read_lock();
>         for (;;) {
> @@ -2968,15 +2970,15 @@ static u64 nfs_access_login_time(const struct task_struct *task,
>                         break;
>                 task = parent;
>         }
> -       ret = task->start_time;
> +       login_time = task->start_time;
>         rcu_read_unlock();
> -       return ret;
> +
> +       return ((s64)(login_time - cache->timestamp) > 0);
>  }
>
>  static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, u32 *mask, bool may_block)
>  {
>         struct nfs_inode *nfsi = NFS_I(inode);
> -       u64 login_time = nfs_access_login_time(current, cred);
>         struct nfs_access_entry *cache;
>         bool retry = true;
>         int err;
> @@ -3005,7 +3007,8 @@ static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *
>                 retry = false;
>         }
>         err = -ENOENT;
> -       if ((s64)(login_time - cache->timestamp) > 0)
> +       if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOFASC) &&
> +           nfs_check_access_stale(current, cred, cache))
>                 goto out;
>         *mask = cache->mask;
>         list_move_tail(&cache->lru, &nfsi->access_cache_entry_lru);
> @@ -3025,7 +3028,6 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
>          * but do it without locking.
>          */
>         struct nfs_inode *nfsi = NFS_I(inode);
> -       u64 login_time = nfs_access_login_time(current, cred);
>         struct nfs_access_entry *cache;
>         int err = -ECHILD;
>         struct list_head *lh;
> @@ -3040,7 +3042,8 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
>                 cache = NULL;
>         if (cache == NULL)
>                 goto out;
> -       if ((s64)(login_time - cache->timestamp) > 0)
> +       if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOFASC) &&
> +           nfs_check_access_stale(current, cred, cache))
>                 goto out;
>         if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
>                 goto out;
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 9bcd53d5c7d4..5cd9b2882c79 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -88,6 +88,7 @@ enum nfs_param {
>         Opt_vers,
>         Opt_wsize,
>         Opt_write,
> +       Opt_fasc,
>  };
>
>  enum {
> @@ -194,6 +195,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>         fsparam_string("vers",          Opt_vers),
>         fsparam_enum  ("write",         Opt_write, nfs_param_enums_write),
>         fsparam_u32   ("wsize",         Opt_wsize),
> +       fsparam_flag_no("fasc",         Opt_fasc),
>         {}
>  };
>
> @@ -861,6 +863,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>         case Opt_sloppy:
>                 ctx->sloppy = true;
>                 break;
> +       case Opt_fasc:
> +               if (result.negated)
> +                       ctx->flags |= NFS_MOUNT_NOFASC;
> +               else
> +                       ctx->flags &= ~NFS_MOUNT_NOFASC;
> +               break;
>         }
>
>         return 0;
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 05ae23657527..059513d403f8 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -444,6 +444,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
>                 { NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
>                 { NFS_MOUNT_UNSHARED, ",nosharecache", "" },
>                 { NFS_MOUNT_NORESVPORT, ",noresvport", "" },
> +               { NFS_MOUNT_NOFASC, ",nofasc", "" },
>                 { 0, NULL, NULL }
>         };
>         const struct proc_nfs_info *nfs_infop;
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index ea2f7e6b1b0b..a39ae1bd2217 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -153,6 +153,7 @@ struct nfs_server {
>  #define NFS_MOUNT_WRITE_EAGER          0x01000000
>  #define NFS_MOUNT_WRITE_WAIT           0x02000000
>  #define NFS_MOUNT_TRUNK_DISCOVERY      0x04000000
> +#define NFS_MOUNT_NOFASC               0x08000000
>
>         unsigned int            fattr_valid;    /* Valid attributes */
>         unsigned int            caps;           /* server capabilities */
> --
> 2.37.2
>
