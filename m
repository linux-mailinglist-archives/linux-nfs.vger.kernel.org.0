Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD712A8794
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 20:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgKETvY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 14:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETvX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 14:51:23 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78DBC0613CF;
        Thu,  5 Nov 2020 11:51:21 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id gn41so4407729ejc.4;
        Thu, 05 Nov 2020 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvL2gQrZbvhosCbXYOfupkOVgRLOaURmIAd+j6qv88Q=;
        b=FinCmXzZ7jfFV8NRSrl0HrA5CIrMKNwgsmETg987z2LIIlw7m3/iGJm5gJxgrx0SDT
         q7AMRBhVOB4zMY7zXd8M8faILLieOAL+MrQzB6dlxHxj3a43kmyJwGfyX43lw++QR7UG
         gRy0VdHuh0tp1J9D8h6ABcxoO9TTxgqvpUW6Tvua/2PvNOX3ld+pYgNsOAm8GmTWVMr7
         crKYPNKlRW4jXxclqnVZeBH/9f6XG5R6QDuRYQq9TXryzg6VqcftHk7LWKYXjsTenA0k
         RztauCme/itE6vezP9NTzDbpVhRVakSGIU9/ojeMvsIvc/TYCGcNkbloTmR2UPS10zQJ
         K8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvL2gQrZbvhosCbXYOfupkOVgRLOaURmIAd+j6qv88Q=;
        b=bAKyGu5rAThPrv8TuuuTbxE5GbQZxPzajyZZ8CX/7zwtiYckFz0eAsaDSyafIuZk9v
         IeY2iiPRS4nEFIWQmA5xURP60dLgR1xx9506Y6Azav4QtscyXIuXUjtgP3rukSVuWgzI
         a3YrCDuyrbqMARs/gKV0F5mjye+oW4J9tkO6Xbq6eVYi9/MFzeFrjII7e9wufRbIk1rd
         uXQV+tbuvGEKCtbg1a/+uWOg55R+Q1yCz/X6PBVQHxpDGaSx/ERlY36ee6Grq2yXXMa7
         YK8KAYCaBoNKV9Li0+hu0blHdtaLxccMuLSJPc3EpzudHonbUwYBdSFqKQBv6zgUAObk
         mA1A==
X-Gm-Message-State: AOAM533ovkuiEK9TtYUPj/ENDBNyPlJFx5Igaywbw73DHeXusykDvJ4y
        UrWp7jA7iM5g/L9ZQ8BTIezTjNGeehZIA7FzCp8=
X-Google-Smtp-Source: ABdhPJx7JaCw761QBwqqqR2pdPyLh9FROD4JMcpvvfaW5oca1h0lrXPIXinlZGdFbeQnb2d6MbioKLJNc14cP4xLS48=
X-Received: by 2002:a17:906:9902:: with SMTP id zl2mr3842991ejb.510.1604605880342;
 Thu, 05 Nov 2020 11:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
 <20201105173328.2539-2-olga.kornievskaia@gmail.com> <CAFqZXNtjMEF0LO4vtEmcgwydbWfUS36d8g24J6C-NDXORYbEJg@mail.gmail.com>
In-Reply-To: <CAFqZXNtjMEF0LO4vtEmcgwydbWfUS36d8g24J6C-NDXORYbEJg@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 5 Nov 2020 14:51:09 -0500
Message-ID: <CAN-5tyF+cLpmT=rwAYvQQ445tjFKZtGq+Qzf6rDGg8COPpFRwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label
 based on LSM state
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 5, 2020 at 1:55 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Nov 5, 2020 at 6:33 PM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Currently, the client will always ask for security_labels if the server
> > returns that it supports that feature regardless of any LSM modules
> > (such as Selinux) enforcing security policy. This adds performance
> > penalty to the READDIR operation.
> >
> > Instead, query the LSM module to find if anything is enabled and
> > if not, then remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.
>
> Having spent some time staring at some of the NFS code very recently,
> I can't help but suggest: Would it perhaps be enough to decide whether
> to ask for labels based on (NFS_SB(dentry->d_sb)->caps &
> NFS_CAP_SECURITY_LABEL)? It is set when mounting the FS iff some LSM
> confirms via the security_sb_*_mnt_opts() hook that it wants the
> filesystem to give it labels (or at least that's how I interpret the
> cryptic name) [1]. It's just a shot in the dark, but it seems to fit
> this use case.
>
> [1] https://elixir.bootlin.com/linux/v5.10-rc2/source/fs/nfs/getroot.c#L148

Very interesting. I was not aware of something like that nor was it
mentioned when I asked on the selinux mailing list. I wonder if this
is a supported feature that will always stay? In that case, NFS
wouldn't need the extra hook that was added for this series. I will
try this out and report back.

>
> >
> > Suggested-by: Scott Mayhew <smayhew@redhat.com>
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c       | 5 +++++
> >  fs/nfs/nfs4xdr.c        | 3 ++-
> >  include/linux/nfs_xdr.h | 1 +
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 9e0ca9b2b210..774bc5e63ca7 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/utsname.h>
> >  #include <linux/freezer.h>
> >  #include <linux/iversion.h>
> > +#include <linux/security.h>
> >
> >  #include "nfs4_fs.h"
> >  #include "delegation.h"
> > @@ -4968,6 +4969,7 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
> >                 .count = count,
> >                 .bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
> >                 .plus = plus,
> > +               .labels = true,
> >         };
> >         struct nfs4_readdir_res res;
> >         struct rpc_message msg = {
> > @@ -4977,10 +4979,13 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
> >                 .rpc_cred = cred,
> >         };
> >         int                     status;
> > +       int sec_flags = LSM_FQUERY_VFS_XATTRS;
> >
> >         dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
> >                         dentry,
> >                         (unsigned long long)cookie);
> > +       if (!security_func_query_vfs(sec_flags))
> > +               args.labels = false;
> >         nfs4_setup_readdir(cookie, NFS_I(dir)->cookieverf, dentry, &args);
> >         res.pgbase = args.pgbase;
> >         status = nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &msg, &args.seq_args, &res.seq_res, 0);
> > diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> > index c6dbfcae7517..585d5b5cc3dc 100644
> > --- a/fs/nfs/nfs4xdr.c
> > +++ b/fs/nfs/nfs4xdr.c
> > @@ -1605,7 +1605,8 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
> >                         FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
> >                         FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
> >                         FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
> > -               attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
> > +               if (readdir->labels)
> > +                       attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
> >                 dircount >>= 1;
> >         }
> >         /* Use mounted_on_fileid only if the server supports it */
> > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > index d63cb862d58e..95f648b26525 100644
> > --- a/include/linux/nfs_xdr.h
> > +++ b/include/linux/nfs_xdr.h
> > @@ -1119,6 +1119,7 @@ struct nfs4_readdir_arg {
> >         unsigned int                    pgbase; /* zero-copy data */
> >         const u32 *                     bitmask;
> >         bool                            plus;
> > +       bool                            labels;
> >  };
> >
> >  struct nfs4_readdir_res {
> > --
> > 2.18.2
> >
>
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
