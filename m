Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A056E175F91
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 17:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgCBQ1v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Mar 2020 11:27:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25122 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726831AbgCBQ1v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Mar 2020 11:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583166470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JWW/WIb3sM0d6LnzQC1mrlResoNDmGFQ94EYgt2Vfc=;
        b=i4aspLQ3ZN+w53/mtI2h9g3X6lHueNlDYPHU9Sq9TPvPZMB9RBVB9BdRjY2AnXHA5eXTvG
        +9zLz7oEYCLLi2yHm/UIP8I6+CIW1IRzG26ClJE7Mnr/lRmvqGzp/l8UQ96C50zbLlUzgg
        K+xmAUyJdj4iu+TNAjTHXvR5oswKUAI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-RSxfxKBEMeiwhafSpA_u0w-1; Mon, 02 Mar 2020 11:27:46 -0500
X-MC-Unique: RSxfxKBEMeiwhafSpA_u0w-1
Received: by mail-qt1-f200.google.com with SMTP id f24so168252qte.22
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2020 08:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JWW/WIb3sM0d6LnzQC1mrlResoNDmGFQ94EYgt2Vfc=;
        b=MjBuj3VJIEXDGs6oh51SR4i5b7xTVBlSCOxpaYVCOP5ebYzallGi/HgK28xUv2JcdS
         zaQUTnRz2uWpIIHpoVm/tOkDQTGdnahtfHyxoc8yteR21A1VwQ4QArpOoXqDTEFFZM7r
         KOdCf9SOK8nEFYDN/OfpAJiUGODJ8G+1M97Cq8EQpjb3jfyMs7fHLOtclFwFHeqsm/gR
         Fj0jPoOz7mx4RxDH6lBPXw0rVze/MA3KU00cNa3S6VF3c+ZE3JnfYIJg+GyKM0OI6iQi
         +DFNMuXvyVTTvxdeOBxKpt0wEuHbudTMTJo62yGRilNtUPHQgPx/GdkqW6D9PnbCRHtv
         qFLA==
X-Gm-Message-State: ANhLgQ3cmA5ipy0LBww3PaZu6XhTHpyXbMvy7DexWjBRl2KElu1ZSoJr
        +xXdx/ZBfJP+L4kBy6Y0jIgWsbBATD5XCiiaEdTTDemOJ4/fSzc4wGaKFtif1YYTt34knf+aaCC
        1h6CtE3jf7i0bV7mQyy3KuSB5DSAnM47k3SHx
X-Received: by 2002:a0c:c68a:: with SMTP id d10mr230512qvj.126.1583166466157;
        Mon, 02 Mar 2020 08:27:46 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvDXcvHsH9KJc55K5v741LgEtlOps76DhnxmVU73f9Rh1qSXa5cN5ZUliz5XWpvV9UMa4BsTdiceRLM0/KL/u4=
X-Received: by 2002:a0c:c68a:: with SMTP id d10mr230497qvj.126.1583166465951;
 Mon, 02 Mar 2020 08:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-4-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-5-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-6-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-7-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-8-trond.myklebust@hammerspace.com> <20200301232145.1465430-9-trond.myklebust@hammerspace.com>
In-Reply-To: <20200301232145.1465430-9-trond.myklebust@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 2 Mar 2020 11:27:09 -0500
Message-ID: <CALF+zOkJPkYaXjCn-tj0dPCQUAjA05zyzxm5fzwoB-XP0SGYvw@mail.gmail.com>
Subject: Re: [PATCH 8/8] sunrpc: Drop the connection when the server drops a request
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Mar 1, 2020 at 6:25 PM Trond Myklebust <trondmy@gmail.com> wrote:
>
> If a server wants to drop a request, then it should also drop the
> connection, in order to let the client know.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/svc_xprt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index de3c077733a7..83a527e56c87 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -873,6 +873,13 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
>  }
>  EXPORT_SYMBOL_GPL(svc_recv);
>
> +static void svc_drop_connection(struct svc_xprt *xprt)
> +{
> +       if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
> +           !test_and_set_bit(XPT_CLOSE, &xprt->xpt_flags))
> +               svc_xprt_enqueue(xprt);
> +}
> +
>  /*
>   * Drop request
>   */
> @@ -880,6 +887,8 @@ void svc_drop(struct svc_rqst *rqstp)
>  {
>         trace_svc_drop(rqstp);
>         dprintk("svc: xprt %p dropped request\n", rqstp->rq_xprt);
> +       /* Close the connection when dropping a request */
> +       svc_drop_connection(rqstp->rq_xprt);
>         svc_xprt_release(rqstp);
>  }
>  EXPORT_SYMBOL_GPL(svc_drop);
> @@ -1148,6 +1157,7 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
>         if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
>                 spin_unlock(&xprt->xpt_lock);
>                 dprintk("revisit canceled\n");
> +               svc_drop_connection(xprt);
>                 svc_xprt_put(xprt);
>                 trace_svc_drop_deferred(dr);
>                 kfree(dr);
> --
> 2.24.1
>

Trond, back in 2014 you had this NFSv4 only patch that took a more
surgical approach:
https://marc.info/?l=linux-nfs&m=141414531832768&w=2

It looks like discussion died out on it after it was ineffective to
solve a different problem.
Is there a reason why you don't want to do that approach now?

