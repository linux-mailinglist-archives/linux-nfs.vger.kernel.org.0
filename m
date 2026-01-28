Return-Path: <linux-nfs+bounces-18554-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK53DOWUeWmOxgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18554-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C2E9D156
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB713008204
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 04:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07302264A8;
	Wed, 28 Jan 2026 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rla9aG0N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76648285C80
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575649; cv=none; b=QUk87l4XWhs8gz4ouF6op9xtFy///k+13V08OriGPEforSla0X9VvAzGKGKcXcE6eTltHtV1yLCiIx1UJnYY7RlernWwHs2uBzHVZhYct5YWATv1fAxj0BxJ0IptCqL9kpE2STLOn8OjOgq8r1ZOfCe3wjcqoUvu5YgM/GKRNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575649; c=relaxed/simple;
	bh=U4x13z/6FWpODCFgX44/Z3qPjAZBFXFXI6olUQBbor8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDuQWvHdhXbe4jRv6z9Ci3BO86ctV7RFEnSKE1EQUHWMvOYehfnZrQGjRpkjMTZxE5MJXyVigRfBx2Sro5NzWi9guOAPaZzM2rjcpMamULayKSCo8HCaiDBR+f6LeV3KGVfKCg9T+VBljbFsXWp4KTdsdeI9BY8aap0xy45LwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rla9aG0N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=veN1dADh5y4kHPcUrmKVSDObvplokozelJDT9hMlPAM=; b=rla9aG0Nd/hj9+3J09OrNd4Ziq
	X1xVElNht/P+UGsNagjkpRUARXWJyh0Jjoifvo+DtJ/IFHPluKU8J8VId3+4qq2QXzHjLlZAK0sLz
	P4E+ETPHY+QEwCYS2pXaKG+1eWwG2JH6xFtDtUGgep4vpU4BzjoyoDH0sbVNvIiezt2SKqNTJmlMg
	r3GxMlMpV6Ddo+xRW5m4AgiJAlFZhdSGaIMeKkQYDjPwll8gmlNVmiKGUOGn9w4AwdvC1FhASHAuq
	qn5aPgXPI9e1DnDqTqqa7aEXPLLs5xpxj59Y5Lpc3wqcSS1h3dFJCxhKvSUcMoujJTLkEmXLpnSsG
	5vDN6jkQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkxSh-0000000FRHY-2JKu;
	Wed, 28 Jan 2026 04:47:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 4/7] NFS: remove the delegation == NULL check in nfs_end_delegation_return
Date: Wed, 28 Jan 2026 05:46:06 +0100
Message-ID: <20260128044706.556046-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128044706.556046-1-hch@lst.de>
References: <20260128044706.556046-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18554-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: B9C2E9D156
X-Rspamd-Action: no action

All callers now pass a non-NULL delegation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index d95a6e9876f1..32803963b5d7 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -571,9 +571,6 @@ static int nfs_end_delegation_return(struct inode *inode,
 	unsigned int mode = O_WRONLY | O_RDWR;
 	int err = 0;
 
-	if (delegation == NULL)
-		return 0;
-
 	/* Directory delegations don't require any state recovery */
 	if (!S_ISREG(inode->i_mode))
 		goto out_return;
-- 
2.47.3


