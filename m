Return-Path: <linux-nfs+bounces-21712-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML0XD7yvDGrdkwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21712-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:45:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25588583D69
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C751304FD2C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819236D9E9;
	Tue, 19 May 2026 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fieldses.org header.i=@fieldses.org header.b="LAoUTX6e";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="NgOzcCeB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C036D512
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216311; cv=none; b=Z4GVWu+m+70WAma9G5ZdRvUTzz6VGdiuUKAC0LBpyeJA1L2OrrQYDIAIVH+nT41FZeVa2cl3uC7KnVJxNIkimQpIWEA3uKzb5zbvNzz35+HqT66XZFmIsZw+4Q/9uX0PYDmPqokiX0V/xUFuh5o3nSv0OnTmtP4+MH53vv+nYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216311; c=relaxed/simple;
	bh=+SP7UdCajSixu2G7Fz6AUtaZg8z2eXdBC2GZrElzUBw=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=Dt/Mdg3jW6egcbViwfZeQueldtZ4ZLCGL3/JaShPP2H3kaeoLG8qRji8kJxT/kaF+wJu/0TqfSU3wn+erL8qgjEpDzygJC926TW/9EPN7d0VBkvSuoz/KALVIZr1UMRfxTGTX51EE8ZLG8QcINMiUQiiHYAVusYuJJ7lOYy0qTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org; spf=pass smtp.mailfrom=fieldses.org; dkim=pass (2048-bit key) header.d=fieldses.org header.i=@fieldses.org header.b=LAoUTX6e; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=NgOzcCeB; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fieldses.org
DKIM-Signature: a=rsa-sha256; b=LAoUTX6evzMD94CsyzLk2c3CrzqstoSGq8VlvWgwiudB15yX9W45n40pEHy3FOJ8iQ2aYaTCgLvg1noa1jD+gLJBlHtGajph3NtZm1CaKsA85pnnxfXQD3cWwT+zyVDwkfiM1T5yHd8nwKuaM4DNF3uURQCOAOgPDWl9X63ILnz/8INQNJuym/hSJkaKijkaCYQvF+swbWAtXSM5t9q0w+O725dudODgqfiDc2qAi74A4CP/1tu7A+FPZ8YeSipMPdnvT3/yZ9tomfG3LS04fEWY/M9cydz8uy6sLI6b/k+jfrP9ClqJ0NdaXCkYFzI0XjvnmSscjhzr4GZZDc30cw==; s=purelymail2; d=fieldses.org; v=1; bh=+SP7UdCajSixu2G7Fz6AUtaZg8z2eXdBC2GZrElzUBw=; h=Received:Received:Date:To:Subject:From;
DKIM-Signature: a=rsa-sha256; b=NgOzcCeBlKk88lNbGEAclv6HHBrsWQM7Xmj/Ji+n9NBZFas5tDqKHj+w+VifqZISS/hM0E/ieoCPnMVhxxl+nuOVCxsM+EFwvIcUrNYRQe7lCrprxBC+GWgas5WYAOF5lUobYz1szmt84kfaiklAJNgoBxrs41pQKdvvNKVog+G40+l98Ypg0mNevfet0/Jh/SE6AL5x5gpoBWwsmXmWRN4+ochKKEyl9Ihtmc4pADrTwqHe8mQiupnCNpgrApoTRx8JVX0LwYsT9I+nEH2GoPxrb3boEuYccMd/8n1vvZbFqnIu/CPj7s9+Lr5yHtVBH2UuI4kD/u8l4L0cEvk6Qg==; s=purelymail2; d=purelymail.com; v=1; bh=+SP7UdCajSixu2G7Fz6AUtaZg8z2eXdBC2GZrElzUBw=; h=Feedback-ID:Received:Received:Date:To:Subject:From;
Feedback-ID: 718849:37075:null:purelymail
X-Pm-Original-To: linux-nfs@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -606818446;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 19 May 2026 18:44:52 +0000 (UTC)
Received: by parkour.fieldses.org (Postfix, from userid 2815)
	id 2BE5822F012F; Tue, 19 May 2026 14:44:52 -0400 (EDT)
Date: Tue, 19 May 2026 14:44:52 -0400
To: Chris Mason <clm@meta.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@gmail.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: drain inflight callbacks in probe_callback_sync
Message-ID: <agyvpO10GIaWtziX@parkour.fieldses.org>
References: <20260519180032.1852793-2-clm@meta.com>
 <20260519180032.1852793-4-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519180032.1852793-4-clm@meta.com>
From: "J. Bruce Fields" <bfields@fieldses.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fieldses.org,reject];
	R_DKIM_ALLOW(-0.20)[fieldses.org:s=purelymail2,purelymail.com:s=purelymail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21712-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fieldses.org:+,purelymail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfields@fieldses.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[parkour.fieldses.org:mid,meta.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 25588583D69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:49:15AM -0700, Chris Mason wrote:
> nfsd4_destroy_session() calls nfsd4_probe_callback_sync() to quiesce
> the backchannel before nfsd4_put_session_locked() drops the last
> se_ref and frees the session. nfsd4_probe_callback_sync() only
> flushes cl_callback_wq, which drains the work_struct that submits
> CB RPCs but returns before the rpciod-side completion tail
> (rpc_call_done -> rpc_release -> nfsd41_destroy_cb) has run.

nfsd4_probe_callback_sync()->nfsd4_probe_callback() sets
NFSD4_CLIENT_CB_UPDATE and calls nfsd4_run_cb(), which should ensure
work is queued that will run nfsd4_run_cb_work and call
nfsd4_process_cb_update()->setup_callback_client(), which calls
rpc_shutdown_client()--and I *think* that isn't supposed to return until
any rpc callbacks have run?  And since that's called from the workqueue,
the flush should do it.

Maybe?  I may not have thought about this in 4 years, but you did cc me,
so if I'm raving, well, you get what you deserve....

--b.

> A CB
> RPC submitted just before teardown can therefore still be executing
> on rpciod, with clp->cl_cb_session pointing at the session about to
> be freed:
> 
>     CPU 0 (DESTROY_SESSION)              CPU 1 (rpciod)
>     -----                                -----
>     nfsd4_probe_callback_sync(clp)
>       flush_workqueue(cl_callback_wq)    nfsd4_cb_sequence_done()
>                                            reads clp->cl_cb_session
>     nfsd4_put_session_locked(ses)
>       free_session(ses)
>       kfree(ses)
>                                          nfsd41_destroy_cb()
>                                            dec cl_cb_inflight
> 
> The se_ref gate in nfsd4_put_session_locked() does not close this
> window: the backchannel dispatch path does not take a se_ref via
> nfsd4_get_session_locked(), so se_ref can already be zero while a
> CB RPC is still in flight against the session.
> 
> cl_cb_inflight, added by commit 2bbfed98a4d8 ("nfsd: Fix races
> between nfsd4_cb_release() and nfsd4_shutdown_callback()"), is the
> barrier that covers the full window: nfsd4_run_cb() bumps it before
> queue_work() and nfsd41_destroy_cb() drops it from rpc_release,
> after the last cl_cb_session dereference. nfsd4_shutdown_callback()
> already calls nfsd41_cb_inflight_wait_complete() after its
> flush_workqueue() for this reason; nfsd4_probe_callback_sync() was
> not updated when cl_cb_inflight was introduced.
> 
> Fix by waiting on cl_cb_inflight in nfsd4_probe_callback_sync()
> after the workqueue flush, so every queued CB RPC has reached its
> rpc_release before the caller proceeds to free the session.
> 
> Fixes: 2bbfed98a4d82ac4 ("nfsd: Fix races between nfsd4_cb_release() and nfsd4_shutdown_callback()")
> Assisted-by: kres (claude-opus-4-7)
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/nfsd/nfs4callback.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 8af2d0cc37c2..6cf5591651e4 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1246,6 +1246,7 @@ void nfsd4_probe_callback_sync(struct nfs4_client *clp)
>  {
>  	nfsd4_probe_callback(clp);
>  	flush_workqueue(clp->cl_callback_wq);
> +	nfsd41_cb_inflight_wait_complete(clp);
>  }
>  
>  void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
> -- 
> 2.52.0
> 

