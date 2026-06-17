Return-Path: <linux-nfs+bounces-22654-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dWijIK6YMmpC2gUAu9opvQ
	(envelope-from <linux-nfs+bounces-22654-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 14:53:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDA5699DDB
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 14:53:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YZ+LlHYd;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22654-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22654-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53205301E593
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC8EEA8;
	Wed, 17 Jun 2026 12:52:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131E4207A
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2026 12:52:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700779; cv=none; b=YOAgZcn2WoCdD9hSROl+pvjrRcOO8Y9WuapEjpFwfOMVPuj0IBHL0u+dN5S+BO8J/heZyQg8lMjadaRBHw52fLJJJpnwT5yQwrmOuCnvd5D+Z34AQzQRaGd0apGzl578ZrYEp1QMcVMvCEqqBHGpfALIIXzfCbHegpQGg/zAYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700779; c=relaxed/simple;
	bh=F3G/KtTYcMSuBXUyOqGsWWGR5kdsmJidB6XYR7Su7XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6VHBBWo2vv239frC8Sk747KjvLh+ycbppRTbHTlXCNQEWYM3JesCv/dtmywUYwZUfpefw7qDGfeJqQF6i3Rscz26gHN9GnuOpVN4Fhzzk/2wQjYO2UQWjPJEPNZ6VwIhKLR+aBXgKDzaDwsNGGo1HWu+CalYmU0Y5M6arpAv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ+LlHYd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFBD1F00A3A;
	Wed, 17 Jun 2026 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781700778;
	bh=RACfpDAkvWLhJoNIJRMSlYJsqy5M3HISN4cAeBiSmfM=;
	h=From:To:Cc:Subject:Date;
	b=YZ+LlHYdPuFgPeg8kXPRK8nq+10KN0Beq09GengZYQZttMoVJTk+fOUcs/Z9bxtRC
	 WL5qBuUiPOWIwI8mRsFmeJDCzgrHxE1L5QwjaP6hEFO8odzAyfOMxM6fi8M4xMS37V
	 PRedDfbfpn+gfYZJ25hGXOf1lC6LCuSE9kePB4crJM/k1V9iqa/MeKrVEGiiRlXhTx
	 qCTwUrUW0dzZY4h4uzVRDERM36WvkpGGO+UT4YCtdQzmT3Ff5+T+MwpYWbNtwJdGXu
	 bW8Fb7uuX5jKDzXWhw2SbfHVODV0sbezyFFIzpjulgXkTcsPSPpk4BZrA9qSbNVAS6
	 N15fdRGEmNegQ==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: Return a delegation the client fails to record
Date: Wed, 17 Jun 2026 08:52:57 -0400
Message-ID: <20260617125257.1293452-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:trond.myklebust@hammerspace.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22654-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEDA5699DDB

When an NFS server grants a delegation in an OPEN reply,
nfs_inode_set_delegation() records it on the client. However, three
of its error flows return without sending DELEGRETURN.

A delegation can be relinquished only by DELEGRETURN (RFC 8881
Section 20.2.4), so dropping one silently leaves the server believing
the client still holds it. If the server happens to recall that
delegation, the client answers CB_RECALL with NFS4ERR_BADHANDLE
because it has no record of the stateid. The server revokes the
delegation and moves it onto its cl_revoked list, because the client
never sends the FREE_STATEID that would drain it. Every subsequent
SEQUENCE reply then carries SEQ4_STATUS_RECALLABLE_STATE_REVOKED,
and the client's state manager loops issuing TEST_STATEID across its
delegations without ever clearing the condition.

The window is easy to reach now that a server offers a write
delegation on any write OPEN: a delegation recalled for one opener
races a re-open that the server answers with a fresh write
delegation.

Instead of dropping it, hand the delegation back during these error
flows.

Fixes: ade04647dd56 ("NFSv4: Ensure we honour NFS_DELEGATION_RETURNING in nfs_inode_set_delegation()")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfs/delegation.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 122fb3f14ffb..cb579f8c55ce 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -440,11 +440,14 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation, *old_delegation;
 	struct nfs_delegation *freeme = NULL;
+	bool orphaned = false;
 	int status = 0;
 
 	delegation = kmalloc_obj(*delegation, GFP_KERNEL_ACCOUNT);
-	if (delegation == NULL)
+	if (delegation == NULL) {
+		nfs4_proc_delegreturn(inode, cred, stateid, NULL, 0);
 		return -ENOMEM;
+	}
 	nfs4_stateid_copy(&delegation->stateid, stateid);
 	refcount_set(&delegation->refcount, 1);
 	delegation->type = type;
@@ -493,11 +496,15 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 			goto out;
 		}
 		if (test_and_set_bit(NFS_DELEGATION_RETURNING,
-					&old_delegation->flags))
+					&old_delegation->flags)) {
+			orphaned = true;
 			goto out;
+		}
 	}
-	if (!nfs_detach_delegations_locked(nfsi, old_delegation, clp))
+	if (!nfs_detach_delegations_locked(nfsi, old_delegation, clp)) {
+		orphaned = true;
 		goto out;
+	}
 	freeme = old_delegation;
 add_new:
 	/*
@@ -532,8 +539,11 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 		nfs_update_delegated_mtime(inode);
 out:
 	spin_unlock(&clp->cl_lock);
-	if (delegation != NULL)
+	if (delegation != NULL) {
+		if (orphaned)
+			nfs_do_return_delegation(inode, delegation, 0);
 		__nfs_free_delegation(delegation);
+	}
 	if (freeme != NULL) {
 		nfs_do_return_delegation(inode, freeme, 0);
 		nfs_mark_delegation_revoked(server, freeme);
-- 
2.54.0


