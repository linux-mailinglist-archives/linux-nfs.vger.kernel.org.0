Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1E2AC775
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKIVlS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729336AbgKIVlS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 16:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604958077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p87XRCm4iQolQJdyYof3mqeTq2/RN+7zGAvrWBsBIb4=;
        b=BWm4dCPqTjkIse2yCY8etnGpII2Y7lHnh5Af0zVr+ew6xmOz3/HTo5dU16VlyLJGcDHUPo
        EDTFpwei0mTgwuExBxXnNjtZnFl0k0arq90aEcfH2aIaxz6n7+2VzovrxlJvdx249sjnvR
        6TPqaPDq2Sk99G19eJLmkWR6gl97qYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-fkHxYbr6Nie7WPE0eXHoPA-1; Mon, 09 Nov 2020 16:41:15 -0500
X-MC-Unique: fkHxYbr6Nie7WPE0eXHoPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B2478049C8;
        Mon,  9 Nov 2020 21:41:14 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E73226EF46;
        Mon,  9 Nov 2020 21:41:13 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
Date:   Mon, 09 Nov 2020 16:41:12 -0500
Message-ID: <86F25343-0860-44A2-BA40-CFB640147D50@redhat.com>
In-Reply-To: <20201107140325.281678-22-trondmy@kernel.org>
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
 <20201107140325.281678-22-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Nov 2020, at 9:03, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If the directory is changing, causing the page cache to get 
> invalidated
> while we are listing the contents, then the NFS client is currently 
> forced
> to read in the entire directory contents from scratch, because it 
> needs
> to perform a linear search for the readdir cookie. While this is not
> an issue for small directories, it does not scale to directories with
> millions of entries.
> In order to be able to deal with large directories that are changing,
> add a heuristic to ensure that if the page cache is empty, and we are
> searching for a cookie that is not the zero cookie, we just default to
> performing uncached readdir.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 238872d116f7..d7a9efd31ecd 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -917,11 +917,28 @@ static int find_and_lock_cache_page(struct 
> nfs_readdir_descriptor *desc)
>  	return res;
>  }
>
> +static bool nfs_readdir_dont_search_cache(struct 
> nfs_readdir_descriptor *desc)
> +{
> +	struct address_space *mapping = desc->file->f_mapping;
> +	struct inode *dir = file_inode(desc->file);
> +	unsigned int dtsize = NFS_SERVER(dir)->dtsize;
> +	loff_t size = i_size_read(dir);
> +
> +	/*
> +	 * Default to uncached readdir if the page cache is empty, and
> +	 * we're looking for a non-zero cookie in a large directory.
> +	 */
> +	return desc->dir_cookie != 0 && mapping->nrpages == 0 && size > 
> dtsize;

inode size > dtsize is a little hand-wavy.  We have a lot of customers 
trying to
reverse-engineer nfs_readdir() behavior instead of reading the code, 
this
is sure to drive them crazy.

That said, in the absence of an easy way to make it tunable, I don't 
have
anything better to suggest.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


> +}
> +
>  /* Search for desc->dir_cookie from the beginning of the page cache 
> */
>  static int readdir_search_pagecache(struct nfs_readdir_descriptor 
> *desc)
>  {
>  	int res;
>
> +	if (nfs_readdir_dont_search_cache(desc))
> +		return -EBADCOOKIE;
> +
>  	do {
>  		if (desc->page_index == 0) {
>  			desc->current_index = 0;
> -- 
> 2.28.0

