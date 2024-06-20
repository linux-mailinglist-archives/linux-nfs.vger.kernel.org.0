Return-Path: <linux-nfs+bounces-4142-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A7D9106BD
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A042E281E68
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C6F1ACE8B;
	Thu, 20 Jun 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECegByhT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793EF1AD487
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891516; cv=none; b=kLWhQcoVrH+d3zwDlOAXgZS1VDZISAI8Kf16Iythjgfy0KT3UeSD91ANE6j1G/JVDalkSP5D/a/HwBkDHtDX6eto9ZfaK0o/ki/h6aM5jOZnLjK93t/JiaizwqSToYbjO/UoNsUuujoM7GpS7tl7OMVW05rwbblezXwgmwSjCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891516; c=relaxed/simple;
	bh=NNd5i+TzRgphVaWt/2iUUdV8LVjCU6JAKiSfaJl/OrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkuLFbkfzepar4U7KnHygqoqjRb+y6Wf4f/DhTL2tathQHj07IJdNK4MRrMCPCr/pcrHe5I/OR4T6lhpjL3T74vqFX90hamraum0k4sBoT/FzeD/z3KwGp8E+UiVQ9RvRd6dG71ZMhdB59ha0squ9RG+EnSA69Rnx2jD2KeUC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECegByhT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718891513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zz22CyE4W4LFsC25ggf/aBX/AMvvXiOOrWUMHcUqEzg=;
	b=ECegByhT8l5shjDhw0YrWYaX3vhABF1iT9YkDPhczhAIdyg2xQHNqKzvNZ4rb31eChyDSb
	Ij+rkL161/I8rmwojwDbCsx6UzgWak897B1p/GW/oV6vWvA3w2qpfEatOC/ZnzS9XCy6hC
	KxkHUA40RczETeYnyJ6xzsWsgky4Q2s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-VU76oiJVOr2_eiRwu6gqNg-1; Thu,
 20 Jun 2024 09:51:51 -0400
X-MC-Unique: VU76oiJVOr2_eiRwu6gqNg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A089195608E;
	Thu, 20 Jun 2024 13:51:50 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE57F19560AE;
	Thu, 20 Jun 2024 13:51:48 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Date: Thu, 20 Jun 2024 09:51:46 -0400
Message-ID: <D3359408-4D02-415A-9557-19A6EFE5DDCE@redhat.com>
In-Reply-To: <20240619173929.177818-9-cel@kernel.org>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 19 Jun 2024, at 13:39, cel@kernel.org wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> During generic/069 runs with pNFS SCSI layouts, the NFS client emits
> the following in the system journal:
>
> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x600=
1405e3366f045b7949eb8e4540b51 (-2)
> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b=
3)
> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x600=
1405e3366f045b7949eb8e4540b51 (-2)
> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b=
3)
> kernel: sd 6:0:0:1: reservation conflict
> kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=3DDID_OK drive=
rbyte=3DDRIVER_OK cmd_age=3D0s
> kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 00 00=
 08 00
> kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRITE) f=
lags 0x0 phys_seg 1 prio class 2
> kernel: sd 6:0:0:1: reservation conflict
> kernel: sd 6:0:0:1: reservation conflict
> kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=3DDID_OK drive=
rbyte=3DDRIVER_OK cmd_age=3D0s
> kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=3DDID_OK drive=
rbyte=3DDRIVER_OK cmd_age=3D0s
> kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 00 00=
 08 00
> kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 00 00=
 08 00
> kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRITE) f=
lags 0x0 phys_seg 1 prio class 0
> kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRITE) f=
lags 0x0 phys_seg 1 prio class 0
> systemd[1]: fstests-generic-069.scope: Deactivated successfully.
> systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
> systemd[1]: media-test.mount: Deactivated successfully.
> systemd[1]: media-scratch.mount: Deactivated successfully.
> kernel: sd 6:0:0:1: reservation conflict
> kernel: failed to unregister PR key.
>
> This appears to be due to a race. bl_alloc_lseg() calls this:
>
> 561 static struct nfs4_deviceid_node *
> 562 bl_find_get_deviceid(struct nfs_server *server,
> 563                 const struct nfs4_deviceid *id, const struct cred *=
cred,
> 564                 gfp_t gfp_mask)
> 565 {
> 566         struct nfs4_deviceid_node *node;
> 567         unsigned long start, end;
> 568
> 569 retry:
> 570         node =3D nfs4_find_get_deviceid(server, id, cred, gfp_mask)=
;
> 571         if (!node)
> 572                 return ERR_PTR(-ENODEV);
>
> nfs4_find_get_deviceid() does a lookup without the spin lock first.
> If it can't find a matching deviceid, it creates a new device_info
> (which calls bl_alloc_deviceid_node, and that registers the device's
> PR key).
>
> Then it takes the nfs4_deviceid_lock and looks up the deviceid again.
> If it finds it this time, bl_find_get_deviceid() frees the spare
> (new) device_info, which unregisters the PR key for the same device.
>
> Any subsequent I/O from this client on that device gets EBADE.
>
> The umount later unregisters the device's PR key again.
>
> To prevent this problem, register the PR key after the deviceid_node
> lookup.

Hi Chuck - nice catch, but I'm not seeing how we don't have the same prob=
lem
after this patch, instead it just seems like it moves the race.  What
prevents another process waiting to take the nfs4_deviceid_lock from
unregistering the same device?  I think we need another way to signal
bl_free_device that we don't want to unregister for the case where the ne=
w
device isn't added to nfs4_deviceid_cache.

No good ideas yet - maybe we can use a flag set within the
nfs4_deviceid_lock?

Ben

>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/blocklayout/blocklayout.c |  9 ++++++++-
>  fs/nfs/blocklayout/blocklayout.h |  1 +
>  fs/nfs/blocklayout/dev.c         | 29 +++++++++++++++++++++--------
>  3 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/bloc=
klayout.c
> index 6be13e0ec170..75cc5e50bd37 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -571,8 +571,14 @@ bl_find_get_deviceid(struct nfs_server *server,
>  	if (!node)
>  		return ERR_PTR(-ENODEV);
>
> -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) =3D=3D 0)
> +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) =3D=3D 0) {
> +		struct pnfs_block_dev *d =3D
> +			container_of(node, struct pnfs_block_dev, node);
> +		if (d->pr_reg)
> +			if (d->pr_reg(d) < 0)
> +				goto out_put;
>  		return node;
> +	}
>
>  	end =3D jiffies;
>  	start =3D end - PNFS_DEVICE_RETRY_TIMEOUT;
> @@ -581,6 +587,7 @@ bl_find_get_deviceid(struct nfs_server *server,
>  		goto retry;
>  	}
>
> +out_put:
>  	nfs4_put_deviceid_node(node);
>  	return ERR_PTR(-ENODEV);
>  }
> diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/bloc=
klayout.h
> index f1eeb4914199..8aabaf5218b8 100644
> --- a/fs/nfs/blocklayout/blocklayout.h
> +++ b/fs/nfs/blocklayout/blocklayout.h
> @@ -116,6 +116,7 @@ struct pnfs_block_dev {
>
>  	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
>  			struct pnfs_block_dev_map *map);
> +	int (*pr_reg)(struct pnfs_block_dev *dev);
>  };
>
>  /* sector_t fields are all in 512-byte sectors */
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index 356bc967fb5d..3d2401820ef4 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -230,6 +230,26 @@ static bool bl_map_stripe(struct pnfs_block_dev *d=
ev, u64 offset,
>  	return true;
>  }
>
> +static int bl_register_scsi(struct pnfs_block_dev *d)
> +{
> +	struct block_device *bdev =3D file_bdev(d->bdev_file);
> +	const struct pr_ops *ops =3D bdev->bd_disk->fops->pr_ops;
> +	int error;
> +
> +	if (d->pr_registered)
> +		return 0;
> +
> +	error =3D ops->pr_register(bdev, 0, d->pr_key, true);
> +	if (error) {
> +		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);=

> +		return -error;
> +	}
> +
> +	trace_bl_pr_key_reg(bdev->bd_disk->disk_name, d->pr_key);
> +	d->pr_registered =3D true;
> +	return 0;
> +}
> +
>  static int
>  bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,=

>  		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask);
> @@ -373,14 +393,7 @@ bl_parse_scsi(struct nfs_server *server, struct pn=
fs_block_dev *d,
>  		goto out_blkdev_put;
>  	}
>
> -	error =3D ops->pr_register(bdev, 0, d->pr_key, true);
> -	if (error) {
> -		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);=

> -		goto out_blkdev_put;
> -	}
> -	trace_bl_pr_key_reg(bdev->bd_disk->disk_name, d->pr_key);
> -
> -	d->pr_registered =3D true;
> +	d->pr_reg =3D bl_register_scsi;
>  	return 0;
>
>  out_blkdev_put:
> -- =

> 2.45.1


