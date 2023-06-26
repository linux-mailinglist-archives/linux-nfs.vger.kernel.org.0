Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514973DC30
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jun 2023 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjFZKZi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jun 2023 06:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFZKZe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jun 2023 06:25:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4FB1A1
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 03:25:31 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 111213F16E
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 10:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687775130;
        bh=Hvs49rJ424sSIPS43YdfiXb70PA/ZaU38W3lwfpEzfo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=g4IWeqSZB+an8AkuTls/W3Rykd8eRSiGzEVNqz+J/DStqIAViA0u3w4i9DoGDIkrG
         fr8zav61TnoOeCuRn2uIkzHx/FFa7jF3I6GncJxy4FCmq6oo4LxqQRMRMndCqKjB77
         negt7iJl2O4H4wzWX0MZC949xdlKMNT96tW4pSHPx39r0r0UEK4cZm57dGNkOVJcvo
         PxAQCqznRi2q35IWS5u22s0pTvpyjr3fU5129QXgwIRwTB6DSyL5F5LRlUpm+jhxkk
         u5LK+/KhuKO/jI9aN0Uwhg4wikM23WdzBfvm6B6iKxWIUuFepdyJRq1WImalF0P60e
         TueCXtNlE6zEQ==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5700861af1bso44649177b3.2
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 03:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687775129; x=1690367129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hvs49rJ424sSIPS43YdfiXb70PA/ZaU38W3lwfpEzfo=;
        b=GLM7p5dFZj5QQ4A3iF7q72Vz3/OR6v/lNCBK1So7lj+HUrLs6IgD5QjL0v8c7BlNv+
         OJdWO9fY+mnjgSSRp0Dym5GuTIK+ZX7gf/cjiAMPRpmpiF76/JT4HqMbWIYkN5/aAAqU
         zd2f3kTITrmlwV3PJfv6q+tsmFURhbHSCT9GvmXNCabJXGlNtPLen9lvQn8q89msii9Y
         e6lvN5LB0FOYlYrlA4BdWEcolxBfHb/RylqWLHNrxfvS8waQDL9mhKlIsNRlcBpDZOhi
         3MUtGg6GkfSiACI6S9fSGu7tUw2/DbeeoOhxZ9RQzTaOVRuP2fcqZggOYw0rDQgvE2en
         U1hA==
X-Gm-Message-State: AC+VfDzLMafaq//G8OoyRsHpw9D60eu9gzt1X/m0TSkvzFpEgkayca/P
        i1mG7ZkhChzHvDQWVzCRc+5V7sa0E1FPKkNhhb4BsyPets9XdLS59q7MXngHWNXWM+toD2Z6849
        bxuGWN9DIYc0pMtms3ZdzhOyclOKqN/P9IhqLCxuUcalsK2+HdDorgQ==
X-Received: by 2002:a0d:ca56:0:b0:573:974a:d264 with SMTP id m83-20020a0dca56000000b00573974ad264mr17225332ywd.49.1687775129073;
        Mon, 26 Jun 2023 03:25:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HdqpY7hy58BmkwQ6n5jiRBdBrQBdN77K8pTReCJltg8Hf29YUojgyxwluZDUIHHmHhljLfJTz7W4R0V3CYfU=
X-Received: by 2002:a0d:ca56:0:b0:573:974a:d264 with SMTP id
 m83-20020a0dca56000000b00573974ad264mr17225321ywd.49.1687775128732; Mon, 26
 Jun 2023 03:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230602020935.43367-1-chengen.du@canonical.com>
In-Reply-To: <20230602020935.43367-1-chengen.du@canonical.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Mon, 26 Jun 2023 18:25:17 +0800
Message-ID: <CAPza5qdv7sS4d5f7nKKJgpEnxh41ZpuLwNp10=Zf2q_SMf23fw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] NFS: Add mount option 'fasc'
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond, Anna,

I apologize for interrupting you, as I understand you may be engaged
in other important tasks.

In order to enhance the flexibility of deploying the NFS service,
I believe it would be beneficial to introduce a mount option that
enables file access stale checking for users.

There are certain users experiencing performance degradation in
specific usage scenarios.
It would be greatly appreciated if you could share some insights on
how to address this issue.
If you have the time, I would greatly appreciate the opportunity to
discuss this matter further.

Thank you in advance for your attention to this request.

Best regards,
Chengen Du

On Fri, Jun 2, 2023 at 10:09=E2=80=AFAM Chengen Du <chengen.du@canonical.co=
m> wrote:
>
> In certain instances, users or applications switch to other privileged
> users by executing commands like 'su' to carry out operations on NFS-
> mounted folders. However, when this happens, the login time for the
> privileged user is reset, and any NFS ACCESS operations must be resent,
> which can result in a decrease in performance. In specific production
> environments where the access cache can be trusted due to stable group
> membership, there's no need to verify the cache stall situation.
> To maintain the initial behavior and performance, a new mount option
> called 'fasc' has been introduced. This option triggers the mechanism
> of clearing the file access cache upon login.
>
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  fs/nfs/dir.c              | 21 ++++++++++++---------
>  fs/nfs/fs_context.c       |  5 +++++
>  fs/nfs/super.c            |  1 +
>  include/linux/nfs_fs_sb.h |  1 +
>  4 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 8f3112e71a6a..cefdb23d4cd7 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2951,12 +2951,14 @@ static struct nfs_access_entry *nfs_access_search=
_rbtree(struct inode *inode, co
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
> @@ -2966,15 +2968,15 @@ static u64 nfs_access_login_time(const struct tas=
k_struct *task,
>                         break;
>                 task =3D parent;
>         }
> -       ret =3D task->start_time;
> +       login_time =3D task->start_time;
>         rcu_read_unlock();
> -       return ret;
> +
> +       return ((s64)(login_time - cache->timestamp) > 0);
>  }
>
>  static int nfs_access_get_cached_locked(struct inode *inode, const struc=
t cred *cred, u32 *mask, bool may_block)
>  {
>         struct nfs_inode *nfsi =3D NFS_I(inode);
> -       u64 login_time =3D nfs_access_login_time(current, cred);
>         struct nfs_access_entry *cache;
>         bool retry =3D true;
>         int err;
> @@ -3003,7 +3005,8 @@ static int nfs_access_get_cached_locked(struct inod=
e *inode, const struct cred *
>                 retry =3D false;
>         }
>         err =3D -ENOENT;
> -       if ((s64)(login_time - cache->timestamp) > 0)
> +       if ((NFS_SERVER(inode)->flags & NFS_MOUNT_FASC) &&
> +           nfs_check_access_stale(current, cred, cache))
>                 goto out;
>         *mask =3D cache->mask;
>         list_move_tail(&cache->lru, &nfsi->access_cache_entry_lru);
> @@ -3023,7 +3026,6 @@ static int nfs_access_get_cached_rcu(struct inode *=
inode, const struct cred *cre
>          * but do it without locking.
>          */
>         struct nfs_inode *nfsi =3D NFS_I(inode);
> -       u64 login_time =3D nfs_access_login_time(current, cred);
>         struct nfs_access_entry *cache;
>         int err =3D -ECHILD;
>         struct list_head *lh;
> @@ -3038,7 +3040,8 @@ static int nfs_access_get_cached_rcu(struct inode *=
inode, const struct cred *cre
>                 cache =3D NULL;
>         if (cache =3D=3D NULL)
>                 goto out;
> -       if ((s64)(login_time - cache->timestamp) > 0)
> +       if ((NFS_SERVER(inode)->flags & NFS_MOUNT_FASC) &&
> +           nfs_check_access_stale(current, cred, cache))
>                 goto out;
>         if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
>                 goto out;
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 9bcd53d5c7d4..0a14bd67efc1 100644
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
> @@ -194,6 +195,7 @@ static const struct fs_parameter_spec nfs_fs_paramete=
rs[] =3D {
>         fsparam_string("vers",          Opt_vers),
>         fsparam_enum  ("write",         Opt_write, nfs_param_enums_write)=
,
>         fsparam_u32   ("wsize",         Opt_wsize),
> +       fsparam_flag  ("fasc",          Opt_fasc),
>         {}
>  };
>
> @@ -861,6 +863,9 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>         case Opt_sloppy:
>                 ctx->sloppy =3D true;
>                 break;
> +       case Opt_fasc:
> +               ctx->flags |=3D NFS_MOUNT_FASC;
> +               break;
>         }
>
>         return 0;
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 30e53e93049e..e8d0ffd04b16 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -444,6 +444,7 @@ static void nfs_show_mount_options(struct seq_file *m=
, struct nfs_server *nfss,
>                 { NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
>                 { NFS_MOUNT_UNSHARED, ",nosharecache", "" },
>                 { NFS_MOUNT_NORESVPORT, ",noresvport", "" },
> +               { NFS_MOUNT_FASC, ",fasc", "" },
>                 { 0, NULL, NULL }
>         };
>         const struct proc_nfs_info *nfs_infop;
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index ea2f7e6b1b0b..332ceb11be6c 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -153,6 +153,7 @@ struct nfs_server {
>  #define NFS_MOUNT_WRITE_EAGER          0x01000000
>  #define NFS_MOUNT_WRITE_WAIT           0x02000000
>  #define NFS_MOUNT_TRUNK_DISCOVERY      0x04000000
> +#define NFS_MOUNT_FASC                 0x08000000
>
>         unsigned int            fattr_valid;    /* Valid attributes */
>         unsigned int            caps;           /* server capabilities */
> --
> 2.39.2
>
