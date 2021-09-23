Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E1D416755
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Sep 2021 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbhIWVWs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 17:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243232AbhIWVWs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 17:22:48 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20744C061574
        for <linux-nfs@vger.kernel.org>; Thu, 23 Sep 2021 14:21:16 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B7C98702D; Thu, 23 Sep 2021 17:21:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B7C98702D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632432074;
        bh=0BOtZ4kXClAFTSW0i9y801T7rp6BbJFqqAfV8Hc/D90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCCwSNTJL6lRoL42gLMqFaJx0ldZl7o5mHfWNtXZj1Ax7wXDr+r8SGXmtpWEVzQh0
         vQZarltc/V8zfWz59vU3U8lE6HH0bt1CZSI8c78F0I0uyP/iSjhqnN/Rp6VlgXKR5A
         +EluFUGC85MzdPK92fIpZH9/e/5tbPXg+R8Dg2i4=
Date:   Thu, 23 Sep 2021 17:21:14 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3 v3] NFSD: move filehandle format declarations out of
 "uapi".
Message-ID: <20210923212114.GG18334@fieldses.org>
References: <20210827151505.GA19199@lst.de>
 <163038488360.7591.7865010833762169362@noble.neil.brown.name>
 <20210901074407.GB18673@lst.de>
 <F517668C-DD79-4358-96AE-1566B956025A@oracle.com>
 <163054528774.24419.6639477440713170169@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163054528774.24419.6639477440713170169@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These 3 still apply after fixing up a couple minor conflicts; queued up
for 5.16.--b.

On Thu, Sep 02, 2021 at 11:14:47AM +1000, NeilBrown wrote:
> 
> A small part of the declaration concerning filehandle format are
> currently in the "uapi" include directory:
>    include/uapi/linux/nfsd/nfsfh.h
> 
> There is a lot more to the filehandle format, including "enum fid_type"
> and "enum nfsd_fsid" which are not exported via "uapi".
> 
> This small part of the filehandle definition is of minimal use outside
> of the kernel, and I can find no evidence that an other code is using
> it. Certainly nfs-utils and wireshark (The most likely candidates) do not
> use these declarations.
> 
> So move it out of "uapi" by copying the content from
>   include/uapi/linux/nfsd/nfsfh.h
> into
>   fs/nfsd/nfsfh.h
> 
> A few unnecessary "#include" directives are not copied, and neither is
> the #define of fh_auth, which is annotated as being for userspace only.
> 
> The copyright claims in the uapi file are identical to those in the nfsd
> file, so there is no need to copy those.
> 
> The "__u32" style integer types are only needed in "uapi".  In
> kernel-only code we can use the more familiar "u32" style.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsfh.h                 |  98 ++++++++++++++++++++++++++-
>  include/uapi/linux/nfsd/nfsfh.h | 116 --------------------------------
>  2 files changed, 97 insertions(+), 117 deletions(-)
>  delete mode 100644 include/uapi/linux/nfsd/nfsfh.h
> 
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 6106697adc04..988e4dfdfbd9 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -10,9 +10,105 @@
>  
>  #include <linux/crc32.h>
>  #include <linux/sunrpc/svc.h>
> -#include <uapi/linux/nfsd/nfsfh.h>
>  #include <linux/iversion.h>
>  #include <linux/exportfs.h>
> +#include <linux/nfs4.h>
> +
> +
> +/*
> + * This is the old "dentry style" Linux NFSv2 file handle.
> + *
> + * The xino and xdev fields are currently used to transport the
> + * ino/dev of the exported inode.
> + */
> +struct nfs_fhbase_old {
> +	u32		fb_dcookie;	/* dentry cookie - always 0xfeebbaca */
> +	u32		fb_ino;		/* our inode number */
> +	u32		fb_dirino;	/* dir inode number, 0 for directories */
> +	u32		fb_dev;		/* our device */
> +	u32		fb_xdev;
> +	u32		fb_xino;
> +	u32		fb_generation;
> +};
> +
> +/*
> + * This is the new flexible, extensible style NFSv2/v3/v4 file handle.
> + * by Neil Brown <neilb@cse.unsw.edu.au> - March 2000
> + *
> + * The file handle starts with a sequence of four-byte words.
> + * The first word contains a version number (1) and three descriptor bytes
> + * that tell how the remaining 3 variable length fields should be handled.
> + * These three bytes are auth_type, fsid_type and fileid_type.
> + *
> + * All four-byte values are in host-byte-order.
> + *
> + * The auth_type field is deprecated and must be set to 0.
> + *
> + * The fsid_type identifies how the filesystem (or export point) is
> + *    encoded.
> + *  Current values:
> + *     0  - 4 byte device id (ms-2-bytes major, ls-2-bytes minor), 4byte inode number
> + *        NOTE: we cannot use the kdev_t device id value, because kdev_t.h
> + *              says we mustn't.  We must break it up and reassemble.
> + *     1  - 4 byte user specified identifier
> + *     2  - 4 byte major, 4 byte minor, 4 byte inode number - DEPRECATED
> + *     3  - 4 byte device id, encoded for user-space, 4 byte inode number
> + *     4  - 4 byte inode number and 4 byte uuid
> + *     5  - 8 byte uuid
> + *     6  - 16 byte uuid
> + *     7  - 8 byte inode number and 16 byte uuid
> + *
> + * The fileid_type identified how the file within the filesystem is encoded.
> + *   The values for this field are filesystem specific, exccept that
> + *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
> + *   in include/linux/exportfs.h for currently registered values.
> + */
> +struct nfs_fhbase_new {
> +	union {
> +		struct {
> +			u8		fb_version_aux;	/* == 1, even => nfs_fhbase_old */
> +			u8		fb_auth_type_aux;
> +			u8		fb_fsid_type_aux;
> +			u8		fb_fileid_type_aux;
> +			u32		fb_auth[1];
> +		/*	u32		fb_fsid[0]; floating */
> +		/*	u32		fb_fileid[0]; floating */
> +		};
> +		struct {
> +			u8		fb_version;	/* == 1, even => nfs_fhbase_old */
> +			u8		fb_auth_type;
> +			u8		fb_fsid_type;
> +			u8		fb_fileid_type;
> +			u32		fb_auth_flex[]; /* flexible-array member */
> +		};
> +	};
> +};
> +
> +struct knfsd_fh {
> +	unsigned int	fh_size;	/* significant for NFSv3.
> +					 * Points to the current size while building
> +					 * a new file handle
> +					 */
> +	union {
> +		struct nfs_fhbase_old	fh_old;
> +		u32			fh_pad[NFS4_FHSIZE/4];
> +		struct nfs_fhbase_new	fh_new;
> +	} fh_base;
> +};
> +
> +#define ofh_dcookie		fh_base.fh_old.fb_dcookie
> +#define ofh_ino			fh_base.fh_old.fb_ino
> +#define ofh_dirino		fh_base.fh_old.fb_dirino
> +#define ofh_dev			fh_base.fh_old.fb_dev
> +#define ofh_xdev		fh_base.fh_old.fb_xdev
> +#define ofh_xino		fh_base.fh_old.fb_xino
> +#define ofh_generation		fh_base.fh_old.fb_generation
> +
> +#define	fh_version		fh_base.fh_new.fb_version
> +#define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
> +#define	fh_auth_type		fh_base.fh_new.fb_auth_type
> +#define	fh_fileid_type		fh_base.fh_new.fb_fileid_type
> +#define	fh_fsid			fh_base.fh_new.fb_auth_flex
>  
>  static inline __u32 ino_t_to_u32(ino_t ino)
>  {
> diff --git a/include/uapi/linux/nfsd/nfsfh.h b/include/uapi/linux/nfsd/nfsfh.h
> deleted file mode 100644
> index 427294dd56a1..000000000000
> --- a/include/uapi/linux/nfsd/nfsfh.h
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/*
> - * This file describes the layout of the file handles as passed
> - * over the wire.
> - *
> - * Copyright (C) 1995, 1996, 1997 Olaf Kirch <okir@monad.swb.de>
> - */
> -
> -#ifndef _UAPI_LINUX_NFSD_FH_H
> -#define _UAPI_LINUX_NFSD_FH_H
> -
> -#include <linux/types.h>
> -#include <linux/nfs.h>
> -#include <linux/nfs2.h>
> -#include <linux/nfs3.h>
> -#include <linux/nfs4.h>
> -
> -/*
> - * This is the old "dentry style" Linux NFSv2 file handle.
> - *
> - * The xino and xdev fields are currently used to transport the
> - * ino/dev of the exported inode.
> - */
> -struct nfs_fhbase_old {
> -	__u32		fb_dcookie;	/* dentry cookie - always 0xfeebbaca */
> -	__u32		fb_ino;		/* our inode number */
> -	__u32		fb_dirino;	/* dir inode number, 0 for directories */
> -	__u32		fb_dev;		/* our device */
> -	__u32		fb_xdev;
> -	__u32		fb_xino;
> -	__u32		fb_generation;
> -};
> -
> -/*
> - * This is the new flexible, extensible style NFSv2/v3/v4 file handle.
> - * by Neil Brown <neilb@cse.unsw.edu.au> - March 2000
> - *
> - * The file handle starts with a sequence of four-byte words.
> - * The first word contains a version number (1) and three descriptor bytes
> - * that tell how the remaining 3 variable length fields should be handled.
> - * These three bytes are auth_type, fsid_type and fileid_type.
> - *
> - * All four-byte values are in host-byte-order.
> - *
> - * The auth_type field is deprecated and must be set to 0.
> - *
> - * The fsid_type identifies how the filesystem (or export point) is
> - *    encoded.
> - *  Current values:
> - *     0  - 4 byte device id (ms-2-bytes major, ls-2-bytes minor), 4byte inode number
> - *        NOTE: we cannot use the kdev_t device id value, because kdev_t.h
> - *              says we mustn't.  We must break it up and reassemble.
> - *     1  - 4 byte user specified identifier
> - *     2  - 4 byte major, 4 byte minor, 4 byte inode number - DEPRECATED
> - *     3  - 4 byte device id, encoded for user-space, 4 byte inode number
> - *     4  - 4 byte inode number and 4 byte uuid
> - *     5  - 8 byte uuid
> - *     6  - 16 byte uuid
> - *     7  - 8 byte inode number and 16 byte uuid
> - *
> - * The fileid_type identified how the file within the filesystem is encoded.
> - *   The values for this field are filesystem specific, exccept that
> - *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
> - *   in include/linux/exportfs.h for currently registered values.
> - */
> -struct nfs_fhbase_new {
> -	union {
> -		struct {
> -			__u8		fb_version_aux;	/* == 1, even => nfs_fhbase_old */
> -			__u8		fb_auth_type_aux;
> -			__u8		fb_fsid_type_aux;
> -			__u8		fb_fileid_type_aux;
> -			__u32		fb_auth[1];
> -			/*	__u32		fb_fsid[0]; floating */
> -			/*	__u32		fb_fileid[0]; floating */
> -		};
> -		struct {
> -			__u8		fb_version;	/* == 1, even => nfs_fhbase_old */
> -			__u8		fb_auth_type;
> -			__u8		fb_fsid_type;
> -			__u8		fb_fileid_type;
> -			__u32		fb_auth_flex[]; /* flexible-array member */
> -		};
> -	};
> -};
> -
> -struct knfsd_fh {
> -	unsigned int	fh_size;	/* significant for NFSv3.
> -					 * Points to the current size while building
> -					 * a new file handle
> -					 */
> -	union {
> -		struct nfs_fhbase_old	fh_old;
> -		__u32			fh_pad[NFS4_FHSIZE/4];
> -		struct nfs_fhbase_new	fh_new;
> -	} fh_base;
> -};
> -
> -#define ofh_dcookie		fh_base.fh_old.fb_dcookie
> -#define ofh_ino			fh_base.fh_old.fb_ino
> -#define ofh_dirino		fh_base.fh_old.fb_dirino
> -#define ofh_dev			fh_base.fh_old.fb_dev
> -#define ofh_xdev		fh_base.fh_old.fb_xdev
> -#define ofh_xino		fh_base.fh_old.fb_xino
> -#define ofh_generation		fh_base.fh_old.fb_generation
> -
> -#define	fh_version		fh_base.fh_new.fb_version
> -#define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
> -#define	fh_auth_type		fh_base.fh_new.fb_auth_type
> -#define	fh_fileid_type		fh_base.fh_new.fb_fileid_type
> -#define	fh_fsid			fh_base.fh_new.fb_auth_flex
> -
> -/* Do not use, provided for userspace compatiblity. */
> -#define	fh_auth			fh_base.fh_new.fb_auth
> -
> -#endif /* _UAPI_LINUX_NFSD_FH_H */
> -- 
> 2.32.0
