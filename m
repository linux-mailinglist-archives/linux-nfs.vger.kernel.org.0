Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B675D030
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGUQ7c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 12:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGUQ7b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 12:59:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9010CB
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 09:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 028CA61D60
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 16:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60033C433C8;
        Fri, 21 Jul 2023 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689958769;
        bh=qiSJQVZ1YR4uqO8WrKw5FehG+Pj3oP7Gx28Yc/4VdhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJsn2Nmqm2EiEkCPuFRK1weQuhy93qkAzSrFWWcvP0ZI3l52qk7UwvrnOlkE9HJ8x
         KPw0P2/YQxWQrubKUUx4w3xT1gb2Gz6zl3nh10i4ZgZ227h909nPIaG6IvhSDjEVVk
         0XaTsK6FuopwHSRRr8wDo1SPpui8dTbD6H/lzqhRu5+1QvtX2Jox89CRscaPZ3LLvf
         ne7G8Db12p3NFVNnaV2EmnqF4RjOYTQreKqLn4eSb4k3xjIcLvtz+/bRNf7ovcFhVf
         Ng9QPOeC4Gcw04h0sGGMlDSvvSNF7bvMXLlXbMjvkUjEDFv9Tp0QnVe78ZzeF73x9y
         eGy4j7f+agfQA==
Date:   Fri, 21 Jul 2023 12:59:26 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, agruenba@redhat.com
Subject: Re: [RFC v6.5-rc2 1/3] fs: lockd: nlm_blocked list race fixes
Message-ID: <ZLq5bsR+vpPftY3h@manet.1015granger.net>
References: <20230720125806.1385279-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720125806.1385279-1-aahringo@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 20, 2023 at 08:58:04AM -0400, Alexander Aring wrote:
> This patch fixes races when lockd accessing the global nlm_blocked list.
> It was mostly safe to access the list because everything was accessed
> from the lockd kernel thread context but there exists cases like
> nlmsvc_grant_deferred() that could manipulate the nlm_blocked list and
> it can be called from any context.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

I agree with Jeff, this one looks fine to apply to nfsd-next. I've done
that so it can get test exposure while we consider 2/3 and 3/3.

I've dropped the "Cc: stable" tag -- since there is no specific bug
report this fix addresses, I will defer the decision about backporting
at least until we have some test experience.


> ---
>  fs/lockd/svclock.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index c43ccdf28ed9..28abec5c451d 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -131,12 +131,14 @@ static void nlmsvc_insert_block(struct nlm_block *block, unsigned long when)
>  static inline void
>  nlmsvc_remove_block(struct nlm_block *block)
>  {
> +	spin_lock(&nlm_blocked_lock);
>  	if (!list_empty(&block->b_list)) {
> -		spin_lock(&nlm_blocked_lock);
>  		list_del_init(&block->b_list);
>  		spin_unlock(&nlm_blocked_lock);
>  		nlmsvc_release_block(block);
> +		return;
>  	}
> +	spin_unlock(&nlm_blocked_lock);
>  }
>  
>  /*
> @@ -152,6 +154,7 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
>  				file, lock->fl.fl_pid,
>  				(long long)lock->fl.fl_start,
>  				(long long)lock->fl.fl_end, lock->fl.fl_type);
> +	spin_lock(&nlm_blocked_lock);
>  	list_for_each_entry(block, &nlm_blocked, b_list) {
>  		fl = &block->b_call->a_args.lock.fl;
>  		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
> @@ -161,9 +164,11 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
>  				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
>  		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
>  			kref_get(&block->b_count);
> +			spin_unlock(&nlm_blocked_lock);
>  			return block;
>  		}
>  	}
> +	spin_unlock(&nlm_blocked_lock);
>  
>  	return NULL;
>  }
> @@ -185,16 +190,19 @@ nlmsvc_find_block(struct nlm_cookie *cookie)
>  {
>  	struct nlm_block *block;
>  
> +	spin_lock(&nlm_blocked_lock);
>  	list_for_each_entry(block, &nlm_blocked, b_list) {
>  		if (nlm_cookie_match(&block->b_call->a_args.cookie,cookie))
>  			goto found;
>  	}
> +	spin_unlock(&nlm_blocked_lock);
>  
>  	return NULL;
>  
>  found:
>  	dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
>  	kref_get(&block->b_count);
> +	spin_unlock(&nlm_blocked_lock);
>  	return block;
>  }
>  
> @@ -317,6 +325,7 @@ void nlmsvc_traverse_blocks(struct nlm_host *host,
>  
>  restart:
>  	mutex_lock(&file->f_mutex);
> +	spin_lock(&nlm_blocked_lock);
>  	list_for_each_entry_safe(block, next, &file->f_blocks, b_flist) {
>  		if (!match(block->b_host, host))
>  			continue;
> @@ -325,11 +334,13 @@ void nlmsvc_traverse_blocks(struct nlm_host *host,
>  		if (list_empty(&block->b_list))
>  			continue;
>  		kref_get(&block->b_count);
> +		spin_unlock(&nlm_blocked_lock);
>  		mutex_unlock(&file->f_mutex);
>  		nlmsvc_unlink_block(block);
>  		nlmsvc_release_block(block);
>  		goto restart;
>  	}
> +	spin_unlock(&nlm_blocked_lock);
>  	mutex_unlock(&file->f_mutex);
>  }
>  
> -- 
> 2.31.1
> 
