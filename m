Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1ED70350A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 18:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbjEOQzO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 12:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243312AbjEOQy4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 12:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8EE6A7E
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 09:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECC22629D1
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 16:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0575AC4339B;
        Mon, 15 May 2023 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684169681;
        bh=JhdVYJ6Uf1Ei2CFmN9v5PZC9uGAY0jYcRYwGGFDefEE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dYmKUntG17x7CG+085n2VoCWH6K0BQOJncYrBf88jnNmkhazXcuNCJKRxu3PiuJgi
         8juVsEniB8G1dJCPQEPi7WzLb5DOeWkJQAewE0JlyD016wqaKtV/DVYsOHHxKAR7nf
         P5ZTYgtHTOpBFcXM6NM+CNkH6eZCg0WKJjbG1HUc1ui6xJraWAm12Xpo1Wi8/xIhWk
         fGoUEYBg79PPUWjF3fkHQ9zqmtLvkiFHke1JMG4riRHNGISnPLIwbkRwVdwcPF83Vm
         iREgMw+yMydjzioMExb7CiXDKME+A+YHwGEiSToOLM/olhfOxM8KUKnyrNhhJLYQig
         S8lATOY4oGQxg==
Message-ID: <13c6a090134e64ce4961c322681a941399268cb9.camel@kernel.org>
Subject: Re: [PATCH 3/4] SUNRPC: Improve observability in svc_tcp_accept()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 12:54:39 -0400
In-Reply-To: <168415757392.9504.14836685251349712202.stgit@manet.1015granger.net>
References: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
         <168415757392.9504.14836685251349712202.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-05-15 at 09:32 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The -ENOMEM arm could fire repeatedly if the system runs low on
> memory, so remove it.
>=20
> Don't bother to trace -EAGAIN error events, since those fire after
> a listener is created (with no work done) and once again after an
> accept has been handled successfully (again, with no work done).
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/svcsock.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index e0fb65e90af2..2058641ab9f6 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -885,13 +885,8 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xp=
rt *xprt)
>  	clear_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
>  	err =3D kernel_accept(sock, &newsock, O_NONBLOCK);
>  	if (err < 0) {
> -		if (err =3D=3D -ENOMEM)
> -			printk(KERN_WARNING "%s: no more sockets!\n",
> -			       serv->sv_name);
> -		else if (err !=3D -EAGAIN)
> -			net_warn_ratelimited("%s: accept failed (err %d)!\n",
> -					     serv->sv_name, -err);
> -		trace_svcsock_accept_err(xprt, serv->sv_name, err);
> +		if (err !=3D -EAGAIN)
> +			trace_svcsock_accept_err(xprt, serv->sv_name, err);

Would this be better done as a TP_CONDITION tracepoint?

>  		return NULL;
>  	}
>  	set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
