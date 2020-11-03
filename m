Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2EB2A46A6
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgKCNfe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 08:35:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgKCNfe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 08:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604410532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mFST4yp5k5zOIAMHhdyb4L1HJJr4/Hntz1/SXRFpETU=;
        b=RRf49Yk7dSq4AOoOccxc/C4NgDTizC2JunX7Rf25On3DxMNVQqTjMP4hZuiBIJZ4S6isxu
        2klgiAUglBr6jjJ5mTUV6tvp/RCeFKrCizd7WpYnk97l5KhB7zBHy1quAFvWWx2Ywrmy44
        +9PeWE3inCMZNy8KMmP42GNry7MuUP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-uiDwQSLVMwuyPoZ4C2xcPw-1; Tue, 03 Nov 2020 08:35:30 -0500
X-MC-Unique: uiDwQSLVMwuyPoZ4C2xcPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 145258058B8;
        Tue,  3 Nov 2020 13:35:29 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD08321E8A;
        Tue,  3 Nov 2020 13:35:28 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 02/12] NFS: Clean up readdir struct nfs_cache_array
Date:   Tue, 03 Nov 2020 08:35:27 -0500
Message-ID: <015FB69A-1E45-4A93-89F3-2755F2A565F0@redhat.com>
In-Reply-To: <20201102180658.6218-3-trondmy@kernel.org>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2 Nov 2020, at 13:06, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Since the 'eof_index' is only ever used as a flag, make it so.
> Also add a flag to detect if the page has been completely filled.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 66 
> ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 17 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 67d8595cd6e5..604ebe015387 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -138,9 +138,10 @@ struct nfs_cache_array_entry {
>  };
>
>  struct nfs_cache_array {
> -	int size;
> -	int eof_index;
>  	u64 last_cookie;
> +	unsigned int size;
> +	unsigned char page_full : 1,
> +		      page_is_eof : 1;
>  	struct nfs_cache_array_entry array[];
>  };
>
> @@ -172,7 +173,6 @@ void nfs_readdir_init_array(struct page *page)
>
>  	array = kmap_atomic(page);
>  	memset(array, 0, sizeof(struct nfs_cache_array));
> -	array->eof_index = -1;
>  	kunmap_atomic(array);
>  }
>
> @@ -192,6 +192,17 @@ void nfs_readdir_clear_array(struct page *page)
>  	kunmap_atomic(array);
>  }
>
> +static void nfs_readdir_array_set_eof(struct nfs_cache_array *array)
> +{
> +	array->page_is_eof = 1;
> +	array->page_full = 1;
> +}
> +
> +static bool nfs_readdir_array_is_full(struct nfs_cache_array *array)
> +{
> +	return array->page_full;
> +}
> +
>  /*
>   * the caller is responsible for freeing qstr.name
>   * when called by nfs_readdir_add_to_array, the strings will be freed 
> in
> @@ -213,6 +224,23 @@ int nfs_readdir_make_qstr(struct qstr *string, 
> const char *name, unsigned int le
>  	return 0;
>  }
>
> +/*
> + * Check that the next array entry lies entirely within the page 
> bounds
> + */
> +static int nfs_readdir_array_can_expand(struct nfs_cache_array 
> *array)
> +{
> +	struct nfs_cache_array_entry *cache_entry;
> +
> +	if (array->page_full)
> +		return -ENOSPC;
> +	cache_entry = &array->array[array->size + 1];
> +	if ((char *)cache_entry - (char *)array > PAGE_SIZE) {
> +		array->page_full = 1;
> +		return -ENOSPC;
> +	}
> +	return 0;
> +}
> +

I think we could do this calculation at compile-time instead of doing it 
for
each entry, for dubious nominal gains..

Ben


>  static
>  int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page 
> *page)
>  {
> @@ -220,13 +248,11 @@ int nfs_readdir_add_to_array(struct nfs_entry 
> *entry, struct page *page)
>  	struct nfs_cache_array_entry *cache_entry;
>  	int ret;
>
> -	cache_entry = &array->array[array->size];
> -
> -	/* Check that this entry lies within the page bounds */
> -	ret = -ENOSPC;
> -	if ((char *)&cache_entry[1] - (char *)page_address(page) > 
> PAGE_SIZE)
> +	ret = nfs_readdir_array_can_expand(array);
> +	if (ret)
>  		goto out;
>
> +	cache_entry = &array->array[array->size];
>  	cache_entry->cookie = entry->prev_cookie;
>  	cache_entry->ino = entry->ino;
>  	cache_entry->d_type = entry->d_type;
> @@ -236,12 +262,21 @@ int nfs_readdir_add_to_array(struct nfs_entry 
> *entry, struct page *page)
>  	array->last_cookie = entry->cookie;
>  	array->size++;
>  	if (entry->eof != 0)
> -		array->eof_index = array->size;
> +		nfs_readdir_array_set_eof(array);
>  out:
>  	kunmap(page);
>  	return ret;
>  }
>
> +static void nfs_readdir_page_set_eof(struct page *page)
> +{
> +	struct nfs_cache_array *array;
> +
> +	array = kmap_atomic(page);
> +	nfs_readdir_array_set_eof(array);
> +	kunmap_atomic(array);
> +}
> +
>  static inline
>  int is_32bit_api(void)
>  {
> @@ -270,7 +305,7 @@ int nfs_readdir_search_for_pos(struct 
> nfs_cache_array *array, nfs_readdir_descri
>  	if (diff < 0)
>  		goto out_eof;
>  	if (diff >= array->size) {
> -		if (array->eof_index >= 0)
> +		if (array->page_is_eof)
>  			goto out_eof;
>  		return -EAGAIN;
>  	}
> @@ -334,7 +369,7 @@ int nfs_readdir_search_for_cookie(struct 
> nfs_cache_array *array, nfs_readdir_des
>  			return 0;
>  		}
>  	}
> -	if (array->eof_index >= 0) {
> +	if (array->page_is_eof) {
>  		status = -EBADCOOKIE;
>  		if (desc->dir_cookie == array->last_cookie)
>  			desc->eof = true;
> @@ -566,7 +601,6 @@ int 
> nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct 
> nfs_entry *en
>  	struct xdr_stream stream;
>  	struct xdr_buf buf;
>  	struct page *scratch;
> -	struct nfs_cache_array *array;
>  	unsigned int count = 0;
>  	int status;
>
> @@ -604,10 +638,8 @@ int 
> nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct 
> nfs_entry *en
>
>  out_nopages:
>  	if (count == 0 || (status == -EBADCOOKIE && entry->eof != 0)) {
> -		array = kmap(page);
> -		array->eof_index = array->size;
> +		nfs_readdir_page_set_eof(page);
>  		status = 0;
> -		kunmap(page);
>  	}
>
>  	put_page(scratch);
> @@ -689,7 +721,7 @@ int 
> nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page 
> *page,
>  				status = 0;
>  			break;
>  		}
> -	} while (array->eof_index < 0);
> +	} while (!nfs_readdir_array_is_full(array));
>
>  	nfs_readdir_free_pages(pages, array_size);
>  out_release_array:
> @@ -825,7 +857,7 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
>  		if (desc->duped != 0)
>  			desc->duped = 1;
>  	}
> -	if (array->eof_index >= 0)
> +	if (array->page_is_eof)
>  		desc->eof = true;
>
>  	kunmap(desc->page);
> -- 
> 2.28.0

