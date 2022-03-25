Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160544E6C3B
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 02:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbiCYBur (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 21:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbiCYBuq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 21:50:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF865406
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 18:49:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 895A3210F4;
        Fri, 25 Mar 2022 01:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648172951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wx0qIu9ySJlY3Psig10fHmn46QfAOeW8lCoFFHy1Wo=;
        b=unBvVjqSCvyb94UVY2weTAdYj/JA4lpHrumr/UuyQKr4D9pHSYoQ5ierWsAphEkIDOBcD9
        jAdWFeQJjiT3MZ8bE4HRYg1hpoGZIFzlBhU2wseZcVaJi8eUaqkfVTyCbRZMDj8TnCb1U3
        RWqYiG7yvaqNF/QBqmTuFKydYX4QNzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648172951;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wx0qIu9ySJlY3Psig10fHmn46QfAOeW8lCoFFHy1Wo=;
        b=l4vpKJdYiE9bntV1ayD4tpIwE//+1asXSJaHNnPhC5PNWiOfrhBHYtqDlc33p1KL/W7nd6
        olCLli0BvZdoWBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACAF51332D;
        Fri, 25 Mar 2022 01:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bFnGGZYfPWIadAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 25 Mar 2022 01:49:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 4/9] SUNRPC: Make the rpciod and xprtiod slab
 allocation modes consistent
In-reply-to: <20220322011618.1052288-5-trondmy@kernel.org>
References: <20220322011618.1052288-1-trondmy@kernel.org>,
 <20220322011618.1052288-2-trondmy@kernel.org>,
 <20220322011618.1052288-3-trondmy@kernel.org>,
 <20220322011618.1052288-4-trondmy@kernel.org>,
 <20220322011618.1052288-5-trondmy@kernel.org>
Date:   Fri, 25 Mar 2022 12:49:05 +1100
Message-id: <164817294549.6096.12941844979004220620@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 22 Mar 2022, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Make sure that rpciod and xprtiod are always using the same slab
> allocation modes.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
....
>  xs_stream_prepare_request(struct rpc_rqst *req)
>  {
>  	xdr_free_bvec(&req->rq_rcv_buf);
> -	req->rq_task->tk_status = xdr_alloc_bvec(&req->rq_rcv_buf, GFP_KERNEL);
> +	req->rq_task->tk_status = xdr_alloc_bvec(
> +		&req->rq_rcv_buf, GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
>  }

I did some testing of swap-over-NFS, and got a crash quite quickly, due
to this change.
The problem is that GFP_KERNEL allocations almost never fail.
Multi-page allocations might occasionally fail, and others might fail
for a process that has been killed by the OOM killer (or maybe just has
a fatal signal pending), but in general GFP_KERNEL is more likely to
wait (and wait and wait) than to fail.
So the failure paths haven't been tested.

xs_stream_prepare_request() is called from xprt_request_prepare(), which
is called from xprt_request_enqueue_receive() which is called in
call_encode() *after* ->tk_status has been tested.
So when the above code sets ->tk_status to -ENOMEM - which is now more
likely - that fact is ignored and we get a crash

[  298.911356] Workqueue: xprtiod xs_stream_data_receive_workfn
[  298.911696] RIP: 0010:_copy_to_iter+0x1cc/0x435
..
[  298.918259]  __skb_datagram_iter+0x64/0x225
[  298.918507]  skb_copy_datagram_iter+0xe9/0xf2
[  298.918767]  tcp_recvmsg_locked+0x653/0x77e
[  298.919015]  tcp_recvmsg+0x100/0x188
[  298.919226]  inet_recvmsg+0x5d/0x86
[  298.919431]  xs_read_stream_request.constprop.0+0x247/0x378
[  298.919754]  xs_read_stream.constprop.0+0x1c2/0x39b
[  298.920038]  xs_stream_data_receive_workfn+0x50/0x160
[  298.920331]  process_one_work+0x267/0x422
[  298.920568]  worker_thread+0x193/0x234

So we really need to audit all these places where we add __GFP_NORETRY
and ensure errors are actually handled.

For call_encode(), it might be easiest to move
	/* Add task to reply queue before transmission to avoid races */
	if (rpc_reply_expected(task))
		xprt_request_enqueue_receive(task);

up before the
	/* Did the encode result in an error condition? */
	if (task->tk_status != 0) {

and change it to

	/* Add task to reply queue before transmission to avoid races */
	if (task->tk_status == 0 && rpc_reply_expected(task))
		xprt_request_enqueue_receive(task);

I'll try a bit more testing and auditing.

Thanks,
NeilBrown
