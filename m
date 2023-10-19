Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C7D7D0003
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 18:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjJSQzX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Oct 2023 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjJSQzV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 12:55:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC159126
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 09:55:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C8DC433C7;
        Thu, 19 Oct 2023 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697734519;
        bh=c9LbcTZWNaU6WQzX93CTBJ/i7V/n+sF+YEuHpKHxeLQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l62x1Doj4dCt0zCit/8fve18O/YnR0yiSpLfcQtuWVlWFLzIx0jIyxGryiPmxEqWR
         K1DCaRn6l6oKahBXI7pUIu6EvmGozFGxf8VLhLjPv0MYy2eGKl/fUnSciApI5saz/F
         l7xUpNW/CqM4l4goJi7L4wGiJinySaFk1EDDtmp1Ii68B4Mtvv8w8syBG3ZkNNzTuj
         z5ICfYBpETispvMsX55qFK8daavXj3xfUZIGc0gQuUB8Za7B61/QIFbv0U1bOXskv1
         NUXWzjDcFDDXoxRMLV72aFmh6A8kPnKXeHGcYNh+6UtYPljk0YUy/B4CfK7u35owjn
         4Wq1FgMkucZAQ==
Message-ID: <12d7225becae370a923bec807a140f8e87c0eca0.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 19 Oct 2023 12:55:17 -0400
In-Reply-To: <fbd3cd01c28e8c132058ae16b22eeae5ddaa8178.1697722160.git.bcodding@redhat.com>
References: <cover.1697722160.git.bcodding@redhat.com>
         <fbd3cd01c28e8c132058ae16b22eeae5ddaa8178.1697722160.git.bcodding@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-10-19 at 09:34 -0400, Benjamin Coddington wrote:
> Expose a per-mount knob in sysfs to set the READDIR requested attributes
> for a non-plus READDIR request.
>=20
> For example:
>=20
>   echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs
>=20
> .. will revert the client to only request rdattr_error and
> mounted_on_fileid for any non "plus" READDIR, as before the patch
> preceeding this one in this series.  This provides existing installations
> an option to fix a potential performance regression that may occur after
> NFS clients update to request additional default READDIR attributes.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/client.c           |  4 ++
>  fs/nfs/nfs4client.c       |  4 ++
>  fs/nfs/nfs4proc.c         |  1 +
>  fs/nfs/nfs4xdr.c          |  7 ++--
>  fs/nfs/sysfs.c            | 86 +++++++++++++++++++++++++++++++++++++++
>  include/linux/nfs_fs_sb.h |  1 +
>  include/linux/nfs_xdr.h   |  1 +
>  7 files changed, 100 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 44eca51b2808..981a2437b752 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -922,6 +922,10 @@ void nfs_server_copy_userdata(struct nfs_server *tar=
get, struct nfs_server *sour
>  	target->options =3D source->options;
>  	target->auth_info =3D source->auth_info;
>  	target->port =3D source->port;
> +#if IS_ENABLED(CONFIG_NFS_V4)
> +	memcpy(target->readdir_attrs, source->readdir_attrs,
> +			sizeof(target->readdir_attrs));
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
> =20
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 11e3a285594c..3bbfb4244c14 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1115,6 +1115,10 @@ static int nfs4_server_common_setup(struct nfs_ser=
ver *server,
> =20
>  	nfs4_server_set_init_caps(server);
> =20
> +	/* Default (non-plus) v4 readdir attributes */
> +	server->readdir_attrs[0] =3D FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERRO=
R;
> +	server->readdir_attrs[1] =3D FATTR4_WORD1_MOUNTED_ON_FILEID;
> +
>  	/* Probe the root fh to retrieve its FSID and filehandle */
>  	error =3D nfs4_get_rootfh(server, mntfh, auth_probe);
>  	if (error < 0)
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 7016eaadf555..0f0028de7941 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5113,6 +5113,7 @@ static int _nfs4_proc_readdir(struct nfs_readdir_ar=
g *nr_arg,
>  		.pgbase =3D 0,
>  		.count =3D nr_arg->page_len,
>  		.plus =3D nr_arg->plus,
> +		.server =3D server,
>  	};
>  	struct nfs4_readdir_res res;
>  	struct rpc_message msg =3D {
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 7200d6f7cd7b..45a9b40b801e 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1601,16 +1601,15 @@ static void encode_read(struct xdr_stream *xdr, c=
onst struct nfs_pgio_args *args
> =20
>  static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_rea=
ddir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
>  {
> -	uint32_t attrs[3] =3D {
> -		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
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
>  		attrs[0] |=3D FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
>  			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index bf378ecd5d9f..03ada52aaee0 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -272,6 +272,84 @@ shutdown_store(struct kobject *kobj, struct kobj_att=
ribute *attr,
> =20
>  static struct kobj_attribute nfs_sysfs_attr_shutdown =3D __ATTR_RW(shutd=
own);
> =20
> +#if IS_ENABLED(CONFIG_NFS_V4)
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
> +	char p[36], *v;
> +	size_t token =3D 0;
> +	int i;
> +
> +	if (count > 36)
> +		return -EINVAL;
> +
> +	v =3D strncpy(p, buf, count);
> +
> +	for (i =3D 0; i < 3; i++) {
> +		token +=3D strcspn(v, " ") + 1;
> +		if (token > 34)
> +			return -EINVAL;
> +
> +		p[token - 1] =3D '\0';
> +		if (kstrtoint(v, 0, &attrs[i]))
> +			return -EINVAL;
> +		v =3D &p[token];
> +	}
> +
> +	/* Allow only what we decode - see decode_getfattr_attrs() */
> +	if (attrs[0] & ~(FATTR4_WORD0_TYPE |
> +			FATTR4_WORD0_CHANGE |
> +			FATTR4_WORD0_SIZE |
> +			FATTR4_WORD0_FSID |
> +			FATTR4_WORD0_RDATTR_ERROR |
> +			FATTR4_WORD0_FILEHANDLE |
> +			FATTR4_WORD0_FILEID |
> +			FATTR4_WORD0_FS_LOCATIONS) ||
> +		attrs[1] & ~(FATTR4_WORD1_MODE |
> +			FATTR4_WORD1_NUMLINKS |
> +			FATTR4_WORD1_OWNER |
> +			FATTR4_WORD1_OWNER_GROUP |
> +			FATTR4_WORD1_RAWDEV |
> +			FATTR4_WORD1_SPACE_USED |
> +			FATTR4_WORD1_TIME_ACCESS |
> +			FATTR4_WORD1_TIME_METADATA |
> +			FATTR4_WORD1_TIME_MODIFY |
> +			FATTR4_WORD1_MOUNTED_ON_FILEID) ||
> +		attrs[2] & ~(FATTR4_WORD2_MDSTHRESHOLD |
> +			FATTR4_WORD2_SECURITY_LABEL))
> +		return -EINVAL;
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
> +static struct kobj_attribute nfs_sysfs_attr_v4_readdir_attrs =3D __ATTR_=
RW(v4_readdir_attrs);
> +#endif /* CONFIG_NFS_V4 */
> +
>  #define RPC_CLIENT_NAME_SIZE 64
> =20
>  void nfs_sysfs_link_rpc_client(struct nfs_server *server,
> @@ -325,6 +403,14 @@ void nfs_sysfs_add_server(struct nfs_server *server)
>  	if (ret < 0)
>  		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>  			server->s_sysfs_id, ret);
> +
> +#if IS_ENABLED(CONFIG_NFS_V4)
> +	ret =3D sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_v4_readdir_=
attrs.attr,
> +				nfs_netns_server_namespace(&server->kobj));
> +	if (ret < 0)
> +		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> +			server->s_sysfs_id, ret);
> +#endif /* IS_ENABLED(CONFIG_NFS_V4) */
>  }
>  EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
> =20
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index cd628c4b011e..db87261b7cd7 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -219,6 +219,7 @@ struct nfs_server {
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

If you are going to add this, then I think the consensus from
yesterday's comments was to put it behind a new Kconfig option. Maybe
there could be a new CONFIG_NFS_TWEAKS or something that exposes this
interface (and other stuff we're not sure about making generally
available).
--=20
Jeff Layton <jlayton@kernel.org>
