Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E742E31A819
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 23:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhBLWyy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 17:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhBLWvF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 17:51:05 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35019C0613D6;
        Fri, 12 Feb 2021 14:50:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jj19so1819919ejc.4;
        Fri, 12 Feb 2021 14:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YJn/CbCyWqLtgH2UnWMYhxyMeo0nY1p+WKMq9NcVjM=;
        b=MUTz9/vIKjQeaw9htoTwsJc1KpTywgc0bjX78EfHSapEkYCqnOV4MAmduxO5shZtqs
         jMLzGZIaQ+OqzOQD4KIke0mbakXHCxfKpmyA49LGn1BtwbWVeOeEQ67E37/GlRQluUHB
         /AYxGyTmYpwjtzyfn7pHD1a0gq2/zZnNsTBDXdd+3NP3q0QAkX2cHxpWE4dR3eDYWJKU
         z2vv4yFnwYNDkbz8yKgcOM4h+m3563VmHeqAFqrIRBoI51WbwNRp/HrtaAl+GgGTabfR
         B7tCbfVO74BV20aouupxYktl2YNL/qx//EOYjbXy9xbRczGtpOftxxQDwtA0AFdr5xVb
         Q9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YJn/CbCyWqLtgH2UnWMYhxyMeo0nY1p+WKMq9NcVjM=;
        b=uZnPhw+FDoL8hhJ9GHyqV+DS858zeupQID4OrEeFna2WCm6dWWgfDxaN1H2O8EVjcB
         +MG5SsSBjazzNvyAB81okNkOOsCRqi7GyAm332+i1sHbQm3GDmuPJ4/UHzILlpM/NKJC
         k30uhioPAQrhPaHaPJijExe26ziPaaA2pV2HCBAzgZ1okwRYg1frb3okScG780q3RE7W
         QoLRGKrQlFmhyaqtvkz+H4JRJ+B69010wl43vh77tPHhs11IZD+hu8w0ryqJP4yWyQ2a
         cq+iylxHoiWnhSatx8qGO24BBzJS0DfGePVo/fXhDYhOL+9j2kvs3o4rb5fUBd6CZ4GS
         dmoA==
X-Gm-Message-State: AOAM533uztPD4EghLW3ypngaBBMS5Yp3J1IE0YUjbbT7YjNtjAqMCgrc
        djTZ0kUbrCE+39Ysb++ArVmStrUhp7qw5t34zI4=
X-Google-Smtp-Source: ABdhPJw29oqHmVe30du0ylzVwcqFl5xtkh4QghCEb7nJNRAA1Nhgr3v9BRCs6OfOlg/OSxQOV4XyEa1FYkwrQnLRHNk=
X-Received: by 2002:a17:906:f950:: with SMTP id ld16mr5139077ejb.248.1613170222831;
 Fri, 12 Feb 2021 14:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20210212211955.11239-1-olga.kornievskaia@gmail.com> <6214d043-3250-43bc-d668-bc9ffa8c9af2@schaufler-ca.com>
In-Reply-To: <6214d043-3250-43bc-d668-bc9ffa8c9af2@schaufler-ca.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 12 Feb 2021 17:50:11 -0500
Message-ID: <CAN-5tyFU7JCKEr6wPQ3_LTGJHQLFmrb=-xWQt6mGhv7JzE_xXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [security] Add new hook to compare new mount to an
 existing mount
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thank you for comment Casey. Comments are in line.

On Fri, Feb 12, 2021 at 5:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/12/2021 1:19 PM, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Add a new hook that takes an existing super block and a new mount
> > with new options and determines if new options confict with an
> > existing mount or not.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/lsm_hooks.h     |  6 ++++
> >  include/linux/security.h      |  1 +
> >  security/security.c           |  7 +++++
> >  security/selinux/hooks.c      | 54 +++++++++++++++++++++++++++++++++++
> >  5 files changed, 69 insertions(+)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 7aaa753b8608..fbfc07d0b3d5 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
> >  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
> >  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
> >  LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
> > +LSM_HOOK(int, 0, sb_do_mnt_opts_match, struct super_block *sb, void *mnt_opts)
>
> Don't you want this to be sb_mnt_opts_compatible ?
> They may not have to match. They just need to be acceptable
> to the security module. SELinux doesn't appear to require
> that they "match" in all respects.

You are right, it was a poor naming choice. Compatible is better. I
can change it.
>
>
> >  LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
> >  LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
> >  LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index a19adef1f088..a11b062c1847 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -142,6 +142,12 @@
> >   *   @orig the original mount data copied from userspace.
> >   *   @copy copied data which will be passed to the security module.
> >   *   Returns 0 if the copy was successful.
> > + * @sb_do_mnt_opts_match:
> > + *   Determine if the existing mount options are compatible with the new
> > + *   mount options being used.
> > + *   @sb superblock being compared
> > + *   @mnt_opts new mount options
> > + *   Return 1 if options are the same.
>
> This is inconsistent with the convention for returns from LSM interfaces.
> Return 0 on success and -ESOMETHINGOROTHER if the operation would be
> denied. Your implementation of security_sb_do_mnt_opts_match() will
> always return 0 if there's no module supplying the hook. I seriously
> doubt that you want the mounts to fail 100% of the time if there isn't
> an LSM.

The mounts are not failing. This allows a file system to decide
whether or not to share the superblocks or not. Ok a good point, I
haven't tested building a kernel where there is LSM but SElinux is not
compiled into the kernel (ie, the only user of that hook). I'm not
sure that's a possible or an interesting option.

Ok, I can flip the returns, I wasn't aware that SElinux is so
restrictive in its return function meaning. Returning 0 on a success
when you are looking for a match/capability seems backwards.

> Also, "options are the same" isn't the right description, even for
> SELinux.

Again compatible is better, I can change it.

> >   * @sb_remount:
> >   *   Extracts security system specific mount options and verifies no changes
> >   *   are being made to those options.
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index c35ea0ffccd9..07026db7304d 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
> >  void security_sb_free(struct super_block *sb);
> >  void security_free_mnt_opts(void **mnt_opts);
> >  int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
> > +int security_sb_do_mnt_opts_match(struct super_block *sb, void *mnt_opts);
> >  int security_sb_remount(struct super_block *sb, void *mnt_opts);
> >  int security_sb_kern_mount(struct super_block *sb);
> >  int security_sb_show_options(struct seq_file *m, struct super_block *sb);
> > diff --git a/security/security.c b/security/security.c
> > index 7b09cfbae94f..dae380916c6a 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
> >  }
> >  EXPORT_SYMBOL(security_sb_eat_lsm_opts);
> >
> > +int security_sb_do_mnt_opts_match(struct super_block *sb,
> > +                              void *mnt_opts)
> > +{
> > +     return call_int_hook(sb_do_mnt_opts_match, 0, sb, mnt_opts);
> > +}
> > +EXPORT_SYMBOL(security_sb_do_mnt_opts_match);
> > +
> >  int security_sb_remount(struct super_block *sb,
> >                       void *mnt_opts)
> >  {
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 644b17ec9e63..aaa3a725da94 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2656,6 +2656,59 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
> >       return rc;
> >  }
> >
> > +static int selinux_sb_do_mnt_opts_match(struct super_block *sb, void *mnt_opts)
> > +{
> > +     struct selinux_mnt_opts *opts = mnt_opts;
> > +     struct superblock_security_struct *sbsec = sb->s_security;
> > +     u32 sid;
> > +     int rc;
> > +
> > +     /* superblock not initialized (i.e. no options) - reject if any
> > +      * options specified, otherwise accept
> > +      */
> > +     if (!(sbsec->flags & SE_SBINITIALIZED))
> > +             return opts ? 0 : 1;
> > +
> > +     /* superblock initialized and no options specified - reject if
> > +      * superblock has any options set, otherwise accept
> > +      */
> > +     if (!opts)
> > +             return (sbsec->flags & SE_MNTMASK) ? 0 : 1;
> > +
> > +     if (opts->fscontext) {
> > +             rc = parse_sid(sb, opts->fscontext, &sid);
> > +             if (rc)
> > +                     return 0;
> > +             if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
> > +                     return 0;
> > +     }
> > +     if (opts->context) {
> > +             rc = parse_sid(sb, opts->context, &sid);
> > +             if (rc)
> > +                     return 0;
> > +             if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
> > +                     return 0;
> > +     }
> > +     if (opts->rootcontext) {
> > +             struct inode_security_struct *root_isec;
> > +
> > +             root_isec = backing_inode_security(sb->s_root);
> > +             rc = parse_sid(sb, opts->rootcontext, &sid);
> > +             if (rc)
> > +                     return 0;
> > +             if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
> > +                     return 0;
> > +     }
> > +     if (opts->defcontext) {
> > +             rc = parse_sid(sb, opts->defcontext, &sid);
> > +             if (rc)
> > +                     return 0;
> > +             if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
> > +                     return 0;
> > +     }
> > +     return 1;
> > +}
> > +
> >  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
> >  {
> >       struct selinux_mnt_opts *opts = mnt_opts;
> > @@ -6984,6 +7037,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >
> >       LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
> >       LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
> > +     LSM_HOOK_INIT(sb_do_mnt_opts_match, selinux_sb_do_mnt_opts_match),
> >       LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
> >       LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
> >       LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
>
