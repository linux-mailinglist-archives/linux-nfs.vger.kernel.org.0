Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B06F9CEF
	for <lists+linux-nfs@lfdr.de>; Mon,  8 May 2023 02:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjEHAUg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 May 2023 20:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjEHAUf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 May 2023 20:20:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BC56593
        for <linux-nfs@vger.kernel.org>; Sun,  7 May 2023 17:20:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 195B81FDA3;
        Mon,  8 May 2023 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683505232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5HzSq9BddN6DuuE5pLCluZbzJ7v7M1CW0JSFhAlaPw=;
        b=RKdVlMEE9ZizJoZECAksyNSwbMES8iLxAM/+RwwexIEO2aytS5OGGO17RmKZqblgbjO/qL
        lDyer1Tvo0DsluyA0lv7ZYUF6YNl9fGKrKo1oeKRywjh8LsqHO1G2X44v9wfu2rsBF+AZS
        ET/1f2rHMEk+zrtvMV4eM7LDF18XXCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683505232;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5HzSq9BddN6DuuE5pLCluZbzJ7v7M1CW0JSFhAlaPw=;
        b=lS+FBUfArwBjOrpj4mm+TlR+g7YFtmWqPJOmEeww8zX+W7/Gi7GI2idl9I9qY6ClsW0YLb
        lIMdllzlViB9yYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4792138E5;
        Mon,  8 May 2023 00:20:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vdrfIU5AWGQ1KgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 08 May 2023 00:20:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 1/2] SUNRPC: Fix NFSD's request deferral on RDMA transports
In-reply-to: <164935340273.76813.7096678268046264254.stgit@klimt.1015granger.net>
References: <164935330144.76813.17862521591948764594.stgit@klimt.1015granger.net>,
 <164935340273.76813.7096678268046264254.stgit@klimt.1015granger.net>
Date:   Mon, 08 May 2023 10:20:26 +1000
Message-id: <168350522604.9647.16917749332832150697@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 08 Apr 2022, Chuck Lever wrote:
> Trond Myklebust reports an NFSD crash in svc_rdma_sendto(). Further
> investigation shows that the crash occurred while NFSD was handling
> a deferred request.
>=20
> This patch addresses two inter-related issues that prevent request
> deferral from working correctly for RPC/RDMA requests:
>=20
> 1. Prevent the crash by ensuring that the original
>    svc_rqst::rq_xprt_ctxt value is available when the request is
>    revisited. Otherwise svc_rdma_sendto() does not have a Receive
>    context available with which to construct its reply.
>=20
> 2. Possibly since before commit 71641d99ce03 ("svcrdma: Properly
>    compute .len and .buflen for received RPC Calls"),
>    svc_rdma_recvfrom() did not include the transport header in the
>    returned xdr_buf. There should have been no need for svc_defer()
>    and friends to save and restore that header, as of that commit.
>    This issue is addressed in a backport-friendly way by simply
>    having svc_rdma_recvfrom() set rq_xprt_hlen to zero
>    unconditionally, just as svc_tcp_recvfrom() does. This enables
>    svc_deferred_recv() to correctly reconstruct an RPC message
>    received via RPC/RDMA.

I'm a bit late to this party but .... this patch is bad and I don't know
how best to fix it.
It is bad for two reasons.
1/ It can leak memory.  When a deferral happens, the context is moved
   into an svc_deferred_req.  There are a couple of places which assume
   that an svc_deferred_req can be freed with kfree(), such as
   svc_delete_xprt() and svc_revisit().  These will now leak the
   context.  This is the bit that is hard to fix.

2/ It can cause a double-free with UDP (and maybe rdma).
   When a request is deferred, the ctxt is moved to the dreq.
   When that request is revisited the ctxt is copied back into the rqst.
   If the rqst is again deferred then the old dreq is reused and,
   importantly, the rq_xprt_ctxt is not cleared.  So when the release
   function is called the ctxt is freed.
   When the request is revisited a second time that ctxt (now pointing
   to freed and possibly reused memory) is copied back into the rqst.
   When the request completes the ctxt is again freed - double free
   oops.

For UDP there is no value in saving the ctxt in the dreq - the content
of the ctxt, which is an skbuf, has been copied into the dreq.  So maybe
the UDB ctxt is a very different beast than the rdma ctxt and needs to
be handled completely differently.

We can fix the UDP double-free by always doing
		rqstp->rq_xprt_ctxt =3D NULL;
whether a new dreq was needed or not.  But that doesn't fix the leaking
of ctxts and is really just a band-aid.

Thoughts?
Do we need to preserve ALL of the svc_rdma_recv_ctxt for deferred
requests?  Could we just copy some bits into the dreq (allocate a bit
more space somehow) so that a simple kfree() is still enough?
Or do we need a free_ctxt() handler attached to the xprt?

Thanks,
NeilBrown




>=20
> Reported-by: Trond Myklebust <trondmy@hammerspace.com>
> Link: https://lore.kernel.org/linux-nfs/82662b7190f26fb304eb0ab1bb042790724=
39d4e.camel@hammerspace.com/
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: <stable@vger.kernel.org>
> ---
>  include/linux/sunrpc/svc.h              |    1 +
>  net/sunrpc/svc_xprt.c                   |    3 +++
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index a5dda4987e8b..217711fc9cac 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -395,6 +395,7 @@ struct svc_deferred_req {
>  	size_t			addrlen;
>  	struct sockaddr_storage	daddr;	/* where reply must come from */
>  	size_t			daddrlen;
> +	void			*xprt_ctxt;
>  	struct cache_deferred_req handle;
>  	size_t			xprt_hlen;
>  	int			argslen;
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 0c117d3bfda8..b42cfffa7395 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1231,6 +1231,8 @@ static struct cache_deferred_req *svc_defer(struct ca=
che_req *req)
>  		dr->daddr =3D rqstp->rq_daddr;
>  		dr->argslen =3D rqstp->rq_arg.len >> 2;
>  		dr->xprt_hlen =3D rqstp->rq_xprt_hlen;
> +		dr->xprt_ctxt =3D rqstp->rq_xprt_ctxt;
> +		rqstp->rq_xprt_ctxt =3D NULL;
> =20
>  		/* back up head to the start of the buffer and copy */
>  		skip =3D rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
> @@ -1269,6 +1271,7 @@ static noinline int svc_deferred_recv(struct svc_rqst=
 *rqstp)
>  	rqstp->rq_xprt_hlen   =3D dr->xprt_hlen;
>  	rqstp->rq_daddr       =3D dr->daddr;
>  	rqstp->rq_respages    =3D rqstp->rq_pages;
> +	rqstp->rq_xprt_ctxt   =3D dr->xprt_ctxt;
>  	svc_xprt_received(rqstp->rq_xprt);
>  	return (dr->argslen<<2) - dr->xprt_hlen;
>  }
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/=
svc_rdma_recvfrom.c
> index cf76a6ad127b..864131a9fc6e 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -831,7 +831,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>  		goto out_err;
>  	if (ret =3D=3D 0)
>  		goto out_drop;
> -	rqstp->rq_xprt_hlen =3D ret;
> +	rqstp->rq_xprt_hlen =3D 0;
> =20
>  	if (svc_rdma_is_reverse_direction_reply(xprt, ctxt))
>  		goto out_backchannel;
>=20
>=20
>=20

