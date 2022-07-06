Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC78569214
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 20:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiGFSpD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 14:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiGFSpC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 14:45:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311BB27B15
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 11:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE2C9B81E83
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 18:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4137BC3411C;
        Wed,  6 Jul 2022 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657133098;
        bh=cM0hUjl5xqLXzpdHKlGUGjERbCHbwt1WZr4DNJMevYg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=taeHfdnXYzUU2mdTMMb38vXF90NMxRQbpiHwDUSQpjugd90TUpKgkdKVmkSr2KB7E
         oS82F9bVlTlMb7xjKOy1ehL0mdFLkWZIKmGjlQSvPJ7K5/W1ix78Jmnn64p+w4Kd4Q
         iPwQ5NzOG6P90IHa5FF3cR6Gv1CryzXoTgW7poHGUv3n67gZJAd5MW+iMnW3pmcjke
         ob2myoJguwz21Ou/W8OLtrVamCePiJ4QEk+usuOG/9mBrIVIM3EL+XjN8RdCQPD0rS
         w9u/1tL46TabMSBquBiLqZyIxnnH6UwZAWx8CydkupYupW0BkR2mBKhHnAkWi9Dgd4
         DD5tEgjJXZ8Iw==
Message-ID: <0240d09511336c5a5490607ec29ec49c12eff473.camel@kernel.org>
Subject: Re: [PATCH v2 04/15] NFS: Replace fs_context-related dprintk() call
 sites with tracepoints
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Wed, 06 Jul 2022 14:44:56 -0400
In-Reply-To: <165452705445.1496.2682789415111295436.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
         <165452705445.1496.2682789415111295436.stgit@oracle-102.nfsv4.dev>
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
> Contributed as part of the long patch series that converts NFS from
> using dprintk to tracepoints for observability.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/fs_context.c |   25 ++++++++++-------
>  fs/nfs/nfstrace.h   |   77 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 92 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 9a16897e8dc6..35e400a557b9 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -21,6 +21,8 @@
>  #include "nfs.h"
>  #include "internal.h"
> =20
> +#include "nfstrace.h"
> +
>  #define NFSDBG_FACILITY		NFSDBG_MOUNT
> =20
>  #if IS_ENABLED(CONFIG_NFS_V3)
> @@ -284,7 +286,7 @@ static int nfs_verify_server_address(struct sockaddr =
*addr)
>  	}
>  	}
> =20
> -	dfprintk(MOUNT, "NFS: Invalid IP address specified\n");
> +	trace_nfs_mount_addr_err(addr);
>  	return 0;
>  }
> =20
> @@ -378,7 +380,7 @@ static int nfs_parse_security_flavors(struct fs_conte=
xt *fc,
>  	char *string =3D param->string, *p;
>  	int ret;
> =20
> -	dfprintk(MOUNT, "NFS: parsing %s=3D%s option\n", param->key, param->str=
ing);
> +	trace_nfs_mount_assign(param->key, string);
> =20
>  	while ((p =3D strsep(&string, ":")) !=3D NULL) {
>  		if (!*p)
> @@ -480,7 +482,7 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  	unsigned int len;
>  	int ret, opt;
> =20
> -	dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", param->key);
> +	trace_nfs_mount_option(param);
> =20
>  	opt =3D fs_parse(fc, nfs_fs_parameters, param, &result);
>  	if (opt < 0)
> @@ -683,6 +685,7 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  			return ret;
>  		break;
>  	case Opt_vers:
> +		trace_nfs_mount_assign(param->key, param->string);
>  		ret =3D nfs_parse_version_string(fc, param->string);
>  		if (ret < 0)
>  			return ret;
> @@ -694,6 +697,7 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  		break;
> =20
>  	case Opt_proto:
> +		trace_nfs_mount_assign(param->key, param->string);
>  		protofamily =3D AF_INET;
>  		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) =
{
>  		case Opt_xprt_udp6:
> @@ -729,6 +733,7 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  		break;
> =20
>  	case Opt_mountproto:
> +		trace_nfs_mount_assign(param->key, param->string);
>  		mountfamily =3D AF_INET;
>  		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) =
{
>  		case Opt_xprt_udp6:
> @@ -751,6 +756,7 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  		break;
> =20
>  	case Opt_addr:
> +		trace_nfs_mount_assign(param->key, param->string);
>  		len =3D rpc_pton(fc->net_ns, param->string, param->size,
>  			       &ctx->nfs_server.address,
>  			       sizeof(ctx->nfs_server._address));
> @@ -759,16 +765,19 @@ static int nfs_fs_context_parse_param(struct fs_con=
text *fc,
>  		ctx->nfs_server.addrlen =3D len;
>  		break;
>  	case Opt_clientaddr:
> +		trace_nfs_mount_assign(param->key, param->string);
>  		kfree(ctx->client_address);
>  		ctx->client_address =3D param->string;
>  		param->string =3D NULL;
>  		break;
>  	case Opt_mounthost:
> +		trace_nfs_mount_assign(param->key, param->string);
>  		kfree(ctx->mount_server.hostname);
>  		ctx->mount_server.hostname =3D param->string;
>  		param->string =3D NULL;
>  		break;
>  	case Opt_mountaddr:
> +		trace_nfs_mount_assign(param->key, param->string);
>  		len =3D rpc_pton(fc->net_ns, param->string, param->size,
>  			       &ctx->mount_server.address,
>  			       sizeof(ctx->mount_server._address));
> @@ -846,7 +855,6 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  		 */
>  	case Opt_sloppy:
>  		ctx->sloppy =3D true;
> -		dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
>  		break;
>  	}
> =20
> @@ -879,10 +887,8 @@ static int nfs_parse_source(struct fs_context *fc,
>  	size_t len;
>  	const char *end;
> =20
> -	if (unlikely(!dev_name || !*dev_name)) {
> -		dfprintk(MOUNT, "NFS: device name not specified\n");
> +	if (unlikely(!dev_name || !*dev_name))
>  		return -EINVAL;
> -	}
> =20
>  	/* Is the host name protected with square brakcets? */
>  	if (*dev_name =3D=3D '[') {
> @@ -922,7 +928,7 @@ static int nfs_parse_source(struct fs_context *fc,
>  	if (!ctx->nfs_server.export_path)
>  		goto out_nomem;
> =20
> -	dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", ctx->nfs_server.export_path);
> +	trace_nfs_mount_path(ctx->nfs_server.export_path);
>  	return 0;
> =20
>  out_bad_devname:
> @@ -1116,7 +1122,6 @@ static int nfs23_parse_monolithic(struct fs_context=
 *fc,
>  	return nfs_invalf(fc, "NFS: nfs_mount_data version supports only AUTH_S=
YS");
> =20
>  out_nomem:
> -	dfprintk(MOUNT, "NFS: not enough memory to handle mount options");
>  	return -ENOMEM;
> =20
>  out_no_address:
> @@ -1248,7 +1253,7 @@ static int nfs4_parse_monolithic(struct fs_context =
*fc,
>  	if (IS_ERR(c))
>  		return PTR_ERR(c);
>  	ctx->nfs_server.export_path =3D c;
> -	dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", c);
> +	trace_nfs_mount_path(c);
> =20
>  	c =3D strndup_user(data->client_addr.data, 16);
>  	if (IS_ERR(c))
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 012bd7339862..ccaeae42ee77 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -1609,6 +1609,83 @@ TRACE_EVENT(nfs_fh_to_dentry,
>  		)
>  );
> =20
> +TRACE_EVENT(nfs_mount_addr_err,
> +	TP_PROTO(
> +		const struct sockaddr *sap
> +	),
> +
> +	TP_ARGS(sap),
> +
> +	TP_STRUCT__entry(
> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->addr, sap, sizeof(__entry->addr));
> +	),
> +
> +	TP_printk("addr=3D%pISpc", __entry->addr)
> +);
> +
> +TRACE_EVENT(nfs_mount_assign,
> +	TP_PROTO(
> +		const char *option,
> +		const char *value
> +	),
> +
> +	TP_ARGS(option, value),
> +
> +	TP_STRUCT__entry(
> +		__string(option, option)
> +		__string(value, value)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(option, option);
> +		__assign_str(value, value);
> +	),
> +
> +	TP_printk("option %s=3D%s",
> +		__get_str(option), __get_str(value)
> +	)
> +);
> +
> +TRACE_EVENT(nfs_mount_option,
> +	TP_PROTO(
> +		const struct fs_parameter *param
> +	),
> +
> +	TP_ARGS(param),
> +
> +	TP_STRUCT__entry(
> +		__string(option, param->key)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(option, param->key);
> +	),
> +
> +	TP_printk("option %s", __get_str(option))
> +);
> +
> +TRACE_EVENT(nfs_mount_path,
> +	TP_PROTO(
> +		const char *path
> +	),
> +
> +	TP_ARGS(path),
> +
> +	TP_STRUCT__entry(
> +		__string(path, path)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(path, path);
> +	),
> +
> +	TP_printk("path=3D'%s'", __get_str(path))
> +);
> +
>  DECLARE_EVENT_CLASS(nfs_xdr_event,
>  		TP_PROTO(
>  			const struct xdr_stream *xdr,
>=20
>=20

Seems like an improvement overall.=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
