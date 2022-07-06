Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03924569242
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiGFS52 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 14:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiGFS51 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 14:57:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C12A941
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 11:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D065BCE2184
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 18:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C42FC341C8;
        Wed,  6 Jul 2022 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657133842;
        bh=3pyBg39LrPKirhTu3ElE/l8VDa8MWwyaxAddo85Hrq4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j6V7v1Q5TEE20Pq5WdCiEXUuGCY/VQfyi2aJW3xpmbI/GHGxIlRVvigaijsXKnAH3
         7+6kzpxEeunHMYvrW4Ict9GvCdHkqudlp3ZucA8eAgMr53ZTsEwNc6Sr1+KFdpSptx
         I6DW71u1D02t74am1oRyFjYmh5QRKhIPTbn51fsWU2CUgEh2U10/i8m8fjddvTIQer
         gfp2WOhcUVBKVcNVV+1vtoC1fyvPginUnncSt04eYyZRJFlL6WP1jmF6m/WmVUqoPP
         WHsAgwRTJO8IuIaf0q13QZaVgml4tZK8CulxVVhRbMM1QW0aqc4KsHsgJu1QnoeV1w
         UqrvCMHr8h7Xg==
Message-ID: <732a3dd097707a57d4208f0bdb807abcd29ba224.camel@kernel.org>
Subject: Re: [PATCH v2 06/15] SUNRPC: Trace the rpc_create_args
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Wed, 06 Jul 2022 14:57:21 -0400
In-Reply-To: <165452706752.1496.657240546600966342.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
         <165452706752.1496.657240546600966342.stgit@oracle-102.nfsv4.dev>
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

On Mon, 2022-06-06 at 10:51 -0400, Chuck Lever wrote:
> Pass the upper layer's rpc_create_args to the rpc_clnt_new()
> tracepoint so additional parts of the upper layer's request can be
> recorded.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/sunrpc.h |   53 +++++++++++++++++++++++++++++++++--=
------
>  net/sunrpc/clnt.c             |    2 +-
>  2 files changed, 44 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.=
h
> index a66aa1f59ed8..986e135e314f 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -139,36 +139,69 @@ DEFINE_RPC_CLNT_EVENT(release);
>  DEFINE_RPC_CLNT_EVENT(replace_xprt);
>  DEFINE_RPC_CLNT_EVENT(replace_xprt_err);
> =20
> +TRACE_DEFINE_ENUM(RPC_XPRTSEC_NONE);
> +TRACE_DEFINE_ENUM(RPC_XPRTSEC_TLS_X509);
> +TRACE_DEFINE_ENUM(RPC_XPRTSEC_TLS_PSK);
> +
> +#define rpc_show_xprtsec_policy(policy)					\
> +	__print_symbolic(policy,					\
> +		{ RPC_XPRTSEC_NONE,		"none" },		\
> +		{ RPC_XPRTSEC_TLS_X509,		"tls-x509" },		\
> +		{ RPC_XPRTSEC_TLS_PSK,		"tls-psk" })
> +
> +#define rpc_show_create_flags(flags)					\
> +	__print_flags(flags, "|",					\
> +		{ RPC_CLNT_CREATE_HARDRTRY,	"HARDRTRY" },		\
> +		{ RPC_CLNT_CREATE_AUTOBIND,	"AUTOBIND" },		\
> +		{ RPC_CLNT_CREATE_NONPRIVPORT,	"NONPRIVPORT" },	\
> +		{ RPC_CLNT_CREATE_NOPING,	"NOPING" },		\
> +		{ RPC_CLNT_CREATE_DISCRTRY,	"DISCRTRY" },		\
> +		{ RPC_CLNT_CREATE_QUIET,	"QUIET" },		\
> +		{ RPC_CLNT_CREATE_INFINITE_SLOTS,			\
> +						"INFINITE_SLOTS" },	\
> +		{ RPC_CLNT_CREATE_NO_IDLE_TIMEOUT,			\
> +						"NO_IDLE_TIMEOUT" },	\
> +		{ RPC_CLNT_CREATE_NO_RETRANS_TIMEOUT,			\
> +						"NO_RETRANS_TIMEOUT" },	\
> +		{ RPC_CLNT_CREATE_SOFTERR,	"SOFTERR" },		\
> +		{ RPC_CLNT_CREATE_REUSEPORT,	"REUSEPORT" })
> +
>  TRACE_EVENT(rpc_clnt_new,
>  	TP_PROTO(
>  		const struct rpc_clnt *clnt,
>  		const struct rpc_xprt *xprt,
> -		const char *program,
> -		const char *server
> +		const struct rpc_create_args *args
>  	),
> =20
> -	TP_ARGS(clnt, xprt, program, server),
> +	TP_ARGS(clnt, xprt, args),
> =20
>  	TP_STRUCT__entry(
>  		__field(unsigned int, client_id)
> +		__field(unsigned long, xprtsec)
> +		__field(unsigned long, flags)
> +		__string(program, clnt->cl_program->name)
> +		__string(server, xprt->servername)
>  		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
>  		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
> -		__string(program, program)
> -		__string(server, server)
>  	),
> =20
>  	TP_fast_assign(
>  		__entry->client_id =3D clnt->cl_clid;
> +		__entry->xprtsec =3D args->xprtsec;
> +		__entry->flags =3D args->flags;
> +		__assign_str(program, clnt->cl_program->name);
> +		__assign_str(server, xprt->servername);
>  		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
>  		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
> -		__assign_str(program, program);
> -		__assign_str(server, server);
>  	),
> =20
> -	TP_printk("client=3D" SUNRPC_TRACE_CLID_SPECIFIER
> -		  " peer=3D[%s]:%s program=3D%s server=3D%s",
> +	TP_printk("client=3D" SUNRPC_TRACE_CLID_SPECIFIER " peer=3D[%s]:%s"
> +		" program=3D%s server=3D%s xprtsec=3D%s flags=3D%s",
>  		__entry->client_id, __get_str(addr), __get_str(port),
> -		__get_str(program), __get_str(server))
> +		__get_str(program), __get_str(server),
> +		rpc_show_xprtsec_policy(__entry->xprtsec),
> +		rpc_show_create_flags(__entry->flags)
> +	)
>  );
> =20
>  TRACE_EVENT(rpc_clnt_new_err,
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 6dcc88d45f5d..0ca86c92968f 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -435,7 +435,7 @@ static struct rpc_clnt * rpc_new_client(const struct =
rpc_create_args *args,
>  	if (parent)
>  		refcount_inc(&parent->cl_count);
> =20
> -	trace_rpc_clnt_new(clnt, xprt, program->name, args->servername);
> +	trace_rpc_clnt_new(clnt, xprt, args);
>  	return clnt;
> =20
>  out_no_path:
>=20
>=20

All of these tracing patches seem like a reasonable thing to add on
their own, IMO. It might be good to move them and some of the bugfixes
to a separate series and get those merged ahead of the parts that add
TLS support (which are more controversial).

Reviewed-by: Jeff Layton <jlayton@kernel.org>
