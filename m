Return-Path: <linux-nfs+bounces-20547-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJD1JHYKzGn+NQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20547-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 19:55:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E319B36F7B5
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 19:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14C3F30BC425
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C8C345CDD;
	Tue, 31 Mar 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqK0Df0/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653E316195;
	Tue, 31 Mar 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977867; cv=none; b=EnL87xDxlLoMVzvY1QZZn61sMkXEezARmlngCPuIJUqA2nt2X2Y7/HHlaVle1AMLaurcVjZzfJkmlCOX1wQzyl6EqB1zw52XS1OIALDxfpwVsPkolq9+RyVZGvUFCzi9wFKJw6Sa78Ozqbb13jftUPTdhgKWlY+q1+j/lXPezuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977867; c=relaxed/simple;
	bh=od98BF/BWv7PmWPX2b2wStsnZy5eTLqe1oQ9E2UQnb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HRONTgy89iGODdYJ8dAXtAfNuSMex5Ir9bvlr7lMvvVBj/Gj28YPUgSKXgNXysgN4R1YoLNGe0nfriJbUqyWKSuH9otiU08uowFozdHDfibiHPvTQWJAZIWKhMLMrP7c0LQElyn1kt5iuKzzrpaCI4Vy6IZ7SGhyko5dQl+zNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqK0Df0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B167EC19424;
	Tue, 31 Mar 2026 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774977866;
	bh=od98BF/BWv7PmWPX2b2wStsnZy5eTLqe1oQ9E2UQnb4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KqK0Df0/rajdsjIohnjL1ksp4JfvZmNODUz9Y2h3sFNgrRsWmIk/fczw+8UY8Jpoq
	 fHxmWfSCu96cQ6jOHaChlzKpif7J455iAxIGnko4oZPzHPZiCDhXqseSTig1FQavwk
	 Ng8hF+neVHvyC7cl5cXqoia7xrAbmAb6msVgA3eLi9xHLtWIIjeKaQP74aVfvWesmo
	 LuKzwBSUYfBzjv4t9Nn61KJSk3ntQXP3k4D4QJNV7Kyog7esF43xMnKVfc0Y1GDiV5
	 388GsJ8r81kXn+frquxNW5r7kScwm2/PWNILJk6pq+IOy32FT/54G4MmNdoP3Oym7r
	 fyVM3//leGKLA==
Message-ID: <a916e82550e128c22c0e559b16f68b8cd56c8b05.camel@kernel.org>
Subject: Re: [PATCH 2/4] exportfs: split out the ops for layout-based block
 device access
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, 	linux-fsdevel@vger.kernel.org
Date: Tue, 31 Mar 2026 13:24:23 -0400
In-Reply-To: <20260331153406.4049290-3-hch@lst.de>
References: <20260331153406.4049290-1-hch@lst.de>
	 <20260331153406.4049290-3-hch@lst.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20547-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lst.de,oracle.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E319B36F7B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-31 at 17:33 +0200, Christoph Hellwig wrote:
> The support to grant layouts for direct block device access works
> at a very different layer than the rest of exports.  Split the methods
> for it into a separate struct, and move that into a separate header
> to better split things out.  The pointer to the new operation vector
> is kept in export_operations to avoid bloating the super_block.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  MAINTAINERS                    |  2 +-
>  fs/nfsd/blocklayout.c          | 14 ++++++------
>  fs/nfsd/nfs4layouts.c          |  9 ++++----
>  fs/xfs/xfs_export.c            |  4 +---
>  fs/xfs/xfs_pnfs.c              | 12 ++++++++---
>  fs/xfs/xfs_pnfs.h              | 11 +++++-----
>  include/linux/exportfs.h       | 25 +++++++---------------
>  include/linux/exportfs_block.h | 39 ++++++++++++++++++++++++++++++++++
>  8 files changed, 74 insertions(+), 42 deletions(-)
>  create mode 100644 include/linux/exportfs_block.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3fe46d7c4bc..b531b87a007e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9856,7 +9856,7 @@ S:	Supported
>  F:	Documentation/filesystems/nfs/exporting.rst
>  F:	fs/exportfs/
>  F:	fs/fhandle.c
> -F:	include/linux/exportfs.h
> +F:	include/linux/exportfs*.h
> =20
>  FILESYSTEMS [IDMAPPED MOUNTS]
>  M:	Christian Brauner <brauner@kernel.org>
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 5ee5735b39bb..3cc3b47361e2 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (c) 2014-2016 Christoph Hellwig.
>   */
> -#include <linux/exportfs.h>
> +#include <linux/exportfs_block.h>
>  #include <linux/iomap.h>
>  #include <linux/slab.h>
>  #include <linux/pr.h>
> @@ -32,8 +32,8 @@ nfsd4_block_map_extent(struct inode *inode, const struc=
t svc_fh *fhp,
>  	u32 device_generation =3D 0;
>  	int error;
> =20
> -	error =3D sb->s_export_op->map_blocks(inode, offset, length, &iomap,
> -			iomode !=3D IOMODE_READ, &device_generation);
> +	error =3D sb->s_export_op->block_ops->map_blocks(inode, offset, length,
> +			&iomap, iomode !=3D IOMODE_READ, &device_generation);
>  	if (error) {
>  		if (error =3D=3D -ENXIO)
>  			return nfserr_layoutunavailable;
> @@ -199,8 +199,8 @@ nfsd4_block_commit_blocks(struct inode *inode, struct=
 nfsd4_layoutcommit *lcp,
>  		iattr.ia_size =3D lcp->lc_newsize;
>  	}
> =20
> -	error =3D inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
> -			nr_iomaps, &iattr);
> +	error =3D inode->i_sb->s_export_op->block_ops->commit_blocks(inode,
> +			iomaps, nr_iomaps, &iattr);
>  	kfree(iomaps);
>  	return nfserrno(error);
>  }
> @@ -223,8 +223,8 @@ nfsd4_block_get_device_info_simple(struct super_block=
 *sb,
> =20
>  	b->type =3D PNFS_BLOCK_VOLUME_SIMPLE;
>  	b->simple.sig_len =3D PNFS_BLOCK_UUID_LEN;
> -	return sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_len,
> -			&b->simple.offset);
> +	return sb->s_export_op->block_ops->get_uuid(sb, b->simple.sig,
> +			&b->simple.sig_len, &b->simple.offset);
>  }
> =20
>  static __be32
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index ad7af8cfcf1f..c53eb67969eb 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2014 Christoph Hellwig.
>   */
>  #include <linux/blkdev.h>
> +#include <linux/exportfs_block.h>
>  #include <linux/kmod.h>
>  #include <linux/file.h>
>  #include <linux/jhash.h>
> @@ -127,6 +128,7 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
>  {
>  #if defined(CONFIG_NFSD_BLOCKLAYOUT) || defined(CONFIG_NFSD_SCSILAYOUT)
>  	struct super_block *sb =3D exp->ex_path.mnt->mnt_sb;
> +	struct exportfs_block_ops *bops =3D sb->s_export_op->block_ops;
>  #endif
> =20
>  	if (!(exp->ex_flags & NFSEXP_PNFS))
> @@ -136,14 +138,11 @@ void nfsd4_setup_layout_type(struct svc_export *exp=
)
>  	exp->ex_layout_types |=3D 1 << LAYOUT_FLEX_FILES;
>  #endif
>  #ifdef CONFIG_NFSD_BLOCKLAYOUT
> -	if (sb->s_export_op->get_uuid &&
> -	    sb->s_export_op->map_blocks &&
> -	    sb->s_export_op->commit_blocks)
> +	if (bops && bops->get_uuid && bops->map_blocks && bops->commit_blocks)
>  		exp->ex_layout_types |=3D 1 << LAYOUT_BLOCK_VOLUME;
>  #endif
>  #ifdef CONFIG_NFSD_SCSILAYOUT
> -	if (sb->s_export_op->map_blocks &&
> -	    sb->s_export_op->commit_blocks &&
> +	if (bops && bops->map_blocks && bops->commit_blocks &&
>  	    sb->s_bdev &&
>  	    sb->s_bdev->bd_disk->fops->pr_ops &&
>  	    sb->s_bdev->bd_disk->fops->get_unique_id)
> diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
> index e3e3c3c89840..9b2ad3786b19 100644
> --- a/fs/xfs/xfs_export.c
> +++ b/fs/xfs/xfs_export.c
> @@ -244,8 +244,6 @@ const struct export_operations xfs_export_operations =
=3D {
>  	.get_parent		=3D xfs_fs_get_parent,
>  	.commit_metadata	=3D xfs_fs_nfs_commit_metadata,
>  #ifdef CONFIG_EXPORTFS_BLOCK_OPS
> -	.get_uuid		=3D xfs_fs_get_uuid,
> -	.map_blocks		=3D xfs_fs_map_blocks,
> -	.commit_blocks		=3D xfs_fs_commit_blocks,
> +	.block_ops		=3D &xfs_export_block_ops,
>  #endif
>  };
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index 221e55887a2a..a52978f6fb76 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -49,7 +49,7 @@ xfs_break_leased_layouts(
>   * Get a unique ID including its location so that the client can identif=
y
>   * the exported device.
>   */
> -int
> +static int
>  xfs_fs_get_uuid(
>  	struct super_block	*sb,
>  	u8			*buf,
> @@ -104,7 +104,7 @@ xfs_fs_map_update_inode(
>  /*
>   * Get a layout for the pNFS client.
>   */
> -int
> +static int
>  xfs_fs_map_blocks(
>  	struct inode		*inode,
>  	loff_t			offset,
> @@ -252,7 +252,7 @@ xfs_pnfs_validate_isize(
>   * to manually flush the cache here similar to what the fsync code path =
does
>   * for datasyncs on files that have no dirty metadata.
>   */
> -int
> +static int
>  xfs_fs_commit_blocks(
>  	struct inode		*inode,
>  	struct iomap		*maps,
> @@ -332,3 +332,9 @@ xfs_fs_commit_blocks(
>  	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
>  	return error;
>  }
> +
> +struct exportfs_block_ops xfs_export_block_ops =3D {
> +	.get_uuid		=3D xfs_fs_get_uuid,
> +	.map_blocks		=3D xfs_fs_map_blocks,
> +	.commit_blocks		=3D xfs_fs_commit_blocks,
> +};
> diff --git a/fs/xfs/xfs_pnfs.h b/fs/xfs/xfs_pnfs.h
> index 940c6c2ad88c..9c289e98f2a6 100644
> --- a/fs/xfs/xfs_pnfs.h
> +++ b/fs/xfs/xfs_pnfs.h
> @@ -2,13 +2,9 @@
>  #ifndef _XFS_PNFS_H
>  #define _XFS_PNFS_H 1
> =20
> -#ifdef CONFIG_EXPORTFS_BLOCK_OPS
> -int xfs_fs_get_uuid(struct super_block *sb, u8 *buf, u32 *len, u64 *offs=
et);
> -int xfs_fs_map_blocks(struct inode *inode, loff_t offset, u64 length,
> -		struct iomap *iomap, bool write, u32 *device_generation);
> -int xfs_fs_commit_blocks(struct inode *inode, struct iomap *maps, int nr=
_maps,
> -		struct iattr *iattr);
> +#include <linux/exportfs_block.h>
> =20
> +#ifdef CONFIG_EXPORTFS_BLOCK_OPS
>  int xfs_break_leased_layouts(struct inode *inode, uint *iolock,
>  		bool *did_unlock);
>  #else
> @@ -18,4 +14,7 @@ xfs_break_leased_layouts(struct inode *inode, uint *iol=
ock, bool *did_unlock)
>  	return 0;
>  }
>  #endif /* CONFIG_EXPORTFS_BLOCK_OPS */
> +
> +extern struct exportfs_block_ops xfs_export_block_ops;
> +
>  #endif /* _XFS_PNFS_H */
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 8bcdba28b406..f07ce833fba3 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -6,9 +6,8 @@
>  #include <linux/path.h>
> =20
>  struct dentry;
> -struct iattr;
> +struct exportfs_block_ops;
>  struct inode;
> -struct iomap;
>  struct super_block;
>  struct vfsmount;
> =20
> @@ -260,19 +259,13 @@ struct handle_to_path_ctx {
>   * @commit_metadata:
>   *    @commit_metadata should commit metadata changes to stable storage.
>   *
> - * @get_uuid:
> - *    Get a filesystem unique signature exposed to clients.
> - *
> - * @map_blocks:
> - *    Map and, if necessary, allocate blocks for a layout.
> - *
> - * @commit_blocks:
> - *    Commit blocks in a layout once the client is done with them.
> - *
>   * @flags:
>   *    Allows the filesystem to communicate to nfsd that it may want to d=
o things
>   *    differently when dealing with it.
>   *
> + * @block_ops:
> + *    Operations for layout grants to block on the underlying device.
> + *
>   * Locking rules:
>   *    get_parent is called with child->d_inode->i_rwsem down
>   *    get_name is not (which is possibly inconsistent)
> @@ -290,12 +283,6 @@ struct export_operations {
>  	struct dentry * (*get_parent)(struct dentry *child);
>  	int (*commit_metadata)(struct inode *inode);
> =20
> -	int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset)=
;
> -	int (*map_blocks)(struct inode *inode, loff_t offset,
> -			  u64 len, struct iomap *iomap,
> -			  bool write, u32 *device_generation);
> -	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
> -			     int nr_iomaps, struct iattr *iattr);
>  	int (*permission)(struct handle_to_path_ctx *ctx, unsigned int oflags);
>  	struct file * (*open)(const struct path *path, unsigned int oflags);
>  #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
> @@ -308,6 +295,10 @@ struct export_operations {
>  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close=
 */
>  #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
>  	unsigned long	flags;
> +
> +#ifdef CONFIG_EXPORTFS_BLOCK_OPS
> +	struct exportfs_block_ops *block_ops;
> +#endif
>  };
> =20
>  /**
> diff --git a/include/linux/exportfs_block.h b/include/linux/exportfs_bloc=
k.h
> new file mode 100644
> index 000000000000..1f52fea8e4dc
> --- /dev/null
> +++ b/include/linux/exportfs_block.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2014-2026 Christoph Hellwig.
> + *
> + * Support for exportfs-based layout grants for direct block device acce=
ss.
> + */
> +#ifndef LINUX_EXPORTFS_BLOCK_H
> +#define LINUX_EXPORTFS_BLOCK_H 1
> +
> +#include <linux/types.h>
> +
> +struct iattr;
> +struct inode;
> +struct iomap;
> +struct super_block;
> +
> +struct exportfs_block_ops {
> +	/*
> +	 * Get the in-band device unique signature exposed to clients.
> +	 */
> +	int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset)=
;
> +
> +	/*
> +	 * Map blocks for direct block access.
> +	 * If @write is %true, also allocate the blocks for the range if needed=
.
> +	 */
> +	int (*map_blocks)(struct inode *inode, loff_t offset, u64 len,
> +			struct iomap *iomap, bool write,
> +			u32 *device_generation);
> +
> +	/*
> +	 * Commit blocks previously handed out by ->map_blocks and written to b=
y
> +	 * the client.
> +	 */
> +	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
> +			int nr_iomaps, struct iattr *iattr);
> +};
> +
> +#endif /* LINUX_EXPORTFS_BLOCK_H */

Meh, ok. Almost doesn't seem worthwhile, but I guess the result is a
bit cleaner layering-wise.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

