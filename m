Return-Path: <linux-nfs+bounces-4140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271C391033A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 13:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE3B288EFA
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345951AB348;
	Thu, 20 Jun 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQoCaAVs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A978C9C
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883707; cv=none; b=ahizBrz8ENAX8wNhzHUL3MSh1hLr+uy1wQ2UONrGcSO5PhVuzF+aWVG2WT3jgEotLeWYcnpvPomujDpCN8BJbFccv3iwujN5FSuz7gWC8xjHYJmuyGwiSZkK91UX5kTVv/wEmlwEfMm6rJVVXT2Jm0BEHUXpZpQin42t3mGCACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883707; c=relaxed/simple;
	bh=/DH3VkUo70pVRpbuKVSUdgsRxedYFXVg9toaX7F9hkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vp/WSjB5/x9q1V2dBi8OfmPXQ4f50Ln8ESBrM+/hn9yRnRMNr5naq6hOaEpvpgD5UGesSpS5Zo/veF9F/P9PivVW3yCmDqY5iEvYkk0KGqpcOy7HcglkZUMIH5rvee3CBEw6XRWShK+Zj0qRHnqYtbsypsonE1ABgPJDI9lpRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQoCaAVs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718883703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa5IpTOfswXXE8D8T5SlCzSJ6g47KWqOw47t5Qs4G3c=;
	b=DQoCaAVsibuv+TMvOJcdgak1X8xp1YaUcbOuRkBpWMGCzih9a64iEhjCasCIjzu93lL7GD
	pK+imz9iHlmcaGnlm+FJb0pZR3nN5wUNlqX7dw7P4bwANKkP9aocZ+AR39+9X/PykuezG1
	LUYkjDkLqGOmhRBTCeFAMyQx3u1vRbs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-G-Xybg8DP2ac2bgbli6rUw-1; Thu,
 20 Jun 2024 07:41:39 -0400
X-MC-Unique: G-Xybg8DP2ac2bgbli6rUw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A696519560AB;
	Thu, 20 Jun 2024 11:41:36 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D143011D41;
	Thu, 20 Jun 2024 11:41:23 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: cel@kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2] SUNRPC: Fix backchannel reply, again
Date: Thu, 20 Jun 2024 07:41:21 -0400
Message-ID: <A10796EF-12E0-4F35-880B-24B5346916D2@redhat.com>
In-Reply-To: <20240619135107.176384-2-cel@kernel.org>
References: <20240619135107.176384-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 19 Jun 2024, at 9:51, cel@kernel.org wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> I still see "RPC: Could not send backchannel reply error: -110"
> quite often, along with slow-running tests. Debugging shows that the
> backchannel is still stumbling when it has to queue a callback reply
> on a busy transport.
>
> Note that every one of these timeouts causes a connection loss by
> virtue of the xprt_conditional_disconnect() call in that arm of
> call_cb_transmit_status().
>
> I found that setting to_maxval is necessary to get the RPC timeout
> logic to behave whenever to_exponential is not set.
>
> Fixes: 57331a59ac0d ("NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

That makes sense - I guess we were getting some random stack value in there?

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

> ---
>  net/sunrpc/svc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 965a27806bfd..e03f14024e47 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1588,9 +1588,11 @@ void svc_process(struct svc_rqst *rqstp)
>   */
>  void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
>  {
> +	struct rpc_timeout timeout = {
> +		.to_increment		= 0,
> +	};
>  	struct rpc_task *task;
>  	int proc_error;
> -	struct rpc_timeout timeout;
>
>  	/* Build the svc_rqst used by the common processing routine */
>  	rqstp->rq_xid = req->rq_xid;
> @@ -1643,6 +1645,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
>  		timeout.to_initval = req->rq_xprt->timeout->to_initval;
>  		timeout.to_retries = req->rq_xprt->timeout->to_retries;
>  	}
> +	timeout.to_maxval = timeout.to_initval;
>  	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
>  	task = rpc_run_bc_task(req, &timeout);
>
> -- 
> 2.45.1


