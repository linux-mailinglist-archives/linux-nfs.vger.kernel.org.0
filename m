Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947E730283F
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbhAYQyI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jan 2021 11:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbhAYQxM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jan 2021 11:53:12 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D30C0613D6
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jan 2021 08:52:29 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A77CB6EAF; Mon, 25 Jan 2021 11:52:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A77CB6EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611593548;
        bh=4Dd/OdtWLbT5gmvFTW0oE5FlSExfIUGKfWCYIjkAvOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRO/owbtktQduhsJF6eFQcdLEQUjuWV6NR/gqRLcUmgCxwhY9+Glnfhg9OS3WsO4I
         3ijtdRJuB+DGDMyArl9AUEwrGnSfVUzlqaHqsSpNszB4Tl5lK2JkJjUyaMvucCA6q2
         8n/0F/nuCP/z5WhBmEAbIthHwl2BZ3xJaejP7z84=
Date:   Mon, 25 Jan 2021 11:52:28 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Subject: Re: [PATCH] NFSv4_2: SSC helper should use its own config.
Message-ID: <20210125165228.GA27913@fieldses.org>
References: <20210123015013.34609-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123015013.34609-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Seems reasonable to me.--b.

On Fri, Jan 22, 2021 at 08:50:13PM -0500, Dai Ngo wrote:
> Currently NFSv4_2 SSC helper, nfs_ssc, incorrectly uses GRACE_PERIOD
> as its config. Fix by adding new config NFS_V4_2_SSC_HELPER which
> depends on NFS_V4_2 and is automatically selected when NFSD_V4 is
> enabled. Also removed the file name from a comment in nfs_ssc.c.
> 
> Fixes: 0cfcd405e758 (NFSv4.2: Fix NFS4ERR_STALE error when doing inter server copy)
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/Kconfig              |  3 +++
>  fs/nfs/nfs4file.c       |  4 ++++
>  fs/nfs/super.c          | 12 ++++++++++++
>  fs/nfs_common/Makefile  |  2 +-
>  fs/nfs_common/nfs_ssc.c |  2 --
>  fs/nfsd/Kconfig         |  1 +
>  6 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index aa4c12282301..d33a31239cbc 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -333,6 +333,9 @@ config NFS_COMMON
>  	depends on NFSD || NFS_FS || LOCKD
>  	default y
>  
> +config NFS_V4_2_SSC_HELPER
> +	tristate
> +
>  source "net/sunrpc/Kconfig"
>  source "fs/ceph/Kconfig"
>  source "fs/cifs/Kconfig"
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 57b3821d975a..441a2fa073c8 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -420,7 +420,9 @@ static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
>   */
>  void nfs42_ssc_register_ops(void)
>  {
> +#ifdef CONFIG_NFSD_V4
>  	nfs42_ssc_register(&nfs4_ssc_clnt_ops_tbl);
> +#endif
>  }
>  
>  /**
> @@ -431,7 +433,9 @@ void nfs42_ssc_register_ops(void)
>   */
>  void nfs42_ssc_unregister_ops(void)
>  {
> +#ifdef CONFIG_NFSD_V4
>  	nfs42_ssc_unregister(&nfs4_ssc_clnt_ops_tbl);
> +#endif
>  }
>  #endif /* CONFIG_NFS_V4_2 */
>  
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 4034102010f0..c7a924580eec 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -86,9 +86,11 @@ const struct super_operations nfs_sops = {
>  };
>  EXPORT_SYMBOL_GPL(nfs_sops);
>  
> +#ifdef CONFIG_NFS_V4_2
>  static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
>  	.sco_sb_deactive = nfs_sb_deactive,
>  };
> +#endif
>  
>  #if IS_ENABLED(CONFIG_NFS_V4)
>  static int __init register_nfs4_fs(void)
> @@ -111,15 +113,21 @@ static void unregister_nfs4_fs(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_NFS_V4_2
>  static void nfs_ssc_register_ops(void)
>  {
> +#ifdef CONFIG_NFSD_V4
>  	nfs_ssc_register(&nfs_ssc_clnt_ops_tbl);
> +#endif
>  }
>  
>  static void nfs_ssc_unregister_ops(void)
>  {
> +#ifdef CONFIG_NFSD_V4
>  	nfs_ssc_unregister(&nfs_ssc_clnt_ops_tbl);
> +#endif
>  }
> +#endif /* CONFIG_NFS_V4_2 */
>  
>  static struct shrinker acl_shrinker = {
>  	.count_objects	= nfs_access_cache_count,
> @@ -148,7 +156,9 @@ int __init register_nfs_fs(void)
>  	ret = register_shrinker(&acl_shrinker);
>  	if (ret < 0)
>  		goto error_3;
> +#ifdef CONFIG_NFS_V4_2
>  	nfs_ssc_register_ops();
> +#endif
>  	return 0;
>  error_3:
>  	nfs_unregister_sysctl();
> @@ -168,7 +178,9 @@ void __exit unregister_nfs_fs(void)
>  	unregister_shrinker(&acl_shrinker);
>  	nfs_unregister_sysctl();
>  	unregister_nfs4_fs();
> +#ifdef CONFIG_NFS_V4_2
>  	nfs_ssc_unregister_ops();
> +#endif
>  	unregister_filesystem(&nfs_fs_type);
>  }
>  
> diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> index fa82f5aaa6d9..119c75ab9fd0 100644
> --- a/fs/nfs_common/Makefile
> +++ b/fs/nfs_common/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
>  nfs_acl-objs := nfsacl.o
>  
>  obj-$(CONFIG_GRACE_PERIOD) += grace.o
> -obj-$(CONFIG_GRACE_PERIOD) += nfs_ssc.o
> +obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
> diff --git a/fs/nfs_common/nfs_ssc.c b/fs/nfs_common/nfs_ssc.c
> index f43bbb373913..7c1509e968c8 100644
> --- a/fs/nfs_common/nfs_ssc.c
> +++ b/fs/nfs_common/nfs_ssc.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * fs/nfs_common/nfs_ssc_comm.c
> - *
>   * Helper for knfsd's SSC to access ops in NFS client modules
>   *
>   * Author: Dai Ngo <dai.ngo@oracle.com>
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index dbbc583d6273..821e5913faee 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -76,6 +76,7 @@ config NFSD_V4
>  	select CRYPTO_MD5
>  	select CRYPTO_SHA256
>  	select GRACE_PERIOD
> +	select NFS_V4_2_SSC_HELPER if NFS_V4_2
>  	help
>  	  This option enables support in your system's NFS server for
>  	  version 4 of the NFS protocol (RFC 3530).
> -- 
> 2.9.5
