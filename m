Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD41E581A36
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 21:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiGZTVd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 15:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGZTVb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 15:21:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE49237F5
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 12:21:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE45A68AA6; Tue, 26 Jul 2022 21:21:27 +0200 (CEST)
Date:   Tue, 26 Jul 2022 21:21:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs/blocklayout: refactor block device opening
Message-ID: <20220726192127.GA20701@lst.de>
References: <20220622135822.3564952-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622135822.3564952-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ping?

On Wed, Jun 22, 2022 at 03:58:22PM +0200, Christoph Hellwig wrote:
> Deduplicate the helpers to open a device node by passing a name
> prefix argument and using the same helper for both kinds of paths.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfs/blocklayout/dev.c | 42 +++++++++++-----------------------------
>  1 file changed, 11 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index 5e56da748b2ab..fea5f8821da5e 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -301,18 +301,14 @@ bl_validate_designator(struct pnfs_block_volume *v)
>  	}
>  }
>  
> -/*
> - * Try to open the udev path for the WWN.  At least on Debian the udev
> - * by-id path will always point to the dm-multipath device if one exists.
> - */
>  static struct block_device *
> -bl_open_udev_path(struct pnfs_block_volume *v)
> +bl_open_path(struct pnfs_block_volume *v, const char *prefix)
>  {
>  	struct block_device *bdev;
>  	const char *devname;
>  
> -	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/wwn-0x%*phN",
> -				v->scsi.designator_len, v->scsi.designator);
> +	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/%s%*phN",
> +			prefix, v->scsi.designator_len, v->scsi.designator);
>  	if (!devname)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -326,28 +322,6 @@ bl_open_udev_path(struct pnfs_block_volume *v)
>  	return bdev;
>  }
>  
> -/*
> - * Try to open the RH/Fedora specific dm-mpath udev path for this WWN, as the
> - * wwn- links will only point to the first discovered SCSI device there.
> - */
> -static struct block_device *
> -bl_open_dm_mpath_udev_path(struct pnfs_block_volume *v)
> -{
> -	struct block_device *bdev;
> -	const char *devname;
> -
> -	devname = kasprintf(GFP_KERNEL,
> -			"/dev/disk/by-id/dm-uuid-mpath-%d%*phN",
> -			v->scsi.designator_type,
> -			v->scsi.designator_len, v->scsi.designator);
> -	if (!devname)
> -		return ERR_PTR(-ENOMEM);
> -
> -	bdev = blkdev_get_by_path(devname, FMODE_READ | FMODE_WRITE, NULL);
> -	kfree(devname);
> -	return bdev;
> -}
> -
>  static int
>  bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
>  		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
> @@ -360,9 +334,15 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
>  	if (!bl_validate_designator(v))
>  		return -EINVAL;
>  
> -	bdev = bl_open_dm_mpath_udev_path(v);
> +	/*
> +	 * Try to open the RH/Fedora specific dm-mpath udev path first, as the
> +	 * wwn- links will only point to the first discovered SCSI device there.
> +	 * On other distributions like Debian, the default SCSI by-id path will
> +	 * point to the dm-multipath device if one exists.
> +	 */
> +	bdev = bl_open_path(v, "dm-uuid-mpath-0x");
>  	if (IS_ERR(bdev))
> -		bdev = bl_open_udev_path(v);
> +		bdev = bl_open_path(v, "wwn-0x");
>  	if (IS_ERR(bdev))
>  		return PTR_ERR(bdev);
>  	d->bdev = bdev;
> -- 
> 2.30.2
---end quoted text---
