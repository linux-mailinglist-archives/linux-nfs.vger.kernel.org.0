Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D865AB4E9
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 17:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiIBPUU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiIBPTv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 11:19:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E0A14A13B
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 07:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37AA1CE3001
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 14:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4691C433C1;
        Fri,  2 Sep 2022 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662130351;
        bh=T9o0YlpxHHeti+yRYPT3M2aF+5gmD4GhqrZU5Xk5yD0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mB35PaAElG9AVp3YW19GXo8ZUddPEgqZBf1ypq00I91tUQ8UydEDQVcXtc9SUL7ke
         xunk98HRBMqDioZxzWfwgwI9FAqBQblgyq1TxG8Ts8KwmZTSKySm9JH+ctPO3L5Mf2
         jp40Gth8fAS2XvXOMoPzE/+HHzHSCGfau+2LU/qdRbJDaDGLLDtgATEEQJnbn42GgP
         5ZLXoWkdSfudgFKrpn/R0417tpf+77P+uNW/KLRAOocVFxdqt0Sqw7LN68scDct+sH
         9BHdAq86Ni7SPYPYQmWRZwE4Q2HNivSGoKud6cr3G/ILUJOzxU7k8/6o8BCVZmCQkM
         pHbV+vG00phzA==
Message-ID: <65038cdd0138922e3b9d1e416a296b4abba383a4.camel@kernel.org>
Subject: Re: [PATCH v5 2/3] NFS: Configure support for netfs when NFS
 fscache is configured
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Date:   Fri, 02 Sep 2022 10:52:29 -0400
In-Reply-To: <20220902125346.1619659-3-dwysocha@redhat.com>
References: <20220902125346.1619659-1-dwysocha@redhat.com>
         <20220902125346.1619659-3-dwysocha@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-09-02 at 08:53 -0400, Dave Wysochanski wrote:
> As first steps for support of the netfs library when NFS_FSCACHE is
> configured, add NETFS_SUPPORT to Kconfig and add the required netfs_inode
> into struct nfs_inode.
>=20
> Using netfs requires we move the VFS inode structure to be stored
> inside struct netfs_inode, along with the fscache_cookie.
> Thus, create a new helper, VFS_I(), which is defined
> differently depending on whether NFS_FSCACHE is configured.
> In addition, use the netfs_inode() and netfs_i_cookie() helpers,
> and remove our own helper, nfs_i_fscache().
>=20
> Later patches will convert NFS fscache to fully use netfs.
>=20
> Link: https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92=
eb028fb.camel@hammerspace.com/
>=20
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/nfs/Kconfig         |  1 +
>  fs/nfs/delegation.c    |  2 +-
>  fs/nfs/dir.c           |  2 +-
>  fs/nfs/fscache.c       | 20 +++++++++-----------
>  fs/nfs/fscache.h       | 15 ++++++---------
>  fs/nfs/inode.c         |  6 +++---
>  fs/nfs/internal.h      |  2 +-
>  fs/nfs/pnfs.c          | 12 ++++++------
>  fs/nfs/write.c         |  2 +-
>  include/linux/nfs_fs.h | 34 +++++++++++++++++++++++-----------
>  10 files changed, 52 insertions(+), 44 deletions(-)
>=20
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index 14a72224b657..8fbb6caf3481 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -171,6 +171,7 @@ config ROOT_NFS
>  config NFS_FSCACHE
>  	bool "Provide NFS client caching support"
>  	depends on NFS_FS=3Dm && FSCACHE || NFS_FS=3Dy && FSCACHE=3Dy
> +	select NETFS_SUPPORT
>  	help
>  	  Say Y here if you want NFS data to be cached locally on disc through
>  	  the general filesystem cache manager
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 5c97cad741a7..b5c492d40367 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -306,7 +306,7 @@ nfs_start_delegation_return_locked(struct nfs_inode *=
nfsi)
>  	}
>  	spin_unlock(&delegation->lock);
>  	if (ret)
> -		nfs_clear_verifier_delegated(&nfsi->vfs_inode);
> +		nfs_clear_verifier_delegated(VFS_I(nfsi));
>  out:
>  	return ret;
>  }
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 5d6c2ddc7ea6..b63c624cea6d 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2799,7 +2799,7 @@ nfs_do_access_cache_scan(unsigned int nr_to_scan)
> =20
>  		if (nr_to_scan-- =3D=3D 0)
>  			break;
> -		inode =3D &nfsi->vfs_inode;
> +		inode =3D VFS_I(nfsi);
>  		spin_lock(&inode->i_lock);
>  		if (list_empty(&nfsi->access_cache_entry_lru))
>  			goto remove_lru_entry;
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index e861d7bae305..a6fc1c8b6644 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -163,13 +163,14 @@ void nfs_fscache_init_inode(struct inode *inode)
>  	struct nfs_server *nfss =3D NFS_SERVER(inode);
>  	struct nfs_inode *nfsi =3D NFS_I(inode);
> =20
> -	nfsi->fscache =3D NULL;
> +	netfs_inode(inode)->cache =3D NULL;
>  	if (!(nfss->fscache && S_ISREG(inode->i_mode)))
>  		return;
> =20
>  	nfs_fscache_update_auxdata(&auxdata, inode);
> =20
> -	nfsi->fscache =3D fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
> +	netfs_inode(inode)->cache =3D fscache_acquire_cookie(
> +					       nfss->fscache,
>  					       0,
>  					       nfsi->fh.data, /* index_key */
>  					       nfsi->fh.size,
> @@ -183,11 +184,8 @@ void nfs_fscache_init_inode(struct inode *inode)
>   */
>  void nfs_fscache_clear_inode(struct inode *inode)
>  {
> -	struct nfs_inode *nfsi =3D NFS_I(inode);
> -	struct fscache_cookie *cookie =3D nfs_i_fscache(inode);
> -
> -	fscache_relinquish_cookie(cookie, false);
> -	nfsi->fscache =3D NULL;
> +	fscache_relinquish_cookie(netfs_i_cookie(&NFS_I(inode)->netfs), false);
> +	netfs_inode(inode)->cache =3D NULL;
>  }
> =20
>  /*
> @@ -212,7 +210,7 @@ void nfs_fscache_clear_inode(struct inode *inode)
>  void nfs_fscache_open_file(struct inode *inode, struct file *filp)
>  {
>  	struct nfs_fscache_inode_auxdata auxdata;
> -	struct fscache_cookie *cookie =3D nfs_i_fscache(inode);
> +	struct fscache_cookie *cookie =3D netfs_i_cookie(&NFS_I(inode)->netfs);
>  	bool open_for_write =3D inode_is_open_for_write(inode);
> =20
>  	if (!fscache_cookie_valid(cookie))
> @@ -230,7 +228,7 @@ EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
>  void nfs_fscache_release_file(struct inode *inode, struct file *filp)
>  {
>  	struct nfs_fscache_inode_auxdata auxdata;
> -	struct fscache_cookie *cookie =3D nfs_i_fscache(inode);
> +	struct fscache_cookie *cookie =3D netfs_i_cookie(&NFS_I(inode)->netfs);
>  	loff_t i_size =3D i_size_read(inode);
> =20
>  	nfs_fscache_update_auxdata(&auxdata, inode);
> @@ -243,7 +241,7 @@ void nfs_fscache_release_file(struct inode *inode, st=
ruct file *filp)
>  static int fscache_fallback_read_page(struct inode *inode, struct page *=
page)
>  {
>  	struct netfs_cache_resources cres;
> -	struct fscache_cookie *cookie =3D nfs_i_fscache(inode);
> +	struct fscache_cookie *cookie =3D netfs_i_cookie(&NFS_I(inode)->netfs);
>  	struct iov_iter iter;
>  	struct bio_vec bvec[1];
>  	int ret;
> @@ -271,7 +269,7 @@ static int fscache_fallback_write_page(struct inode *=
inode, struct page *page,
>  				       bool no_space_allocated_yet)
>  {
>  	struct netfs_cache_resources cres;
> -	struct fscache_cookie *cookie =3D nfs_i_fscache(inode);
> +	struct fscache_cookie *cookie =3D netfs_i_cookie(&NFS_I(inode)->netfs);
>  	struct iov_iter iter;
>  	struct bio_vec bvec[1];
>  	loff_t start =3D page_offset(page);
> diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
> index 2a37af880978..38614ed8f951 100644
> --- a/fs/nfs/fscache.h
> +++ b/fs/nfs/fscache.h
> @@ -54,7 +54,7 @@ static inline bool nfs_fscache_release_folio(struct fol=
io *folio, gfp_t gfp)
>  		if (current_is_kswapd() || !(gfp & __GFP_FS))
>  			return false;
>  		folio_wait_fscache(folio);
> -		fscache_note_page_release(nfs_i_fscache(folio->mapping->host));
> +		fscache_note_page_release(netfs_i_cookie(&NFS_I(folio->mapping->host)-=
>netfs));
>  		nfs_inc_fscache_stats(folio->mapping->host,
>  				      NFSIOS_FSCACHE_PAGES_UNCACHED);
>  	}
> @@ -66,7 +66,7 @@ static inline bool nfs_fscache_release_folio(struct fol=
io *folio, gfp_t gfp)
>   */
>  static inline int nfs_fscache_read_page(struct inode *inode, struct page=
 *page)
>  {
> -	if (nfs_i_fscache(inode))
> +	if (netfs_inode(inode)->cache)
>  		return __nfs_fscache_read_page(inode, page);
>  	return -ENOBUFS;
>  }
> @@ -78,7 +78,7 @@ static inline int nfs_fscache_read_page(struct inode *i=
node, struct page *page)
>  static inline void nfs_fscache_write_page(struct inode *inode,
>  					   struct page *page)
>  {
> -	if (nfs_i_fscache(inode))
> +	if (netfs_inode(inode)->cache)
>  		__nfs_fscache_write_page(inode, page);
>  }
> =20
> @@ -101,13 +101,10 @@ static inline void nfs_fscache_update_auxdata(struc=
t nfs_fscache_inode_auxdata *
>  static inline void nfs_fscache_invalidate(struct inode *inode, int flags=
)
>  {
>  	struct nfs_fscache_inode_auxdata auxdata;
> -	struct nfs_inode *nfsi =3D NFS_I(inode);
> +	struct fscache_cookie *cookie =3D  netfs_i_cookie(&NFS_I(inode)->netfs)=
;
> =20
> -	if (nfsi->fscache) {
> -		nfs_fscache_update_auxdata(&auxdata, inode);
> -		fscache_invalidate(nfsi->fscache, &auxdata,
> -				   i_size_read(inode), flags);
> -	}
> +	nfs_fscache_update_auxdata(&auxdata, inode);
> +	fscache_invalidate(cookie, &auxdata, i_size_read(inode), flags);
>  }
> =20
>  /*
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index bea7c005119c..aa2aec785ab5 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -1411,7 +1411,7 @@ int nfs_revalidate_mapping(struct inode *inode, str=
uct address_space *mapping)
> =20
>  static bool nfs_file_has_writers(struct nfs_inode *nfsi)
>  {
> -	struct inode *inode =3D &nfsi->vfs_inode;
> +	struct inode *inode =3D VFS_I(nfsi);
> =20
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
> @@ -2249,7 +2249,7 @@ struct inode *nfs_alloc_inode(struct super_block *s=
b)
>  #ifdef CONFIG_NFS_V4_2
>  	nfsi->xattr_cache =3D NULL;
>  #endif
> -	return &nfsi->vfs_inode;
> +	return VFS_I(nfsi);
>  }
>  EXPORT_SYMBOL_GPL(nfs_alloc_inode);
> =20
> @@ -2273,7 +2273,7 @@ static void init_once(void *foo)
>  {
>  	struct nfs_inode *nfsi =3D (struct nfs_inode *) foo;
> =20
> -	inode_init_once(&nfsi->vfs_inode);
> +	inode_init_once(VFS_I(nfsi));
>  	INIT_LIST_HEAD(&nfsi->open_files);
>  	INIT_LIST_HEAD(&nfsi->access_cache_entry_lru);
>  	INIT_LIST_HEAD(&nfsi->access_cache_inode_lru);
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 27c720d71b4e..273687082992 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -355,7 +355,7 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_l=
abel *src)
> =20
>  static inline void nfs_zap_label_cache_locked(struct nfs_inode *nfsi)
>  {
> -	if (nfs_server_capable(&nfsi->vfs_inode, NFS_CAP_SECURITY_LABEL))
> +	if (nfs_server_capable(VFS_I(nfsi), NFS_CAP_SECURITY_LABEL))
>  		nfsi->cache_validity |=3D NFS_INO_INVALID_LABEL;
>  }
>  #else
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index 2613b7e36eb9..035bf2eac2cf 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -763,19 +763,19 @@ static struct pnfs_layout_hdr *__pnfs_destroy_layou=
t(struct nfs_inode *nfsi)
>  	struct pnfs_layout_hdr *lo;
>  	LIST_HEAD(tmp_list);
> =20
> -	spin_lock(&nfsi->vfs_inode.i_lock);
> +	spin_lock(&VFS_I(nfsi)->i_lock);
>  	lo =3D nfsi->layout;
>  	if (lo) {
>  		pnfs_get_layout_hdr(lo);
>  		pnfs_mark_layout_stateid_invalid(lo, &tmp_list);
>  		pnfs_layout_clear_fail_bit(lo, NFS_LAYOUT_RO_FAILED);
>  		pnfs_layout_clear_fail_bit(lo, NFS_LAYOUT_RW_FAILED);
> -		spin_unlock(&nfsi->vfs_inode.i_lock);
> +		spin_unlock(&VFS_I(nfsi)->i_lock);
>  		pnfs_free_lseg_list(&tmp_list);
> -		nfs_commit_inode(&nfsi->vfs_inode, 0);
> +		nfs_commit_inode(VFS_I(nfsi), 0);
>  		pnfs_put_layout_hdr(lo);
>  	} else
> -		spin_unlock(&nfsi->vfs_inode.i_lock);
> +		spin_unlock(&VFS_I(nfsi)->i_lock);
>  	return lo;
>  }
> =20
> @@ -790,9 +790,9 @@ static bool pnfs_layout_removed(struct nfs_inode *nfs=
i,
>  {
>  	bool ret;
> =20
> -	spin_lock(&nfsi->vfs_inode.i_lock);
> +	spin_lock(&VFS_I(nfsi)->i_lock);
>  	ret =3D nfsi->layout !=3D lo;
> -	spin_unlock(&nfsi->vfs_inode.i_lock);
> +	spin_unlock(&VFS_I(nfsi)->i_lock);
>  	return ret;
>  }
> =20
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 1843fa235d9b..d84121799a7a 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -828,7 +828,7 @@ nfs_page_search_commits_for_head_request_locked(struc=
t nfs_inode *nfsi,
>  {
>  	struct nfs_page *freq, *t;
>  	struct nfs_commit_info cinfo;
> -	struct inode *inode =3D &nfsi->vfs_inode;
> +	struct inode *inode =3D VFS_I(nfsi);
> =20
>  	nfs_init_cinfo_from_inode(&cinfo, inode);
> =20
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 7931fa472561..a1c402e26abf 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -31,6 +31,10 @@
>  #include <linux/sunrpc/auth.h>
>  #include <linux/sunrpc/clnt.h>
> =20
> +#ifdef CONFIG_NFS_FSCACHE
> +#include <linux/netfs.h>
> +#endif
> +
>  #include <linux/nfs.h>
>  #include <linux/nfs2.h>
>  #include <linux/nfs3.h>
> @@ -204,9 +208,11 @@ struct nfs_inode {
>  	__u64 write_io;
>  	__u64 read_io;
>  #ifdef CONFIG_NFS_FSCACHE
> -	struct fscache_cookie	*fscache;
> -#endif
> +	struct netfs_inode	netfs; /* netfs context and VFS inode */
> +#else
>  	struct inode		vfs_inode;
> +#endif
> +
> =20
>  #ifdef CONFIG_NFS_V4_2
>  	struct nfs4_xattr_cache *xattr_cache;
> @@ -281,10 +287,25 @@ struct nfs4_copy_state {
>  #define NFS_INO_LAYOUTSTATS	(11)		/* layoutstats inflight */
>  #define NFS_INO_ODIRECT		(12)		/* I/O setting is O_DIRECT */
> =20
> +#ifdef CONFIG_NFS_FSCACHE
> +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> +{
> +	return &nfsi->netfs.inode;
> +}
> +static inline struct nfs_inode *NFS_I(const struct inode *inode)
> +{
> +	return container_of(inode, struct nfs_inode, netfs.inode);
> +}
> +#else
> +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> +{
> +	return &nfsi->vfs_inode;
> +}
>  static inline struct nfs_inode *NFS_I(const struct inode *inode)
>  {
>  	return container_of(inode, struct nfs_inode, vfs_inode);
>  }
> +#endif
> =20
>  static inline struct nfs_server *NFS_SB(const struct super_block *s)
>  {
> @@ -328,15 +349,6 @@ static inline int NFS_STALE(const struct inode *inod=
e)
>  	return test_bit(NFS_INO_STALE, &NFS_I(inode)->flags);
>  }
> =20
> -static inline struct fscache_cookie *nfs_i_fscache(struct inode *inode)
> -{
> -#ifdef CONFIG_NFS_FSCACHE
> -	return NFS_I(inode)->fscache;
> -#else
> -	return NULL;
> -#endif
> -}
> -
>  static inline __u64 NFS_FILEID(const struct inode *inode)
>  {
>  	return NFS_I(inode)->fileid;

Much nicer.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
