Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193D5578B29
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiGRTqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiGRTqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 15:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA0BBC34
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 12:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7703761732
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 19:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6380FC341C0;
        Mon, 18 Jul 2022 19:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658173591;
        bh=CuwTLZYwxJ5VDk0Eu2Po+oENrDx3E+Fm5QkCC7SfKMI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i9Zr73J8ZeyUz3rfFxPLXpFgSeaoMbPFWjfkgw7uVIS/J9EA7L2qgaegU14ud9z1q
         46LpoPz9LvkvA5N5L+GpeZdVdWTwx7Etma8VRAa2GhvwILlrojiEoDl9CZ73YW+OnD
         NCDpgdGIAtPx9jFQl8lQbdvyNGI+lyfp7u0chSnWxJXP+Gsa1YL2dzxliCXtBw9SBc
         /I2vG3srK4gkesy1wpxSbHOdd4maJIDOMFnQpHSJLD/jkM9oIMqIQSmCBUx7x/lvhJ
         kfHMe84yYO452kP/b+F26BNDNN+vlRVy+BkEAR/DwzJ/lMlAyUIzBYTld64tLuQTsd
         txMMttVhMs+uA==
Message-ID: <bd35c69731c9d658b4c7eea54106e2ba8dfdb513.camel@kernel.org>
Subject: Re: [PATCH v2 05/15] SUNRPC: Plumb an API for setting transport
 layer security
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 18 Jul 2022 15:46:30 -0400
In-Reply-To: <165452706106.1496.9556038561796216812.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
         <165452706106.1496.9556038561796216812.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-06-06 at 10:51 -0400, Chuck Lever wrote:
> Add an initial set of policies along with fields for upper layers to
> pass the requested policy down to the transport layer.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/clnt.h |    9 +++++++++
>  include/linux/sunrpc/xprt.h |    2 ++
>  net/sunrpc/clnt.c           |    4 ++++
>  3 files changed, 15 insertions(+)
>=20
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index cbdd20dc84b7..85c2f810d4bb 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -58,6 +58,7 @@ struct rpc_clnt {
>  				cl_noretranstimeo: 1,/* No retransmit timeouts */
>  				cl_autobind : 1,/* use getport() */
>  				cl_chatty   : 1;/* be verbose */
> +	unsigned int		cl_xprtsec;	/* transport security policy */
> =20
>  	struct rpc_rtt *	cl_rtt;		/* RTO estimator data */
>  	const struct rpc_timeout *cl_timeout;	/* Timeout strategy */
> @@ -139,6 +140,7 @@ struct rpc_create_args {
>  	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
>  	const struct cred	*cred;
>  	unsigned int		max_connect;
> +	unsigned int		xprtsec;
>  };
> =20
>  struct rpc_add_xprt_test {
> @@ -162,6 +164,13 @@ struct rpc_add_xprt_test {
>  #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
>  #define RPC_CLNT_CREATE_CONNECTED	(1UL << 12)
> =20
> +/* RPC transport layer security policies */
> +enum {
> +	RPC_XPRTSEC_NONE =3D 0,
> +	RPC_XPRTSEC_TLS_X509,
> +	RPC_XPRTSEC_TLS_PSK,
> +};
> +
>  struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>  struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
>  				const struct rpc_program *, u32);
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index 522bbf937957..d091ad2b7340 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -228,6 +228,7 @@ struct rpc_xprt {
>  	 */
>  	unsigned long		bind_timeout,
>  				reestablish_timeout;
> +	unsigned int		xprtsec;
>  	unsigned int		connect_cookie;	/* A cookie that gets bumped
>  						   every time the transport
>  						   is reconnected */
> @@ -332,6 +333,7 @@ struct xprt_create {
>  	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
>  	struct rpc_xprt_switch	*bc_xps;
>  	unsigned int		flags;
> +	unsigned int		xprtsec;
>  };
> =20
>  struct xprt_class {
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 8fd45de66882..6dcc88d45f5d 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -385,6 +385,7 @@ static struct rpc_clnt * rpc_new_client(const struct =
rpc_create_args *args,
>  	if (!clnt)
>  		goto out_err;
>  	clnt->cl_parent =3D parent ? : clnt;
> +	clnt->cl_xprtsec =3D args->xprtsec;
> =20
>  	err =3D rpc_alloc_clid(clnt);
>  	if (err)
> @@ -532,6 +533,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *a=
rgs)
>  		.addrlen =3D args->addrsize,
>  		.servername =3D args->servername,
>  		.bc_xprt =3D args->bc_xprt,
> +		.xprtsec =3D args->xprtsec,
>  	};
>  	char servername[48];
>  	struct rpc_clnt *clnt;
> @@ -726,6 +728,7 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt=
,
>  	struct rpc_clnt *parent;
>  	int err;
> =20
> +	args->xprtsec =3D clnt->cl_xprtsec;
>  	xprt =3D xprt_create_transport(args);
>  	if (IS_ERR(xprt))
>  		return PTR_ERR(xprt);
> @@ -2973,6 +2976,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
> =20
>  	if (!xprtargs->ident)
>  		xprtargs->ident =3D ident;
> +	xprtargs->xprtsec =3D clnt->cl_xprtsec;
>  	xprt =3D xprt_create_transport(xprtargs);
>  	if (IS_ERR(xprt)) {
>  		ret =3D PTR_ERR(xprt);
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
