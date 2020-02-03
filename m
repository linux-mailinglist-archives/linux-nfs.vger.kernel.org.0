Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2076B1511B7
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 22:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgBCVTY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 16:19:24 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34954 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCVTX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Feb 2020 16:19:23 -0500
Received: by mail-yw1-f65.google.com with SMTP id i190so15446312ywc.2
        for <linux-nfs@vger.kernel.org>; Mon, 03 Feb 2020 13:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Yz3OT0g6JgGUaiYQlLu8KW3O/aTYITbTyuu1+VD8kmk=;
        b=Ak8Ec1yv5nnVBNVXfVZphb3Tf8WxMLh+6pqrj8hgKGSmdC9SOVImyHwbsJnNKAMvE5
         VsWzXqjovKicD6l6VcbRVILOBEMhw4rg87wYuzgNaJoHJ1fWraE1XRnZT6qcbBWhuetA
         KF2lUUknfs6vGxsdIacl7QmYvycI+UA3Q5NT/Wli9Hm/Tk4bA58Bvz/G8WzCBG9hMKkI
         UNDDXJTF6URlK+q21ehSZZpf8IruSUXRXaqkSEZf5AqLltIO2WISQWAQBj5tTNUKCj6M
         rvqq7XbJniiIKDKfZsm8bzebBlf1usIfWFoYFjKS5Y3Jf1QfqP0XJH62+XxC6A9Kz0rR
         kMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Yz3OT0g6JgGUaiYQlLu8KW3O/aTYITbTyuu1+VD8kmk=;
        b=R26A95S5BQITJPC9DpzgHih55OgquPHfu4kaLw/nm7lkb5u5SegOiT91jsYtnHYrI8
         SmUq6BFhezTwQpn/Al/tbg0maC0O8c+19Dn0ZiuqX+EjVAzJxnlTYXfofhVoPI7QIzgL
         SotAFfctBlGorqOjql7hmlxIFkOCvpSrC24cDsJayVbagxILTMfY1VB6WVG0Lv32kL1h
         YngmTDkrslqss69P5YXqcCQS2hUXtWVn15BYXw4gs980orP27AZ0RQqRbJZm4AEnyTOn
         qVcGkraRmDBuXPHYixJpfxAnsCLqoBMEVctd/l+3fnsvfm8ebkF25m6uyTZX/jYUpddi
         eG5g==
X-Gm-Message-State: APjAAAUjZCCmHBWVWrfw1LxPsAf+r9yNcjlgeHWaGosZ8thq+jhlOVhY
        i1W9SESZsEQARxaiDH4oww==
X-Google-Smtp-Source: APXvYqzsMXH+p4mAPV3jE7L5I4IQUjahQwv/dLKaGuGWReJM6jEmvZZe3tKwVCvf/ugeEa105/2hdQ==
X-Received: by 2002:a81:98c7:: with SMTP id p190mr1741479ywg.200.1580764761737;
        Mon, 03 Feb 2020 13:19:21 -0800 (PST)
Received: from leira (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id m62sm8796097ywb.107.2020.02.03.13.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:19:21 -0800 (PST)
Message-ID: <beb3c648da7f641d34f9a1cbef5639ba014de6db.camel@gmail.com>
Subject: Re: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
From:   Trond Myklebust <trondmy@gmail.com>
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Date:   Mon, 03 Feb 2020 16:18:59 -0500
In-Reply-To: <16a7298dacd9fd1d08cd26b7073e9ced62c5fa24.camel@netapp.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
         <20200202225356.995080-2-trond.myklebust@hammerspace.com>
         <20200202225356.995080-3-trond.myklebust@hammerspace.com>
         <16a7298dacd9fd1d08cd26b7073e9ced62c5fa24.camel@netapp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-02-03 at 20:31 +0000, Schumaker, Anna wrote:
> Hi Trond,
> 
> On Sun, 2020-02-02 at 17:53 -0500, Trond Myklebust wrote:
> > When a NFS directory page cache page is removed from the page
> > cache,
> > its contents are freed through a call to nfs_readdir_clear_array().
> > To prevent the removal of the page cache entry until after we've
> > finished reading it, we must take the page lock.
> > 
> > Fixes: 11de3b11e08c ("NFS: Fix a memory leak in nfs_readdir")
> > Cc: stable@vger.kernel.org # v2.6.37+
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  fs/nfs/dir.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index ba0d55930e8a..90467b44ec13 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -705,8 +705,6 @@ int nfs_readdir_filler(void *data, struct page*
> > page)
> >  static
> >  void cache_page_release(nfs_readdir_descriptor_t *desc)
> >  {
> > -	if (!desc->page->mapping)
> > -		nfs_readdir_clear_array(desc->page);
> >  	put_page(desc->page);
> >  	desc->page = NULL;
> >  }
> > @@ -720,19 +718,28 @@ struct page
> > *get_cache_page(nfs_readdir_descriptor_t
> > *desc)
> >  
> >  /*
> >   * Returns 0 if desc->dir_cookie was found on page desc-
> > >page_index
> > + * and locks the page to prevent removal from the page cache.
> >   */
> >  static
> > -int find_cache_page(nfs_readdir_descriptor_t *desc)
> > +int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
> >  {
> >  	int res;
> >  
> >  	desc->page = get_cache_page(desc);
> >  	if (IS_ERR(desc->page))
> >  		return PTR_ERR(desc->page);
> > -
> > -	res = nfs_readdir_search_array(desc);
> > +	res = lock_page_killable(desc->page);
> >  	if (res != 0)
> > -		cache_page_release(desc);
> > +		goto error;
> > +	res = -EAGAIN;
> > +	if (desc->page->mapping != NULL) {
> > +		res = nfs_readdir_search_array(desc);
> > +		if (res == 0)
> > +			return 0;
> > +	}
> > +	unlock_page(desc->page);
> > +error:
> > +	cache_page_release(desc);
> >  	return res;
> >  }
> >  
> 
> Can you give me some guidance on how to apply this on top of Dai's v2
> patch from
> January 23? Right now I have the nfsi->page_index getting set before
> the
> unlock_page():

Since this needs to be a stable patch, it would be preferable to apply
them in the opposite order to avoid an extra dependency on Dai's patch.

That said, since the nfsi->page_index is not a per-page variable, there
is no need to put it under the page lock.


> @@ -732,15 +733,24 @@ int find_cache_page(nfs_readdir_descriptor_t
> *desc)
>  	if (IS_ERR(desc->page))
>  		return PTR_ERR(desc->page);
>  
> -	res = nfs_readdir_search_array(desc);
> +	res = lock_page_killable(desc->page);
>  	if (res != 0)
>  		cache_page_release(desc);
> +		goto error;
> +	res = -EAGAIN;
> +	if (desc->page->mapping != NULL) {
> +		res = nfs_readdir_search_array(desc);
> +		if (res == 0)
> +			return 0;
> +	}
>  
>  	dentry = file_dentry(desc->file);
>  	inode = d_inode(dentry);
>  	nfsi = NFS_I(inode);
>  	nfsi->page_index = desc->page_index;
> -
> +	unlock_page(desc->page);
> +error:
> +	cache_page_release(desc);
>  	return res;
>  }
>  
> 
> Please let me know if there is a better way to handle the conflict!
> 
> Anna
> 
> 
> > @@ -747,7 +754,7 @@ int
> > readdir_search_pagecache(nfs_readdir_descriptor_t
> > *desc)
> >  		desc->last_cookie = 0;
> >  	}
> >  	do {
> > -		res = find_cache_page(desc);
> > +		res = find_and_lock_cache_page(desc);
> >  	} while (res == -EAGAIN);
> >  	return res;
> >  }
> > @@ -786,7 +793,6 @@ int nfs_do_filldir(nfs_readdir_descriptor_t
> > *desc)
> >  		desc->eof = true;
> >  
> >  	kunmap(desc->page);
> > -	cache_page_release(desc);
> >  	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @
> > cookie %Lu;
> > returning = %d\n",
> >  			(unsigned long long)*desc->dir_cookie, res);
> >  	return res;
> > @@ -832,13 +838,13 @@ int uncached_readdir(nfs_readdir_descriptor_t
> > *desc)
> >  
> >  	status = nfs_do_filldir(desc);
> >  
> > + out_release:
> > +	nfs_readdir_clear_array(desc->page);
> > +	cache_page_release(desc);
> >   out:
> >  	dfprintk(DIRCACHE, "NFS: %s: returns %d\n",
> >  			__func__, status);
> >  	return status;
> > - out_release:
> > -	cache_page_release(desc);
> > -	goto out;
> >  }
> >  
> >  /* The file offset position represents the dirent entry number.  A
> > @@ -903,6 +909,8 @@ static int nfs_readdir(struct file *file,
> > struct
> > dir_context *ctx)
> >  			break;
> >  
> >  		res = nfs_do_filldir(desc);
> > +		unlock_page(desc->page);
> > +		cache_page_release(desc);
> >  		if (res < 0)
> >  			break;
> >  	} while (!desc->eof);

