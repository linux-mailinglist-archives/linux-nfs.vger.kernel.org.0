Return-Path: <linux-nfs+bounces-18885-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCOTOBSmjGnVrwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18885-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 16:53:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B002125DCA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 16:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3A71300404C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851F82E62A6;
	Wed, 11 Feb 2026 15:53:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B6253F05;
	Wed, 11 Feb 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825231; cv=none; b=S+q2ZwlPuwx3/LlmShbsKTHOHbtKndGZUZXiyimR5zA4acoRxgCfYM4YfaKRnGd7/2L+xTScCn0tsHzXJiLzHaiLq3A0DseHSVLqQX/7mTycT7DR4dybBzx1pXAGXcQctdq3fFmiRO16QnATnMh7AgLtQCjDFkBktJsdojkuzcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825231; c=relaxed/simple;
	bh=bQpzoySm9WxiL3m+AQgKRKyIaZ51ZZa5CoaKD8psjFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f00oN0V6d7N+7RZhOtqBqm2TBlpBGmsfRVGhSDg05lgY3TZZm7r5vnnqRzn0XsH4nclQ0q4J7mJcd9JcfySS84cIL7ZwL4Z2OIScWcC5tONtR0jrsxS0NjPYjNM5iIO0V9FJWaDQYSiIfe2/hqTC9RqJupqTVg2zpz90+ttnvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35A4668C7B; Wed, 11 Feb 2026 16:53:47 +0100 (CET)
Date: Wed, 11 Feb 2026 16:53:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
	pankaj.raghav@linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com,
	mcgrof@kernel.org
Subject: Re: [PATCH 0/4] Avoid filesystem references to writeback internals
Message-ID: <20260211155346.GA10445@lst.de>
References: <CGME20260211070533epcas5p32f50f317b20250bb61b1b5a0b3a2a5d9@epcas5p3.samsung.com> <20260211070057.22001-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18885-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 3B002125DCA
X-Rspamd-Action: no action

Looks fine as a cleanup, but maybe add comments that these functions
must not be used by file systems that support cgroup writeback and
thus can have multiple bdi_writeback structures per bdi?


