Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C64DA798
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 02:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353028AbiCPByY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 21:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353026AbiCPByX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 21:54:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CF5240AD
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 18:53:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 108031F385;
        Wed, 16 Mar 2022 01:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647395589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9MiOcmQ0Mbi5Z2CjN/Mg1ILd8felHOuwBH8oVYBsdOs=;
        b=tXN9kIr6QuBsv3X6FCcVD5Wl4XubfxJ0rMKW2kd25tG9i7hgD+eGBTyR3Gi4G1bFdECRfO
        QdFJLe04yfM2b62Q4qVznPygLjba1e4rp7hWgJBoKe+j/VeXQJsDTg9FfITkmvdNIvbcUI
        p6U2HgwQ1uIRGmbRZzCJsxl7VErN01M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647395589;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9MiOcmQ0Mbi5Z2CjN/Mg1ILd8felHOuwBH8oVYBsdOs=;
        b=iK3ZY64M/VORokNbvqn5znLerW+LUnCxa0Kd+SCQpx4hZpnx3cA9P3PydXty/EuGt1xEdV
        zABz4rJKphX1roCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38CBA13215;
        Wed, 16 Mar 2022 01:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OYYfOQNDMWJJcwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 16 Mar 2022 01:53:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Fix memory allocation in rpc_malloc()
In-reply-to: <20220315162052.570677-1-trondmy@kernel.org>
References: <20220315162052.570677-1-trondmy@kernel.org>
Date:   Wed, 16 Mar 2022 12:53:04 +1100
Message-id: <164739558440.9764.6759307849718646101@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 16 Mar 2022, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> When allocating memory, it should be safe to always use GFP_KERNEL,
> since both swap tasks and asynchronous tasks will regulate the
> allocation mode through the struct task flags.

'struct task_struct' flags can only enforce NOFS, NOIO, or MEMALLOC.
They cannot prevent waiting altogether.
We need rpciod task to not block waiting for memory.  If they all do,
then there will be no thread free to handle the replies to WRITE which
would allow swapped-out memory to be freed.

As the very least the rescuer thread mustn't block, so the use of
GFP_NOWAIT could depend on current_is_workqueue_rescuer().

Was there some problem you saw caused by the use of GFP_NOWAIT ??

Thanks,
NeilBrown

> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/sched.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 7c8f87ebdbc0..c62fcacf7366 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -1030,16 +1030,12 @@ int rpc_malloc(struct rpc_task *task)
>  	struct rpc_rqst *rqst = task->tk_rqstp;
>  	size_t size = rqst->rq_callsize + rqst->rq_rcvsize;
>  	struct rpc_buffer *buf;
> -	gfp_t gfp = GFP_KERNEL;
> -
> -	if (RPC_IS_ASYNC(task))
> -		gfp = GFP_NOWAIT | __GFP_NOWARN;
>  
>  	size += sizeof(struct rpc_buffer);
>  	if (size <= RPC_BUFFER_MAXSIZE)
> -		buf = mempool_alloc(rpc_buffer_mempool, gfp);
> +		buf = mempool_alloc(rpc_buffer_mempool, GFP_KERNEL);
>  	else
> -		buf = kmalloc(size, gfp);
> +		buf = kmalloc(size, GFP_KERNEL);
>  
>  	if (!buf)
>  		return -ENOMEM;
> -- 
> 2.35.1
> 
> 
