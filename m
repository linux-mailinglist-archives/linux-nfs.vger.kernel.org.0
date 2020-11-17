Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29C2B5F13
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 13:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgKQM1G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Nov 2020 07:27:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgKQM1G (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Nov 2020 07:27:06 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AEF522203;
        Tue, 17 Nov 2020 12:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605616025;
        bh=KNzpZq0D/HkUbbQWGlvhsy0dcuMw1SXpoL/sQ9QzeGI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=etaxxVvSlESFEeQrG4DcFK0+FF+MF+UoeIOS/Z43lJIpw9yaro1kE+GL0Gv4LsC0l
         BEFHzOfnAUFRmzwzFIS8/F1lFIVm2IQ4rlJSLa3I/huLztUMvbqqsICngESpsFXoa8
         /T660SovGopn8HwouCpnxl3OurJhRQHqTBrKE4M4=
Message-ID: <4be708fffc15a27560c378af20314212e8594f85.camel@kernel.org>
Subject: Re: [PATCH 3/4] nfs: don't mangle i_version on NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Date:   Tue, 17 Nov 2020 07:27:03 -0500
In-Reply-To: <1605583086-19869-3-git-send-email-bfields@redhat.com>
References: <20201117031601.GB10526@fieldses.org>
         <1605583086-19869-1-git-send-email-bfields@redhat.com>
         <1605583086-19869-3-git-send-email-bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-11-16 at 22:18 -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> The i_version on NFS has pretty much opaque to the client, so we don't
> want to give the low bit any special interpretation.
> 
> Define a new FS_PRIVATE_I_VERSION flag for filesystems that manage the
> i_version on their own.
> 

Description here doesn't quite match the patch...

> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfs/export.c          | 1 +
>  include/linux/exportfs.h | 1 +
>  include/linux/iversion.h | 4 ++++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 3430d6891e89..c2eb915a54ca 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -171,4 +171,5 @@ const struct export_operations nfs_export_ops = {
>  	.encode_fh = nfs_encode_fh,
>  	.fh_to_dentry = nfs_fh_to_dentry,
>  	.get_parent = nfs_get_parent,
> +	.fetch_iversion = inode_peek_iversion_raw,
>  };
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 3ceb72b67a7a..6000121a201f 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -213,6 +213,7 @@ struct export_operations {
>  			  bool write, u32 *device_generation);
>  	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
>  			     int nr_iomaps, struct iattr *iattr);
> +	u64 (*fetch_iversion)(const struct inode *);
>  };
>  
> 
> 
> 
> 
> 
> 
> 
>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index 2917ef990d43..481b3debf6bb 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_IVERSION_H
>  
> 
> 
> 
> 
> 
> 
> 
>  #include <linux/fs.h>
> +#include <linux/exportfs.h>
>  
> 
> 
> 
> 
> 
> 
> 
>  /*
>   * The inode->i_version field:
> @@ -306,6 +307,9 @@ inode_query_iversion(struct inode *inode)
>  {
>  	u64 cur, old, new;
>  
> 
> 
> 
> 
> 
> 
> 
> +	if (inode->i_sb->s_export_op->fetch_iversion)
> +		return inode->i_sb->s_export_op->fetch_iversion(inode);
> +

This looks dangerous -- s_export_op could be a NULL pointer.

>  	cur = inode_peek_iversion_raw(inode);
>  	for (;;) {
>  		/* If flag is already set, then no need to swap */

-- 
Jeff Layton <jlayton@kernel.org>

