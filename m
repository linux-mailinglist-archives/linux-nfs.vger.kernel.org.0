Return-Path: <linux-nfs+bounces-11703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13FAB5D4E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 21:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50FA7AA7C0
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724512C0847;
	Tue, 13 May 2025 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg44Ek2M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E82C033A
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165351; cv=none; b=gZyBYYwVhwNBBqil0Mu/UseLZ4ZSdOhvYViK9azxzxV7T/VPormM7W0kfzyCMJu8LLmzyQjwYMJf1nSFEjySzcFYeKrcGFS9geK5EDn/vIy3L9m4UdIZ0ZDJknBg9jMrKd9Ytk8uuAigt6a0KXC2bfrSpBlLfyVtzYjIhGTDdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165351; c=relaxed/simple;
	bh=vtMxvHiH9Fe21AGvDqaC9E3XZQqX4x0DwoJib8MV49c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXtJUUUvQzFSYVjo5hrXQfedXcblI/VTPykKel/FD+0pNWVFmGzXdHthrRsZw0io0b/IgBfWT09aPHDco0S5/t0ia/YHpNdJOtzKPsJV19C5R+KLCYW/LsTwC01Hq1hqlGCrvjx5nFEcx5F/9LJ0mFUKHQQ1p0kbQsAXPnaQr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fg44Ek2M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747165348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EbMvapy3Der7prJPdxqVwSSvAyjp2TNzz54Vo1efxI=;
	b=fg44Ek2MwOfi4f8JUsaXTegUN7sbTzRMtYE8yH6I+IcHXBT9l0QRWeiqX9t9h/VfZ8l3GV
	2Im57YKrFFuGwVmRdDrKCxW8pmssqFaOkD4HC8XiPzUm8u1pw3nXSKm0rcooRyEpYg4PKg
	xsP0LfDpyx2683elIOob8jFt2TH+jCI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-YnI2SVotNCOThOU5X800-Q-1; Tue,
 13 May 2025 15:42:26 -0400
X-MC-Unique: YnI2SVotNCOThOU5X800-Q-1
X-Mimecast-MFC-AGG-ID: YnI2SVotNCOThOU5X800-Q_1747165345
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB9CE1955DE7;
	Tue, 13 May 2025 19:42:24 +0000 (UTC)
Received: from [10.22.88.54] (unknown [10.22.88.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCC8B19373DC;
	Tue, 13 May 2025 19:42:23 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
Date: Tue, 13 May 2025 15:42:21 -0400
Message-ID: <FF92BAC2-7BA7-4FD4-8D1E-1A296B9EA3AD@redhat.com>
In-Reply-To: <20230901083421.2139-1-chenhx.fnst@fujitsu.com>
References: <20230901083421.2139-1-chenhx.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 1 Sep 2023, at 4:34, Chen Hanxiao wrote:

> nfsd already support btime by commit e377a3e698.
>
> This patch enable nfs to report btime in nfs_getattr.
> If underlying filesystem supports "btime" timestamp,
> statx will report btime for STATX_BTIME.
>
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
>
> ---
> v1.1:
> 	minor fix
> v2:
> 	properly set cache validity
>
>  fs/nfs/inode.c          | 28 ++++++++++++++++++++++++----
>  fs/nfs/nfs4proc.c       |  3 +++
>  fs/nfs/nfs4xdr.c        | 23 +++++++++++++++++++++++
>  include/linux/nfs_fs.h  |  2 ++
>  include/linux/nfs_xdr.h |  5 ++++-
>  5 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 8172dd4135a1..cfdf68b07982 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -196,7 +196,8 @@ void nfs_set_cache_invalid(struct inode *inode, uns=
igned long flags)
>  		if (!(flags & NFS_INO_REVAL_FORCED))
>  			flags &=3D ~(NFS_INO_INVALID_MODE |
>  				   NFS_INO_INVALID_OTHER |
> -				   NFS_INO_INVALID_XATTR);
> +				   NFS_INO_INVALID_XATTR |
> +				   NFS_INO_INVALID_BTIME);
>  		flags &=3D ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
>  	}
>
> @@ -515,6 +516,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh=
, struct nfs_fattr *fattr)
>  		memset(&inode->i_atime, 0, sizeof(inode->i_atime));
>  		memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
>  		memset(&inode->i_ctime, 0, sizeof(inode->i_ctime));
> +		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>  		inode_set_iversion_raw(inode, 0);
>  		inode->i_size =3D 0;
>  		clear_nlink(inode);
> @@ -538,6 +540,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *f=
h, struct nfs_fattr *fattr)
>  			inode->i_ctime =3D fattr->ctime;
>  		else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
>  			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
> +		if (fattr->valid & NFS_ATTR_FATTR_BTIME)
> +			nfsi->btime =3D fattr->btime;
> +		else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
> +			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BTIME);
>  		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
>  			inode_set_iversion_raw(inode, fattr->change_attr);
>  		else
> @@ -835,6 +841,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const stru=
ct path *path,
>  {
>  	struct inode *inode =3D d_inode(path->dentry);
>  	struct nfs_server *server =3D NFS_SERVER(inode);
> +	struct nfs_inode *nfsi =3D NFS_I(inode);
>  	unsigned long cache_validity;
>  	int err =3D 0;
>  	bool force_sync =3D query_flags & AT_STATX_FORCE_SYNC;
> @@ -845,7 +852,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const stru=
ct path *path,
>
>  	request_mask &=3D STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |=

>  			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
> -			STATX_INO | STATX_SIZE | STATX_BLOCKS |
> +			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
>  			STATX_CHANGE_COOKIE;
>
>  	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
> @@ -920,6 +927,10 @@ int nfs_getattr(struct mnt_idmap *idmap, const str=
uct path *path,
>  		stat->attributes |=3D STATX_ATTR_CHANGE_MONOTONIC;
>  	if (S_ISDIR(inode->i_mode))
>  		stat->blksize =3D NFS_SERVER(inode)->dtsize;
> +	if (!(server->fattr_valid & NFS_ATTR_FATTR_BTIME))
> +		stat->result_mask &=3D ~STATX_BTIME;
> +	else
> +		stat->btime =3D nfsi->btime;
>  out:
>  	trace_nfs_getattr_exit(inode, err);
>  	return err;
> @@ -1803,7 +1814,7 @@ static int nfs_inode_finish_partial_attr_update(c=
onst struct nfs_fattr *fattr,
>  		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
>  		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
>  		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
> -		NFS_INO_INVALID_NLINK;
> +		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
>  	unsigned long cache_validity =3D NFS_I(inode)->cache_validity;
>  	enum nfs4_change_attr_type ctype =3D NFS_SERVER(inode)->change_attr_t=
ype;
>
> @@ -2122,7 +2133,8 @@ static int nfs_update_inode(struct inode *inode, =
struct nfs_fattr *fattr)
>  	nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
>  			| NFS_INO_INVALID_ATIME
>  			| NFS_INO_REVAL_FORCED
> -			| NFS_INO_INVALID_BLOCKS);
> +			| NFS_INO_INVALID_BLOCKS
> +			| NFS_INO_INVALID_BTIME);
>
>  	/* Do atomic weak cache consistency updates */
>  	nfs_wcc_update_inode(inode, fattr);
> @@ -2161,6 +2173,7 @@ static int nfs_update_inode(struct inode *inode, =
struct nfs_fattr *fattr)
>  					| NFS_INO_INVALID_BLOCKS
>  					| NFS_INO_INVALID_NLINK
>  					| NFS_INO_INVALID_MODE
> +					| NFS_INO_INVALID_BTIME
>  					| NFS_INO_INVALID_OTHER;
>  				if (S_ISDIR(inode->i_mode))
>  					nfs_force_lookup_revalidate(inode);
> @@ -2189,6 +2202,12 @@ static int nfs_update_inode(struct inode *inode,=
 struct nfs_fattr *fattr)
>  		nfsi->cache_validity |=3D
>  			save_cache_validity & NFS_INO_INVALID_MTIME;
>
> +	if (fattr->valid & NFS_ATTR_FATTR_BTIME) {
> +		nfsi->btime =3D fattr->btime;
> +	} else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
> +		nfsi->cache_validity |=3D
> +			save_cache_validity & NFS_INO_INVALID_BTIME;
> +
>  	if (fattr->valid & NFS_ATTR_FATTR_CTIME)
>  		inode->i_ctime =3D fattr->ctime;
>  	else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
> @@ -2332,6 +2351,7 @@ struct inode *nfs_alloc_inode(struct super_block =
*sb)
>  #endif /* CONFIG_NFS_V4 */
>  #ifdef CONFIG_NFS_V4_2
>  	nfsi->xattr_cache =3D NULL;
> +	memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>  #endif
>  	nfs_netfs_inode_init(nfsi);
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 832fa226b8f2..024a057a055c 100644
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
> @@ -3909,6 +3910,8 @@ static int _nfs4_server_capabilities(struct nfs_s=
erver *server, struct nfs_fh *f
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
> @@ -4171,6 +4171,24 @@ static int decode_attr_time_access(struct xdr_st=
ream *xdr, uint32_t *bitmap, str
>  	return status;
>  }
>
> +static int decode_attr_time_create(struct xdr_stream *xdr, uint32_t *b=
itmap, struct timespec64 *time)
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
>  static int decode_attr_time_metadata(struct xdr_stream *xdr, uint32_t =
*bitmap, struct timespec64 *time)
>  {
>  	int status =3D 0;
> @@ -4730,6 +4748,11 @@ static int decode_getfattr_attrs(struct xdr_stre=
am *xdr, uint32_t *bitmap,
>  		goto xdr_error;
>  	fattr->valid |=3D status;
>
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
>
>  	unsigned long		attr_gencount;


Just had another thought here, we probably don't want to bump the
attr_gencount down to the next cacheline, here's my pahole output with th=
is
patch:


    /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
    long unsigned int          flags;                /*   144     8 */
    long unsigned int          cache_validity;       /*   152     8 */
    long unsigned int          read_cache_jiffies;   /*   160     8 */
    long unsigned int          attrtimeo;            /*   168     8 */
    long unsigned int          attrtimeo_timestamp;  /*   176     8 */
    struct timespec64          btime;                /*   184    16 */
    /* --- cacheline 3 boundary (192 bytes) was 8 bytes ago --- */
    long unsigned int          attr_gencount;        /*   200     8 */
    struct rb_root             access_cache;         /*   208     8 */
    struct list_head           access_cache_entry_lru; /*   216    16 */
    struct list_head           access_cache_inode_lru; /*   232    16 */


Maybe a better place would be after the xattr_cache?

Ben


