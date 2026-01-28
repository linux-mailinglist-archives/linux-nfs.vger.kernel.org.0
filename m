Return-Path: <linux-nfs+bounces-18548-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMuOBD+EeWnNxQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18548-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 04:36:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 817759CC22
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 04:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2737300F157
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 03:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5AF309F04;
	Wed, 28 Jan 2026 03:36:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B3B261B8C;
	Wed, 28 Jan 2026 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571388; cv=none; b=VmgVE7stu66lbpfUxve1Hdc5nzZ3e/ha8b+4A69tILLqLwTqq8mEhPPcN+iW2bWuvo8Q/qkbRQXzxGju+k+Kl88kbdYoQztLBfOuV28wT7H2uIUUFaDGrvp4l78D9Hd4T8bfbsffVIYDWm/YAH6I5ot9Z3ef/65s7rvbkD04bI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571388; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV9C7K5ysHDqcJ9ENJO91y//ePFp2f3QnAbG0WurlEwq96McMs1eP2nTteTxX6pgSGhq+vgF+rAlqWWES2cD1StzFPJ4lrFLztmOLWqz1hD1rc8Q95n1Z/U42o5edOimZ5z1pMDHkJvTQ5wJsr5FQI/poHw//7VnW6BGk/ebKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC4D5227AAA; Wed, 28 Jan 2026 04:36:24 +0100 (CET)
Date: Wed, 28 Jan 2026 04:36:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 3/5] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260128033624.GA30926@lst.de>
References: <20260128005400.25147-1-cel@kernel.org> <20260128005400.25147-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128005400.25147-4-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18548-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 817759CC22
X-Rspamd-Action: no action

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


