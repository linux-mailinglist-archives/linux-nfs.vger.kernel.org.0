Return-Path: <linux-nfs+bounces-20239-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGrWBbZouWmZDwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20239-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 15:44:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C462C2AC348
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 15:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 348A731C1776
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E53E5571;
	Tue, 17 Mar 2026 14:29:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740593E556C;
	Tue, 17 Mar 2026 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757741; cv=none; b=Mw0NrAVvys0PFeMwIwPq7KHFY1X6ZxwOmzPvAxC6BGK50JvKFKKuodxpDtvG7dBebAcJSLb0k2e/dkuc9i1HpSaE4GQH/0LWIxPhPEMY7KCrwgQooTAgd0iESaJ3V1TwhlisLoljeVE0bPC7LBVeYC8dBojOeimn2Bcu1q799sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757741; c=relaxed/simple;
	bh=6k2DwzhDv5q/kP3eGvrXx6LEOjVKfaaAFH615P7eWxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb6EA6ko/70DTAZeyN90P/Om3f8DqwyT1r9YN1MCu8IScbhxzEZJ6SH5X+fkfcErV0ZFUKS7bzN3uaImQxcrtwFN+zPop7Z1PRwkxgMSqjd6kIqONg/S2bOUfKK4WIM4JYOy1ukws8tUgbeupNOv5vnhF7UZqJGU9ynlqoVicFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E89A068C7B; Tue, 17 Mar 2026 15:28:55 +0100 (CET)
Date: Tue, 17 Mar 2026 15:28:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 4/4] svcrdma: Use contiguous pages for RDMA Read
 sink buffers
Message-ID: <20260317142855.GD4367@lst.de>
References: <20260313194201.5818-1-cel@kernel.org> <20260313194201.5818-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313194201.5818-5-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20239-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org,infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.889];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C462C2AC348
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 03:42:01PM -0400, Chuck Lever wrote:
> Suggested-by: Christoph Hellwig <hch@infradead.org>

I think that's a bit too much credit.  I just wondered why sunrpc can't
coalesce pages itself.

> +#if PAGE_SIZE < SZ_64K
> +
> +/*
> + * Limit contiguous RDMA Read sink allocations to 64KB
> + * (order-4 on 4KB-page systems). Higher orders risk
> + * allocation failure under __GFP_NORETRY, which would
> + * negate the benefit of the contiguous fast path.
> + */
> +#define SVC_RDMA_CONTIG_MAX_ORDER	get_order(SZ_64K)

Isn't the limit really an order and thus grows with the page size,
instead of based on a fixed size?

> +	o = get_order(nr_pages << PAGE_SHIFT);
> +	if (o > SVC_RDMA_CONTIG_MAX_ORDER)
> +		o = SVC_RDMA_CONTIG_MAX_ORDER;

Use min()?


