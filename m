Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA43784952
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Aug 2023 20:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHVSQe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Aug 2023 14:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHVSQd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Aug 2023 14:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808B0128
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 11:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EEAA619B9
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 18:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F1C433C8;
        Tue, 22 Aug 2023 18:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692728190;
        bh=HrlMlpIZxA1ttp+2acqjNWH7au3/S6fSrgZO+q4z82w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QJTDqdv/6pimL9VKU8zOAb+gOlMHyZK7XNa/xwV2vNKO0/7UMNnWpIV/90IHx8+Z+
         ffG0O/s528tgdcWTmacYOVq3+kAschgDLXIodmVz8gnVplPSghXUBZwEU5Il9Q6fm6
         hohzDB2QSe45dPpSjrTC6tLQc+qxzhw70JUMiaCcQqS7789jE1SMfMQFsQmWgfFcGG
         nJ432TNEiE/Ay7i804Q7VUhfOIETNTKL6xtDmQtbmGvvX3RCwPRVMuDP/qiU/QpFQF
         PT7xhoOXeSlgo5LM0Lm8YY5gulBKC4Amch2HsAaxeodIetzS0pdWmPGGqh84/oZuwC
         dB+wJYEMeMHsg==
Message-ID: <d7821abc0df7daea8c9458bf8528b8c227524c3f.camel@kernel.org>
Subject: Re: [RFC PATCH v1.1] nfs: Add support for the birth time attribute
From:   Jeff Layton <jlayton@kernel.org>
To:     Chen Hanxiao <chenhx.fnst@fujitsu.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 22 Aug 2023 14:16:28 -0400
In-Reply-To: <20230822100008.1942-1-chenhx.fnst@fujitsu.com>
References: <20230822100008.1942-1-chenhx.fnst@fujitsu.com>
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

On Tue, 2023-08-22 at 18:00 +0800, Chen Hanxiao wrote:
> nfsd already support btime by:
> commit e377a3e698fb ("nfsd: Add support for the birth time attribute")
>=20
> This patch enable nfs to report btime in nfs_getattr.
> If underlying filesystem supports "btime" timestamp,
> statx will report btime for STATX_BTIME.
>=20
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
>=20
> ---
> 1.1:
> 	minor fix
>=20
>  fs/nfs/inode.c          | 14 +++++++++++++-
>  fs/nfs/nfs4proc.c       |  3 +++
>  fs/nfs/nfs4xdr.c        | 23 +++++++++++++++++++++++
>  include/linux/nfs_fs.h  |  2 ++
>  include/linux/nfs_xdr.h |  2 ++
>  5 files changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 8172dd4135a1..36e322b993f8 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -835,6 +835,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
>  {
>  	struct inode *inode =3D d_inode(path->dentry);
>  	struct nfs_server *server =3D NFS_SERVER(inode);
> +	struct nfs_inode *nfsi =3D NFS_I(inode);
>  	unsigned long cache_validity;
>  	int err =3D 0;
>  	bool force_sync =3D query_flags & AT_STATX_FORCE_SYNC;
> @@ -845,7 +846,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
> =20
>  	request_mask &=3D STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
>  			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
> -			STATX_INO | STATX_SIZE | STATX_BLOCKS |
> +			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
>  			STATX_CHANGE_COOKIE;
> =20
>  	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
> @@ -911,6 +912,10 @@ int nfs_getattr(struct mnt_idmap *idmap, const struc=
t path *path,
>  out_no_revalidate:
>  	/* Only return attributes that were revalidated. */
>  	stat->result_mask =3D nfs_get_valid_attrmask(inode) | request_mask;
> +	if (nfsi->btime.tv_sec =3D=3D 0 && nfsi->btime.tv_nsec =3D=3D 0)
> +		stat->result_mask &=3D ~STATX_BTIME;
> +	else
> +		stat->btime =3D nfsi->btime;
> =20
>  	generic_fillattr(&nop_mnt_idmap, inode, stat);
>  	stat->ino =3D nfs_compat_user_ino64(NFS_FILEID(inode));
> @@ -2189,6 +2194,12 @@ static int nfs_update_inode(struct inode *inode, s=
truct nfs_fattr *fattr)
>  		nfsi->cache_validity |=3D
>  			save_cache_validity & NFS_INO_INVALID_MTIME;
> =20
> +	if (fattr->valid & NFS_ATTR_FATTR_BTIME) {
> +		nfsi->btime =3D fattr->btime;
> +	} else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
> +		nfsi->cache_validity |=3D
> +			save_cache_validity & NFS_INO_INVALID_BTIME;
> +

I'm not sure we actually need the "else" part here, or the INVALID_BTIME
bit. The btime isn't expected to change, really ever, so if the server
didn't report it, I think we're generally safe to trust whatever we have
in cache.

>  	if (fattr->valid & NFS_ATTR_FATTR_CTIME)
>  		inode->i_ctime =3D fattr->ctime;
>  	else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
> @@ -2332,6 +2343,7 @@ struct inode *nfs_alloc_inode(struct super_block *s=
b)
>  #endif /* CONFIG_NFS_V4 */
>  #ifdef CONFIG_NFS_V4_2
>  	nfsi->xattr_cache =3D NULL;
> +	memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>  #endif
>  	nfs_netfs_inode_init(nfsi);
> =20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index e1a886b58354..c4717ae4b1b3 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -211,6 +211,7 @@ const u32 nfs4_fattr_bitmap[3] =3D {
>  	| FATTR4_WORD1_TIME_ACCESS
>  	| FATTR4_WORD1_TIME_METADATA
>  	| FATTR4_WORD1_TIME_MODIFY
> +	| FATTR4_WORD1_TIME_CREATE
>  	| FATTR4_WORD1_MOUNTED_ON_FILEID,
>  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
>  	FATTR4_WORD2_SECURITY_LABEL
> @@ -3909,6 +3910,8 @@ static int _nfs4_server_capabilities(struct nfs_ser=
ver *server, struct nfs_fh *f
>  			server->fattr_valid &=3D ~NFS_ATTR_FATTR_CTIME;
>  		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
>  			server->fattr_valid &=3D ~NFS_ATTR_FATTR_MTIME;
> +		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_CREATE))
> +			server->fattr_valid &=3D ~NFS_ATTR_FATTR_BTIME;
>  		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
>  				sizeof(server->attr_bitmask));
>  		server->attr_bitmask_nl[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index deec76cf5afe..df3699eb29e8 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -4171,6 +4171,24 @@ static int decode_attr_time_access(struct xdr_stre=
am *xdr, uint32_t *bitmap, str
>  	return status;
>  }
> =20
> +static int decode_attr_time_create(struct xdr_stream *xdr, uint32_t *bit=
map, struct timespec64 *time)
> +{
> +	int status =3D 0;
> +
> +	time->tv_sec =3D 0;
> +	time->tv_nsec =3D 0;
> +	if (unlikely(bitmap[1] & (FATTR4_WORD1_TIME_CREATE - 1U)))
> +		return -EIO;
> +	if (likely(bitmap[1] & FATTR4_WORD1_TIME_CREATE)) {
> +		status =3D decode_attr_time(xdr, time);
> +		if (status =3D=3D 0)
> +			status =3D NFS_ATTR_FATTR_BTIME;
> +		bitmap[1] &=3D ~FATTR4_WORD1_TIME_CREATE;
> +	}
> +	dprintk("%s: btime=3D%lld\n", __func__, time->tv_sec);
> +	return status;
> +}
> +
>  static int decode_attr_time_metadata(struct xdr_stream *xdr, uint32_t *b=
itmap, struct timespec64 *time)
>  {
>  	int status =3D 0;
> @@ -4730,6 +4748,11 @@ static int decode_getfattr_attrs(struct xdr_stream=
 *xdr, uint32_t *bitmap,
>  		goto xdr_error;
>  	fattr->valid |=3D status;
> =20
> +	status =3D decode_attr_time_create(xdr, bitmap, &fattr->btime);
> +	if (status < 0)
> +		goto xdr_error;
> +	fattr->valid |=3D status;
> +
>  	status =3D decode_attr_time_metadata(xdr, bitmap, &fattr->ctime);
>  	if (status < 0)
>  		goto xdr_error;
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 279262057a92..ba8c1872494d 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -159,6 +159,7 @@ struct nfs_inode {
>  	unsigned long		read_cache_jiffies;
>  	unsigned long		attrtimeo;
>  	unsigned long		attrtimeo_timestamp;
> +	struct timespec64       btime;
> =20
>  	unsigned long		attr_gencount;
> =20
> @@ -298,6 +299,7 @@ struct nfs4_copy_state {
>  #define NFS_INO_INVALID_XATTR	BIT(15)		/* xattrs are invalid */
>  #define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
>  #define NFS_INO_INVALID_MODE	BIT(17)		/* cached mode is invalid */
> +#define NFS_INO_INVALID_BTIME	BIT(18)		/* cached btime is invalid */
> =20
>  #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
>  		| NFS_INO_INVALID_CTIME \
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 12bbb5c63664..8e90c5bbf5e4 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -67,6 +67,7 @@ struct nfs_fattr {
>  	struct timespec64	atime;
>  	struct timespec64	mtime;
>  	struct timespec64	ctime;
> +	struct timespec64	btime;
>  	__u64			change_attr;	/* NFSv4 change attribute */
>  	__u64			pre_change_attr;/* pre-op NFSv4 change attribute */
>  	__u64			pre_size;	/* pre_op_attr.size	  */
> @@ -106,6 +107,7 @@ struct nfs_fattr {
>  #define NFS_ATTR_FATTR_OWNER_NAME	(1U << 23)
>  #define NFS_ATTR_FATTR_GROUP_NAME	(1U << 24)
>  #define NFS_ATTR_FATTR_V4_SECURITY_LABEL (1U << 25)
> +#define NFS_ATTR_FATTR_BTIME		(1U << 26)
> =20
>  #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
>  		| NFS_ATTR_FATTR_MODE \

Looks good otherwise.

Note that Trond had patches a few years ago that added this support but
they got dropped for some reason. It might be good to follow back up on
that discussion and make sure you address any concerns that were brought
up there.

--=20
Jeff Layton <jlayton@kernel.org>
