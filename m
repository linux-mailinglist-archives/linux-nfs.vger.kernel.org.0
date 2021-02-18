Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09F31F26F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 23:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBRWkd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 17:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBRWk2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 17:40:28 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EABC061574;
        Thu, 18 Feb 2021 14:39:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jt13so8440144ejb.0;
        Thu, 18 Feb 2021 14:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTCuvFfvg+RVGlmApliroe5RH99dNBSdy6kghqEKeKM=;
        b=TTRqCZitzKXjbAYcKdh2EHw49afJposyH8zD2++2jW7hSIF7Ws+0DtKovdZLUzO9l6
         iGyhjkcj+4p4MyMfu2eEQWNRxI9QEvs12dUa9DIP8t7Wee35FfbDmY6KQgLjaAq5umzr
         BoyHINLcOfXtqvCugu4LSd4u9Y9w85ZDKXBIg1eBAi8SBA/Sj+m1nLSzWnarSRbg3EZe
         Kh88mGVSdNGFgp1K93BeZI2sqv9brftT0+/F8GXPKYoqlWkyEZYUjJ8N/dJfOIMjujcA
         lSUDmhSIvjvBTVJbMxFtkPXJym7FFvw78RV40Uzs0rYr7rC8Ns68JFdk4YLrWR8l4Enk
         ovsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTCuvFfvg+RVGlmApliroe5RH99dNBSdy6kghqEKeKM=;
        b=NRrluC30NtSDK3Cd6U8ArFyBYOseg4ZxvZesVwhG3RevPUh4rkXKGSms0vWqzeOVod
         IsJJJlnT6ZwAsMcGU429nT61D/2k4wCOQ0xIPNbc9QzujRFrni8lDm933i/psWwW1K+i
         sWJGR/ANS3hCMNLaLIXvFZgXV5c3XbQSHxmQimz7OvgtT4bP2J4WfCEmqMSskj0W/tIm
         6OHLVaynb1vXCOKTURz/rKYRcNFN22c33Qu0IoUF4Fi8NIe5IKxjAcVavHiQgz7iK0pY
         iWJPBpdQWjg+VJvL5vaBmn2cztJ6AURZaDS2paPXIJhxFYg6y92uQ59zuZOy2rHJ89KU
         z+Vg==
X-Gm-Message-State: AOAM530inlUQUHrhB0bolGvqNL/vyy8wFDH+Xg+ix6eK6RBpTRzPvz5p
        4qCQza0gO/mdmL8vBZSwwG+L+NBxmPplFVZD0Dw=
X-Google-Smtp-Source: ABdhPJxCtFy1BXkoIPKOPFFBWWLaB4B3BTpkzl3DSP+KhBK2OGGEc+89AE0h11okUYBX/wki//shpbWOVRGzLbsG9fI=
X-Received: by 2002:a17:907:35ca:: with SMTP id ap10mr6079157ejc.451.1613687986394;
 Thu, 18 Feb 2021 14:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
 <20210218195046.19280-2-olga.kornievskaia@gmail.com> <7587df15-6f6f-3581-8bae-a648315cfae9@schaufler-ca.com>
In-Reply-To: <7587df15-6f6f-3581-8bae-a648315cfae9@schaufler-ca.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 18 Feb 2021 17:39:35 -0500
Message-ID: <CAN-5tyGff24KwP-sTezU=h39_zTVTgh10D-6eT220SO=HSk3+w@mail.gmail.com>
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

On Thu, Feb 18, 2021 at 5:07 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/18/2021 11:50 AM, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Keep track of whether or not there was an selinux context mount
> > options during the mount.
>
> This may be the intention, but it's not what the change you're
> introducing here does.

Can you explain why, as I must be doing something wrong? I'm familiar
with NFS but not with Selinux and I thought I was doing the correct
changes to the Selinux. If that's not the case would you share what
has been done incorrectly.

> >  While deciding if the superblock can be
> > shared for the new mount, check for if we had selinux context on
> > the existing mount and call into selinux to tell if new passed
> > in selinux context is compatible with the existing mount's options.
>
> You're describing how you expect the change to be used, not
> what it does. If I am the author of a security module other
> than SELinux (which, it turns out, I am) what would I use this
> for? How might this change interact with my security module?
> Is this something I might exploit? If I am the author of a
> filesystem other than NFS (which I am not) should I be doing
> the same thing?

I'm not sure I'm understanding your questions. I'm solving a bug that
exists when NFS interacts with selinux. This is really not a feature
that I'm introducing. I thought it was somewhat descriptive with an
example that if you want to mount with different security contexts but
whatever you are mounting has a possibility of sharing the same
superblock, we need to be careful and take security contexts that are
being used by those mount into account to decide whether or not to
share the superblock. Again I thought that's exactly what the commit
states. A different security module, if it acts on security context,
would have to have the same ability to compare if one context options
are compatible with anothers. Another filesystem can decide if it
wants to share superblocks based on compatibility of existing security
context and new one. Is that what you are asking?


>
> >
> > Previously, NFS wasn't able to do the following 2mounts:
> > mount -o vers=4.2,sec=sys,context=system_u:object_r:root_t:s0
> > <serverip>:/ /mnt
> > mount -o vers=4.2,sec=sys,context=system_u:object_r:swapfile_t:s0
> > <serverip>:/scratch /scratch
> >
> > 2nd mount would fail with "mount.nfs: an incorrect mount option was
> > specified" and var log messages would have:
> > "SElinux: mount invalid. Same superblock, different security
> > settings for.."
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/fs_context.c       | 3 +++
> >  fs/nfs/internal.h         | 1 +
> >  fs/nfs/super.c            | 4 ++++
> >  include/linux/nfs_fs_sb.h | 1 +
> >  4 files changed, 9 insertions(+)
> >
> > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > index 06894bcdea2d..8067f055d842 100644
> > --- a/fs/nfs/fs_context.c
> > +++ b/fs/nfs/fs_context.c
> > @@ -448,6 +448,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
> >       if (opt < 0)
> >               return ctx->sloppy ? 1 : opt;
> >
> > +     if (fc->security)
> > +             ctx->has_sec_mnt_opts = 1;
> > +
> >       switch (opt) {
> >       case Opt_source:
> >               if (fc->source)
> > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > index 62d3189745cd..08f4f34e8cf5 100644
> > --- a/fs/nfs/internal.h
> > +++ b/fs/nfs/internal.h
> > @@ -96,6 +96,7 @@ struct nfs_fs_context {
> >       char                    *fscache_uniq;
> >       unsigned short          protofamily;
> >       unsigned short          mountfamily;
> > +     bool                    has_sec_mnt_opts;
> >
> >       struct {
> >               union {
> > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > index 4034102010f0..0a2d252cf90f 100644
> > --- a/fs/nfs/super.c
> > +++ b/fs/nfs/super.c
> > @@ -1058,6 +1058,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
> >                                                &sb->s_blocksize_bits);
> >
> >       nfs_super_set_maxbytes(sb, server->maxfilesize);
> > +     server->has_sec_mnt_opts = ctx->has_sec_mnt_opts;
> >  }
> >
> >  static int nfs_compare_mount_options(const struct super_block *s, const struct nfs_server *b,
> > @@ -1174,6 +1175,9 @@ static int nfs_compare_super(struct super_block *sb, struct fs_context *fc)
> >               return 0;
> >       if (!nfs_compare_userns(old, server))
> >               return 0;
> > +     if ((old->has_sec_mnt_opts || fc->security) &&
> > +                     security_sb_mnt_opts_compat(sb, fc->security))
> > +             return 0;
> >       return nfs_compare_mount_options(sb, server, fc);
> >  }
> >
> > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > index 38e60ec742df..3f0acada5794 100644
> > --- a/include/linux/nfs_fs_sb.h
> > +++ b/include/linux/nfs_fs_sb.h
> > @@ -254,6 +254,7 @@ struct nfs_server {
> >
> >       /* User namespace info */
> >       const struct cred       *cred;
> > +     bool                    has_sec_mnt_opts;
> >  };
> >
> >  /* Server capabilities */
>
