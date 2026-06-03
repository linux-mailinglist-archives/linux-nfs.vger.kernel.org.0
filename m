Return-Path: <linux-nfs+bounces-22254-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zh2VJ5h9IGoF4QAAu9opvQ
	(envelope-from <linux-nfs+bounces-22254-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 21:16:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE61D63AC8B
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 21:16:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eXA2MGoC;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22254-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22254-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352A3300D971
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 19:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F2F31E831;
	Wed,  3 Jun 2026 19:14:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671C301704
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 19:14:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514098; cv=none; b=Xj2EV5wbGifV3+vANbrvIMOR7h3RCevOBEJejfsLv/uyogqUSVPM3stKMJxMakjgUgvRuoJ1hPymUx+hZY6a8B6wChk5+I33eGEFo71QJ5xetJrbDRWBqGKD7i8T8ha5dCHVLNKgOUJCjJq7jX655CWZT+Rdz9RySq/lQR0YULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514098; c=relaxed/simple;
	bh=KlraIHoO9dT7uQixZ1PcG6ChAwDAZ0OPlciMZSGCqQ4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=arbIcHpwEnMnDLnhz0Ia+y4gMi0Dw+AmdJplKBVymr35zz1akvF+utO2DONXLPGJQ8zI4SByj9sfZbb/WEtPRXBBj3TlvOKAUDg1awCaPN42AnZqvMTIG56s1m1Tb4pgekTVGrlqd1gQ5KMnX/7TaY7eBmJBNCadZLIiVQ7O2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXA2MGoC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F278D1F00898;
	Wed,  3 Jun 2026 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780514097;
	bh=zRiAvnR4/QeSXm7p6R5pu7S/hlCFjtD18rrCTstWfD8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=eXA2MGoCuJYE5miKpYjCHdpKEKeGAjNsc334Blil8qVtK3DsBHt8qguN/tuW7LOcl
	 DO3WeIkjFAKU9ef9bcuX9Un7yiS82SOJusdFywpyclWXXClb5XSb6qenHouSP1G5vs
	 gugT54KpkFxyE8cqktqDEPFfqReW0BHhEsafxtOe75MCa6NV+tw5pfmm88Rt+uTwVE
	 gMKfx6feWn2v31Qo2QzoDPllztQ45j6mLCx9MS2uQuGr2GulU42fwUpuGTgevOmoSf
	 rxTCYnfDjprRj8aTqkPg08YBliTcu5rWaRDVglNqKd8m/vXWBDRR5ajBQkv40ZxEYf
	 OVPRL1kW7VC4w==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 28ACFF4006C;
	Wed,  3 Jun 2026 15:14:56 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 15:14:56 -0400
X-ME-Sender: <xms:MH0gan8ie9l47aKaEqO_h67JR1KsxSmJjMA4EZNhn4YC1Eb_5W68pw>
    <xme:MH0gauidDgX9-af4clJP-yPeUBzOcTNUnJlpxsB0vyhgAU8Yf45BBU1p-CSlsetFf
    5NKYUmRNlfJy9JMO--gZKuSHX3y8BsWIp05I122FPKLTZJgf3Q9DR4>
X-ME-Proxy-Cause: dmFkZTF4B7mJMt3lRrh6wQMVI8cdziCIeAKm30NpqgaNQgENFV8NB97khw/2Hn2Sn+jeeb
    JFhi+EmGgl9OZSTWDXSJrkm5aHJt22L8jaNUnFYdKn5tLHDZlJ4zkg+sqizEFkSuBUGabr
    JinbF2LQRjwVtWrGJ9KTFDClbX0pMB/y2/+4oqaWTPIiCjSBj/DPLNwYDXCN5KpWkqFfqE
    XMkqXFa83en0J3fXhV/F2WxKq8B9Af96uyfxYrZyZWvWRqIDsvbvH81xE7FdFNv3d7TSIO
    oZQr1SSAJqH6YBJmrYUxwu81GeEL94aMAMWcSB/ZHBv2neyw7d9eooBRWr2Wtxkjx4z7ic
    E5SYjvbVJqv5AkuIUpCLQ9NKEjP50c4AJFlNqUE9XM8sALm6b2z7ezK64d9NlxsR9UH490
    /KANSxo35NBiaDXz6wzzbaxRqKtCydWycqhdxpx0d/I2tRZ3zaIQ72tRWtbkP+TNUje6ly
    dPPezlrQr1x6VorvYzdedy4dKD7BAy05j57QKKSypFCkXo7Y6/tKo95lkFnOqTB13CPBWx
    XXFcbelytCIqq+OQSwYIo4QQjU85lAU07gvijk1P0dke5ZqBx3UHMRTXFzn7/I1uYPjcZW
    D3P678kOzvBtRu1HJ2KMjz+012RlagTtw/2r1TM4ZOHy69HbA3ynSNvJKD+Q
X-ME-Proxy: <xmx:MH0gahmOUHf-Su8FuyttV8u-2Ouv2qCSLzrtEe-EWe7pDJNxt7tBCw>
    <xmx:MH0gam5WUCyeGgR5lhBHkiKLvV2odkY5ntDeWCV81yCttE4Y-bIe9w>
    <xmx:MH0ganj8HZG__L-l_fIRwWfzknc7WzeRN2OR29V4jtxwd8h-T-UN2w>
    <xmx:MH0gajFKoRfBnYjk5-bJ_EUIxEb0xj6HJrYxXQNN_mUD6_60BQKrqQ>
    <xmx:MH0gatRaDW_U9RNeJbb5qc99IdLBCU77_NnV66fxxy2lgmW4c4n5AjUA>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 01256B6006F; Wed,  3 Jun 2026 15:14:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuoKuaWt7G2w
Date: Wed, 03 Jun 2026 15:14:35 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Pranjal Shrivastava" <praan@google.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Shivaji Kant" <shivajikant@google.com>
Message-Id: <29a0511d-5216-46f2-a7e4-9c04ae9b1890@app.fastmail.com>
In-Reply-To: <20260603053033.3300318-7-praan@google.com>
References: <20260603053033.3300318-1-praan@google.com>
 <20260603053033.3300318-7-praan@google.com>
Subject: Re: [PATCH v1 6/7] nfs: Optimize direct I/O to use folios for requests
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
	TAGGED_FROM(0.00)[bounces-22254-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:praan@google.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: EE61D63AC8B

Hi Pranjal,

On Wed, Jun 3, 2026, at 1:30 AM, Pranjal Shrivastava wrote:
> Optimize nfs_direct_extract_pages() to group contiguous pages from the
> same folio into single nfs_page structures. This effectively migrates
> NFS Direct I/O from being page-based to being folio-based.
>
> Reduce the number of nfs_page allocations and subsequent iterations
> by utilizing nfs_page_create_from_folio() to create aggregated
> requests.

I am seeing a LOT of failing xfstests after applying this patch (testing
against various NFS versions over TCP with AUTH_SYS):

+-------------+-----------+-------------+-------------+-------------+
|    testcase | tcp-sys-3 | tcp-sys-4.0 | tcp-sys-4.1 | tcp-sys-4.2 |
+-------------+-----------+-------------+-------------+-------------+
| generic/091 | failure   | failure     | failure     | failure     |
| generic/130 | failure   | failure     | failure     | failure     |
| generic/139 | skipped   | skipped     | skipped     | failure     |
| generic/143 | skipped   | skipped     | skipped     | failure     |
| generic/154 | skipped   | skipped     | skipped     | failure     |
| generic/155 | skipped   | skipped     | skipped     | failure     |
| generic/183 | skipped   | skipped     | skipped     | failure     |
| generic/188 | skipped   | skipped     | skipped     | failure     |
| generic/190 | skipped   | skipped     | skipped     | failure     |
| generic/196 | skipped   | skipped     | skipped     | failure     |
| generic/198 | failure   | failure     | failure     | failure     |
| generic/203 | skipped   | skipped     | skipped     | failure     |
| generic/214 | skipped   | skipped     | skipped     | failure     |
| generic/240 | failure   | failure     | failure     | failure     |
| generic/263 | failure   | failure     | failure     | failure     |
| generic/287 | skipped   | skipped     | skipped     | failure     |
| generic/290 | skipped   | skipped     | skipped     | failure     |
| generic/292 | skipped   | skipped     | skipped     | failure     |
| generic/330 | skipped   | skipped     | skipped     | failure     |
| generic/444 | failure   | skipped     | skipped     | skipped     |
| generic/450 | failure   | failure     | failure     | failure     |
| generic/451 | failure   | failure     | failure     | failure     |
| generic/586 | skipped   | skipped     | skipped     | failure     |
| generic/647 | failure   | failure     | failure     | failure     |
| generic/708 | failure   | failure     | failure     | failure     |
| generic/729 | failure   | failure     | failure     | failure     |
| generic/760 | failure   | failure     | failure     | failure     |
+-------------+-----------+-------------+-------------+-------------+

I'm curious if you've run xfstests against your changes, and if you
see the same failures?

Thanks,
Anna

>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  fs/nfs/direct.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 59002c150f23..93e1af9ec36b 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -194,23 +194,45 @@ static ssize_t nfs_direct_extract_pages(struct 
> nfs_direct_req *dreq,
>  		return result;
> 
>  	npages = (result + pgbase + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -	for (i = 0; i < npages; i++) {
> +	for (i = 0; i < npages; ) {
> +		unsigned int chunk_len, folio_offset;
> +		unsigned int nr_to_add = 1;
>  		struct nfs_page *req;
> -		unsigned int req_len = min_t(size_t, result - bytes, PAGE_SIZE - pgbase);
> +		struct folio *folio;
> 
> -		req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
> -						pinned, pgbase, *pos,
> -						req_len);
> +		folio = page_folio(pagevec[i]);
> +		folio_offset = (folio_page_idx(folio, pagevec[i]) << PAGE_SHIFT) + pgbase;
> +		chunk_len = min_t(size_t, result - bytes, PAGE_SIZE - pgbase);
> +
> +		while (i + nr_to_add < npages) {
> +			struct page *next_page = pagevec[i + nr_to_add];
> +			struct page *prev_page = pagevec[i + nr_to_add - 1];
> +
> +			if (page_folio(next_page) != folio ||
> +			    next_page != prev_page + 1)
> +				break;
> +
> +			chunk_len += min_t(size_t, result - bytes - chunk_len, PAGE_SIZE);
> +			nr_to_add++;
> +		}
> +
> +		req = nfs_page_create_from_folio(dreq->ctx, folio,
> +						  pinned, folio_offset,
> +						  chunk_len);
>  		if (IS_ERR(req)) {
>  			if (!bytes)
>  				bytes = PTR_ERR(req);
>  			break;
>  		}
> 
> +		req->wb_index = *pos >> PAGE_SHIFT;
> +		req->wb_offset = *pos;
> +
>  		list_add_tail(&req->wb_list, list);
>  		pgbase = 0;
> -		bytes += req_len;
> -		*pos += req_len;
> +		bytes += chunk_len;
> +		*pos += chunk_len;
> +		i += nr_to_add;
>  	}
> 
>  	if (i < npages) {
> -- 
> 2.54.0.1013.g208068f2d8-goog

