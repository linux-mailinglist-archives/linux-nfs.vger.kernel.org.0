Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE21AFDF8
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2020 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSUPr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 16:15:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38442 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725905AbgDSUPr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 16:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587327345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dz1cnU6WA4NYfV3z7iMjwWJCTB21f7P+TYeg4ywg2m4=;
        b=BILOi0QwCkdUa2pqzXAMM5sEIpr95HzSDuQB/qqgYj00p4gYDwJdQNsT5VCg0p/AeZEkmK
        Ck4kmvTZBjp0zE/T1fn0JwWKJgyxhjEFOhsVAnnz6TqpC+lHJ1zt/9lZ9PuVfdFZx21kLa
        jWFxcwiVcr264viE89RPAc47Ddg2zu4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-boFYBOuBOBeDVAL7vJvTOA-1; Sun, 19 Apr 2020 16:15:43 -0400
X-MC-Unique: boFYBOuBOBeDVAL7vJvTOA-1
Received: by mail-lf1-f71.google.com with SMTP id b16so3299882lfb.19
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 13:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dz1cnU6WA4NYfV3z7iMjwWJCTB21f7P+TYeg4ywg2m4=;
        b=WB+eHC+YKhPTKm+Kg6OmJwBL03rU5avAeQa+c9exTZQgc5l8ZjbMu3/mTduX2XpizG
         +Gez+ybno15hKir0Si08mIGc2stQZHZN02s+YVZrlcEuKIzk8SznzNaV1Zb73ClbCOE5
         H9IE7v6v/9ayUAf/VUM9Xi70RdjIgeu+FwTrutrnIKV7b5fiRdcr300oZ7AxxVouEXq+
         4W3oJhe4S9nJld/1YHewuEsz9V8LNaLICRqhdmaz6IVdj+osZOWIcX03YfEANZJE5yZI
         kgC96jtY0aL+f92pYS88YPNJ+K2nqq7lghm2K/gBN27vxr9ENqMDrSGD9ARbRom9E7Zb
         qRtA==
X-Gm-Message-State: AGi0PuY54MafHYzaZkdqGqn8WJTvrcPcwCZCJcTE1VIWgtENHueAgQ4i
        LbaLqlkeS8ejCk4puzcGdJaoJmZrGV3s7QXEO4RXuPG0XOCX/jyRheVpAk0h1deN5ZXMsWSne9V
        QNnzzDrFVm1IT72mJpUKmQi3sMK2O4uxP7vJL
X-Received: by 2002:ac2:4554:: with SMTP id j20mr8543749lfm.91.1587327341810;
        Sun, 19 Apr 2020 13:15:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypLAzflkwLhWJFyl+eq9K8QUtWCaZscYI3ap+CfTzzRsH+jdTcW0VhcmNGLZQDihjdzigGXR5FoDiujXom5dBr8=
X-Received: by 2002:ac2:4554:: with SMTP id j20mr8543744lfm.91.1587327341583;
 Sun, 19 Apr 2020 13:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200419173620.GA98107@nevermore.foobar.lan> <4374ca0a713db31a6fc17d653cd5fe54f2f95ec7.camel@hammerspace.com>
In-Reply-To: <4374ca0a713db31a6fc17d653cd5fe54f2f95ec7.camel@hammerspace.com>
From:   Achilles Gaikwad <agaikwad@redhat.com>
Date:   Mon, 20 Apr 2020 01:45:30 +0530
Message-ID: <CAK0MK2rcyFybBXhAzGze=S-44+GdK7tphPVm45Qw7Z2p-p-JPA@mail.gmail.com>
Subject: Re: [PATCH] nfsd4: add filename to states output
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the help Trond!
I'll fix the code and send another patch.

Best,
- Achilles
---

On Mon, Apr 20, 2020 at 12:42 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Sun, 2020-04-19 at 23:06 +0530, Achilles Gaikwad wrote:
> > Add filename to states output for ease of debugging.
> >
> > Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
> > Signed-off-by: Kenneth Dsouza <kdsouza@redhat.com>
> > ---
> >  fs/nfsd/nfs4state.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index e32ecedece0f..0f4ed5e3fbe4 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2414,6 +2414,11 @@ static void nfs4_show_superblock(struct
> > seq_file *s, struct nfsd_file *f)
> >                                        inode->i_ino);
> >  }
> >
> > +static void nfs4_show_fname(struct seq_file *s, struct nfsd_file *f)
> > +{
> > +     seq_printf(s, "filename: \"%s\"", f->nf_file->f_path.dentry-
> > >d_name.name);
>
> Please consider using the '%pD' format specifier, as described in
> Documentation/core-api/printk-formats.rst, which is designed to avoid
> races with rename in cases like the above.
>
> Note that most debugging printks use something like %pD2 in order to
> display the name of the parent directory as well, in which case you
> want
>
>         seq_printf (s, "filename: \"%pD2\"", f->nf_file);
>
> > +}
> > +
> >  static void nfs4_show_owner(struct seq_file *s, struct
> > nfs4_stateowner *oo)
> >  {
> >       seq_printf(s, "owner: ");
> > @@ -2449,6 +2454,8 @@ static int nfs4_show_open(struct seq_file *s,
> > struct nfs4_stid *st)
> >
> >       nfs4_show_superblock(s, file);
> >       seq_printf(s, ", ");
> > +     nfs4_show_fname(s, file);
> > +     seq_printf(s, ", ");
> >       nfs4_show_owner(s, oo);
> >       seq_printf(s, " }\n");
> >       nfsd_file_put(file);
> > @@ -2480,6 +2487,8 @@ static int nfs4_show_lock(struct seq_file *s,
> > struct nfs4_stid *st)
> >       nfs4_show_superblock(s, file);
> >       /* XXX: open stateid? */
> >       seq_printf(s, ", ");
> > +     nfs4_show_fname(s, file);
> > +     seq_printf(s, ", ");
> >       nfs4_show_owner(s, oo);
> >       seq_printf(s, " }\n");
> >       nfsd_file_put(file);
> > @@ -2506,6 +2515,7 @@ static int nfs4_show_deleg(struct seq_file *s,
> > struct nfs4_stid *st)
> >       /* XXX: lease time, whether it's being recalled. */
> >
> >       nfs4_show_superblock(s, file);
> > +     nfs4_show_fname(s, file);
> >       seq_printf(s, " }\n");
> >
> >       return 0;
> > @@ -2524,6 +2534,7 @@ static int nfs4_show_layout(struct seq_file *s,
> > struct nfs4_stid *st)
> >       /* XXX: What else would be useful? */
> >
> >       nfs4_show_superblock(s, file);
> > +     nfs4_show_fname(s, file);
> >       seq_printf(s, " }\n");
> >
> >       return 0;
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

