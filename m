Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7BC78A653
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjH1HPY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 03:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjH1HPL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 03:15:11 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B86F113
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 00:15:08 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB0A73F657
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 07:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693206906;
        bh=2NmxD2QM1201soflytY9RDoLqAz+5ke4JpjzANAuhPo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GgQXQ0sS7bwoRB5m9VHaUKwiPpghDpBr2i8rsnsSic4rKzqwy9oRZMWpfVnfgKhVS
         suVA6p8Fy7aeslaKsAZsNpTfqjtw4lNO29freiLqvHJcIZ+11Yz7XqWbvG4MZQcJQM
         IxcgjkTzv0vHpXyYuhsCjT36LxKPqDZrbjD2+RR0xk+K+5/xd24AnSttb+upkK2AI6
         zyTlevxMyrxG2JesRUoDzNzn1oQI8BPeBTsblrjuYth3sVjZ2Jq7S2j2zUja+vZ15n
         mfrtY3ffhH5pTDm5VrDt+KzJOjGqqIP+T1HaB5+GM8XPj87v7Ug7OgYprNWTDtqHRH
         Uw3ADmmxquocA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51d8823eb01so2742554a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 00:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206906; x=1693811706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NmxD2QM1201soflytY9RDoLqAz+5ke4JpjzANAuhPo=;
        b=H2R9oi457+637dOjLr/N+cMk58NMwRfdUJBV3WE+dUhhfxmGtNpIyGvGWTG+Mnso8x
         TbyxRcFkW2ZnXFDEBHMd9uCmZOZXoC/N1Fax7UKm5EK/P4SmzItIJR4IWf+gQUOriOSU
         cl090Vq4vwfNEOgUx96gfYKSRgyCwKf6MHoHMr3aP13B3XK/Uh7L4zgHWvvuZv2wB0MC
         fb3kSzKPVSEqyYQ5qvfyegAjTQrOeE/NfRKGiRAaGVH65FY6Gnii/vCAqG/vzTJTomN9
         FmZcFXDkjWm+utrwxOCMBNU7KAyCPkBuuCYQN5o61ivQpDUIPgW29au/qpqQxUBRWLrU
         i25w==
X-Gm-Message-State: AOJu0YzrTi6q+oVhKHIWfQgkE1wLRh2ctgeFmQsH1bV5pk+5+jCxtbco
        4sFAmA6Nxe4NB/qjSxemOPdbkGflJejGgxnW/mT2wwTuB0qPYHqPidNmbhVjXuFKT1YX+19CUiA
        6X8TrD5fddgYFo1QPAL3LQ68BDJsF1LwMqeYQNYr90KGFL73OsMMWEQ==
X-Received: by 2002:a17:906:301a:b0:9a1:c448:3c35 with SMTP id 26-20020a170906301a00b009a1c4483c35mr11514995ejz.68.1693206906441;
        Mon, 28 Aug 2023 00:15:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5UB/5nwcqCps2bRXq+IOJkhYw8VYWTqg4mL8nCB8BhWIUUTD58f/g6p9wHNp1vZQH7yzFeTYUmMCExzaoCcc=
X-Received: by 2002:a17:906:301a:b0:9a1:c448:3c35 with SMTP id
 26-20020a170906301a00b009a1c4483c35mr11514988ejz.68.1693206906109; Mon, 28
 Aug 2023 00:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230828055310.21391-1-chengen.du@canonical.com>
In-Reply-To: <20230828055310.21391-1-chengen.du@canonical.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Mon, 28 Aug 2023 15:14:55 +0800
Message-ID: <CAPza5qe0NBWiKZ1yLyfdPGOsmM=VGqWMs=oWJqVzLRcd8AFyJQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] NFS: Add mount option 'fasc'
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

The performance issue has been brought to our attention by users
within the Ubuntu community.
However, it seems to be confined to specific user scenarios.
Canonical has taken proactive measures to tackle the problem by
implementing a temporary solution [1], which has effectively resolved
the issue at hand.
Nonetheless, our earnest desire is for a definitive resolution of the
performance concern at its source upstream.

I've taken the initiative to send the patches addressing this matter.
Regrettably, as of now, I've yet to receive any response.
This situation leads me to consider the possibility of reservations or
deliberations surrounding this issue.
I am genuinely keen to gain insights and perspectives from the
upstream community.

I kindly ask for your valuable input on this matter.
Your thoughts would significantly aid my progress and contribute to a
collective consensus.

Best regards,
Chengen Du

[1] https://bugs.launchpad.net/bugs/2022098

On Mon, Aug 28, 2023 at 1:53=E2=80=AFPM Chengen Du <chengen.du@canonical.co=
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
> index 853e8d609bb3..2fbc2d1bd775 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -92,6 +92,7 @@ enum nfs_param {
>         Opt_wsize,
>         Opt_write,
>         Opt_xprtsec,
> +       Opt_fasc,
>  };
>
>  enum {
> @@ -199,6 +200,7 @@ static const struct fs_parameter_spec nfs_fs_paramete=
rs[] =3D {
>         fsparam_enum  ("write",         Opt_write, nfs_param_enums_write)=
,
>         fsparam_u32   ("wsize",         Opt_wsize),
>         fsparam_string("xprtsec",       Opt_xprtsec),
> +       fsparam_flag  ("fasc",          Opt_fasc),
>         {}
>  };
>
> @@ -925,6 +927,9 @@ static int nfs_fs_context_parse_param(struct fs_conte=
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
> index 2284f749d892..7a0c5280e388 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -448,6 +448,7 @@ static void nfs_show_mount_options(struct seq_file *m=
, struct nfs_server *nfss,
>                 { NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
>                 { NFS_MOUNT_UNSHARED, ",nosharecache", "" },
>                 { NFS_MOUNT_NORESVPORT, ",noresvport", "" },
> +               { NFS_MOUNT_FASC, ",fasc", "" },
>                 { 0, NULL, NULL }
>         };
>         const struct proc_nfs_info *nfs_infop;
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 20eeba8b009d..6a88ba36f7a8 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -155,6 +155,7 @@ struct nfs_server {
>  #define NFS_MOUNT_WRITE_WAIT           0x02000000
>  #define NFS_MOUNT_TRUNK_DISCOVERY      0x04000000
>  #define NFS_MOUNT_SHUTDOWN                     0x08000000
> +#define NFS_MOUNT_FASC                 0x10000000
>
>         unsigned int            fattr_valid;    /* Valid attributes */
>         unsigned int            caps;           /* server capabilities */
> --
> 2.39.2
>
