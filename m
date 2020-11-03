Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2622A4A67
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 16:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgKCPz2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 10:55:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727385AbgKCPz2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 10:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604418926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SG1jVraopaEnGKB4rrzsnrSjjc+iFCOZLhcZH/v40MI=;
        b=hsIil1JJveBaFLfBo7T7RIF4NluspVWS94UJtFl+gYFhJDervLKr06kfvPkiIgTgKGjncS
        4qK6h5RI3CAhlEmpMvBIBb0HWzKmjyEHI6zx2OBlEOmDliVTpUp4boGoXCY3FIn7vtwFyS
        U4St9034z41K89z42MWEozKP/HWxspY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-4EatxdD7PlOwEzJfav8LdQ-1; Tue, 03 Nov 2020 10:55:24 -0500
X-MC-Unique: 4EatxdD7PlOwEzJfav8LdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14F761087D64;
        Tue,  3 Nov 2020 15:55:23 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C76805D9CC;
        Tue,  3 Nov 2020 15:55:22 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 05/16] NFS: Don't discard readdir results
Date:   Tue, 03 Nov 2020 10:55:21 -0500
Message-ID: <DEB8710B-8D01-4FC9-9DA6-78A701C46E19@redhat.com>
In-Reply-To: <20201103153329.531942-6-trondmy@kernel.org>
References: <20201103153329.531942-1-trondmy@kernel.org>
 <20201103153329.531942-2-trondmy@kernel.org>
 <20201103153329.531942-3-trondmy@kernel.org>
 <20201103153329.531942-4-trondmy@kernel.org>
 <20201103153329.531942-5-trondmy@kernel.org>
 <20201103153329.531942-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3 Nov 2020, at 10:33, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If a readdir call returns more data than we can fit into one page
> cache page, then allocate a new one for that data rather than
> discarding the data.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index b4861a33ad60..788c2a2eeaa3 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -321,6 +321,26 @@ static void nfs_readdir_page_set_eof(struct page 
> *page)
>  	kunmap_atomic(array);
>  }
>
> +static void nfs_readdir_page_unlock_and_put(struct page *page)
> +{
> +	unlock_page(page);
> +	put_page(page);
> +}
> +
> +static struct page *nfs_readdir_page_get_next(struct address_space 
> *mapping,
> +					      pgoff_t index, u64 cookie)
> +{
> +	struct page *page;
> +
> +	page = nfs_readdir_page_get_locked(mapping, index, cookie);
> +	if (page) {
> +		if (nfs_readdir_page_last_cookie(page) == cookie)
> +			return page;
> +		nfs_readdir_page_unlock_and_put(page);
> +	}
> +	return NULL;
> +}
> +
>  static inline
>  int is_32bit_api(void)
>  {
> @@ -638,13 +658,15 @@ void nfs_prime_dcache(struct dentry *parent, 
> struct nfs_entry *entry,
>  }
>
>  /* Perform conversion from xdr to cache array */
> -static
> -int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct 
> nfs_entry *entry,
> -				struct page **xdr_pages, struct page *page, unsigned int buflen)
> +static int nfs_readdir_page_filler(struct nfs_readdir_descriptor 
> *desc,
> +				   struct nfs_entry *entry,
> +				   struct page **xdr_pages,
> +				   struct page *fillme, unsigned int buflen)
>  {
> +	struct address_space *mapping = desc->file->f_mapping;
>  	struct xdr_stream stream;
>  	struct xdr_buf buf;
> -	struct page *scratch;
> +	struct page *scratch, *new, *page = fillme;
>  	int status;
>
>  	scratch = alloc_page(GFP_KERNEL);
> @@ -667,6 +689,19 @@ int 
> nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct 
> nfs_entry *en
>  					desc->dir_verifier);
>
>  		status = nfs_readdir_add_to_array(entry, page);
> +		if (status != -ENOSPC)
> +			continue;
> +
> +		if (page->mapping != mapping)
> +			break;

^^ How can this happen?

Ben

