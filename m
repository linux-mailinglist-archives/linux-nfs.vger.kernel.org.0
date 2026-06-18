Return-Path: <linux-nfs+bounces-22670-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /V/3EKf8M2r8KAYAu9opvQ
	(envelope-from <linux-nfs+bounces-22670-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 16:11:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CB06A0D41
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 16:11:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=SDWHM7EW;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22670-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22670-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52E673009F76
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6313E7141;
	Thu, 18 Jun 2026 14:11:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4C3B2FC2;
	Thu, 18 Jun 2026 14:11:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791906; cv=none; b=GpjoCZGa0v0Ue3ZsJhO5nDOq4gntl06mUGjCqdstf+OdUrmQ7dQD3V1IDF+m9Ojjr69akMnphjY/VWfnIer7s+pPHJJXBy9CVk2PLIh7mIhrcDS40rCAZPS4tIlLu39M/Joz+Fk55PRILQe5mlN4RCVQUN8GN4C+wVS8dFdpZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791906; c=relaxed/simple;
	bh=VBVkYCUWfueQgx1Sqa9pxKAo+hP9ZfeDWUaqvHn4iwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMlPqT+pThw4EIPrJvXa4CSCceOa6ntM+8M9BKL24lapnJvtA8Y6R81NAYuT2TtLSXhSjhSIrjd+WvWd4/GPAoMk9Hea6oa65UQpUHuCEmnnmvPjH64GPB2KFpbXV9O2JNIF0jRwhlkb4vFrmYkbNmcjWZp3VskVOwffrQjJwwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SDWHM7EW; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5XfNA/Z4Szr2VM5sQ0M6nM09tAAE3/dubcHoaRqoqVg=; b=SDWHM7EWvXpZbkUBGN0C4jKU+q
	IQVqVsCgp1mgvzPVtDJmqwNOhugr9dmSe1hHF0ykQf/R5d+gjW3Hga+kUzh2APzCPTOry4nqTvAuO
	9Wkr3JCTfpvisSN5ViJumnGazFru9wqMx2fQKjULBfJRWrFyQCJiKMjgPcpcj89E1sgqpi/5U1wDw
	nvRhqpbxCLezDDj0Z8V0xDlELUrtmk6g2yN/6jZwHGQoM+cBuDG1EUOAL4Q2yuu0XhPsTO6xq+ho/
	nS9KJOnZt3X/RwKEP/LJGbNLTA3u0ySHT8RO/eL9J/VMa2FYQTOXrFGdT0+TCbWDf3QXN7VW3k9Jb
	Tddq0ljg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waDT7-00000001PpM-1O18;
	Thu, 18 Jun 2026 14:11:45 +0000
Date: Thu, 18 Jun 2026 07:11:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v2 0/7] nfs: Modernize Direct I/O path
Message-ID: <ajP8oV7Ho3db_09N@infradead.org>
References: <20260616134000.2733403-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616134000.2733403-1-praan@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22670-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:praan@google.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1CB06A0D41

On Tue, Jun 16, 2026 at 01:39:53PM +0000, Pranjal Shrivastava wrote:
> =======
> This series has been tested with xfstests [2] on RDMA & TCP transports:
> 
>  ./check generic/091 generic/130 generic/139 generic/143 generic/154 \
>          generic/155 generic/183 generic/188 generic/190 generic/196 \
>          generic/198 generic/203 generic/214 generic/240 generic/263 \
>          generic/287 generic/290 generic/292 generic/330 generic/444 \
>          generic/450 generic/451 generic/586 generic/647 generic/708 \
>          generic/729 generic/760

Did you only run these tests that previously failed for Anna or all
of xfstests, which should give you much better coverage?


