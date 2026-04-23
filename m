Return-Path: <linux-nfs+bounces-21059-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJlqAERi6mmrygIAu9opvQ
	(envelope-from <linux-nfs+bounces-21059-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:17:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD45455FE4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2559307C7C5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557BE3AB298;
	Thu, 23 Apr 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nctX78Bt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335763A7848
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968109; cv=none; b=W4jj7RiKjNnmr6zhYt4i2WtxHMvWXcB75zVVWjj++qSclUtldcLPCT9FEQPDJDBJdptz+GrLZQQcNgLxpMyBgQ8fgxFudGjCASc4+zj1YsFL9RvjeKEaRPwGmox19UCHKhr9ks+sgXROEC5Ilja+63/Ngkf6lJWnhvMMLfDWHy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968109; c=relaxed/simple;
	bh=/UmQAFSBbswT/Ryu4EDaN4Mj72kBgfupv+DLFwk4FvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGzNaJm5ZvERqo87dwjD4AA404Wj1cFeV2qk0Iar9dSh+vXuKazbLir1YAbhQ9b8XgA/dqX1saCNUYlrprmaYZsvGDqqgrm4KKMke5vY/ak51QzXXxtNTzCbUgqcsxDEGJ2wMBuSTJImXSscDssuOJ+V3oQSHu9A3BCKqvD2eUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nctX78Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5EAC2BCB6;
	Thu, 23 Apr 2026 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968109;
	bh=/UmQAFSBbswT/Ryu4EDaN4Mj72kBgfupv+DLFwk4FvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nctX78BtQj/qG8xprmcvCKAh9RicjupohzfALwPhjVaM12fICiQDGNp71lLDzcbYs
	 nYlVTaEizMZ8zozguNXlc5pvQyLUD640C/Qy17MlbmkE4rO1PcNUNMflC/SjaFiHy3
	 oUfnodYBL5w0eSz/SHyAXzJixfEnMSIyjDF5387AVYvbvTQ+PEoz+Vdh8R6YW3X1sX
	 jHrTwx6abq4Eh3v63T2616MJmJRXKasdA4FzMgLKlLX3PWUUPEGBAIWzXnY0+IxYjF
	 BSzrv3RG936tj9OxKI5hWUbIs+U925ey8Ns4wi5713Lx3M7BqmJXejmXZyR9UB9Tjz
	 ylQdV3AnOmCuw==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] nfsd/blocklayout: always ignore loca_time_modify
Date: Thu, 23 Apr 2026 14:15:01 -0400
Message-ID: <20260423181505.742554-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423181505.742554-1-cel@kernel.org>
References: <20260423181505.742554-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org,lst.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21059-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BD45455FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christoph Hellwig <hch@lst.de>

RFC 8881 Section 18.42 makes it clear that the client provided timestamp
is a "may" condition, and clients that want to force a specific timestamp
should send a separate SETATTR in the compound.

Since commit b82f92d5dd1a ("fs: have setattr_copy handle multigrain
timestamps appropriately") the ia_mtime value is ignored by file
systems using multi-grain timestamps like XFS, which is the only
file system supporting blocklayout exports right now, so make that
explicit in NFSD as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/blocklayout.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 9d829c84f374..24cc5025f649 100644
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
2.53.0


