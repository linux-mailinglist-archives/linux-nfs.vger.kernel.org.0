Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CEC2CB09F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Dec 2020 00:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgLAXEZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 18:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgLAXEY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 18:04:24 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256C5C0613D4
        for <linux-nfs@vger.kernel.org>; Tue,  1 Dec 2020 15:03:44 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f9so8001328ejw.4
        for <linux-nfs@vger.kernel.org>; Tue, 01 Dec 2020 15:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iioo4zUQdkfAOEd5mKHeAUrSYq2JI/TT91G0bGPfx0E=;
        b=MBtEMJOVsdlafWmV4J++NLmEyLTG1DYy1wgBA4RMU8LC8EpgrADYsWIQUK/foo6437
         RboJjcNAXQcP0SyirLJ6LNGW79HTP5yvQ9OIfHQFls+iN1SV2Of9rCrKbT+WylxenfB8
         lVDI0DBkN8+uYJLtd9WuF78FPUBbWyF/J0jgh6M5cNUA+QqoD0mtTmadHdgsNJI9RTkK
         Ft7/5UDHe2C+LXHqTrhL59vQudQoq2M4mwJu5Oybkov6QNviF60heds6AMMihwocTJU4
         Z0K+fqhocidB5+vSwkbn6X/3cEO7rep6cLxlCVzmvhjGUc5m/g9d/obYU2xaxC7IFw0J
         lo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iioo4zUQdkfAOEd5mKHeAUrSYq2JI/TT91G0bGPfx0E=;
        b=ZGkqn2Jzu+i4EkFJ8L4ZlMERuFaw2qEbyMkQ3lqV5aPnLe+UJSqYVY+ASqtugX/9ka
         6ns2fcGXOSauTol8byuMZazeioVTnQg+nHSm2+XmD9eKIpB/Yk3vv/kZN9JJdi7TSdkJ
         5rQCqugzSc7RrGdjqZpx43zDZuD1oBEdDWaFOd+1ONLStsnSjjmw/Zp+UggurRllURCp
         DP7gJdg5FR7VWJWNsaWfOV/IUfGRNHzCiQQCiVN13YtifVO+SrtRDEKPxdNBH42M5LN9
         q+04pwDVAB+eNj82r3qNFrhuJt0i0dTk7pq0dMFKZ4ode4avZ6JZR09I/WFX5pF3V+mV
         +8OA==
X-Gm-Message-State: AOAM5311sGc6LwVlbSgG5ziRX8ccQslnd8y/eSPUshczOyFfUU60iLYc
        CWKEQEwdfA3V1RlUJ2GKR3r06+kjKjYPLaw/0iI=
X-Google-Smtp-Source: ABdhPJwfOjTqubJc8N2CU0v1kDt3vpFwUhA41dxBnVdI5I7IIvR5BexCjpVHeNqAFq+D7RHCy9lK9YGezUDWlbL+Dn0=
X-Received: by 2002:a17:906:ae14:: with SMTP id le20mr4361105ejb.451.1606863822780;
 Tue, 01 Dec 2020 15:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201213128.13624-1-fllinden@amazon.com> <ea48cd1ddad6097901597356e22f88227d487886.camel@hammerspace.com>
In-Reply-To: <ea48cd1ddad6097901597356e22f88227d487886.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 1 Dec 2020 18:03:31 -0500
Message-ID: <CAN-5tyGxTi0uLMWmMwZdfFMvobBb_aw9Pa4J7sYJW__jaOvv_g@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: improve page handling for GETXATTR
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "fllinden@amazon.com" <fllinden@amazon.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 1, 2020 at 5:15 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2020-12-01 at 21:31 +0000, Frank van der Linden wrote:
> > XDRBUF_SPARSE_PAGES can cause problems for the RDMA transport,
> > and it's easy enough to allocate enough pages for the request
> > up front, so do that.
> >
> > Also, since we've allocated the pages anyway, use the full
> > page aligned length for the receive buffer. This will allow
> > caching of valid replies that are too large for the caller,
> > but that still fit in the allocated pages.
> >
> > Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> > ---
> >  fs/nfs/nfs42proc.c | 39 ++++++++++++++++++++++++++++++---------
> >  fs/nfs/nfs42xdr.c  | 22 +++++++++++++++++-----
> >  2 files changed, 47 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index 2b2211d1234e..bfe15ac77bd9 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -1176,11 +1176,9 @@ static ssize_t _nfs42_proc_getxattr(struct
> > inode *inode, const char *name,
> >                                 void *buf, size_t buflen)
> >  {
> >         struct nfs_server *server = NFS_SERVER(inode);
> > -       struct page *pages[NFS4XATTR_MAXPAGES] = {};
> > +       struct page **pages;
> >         struct nfs42_getxattrargs arg = {
> >                 .fh             = NFS_FH(inode),
> > -               .xattr_pages    = pages,
> > -               .xattr_len      = buflen,
> >                 .xattr_name     = name,
> >         };
> >         struct nfs42_getxattrres res;
> > @@ -1189,12 +1187,31 @@ static ssize_t _nfs42_proc_getxattr(struct
>
> Why can't we set up the page array in nfs42_proc_getxattr()? This means
> that if we get a retryable error from the server, then we perform
> multiple allocations of the same buffer.

I wonder if the same then is needed for the LISTXATTR as we allocated
pages in _nfs42_proc_listxattr() and instead should do it in
nfs42_proc_listxattr()....

> > inode *inode, const char *name,
> >                 .rpc_argp       = &arg,
> >                 .rpc_resp       = &res,
> >         };
> > -       int ret, np;
> > +       ssize_t ret, np, i;
> > +
> > +       arg.xattr_len = buflen ?: XATTR_SIZE_MAX;
> > +
> > +       ret = -ENOMEM;
> > +       np = DIV_ROUND_UP(arg.xattr_len, PAGE_SIZE);
>
> Please just use nfs_page_array_len(). It should be more efficient than
> the above.
>
> > +
> > +       pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
>
> Perhaps do this as kmalloc_array() so we don't have to zero out the
> array? If the alloc_page() fails below, you can always just truncate
> the value of 'np' before jumping to 'out_free'.
>
> Also note that we prefer to use 'sizeof(*pages)' rather than
> sizeof(struct page *).
>
> > +       if (pages == NULL)
> > +               return ret;
> > +
> > +       for (i = 0; i < np; i++) {
> > +               pages[i] = alloc_page(GFP_KERNEL);
> > +               if (!pages[i])
> > +                       goto out_free;
> > +       }
> > +
> > +       arg.xattr_pages = pages;
> >
> >         ret = nfs4_call_sync(server->client, server, &msg,
> > &arg.seq_args,
> >             &res.seq_res, 0);
> >         if (ret < 0)
> > -               return ret;
> > +               goto out_free;
> > +
> > +       ret = res.xattr_len;
> >
> >         /*
> >          * Normally, the caching is done one layer up, but for
> > successful
> > @@ -1209,16 +1226,20 @@ static ssize_t _nfs42_proc_getxattr(struct
> > inode *inode, const char *name,
> >         nfs4_xattr_cache_add(inode, name, NULL, pages,
> > res.xattr_len);
> >
> >         if (buflen) {
> > -               if (res.xattr_len > buflen)
> > -                       return -ERANGE;
> > +               if (res.xattr_len > buflen) {
> > +                       ret = -ERANGE;
> > +                       goto out_free;
> > +               }
> >                 _copy_from_pages(buf, pages, 0, res.xattr_len);
> >         }
> >
> > -       np = DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
> > +out_free:
> >         while (--np >= 0)
> >                 __free_page(pages[np]);
> >
> > -       return res.xattr_len;
> > +       kfree(pages);
> > +
> > +       return ret;
> >  }
> >
> >  static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void
> > *buf,
> > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > index 6e060a88f98c..8dfe674d1301 100644
> > --- a/fs/nfs/nfs42xdr.c
> > +++ b/fs/nfs/nfs42xdr.c
> > @@ -489,6 +489,12 @@ static int decode_getxattr(struct xdr_stream
> > *xdr,
> >                 return -EIO;
> >
> >         len = be32_to_cpup(p);
> > +
> > +       /*
> > +        * Only check against the page length here. The actual
> > +        * requested length may be smaller, but that is only
> > +        * checked against after possibly caching a valid reply.
> > +        */
> >         if (len > req->rq_rcv_buf.page_len)
> >                 return -ERANGE;
> >
> > @@ -1483,11 +1489,17 @@ static void nfs4_xdr_enc_getxattr(struct
> > rpc_rqst *req, struct xdr_stream *xdr,
> >         encode_putfh(xdr, args->fh, &hdr);
> >         encode_getxattr(xdr, args->xattr_name, &hdr);
> >
> > -       plen = args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
> > -
> > -       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> > -           hdr.replen);
> > -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
> > +       /*
> > +        * The GETXATTR op has no length field in the call, and the
> > +        * xattr data is at the end of the reply.
> > +        *
> > +        * Since the pages have already been allocated, there is no
> > +        * downside in using the page-aligned length. It will allow
> > +        * receiving and caching xattrs that are too large for the
> > +        * caller but still fit in the page-rounded value.
> > +        */
> > +       plen = round_up(args->xattr_len, PAGE_SIZE);
>
> This is the wrong place to be recalculating page buffer sizes. This
> function should have no idea what was allocated or by whom. Please just
> set the correct value for args->xattr_len in nfs42_proc_getxattr().
>
> > +       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> > hdr.replen);
> >
> >         encode_nops(&hdr);
> >  }
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
