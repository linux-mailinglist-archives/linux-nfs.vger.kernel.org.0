Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E8D2AC67C
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgKIVAB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgKIVAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 16:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604955599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MF+Qc8aCD5gMbvxMQexOO9CuYLgpE54n1FJu0IDJPgg=;
        b=LrhRZYEHjdErVJMy4Oa8rFURqo2mWHSc2ejH66KXQHgE1DRM5q9MJWZ/px80j5kjPCLGAN
        X60xDfTJHZQrwLneraTWSJjvAS2NjVa0bTkjoVXn+ztTzIoHwp/aXhYdpCn9DT9QYevclv
        4UlrpTMMqKSrQXy7nSrc363Ack28kG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-5LGX9kVqO0ufsyc7CKPwNw-1; Mon, 09 Nov 2020 15:59:57 -0500
X-MC-Unique: 5LGX9kVqO0ufsyc7CKPwNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A928879511;
        Mon,  9 Nov 2020 20:59:56 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8FD71001901;
        Mon,  9 Nov 2020 20:59:54 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 20/21] NFS: Reduce number of RPC calls when doing
 uncached readdir
Date:   Mon, 09 Nov 2020 15:59:53 -0500
Message-ID: <58FA369F-46B0-47E6-B7C8-E0205427B0C0@redhat.com>
In-Reply-To: <20201107140325.281678-21-trondmy@kernel.org>
References: <20201107140325.281678-1-trondmy@kernel.org>
 <20201107140325.281678-2-trondmy@kernel.org>
 <20201107140325.281678-3-trondmy@kernel.org>
 <20201107140325.281678-4-trondmy@kernel.org>
 <20201107140325.281678-5-trondmy@kernel.org>
 <20201107140325.281678-6-trondmy@kernel.org>
 <20201107140325.281678-7-trondmy@kernel.org>
 <20201107140325.281678-8-trondmy@kernel.org>
 <20201107140325.281678-9-trondmy@kernel.org>
 <20201107140325.281678-10-trondmy@kernel.org>
 <20201107140325.281678-11-trondmy@kernel.org>
 <20201107140325.281678-12-trondmy@kernel.org>
 <20201107140325.281678-13-trondmy@kernel.org>
 <20201107140325.281678-14-trondmy@kernel.org>
 <20201107140325.281678-15-trondmy@kernel.org>
 <20201107140325.281678-16-trondmy@kernel.org>
 <20201107140325.281678-17-trondmy@kernel.org>
 <20201107140325.281678-18-trondmy@kernel.org>
 <20201107140325.281678-19-trondmy@kernel.org>
 <20201107140325.281678-20-trondmy@kernel.org>
 <20201107140325.281678-21-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Nov 2020, at 9:03, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If we're doing uncached readdir, allocate multiple pages in order to
> try to avoid duplicate RPC calls for the same getdents() call.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

> ---
>  fs/nfs/dir.c | 79 
> ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 46 insertions(+), 33 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index b6c3501e8f61..238872d116f7 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -694,12 +694,14 @@ void nfs_prime_dcache(struct dentry *parent, 
> struct nfs_entry *entry,
>  static int nfs_readdir_page_filler(struct nfs_readdir_descriptor 
> *desc,
>  				   struct nfs_entry *entry,
>  				   struct page **xdr_pages,
> -				   struct page *fillme, unsigned int buflen)
> +				   unsigned int buflen,
> +				   struct page **arrays,
> +				   size_t narrays)
>  {
>  	struct address_space *mapping = desc->file->f_mapping;
>  	struct xdr_stream stream;
>  	struct xdr_buf buf;
> -	struct page *scratch, *new, *page = fillme;
> +	struct page *scratch, *new, *page = *arrays;
>  	int status;
>
>  	scratch = alloc_page(GFP_KERNEL);
> @@ -725,15 +727,22 @@ static int nfs_readdir_page_filler(struct 
> nfs_readdir_descriptor *desc,
>  		if (status != -ENOSPC)
>  			continue;
>
> -		if (page->mapping != mapping)
> -			break;
> -		new = nfs_readdir_page_get_next(mapping, page->index + 1,
> -						entry->prev_cookie);
> -		if (!new)
> -			break;
> -		if (page != fillme)
> -			nfs_readdir_page_unlock_and_put(page);
> -		page = new;
> +		if (narrays > 1) {
> +			narrays--;
> +			arrays++;
> +			page = *arrays;
> +		} else {
> +			if (page->mapping != mapping)
> +				break;
> +			new = nfs_readdir_page_get_next(mapping,
> +							page->index + 1,
> +							entry->prev_cookie);
> +			if (!new)
> +				break;
> +			if (page != *arrays)
> +				nfs_readdir_page_unlock_and_put(page);
> +			page = new;
> +		}
>  		status = nfs_readdir_add_to_array(entry, page);
>  	} while (!status && !entry->eof);
>
> @@ -750,7 +759,7 @@ static int nfs_readdir_page_filler(struct 
> nfs_readdir_descriptor *desc,
>  		break;
>  	}
>
> -	if (page != fillme)
> +	if (page != *arrays)
>  		nfs_readdir_page_unlock_and_put(page);
>
>  	put_page(scratch);
> @@ -790,10 +799,11 @@ static struct page 
> **nfs_readdir_alloc_pages(size_t npages)
>  }
>
>  static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor 
> *desc,
> -				    struct page *page, __be32 *verf_arg,
> -				    __be32 *verf_res)
> +				    __be32 *verf_arg, __be32 *verf_res,
> +				    struct page **arrays, size_t narrays)
>  {
>  	struct page **pages;
> +	struct page *page = *arrays;
>  	struct nfs_entry *entry;
>  	size_t array_size;
>  	struct inode *inode = file_inode(desc->file);
> @@ -835,7 +845,8 @@ static int nfs_readdir_xdr_to_array(struct 
> nfs_readdir_descriptor *desc,
>  			break;
>  		}
>
> -		status = nfs_readdir_page_filler(desc, entry, pages, page, pglen);
> +		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
> +						 arrays, narrays);
>  	} while (!status && nfs_readdir_page_needs_filling(page));
>
>  	nfs_readdir_free_pages(pages, array_size);
> @@ -884,8 +895,8 @@ static int find_and_lock_cache_page(struct 
> nfs_readdir_descriptor *desc)
>  	if (!desc->page)
>  		return -ENOMEM;
>  	if (nfs_readdir_page_needs_filling(desc->page)) {
> -		res = nfs_readdir_xdr_to_array(desc, desc->page,
> -					       nfsi->cookieverf, verf);
> +		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
> +					       &desc->page, 1);
>  		if (res < 0) {
>  			nfs_readdir_page_unlock_and_put_cached(desc);
>  			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
> @@ -976,35 +987,37 @@ static void nfs_do_filldir(struct 
> nfs_readdir_descriptor *desc)
>   */
>  static int uncached_readdir(struct nfs_readdir_descriptor *desc)
>  {
> -	struct page	*page = NULL;
> +	struct page	**arrays;
> +	size_t		i, sz = 16;
>  	__be32		verf[NFS_DIR_VERIFIER_SIZE];
>  	int		status;
>
>  	dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cookie 
> %Lu\n",
>  			(unsigned long long)desc->dir_cookie);
>
> -	page = alloc_page(GFP_HIGHUSER);
> -	if (!page) {
> -		status = -ENOMEM;
> -		goto out;
> -	}
> +	arrays = nfs_readdir_alloc_pages(sz);
> +	if (!arrays)
> +		return -ENOMEM;
> +	for (i = 0; i < sz; i++)
> +		nfs_readdir_page_init_array(arrays[i], desc->dir_cookie);
>
>  	desc->page_index = 0;
>  	desc->last_cookie = desc->dir_cookie;
> -	desc->page = page;
>  	desc->duped = 0;
>
> -	nfs_readdir_page_init_array(page, desc->dir_cookie);
> -	status = nfs_readdir_xdr_to_array(desc, page, desc->verf, verf);
> -	if (status < 0)
> -		goto out_release;
> +	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, 
> sz);
>
> -	nfs_do_filldir(desc);
> +	for (i = 0; !desc->eof && i < sz; i++) {
> +		desc->page = arrays[i];
> +		nfs_do_filldir(desc);
> +	}
> +	desc->page = NULL;
> +
> +
> +	for (i = 0; i < sz; i++)
> +		nfs_readdir_clear_array(arrays[i]);
> +	nfs_readdir_free_pages(arrays, sz);
>
> - out_release:
> -	nfs_readdir_clear_array(desc->page);
> -	nfs_readdir_page_put(desc);
> - out:
>  	dfprintk(DIRCACHE, "NFS: %s: returns %d\n",
>  			__func__, status);
>  	return status;
> -- 
> 2.28.0

