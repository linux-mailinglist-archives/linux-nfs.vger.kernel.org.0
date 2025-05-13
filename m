Return-Path: <linux-nfs+bounces-11692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E31AB595B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 18:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD7519E55AE
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE31F94C;
	Tue, 13 May 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dgi54lfi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499FB14A8B
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152497; cv=none; b=kU23SACiJmvQLCdiwZh1w9csCZRnje3K08xM+vd5waS8D8PkT4O3n1Behdj+3B5aBe7Pth30qIJpq5tB1U6MacND+s/U0DeH0B3rMIxjOi71zAuTtRTcHKvbYpnIUBozxF7uRe04V08Pd28FqODmrqAj9YKfVRrF0idKXL0ysB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152497; c=relaxed/simple;
	bh=0IZV24wuUiEyAiObXLKPrxEexdC0T9FFENjrPL8yxcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXb+oWNNIa5s5FRK+Mx6iloIscwhsJXQuL3MGMavBwek3MEVRniIMOw6/Vt+MGRINL0WGsTibieYbTxh0i4uTC92aieffTk4Ue0dBG94sVd7iZQwoTrV/gQ/JwlWDAsr5Yh3RCLGrSpw/codjRKuldNV4Ti3Ic08spN4/z8wITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dgi54lfi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747152493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksLELIaREV5rP0KGgzXwEWOB2XAnlBeoS+e+Q/rao7g=;
	b=Dgi54lfiXyA6oR1FBvrrgwckoNOO5VWotw0Xatr0eYt7cn13ESbXsr5imYCftFEU3Fj5Gr
	8CCCPXieZJcK0zS77JgsJ2ILAM3jlSoCVOwHiI5AESmGrTgGxTCodGjyaa+VRHKToSwD46
	GiirGg8iQTlxApEmdKHgfHtuWgvH0mc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-27YGxQwtMxiPkuBLfKnThA-1; Tue,
 13 May 2025 12:08:07 -0400
X-MC-Unique: 27YGxQwtMxiPkuBLfKnThA-1
X-Mimecast-MFC-AGG-ID: 27YGxQwtMxiPkuBLfKnThA_1747152486
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 297D319560B8;
	Tue, 13 May 2025 16:08:06 +0000 (UTC)
Received: from [10.22.89.59] (unknown [10.22.89.59])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A06030001A1;
	Tue, 13 May 2025 16:08:04 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
Date: Tue, 13 May 2025 12:08:02 -0400
Message-ID: <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I'm interested in this work, Chen are you still interested in moving this=

forward?   I have another question below --

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


^^ is this redundant if we're going to do it anyway in nfs_fhget for I_NE=
W?

=2E. actually, I don't understand why were doing /any/ nfsi member
initialization here.. am I missing something?

Otherwise, this gets

Tested-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


