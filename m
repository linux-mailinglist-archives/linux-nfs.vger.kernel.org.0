Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F22E4D2
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 20:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfE2Sy3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 14:54:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46982 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Sy3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 May 2019 14:54:29 -0400
Received: by mail-vs1-f68.google.com with SMTP id l125so2618200vsl.13;
        Wed, 29 May 2019 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCvRfjMaoe8atosMw9vpL+AtU6nrgPQCPjhnaZzCbsM=;
        b=cqFqy9eCxa8h1FX1mKoort4lffCfK4CG9Y5YoL6yBFhj42AIuHaGLifCq2qqybuccK
         bYiD17z+z9hHq6GfuISDiPNqa6fPd4N/9SpVQMuXKdf5GCzpptWEPr4GSlDlPB04snbt
         sUrogDzeTnr4zOgdqoIucUlU/9wk5fQF+HF3cwTCOgVD+lyuFdGQUKXxs69XcB0dCNju
         ia/Xdlgo2TAYtwZlUQ3pPL2tlv9ImA7tBWOK7YEMAt2MYnAw26XjNc+vd4iTwtYctuyi
         AeUUUJUeemgC1aoAMksRvZvvFXbHobcNoXlcbRJQJwGXFT9naPvzi/o9kLyEcu7iMjzQ
         zkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCvRfjMaoe8atosMw9vpL+AtU6nrgPQCPjhnaZzCbsM=;
        b=ljK+9tPIuSSJcpP/m7H8PAxPuXGl4ThWdTn2no7a7gUiK/ItbWVNAd7/PzGLtZQzcB
         Iyhp7v1DcKu2OCJNi1seYxt4cdoWFqbmXT353MhWbxrzeHpf2ky3Y+jV3Ya0LqXVlXRA
         hnQbDvywcmFXkxx8egwSSKhdWcxR35/bMLZ+i3535tOToB+ANSfu8yS1ZcxfBekbyOOP
         yYV4vN+/WJKQY+RFalUw3dDlvBo69kuQqD5PkZldNuJ1UwSpQSKfw8xe2n8BbVsTY7jn
         o0U8xnTiItj7b+yvJCjvTf0n6tsl8tzlULY7ydAuIFfJa8SgIrwKJz1a9hVrc2AVoSo+
         JO9w==
X-Gm-Message-State: APjAAAWHlcUbNNB/uUobPTjqho2LuluUeo9LjDH/A3O38WrgseSJP30o
        Z17/2XNiOVi7tInz/H5Y/y34XrZxlWZSJIn03BA=
X-Google-Smtp-Source: APXvYqziLHhX9A6iAge8aPXbfuG8rZVv36yFfLC/qNQR8rQn8NiS7O4UxAwF5EPDRQOYx9qg6L+kNbIkswgeivhZ5vk=
X-Received: by 2002:a67:de99:: with SMTP id r25mr47937874vsk.215.1559156067660;
 Wed, 29 May 2019 11:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190529151003.hzmesyoiopnbcgkb@aura.draconx.ca> <ceecedad1b650f703a12ec3424493c4a73d1e20e.camel@hammerspace.com>
In-Reply-To: <ceecedad1b650f703a12ec3424493c4a73d1e20e.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 29 May 2019 14:54:16 -0400
Message-ID: <CAN-5tyHws9bO5Yuj9FTn6EdcPcY5QGK0419aBbujU7Ugt4_6uQ@mail.gmail.com>
Subject: Re: PROBLEM: oops spew with Linux 5.1.5 (NFS regression?)
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "nbowler@draconx.ca" <nbowler@draconx.ca>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Olga.Kornievskaia@netapp.com" <Olga.Kornievskaia@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 29, 2019 at 1:14 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2019-05-29 at 11:10 -0400, Nick Bowler wrote:
> > Hi,
> >
> > I upgraded to Linux 5.1.5 on one machine yesterday, and this morning
> > I
> > happened noticed a large amount of backtraces in the log.  It appears
> > that the system oopsed 62 times over a period of about 5 minutes,
> > producing about half a megabyte of log messages, after which the
> > messages stopped.  No idea what action (if any) triggered these.
> >
> > However, other than the noise in the logs there is nothing obviously
> > broken, but I thought I should report the spews anyway.  I was
> > running
> > 5.0.9 previously and have not seen any similar errors.  The first
> > couple
> > spews are appended.  All 64 faults look very similar to these ones,
> > with
> > the same faulting address and the same rpc_check_timeout function at
> > the
> > top of the backtrace.
>
> OK, I think this is the same problem that Olga was seeing (Cced), and
> it looks like I missed the use-after-free issue when the server returns
> a credential error when she asked.

I think this is actually different than what I encountered for the
umount case but the trigger is the same -- failing validation.

I tried to reproduce Nick's oops on 5.2-rc but haven't been able to
(but I'm not confident I produced the right trigger conditions. will
try 5.1).


>
> I believe that the following patch should fix it:
>
> 8<------------------------------------------------------------------
> From 33905f5a7d1d200db8eeb3f4ea8670c9da4cb64d Mon Sep 17 00:00:00 2001
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Wed, 29 May 2019 12:49:52 -0400
> Subject: [PATCH] SUNRPC: Fix a use after free when a server rejects the
>  RPCSEC_GSS credential
>
> The addition of rpc_check_timeout() to call_decode causes an Oops
> when the RPCSEC_GSS credential is rejected.
> The reason is that rpc_decode_header() will call xprt_release() in
> order to free task->tk_rqstp, which is needed by rpc_check_timeout()
> to check whether or not we should exit due to a soft timeout.
>
> The fix is to move the call to xprt_release() into call_decode() so
> we can perform it after rpc_check_timeout().
>
> Reported-by: Olga Kornievskaia <olga.kornievskaia@gmail.com>
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> Fixes: cea57789e408 ("SUNRPC: Clean up")
> Cc: stable@vger.kernel.org # v5.1+
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/clnt.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index d6e57da56c94..4c02c37fa774 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2426,17 +2426,21 @@ call_decode(struct rpc_task *task)
>                 return;
>         case -EAGAIN:
>                 task->tk_status = 0;
> -               /* Note: rpc_decode_header() may have freed the RPC slot */
> -               if (task->tk_rqstp == req) {
> -                       xdr_free_bvec(&req->rq_rcv_buf);
> -                       req->rq_reply_bytes_recvd = 0;
> -                       req->rq_rcv_buf.len = 0;
> -                       if (task->tk_client->cl_discrtry)
> -                               xprt_conditional_disconnect(req->rq_xprt,
> -                                                           req->rq_connect_cookie);
> -               }
> +               xdr_free_bvec(&req->rq_rcv_buf);
> +               req->rq_reply_bytes_recvd = 0;
> +               req->rq_rcv_buf.len = 0;
> +               if (task->tk_client->cl_discrtry)
> +                       xprt_conditional_disconnect(req->rq_xprt,
> +                                                   req->rq_connect_cookie);
>                 task->tk_action = call_encode;
>                 rpc_check_timeout(task);
> +               break;
> +       case -EKEYREJECTED:
> +               task->tk_action = call_reserve;
> +               rpc_check_timeout(task);
> +               rpcauth_invalcred(task);
> +               /* Ensure we obtain a new XID if we retry! */
> +               xprt_release(task);
>         }
>  }
>
> @@ -2572,11 +2576,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
>                         break;
>                 task->tk_cred_retry--;
>                 trace_rpc__stale_creds(task);
> -               rpcauth_invalcred(task);
> -               /* Ensure we obtain a new XID! */
> -               xprt_release(task);
> -               task->tk_action = call_reserve;
> -               return -EAGAIN;
> +               return -EKEYREJECTED;
>         case rpc_autherr_badcred:
>         case rpc_autherr_badverf:
>                 /* possibly garbled cred/verf? */
> --
> 2.21.0
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
