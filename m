Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F1754A70
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jul 2023 19:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGORVj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jul 2023 13:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGORVi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jul 2023 13:21:38 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Jul 2023 10:21:37 PDT
Received: from smtp.rcn.com (mail.rcn.syn-alias.com [129.213.13.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0532706
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 10:21:37 -0700 (PDT)
X-Authed-Username: dG10YWxwZXlAcmNuLmNvbQ==
Authentication-Results:  smtp01.rcn.email-ash1.sync.lan smtp.user=<hidden>; auth=pass (PLAIN)
Received: from [96.237.161.173] ([96.237.161.173:53335] helo=[192.168.0.206])
        by smtp.rcn.com (envelope-from <tom@talpey.com>)
        (ecelerity 4.4.0.19839 r(msys-ecelerity:tags/4.4.0.0^0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
        id AF/C5-05333-FE0D2B46; Sat, 15 Jul 2023 13:01:35 -0400
Message-ID: <a9f18064-45d4-4346-0156-dcd74e001b82@talpey.com>
Date:   Sat, 15 Jul 2023 13:01:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] xprtrdma: Remap Receive buffers after a reconnect
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, anna.schumaker@netapp.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, kolga@netapp.com
References: <168934757954.2781502.4228890662497418497.stgit@morisot.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <168934757954.2781502.4228890662497418497.stgit@morisot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgedviedrfeekgddutdelucetufdoteggodetrfdotffvucfrrhho
X-Vade-Analysis-2: fhhilhgvmecuufgjpfetvefqtfdptfevpfdpgffpggdqtfevpfdpqfgfvfenuceurghilhhouhhtmecu
X-Vade-Analysis-3: fedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgj
X-Vade-Analysis-4: tgfgsehtjeertddtfeejnecuhfhrohhmpefvohhmucfvrghlphgvhicuoehtohhmsehtrghlphgvhidr
X-Vade-Analysis-5: tghomheqnecuggftrfgrthhtvghrnhepudethfegfeejjeeghedtffegkedttdduueekleejhfduudek
X-Vade-Analysis-6: gfehuedvudfgudefnecukfhppeeliedrvdefjedrudeiuddrudejfeenucevlhhushhtvghrufhiiigv
X-Vade-Analysis-7: pedtnecurfgrrhgrmhepihhnvghtpeeliedrvdefjedrudeiuddrudejfedphhgvlhhopegludelvddr
X-Vade-Analysis-8: udeikedrtddrvddtiegnpdhmrghilhhfrhhomhepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthht
X-Vade-Analysis-9: oheptggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrrdhstghhuhhmrghkvghrsehn
X-Vade-Analysis-10: vghtrghpphdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
X-Vade-Analysis-11: rhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
X-Vade-Analysis-12: lhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhholhhgrges
X-Vade-Analysis-13: nhgvthgrphhprdgtohhmpdhmthgrhhhoshhtpehsmhhtphdtuddrrhgtnhdrvghmrghilhdqrghshhdu
X-Vade-Analysis-14: rdhshihntgdrlhgrnh
X-Vade-Client: RCN
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/14/2023 11:13 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On server-initiated disconnect, rpcrdma_xprt_disconnect() DMA-unmaps
> the transport's Receive buffers, but rpcrdma_post_recvs() neglected
> to remap them after a new connection had been established. The
> result is immediate failure of the new connection with the Receives
> flushing with LOCAL_PROT_ERR.

The fix is correct, my only comment is that the failure occurs when the
first message is received, and only the first CQE is a LOCAL_PROT_ERR.
The remainder of the posted receives are simply flushed.

Same result of course! The summary is ok as-is. Important fix.

Reviewed-by: Tom Talpey <tom@talpey.com>

> Fixes: 671c450b6fe0 ("xprtrdma: Fix oops in Receive handler after device removal")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/verbs.c |    9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> Hi Anna-
> 
> Can you apply this for 6.5-rc ?
> 
> 
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index b098fde373ab..28c0771c4e8c 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -935,9 +935,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
>   	if (!rep->rr_rdmabuf)
>   		goto out_free;
>   
> -	if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
> -		goto out_free_regbuf;
> -
>   	rep->rr_cid.ci_completion_id =
>   		atomic_inc_return(&r_xprt->rx_ep->re_completion_ids);
>   
> @@ -956,8 +953,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
>   	spin_unlock(&buf->rb_lock);
>   	return rep;
>   
> -out_free_regbuf:
> -	rpcrdma_regbuf_free(rep->rr_rdmabuf);
>   out_free:
>   	kfree(rep);
>   out:
> @@ -1363,6 +1358,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
>   			rep = rpcrdma_rep_create(r_xprt, temp);
>   		if (!rep)
>   			break;
> +		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
> +			rpcrdma_rep_put(buf, rep);
> +			break;
> +		}
>   
>   		rep->rr_cid.ci_queue_id = ep->re_attr.recv_cq->res.id;
>   		trace_xprtrdma_post_recv(rep);
> 
> 
> 
