Return-Path: <linux-nfs+bounces-22240-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2m9FJcxfIGpJ2AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22240-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 19:09:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A9563A0CA
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 19:09:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z6Yffx6i;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22240-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22240-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F8E0313A663
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783483DA5B4;
	Wed,  3 Jun 2026 16:40:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E53E5ED1
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 16:40:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504812; cv=none; b=l8BeMIcFz09C/Kf5JTYI2UbCMnNmZvokaPlyW0Jhw4rfmALqLDY/WeOq3SpAW2dCN1Ae2CruVn02t2TvG6RLm/8+4RRZlTYX9KrIJYLwwVHEHEA/8KrRtrLfvI79sI1JSQWSgGmmQsPXZPZS70pCeLQDY4PcFrXNEiizGlosUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504812; c=relaxed/simple;
	bh=CpSZGGK0VATJN4vSVlL2OgNVRWwHZn3P+ajOSGcwUi8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cTJcG7hvuv8rdpBSWQYev8Un6J1F77F86PmFwDVUQdrjCtdqVrJwlhbH5lseKZkS0QZZfIyvkmTUpfYKUaS4QscqSK5mQb73vw4i+Ct5NHbeQPFMrJvuetPkxxBtBTRtTh5UMymFAeQhfAwJv8OoQQ0oWU+ulxOhBRdnpuH55jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6Yffx6i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C543D1F00899;
	Wed,  3 Jun 2026 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504810;
	bh=hqEEPjMUPH5As2Soj3gzCMcUfh09/9eavtH6qo6pItc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Z6Yffx6iEQOKLKQvEZ5GjhPRHm7/8I8vNgb7TI0n4RdRJ0HHh/ejxTYcHSp/gRL2+
	 m2VlrtF/iZS9P7+OIJpOAJi5OvAcD7papYPzITCpG6o2JpDIADkD43OMw0+SGGhx9a
	 Yp7S57AI1dhHjGbD70Gh5PtGs7s/sZELn3DnAFAVlaI85tl3/n1+FUTALDo6dym5M8
	 aCQmkAJYzv8akKvcHwb5HqegiwLEZN2hncrDHjSOhbPGCU+bEgBoPUfklkpiRiKfbL
	 vMoPTteJRC2z1WY2BQnH+J/dyagcgPY5DtCLjrzGTT0Zxo1B2YPtr+m7rcBQ69ZzPp
	 pjhrB3aNvtKYA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id F39D1F40082;
	Wed,  3 Jun 2026 12:40:08 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 12:40:08 -0400
X-ME-Sender: <xms:6FggagtmgxZRgedAF3jvJx3m6DGLixpEDo4K3dV60SzOY0plWZl6-w>
    <xme:6FggaoQoUxva55wyEbhcOIlVxKYq3iDe6AEMmDMzhT14IaI0W41DL8IieldZTPCmR
    WweiqLq6q19ojArCUWSdJeGB1juvtctjY2QneXVKzObEiJtFInxOGkj>
X-ME-Proxy-Cause: dmFkZTGbTO7WNxjA2FpfC6POsTtA2unXAOZq2Y2jVmExRizgvdJJVMY5M++IrcJ5kvptAy
    iqhHH1cYEa2XVa+RM/VQYKc5ybiwJWKkLRY0jVz/Evum6JxRTG0DrbavYiSNsCOohgpUZr
    0iPOtvr4cLBgBPp1m54fRKXVqHK+LcVPlx6I4vm34IYHzkpz155wEFZkG/EZrCFWc7dDsM
    yId7qFg368Nk4zi9W6WJF6icUIk7utpBVNkOhm98lv4mbB33SnrON1uNDOUDS+IfDnG+Sn
    vo2oKLayeXMQyAKIf796ntmC0iLkIENI/n8zN00SGDzsYNobckAJ4JdTIN9ReNVTLsMamW
    U61l+mfBwcOflUNWVvxQZrqtk1r1hrHAXXAysNZal6oi1JC8lxqTH5RpbwMm8bZD4Fld81
    sHRZx+Fv8ZABtV7mPnePVee5nWLqBe3TR1Gi76CeL+JKYP7sVWsOLzWkmjHE553f5Us/mz
    I01kcxhzyjN3SRGGUZes6DPC/XGDFqR2yx0JByXRDrSkXIpWVkVu0FAedtyFrcGB12oFjn
    lbgZ7fAcj6+Ku4shUuilUhwwvtxanH6mz58IVPNL3yAIQWM9vFP97xTYa3GL+nS1amhAyo
    lppdS41dc5r9sgvpNIylNS7xIVhylFtFgxXtAbTleinIXnz8D0nFPLA96HQQ
X-ME-Proxy: <xmx:6FggaqUC_0540ShL1hkA_tb7E67yCWaWCTKoZ-a4lbzomlxpw0XseQ>
    <xmx:6Fggagq-XZcBFiX_nBgOV92JlWVs2_Ui-K7bTGm_YS1J7GNgAqT9kw>
    <xmx:6FggauRBufywofCMDZz2Y6HsmhelP7qKijIOtnU7r7xStvPgoy_K-w>
    <xmx:6Fggai3hrBDsDVCGlc1XHJEORxxOhhOoTccve_qNX-n9lPVGrYvQgA>
    <xmx:6FggaiAM85oANKzilmPhpIUwhCqJYk9szqUPsR_r39Fuyqkj8nLMNJ7Q>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D1578B6006E; Wed,  3 Jun 2026 12:40:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMt2VjRfuerg
Date: Wed, 03 Jun 2026 12:39:47 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Pranjal Shrivastava" <praan@google.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Shivaji Kant" <shivajikant@google.com>
Message-Id: <9cd182d7-8f31-499d-aeec-33bf86271fa6@app.fastmail.com>
In-Reply-To: <20260603053033.3300318-2-praan@google.com>
References: <20260603053033.3300318-1-praan@google.com>
 <20260603053033.3300318-2-praan@google.com>
Subject: Re: [PATCH v1 1/7] nfs: make nfs_page pin-aware
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-22240-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:praan@google.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3A9563A0CA

Hi Pranjal,

On Wed, Jun 3, 2026, at 1:30 AM, Pranjal Shrivastava wrote:
> Modernizing the NFS Direct I/O path to use iov_iter_extract_pages()
> introduces page pinning (GUP) instead of standard page referencing.
> To handle this correctly, nfs_page must track whether it holds a
> pin or a standard reference.
>
> Introduce a new flag, PG_PINNED, to struct nfs_page. Update the creation
> path (nfs_page_create_from_page and nfs_page_create_from_folio) to
> accept a pinned bool and set the flag accordingly. If the page is pinned,
> we skip the existing reference increment (get_page/folio_get) as the pin
> itself acts as a reference.
>
> Update nfs_clear_request() & nfs_direct_release_pages() to use
> unpin_user_page() or unpin_user_folio() instead of only refcount
> decrement (put_page) when PG_PINNED flag is set. Finally, ensure
> subrequests inherit the pinning status from their parent request.
>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  fs/nfs/direct.c          | 22 +++++++++++++++-------
>  fs/nfs/pagelist.c        | 36 ++++++++++++++++++++++++++----------
>  fs/nfs/read.c            |  2 +-
>  fs/nfs/write.c           |  2 +-
>  include/linux/nfs_page.h |  3 +++
>  5 files changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 48d89716193a..80319c5eeed4 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -165,11 +165,17 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
>  	return 0;
>  }
> 
> -static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
> +static void nfs_direct_release_pages(struct page **pages, unsigned int npages,
> +				     bool pinned)
>  {
>  	unsigned int i;
> -	for (i = 0; i < npages; i++)
> -		put_page(pages[i]);
> +
> +	if (pinned) {
> +		unpin_user_pages(pages, npages);
> +	} else {
> +		for (i = 0; i < npages; i++)
> +			put_page(pages[i]);
> +	}
>  }
> 
>  void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
> @@ -371,7 +377,8 @@ static ssize_t 
> nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
>  			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
>  			/* XXX do we need to do the eof zeroing found in async_filler? */
>  			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
> -							pgbase, pos, req_len);
> +							false, pgbase, pos,
> +							req_len);
>  			if (IS_ERR(req)) {
>  				result = PTR_ERR(req);
>  				break;
> @@ -386,7 +393,7 @@ static ssize_t 
> nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
>  			requested_bytes += req_len;
>  			pos += req_len;
>  		}
> -		nfs_direct_release_pages(pagevec, npages);
> +		nfs_direct_release_pages(pagevec, npages, false);
>  		kvfree(pagevec);
>  		if (result < 0)
>  			break;
> @@ -899,7 +906,8 @@ static ssize_t 
> nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
>  			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
> 
>  			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
> -							pgbase, pos, req_len);
> +							false, pgbase, pos,
> +							req_len);
>  			if (IS_ERR(req)) {
>  				result = PTR_ERR(req);
>  				break;
> @@ -942,7 +950,7 @@ static ssize_t 
> nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
>  			desc.pg_error = 0;
>  			defer = true;
>  		}
> -		nfs_direct_release_pages(pagevec, npages);
> +		nfs_direct_release_pages(pagevec, npages, false);
>  		kvfree(pagevec);
>  		if (result < 0)
>  			break;
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 4a87b2fdb2e6..5c5601a27663 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -404,20 +404,26 @@ static struct nfs_page *nfs_page_create(struct 
> nfs_lock_context *l_ctx,
>  	return req;
>  }
> 
> -static void nfs_page_assign_folio(struct nfs_page *req, struct folio 
> *folio)
> +static void nfs_page_assign_folio(struct nfs_page *req, struct folio 
> *folio, bool pinned)
>  {
>  	if (folio != NULL) {
>  		req->wb_folio = folio;
> -		folio_get(folio);
> +		if (pinned)
> +			set_bit(PG_PINNED, &req->wb_flags);
> +		else
> +			folio_get(folio);
>  		set_bit(PG_FOLIO, &req->wb_flags);
>  	}
>  }
> 
> -static void nfs_page_assign_page(struct nfs_page *req, struct page 
> *page)
> +static void nfs_page_assign_page(struct nfs_page *req, struct page 
> *page, bool pinned)
>  {
>  	if (page != NULL) {
>  		req->wb_page = page;
> -		get_page(page);
> +		if (pinned)
> +			set_bit(PG_PINNED, &req->wb_flags);
> +		else
> +			get_page(page);
>  	}
>  }
> 
> @@ -435,6 +441,7 @@ static void nfs_page_assign_page(struct nfs_page 
> *req, struct page *page)
>   */
>  struct nfs_page *nfs_page_create_from_page(struct nfs_open_context 
> *ctx,
>  					   struct page *page,
> +					   bool pinned,

Can you add a description for "pinned" to the kernel doc comment right
above this function? I'm seeing:

Warning: fs/nfs/pagelist.c:446 function parameter 'pinned' not described in 'nfs_page_create_from_page'


>  					   unsigned int pgbase, loff_t offset,
>  					   unsigned int count)
>  {
> @@ -446,7 +453,7 @@ struct nfs_page *nfs_page_create_from_page(struct 
> nfs_open_context *ctx,
>  	ret = nfs_page_create(l_ctx, pgbase, offset >> PAGE_SHIFT,
>  			      offset_in_page(offset), count);
>  	if (!IS_ERR(ret)) {
> -		nfs_page_assign_page(ret, page);
> +		nfs_page_assign_page(ret, page, pinned);
>  		nfs_page_group_init(ret, NULL);
>  	}
>  	nfs_put_lock_context(l_ctx);
> @@ -466,6 +473,7 @@ struct nfs_page *nfs_page_create_from_page(struct 
> nfs_open_context *ctx,
>   */
>  struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context 
> *ctx,
>  					    struct folio *folio,
> +					    bool pinned,

Same here:

Warning: fs/nfs/pagelist.c:478 function parameter 'pinned' not described in 'nfs_page_create_from_folio'

Thanks,
Anna

>  					    unsigned int offset,
>  					    unsigned int count)
>  {
> @@ -476,7 +484,7 @@ struct nfs_page *nfs_page_create_from_folio(struct 
> nfs_open_context *ctx,
>  		return ERR_CAST(l_ctx);
>  	ret = nfs_page_create(l_ctx, offset, folio->index, offset, count);
>  	if (!IS_ERR(ret)) {
> -		nfs_page_assign_folio(ret, folio);
> +		nfs_page_assign_folio(ret, folio, pinned);
>  		nfs_page_group_init(ret, NULL);
>  	}
>  	nfs_put_lock_context(l_ctx);
> @@ -498,9 +506,11 @@ nfs_create_subreq(struct nfs_page *req,
>  			      offset, count);
>  	if (!IS_ERR(ret)) {
>  		if (folio)
> -			nfs_page_assign_folio(ret, folio);
> +			nfs_page_assign_folio(ret, folio,
> +					      test_bit(PG_PINNED, &req->wb_flags));
>  		else
> -			nfs_page_assign_page(ret, page);
> +			nfs_page_assign_page(ret, page,
> +					     test_bit(PG_PINNED, &req->wb_flags));
>  		/* find the last request */
>  		for (last = req->wb_head;
>  		     last->wb_this_page != req->wb_head;
> @@ -552,11 +562,17 @@ static void nfs_clear_request(struct nfs_page 
> *req)
>  	struct nfs_open_context *ctx;
> 
>  	if (folio != NULL) {
> -		folio_put(folio);
> +		if (test_and_clear_bit(PG_PINNED, &req->wb_flags))
> +			unpin_user_folio(folio, 1);
> +		else
> +			folio_put(folio);
>  		req->wb_folio = NULL;
>  		clear_bit(PG_FOLIO, &req->wb_flags);
>  	} else if (page != NULL) {
> -		put_page(page);
> +		if (test_and_clear_bit(PG_PINNED, &req->wb_flags))
> +			unpin_user_page(page);
> +		else
> +			put_page(page);
>  		req->wb_page = NULL;
>  	}
>  	if (l_ctx != NULL) {
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index e1fe78d7b8d0..ebfebc47966d 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -301,7 +301,7 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
> 
>  	aligned_len = min_t(unsigned int, ALIGN(len, rsize), fsize);
> 
> -	new = nfs_page_create_from_folio(ctx, folio, 0, aligned_len);
> +	new = nfs_page_create_from_folio(ctx, folio, false, 0, aligned_len);
>  	if (IS_ERR(new)) {
>  		error = PTR_ERR(new);
>  		if (nfs_netfs_folio_unlock(folio))
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 3134bb17f3e3..cf56c07ae2ee 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1086,7 +1086,7 @@ static struct nfs_page 
> *nfs_setup_write_request(struct nfs_open_context *ctx,
>  	req = nfs_try_to_update_request(folio, offset, bytes);
>  	if (req != NULL)
>  		goto out;
> -	req = nfs_page_create_from_folio(ctx, folio, offset, bytes);
> +	req = nfs_page_create_from_folio(ctx, folio, false, offset, bytes);
>  	if (IS_ERR(req))
>  		goto out;
>  	nfs_inode_add_request(req);
> diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> index afe1d8f09d89..9ece78f1b788 100644
> --- a/include/linux/nfs_page.h
> +++ b/include/linux/nfs_page.h
> @@ -37,6 +37,7 @@ enum {
>  	PG_REMOVE,		/* page group sync bit in write path */
>  	PG_CONTENDED1,		/* Is someone waiting for a lock? */
>  	PG_CONTENDED2,		/* Is someone waiting for a lock? */
> +	PG_PINNED,		/* page is pinned by GUP */
>  };
> 
>  struct nfs_inode;
> @@ -124,11 +125,13 @@ struct nfs_pageio_descriptor {
> 
>  extern struct nfs_page *nfs_page_create_from_page(struct 
> nfs_open_context *ctx,
>  						  struct page *page,
> +						  bool pinned,
>  						  unsigned int pgbase,
>  						  loff_t offset,
>  						  unsigned int count);
>  extern struct nfs_page *nfs_page_create_from_folio(struct 
> nfs_open_context *ctx,
>  						   struct folio *folio,
> +						   bool pinned,
>  						   unsigned int offset,
>  						   unsigned int count);
>  extern	void nfs_release_request(struct nfs_page *);
> -- 
> 2.54.0.1013.g208068f2d8-goog

