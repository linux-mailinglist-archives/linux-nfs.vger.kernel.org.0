Return-Path: <linux-nfs+bounces-20542-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM8TH/3ry2l6MgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20542-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:45:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9436BFFF
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19D603194C96
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCE5411618;
	Tue, 31 Mar 2026 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WxFVH+r2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BD421880;
	Tue, 31 Mar 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971261; cv=none; b=F3sN2f6zoiSInABXgsmP2I4ECAVGAYUYrxJcMPijsCPjIM2HoCbQeh7JaEadmOl7zqtaGNcauX3z9MyRSB/fCT1oBAN8uVbqhit90fOlQcz8u3b18h08Zaqcqcwf0cJ6GnCkNbOgyxIU+3IrzkzzsbWJmCvlzxWdutpbdXkOJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971261; c=relaxed/simple;
	bh=fvciSXFExvv/gcKb2vmbtSyPc1ek97Ieke1n6UI4r4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1KL1dpKmcFtrg3M3mj9djqaSWODYl7bW1sBIQd+S2/QimV9CqTmjN7E6Zo/LJ4U8WyVfAzoZT2PWNo97FTlQmTfvaLzu17Ao0rTiHlNQH5kvMObmJv5kbxev9ZVsRQCPxcRfzmqhlwsgN/X1HqvIKxVV/RSeyMeSVXTz0aznwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WxFVH+r2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=X9tq2WB/kO5ZwBjJ1Hvsc2PV2f/LEoZ1kWJxPhl+YyY=; b=WxFVH+r2A8MDpGWEytqninV2Y3
	4F3dhDWdz31zje9x+s8PNY595fRFH78ewr2XdiwWQIeyTVXSykaZdy4pmv0RQvdwgEkrRWQnpi64I
	uoL2l5F8efGidoO4g5DkicPt+Thu4fnHNo7M01fFYW4WVe+8cDCou7kVrRBAya81Vetr1TQyYU4as
	6urnjIN0MoVPwWkxOqzlDEaYQTUxJ6BjfxPoTj0dRDObSK1lhoB2zqgZi1UncpbDUzrb8/5DiMkl1
	iisYl0fLfRNFjk8jyfGY/Y70O44QtPap2MZ8Yn5NhaCPJrwjuE9YN26FFIMGHsfz4jDhkDXw0ZRqo
	tp5DcDog==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7b6b-0000000DBq8-2mJV;
	Tue, 31 Mar 2026 15:34:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] nfsd/blocklayout: always ignore loca_time_modify
Date: Tue, 31 Mar 2026 17:33:26 +0200
Message-ID: <20260331153406.4049290-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331153406.4049290-1-hch@lst.de>
References: <20260331153406.4049290-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20542-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: BCE9436BFFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 8881 Section 18.42 makes it clear that the client provided timestamp
is a "may" condition, and clients that want to force a specific timestamp
should send a separate SETATTR in the compound.

Since commit b82f92d5dd1a ("fs: have setattr_copy handle multigrain
timestamps appropriately") the ia_mtime value is ignored by file
systems using multi-grain timestamps like XFS, which is the only
file system supporting blocklayout exports right now, so make that
explicit in NFSD as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index a7cfba29990e..5ee5735b39bb 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -179,15 +179,20 @@ static __be32
 nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
-	struct timespec64 mtime = inode_get_mtime(inode);
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
-	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
-	    timespec64_compare(&lcp->lc_mtime, &mtime) < 0)
-		lcp->lc_mtime = current_time(inode);
+	/*
+	 * This ignores the client provided mtime in loca_time_modify, as a
+	 * fully client specified mtime doesn't really fit into the Linux
+	 * multi-grain timestamp architecture.
+	 *
+	 * RFC 8881 Section 18.42 makes it clear that the client provided
+	 * timestamp is a "may" condition, and clients that want to force a
+	 * specific timestamp should send a separate SETATTR in the compound.
+	 */
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
-	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
+	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = current_time(inode);
 
 	if (lcp->lc_size_chg) {
 		iattr.ia_valid |= ATTR_SIZE;
-- 
2.47.3


