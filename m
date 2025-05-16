Return-Path: <linux-nfs+bounces-11777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8575CAB9F7A
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB99DA27545
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812E26AF3;
	Fri, 16 May 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8U/UN32"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C54219ED
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407940; cv=none; b=nX2auy95FgIor8JkOo38nIUUY+vo7tUB7Vqd/72en9lxEibzr00dCCmdEy7pOqyDya9ynHJyzHs7QlS8FebAWqDVlUEISZC4P5PiH/EvPfyFp6W/9R/DbBzif9zCVXwe4Z9Dr+j73uNqKuc5K01jDe7ky6KtdnpFb92Gg/KVJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407940; c=relaxed/simple;
	bh=oXE/T4whAQ5L/UaLy3satDRzB+LuvBn85GOIWefkzY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qiZHcZYlxpHhZ6kDEaXdentX8ECTpMCKTmD5GaKswCNhme/WcibNho9Y7iLNNYYHSKbQn5dzRovZdRDitfQ/2EP5zPkW5YUzlv5LiV1pFNzxB4OB0rNVxO6cf8bhb0rxpqvHPcibO/8ZiNiMQB1ticaYP+c+XK1I6GD6WuAkX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8U/UN32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D157C4CEE4;
	Fri, 16 May 2025 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747407939;
	bh=oXE/T4whAQ5L/UaLy3satDRzB+LuvBn85GOIWefkzY0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N8U/UN32jOAwScEdjvj4eUCEuzaaGEijXeBqh9xROdmm2OfNKaX3uj7Nndz4G0D3c
	 HWyHCV0QcPKhV7ds4a5F6Fo3rHb6rsixwV+Tez8+20MR5JzyGNj7pWaAFeCM5g5Oe4
	 97oPP8DfE4CgFBwZbHbxrMsDzS6hWDgvI4LgiNpc4bqgreEuZEdB4yGrsgPVxaHnF5
	 /xry/YNioIPicKyIf/PwRqXxrOKyvUUOveQhA7XpzcnzNOfVIT8BpHDG4eD0hiKvIh
	 QvVP7bAaU/V6nx/+T5aLbw3ZEYOpYb34pDBbc22vYjkctf7U0U0CuZ5ByVug1oS00b
	 VB1QssEeRXXOQ==
Message-ID: <480b2ed5ded21d186f4b4e64a8aebc226d4c3468.camel@kernel.org>
Subject: Re: [PATCH v1 1/3] Expand the type of nfs_fattr->valid
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>, Trond Myklebust
	 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Lance Shelton <lance.shelton@hammerspace.com>
Date: Fri, 16 May 2025 11:05:38 -0400
In-Reply-To: <725abd9afbe268c50b99a1b2ded6c2339a5e79c0.1747318805.git.bcodding@redhat.com>
References: <cover.1747318805.git.bcodding@redhat.com>
	 <725abd9afbe268c50b99a1b2ded6c2339a5e79c0.1747318805.git.bcodding@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-15 at 10:40 -0400, Benjamin Coddington wrote:
> From: Trond Myklebust <trond.myklebust@primarydata.com>
>=20
> We need to be able to track more than 32 attributes per inode.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/inode.c            |  5 ++--
>  include/linux/nfs_fs_sb.h |  2 +-
>  include/linux/nfs_xdr.h   | 54 +++++++++++++++++++--------------------
>  3 files changed, 31 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 1aa67fca69b2..d4e449fa076e 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2164,10 +2164,11 @@ static int nfs_update_inode(struct inode *inode, =
struct nfs_fattr *fattr)
>  	bool attr_changed =3D false;
>  	bool have_delegation;
> =20
> -	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=3D0x%08x ct=3D%d info=3D0x%x)\n",
> +	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=3D0x%08x ct=3D%d info=3D0x%lx)\n",
>  			__func__, inode->i_sb->s_id, inode->i_ino,
>  			nfs_display_fhandle_hash(NFS_FH(inode)),
> -			atomic_read(&inode->i_count), fattr->valid);
> +			atomic_read(&inode->i_count),
> +			(unsigned long)fattr->valid);

Why the cast? You could just set the format to %llx and pass fattr-
>valid as-is?

> =20
>  	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
>  		/* Only a mounted-on-fileid? Just exit */
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index f00bfcee7120..056d0ad38756 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -168,8 +168,8 @@ struct nfs_server {
>  #define NFS_MOUNT_SHUTDOWN			0x08000000
>  #define NFS_MOUNT_NO_ALIGNWRITE		0x10000000
> =20
> -	unsigned int		fattr_valid;	/* Valid attributes */
>  	unsigned int		caps;		/* server capabilities */
> +	__u64			fattr_valid;	/* Valid attributes */
>  	unsigned int		rsize;		/* read size */
>  	unsigned int		rpages;		/* read size (in pages) */
>  	unsigned int		wsize;		/* write size */
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 9155a6ffc370..b7b06f0d2fb9 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -45,7 +45,7 @@ struct nfs4_threshold {
>  };
> =20
>  struct nfs_fattr {
> -	unsigned int		valid;		/* which fields are valid */
> +	__u64			valid;		/* which fields are valid */
>  	umode_t			mode;
>  	__u32			nlink;
>  	kuid_t			uid;
> @@ -80,32 +80,32 @@ struct nfs_fattr {
>  	struct nfs4_label	*label;
>  };
> =20
> -#define NFS_ATTR_FATTR_TYPE		(1U << 0)
> -#define NFS_ATTR_FATTR_MODE		(1U << 1)
> -#define NFS_ATTR_FATTR_NLINK		(1U << 2)
> -#define NFS_ATTR_FATTR_OWNER		(1U << 3)
> -#define NFS_ATTR_FATTR_GROUP		(1U << 4)
> -#define NFS_ATTR_FATTR_RDEV		(1U << 5)
> -#define NFS_ATTR_FATTR_SIZE		(1U << 6)
> -#define NFS_ATTR_FATTR_PRESIZE		(1U << 7)
> -#define NFS_ATTR_FATTR_BLOCKS_USED	(1U << 8)
> -#define NFS_ATTR_FATTR_SPACE_USED	(1U << 9)
> -#define NFS_ATTR_FATTR_FSID		(1U << 10)
> -#define NFS_ATTR_FATTR_FILEID		(1U << 11)
> -#define NFS_ATTR_FATTR_ATIME		(1U << 12)
> -#define NFS_ATTR_FATTR_MTIME		(1U << 13)
> -#define NFS_ATTR_FATTR_CTIME		(1U << 14)
> -#define NFS_ATTR_FATTR_PREMTIME		(1U << 15)
> -#define NFS_ATTR_FATTR_PRECTIME		(1U << 16)
> -#define NFS_ATTR_FATTR_CHANGE		(1U << 17)
> -#define NFS_ATTR_FATTR_PRECHANGE	(1U << 18)
> -#define NFS_ATTR_FATTR_V4_LOCATIONS	(1U << 19)
> -#define NFS_ATTR_FATTR_V4_REFERRAL	(1U << 20)
> -#define NFS_ATTR_FATTR_MOUNTPOINT	(1U << 21)
> -#define NFS_ATTR_FATTR_MOUNTED_ON_FILEID (1U << 22)
> -#define NFS_ATTR_FATTR_OWNER_NAME	(1U << 23)
> -#define NFS_ATTR_FATTR_GROUP_NAME	(1U << 24)
> -#define NFS_ATTR_FATTR_V4_SECURITY_LABEL (1U << 25)
> +#define NFS_ATTR_FATTR_TYPE		BIT_ULL(0)
> +#define NFS_ATTR_FATTR_MODE		BIT_ULL(1)
> +#define NFS_ATTR_FATTR_NLINK		BIT_ULL(2)
> +#define NFS_ATTR_FATTR_OWNER		BIT_ULL(3)
> +#define NFS_ATTR_FATTR_GROUP		BIT_ULL(4)
> +#define NFS_ATTR_FATTR_RDEV		BIT_ULL(5)
> +#define NFS_ATTR_FATTR_SIZE		BIT_ULL(6)
> +#define NFS_ATTR_FATTR_PRESIZE		BIT_ULL(7)
> +#define NFS_ATTR_FATTR_BLOCKS_USED	BIT_ULL(8)
> +#define NFS_ATTR_FATTR_SPACE_USED	BIT_ULL(9)
> +#define NFS_ATTR_FATTR_FSID		BIT_ULL(10)
> +#define NFS_ATTR_FATTR_FILEID		BIT_ULL(11)
> +#define NFS_ATTR_FATTR_ATIME		BIT_ULL(12)
> +#define NFS_ATTR_FATTR_MTIME		BIT_ULL(13)
> +#define NFS_ATTR_FATTR_CTIME		BIT_ULL(14)
> +#define NFS_ATTR_FATTR_PREMTIME		BIT_ULL(15)
> +#define NFS_ATTR_FATTR_PRECTIME		BIT_ULL(16)
> +#define NFS_ATTR_FATTR_CHANGE		BIT_ULL(17)
> +#define NFS_ATTR_FATTR_PRECHANGE	BIT_ULL(18)
> +#define NFS_ATTR_FATTR_V4_LOCATIONS	BIT_ULL(19)
> +#define NFS_ATTR_FATTR_V4_REFERRAL	BIT_ULL(20)
> +#define NFS_ATTR_FATTR_MOUNTPOINT	BIT_ULL(21)
> +#define NFS_ATTR_FATTR_MOUNTED_ON_FILEID BIT_ULL(22)
> +#define NFS_ATTR_FATTR_OWNER_NAME	BIT_ULL(23)
> +#define NFS_ATTR_FATTR_GROUP_NAME	BIT_ULL(24)
> +#define NFS_ATTR_FATTR_V4_SECURITY_LABEL BIT_ULL(25)
> =20
>  #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
>  		| NFS_ATTR_FATTR_MODE \

--=20
Jeff Layton <jlayton@kernel.org>

