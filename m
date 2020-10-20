Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95929294100
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Oct 2020 19:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395099AbgJTRBQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Oct 2020 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395094AbgJTRBQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Oct 2020 13:01:16 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD698C0613CE
        for <linux-nfs@vger.kernel.org>; Tue, 20 Oct 2020 10:01:15 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4F4D55F98; Tue, 20 Oct 2020 13:01:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4F4D55F98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603213274;
        bh=MFrvR6i2pealuWlc7WLCqcheUVQjzqHugLoEEM+r2BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCHzQLi4/kKni3IMQm4EWtwWgAueosup1/Ye1KFugvvKbLtwj3XW8nptgSgYe5NIW
         FDDrIP6/n3YDaejwca6ecrFaLcYtRG27qEE9Gco4IxxL9cCFRJBH20Q41sBAh5nlIC
         dLucJNXE0pLbBsmPutz564f6XtUl/PVEq/OWR60w=
Date:   Tue, 20 Oct 2020 13:01:14 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
Message-ID: <20201020170114.GF1133@fieldses.org>
References: <20201019034249.27990-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019034249.27990-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Oct 18, 2020 at 11:42:49PM -0400, Dai Ngo wrote:
> NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
> build errors and some configs with NFSD=m to get NFS4ERR_STALE
> error when doing inter server copy.
> 
> Added ops table in nfs_common for knfsd to access NFS client modules.

OK, looks reasonable to me, applying.  Does this resolve all the
problems you've seen, or is there any bad case left?

--b.

> 
> Fixes: 3ac3711adb88 ("NFSD: Fix NFS server build errors")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> changes from v2: fix 0-day build issues.
> changes from v3: reacted to Bruce's comments, removed paranoid error checking.
> ---
>  fs/nfs/nfs4file.c       | 38 ++++++++++++++++----
>  fs/nfs/nfs4super.c      |  5 +++
>  fs/nfs/super.c          | 17 +++++++++
>  fs/nfs_common/Makefile  |  1 +
>  fs/nfs_common/nfs_ssc.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/Kconfig         |  2 +-
>  fs/nfsd/nfs4proc.c      |  3 +-
>  include/linux/nfs_ssc.h | 67 +++++++++++++++++++++++++++++++++++
>  8 files changed, 219 insertions(+), 8 deletions(-)
>  create mode 100644 fs/nfs_common/nfs_ssc.c
>  create mode 100644 include/linux/nfs_ssc.h
> 
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index fdfc77486ace..984938024011 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -9,6 +9,7 @@
>  #include <linux/falloc.h>
>  #include <linux/mount.h>
>  #include <linux/nfs_fs.h>
> +#include <linux/nfs_ssc.h>
>  #include "delegation.h"
>  #include "internal.h"
>  #include "iostat.h"
> @@ -314,9 +315,8 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
>  static int read_name_gen = 1;
>  #define SSC_READ_NAME_BODY "ssc_read_%d"
>  
> -struct file *
> -nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
> -		nfs4_stateid *stateid)
> +static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
> +		struct nfs_fh *src_fh, nfs4_stateid *stateid)
>  {
>  	struct nfs_fattr fattr;
>  	struct file *filep, *res;
> @@ -398,14 +398,40 @@ struct file *
>  	fput(filep);
>  	goto out_free_name;
>  }
> -EXPORT_SYMBOL_GPL(nfs42_ssc_open);
> -void nfs42_ssc_close(struct file *filep)
> +
> +static void __nfs42_ssc_close(struct file *filep)
>  {
>  	struct nfs_open_context *ctx = nfs_file_open_context(filep);
>  
>  	ctx->state->flags = 0;
>  }
> -EXPORT_SYMBOL_GPL(nfs42_ssc_close);
> +
> +static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
> +	.sco_open = __nfs42_ssc_open,
> +	.sco_close = __nfs42_ssc_close,
> +};
> +
> +/**
> + * nfs42_ssc_register_ops - Wrapper to register NFS_V4 ops in nfs_common
> + *
> + * Return values:
> + *   None
> + */
> +void nfs42_ssc_register_ops(void)
> +{
> +	nfs42_ssc_register(&nfs4_ssc_clnt_ops_tbl);
> +}
> +
> +/**
> + * nfs42_ssc_unregister_ops - wrapper to un-register NFS_V4 ops in nfs_common
> + *
> + * Return values:
> + *   None.
> + */
> +void nfs42_ssc_unregister_ops(void)
> +{
> +	nfs42_ssc_unregister(&nfs4_ssc_clnt_ops_tbl);
> +}
>  #endif /* CONFIG_NFS_V4_2 */
>  
>  const struct file_operations nfs4_file_operations = {
> diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
> index 0c1ab846b83d..93f5c1678ec2 100644
> --- a/fs/nfs/nfs4super.c
> +++ b/fs/nfs/nfs4super.c
> @@ -7,6 +7,7 @@
>  #include <linux/mount.h>
>  #include <linux/nfs4_mount.h>
>  #include <linux/nfs_fs.h>
> +#include <linux/nfs_ssc.h>
>  #include "delegation.h"
>  #include "internal.h"
>  #include "nfs4_fs.h"
> @@ -279,6 +280,9 @@ static int __init init_nfs_v4(void)
>  	if (err)
>  		goto out2;
>  
> +#ifdef CONFIG_NFS_V4_2
> +	nfs42_ssc_register_ops();
> +#endif
>  	register_nfs_version(&nfs_v4);
>  	return 0;
>  out2:
> @@ -297,6 +301,7 @@ static void __exit exit_nfs_v4(void)
>  	unregister_nfs_version(&nfs_v4);
>  #ifdef CONFIG_NFS_V4_2
>  	nfs4_xattr_cache_exit();
> +	nfs42_ssc_unregister_ops();
>  #endif
>  	nfs4_unregister_sysctl();
>  	nfs_idmap_quit();
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 7a70287f21a2..f7dad8227a5f 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -57,6 +57,7 @@
>  #include <linux/rcupdate.h>
>  
>  #include <linux/uaccess.h>
> +#include <linux/nfs_ssc.h>
>  
>  #include "nfs4_fs.h"
>  #include "callback.h"
> @@ -85,6 +86,10 @@
>  };
>  EXPORT_SYMBOL_GPL(nfs_sops);
>  
> +static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
> +	.sco_sb_deactive = nfs_sb_deactive,
> +};
> +
>  #if IS_ENABLED(CONFIG_NFS_V4)
>  static int __init register_nfs4_fs(void)
>  {
> @@ -106,6 +111,16 @@ static void unregister_nfs4_fs(void)
>  }
>  #endif
>  
> +static void nfs_ssc_register_ops(void)
> +{
> +	nfs_ssc_register(&nfs_ssc_clnt_ops_tbl);
> +}
> +
> +static void nfs_ssc_unregister_ops(void)
> +{
> +	nfs_ssc_unregister(&nfs_ssc_clnt_ops_tbl);
> +}
> +
>  static struct shrinker acl_shrinker = {
>  	.count_objects	= nfs_access_cache_count,
>  	.scan_objects	= nfs_access_cache_scan,
> @@ -133,6 +148,7 @@ int __init register_nfs_fs(void)
>  	ret = register_shrinker(&acl_shrinker);
>  	if (ret < 0)
>  		goto error_3;
> +	nfs_ssc_register_ops();
>  	return 0;
>  error_3:
>  	nfs_unregister_sysctl();
> @@ -152,6 +168,7 @@ void __exit unregister_nfs_fs(void)
>  	unregister_shrinker(&acl_shrinker);
>  	nfs_unregister_sysctl();
>  	unregister_nfs4_fs();
> +	nfs_ssc_unregister_ops();
>  	unregister_filesystem(&nfs_fs_type);
>  }
>  
> diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> index 4bebe834c009..fa82f5aaa6d9 100644
> --- a/fs/nfs_common/Makefile
> +++ b/fs/nfs_common/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
>  nfs_acl-objs := nfsacl.o
>  
>  obj-$(CONFIG_GRACE_PERIOD) += grace.o
> +obj-$(CONFIG_GRACE_PERIOD) += nfs_ssc.o
> diff --git a/fs/nfs_common/nfs_ssc.c b/fs/nfs_common/nfs_ssc.c
> new file mode 100644
> index 000000000000..f43bbb373913
> --- /dev/null
> +++ b/fs/nfs_common/nfs_ssc.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * fs/nfs_common/nfs_ssc_comm.c
> + *
> + * Helper for knfsd's SSC to access ops in NFS client modules
> + *
> + * Author: Dai Ngo <dai.ngo@oracle.com>
> + *
> + * Copyright (c) 2020, Oracle and/or its affiliates.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/nfs_ssc.h>
> +#include "../nfs/nfs4_fs.h"
> +
> +MODULE_LICENSE("GPL");
> +
> +struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
> +EXPORT_SYMBOL_GPL(nfs_ssc_client_tbl);
> +
> +#ifdef CONFIG_NFS_V4_2
> +/**
> + * nfs42_ssc_register - install the NFS_V4 client ops in the nfs_ssc_client_tbl
> + * @ops: NFS_V4 ops to be installed
> + *
> + * Return values:
> + *   None
> + */
> +void nfs42_ssc_register(const struct nfs4_ssc_client_ops *ops)
> +{
> +	nfs_ssc_client_tbl.ssc_nfs4_ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(nfs42_ssc_register);
> +
> +/**
> + * nfs42_ssc_unregister - uninstall the NFS_V4 client ops from
> + *				the nfs_ssc_client_tbl
> + * @ops: ops to be uninstalled
> + *
> + * Return values:
> + *   None
> + */
> +void nfs42_ssc_unregister(const struct nfs4_ssc_client_ops *ops)
> +{
> +	if (nfs_ssc_client_tbl.ssc_nfs4_ops != ops)
> +		return;
> +
> +	nfs_ssc_client_tbl.ssc_nfs4_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(nfs42_ssc_unregister);
> +#endif /* CONFIG_NFS_V4_2 */
> +
> +#ifdef CONFIG_NFS_V4_2
> +/**
> + * nfs_ssc_register - install the NFS_FS client ops in the nfs_ssc_client_tbl
> + * @ops: NFS_FS ops to be installed
> + *
> + * Return values:
> + *   None
> + */
> +void nfs_ssc_register(const struct nfs_ssc_client_ops *ops)
> +{
> +	nfs_ssc_client_tbl.ssc_nfs_ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(nfs_ssc_register);
> +
> +/**
> + * nfs_ssc_unregister - uninstall the NFS_FS client ops from
> + *				the nfs_ssc_client_tbl
> + * @ops: ops to be uninstalled
> + *
> + * Return values:
> + *   None
> + */
> +void nfs_ssc_unregister(const struct nfs_ssc_client_ops *ops)
> +{
> +	if (nfs_ssc_client_tbl.ssc_nfs_ops != ops)
> +		return;
> +	nfs_ssc_client_tbl.ssc_nfs_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(nfs_ssc_unregister);
> +
> +#else
> +void nfs_ssc_register(const struct nfs_ssc_client_ops *ops)
> +{
> +}
> +EXPORT_SYMBOL_GPL(nfs_ssc_register);
> +
> +void nfs_ssc_unregister(const struct nfs_ssc_client_ops *ops)
> +{
> +}
> +EXPORT_SYMBOL_GPL(nfs_ssc_unregister);
> +#endif /* CONFIG_NFS_V4_2 */
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 99d2cae91bd6..f368f3215f88 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -136,7 +136,7 @@ config NFSD_FLEXFILELAYOUT
>  
>  config NFSD_V4_2_INTER_SSC
>  	bool "NFSv4.2 inter server to server COPY"
> -	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2 && NFS_FS=y
> +	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
>  	help
>  	  This option enables support for NFSv4.2 inter server to
>  	  server copy where the destination server calls the NFSv4.2
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index eaf50eafa935..84e10aef1417 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -38,6 +38,7 @@
>  #include <linux/slab.h>
>  #include <linux/kthread.h>
>  #include <linux/sunrpc/addr.h>
> +#include <linux/nfs_ssc.h>
>  
>  #include "idmap.h"
>  #include "cache.h"
> @@ -1247,7 +1248,7 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>  static void
>  nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>  {
> -	nfs_sb_deactive(ss_mnt->mnt_sb);
> +	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>  	mntput(ss_mnt);
>  }
>  
> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
> new file mode 100644
> index 000000000000..f5ba0fbff72f
> --- /dev/null
> +++ b/include/linux/nfs_ssc.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * include/linux/nfs_ssc.h
> + *
> + * Author: Dai Ngo <dai.ngo@oracle.com>
> + *
> + * Copyright (c) 2020, Oracle and/or its affiliates.
> + */
> +
> +#include <linux/nfs_fs.h>
> +
> +extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
> +
> +/*
> + * NFS_V4
> + */
> +struct nfs4_ssc_client_ops {
> +	struct file *(*sco_open)(struct vfsmount *ss_mnt,
> +		struct nfs_fh *src_fh, nfs4_stateid *stateid);
> +	void (*sco_close)(struct file *filep);
> +};
> +
> +/*
> + * NFS_FS
> + */
> +struct nfs_ssc_client_ops {
> +	void (*sco_sb_deactive)(struct super_block *sb);
> +};
> +
> +struct nfs_ssc_client_ops_tbl {
> +	const struct nfs4_ssc_client_ops *ssc_nfs4_ops;
> +	const struct nfs_ssc_client_ops *ssc_nfs_ops;
> +};
> +
> +extern void nfs42_ssc_register_ops(void);
> +extern void nfs42_ssc_unregister_ops(void);
> +
> +extern void nfs42_ssc_register(const struct nfs4_ssc_client_ops *ops);
> +extern void nfs42_ssc_unregister(const struct nfs4_ssc_client_ops *ops);
> +
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +static inline struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
> +		struct nfs_fh *src_fh, nfs4_stateid *stateid)
> +{
> +	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
> +		return (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_open)(ss_mnt, src_fh, stateid);
> +	return ERR_PTR(-EIO);
> +}
> +
> +static inline void nfs42_ssc_close(struct file *filep)
> +{
> +	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
> +		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
> +}
> +#endif
> +
> +/*
> + * NFS_FS
> + */
> +extern void nfs_ssc_register(const struct nfs_ssc_client_ops *ops);
> +extern void nfs_ssc_unregister(const struct nfs_ssc_client_ops *ops);
> +
> +static inline void nfs_do_sb_deactive(struct super_block *sb)
> +{
> +	if (nfs_ssc_client_tbl.ssc_nfs_ops)
> +		(*nfs_ssc_client_tbl.ssc_nfs_ops->sco_sb_deactive)(sb);
> +}
> -- 
> 1.8.3.1
