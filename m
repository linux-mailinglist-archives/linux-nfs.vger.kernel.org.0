Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 667016178F
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2019 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfGGVB2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jul 2019 17:01:28 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:54734 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfGGVB2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Jul 2019 17:01:28 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id A98E0E00F8
        for <linux-nfs@vger.kernel.org>; Sun,  7 Jul 2019 23:01:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de A98E0E00F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1562533285; bh=mLOV8/oo6j7Uj9PJetr7ntZVMTvEPZQ4KmW2pr1SzXY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EkcGfx6ljcBcmDVadqOl2XJJY/f15KF/4PulXh2XStL38zeOge/3U7hCBQ4mFuia3
         S90+R8tEUbdEJVGS6JNJ3oCLwH50r6ZGIR/8ZdMd+huBLAAk+ksqMPVMde/jHa9fVG
         ubORLXmrNjJIC7nN7wG2ixMaBpLtpvhu4O8GKiYE=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id A3B39120261;
        Sun,  7 Jul 2019 23:01:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 6F37B8003E;
        Sun,  7 Jul 2019 23:01:25 +0200 (CEST)
Date:   Sun, 7 Jul 2019 23:01:25 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        zhangliguang <zhangliguang@linux.alibaba.com>
Message-ID: <1898309819.16314811.1562533285002.JavaMail.zimbra@desy.de>
In-Reply-To: <20190706185252.32488-1-trond.myklebust@hammerspace.com>
References: <20190706185252.32488-1-trond.myklebust@hammerspace.com>
Subject: Re: [PATCH 1/3] NFS: Fix off-by-one errors in nfs_readdir
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF67 (Mac)/8.8.10_GA_3786)
Thread-Topic: Fix off-by-one errors in nfs_readdir
Thread-Index: kHsoMNekwoYHRgxh4LX2umOu2vzwxQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Hi Trond,

Unfortunately, this change doesn't fix another issue introduced 
with be4c2d4723a4: en extra READDIR request after server have sent
all entries and indicated it with eol=true:

https://www.spinics.net/lists/linux-nfs/msg73399.html

Tigran.

----- Original Message -----
> From: "Trond Myklebust" <trondmy@gmail.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Cc: "zhangliguang" <zhangliguang@linux.alibaba.com>
> Sent: Saturday, July 6, 2019 8:52:50 PM
> Subject: [PATCH 1/3] NFS: Fix off-by-one errors in nfs_readdir

> In C, the array size and the maximum index are not the same. In this
> case, the field desc->pvec.nr is being used as a cursor but is
> occasionally being treated as if it the array size.
> This patch renames it to desc->pvec.cursor in order to make clear that
> it is tracking an index.
> 
> Fixes: be4c2d4723a4 ("NFS: readdirplus optimization by cache mechanism")
> Cc: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Cc: stable@vger.kernel.org # v5.1+
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfs/dir.c | 53 +++++++++++++++++++++++++---------------------------
> 1 file changed, 25 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 57b6a45576ad..e44f3c9fad5b 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -134,14 +134,14 @@ struct nfs_cache_array_entry {
> };
> 
> struct nfs_cache_array {
> -	int size;
> -	int eof_index;
> 	u64 last_cookie;
> +	unsigned int size;
> +	bool eof;
> 	struct nfs_cache_array_entry array[0];
> };
> 
> struct readdirvec {
> -	unsigned long nr;
> +	unsigned long cursor;
> 	unsigned long index;
> 	struct page *pages[NFS_MAX_READDIR_RAPAGES];
> };
> @@ -172,7 +172,7 @@ static
> void nfs_readdir_clear_array(struct page *page)
> {
> 	struct nfs_cache_array *array;
> -	int i;
> +	unsigned int i;
> 
> 	array = kmap_atomic(page);
> 	for (i = 0; i < array->size; i++)
> @@ -224,7 +224,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct
> page *page)
> 	array->last_cookie = entry->cookie;
> 	array->size++;
> 	if (entry->eof != 0)
> -		array->eof_index = array->size;
> +		array->eof = true;
> out:
> 	kunmap(page);
> 	return ret;
> @@ -239,7 +239,7 @@ int nfs_readdir_search_for_pos(struct nfs_cache_array
> *array, nfs_readdir_descri
> 	if (diff < 0)
> 		goto out_eof;
> 	if (diff >= array->size) {
> -		if (array->eof_index >= 0)
> +		if (array->eof)
> 			goto out_eof;
> 		return -EAGAIN;
> 	}
> @@ -265,7 +265,7 @@ nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
> static
> int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
> nfs_readdir_descriptor_t *desc)
> {
> -	int i;
> +	unsigned int i;
> 	loff_t new_pos;
> 	int status = -EAGAIN;
> 
> @@ -300,7 +300,7 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array
> *array, nfs_readdir_des
> 			return 0;
> 		}
> 	}
> -	if (array->eof_index >= 0) {
> +	if (array->eof) {
> 		status = -EBADCOOKIE;
> 		if (*desc->dir_cookie == array->last_cookie)
> 			desc->eof = true;
> @@ -532,10 +532,9 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc,
> struct nfs_entry *en
> 	struct nfs_cache_array *array;
> 	unsigned int count = 0;
> 	int status;
> -	int max_rapages = NFS_MAX_READDIR_RAPAGES;
> 
> 	desc->pvec.index = desc->page_index;
> -	desc->pvec.nr = 0;
> +	desc->pvec.cursor = 0;
> 
> 	scratch = alloc_page(GFP_KERNEL);
> 	if (scratch == NULL)
> @@ -560,12 +559,12 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t
> *desc, struct nfs_entry *en
> 		if (desc->plus)
> 			nfs_prime_dcache(file_dentry(desc->file), entry);
> 
> -		status = nfs_readdir_add_to_array(entry, desc->pvec.pages[desc->pvec.nr]);
> +		status = nfs_readdir_add_to_array(entry,
> desc->pvec.pages[desc->pvec.cursor]);
> 		if (status == -ENOSPC) {
> -			desc->pvec.nr++;
> -			if (desc->pvec.nr == max_rapages)
> +			if (desc->pvec.cursor == ARRAY_SIZE(desc->pvec.pages) - 1)
> 				break;
> -			status = nfs_readdir_add_to_array(entry, desc->pvec.pages[desc->pvec.nr]);
> +			desc->pvec.cursor++;
> +			status = nfs_readdir_add_to_array(entry,
> desc->pvec.pages[desc->pvec.cursor]);
> 		}
> 		if (status != 0)
> 			break;
> @@ -579,8 +578,8 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc,
> struct nfs_entry *en
> 
> out_nopages:
> 	if (count == 0 || (status == -EBADCOOKIE && entry->eof != 0)) {
> -		array = kmap_atomic(desc->pvec.pages[desc->pvec.nr]);
> -		array->eof_index = array->size;
> +		array = kmap_atomic(desc->pvec.pages[desc->pvec.cursor]);
> +		array->eof = true;
> 		status = 0;
> 		kunmap_atomic(array);
> 	}
> @@ -588,11 +587,11 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t
> *desc, struct nfs_entry *en
> 	put_page(scratch);
> 
> 	/*
> -	 * desc->pvec.nr > 0 means at least one page was completely filled,
> +	 * desc->pvec.cursor > 0 means at least one page was completely filled,
> 	 * we should return -ENOSPC. Otherwise function
> 	 * nfs_readdir_xdr_to_array will enter infinite loop.
> 	 */
> -	if (desc->pvec.nr > 0)
> +	if (desc->pvec.cursor > 0)
> 		return -ENOSPC;
> 	return status;
> }
> @@ -634,13 +633,12 @@ static
> void nfs_readdir_rapages_init(nfs_readdir_descriptor_t *desc)
> {
> 	struct nfs_cache_array *array;
> -	int max_rapages = NFS_MAX_READDIR_RAPAGES;
> -	int index;
> +	unsigned int max_rapages = NFS_MAX_READDIR_RAPAGES;
> +	unsigned int index;
> 
> 	for (index = 0; index < max_rapages; index++) {
> 		array = kmap_atomic(desc->pvec.pages[index]);
> 		memset(array, 0, sizeof(struct nfs_cache_array));
> -		array->eof_index = -1;
> 		kunmap_atomic(array);
> 	}
> }
> @@ -678,7 +676,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc,
> struct page *page,
> 
> 	array = kmap(page);
> 	memset(array, 0, sizeof(struct nfs_cache_array));
> -	array->eof_index = -1;
> 
> 	status = nfs_readdir_alloc_pages(pages, array_size);
> 	if (status < 0)
> @@ -696,7 +693,7 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc,
> struct page *page,
> 				status = 0;
> 			break;
> 		}
> -	} while (array->eof_index < 0);
> +	} while (!array->eof);
> 
> 	nfs_readdir_free_pages(pages, array_size);
> out_release_array:
> @@ -723,10 +720,10 @@ int nfs_readdir_filler(void *data, struct page* page)
> 
> 	/*
> 	 * If desc->page_index in range desc->pvec.index and
> -	 * desc->pvec.index + desc->pvec.nr, we get readdir cache hit.
> +	 * desc->pvec.index + desc->pvec.cursor, we get readdir cache hit.
> 	 */
> 	if (desc->page_index >= desc->pvec.index &&
> -		desc->page_index < (desc->pvec.index + desc->pvec.nr)) {
> +		desc->page_index <= (desc->pvec.index + desc->pvec.cursor)) {
> 		/*
> 		 * page and desc->pvec.pages[x] are valid, don't need to check
> 		 * whether or not to be NULL.
> @@ -809,7 +806,7 @@ static
> int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
> {
> 	struct file	*file = desc->file;
> -	int i = 0;
> +	unsigned int i = 0;
> 	int res = 0;
> 	struct nfs_cache_array *array = NULL;
> 	struct nfs_open_dir_context *ctx = file->private_data;
> @@ -832,7 +829,7 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
> 		if (ctx->duped != 0)
> 			ctx->duped = 1;
> 	}
> -	if (array->eof_index >= 0)
> +	if (array->eof)
> 		desc->eof = true;
> 
> 	kunmap(desc->page);
> @@ -903,7 +900,7 @@ static int nfs_readdir(struct file *file, struct dir_context
> *ctx)
> 			*desc = &my_desc;
> 	struct nfs_open_dir_context *dir_ctx = file->private_data;
> 	int res = 0;
> -	int max_rapages = NFS_MAX_READDIR_RAPAGES;
> +	unsigned int max_rapages = NFS_MAX_READDIR_RAPAGES;
> 
> 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
> 			file, (long long)ctx->pos);
> --
> 2.21.0
