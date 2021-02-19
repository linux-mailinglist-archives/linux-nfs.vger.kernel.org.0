Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09F731FD15
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSQ0y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 11:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSQ0x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 11:26:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229D9C061574;
        Fri, 19 Feb 2021 08:26:12 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j9so10979129edp.1;
        Fri, 19 Feb 2021 08:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBveBH4iWWPEmL1QkOi4J0Nhc0g/tqtS/bENktZlMMI=;
        b=hpY/PQwQnolM6ZbD+8dD/myTkqnyJfyyI+yxLlKoyv2dSIr2WSafuJp+IycAPyEa9i
         6fimoylNLRFdlFhqEqS9Ekm8NJd86UUrgMINIYmAGqm4P7hmbruiqAoTMR3pUbRI7slu
         u5luUgte1JGg0I5jB4DUi2IV7gqkwixZmY5sb/IXeJddMPyUQGQLIjvvzvLvf7tLZKAU
         RY7zs0Z0HeNnJMRlNXLJEDbHKqohL+lBt7Z7hHZQsEVLxMdQiaLnSuEg8wbm/6KznhBY
         m4/wHvxG9yXsH1JlsPQCKRMP/JMNdnVfCQ9Xbyw9W1o6C8cDSxx3BCEEcriDAXRTvUdF
         rR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBveBH4iWWPEmL1QkOi4J0Nhc0g/tqtS/bENktZlMMI=;
        b=aRh4jUL54rsPKLe+L7VOqqcmYG9FBebAG6NxAjAb9GVGDhGwv2FIg+da/q8vqMf5WA
         ptlKoLd0HV3nfKRKQw3cSyDxW805Fw7XG2gPOEq9wkOvoE84qL/rlQnaV97zn/LC+8kg
         YazfVnUb9XiwvZIewbwYmuOP+oGrg6zoosQYIUehxuqX3uQo/FW9+QFd3GH2cQ3Kk1da
         +Ff6tJZhoo5vVw+Vuzkyz/Rmyhw5nUiG8FJZrG1AG76Q11o01u4FNcmF/9m29E+/M4Mg
         u1BGiriBRXyS0DBjFxZwFy42FHhM2HHkFDxcIS2LjwJPBixlXaF9rWWCxW+O1NZvIPjy
         kyIg==
X-Gm-Message-State: AOAM531mQLK/kRMQYRluhLvynFtfRv55Su7FqiZp5ZPXt0IsHVM4KVn7
        HCnk7yPViEeuHLAwQ/5xQZ+Z4TgUuEkeTN1p2pc=
X-Google-Smtp-Source: ABdhPJzXhP9to2K4bPPKLQXaL4EnvZPcXM0m83TXmqca3RPU9TMS4+3wc4+romWiX+HMFfT3Ine+0/zEIn1dzer44EE=
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr10151895edu.139.1613751970736;
 Fri, 19 Feb 2021 08:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20210218195046.19280-1-olga.kornievskaia@gmail.com> <5742cb0f-cd47-4406-928a-0b5b4063c480@schaufler-ca.com>
In-Reply-To: <5742cb0f-cd47-4406-928a-0b5b4063c480@schaufler-ca.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 19 Feb 2021 11:25:59 -0500
Message-ID: <CAN-5tyHDmbJkNV-f-CaONV5PKbhFk0qxC+XSJ21mZJkO9A-87g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] [security] Add new hook to compare new mount to an
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

On Thu, Feb 18, 2021 at 4:57 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/18/2021 11:50 AM, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Add a new hook that takes an existing super block and a new mount
> > with new options and determines if new options confict with an
> > existing mount or not.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > `
> > ---
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/lsm_hooks.h     |  6 ++++
> >  include/linux/security.h      |  8 ++++++
> >  security/security.c           |  7 +++++
> >  security/selinux/hooks.c      | 54 +++++++++++++++++++++++++++++++++++
> >  5 files changed, 76 insertions(+)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 7aaa753b8608..1b12a5266a51 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
> >  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
> >  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
> >  LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
> > +LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
> >  LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
> >  LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
> >  LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index a19adef1f088..77c1e9cdeaca 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -142,6 +142,12 @@
> >   *   @orig the original mount data copied from userspace.
> >   *   @copy copied data which will be passed to the security module.
> >   *   Returns 0 if the copy was successful.
> > + * @sb_mnt_opts_compat:
> > + *   Determine if the existing mount options are compatible with the new
> > + *   mount options being used.
> > + *   @sb superblock being compared
> > + *   @mnt_opts new mount options
> > + *   Return 0 if options are the same.
>
> s/the same/compatible/
>
> >   * @sb_remount:
> >   *   Extracts security system specific mount options and verifies no changes
> >   *   are being made to those options.
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index c35ea0ffccd9..50db3d5d1608 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
> >  void security_sb_free(struct super_block *sb);
> >  void security_free_mnt_opts(void **mnt_opts);
> >  int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
> > +int security_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts);
> >  int security_sb_remount(struct super_block *sb, void *mnt_opts);
> >  int security_sb_kern_mount(struct super_block *sb);
> >  int security_sb_show_options(struct seq_file *m, struct super_block *sb);
> > @@ -635,6 +636,13 @@ static inline int security_sb_remount(struct super_block *sb,
> >       return 0;
> >  }
> >
> > +static inline int security_sb_mnt_opts_compat(struct super_block *sb,
> > +                                           void *mnt_opts)
> > +{
> > +     return 0;
> > +}
> > +
> > +
> >  static inline int security_sb_kern_mount(struct super_block *sb)
> >  {
> >       return 0;
> > diff --git a/security/security.c b/security/security.c
> > index 7b09cfbae94f..56cf5563efde 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
> >  }
> >  EXPORT_SYMBOL(security_sb_eat_lsm_opts);
> >
> > +int security_sb_mnt_opts_compat(struct super_block *sb,
> > +                             void *mnt_opts)
> > +{
> > +     return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
> > +}
> > +EXPORT_SYMBOL(security_sb_mnt_opts_compat);
> > +
> >  int security_sb_remount(struct super_block *sb,
> >                       void *mnt_opts)
> >  {
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 644b17ec9e63..f0b8ebc1e2c2 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2656,6 +2656,59 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
> >       return rc;
> >  }
> >
> > +static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
> > +{
> > +     struct selinux_mnt_opts *opts = mnt_opts;
> > +     struct superblock_security_struct *sbsec = sb->s_security;
> > +     u32 sid;
> > +     int rc;
> > +
> > +     /* superblock not initialized (i.e. no options) - reject if any
>
> Please maintain the existing comment style used in this file.

I'm again not sure what exactly is the style used in this file and how
is this inconsistent?

Here's one example from this file:
        /* Wake up the parent if it is waiting so that it can recheck
         * wait permission to the new task SID. */
this is another example from this file:
        /* Check whether the new SID can inherit signal state from the old SID.
         * If not, clear itimers to avoid subsequent signal generation and
         * flush and unblock signals.
         *
         * This must occur _after_ the task SID has been updated so that any
         * kill done after the flush will be checked against the new SID.
         */
Here's another:
                       /* strip quotes */

What exactly is not correct about the new comment?
        /* superblock not initialized (i.e. no options) - reject if any
         * options specified, otherwise accept
         */
It uses "/*" and has a space after. It starts each new line with "*"
and a space. And ends with a new line. This is consistent with the
general kernel style. Actually example 1 is not following kernel style
by not ending on the new line.

Is the objection that it's perhaps not a sentence that starts with a
capital letter and ends with a period? Not all comments are sentences.
If so please specify. Otherwise, I'm just guessing what you are
expecting.


>         /*
>          * superblock not initialized (i.e. no options) - reject if any
>
> > +      * options specified, otherwise accept
> > +      */
> > +     if (!(sbsec->flags & SE_SBINITIALIZED))
> > +             return opts ? 1 : 0;
> > +
> > +     /* superblock initialized and no options specified - reject if
> > +      * superblock has any options set, otherwise accept
> > +      */
> > +     if (!opts)
> > +             return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
> > +
> > +     if (opts->fscontext) {
> > +             rc = parse_sid(sb, opts->fscontext, &sid);
> > +             if (rc)
> > +                     return 1;
> > +             if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
> > +                     return 1;
> > +     }
> > +     if (opts->context) {
> > +             rc = parse_sid(sb, opts->context, &sid);
> > +             if (rc)
> > +                     return 1;
> > +             if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
> > +                     return 1;
> > +     }
> > +     if (opts->rootcontext) {
> > +             struct inode_security_struct *root_isec;
> > +
> > +             root_isec = backing_inode_security(sb->s_root);
> > +             rc = parse_sid(sb, opts->rootcontext, &sid);
> > +             if (rc)
> > +                     return 1;
> > +             if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
> > +                     return 1;
> > +     }
> > +     if (opts->defcontext) {
> > +             rc = parse_sid(sb, opts->defcontext, &sid);
> > +             if (rc)
> > +                     return 1;
> > +             if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
> > +                     return 1;
> > +     }
> > +     return 0;
> > +}
> > +
> >  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
> >  {
> >       struct selinux_mnt_opts *opts = mnt_opts;
> > @@ -6984,6 +7037,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >
> >       LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
> >       LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
> > +     LSM_HOOK_INIT(sb_mnt_opts_compat, selinux_sb_mnt_opts_compat),
> >       LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
> >       LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
> >       LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
