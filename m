Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59E31FDAE
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 18:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBSRMB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 12:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBSRL7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 12:11:59 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AFDC061574;
        Fri, 19 Feb 2021 09:11:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gg8so3422351ejb.13;
        Fri, 19 Feb 2021 09:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlqBDH4lx9E/5HEGbcZSk9Z6LSm2PgQK4YV9Qbu628Y=;
        b=qKwMj+buSqM+D5CS8EAGZ+SiZXZGgFhh64xtJTk3BOsLmNNhHehKGK0fzMdZF8BWe/
         TNzvrlsjSEWXO8pjuTBSrxv8fAIVnmIu2bxLc3iieK5N45HbEBHqsTa41/MwYan4eJKz
         AF3T4n93tDfpLxbx91Hib9jwuog4Rl8g8sf5YRrr3hx9y+zsMrG6aAr5LJPcLoYFSNUG
         tgplNxl0DoST4/Q/mamwbgNDvJkC+vhiOSDJX+1nBICOkV1kvadzNYxZ5oblQ3J0ihDG
         TBiKOFNzKAoDOB3deFMay+/KDTIpG4BZBebw4MCi+ULz4yVzlqmKe235gj1Cszwcslcw
         L9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlqBDH4lx9E/5HEGbcZSk9Z6LSm2PgQK4YV9Qbu628Y=;
        b=QroreEno7XfRSiC5P0s68tY8DXVMnK1wA6i8MApraZRWB1qzijP6Eeldj/PZJRZsIJ
         1vdhJBOncEbOgn1S1iNr0zn+NxWKjonf2Lwamz4nVnM5F5O41SZNdebJ2SetaYPcJ9Vy
         pC/EJwLOdcO3olBjCQYCcdmklwPkowpQgoHsC4opIgXS2y+DuUN07HurHn/IRI7tbE64
         jRbl5MVtqj4t1lQ8c4J/ZnIb65VH3bm7ddeBHjQkq5XlN1pyVDeIk9TQhftkhtkyTfxZ
         RzDurju6P+xJh2I3fyCA6HzK+07b/i/6idazqbY2lOuNa61qKlWv7WpPOa7xUsJo2TrY
         j//A==
X-Gm-Message-State: AOAM533sh8xICz+UyeDIr5x3PWFgKLazsrsnRuD/EO4AGI1gEMyOUim3
        Er9f4vpgdEQ9iKJeCgqikTq2JwpPljL8JbMSRyWwFba8
X-Google-Smtp-Source: ABdhPJwSe/72XmbTSWFdmsoVvKWZguFKHBkrXFR6IF7ZQzpMbMkF/EImVFYJ32ZOs8MsPHRy9lVjEnw6pwRc7e4VVyU=
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr9673574ejc.348.1613754677790;
 Fri, 19 Feb 2021 09:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
 <20210218195046.19280-2-olga.kornievskaia@gmail.com> <7587df15-6f6f-3581-8bae-a648315cfae9@schaufler-ca.com>
 <CAN-5tyGff24KwP-sTezU=h39_zTVTgh10D-6eT220SO=HSk3+w@mail.gmail.com> <9da50d82-85d3-3a2f-df00-586b8e3e890f@schaufler-ca.com>
In-Reply-To: <9da50d82-85d3-3a2f-df00-586b8e3e890f@schaufler-ca.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 19 Feb 2021 12:11:10 -0500
Message-ID: <CAN-5tyEkaiePjMhssvOw_JbAB57n0d_QZEgJwHk3362eJjdM8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] NFSv4 account for selinux security context when
 deciding to share superblock
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

On Thu, Feb 18, 2021 at 6:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/18/2021 2:39 PM, Olga Kornievskaia wrote:
> > On Thu, Feb 18, 2021 at 5:07 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 2/18/2021 11:50 AM, Olga Kornievskaia wrote:
> >>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>
> >>> Keep track of whether or not there was an selinux context mount
> >>> options during the mount.
> >> This may be the intention, but it's not what the change you're
> >> introducing here does.
> > Can you explain why, as I must be doing something wrong? I'm familiar
> > with NFS but not with Selinux and I thought I was doing the correct
> > changes to the Selinux. If that's not the case would you share what
> > has been done incorrectly.
>
> The code in this patch is generic for any LSM that wants to provide
> a security_sb_mnt_opts_compat() hook. Your 1/2 patch deals with how
> the hook provided by SELinux behaves.  All the behavior that is specific
> to SELinux should be in the SELinux hook. If you can state the behavior
> generically you should do that here.

Hopefully by removing specific reference to the selinux and sticking
with LSM addresses your comment. To NFS it's a security context it
doesn't care if it's selinux or something else.

> >>>  While deciding if the superblock can be
> >>> shared for the new mount, check for if we had selinux context on
> >>> the existing mount and call into selinux to tell if new passed
> >>> in selinux context is compatible with the existing mount's options.
> >> You're describing how you expect the change to be used, not
> >> what it does. If I am the author of a security module other
> >> than SELinux (which, it turns out, I am) what would I use this
> >> for? How might this change interact with my security module?
> >> Is this something I might exploit? If I am the author of a
> >> filesystem other than NFS (which I am not) should I be doing
> >> the same thing?
> > I'm not sure I'm understanding your questions. I'm solving a bug that
> > exists when NFS interacts with selinux.
>
> Right, but you're introducing an LSM interface to do so. LSM interfaces
> are expected to be usable by any security module. Smack ought to be able
> to provide NFS support, so might be expected to provide a hook for
> security_sb_mnt_opts_compat().

So I thought to address how a filesystem uses the hooks should have
been in the first patch and I added it here. But addressing how
another LSM module (like Smack) would use it again should be coming
from the first patch. It's a new hook to compare mount options and if
Smack were to implement some security mount options it would implement
a comparison function of the two.


>
> >  This is really not a feature
> > that I'm introducing. I thought it was somewhat descriptive with an
> > example that if you want to mount with different security contexts but
> > whatever you are mounting has a possibility of sharing the same
> > superblock, we need to be careful and take security contexts that are
> > being used by those mount into account to decide whether or not to
> > share the superblock. Again I thought that's exactly what the commit
> > states. A different security module, if it acts on security context,
> > would have to have the same ability to compare if one context options
> > are compatible with anothers.
>
> Not everyone is going to extrapolate the general behavior from
> the SELinux behavior. Your description of the SELinux behavior in 1/2
> is fine. I'm looking for how a module other than SELinux would use
> this.
>
> >  Another filesystem can decide if it
> > wants to share superblocks based on compatibility of existing security
> > context and new one. Is that what you are asking?
>
> What I'm asking is whether this should be a concern for filesystems
> in general, in which case this isn't the right place to make this change.
>
> >
> >
> >>> Previously, NFS wasn't able to do the following 2mounts:
> >>> mount -o vers=4.2,sec=sys,context=system_u:object_r:root_t:s0
> >>> <serverip>:/ /mnt
> >>> mount -o vers=4.2,sec=sys,context=system_u:object_r:swapfile_t:s0
> >>> <serverip>:/scratch /scratch
> >>>
> >>> 2nd mount would fail with "mount.nfs: an incorrect mount option was
> >>> specified" and var log messages would have:
> >>> "SElinux: mount invalid. Same superblock, different security
> >>> settings for.."
> >>>
> >>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>> ---
> >>>  fs/nfs/fs_context.c       | 3 +++
> >>>  fs/nfs/internal.h         | 1 +
> >>>  fs/nfs/super.c            | 4 ++++
> >>>  include/linux/nfs_fs_sb.h | 1 +
> >>>  4 files changed, 9 insertions(+)
> >>>
> >>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> >>> index 06894bcdea2d..8067f055d842 100644
> >>> --- a/fs/nfs/fs_context.c
> >>> +++ b/fs/nfs/fs_context.c
> >>> @@ -448,6 +448,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
> >>>       if (opt < 0)
> >>>               return ctx->sloppy ? 1 : opt;
> >>>
> >>> +     if (fc->security)
> >>> +             ctx->has_sec_mnt_opts = 1;
> >>> +
> >>>       switch (opt) {
> >>>       case Opt_source:
> >>>               if (fc->source)
> >>> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> >>> index 62d3189745cd..08f4f34e8cf5 100644
> >>> --- a/fs/nfs/internal.h
> >>> +++ b/fs/nfs/internal.h
> >>> @@ -96,6 +96,7 @@ struct nfs_fs_context {
> >>>       char                    *fscache_uniq;
> >>>       unsigned short          protofamily;
> >>>       unsigned short          mountfamily;
> >>> +     bool                    has_sec_mnt_opts;
> >>>
> >>>       struct {
> >>>               union {
> >>> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> >>> index 4034102010f0..0a2d252cf90f 100644
> >>> --- a/fs/nfs/super.c
> >>> +++ b/fs/nfs/super.c
> >>> @@ -1058,6 +1058,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
> >>>                                                &sb->s_blocksize_bits);
> >>>
> >>>       nfs_super_set_maxbytes(sb, server->maxfilesize);
> >>> +     server->has_sec_mnt_opts = ctx->has_sec_mnt_opts;
> >>>  }
> >>>
> >>>  static int nfs_compare_mount_options(const struct super_block *s, const struct nfs_server *b,
> >>> @@ -1174,6 +1175,9 @@ static int nfs_compare_super(struct super_block *sb, struct fs_context *fc)
> >>>               return 0;
> >>>       if (!nfs_compare_userns(old, server))
> >>>               return 0;
> >>> +     if ((old->has_sec_mnt_opts || fc->security) &&
> >>> +                     security_sb_mnt_opts_compat(sb, fc->security))
> >>> +             return 0;
> >>>       return nfs_compare_mount_options(sb, server, fc);
> >>>  }
> >>>
> >>> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> >>> index 38e60ec742df..3f0acada5794 100644
> >>> --- a/include/linux/nfs_fs_sb.h
> >>> +++ b/include/linux/nfs_fs_sb.h
> >>> @@ -254,6 +254,7 @@ struct nfs_server {
> >>>
> >>>       /* User namespace info */
> >>>       const struct cred       *cred;
> >>> +     bool                    has_sec_mnt_opts;
> >>>  };
> >>>
> >>>  /* Server capabilities */
>
