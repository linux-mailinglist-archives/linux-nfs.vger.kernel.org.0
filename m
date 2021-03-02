Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1B32A976
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhCBSXY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:23:24 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:40821 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580760AbhCBSVV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 13:21:21 -0500
Received: by mail-ej1-f47.google.com with SMTP id ci14so18088799ejc.7;
        Tue, 02 Mar 2021 10:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pNEu7KQLcXSJZyITrmV1pUTE9NtYAwDbH+VjXoKaew=;
        b=BOveuMS8u9ePiWp+k3D7UBpNBRIj/XDLgR2LPkZZqH1aEu6BlXCXqFd0bbm7ad23A8
         YiLvVPVo9HJMukBOT8po3pBqtphyA/pMwoUGZJm7ZxpqPQ7eoh+duP3O4Ns3PZBDcItJ
         SfybSP/M8Hk9GcvDJKoYqB+NU5WfiJPARA7UTCBC3twLwSxY1ttnNQH4AlZ/S0OUy4ss
         7iDJqooOzBdd/NKkYL4XVqblpGoGxYQG9lNSyDjkrgoEwTgzGjlyP1L4yJ6YxCy/7ttS
         84CYXmOipQhlEYHQ1VvuweeCw3jGDtBgKlxbGX6QY2ji6/KJHuELOK6M9GneYV6YW4ht
         T8UA==
X-Gm-Message-State: AOAM5315D5IwmEUeMFYpK3cTJjMsLnFpQsrgALiwlSXbawOqX3xn89Gk
        WQnaA7k6jYGKHLANN6BWUv5zlU9cnX5ruXeBQKk=
X-Google-Smtp-Source: ABdhPJx+VRxciomDvLVgvTm07NKqU2Xf0GxHlyss8gTFZGpdlMA8V5dIvUeirFiXZi04/Le6ee9l/Cy0ApO7VvOQ6dw=
X-Received: by 2002:a17:906:4e17:: with SMTP id z23mr20564237eju.439.1614709232401;
 Tue, 02 Mar 2021 10:20:32 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210227033755.24460-1-olga.kornievskaia@gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 2 Mar 2021 13:20:16 -0500
Message-ID: <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        casey@schaufler-ca.com
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Casey,

On Fri, Feb 26, 2021 at 10:40 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Add a new hook that takes an existing super block and a new mount
> with new options and determines if new options confict with an
> existing mount or not.
>
> A filesystem can use this new hook to determine if it can share
> the an existing superblock with a new superblock for the new mount.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

Do you have any other thoughts on this patch? I'm also wondering how
you want to handle sending it upstream. I'm happy to take it through
the NFS tree (with an acked-by) for a 5.12-rc with Olga's bugfix
patches, but if you have other thoughts or plans then let me know!

Thanks,
Anna

> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     |  6 ++++
>  include/linux/security.h      |  8 +++++
>  security/security.c           |  7 +++++
>  security/selinux/hooks.c      | 56 +++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 7aaa753b8608..1b12a5266a51 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
>  LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
> +LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
>  LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
>  LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
>  LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a19adef1f088..0de8eb2ea547 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -142,6 +142,12 @@
>   *     @orig the original mount data copied from userspace.
>   *     @copy copied data which will be passed to the security module.
>   *     Returns 0 if the copy was successful.
> + * @sb_mnt_opts_compat:
> + *     Determine if the new mount options in @mnt_opts are allowed given
> + *     the existing mounted filesystem at @sb.
> + *     @sb superblock being compared
> + *     @mnt_opts new mount options
> + *     Return 0 if options are compatible.
>   * @sb_remount:
>   *     Extracts security system specific mount options and verifies no changes
>   *     are being made to those options.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c35ea0ffccd9..50db3d5d1608 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
>  void security_sb_free(struct super_block *sb);
>  void security_free_mnt_opts(void **mnt_opts);
>  int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
> +int security_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts);
>  int security_sb_remount(struct super_block *sb, void *mnt_opts);
>  int security_sb_kern_mount(struct super_block *sb);
>  int security_sb_show_options(struct seq_file *m, struct super_block *sb);
> @@ -635,6 +636,13 @@ static inline int security_sb_remount(struct super_block *sb,
>         return 0;
>  }
>
> +static inline int security_sb_mnt_opts_compat(struct super_block *sb,
> +                                             void *mnt_opts)
> +{
> +       return 0;
> +}
> +
> +
>  static inline int security_sb_kern_mount(struct super_block *sb)
>  {
>         return 0;
> diff --git a/security/security.c b/security/security.c
> index 7b09cfbae94f..56cf5563efde 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
>  }
>  EXPORT_SYMBOL(security_sb_eat_lsm_opts);
>
> +int security_sb_mnt_opts_compat(struct super_block *sb,
> +                               void *mnt_opts)
> +{
> +       return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
> +}
> +EXPORT_SYMBOL(security_sb_mnt_opts_compat);
> +
>  int security_sb_remount(struct super_block *sb,
>                         void *mnt_opts)
>  {
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 644b17ec9e63..afee3a222a0e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2656,6 +2656,61 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>         return rc;
>  }
>
> +static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
> +{
> +       struct selinux_mnt_opts *opts = mnt_opts;
> +       struct superblock_security_struct *sbsec = sb->s_security;
> +       u32 sid;
> +       int rc;
> +
> +       /*
> +        * Superblock not initialized (i.e. no options) - reject if any
> +        * options specified, otherwise accept.
> +        */
> +       if (!(sbsec->flags & SE_SBINITIALIZED))
> +               return opts ? 1 : 0;
> +
> +       /*
> +        * Superblock initialized and no options specified - reject if
> +        * superblock has any options set, otherwise accept.
> +        */
> +       if (!opts)
> +               return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
> +
> +       if (opts->fscontext) {
> +               rc = parse_sid(sb, opts->fscontext, &sid);
> +               if (rc)
> +                       return 1;
> +               if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
> +                       return 1;
> +       }
> +       if (opts->context) {
> +               rc = parse_sid(sb, opts->context, &sid);
> +               if (rc)
> +                       return 1;
> +               if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
> +                       return 1;
> +       }
> +       if (opts->rootcontext) {
> +               struct inode_security_struct *root_isec;
> +
> +               root_isec = backing_inode_security(sb->s_root);
> +               rc = parse_sid(sb, opts->rootcontext, &sid);
> +               if (rc)
> +                       return 1;
> +               if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
> +                       return 1;
> +       }
> +       if (opts->defcontext) {
> +               rc = parse_sid(sb, opts->defcontext, &sid);
> +               if (rc)
> +                       return 1;
> +               if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
> +                       return 1;
> +       }
> +       return 0;
> +}
> +
>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
>  {
>         struct selinux_mnt_opts *opts = mnt_opts;
> @@ -6984,6 +7039,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>
>         LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>         LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
> +       LSM_HOOK_INIT(sb_mnt_opts_compat, selinux_sb_mnt_opts_compat),
>         LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>         LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>         LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
> --
> 2.27.0
>
