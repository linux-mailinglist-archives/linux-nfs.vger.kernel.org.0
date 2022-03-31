Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03E44EDBC4
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbiCaOh5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 10:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiCaOh5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 10:37:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A8BD2E1
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 07:36:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9A11C210E3;
        Thu, 31 Mar 2022 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648737364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmTxuSg6o1y1B2uWtPz8DTm0n8k9Thb4PcxUv1nnegY=;
        b=IlmhqAgGNsMth6T4i99CLy1+uGchjjYQO2D5raNgmavo2pJqFgbDIXlYdV6S2P5dyKFJIu
        CF2oxy2kU8bmXeaU9julqm5gqdZTj7QM2o6AvktVqF5SgFy07qBBRs0w3ayONKGCFF/8FC
        O1SsuIQza5TaY6is0d1oDB0XmF/rxWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648737364;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmTxuSg6o1y1B2uWtPz8DTm0n8k9Thb4PcxUv1nnegY=;
        b=zaRXc3k0CSlsvdyxnKMbtFskde2rsiemBnVDU3MwVu07a/deCdOb73xdEFbUBVPCHGN+Xb
        7XTDtXUb8O370+Ag==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7B60BA3B96;
        Thu, 31 Mar 2022 14:36:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E576DA0610; Thu, 31 Mar 2022 16:36:01 +0200 (CEST)
Date:   Thu, 31 Mar 2022 16:36:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     trondmy@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: Fix a write performance regression
Message-ID: <20220331143601.3dz56btaa5h63tu3@quack3.lan>
References: <20220331135402.7187-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331135402.7187-1-trondmy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu 31-03-22 09:54:01, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The call to filemap_flush() in nfsd_file_put() is there to ensure that
> we clear out any writes belonging to a NFSv3 client relatively quickly
> and avoid situations where the file can't be evicted by the garbage
> collector. It also ensures that we detect write errors quickly.
> 
> The problem is this causes a regression in performance for some
> workloads.
> 
> So try to improve matters by deferring writeback until we're ready to
> close the file, and need to detect errors so that we can force the
> client to resend.
> 
> Tested-by: Jan Kara <jack@suse.cz>
> Fixes: b6669305d35a ("nfsd: Reduce the number of calls to nfsd_file_gc()")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Perphaps you could add:

Link: https://lore.kernel.org/all/20220330103457.r4xrhy2d6nhtouzk@quack3.lan

To make life of Thorsten Leemhuis doing regression tracking simpler :) (I
think his automation will close the regression once it sees a patch like
that merged).

								Honza

> ---
>  fs/nfsd/filecache.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8bc807c5fea4..9578a6317709 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -235,6 +235,13 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
>  	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
>  }
>  
> +static void
> +nfsd_file_flush(struct nfsd_file *nf)
> +{
> +	if (nf->nf_file && vfs_fsync(nf->nf_file, 1) != 0)
> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> +}
> +
>  static void
>  nfsd_file_do_unhash(struct nfsd_file *nf)
>  {
> @@ -302,11 +309,14 @@ nfsd_file_put(struct nfsd_file *nf)
>  		return;
>  	}
>  
> -	filemap_flush(nf->nf_file->f_mapping);
>  	is_hashed = test_bit(NFSD_FILE_HASHED, &nf->nf_flags) != 0;
> -	nfsd_file_put_noref(nf);
> -	if (is_hashed)
> +	if (!is_hashed) {
> +		nfsd_file_flush(nf);
> +		nfsd_file_put_noref(nf);
> +	} else {
> +		nfsd_file_put_noref(nf);
>  		nfsd_file_schedule_laundrette();
> +	}
>  	if (atomic_long_read(&nfsd_filecache_count) >= NFSD_FILE_LRU_LIMIT)
>  		nfsd_file_gc();
>  }
> @@ -327,6 +337,7 @@ nfsd_file_dispose_list(struct list_head *dispose)
>  	while(!list_empty(dispose)) {
>  		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
>  		list_del(&nf->nf_lru);
> +		nfsd_file_flush(nf);
>  		nfsd_file_put_noref(nf);
>  	}
>  }
> @@ -340,6 +351,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispose)
>  	while(!list_empty(dispose)) {
>  		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
>  		list_del(&nf->nf_lru);
> +		nfsd_file_flush(nf);
>  		if (!refcount_dec_and_test(&nf->nf_ref))
>  			continue;
>  		if (nfsd_file_free(nf))
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
