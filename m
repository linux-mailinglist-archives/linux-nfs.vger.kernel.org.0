Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F574409BF
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Oct 2021 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhJ3O5B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Oct 2021 10:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229993AbhJ3O5B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 Oct 2021 10:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635605670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfrVunqiJEwzz+TQ9Qe0hb9/y6gm/MNSEewCwtu3OYk=;
        b=KZLFDlQlJoFRYA8DLnQPz0lWig5LnMiwyy8k+XH0hGP8hawImH8G5ZhLqT3u/qOPupR2ty
        FifBClgjgVYoAZDieRKlkYz+QmmT8//0wbSWt5rl2Hp0WNucAb6l20kgvS4381tGU8WTAc
        i7SXrP/p36CjGx3e0Y0RealLcx1ceFY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-97Iv_dm5N32gjxhhlvRAGw-1; Sat, 30 Oct 2021 10:54:28 -0400
X-MC-Unique: 97Iv_dm5N32gjxhhlvRAGw-1
Received: by mail-ed1-f72.google.com with SMTP id q6-20020a056402518600b003dd81fc405eso11810882edd.1
        for <linux-nfs@vger.kernel.org>; Sat, 30 Oct 2021 07:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfrVunqiJEwzz+TQ9Qe0hb9/y6gm/MNSEewCwtu3OYk=;
        b=u1O3ReEKKvqfr/kEGkZ+mWmD262cQqox1rwUn9g6tHx+ei3gl3z8VvIfIh9aUp9JZf
         nFR+1l3sgvI6qAZxgNhPcc7MzTbrth8yTOc6rgy1oDZXjbF3a0GFX9suXSecLT/LUu9G
         fVaddhT0kjWvpE004Si5STQwNe0K6I26HgNjnfMvkjHfivaK5bWn+Pv9UuNXm/wQ9P3O
         WPof2attqPN5cMgClPBckYBY/Kvk06SxpHb11KlFI2lYvoQJQstIDwLFnUAjDz/X1ZuN
         KShAZfvJaqX6ZkhlpkoGEC2FTREx9p27PtLdW+gs5SM4SefQ+Nst4VyjMryTxO/PnWz0
         7t7A==
X-Gm-Message-State: AOAM530af97XRn+j1j/1UM0hsclqb1tZ0JwX5wct/ujnz4qQZVEbLULN
        rdVlnGGX/x9ODPJwEJP0eCrSgAQ3hl+SBT7Fl03bJRT/cvJ/pVCPTeNjG6XZKlC16cb5lUCRBkk
        /IDXN01QOkNnqf8lActiNPJqWuins4MTI0nAv
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr25190844edb.64.1635605667638;
        Sat, 30 Oct 2021 07:54:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypnIik+leJVO/rMAEBHbWg6THVWlhOr30+7SXtMRXe8noobro7zgctFd00sZt3QISkpKxahPyOOrzsttlGlAA=
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr25190819edb.64.1635605667414;
 Sat, 30 Oct 2021 07:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211029200421.65090-1-trondmy@kernel.org>
In-Reply-To: <20211029200421.65090-1-trondmy@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Sat, 30 Oct 2021 10:53:51 -0400
Message-ID: <CALF+zOmEbw_fp4wqWJ26K70tNaQVwmEC93pU6WLNUTX23DCPhg@mail.gmail.com>
Subject: Re: [PATCH 1/4] SUNRPC: Fix races when closing the socket
To:     trondmy@kernel.org
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 29, 2021 at 4:11 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Ensure that we bump the xprt->connect_cookie when we set the
> XPRT_CLOSE_WAIT flag so that another call to
> xprt_conditional_disconnect() won't race with the reconnection.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/xprt.c     | 2 ++
>  net/sunrpc/xprtsock.c | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 48560188e84d..691fe5a682b6 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -735,6 +735,8 @@ static void xprt_autoclose(struct work_struct *work)
>         unsigned int pflags = memalloc_nofs_save();
>
>         trace_xprt_disconnect_auto(xprt);
> +       xprt->connect_cookie++;
> +       smp_mb__before_atomic();
>         clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
>         xprt->ops->close(xprt);
>         xprt_release_write(xprt, NULL);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 04f1b78bcbca..b18d13479104 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1134,6 +1134,7 @@ static void xs_run_error_worker(struct sock_xprt *transport, unsigned int nr)
>
>  static void xs_sock_reset_connection_flags(struct rpc_xprt *xprt)
>  {
> +       xprt->connect_cookie++;
>         smp_mb__before_atomic();
>         clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
>         clear_bit(XPRT_CLOSING, &xprt->state);
> --
> 2.31.1
>

Hey Trond,

Are you working on this "double SYN" problem that Olga / Netapp found
or something else?

FWIW, late yesterday, I tested these patches on top of your "testing"
branch and still see "double SYNs".  I have a simple reproducer I'm
using where I fire off a bunch of "flocks" in parallel then reboot the
server.

If I can help with testing or something similar, let me know.  I also
noticed that the tracepoints that would be useful for these reconnect
problems do not have 'src' TCP port in them, which would be helpful.
I don't have a patch for that yet but started looking into it.

