Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD293F7D39
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Aug 2021 22:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbhHYUic (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Aug 2021 16:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231745AbhHYUi1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Aug 2021 16:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629923861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJvtz7skxQ+qXaD7ZUuAQu/BSZOhmop61bH300s9AkI=;
        b=Wy0VNSgBTEOot2TFbwaepXMXPS2IAa/xYW1tGsjXRrPZptlVJmnkmK+joQK51P2c1yn2fE
        gm6YT8u1AZlNDP1Fe1gfh/NPUX5YQz/pcmYX2xrLJfnPSN0sLM7B9fYta2Vg4hKH9oxiiT
        G8emrwqkhqziMMge1uBRDy1gcD2uny0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-BgC3M6i9MCesT14_GIgt3g-1; Wed, 25 Aug 2021 16:37:40 -0400
X-MC-Unique: BgC3M6i9MCesT14_GIgt3g-1
Received: by mail-io1-f69.google.com with SMTP id k21-20020a5e93150000b02905b30d664397so343376iom.0
        for <linux-nfs@vger.kernel.org>; Wed, 25 Aug 2021 13:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJvtz7skxQ+qXaD7ZUuAQu/BSZOhmop61bH300s9AkI=;
        b=l7h24z8y7wkKLOQUSf36y5tC/I9zk6Cc8N/UBuUG2yKD6TJ24gX4ZKUpfvqNpqF77F
         ulXvhBLn6Rqryte6ab8yj6IZgrwe+VBrK61FjM5Y7t76NY34X286BWgvYz1PdQZ9feND
         /XslAl9Sz7gaKTSvDkIr0k7Tl7X6K7o1e3wnq5POepo438/85W5utjG4Pcl0ilX5dA+v
         JAtwTnF4vxU4K9Jyv58COOv3GMlGpHiglSri5ww60kxT/30oiIoydfPbL0iwgkzy9tS3
         wCmXjol0vAonTrpdtmgFzi8k9BGUkzQvJS+n7I8FYMvviq2NZLmpAVqc+unj2WurWyXg
         03jQ==
X-Gm-Message-State: AOAM532xtfLVqwBDB+Wk1YrZo5hHmcuB+TPRWfH4P9pTEb6/My0rF11x
        69ajhGbLNq6tGBhpIZwCKAlnMVtIN9MaIjITTljlF7CxFij5ifjur/JzBKm4R+qmJYCQOhoiQud
        qcdBy2q2x+G3ae8R+G/mBqpCCPFdGVAEt22IC
X-Received: by 2002:a6b:5819:: with SMTP id m25mr260314iob.105.1629923859106;
        Wed, 25 Aug 2021 13:37:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLhLBidSrIoJ9zdMsXhqllbprUs0+iQBjVpTjVbQHfm4ypHc+SaFWB+RYU2PdZv75ABncnjPNBlQpIHVjRMJQ=
X-Received: by 2002:a6b:5819:: with SMTP id m25mr260303iob.105.1629923858860;
 Wed, 25 Aug 2021 13:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210825193314.354079-1-trond.myklebust@hammerspace.com> <86716FAD-E791-4F89-BED3-9AC934A281E7@oracle.com>
In-Reply-To: <86716FAD-E791-4F89-BED3-9AC934A281E7@oracle.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Wed, 25 Aug 2021 16:37:28 -0400
Message-ID: <CAPL3RVE9BB4Rk4qSn0=gX_7Ld4HrHmtL8fotjS-XUc8=dC4R1g@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Fix XPT_BUSY flag leakage in svc_handle_xprt()...
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I wonder if this would explain
https://bugzilla.kernel.org/show_bug.cgi?id=213887.

On Wed, Aug 25, 2021 at 3:51 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Aug 25, 2021, at 3:33 PM, trondmy@gmail.com wrote:
> >
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >
> > If the attempt to reserve a slot fails, we currently leak the XPT_BUSY
> > flag on the socket. Among other things, this make it impossible to close
> > the socket.
> >
> > Fixes: 82011c80b3ec ("SUNRPC: Move svc_xprt_received() call sites")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > net/sunrpc/svc_xprt.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 5f0d33ca4bdb..b3cff4077899 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -975,7 +975,8 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
> >               rqstp->rq_stime = ktime_get();
> >               rqstp->rq_reserved = serv->sv_max_mesg;
> >               atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
> > -     }
> > +     } else
> > +             svc_xprt_received(xprt);
> > out:
> >       trace_svc_handle_xprt(xprt, len);
> >       return len;
> > --
> > 2.31.1
>
> Looks correct. Bruce, perhaps you should pull this for 5.14-rc.
> Linus says he expects to release 5.14-final this Sunday, fyi.
>
> --
> Chuck Lever
>
>
>

