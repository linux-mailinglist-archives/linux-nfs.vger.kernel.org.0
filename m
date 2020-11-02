Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585CB2A2F81
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 17:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgKBQRl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 11:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgKBQRk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 11:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604333858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yzwbn9p4rnPyl3APTWsLwY5GfK88lg/KxUiGugny2z8=;
        b=Bjwf1VhimuH3RdFsjJxZSt4/c6l6tLeV/akzSj8AMeIrrvQMKxleNWUXkGKCvGyf5qEfEq
        zYngHNE7VP9Pi1D8TOYQqn90rniDKDFLXiuBcDXAVi4vDLdSfyJjsdPkERYa3AiYlsojBM
        sABCt3j+JYuZnNoZZgNHFkRuLN5hnZE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-qWuR0_YcOW2-hVEMHf77ag-1; Mon, 02 Nov 2020 11:17:37 -0500
X-MC-Unique: qWuR0_YcOW2-hVEMHf77ag-1
Received: by mail-ed1-f72.google.com with SMTP id t7so6395574edt.0
        for <linux-nfs@vger.kernel.org>; Mon, 02 Nov 2020 08:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yzwbn9p4rnPyl3APTWsLwY5GfK88lg/KxUiGugny2z8=;
        b=bmjtGn0I2+vM2BOnliVbA95O7vYK7koQGCbqzuZmJugRqufiKxqcJzb4jWwr7jFnDL
         EGM1z8v98jJX6e4tIlcOpDKQ4rzD3iHf9x/5N6s0T354DrGU+Mb9JBmLBGFwvaGwYGkX
         hg1Y7Nf2IwlbN2liqQs119CxGHcEuTqtZHuv09sBRa3ge6LhZ8Dp2U3YQHlsCgJk3cTf
         3VXH39fs+L52vbmBJQpILaNJn6CW78vJ1OWrbiKQBULhllzF0PurCf+naWsh9h4kZ1rW
         IgPvzBDj9YF9e1XjOeXNmUXLb0L9bz71Z4vFfxIomqHBJkomySyIj698E50kWO/Mteo5
         mwAg==
X-Gm-Message-State: AOAM530b6iZPkzYfrlS1oL6NXryuRaiUyGLZ6I0h1U9vyE9BULXZiuVw
        BEvteDr17Yz8TSv4umPeWbBhztsw/U2zYp5ZnbUonVNG1bBHU4TPsvtTrEkLrbVg5GvA5uPat0Q
        TnIojtiE0yhJ3wyfsMb7Y7g/l8OZlLUrKVHKC
X-Received: by 2002:a50:d5dd:: with SMTP id g29mr1018925edj.344.1604333855664;
        Mon, 02 Nov 2020 08:17:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMcfNjVlorW0l4emw3r+kVtYWnG5W9L2tG56NZziW1MUBDlZpXJkotUUf0jU4PLmrPx783RdqHXhfjqwndHmg=
X-Received: by 2002:a50:d5dd:: with SMTP id g29mr1018912edj.344.1604333855476;
 Mon, 02 Nov 2020 08:17:35 -0800 (PST)
MIME-Version: 1.0
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
 <1604325011-29427-12-git-send-email-dwysocha@redhat.com> <1976524196.5308081.1604331522179.JavaMail.zimbra@desy.de>
In-Reply-To: <1976524196.5308081.1604331522179.JavaMail.zimbra@desy.de>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 2 Nov 2020 11:16:59 -0500
Message-ID: <CALF+zOkEuGEj=4Rre_ofyxCZrtj-snFshYxZX1VfURdXOcALbA@mail.gmail.com>
Subject: Re: [PATCH 11/11] NFS: Bring back nfs_dir_mapping_need_revalidate()
 in nfs_readdir()
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     trondmy <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 2, 2020 at 10:48 AM Mkrtchyan, Tigran
<tigran.mkrtchyan@desy.de> wrote:
>
> Hi Dave,
>
> ----- Original Message -----
> > From: "David Wysochanski" <dwysocha@redhat.com>
> > To: "trondmy" <trondmy@hammerspace.com>, "Anna Schumaker" <anna.schumaker@netapp.com>
> > Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> > Sent: Monday, 2 November, 2020 14:50:11
> > Subject: [PATCH 11/11] NFS: Bring back nfs_dir_mapping_need_revalidate() in nfs_readdir()
>
> > commit 79f687a3de9e ("NFS: Fix a performance regression in readdir")
> > removed nfs_dir_mapping_need_revalidate() in an attempt to fix a
> > performance regression, but had the effect that with NFSv3 the
> > pagecache would never expire while a process was reading a directory.
> > An earlier patch addressed this problem by allowing the pagecache
> > to expire but the current process to continue using the last cookie
> > returned by the server when searching the pagecache, rather than
> > always starting at 0.  Thus, bring back nfs_dir_mapping_need_revalidate()
> > so that nfsi->cache_validity & NFS_INO_INVALID_DATA will be seen
> > and nfs_revalidate_mapping() will be called with NFSv3 as well,
> > making it behave the same as NFSv4.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> > fs/nfs/dir.c | 13 ++++++++++++-
> > 1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index cbd74cbdbb9f..aeb086fb3d0a 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -872,6 +872,17 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
> >       return status;
> > }
> >
> > +static bool nfs_dir_mapping_need_revalidate(struct inode *dir)
> > +{
> > +     struct nfs_inode *nfsi = NFS_I(dir);
> > +
> > +     if (nfs_attribute_cache_expired(dir))
> > +             return true;
> > +     if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
> > +             return true;
> > +     return false;
> > +}
>
> Is this the same as:
>
> static bool nfs_dir_mapping_need_revalidate(struct inode *dir)
> {
>         struct nfs_inode *nfsi = NFS_I(dir);
>
>         return nfs_attribute_cache_expired(dir) || nfsi->cache_validity & NFS_INO_INVALID_DATA);
> }
>
Yes that's a nice simplification!

> Tigran.
>
> > +
> > /* The file offset position represents the dirent entry number.  A
> >    last cookie cache takes care of the common case of reading the
> >    whole directory.
> > @@ -903,7 +914,7 @@ static int nfs_readdir(struct file *file, struct dir_context
> > *ctx)
> >        * to either find the entry with the appropriate number or
> >        * revalidate the cookie.
> >        */
> > -     if (ctx->pos == 0 || nfs_attribute_cache_expired(inode))
> > +     if (ctx->pos == 0 || nfs_dir_mapping_need_revalidate(inode))
> >               res = nfs_revalidate_mapping(inode, file->f_mapping);
> >       if (res < 0)
> >               goto out;
> > --
> > 1.8.3.1
>

