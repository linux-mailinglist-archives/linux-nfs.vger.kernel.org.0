Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2E78F148
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjHaQ3i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjHaQ3h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 12:29:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79810D7
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 09:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 923A26423A
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 16:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9637C433C7;
        Thu, 31 Aug 2023 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693499336;
        bh=++fgTN+ycOMFZ+UziUYxLmWO2V3AI9QM093L7yFJ8LY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ZpoHBrK2RFg1bfqm5pgPYIwoiBP3gWnXEVbakrRPn5JKgb2fycvXNc8cqUcHS1/Nw
         LvSSE39PEiuiutsQNJGkHalJawUK9bfQSvw2p6StBmXhyNs7Kuic/FkAP41OUZVYfE
         FeTj/TL5S/y87DzOn2gywHQiVK1ubgLV3L//18aRCmRMJscIUgl86h/S42XMx20uNG
         MfGIqkI1jDB32ZK+yfp3/WryZnr1xenE2pnt+1wCI5fN4BipGAt0AqLUHRrJsGPKup
         B69H9Rq48yh56fxrXUuIRQHEPBIPRTaBWEl9wvDN34YpuhhjGG7LMxcC/UoNISW1Tt
         EjwZUiRW3U8RQ==
Message-ID: <021d9cf4ba3ee8a776d8c227858866caf6c7308d.camel@kernel.org>
Subject: Re: [RFC PATCH] NFSv4: add sysctl for setting READDIR attrs
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Date:   Thu, 31 Aug 2023 12:28:54 -0400
In-Reply-To: <8f752f70daf73016e20c49508f825e8c2c94f5e7.1693494824.git.bcodding@redhat.com>
References: <8f752f70daf73016e20c49508f825e8c2c94f5e7.1693494824.git.bcodding@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-08-31 at 11:15 -0400, Benjamin Coddington wrote:
> Expose a knob in sysfs to set the READDIR requested attributes for a
> non-plus READDIR request.  This allows installations another option for
> tuning READDIR on v4.  Further work is needed to detect whether enough
> attributes are being returned to also prime the dcache.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/client.c           |  2 ++
>  fs/nfs/nfs4client.c       |  3 ++
>  fs/nfs/nfs4proc.c         |  1 +
>  fs/nfs/nfs4xdr.c          |  7 ++---
>  fs/nfs/sysfs.c            | 58 +++++++++++++++++++++++++++++++++++++++
>  include/linux/nfs_fs_sb.h |  1 +
>  include/linux/nfs_xdr.h   |  1 +
>  7 files changed, 69 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index e4c5f193ed5e..cf23a7c54bf1 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -920,6 +920,8 @@ void nfs_server_copy_userdata(struct nfs_server *targ=
et, struct nfs_server *sour
>  	target->options =3D source->options;
>  	target->auth_info =3D source->auth_info;
>  	target->port =3D source->port;
> +	memcpy(target->readdir_attrs, source->readdir_attrs,
> +			sizeof(target->readdir_attrs));
>  }
>  EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
> =20
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index d9114a754db7..ba1dffdd25eb 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1108,6 +1108,9 @@ static int nfs4_server_common_setup(struct nfs_serv=
er *server,
> =20
>  	nfs4_server_set_init_caps(server);
> =20
> +	server->readdir_attrs[0] =3D FATTR4_WORD0_RDATTR_ERROR;
> +	server->readdir_attrs[1] =3D FATTR4_WORD1_MOUNTED_ON_FILEID;
> +
>  	/* Probe the root fh to retrieve its FSID and filehandle */
>  	error =3D nfs4_get_rootfh(server, mntfh, auth_probe);
>  	if (error < 0)
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 832fa226b8f2..12cc9e972f36 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5109,6 +5109,7 @@ static int _nfs4_proc_readdir(struct nfs_readdir_ar=
g *nr_arg,
>  		.pgbase =3D 0,
>  		.count =3D nr_arg->page_len,
>  		.plus =3D nr_arg->plus,
> +		.server =3D server,
>  	};
>  	struct nfs4_readdir_res res;
>  	struct rpc_message msg =3D {
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index deec76cf5afe..1825e3eeb34b 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1601,16 +1601,15 @@ static void encode_read(struct xdr_stream *xdr, c=
onst struct nfs_pgio_args *args
> =20
>  static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_rea=
ddir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
>  {
> -	uint32_t attrs[3] =3D {
> -		FATTR4_WORD0_RDATTR_ERROR,
> -		FATTR4_WORD1_MOUNTED_ON_FILEID,
> -	};
> +	uint32_t attrs[3];
>  	uint32_t dircount =3D readdir->count;
>  	uint32_t maxcount =3D readdir->count;
>  	__be32 *p, verf[2];
>  	uint32_t attrlen =3D 0;
>  	unsigned int i;
> =20
> +	memcpy(attrs, readdir->server->readdir_attrs, sizeof(attrs));
> +
>  	if (readdir->plus) {
>  		attrs[0] |=3D FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
>  			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index bf378ecd5d9f..6bded395df18 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -270,7 +270,59 @@ shutdown_store(struct kobject *kobj, struct kobj_att=
ribute *attr,
>  	return count;
>  }
> =20
> +static ssize_t
> +v4_readdir_attrs_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				char *buf)
> +{
> +	struct nfs_server *server;
> +	server =3D container_of(kobj, struct nfs_server, kobj);
> +
> +	return sysfs_emit(buf, "0x%x 0x%x 0x%x\n",
> +			server->readdir_attrs[0],
> +			server->readdir_attrs[1],
> +			server->readdir_attrs[2]);
> +}
> +
> +static ssize_t
> +v4_readdir_attrs_store(struct kobject *kobj, struct kobj_attribute *attr=
,
> +				const char *buf, size_t count)
> +{
> +	struct nfs_server *server;
> +	u32 attrs[3];
> +	char p[24], *v;
> +	size_t token =3D 0;
> +	int i;
> +
> +	if (count > 24)
> +		return -EINVAL;
> +
> +	v =3D strncpy(p, buf, count);
> +
> +	for (i =3D 0; i < 3; i++) {
> +		token +=3D strcspn(v, " ") + 1;
> +		if (token > 22)
> +			return -EINVAL;
> +
> +		p[token - 1] =3D '\0';
> +		if (kstrtoint(v, 0, &attrs[i]))
> +			return -EINVAL;
> +		v =3D &p[token];
> +	}
> +
> +	server =3D container_of(kobj, struct nfs_server, kobj);
> +
> +	if (attrs[0])
> +		server->readdir_attrs[0] =3D attrs[0];
> +	if (attrs[1])
> +		server->readdir_attrs[1] =3D attrs[1];
> +	if (attrs[2])
> +		server->readdir_attrs[2] =3D attrs[2];
> +
> +	return count;
> +}
> +
>  static struct kobj_attribute nfs_sysfs_attr_shutdown =3D __ATTR_RW(shutd=
own);
> +static struct kobj_attribute nfs_sysfs_attr_v4_readdir_attrs =3D __ATTR_=
RW(v4_readdir_attrs);
> =20
>  #define RPC_CLIENT_NAME_SIZE 64
> =20
> @@ -325,6 +377,12 @@ void nfs_sysfs_add_server(struct nfs_server *server)
>  	if (ret < 0)
>  		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>  			server->s_sysfs_id, ret);
> +
> +	ret =3D sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_v4_readdir_=
attrs.attr,
> +				nfs_netns_server_namespace(&server->kobj));
> +	if (ret < 0)
> +		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> +			server->s_sysfs_id, ret);
>  }
>  EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
> =20
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 20eeba8b009d..f37cc3fe140e 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -218,6 +218,7 @@ struct nfs_server {
>  						   of change attribute, size, ctime
>  						   and mtime attributes supported by
>  						   the server */
> +	u32			readdir_attrs[3]; /* V4 tuneable default readdir attrs */
>  	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
>  						   that are supported on this
>  						   filesystem */
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 12bbb5c63664..e05d861b1788 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1142,6 +1142,7 @@ struct nfs4_readdir_arg {
>  	struct page **			pages;	/* zero-copy data */
>  	unsigned int			pgbase;	/* zero-copy data */
>  	const u32 *			bitmask;
> +	const struct nfs_server		*server;
>  	bool				plus;
>  };
> =20

This doesn't seem worthwhile to me. We have a clear reason to add
WORD0_TYPE to "basic" READDIR, which is that we want to be able to fill
out the d_type for getdents.

I don't see the same sort of rationale for fetching other attributes. It
would just be priming the inode cache with certain info. That could
useful for some workloads, but that seems like sort of a niche thing.

Adding more info also reduces the number of entries you can pack into a
READDIR reply, which is makes it easier to trigger cookie problems with
creates and deletes in large directories.
--=20
Jeff Layton <jlayton@kernel.org>
