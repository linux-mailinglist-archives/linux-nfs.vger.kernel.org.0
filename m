Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D874C3073
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 16:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiBXPyQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 10:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiBXPyP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 10:54:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ECF916DADC
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 07:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645718024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTtRTgaTWjdBr5BQelwxfuEZ3dA6eZVrqE8Rtjf1wQc=;
        b=QFT9t56yQ0Dn55MCyfUDTLiQOoPB/ovlfI5zmkeeRlZ1W5QzKglhfM6sczEHB4pagjMHch
        8IohhAHBvg0nUM3EvwIVi7wl+s3waM/s/+IDz1EJtx6JNo05dlC1j21pkz4GolhB7nON8L
        qItH+FHeZV/ZtkTt9gjagIcGq8EqRAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-G2mD_BUpPnWvjTA_XdNoFA-1; Thu, 24 Feb 2022 10:53:41 -0500
X-MC-Unique: G2mD_BUpPnWvjTA_XdNoFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EECB751AE;
        Thu, 24 Feb 2022 15:53:39 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9998783796;
        Thu, 24 Feb 2022 15:53:39 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 16/21] NFS: Add basic readdir tracing
Date:   Thu, 24 Feb 2022 10:53:38 -0500
Message-ID: <27661489-682E-427D-8644-6F768AC6C4E0@redhat.com>
In-Reply-To: <20220223211305.296816-17-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org>
 <20220223211305.296816-8-trondmy@kernel.org>
 <20220223211305.296816-9-trondmy@kernel.org>
 <20220223211305.296816-10-trondmy@kernel.org>
 <20220223211305.296816-11-trondmy@kernel.org>
 <20220223211305.296816-12-trondmy@kernel.org>
 <20220223211305.296816-13-trondmy@kernel.org>
 <20220223211305.296816-14-trondmy@kernel.org>
 <20220223211305.296816-15-trondmy@kernel.org>
 <20220223211305.296816-16-trondmy@kernel.org>
 <20220223211305.296816-17-trondmy@kernel.org>
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

On 23 Feb 2022, at 16:13, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Add tracing to track how often the client goes to the server for 
> updated
> readdir information.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c      | 13 ++++++++-
>  fs/nfs/nfstrace.h | 68 
> +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 54f0d37485d5..41e2d02d8611 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -969,10 +969,14 @@ static int find_and_lock_cache_page(struct 
> nfs_readdir_descriptor *desc)
>  		return -ENOMEM;
>  	if (nfs_readdir_page_needs_filling(desc->page)) {
>  		desc->page_index_max = desc->page_index;
> +		trace_nfs_readdir_cache_fill(desc->file, nfsi->cookieverf,
> +					     desc->last_cookie,
> +					     desc->page_index, desc->dtsize);
>  		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
>  					       &desc->page, 1);
>  		if (res < 0) {
>  			nfs_readdir_page_unlock_and_put_cached(desc);
> +			trace_nfs_readdir_cache_fill_done(inode, res);
>  			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
>  				invalidate_inode_pages2(desc->file->f_mapping);
>  				desc->page_index = 0;
> @@ -1090,7 +1094,14 @@ static int uncached_readdir(struct 
> nfs_readdir_descriptor *desc)
>  	desc->duped = 0;
>  	desc->page_index_max = 0;
>
> +	trace_nfs_readdir_uncached(desc->file, desc->verf, 
> desc->last_cookie,
> +				   -1, desc->dtsize);
> +
>  	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, 
> sz);
> +	if (status < 0) {
> +		trace_nfs_readdir_uncached_done(file_inode(desc->file), status);
> +		goto out_free;
> +	}
>
>  	for (i = 0; !desc->eob && i < sz && arrays[i]; i++) {
>  		desc->page = arrays[i];
> @@ -1109,7 +1120,7 @@ static int uncached_readdir(struct 
> nfs_readdir_descriptor *desc)
>  			 i < (desc->page_index_max >> 1))
>  			nfs_shrink_dtsize(desc);
>  	}
> -
> +out_free:
>  	for (i = 0; i < sz && arrays[i]; i++)
>  		nfs_readdir_page_array_free(arrays[i]);
>  out:
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 3672f6703ee7..c2d0543ecb2d 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -160,6 +160,8 @@ DEFINE_NFS_INODE_EVENT(nfs_fsync_enter);
>  DEFINE_NFS_INODE_EVENT_DONE(nfs_fsync_exit);
>  DEFINE_NFS_INODE_EVENT(nfs_access_enter);
>  DEFINE_NFS_INODE_EVENT_DONE(nfs_set_cache_invalid);
> +DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_cache_fill_done);
> +DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_uncached_done);
>
>  TRACE_EVENT(nfs_access_exit,
>  		TP_PROTO(
> @@ -271,6 +273,72 @@ DEFINE_NFS_UPDATE_SIZE_EVENT(wcc);
>  DEFINE_NFS_UPDATE_SIZE_EVENT(update);
>  DEFINE_NFS_UPDATE_SIZE_EVENT(grow);
>
> +DECLARE_EVENT_CLASS(nfs_readdir_event,
> +		TP_PROTO(
> +			const struct file *file,
> +			const __be32 *verifier,
> +			u64 cookie,
> +			pgoff_t page_index,
> +			unsigned int dtsize
> +		),
> +
> +		TP_ARGS(file, verifier, cookie, page_index, dtsize),
> +
> +		TP_STRUCT__entry(
> +			__field(dev_t, dev)
> +			__field(u32, fhandle)
> +			__field(u64, fileid)
> +			__field(u64, version)
> +			__array(char, verifier, NFS4_VERIFIER_SIZE)
> +			__field(u64, cookie)
> +			__field(pgoff_t, index)
> +			__field(unsigned int, dtsize)


I'd like to be able to see the change_attr too, whether or not it's the
cache_change_attribute or i_version.

Ben

