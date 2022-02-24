Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF344C2EB8
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 15:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiBXOx6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 09:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiBXOxz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 09:53:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 206E417C43E
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 06:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645714404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbXuTJY8AD2UWg52HcOGk1najU2bqGc2Q+PIfCla/30=;
        b=EH8AqbtzUJazE+GUD4gnhc7VgCmwq5dZLgdrO9g3ESyabC9yFvEqQhPhZ/npZxYJHN+9jE
        lmXbiRGb+JFzlgQzUzsojrJA1UoF0rvB1ubNskrug4fOgljppdBi2jNoFqvxLePFhblLxK
        lrRjuISguFPUyiKww6ueeYt2FzRDs/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-ZRdo3LuFOjOFC2bYNynMVg-1; Thu, 24 Feb 2022 09:53:20 -0500
X-MC-Unique: ZRdo3LuFOjOFC2bYNynMVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 094511006AA5;
        Thu, 24 Feb 2022 14:53:20 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F8C983580;
        Thu, 24 Feb 2022 14:53:19 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 05/21] NFS: Store the change attribute in the directory
 page cache
Date:   Thu, 24 Feb 2022 09:53:18 -0500
Message-ID: <0DBE97BF-3A88-49FD-B078-012B5EDA5849@redhat.com>
In-Reply-To: <20220223211305.296816-6-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23 Feb 2022, at 16:12, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Use the change attribute and the first cookie in a directory page 
> cache
> entry to validate that the page is up to date.
>
> Suggested-by: Benjamin Coddington <bcodding@redhat.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 68 
> ++++++++++++++++++++++++++++------------------------
>  1 file changed, 37 insertions(+), 31 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index f2258e926df2..5d9367d9b651 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -139,6 +139,7 @@ struct nfs_cache_array_entry {
>  };
>
>  struct nfs_cache_array {
> +	u64 change_attr;
>  	u64 last_cookie;
>  	unsigned int size;
>  	unsigned char page_full : 1,
> @@ -175,7 +176,8 @@ static void nfs_readdir_array_init(struct 
> nfs_cache_array *array)
>  	memset(array, 0, sizeof(struct nfs_cache_array));
>  }
>
> -static void nfs_readdir_page_init_array(struct page *page, u64 
> last_cookie)
> +static void nfs_readdir_page_init_array(struct page *page, u64 
> last_cookie,
> +					u64 change_attr)
>  {
>  	struct nfs_cache_array *array;


There's a hunk missing here, something like:

@@ -185,6 +185,7 @@ static void nfs_readdir_page_init_array(struct page 
*page, u64 last_cookie,
         nfs_readdir_array_init(array);
         array->last_cookie = last_cookie;
         array->cookies_are_ordered = 1;
+       array->change_attr = change_attr;
         kunmap_atomic(array);
  }

>
> @@ -207,7 +209,7 @@ nfs_readdir_page_array_alloc(u64 last_cookie, 
> gfp_t gfp_flags)
>  {
>  	struct page *page = alloc_page(gfp_flags);
>  	if (page)
> -		nfs_readdir_page_init_array(page, last_cookie);
> +		nfs_readdir_page_init_array(page, last_cookie, 0);
>  	return page;
>  }
>
> @@ -304,19 +306,44 @@ int nfs_readdir_add_to_array(struct nfs_entry 
> *entry, struct page *page)
>  	return ret;
>  }
>
> +static bool nfs_readdir_page_cookie_match(struct page *page, u64 
> last_cookie,
> +					  u64 change_attr)

How about "nfs_readdir_page_valid()"?  There's more going on than a 
cookie match.


> +{
> +	struct nfs_cache_array *array = kmap_atomic(page);
> +	int ret = true;
> +
> +	if (array->change_attr != change_attr)
> +		ret = false;

Can we skip the next test if ret = false?

> +	if (array->size > 0 && array->array[0].cookie != last_cookie)
> +		ret = false;
> +	kunmap_atomic(array);
> +	return ret;
> +}
> +
> +static void nfs_readdir_page_unlock_and_put(struct page *page)
> +{
> +	unlock_page(page);
> +	put_page(page);
> +}
> +
>  static struct page *nfs_readdir_page_get_locked(struct address_space 
> *mapping,
>  						pgoff_t index, u64 last_cookie)
>  {
>  	struct page *page;
> +	u64 change_attr;
>
>  	page = grab_cache_page(mapping, index);
> -	if (page && !PageUptodate(page)) {
> -		nfs_readdir_page_init_array(page, last_cookie);
> -		if (invalidate_inode_pages2_range(mapping, index + 1, -1) < 0)
> -			nfs_zap_mapping(mapping->host, mapping);
> -		SetPageUptodate(page);
> +	if (!page)
> +		return NULL;
> +	change_attr = inode_peek_iversion_raw(mapping->host);
> +	if (PageUptodate(page)) {
> +		if (nfs_readdir_page_cookie_match(page, last_cookie,
> +						  change_attr))
> +			return page;
> +		nfs_readdir_clear_array(page);


Why use i_version rather than nfs_save_change_attribute?  Seems having a
consistent value across the pachecache and dir_verifiers would help
debugging, and we've already have a bunch of machinery around the
change_attribute.

Don't we need to send a GETATTR with READDIR for v4?  Not doing so means
that the pagecache is going to behave differently for v3 and v4, and 
we'll
potentially end up with totally bogus listings for cases where one 
reader
has cached a page of entries in the middle of the pagecache marked with
i_version A, but entries are actually from i_version A++ on the server.
Then another reader comes along and follows earlier entries from 
i_version A
on the server that lead into entries from A++.  I don't think we can 
detect
this case unless we're checking the directory on every READDIR.

Sending a GETATTR for v4 doesn't eliminate that race on the server side, 
but
does remove the large window on the client created by the attribute 
cache
timeouts, and I think its mostly harmless performance-wise.

Also, we don't need the local change_attr variable just to pass it to 
other
functions that can access it themselves.

>  	}
> -
> +	nfs_readdir_page_init_array(page, last_cookie, change_attr);
> +	SetPageUptodate(page);
>  	return page;
>  }
>
> @@ -356,12 +383,6 @@ static void nfs_readdir_page_set_eof(struct page 
> *page)
>  	kunmap_atomic(array);
>  }
>
> -static void nfs_readdir_page_unlock_and_put(struct page *page)
> -{
> -	unlock_page(page);
> -	put_page(page);
> -}
> -
>  static struct page *nfs_readdir_page_get_next(struct address_space 
> *mapping,
>  					      pgoff_t index, u64 cookie)
>  {
> @@ -418,16 +439,6 @@ static int nfs_readdir_search_for_pos(struct 
> nfs_cache_array *array,
>  	return -EBADCOOKIE;
>  }
>
> -static bool
> -nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
> -{
> -	if (nfsi->cache_validity & (NFS_INO_INVALID_CHANGE |
> -				    NFS_INO_INVALID_DATA))
> -		return false;
> -	smp_rmb();
> -	return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
> -}
> -
>  static bool nfs_readdir_array_cookie_in_range(struct nfs_cache_array 
> *array,
>  					      u64 cookie)
>  {
> @@ -456,8 +467,7 @@ static int nfs_readdir_search_for_cookie(struct 
> nfs_cache_array *array,
>  			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
>
>  			new_pos = nfs_readdir_page_offset(desc->page) + i;
> -			if (desc->attr_gencount != nfsi->attr_gencount ||
> -			    !nfs_readdir_inode_mapping_valid(nfsi)) {
> +			if (desc->attr_gencount != nfsi->attr_gencount) {
>  				desc->duped = 0;
>  				desc->attr_gencount = nfsi->attr_gencount;
>  			} else if (new_pos < desc->prev_index) {
> @@ -1094,11 +1104,7 @@ static int nfs_readdir(struct file *file, 
> struct dir_context *ctx)
>  	 * to either find the entry with the appropriate number or
>  	 * revalidate the cookie.
>  	 */
> -	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
> -		res = nfs_revalidate_mapping(inode, file->f_mapping);
> -		if (res < 0)
> -			goto out;
> -	}
> +	nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);

Same as above -> why not send GETATTR with READDIR instead of doing it 
in a
separate RPC?

Ben

