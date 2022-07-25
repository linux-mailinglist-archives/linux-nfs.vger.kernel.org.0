Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D172B580058
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiGYODk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 10:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiGYODg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 10:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDFF15FCC
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 07:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F33F611DB
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 14:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F425C341C6;
        Mon, 25 Jul 2022 14:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658757814;
        bh=RfCUEgRu2RTVsnCmQzh3gVvKyj4WXqXvfWym3E7P2Gc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Otvjrosxw5Wk1EMxgF9beF25YpZLss24ppeybja/atunSoamxMUOiPkHbRMgnGKkP
         6TDrgPN7U5snZqapMNlDqdYay3jWGJweryQJ2wnMCOTs0c66kO8rOrxzxwR6y9t9Ui
         pNgrhtxO7m0ol2UqgBgTBUb6xNUFYIYuVxTj3EePkP10wYhojdTmIMrMmXc5OL20YH
         5N2x9UiafBuhBM0ZoJCYYQX6VBmvFtF1g8TehYFvAOel1FMBrgreZOtqAfCvmhp731
         8LzJ8Jn8bbZwcvcTGCT4bRRkCPggcnnMOgjsPspES7unBSGeSccW43X8EdQa/ZZz+P
         X+zH30T9Vv4xQ==
Message-ID: <9a3a447a3c4351daac436944b535b32a0e29ab51.camel@kernel.org>
Subject: Re: [PATCH v2 3/4] SUNRPC: Replace dprintk() call site in
 xs_data_ready
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, anna.schumaker@netapp.com,
        trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 25 Jul 2022 10:03:32 -0400
In-Reply-To: <165851689770.2312015.16674329181783074734.stgit@morisot.1015granger.net>
References: <165851677341.2312015.16636288284789960852.stgit@morisot.1015granger.net>
         <165851689770.2312015.16674329181783074734.stgit@morisot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-07-22 at 15:08 -0400, Chuck Lever wrote:
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/sunrpc.h |   20 ++++++++++++++++++++
>  net/sunrpc/xprtsock.c         |    6 ++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.=
h
> index b61d9c90fa26..21068ad61db8 100644
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
> +
> +	TP_printk("peer=3D[%s]:%s", __get_str(addr), __get_str(port))
> +);
> +
>  TRACE_EVENT(xs_stream_read_data,
>  	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
> =20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index fcdd0fca408e..eba1be9984f8 100644
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
