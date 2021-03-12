Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C81339199
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 16:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhCLPn3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 10:43:29 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35742 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhCLPnO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 10:43:14 -0500
Received: by mail-ed1-f54.google.com with SMTP id dm8so8587051edb.2;
        Fri, 12 Mar 2021 07:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKVtxuyJN3WBJ9IZ3C8n2cwCCsnCGodTX/7iONzSVKU=;
        b=q7ShJD+zfKKdacRdD0PjusKcgvk9vkpn8b3lJc3Qb15TB4iVEN4RUFyDL3lFW4pc76
         7FJ41DpbO6CP6eJ/FcHw4wbaCbm2jfeeivRlXp3vYrph5vhNpJugrJRbjjAQy9iKqBfw
         dnmW6frYkYK+FpIBMY0z4yvtD+oPi1zslzFoitce44Ck/mDTnCXVNy/UzIraJN6sipBn
         L45xB35pcfrH8Ieaog4q8w8T8rxfwj8G9WhjT7Kre8uBxMHHJRwCDH2Bmm5bnYN73pk9
         A5BSV/suDtTwli1xN4AjcuiCFd3a62ScdelNYts7hhtA5TJHre8O5IXmCRk2Z6SBIXgs
         i0cg==
X-Gm-Message-State: AOAM533bvg+SpY3evRfAeRtfO1Csx3hLK4IAWnMdaZ9AYPHR4ibJd7th
        U7ziZh4Ex18tTwRdfW/htZUjQwznB4gBXqIpLNDovUdy
X-Google-Smtp-Source: ABdhPJxp+Dg61FcjReA06I8AI8+JRkKb2uW3c/Z3Fc2qVxf3vuWRuN6gg1AQmkmlS0fGjOCad0xbvvG2eHnwVDzgV9Y=
X-Received: by 2002:a05:6402:2215:: with SMTP id cq21mr15259840edb.281.1615563792548;
 Fri, 12 Mar 2021 07:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20210115174356.408688-1-omosnace@redhat.com> <CAFqZXNtssgDmhMS+p6+F2zC=ka3=bM22GpNQLO2NbSLWQroYFg@mail.gmail.com>
In-Reply-To: <CAFqZXNtssgDmhMS+p6+F2zC=ka3=bM22GpNQLO2NbSLWQroYFg@mail.gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Fri, 12 Mar 2021 10:42:56 -0500
Message-ID: <CAFX2JfmcCSKViTQjpw4Shw_3QjG_Bizp02ECOQkxN-zGCPUpkg@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: fix return value of _nfs4_get_security_label()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        David Quigley <dpquigl@davequigley.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ondrej,

On Tue, Mar 9, 2021 at 5:10 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Jan 15, 2021 at 6:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > An xattr 'get' handler is expected to return the length of the value on
> > success, yet _nfs4_get_security_label() (and consequently also
> > nfs4_xattr_get_nfs4_label(), which is used as an xattr handler) returns
> > just 0 on success.
> >
> > Fix this by returning label.len instead, which contains the length of
> > the result.
> >
> > Fixes: aa9c2669626c ("NFS: Client implementation of Labeled-NFS")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  fs/nfs/nfs4proc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 2f4679a62712a..28465d8aada64 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -5971,7 +5971,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
> >                 return ret;
> >         if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
> >                 return -ENOENT;
> > -       return 0;
> > +       return label.len;
> >  }
> >
> >  static int nfs4_get_security_label(struct inode *inode, void *buf,
> > --
> > 2.29.2
> >
>
> Ping. It's been almost 2 months now, and I can't see the patch applied
> anywhere, nor has it received any feedback from the NFS maintainers...
> Trond? Anna?

Thanks for the ping! I've queued this up for the next bugfixes pull request.

Anna
>
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
