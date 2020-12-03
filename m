Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA152CDFB8
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 21:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgLCUcT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 15:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgLCUcT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 15:32:19 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6FDC061A4F
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 12:31:38 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id cw27so3533255edb.5
        for <linux-nfs@vger.kernel.org>; Thu, 03 Dec 2020 12:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7ZW2EIWp0/rl6e0h48rxwD5qR0jl7ikqoyfMg8u2VQ=;
        b=Y2x6+pir0YItG2IGYZb2xOGgu9dm9s/ANuhx3UTNTwsPGLURaWy4pSYHs/EqJfBU+V
         eXSXCgLvcE+8nH/uYRg+HLBgdnaXcC1D9+Gxm7DdVp/vlyNgDwyg7bCOgbgp/qIlgUwI
         +3DYpE3VLoJs+3QRDloXMBMVucp5xFuEctHuxC+4AJ4H3hsZYFOOF3nis+z2Cj1ZxXbo
         itTeDtBAuIvVRUCjIzuUkL8ihaxXB+Cj3EK9P/IqA6ikjoPKs/dkFLvc70Zk1GVKOLnh
         APa9drmEx8XTVGqmHI0bckgI9lfBnTrhK050VTtzmdF0b8estUBwrbg+vbJZSNROtBkk
         bkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7ZW2EIWp0/rl6e0h48rxwD5qR0jl7ikqoyfMg8u2VQ=;
        b=OX58kaF8zoLQEtiDagDe1fMI7uEaHUZcMYrFXawan6JNLlLqwjmmqXDI691nptEGK0
         xsQe8U7oHNZTdSGrZI5oV9o7DSBFNZqsvrv7Mne9X9jEbE+JsyKVkkpjzp2AacANsfK9
         8x5qv78H0iwrIbJma3HoNQXa8caViHD0es1/pwYxWpV1vtMYWl4mdBHxx8PWnwJtuD2K
         qGVypvteatuX9QrGJVWavbFhciRq0hhChJoZwb9R3J4XjWaFWT7Q2U+8n+4iVEuimmqN
         TXT04woPijSCLu0kB7Nqjdkp5L0kH0anejupvrw5s/TpRqD4oGI7qLhY+FX5ehfteK1K
         0pRw==
X-Gm-Message-State: AOAM533R/QOA1tjsuQ9LwI0tE6tlFDWCwgFkG/3MHAxLYX6YXwWbn3fD
        sZB6Cd8T/apNdnI+4jKaU6Y0yEHXryBusrelXGs=
X-Google-Smtp-Source: ABdhPJxUnaf33f8TivIb6Ujf4u8zvkXqf4Bg1PMGGY7u97XjuQ86Bb7MhFWMbZOEiaXjYm7mrzIEQpcPiPtSk5i2fJ4=
X-Received: by 2002:aa7:dcd2:: with SMTP id w18mr4616441edu.281.1607027497037;
 Thu, 03 Dec 2020 12:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
 <20201203201841.103294-3-Anna.Schumaker@Netapp.com> <8CE5CE8C-9301-4250-B077-ACE23969C19A@oracle.com>
In-Reply-To: <8CE5CE8C-9301-4250-B077-ACE23969C19A@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 3 Dec 2020 15:31:20 -0500
Message-ID: <CAFX2JfnsHskDd+tsGcZ1-JNaWpZ9V4c-5=x2VE4mwC6p+MhfYQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] NFS: Allocate a scratch page for READ_PLUS
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 3, 2020 at 3:27 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Dec 3, 2020, at 3:18 PM, schumaker.anna@gmail.com wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > We might need this to better handle shifting around data in the reply
> > buffer.
> >
> > Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > fs/nfs/nfs42xdr.c       |  2 ++
> > fs/nfs/read.c           | 13 +++++++++++--
> > include/linux/nfs_xdr.h |  1 +
> > 3 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > index 8432bd6b95f0..ef095a5f86f7 100644
> > --- a/fs/nfs/nfs42xdr.c
> > +++ b/fs/nfs/nfs42xdr.c
> > @@ -1297,6 +1297,8 @@ static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
> >       struct compound_hdr hdr;
> >       int status;
> >
> > +     xdr_set_scratch_buffer(xdr, page_address(res->scratch), PAGE_SIZE);
>
> I intend to submit this for v5.11:
>
> https://git.linux-nfs.org/?p=cel/cel-2.6.git;a=commit;h=0ae4c3e8a64ace1b8d7de033b0751afe43024416

Thanks for the heads up! This patch can probably be deferred until
yours goes in.

>
> But seems like enough callers need a scratch buffer that the XDR
> layer should set up it transparently for all requests.

That could work too, and save some headache.

Anna

>
>
> > +
> >       status = decode_compound_hdr(xdr, &hdr);
> >       if (status)
> >               goto out;
> > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > index eb854f1f86e2..012deb5a136f 100644
> > --- a/fs/nfs/read.c
> > +++ b/fs/nfs/read.c
> > @@ -37,15 +37,24 @@ static struct kmem_cache *nfs_rdata_cachep;
> >
> > static struct nfs_pgio_header *nfs_readhdr_alloc(void)
> > {
> > -     struct nfs_pgio_header *p = kmem_cache_zalloc(nfs_rdata_cachep, GFP_KERNEL);
> > +     struct nfs_pgio_header *p;
> > +     struct page *page;
> >
> > -     if (p)
> > +     page = alloc_page(GFP_KERNEL);
> > +     if (!page)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     p = kmem_cache_zalloc(nfs_rdata_cachep, GFP_KERNEL);
> > +     if (p) {
> >               p->rw_mode = FMODE_READ;
> > +             p->res.scratch = page;
> > +     }
> >       return p;
> > }
> >
> > static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
> > {
> > +     __free_page(rhdr->res.scratch);
> >       kmem_cache_free(nfs_rdata_cachep, rhdr);
> > }
> >
> > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > index d63cb862d58e..e0a1c97f11a9 100644
> > --- a/include/linux/nfs_xdr.h
> > +++ b/include/linux/nfs_xdr.h
> > @@ -659,6 +659,7 @@ struct nfs_pgio_res {
> >       struct nfs_fattr *      fattr;
> >       __u64                   count;
> >       __u32                   op_status;
> > +     struct page *           scratch;
> >       union {
> >               struct {
> >                       unsigned int            replen;         /* used by read */
> > --
> > 2.29.2
> >
>
> --
> Chuck Lever
>
>
>
