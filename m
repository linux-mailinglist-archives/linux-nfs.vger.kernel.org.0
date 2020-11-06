Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C4E2A97CF
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 15:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgKFOmB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 09:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFOmB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 09:42:01 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63BC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Nov 2020 06:42:00 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id j20so1503018edt.8
        for <linux-nfs@vger.kernel.org>; Fri, 06 Nov 2020 06:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxr0wHM4FFYdibCFtj6NruVdURcziMe7yCn1U2mTfis=;
        b=lvL7sJ18VJVQqdkyHrhrKFPI2TZMvXmkjTp++9DzohTjIIGSxLgpYFKz48cYdIthqi
         H9XMlece1cu89Zt1U60AAvK4EJpmQsuU4jouCLTs/cDotjAj9XxfA3FgrgMq/3EKyl2U
         7kDD+jDLrYRm+owrFNAHQjVbODrm8m6vAbwI3oLFowyZB7AbpgvzSRUkAkZ6C6fGSrOz
         kix8/iVvAX1zsWnJvk8Xgg+zQkdvvoMh/C2WKUq+3Uh1dqHCIdmPq98SCLcShdawo8pa
         DYGUgM/ozDezx/In0xIo8oklXtl10Qz3T7+85+LAG9vDwyU9qUR/iOPB2mL32adQ6gPk
         uymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxr0wHM4FFYdibCFtj6NruVdURcziMe7yCn1U2mTfis=;
        b=GXdh58yrlJbPIU+s+ivOutQvcZvaOV9Q0g4WsEb/BUdY5qlzY0jGRDnR1+JZ96i1mB
         yDYhlLPaDIjP1Oz23nK6ojfD65yzZyFgt/lezbxgOOyLWsKRVqKbHB/Tn8paJX6qnwIi
         Fl6HOADKEBuLUb19TtGgKSsvgLLtOoYgs1yXip25B19z0LTJxBMpKodMkY5Rl/nxdql7
         QCnLetKExAgfMh0hUgTroxe2nvKoquHDFci+x1tnRgCHZZfqJ/d4MtIiDsRl3DRPyBCe
         nL/4ApBIx4bEdcan6YMZnT+g8iEaZblJjWQ/z/hccTIXgRJ7I1Q80JujkDn/cn2UmzFd
         T+sA==
X-Gm-Message-State: AOAM530EopTswip5xu9o5BVAiNqX90A8Z9p1NMO7SH6iwswIiROH0CQz
        +eOkw/fNhdkCUHXlPQblFIhN/bWset3tN8UDP94=
X-Google-Smtp-Source: ABdhPJzzZpUBd7QUt6tF/aSxdSk8D4qO/Xpf12j7wgIB5QHKOFCIS+KgyJxR4awxrs6IH5rF8zASd1DqJN9MCz7R4uY=
X-Received: by 2002:a05:6402:559:: with SMTP id i25mr2420347edx.128.1604673719454;
 Fri, 06 Nov 2020 06:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20201105221245.2838-1-olga.kornievskaia@gmail.com> <CAFqZXNtJ2fkae7Xt-+nDR79kVs=yY=9vSoZaS-V-5UKSk22s4A@mail.gmail.com>
In-Reply-To: <CAFqZXNtJ2fkae7Xt-+nDR79kVs=yY=9vSoZaS-V-5UKSk22s4A@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 6 Nov 2020 09:41:48 -0500
Message-ID: <CAN-5tyFSNqPQN0jW4005n2Yp4V02Aaf70Aa=vd_UiXowxJw0gA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFSv4.2: condition READDIR's mask for security
 label based on LSM state
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 5, 2020 at 5:37 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Nov 5, 2020 at 11:12 PM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Currently, the client will always ask for security_labels if the server
> > returns that it supports that feature regardless of any LSM modules
> > (such as Selinux) enforcing security policy. This adds performance
> > penalty to the READDIR operation.
> >
> > Client adjusts the superblock's support of the security_label based on
> > the server's support but also on the current client's configuration of
> > the LSM module(s). Thus, prior to using the default bitmask in READDIR,
> > this patch checks the server's capabilities and then instructs
> > READDIR to remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.
> >
> > v2: dropping selinux hook and using the sb cap.
>
> Thanks! I'm happy that we managed to avoid adding yet another LSM hook
> in the end :)
>
> >
> > Suggested-by: Ondrej Mosnacek <omosnace@redhat.com
> > Suggested-by: Scott Mayhew <smayhew@redhat.com>
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c       | 3 +++
> >  fs/nfs/nfs4xdr.c        | 3 ++-
> >  include/linux/nfs_xdr.h | 1 +
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 9e0ca9b2b210..9c9d9aa2a8f8 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -4968,6 +4968,7 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
> >                 .count = count,
> >                 .bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
> >                 .plus = plus,
> > +               .labels = true,
> >         };
> >         struct nfs4_readdir_res res;
> >         struct rpc_message msg = {
> > @@ -4981,6 +4982,8 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
> >         dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
> >                         dentry,
> >                         (unsigned long long)cookie);
> > +       if (!(NFS_SB(dentry->d_sb)->caps & NFS_CAP_SECURITY_LABEL))
> > +               args.labels = false;
>
> Minor nit: you could initialize .labels directly in the initializer of
> "args" like this:
>
> .labels = !!(NFS_SB(dentry->d_sb)->caps & NFS_CAP_SECURITY_LABEL),

Thank you. v3 will have it.

>
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
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
