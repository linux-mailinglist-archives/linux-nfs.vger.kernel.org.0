Return-Path: <linux-nfs+bounces-11947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE6AC69E3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 14:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BBE7B055B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FE6283FC3;
	Wed, 28 May 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0hpDGpC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296B246774
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437031; cv=none; b=AvIPJLyEDhm5NKQGshnogIm8UWC6s9NI+ecRSaJPJTAwcpAKtjxNVETzE3chgArUSJ4U1tf2K7+f69NxnQUxDg9zkiSVyFfIArVgdqv9C8anmRPhEaYUSsOaz0TeTZP7IVNZbqkkrtjAcVlYi17++DwDLZDZChKoNHqDdrvoFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437031; c=relaxed/simple;
	bh=ZFu1JTfGsFcZdGAkFwrYMHwOJtmxfCebcoN26nhWDuk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZY9Qd8Wi1BTdsVLwAivuG0TmKnAsE6uASjab7SuCkmwqeRw8kqCJeoIb1rECcClPRxhaNAfikGbx++ppmnS35FyX4qg7ddLPPIvJ2LasM66NgA3WlOzuGk7y7JxjrnILuaxGB2/1hmM0jTROclX6TJ++VznSx7/D6YYfs5FAxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0hpDGpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA29C4CEE7;
	Wed, 28 May 2025 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748437031;
	bh=ZFu1JTfGsFcZdGAkFwrYMHwOJtmxfCebcoN26nhWDuk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=t0hpDGpC4oQYAstKAm+hrBiyoGPfV7W7VON68Iffw/XEdFLGspyQZ5q72RFHfZDjx
	 ItMOcDNMm/5ZMyMFBM51vqOzWvnh1mkcya/oA8L7av3syc4aFEwqjvicO83bKeQzfB
	 Icn1iuMmi4VtiHZStGg8hXeVouPtcD1630KrAWRHYwrU0K71EvfCTfaMvMkisP/CaI
	 zpWUco+6/WHw3syYg6uECDelVWRGsRD8ddZ3BkFMPLIb5OdUQtbD/SSXF/5Ky8XoaZ
	 oafOU1WDkM0V1JJTOZsgHPYxbTggMGnH3c8n8u57y3cIj10h8897w3lr8qgkXJ823h
	 Mk03x9rGVZcAQ==
Message-ID: <a639fc978c9bdc54943301fad6618f8f068203ce.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] nfs: Add timecreate to nfs inode
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>, Trond Myklebust
	 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Lance Shelton <lance.shelton@hammerspace.com>
Date: Wed, 28 May 2025 08:56:37 -0400
In-Reply-To: <ee8d37a7b6495e95aa2875241e2962d41e57dc14.1748436487.git.bcodding@redhat.com>
References: <cover.1748436487.git.bcodding@redhat.com>
	 <ee8d37a7b6495e95aa2875241e2962d41e57dc14.1748436487.git.bcodding@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-28 at 08:50 -0400, Benjamin Coddington wrote:
> From: Anne Marie Merritt <annemarie.merritt@primarydata.com>
>=20
> Add tracking of the create time (a.k.a. btime) along with corresponding
> bitfields, request, and decode xdr routines.
>=20
> Signed-off-by: Anne Marie Merritt <annemarie.merritt@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/inode.c          | 28 ++++++++++++++++++++++------
>  fs/nfs/nfs4proc.c       | 14 +++++++++++++-
>  fs/nfs/nfs4xdr.c        | 24 ++++++++++++++++++++++++
>  fs/nfs/nfstrace.h       |  3 ++-
>  include/linux/nfs_fs.h  |  7 +++++++
>  include/linux/nfs_xdr.h |  3 +++
>  6 files changed, 71 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 160f3478a835..fd84c24963b3 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -197,6 +197,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsig=
ned long flags)
>  		if (!(flags & NFS_INO_REVAL_FORCED))
>  			flags &=3D ~(NFS_INO_INVALID_MODE |
>  				   NFS_INO_INVALID_OTHER |
> +				   NFS_INO_INVALID_BTIME |
>  				   NFS_INO_INVALID_XATTR);
>  		flags &=3D ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
>  	}
> @@ -522,6 +523,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, =
struct nfs_fattr *fattr)
>  		inode_set_atime(inode, 0, 0);
>  		inode_set_mtime(inode, 0, 0);
>  		inode_set_ctime(inode, 0, 0);
> +		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>  		inode_set_iversion_raw(inode, 0);
>  		inode->i_size =3D 0;
>  		clear_nlink(inode);
> @@ -545,6 +547,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh,=
 struct nfs_fattr *fattr)
>  			inode_set_ctime_to_ts(inode, fattr->ctime);
>  		else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
>  			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
> +		if (fattr->valid & NFS_ATTR_FATTR_BTIME)
> +			nfsi->btime =3D fattr->btime;
> +		else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
> +			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BTIME);
>  		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
>  			inode_set_iversion_raw(inode, fattr->change_attr);
>  		else
> @@ -1900,7 +1906,7 @@ static int nfs_inode_finish_partial_attr_update(con=
st struct nfs_fattr *fattr,
>  		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
>  		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
>  		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
> -		NFS_INO_INVALID_NLINK;
> +		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
>  	unsigned long cache_validity =3D NFS_I(inode)->cache_validity;
>  	enum nfs4_change_attr_type ctype =3D NFS_SERVER(inode)->change_attr_typ=
e;
> =20
> @@ -2219,10 +2225,13 @@ static int nfs_update_inode(struct inode *inode, =
struct nfs_fattr *fattr)
>  	nfs_fattr_fixup_delegated(inode, fattr);
> =20
>  	save_cache_validity =3D nfsi->cache_validity;
> -	nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
> -			| NFS_INO_INVALID_ATIME
> -			| NFS_INO_REVAL_FORCED
> -			| NFS_INO_INVALID_BLOCKS);
> +	nfsi->cache_validity &=3D
> +		~(NFS_INO_INVALID_ATIME | NFS_INO_REVAL_FORCED |
> +		  NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
> +		  NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
> +		  NFS_INO_INVALID_OTHER | NFS_INO_INVALID_BLOCKS |
> +		  NFS_INO_INVALID_NLINK | NFS_INO_INVALID_MODE |
> +		  NFS_INO_INVALID_BTIME);
> =20

The delta above is a little curious. This patch is just adding
NFS_INO_INVALID_BTIME, but the patch above adds the clearing of several
other bits as well. Why does this logic change?

>  	/* Do atomic weak cache consistency updates */
>  	nfs_wcc_update_inode(inode, fattr);
> @@ -2261,7 +2270,8 @@ static int nfs_update_inode(struct inode *inode, st=
ruct nfs_fattr *fattr)
>  					| NFS_INO_INVALID_BLOCKS
>  					| NFS_INO_INVALID_NLINK
>  					| NFS_INO_INVALID_MODE
> -					| NFS_INO_INVALID_OTHER;
> +					| NFS_INO_INVALID_OTHER
> +					| NFS_INO_INVALID_BTIME;
>  				if (S_ISDIR(inode->i_mode))
>  					nfs_force_lookup_revalidate(inode);
>  				attr_changed =3D true;
> @@ -2295,6 +2305,12 @@ static int nfs_update_inode(struct inode *inode, s=
truct nfs_fattr *fattr)
>  		nfsi->cache_validity |=3D
>  			save_cache_validity & NFS_INO_INVALID_CTIME;
> =20
> +	if (fattr->valid & NFS_ATTR_FATTR_BTIME)
> +		nfsi->btime =3D fattr->btime;
> +	else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
> +		nfsi->cache_validity |=3D
> +			save_cache_validity & NFS_INO_INVALID_BTIME;
> +
>  	/* Check if our cached file size is stale */
>  	if (fattr->valid & NFS_ATTR_FATTR_SIZE) {
>  		new_isize =3D nfs_size_to_loff_t(fattr->size);
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index b1d2122bd5a7..f7fb61f805a3 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -222,6 +222,7 @@ const u32 nfs4_fattr_bitmap[3] =3D {
>  	| FATTR4_WORD1_RAWDEV
>  	| FATTR4_WORD1_SPACE_USED
>  	| FATTR4_WORD1_TIME_ACCESS
> +	| FATTR4_WORD1_TIME_CREATE
>  	| FATTR4_WORD1_TIME_METADATA
>  	| FATTR4_WORD1_TIME_MODIFY
>  	| FATTR4_WORD1_MOUNTED_ON_FILEID,
> @@ -243,6 +244,7 @@ static const u32 nfs4_pnfs_open_bitmap[3] =3D {
>  	| FATTR4_WORD1_RAWDEV
>  	| FATTR4_WORD1_SPACE_USED
>  	| FATTR4_WORD1_TIME_ACCESS
> +	| FATTR4_WORD1_TIME_CREATE
>  	| FATTR4_WORD1_TIME_METADATA
>  	| FATTR4_WORD1_TIME_MODIFY,
>  	FATTR4_WORD2_MDSTHRESHOLD
> @@ -323,6 +325,9 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const=
 __u32 *src,
>  	if (!(cache_validity & NFS_INO_INVALID_OTHER))
>  		dst[1] &=3D ~(FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP);
> =20
> +	if (!(cache_validity & NFS_INO_INVALID_BTIME))
> +		dst[1] &=3D ~FATTR4_WORD1_TIME_CREATE;
> +
>  	if (nfs_have_delegated_mtime(inode)) {
>  		if (!(cache_validity & NFS_INO_INVALID_ATIME))
>  			dst[1] &=3D ~FATTR4_WORD1_TIME_ACCESS;
> @@ -1307,7 +1312,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
>  				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
>  				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
>  				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
> -				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR;
> +				NFS_INO_INVALID_MODE | NFS_INO_INVALID_BTIME |
> +				NFS_INO_INVALID_XATTR;
>  		nfsi->attrtimeo =3D NFS_MINATTRTIMEO(inode);
>  	}
>  	nfsi->attrtimeo_timestamp =3D jiffies;
> @@ -4047,6 +4053,10 @@ static int _nfs4_server_capabilities(struct nfs_se=
rver *server, struct nfs_fh *f
>  			server->fattr_valid &=3D ~NFS_ATTR_FATTR_CTIME;
>  		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
>  			server->fattr_valid &=3D ~NFS_ATTR_FATTR_MTIME;
> +		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
> +			server->fattr_valid &=3D ~NFS_ATTR_FATTR_MTIME;
> +		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_CREATE))
> +			server->fattr_valid &=3D ~NFS_ATTR_FATTR_BTIME;
>  		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
>  				sizeof(server->attr_bitmask));
>  		server->attr_bitmask_nl[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> @@ -5773,6 +5783,8 @@ void nfs4_bitmask_set(__u32 bitmask[], const __u32 =
src[],
>  		bitmask[1] |=3D FATTR4_WORD1_TIME_MODIFY;
>  	if (cache_validity & NFS_INO_INVALID_BLOCKS)
>  		bitmask[1] |=3D FATTR4_WORD1_SPACE_USED;
> +	if (cache_validity & NFS_INO_INVALID_BTIME)
> +		bitmask[1] |=3D FATTR4_WORD1_TIME_CREATE;
> =20
>  	if (cache_validity & NFS_INO_INVALID_SIZE)
>  		bitmask[0] |=3D FATTR4_WORD0_SIZE;
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 55bef5fbfa47..f8d019c9d58d 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1623,6 +1623,7 @@ static void encode_readdir(struct xdr_stream *xdr, =
const struct nfs4_readdir_arg
>  			| FATTR4_WORD1_RAWDEV
>  			| FATTR4_WORD1_SPACE_USED
>  			| FATTR4_WORD1_TIME_ACCESS
> +			| FATTR4_WORD1_TIME_CREATE
>  			| FATTR4_WORD1_TIME_METADATA
>  			| FATTR4_WORD1_TIME_MODIFY;
>  		attrs[2] |=3D FATTR4_WORD2_SECURITY_LABEL;
> @@ -4207,6 +4208,24 @@ static int decode_attr_time_access(struct xdr_stre=
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
> @@ -4781,6 +4800,11 @@ static int decode_getfattr_attrs(struct xdr_stream=
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
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 7a058bd8c566..f49f064c5ee5 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -32,7 +32,8 @@
>  			{ NFS_INO_INVALID_BLOCKS, "INVALID_BLOCKS" }, \
>  			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" }, \
>  			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" }, \
> -			{ NFS_INO_INVALID_MODE, "INVALID_MODE" })
> +			{ NFS_INO_INVALID_MODE, "INVALID_MODE" }, \
> +			{ NFS_INO_INVALID_BTIME, "INVALID_BTIME" })
> =20
>  #define nfs_show_nfsi_flags(v) \
>  	__print_flags(v, "|", \
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 67ae2c3f41d2..5cc5f7f02887 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -160,6 +160,12 @@ struct nfs_inode {
>  	unsigned long		flags;			/* atomic bit ops */
>  	unsigned long		cache_validity;		/* bit mask */
> =20
> +	/*
> +	 * NFS Attributes not included in struct inode
> +	 */
> +
> +	struct timespec64	btime;
> +
>  	/*
>  	 * read_cache_jiffies is when we started read-caching this inode.
>  	 * attrtimeo is for how long the cached information is assumed
> @@ -316,6 +322,7 @@ struct nfs4_copy_state {
>  #define NFS_INO_INVALID_XATTR	BIT(15)		/* xattrs are invalid */
>  #define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
>  #define NFS_INO_INVALID_MODE	BIT(17)		/* cached mode is invalid */
> +#define NFS_INO_INVALID_BTIME	BIT(18)		/* cached btime is invalid */
> =20
>  #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
>  		| NFS_INO_INVALID_CTIME \
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 9cacbbd14787..ac4bff6e9913 100644
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
>  #define NFS_ATTR_FATTR_OWNER_NAME	BIT_ULL(23)
>  #define NFS_ATTR_FATTR_GROUP_NAME	BIT_ULL(24)
>  #define NFS_ATTR_FATTR_V4_SECURITY_LABEL BIT_ULL(25)
> +#define NFS_ATTR_FATTR_BTIME		BIT_ULL(26)
> =20
>  #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
>  		| NFS_ATTR_FATTR_MODE \
> @@ -126,6 +128,7 @@ struct nfs_fattr {
>  		| NFS_ATTR_FATTR_SPACE_USED)
>  #define NFS_ATTR_FATTR_V4 (NFS_ATTR_FATTR \
>  		| NFS_ATTR_FATTR_SPACE_USED \
> +		| NFS_ATTR_FATTR_BTIME \
>  		| NFS_ATTR_FATTR_V4_SECURITY_LABEL)
> =20
>  /*

--=20
Jeff Layton <jlayton@kernel.org>

