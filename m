Return-Path: <linux-nfs+bounces-19814-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BfPIDyrqWlSBwEAu9opvQ
	(envelope-from <linux-nfs+bounces-19814-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:11:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 227AD215318
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78AF73020A43
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89E3CD8B9;
	Thu,  5 Mar 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bpp7wEEs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7E3CD8AB
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727097; cv=none; b=ZcLbsdfs9oyHrX5Gqw3ELQjErPVxC3qYC57K9BCv8+F6/uvqI540+0TCOMMpJj6U4uldkH7e5JUKhaLmUwYQwY2f0/xQ/8T9BaxlYErSsdQaE7nvZEM1M/2kMuDgjlSPR+84iwS/h6c8eykUC40WnS1h9HEz47cS4qyF0IRUspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727097; c=relaxed/simple;
	bh=Ts6fNhijqZfQz3V062BDqiSFWtlLLJxI0Pzd3DGnXd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVSWJafxHi2CAWsEUUv25Hhmmwfe5aWjXPp/c5ePX6Q4hbZU1NeCQBcP07Wh69fqiZ7qPfUWihe4WRz4IdbMW7JZFyd9LG2FZ+Tx8066vc9lcSh8dTMda6icdsVfABIZ9kpvH7DXGHzZ3hAi9W3N2yQfuHyRqD7r9+5GpadWtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bpp7wEEs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TgelaKl1bISnNs3LcVKWpS+noQ/NTNKwTOIqdcL4gw0=; b=bpp7wEEs06TBEy9BiIqF66fU7g
	x5DYbz0aV0w5Fater3ABSf5Hnwrfdx0VSXdE+K5pKozrLVQa3T0Vbqmlzl9tUoJ4sQVqi+YGuTJ3Z
	eUJbDIYxkJEFsQgNDOhxi+n0Za8CeAlYnhvvTYuV5iYL9zsA1jzOATIxX4mWiktM64aCyYDXmB/Z/
	Cs2GmMxIf7Y9eAVdczkL5QEDUdUAcTBhF6QXYYJaK0j3mn3Fi9eK5TstMqyR6JO30/DD6Rbl+7hZW
	PXW7LJmX/sUBI4wUXhqfW+mcv7IR8ys+1hSaLkLoqbo2sCeZCYQgkmpNbZjbb1VDEUba7ZIXtSetb
	OLDxe5nQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyBIV-00000002Bfx-2sdG;
	Thu, 05 Mar 2026 16:11:35 +0000
Date: Thu, 5 Mar 2026 08:11:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Steve Dickson <steved@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Revert "nfsrahead: enable event-driven mountinfo
 monitoring"
Message-ID: <aamrN6RV9_8RJDuU@infradead.org>
References: <20260305124221.55407-1-steved@redhat.com>
 <aamQbSl40bG5pjD5@infradead.org>
 <6a213da9-7c4f-4912-8ba4-80104a34ddcf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a213da9-7c4f-4912-8ba4-80104a34ddcf@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 227AD215318
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19814-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:31:14AM -0500, Steve Dickson wrote:
> 
> 
> On 3/5/26 9:17 AM, Christoph Hellwig wrote:
> > On Thu, Mar 05, 2026 at 07:42:21AM -0500, Steve Dickson wrote:
> > > This reverts commit 2b62ac4c273a647df07400dc1126fceb76ad96c0.
> > 
> > Why?
> > 
> > 
> https://lore.kernel.org/linux-block/CAHj4cs8URj2fJ7KyP9ViAm6npVOaMiAErnw2uFyPYEU2wb7G_w@mail.gmail.com/T/#t

Please put the reason into the commit log.


