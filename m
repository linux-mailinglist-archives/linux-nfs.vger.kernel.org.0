Return-Path: <linux-nfs+bounces-12374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B8AD765B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 17:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9631C188D232
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E529B22D;
	Thu, 12 Jun 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eh+QhCjQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1E29B766
	for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742112; cv=none; b=h1Y4Q7faViDIUrqp0rWsCNZkW7B3PSB6H9PFz1weIQ9Ac8hSRIyfmvdTQLl7R9cereR0LFYKstWhKnvT6IKSPGDFZy/fkuS9LmQCDSV7aGIsOTnHG5Jot38e1Gj2kZyFiz7OkKhVzrI2lV2JAK05skHSuD/yQTZw9IwM3uZulHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742112; c=relaxed/simple;
	bh=RRogf1aHOoyQl3FeHP5zxfE3RXNRa8Hl8TNR/Kv6/jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXLMTMoNzViIXZ6xpMxnPSICaWEmTxeiLZD+EjkIRLsLha7JdTM88rf1N5noCGALRqbdBcuiTpYrMRyPbeXIE6fSAX1BC4rBubP4chCGRaMPD0X2sutkP2ILjgOOYrjBaG4SKaaAkmwrXx5kFpbvkzMXpMsEYwglSQFdGqdunLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eh+QhCjQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749742108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K68kmoXYmN1U2XhajyNVfjsziFOx/Ezh1zRr8FsmUOI=;
	b=eh+QhCjQxDiyoRdJH03siV8TpwEtzHiSZLQUPbQ0SMU+5DUNX1UPROXSICplYlp0R8Oezx
	WUkz2CuEA7+eEP9GOD1vgvlgSU1MkpYRcRCO8X6rAS48NPsAnyZTTAnjBC0yCNAQygdsxO
	7B2CAwDOEvUP4MYgYIePYLu+O2JupoY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-IH31W6V3NG2948c1PzPlvQ-1; Thu,
 12 Jun 2025 11:28:25 -0400
X-MC-Unique: IH31W6V3NG2948c1PzPlvQ-1
X-Mimecast-MFC-AGG-ID: IH31W6V3NG2948c1PzPlvQ_1749742104
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDADB19560B2;
	Thu, 12 Jun 2025 15:28:23 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95B9A18002B0;
	Thu, 12 Jun 2025 15:28:22 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Lance Shelton <lance.shelton@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3 2/3] nfs: Add timecreate to nfs inode
Date: Thu, 12 Jun 2025 11:28:20 -0400
Message-ID: <6D9EC0BF-E2C0-4644-BC33-6696DA66AE69@redhat.com>
In-Reply-To: <1e3677b0655fa2bbaba0817b41d111d94a06e5ee.1748515333.git.bcodding@redhat.com>
References: <cover.1748515333.git.bcodding@redhat.com>
 <1e3677b0655fa2bbaba0817b41d111d94a06e5ee.1748515333.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 29 May 2025, at 6:45, Benjamin Coddington wrote:

> From: Anne Marie Merritt <annemarie.merritt@primarydata.com>
>
> Add tracking of the create time (a.k.a. btime) along with corresponding=

> bitfields, request, and decode xdr routines.
>
> Signed-off-by: Anne Marie Merritt <annemarie.merritt@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/inode.c          | 17 +++++++++++++++--
>  fs/nfs/nfs4proc.c       | 14 +++++++++++++-
>  fs/nfs/nfs4xdr.c        | 24 ++++++++++++++++++++++++
>  fs/nfs/nfstrace.h       |  3 ++-
>  include/linux/nfs_fs.h  |  8 ++++++++
>  include/linux/nfs_xdr.h |  3 +++
>  6 files changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 160f3478a835..2e36188a855b 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -197,6 +197,7 @@ void nfs_set_cache_invalid(struct inode *inode, uns=
igned long flags)
>  		if (!(flags & NFS_INO_REVAL_FORCED))
>  			flags &=3D ~(NFS_INO_INVALID_MODE |
>  				   NFS_INO_INVALID_OTHER |
> +				   NFS_INO_INVALID_BTIME |
>  				   NFS_INO_INVALID_XATTR);
>  		flags &=3D ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
>  	}
> @@ -522,6 +523,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh=
, struct nfs_fattr *fattr)
>  		inode_set_atime(inode, 0, 0);
>  		inode_set_mtime(inode, 0, 0);
>  		inode_set_ctime(inode, 0, 0);
> +		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>  		inode_set_iversion_raw(inode, 0);
>  		inode->i_size =3D 0;
>  		clear_nlink(inode);
> @@ -545,6 +547,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *f=
h, struct nfs_fattr *fattr)
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
> @@ -1900,7 +1906,7 @@ static int nfs_inode_finish_partial_attr_update(c=
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
> @@ -2261,7 +2267,8 @@ static int nfs_update_inode(struct inode *inode, =
struct nfs_fattr *fattr)
>  					| NFS_INO_INVALID_BLOCKS
>  					| NFS_INO_INVALID_NLINK
>  					| NFS_INO_INVALID_MODE
> -					| NFS_INO_INVALID_OTHER;
> +					| NFS_INO_INVALID_OTHER
> +					| NFS_INO_INVALID_BTIME;
>  				if (S_ISDIR(inode->i_mode))
>  					nfs_force_lookup_revalidate(inode);
>  				attr_changed =3D true;
> @@ -2295,6 +2302,12 @@ static int nfs_update_inode(struct inode *inode,=
 struct nfs_fattr *fattr)
>  		nfsi->cache_validity |=3D
>  			save_cache_validity & NFS_INO_INVALID_CTIME;
>
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
> @@ -323,6 +325,9 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, con=
st __u32 *src,
>  	if (!(cache_validity & NFS_INO_INVALID_OTHER))
>  		dst[1] &=3D ~(FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP);
>
> +	if (!(cache_validity & NFS_INO_INVALID_BTIME))
> +		dst[1] &=3D ~FATTR4_WORD1_TIME_CREATE;
> +
>  	if (nfs_have_delegated_mtime(inode)) {
>  		if (!(cache_validity & NFS_INO_INVALID_ATIME))
>  			dst[1] &=3D ~FATTR4_WORD1_TIME_ACCESS;
> @@ -1307,7 +1312,8 @@ nfs4_update_changeattr_locked(struct inode *inode=
,
>  				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
>  				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
>  				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
> -				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR;
> +				NFS_INO_INVALID_MODE | NFS_INO_INVALID_BTIME |
> +				NFS_INO_INVALID_XATTR;
>  		nfsi->attrtimeo =3D NFS_MINATTRTIMEO(inode);
>  	}
>  	nfsi->attrtimeo_timestamp =3D jiffies;
> @@ -4047,6 +4053,10 @@ static int _nfs4_server_capabilities(struct nfs_=
server *server, struct nfs_fh *f
>  			server->fattr_valid &=3D ~NFS_ATTR_FATTR_CTIME;
>  		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
>  			server->fattr_valid &=3D ~NFS_ATTR_FATTR_MTIME;
> +		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
> +			server->fattr_valid &=3D ~NFS_ATTR_FATTR_MTIME;

^^
I just noticed this duplicates the two lines right above -- not harmful, =
but
probably needs a cleanup..  let me know if I should repost or if this can=
 be
fixed up in a maintainers tree.

Ben


