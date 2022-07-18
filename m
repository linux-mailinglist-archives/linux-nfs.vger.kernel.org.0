Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546D9578BB1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 22:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiGRUYY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 16:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiGRUYY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 16:24:24 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9FC2CCA6
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 13:24:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c3so3931835qko.1
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=j9h06O4aYp1bsBPEetYxJ/X390zNV17CuOHVE8zfqlQ=;
        b=yD41PuV8xhcQqPLW+1EjX/hJIuhHs7x0Aef9ggicRCd8wqtq3UR5I4pJBkSVgNRADt
         sbesp11dQvkg4GISIqJKJFSb1kUWb9vsnqD9Ym61Kg4fDm7fVubEEIdU2TF8qQlGLhq5
         XMTDkZsSNokVyYTOGg2q6y7IiF59tCAbD9GaQ1mxKZ4sV1/B3Sw7CxosEU8bcu76wrHx
         vtgA1V6LShFkUQFL+l4xVUJ9/LBm3WkBWN62QiLkftM8a4CWyg3UIZ2uMQIkP4Dd0cl3
         JwVZ/lKBON2684kgsIMzZ4pA/8gD2th33T/mLJTUCV6SQSmkNr6Ao+K1Nu0DaAKxewf3
         MyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=j9h06O4aYp1bsBPEetYxJ/X390zNV17CuOHVE8zfqlQ=;
        b=q4QjpVS8qrE2rSeQJKtNsCewajHhSgebFRbULym4gxBESx2fgo7IMtDSNdJV9j4GFZ
         39OHwPcOGIQxPPAOD3ncXKw5o9Hy7f/jKDvNb5xpTBOqpcS23FVpI1hlpqicRWGOqfTu
         xE414bZ5VIu+4x9QPd2k4ONACGFVCCM60Ibo+0CldBsz6K2485TcMHG84CIb5psSWuKx
         q2adZC0QIVyimP42JKNy75snwGqfHEdgUzYxG7HUFSZOJpApAr7pB8WC+tsjsF4shP7M
         knu6hmk8T97Lk0o3COqG6c0M30MW4pHhzR46lTzw5J0FZR3PV9CGEWjbYHUqEaGrCNvW
         rTug==
X-Gm-Message-State: AJIora9aZpSnxc9CbGQi17a0kvQqIytfAkuxyyDSjX1JUAg2cBEC0FOF
        z2DSpRhsj82IaTQg/QCB9jmZYA==
X-Google-Smtp-Source: AGRyM1uzQXHZA5TqiBNM7dkuA9qJzutrk4ICFXK61OGcZoXmXUty/J3E+OsAXPelLO7Fg7cDIBbG2g==
X-Received: by 2002:a37:6845:0:b0:6b5:d078:585 with SMTP id d66-20020a376845000000b006b5d0780585mr10263064qkc.316.1658175860201;
        Mon, 18 Jul 2022 13:24:20 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id z12-20020ac8710c000000b0031d3d0b2a04sm9685947qto.9.2022.07.18.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:24:19 -0700 (PDT)
Message-ID: <97306a9fb52c0f5cd37b27817c901f4894298bcd.camel@poochiereds.net>
Subject: Re: [PATCH v2 15/15] NFS: Add an "xprtsec=" NFS mount option
From:   Jeff Layton <jlayton@poochiereds.net>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 18 Jul 2022 16:24:18 -0400
In-Reply-To: <165452712574.1496.3911067710891054200.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
         <165452712574.1496.3911067710891054200.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-06-06 at 10:52 -0400, Chuck Lever wrote:
> After some discussion, we decided that controlling transport layer
> security policy should be separate from the setting for the user
> authentication flavor. To accomplish this, add a new NFS mount
> option to select a transport layer security policy for RPC
> operations associated with the mount point.
>=20
>   xprtsec=3Dnone     - Transport layer security is disabled.
>=20
>   xprtsec=3Dtls      - Establish an encryption-only TLS session. If
>                      the initial handshake fails, the mount fails.
>                      If TLS is not available on a reconnect, drop
>                      the connection and try again.
>=20
> The mount.nfs command will provide an addition setting:
>=20
>   xprtsec=3Dauto     - Try to establish a TLS session, but proceed
>                      with no transport layer security if that fails.
>=20
> Updates to mount.nfs and nfs(5) will be sent under separate cover.
>=20

Seems like a reasonable interface.

> Future work:
>=20
> To support client peer authentication, the plan is to add another
> xprtsec=3D choice called "mtls" which will require a second mount
> option that specifies the pathname of a directory containing the
> private key and an x.509 certificate.
>=20
> Similarly, pre-shared key authentication can be supported by adding
> support for "xprtsec=3Dpsk" along with a second mount option that
> specifies the name of a file containing the key.
>=20


^^^
We might want something more flexible than this over the long haul.=20
Container orchestration like kubernetes would probably prefer to manage
this without sprinkling files all over.

Maybe we can allow this info to be set in the kernel keyring of the
mounting process instead of requiring files? In any case, we can cross
that bridge when we come to it.

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/client.c     |   10 +++++++++-
>  fs/nfs/fs_context.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  fs/nfs/internal.h   |    1 +
>  fs/nfs/nfs4client.c |    2 +-
>  fs/nfs/super.c      |    7 +++++++
>  5 files changed, 58 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 0896e4f047d1..1f26c1ad18b3 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -530,6 +530,14 @@ int nfs_create_rpc_client(struct nfs_client *clp,
>  	if (test_bit(NFS_CS_REUSEPORT, &clp->cl_flags))
>  		args.flags |=3D RPC_CLNT_CREATE_REUSEPORT;
> =20
> +	switch (clp->cl_xprtsec) {
> +	case NFS_CS_XPRTSEC_TLS:
> +		args.xprtsec =3D RPC_XPRTSEC_TLS_X509;
> +		break;
> +	default:
> +		args.xprtsec =3D RPC_XPRTSEC_NONE;
> +	}
> +
>  	if (!IS_ERR(clp->cl_rpcclient))
>  		return 0;
> =20
> @@ -680,7 +688,7 @@ static int nfs_init_server(struct nfs_server *server,
>  		.cred =3D server->cred,
>  		.nconnect =3D ctx->nfs_server.nconnect,
>  		.init_flags =3D (1UL << NFS_CS_REUSEPORT),
> -		.xprtsec_policy =3D NFS_CS_XPRTSEC_NONE,
> +		.xprtsec_policy =3D ctx->xprtsec_policy,
>  	};
>  	struct nfs_client *clp;
>  	int error;
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 35e400a557b9..3e29dd88b59b 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -88,6 +88,7 @@ enum nfs_param {
>  	Opt_vers,
>  	Opt_wsize,
>  	Opt_write,
> +	Opt_xprtsec,
>  };
> =20
>  enum {
> @@ -194,6 +195,7 @@ static const struct fs_parameter_spec nfs_fs_paramete=
rs[] =3D {
>  	fsparam_string("vers",		Opt_vers),
>  	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
>  	fsparam_u32   ("wsize",		Opt_wsize),
> +	fsparam_string("xprtsec",	Opt_xprtsec),
>  	{}
>  };
> =20
> @@ -267,6 +269,18 @@ static const struct constant_table nfs_secflavor_tok=
ens[] =3D {
>  	{}
>  };
> =20
> +enum {
> +	Opt_xprtsec_none,
> +	Opt_xprtsec_tls,
> +	nr__Opt_xprtsec
> +};
> +
> +static const struct constant_table nfs_xprtsec_policies[] =3D {
> +	{ "none",	Opt_xprtsec_none },
> +	{ "tls",	Opt_xprtsec_tls },
> +	{}
> +};
> +
>  /*
>   * Sanity-check a server address provided by the mount command.
>   *
> @@ -431,6 +445,26 @@ static int nfs_parse_security_flavors(struct fs_cont=
ext *fc,
>  	return 0;
>  }
> =20
> +static int nfs_parse_xprtsec_policy(struct fs_context *fc,
> +				    struct fs_parameter *param)
> +{
> +	struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
> +
> +	trace_nfs_mount_assign(param->key, param->string);
> +
> +	switch (lookup_constant(nfs_xprtsec_policies, param->string, -1)) {
> +	case Opt_xprtsec_none:
> +		ctx->xprtsec_policy =3D NFS_CS_XPRTSEC_NONE;
> +		break;
> +	case Opt_xprtsec_tls:
> +		ctx->xprtsec_policy =3D NFS_CS_XPRTSEC_TLS;
> +		break;
> +	default:
> +		return nfs_invalf(fc, "NFS: Unrecognized transport security policy");
> +	}
> +	return 0;
> +}
> +
>  static int nfs_parse_version_string(struct fs_context *fc,
>  				    const char *string)
>  {
> @@ -695,6 +729,11 @@ static int nfs_fs_context_parse_param(struct fs_cont=
ext *fc,
>  		if (ret < 0)
>  			return ret;
>  		break;
> +	case Opt_xprtsec:
> +		ret =3D nfs_parse_xprtsec_policy(fc, param);
> +		if (ret < 0)
> +			return ret;
> +		break;
> =20
>  	case Opt_proto:
>  		trace_nfs_mount_assign(param->key, param->string);
> @@ -1564,6 +1603,7 @@ static int nfs_init_fs_context(struct fs_context *f=
c)
>  		ctx->selected_flavor	=3D RPC_AUTH_MAXFLAVOR;
>  		ctx->minorversion	=3D 0;
>  		ctx->need_mount		=3D true;
> +		ctx->xprtsec_policy	=3D NFS_CS_XPRTSEC_NONE;
> =20
>  		fc->s_iflags		|=3D SB_I_STABLE_WRITES;
>  	}
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 0a3512c39376..bc60a556ad92 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -102,6 +102,7 @@ struct nfs_fs_context {
>  	unsigned int		bsize;
>  	struct nfs_auth_info	auth_info;
>  	rpc_authflavor_t	selected_flavor;
> +	unsigned int		xprtsec_policy;
>  	char			*client_address;
>  	unsigned int		version;
>  	unsigned int		minorversion;
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 682d47e5977b..8dbdb00859fe 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1159,7 +1159,7 @@ static int nfs4_init_server(struct nfs_server *serv=
er, struct fs_context *fc)
>  				ctx->nfs_server.nconnect,
>  				ctx->nfs_server.max_connect,
>  				fc->net_ns,
> -				NFS_CS_XPRTSEC_NONE);
> +				ctx->xprtsec_policy);
>  	if (error < 0)
>  		return error;
> =20
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 6ab5eeb000dc..66da994500f9 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -491,6 +491,13 @@ static void nfs_show_mount_options(struct seq_file *=
m, struct nfs_server *nfss,
>  	seq_printf(m, ",timeo=3D%lu", 10U * nfss->client->cl_timeout->to_initva=
l / HZ);
>  	seq_printf(m, ",retrans=3D%u", nfss->client->cl_timeout->to_retries);
>  	seq_printf(m, ",sec=3D%s", nfs_pseudoflavour_to_name(nfss->client->cl_a=
uth->au_flavor));
> +	switch (clp->cl_xprtsec) {
> +	case NFS_CS_XPRTSEC_TLS:
> +		seq_printf(m, ",xprtsec=3Dtls");
> +		break;
> +	default:
> +		break;
> +	}
> =20
>  	if (version !=3D 4)
>  		nfs_show_mountd_options(m, nfss, showdefaults);
>=20
>=20

--=20
Jeff Layton <jlayton@poochiereds.net>
