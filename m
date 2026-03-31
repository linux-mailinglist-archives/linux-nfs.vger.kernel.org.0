Return-Path: <linux-nfs+bounces-20552-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGuuJhALzGnGNgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20552-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 19:57:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A8936F887
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 19:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 683BA3098E90
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B3441022;
	Tue, 31 Mar 2026 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcK8l+a5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65630426EB4;
	Tue, 31 Mar 2026 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979533; cv=none; b=VtU/K7idzv2CfjmEmAdiz6cysggX4/oItAKxMhrwNZLpnZiNaq/7/hQ3Orme1/P1JcAb585MTpYdYvjqVL/VU1n444GnBJcTNN1Fgea0V2h/UMlSxz1ibGPDLoWuyymicTij10MuyvSu4hmYATTlqZe6EltxCCFTuyRfPF5fiwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979533; c=relaxed/simple;
	bh=XHS9GYl6jWMS8N92t7nfRJKFs8QPMUWOJq9AgTUJtvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ive4pb5fYsJQMqSwTCWslCfZWrFmlhrAhPOIR2/wx93AqnBf5SlnuJLLtljLNVsmfQHfPInaS/4YtdNV+Qfx/uRyGMyg9rRY0yGioiAtBWKiMCVRGz/F5EYduvoRI70Z6av/UzqwykmzGZ3Mgy2Bol52VZu4o0dNyZtVMQhKSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcK8l+a5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAB2C19423;
	Tue, 31 Mar 2026 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774979532;
	bh=XHS9GYl6jWMS8N92t7nfRJKFs8QPMUWOJq9AgTUJtvI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FcK8l+a5Badu77ALoGBbaQAYdXA1RlTqndy+I9V2BgyujEpgKgsKLfDkjqhvq8ysl
	 Ti3bqoc9uYSy7oMY/3MBYago8ImcpNX5BKJcay8pwWkfwpHTPcAaNSI45eyU3OlpNe
	 +KYCcJu3btjt6pLNXXL965Nz1XzsCWqnY2ELs7vgliPdTNne6wQ9UOndlDbHF+O4Z9
	 7VrhIsnYxQPDwGjVRt8POgZl4l441WxozW5C6kxefKTibfnItmvHXiFuf6JDQLy17D
	 qSVxjfpGzl3YZs2jN80M0dlN1AjuU+XG4DkqHG5JbGXoEpvmNnpoa2GNxgnpqKGIkk
	 9+xEyx9MyNPsw==
Message-ID: <73abf22dec079ed8eb3795ecdeaa851b704bdcb8.camel@kernel.org>
Subject: Re: [PATCH 4/4] exportfs,nfsd: rework checking for layout-based
 block device access support
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, 	linux-fsdevel@vger.kernel.org
Date: Tue, 31 Mar 2026 13:52:09 -0400
In-Reply-To: <20260331153406.4049290-5-hch@lst.de>
References: <20260331153406.4049290-1-hch@lst.de>
	 <20260331153406.4049290-5-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20552-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lst.de,oracle.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 34A8936F887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-31 at 17:33 +0200, Christoph Hellwig wrote:
> Currently NFSD hard codes checking support for block-style layouts.
> Lift the checks into a file system-helper and provide a exportfs-level
> helper to implement the typical checks.
>=20
> This prepares for supporting block layout export of multiple devices
> per file system.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfsd/export.c               |  3 +-
>  fs/nfsd/nfs4layouts.c          | 26 +++++------------
>  fs/xfs/xfs_pnfs.c              | 13 +++++++++
>  include/linux/exportfs_block.h | 52 +++++++++++++++++++++++++++++++++-
>  4 files changed, 73 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 8e8a76a44ff0..e20298f9212f 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -735,7 +735,8 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>  			goto out4;
>  		err =3D 0;
> =20
> -		nfsd4_setup_layout_type(&exp);
> +		if (exp.ex_flags & NFSEXP_PNFS)
> +			nfsd4_setup_layout_type(&exp);
>  	}
> =20
>  	expp =3D svc_export_lookup(&exp);
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index c53eb67969eb..7b849b637b5e 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (c) 2014 Christoph Hellwig.
>   */
> -#include <linux/blkdev.h>
>  #include <linux/exportfs_block.h>
>  #include <linux/kmod.h>
>  #include <linux/file.h>
> @@ -126,28 +125,17 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const=
 struct svc_fh *fhp,
> =20
>  void nfsd4_setup_layout_type(struct svc_export *exp)
>  {
> -#if defined(CONFIG_NFSD_BLOCKLAYOUT) || defined(CONFIG_NFSD_SCSILAYOUT)
>  	struct super_block *sb =3D exp->ex_path.mnt->mnt_sb;
> -	struct exportfs_block_ops *bops =3D sb->s_export_op->block_ops;
> -#endif
> -
> -	if (!(exp->ex_flags & NFSEXP_PNFS))
> -		return;
> +	expfs_block_layouts_t block_supported =3D exporfs_layouts_supported(sb)=
;
> =20
> -#ifdef CONFIG_NFSD_FLEXFILELAYOUT
> -	exp->ex_layout_types |=3D 1 << LAYOUT_FLEX_FILES;
> -#endif
> -#ifdef CONFIG_NFSD_BLOCKLAYOUT
> -	if (bops && bops->get_uuid && bops->map_blocks && bops->commit_blocks)
> +	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT))
> +		exp->ex_layout_types |=3D 1 << LAYOUT_FLEX_FILES;
> +	if (IS_ENABLED(CONFIG_NFSD_BLOCKLAYOUT) &&
> +	    (block_supported & EXPFS_BLOCK_IN_BAND_ID))
>  		exp->ex_layout_types |=3D 1 << LAYOUT_BLOCK_VOLUME;
> -#endif
> -#ifdef CONFIG_NFSD_SCSILAYOUT
> -	if (bops && bops->map_blocks && bops->commit_blocks &&
> -	    sb->s_bdev &&
> -	    sb->s_bdev->bd_disk->fops->pr_ops &&
> -	    sb->s_bdev->bd_disk->fops->get_unique_id)
> +	if (IS_ENABLED(CONFIG_NFSD_SCSILAYOUT) &&
> +	    (block_supported & EXPFS_BLOCK_OUT_OF_BAND_ID))
>  		exp->ex_layout_types |=3D 1 << LAYOUT_SCSI;
> -#endif
>  }
> =20
>  void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index fee782a3edbe..acefa0b99f53 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -13,6 +13,7 @@
>  #include "xfs_bmap.h"
>  #include "xfs_iomap.h"
>  #include "xfs_pnfs.h"
> +#include <linux/exportfs_block.h>
> =20
>  /*
>   * Ensure that we do not have any outstanding pNFS layouts that can be u=
sed by
> @@ -45,6 +46,17 @@ xfs_break_leased_layouts(
>  	return error;
>  }
> =20
> +static expfs_block_layouts_t
> +xfs_fs_layouts_supported(
> +	struct super_block	*sb)
> +{
> +	expfs_block_layouts_t	supported =3D EXPFS_BLOCK_IN_BAND_ID;
> +
> +	if (exportfs_bdev_supports_out_of_band_id(sb->s_bdev))
> +		supported |=3D EXPFS_BLOCK_OUT_OF_BAND_ID;
> +	return supported;
> +}
> +
>  /*
>   * Get a unique ID including its location so that the client can identif=
y
>   * the exported device.
> @@ -335,6 +347,7 @@ xfs_fs_commit_blocks(
>  }
> =20
>  struct exportfs_block_ops xfs_export_block_ops =3D {
> +	.layouts_supported	=3D xfs_fs_layouts_supported,
>  	.get_uuid		=3D xfs_fs_get_uuid,
>  	.map_blocks		=3D xfs_fs_map_blocks,
>  	.commit_blocks		=3D xfs_fs_commit_blocks,
> diff --git a/include/linux/exportfs_block.h b/include/linux/exportfs_bloc=
k.h
> index d1dec4689b14..8d5b0b0c5a82 100644
> --- a/include/linux/exportfs_block.h
> +++ b/include/linux/exportfs_block.h
> @@ -7,13 +7,35 @@
>  #ifndef LINUX_EXPORTFS_BLOCK_H
>  #define LINUX_EXPORTFS_BLOCK_H 1
> =20
> -#include <linux/types.h>
> +#include <linux/blkdev.h>
> +#include <linux/exportfs.h>
> +#include <linux/fs.h>
> =20
>  struct inode;
>  struct iomap;
>  struct super_block;
> =20
> +/*
> + * There are the two types of block-style layout support:
> + *  - In-band implies a device identified by a unique cookie inside the =
actual
> + *    device address space checked by the ->get_uuid method as used by t=
he pNFS
> + *    block layout.  This is a bit dangerous and deprecated.
> + *  - Out of band implies identification by out of band unique identifie=
rs
> + *    specified by the storage protocol, which is much safer and used by=
 the
> + *    pNFS SCSI/NVMe layouts.
> + */
> +typedef unsigned int __bitwise expfs_block_layouts_t;
> +#define EXPFS_BLOCK_FLAG(__bit) \
> +	((__force expfs_block_layouts_t)(1u << __bit))
> +#define EXPFS_BLOCK_IN_BAND_ID		EXPFS_BLOCK_FLAG(0)
> +#define EXPFS_BLOCK_OUT_OF_BAND_ID	EXPFS_BLOCK_FLAG(1)
> +
>  struct exportfs_block_ops {
> +	/*
> +	 * Returns the EXPFS_BLOCK_* bitmap of supported layout types.
> +	 */
> +	expfs_block_layouts_t (*layouts_supported)(struct super_block *sb);
> +
>  	/*
>  	 * Get the in-band device unique signature exposed to clients.
>  	 */
> @@ -35,4 +57,32 @@ struct exportfs_block_ops {
>  			int nr_iomaps, loff_t new_size);
>  };
> =20
> +static inline bool
> +exportfs_bdev_supports_out_of_band_id(struct block_device *bdev)
> +{
> +	return bdev->bd_disk->fops->pr_ops &&
> +		bdev->bd_disk->fops->get_unique_id;
> +}
> +
> +#ifdef CONFIG_EXPORTFS_BLOCK_OPS
> +static inline expfs_block_layouts_t
> +exporfs_layouts_supported(struct super_block *sb)
> +{
> +	struct exportfs_block_ops *bops =3D sb->s_export_op->block_ops;
> +
> +	if (!bops ||
> +	    !bops->layouts_supported ||
> +	    WARN_ON_ONCE(!bops->map_blocks) ||
> +	    WARN_ON_ONCE(!bops->commit_blocks))
> +		return 0;
> +	return bops->layouts_supported(sb);
> +}
> +#else
> +static inline expfs_block_layouts_t
> +exporfs_layouts_supported(struct super_block *sb)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_EXPORTFS_BLOCK_OPS */
> +
>  #endif /* LINUX_EXPORTFS_BLOCK_H */

Much cleaner.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

