Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287A72D4828
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbgLIRkV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbgLIRkN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 12:40:13 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FCCC0613D6
        for <linux-nfs@vger.kernel.org>; Wed,  9 Dec 2020 09:39:32 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id p22so2463320edu.11
        for <linux-nfs@vger.kernel.org>; Wed, 09 Dec 2020 09:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBZzAfNzfOou0B8fifSYJ0Zgmw/sL+t1Bu/8GF9krME=;
        b=ceH0ica9+uzFYJHMzGxTwxiyyhwt3PqKG/93nw1+WFrptzaOo4soGviZwsWI+3RRb8
         FG+IXMFWiSgYqtiAyQmPikIdDizpCseRrjIJ1uRByouGAXASRcdVEKvcROhH7OumMzxI
         beoqSq5SNmhe7nP1SSN8PsdWI4hHejdqdsfwEnqwAQ8ZYHVS6dRrxnvpY/Sl3raZs08o
         e5cXhcJLvyCgun0UPcaloJ6jJ+rUhpZjt+KyW9oyPBmqYglcGMn3XKWYpKQS2ULETV2i
         QI1fJFQiz2HG3UhchNXo8b2bWp+ONafN6pdsOD4kSOvdL6Nf9Uu3LQttUqVFArjSvjAl
         hdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBZzAfNzfOou0B8fifSYJ0Zgmw/sL+t1Bu/8GF9krME=;
        b=ZlP6Fipnuf385Ps2R4w2J9xq8vKvIADA/yTJXnbtKxpF3t83I5oa23wFXdAZXKfWlu
         oQCMkwydIg4U7PRcZFlVqqxzUU9WE+w2LX2b6c7R/CkuP00sYuj5NjyPd7kxuTbeJZup
         93ymB2N/txPODwDAfVKMCNnXvjWN03N+6BKQITCgYIuRwPW8sti5lnlXe0YRyAwi4z3y
         LCeHyhM7FSobmfSgopNGkV0/LBuOgFOY92WZMO2N90t1h+oQ+pNdxWSWWOTDt2kIuXRs
         gNZJmNi54HSyX27O0YoH97g2zGNN7jwMP+VsoOzwNQXXB/ylSaUtZCayvhrk3xO7XGKu
         X03Q==
X-Gm-Message-State: AOAM530tFVIrtxZH27zUhYC4xvb4KzHKkazaIV0PV8KKoFCCnN17pBuL
        1+V7nJkncrdT1/kC6a6+d6b30iFNZDrvNMUm8EErF11v
X-Google-Smtp-Source: ABdhPJwUg4e39/38CuwhQ+frgX7yGI0Ho3lN+0/qpeHk/i7ppSQKajA9wAVng8cSHoYqANWKsEq4d7RZG1RBNxV+DbY=
X-Received: by 2002:aa7:d886:: with SMTP id u6mr3119710edq.139.1607535571611;
 Wed, 09 Dec 2020 09:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
 <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de> <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
 <14eac8ec352c76206c811f75b130957bb75ff590.camel@hammerspace.com>
 <CAN-5tyFwgWTBsCOBJ=7ELS4md4SBgiMQ4EPAS7LCxzCK74X13g@mail.gmail.com>
 <a70034b9506c650aa10480727f9f5e00cc71e25a.camel@hammerspace.com>
 <CAN-5tyFUmQQeQQjHtmetvTN2rcJpf3KwPbhm+6TB_N33auirag@mail.gmail.com> <CAFX2JfnMpEfqZFUYWQD9rV0VCvyYAejNWbNMUvW44fvhBeGhBw@mail.gmail.com>
In-Reply-To: <CAFX2JfnMpEfqZFUYWQD9rV0VCvyYAejNWbNMUvW44fvhBeGhBw@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 9 Dec 2020 12:39:20 -0500
Message-ID: <CAN-5tyHJ0xChJxydZuqcJw3AZRDG708v2aSMSCuj3xc+57caDw@mail.gmail.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 9, 2020 at 12:29 PM Anna Schumaker <schumaker.anna@gmail.com> wrote:
>
> On Wed, Dec 9, 2020 at 12:22 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Wed, Dec 9, 2020 at 12:12 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> > >
> > > On Wed, 2020-12-09 at 12:07 -0500, Olga Kornievskaia wrote:
> > > > On Wed, Dec 9, 2020 at 11:59 AM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Fri, 2020-12-04 at 15:00 -0500, Olga Kornievskaia wrote:
> > > > > > I object to putting the disable patch in, I think we need to fix
> > > > > > the
> > > > > > problem.
> > > > >
> > > > > I can't see the problem is fixable in 5.10. There are way too many
> > > > > changes required, and we're in the middle of the week of the last -
> > > > > rc
> > > > > for 5.10. Furthermore, there are no regressions introduced by just
> > > > > disabling the functionality, because READ_PLUS has only just been
> > > > > merged in this release cycle.
> > > > >
> > > > > I therefore strongly suggest we just send [PATCH 1/3] NFS: Disable
> > > > > READ_PLUS by default and then fix the rest in 5.11.
> > > >
> > > > Sure, but shouldn't there be more ifdefs inside of the xdr code to
> > > > turn it off completely?
> > >
> > > AFAICT, those functions are not called by anything else, so as long as
> > > the READ_PLUS client functionality is disabled, they should be
> > > harmless.
> >
> > Is it benign that in the normal read path sunrpc will be calling a new
> > function of xdr_realign_pages()? Non readplus code didn't have it.
>
> It should be. All I did was pull out some code from xdr_align_pages()
> and put it into a new function. `git show --diff-algorithm=histogram`
> says this is what I did:

Ok sounds good then. I just wanted to double check.

> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 909920fab93b..d93bcad5ba9f 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -997,10 +997,25 @@ __be32 * xdr_inline_decode(struct xdr_stream
> *xdr, size_t nbytes)
>  }
>  EXPORT_SYMBOL_GPL(xdr_inline_decode);
>
> +static void xdr_realign_pages(struct xdr_stream *xdr)
> +{
> +       struct xdr_buf *buf = xdr->buf;
> +       struct kvec *iov = buf->head;
> +       unsigned int cur = xdr_stream_pos(xdr);
> +       unsigned int copied, offset;
> +
> +       /* Realign pages to current pointer position */
> +       if (iov->iov_len > cur) {
> +               offset = iov->iov_len - cur;
> +               copied = xdr_shrink_bufhead(buf, offset);
> +               trace_rpc_xdr_alignment(xdr, offset, copied);
> +               xdr->nwords = XDR_QUADLEN(buf->len - cur);
> +       }
> +}
> +
>  static unsigned int xdr_align_pages(struct xdr_stream *xdr, unsigned int len)
>  {
>         struct xdr_buf *buf = xdr->buf;
> -       struct kvec *iov;
>         unsigned int nwords = XDR_QUADLEN(len);
>         unsigned int cur = xdr_stream_pos(xdr);
>         unsigned int copied, offset;
> @@ -1008,15 +1023,7 @@ static unsigned int xdr_align_pages(struct
> xdr_stream *xdr, unsigned int len)
>         if (xdr->nwords == 0)
>                 return 0;
>
> -       /* Realign pages to current pointer position */
> -       iov = buf->head;
> -       if (iov->iov_len > cur) {
> -               offset = iov->iov_len - cur;
> -               copied = xdr_shrink_bufhead(buf, offset);
> -               trace_rpc_xdr_alignment(xdr, offset, copied);
> -               xdr->nwords = XDR_QUADLEN(buf->len - cur);
> -       }
> -
> +       xdr_realign_pages(xdr);
>         if (nwords > xdr->nwords) {
>                 nwords = xdr->nwords;
>                 len = nwords << 2;
>
>
> >
> > >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
