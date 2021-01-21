Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B82FF1D1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 18:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbhAUR0l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 12:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387848AbhAURZ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 12:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611249839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZ8LycJ+F4Sr8OUibD8MTW+9AWyXf4FxW/0wGLz0O/0=;
        b=edRuqq3mY8/g+9hmkiOuwvVaR0KQJ3LGii1kNXdZpkvSJoPT0qvho8mcpx7XfVj/OrJd9i
        qz/CeglBFhzIzQIwgDdI3EuDsKyU8vf2NN4rULTDhPByNlqChEJl0fSg+PFfDMOoU4Lxqz
        cUIURULTSdCQmSLZDxGGV9WGhGN26FM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427--lZbCy67Nn-cFBWcJYNtYQ-1; Thu, 21 Jan 2021 12:23:55 -0500
X-MC-Unique: -lZbCy67Nn-cFBWcJYNtYQ-1
Received: by mail-ed1-f71.google.com with SMTP id n18so1518621eds.2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 09:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZ8LycJ+F4Sr8OUibD8MTW+9AWyXf4FxW/0wGLz0O/0=;
        b=SR0DhaSK0lCTBUkhkw6ryl6DW/ys8iZ6JRh3CVdPwiJGkBQTHt/gUb0vgaNp56Eu/h
         oghDhLlStaqRfbtE7NYrfgb59/isrqYv4qtZK5LeswMT+LESZKHwLhTaDOEs7uBZA2s3
         nJJVNC8Gk90cnnBmH9fQC0ZWBgTwhPpIvwG4I5mnRSmmyG5Uam7Txj3Aq9h66WB88Hk7
         StUdFA2+0Yp0A7jyOI/OCu5ckR4Y4GDJNHOoOCGX8fs7DXPN6fgYx77hrnXRgG+H4xZu
         4Ndc1NRU3MTu/F7uKZeOIdjbJeguq0ygz87ElmAJ8kdLd7nMHybXxnGtD1CznumRw6Fs
         kvOQ==
X-Gm-Message-State: AOAM531MciqhXxjp6v64pLCePY8oLSJwA8srpCJW5ZfYdwZhTNhyDHz1
        IIu/+4HPpu6RLe2q8zygUvpAnO7jftwUyJlrW3ymf6Cpjt1J+ccgxud6nhRZGwRRC1e2IK8e3pf
        ewIDGAr94dPLRmi3eA41+6NnMO+D594408LRk
X-Received: by 2002:a17:906:705:: with SMTP id y5mr354142ejb.83.1611249833916;
        Thu, 21 Jan 2021 09:23:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvCHQDb5sk7iqXGLhEm7tnfiX0AHiznsKlHmiwf+4hRuQhGXca/dCzVuVvlBiLSd/4CUaBSMEtCZzrNJ4XMgE=
X-Received: by 2002:a17:906:705:: with SMTP id y5mr354130ejb.83.1611249833755;
 Thu, 21 Jan 2021 09:23:53 -0800 (PST)
MIME-Version: 1.0
References: <1611246016-21129-1-git-send-email-dwysocha@redhat.com>
 <1611246016-21129-2-git-send-email-dwysocha@redhat.com> <4a3f8595d74221ca560e7f92f1b3abc68f5d48a1.camel@hammerspace.com>
In-Reply-To: <4a3f8595d74221ca560e7f92f1b3abc68f5d48a1.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 21 Jan 2021 12:23:17 -0500
Message-ID: <CALF+zOmNZPNam11aX_qf1q_1gG1ZcHam_uPriURXydbWJAe0Fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] SUNRPC: Move simple_get_bytes and
 simple_get_netobj into xdr.h
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 12:05 PM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Thu, 2021-01-21 at 11:20 -0500, Dave Wysochanski wrote:
> > Remove duplicated helper functions to parse opaque XDR objects
> > and place inside the xdr.h file.  Also update comment which
> > is wrong since lockd is not the only user of xdr_netobj.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  include/linux/sunrpc/xdr.h          | 33
> > +++++++++++++++++++++++++++++++--
> >  net/sunrpc/auth_gss/auth_gss.c      | 29 ---------------------------
> > --
> >  net/sunrpc/auth_gss/gss_krb5_mech.c | 29 ---------------------------
> > --
> >  3 files changed, 31 insertions(+), 60 deletions(-)
> >
> > diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> > index 19b6dea27367..8ef788ff80b9 100644
> > --- a/include/linux/sunrpc/xdr.h
> > +++ b/include/linux/sunrpc/xdr.h
> > @@ -25,8 +25,7 @@
> >  #define XDR_QUADLEN(l)         (((l) + 3) >> 2)
> >
> >  /*
> > - * Generic opaque `network object.' At the kernel level, this type
> > - * is used only by lockd.
> > + * Generic opaque `network object.'
> >   */
> >  #define XDR_MAX_NETOBJ         1024
> >  struct xdr_netobj {
> > @@ -34,6 +33,36 @@ struct xdr_netobj {
> >         u8 *                    data;
> >  };
> >
> > +static inline const void *
> > +simple_get_bytes(const void *p, const void *end, void *res, size_t
> > len)
> > +{
> > +       const void *q = (const void *)((const char *)p + len);
> > +       if (unlikely(q > end || q < p))
> > +               return ERR_PTR(-EFAULT);
> > +       memcpy(res, p, len);
> > +       return q;
> > +}
> > +
> > +static inline const void *
> > +simple_get_netobj(const void *p, const void *end, struct xdr_netobj
> > *dest)
> > +{
> > +       const void *q;
> > +       unsigned int len;
> > +
> > +       p = simple_get_bytes(p, end, &len, sizeof(len));
> > +       if (IS_ERR(p))
> > +               return p;
> > +       q = (const void *)((const char *)p + len);
> > +       if (unlikely(q > end || q < p))
> > +               return ERR_PTR(-EFAULT);
> > +       dest->data = kmemdup(p, len, GFP_NOFS);
> > +       if (unlikely(dest->data == NULL))
> > +               return ERR_PTR(-ENOMEM);
> > +       dest->len = len;
> > +       return q;
> > +}
> > +
>
> Hmm... I'm not too keen on having these in sunrpc/xdr.h. For one thing,
> they do not describe objects that are XDR encoded. Secondly, their
> naming isn't really consistent with any of the existing conventions for
> xdr.
>
> Can we please rather just create a new header file that is private in
> net/sunrpc/auth_gss/ ?
>

Sure.  Do you have any preference for the name?
internal.h
auth_gss.h
something else...


> > +
> >  /*
> >   * Basic structure for transmission/reception of a client XDR
> > message.
> >   * Features a header (for a linear buffer containing RPC headers
> > diff --git a/net/sunrpc/auth_gss/auth_gss.c
> > b/net/sunrpc/auth_gss/auth_gss.c
> > index 4ecc2a959567..228456b22b23 100644
> > --- a/net/sunrpc/auth_gss/auth_gss.c
> > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > @@ -125,35 +125,6 @@ struct gss_auth {
> >         clear_bit(RPCAUTH_CRED_NEW, &cred->cr_flags);
> >  }
> >
> > -static const void *
> > -simple_get_bytes(const void *p, const void *end, void *res, size_t
> > len)
> > -{
> > -       const void *q = (const void *)((const char *)p + len);
> > -       if (unlikely(q > end || q < p))
> > -               return ERR_PTR(-EFAULT);
> > -       memcpy(res, p, len);
> > -       return q;
> > -}
> > -
> > -static inline const void *
> > -simple_get_netobj(const void *p, const void *end, struct xdr_netobj
> > *dest)
> > -{
> > -       const void *q;
> > -       unsigned int len;
> > -
> > -       p = simple_get_bytes(p, end, &len, sizeof(len));
> > -       if (IS_ERR(p))
> > -               return p;
> > -       q = (const void *)((const char *)p + len);
> > -       if (unlikely(q > end || q < p))
> > -               return ERR_PTR(-EFAULT);
> > -       dest->data = kmemdup(p, len, GFP_NOFS);
> > -       if (unlikely(dest->data == NULL))
> > -               return ERR_PTR(-ENOMEM);
> > -       dest->len = len;
> > -       return q;
> > -}
> > -
> >  static struct gss_cl_ctx *
> >  gss_cred_get_ctx(struct rpc_cred *cred)
> >  {
> > diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c
> > b/net/sunrpc/auth_gss/gss_krb5_mech.c
> > index ae9acf3a7389..99ea36d5eefe 100644
> > --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
> > +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
> > @@ -143,35 +143,6 @@
> >         return NULL;
> >  }
> >
> > -static const void *
> > -simple_get_bytes(const void *p, const void *end, void *res, int len)
> > -{
> > -       const void *q = (const void *)((const char *)p + len);
> > -       if (unlikely(q > end || q < p))
> > -               return ERR_PTR(-EFAULT);
> > -       memcpy(res, p, len);
> > -       return q;
> > -}
> > -
> > -static const void *
> > -simple_get_netobj(const void *p, const void *end, struct xdr_netobj
> > *res)
> > -{
> > -       const void *q;
> > -       unsigned int len;
> > -
> > -       p = simple_get_bytes(p, end, &len, sizeof(len));
> > -       if (IS_ERR(p))
> > -               return p;
> > -       q = (const void *)((const char *)p + len);
> > -       if (unlikely(q > end || q < p))
> > -               return ERR_PTR(-EFAULT);
> > -       res->data = kmemdup(p, len, GFP_NOFS);
> > -       if (unlikely(res->data == NULL))
> > -               return ERR_PTR(-ENOMEM);
> > -       res->len = len;
> > -       return q;
> > -}
> > -
> >  static inline const void *
> >  get_key(const void *p, const void *end,
> >         struct krb5_ctx *ctx, struct crypto_sync_skcipher **res)
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

