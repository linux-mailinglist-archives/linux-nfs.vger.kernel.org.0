Return-Path: <linux-nfs+bounces-22949-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MeNZIvLIRmrgdQsAu9opvQ
	(envelope-from <linux-nfs+bounces-22949-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 22:24:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B91BE6FCB56
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 22:24:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A6XOW42p;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22949-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22949-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD701301FD61
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F333749FE;
	Thu,  2 Jul 2026 20:24:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B19A3161BE;
	Thu,  2 Jul 2026 20:24:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023853; cv=none; b=YaRI744/M+9j4Gj6FeNEFe9DIYO0s748XkDAoG++GMwI7U8gp1FifcLbt/Q2r5VmT6FCTluCymy21S2w5cZoeU08o/1dNzWZRX0CAXKMSHrO9kOGDPYAT0KmV9c0orJhJSKpqDQmUmemnY+HW/oaN/j6HV2oKoIVJerbeusybys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023853; c=relaxed/simple;
	bh=xrgy0IwFvREORgwQbHar9rE7JfTLdYMoJNQuBcReywg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQn/yGqhjPROPS98KU8GVY9lpqAk4Y5R7i8ufsKl1Sja3yWMUoSvrRNLNfLaIgVildF5RF8uGsk7kGVCzhedaQedSizMEe3BvvPZ2ij7ercFnSFKkc34gq+G07VYBrV5lPv6QlVwf065IbhCGy6RwnOtQBMYSa3ORSCNPlwHo70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6XOW42p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912471F000E9;
	Thu,  2 Jul 2026 20:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783023851;
	bh=5510spoNmYST91XZlQkeB1E010rR5/z9zPTJFO942lw=;
	h=From:To:Cc:Subject:Date;
	b=A6XOW42p3yBksluxlbURc/2ubDWGh5VYcafWWJ5YgROuUaL5MYL07mVjb6a8UpsI1
	 ZNF/8GbQIGPK0ci1NcqbI+mG9mUdOng5YsFmOlR9lb2QnpdJlOuGf7YambpANPZf27
	 vR2DCbKhQOH8mINdMBi9aAY8m4nz0nc70poYoRl1Bj2PVxNUauxR2o9Tl/w1BTjCym
	 KkNnuo2jI9UULPa3IsZZWeQWIDUelFgEdF4rOlgT5WeEM0zReVPWDJSOCQqpgKzyKe
	 KeejeCo5PJdDVzi0knEbWK+f4TGvy3uRyVC/mxg/nUOR2hGSGVBf86Hr667Qj46vRx
	 yFBkMI085tezA==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 6.18.y 1/3] nfsd: update mtime/ctime on CLONE in presense of delegated attributes
Date: Thu,  2 Jul 2026 16:24:07 -0400
Message-ID: <20260702202409.1583677-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:okorniev@redhat.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22949-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B91BE6FCB56

From: Olga Kornievskaia <okorniev@redhat.com>

commit 2863bac7f49c4acd80a048ce52506a2b9c8db015 upstream.

When delegated attributes are given on open, the file is opened with
NOCMTIME and modifying operations do not update mtime/ctime as to not get
out-of-sync with the client's delegated view. However, for CLONE operation,
the server should update its view of mtime/ctime and reflect that in any
GETATTR queries.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ cel: 9be4b7e74eb7 and 3daab3112f03 are missing from linux-6.18.y ]
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  3 +++
 fs/nfsd/nfs4state.c | 44 +++++++++++++++++++++++++++++---------------
 fs/nfsd/state.h     |  1 +
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8dada7ef97cb..dd22bfd168b5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1350,6 +1350,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
 
+	if (!status && (READ_ONCE(dst->nf_file->f_mode) & FMODE_NOCMTIME) != 0)
+		nfsd_update_cmtime_attr(dst->nf_file, 0);
+
 	nfsd_file_put(dst);
 	nfsd_file_put(src);
 out:
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a9e95df2fdb6..e4a10cd8f8dc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1226,10 +1226,6 @@ static void put_deleg_file(struct nfs4_file *fp)
 
 static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct file *f)
 {
-	struct iattr ia = { .ia_valid = ATTR_ATIME | ATTR_CTIME | ATTR_MTIME | ATTR_DELEG };
-	struct inode *inode = file_inode(f);
-	int ret;
-
 	/* don't do anything if FMODE_NOCMTIME isn't set */
 	if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) == 0)
 		return;
@@ -1247,17 +1243,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 		return;
 
 	/* Stamp everything to "now" */
-	inode_lock(inode);
-	ret = notify_change(&nop_mnt_idmap, f->f_path.dentry, &ia, NULL);
-	inode_unlock(inode);
-	if (ret) {
-		struct inode *inode = file_inode(f);
-
-		pr_notice_ratelimited("Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
-					MAJOR(inode->i_sb->s_dev),
-					MINOR(inode->i_sb->s_dev),
-					inode->i_ino, ret);
-	}
+	nfsd_update_cmtime_attr(f, ATTR_ATIME);
 }
 
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
@@ -9433,3 +9419,31 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	nfs4_put_stid(&dp->dl_stid);
 	return status;
 }
+
+/**
+ * nfsd_update_cmtime_attr - update file's delegated ctime/mtime,
+ *                           and optionally other attributes (ie ATTR_ATIME).
+ * @f: pointer to an opened file
+ * @flags: any additional flags that should be updated
+ *
+ * Given upon opening a file delegated attributes were issues, update
+ * @f attributes to current times.
+ */
+void nfsd_update_cmtime_attr(struct file *f, unsigned int flags)
+{
+	int ret;
+	struct inode *inode = file_inode(f);
+	struct iattr attr = {
+		.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_DELEG | flags,
+	};
+
+	inode_lock(inode);
+	ret = notify_change(&nop_mnt_idmap, f->f_path.dentry, &attr, NULL);
+	inode_unlock(inode);
+	if (ret)
+		pr_notice_ratelimited("nfsd: Unable to update timestamps on "
+				      "inode %02x:%02x:%lu: %d\n",
+				      MAJOR(inode->i_sb->s_dev),
+				      MINOR(inode->i_sb->s_dev),
+				      inode->i_ino, ret);
+}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index aaf513ed9104..2eed2c5b3cd0 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -831,6 +831,7 @@ extern void nfsd4_shutdown_callback(struct nfs4_client *);
 extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
 void nfsd4_async_copy_reaper(struct nfsd_net *nn);
 bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
+void nfsd_update_cmtime_attr(struct file *f, unsigned int flags);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
 				struct xdr_netobj princhash, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
-- 
2.54.0


