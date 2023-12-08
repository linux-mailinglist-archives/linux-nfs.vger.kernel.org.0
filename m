Return-Path: <linux-nfs+bounces-472-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432A880ACA4
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 20:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B891C208EC
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C141C80;
	Fri,  8 Dec 2023 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtRzBnQj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D42E84
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 11:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702062486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMcGFasePBvzFgsjvrxP1IuuCfq1PJHsMXAvC4CYFCg=;
	b=HtRzBnQjrnz5KCaNotZvE/In1fa1RkrwSbNGjgPqv2MEfD4nLuV1a5t/2MJPnhV3efPJId
	+Psan7fRQEYan7gGzrmSpsRX+qKCT3ZojNO9efHEi5IO/FkjY4GIeJG487rB3GksAbSlIT
	3SGyZrfx3v98zSzFJvK3r0hmNs+ksl8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-N2Gh1fn3On2pHK-2KiP7ig-1; Fri,
 08 Dec 2023 14:08:05 -0500
X-MC-Unique: N2Gh1fn3On2pHK-2KiP7ig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22BFB1C068EC;
	Fri,  8 Dec 2023 19:08:05 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 80B5840C6EB9;
	Fri,  8 Dec 2023 19:08:04 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fixup v4.1 backchannel request timeouts
Date: Fri, 08 Dec 2023 14:08:03 -0500
Message-ID: <B2C32D9D-EA56-4886-90B3-17EE46DEEAA1@redhat.com>
In-Reply-To: <fbd98744da0c47e7830db6a753a27db541f07379.camel@hammerspace.com>
References: <d69074e4dc692ea7a9ccc866d8f87177539411e2.1702053194.git.bcodding@redhat.com>
 <fbd98744da0c47e7830db6a753a27db541f07379.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 8 Dec 2023, at 13:16, Trond Myklebust wrote:

> On Fri, 2023-12-08 at 11:33 -0500, Benjamin Coddington wrote:
>> After commit 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out
>> when on
>> the sending list"), any 4.1 backchannel tasks placed on the sending
>> queue
>> would immediately return with -ETIMEDOUT since their req timers are
>> zero.
>> We can fix this by keeping a copy of the rpc_clnt's timeout params on
>> the
>> transport and using them to properly setup the timeouts on the v4.1
>> backchannel tasks' req.
>>
>> Fixes: 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on
>> the sending list")
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  include/linux/sunrpc/xprt.h |  1 +
>>  net/sunrpc/clnt.c           |  3 +++
>>  net/sunrpc/xprt.c           | 15 +++++++++++++--
>>  3 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/sunrpc/xprt.h
>> b/include/linux/sunrpc/xprt.h
>> index f85d3a0daca2..7565902053f3 100644
>> --- a/include/linux/sunrpc/xprt.h
>> +++ b/include/linux/sunrpc/xprt.h
>> @@ -285,6 +285,7 @@ struct rpc_xprt {
>>  						 * items */
>>  	struct list_head	bc_pa_list;	/* List of
>> preallocated
>>  						 * backchannel
>> rpc_rqst's */
>> +	struct rpc_timeout	bc_timeout;	/* backchannel
>> timeout params */
>>  #endif /* CONFIG_SUNRPC_BACKCHANNEL */
>>  
>>  	struct rb_root		recv_queue;	/* Receive queue */
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index d6805c1268a7..5891757c88b1 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -279,6 +279,9 @@ static struct rpc_xprt
>> *rpc_clnt_set_transport(struct rpc_clnt *clnt,
>>  		clnt->cl_autobind = 1;
>>  
>>  	clnt->cl_timeout = timeout;
>> +#if defined(CONFIG_SUNRPC_BACKCHANNEL)
>> +	memcpy(&xprt->bc_timeout, timeout, sizeof(struct
>> rpc_timeout));
>> +#endif
>>  	rcu_assign_pointer(clnt->cl_xprt, xprt);
>>  	spin_unlock(&clnt->cl_lock);
>>  
>> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
>> index 92301e32cda4..d9cbe0814fd8 100644
>> --- a/net/sunrpc/xprt.c
>> +++ b/net/sunrpc/xprt.c
>> @@ -655,9 +655,14 @@ static unsigned long
>> xprt_abs_ktime_to_jiffies(ktime_t abstime)
>>  
>>  static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
>>  {
>> -	const struct rpc_timeout *to = req->rq_task->tk_client-
>>> cl_timeout;
>> +	const struct rpc_timeout *to;
>>  	unsigned long majortimeo = req->rq_timeout;
>>  
>> +	if (req->rq_task->tk_client)
>> +		to = req->rq_task->tk_client->cl_timeout;
>> +	else
>> +		to = &req->rq_xprt->bc_timeout;
>>
>
> If you're going to convert this function for generic use, then please
> pass the timeout 'to' as a function parameter rather than making
> assumptions here.

No problem, I'll send it, but we'll end needing to make the same assumption
calling xprt_reset_majortimeo() from xprt_adjust_timeout().

.. actually it looks like backchannel tasks never currently call
rpc_check_timeout(), so we could just send the rpc_client's rpc_timeout
there, but that looks like a potential future problem.  I'll send a v2 that
way and kick off my testing again.

I always thought that NULL tk_client was definitively backchannel.  Is there
a case you're worried about?

We can fix this another way, probably.  Looks like this fix won't actually
end up implementing normal timeout processing without adding
rpc_check_timeout() calls to the backchannel's tk_actions.

Ben


