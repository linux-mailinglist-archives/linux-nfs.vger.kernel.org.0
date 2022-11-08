Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257E2620CC9
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 11:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiKHKBx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 05:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiKHKBw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 05:01:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F3F2A264
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 02:01:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE80061236
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 10:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA56C433D6;
        Tue,  8 Nov 2022 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667901710;
        bh=ckxXE+cHw0w92spMIniZ49V1lwe1HS3THCgxaqcWm2Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hOrhgN8A+wLo9a/BcvsltgtZGG7VJ6xl5EEsObgNMEgC+49OVohGDbkV8PH/CCOwE
         Zj732QWk3vstOCdjpNlqOnW+cKWsN2lrEN9txTMbHsrJ/xDVzsw6N6o57+ZEQ3eSD3
         zgdyi6/UZLq4fPCqDpVQ3m5Rrun/bFcs0j1myZ3zvkycXpFUiqCllNfknC/hdM8Ad3
         cY4CIq1A2niBYqS+OkccFvMesO4TY+18G3+Z3iAT9F2w/v4OXxqO0X9/6fsECS/VyO
         z8lAZH3Wx2YhYvVC7xs6ohHYyzdm/TPSBLz5zjfzPZHC3PPsv4jlQhI+5Xgxrwgw5g
         URfFvSpgX1TBA==
Message-ID: <9c9363ccabfa9906bcfd2604ec25994b57ee0f44.camel@kernel.org>
Subject: Re: [PATCH] NFS: Allow setting rsize / wsize to a multiple of
 PAGE_SIZE
From:   Jeff Layton <jlayton@kernel.org>
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com
Cc:     Jianhong Yin <jiyin@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>
Date:   Tue, 08 Nov 2022 05:01:48 -0500
In-Reply-To: <20220617202336.1099702-1-anna@kernel.org>
References: <20220617202336.1099702-1-anna@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-06-17 at 16:23 -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Previously, we required this to value to be a power of 2 for UDP related
> reasons. This patch keeps the power of 2 rule for UDP but allows more
> flexibility for TCP and RDMA.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  fs/nfs/client.c                           | 13 +++++++------
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c |  6 ++++--
>  fs/nfs/internal.h                         | 18 ++++++++++++++++++
>  fs/nfs/nfs4client.c                       |  4 ++--
>  4 files changed, 31 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index e828504cc396..da8da5cdbbc1 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -708,9 +708,9 @@ static int nfs_init_server(struct nfs_server *server,
>  	}
> =20
>  	if (ctx->rsize)
> -		server->rsize =3D nfs_block_size(ctx->rsize, NULL);
> +		server->rsize =3D nfs_io_size(ctx->rsize, clp->cl_proto);
>  	if (ctx->wsize)
> -		server->wsize =3D nfs_block_size(ctx->wsize, NULL);
> +		server->wsize =3D nfs_io_size(ctx->wsize, clp->cl_proto);
> =20
>  	server->acregmin =3D ctx->acregmin * HZ;
>  	server->acregmax =3D ctx->acregmax * HZ;
> @@ -755,18 +755,19 @@ static int nfs_init_server(struct nfs_server *serve=
r,
>  static void nfs_server_set_fsinfo(struct nfs_server *server,
>  				  struct nfs_fsinfo *fsinfo)
>  {
> +	struct nfs_client *clp =3D server->nfs_client;
>  	unsigned long max_rpc_payload, raw_max_rpc_payload;
> =20
>  	/* Work out a lot of parameters */
>  	if (server->rsize =3D=3D 0)
> -		server->rsize =3D nfs_block_size(fsinfo->rtpref, NULL);
> +		server->rsize =3D nfs_io_size(fsinfo->rtpref, clp->cl_proto);
>  	if (server->wsize =3D=3D 0)
> -		server->wsize =3D nfs_block_size(fsinfo->wtpref, NULL);
> +		server->wsize =3D nfs_io_size(fsinfo->wtpref, clp->cl_proto);
> =20
>  	if (fsinfo->rtmax >=3D 512 && server->rsize > fsinfo->rtmax)
> -		server->rsize =3D nfs_block_size(fsinfo->rtmax, NULL);
> +		server->rsize =3D nfs_io_size(fsinfo->rtmax, clp->cl_proto);
>  	if (fsinfo->wtmax >=3D 512 && server->wsize > fsinfo->wtmax)
> -		server->wsize =3D nfs_block_size(fsinfo->wtmax, NULL);
> +		server->wsize =3D nfs_io_size(fsinfo->wtmax, clp->cl_proto);
> =20
>  	raw_max_rpc_payload =3D rpc_max_payload(server->client);
>  	max_rpc_payload =3D nfs_block_size(raw_max_rpc_payload, NULL);
> diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilel=
ayout/flexfilelayoutdev.c
> index bfa7202ca7be..e028f5a0ef5f 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> @@ -113,8 +113,10 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *serve=
r, struct pnfs_device *pdev,
>  			goto out_err_drain_dsaddrs;
>  		ds_versions[i].version =3D be32_to_cpup(p++);
>  		ds_versions[i].minor_version =3D be32_to_cpup(p++);
> -		ds_versions[i].rsize =3D nfs_block_size(be32_to_cpup(p++), NULL);
> -		ds_versions[i].wsize =3D nfs_block_size(be32_to_cpup(p++), NULL);
> +		ds_versions[i].rsize =3D nfs_io_size(be32_to_cpup(p++),
> +						   server->nfs_client->cl_proto);
> +		ds_versions[i].wsize =3D nfs_io_size(be32_to_cpup(p++),
> +						   server->nfs_client->cl_proto);
>  		ds_versions[i].tightly_coupled =3D be32_to_cpup(p);
> =20
>  		if (ds_versions[i].rsize > NFS_MAX_FILE_IO_SIZE)
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 8f8cd6e2d4db..af6d261241ff 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -704,6 +704,24 @@ unsigned long nfs_block_size(unsigned long bsize, un=
signed char *nrbitsp)
>  	return nfs_block_bits(bsize, nrbitsp);
>  }
> =20
> +/*
> + * Compute and set NFS server rsize / wsize
> + */
> +static inline
> +unsigned long nfs_io_size(unsigned long iosize, enum xprt_transports pro=
to)
> +{
> +	if (iosize < NFS_MIN_FILE_IO_SIZE)
> +		iosize =3D NFS_DEF_FILE_IO_SIZE;
> +	else if (iosize >=3D NFS_MAX_FILE_IO_SIZE)
> +		iosize =3D NFS_MAX_FILE_IO_SIZE;
> +	else
> +		iosize =3D iosize & PAGE_MASK;
> +
> +	if (proto =3D=3D XPRT_TRANSPORT_UDP)
> +		return nfs_block_bits(iosize, NULL);
> +	return iosize;
> +}
> +
>  /*
>   * Determine the maximum file size for a superblock
>   */
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 47a6cf892c95..3c5678aec006 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1161,9 +1161,9 @@ static int nfs4_init_server(struct nfs_server *serv=
er, struct fs_context *fc)
>  		return error;
> =20
>  	if (ctx->rsize)
> -		server->rsize =3D nfs_block_size(ctx->rsize, NULL);
> +		server->rsize =3D nfs_io_size(ctx->rsize, server->nfs_client->cl_proto=
);
>  	if (ctx->wsize)
> -		server->wsize =3D nfs_block_size(ctx->wsize, NULL);
> +		server->wsize =3D nfs_io_size(ctx->wsize, server->nfs_client->cl_proto=
);
> =20
>  	server->acregmin =3D ctx->acregmin * HZ;
>  	server->acregmax =3D ctx->acregmax * HZ;

This patch seems to have caused a regression. With this patch in place,
I can't set an rsize/wsize value that is less than 4k:

    # mount server:/export /mnt -o rsize=3D1024,wsize=3D1024

...now yields:

    server:/export on /mnt type nfs4 (rw,relatime,vers=3D4.2,rsize=3D104857=
6,wsize=3D1048576,namlen=3D255,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=
=3Dsys,clientaddr=3D192.168.1.210,local_lock=3Dnone,addr=3D192.168.1.3)

...such that the requested sizes were ignored.

Was this an intended effect? If we really do want to deprecate the use
of small rsize/wsize with TCP/RDMA, then we probably ought to reject
these mount attempts with -EINVAL.
--=20
Jeff Layton <jlayton@kernel.org>
