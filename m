Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9815079C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgBCNo2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 08:44:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50157 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727066AbgBCNo2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Feb 2020 08:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580737467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=incqINHYayyuHCWAMyZBplY1Vi0FOH3O8+tpg2Zrza0=;
        b=Xk8kB8bsbiPDbE0d64sAHekvIi/Mhk+bZW+aEFrIY+zbARr1apbv6VTLBk+T25bdZwpZP8
        lxTBJPrm6royC8uMmjPXc5bwBRNTsatFKomGV5WmaJLuGBr1xJuHJORFFZzwiQ03IGwrJq
        lL7TfFiGzvbyCYhXv8r89oOISajT+Jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-g2_QjwG0PU6U9jq4u-mtEw-1; Mon, 03 Feb 2020 08:44:23 -0500
X-MC-Unique: g2_QjwG0PU6U9jq4u-mtEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC59C8017CC;
        Mon,  3 Feb 2020 13:44:22 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28D265C1D4;
        Mon,  3 Feb 2020 13:44:22 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@gmail.com>
Cc:     "Anna Schumaker" <Anna.Schumaker@netapp.com>,
        "Dai Ngo" <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/4] NFS: Fix memory leaks and corruption in readdir
Date:   Mon, 03 Feb 2020 08:44:21 -0500
Message-ID: <60888F6B-EA4B-4857-9B41-2F6087212D76@redhat.com>
In-Reply-To: <20200202225356.995080-2-trond.myklebust@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
 <20200202225356.995080-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2 Feb 2020, at 17:53, Trond Myklebust wrote:

> nfs_readdir_xdr_to_array() must not exit without having initialised
> the array, so that the page cache deletion routines can safely
> call nfs_readdir_clear_array().
> Furthermore, we should ensure that if we exit nfs_readdir_filler()
> with an error, we free up any page contents to prevent a leak
> if we try to fill the page again.
>
> Fixes: 11de3b11e08c ("NFS: Fix a memory leak in nfs_readdir")
> Cc: stable@vger.kernel.org # v2.6.37+
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Looks good to me.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

> ---
>  fs/nfs/dir.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 76404f53cf21..ba0d55930e8a 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -163,6 +163,17 @@ typedef struct {
>  	bool eof;
>  } nfs_readdir_descriptor_t;
>
> +static
> +void nfs_readdir_init_array(struct page *page)
> +{
> +	struct nfs_cache_array *array;
> +
> +	array = kmap_atomic(page);
> +	memset(array, 0, sizeof(struct nfs_cache_array));
> +	array->eof_index = -1;
> +	kunmap_atomic(array);
> +}
> +
>  /*
>   * we are freeing strings created by nfs_add_to_readdir_array()
>   */
> @@ -175,6 +186,7 @@ void nfs_readdir_clear_array(struct page *page)
>  	array = kmap_atomic(page);
>  	for (i = 0; i < array->size; i++)
>  		kfree(array->array[i].string.name);
> +	array->size = 0;
>  	kunmap_atomic(array);
>  }
>
> @@ -613,6 +625,8 @@ int 
> nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page 
> *page,
>  	int status = -ENOMEM;
>  	unsigned int array_size = ARRAY_SIZE(pages);
>
> +	nfs_readdir_init_array(page);
> +
>  	entry.prev_cookie = 0;
>  	entry.cookie = desc->last_cookie;
>  	entry.eof = 0;
> @@ -629,8 +643,6 @@ int 
> nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page 
> *page,
>  	}
>
>  	array = kmap(page);
> -	memset(array, 0, sizeof(struct nfs_cache_array));
> -	array->eof_index = -1;
>
>  	status = nfs_readdir_alloc_pages(pages, array_size);
>  	if (status < 0)
> @@ -685,6 +697,7 @@ int nfs_readdir_filler(void *data, struct page* 
> page)
>  	unlock_page(page);
>  	return 0;
>   error:
> +	nfs_readdir_clear_array(page);
>  	unlock_page(page);
>  	return ret;
>  }
> -- 
> 2.24.1

