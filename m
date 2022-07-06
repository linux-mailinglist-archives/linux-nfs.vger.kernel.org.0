Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69EF569081
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiGFRTd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiGFRTc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 13:19:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8027192A1
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 10:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 26047CE1EC6
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 17:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E400CC3411C;
        Wed,  6 Jul 2022 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657127968;
        bh=kIm3Y17v2DgOnkUZOFpkBWBIobB/QW84DAQ4yDI7t1U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BJPYszBQFdq6ZGdmQ6NNsDVB5P9sjX2fMjCpMT/wJBH1SdNeKgoeSl/TEahvzaKm3
         uQsHZXde92hC1wvH0tJVPXHsAK+1P1cfWX+wPVneqk36B4XpyBqzyQoG5FF/v64kc2
         3WLe4/IaBWjY0VXbUHE6uO4LYieYFlkSEK4cz51PP8pD7Z8tMpTyOOY57gArLg7bhc
         FhakpBBuv1/YaJ6Dykpi5v7ZJFOb8f/0JrBrl0iU/xRUjHDXG0ILRZ0PtWdXTehcc3
         CLsdNd4OHgJJQEOplL7vyHsMEr5HsDfRPiN8XahT7+7fCIaqMv7PGcgN9trm0w4v2w
         cm/ZIXNJZOtDw==
Message-ID: <8d04a3f22e170e117cdc605037932f29f6408d6b.camel@kernel.org>
Subject: Re: [PATCH v2 03/15] SUNRPC: Replace dprintk() call site in
 xs_data_ready
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Wed, 06 Jul 2022 13:19:26 -0400
In-Reply-To: <165452704802.1496.15626296214203899256.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
         <165452704802.1496.15626296214203899256.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-06-06 at 10:50 -0400, Chuck Lever wrote:
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/sunrpc.h |   20 ++++++++++++++++++++
>  net/sunrpc/xprtsock.c         |    6 ++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.=
h
> index 3995c58a1c51..a66aa1f59ed8 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -1266,6 +1266,26 @@ TRACE_EVENT(xprt_reserve,
>  	)
>  );
> =20
> +TRACE_EVENT(xs_data_ready,
> +	TP_PROTO(
> +		const struct rpc_xprt *xprt
> +	),
> +
> +	TP_ARGS(xprt),
> +
> +	TP_STRUCT__entry(
> +		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
> +		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
> +		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
> +	),
>=20
>=20

This tracepoint is likely to fire rather often when it's enabled. Would
it be more efficient to store the addr and port as binary data instead?

> +
> +	TP_printk("peer=3D[%s]:%s", __get_str(addr), __get_str(port))
> +);
> +
>  TRACE_EVENT(xs_stream_read_data,
>  	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
> =20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 650102a9c86a..73fab802996d 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1378,7 +1378,7 @@ static void xs_udp_data_receive_workfn(struct work_=
struct *work)
>  }
> =20
>  /**
> - * xs_data_ready - "data ready" callback for UDP sockets
> + * xs_data_ready - "data ready" callback for sockets
>   * @sk: socket with data to read
>   *
>   */
> @@ -1386,11 +1386,13 @@ static void xs_data_ready(struct sock *sk)
>  {
>  	struct rpc_xprt *xprt;
> =20
> -	dprintk("RPC:       xs_data_ready...\n");
>  	xprt =3D xprt_from_sock(sk);
>  	if (xprt !=3D NULL) {
>  		struct sock_xprt *transport =3D container_of(xprt,
>  				struct sock_xprt, xprt);
> +
> +		trace_xs_data_ready(xprt);
> +
>  		transport->old_data_ready(sk);
>  		/* Any data means we had a useful conversation, so
>  		 * then we don't need to delay the next reconnect
>=20
>=20

That dprintk was pretty worthless anyway. So the change seems fine to
me.


--=20
Jeff Layton <jlayton@kernel.org>
