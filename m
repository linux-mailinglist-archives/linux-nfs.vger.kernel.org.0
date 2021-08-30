Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69133FBAE0
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhH3R0H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 13:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3R0G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 13:26:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A600DC061575
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 10:25:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h9so32768353ejs.4
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35lp1oOXf1wGv5PVRNy0l1tU4kQAvOjKZDYQPlC7Svg=;
        b=RMCxiTL3geXV27TQYvEMbbxZTNbMmcU8uFU7FqL4ifKzKgnIVAxIoNKpm+XfzOaqJa
         Mi3Lwxf2h/ZXQZfCiY37+ZNAMsxgCv2C72irwyeOHGcZXdNyLJbJnsF9btiAbWTEoLDG
         QvArKM4L12L/S3CJs2WuS4WEvlE2dmp3Z7ANuifgilGdo9LnGf53l1O0QCFGb2CFIPND
         zu+1HNipkJ7B8hx2hmky4um0JqDQ1/AtducSYkl/xJW1NJk2T5QUBHEC3WT8SkNjuGTI
         aptmFMgMX0MRelF8lbIYdyu6SE8ccLU+tekYu/3zWHEwPQ9k3QOm5pcOUepsre9Mz15T
         /1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35lp1oOXf1wGv5PVRNy0l1tU4kQAvOjKZDYQPlC7Svg=;
        b=ljfIwhSmcqpndUIDFwDS6piQn/wMgpt313weweUDGTQ7et1BBs9o/lTnISAnKRbUmX
         bhPS3gIxBfG2iF7WdmNvs7NMYncLMBUeCZDuN3sZoFdbBSG7dHRkThLTNDKZMJt6Mn+R
         0h+nKCKQUgOP5iGtdMN80jMJgeMmLrlV326UoTHdNmLbNzXEHlGSs3CTlKItNat+274V
         /1nHtTjx1L6iCT1B4IXtQ2I8pggr2w8w+AmCSegvIs1cePy4NTOhS8qMUD+S4ZUVdVAE
         zPjiH2hYp0MOZlEnpwsmq0iRRCbqS3CiA8zrheAxhhFkXUaEenyySLcNIu/azqRgplQ3
         mHsw==
X-Gm-Message-State: AOAM531+8uwoK+DrpSKFzfYBYSThzhRDxSY2wvY25cUxjbXqG0vFicA0
        CJkYSRTlguK99jOixkOGo9RcqvaYPl6ZLAMJdHpaYGXoBG8=
X-Google-Smtp-Source: ABdhPJwAPRgD42Hzg8NICqkw2WKvi8g2PMC7Z9CE6RWf6bSY8j8euh7RejRbItMeB7fn7cNAS88PqIwwkim81aGsSvU=
X-Received: by 2002:a17:906:6b0c:: with SMTP id q12mr26551508ejr.0.1630344311226;
 Mon, 30 Aug 2021 10:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com> <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
In-Reply-To: <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 30 Aug 2021 13:24:59 -0400
Message-ID: <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 30, 2021 at 1:04 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi Olga-
>
> > On Aug 30, 2021, at 12:53 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Given the patch "Always provide aligned buffers to the RPC read layers",
> > RPC over RDMA doesn't need to look at the tail page and add that space
> > to the write chunk.
> >
> > For the RFC 8166 compliant server, it must not write an XDR padding
> > into the write chunk (even if space was provided). Historically
> > (before RFC 8166) Solaris RDMA server has been requiring the client
> > to provide space for the XDR padding and thus this client code has
> > existed.
>
> I don't understand this change.
>
> So, the upper layer doesn't provide XDR padding any more. That doesn't
> mean Solaris servers still aren't going to want to write into it. The
> client still has to provide this padding from somewhere.
>
> This suggests that "Always provide aligned buffers to the RPC read
> layers" breaks our interop with Solaris servers. Does it?

No, I don't believe "Always provide aligned buffers to the RPC read
layers" breaks the interoperability. THIS patch would break the
interop.

If we are not willing to break the interoperability and support only
servers that comply with RFC 8166, this patch is not needed.

> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > net/sunrpc/xprtrdma/rpc_rdma.c | 15 ---------------
> > 1 file changed, 15 deletions(-)
> >
> > diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> > index c335c1361564..2c4146bcf2a8 100644
> > --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> > +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> > @@ -255,21 +255,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
> >               page_base = 0;
> >       }
> >
> > -     if (type == rpcrdma_readch)
> > -             goto out;
> > -
> > -     /* When encoding a Write chunk, some servers need to see an
> > -      * extra segment for non-XDR-aligned Write chunks. The upper
> > -      * layer provides space in the tail iovec that may be used
> > -      * for this purpose.
> > -      */
> > -     if (type == rpcrdma_writech && r_xprt->rx_ep->re_implicit_roundup)
> > -             goto out;
> > -
> > -     if (xdrbuf->tail[0].iov_len)
>
> Instead of checking for a tail, we could check
>
>         if (xdr_pad_size(xdrbuf->page_len))
>
> and provide some tail space in that case.

I don't believe this is any different than what we have now. If the
page size is non-4byte aligned then, we would still allocate size for
the padding which "SHOULD NOT" be there. But yes it is allowed to be
there.

The problem, as you know from our offline discussion, is allocating
the tail page and including it in the write chunk for the Nvidia
environment where Nvidia doesn't support use of data (user) pages and
nfs kernel allocated pages in the same segment.

Alternatively, my ask is then to change rpcrdma_convert_iovs() to
return 2 segs instead of one: one for the pages and another for the
tail.

>
> > -             rpcrdma_convert_kvec(&xdrbuf->tail[0], seg, &n);
> > -
> > -out:
> >       if (unlikely(n > RPCRDMA_MAX_SEGS))
> >               return -EIO;
> >       return n;
> > --
> > 2.27.0
> >
>
> --
> Chuck Lever
>
>
>
