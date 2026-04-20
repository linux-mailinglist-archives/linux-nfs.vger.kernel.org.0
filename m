Return-Path: <linux-nfs+bounces-20967-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIKpKnER5mlrrAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20967-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 13:43:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21F442A011
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 13:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C1A23014798
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05639E184;
	Mon, 20 Apr 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjVlDla8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A539C624
	for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685420; cv=none; b=mn9oAAEGKaHbAj+AMEzDuMXdu61uwijeaJ6/sT/pokzVTBLpyewvXqrJ4L4IMozMi/1sMEIuXaPoxamsR9gGZugYKkHUXYquAuIXtyUIwz6ZFVimuCTCgJSXKCI8DGZsmKbdfA/UI89MWiXfT0whUgxsrf4g5sowt46FNFnM2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685420; c=relaxed/simple;
	bh=47ZdeusVTQ92ce4271gf5O3lktx5j/ugFB1tbL1maY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4xwI5jI0b59us2qDZeKDwI4WsYsgG8UK+8angyJvkm2hOZQ8xoI99CIfuFpdadscKwSb0/MVHpkFpnHjmKmriBRiOJfJDfDSH+NF87XKPdq3ORMcC9sZMkdyQ5VRJGJUsAeE4MsxVgCjLx+Kx66TmN/XvrPhLyoYKtCITRqFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjVlDla8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776685418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YpkSz6N29LSu9RDEBAyMQ+b4IfOFBETmzkQPWKmEpQg=;
	b=UjVlDla8XTSI7R/pnufZ37a0zJslE2zUaPnb30LgBzBmaS0Y2YjHASMCOYzUya+a03f1Tp
	lUcqG4FWzm596MtFgY2/H+o+5+u268Ktsrs9S5/7Os05O4jdL5zUt+Fs+2zf5ApCqFMo2a
	drNOZuzXoeGPt/tsKcVMhGBywgTwcNM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-43YXx669MOqChBV5DZwprg-1; Mon,
 20 Apr 2026 07:43:35 -0400
X-MC-Unique: 43YXx669MOqChBV5DZwprg-1
X-Mimecast-MFC-AGG-ID: 43YXx669MOqChBV5DZwprg_1776685414
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EBF1180036E;
	Mon, 20 Apr 2026 11:43:34 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.44.50.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA9B63000C15;
	Mon, 20 Apr 2026 11:43:32 +0000 (UTC)
From: Roberto Bergantinos Corpas <rbergant@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH RESEND] nfs: force drop_nlink if we have a delegation during REMOVE
Date: Mon, 20 Apr 2026 13:43:31 +0200
Message-ID: <20260420114331.700769-1-rbergant@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20967-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbergant@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A21F442A011
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


