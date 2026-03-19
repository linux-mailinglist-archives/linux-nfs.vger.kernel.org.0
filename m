Return-Path: <linux-nfs+bounces-20267-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAKdL5veu2lXpQIAu9opvQ
	(envelope-from <linux-nfs+bounces-20267-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 12:31:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619D2CA518
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1C20301C966
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681D8348889;
	Thu, 19 Mar 2026 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITeE20ax"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680135DA6F
	for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919881; cv=none; b=rhvaVuY+mFuFKAcG/3SQOwpuRT9bBRmC1dlxDu6C9tJgpiOqpL7gxFNFMm6CUbWoBqOxwgcjabVLUaY7+UBiNuZEXgKLyc2YjNnUBtc4knF3/F78effsrwO4a8oIDZZrUWxmfZOomax85yidy5l+2MWOQ80LF0eXpOhhfJHMZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919881; c=relaxed/simple;
	bh=47ZdeusVTQ92ce4271gf5O3lktx5j/ugFB1tbL1maY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tj7ddhW59eokwIZ9wDNdgPmKxXBaQ+FFAZua35nQ/b9EZJo20tWD9FFmlIRvdy8dYuHdu9gcltPVOQ4mNITPAIzc5t5dPs0lugeSzhOa8ijCB7uAyUFIJ2PkxXhnkZJJvmpZtkm5vZmrHAUy/uBpHHasct/nJtCU80R1LZptXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITeE20ax; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773919873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YpkSz6N29LSu9RDEBAyMQ+b4IfOFBETmzkQPWKmEpQg=;
	b=ITeE20ax27f3f2z7KmazdOlxSNsE44alUxbDNf0h3vfHTng7/9w1mq/++BONFd/hVg6eup
	HeSarGD35Q8m4ZjUs2ZO2sgIw83WqWBTUjtZhi9SH2GYcW4OqD+gecyZTD5evTGxeCncGi
	yPhItSYXRSZW9vhw836ooCtjs7f0PDw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-jfEFCo_9OOO7FF9OVzYypQ-1; Thu,
 19 Mar 2026 07:31:10 -0400
X-MC-Unique: jfEFCo_9OOO7FF9OVzYypQ-1
X-Mimecast-MFC-AGG-ID: jfEFCo_9OOO7FF9OVzYypQ_1773919869
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97688180058D;
	Thu, 19 Mar 2026 11:31:09 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.45.226.135])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15FA51955F2B;
	Thu, 19 Mar 2026 11:31:07 +0000 (UTC)
From: Roberto Bergantinos Corpas <rbergant@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: force drop_nlink if we have a delegation during REMOVE
Date: Thu, 19 Mar 2026 12:31:06 +0100
Message-ID: <20260319113106.17308-1-rbergant@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20267-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbergant@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3619D2CA518
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit bd4928ec799b ("NFS: Avoid changing nlink when file removes and
attribute updates race") avoids races on attribute cache with any
inflight RPC that may modify inode attributes (and gencount) during
i.e. REMOVE.

However it does not take into account that REMOVE may trigger
a delegation return which also advances gencount (via the attribute
refresh during delegation return), and in that case the gencount
mismatch is not due to an inflight RPC that already reflected the
removal.

If nlink is 1 and we have a delegation before REMOVE, we should force
the drop to ensure the VFS delivers the expected FS_DELETE_SELF
notification.

This fixes LTP/inotify04 failure after bd4928ec799b.

Fixes: bd4928ec799b ("NFS: Avoid changing nlink when file removes and attribute updates race")
Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 fs/nfs/dir.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2402f57c8e7d..bc6bbf434a21 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1937,13 +1937,13 @@ static int nfs_dentry_delete(const struct dentry *dentry)
 }
 
 /* Ensure that we revalidate inode->i_nlink */
-static void nfs_drop_nlink(struct inode *inode, unsigned long gencount)
+static void nfs_drop_nlink(struct inode *inode, unsigned long gencount, bool force)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	spin_lock(&inode->i_lock);
 	/* drop the inode if we're reasonably sure this is the last link */
-	if (inode->i_nlink > 0 && gencount == nfsi->attr_gencount)
+	if (inode->i_nlink > 0 && (force || gencount == nfsi->attr_gencount))
 		drop_nlink(inode);
 	nfsi->attr_gencount = nfs_inc_attr_generation_counter();
 	nfs_set_cache_invalid(
@@ -1961,7 +1961,7 @@ static void nfs_dentry_iput(struct dentry *dentry, struct inode *inode)
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
 		unsigned long gencount = READ_ONCE(NFS_I(inode)->attr_gencount);
 		nfs_complete_unlink(dentry, inode);
-		nfs_drop_nlink(inode, gencount);
+		nfs_drop_nlink(inode, gencount, false);
 	}
 	iput(inode);
 }
@@ -2556,10 +2556,11 @@ static int nfs_safe_remove(struct dentry *dentry)
 	trace_nfs_remove_enter(dir, dentry);
 	if (inode != NULL) {
 		unsigned long gencount = READ_ONCE(NFS_I(inode)->attr_gencount);
+		bool force_drop = nfs_have_read_or_write_delegation(inode) && inode->i_nlink == 1;
 
 		error = NFS_PROTO(dir)->remove(dir, dentry);
 		if (error == 0)
-			nfs_drop_nlink(inode, gencount);
+			nfs_drop_nlink(inode, gencount, force_drop);
 	} else
 		error = NFS_PROTO(dir)->remove(dir, dentry);
 	if (error == -ENOENT)
@@ -2852,7 +2853,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			new_dir, new_dentry, error);
 	if (!error) {
 		if (new_inode != NULL)
-			nfs_drop_nlink(new_inode, new_gencount);
+			nfs_drop_nlink(new_inode, new_gencount, false);
 		/*
 		 * The d_move() should be here instead of in an async RPC completion
 		 * handler because we need the proper locks to move the dentry.  If
-- 
2.53.0


