Return-Path: <linux-nfs+bounces-22327-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sb+bCkpZI2r9qQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22327-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 01:18:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4E864BC6A
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 01:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=Sro0e4tk;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22327-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22327-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E94B3007F47
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 23:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE25D3D3D14;
	Fri,  5 Jun 2026 23:13:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3A3D3309
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2026 23:13:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701196; cv=pass; b=Orx9CKxZ1mAfhksOmrE/k5F4M2PgfcLgVjrHwpUAhorGAao30xbJFZCbcMcg6bfyiSdryPp5Zpv+HazI1aLEEK9LWNfqTO/SG2LdIL1TfnnrYVR3V19IbZupeXO2dyNrQvdh73qsK47Ma4JjmA1dtPvWBiMNrNaE6enyO5blYjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701196; c=relaxed/simple;
	bh=4cE486h5t6YIIigwj5Ql88T65gS4pqp6vVCrPMt54vY=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phsydGHRtDBGQOnq6ORFTLQ7IZ+DCDxF0bEab1iQRuhSQqRWuOMjNZI0NZkEIRyU9YMluGsqppDF71j2qiZrbQ/XRQ/9JYESKR1GcJZDN+QCF1r7pZEyg0fIwZOy4JgWBaakyk/4G5g8ECsfqbm1xaTY0sS05u9ayznMWtpIlBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Sro0e4tk; arc=pass smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49068493267so18309505e9.1
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jun 2026 16:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780701193; cv=none;
        d=google.com; s=arc-20240605;
        b=jQ5QgCYeb4VAFuG/oWDS25Iv3g8wRhwR25ro7+YNVaTHV266b3DW3cYNXHBYEbGYS2
         e2i2LxAW3pgTbGRx7WIi9B/EgBc4NNxbL8kFNIfOsxEtjtG6cUxwa1PUe+3Ljft+0RJf
         W9a5pt562KM9P0yBLMP97cPG361hylLo7uciWnlga0fxY2bUVuN+WRWG51aF25HJbNxo
         tASY3ukalcenyL2Z2mfjy114o7MYyr+DT0ipEWKgevzwiHCkivKFuAZOAjUnB+qK7tmy
         LbLrTJsAnS2NUnXLn2XDNxiGDwrgFc3fWvR0GPdDArQvErIlE67Fdc5HUUaE1mti2vLU
         IqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:dkim-signature;
        bh=79tlu8fv//QY1Mz5hfzUvL7B6kALz4yuxyZKouUvpEA=;
        fh=zclRT0AL/VU5GNEzXpWBMxRZa9n+H0QFGVGjNlhFdfI=;
        b=cNAutoPB8o6JZnq2i1AFVRVLHk6wkv1kkAZZe0+MnE1TX5XBW65Rm8zquaxpf4+8Ix
         DLBtVqPeqX6/Wp8cW0hd6j/09glOPH3TqT5CRT8io/1wPCq4vS5vXP3ZxPQdB3pADvKE
         5hmXSq4ntj0pEqKES6bJqU6M5N1O7nzPg0I+tKvuQYHwLd4jN9hiqOXoPybDXOLJVfVJ
         6nMs6jXzWE2Dgu9z2FpfTmM4ru3zPBIVrsapBN+tRmOhgJ6lMG2fAjlDEWlMK7UVqxw/
         xhKUTd+V0UnnRL8TFX+M5bIRoVw9hbRUpJqPacYfRbN35mArwPvsfx+to/yKA9HT8Pqh
         uZbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780701193; x=1781305993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79tlu8fv//QY1Mz5hfzUvL7B6kALz4yuxyZKouUvpEA=;
        b=Sro0e4tkAKPOnRXFRQ8v4kPraQLZOK6t5d94gln1A9t6aAnh04YmkITeCel4NhGyPu
         jjrUmX/9olqBO0gCRVpxRo1Iu0zmJJRjs2qRIZhXCQNVt9UtZ6HwSb38SPC5VU16+6ME
         MSXuCWNMKIQpJrzrTCDTsaTsXw6ImLRAj+pG5Ntkn+1Z58YCJ4Y2xir/5+dlixrX/QGS
         mUFPvG1atkEdhcpVIS19Itzc900s2pxsSdkLv/EwfjFH4ZSLt+ps7oSlmJFZmWTfRBeL
         wfgCEovnT6TPvnMzqFJIhq7tvfruMqfYFhxHqsA7E1q9p2BloxIBY0Npr7kAfDJPxTVx
         t04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780701193; x=1781305993;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79tlu8fv//QY1Mz5hfzUvL7B6kALz4yuxyZKouUvpEA=;
        b=depHKvqRN8qlnE3svyc9xRA1jW+y12hOkw8lTBsEJOUkn7GvjiR6MGa0IIiuzmw2m0
         djXuhzQBXbjVGJa56Alols6eXV7JUhQVeFiVYM8FaLc+qME6ojLr1o01Wmx5N/HtsuuO
         m5FLkuORNtaBPBmyq3noPBu+hRfT91IxDYf4xZSSdtMib/WwA3O+wHTzGD/Gh6sozGFG
         vMc9HXkj6wYOMPLKpLQeFz07aG0n7vGziwuwbSXDmWjaHJ0O03zJ5UzZAzQUJvaYeJmr
         1GkopQxNzSgB9J3TO+bKcK4QP4i3/rpWHayjXBciBsypGvm6tdCiTVX/HZ2MOnXCPAjE
         HeCQ==
X-Gm-Message-State: AOJu0YwIkVB7n85Ulh/AH1w+WSpAoCqQPbd/ojk59z/4L7h09i0skuYr
	I+c4HJVZb7GNAc4V8dM8Zs3lY+U5+DDbOp09zjT9EuBZd3rf4MN1TWwr0nKU5V4GE4yf5asdFaw
	CJC6O4SriGPYwbIO+gP0/6LPeiDWOnwjXYdDHe2McuA==
X-Gm-Gg: Acq92OFjV9AD5uHyrriiB+aVMfupdTUSrEJepTsntaI5ihPoqZwPBnKo1ncB9hJ621r
	KEYtI+2djAcvqxU/IIvWnijbpcf9THgZcR8qPhX/e3vRvOQoJO6FCe5BlP3qnV4XWNtgYpNR0Ud
	0bbxOTX6fd0382Rm2saStN0f/FmWrBfrf1kNdDTmMKQi6czeloEDBJ7XdsnZn4Mmpu7bHvnsY0m
	9dA54HBofMSsfC1i/t0n+aKQQ0+YuEImohq9TlMEjroViQDxdiMb+jryVBTHGh47iJNGQwNJVsL
	m5oyOF99OEXYkNBo
X-Received: by 2002:a05:600c:628e:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-490c2599ff8mr101101885e9.4.1780701193538; Fri, 05 Jun 2026
 16:13:13 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
References: <20260605223118.75092-1-cel@kernel.org>
In-Reply-To: <20260605223118.75092-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIiV4E/dqzlDyccSLfgm6X2NNlNbLWl0DlA
Date: Fri, 5 Jun 2026 17:13:12 -0600
X-Gm-Features: AVVi8CcgDTMvhJMy5dzuXLKJ8d6pBsj9mQVdQ0taq0X4REIWYUp5n2UXMlf1Tko
Message-ID: <01eb014a108d59a6312cd23379abb49b@mail.gmail.com>
Subject: RE: [PATCH] svcrdma: Avoid direct reclaim when allocating Read sink buffers
To: Chuck Lever <cel@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jonathan.flynn@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22327-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.flynn@hammerspace.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,hammerspace.com:dkim,hammerspace.com:from_mime,hammerspace.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B4E864BC6A

> -----Original Message-----
> From: Chuck Lever <cel@kernel.org>
> Sent: Friday, June 5, 2026 4:31 PM
> To: Mike Snitzer <snitzer@kernel.org>
> Cc: linux-nfs@vger.kernel.org; linux-rdma@vger.kernel.org; Chuck Lever
> <chuck.lever@oracle.com>; Jonathan Flynn
> <jonathan.flynn@hammerspace.com>
> Subject: [PATCH] svcrdma: Avoid direct reclaim when allocating Read sink
> buffers
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> svc_rdma_alloc_read_pages() passes __GFP_NORETRY, which limits the
> allocator to a single round of direct reclaim and asynchronous
compaction per
> attempt. Under memory pressure or fragmentation that round can take a
long
> time, and the fallback loop repeats it at each order, multiplying the
stall while
> the RPC waits for its Read sink buffer.
>
> The contiguous allocation is opportunistic: when it fails, Read sink
buffers
> come from the pages already in rq_pages[]. Direct reclaim effort buys
little
> here. Allocate with GFP_NOWAIT instead, which omits
> __GFP_DIRECT_RECLAIM so the allocator takes pages only from the free
lists
> and returns NULL immediately when none are available. GFP_NOWAIT retains
> __GFP_KSWAPD_RECLAIM, so a failed attempt still wakes kswapd to
replenish
> higher-order pages in the background, and it already includes
> __GFP_NOWARN. __GFP_NORETRY has no effect once direct reclaim is off.
> skb_page_frag_refill() takes the same approach for its opportunistic
high-
> order allocation.
>
> Reported-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
> Fixes: 18755b8c2f24 ("svcrdma: Use contiguous pages for RDMA Read sink
> buffers")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_rw.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
>
> Given the perf symbol resolution inaccuracies I can't swear this will
fix the
> issue, but here's a stab at it.
>
>
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> index 587e4cd29303..efde26cac961 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -746,10 +746,9 @@ int svc_rdma_prepare_reply_chunk(struct
> svcxprt_rdma *rdma,  }
>
>  /*
> - * Cap contiguous RDMA Read sink allocations at order-4.
> - * Higher orders risk allocation failure under
> - * __GFP_NORETRY, which would negate the benefit of the
> - * contiguous fast path.
> + * Cap contiguous RDMA Read sink allocations at order-4. Higher orders
> + risk
> + * allocation failure under GFP_NOWAIT, which would negate the benefit
> + of
> + * the contiguous fast path.
>   */
>  #define SVC_RDMA_CONTIG_MAX_ORDER	4
>
> @@ -758,9 +757,11 @@ int svc_rdma_prepare_reply_chunk(struct
> svcxprt_rdma *rdma,
>   * @nr_pages: number of pages needed
>   * @order: on success, set to the allocation order
>   *
> - * Attempts a higher-order allocation, falling back to smaller orders.
> - * The returned pages are split immediately so each sub-page has its
> - * own refcount and can be freed independently.
> + * Attempts a higher-order allocation, falling back to smaller orders.
> + The
> + * allocation is opportunistic: it takes pages only from the free
> + lists,
> + * without direct reclaim, so it fails fast under memory pressure. The
> + * returned pages are split immediately so each sub-page has its own
> + * refcount and can be freed independently.
>   *
>   * Returns a pointer to the first page on success, or NULL if even
>   * order-1 allocation fails.
> @@ -775,8 +776,7 @@ svc_rdma_alloc_read_pages(unsigned int nr_pages,
> unsigned int *order)
>  		SVC_RDMA_CONTIG_MAX_ORDER);
>
>  	while (o >= 1) {
> -		page = alloc_pages(GFP_KERNEL | __GFP_NORETRY |
> __GFP_NOWARN,
> -				   o);
> +		page = alloc_pages(GFP_NOWAIT, o);
>  		if (page) {
>  			split_page(page, o);
>  			*order = o;
> --
> 2.54.0
Unfortunately, the GFP_NOWAIT change did not materially affect either
throughput or the perf profile. The allocator-heavy stack rooted at
svc_rdma_build_read_segment_contig() remains dominant, with
alloc_pages_noprof() and rmqueue_buddy() continuing to account for a
significant portion of the samples, similar to the original regressed
build.

I have added a gfp-nowait directory to the OneDrive link referenced in my
previous email. It contains the fio results, perf reports, and a
flamegraph for the GFP_NOWAIT test.

I have also added a flamegraph to:

rpcrdma-regression/regressed/phase2/server

for the original regressed configuration.

-Jon

