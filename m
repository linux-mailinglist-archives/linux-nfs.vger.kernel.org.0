Return-Path: <linux-nfs+bounces-20608-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIMdKdb5zWkdkAYAu9opvQ
	(envelope-from <linux-nfs+bounces-20608-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:08:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C65383DDA
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0BD3303F7D8
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 05:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3035F61F;
	Thu,  2 Apr 2026 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yFI9NrJF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582D317176;
	Thu,  2 Apr 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106452; cv=none; b=ZHQGAeb+p4cVtLwL2L7QtJjq0/AzzPYnfjgtgA/zADU59KmlnUlC3ThboK/Haxlh66zzdCPQwKt+9bLEubmeNbJPG57TyMK0WoszAZmRcN968obDMIpWoriFlZmoaajMI6xGwcKz5KhSPciLWRRfsX8AlazawRItEP8z1maOgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106452; c=relaxed/simple;
	bh=+Db5bhh91/Zn+M87MC/W3V4/XRdo0MEXCj34TdGQWik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQE3m5b2MYLLzqCnv85wSUAhrHHzXsX6a2Xp32IneqhIuCPYQKIHSEA+59q++KC9OhR7ECZganyeeJcz96IvxF3Bcq0SAKIS40Ux5UkNCe848J94fD7Zbpufs04rXwb36faC7BfYs+RIMXE5E9C1tJlhOyA0uMfj6kT87Ri5vYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yFI9NrJF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VsyI3F3JLcKFaFeQA5wACxBqiWIPHJgFR3MY8SR+ei0=; b=yFI9NrJF03GGB9B9XacIKFVWab
	3/E5KKWHZXWQoQdlX7Z51iLjcAnPSrpGGrLfaa2xnJOveiDbC8FV2Dv8V/4LcDhMIu1IRwr8LLMQB
	HIFX0U0TWTNMyf6OgWpp6W3g5Grkjcyvlpf5rQrZNJ3NwdW51hDmmxcJgVqFBiNDJFD6aP2Yx4RmO
	/s6zrNxTdk9rYQIgrbTMC1ZU+X80py/KYeEdJBhKcrEhwjwMB2dD/+uWrDz1vz0UDVXmjApK4WUJu
	UayH1QBQzXKtWbSeYZW1+i6PdJg10Ex32atbVNcuhv2MG7hj/WjbuCAlf4GSfiCk9RHMDnokHVxAb
	97FONsYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8AH6-0000000GnFy-0lCj;
	Thu, 02 Apr 2026 05:07:25 +0000
Date: Wed, 1 Apr 2026 22:07:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com,
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] nfs: Enable PCI Peer-to-Peer DMA (P2PDMA) support
Message-ID: <ac35jH0V38pZJqYD@infradead.org>
References: <20260401194501.2269200-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401194501.2269200-1-praan@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20608-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 08C65383DDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Besides the point of splitting out the iov_iter_extract* conversion this
seems to ignore pNFS.  You also need to check the layout driver for the
current file range and propagate P2P support or lack of through that.

Note that the block-style layouts can also trivially support P2P and not
just RPC-based ones.


