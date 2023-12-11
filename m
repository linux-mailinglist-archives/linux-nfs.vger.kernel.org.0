Return-Path: <linux-nfs+bounces-479-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B64D80C911
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 13:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36182281F24
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8143A279;
	Mon, 11 Dec 2023 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyjNcadl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A89B
	for <linux-nfs@vger.kernel.org>; Mon, 11 Dec 2023 04:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702296599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnYm5KfX8lM8APHl62ZJ0088IHHtCECQow+H9/WQ9iE=;
	b=EyjNcadltUXyQUSjcZurdxE6QJV7UxkgS99QCD2nrWVkJvwq//4Xy6O/WC03yXz9gXti4D
	p1koHQ7ptOtnwH4xOv2sqjFcHaOm6yN2n1bDmnF5mXBawzMqWzGOzGE6OSEmQjPvjauI9w
	hoLVfhFmWV3GjkhrKGPxFf5igkAGKdY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-13hXbWqZNOChHpgE9jYzEg-1; Mon, 11 Dec 2023 07:09:56 -0500
X-MC-Unique: 13hXbWqZNOChHpgE9jYzEg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72FB6836F20;
	Mon, 11 Dec 2023 12:09:56 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-7.rdu2.redhat.com [10.22.0.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DDB09492BC6;
	Mon, 11 Dec 2023 12:09:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] SUNRPC: Fixup v4.1 backchannel request timeouts
Date: Mon, 11 Dec 2023 06:53:14 -0500
Message-ID: <35D8B8C5-C025-43CA-B06E-60CD44634AD7@redhat.com>
In-Reply-To: <089148135f43daaa77e4f83b199883c8b22c7b0f.camel@hammerspace.com>
References: <1bcb93ab5feefca853b95a1759da5b008c204092.1702063105.git.bcodding@redhat.com>
 <089148135f43daaa77e4f83b199883c8b22c7b0f.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 9 Dec 2023, at 4:55, Trond Myklebust wrote:

> On Fri, 2023-12-08 at 14:19 -0500, Benjamin Coddington wrote:
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
>>  net/sunrpc/xprt.c           | 23 ++++++++++++++---------
>>  3 files changed, 18 insertions(+), 9 deletions(-)
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
>
> Hmm... The xprt can and will be shared among a number of rpc_clnt
> instances. I therefore think we're better off doing this when we're
> setting up the back channel.

.. and it seems the timeouts could be different for each, so now I think
keeping a copy of the last rpc_clnt's timeouts on the xprt is wrong.

We could use the current timeouts from the nfs_client side after we
figure out which nfs_client that would be in nfs4_callback_compound().
Trouble is if we have to make a reply before getting that far there's
still no timeout set, but that's probably a rare case and could use the xprt
type defaults.

> i.e. probably doing it in nfs41_init_clientid() after we picked up the
> lease time (but before we mark the client as ready), and then doing it
> in nfs4_proc_bind_conn_to_session() if ever that gets called.
>
> Note that we have to set the bc_timeout on all xprts that could act as
> back channels, so you might want to use
> rpc_clnt_iterate_for_each_xprt().
> It might also be worth to look at Olga's trunking code, since I suspect
> we might need to do something there when adding a new xprt to the
> existing set.

Ben


